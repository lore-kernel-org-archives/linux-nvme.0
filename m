From: hch@lst.de (Christoph Hellwig)
Date: Sat, 28 Oct 2017 08:15:23 +0200
Subject: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
In-Reply-To: <09f8a87b-f8da-9f5a-6efd-f5e9acfaee45@suse.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-7-hch@lst.de>
 <09f8a87b-f8da-9f5a-6efd-f5e9acfaee45@suse.de>
Message-ID: <20171028061523.GB13723@lst.de>

On Tue, Oct 24, 2017@09:18:47AM +0200, Hannes Reinecke wrote:
> Can we have some information in sysfs to figure out if a gendisk is
> hidden? I'd hate having to do an inverse lookup in /proc/partitions;
> it's always hard to prove that something is _not_ present.
> And we already present various information (like disk_removable_show()),
> so it's not without precedent.
> And it would make integration with systemd/udev easier.

Sure, I'll add a hidden flag sysfs file.
