From: keith.busch@intel.com (Keith Busch)
Date: Mon, 2 Oct 2017 10:53:18 -0600
Subject: [PATCH 5/6] nvme: Export subsystems to /sys/class/nvme-subsys
In-Reply-To: <20171002161808.GD11048@lst.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-6-git-send-email-hare@suse.de>
 <20171002161808.GD11048@lst.de>
Message-ID: <20171002165317.GT8463@localhost.localdomain>

On Mon, Oct 02, 2017@06:18:08PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 02, 2017@03:55:58PM +0200, Hannes Reinecke wrote:
> > Create a class for each subsystem to create a 'device' link
> > for each subsystem device.
> 
> I thought about this as it seems useful.  The only downside is that
> iff we run into subsystems with duplicate NQNs (or fake NQNs using
> MN/SN) we are in deep trouble once this is exposed in sysfs.
> 
> Keith was the one most concerned about that, so I'd like him to
> chime in.

The driver will unbind from the controller if it detects an unsupported
duplicate nvme subsystem. The same logic will prevent duplciate sysfs
entries in this patch, so I think we're okay from that standpoint.

My concern was the user can't query or fix the controller that has the
duplicate subsystem name since we unbind from it. Unbinding is probably
the right thing to do, though, so the confused subsystem can be fixed
when the user isolates it from the others.

BTW, I just notice nvme_init_subsystem needs call nvme_put_subsystem in
the invalid duplicate subnqn case.
