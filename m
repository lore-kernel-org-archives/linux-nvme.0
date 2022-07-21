Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ADAC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 06:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KAO2VPWSy+kFCQCIJkRvwztHjMzhz7EfdSG4Fv/zirA=; b=DpV3xGbP5La/1Uvq3RCKOtferY
	xF1V+bxPk+OGv4AmTw4CWY+FpfsS1KLMZINcfwX8bFo8W1TXOFT7trlKid1/5uCN9zniP+3YNbRKx
	hSeB9VTSz227yQntLx+1rTUPCS0ZDi6YG6RBvKxNva66GRcDJWzjDn8DMYybhfkb57hCmNQfaKtqW
	MXf1cM0zKV1heySFSddJo20nvuPkCzWyCc2ErfbXQhRuD1MCwmVix37pUPfZlzdOxPctzfBDb1iMT
	z+hj7zFE5MEXxmHGSclmNkDV2BGLSfz7druA6j8t8wOARtk3dRZgLLaqcMipsZftOX5sS/zyqWeEq
	Tk4AdeOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPlz-00158y-Ss; Thu, 21 Jul 2022 06:34:59 +0000
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPlv-00150P-IY
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 06:34:57 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VK-QiEr_1658385285;
Received: from 30.178.82.178(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VK-QiEr_1658385285)
          by smtp.aliyun-inc.com;
          Thu, 21 Jul 2022 14:34:46 +0800
Message-ID: <06b571a5-4d0f-2112-c73b-35618b652a3b@linux.alibaba.com>
Date: Thu, 21 Jul 2022 14:34:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2] nvme: Define compat_ioctl again to unbreak 32-bit
 userspace.
To: Nick Bowler <nbowler@draconx.ca>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20220721035735.2720-1-nbowler@draconx.ca>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20220721035735.2720-1-nbowler@draconx.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_233455_864781_7A8C1E8D 
X-CRM114-Status: GOOD (  16.92  )
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

LGTM,

Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>

在 2022/7/21 11:57, Nick Bowler 写道:
> Commit 89b3d6e60550 ("nvme: simplify the compat ioctl handling") removed
> the initialization of compat_ioctl from the nvme block_device_operations
> structures.
>
> Presumably the expectation was that 32-bit ioctls would be directed
> through the regular handler but this is not the case: failing to assign
> .compat_ioctl actually means that the compat case is disabled entirely,
> and any attempt to submit nvme ioctls from 32-bit userspace fails
> outright with -ENOTTY.
>
> For example:
>
>    % smartctl -x /dev/nvme0n1
>    [...]
>    Read NVMe Identify Controller failed: NVME_IOCTL_ADMIN_CMD: Inappropriate ioctl for device
>
> The blkdev_compat_ptr_ioctl helper can be used to direct compat calls
> through the main ioctl handler and makes things work again.
>
> Fixes: 89b3d6e60550 ("nvme: simplify the compat ioctl handling")
> Signed-off-by: Nick Bowler <nbowler@draconx.ca>
> ---
>
> v2: use blkdev_compat_ptr_ioctl as suggested by Christoph Hellwig
>
>   drivers/nvme/host/core.c      | 1 +
>   drivers/nvme/host/multipath.c | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6a12a906a11e..9c75d7378d31 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2123,6 +2123,7 @@ static int nvme_report_zones(struct gendisk *disk, sector_t sector,
>   static const struct block_device_operations nvme_bdev_ops = {
>   	.owner		= THIS_MODULE,
>   	.ioctl		= nvme_ioctl,
> +	.compat_ioctl	= blkdev_compat_ptr_ioctl,
>   	.open		= nvme_open,
>   	.release	= nvme_release,
>   	.getgeo		= nvme_getgeo,
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index d3e2440d8abb..432ea9793a84 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -408,6 +408,7 @@ const struct block_device_operations nvme_ns_head_ops = {
>   	.open		= nvme_ns_head_open,
>   	.release	= nvme_ns_head_release,
>   	.ioctl		= nvme_ns_head_ioctl,
> +	.compat_ioctl	= blkdev_compat_ptr_ioctl,
>   	.getgeo		= nvme_getgeo,
>   	.report_zones	= nvme_ns_head_report_zones,
>   	.pr_ops		= &nvme_pr_ops,

