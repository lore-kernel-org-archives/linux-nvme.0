Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000E1C46CD4
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Dec 2023 01:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0g68KXYMTYQXJNAd8R5u8wUuhAH/4MGhjfuMMmpWfSE=; b=gLvRcmChPEMNFJKp0o7JTQ4bLt
	IFhJiBO9chz66YwgmnBg4+lprVibVxMCP475Bj7MHJ7E+jNbqTYSDHDB14Mgm3oEA5TYMfQ2Y95vm
	yEWPGrvJi30+4E8JPqnEWSXehWDtlgr1WIalIJ2BUB9BrZvcpGYvVMX2pNj9kVsnvNwkxGT9xR1rW
	mPR2Js1G6XS3Arj5FEJlnOENGbuQWbiUU5awVHml0dMwntJotug1pu8wHVPIkL/4YiLI9o3A9qn4+
	D3pOr3TyQu7HHrEI6h1/66MQaxa0evC86TMhWBfzjxnaQwHN8FxJK4WCSZxEaI1qIsLUoZOX6JCWu
	tv0kX/IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIfVv-00FuuA-0f;
	Thu, 28 Dec 2023 01:48:47 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIfVs-00Fut4-06
	for linux-nvme@lists.infradead.org;
	Thu, 28 Dec 2023 01:48:45 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VzMS-ou_1703728117;
Received: from 30.178.80.210(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VzMS-ou_1703728117)
          by smtp.aliyun-inc.com;
          Thu, 28 Dec 2023 09:48:38 +0800
Message-ID: <8e0b0055-0da9-4d23-b63e-09ca21f1b3e8@linux.alibaba.com>
Date: Thu, 28 Dec 2023 09:48:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] nvme: introduce nvme_disk_is_ns_head helper
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
References: <20231227093106.78551-1-kanie@linux.alibaba.com>
From: Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20231227093106.78551-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231227_174844_247584_98812666 
X-CRM114-Status: GOOD (  18.72  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Using helper functions makes the code more readable.

Reviewed-by: Liu Song <liusong@linux.alibaba.com>

在 2023/12/27 17:31, Guixin Liu 写道:
> We currently rely on gendisk's file operations (fops) to distinguish
> between a namespace head (ns_head) and a regular namespace. To enhance
> code readability, introduce a helper function.
> Additionally, we must ensure that the device is not an ns_head before
> calling nvme_get_ns_from_dev(). To enforce this, add a WARN_ON check
> within the nvme_get_ns_from_dev().
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> Changes from v2 to v3:
> - simplify to disk->fops == &nvme_ns_head_ops.
>
> Changes from v1 to v2:
> - change helper name from nvme_gendisk_is_ns_head to
>    nvme_disk_is_ns_head.
> - remove redundant comment.
>
>   drivers/nvme/host/nvme.h  | 10 +++++++++-
>   drivers/nvme/host/pr.c    |  2 +-
>   drivers/nvme/host/sysfs.c |  9 +++++----
>   3 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index e7411dac00f7..3dcbf48e9fdf 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -1029,9 +1029,17 @@ static inline int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>   }
>   #endif
>   
> +static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
> +{
> +	return disk->fops == &nvme_ns_head_ops;
> +}
> +
>   static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
>   {
> -	return dev_to_disk(dev)->private_data;
> +	struct gendisk *disk = dev_to_disk(dev);
> +
> +	WARN_ON(nvme_disk_is_ns_head(disk));
> +	return disk->private_data;
>   }
>   
>   #ifdef CONFIG_NVME_HWMON
> diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
> index 391b1465ebfd..fc3eed00f9ff 100644
> --- a/drivers/nvme/host/pr.c
> +++ b/drivers/nvme/host/pr.c
> @@ -98,7 +98,7 @@ static int nvme_send_pr_command(struct block_device *bdev,
>   		struct nvme_command *c, void *data, unsigned int data_len)
>   {
>   	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
> -	    bdev->bd_disk->fops == &nvme_ns_head_ops)
> +	    nvme_disk_is_ns_head(bdev->bd_disk))
>   		return nvme_send_ns_head_pr_command(bdev, c, data, data_len);
>   
>   	return nvme_send_ns_pr_command(bdev->bd_disk->private_data, c, data,
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index c6b7fbd4d34d..925042ca728b 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -39,10 +39,10 @@ static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
>   {
>   	struct gendisk *disk = dev_to_disk(dev);
>   
> -	if (disk->fops == &nvme_bdev_ops)
> -		return nvme_get_ns_from_dev(dev)->head;
> -	else
> +	if (nvme_disk_is_ns_head(disk))
>   		return disk->private_data;
> +	else
> +		return nvme_get_ns_from_dev(dev)->head;
>   }
>   
>   static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
> @@ -148,7 +148,8 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
>   	}
>   #ifdef CONFIG_NVME_MULTIPATH
>   	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
> -		if (dev_to_disk(dev)->fops != &nvme_bdev_ops) /* per-path attr */
> +		/* per-path attr */
> +		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
>   			return 0;
>   		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
>   			return 0;

