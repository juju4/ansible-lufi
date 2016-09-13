# Ansible Role for Lufi (Let's Upload That File)

[![Build Status](https://travis-ci.org/noplanman/ansible-lufi.svg?branch=master)](https://travis-ci.org/noplanman/ansible-lufi)

Installs and configures Lufi on Debian/Ubuntu servers.
Find out more about Lufi [here](https://framagit.org/luc/lufi), created by [Luc Didry](https://framagit.org/u/luc).

This role will automatically install a service that will start when the server boots up.
It will figure out which service manager is being used automatically too.

## Requirements

Using this role doesn't install Nginx or Apache as a reverse proxy, you need to do that yourself!
An example configuration for Nginx can be found [here](https://framagit.org/luc/lufi/wikis/installation#putting-lufi-behind-nginx).

## Role Variables

Set the user/group that will be used to run Lufi. It makes sense to use the webserver user/group.

```
lufi_user: www-data
lufi_group: www-data
```

There are a few mandatory and many optional values. Check all possible variables in `defaults/main.yml`.

```
# Required!
lufi_working_dir: "/var/www/example.com"
lufi_listen: "http://127.0.0.1:8080"
lufi_contact: "admin@example.com"
lufi_secrets: ["array", "of", "random", "secrets"]
# Optional
lufi_theme: "default"
lufi_broadcast_message: "Maintenance"
lufi_allowed_domains: []
```

## Role Tags

Each part of the setup has a tag.

```
lufi.install
lufi.site
lufi.service
```

## Dependencies

None.

## Example Playbook

```
# playbook.yml
---
- hosts: servers
  become: yes
  vars_files:
    - vars/main.yml
  roles:
    - { role: noplanman.lufi }
```
```
# vars/main.yml
---
lufi_working_dir: "/var/www/lufi.example.com"
lufi_listen: "http://127.0.0.1:8080"
lufi_contact: "admin@lufi.example.com"
lufi_secrets: ["xud7ooJu","aiNg7duG","ih7kom8Z","Ocaish3I","Ooja7chi","Eet4weil","Ethee4Go","xahJ0ohy"]
lufi_broadcast_message: "Welcome to Lufi. Upload those files!"
```

## License

MIT
