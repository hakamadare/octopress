---
type: post
title: "SSL Root Certificate Hashes"
date: 2014-07-02 10:10:35 -0400
comments: true
categories: signal ssl
---
Speaking of things about SSL that I am tired of forgetting:

Programs that use OpenSSL libraries (including the OpenSSL command-line tools) can sometimes need handholding in order to find their certificate authority root certificates.  For example, here's me trying to verify that a newly deployed certificate is valid:

```console
$ openssl s_client -connect ${HOSTNAME}:443 </dev/null
CONNECTED(00000003)
depth=1 /C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert High Assurance CA-3
verify error:num=20:unable to get local issuer certificate
verify return:0
```

What you say?  I tested this cert on my workstation before deployment, and I don't see any certificate errors in Chrome or Firefox.  Hm... oh, facepalm, I forgot to tell it where to look for CA roots.

```console
$ openssl s_client -CApath /etc/ssl/certs -connect ${HOSTNAME}:443 </dev/null
CONNECTED(00000003)
depth=1 /C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert High Assurance CA-3
verify error:num=20:unable to get local issuer certificate
verify return:0
```

Um.  The CA root is totally in that directory, I checked.  Paul Heinlein's OpenSSL Command-Line HOWTO [to the rescue](http://www.madboa.com/geek/openssl/#verify-system)!

In brief: it's not sufficient to simply drop the CA root into your certs directory, you also have to create a symlink based on the hash value of the root certificate.  Paul provides a helper script:

```shell
#!/bin/sh
#
# usage: certlink.sh filename [filename ...]

for CERTFILE in $*; do
  # make sure file exists and is a valid cert
  test -f "$CERTFILE" || continue
  HASH=$(openssl x509 -noout -hash -in "$CERTFILE")
  test -n "$HASH" || continue

  # use lowest available iterator for symlink
  for ITER in 0 1 2 3 4 5 6 7 8 9; do
    test -f "${HASH}.${ITER}" && continue
    ln -s "$CERTFILE" "${HASH}.${ITER}"
    test -L "${HASH}.${ITER}" && break
  done
done
```

You need to run this on the host where your **client** is, not the host that is serving out your SSL-enabled content!  And now peace and tranquility are restored:

```console
$ certlink.sh <CA ROOT CERTIFICATE>.crt
$ openssl s_client -CApath /etc/ssl/certs -connect ${HOSTNAME}:443 </dev/null
depth=2 /C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert High Assurance EV Root CA
verify return:1
depth=1 /C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert High Assurance CA-3
verify return:1
depth=0 /C=US/<SOME OTHER CN>
verify return:1
DONE
CONNECTED(00000003)
```
