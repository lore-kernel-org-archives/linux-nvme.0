From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Oct 2017 18:18:08 +0200
Subject: [PATCH 5/6] nvme: Export subsystems to /sys/class/nvme-subsys
In-Reply-To: <1506952559-1588-6-git-send-email-hare@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-6-git-send-email-hare@suse.de>
Message-ID: <20171002161808.GD11048@lst.de>

On Mon, Oct 02, 2017@03:55:58PM +0200, Hannes Reinecke wrote:
> Create a class for each subsystem to create a 'device' link
> for each subsystem device.

I thought about this as it seems useful.  The only downside is that
iff we run into subsystems with duplicate NQNs (or fake NQNs using
MN/SN) we are in deep trouble once this is exposed in sysfs.

Keith was the one most concerned about that, so I'd like him to
chime in.
