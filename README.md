# Experimental Record with GPGME

System for providing for a cryptographically enforced one-way information flow.

- Encrypted records
- Data retention policy - delete after date

## Dependencies
- gnupg
  - sudo apt-get install gpg
  - brew install gpg
- gpgme
  - sudo apt-get install libgpgme11-dev
  - brew install gpgme

## Cryptosystem in place
This system does not invent its own crypto, but uses GnuPG, that implements the
OpenPGP standard.

### Encrypted Message Superclass
The base of the system is `EncryptedMessage`. It needs to be subclassed.

### Filter Attributes

## Weaknesses

### Know plaintext attack
If GnuPG were to be found to be susceptible to a known plaintext attack then an attacker could learn information about the key used because encrypted records have labels or JSON keys in common. **It is not known to be susceptible to this attack with the current modern ciphers.**

This should only be possible for weak ciphers, even the classic DES is not prone to a KPA.

[Re: Known Cleartext Attacks (was Mutt and GPG)](http://marc.info/?l=mutt-users&m=100163863430823&w=2) (the original quoted source is no longer available online.):

> A strong encryption algorithm will be unbreakable not only under
> known plaintext (assuming the enemy knows all the plaintext for a
> given ciphertext) but also under ``adaptive chosen plaintext'' - an
> attack making life much easier for the cryptanalyst. In this attack,
> the enemy gets to choose what plaintext to use and gets to do this
> over and over, choosing the plaintext for round N+1 only after
> analyzing the result of round N.

> For example, as far as we know, DES is reasonably strong even under
> an adaptive chosen plaintext attack (the attack Biham and Shamir
> used). Of course, we do not have access to the secrets of US
> government cryptanalytic services. Still, it is the working
> assumption that DES is reasonably strong under known plaintext and
> triple-DES is very strong under all attacks.

### Key management
Even the strongest cryptosystem will fall if end-point security fails in a way that leads to the disclosure of the secret keys that gain access to data.

#### End-user Keys
#### Decrytping Server



## Further Reading

- PostgreSQL has GPG support by default too.


# License and Copyright

Copyright © 2014 Rietta Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Rietta nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.