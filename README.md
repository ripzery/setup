# Setup

A personal set of commands to setup new working machine depending on the OS.

## Common

### Setup Git

1. Install git and configure the user credential

```bash
apt-get update && \
apt-get install -y git && \
git config --global user.email "ripzery@gmail.com" && \
git config --global user.name "euro"
```

2. Add ssh key for GitHub account

On the server:

```bash
cd ~/.ssh && \
ssh-keygen -t rsa -C "ripzery@gmail.com" && \
cat your_ssh_key.pub
```
Copy & paste your public key at https://github.com/settings/keys

3. Add ssh key to agent permanently

```bash
echo "Host *
  AddKeysToAgent yes
  IdentityFile ~/.ssh/gh_id_rsa" > ~/.ssh/config
```

4. Test your connection to GitHub

```bash
echo "yes" | ssh -T git@github.com
```

You should see something similar to

```
Hi ripzery! You've successfully authenticated, but GitHub does not provide shell access.
```

## Debian Server

Run the following command:

```bash
apt-get update && \
apt-get install -y git curl && \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ripzery/setup/master/debian/setup.sh)"
```

**Requirement**:

1. VIM
2. ZSH
3. CLI Tools
4. Git Access Token
5. Add Mosh server. 
6. NVM
7. Node LTS version
8. Nvm and Yarn

## Mac

