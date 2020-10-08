# Amiga C cross compiler setup for Linux / Macos

Based on the [vbcc](http://www.compilers.de/vbcc.html) compiler.

Prerequisite:
LHA decompressor, eg:
```
brew install lha (Macos)
sudo apt install lhasa (Debian-based distros)
```

To install:

**From your home directory:**
```
git clone https://github.com/nicolasbauw/Amiga-cc.git
cd Amiga-cc/
./install_amiga_toolchain.sh
```

You will soon be prompted by a set of questions, like:
```
Are you building a cross-compiler?
Type y or n [y]:
```

Just press enter each time, and the installation will go on.

When finished, copy-paste env.txt contents to your shell to set environment variables (or edit yourself the .profile, .bashrc or whatever config file), for instance bash users can do this way:

```
cat env.txt >> ~/.bashrc
```

Nearly the same thing for zsh:
```
cat env.txt >> ~/.zshenv
```

then close and reopen your session.

Let's now have a try:
```
./test.sh
```

This will compile the Amiga source **window.c**, you should obtain no error message, and a **window** file, which is the Amiga executable you'll be excited to try on UAE or a real machine ;-)

To compile your own program, here is the command line:
```
vc -c99 +aos68k -I$NDK_INC -o window window.c -lamiga -lauto
```

This repo was made thanks to informations from [this blog post](https://blitterstudio.com/setting-up-an-amiga-cross-compiler/) and [this youtube video](https://www.youtube.com/watch?v=vFV0oEyY92I).
