# Setup

A personal set of commands to setup new working machine depending on the OS.

## Common



## Debian Server

**Prequisite**

1. Install git to be able to clone the repo with the following command:

```bash
echo y | apt-get install git
```

2. Add ssh key for GitHub account

On the server:

```bash
cd ~/.ssh
ssh-keygen -t rsa -C "your_email"
cat your_ssh_key.pub
```
Copy & paste your public key at https://github.com/settings/keys

3. Add ssh key to agent

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/your_ssh_key
```

**Requirement**:

1. VIM
2. ZSH
3. Font
4. CLI Tools
5. Git Access Token
6. Add Mosh server

### Setup VIM



## Mac

