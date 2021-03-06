terraform {
  required_version = ">= 0.11.7"
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region  = "${var.region}"
}

#создаем инстанс с предустановленным docker
resource "google_compute_instance" "docker" {
  name         = "reddit-docker-${count.index}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["app-docker"]
  count        = "${var.docker_count}"

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

#создаем инстанс без предустановелного docker
resource "google_compute_instance" "no-docker" {
  name         = "reddit-nodocker-${count.index}"
  machine_type = "g1-small"
  count        = "${var.no_docker_count}"
  zone         = "${var.zone}"
  tags         = ["app-docker"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

#описываем правила фаервола
resource "google_compute_firewall" "firewall_app_ssh" {
  name    = "allow-puma-default-http-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292", "22", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["app-docker"]
}

#задаем источник данных инстанса с docker для формирования динамической записи реестра ansible
data "template_file" "docker" {
  template = "${file("host.json")}"
  count    = "${google_compute_instance.docker.count}"

  vars {
    ip   = "${element(google_compute_instance.docker.*.network_interface.0.access_config.0.nat_ip, count.index)}"
    name = "${element(google_compute_instance.docker.*.name, count.index)}"
  }
}

#задаем источник данных инстанса без преустановленного docker для формирования динамической записи реестра ansible

data "template_file" "nodocker" {
  template = "${file("host.json")}"
  count    = "${google_compute_instance.no-docker.count}"

  vars {
    ip   = "${element(google_compute_instance.no-docker.*.network_interface.0.access_config.0.nat_ip, count.index)}"
    name = "${element(google_compute_instance.no-docker.*.name, count.index)}"
  }
}

#создаем json файл динамического реестра ansible
resource "template_file" "dynamic_inv" {
  template = "${file("dynamic_inventory.json")}"

  vars {
    all_hosts            = "${join(",", concat(data.template_file.docker.*.rendered, data.template_file.nodocker.*.rendered))}"
    docker_host_names    = "${jsonencode(google_compute_instance.docker.*.name)}"
    nodocker_hosts_names = "${jsonencode(google_compute_instance.no-docker.*.name)}"
  }
}
