From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Sep 2015 21:40:47 +0000 (UTC)
Subject: Intel P3600 writes after hot add (RHEL7.1)
In-Reply-To: <CA+At7pUsnjH__0bkcbS7TyaCxdnym0Du6takuuVe9c6jeoK-xQ@mail.gmail.com>
References: <CA+At7pUsnjH__0bkcbS7TyaCxdnym0Du6takuuVe9c6jeoK-xQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1509292129180.23840@localhost.lm.intel.com>

On Tue, 29 Sep 2015, j cagle wrote:
> I'm having a problem with 2.5" Intel P3600 & P3700 Series NVMe drives
> with RHEL7.1.
>
> I can quiesce the drive, then hot-remove it, and there's no problem.
>
> I can then hot-add it and it is discovered properly - no problem.
>
> Then I can read from the drive, again - no problem.
>
> The problem is that the server crashes (PCIe unrecoverable error) as
> soon as I attempt to write anything to the drive:
>
> [ 9838.102041] {1}[Hardware Error]: event severity: fatal
> [ 9838.102042] {1}[Hardware Error]:  Error 0, type: fatal
> [ 9838.102042] {1}[Hardware Error]:   section_type: PCIe error
> [ 9838.102043] {1}[Hardware Error]:   port_type: 0, PCIe end point
> [ 9838.102043] {1}[Hardware Error]:   version: 1.16
> [ 9838.102044] {1}[Hardware Error]:   command: 0x0406, status: 0x0010
> [ 9838.102045] {1}[Hardware Error]:   device_id: 0000:84:00.0
> [ 9838.102045] {1}[Hardware Error]:   slot: 0
> [ 9838.102045] {1}[Hardware Error]:   secondary_bus: 0x00
> [ 9838.102046] {1}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x0953
> [ 9838.102046] {1}[Hardware Error]:   class_code: 020801
> [ 9838.102062] Kernel panic - not syncing: Fatal hardware error!
>
> Has anyone seen this error before?

Yes! The device is hot-added with a mismatched PCI-e Max Payload Size,
so data can only go one way: host -> device. We've fixed the default
pci behavior in kernel 4.3 to tune the settings on hot-added devices.

In the meantime, you can append "pci=pcie_bus_perf" to your kernel
parameters. I'm not sure how to make this parameter permanent in RHEL,
but I think you add it to the 'GRUB_CMDLINE_LINUX_DEFAULT' line in
/etc/default/grub, then run grub2-mkconfig (or something like that).

There actually should have been a hint in the 'dmesg' after the hot-add
that recommends "pci=pcie_bus_safe" that would also be work, but it's
easy to miss that hint.

> Thanks,
> John
