# atsip76_microservices

# atsip76 microservices repository

# HW23
## Kubernetes-5

* Установил ingress-контроллер nginx из helm-чарта;
* Добавил /etc/hosts имена хостов по адресу Ingress;
* Создал custom_values.yml;
* Установил Prometheus;
* Включил в конфиге kube-state-metrics, обновил релиз;
* Включил node-exporter, обновил релиз;
* Провеоил метрики;
* Запустил relise reddit-test, production и staging;
* Обновил конфиг, добавив джоб reddit-endpoints, обновил релиз;
* Добавил метки k8s и prometheus;
* Добавил джоб reddit-production, обновил релиз;
* Разбил джоб reddit-endpoints на джобы по эндпойнтам ui, post и comment;
* Поставил grafana через helm;
* Добавил датасорс прометеуса, загрузил дэшборд кубернетиса;
* Добавил дэшборды, ранее созданные в предыдущих ДЗ по логированию;
* Добавил на дэшборд UI_service_monitoring переменую namespace;
* Все используемые в рамках этого ДЗ дэшборды сохранил в `kubernetes/grafana/dashboards`;
* Выполнил задание со *;
* Создал директорию kubernetes/efk/, создал манифесты, применил;
* Установил кибану через helm, настроил;
* Выполнил задание со **.



# HW22
## Kubernetes-4

* Установил Helm, создал манифест тиллера, проинициализировал Helm;
* Создал директории под чарты, создал ui/Chart.yaml;
* Создал директорию ui/templates и перенес туда манифесты ui;
* Установил чарт ui;
* Шаблонизировал ui/templates/service.yaml, deployment.yaml и ingress.yaml, определил переменные в ui/values.yaml;
* Установил несколько релизов ui, проверил работу приложений;
* Кастомизировал переменными deployment.yaml, service.yaml и ingress.yaml, добавил новые переменные в values.yaml;
* Проапгрейдил релиз ui;
* Добавил шаблоны для post и comment;
* Описал функцию comment.fullname в _helpers.tpl, подменил названия на результат функции в нужных местах;
* Проделал аналогичное для ui и post;
* В директрии reddit/ создал необходимые файлы, загрузил зависимости;
* Нашел чарт монги, добавил его в файл зависимостей, обновил зависимости;
* Установил приложение с зависимостями;
* Добавил в ui/deployments.yaml шаблонизированные переменные окружения;
* Обновил зависимости и обновил релиз;
* Создал новый пул узлов bigpool в GKE под GitLab;
* Добавил репо гитлаба, скачал его чарт;
* Поправил необходимые конфиги;
* Создал группу и проекты, добавил в переменные CI/CD группы даныне для входа в докер-хаб;
* Перенес исходники ui в Gitlab_ci/ui, проинициализировал репозиторий для гитлаба и пушнул код в него;
* Аналогичные действия сделал для post и comment;
* Перенес чарты в Gitlab_ci/reddit-deploy, пушнул в гитлаб;
* Создал Gitlab_ci/ui/.gitlab-ci.yml, пушнул, проверил пайплайн, повторил для post и comment;
* Обновил конфиг ингресса для ui;
* Создал ветку feature/3 в ui, обновил CI-скрипт, пушнул в гитлаб;
* Добавил в CI-скрипт стейдж удаления окружения, проверил работу пайплайна в гитлабе, проверил удаление окружения;
* Повторил те же шаги для post и comment;
* Создал reddit-deploy/.gitlab-ci.yml, пушнул в гитлаб, проверил пайплайн и окружения;

### Задание со *
* Выполнил


# HW21
## Kubernetes-3

