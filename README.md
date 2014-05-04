# Experimental Record with GPGME

System for providing for a cryptographically enforced one-way information flow.

- Encrypted records
- Data retention policy - delete after date

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

#### End-user Keys
#### Decrytping Server



## Further Reading

- PostgreSQL has GPG support by default too.