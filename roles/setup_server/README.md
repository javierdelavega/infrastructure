# Ansible Codechallenge Setup Server Role

This role installs required **Packages**, creates needed **Files/Directories** and setup a **Database** to run the Codechallenge app Backend and Frontend.

  - **Packages:** This role installs Nginx, MariaDB, Php-Fpm and php extensions (php-mysql, php-zip, php-xml, php-curl, php-intl, php-apcu).

  - **Files/Directories** This role creates the Nginx directories to host the backend and the frontend, the paths are configured in role variables. The role configures two vhosts: one to serve the frontend (html), one to serve the backend (php).

  - **Database** This role create the database, and the database user required to run the app.

## Requirements

### Ansible

- This role is developed and tested with [Ansible Core 2.16](https://github.com/ansible/ansible/tree/stable-2.16) and [Molecule](https://ansible.readthedocs.io/projects/molecule/) 6.0.2.
- When using Ansible core, you will also need to install the following collections:

    ```yaml
    ---
    collections:
      - name: ansible.posix
      - name: community.mysql
      - name: community.docker
    ```

- You will need to run this role as a root user using Ansible's `become` parameter. Make sure you have set up the appropriate permissions on your target hosts.
- Instructions on how to install Ansible can be found in the [Ansible website](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

### Jinja2

- This role uses Jinja2 templates. Ansible core installs Jinja2 by default.

### Molecule (Optional)

- Molecule is used to test the functionalities of the role. The required version of Molecule to test this role is `6.x`.
- Instructions on how to install Molecule can be found in the [Molecule website](https://molecule.readthedocs.io/en/latest/installation.html). *You will also need to install the Molecule Docker driver.*


## Platforms

```yaml
Debian:
  - bookworm (12)
Ubuntu:
  - 22.04 LTS
Rocky Linux:
  - 9
```

## Role Variables

### Required variables:

**Note:** You may want to set sensitive variables through system environment variables, or through a secrets.yaml file you can include in the playbook. Host specific variables like FQDN and root directory can be set per host in the inventory file.

| Name | Description |
| ---- | ----------- |
| **host_backend_fqdn** | Backend FQDN |
| **host_frontend_fqdn** | Backend FQDN |
| **nginx_frontend_root** | Path to the root of the frontend vhost directory |
| **nginx_backend_root** | Path to the root of the backend vhost directory |
| **symfony_app_secret** | Symfony app secret |
| **symfony_db_name** | The Database name for the symfony app |
| **symfony_db_user** | The Database user for the symfony app |
| **symfony_db_name** | The Database password for the symfony app |

### Optional variables

| Name | Description |
| ---- | ----------- |
| **nginx_version** | Nginx version to install. Default: latest |
| **nginx_port** | Nginx listen port |
| **mariadb_version** | MariaDB version to install. Default: latest |
| **php_branch** | PHP Major version to install. Default: 8.2 |
| **php_release** | PHP Release to install. Default: latest version of the PHP Major version selected |
| **symfony_db_name** | The Database name for the symfony app |
| **[`php.yml`](https://github.com/javierdelavega/infrastructure/blob/main/roles/setup_server/vars/php.yml)** | PHP configuration variables |


## Example

### Example Inventory - hosts.yml

```yaml
webservers:
  hosts:
    staging:
      ansible_host: myapp.staging.com
      ansible_user: root
      host_backend_fqdn: myapp.staging.com
      host_frontend_fqdn: myapp-front.staging.com
    production:
      ansible_host: myapp.com
      ansible_user: root
      host_backend_fqdn: myapp.com
      host_frontend_fqdn: myapp-front.com
```
### Example Playbook - setup_webservers.yml

```yaml
- name: Setup webservers
  hosts: webservers
  roles:
    - { role: setup_server }
```

### Run the role

```bash
ansible-playbook -i hosts.yml setup_webserver.yml
```