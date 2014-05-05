# Experimental Record with GPGME

System for providing for a cryptographically enforced one-way information flow.

- Encrypted records
- Data retention policy - delete after date
- Easily subclassed to create specific types of Encrypted Records

## Dependencies
- gnupg
  - sudo apt-get install gpg
  - brew install gpg
- gpgme
  - sudo apt-get install libgpgme11-dev
  - brew install gpgme

## Crypto-system in place
This system does not invent its own crypto, but uses GnuPG, that implements the
OpenPGP standard.

### Encrypted Message Superclass
The base of the system is `EncryptedMessage`. It needs to be subclassed.

### Filter Attributes

In Ruby on Rails' ActiveRecord models, `attr_accessor` virtual attributes are not written to the Rails log file, but the cipher text blocks are since they are not the standard protected attributes.

For example, an entry in the log for a new `Post` looks like this:

```sql
INSERT INTO "encrypted_messages" ("created_at", "delete_at", "encrypted_body", "encrypted_structured_body", "plaintext_description", "ty
pe", "updated_at") VALUES (?, ?, ?, ?, ?, ?, ?)  [["created_at", "2014-05-05 03:51:04.744500"], ["delete_at", "2016-05-04"], ["encrypted_body", "-----BEGIN PGP MESSAGE-----\nVersion: GnuPG v1\n\nhQIMA4Ybj5/9AZITAQ//XbsQE6NYE87q0uYw4GLXveOCLicp3E3lh+GgQujDy0ao\nMvcSvAzOVy7i5kKklFmS9zaPbvXWsgpdoEMTFsy8QONSyTHMc1LGFARKqhJrqTU7\nNnh6ghZOYPN6RCj1cY/tR41uuGc9A2bocQ35Q4QwnWT1nt/qYeJ0uOAV2biBJKs2\nw6ouiQnEAbeOuyolUb6RJJIs5szrIkswkABA2hEhrqAZILCtKYk/jIlrY55Xgvy4\nd+yo6DYjnXKG8LYe2DXVQeWEcAJrdgEGWjNgdWz3jk+cwWNv+MrskbAgkJO9E/JU\n/jxcXbKlZDwgqeTTUFxx2VPhgoc2MfMbHqrnIAHMbUXFjsXGLKxPr3WBEsKCYNaZ\nKvD0/4D8wcYp0xqwylSHlLX/jA7Urc4pc0IxCgibWWk9SoN7+G3w0XZK7XeKBWJx\n9t84Ozd+kkRexX8wsCGLyPjrDOlkYT9EKdBXAOGDZ3AglDB10c4P+/HKETxlkMCa\nlCXV0+pAhngIygCAE1KD9Vla5aFf9CZJCWHH8UfhUPQBexBhJB1jtD3yFtb8G//5\n2mskBWMqCPgkFUBWFW9FRw5ziHFY6EX1QAYRKI5UcHBYcDlCAOKTX3K4SO0oM833\nL+gBk5M0p7WJUxkrhiWsuTNR/I0/kWokLKXhAiP8yowEq11yNTyof2DUAA3o4naF\nAgwDsLLo+5HI/r8BEACY0fBTdkEMAsA8A+eqI2SvputWzNJOpdAh1hQxW2DGVdfz\nXPxHJxRp46e95bXvsuKEwno35QVCb6iAZkb5VHAMLV5dbUlq7DtfzQvsa+oldAIw\n0v/bSSO3RvCGEcdcf/jufdjN7zsAIuz5RZD2PxHKgQ6YZ0HlL9ucl84YFGk92Jq6\n6GhZsSkRpUmPfg6Nu+jALW89xN3H2aWFQJlLGnCt+5mZliycnM5uJ2UO0L+od3m0\nvrQKdSbU4rq/ZcUl0B4scIT+R/9s0SmpZahnwfZAQlUjYOnOnZZLNcPThCvBv3RH\nTO9c044DnNCZ1lyTyvhP2Iq+KBUf6YWdQXpdVJawUWOYkNUj5Rf5ACVyrbbJ+KWD\nITSDNgjnLP7Oh/RJAxCzdu49u/9cgTQiI91JuuRIQr6IAwrMQIPVKw+GmSG5kkbw\ntxj19vZrKwLQnzzcIAFQ4jDj1Nk13b2AHqxadHfHOWJlv+voHwy4+mvXvMRLAl6Z\nnPKgbYn8rSJOYthOKlQ5hgCEu9vfJ6ZuZ4KPGtZ1ULPjoKZ4Uo+cQbBami8Nrygd\nsq4hv8dwLqH11/WHRCrQ5oPVYyPKcxz06T2yKFwfLXI437gVzzTPGTSwup5B3W+t\nEERfvBClPXgZz/0D1d+RC8lczIpKbX4PogrNhXI0jcRjIUJFtQaFpP71+Ra8RIUB\nDANdgCrVDNiyVQEIAIFTCUK9MIpSr3vZrEAaotKTsFEfs6Y2Pk4/ytfWXU6pwHcX\nmmx01TMiR1miOpxg0AdkYoRPxODcUn2cLZNzVFcCM9YVGzMrktlSurJOH8HPz22U\nV1OtXCapq07SV138lKfkFI2BC0tK5upYpD0sC98P1KRP4i8epe2OLl689Xk4aQmF\n8JxJ9/bH9czl1dcYz7S+tTUYwHl1PdS9rXeSOIP0sviXhBF8DxyMApN3NuAsmLSu\nNDImGyUEBIvlm/AaBPdihDJuWCqT+XkYdkBXOTlqVDlS1f/zQk/lxKlGtVRMkTPm\nzwxs1l04DQmd+7ui7ZmAvDIC2oDFTVd6VQY6bGfSjAHJyxN6dmqZxAj0ChhI+6p8\nslEnR2nRQfnpnrrhSTPtpUevKvj767/0EDPNBXBKe/Eh9f+wGvfRxZ3YUD9rXslt\nr04lQ45ZqZ/ED+Ii+U/NqhXo3sjYGDqd/U00bh/IYRlm7aAkFnAIgrDFI2Ci/RLM\ncaYGKCEFl4HAupATWdyQa/1P3R+3O67hL2SC\n=BEK/\n-----END PGP MESSAGE-----\n"], ["encrypted_structured_body", "-----BEGIN PGP MESSAGE-----\nVersion: GnuPG v1\n\nhQIMA4Ybj5/9AZITARAAjUxVHFNBTkSMiVx5Pa9bNJXyxYMJ+0DHIepOk5h3/6GA\nlBlGvNJslS8F43YD+i8OyummDlOhiGqFdrM9DW5a94a2CRRu8LOn/odqsEF7hHkl\nzhm4h6DbzhfctsWnbNUbJ6ZwPoNJM0NpIRLQsq8jaHdnN659UEgJYcC1nwQUU7qr\nR9d6QSbFRWB9/LmSu8J3zCb7fvZzsL/BQ1+lxoxCBoeKumIho3ozXd6zrLwiurqn\nBnfyCWCoJ82GbOW9fd9ao/A1w6SCjtw7FsLUZwV6mIhbqhLoStTOm9eh1tdNrW+n\n4EvyDNQrFQrEXDwOV7JS+0rNznzjTD+9iIMIST68TKfNOQBi6i2Y3Qq+sjGJOFTj\nh6uRG3fxwo04pD+8+vRw33w3K3OdT1sY9129k2Vmw56zumkIrjvKAtadZhp0+9nA\nJc3RFDE4TX2sex2eF7+tNIm09JP+0Vl9+EwXEUIrFAUYDFW/HGMNyAwoaZPzJMqP\n//F72OlqMuPak1EjSnqak9UvThFIWagoFmMoydGIxNlsRPKyN2NooNWUL0JpwDNp\nrssQwK/6vqBFBn57ivBtqUOI5B7V4UYg6XRpFcnQbbK+wmDAMHZtCHZTkK2jdTIi\nwH9zICcdPlUpUPS01DBldGuMdrxn4/LqpfC0PYnimrq9nVkOA3xMM5xbgjYdy5aF\nAgwDsLLo+5HI/r8BEAC0bNGS48C+W6nxPQ+TsBH1hAAvGz9uRRfEfzfBW0KgIB/g\naPNY78P3+a4K2tZw5kIHy6rfKLzZbfvOhFvtj/2VwUgdAnSUYM7R0yre9183mRse\nbKBxMtW79bgsYCfj5svweapBE9sPoDxpFXvJG9heoD5QnIzTY5Ef81KWe/PAWvbz\nkuX35jopWWp9dXFSlZ4u/5lFWuFOGLuib4DTgcCqZlV/Z31t6xfzkTTqJ0ca8IvN\nGcXFG7xJK2bjnaeZhdv/m/wXVS1zcYFt21oqt3m2UEk/4RWHv5CHGL3iLxlsuQZU\nbur4Q+xjfCLdtxrDrolIZDJ8J3uEBu6sQW3ne+YFet2C34kh9KBaj/WnONtdeNe8\nobCIY2qfG2qaCOXq/AjjFsz9gc/3J5tLZOibpQGMgh0CXrDkpXBhNrhtIGVK8RZm\nS4jxIQuT0+85C4irK4QMDwyKInQ5SoBHtzu93VXVkfzvTcWIKpy+B5C1kpkHX6QV\nGu7w60RLYFV9HwyPWw++9AyLqRdiPJ91U2bmb6TMemeCI2gtjvbv6WEM2rxCZ8XW\n/pWbblPWG6o63mN/u+lQsrW25M5OzREE/lyMqordRvUh6e7t91bGbBH6GQ0BPL9O\nwhQwxLko2Tsb6jmdURZN1efcd9WWmocGgpGY5PtLzGZ5YqC02xLqVE+ooH+aFoUB\nDANdgCrVDNiyVQEH+wQ8iz3ZyozB8t19SVYfrSpTqkttli8qcXSLQfyx0X7aRUlN\n68/bfAqrF0kdkPiu52E26ugnOWFDGgtond/AB2gzygYkCuW5btt9VGCf7p88ksSk\nSEXLerYgbrwHtJ3FFyDWCBJlRCSaEW2in2kaKFcWVrpD32+leF2W+z9c799YCTUk\nkXy2gpmaqW2AHKnXHM5/Z7P5TigA1JklKtdjr+sQ8z9yPOSFcgASeQVO+/ztGsHP\nNrWrnWxHDT+u8YaJpPfHMkB01Pskl0Ca0rTZ94twe2CM8E5CFe6XLBmUNYA2mINf\njSlIZxe3jh67T95Ogi2uKHN/A0eT6NpQN+tnZo7SjQEBRz06y6IZfVPTyD2lDIP4\nMsI9vE50NaYSivYF2tm/ttZW1S1MDhd1As/hideiaVGNKCwlHG5Wz9vL6Nrr/9YU\na8AXMdDMlX+YKyOmVw0Xbag8vDMSBkrAFuaynBn6BqAWZ8KBMA1Q5cKpFzX8YtL0\n03LsMbbxAxc31XqMdAYd8GfEPZIwdCLrOCuJVA==\n=11c2\n-----END PGP MESSAGE-----\n"], ["plaintext_description", "Hello message."], ["type", "Post"], ["updated_at", "2014-05-05 03:51:04.744500"]]
```

This means that the Rails logs contain the ciphertext of the protected message, but as long as the front-end server never has the keys to decrypt them then that is not leaked information.

Even setting a filter parameter in `/config/application.rb` does not stop the ciphertext from being written to the log by the Rails' SQL logger.

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
Even the strongest crypto-system will fall if end-point security fails in a way that leads to the disclosure of the secret keys that gain access to data.

#### The GnuPG Keyring
The system makes use of the GnuPG keyring on the server, that is not managed within the context of the web application.

#### End-user Keys
When the server encrypts data to recipient keys that have never been present on the server and are managed by local end-user systems.

#### Decrypting Server
An alternate configuration. That uses database permissions and a second server to decrypt the contents for authorized users.  *The details are not covered here.*


## Further Reading

- PostgreSQL has GPG support by default too.
- [GnuPG OpenPGP Cards](https://www.gnupg.org/howtos/card-howto/en/smartcard-howto-single.html)


# License and Copyright

## Third-Party Licenses
This project makes use of the [ruby-gpgme gem](https://github.com/ueno/ruby-gpgme/), that is licensed under the terms of the GNU Lesser Public License.

## Our License

Copyright © 2014 Rietta Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

- Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
- Neither the name of the Rietta nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL RIETTA BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.