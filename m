Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3B3C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 20:17:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DB461153
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 20:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DB461153
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IOusu0lLReVDff/jXTLc5X+YSFDk0dtPBbZ3indpfIM=; b=VfkeVeECz0WSdcztGZHlDZMyR
	jtZOxYrvdOi7ZxjBgtzCh2xG+TiZUeo+Lf/JO7Qxl2xhhH/XO2hhsDqEoM5a2//BesBuOMFuei8c9
	8cxdQivdP4Zdkm+8HQFJ5iENygHWX50kqUBQXQPC15I9FU684dI/D1C7ppm3ntS6erE7VOAbENLJq
	E5gOpDUEdiChWi0ZmDE4/RJoPP8Zpv8mWU5h8bTBqkvNUeq/ifoPvvP+rkmQAuKXxvL4MGvrfg6mO
	AY4KYS1otuVQ3hl14GqUjir+ELpBwlVY/PxQWOdgUCWp3AvdPXHUbA3dxYgNkRfvnh8y8eiMebtH+
	Ydril9Utg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lX8Q0-00HEfL-Td; Thu, 15 Apr 2021 20:16:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX8Pw-00HEef-EZ
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 20:16:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=R4MN2eqir+CBtD0tgtCkvzIAT+xpznMNoAirRW915JI=; b=y1yJ0e5HEsmDW+SzMsLONcSlfh
 4iSUqXpK4dWcWQRyobWq2tstvfmFbNvGsq75+JZpnWSCxuUgRlfXqys3RjBwQCkKN687DKsJ3vuWP
 vmJog+DPlTJ56HWsAViChSM+OY5mZEqdAhwD/W3f02w2YkEAgT7FmHjXD7J6yceD92ZQNk4TkHv3K
 pfJrKljybCTDRgWYxcBljOTC854dnhJ2D2JDmMFQlZ5IZdinKIJQ1gZm7qLzMlVyCO7OE9kso5UMy
 ASNuMlX1Z5uXQqErHQDMFKuckJjnGLJAu4sC4xZgI+TWJpubP2arlEq8c9/xVqzLceBiWJ1C7ccvk
 sS/O/abQ==;
Received: from mail-pf1-f181.google.com ([209.85.210.181])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX8Pt-008s20-SN
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 20:16:47 +0000
Received: by mail-pf1-f181.google.com with SMTP id w8so13350242pfn.9
 for <linux-nvme@lists.infradead.org>; Thu, 15 Apr 2021 13:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R4MN2eqir+CBtD0tgtCkvzIAT+xpznMNoAirRW915JI=;
 b=SCUVsvBj7RUqyMKIFgXROVYCz/Q1CZIo7jcldxTUecs8LEfFRIgimDHbdNNUUbbuB5
 VK3+oIS/9HsDfv7NWKqXWrwOWeuN3ORjqZUxW1oMt41UlZDHzUIMHvPudUVZrKxSa3EW
 5NgCm+2DyTOexmdhX5LeUXZVW+k4dU0TAZzwicvnsoh9V8nFsNT+qkmcL+Eo6VbJfD0h
 fIyMVraeL4YDUbvyudZp2s33yPN5vaJYwWrwp/lrCFEThLe/fHFgvstNv0clmxJc6M1X
 PxckXY2lKecIhA03B9U1JfdsunqVcirGtGk17Z8EurXARlPuba+UIx15X5BxSbP41u/E
 l63Q==
X-Gm-Message-State: AOAM530y2yPyo17HT8Hn8gJlTVoCy0hvsN5f09AhMey1jG12bvAR7pUf
 nM398clC2WmqqC7x4nO9S7k=
X-Google-Smtp-Source: ABdhPJxasAeAsl5iQIA7O0Hpn7d6fx6L/z8/SVQlS1C09Khzz+GwalY1VdAAhZbxcExOg1StAuq49Q==
X-Received: by 2002:a65:53c8:: with SMTP id z8mr5048457pgr.340.1618517804655; 
 Thu, 15 Apr 2021 13:16:44 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:f031:1d3a:7e95:2876?
 ([2601:647:4000:d7:f031:1d3a:7e95:2876])
 by smtp.gmail.com with ESMTPSA id y187sm2814668pfb.109.2021.04.15.13.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Apr 2021 13:16:43 -0700 (PDT)
Subject: Re: [dm-devel] [RFC PATCH 2/2] block: support to freeze bio based
 request queue
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-raid@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Song Liu <song@kernel.org>, dm-devel@redhat.com,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Christoph Hellwig <hch@lst.de>
References: <20210415103310.1513841-1-ming.lei@redhat.com>
 <20210415103310.1513841-3-ming.lei@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <af8f41f4-74e8-450d-fa63-6feb6b745222@acm.org>
Date: Thu, 15 Apr 2021 13:16:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210415103310.1513841-3-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_131645_952593_415F90E1 
X-CRM114-Status: GOOD (  18.50  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/15/21 3:33 AM, Ming Lei wrote:
> 1) grab two queue usage refcount for blk-mq before submitting blk-mq
> bio, one is for bio, anther is for request;
                       ^^^^^^
                       another?

> diff --git a/block/blk-core.c b/block/blk-core.c
> index 09f774e7413d..f71e4b433030 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -431,12 +431,13 @@ EXPORT_SYMBOL(blk_cleanup_queue);
>  int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>  {
>  	const bool pm = flags & BLK_MQ_REQ_PM;
> +	const unsigned int nr = (flags & BLK_MQ_REQ_DOUBLE_REF) ? 2 : 1;

Please leave out the parentheses from around the condition in the above
and in other ternary expressions. The ternary operator has a very low
precedence so adding parentheses around the condition in a ternary
operator is almost never necessary.

> @@ -480,8 +481,18 @@ static inline int bio_queue_enter(struct bio *bio)
>  	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
>  	bool nowait = bio->bi_opf & REQ_NOWAIT;
>  	int ret;
> +	blk_mq_req_flags_t flags = nowait ? BLK_MQ_REQ_NOWAIT : 0;
> +	bool reffed = bio_flagged(bio, BIO_QUEUE_REFFED);
>  
> -	ret = blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0);
> +	if (!reffed)
> +		bio_set_flag(bio, BIO_QUEUE_REFFED);
> +
> +	/*
> +	 * Grab two queue references for blk-mq, one is for bio, and
> +	 * another is for blk-mq request.
> +	 */
> +	ret = blk_queue_enter(q, q->mq_ops && !reffed ?
> +			(flags | BLK_MQ_REQ_DOUBLE_REF) : flags);

Consider rewriting the above code as follows to make it easier to read:

	if (q->mq_ops && !reffed)
		flags |= BLK_MQ_REQ_DOUBLE_REF;
	ret = blk_queue_enter(q, flags);

Please also expand the comment above this code. The comment only
explains the reffed == false case but not the reffed == true case. I
assume that the reffed == true case applies to stacked bio-based drivers?

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
