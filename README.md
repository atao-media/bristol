# Bristol

[Bristol](http://bristol.sourceforge.net/) is a synthesizer emulation package for a range of diverse vintage synthesisers, electric pianos and organs. The application consists of a multithreaded audio synthesizer and a user interface called `brighton`.

More documentation is available:
* a [manual](./HOWTO),
* a [description](./README.txt) of each synthesizer.

## Features

* Over thirty emulators to mix and match
* Multitimbral engine
* Simultaneous splits and layers of different emulators
* Distributed graphical user interface and engine
* ALSA Audio and MIDI support
* Jack Audio and MIDI support
* OSS Audio and MIDI support
* LADI Session Manager support
* JACK Session Manager support
* Text Based Command Line Interface option
* Monophonic keypreference note logic option

## Samples

![Vintage 1](./doc/1.jpeg)
![Vintage 2](./doc/2.jpeg)
![Vintage 5](./doc/5.jpeg)
![Hammond B3](./doc/hammondb3.jpeg)

## Install

### Requirements

To build `Bristol`, if needed install:

```bash
sudo apt-get install -y jackd libjack-jackd2-dev libx11-dev libasound2-dev
```

### Default keyboard

To start:

```bash

git clone https://github.com/atao60/audio/bristol-0.60.11-0B bristol
cd bristol
./configure
make
sudo make install

```

### French azerty keyboard

A script is provided that allows to generate a french azerty mapping to any existing synthetizer (°), eg for the default synthesizer, ie the Hammond B3.

***WIP*** ATM only the note keys are right. The function keys are still the qwerty ones.

```bash

./scripts/azerty4bristol.sh

```
The customized file will be under `~/.bristol/memory/profiles/`. It will be used at the next launch of Bristol as Hammond B3. 

> (°) See available mapping files under either the system folder `/usr/local/share/bristol/memory/profiles/` or under the source one `./memory/profiles`.

## Run 

### Hammond B3 alone

To start:

```bash
startBristol -b3 -jack &

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
# bristol:midi_in

jack_connect bristol:out_left system:playback_1
jack_connect bristol:out_right system:playback_2

```

To stop from the command line:
```bash
killall bristol
```

### Hammond B3 with Akai LPK 25

Here:
- still starting an Hammond B3,
- a keyboard Akai LPK 25 is connected to the computer through USB.

```bash

startBristol -b3 -audio jack -midi alsa &

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

aconnect -o
# client 14: 'Midi Through' [type=noyau]
#     0 'Midi Through Port-0'
# client 24: 'LPK25' [type=noyau,card=2]
#     0 'LPK25 MIDI 1    '
# client 128: 'bristol' [type=utilisateur,pid=20794]
#     0 'bristol input   '

KB_OUT=$(aconnect -i|grep LPK25|grep client|cut -d':' -f1|cut -d' ' -f2) \
  && KB_OUT=$KB_OUT:$(aconnect -i|grep LPK25|grep -A1 client|tail -n 1|cut -d"'" -f1|tr -d ' ') \
  && BRISTOL_IN=$(aconnect -o|grep bristol|grep -A1 client|cut -d':' -f1|cut -d' ' -f2) \
  && BRISTOL_IN=$BRISTOL_IN:$(aconnect -o|grep bristol|grep -A1 client|tail -n 1|cut -d"'" -f1|tr -d ' ') \
  && aconnect $KB_OUT $BRISTOL_IN \
  && jack_connect bristol:out_left system:playback_1 \
  && jack_connect bristol:out_right system:playback_2

```

## Credits

It's a fork of Bristol 0.60.11 from archive available on [sourceforge](https://sourceforge.net/projects/bristol/). See ChangeLog and NEWS.

Local changes:
- [bristol: FTBFS: audioEngineJack.c:42:26: fatal error: alsa/iatomic.h: No such file or directory](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=834180) 
- [#93 extended ascii char. from keyboard are ignored ](https://sourceforge.net/p/bristol/bugs/93/)

## License

[GNU General Public License version 2.0 (GPLv2)](https://sourceforge.net/directory/license:gpl/)
