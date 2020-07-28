Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC55C433EA
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 01:09:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4BE20714
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 01:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EvWgcT4t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3Ve9qig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4BE20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=C6foilF5Qe1IuV+N6ia+Alk++GxS6N0IFZen5MMEbOk=; b=EvWgcT4tLALeLm/+7JXtSReBU
	8AnPvawB3YdGzqj2es2WUOw1SsRi2rUoozu06RFik2pJQgADnr+E9qtyXhAQEJYLCxOjoBwdJ8hgL
	Rv3A8pGBG0RCa/eHS0Pu+XBoUb7uF356E6kcAak+ygCXQpVLHriG7Obr5lTf5tqwy4zycl96qKKPh
	i3qvcsHHIEBdJjy7zbegI0FiHDkEIqp2giRF/sy3PfV+xvSwaPiWuy3KnftAEI4AMKv8NHpb+ULRA
	KkiOQ/Tv4gQ8ToN5xvHhkJaCv7sl7ezTGBikGG17J6GBRoNOrcGJGHYlXGx0wUoIR18sJrhvW9CnE
	1oCyXp+vA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0E7m-0001y3-GU; Tue, 28 Jul 2020 01:09:46 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0E7j-0001xR-VX
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 01:09:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595898583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=baOPMXnAAHz4Dgy9VjwzwyyrCvFs3hyQP6/RGRj2qaE=;
 b=O3Ve9qigkiqBKS5hfSvutXUbrhiNgV8fFAO9i6fls8HmQretWUX4Gbwtpl+MNvyvHPsbfI
 Eqx2/i0A772Djv89df6nMGGOP6akeCcaNnZRwd9Hdo+lnWMtC+tVQ9DZlZUFrDtzF4w+3E
 fxk2pRq/awBJODu49lqR9wxqdRFUkFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-EODb3-lnNu2XjM7cLv6kGA-1; Mon, 27 Jul 2020 21:09:41 -0400
X-MC-Unique: EODb3-lnNu2XjM7cLv6kGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF983800468;
 Tue, 28 Jul 2020 01:09:39 +0000 (UTC)
Received: from T590 (ovpn-12-109.pek2.redhat.com [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 898F810013D0;
 Tue, 28 Jul 2020 01:09:32 +0000 (UTC)
Date: Tue, 28 Jul 2020 09:09:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
Message-ID: <20200728010928.GA1303645@T590>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me>
 <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
 <f2fc0ecf-b599-678f-7241-fcd44cde6fab@kernel.dk>
 <bcb8f89b-8477-c48b-1e0f-947cbe741818@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bcb8f89b-8477-c48b-1e0f-947cbe741818@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_210944_074288_53469D8F 
X-CRM114-Status: GOOD (  33.26  )
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

On Mon, Jul 27, 2020 at 02:00:15PM -0700, Sagi Grimberg wrote:
> 
> > > > > > > +void blk_mq_quiesce_queue_async(struct request_queue *q)
> > > > > > > +{
> > > > > > > +	struct blk_mq_hw_ctx *hctx;
> > > > > > > +	unsigned int i;
> > > > > > > +
> > > > > > > +	blk_mq_quiesce_queue_nowait(q);
> > > > > > > +
> > > > > > > +	queue_for_each_hw_ctx(q, hctx, i) {
> > > > > > > +		init_completion(&hctx->rcu_sync.completion);
> > > > > > > +		init_rcu_head(&hctx->rcu_sync.head);
> > > > > > > +		if (hctx->flags & BLK_MQ_F_BLOCKING)
> > > > > > > +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
> > > > > > > +				wakeme_after_rcu);
> > > > > > > +		else
> > > > > > > +			call_rcu(&hctx->rcu_sync.head,
> > > > > > > +				wakeme_after_rcu);
> > > > > > > +	}
> > > > > > 
> > > > > > Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
> > > > > > synchronize_rcu() is OK for all hctx during waiting.
> > > > > 
> > > > > That's true, but I want a single interface for both. v2 had exactly
> > > > > that, but I decided that this approach is better.
> > > > 
> > > > Not sure one new interface is needed, and one simple way is to:
> > > > 
> > > > 1) call blk_mq_quiesce_queue_nowait() for each request queue
> > > > 
> > > > 2) wait in driver specific way
> > > > 
> > > > Or just wondering why nvme doesn't use set->tag_list to retrieve NS,
> > > > then you may add per-tagset APIs for the waiting.
> > > 
> > > Because it puts assumptions on how quiesce works, which is something
> > > I'd like to avoid because I think its cleaner, what do others think?
> > > Jens? Christoph?
> > 
> > I'd prefer to have it in a helper, and just have blk_mq_quiesce_queue()
> > call that.
> 
> I agree with this approach as well.
> 
> Jens, this mean that we use the call_rcu mechanism also for non-blocking
> hctxs, because the caller  will call it for multiple request queues (see
> patch 2) and we don't want to call synchronize_rcu for every request
> queue serially, we want it to happen in parallel.
> 
> Which leaves us with the patchset as it is, just to convert the
> rcu_synchronize structure to be dynamically allocated on the heap
> rather than keeping it statically allocated in the hctx.
> 
> This is how it looks:
> --
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index abcf590f6238..d913924117d2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -209,6 +209,52 @@ void blk_mq_quiesce_queue_nowait(struct request_queue
> *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
> 
> +void blk_mq_quiesce_queue_async(struct request_queue *q)
> +{
> +       struct blk_mq_hw_ctx *hctx;
> +       unsigned int i;
> +       int rcu = false;
> +
> +       blk_mq_quiesce_queue_nowait(q);
> +
> +       queue_for_each_hw_ctx(q, hctx, i) {
> +               hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync),
> GFP_KERNEL);
> +               if (!hctx->rcu_sync) {
> +                       /* fallback to serial rcu sync */
> +                       if (hctx->flags & BLK_MQ_F_BLOCKING)
> +                               synchronize_srcu(hctx->srcu);
> +                       else
> +                               rcu = true;
> +               } else {
> +                       init_completion(&hctx->rcu_sync->completion);
> +                       init_rcu_head(&hctx->rcu_sync->head);
> +                       if (hctx->flags & BLK_MQ_F_BLOCKING)
> +                               call_srcu(hctx->srcu, &hctx->rcu_sync->head,
> +                                       wakeme_after_rcu);
> +                       else
> +                               call_rcu(&hctx->rcu_sync->head,
> +                                       wakeme_after_rcu);
> +               }
> +       }
> +       if (rcu)
> +               synchronize_rcu();
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
> +
> +void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
> +{
> +       struct blk_mq_hw_ctx *hctx;
> +       unsigned int i;
> +
> +       queue_for_each_hw_ctx(q, hctx, i) {
> +               if (!hctx->rcu_sync)
> +                       continue;
> +               wait_for_completion(&hctx->rcu_sync->completion);
> +               destroy_rcu_head(&hctx->rcu_sync->head);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
> +
>  /**
>   * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
>   * @q: request queue.
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 23230c1d031e..7213ce56bb31 100644
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
>          */
>         struct list_head        hctx_list;
> 
> +       struct rcu_synchronize  *rcu_sync;

The above pointer needn't to be added to blk_mq_hw_ctx, and it can be
allocated on heap and passed to the waiting helper.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
