From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 10 Feb 2016 10:18:22 +0100
Subject: [PATCH v2 1/5] nvme/host: reference the fabric module for each
 bdev open callout
In-Reply-To: <1455062873-18392-2-git-send-email-mlin@kernel.org>
References: <1455062873-18392-1-git-send-email-mlin@kernel.org>
 <1455062873-18392-2-git-send-email-mlin@kernel.org>
Message-ID: <20160210091822.GR27969@c203.arch.suse.de>

On Tue, Feb 09, 2016@04:07:49PM -0800, Ming Lin wrote:
> From: Sagi Grimberg <sagig at mellanox.com>
> 
> We don't want to be able to unload the fabric driver when we have
> openened referenced to our namespaces. Thus, for each nvme_open we
> take a reference on the fabric driver and put it in nvme_release.
> This behavior is consistent with the scsi model.
> 
> This resolves the panic when unloading a fabric module with
> mpath holders.
> 
> Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Ian Bakshan <ianb at mellanox.com>
> Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
