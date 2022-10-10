Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD131C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Oct 2022 07:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1tUMMaMbsNcj03Xl6K+6IxqxLn7xCzLOdkslRNp7V+U=; b=p6Ot5yhffUuQROpz+jEFmwG49U
	3GKCNONDoF6OZWQz4woetD7snkhpGM9fQ9Zb39f0paGhx31QRXMJ4t1WAGEtGCmdGewjPy1z16+Xl
	8gQrMAdbYKE0NH7foZfxaMLh+gW3urr9od5qqAgCcNP4rdBVC04xSNylzcpOHg+pjwpFbhSv0Wx5C
	RtP/lKSJRcuivckJwXAMKqmiywp+rJxn9EEuaaAqONLaN7pz1PuTyC+7Tvf0u9m+E+G8IqYNFy2I9
	RLYQjPH+BOPgvMaklBshDTFab1bskiBWc1hwxY+3B8Kb3OigO0W2KEyhf3LhgUCXt2s312xjsJuh7
	OzUgCSYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohnFc-00HO2O-Nw; Mon, 10 Oct 2022 07:31:00 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohnFX-00HO28-KB; Mon, 10 Oct 2022 07:30:55 +0000
Date: Mon, 10 Oct 2022 00:30:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] blk-mq: aggregate ktime_get per request batch
Message-ID: <Y0PKL2Lm5yAY/ODl@infradead.org>
References: <20221004153004.2058994-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004153004.2058994-1-kbusch@meta.com>
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

>  	rq->timeout = 0;
>  
> -	if (blk_mq_need_time_stamp(rq))
> -		rq->start_time_ns = ktime_get_ns();
> -	else
> -		rq->start_time_ns = 0;
> +	rq->start_time_ns = now;
>  	rq->part = NULL;
>  #ifdef CONFIG_BLK_RQ_ALLOC_TIME
> -	rq->alloc_time_ns = alloc_time_ns;
> +	rq->alloc_time_ns = now;
>  #endif

Given that rq->start_time_ns and rq->alloc_time_ns are not always
the same (except for the odd flush case), do we even need both fields?

>  static inline struct request *
>  __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
> -		u64 alloc_time_ns)
> +		u64 now)

Nit: this fits into the previous line now.

>  	return blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag,
> -					alloc_time_ns);
> +					now);

Same here.

>  static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
> -					    struct request *rq, bool last)
> +					    struct request *rq, bool last, u64 now)

Overly long line.  FYI, this becomes a lot more readable anyway with
the two tab indent:

static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
		struct request *rq, bool last, u64 now)

> @@ -2521,6 +2528,7 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	 * Any other error (busy), just add it to our list as we
>  	 * previously would have done.
>  	 */
> +	rq->io_start_time_ns = now;

Looking though this more I hate all these extra assignments, and
it will change the accounting a bit from what we had.  Why can't we
pass the time to blk_mq_start_request and just keep it where it was?

> +	u64 now = 0;
> +
> +	if (blk_queue_stat(rq->q))
> +		now = ktime_get_ns();

This code pattern is duplicated a lot.  Can't we have a nice
helper and shortcut it to:

	u64 now = blk_ktime_get_ns_for_stats(rq->q);

and use the opportunity to document the logic in the helpe.

> -static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
> +static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last, u64 now)

Overly long line here.  But I really wonder why we even needthis helper.


