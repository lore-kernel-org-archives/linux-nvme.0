Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675A7D30019
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 16:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UZOvWd9Qdr/ICcHkPTjBkXNpReqYfNANXbD13j3yPbA=; b=zM3kE1KBxS8KCN04FnH+QQT7cL
	jzSCPLGL+Mehfkl/xAzzw/Jpz5wgN7zk4Hsuc9aan9lKIKEkeuGmAXd5rArrawxSGJkiz/r0KIEIl
	X3EwkSEFUOmASan66CAmKoHhGIrmdgUHQrXlRRn5n9dvq6MJHQeEc4Qgf/IUc8x/uZClkCMZLOf86
	zMLAxchhLxUj970AMFK4ckTsmBfKGIJhXqE1Y6oYgC0BOxPq2gRxvSQJHOcEEONAfAKcvUWmQiCQZ
	VHzjNWR4Y7AMz2rRsIMe4jQNkLEb4WuLlCd0fyYL21VDgiGG3dk5RwEXC3UsbJ9PhAnudugY9o/Yv
	Ew9sk2rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1pgm-00000001KSY-31P7;
	Fri, 18 Oct 2024 16:18:56 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1pgj-00000001KQG-07Vj
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 16:18:54 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XVVJB6FQMz6ClSq5;
	Fri, 18 Oct 2024 16:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1729268319; x=1731860320; bh=UZOvWd9Qdr/ICcHkPTjBkXNp
	ReqYfNANXbD13j3yPbA=; b=VzlrEF+sa5/JCGuO0NnR/jFuALhH083kv+ExB8vk
	5YNp7M0ui1R2CJHzoDdhkiwyPJioERh7UIggGaYtodtkPsePh42DqJ8bXKa6QHXJ
	bPAKMy7Yb++Sjr4kgfPzq7g8mHdasUPcjNa8cTpPn9SQMsLla68j6NIN9vzDDTQ/
	iW9EO1yXUQ5F+YPnWDpx2p5MPmR1G7m8mnMq5iBEdkRx2o+QZCfoU4sdzbXACY42
	YwXNDesRJocfgmOMvI3FXCbJyxhoic7n6n7HLclz4pORGJE+/l7m30wzJz8szNpL
	2cBBs6Df6+FvNo/mhvljvqsiwF5Lb/CkbWFIMoKhySHXRw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id izSwHc7fHMsE; Fri, 18 Oct 2024 16:18:39 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XVVHx1z0Zz6ClV8W;
	Fri, 18 Oct 2024 16:18:36 +0000 (UTC)
Message-ID: <57798ab7-fc67-4606-900e-d221e028bd8f@acm.org>
Date: Fri, 18 Oct 2024 09:18:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 3/6] block: introduce max_write_hints queue limit
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
 io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
 javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20241017160937.2283225-1-kbusch@meta.com>
 <20241017160937.2283225-4-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241017160937.2283225-4-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_091853_234985_EB8FC554 
X-CRM114-Status: GOOD (  14.41  )
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

On 10/17/24 9:09 AM, Keith Busch wrote:
> Drivers with hardware that support write hints need a way to export how
> many are available so applications can generically query this.

Something is missing from this patch, namely a change for the SCSI disk
(sd) driver that sets max_write_hints to sdkp->permanent_stream_count.

> +What:		/sys/block/<disk>/queue/max_write_hints
> +Date:		October 2024
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RO] Maximum number of write hints supported, 0 if not
> +		supported. If supported, valid values are 1 through
> +		max_write_hints, inclusive.

That's a bit short. I think it would help to add a reference to the
aspects of the standards related to this attribute: permanent streams
for SCSI and FDP for NVMe.

> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index a446654ddee5e..921fb4d334fa4 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -43,6 +43,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>   	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
>   
>   	/* Inherit limits from component devices */
> +	lim->max_write_hints = USHRT_MAX;
>   	lim->max_segments = USHRT_MAX;
>   	lim->max_discard_segments = USHRT_MAX;
>   	lim->max_hw_sectors = UINT_MAX;
> @@ -544,6 +545,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>   	t->max_segment_size = min_not_zero(t->max_segment_size,
>   					   b->max_segment_size);
>   
> +	t->max_write_hints = min(t->max_write_hints, b->max_write_hints);
> +
>   	alignment = queue_limit_alignment_offset(b, start);
>   

I prefer that lim->max_write_hints is initialized to zero in
blk_set_stacking_limits() and that blk_stack_limits() uses
min_not_zero().

Thanks,

Bart.

