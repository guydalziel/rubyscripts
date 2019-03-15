# OpenSSL Encryption & Decryption Scripts
## Overview ##
Scripts to encrypt/decrypt files with a password via OpenSSL.
## Usage ##
```
Usage:
  encrypt [options] <filename>
  decrypt [options] <filename.aes>
```
## Options ##
```
  -r, --retain        Do not remove original files when performing encryption/decryption.
```
## Example ##
```
[gdalziel@wintermute openssl_encryption_tools]$ echo "this is a test" > new

[gdalziel@wintermute openssl_encryption_tools]$ ll
total 16
-rwxrwxr-x. 1 gdalziel gdalziel  824 Mar 15 11:47 decrypt
-rwxrwxr-x. 1 gdalziel gdalziel  826 Mar 15 11:46 encrypt
-rw-rw-r--. 1 gdalziel gdalziel   15 Mar 15 11:47 new
-rw-rw-r--. 1 gdalziel gdalziel 1297 Mar 15 11:01 README.md

[gdalziel@wintermute openssl_encryption_tools]$ ./encrypt new
enter aes-256-cbc encryption password:
Verifying - enter aes-256-cbc encryption password:

[gdalziel@wintermute openssl_encryption_tools]$ ll
total 16
-rwxrwxr-x. 1 gdalziel gdalziel  824 Mar 15 11:47 decrypt
-rwxrwxr-x. 1 gdalziel gdalziel  826 Mar 15 11:46 encrypt
-rw-rw-r--. 1 gdalziel gdalziel   45 Mar 15 11:48 new.aes
-rw-rw-r--. 1 gdalziel gdalziel 1297 Mar 15 11:01 README.md

[gdalziel@wintermute openssl_encryption_tools]$ cat new.aes
U2FsdGVkX18ootkSdMl3pEeFe++UVIoz05hWGlCKOp0=

[gdalziel@wintermute openssl_encryption_tools]$ ./decrypt new.aes
enter aes-256-cbc decryption password:

[gdalziel@wintermute openssl_encryption_tools]$ ll
total 16
-rwxrwxr-x. 1 gdalziel gdalziel  826 Mar 15 11:53 decrypt
-rwxrwxr-x. 1 gdalziel gdalziel  826 Mar 15 11:53 encrypt
-rw-rw-r--. 1 gdalziel gdalziel   15 Mar 15 11:53 new
-rw-rw-r--. 1 gdalziel gdalziel 1297 Mar 15 11:01 README.md

[gdalziel@wintermute openssl_encryption_tools]$ cat new
this is a test
