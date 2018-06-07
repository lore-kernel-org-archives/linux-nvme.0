From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 13:24:40 +0200
Subject: [PATCHv2] block: always set partition number to '0' in
 blk_partition_remap()
In-Reply-To: <20180607082944.41676-1-hare@suse.de>
References: <20180607082944.41676-1-hare@suse.de>
Message-ID: <20180607112440.GA10915@lst.de>

On Thu, Jun 07, 2018@10:29:44AM +0200, Hannes Reinecke wrote:
> blk_partition_remap() will only clear bi_partno if an actual remapping
> has happened. But flush request et al don't have an actual size, so
> the remapping doesn't happen and bi_partno is never cleared.
> So for stacked devices blk_partition_remap() will be called on each level.
> If (as is the case for native nvme multipathing) one of the lower-level
> devices do _not_support partitioning a spurious I/O error is generated.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
