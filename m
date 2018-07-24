From: hch@lst.de (Christoph Hellwig)
Date: Tue, 24 Jul 2018 15:55:46 +0200
Subject: [PATCH 2/3] block: move dif_prepare/dif_complete functions to
 block layer
In-Reply-To: <1532439222-5668-2-git-send-email-maxg@mellanox.com>
References: <1532439222-5668-1-git-send-email-maxg@mellanox.com>
 <1532439222-5668-2-git-send-email-maxg@mellanox.com>
Message-ID: <20180724135546.GB29918@lst.de>

> +/*
> + * The virtual start sector is the one that was originally submitted
> + * by the block layer.	Due to partitioning, MD/DM cloning, etc. the
> + * actual physical start sector is likely to be different.  Remap
> + * protection information to match the physical LBA.
> + *
> + * From SCSI protocol perspective there's a slight difference between
> + * Type 1 and 2.  The latter uses command's 32-byte exclusively, and the
> + * reference tag is seeded in the command.  This gives us the potential to
> + * avoid virt->phys remapping during write.  However, at read time we
> + * don't know whether the virt sector is the same as when we wrote it
> + * (we could be reading from real disk as opposed to MD/DM device.  So
> + * we always remap Type 2 making it identical to Type 1.
> + *
> + * Type 3 does not have a reference tag so no remapping is required.
> + */

Please convert the comments for  t10_pi_prepare/t10_pi_complete to
kerneldoc format, and remove the mention of 32-byte CDBs, which
are SCSI specific.

Otherwise this looks good to me.

Note that after this patch only sd_dif_config_host is left in sd_dif.c,
at which point it might be worth merging into sd.c as a separate patch.
