---
title: Setting up pass
---

### Install pass & gpg

```bash
apt install pass gpg
```

### Generate gpg keys

```bash
gpg --full-generate-key
```

### View gpg secrets

```bash
gpg --list-secret-keys --keyid-format LONG
```

### Initialize pass

```bash
pass init <<gpgid>>
```

### Insert pass

```bash
pass insert account
# e.g.
# pass insert vault
```

### Generate random password

```bash
pass generate -n -f pass-name pass-length
# e.g.
# pass generate -n -f local/vault 25
```