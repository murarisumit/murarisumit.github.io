---
title: GPG basic command snippets
date: '2017-08-25 02:18:53 +0000'
layout: post
tags:
- crypto
---

* I use keybase for keeping gpg 


* Download Private and Public Key from Keybase.io (edit Button next to Key on Profile, Export my Private Key, Key Checksum for Export of Public Key)

* Import gpg private and public key.
  * `gpg --allow-secret-key-import --import keybase-private.key
  * gpg --import keybase-public.key

List gpg keys:
* `gpg --list-keys`

Open deatils in edit key
* `gpg --edit-key myname@keybase.io` 

Adding new uid to private key
* `gpg> adduid`

Remove old uid user from private key 
* ```gpg> uid <old uid number>
gpg> revuid
Really revoke this user ID? (y/N) y
Your decision? 4
Enter an optional description; end it with an empty line: <description>
Is this okay? (y/N) y
</description>
</old> 
```

Reference: 
* [https://www.nico-maas.de/?p=1522](https://www.nico-maas.de/?p=1522)
* [https://coderwall.com/p/tx_1-g/gpg-change-email-for-key-in-pgp-key-servers](https://coderwall.com/p/tx_1-g/gpg-change-email-for-key-in-pgp-key-servers)

