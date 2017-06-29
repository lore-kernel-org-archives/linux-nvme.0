From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 29 Jun 2017 10:33:16 +0200
Subject: [PATCH] nvme: Makefile: remove dead build rule
In-Reply-To: <20170629065907.13132-1-vrothberg@suse.com>
References: <20170629065907.13132-1-vrothberg@suse.com>
Message-ID: <20170629083315.GF3808@linux-x5ow.site>

On Thu, Jun 29, 2017@08:59:07AM +0200, Valentin Rothberg wrote:
> Remove dead build rule for drivers/nvme/host/scsi.c which has been
> removed by commit ("nvme: Remove SCSI translations").
> 
> Signed-off-by: Valentin Rothberg <vrothberg at suse.com>
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
