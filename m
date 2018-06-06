From: hch@lst.de (Christoph Hellwig)
Date: Wed, 6 Jun 2018 16:42:18 +0200
Subject: [PATCH] block: always set partition number to '0' in
 blk_partition_remap()
In-Reply-To: <25f0db7b-ccac-88f6-76e7-99d1b94e11f9@kernel.dk>
References: <20180606142218.64220-1-hare@suse.de>
 <25f0db7b-ccac-88f6-76e7-99d1b94e11f9@kernel.dk>
Message-ID: <20180606144218.GB20487@lst.de>

On Wed, Jun 06, 2018@08:26:56AM -0600, Jens Axboe wrote:
> On 6/6/18 8:22 AM, Hannes Reinecke wrote:
> > blk_partition_remap() will only clear bi_partno if an actual remapping
> > has happened. But flush request et al don't have an actual size, so
> > the remapping doesn't happen and bi_partno is never cleared.
> > So for stacked devices blk_partition_remap() will be called on each level.
> > If (as is the case for native nvme multipathing) one of the lower-level
> > devices do _not_support partitioning a spurious I/O error is generated.
> 
> Just move it down, we're now clearing it for both cases.

Agreed.
