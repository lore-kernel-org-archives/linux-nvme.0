Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221D8C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 05:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ROJlRVwAXDdgDK1vrrovcBIQGCbkJ7gNw4MmeSosPM=; b=Pob4RUaBUzkeR7P2MW7bVlGljP
	70ANhMQFJ81R4xLdPvD+CHY4x1cLzclaTlo3rpw7cTVK6q4TAgO+FdL0GRo1TwZ6pT+oUGk+/M9SL
	LIDrBuRYqapEPyky3NHARV+m7Ahlo1N/wF0qNMCfkfOBWAvIS+K8cMdYrQU15e+lq6/UZZ31Y6s5w
	qqMKq2IWy1cWPuokSUp07z6ZiiY+pdjH59Lao9aFRLRVcwCROq8FdagyeBZOBvvHgA0E1TT0eyAax
	RAA8BuSGeGVsuLUMWAdjFeT82cnwhT+oVQqRj7rgzoJL5IYZaslzFs+dMAsn4eprbFFyxa2T018AX
	xrBlrZmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rS97n-00F7WK-2J;
	Tue, 23 Jan 2024 05:15:03 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rS97k-00F7VV-2O
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 05:15:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C2011CE2DBC;
	Tue, 23 Jan 2024 05:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D38C433C7;
	Tue, 23 Jan 2024 05:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705986896;
	bh=SeDxthAOTwIFhmRZDIowt7SyrKBsfhtYcYm8P7eDFOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EZ0y6vCD6HFvuRmSM7s/RT9DEP3p7gRhTKVYy4+fidZ2Hu/56vVZ1in80rhT1IPde
	 Mz/BDuGECMXYB+VnSD3hQnnr5vzj20uZKGoU6NEauXc0UUSa3LmEKumv7jEBgZoN+n
	 FtPDuN37BqeZOMSEBYio35lkhWbDilu9k7xj93vMz5OKSnwjCgulvtyd5LDsPnr+ed
	 yy5+DhSTlQoBeyYzghqCEWZyYJQs6uZQsSwq4ZtfP1C4LbgMftQ/rLUSFZ/+MGlPCr
	 Ztqvp/ZCUrPr/6Ytzn2pcb2FPj5rkvozgjgc5x6uQe7EQqNQyQm/CfIgTKrME5cSCs
	 i5jF2UPHmzNtQ==
Message-ID: <c0738ba9-2eb8-4997-b357-af481da0a457@kernel.org>
Date: Tue, 23 Jan 2024 14:12:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] nvme: remove the hack to not update the discard
 limits in nvme_config_discard
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-7-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_211500_990386_1879D8AB 
X-CRM114-Status: GOOD (  17.91  )
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

On 1/23/24 02:36, Christoph Hellwig wrote:
> Now that the block layer tracks a separate user max discard limit, there
> is no need to prevent nvme from updating it on controller capability
> changes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 85ab0fcf9e8864..ef70268dccbc5a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1754,16 +1754,6 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
>  	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
>  			NVME_DSM_MAX_RANGES);
>  
> -	/*
> -	 * If discard is already enabled, don't reset queue limits.
> -	 *
> -	 * This works around the fact that the block layer can't cope well with
> -	 * updating the hardware limits when overridden through sysfs.  This is
> -	 * harmless because discard limits in NVMe are purely advisory.
> -	 */
> -	if (queue->limits.max_discard_sectors)
> -		return;
> -
>  	blk_queue_max_discard_sectors(queue, max_discard_sectors);

This function references max_user_discard_sectors but that access is done
without holding the queue limits mutex. Is that safe ?

>  	if (ctrl->dmrl)
>  		blk_queue_max_discard_segments(queue, ctrl->dmrl);

-- 
Damien Le Moal
Western Digital Research


