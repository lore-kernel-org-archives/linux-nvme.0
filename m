Return-Path: <SRS0=KTc9=BF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E292CC433E1
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 09:32:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E29206E3
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 09:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nGImnn27";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwqC6q1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E29206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bt7K6O+L1CRlRmpuL9CllgIHnd1YgSjkyjIIG/KbzoE=; b=nGImnn27ZR7QojAKKsIA9xFpm
	VF2uKR9iG/5w6WO15gwrphyXwJTD+Tv6DpBQHMDk63lGDIBLicicQSIpGRKIpm+4FLowPAXmsL18f
	1yhLQPCcVimzFDqQPc7BKnw4t+RBXyCjiOWCxupyB2MOid15taaUBMM4dHcyzQVvXoB7gjd4KDtiA
	ANWO67iKhOTfZeqT2Dv+F7WdlLotTJBTVCR6QAws+HIQq+eIqr80cNFprvDbpbgM8v+wmScC+OcCS
	5At7/c26RdFPhEBwx0HbHHFhXEN7s32dF2eiI2t76my2Bdl9WSTk8+R0ABF+5p4qVuXLU7NZaNds5
	VA8bJCTqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzd0b-0008Iq-K0; Sun, 26 Jul 2020 09:31:53 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzd0Y-0008IQ-RB
 for linux-nvme@lists.infradead.org; Sun, 26 Jul 2020 09:31:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595755909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WFFrWY8Oz3HwxPvXJO5/UEvTxCU9HEM5CYerxz56T1c=;
 b=gwqC6q1/FKg/vEXzfHR6N9PAchzx+aF0PL5TtiTRMyki/HZ+Eo/YuNzKwWi721cQEmLq8g
 ePJBub9oRNLJn1e5pPqgrzLdeLIeBLbkb4ZmxEM86UEeeXlyKnQ7yB90aJIXR5E9o25GMn
 OUqkM+zojeChvVcKY2va7nObsje6vu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-rj0vGx7EP4yvMW3S375rfg-1; Sun, 26 Jul 2020 05:31:45 -0400
X-MC-Unique: rj0vGx7EP4yvMW3S375rfg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F04C01902EA2;
 Sun, 26 Jul 2020 09:31:43 +0000 (UTC)
Received: from T590 (ovpn-12-72.pek2.redhat.com [10.72.12.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E47485DA30;
 Sun, 26 Jul 2020 09:31:36 +0000 (UTC)
Date: Sun, 26 Jul 2020 17:31:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
Message-ID: <20200726093132.GD1110104@T590>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200726002301.145627-2-sagi@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200726_053150_938217_3FA3F2F3 
X-CRM114-Status: GOOD (  20.03  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi,

On Sat, Jul 25, 2020 at 05:23:00PM -0700, Sagi Grimberg wrote:
> Drivers that may have to quiesce a large amount of request queues at once
> (e.g. controller or adapter reset). These drivers would benefit from an
> async quiesce interface such that the can trigger quiesce asynchronously
> and wait for all in parallel.
> 
> This leaves the synchronization responsibility to the driver, but adds
> a convenient interface to quiesce async and wait in a single pass.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  block/blk-mq.c         | 32 ++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  4 ++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index abcf590f6238..60d137265bd9 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -209,6 +209,38 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>  
> +void blk_mq_quiesce_queue_async(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned int i;
> +
> +	blk_mq_quiesce_queue_nowait(q);
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		init_completion(&hctx->rcu_sync.completion);
> +		init_rcu_head(&hctx->rcu_sync.head);
> +		if (hctx->flags & BLK_MQ_F_BLOCKING)
> +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
> +				wakeme_after_rcu);
> +		else
> +			call_rcu(&hctx->rcu_sync.head,
> +				wakeme_after_rcu);
> +	}

Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
synchronize_rcu() is OK for all hctx during waiting.

> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
> +
> +void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned int i;
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		wait_for_completion(&hctx->rcu_sync.completion);
> +		destroy_rcu_head(&hctx->rcu_sync.head);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
> +
>  /**
>   * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
>   * @q: request queue.
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 23230c1d031e..5536e434311a 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -5,6 +5,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/sbitmap.h>
>  #include <linux/srcu.h>
> +#include <linux/rcupdate_wait.h>
>  
>  struct blk_mq_tags;
>  struct blk_flush_queue;
> @@ -170,6 +171,7 @@ struct blk_mq_hw_ctx {
>  	 */
>  	struct list_head	hctx_list;
>  
> +	struct rcu_synchronize	rcu_sync;
 
The above struct takes at least 5 words, and I'd suggest to avoid it,
and the hctx->srcu should be re-used for waiting BLK_MQ_F_BLOCKING.
Meantime !BLK_MQ_F_BLOCKING doesn't need it.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
