Return-Path: <SRS0=5LEM=CT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BB9C43461
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 14:55:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732D320809
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 14:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DUiJVQ1H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8jVqRVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732D320809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LZ5Nya6QDyRvXXKVuPLDWPDUtjK0Rj/75VFEBhy2DRY=; b=DUiJVQ1HClxX8Vgz8NIei8BeI
	wO53i0KGQT70EFLlnqadkGMk/uH5YweFl5RsFrBtpvPJRvqZd31qWbacrk/XamP6ZZZb4Fc5G7Ai9
	MSJD/PD0WakqEcWfIF1jdjlCNfaoxjibl3jXi/z+aLbGDEvyKGrJ2mIzdpu0XPNFVDUXJlPPATOXL
	OvXHnKZMjzx3NoQNTgGts0uHrtfxEWULCZwsBAoXcEDGQeB+1MNvXlnRcdWXfLkGLDMreT458Mf0a
	dhLLMwVzKc6NE7YesuF3q5IIlwNZNtB+5rEBSx+T03tsHUvc4mgh4db5+DjZez9Q87KjqpwjjNKva
	BNTGQ2X1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGNyv-0006LZ-Rx; Thu, 10 Sep 2020 14:55:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGNys-0006Jj-A8
 for linux-nvme@lists.infradead.org; Thu, 10 Sep 2020 14:55:23 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 55D6F207FB;
 Thu, 10 Sep 2020 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599749721;
 bh=PHydTs//1Z0WBTdqTTnUXRZ2vHkm9CK82ppdHxvRuEo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f8jVqRVYdCaqZSptWgC5AD+FsuYiHbFCLi2QJ2FG82xlRMGt5aZlQHtLJtb2wqXRx
 UDSizF6QenG+Rr50GwG2SxV0CSDrVWOtlFNueV8lIESqmSziXBKP0o18pOGQy58MNd
 9fHkrv0FS4BLUqetoSc1kY34QVRluuVgmXeeIz+8=
Date: Thu, 10 Sep 2020 07:55:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V4 2/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200910145518.GB3446191@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200909104116.1674592-1-ming.lei@redhat.com>
 <20200909104116.1674592-3-ming.lei@redhat.com>
 <20200909160409.GA3356175@dhcp-10-100-145-180.wdl.wdc.com>
 <20200910015321.GA7420@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910015321.GA7420@T590>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200910_105522_572595_3E019489 
X-CRM114-Status: GOOD (  28.06  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 10, 2020 at 09:53:21AM +0800, Ming Lei wrote:
> On Wed, Sep 09, 2020 at 09:04:09AM -0700, Keith Busch wrote:
> > On Wed, Sep 09, 2020 at 06:41:14PM +0800, Ming Lei wrote:
> > >  void blk_mq_quiesce_queue(struct request_queue *q)
> > >  {
> > > -	struct blk_mq_hw_ctx *hctx;
> > > -	unsigned int i;
> > > -	bool rcu = false;
> > > +	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
> > > +	bool was_quiesced =__blk_mq_quiesce_queue_nowait(q);
> > >  
> > > -	__blk_mq_quiesce_queue_nowait(q);
> > > +	if (!was_quiesced && blocking)
> > > +		percpu_ref_kill(&q->dispatch_counter);
> > >  
> > > -	queue_for_each_hw_ctx(q, hctx, i) {
> > > -		if (hctx->flags & BLK_MQ_F_BLOCKING)
> > > -			synchronize_srcu(hctx->srcu);
> > > -		else
> > > -			rcu = true;
> > > -	}
> > > -	if (rcu)
> > > +	if (blocking)
> > > +		wait_event(q->mq_quiesce_wq,
> > > +				percpu_ref_is_zero(&q->dispatch_counter));
> > > +	else
> > >  		synchronize_rcu();
> > >  }
> > 
> > In the previous version, you had ensured no thread can unquiesce a queue
> > while another is waiting for quiescence. Now that the locking is gone,
> > a thread could unquiesce the queue before percpu_ref reaches zero, so
> > the wait_event() may never complete on the resurrected percpu_ref.
> > 
> > I don't think any drivers do such a thing today, but it just looks like
> > the implementation leaves open the possibility.
> 
> This driver can cause bigger trouble if it unquiesces its queue which is
> being quiesced and still not done.
> 
> However, we can avoid that by the following delta change:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7669fe815cf9..5632727d71fa 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -225,9 +225,16 @@ static void __blk_mq_quiesce_queue(struct request_queue *q, bool wait)
>  	if (!wait)
>  		return;
>  
> +	/*
> +	 * In case of F_BLOCKING, if driver unquiesces its queue which is being
> +	 * quiesced and still not done, it can cause bigger trouble, and we simply
> +	 * return & warn once for avoiding hang here.
> +	 */
>  	if (blocking)
>  		wait_event(q->mq_quiesce_wq,
> -				percpu_ref_is_zero(&q->dispatch_counter));
> +				percpu_ref_is_zero(&q->dispatch_counter) ||
> +				WARN_ON_ONCE(!percpu_ref_is_dying(
> +						&q->dispatch_counter)));
>  	else
>  		synchronize_rcu();
>  }

Yeah, I'm okay with this. A warning and return should be good to
indicate driver sequence errors. So if you just want to fold the above
into this patch, then I don't think I have any remaining concerns.

The other race condition is if unquiesce resurrects the ref before
quiesce kills it, and there's already a warning there too.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
