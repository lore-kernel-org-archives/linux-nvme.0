Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8CDC47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 04:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tlPq/FKI9RJDCR/GCILquHLQqTYDHrot2iee04VOiZ0=; b=RnR+Mt22WTpFQW6AlSVrsK4Lg0
	N2IsLtcudsQtBIYKiP98UxFRIIOvDHwhEzfznwqspE6oNwW6Iz3JRNmVJo1UzrLr4qEJ5dbVdCgU7
	rwnCd3CigFX96l22w7lSMmb4NjbIeuHHQBQyM31YDwkQ2fPdYkOkaVldbnwD+Qj91/tviE5mdgpMT
	QoeacJmZqkX9UUrebyf/tS9xwqBQdUMj2Ov4xSXLlb5vMhwC82yOfh6/sm4+0KLjNUlPc+G4CiAOq
	zuS+LC0av7wdWMF794PX0lPgCxsVnliR6BJ5rlnyoIhPMwty4ly/QDd0VhWFZTMqc2R0CKB2BKzF/
	pXcuiS5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rS8b5-00F4p7-01;
	Tue, 23 Jan 2024 04:41:15 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rS8b1-00F4o3-22
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 04:41:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8253DCE2DD4;
	Tue, 23 Jan 2024 04:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E062AC433F1;
	Tue, 23 Jan 2024 04:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705984868;
	bh=ydiaEKqGk/zYwexK6yzv2Z6sXqMYYQwc2PODQ/3cRT0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eLqrVb+9U+loA7Exrh1sMeqofdgr3FTefrzp9Ur7YpMWuAY7BVaSth6Awf5CgvIGe
	 tFu/z70wDR03btfPn6ZM4ATGRaEcUW8PIVMzPw3HLpj5/rfMX4gQZ7HIlbVYtCGYUU
	 Z75d9VNpDR2WjSYuqulqz78htBcsHA1m34DRJawlAULEYGxNRhzRJRpjkHmRdizAi1
	 cZY86Z//2ifd/dM26MA/vOyInP68HoJUDL0dxvpmJVQifKtWgD2xKyn65rR0MWRaNR
	 34QL1I/DUy+xxmCFlAutaX7YQKVE0HUMGuONPobg/ejXxKmQPtftXY50lrDqIRmysg
	 MF67DWUz9yxdg==
Message-ID: <96007133-162c-4fff-9343-dd88ca520aa7@kernel.org>
Date: Tue, 23 Jan 2024 13:41:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] block: refactor disk_update_readahead
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
 <20240122173645.1686078-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_204111_862001_A94A9EF9 
X-CRM114-Status: GOOD (  19.69  )
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
> Factor out a blk_apply_bdi_limits limits helper that can be used with
> an explicit queue_limits argument, which will be useful later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-settings.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 06ea91e51b8b2e..e872b0e168525e 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -85,6 +85,17 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>  }
>  EXPORT_SYMBOL(blk_set_stacking_limits);
>  
> +static void blk_apply_bdi_limits(struct backing_dev_info *bdi,
> +		struct queue_limits *lim)
> +{
> +	/*
> +	 * For read-ahead of large files to be effective, we need to read ahead
> +	 * at least twice the optimal I/O size.
> +	 */
> +	bdi->ra_pages = max(lim->io_opt * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);

Nit: while at it, you could replace that division by PAGE_SIZE with a right
shift by PAGE_SHIFT.

Other than that, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +	bdi->io_pages = lim->max_sectors >> (PAGE_SHIFT - 9);
> +}
> +
>  /**
>   * blk_queue_bounce_limit - set bounce buffer limit for queue
>   * @q: the request queue for the device
> @@ -393,15 +404,7 @@ EXPORT_SYMBOL(blk_queue_alignment_offset);
>  
>  void disk_update_readahead(struct gendisk *disk)
>  {
> -	struct request_queue *q = disk->queue;
> -
> -	/*
> -	 * For read-ahead of large files to be effective, we need to read ahead
> -	 * at least twice the optimal I/O size.
> -	 */
> -	disk->bdi->ra_pages =
> -		max(queue_io_opt(q) * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
> -	disk->bdi->io_pages = queue_max_sectors(q) >> (PAGE_SHIFT - 9);
> +	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
>  }
>  EXPORT_SYMBOL_GPL(disk_update_readahead);
>  

-- 
Damien Le Moal
Western Digital Research


