Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB200C48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 07:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rBuMgRfVBkYHZqafAPW5TTk4cM8Z6fuCzf3W03Um2j8=; b=MZzoy8xs4RsNfVH9pVs+Iy8MCk
	VePix1ASCHEYPWfqde48wOpTyJXW7a7bRVGjZI6z1SqqlikxarBc0X79QtJjOivdH/MVGFvgy7nD4
	tZJezGR8ZDICtUMHCE2mNzf89UeeND9Hd3A7vVwY+eVDDj8Qc8YCFM3YxCRRZ9vY/YysSBP4KfwYh
	hZRuxRjb8T2luvyg/MFe1E9aa3szfXs0tv06zQxcLOw/HdyJx0/sFwBMOjtjgMjARUTWuh5vTuSSa
	kFlUuS7oEBHbzs2wRZojOoq9jm0/VFwu6HtPNpTM9Y80QoPCWByxN9+da/cRz43Y5HUzwKovR7bF3
	GEMajWnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQWm-00000004TC0-2tRj;
	Mon, 12 Feb 2024 07:14:56 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQWk-00000004TAj-3DLf
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 07:14:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 923CDCE0022;
	Mon, 12 Feb 2024 07:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AD4C433C7;
	Mon, 12 Feb 2024 07:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707722091;
	bh=Ruyp/aqRGVYf/y+pWuf+666gtKrZkHSIarRGzQGsj/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=py7dt9Et5yXvGNkxG1iq0OW3q95ZGtQaQb+zaXDEgLf0RUUSS0NBywYfAVFuZY2WD
	 AkqG0aOxRv24zvBQ0AxHUE4QcA1l6c4zwVRhOG9Q+G8tZbkS3oo5zZoqT31iGtJYC0
	 w7xjdc5EWzT4j3ingzLRUsf38DQFK6PTPQEoD9sMafQ1vNna1ZAH9pFe81rrnFQX/2
	 838JWWqlnYmvfGuKMN0rEG+naPZW/Azp0ob5JMcdTYKxDuAm/yzFoyhn1irzFydu8Y
	 VH/oYaryQitAD7NZKLHHoqQmbo49mlkMnkH3K9L1Vomb3HjwYawBhL6+vz+PQQzFO1
	 K0V4SLwdmN1fA==
Message-ID: <74b1ddcc-4249-4b5f-89ef-6ebca70100a2@kernel.org>
Date: Mon, 12 Feb 2024 16:14:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] block: decouple blk_set_stacking_limits from
 blk_set_default_limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240212064609.1327143-1-hch@lst.de>
 <20240212064609.1327143-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240212064609.1327143-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_231455_019903_3C6DE40C 
X-CRM114-Status: GOOD (  16.44  )
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

On 2/12/24 15:45, Christoph Hellwig wrote:
> blk_set_stacking_limits uses very little from blk_set_default_limits.
> Open code these initializations in preparation for rewriting
> blk_set_default_limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-settings.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index f16d3fec6658e5..1cae2db41490d2 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -65,13 +65,16 @@ void blk_set_default_limits(struct queue_limits *lim)
>   * blk_set_stacking_limits - set default limits for stacking devices
>   * @lim:  the queue_limits structure to reset
>   *
> - * Description:
> - *   Returns a queue_limit struct to its default state. Should be used
> - *   by stacking drivers like DM that have no internal limits.
> + * Prepare queue limits for applying limits from underlying devices using
> + * blk_stack_limits().
>   */
>  void blk_set_stacking_limits(struct queue_limits *lim)
>  {
> -	blk_set_default_limits(lim);
> +	memset(lim, 0, sizeof(*lim));
> +	lim->logical_block_size = lim->physical_block_size = lim->io_min = 512;
> +	lim->discard_granularity = 512;

Super minor nit: SECTOR_SIZE would be nice here.

> +	lim->dma_alignment = 511;
> +	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
>  
>  	/* Inherit limits from component devices */
>  	lim->max_segments = USHRT_MAX;

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


