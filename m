From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Oct 2017 18:56:32 +0200
Subject: [PATCH 5/6] nvme: Export subsystems to /sys/class/nvme-subsys
In-Reply-To: <20171002165317.GT8463@localhost.localdomain>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-6-git-send-email-hare@suse.de>
 <20171002161808.GD11048@lst.de> <20171002165317.GT8463@localhost.localdomain>
Message-ID: <20171002165632.GA12157@lst.de>

On Mon, Oct 02, 2017@10:53:18AM -0600, Keith Busch wrote:
> The driver will unbind from the controller if it detects an unsupported
> duplicate nvme subsystem. The same logic will prevent duplciate sysfs
> entries in this patch, so I think we're okay from that standpoint.
>
> My concern was the user can't query or fix the controller that has the
> duplicate subsystem name since we unbind from it. Unbinding is probably
> the right thing to do, though, so the confused subsystem can be fixed
> when the user isolates it from the others.
> 

Right now that's what we do.  But if this actually shows up in the wild
in e.g. consumer products we'll have to come up with a work around and
just allow that case and skip matches for it.  It would be a little ugly
but doable - once we expose the name in sysfs we are in deep trouble
with duplicate names.

> BTW, I just notice nvme_init_subsystem needs call nvme_put_subsystem in
> the invalid duplicate subnqn case.

We call __nvme_free_subsystem in that case, which should do the job.
