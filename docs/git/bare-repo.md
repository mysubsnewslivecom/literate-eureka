```
git init --bare $HOME/.cfg

echo "alias dot='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bash_aliases

alias dot='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

dot config --local status.showUntrackedFiles no

dot remote add origin git@github.com:mysubsnewslivecom/cfg.git

dot remote set-url origin git@github.com:mysubsnewslivecom/cfg.git

```