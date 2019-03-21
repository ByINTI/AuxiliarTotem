A udev rules file is provided with C3.

Thanks to these rules, Linux mounts dynamically a node “/dev/telium” when a Telium USB terminal is plugged.
These rules disambiguate a terminal from any other ACM compatible USB device.

As a consequence, the serial configuration can be set in c3config to: 
L10_COM=/dev/telium 115200/8/1/0

The installation steps are provided at the beginning of the rules file.
