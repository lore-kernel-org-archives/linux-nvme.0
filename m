From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 7 Jun 2018 06:56:14 -0600
Subject: [PATCHv2] block: always set partition number to '0' in
 blk_partition_remap()
In-Reply-To: <20180607082944.41676-1-hare@suse.de>
References: <20180607082944.41676-1-hare@suse.de>
Message-ID: <3d45f792-f00e-0955-3acf-466e73050a9c@kernel.dk>

On 6/7/18 2:29 AM, Hannes Reinecke wrote:
> blk_partition_remap() will only clear bi_partno if an actual remapping
> has happened. But flush request et al don't have an actual size, so
> the remapping doesn't happen and bi_partno is never cleared.
> So for stacked devices blk_partition_remap() will be called on each level.
> If (as is the case for native nvme multipathing) one of the lower-level
> devices do _not_support partitioning a spurious I/O error is generated.

That's better, applied.

-- 
Jens Axboe
