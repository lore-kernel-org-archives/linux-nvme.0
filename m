Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EF2C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jul 2022 03:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r0g5uI8vUs9VStm5MwZBQ38Sg6jZY32NeIvw6YEoRGI=; b=ErxdCYrFZBoIxrwSf5wrkNjsXl
	PvL++EMqAnqhLz80+7SIFUzfC1u/kgKweJ/PEhOAhs3cEeyzmiEbXUhyIAqF/EwUOpj3vG+f2GBS+
	ddinsAPZUp6xSKOO0sLUsPmtaERPOUhf7pJGZ61Dkk2D4nlQq9aI/bdVL6f5aDjp56UyxvbxqMrhp
	XpiaCRspUKvPmLjQbLQW8/FU3dhxNKBE2lCncCmbQqs/BMw7O7YvHoneusUBGBAJG+B278H1T1gzb
	siRKLoPO50xmgbAdUDBpzSZX9IEGb8meMDPd6XMhVUdbqbyAs+brYnr31jxlN0xuf9IATgxgEounx
	ER6W9z8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE0k0-00HVGP-Tx; Wed, 20 Jul 2022 03:51:16 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE0jx-00HVBv-6l
	for linux-nvme@lists.infradead.org; Wed, 20 Jul 2022 03:51:15 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJv7hAH_1658289066;
Received: from 30.178.82.186(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VJv7hAH_1658289066)
          by smtp.aliyun-inc.com;
          Wed, 20 Jul 2022 11:51:07 +0800
Message-ID: <9122f83f-902b-3738-3b0e-f806df999c3f@linux.alibaba.com>
Date: Wed, 20 Jul 2022 11:51:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] nvme: Define compat_ioctl again to unbreak 32-bit
 userspace.
To: Nick Bowler <nbowler@draconx.ca>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20220720015538.15838-1-nbowler@draconx.ca>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20220720015538.15838-1-nbowler@draconx.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_205113_464430_E7626FA2 
X-CRM114-Status: GOOD (  16.01  )
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

Hi Nick,

Should this in the brace of "#ifdef CONFIG_COMPAT" and "#endif"?

best regards,

Guixin Liu

在 2022/7/20 09:55, Nick Bowler 写道:
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
> Direct .compat_ioctl to the main ioctl handlers in order to make things
> work again.
>
> Fixes: 89b3d6e60550 ("nvme: simplify the compat ioctl handling")
> Signed-off-by: Nick Bowler <nbowler@draconx.ca>
> ---
>   drivers/nvme/host/core.c      | 1 +
>   drivers/nvme/host/multipath.c | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a2862a56fadc..30e105dbc178 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2093,6 +2093,7 @@ static int nvme_report_zones(struct gendisk *disk, sector_t sector,
>   static const struct block_device_operations nvme_bdev_ops = {
>   	.owner		= THIS_MODULE,
>   	.ioctl		= nvme_ioctl,
> +	.compat_ioctl	= nvme_ioctl,
>   	.open		= nvme_open,
>   	.release	= nvme_release,
>   	.getgeo		= nvme_getgeo,
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index d464fdf978fb..0f38a5feec22 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -408,6 +408,7 @@ const struct block_device_operations nvme_ns_head_ops = {
>   	.open		= nvme_ns_head_open,
>   	.release	= nvme_ns_head_release,
>   	.ioctl		= nvme_ns_head_ioctl,
> +	.compat_ioctl	= nvme_ns_head_ioctl,
>   	.getgeo		= nvme_getgeo,
>   	.report_zones	= nvme_ns_head_report_zones,
>   	.pr_ops		= &nvme_pr_ops,

