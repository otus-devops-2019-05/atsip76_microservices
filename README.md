# atsip76_microservices

# atsip76 microservices repository

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
