# Описание работы
Создание инфраструктуры в рамках финальной работы курса «DevOps-инженер. Основы». 
В vk-облаке разворачивается структура включающая в себя stage server, production server, сервер мониторинга и сервер хранения и управления git-репозиториями. Для stage и production серверов настраивается балансировщики сети
На созданные сервера заливается необходимое ПО

# Сборка проекта
## Terraform
1. Указываем регистрационные данные облака в terraform/vkcs_provider.tf
2. Проводим инициализацию:
   ```shell
   cd ./terraform && terraform init
   ```
4. Разворачиваем инфраструктуру:
   ```shell
   terraform apply
   ```

## Ansible  
1. Меняем адреса серверов в файле ansible/hosts на полученные от результата вывода работы terraform
2. Запускаем плэйбук для установки ПО на все сервера кроме prod:
   ```shell
   cd ../ansible && ansible-playbook -b server_playbook.yml -vv
   ```
4. Для prod сервера отдельный плэйбук:
   ```shell
   cd ../ansible && ansible-playbook -b prod_server_playbook.yml -vv
   ```
