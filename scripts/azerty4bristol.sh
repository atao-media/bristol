#!/bin/bash

pushd ~/.bristol/memory/profiles/

if [ "$PROFILE_FILE_NAME" = "" ]
then
    PROFILE_FILE_NAME="hammondB3"
    echo "Default profile is used: $PROFILE_FILE_NAME"
fi

mv $PROFILE_FILE_NAME $PROFILE_FILE_NAME.original
cp /usr/local/share/bristol/memory/profiles/$PROFILE_FILE_NAME .

sed \-i 's/\(^# Keyboard map format is "KM: \)\(.*MIDI_chan\)\(.*$\)/\1Extended_\2 [key_code]\3/' $PROFILE_FILE_NAME 

sed \-i -e '0,/^KM: / {/^KM: /i\KM: * 19 1' -e'}' $PROFILE_FILE_NAME 
sed \-i -e '0,/^KM: / {/^KM: /i\KM: < 0 1'  -e'}' $PROFILE_FILE_NAME 
sed \-i -e '0,/^KM: / {/^KM: /i\KM: & 23 0' -e'}' $PROFILE_FILE_NAME 

sed \-i -e 's/\(^KM: \)0/\1à/' -e 's/\(^KM: \)2/\1é/' -e 's/\(^KM: \)3/\1"/' $PROFILE_FILE_NAME
sed \-i -e 's/\(^KM: \)5/\1(/' -e 's/\(^KM: \)6/\1-/' -e 's/\(^KM: \)7/\1è/' $PROFILE_FILE_NAME
sed \-i    's/\(^KM: \)9/\1ç/' $PROFILE_FILE_NAME

sed \-i    's/\(^KM: \)\[\(.*\)$/\1Æ\2 65106/' $PROFILE_FILE_NAME
sed \-i    's/\(^KM: \)\]/\1$/' $PROFILE_FILE_NAME

sed \-i -e '/^KM:/ s/q/\[q\]/' -e '/^KM:/ s/a/q/' -e '/^KM:/ s/\[q\]/a/' $PROFILE_FILE_NAME
sed \-i -e '/^KM:/ s/z/\[z\]/' -e '/^KM:/ s/w/z/' -e '/^KM:/ s/\[z\]/w/' $PROFILE_FILE_NAME
sed \-i -e '/^KM:/ s/m/\[m\]/' -e '/^KM:/ s/,/\[,\]/' $PROFILE_FILE_NAME
sed \-i -e '/^KM:/ s/\[m\]/,/' -e '/^KM:/ s/\[,\]/;/' $PROFILE_FILE_NAME
sed \-i -e '/^KM:/ s|/|!|' -e '/^KM:/ s/\./:/' -e "/^KM:/ s/'/ù/" $PROFILE_FILE_NAME

iconv -f UTF8 -t ISO_8859-1 -o $PROFILE_FILE_NAME $PROFILE_FILE_NAME
popd 
