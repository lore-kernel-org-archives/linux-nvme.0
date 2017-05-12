From: keith.busch@intel.com (Keith Busch)
Date: Fri, 12 May 2017 17:18:31 -0400
Subject: [PATCH] nvme: Implement NS Optimial IO Boundary from 1.3 Spec
In-Reply-To: <1494620945-8061-1-git-send-email-scott.bauer@intel.com>
References: <1494620945-8061-1-git-send-email-scott.bauer@intel.com>
Message-ID: <20170512211831.GD21136@localhost.localdomain>

On Fri, May 12, 2017@02:29:05PM -0600, Scott Bauer wrote:
> The NVMe 1.3 spec introduces Namespace Optimal IO Boundaries (NOIOB).
> This feature standardizes the stripe mechanism we currently have quirks for.
> This patch implements the necessary logic to handle this new feature.
> 
> Signed-off-by: Scott Bauer <scott.bauer at intel.com>

Thanks Scott, looks good to me.

Reviewed-by: Keith Busch <keith.busch at intel.com>

> +	if (ns->ctrl->vs >= NVME_VS(1, 3, 0) && le16_to_cpu(id->noiob)) {
> +		/* Convert from controller logical blocks to 512 sectors. */
> +		iob = ((unsigned int)le16_to_cpu(id->noiob)) << (ns->lba_shift - 9);
> +		if (is_power_of_2(iob))
> +			blk_queue_chunk_sectors(ns->queue, iob);
> +	}

Just want to point out that if a Namespace has this set, then magically
doesn't after a rescan, we're stuck with the previous chunk size. Even if
that does happen, the only harm is a command may be split into two smaller
ones. Not a big deal, and that'll never happen in real life anyway.
