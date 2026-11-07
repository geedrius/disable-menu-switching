# Disable Menu Switching

[<img src="https://raw.githubusercontent.com/andyholmes/gnome-shell-extensions-badge/master/get-it-on-ego.svg?sanitize=true" height="100" align="right">](https://extensions.gnome.org/extension/4133/disable-menu-switching/)
[GNOME Shell](https://www.gnome.org/) extension disabling default GNOME behavior which is changing menu on hover another panel button.

## Building and installing from source

To build and install the extension, run:
```bash
./build.sh -bi
```

This packs the extension into `disable-menu-switching@selfmade.pl.shell-extension.zip`
and installs it for the current user.

The available options are:

| Option | Description                                   |
|--------|-----------------------------------------------|
| `-b`   | Build (pack) the extension into a zip archive |
| `-i`   | Install the packed extension                  |
| `-l`   | Log out of the GNOME session afterwards       |

GNOME Shell only loads new extension code after you log out and back in (on Wayland),
so you can add `-l` to log out right away:
```bash
./build.sh -bil
```

After logging back in, enable the extension:
```bash
gnome-extensions enable disable-menu-switching@selfmade.pl
```
