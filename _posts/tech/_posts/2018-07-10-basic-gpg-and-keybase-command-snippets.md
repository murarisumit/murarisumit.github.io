---
title: gpg and keybase basic command snippets
date: '2018-07-10 00:00:00 +0000'
layout: post
tags:
- crypto
category:
- tech
---

Keybase provides key directory service, basically "it maps your identity to your public keys, and vice versa". Since it has a pgp key directory service, below are snippets that we can use to play with keybase and gpg2.


* List gpg keys:
  * `keybase pgp list`
  * Using gpg :  `gpg --list-keys`

* List secret gpg keys:
  * `keybase pgp list`
  * Using gpg: `gpg --list-secret-keys`

* Get you public key
  * `keybase pgp export > public.key`
  * Using gpg: `gpg --export -a email-id`

* Get your private key
  * `keybase pgp export -s > private.key`
  * Using gpg: `gpg --export-secret-key -a email-id > private.key`

* Import your in local gpg keyring
  * `gpg --import private.key`

* Use gpg to edit key, for adding or removing identities:
  * `gpg --edit-key myname@keybase.io` 
  * `gpg --edit-key email@id.here` 

  * List the user ids:
      * `gpg> uid`

  * Select the user id:
      * `gpg> uid 2`

  * Adding new uid to private key
    * `gpg> adduid`

  * Incase you want to remove some id.
    * `gpg> revuid`

  * Save the changes
    * `gpg> save`

* Update the details with keybase
  * `keybase gpg update`

  * It should say:
  ```
  ▶ INFO Posting update for key xxxxxxxxxxxxxxxxxxx.
  ▶ INFO Update succeeded for key xxxxxxxxxxxxxxxxxxxxx.
  ```  

---
For more gpg commands: [https://medium.com/@acparas/gpg-quickstart-guide-d01f005ca99](https://medium.com/@acparas/gpg-quickstart-guide-d01f005ca99)

---
Reference:

* Keybase command line tool in-build help, Usage : `keybase pgp help`
* [https://www.nico-maas.de/?p=1522](https://www.nico-maas.de/?p=1522)
* [https://www.ahmadnassri.com/blog/github-gpg-keybase-pgp/](https://www.ahmadnassri.com/blog/github-gpg-keybase-pgp/)
* [https://coderwall.com/p/tx_1-g/gpg-change-email-for-key-in-pgp-key-servers](https://coderwall.com/p/tx_1-g/gpg-change-email-for-key-in-pgp-key-servers)



