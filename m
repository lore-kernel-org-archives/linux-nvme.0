Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE50C433E4
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 02:08:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C932070A
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 02:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GxK3RTCQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXC36Dgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C932070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2G2zqSimqfKspBGsF3xla/y4y5Iu/Y3WaCnYaxoO5gw=; b=GxK3RTCQTMS7NCRpke/OnifFt
	eLif67nq4zqpqpkZY41lhn9Z9knU0/4xKrpXU8/wsSD5gRvMKOlxIC63+4H9wESplmPB+c814YZFR
	540KUIWdjSVCbwP9Kzf/krNkTCcVobv8Q2b1SZo/2nsA/aW6EhhQmx6frRwsavmMRHekocpiDQyC/
	aYrU5E04fqIHiloRtbiYfGTNKyqMx5FlcfPQQB6HOo5+QBEw34O5WFaOP+w2PTizIZUIr/QkCejjc
	4G0bA7Jmjg3MqNqa726EJAZrjqISZqxzmHTf73pEAXZ0eEuIKOFVMHZG5DsvD9QMgo3v5420dtp7n
	V+s6VXRsw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzsZ2-0001U7-Nf; Mon, 27 Jul 2020 02:08:28 +0000
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzsYw-0001Ti-SV
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 02:08:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595815702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eHxRyECYtQanh0ezBnPcM1ZXwerag91PJylDaVDzjY4=;
 b=MXC36DgyUfx1oHCnM/cYhLBzgA5bSccsO4GpCL8NOq48SLsexuf/8XIa3zicO//L0J3jyT
 ppt74bOje24eVwGHcW/qvRQ1zGU8J4Jemz2zMjMDtyVTJzF7bxsgkmn/exBZbrpwl/lCIa
 4yqMEaO9D/7dkgpeTlDKoyy3frXWdWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-YJqsOQdjOPqpH92RAWKq1A-1; Sun, 26 Jul 2020 22:08:18 -0400
X-MC-Unique: YJqsOQdjOPqpH92RAWKq1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 500DA1005510;
 Mon, 27 Jul 2020 02:08:16 +0000 (UTC)
Received: from T590 (ovpn-12-208.pek2.redhat.com [10.72.12.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A643A1992D;
 Mon, 27 Jul 2020 02:08:08 +0000 (UTC)
Date: Mon, 27 Jul 2020 10:08:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
Message-ID: <20200727020803.GC1129253@T590>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me>
 <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200726_220823_127969_0C98CF31 
X-CRM114-Status: GOOD (  23.90  )
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

On Sun, Jul 26, 2020 at 09:27:56AM -0700, Sagi Grimberg wrote:
> 
> > > +void blk_mq_quiesce_queue_async(struct request_queue *q)
> > > +{
> > > +	struct blk_mq_hw_ctx *hctx;
> > > +	unsigned int i;
> > > +
> > > +	blk_mq_quiesce_queue_nowait(q);
> > > +
> > > +	queue_for_each_hw_ctx(q, hctx, i) {
> > > +		init_completion(&hctx->rcu_sync.completion);
> > > +		init_rcu_head(&hctx->rcu_sync.head);
> > > +		if (hctx->flags & BLK_MQ_F_BLOCKING)
> > > +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
> > > +				wakeme_after_rcu);
> > > +		else
> > > +			call_rcu(&hctx->rcu_sync.head,
> > > +				wakeme_after_rcu);
> > > +	}
> > 
> > Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
> > synchronize_rcu() is OK for all hctx during waiting.
> 
> That's true, but I want a single interface for both. v2 had exactly
> that, but I decided that this approach is better.

Not sure one new interface is needed, and one simple way is to:

1) call blk_mq_quiesce_queue_nowait() for each request queue

2) wait in driver specific way

Or just wondering why nvme doesn't use set->tag_list to retrieve NS,
then you may add per-tagset APIs for the waiting.

> 
> Also, having the driver call a single synchronize_rcu isn't great

Too many drivers are using synchronize_rcu():

	$ git grep -n synchronize_rcu ./drivers/ | wc
	    186     524   11384

> layering (as quiesce can possibly use a different mechanism in the future).

What is the different mechanism?

> So drivers assumptions like:
> 
>         /*
>          * SCSI never enables blk-mq's BLK_MQ_F_BLOCKING flag so
>          * calling synchronize_rcu() once is enough.
>          */
>         WARN_ON_ONCE(shost->tag_set.flags & BLK_MQ_F_BLOCKING);
> 
>         if (!ret)
>                 synchronize_rcu();
> 
> Are not great...

Both rcu read lock/unlock and synchronize_rcu is global interface, then
it is reasonable to avoid unnecessary synchronize_rcu().

> 
> > > +}
> > > +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
> > > +
> > > +void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
> > > +{
> > > +	struct blk_mq_hw_ctx *hctx;
> > > +	unsigned int i;
> > > +
> > > +	queue_for_each_hw_ctx(q, hctx, i) {
> > > +		wait_for_completion(&hctx->rcu_sync.completion);
> > > +		destroy_rcu_head(&hctx->rcu_sync.head);
> > > +	}
> > > +}
> > > +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
> > > +
> > >   /**
> > >    * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
> > >    * @q: request queue.
> > > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > > index 23230c1d031e..5536e434311a 100644
> > > --- a/include/linux/blk-mq.h
> > > +++ b/include/linux/blk-mq.h
> > > @@ -5,6 +5,7 @@
> > >   #include <linux/blkdev.h>
> > >   #include <linux/sbitmap.h>
> > >   #include <linux/srcu.h>
> > > +#include <linux/rcupdate_wait.h>
> > >   struct blk_mq_tags;
> > >   struct blk_flush_queue;
> > > @@ -170,6 +171,7 @@ struct blk_mq_hw_ctx {
> > >   	 */
> > >   	struct list_head	hctx_list;
> > > +	struct rcu_synchronize	rcu_sync;
> > The above struct takes at least 5 words, and I'd suggest to avoid it,
> > and the hctx->srcu should be re-used for waiting BLK_MQ_F_BLOCKING.
> > Meantime !BLK_MQ_F_BLOCKING doesn't need it.
> 
> It is at the end and contains exactly what is needed to synchronize. Not

The sync is simply single global synchronize_rcu(), and why bother to add
extra >=40bytes for each hctx.

> sure what you mean by reuse hctx->srcu?

You already reuses hctx->srcu, but not see reason to add extra rcu_synchronize
to each hctx for just simulating one single synchronize_rcu().


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
