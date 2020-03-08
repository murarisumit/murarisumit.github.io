---
title: OpenPGP Digital Signature and Encryption.
date: '2020-03-08 00:00:00 +0000'
layout: post
tags:
- crypto
category:
- tech
---

---

### **Authentication via Digital Signature**

The digital signature uses a hash code or message digest algorithm,
and a public-key signature algorithm.  The sequence is as follows:

1.  The sender creates a message.

2.  The sending software generates a hash code of the message.

3.  The sending software generates a signature from the hash code
   using the sender's private key.

4.  The binary signature is attached to the message.

5.  The receiving software keeps a copy of the message signature.

6.  The receiving software generates a new hash code for the received
   message and verifies it using the message's signature.  If the
   verification is successful, the message is accepted as authentic.

---

### **Confidentiality via Encryption**

OpenPGP combines symmetric-key encryption and public-key encryption
to provide confidentiality.  When made confidential, first the object
is encrypted using a symmetric encryption algorithm.  Each symmetric
key is used only once, for a single object.  A new "session key" is
generated as a random number for each object (sometimes referred to
as a session).  Since it is used only once, the session key is bound
to the message and transmitted with it.  To protect the key, it is
encrypted with the receiver's public key.  The sequence is as
follows:

1. The sender creates a message.

2. The sending OpenPGP generates a random number to be used as a
   session key for this message only.

3. The session key is encrypted using each recipient's public key.
   These "encrypted session keys" start the message.

4. The sending OpenPGP encrypts the message using the session key,
   which forms the remainder of the message.  Note that the message
   is also usually compressed.

5. The receiving OpenPGP decrypts the session key using the
   recipient's private key.

6. The receiving OpenPGP decrypts the message using the session key.
   If the message was compressed, it will be decompressed.

With symmetric-key encryption, an object may be encrypted with a
symmetric key derived from a passphrase (or other shared secret), or
a two-stage mechanism similar to the public-key method described
above in which a session key is itself encrypted with a symmetric
algorithm keyed from a shared secret.

Both digital signature and confidentiality services may be applied to
the same message.  First, a signature is generated for the message
and attached to the message.  Then the message plus signature is
encrypted using a symmetric session key.  Finally, the session key is
encrypted using public-key encryption and prefixed to the encrypted
block. 


---
Related Posts: 
* [{{ site.url}}/posts.html#crypto]({{ site.url}}/posts.html#crypto)

---
Reference:
* [https://tools.ietf.org/html/rfc4880](https://tools.ietf.org/html/rfc4880)

