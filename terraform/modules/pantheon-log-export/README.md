This is a stripped down version of the official log-export module
https://github.com/terraform-google-modules/terraform-google-log-export

Our version skips functionality we do not need in the Pantheon
context. Moreover, we provided a hard-coded filter expression that is
required with Pantheon on the receiving side.
