# Результаты выполнения ДЗ 5, Коршунов Пётр Андреевич М05-511б

## Развертывание и настройка Jenkins
### Запуск контейнеров
![image](images/global_setup/successful_jenkins_start.png)

### Стартовая страница
![image](images/global_setup/main_page.png)

### Конфигурирование JDK
![image](images/global_setup/jdk_setup.png)

### Установка allure
![image](images/global_setup/allure_install.png)

### Настройка плагина Sonarqube
#### Установка плагина
![image](images/global_setup/sonarqube_install.png)

#### Конфигурация плагина
![image](images/global_setup/sonarqube_plugin_config.png)

### Настройка плагина Nexus
#### Установка плагина
![image](images/global_setup/nexus_plugin_install.png)

#### Создание credentials
![image](images/global_setup/nexus_cred.png)

### Добавление nodes
![image](images/global_setup/slave_setup_1.png)
![image](images/global_setup/slave_setup_2.png)

### Результат добавления nodes
![image](images/global_setup/nodes_add_result.png)

## Добавление job
### Build job
#### Настройка
##### Установка источника исходного кода job
![image](images/build_job/build_job_set_scm_as_code_source.png)

##### Добавление параметров job
![image](images/build_job/build_job_params.png)

#### Результат
##### Статус job
![image](images/build_job/build_job_result.png)

##### Allure
![image](images/build_job/build_job_allure_result.png)

##### Sonarqube
![image](images/build_job/build_job_sonar_result.png)

##### Nexus
![image](images/build_job/build_job_nexus_result.png)

### Deploy job
#### Настройка

##### Установка источника исходного кода job
![image](images/deploy_job/deploy_job_set_scm_source.png)

##### Настройка параметров job
![image](images/deploy_job/deploy_job_params.png)

##### Установка плагина для удаленного ssh подключения к хосту
![image](images/deploy_job/deploy_job_ssh_publisher_install.png)

##### Настройка плагина
![image](images/deploy_job/deploy_job_ssh_publisher_config.png)

#### Результат
##### Статус job
![image](images/deploy_job/deploy_job_result.png)

##### Логи развернутого сервиса на удаленном хосте
![image](images/deploy_job/deploy_job_remote_host_logs.png)
Запущено два java процесса, в логах виден успешный старт spring-приложения