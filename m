From: keith.busch@intel.com (Keith Busch)
Date: Tue, 26 Feb 2019 09:08:35 -0700
Subject: Race between nvme_remove and nvme_reset_work
In-Reply-To: <80bcafee-6249-07d2-8958-ffc4f75f6956@redhat.com>
References: <80bcafee-6249-07d2-8958-ffc4f75f6956@redhat.com>
Message-ID: <20190226160835.GA17537@localhost.localdomain>

On Tue, Feb 26, 2019@11:00:26AM -0500, David Milburn wrote:
> Hi Keith,
> 
> In AWS environment running linux-5.0.0-rc8, Xiao is seeing disks stuck
> in detaching state with dmesg showing probe failures:
> 
> After I detached another disk, both disks are in 'detaching' state, and
> I see below output:
> [ 6296.815457] pci 0000:00:1f.0: [1d0f:8061] type 00 class 0x010802
> [ 6296.815735] pci 0000:00:1f.0: reg 0x10: [mem 0xc0000000-0xc0003fff]
> [ 6296.818160] pci 0000:00:1f.0: BAR 0: assigned [mem 0xc0000000-0xc0003fff]
> [ 6296.820968] nvme nvme1: pci function 0000:00:1f.0
> [ 6296.824562] pci 0000:00:1c.0: [1d0f:8061] type 00 class 0x010802
> [ 6296.824938] pci 0000:00:1c.0: reg 0x10: [mem 0xc0004000-0xc0007fff]
> [ 6296.827024] pci 0000:00:1c.0: BAR 0: assigned [mem 0xc0004000-0xc0007fff]
> [ 6296.829767] nvme nvme2: pci function 0000:00:1c.0
> [ 6296.930586] nvme nvme1: failed to mark controller CONNECTING
> [ 6296.932756] nvme nvme1: Removing after probe failure status: 0
> [ 6297.044546] nvme nvme2: 2/0/0 default/read/poll queues
> [ 6477.102770] pci 0000:00:1f.0: [1d0f:8061] type 00 class 0x010802
> [ 6477.103287] pci 0000:00:1f.0: reg 0x10: [mem 0xc0000000-0xc0003fff]
> [ 6477.105944] pci 0000:00:1f.0: BAR 0: assigned [mem 0xc0000000-0xc0003fff]
> [ 6477.112014] nvme nvme1: pci function 0000:00:1f.0
> [ 6477.118596] pci 0000:00:1c.0: [1d0f:8061] type 00 class 0x010802
> [ 6477.118958] pci 0000:00:1c.0: reg 0x10: [mem 0xc0004000-0xc0007fff]
> [ 6477.120980] pci 0000:00:1c.0: BAR 0: assigned [mem 0xc0004000-0xc0007fff]
> [ 6477.126769] nvme nvme2: pci function 0000:00:1c.0
> [ 6477.224439] nvme nvme1: failed to mark controller CONNECTING
> [ 6477.229642] nvme nvme1: Removing after probe failure status: 0
> [ 6477.346051] nvme nvme2: 2/0/0 default/read/poll queues
> 
> It looks like there is an acpi_device_hotplug add followed by an
> acpi_device_hotplug remove and nvme_remove is completing before
> nvme_reset_work actually runs resulting in probe failure.
> 
> Do you have any thoughts?

Hi David,

If you have a remove event before initialization completes, we should
expect the probe to fail.

I don't think it's possible for nvme_remove() to complete before the
reset_work, though. That should all be fully synchronized.
