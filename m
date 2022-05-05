Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1252FC433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PV6wBZmVtTcLzLdqX7LnKeJ6D+LpJnxwl2ACNXXhtMk=; b=rO3qegZEEUQ+Wx5an34kSviLlx
	kReeLAHtvVNQjZQ/NzXjdxR5bzh1FGol1NP0gPhzjsQimwp1338PWWJwkkNpfH4isgf29qSO9Ivo+
	eBggyQ7YdQQeWLvNN7A8UZrRpT/HlxnxXYJOeGYR7dFZN62FWUPE5V/LyOfJ1Tbrx692WCEm8nPyf
	YhHKbh5TkMXpIAUJDA1NZrSj0GM30v+hfTIe1Cs3XN/gkKaV+uagNykZVJTPmZ+JHjAtG2gv/LlPc
	JAufDl0IB59DciuSDCigQCzXPVH+Q8uWT8tV3VB2r20lTS/WyUCmgNE2DXBVRvqGzVRUDYsr92ZnX
	bEDQYW+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmcMe-00GLoP-3d; Thu, 05 May 2022 14:21:56 +0000
Received: from us-smtp-delivery-74.mimecast.com ([170.10.129.74])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmcMV-00GLjO-7O
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 14:21:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651760505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PV6wBZmVtTcLzLdqX7LnKeJ6D+LpJnxwl2ACNXXhtMk=;
 b=LGgYF3MLA4m4ebIpj/zJxO5NAwTcnUgjOCfUNF32U8wEJSTax4KPE3q57O7pDvCppw13UR
 yXwcZRqrqr+pxsOiB9REgfMQ+l8zrldbwC7aLCPYS2o98Yn5J/wvW1vfzw1jYy6Gg9i4TV
 IXmANyRwR2FIZL6qL0yYLb4yxlG8YR0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-uFpv01qhPQeVUzK0NZtdMg-1; Thu, 05 May 2022 10:21:43 -0400
X-MC-Unique: uFpv01qhPQeVUzK0NZtdMg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA684395AFE1;
 Thu,  5 May 2022 14:21:30 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9DCF416157;
 Thu,  5 May 2022 14:21:21 +0000 (UTC)
Date: Thu, 5 May 2022 22:21:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com,
 mcgrof@kernel.org, shr@fb.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 2/5] block: wire-up support for passthrough plugging
Message-ID: <YnPdW7T8JVRsNeno@T590>
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061146epcas5p3919c48d58d353a62a5858ee10ad162a0@epcas5p3.samsung.com>
 <20220505060616.803816-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505060616.803816-3-joshi.k@samsung.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_072147_398803_88DA5994 
X-CRM114-Status: GOOD (  28.29  )
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

On Thu, May 05, 2022 at 11:36:13AM +0530, Kanchan Joshi wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> Add support for plugging in passthrough path. When plugging is enabled, the
> requests are added to a plug instead of getting dispatched to the driver.
> And when the plug is finished, the whole batch gets dispatched via
> ->queue_rqs which turns out to be more efficient. Otherwise dispatching
> used to happen via ->queue_rq, one request at a time.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c | 73 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 39 insertions(+), 34 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 84d749511f55..2cf011b57cf9 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2340,6 +2340,40 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	blk_mq_hctx_mark_pending(hctx, ctx);
>  }
>  
> +/*
> + * Allow 2x BLK_MAX_REQUEST_COUNT requests on plug queue for multiple
> + * queues. This is important for md arrays to benefit from merging
> + * requests.
> + */
> +static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
> +{
> +	if (plug->multiple_queues)
> +		return BLK_MAX_REQUEST_COUNT * 2;
> +	return BLK_MAX_REQUEST_COUNT;
> +}
> +
> +static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
> +{
> +	struct request *last = rq_list_peek(&plug->mq_list);
> +
> +	if (!plug->rq_count) {
> +		trace_block_plug(rq->q);
> +	} else if (plug->rq_count >= blk_plug_max_rq_count(plug) ||
> +		   (!blk_queue_nomerges(rq->q) &&
> +		    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
> +		blk_mq_flush_plug_list(plug, false);
> +		trace_block_plug(rq->q);
> +	}
> +
> +	if (!plug->multiple_queues && last && last->q != rq->q)
> +		plug->multiple_queues = true;
> +	if (!plug->has_elevator && (rq->rq_flags & RQF_ELV))
> +		plug->has_elevator = true;
> +	rq->rq_next = NULL;
> +	rq_list_add(&plug->mq_list, rq);
> +	plug->rq_count++;
> +}
> +
>  /**
>   * blk_mq_request_bypass_insert - Insert a request at dispatch list.
>   * @rq: Pointer to request to be inserted.
> @@ -2353,7 +2387,12 @@ void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
>  				  bool run_queue)
>  {
>  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> +	struct blk_plug *plug = current->plug;
>  
> +	if (plug) {
> +		blk_add_rq_to_plug(plug, rq);
> +		return;
> +	}

This way looks a bit fragile.

blk_mq_request_bypass_insert() is called for dispatching io request too,
such as blk_insert_cloned_request(), then the request may be inserted to
scheduler finally from blk_mq_flush_plug_list().

Another issue in blk_execute_rq(), the request may stay in plug list
before polling, then hang forever.

Just wondering why not adding the pt request to plug in blk_execute_rq_nowait()
explicitly?


Thanks, 
Ming


