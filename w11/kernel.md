The Linux kernel is packaged and managed by the Ubuntu package management system (APT). The kernel is distributed as a set of packages, most notably:

linux-image-<version>: This package contains the kernel binary itself (the file to be loaded at boot).

linux-headers-<version>: This contains the headers for building kernel modules.

There may also be linux-modules-<version>, and similar packages for optional drivers or extras.

These kernel packages are stored in the system package repositories and get installed just like other software packages via tools like apt, dpkg, or graphical package managers. You can find which kernel version you are running with commands like uname -r, and you can see installed kernel packages with dpkg -l | grep linux-image.

The kernel binary file itself is typically placed at /boot/vmlinuz-<version> after installation, which is what the bootloader (like GRUB) uses to start Linux. The supporting modules are in /lib/modules/<version>/.

If you want to see the kernel package, you can do: apt search linux-image or apt list --installed | grep linux-image.

If you want the kernel source code, you can download it with apt source linux-image-$(uname -r) (if available) or from Ubuntu's kernel Git repository for the latest sources.

So, the kernel is provided and updated as packages in Ubuntu's package management system, and not as a loose file to copy around.

