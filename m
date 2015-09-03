From: keith.busch@intel.com (Keith Busch)
Date: Thu, 3 Sep 2015 20:38:09 +0000 (UTC)
Subject: [PATCH] block: Inline blk_integrity in struct gendisk
In-Reply-To: <1440635121-8765-1-git-send-email-martin.petersen@oracle.com>
References: <B58D82457FDA0744A320A2FC5AC253B93CBE5758@fmsmsx104.amr.corp.intel.com>
 <1440635121-8765-1-git-send-email-martin.petersen@oracle.com>
Message-ID: <alpine.LNX.2.00.1509032035360.23840@localhost.lm.intel.com>

On Wed, 26 Aug 2015, Martin K. Petersen wrote:
> @@ -1985,14 +1985,10 @@ static int nvme_revalidate_disk(struct gendisk *disk)
> 	ns->pi_type = pi_type;
> 	blk_queue_logical_block_size(ns->queue, bs);
>
> -	if (ns->ms && !blk_get_integrity(disk) && (disk->flags & GENHD_FL_UP) &&
> -								!ns->ext)
> +	if (ns->ms && !ns->ext)
> 		nvme_init_integrity(ns);
>
> -	if (ns->ms && !blk_get_integrity(disk))
> -		set_capacity(disk, 0);
> -	else
> -		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
> +	set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));

We still ought to set the capacity to 0 if there is no block integrity
support for the disk when it has meta data formats. This would happen
with either extended metadata, or kernel config does not include integrity
extensions.
