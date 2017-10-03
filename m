From: hch@lst.de (Christoph Hellwig)
Date: Tue, 3 Oct 2017 13:49:24 +0200
Subject: [PATCH 4/6] nvme: display 'NMIC' namespace attribute
In-Reply-To: <e5f46d2d-9473-c99c-9319-8567567b6994@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-5-git-send-email-hare@suse.de>
 <20171002161654.GC11048@lst.de>
 <e5f46d2d-9473-c99c-9319-8567567b6994@suse.de>
Message-ID: <20171003114924.GA24650@lst.de>

On Tue, Oct 03, 2017@12:00:16PM +0200, Hannes Reinecke wrote:
> Do stop systemd/udev doing weird things on the device.

Please define weird things, preferably actual practical wierd things
you've observed with this implementation and then document them here
in the patch description.

> If we have the 'NMIC' attribute in sysfs we can evaluate it during event
> handling, and set the 'SYSTEMD_READY=0' flag if NMIC=1.

Bonus points of including such sniplets in the patch description,
similar to how I offered udev rules in the main multipath path.

> One of the painful lessons learned when moving multipath-tools to
> systemd; we absolutely need an indicator in sysfs to handle multipath
> devices race-free.

dm-multipath devices require userspace setup, nvme-mpath ones don't.
That's a huge difference that would make udev rules a lot simpler.
But if they don't I'd like to see a good explanation here, both to
understand why you'd want this flag, and also if there is a way to
just do the right thing from the kernel.
