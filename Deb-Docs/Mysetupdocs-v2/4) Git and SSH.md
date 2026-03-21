## set up git repo 
``` bash
git init
```

**Create git ignore file and add node_modules, .env, builds etc**

## Stage files
``` bash 
git add .
```

## Commit 
``` bash
git commit -m "Initial commit"
```

## Make repo in git
#### Make SSH key if needed and store the private and copy the public to github
## push to repo
``` bash
git remote add origin git@github.com:yourusername/your-repo.git
git branch -M main
git push -u origin main
```

# Setting up a new PC
## Set up git 
``` bash 
git config --global username
```
``` bash 
git config --global email
```
## generate key and copy it to git
``` bash
ssh-keygen -t ed25519 -C "comment"
```

``` bash
cat ~/.ssh/id_ed25519.pub
```

## Paste into github
1. Log into your GitHub account in a web browser.
2. Click your profile picture in the top right corner and go to **Settings**
3. On the left sidebar, click **SSH and GPG keys**.
4. Click the green **New SSH key** button.
5. Give it a Title (like "Debian Desktop").
6. **Paste** the text you copied from your terminal into the large "Key" box.
7. Click **Add SSH key**.

