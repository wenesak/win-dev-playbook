# Win dev playbook

This playbook installs and configures most of the software I use on my Windows machine and
my WSL development environtment on that machine. It uses Ansible from within a WSL environment to
both update the WSL environment itself as well as it's Windows host.

Some things in Windows are slightly difficult to automate,
so I still have some manual installation steps, but at least it's  going to be all documented here.

This is a work in progress, and is mostly a means for me to document my current Windows's /WSL setup.
I'll be evolving this set of playbooks over time.

For a Mac? See: [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)

## Upgrade to Ansible 2.10 and higher

Don't!. No serious ;) First uninstall Ansible 2.9 or lower. Upgrading does not
work.

Install ansible 2.10 and higer  with:

```shell
pip install ansible-base
pip install ansible
```

