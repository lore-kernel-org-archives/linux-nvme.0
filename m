From: hch@lst.de (Christoph Hellwig)
Date: Sat, 15 Jul 2017 10:46:03 +0200
Subject: [PATCH 3/3] nvme: wwid_show: copy hex string verbatim
In-Reply-To: <1500061257.4808.23.camel@suse.com>
References: <20170713222533.30794-1-mwilck@suse.com>
 <20170713222533.30794-4-mwilck@suse.com> <20170714075451.GD17877@lst.de>
 <1500026296.4808.8.camel@suse.com> <20170714123025.GC26187@lst.de>
 <1500061257.4808.23.camel@suse.com>
Message-ID: <20170715084603.GC23189@lst.de>

On Fri, Jul 14, 2017@09:40:57PM +0200, Martin Wilck wrote:
> > True.  Although that only really is a fix for buggy controllers,
> > and should not affect the PCIe controllers (for which a compliance
> > test for this exists, unfortunately that doesn't work for fabrics).
> 
> Is that a NAK, or not?

That's an ACK for the null vs whitespace changes.  The NAK
for this patch still stands.

> "We will"? People are (trying to) use NVMe with multipath today, and
> they use dm-multipath and multipathd for that. Maybe that'll change
> some day, but not too soon, I believe.

Who are these people and why aren't they on the nvme list?  The
dm-mpath approach is fundamentally wrong for NVMe, and especially
NVMeOF - e.g. for NVMeOF we have the mandatory keep alive, so doing
any wonky path checking from userspace is just going to create
problems.
