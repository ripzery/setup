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

3. Add ssh key to agent permanently

```bash
echo "Host *
  AddKeysToAgent yes
  IdentityFile ~/.ssh/gh_id_rsa" > ~/.ssh/config
```

4. Test your connection to GitHub

```bash
echo "y" | ssh -T git@github.com
```

Your should see something similar to

```
Hi ripzery! You've successfully authenticated, but GitHub does not provide shell access.
```

5. Clone this repo

```bash
mkdir workspace && cd workspace
git clone git@github.com:ripzery/setup.get && cd setup
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

