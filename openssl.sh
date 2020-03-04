OPENSSL_PASSPHRASE=

openssl_decrypt() {
    cat | openssl enc -d -aes-256-cbc -a -k $OPENSSL_PASSPHRASE 2>/dev/null
}
