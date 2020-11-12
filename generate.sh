#!/bin/bash

KEYTOOL=$JAVA_HOME/bin/keytool

GENEARTED_DIR=generated
KEYSTORE=${GENEARTED_DIR}/keystore.p12
TRUSTSTORE=${GENEARTED_DIR}/truststore.p12
CERT=${GENEARTED_DIR}/cert.cer
PASSWORD=changeit
ALIAS=ivy

# clean
rm -rf ${GENEARTED_DIR}
mkdir ${GENEARTED_DIR}

# create a keystore with a certificate
$KEYTOOL -genkeypair \
    -v \
    -keystore $KEYSTORE \
    -storepass $PASSWORD \
    -storetype 'pkcs12' \
    -alias $ALIAS \
    -dname 'CN=AXON Ivy AG, OU=DEVELOPMENT, O=AXON Ivy AG, L=Zug, ST=Zug, C=CH' \
    -keypass $PASSWORD \
    -validity '730' \
    -keyalg 'RSA' \
    -keysize '2048' \
    -sigalg 'SHA256withRSA' \
    -ext 'san=dns:localhost,ip:127.0.0.1'

# export certificate
$KEYTOOL -export \
    -v \
    -keystore $KEYSTORE \
    -storepass $PASSWORD \
    -alias $ALIAS \
    -file $CERT

# create truststore with certificate
$KEYTOOL -importcert \
    -v \
    -keystore $TRUSTSTORE \
    -noprompt \
    -keypass $PASSWORD \
    -storepass $PASSWORD \
    -alias $ALIAS \
    -file $CERT

rm $CERT
