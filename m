Return-Path: <SRS0=XP6N=CS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EC2C43461
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 16:04:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B757A20639
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 16:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t3gwdXbA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrtPUDUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B757A20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iSecKimRQL7YgLLWTRdafrUt7ScC4/hCfNZHhVoFtBo=; b=t3gwdXbA9td/nmAqMwohm4XdK
	m5A8HQb4UnJyj+FTU58DP/zXNX4NZAFHhfGjnR3fv1kR3Ngoyw2nFgXQ3JKLYZYcIIWNyGGaI79VV
	nFI6SzQFQeVW1kjFzYQ+qjOQ+LNVy5dtDrCkWkgtQQ3b0pl49Ro3V41UWMLmOADdYNsVQPRw/Xrg/
	WzfLqv4CgTk9ALh9ySbX0Z9hl4xEvM99IYfBPmgu+3dN0QUSJxYT6UQyNunMw7wR8lNMdLI39T5qY
	gGDD7ESJtF9P9Ak5YUpFVg5ohgFab+hVjJwRmViT1gLn2y03br7DJ/ixLM6oBU2J75RK2TiE68xqE
	tqyD0yy+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kG2a0-0001o3-3t; Wed, 09 Sep 2020 16:04:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kG2Zx-0001nd-Vk
 for linux-nvme@lists.infradead.org; Wed, 09 Sep 2020 16:04:14 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6DB5620639;
 Wed,  9 Sep 2020 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599667452;
 bh=EHuvVrnM07dPmNMBqcaf0SREfFCZ6XvDoOjALPhXkgA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OrtPUDUzwmiiFBSlYsP99CvXjvHsmTQy39GPYHZS5J1xTSg0FKPL75BEUPvS/lzi4
 SvyqVsWs9cVwdxQWoahNvRe98uSDZxscE89XeJSGgZPs8fu4FXlAqlb4RtlF/S4Wr1
 +yI5Mqm4pEbempPnDIOAZJjCbixaaZy60eZREKaM=
Date: Wed, 9 Sep 2020 09:04:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V4 2/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200909160409.GA3356175@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200909104116.1674592-1-ming.lei@redhat.com>
 <20200909104116.1674592-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200909104116.1674592-3-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200909_120414_100187_C9D165FD 
X-CRM114-Status: GOOD (  16.24  )
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

On Wed, Sep 09, 2020 at 06:41:14PM +0800, Ming Lei wrote:
>  void blk_mq_quiesce_queue(struct request_queue *q)
>  {
> -	struct blk_mq_hw_ctx *hctx;
> -	unsigned int i;
> -	bool rcu = false;
> +	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
> +	bool was_quiesced =__blk_mq_quiesce_queue_nowait(q);
>  
> -	__blk_mq_quiesce_queue_nowait(q);
> +	if (!was_quiesced && blocking)
> +		percpu_ref_kill(&q->dispatch_counter);
>  
> -	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (hctx->flags & BLK_MQ_F_BLOCKING)
> -			synchronize_srcu(hctx->srcu);
> -		else
> -			rcu = true;
> -	}
> -	if (rcu)
> +	if (blocking)
> +		wait_event(q->mq_quiesce_wq,
> +				percpu_ref_is_zero(&q->dispatch_counter));
> +	else
>  		synchronize_rcu();
>  }

In the previous version, you had ensured no thread can unquiesce a queue
while another is waiting for quiescence. Now that the locking is gone,
a thread could unquiesce the queue before percpu_ref reaches zero, so
the wait_event() may never complete on the resurrected percpu_ref.

I don't think any drivers do such a thing today, but it just looks like
the implementation leaves open the possibility.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
