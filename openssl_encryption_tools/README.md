# OpenSSL Encryption & Decryption Scripts
## Overview ##
Scripts to encrypt/decrypt files with a password via OpenSSL.
## Usage ##
```
Usage:
  encrypt <filename>
  decrypt <filename.aes>
```
## Example ##
```
[gdalziel@wintermute ~]$ tar -tf backup.tar.gz
./
./test2.rb
./test3.json
./results.txt
./aws_output.json
./test.rb
./volumes.txt
./test.json
./mapping.json
./aws-admin.rb
./test2.json
./aws-sdk-3.0.1.gem

[gdalziel@wintermute ~]$ encrypt backup.tar.gz
enter aes-256-cbc encryption password:
Verifying - enter aes-256-cbc encryption password:

[gdalziel@wintermute ~]$ ll
total 92
-rw-r--r--. 1 root root 37813 Dec  6 11:14 backup.tar.gz
-rw-r--r--. 1 root root 51245 Dec  6 11:15 backup.tar.gz.aes

Note: The original unencrypted file still exists. You can remove this manually if desired.

[gdalziel@wintermute ~]$ rm backup.tar.gz

[gdalziel@wintermute ~]$ decrypt backup.tar.gz.aes
enter aes-256-cbc decryption password:

[gdalziel@wintermute ~]$ ll
total 92
-rw-r--r--. 1 root root 37813 Dec  6 11:20 backup.tar.gz
-rw-r--r--. 1 root root 51245 Dec  6 11:15 backup.tar.gz.aes

[gdalziel@wintermute ~]$ tar -tf backup.tar.gz
./
./test2.rb
./test3.json
./results.txt
./aws_output.json
./test.rb
./volumes.txt
./test.json
./mapping.json
./aws-admin.rb
./test2.json
./aws-sdk-3.0.1.gem