- Настроил ui-service на использование балансировщика нагрузки (LoadBalancer);
- Создал Ingress для сервиса ui;
- Изменил тип сервиса ui на NodePort;
- Добавил маршрутизацию трафика по пути /* на порт 9292 в Ingress;
- Создал самоподписанный сертифика для Ingress;
- Создал секрет в kubernetes с созадынным сертификатом;
- Зашел на адрес приложения по HTTPS;
- Включил network-policy для кластера GKE;
- Создал сетевую политику, которая разрешает доступ к mongo только с comment;
- Обновил политику, добавив туда доступ к mongo для post;
- Создал несколько постов, удалил деплоймент mongo, создал его заново и убедился, что посты пропали;
- Создал диск в GCP и добавил новый раздел в деплоймент mongo;
- Применил изменения и убедился с помощью пересоздания деплоймента, что данные сохраняются;
- Создал описание PersistentVolume и добавил его в кластер;
- Создал описание PersistentVolumeClaim, добавил его также в кластер;
- Подключил PersistentVolumeClaim к деплойменту mongo, обновил деплоймент в кластере;
- Создал описание StorageClass’а и PersistentVolumeClaim с использованием этого класса;
- Подключил созданный PVC к деплойменту mongo;

### Task*
- Создал описание секрета в файле tls-secret.yml

# HW20
## Kubernetes-2

- Установил и запустил minikube;
- Проверил, что нода создалась;
- Изучил файл конфига ~/.kube/config и порядок настройки kubectl;
- Изменил файл деплоймента ui, запустил ui в кластере;
- Пробросил порт 9292 пода ui на порт 8080 моей машины, перешел на localhost:8080 и проверил, что страница ui открывается;
- Обновил деплойменты comment, post и mongo, в mongo дополнительно примонтировал раздел;
- Описал сервисы comment-service.yml, post-service.yml и mongodb-service.yml, запустил их;
- Создал ui-service.yml с добавлением типа сервиса type: NodePort и указанием статичного порта;
- Запустил minikube service ui, открылось ссылка приложения;
- Нашел все запущенные компоненты аддона dashboard командой kubectl get all -n kube-system --selector app=kubernetes-dashboard;
- Зашел в дэшборд и ознакомился с его функциональностью;
- Создал и применил dev-namespace.yml, запустил приложение в неймспейсе dev;
- Зашел в консоль GKE и создал кластер с указанными параметрами;
- Создал dev неймспейс и развернул в нем приложение;
- Создал правило фаервола для ui;
- Зашел по адресу ноды и порту на сервис ui;
- Скриншот лежит в директории reddit;
- Включил панель управления Kubernetes для кластера;
- Выполнил kubectl proxy и перешел по ссылке http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/, вместо описанной в ДЗ нерабочей http://localhost:8001/ui;
- Получил ошибку RBAC;
- Назначил роль cluster-admin сервис-аккаунту дэшборда командой kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard;
- Т.к. используется инструментальная панель версии младше 1.10 пришлось добавить --enable-skip-login к аргументам командной строки развертывания kubectl edit deployment/kubernetes-dashboard --namespace=kube-system;
- После этого появился батон SKIP на странице входа для доступа к панели инструментов;
- Перешел снова в панель у правления и убедился, что она работает;

### Task*
- Создал директорию kubernetes/terraform, описал параметры создания кластера в файле main.tf по примеру из документации терраформ;
- Для создания манифеста сервис-аккауна панели управления использовал команду kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin -serviceaccount=kube-system:kubernetes-dashboard с параметром -o yaml, дял вывода описания создаваемого объекта в yaml формате;
- Вывод сохранил в файле kubernetes-dashboard-rolebind.yml

# HW19
## Kubernetes-1

- Описал манифесты сервисов reddit в директории kubernetes/reddit;
- Прошел The Hard Way, все созданные в ходе прохождения файлы сохранил в kubernetes/the_hard_way;
- Проверил, что kubectl apply -f (ui, post, mongo, comment) работает и поды создаются;
- Удалил кластер


# HW18
## Loging-1

- Обновил код приложения src;
- Добавил в Dockerfile post установку gcc и musl-dev;
- Пересобрал все образы приложения reddit;
- Создал докер-хост;
- Создал docker-compose-logging.yml;
- Создал Dockerfile для fluentd в директории logging/fluentd;
- Там же создал fluent.conf, заполнил его и собрал образ fluentd;
- Запустил приложение и понаблюдал за логами post;
- Описал в компоуз файле использование для сервиса post логгирования через fluentd, переподнял контейнеры;
- Открыл Кибана и создал паттерн индексов;
- Ознакомился с интерфейсом Кибана, нашел логи post, попробовал использовать поиск по логам;
- Добавил во fluent.conf фильтр для парсинга JSON для сервиса post;
- Перезапустил fluent и убедился в кибана, что json-поле распарсилось;
- Добавил в компоуз-файле вывод логов в fluent для ui;
- Перезапустил приложение и проверил как собираются логи от ui;
- Добавил во fluent.conf фильтр для парсинга логов ui через регулярное выражение;
- Перезапустил сервисы логгирования и проверил как распарсились логи ui;
- Заменил фильтр для логов ui с регулярным выражением на grok-pattern;
- Добавил еще один парсинг через grok-pattern для парсинга оставшейся части лога ui;
- Добавил Zipkin в docker-compose-logging.yml (использовал версию 2.11.8, т.к. последняя версия багованая, не отображает время спанов);
- Добавил для каждого сервиса в docker-compose.yml переменую окружения ZIPKIN_ENABLED=true и пересоздал все сервисы;
- Открыл интерфейс zipkin и нашел запросы от ui_app;

### Task*
- Добавил еще один grok-pattern для парсинга второй части лога ui;

#### Task**
- Склонировал забагованную репу;
- Поправил Dockerfile, добавли тег bug;
- Собрал образы for i in ui post-py comment; do cd bugged-code/$i; bash docker_build.sh; cd -; done
- Создал копию 'docker-compose.yml', где изменил образы на bug, поднял приложение;
- Посты открываются с существенной задержкой;
- Zipkin запрос открытия post 3.019s

| Date Time            | Relative Time | Annotation    | Address                  |
| -------------------- | ------------- | ------------- | ------------------------ |
| 08.09.2019, 12:24:29 | 1.504ms       | Client Start  | 172.31.0.6:9292 (ui_app) |
| 08.09.2019, 12:24:29 | 4.086ms       | Server Start  | 172.31.0.5:5000 (post)   |
| 08.09.2019, 12:24:32 | 3.012s        | Server Finish | 172.31.0.5:5000 (post)   |
| 08.09.2019, 12:24:32 | 3.019s        | Client Finish | 172.31.0.6:9292 (ui_app) |

 - Нашел в коде post_app.py функцию поиска поста find_post  в ней умышленная задержка в 3 сек time.sleep(3)
 - Убрал задержку

# HW17
## Monitoring-2

- Выделил из файла docker-compose в файл docker-compose-monitoring описание сервисов мониторинга;
- Добавил описание сервиса cAdvisor в compose-файл, добавил таргет cAdvisor в prometheus.yml;
- Запустил проект, пощупал интерфейс cAdvisor;
- Добавил Grafana в compose-файл;
- Запустил и настроил графану;
- Скачал с сайта графаны дэшборд с мониторингом докера, импортировал его в графану, сохранил его также в папке monitoring/grafana/dashboards;
- Добавил в prometheus.yml таргет posr с метриками приложения;
- Перезапустил мониторинги, добавил несколько постов в приложение и проверил, что метрики post работают;
- Создал дэшборд UI service monitoring, добавил туда панель UI HTTP Requests с метрикой ui_request_count;
- Добавил панель Rate of UI HTTP requests with error с метрикой rate(ui_request_count{http_status=~"^[45].*"}[1m]), сгенерировал 400-х ошибок и убедился, что график их отображает;
- Изменил панель UI HTTP Requests, довив функцию rate к метрике (rate(ui_request_count[5m])), переименовал панель в Rate of UI HTTP Requests;
- Добавил новую панель HTTP response time 95th percentile с метрикой histogram_quantile(0.95, sum(rate(ui_request_latency_seconds_bucket[5m])) by (le));
- Соханил дэшборд, экспортировал его и сохранил в папке monitoring/grafana/dashboards;
- Создал новый дэшборд Business_Logic_Monitoring, добавил на него панель Posts Rate с метрикой rate(post_count[1h]);
- Добавил панель Comments Rate с метрикой rate(comment_count[1h]), сохранил и экспортировал в папку с дэшбордами;
- Создал директорию monitoring/alertmanager, а в ней Dockerfile и config.yml;
- В config.yml описал интеграцию со Slack и маршрут алертинга, собрал образ;
- Канал Slack для алертов https://app.slack.com/client/T6HR0TUP3/CKA8PH0US
- Добавил alertmanager в компоуз-файл;
- Создал в директории прометеус файл alerts.yml, где описал правило алертинга на падение инстансов;
- Добавил этот файл в Dockerfile, подключил его и описал подклчение к alertmanager в prometheus.yml, пересобрал образы;
- Остановил один из сервисов и проверил работу алертов;
- Пушим образы в репозиторий https://hub.docker.com/u/atsip;

### Task*
- Изменил Makefile для сборки и деплоя образов в docker-registry;

# HW16
## Monitoring-1

- Редактируем компоус файл docker/docker-compose.yml добавляя сервис прометея и шарим сети
- Редактируем .env (в моем случае сменил порт ui с 80 на 9292)
- Удаляем все старые контейнеры docker-compose down
- Удаляем сети docker network prune
- Поднимаем сервисы docker/docker-compose.yml
- Проверяем работу прометея
- Проверяем работу приложения, эмулируем падение зависимых микросервисов, мониторим графики жизни приложений
- Настраиваем экспортер node_exporter
- Проверяем мониторинг под нагрузкой
- Пушим образы в репозиторий https://hub.docker.com/u/atsip

### Task*
- Добавил экспортер ssalaues/mongodb-exporter для мониторинга mongodb
- Добавил экспортер atsip/blackbox-exporter
- Добавил экспортер atsip/cloudprober
- Добавил Makefile для сборки и деплоя образов в docker-registry

# HW15
## GitLab CI

- Packer запекаю образ с предустановленным docker, docker-compose и забираю курлом docker-compose.yml для сборки и запуска контейнера с gitlab ci
- Terraform разворачиваю конфигурацию используя созданный образ, с параметрами инстанса не менее 3.7 ram 100 gb hdd, открывая порты 443, 80, 22 в ресурсе firewall
- Ansible произвожу модификацию docker-compose файла с изменением значения <YOUR-VM-IP> на текущий IP адрес
ansible_host, запускаю docker-compose  разворачивая и запуская конейнер с GitLab CI
- Код создания инфраструктуры находится в директории infra
- Конфигурацию разворачиваем запуская скрипт start_deploy.sh в корне директории infra
- В браузере заходим на созданный ресурс, меняем пароль рута, регистрируем группу проекта и создаем репозиторий example
- пушим локальный репозиторий в gitlab
- Выполняем практическую работу:
Настройка Gitlab
Настройка Gitlab CI/CD Pipeline
Тестирование reddit
Настройка окружений



# HW14
## Docker-4

- изменил docker-compose файл в соответствии с множестом сетей и алиасов из примера на стр.18
- параметизировал docker-compose с помощью пременных порт httpd, версии сервисов, юзера, используя файл .env
- запустил контейнеры и проверил правильность настроек
- базовое имя проекта образуется от имени директории в которой расположен docker-compose файл, можно изменить через переменную окружения  COMPOSE_PROJECT_NAME={project name}

### Task*
- создал docker-compose.override.yml смонтировал в нем код приложения как том, добавил дебаг опции при запуске приложений

### Проверка работоспособности
http://localhost:80

# HW13
## Docker-3

- разбиваем монолит на микросервисы
- сборка образа post-py валится с ошибкой отсутствия компилятора gcc:
```sh
unable to execute 'gcc': No such file or directory
error: command 'gcc' failed with exit status 1
 ----------------------------------------
Command "/usr/local/bin/python3.6 -u -c "import setuptools, tokenize;__file__='/tmp/pip-build-x_qkhb9k/thriftpy/setup.py';f=getattr(tokenize, 'open', open)(__file__);code=f.read().replace('\r\n', '\n');f.close();exec(compile(code, __file__, 'exec'))" install --record /tmp/pip-0lp3215y-record/install-record.txt --single-version-externally-managed --compile" failed with error code 1 in /tmp/pip-build-x_qkhb9k/thriftpy/
You are using pip version 9.0.1, however version 19.2.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
```
- добавляем в докерфайл post-py обновление пакетов и установку gcc, после этого компиляция приложения и сборка имиджа успешна
- подключаем volume  к контейнеру с db для хранения базы локально на хосте

### Task*
- изменил алиасы сети для сервисов
- собираем образа ui,comment на базе alpine сократив размеры до 260 мгб.

### Проверка работоспособности
http://localhost:9292

# HW12
## Docker-2

- заполняем docker-1.log
- создан имидж и запущены контейнеры сервера приложения локально и в облаке
- провел практическое занятие с созданным контейнером

### Task*
- запекаем образ с интегрированным docker & docker-compose: build_image.sh
- треррой разворачиваю нужное количество инстансов из образа с предустановленным докером и без
- ансибле произвожу деплой контейнера из образа с хаба с запуском приложения

### Запуск проекта:

```sh
Создаем образ с предустановленным докер и зависимостями: Выполнить build_image.sh в директории проект/packer
Разворачиваем конфигурацию из директории проект/terraform terraform apply
Устанавливаем докер (если инстанс из имиджа без докера) контейнер и запускаем сервис проект/ansible ansible-playbook main.yml
```

### Проверка развертывания, перейдя по адресу сервера в вашем браузере:
```sh
Открыть в вашем браузере:
http://любой ip инстанса:80
```
