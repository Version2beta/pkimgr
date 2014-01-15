# Pkimgr

THIS PROJECT IS NOT PRODUCTION READY. Chances are good it won't work for you even a little, so don't even try, k?

pkimgr makes x.509 certificates, and what it makes it can also take away.

## Installation

Add this line to your application's Gemfile:

    gem 'pkimgr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pkimgr

## Usage

### The state of things

`pkimgr`

Show the current state of pkimgr's world, including the current configuration profile, CAs, host certificates, and client certificates with status of each.

`pkimgr config`

Show the currently configured default values from ~/.pkimgr.conf or /etc/pkimgr.conf.

`pkimgr config --new [filename]`

Create a new configuration file template and output to standard out or `filename`.

`pkimgr config --use filename`

Change to a different configuration profile.

### Certificate authorities

`pkimgr CA`

Show the current and available certificate authorities.

`pkimgr CA --new [keyfile] --sign [--[no]passphrase [passphrase]]`

Create a new certificate authority.

* If keyfile is not provided, create a new key.
* If `--nopassphrase` is given, do not create a passphrase for the CA. NOT RECOMMENDED.
* If `--passphrase` is given without a passphrase, prompt for a passphrase.
* If `--passphrase` is given with a passphrase, use the provided passphrase.
* If `--sign` is given, the new CA certificate will be signed by the currently selected CA, creating the new CA within a CA hierarchy.

pkimgr will change to the new CA after creating it.

`pkimgr CA --use certID`

Change to another certificate authority.

`pkimgr CA --revoke`

Revoke a certificate authority (except a root authority).

### Hosts

`pkimgr host`

Show the current and available host certificates.

`pkimgr host --new [keyfile | CSR] [--[no]passphrase [passphrase]] [--CApassphrase passphrase]`

Create a new host certificate. If keyfile is not provided, also create a new key.

* If keyfile is not provided, create a new key.
* If a CSR is not provided, one will be created interactively.
* If `--nopassphrase` is given, do not create a passphrase for the CA. NOT RECOMMENDED.
* If `--passphrase` is given without a passphrase, prompt for a passphrase.
* If `--passphrase` is given with a passphrase, use the provided passphrase.
* If `--CApassphrase` is not provided, the CA passphrase (if needed) will be requested interactively.

`pkimgr host --revoke certID`

Revoke the host with certID.

### Clients

`pkimgr client`

Show the current and available client certificates.

`pkimgr client --new [keyfile | CSR] [--[no]passphrase [passphrase]] [--CApassphrase passphrase]`

Create a new client certificate. If keyfile is not provided, also create a new key.

* If keyfile is not provided, a new key will be created.
* If a CSR is not provided, one will be created interactively.
* If `--nopassphrase` is given, do not create a passphrase for the CA. NOT RECOMMENDED.
* If `--passphrase` is given without a passphrase, prompt for a passphrase.
* If `--passphrase` is given with a passphrase, use the provided passphrase.
* If `--CApassphrase` is not provided, the CA passphrase (if needed) will be requested interactively.

`pkimgr client --revoke certID`

Revoke the client with certID.

## Sample configuration file

pkimgr configuration is stored as YAML. The preferred location is ~/.pkimgr.conf, but /etc/pkimgr.conf 

```yaml
directory: ~/.pkimgr/
CA:
  days: 7300
  bits: 2048
  cipher: aes256
  message_digest: SHA1
  CN:
    default: ca.example.com admin@example.com
    policy: required
  O:
    default: My Example LLC
    policy: optional
  L:
    default: Anytown
    policy: optional
  ST:
    default: Wisconsin
    policy: optional
  C:
    default: US
    policy: optional
  CAs:
    days: 3650
    bits: 2048
    cipher: aes256
    message_digest: SHA1
    CN:
      default: ca.example.com admin@example.com
      policy: required
    O:
      default: My Example LLC
      policy: optional
    L:
      default: Anytown
      policy: optional
    ST:
      default: Wisconsin
      policy: optional
    C:
      default: US
      policy: optional
host:
  days: 1825
  bits: 2048
  cipher: aes256
  message_digest: SHA1
  CN:
    default: host.example.com admin@example.com
    policy: required
  O:
    default: My Example LLC
    policy: optional
  L:
    default: Anytown
    policy: optional
  ST:
    default: Wisconsin
    policy: optional
  C:
    default: US
client:
  days: 1825
  bits: 2048
  cipher: aes256
  message_digest: SHA1
  CN:
    default: client.example.com admin@example.com
    policy: required
  O:
    default: My Example LLC
    policy: optional
  L:
    default: Anytown
    policy: optional
  ST:
    default: Wisconsin
    policy: optional
  C:
    default: US
```

## Directory structure

pkimgr's home directory is organized as follows:

* .pkimgr
  * CA.cert
  * CA.key
  * serials.txt
  * crl-list.txt
  * crl-index.txt
  * CAs (Subordinate certificate authorities)
    * N
      * CA.cert
      * CA.key
      * serials.txt
      * crl-list.txt
      * crl-index.txt
      * hosts
        * N
          * N.key
          * N.cert
        * N+1
          * ...
      * clients
        * N
          * N.key
          * N.cert
        * N+1
          * ...
    * N+1
      * ...
  * hosts
    * N
      * N.key
      * N.cert
    * N+1
      * ...
  * clients
    * N
      * N.key
      * N.cert
    * N+1
      * ...

## Contributing

1. Fork it ( http://github.com/<my-github-username>/pkimgr/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
