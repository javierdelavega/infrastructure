# Proyecto Terraform para instancia AWS EC2

Despliegue de una instancia EC2 en AWS

- Se ha utlizado **[`Terraform 1.6.4`](https://www.terraform.io)**

### Instancia EC2

- Se configura una instancia EC2 con la imagen Ubuntu 22.04 LTS

- Se define una pareja de claves SSH para el acceso a la instancia

- Se define un security group para permitir el acceso a los puertos 80 (http) y 22 (ssh)

- Se provee un script de aprovisionamiento

### Script de aprovisionamiento

El shell script **[`provision.sh`](https://github.com/javierdelavega/infrastructure/blob/main/terraform/provision.sh)** instalará los paquetes requeridos para que la instancia pueda ser gestionado con Ansible tras su creación

- Instala python3, gut y rsync

- Instala las claves ssh adicionales para el acceso al repositorio de la aplicación codechallenge, y acceso a la instancia desde Ansible.

### Outputs

Se definen outputs de terraform para ser consumidos desde Ansible