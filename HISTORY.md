It's a fork of Bristol 0.60.11 from archive available on [sourceforge](https://sourceforge.net/projects/bristol/). See ChangeLog and NEWS.

Local changes:
- [bristol: FTBFS: audioEngineJack.c:42:26: fatal error: alsa/iatomic.h: No such file or directory](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=834180) 
- [#93 extended ascii char. from keyboard are ignored ](https://sourceforge.net/p/bristol/bugs/93/)

> ***TODO*** The code version 0.60.11 from the repo on sourceforge is not working anymore under last version of Debian. See branch 0.60.11-3 (i.e. the last one, on 11/2019) from [Debian fork](https://salsa.debian.org/multimedia-team/bristol). Apply on it the patches [#93 extended ascii char. from keyboard are ignored ](https://sourceforge.net/p/bristol/bugs/93/).

```bash

PROJECT_VER=0.60
PROJECT_SUB_VER=.11
PROJECT_LOCAL_SUB_VERSION=-0B   # add suffix '-0B' to the changed version
PROJECT_ROOT_NAME=bristol
PROJECT_NAME=$PROJECT_ROOT_NAME-$PROJECT_VER$PROJECT_SUB_VER
ARCH_FILE_NAME=$PROJECT_NAME.tar.gz
ARCH_REPO=https://freefr.dl.sourceforge.net/project

wget $ARCH_REPO/$PROJECT_ROOT_NAME/$PROJECT_ROOT_NAME/$PROJECT_VER/$ARCH_FILE_NAME
# --2019-11-12 10:55:08--  https://freefr.dl.sourceforge.net/project/bristol/bristol/0.60/bristol-0.60.11.tar.gz
# Résolution de freefr.dl.sourceforge.net (freefr.dl.sourceforge.net)… 2a01:e0d:1:8:58bf:fa88:0:1, 88.191.250.136
# Connexion à freefr.dl.sourceforge.net (freefr.dl.sourceforge.net)|2a01:e0d:1:8:58bf:fa88:0:1|:443… connecté.
# requête HTTP transmise, en attente de la réponse… 200 OK
# Taille : 4218697 (4,0M) [application/x-gzip]
# Enregistre : «bristol-0.60.11.tar.gz»
#
# bristol-0.60.11.tar.gz                               100%[====================>]   4,02M  96,5KB/s    ds 34s     
#
# 2019-11-12 10:55:43 (121 KB/s) - «bristol-0.60.11.tar.gz» enregistré [4218697/4218697]

tar -zxvf $ARCH_FILE_NAME && rm -f $ARCH_FILE_NAME
# [...]

mv $PROJECT_NAME $PROJECT_NAME$PROJECT_LOCAL_SUB_VERSION

cd $PROJECT_NAME$PROJECT_LOCAL_SUB_VERSION

git init
# Dépôt Git vide initialisé dans /home/pierre/DevSpace/perso-sound/bristol-0.60.11-0B/.git/

git add --all

git commit -m "Initial code cloned from bristol 0.60.11"
# [...]

touch HISTORY.md

code .

sudo dpkg -l libx11-dev libasound2-dev jackd libjack-dev
# Souhait=inconnU/Installé/suppRimé/Purgé/H=à garder
# | État=Non/Installé/fichier-Config/dépaqUeté/échec-conFig/H=semi-installé/W=attend-traitement-déclenchements
# |/ Err?=(aucune)/besoin Réinstallation (État,Err: majuscule=mauvais)
# ||/ Nom                                            Version                      Architecture                 Description
# +++-==============================================-============================-============================-==================================================================================================
# ii  jackd                                          5                            all                          JACK Audio Connection Kit (default server package)
# ii  libx11-dev:amd64                               2:1.6.4-3ubuntu0.2           amd64                        X11 client-side library (development headers)
# dpkg-query: aucun paquet ne correspond à libasound2-dev
# dpkg-query: aucun paquet ne correspond à libjack-dev

sudo apt-get install -y libasound2-dev libjack-dev
# [...]
# Les paquets suivants seront ENLEVÉS :
#   jackd2 jackd2-firewire libjack-jackd2-0
# Les NOUVEAUX paquets suivants seront installés :
#   jackd1 jackd1-firewire libasound2-dev libjack-dev libjack0 libzita-alsa-pcmi0 libzita-resampler1 pkg-config uuid-dev
# 0 mis à jour, 9 nouvellement installés, 3 à enlever et 220 non mis à jour.
# Il est nécessaire de prendre 716 ko dans les archives.
# Après cette opération, 2 081 ko d'espace disque supplémentaires seront utilisés.
# Réception de:1 http://fr.archive.ubuntu.com/ubuntu bionic/universe amd64 jackd1 amd64 1:0.125.0-3 [183 kB]
# Réception de:2 http://fr.archive.ubuntu.com/ubuntu bionic/universe amd64 libjack0 amd64 1:0.125.0-3 [94,4 kB]
# Réception de:3 http://fr.archive.ubuntu.com/ubuntu bionic/universe amd64 libzita-alsa-pcmi0 amd64 0.2.0-4ubuntu2 [12,0 kB]
# Réception de:4 http://fr.archive.ubuntu.com/ubuntu bionic/universe amd64 libzita-resampler1 amd64 1.6.0-2 [10,5 kB]
# Réception de:5 http://fr.archive.ubuntu.com/ubuntu bionic/universe amd64 jackd1-firewire amd64 1:0.125.0-3 [10,7 kB]
# Réception de:6 http://fr.archive.ubuntu.com/ubuntu bionic-updates/main amd64 libasound2-dev amd64 1.1.3-5ubuntu0.2 [123 kB]
# Réception de:7 http://fr.archive.ubuntu.com/ubuntu bionic/main amd64 pkg-config amd64 0.29.1-0ubuntu2 [45,0 kB]
# Réception de:8 http://fr.archive.ubuntu.com/ubuntu bionic-updates/main amd64 uuid-dev amd64 2.31.1-0.4ubuntu3.4 [33,2 kB]
# Réception de:9 http://fr.archive.ubuntu.com/ubuntu bionic/universe amd64 libjack-dev amd64 1:0.125.0-3 [204 kB]
# 716 ko réceptionnés en 5s (146 ko/s)  
# [...]

sudo apt-get remove -y libasound2-dev libjack-dev
# [...]
# Les paquets suivants seront ENLEVÉS :
#   libasound2-dev libjack-dev
# [...]

sudo apt-get remove -y jackd1 jackd1-firewire libjack0 libzita-alsa-pcmi0 libzita-resampler1 pkg-config uuid-dev
# [...]
# Les paquets suivants seront ENLEVÉS :
#   jackd1 jackd1-firewire libjack0 libzita-alsa-pcmi0 libzita-resampler1 pkg-config uuid-dev
# Les NOUVEAUX paquets suivants seront installés :
#   jackd2 jackd2-firewire libjack-jackd2-0
# Les paquets suivants seront mis à jour :
#   gstreamer1.0-plugins-good libgstreamer-plugins-base1.0-0 libgstreamer-plugins-good1.0-0 libgstreamer1.0-0
# [...]

sudo apt-get install -y libasound2-dev libjack-jackd2-dev
# [...]
# Les NOUVEAUX paquets suivants seront installés :
#   libasound2-dev libjack-jackd2-dev pkg-config
# [...]

### See https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=834180

sed -i '\|alsa/iatomic.h| s|.*|//&|' libbristolaudio/audioEngineJack.c

./configure
# [...]
# [...]
# bristol 0.60.11 :
#
# | Build with OSS support ......................... : true
# | Build with ALSA support ........................ : true
# | Build with JACK support ........................ : true
# | Build with JACK MIDI support ................... : true
# | Build with JACK Session support ................ : true
# | Default audio drivers .......................... : alsa
# | Default MIDI drivers ........................... : alsa
# | Build with Graphical Interface ................. : true
# | Compile with GUI support ....................... : true
# | Bin directory .................................. : /usr/local/bin
# | Lib directory .................................. : /usr/local/lib
# | Data directory ................................. : /usr/local/share/bristol
# | Default voicecount ............................. : BRISTOL_VOICECOUNT=32
# | author ......................................... : Nick Copeland
# | email .......................................... : nickycopeland@hotmail.com
# | web ............................................ : http://bristol.sf.net
#
# execute 'make install' then 'startBristol'

make
# [...]
# make[2] : on quitte le répertoire « /home/pierre/DevSpace/perso-sound/bristol-0.60.11-0B/bin »
# make[2] : on entre dans le répertoire « /home/pierre/DevSpace/perso-sound/bristol-0.60.11-0B »
# make[2] : on quitte le répertoire « /home/pierre/DevSpace/perso-sound/bristol-0.60.11-0B »
# make[1] : on quitte le répertoire « /home/pierre/DevSpace/perso-sound/bristol-0.60.11-0B »

sudo make install
# [...]
# mkdir -p -m 0755 /usr/local/bin
# /bin/bash /home/pierre/DevSpace/perso-sound/bristol-0.60.11-0B/install-sh -c -m 0755 bin/startBristol /usr/local/bin
# /usr/bin/install -c -d /usr/local/share/man/man1
# /usr/bin/install -c -m 0644 ./bristol.1 /usr/local/share/man/man1/
# /usr/bin/install -c -m 0644 ./bristoljackstats.1 /usr/local/share/man/man1/
# gzip -9fn /usr/local/share/man/man1/bristol.1
# gzip -9fn /usr/local/share/man/man1/bristoljackstats.1
# cd /usr/local/share/man/man1 && ln -sf bristol.1.gz brighton.1.gz && ln -sf bristol.1.gz startBristol.1.gz

cat > .gitignore << ___EOF
archives
*.original

Makefile
.deps
.libs
*.log
*.o
*.a
*.lo
*.la

/config.h
/config.status
/libtool
/stamp-h1
/bin/startBristol
/bin/bristoljackstats
/brighton/brighton
/bristol/bristol
___EOF

qjackctl &
# [1] 17101

startBristol -mini -jack &
# [2] 12705
# jackstats found -rate 44100 -count 1024
# checking availability of TCP port 5006
# using port 5006
# starting logging thread [@1573623628.484177]
# Copyright (c) by Nick Copeland <nickycopeland@hotmail.com> 1996,2012
# [...]
# Nov 12 12:57:12 bristol  [3.438118] Found port system:playback_1
# Nov 12 12:57:12 bristol  [3.438211] Found port system:playback_2
# Nov 12 12:57:12 bristol  [3.438233] Found port system:capture_1
# Nov 12 12:57:12 bristol  [3.438247] Found port system:capture_2

### check that Bristol works as expected using Qjack:
#   - start the server if needed (required to display the clients on audio tab under Qsynth)
#   - click on "Connect"
#   - select tab "Audio"
#   - on left side, list "Readable Clients / Input Ports", select "bristol"
#   - on right side, list "Writable Clients / Output Ports", select "system"
#   - click on "Connect"
#   - play on the synthesizer keyboard
#   OK

killall bristol
# Nov 13 06:42:14 bristol  [106.113518] closedown on interrupt
# pierre@station-dev:~/DevSpace/perso-sound/bristol-0.60.11-0B$ Nov 13 06:42:14 brighton [106.190758] no data in alsa buffer for 0 (close)
# Nov 13 06:42:15 brighton [106.930763] brighton event thread exited
# Nov 13 06:42:15 brighton [106.930832] terminating logging thread (0)
#
# [2]+  Fini                    startBristol -mini -jack

killall qjackctl
```
ATM Qjack doesn't display Bristol as input in Alsa tab, only in MIDI tab.
To allow a device as input to bristol, eg an Akai LPK25, force alsa as MIDI driver:

```bash
qjackctl &
startBristol -b3 -audio jack -midi alsa &
### check that Bristol works as expected using Qjack:
#   - start the server if needed (required to display the clients on audio tab under Qsynth)
#   - click on "Connect"
#   - select tab "Audio"
#   - on left side, list "Readable Clients / Input Ports", select "bristol"
#   - on right side, list "Writable Clients / Output Ports", select "system"
#   - select tab "ALSA"
#   - on left side, list "Readable Clients / Input Ports", select "xxx:LPK25"
#   - on right side, list "Writable Clients / Output Ports", select "xxx:bristol"
#   - click on "Connect"
#   - play on the synthesizer keyboard
#   OK

```

Setup the connection from the command line:

```bash
qjackctl &
startBristol -b3 -audio jack -midi alsa &

aconnect -i
# client 0: 'System' [type=noyau]
#     0 'Timer           '
#     1 'Announce        '
# client 14: 'Midi Through' [type=noyau]
#     0 'Midi Through Port-0'
# client 24: 'LPK25' [type=noyau,card=2]
#     0 'LPK25 MIDI 1    '

aconnect -o
# client 14: 'Midi Through' [type=noyau]
#     0 'Midi Through Port-0'
# client 24: 'LPK25' [type=noyau,card=2]
#     0 'LPK25 MIDI 1    '
# client 129: 'bristol' [type=utilisateur,pid=15165]
#     0 'bristol input   '

#*: aconnect 24:0 129:0
aconnect 24:LPK25 129:bristol

jack_lsp -A
# system:capture_1
#    alsa_pcm:hw:0:out1
# system:capture_2
#    alsa_pcm:hw:0:out2
# system:playback_1
#    alsa_pcm:hw:0:in1
# system:playback_2
#    alsa_pcm:hw:0:in2
# bristol:out_left
# bristol:out_right
# bristol:in_left
# bristol:in_right

jack_connect bristol:out_left system:playback_1
jack_connect bristol:out_right system:playback_2

### check that Bristol works as expected:
#   OK

```

In fact Qsynth is required only to display the connections. Start Bristol without Qjack:

```bash
startBristol -b3 -audio jack -midi alsa &

KB_OUT=$(aconnect -i|grep LPK25|grep client|cut -d':' -f1|cut -d' ' -f2)
KB_OUT=$KB_OUT:$(aconnect -i|grep LPK25|grep -A1 client|tail -n 1|cut -d"'" -f1|tr -d ' ')

BRISTOL_IN=$(aconnect -o|grep bristol|grep -A1 client|cut -d':' -f1|cut -d' ' -f2)
BRISTOL_IN=$BRISTOL_IN:$(aconnect -o|grep bristol|grep -A1 client|tail -n 1|cut -d"'" -f1|tr -d ' ')

aconnect $KB_OUT $BRISTOL_IN

jack_connect bristol:out_left system:playback_1
jack_connect bristol:out_right system:playback_2

### check that Bristol works as expected without using Qjack:
#   OK

```
## Azerty keyboard

There are two issues with kayboard mapping under Bristol:
- it uses only strict ASCII charset,
- each synthesizer uses its own mapping file.

Then to get a working AZERTY keyboard, two changes are required:
- code: deal with extended ASCII characters,
- configuration: create an AZERTY file for each synthesizer.

### Patch #93

A patch is available from [#93 extended ascii char. from keyboard are ignored](http://sourceforge.net/p/bristol/bugs/93). It allows to deal with:
- extended ASCII characters such as é, à, ç, ... ie coded on only one byte (here ISO 8956-1 charset see below about mapping configuration files),
- dead keys such as ^ or ¨ on a french azerty keyboard.

> Patches are dowloaded from Sourceforge.net. If a "503 : Service Unavailable" is returned, try again. Or try later... 

```bash

cd bristol-0.60.11-0B

mkdir -pv patches

cd patches 

PATCH_URL=https://sourceforge.net/p/bristol/bugs/_discuss/thread/91f78036

SRC_FILE=brightonControllers.c && SUB_PATH=a03b && SRC_DIR=../brighton
wget $PATCH_URL/$SUB_PATH/attachment/$SRC_FILE.patch
cp $SRC_DIR/$SRC_FILE $SRC_DIR/$SRC_FILE.original
patch -p0 $SRC_DIR/$SRC_FILE < $SRC_FILE.patch
        
SRC_FILE=brightoninternals.h && SUB_PATH=410b && SRC_DIR=../include/brighton
wget $PATCH_URL/$SUB_PATH/attachment/$SRC_FILE.patch
cp $SRC_DIR/$SRC_FILE $SRC_DIR/$SRC_FILE.original
patch -p0 $SRC_DIR/$SRC_FILE < $SRC_FILE.patch
        
SRC_FILE=brightonWindowMgt.c && SUB_PATH=68a2 && SRC_DIR=../libbrighton
wget $PATCH_URL/$SUB_PATH/attachment/$SRC_FILE.patch
cp $SRC_DIR/$SRC_FILE $SRC_DIR/$SRC_FILE.original
patch -p0 $SRC_DIR/$SRC_FILE < $SRC_FILE.patch
        
cd ..
        
sudo make uninstall
make clean
./configure 
make
sudo make install 

startBristol -b3 -audio jack -midi alsa &

KB_OUT=$(aconnect -i|grep LPK25|grep client|cut -d':' -f1|cut -d' ' -f2) \
  && KB_OUT=$KB_OUT:$(aconnect -i|grep LPK25|grep -A1 client|tail -n 1|cut -d"'" -f1|tr -d ' ') \
  && BRISTOL_IN=$(aconnect -o|grep bristol|grep -A1 client|cut -d':' -f1|cut -d' ' -f2) \
  && BRISTOL_IN=$BRISTOL_IN:$(aconnect -o|grep bristol|grep -A1 client|tail -n 1|cut -d"'" -f1|tr -d ' ') \
  && aconnect $KB_OUT $BRISTOL_IN \
  && jack_connect bristol:out_left system:playback_1 \
  && jack_connect bristol:out_right system:playback_2

killall bristol

git add *.c
git add include/brighton/brightoninternals.h
git add *.patch
git commit -m "Allow keyboard mapping with extended ASCII characters"

```

### mapping file

Each synthesizer has its own profile file, see /usr/local/share/bristol/memory/profiles.

Here, the goal is to provide a configuration file for a french azerty keyboard for any available synthesizer:
- where the mapping is as regular as possible, ie without shifted key. That requieres dead keys such as "^" or "¨" must be dealt with.
- with the above patch, Bristol is able to deal with any character coded on one byte. So UTF-8 can't be used: ISO 8859-1 will be OK.

About dead keys, it have to be specified:
- an arbitrary extended ASCII code but not displayed on the keyboard,
- the key code send when the dead key is striked, eg 65106 for "^" on a french keyboard.

To do the job, a script will be used. Use it it at least for the Hammond B3. Use it as the default one.

```bash

cd bristol-0.60.11-0B

mkdir -pv scripts && cd scripts

cat > azerty4bristol.sh << ___EOF
#!/bin/bash

pushd ~/.bristol/memory/profiles/

if [ "\$PROFILE_FILE_NAME" = "" ]
then
    PROFILE_FILE_NAME="hammondB3"
    echo "Default profile is used: \$PROFILE_FILE_NAME"
fi

mv \$PROFILE_FILE_NAME \$PROFILE_FILE_NAME.original
cp /usr/local/share/bristol/memory/profiles/\$PROFILE_FILE_NAME .

sed \-i 's/\(^# Keyboard map format is "KM: \)\(.*MIDI_chan\)\(.*\$\)/\1Extended_\2 [key_code]\3/' \$PROFILE_FILE_NAME 

sed \-i -e '0,/^KM: / {/^KM: /i\KM: * 19 1' -e'}' \$PROFILE_FILE_NAME 
sed \-i -e '0,/^KM: / {/^KM: /i\KM: < 0 1'  -e'}' \$PROFILE_FILE_NAME 
sed \-i -e '0,/^KM: / {/^KM: /i\KM: & 23 0' -e'}' \$PROFILE_FILE_NAME 

sed \-i -e 's/\(^KM: \)0/\1à/' -e 's/\(^KM: \)2/\1é/' -e 's/\(^KM: \)3/\1"/' \$PROFILE_FILE_NAME
sed \-i -e 's/\(^KM: \)5/\1(/' -e 's/\(^KM: \)6/\1-/' -e 's/\(^KM: \)7/\1è/' \$PROFILE_FILE_NAME
sed \-i    's/\(^KM: \)9/\1ç/' \$PROFILE_FILE_NAME

sed \-i    's/\(^KM: \)\[\(.*\)$/\1Æ\2 65106/' \$PROFILE_FILE_NAME
sed \-i    's/\(^KM: \)\]/\1$/' \$PROFILE_FILE_NAME

sed \-i -e '/^KM:/ s/q/\[q\]/' -e '/^KM:/ s/a/q/' -e '/^KM:/ s/\[q\]/a/' \$PROFILE_FILE_NAME
sed \-i -e '/^KM:/ s/z/\[z\]/' -e '/^KM:/ s/w/z/' -e '/^KM:/ s/\[z\]/w/' \$PROFILE_FILE_NAME
sed \-i -e '/^KM:/ s/m/\[m\]/' -e '/^KM:/ s/,/\[,\]/' \$PROFILE_FILE_NAME
sed \-i -e '/^KM:/ s/\[m\]/,/' -e '/^KM:/ s/\[,\]/;/' \$PROFILE_FILE_NAME
sed \-i -e '/^KM:/ s|/|!|' -e '/^KM:/ s/\./:/' -e "/^KM:/ s/'/ù/" \$PROFILE_FILE_NAME

iconv -f UTF8 -t ISO_8859-1 -o \$PROFILE_FILE_NAME \$PROFILE_FILE_NAME
popd 
___EOF

chmod a+x azerty4bristol.sh

./azerty4bristol.sh

startBristol -b3 -audio jack -midi alsa &

KB_OUT=$(aconnect -i|grep LPK25|grep client|cut -d':' -f1|cut -d' ' -f2) \
  && KB_OUT=$KB_OUT:$(aconnect -i|grep LPK25|grep -A1 client|tail -n 1|cut -d"'" -f1|tr -d ' ') \
  && BRISTOL_IN=$(aconnect -o|grep bristol|grep -A1 client|cut -d':' -f1|cut -d' ' -f2) \
  && BRISTOL_IN=$BRISTOL_IN:$(aconnect -o|grep bristol|grep -A1 client|tail -n 1|cut -d"'" -f1|tr -d ' ') \
  && aconnect $KB_OUT $BRISTOL_IN \
  && jack_connect bristol:out_left system:playback_1 \
  && jack_connect bristol:out_right system:playback_2

killall bristol

git add scripts/*
git commit -m "French azerty keyboard mapping (ISO 8956-1 charset)"




```






***TODO*** create a script and a desktop shortcut

