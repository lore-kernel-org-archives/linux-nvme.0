From: cmartin@altera.com (Chris Martin)
Date: Tue, 20 Oct 2015 14:02:02 +0000
Subject: Help with NVMe Driver on Altera SoCs
Message-ID: <20B8CF9DC7757148B9D6420301E14D590AE5E744@SJ-ITEXCH02.altera.priv.altera.com>

Hi All,

I am testing the NVMe kernel module with the 4.3 kernel and with an Altera Arria10 SoC board (on a dual ARM Cortex-A9 chip), but running into some issues with the NVMe driver starting.  The NVMe module reports that the NVMe card failed to resume.

Tracing this back a little, I found that the nvme_dev_resume() function returns -12 (ENOMEM) from within the nvme_async_probe() function.  I am also tracing this back further to see what the nvme_dev_start() function (called from within nvme_dev_resume() in nvme-core.c) is doing to return this, but I am also wondering if anyone has some ideas for something to look for.

Below are some details of what I see in my system (Arria 10 SoC Dev Kit: http://rocketboards.org/foswiki/view/Documentation/Arria10SoCDevelopmentKit):

Lspci output (simple output, but can send out the verbose output later):
00:00.0 PCI bridge: Altera Corporation Device e000 (rev 01)
01:00.0 Non-Volatile memory controller: PMC-Sierra Inc. Device f117 (rev 05)


Kernel messages (output from 'dmesg | grep -i pci'):
[    0.198390] PCI host bridge /pcie at 0x010000000 ranges:
[    0.198541] altera-pcie d0000000.pcie: PCI host bridge to bus 0000:00
[    0.198553] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.198565] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xdfffffff] (bus address [0x00000000-0x0fffffff])
[    0.198721] pci 0000:00:00.0: [1172:e000] type 01 class 0x060400
[    0.199111] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0xffffffff 64bit pref]
[    0.199605] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    0.200005] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.200709] pci 0000:01:00.0: [11f8:f117] type 00 class 0x010802
[    0.201271] pci 0000:01:00.0: reg 0x10: [mem 0xd0000000-0xd0003fff 64bit]
[    0.201734] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x3fffffff 64bit pref]
[    0.202827] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.203196] pci 0000:00:00.0: BAR 8: no space for [mem size 0x60000000]
[    0.203205] pci 0000:00:00.0: BAR 8: failed to assign [mem size 0x60000000]
[    0.203215] pci 0000:01:00.0: BAR 4: no space for [mem size 0x40000000 64bit pref]
[    0.203222] pci 0000:01:00.0: BAR 4: failed to assign [mem size 0x40000000 64bit pref]
[    0.203229] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
[    0.203236] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64 bit]
[    0.203243] pci 0000:00:00.0: PCI bridge to [bus 01]


Output from 'insmod nvme.ko':
[  321.835507] nvme 0000:01:00.0: Device failed to resume

Would the PCIe driver failing to assign BARs cause the NVMe driver to fail?

Thanks for the help,
Chris Martin
Embedded Technical Specialist
Altera Corporation

________________________________

Confidentiality Notice.
This message may contain information that is confidential or otherwise protected from disclosure. If you are not the intended recipient, you are hereby notified that any use, disclosure, dissemination, distribution, or copying of this message, or any attachments, is strictly prohibited. If you have received this message in error, please advise the sender by reply e-mail, and delete the message and any attachments. Thank you.
