From: keith.busch@intel.com (Busch, Keith)
Date: Tue, 20 Oct 2015 14:17:44 +0000
Subject: Help with NVMe Driver on Altera SoCs
In-Reply-To: <20B8CF9DC7757148B9D6420301E14D590AE5E744@SJ-ITEXCH02.altera.priv.altera.com>
References: <20B8CF9DC7757148B9D6420301E14D590AE5E744@SJ-ITEXCH02.altera.priv.altera.com>
Message-ID: <20151020141744.GA18345@localhost.localdomain>

On Tue, Oct 20, 2015@02:02:02PM +0000, Chris Martin wrote:
> Kernel messages (output from 'dmesg | grep -i pci'):
> [    0.198390] PCI host bridge /pcie at 0x010000000 ranges:
> [    0.198541] altera-pcie d0000000.pcie: PCI host bridge to bus 0000:00
> [    0.198553] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.198565] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xdfffffff] (bus address [0x00000000-0x0fffffff])
> [    0.198721] pci 0000:00:00.0: [1172:e000] type 01 class 0x060400
> [    0.199111] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0xffffffff 64bit pref]
> [    0.199605] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
> [    0.200005] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    0.200709] pci 0000:01:00.0: [11f8:f117] type 00 class 0x010802
> [    0.201271] pci 0000:01:00.0: reg 0x10: [mem 0xd0000000-0xd0003fff 64bit]
> [    0.201734] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x3fffffff 64bit pref]
> [    0.202827] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> [    0.203196] pci 0000:00:00.0: BAR 8: no space for [mem size 0x60000000]
> [    0.203205] pci 0000:00:00.0: BAR 8: failed to assign [mem size 0x60000000]
> [    0.203215] pci 0000:01:00.0: BAR 4: no space for [mem size 0x40000000 64bit pref]
> [    0.203222] pci 0000:01:00.0: BAR 4: failed to assign [mem size 0x40000000 64bit pref]
> [    0.203229] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
> [    0.203236] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64 bit]
> [    0.203243] pci 0000:00:00.0: PCI bridge to [bus 01]
> 
> 
> Output from 'insmod nvme.ko':
> [  321.835507] nvme 0000:01:00.0: Device failed to resume
> 
> Would the PCIe driver failing to assign BARs cause the NVMe driver to fail?

Yes, this says that there were no memory resources available to assign
to BAR0, which is the controller registers. If the driver is unable to
remap the controller registers, it won't be able to drive it. It returns
-ENOMEM since the error is a memory resource.
