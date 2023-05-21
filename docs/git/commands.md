---
title: Commands
---

### Git log

1. Log

```sh
git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all
```

## Git tags

### Fetch all git tags

```sh
git fetch --all --tags
```

### Annotatate Tag

```sh
git tag -a [tag_name] [commit_SHA] -m "Tag notes"
```
