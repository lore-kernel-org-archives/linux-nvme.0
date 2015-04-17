From: keith.busch@intel.com (Keith Busch)
Date: Fri, 17 Apr 2015 18:12:19 +0000 (UTC)
Subject: [PATCH] nvme: consolidate synchronous command submission helpers
In-Reply-To: <1429293033-4353-1-git-send-email-hch@lst.de>
References: <1429293033-4353-1-git-send-email-hch@lst.de>
Message-ID: <alpine.LNX.2.00.1504171803090.32385@localhost.lm.intel.com>

On Fri, 17 Apr 2015, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
> drivers/block/nvme-core.c | 91 +++++++++++++++--------------------------------
> drivers/block/nvme-scsi.c | 17 +++++----
> include/linux/nvme.h      |  7 ++--
> 3 files changed, 38 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 85b8036..69c9196 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c

Thanks, this is a nice improvement over what we had before. I found
only one problem:

> int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
> @@ -1189,7 +1162,7 @@ int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
> 	c.features.fid = cpu_to_le32(fid);
> 	c.features.dword11 = cpu_to_le32(dword11);
>
> -	return nvme_submit_admin_cmd(dev, &c, result);
> +	return nvme_submit_sync_cmd(dev->admin_q, &c, NULL);
> }

Probably a copy-paste error, but setting the result field to NULL means
initialization won't obtain the proper i/o queue count. The same thing
was done in the nvme_get_features().

Otherwise looks good!
