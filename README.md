docker-media-player (mpsyt + pulseaudio)
========================================

mpyst and pulseaudio in docker. Made so that I can run my audio from a container
and therefore from my terminal, on OSX.

Steps
-----

1. Ensure pulse audio is running on your host:

```bash
pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon
```

2. Run container with necessary volumes mounted:

```bash
docker run --rm \
  -e PULSE_SERVER=docker.for.mac.localhost \
  -v ~/.config/pulse:/home/pulseaudio/.config/pulse \
  -it \
  --name player \
  pemcconnell/mpsyt:0.1
```

Optional
--------

Add this to your `.bashrc` or other dotfiles and gain a `player` command:

```bash
d_player() {
  docker run --rm \
  -e PULSE_SERVER=docker.for.mac.localhost \
  -v ~/.config/pulse:/home/pulseaudio/.config/pulse \
  -it \
  --name player \
  pemcconnell/mpsyt:0.1 "$@"
}
```
