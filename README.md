# Ansible Codechallenge Roles and Playbooks

Roles y playbooks para la aplicación Codechallenge.

- Se ha utlizado **[`Ansible Core 2.16`](https://github.com/ansible/ansible/tree/stable-2.16)** y **[`Molecule`](https://ansible.readthedocs.io/projects/molecule/)** 6.0.2 para su desarrollo y tests.

- No se han utilizado roles ya existentes para nginx, php o mariadb ya que el objetivo es el entrenamiento en Ansible. 

- Se detalla información en el README de cada rol (ver tabla).

### Roles

| Nombre | Descripción |
| ---- | ----------- |
| **[`setup_server`](https://github.com/javierdelavega/infrastructure/tree/main/roles/setup_server)** | Rol para instalación y configuración de los servidores |
| **[`deploy_app`](https://github.com/javierdelavega/infrastructure/tree/main/roles/deploy_app)**  | Rol para el despliegue de la app en los servidores utilizando ansistrano |

### Playbooks

| Nombre | Descripción |
| ---- | ----------- |
| **[`deploy_aws_server.yml`](https://github.com/javierdelavega/infrastructure/blob/main/playbooks/deploy_aws_server.yml)** | Playbook para despliegue de una instancia AWS EC2 utilizando Terraform |
| **[`setup_webservers.yml`](https://github.com/javierdelavega/infrastructure/blob/main/playbooks/setup_webservers.yml)** | Playbook para instalación y configuración de servidores |
| **[`deploy_app_staging.yml`](https://github.com/javierdelavega/infrastructure/blob/main/playbooks/deploy_app_staging.yml)** | Playbook para despliegue de la app en el servidor *staging* alojada en: **[`ansible.codechallenge-front-staging.smartidea.es`](https://ansible.codechallenge-front-staging.smartidea.es/)** |
| **[`deploy_app_production.yml`](https://github.com/javierdelavega/infrastructure/blob/main/playbooks/deploy_app_production.yml)** | Playbook para despliegue de la app en el servidor *producción* alojada en: **[`ansible.codechallenge-front.smartidea.es`](https://ansible.codechallenge-front.smartidea.es/)** |
| **[`deploy_app_aws.yml`](https://github.com/javierdelavega/infrastructure/blob/main/playbooks/deploy_app_aws.yml)** | Playbook para despliegue de la app en el servidor *aws* alojada en: **[`aws.codechallenge-front.smartidea.es`](https://aws.codechallenge-front.smartidea.es/)** |
| **[`setup_webservers_semaphore.yml`](https://github.com/javierdelavega/infrastructure/blob/main/playbooks/setup_webservers_semaphore.yml)** | Playbook para instalación y configuración de servidores con SemaphoreUI|
| **[`deploy_app_staging_semaphore.yml`](https://github.com/javierdelavega/infrastructure/blob/main/playbooks/deploy_app_staging_semaphore.yml)** | Playbook para despliegue de la app en el servidor *staging* con SemaphoreUI |
| **[`deploy_app_production_semaphore.yml`](https://github.com/javierdelavega/infrastructure/blob/main/playbooks/deploy_app_production_semaphore.yml)** | Playbook para despliegue de la app en el servidor *producción* con SemaphoreUI |
| **[`deploy_app_aws_semaphore.yml`](https://github.com/javierdelavega/infrastructure/blob/main/playbooks/deploy_app_aws_semaphore.yml)** Playbook para despliegue de la app en el servidor *aws* con SemaphoreUI |

## SemaphoreUI

Como extra, se ha utilizado la herramienta **[`SemaphoreUI`](https://www.ansible-semaphore.com)** alojada en **[`ansible.semaphore.smartidea.es`](https://ansible.semaphore.smartidea.es)**.

- SemaphoreUI provee una API. Como ejemplo se ha utilizado esta API desde las pipelines de Jenkins para automatizar los despliegues, sin necesidad de ssh, y poder revisar así su historial, quién los ejecutó, y las salidas de consola de cada ejecución.

- SemaphoreUI utiliza repositorios para obtener y ejecutar los playbooks y un fichero **[`requirements.yml`](https://github.com/javierdelavega/infrastructure/blob/main/roles/requirements.yml)** para instalar las dependencias con ansible-galaxy automáticamente. También podemos usar este fichero desde CLI:

```bash
ansible-galaxy install -r roles/requirements.yml
```

**Nota:** Se han creado playbooks adicionales para semaphore, ya que para ansible cli se ha utilizado un fichero secrets.yml para las variables de entorno, y en SemaphoreUI se han definido en un entorno gestionado por semaphore.