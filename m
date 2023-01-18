Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AA4C38147
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s+uP61lk3WyH/rUXZilmvQ986E2tFq1ppIzjnNODw1k=; b=byjPYMmnqzJjEI0xaNZ/bGAcVk
	a3SITUUt7zWzWTTXcLnfs4o5Xc3ShMlXvgZtroKvs5Cxmsqviftxs4QEjwi5yFTHinJTzF+0E8lJP
	ZZZmOxXxagmP64+6GdVhbL+wy1OPAP0t9QahA2xD3Loz6Jb96zh2UQPnBZ+1QRV5KLaE+9PwQHXQU
	yprVkQ0iPCON4mtyBnwPiWlOC2sROLIitL3Z76aUcx5838Z/s9oZZYDQh0pgYpoVKU1eHW/kdCl8w
	O3XWN6BfxliMR4ouKhD1nUHatBo7Y+ZwySxXF7cccPK5hcl1GBf7JIRBmnzL9mDwLaCnIeXBh1cO3
	UpQp1U/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIAGL-001Y9P-Uf; Wed, 18 Jan 2023 15:22:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIAGJ-001Y8v-9c
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 15:22:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C7B9C6189B;
	Wed, 18 Jan 2023 15:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D6AC433AE;
	Wed, 18 Jan 2023 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674055321;
	bh=c9S34Zz3JSV1iqFStgnI3BLnN7Nel4054VUva74EZMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVcnVx0t19MTRpunzic3/nv8WU1EvR1IuYoDNJnewC6m7mRiE1J/vXZSL/ZJOOfgO
	 wKkyC3ewfJXnR+fNsQ/T+0UWa4IrRvxauKC4UFhiIM+rZEe3B9ZI+uiXNNNFXHmfls
	 x0JGLPx7ZhapDeMHzbF9HJK5M64Jamw5R9kxl46gwuIiSC9znLRy5ANlR2S7aKamCf
	 CvjRiO9oLXqfJTPFeN6ntnIGn5E5yC5HA/Utz2RLI0CXCTBK6gTl1cHhZl4vew9ihs
	 tROHvh5g04tat1Fq8Yc85wsL7ful7p/V56Fo8xHe5RG8hQ8zhTvhpMsvyBiHP2WS6z
	 31hFRSf2yYphg==
Date: Wed, 18 Jan 2023 08:21:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv2] nvme-pci: fix timeout request state check
Message-ID: <Y8gOlnKNsOTPq1Yj@kbusch-mbp>
References: <20230118052244.741505-1-kbusch@meta.com>
 <20230118053306.GA24817@lst.de>
 <Y8eJJ/9qo9c7jzLT@kbusch-mbp>
 <20230118073330.GA27048@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118073330.GA27048@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_072203_395007_3E57C52C 
X-CRM114-Status: GOOD (  23.96  )
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

On Wed, Jan 18, 2023 at 08:33:30AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 17, 2023 at 10:52:39PM -0700, Keith Busch wrote:
> > We're actually not batching here (no IOB in the timeout context), so we
> > are either:
> > 
> >   a. calling nvme_pci_complete_rq() inline with the cqe
> >   b. racing with smp ipi or softirq
> > 
> > If case (a), we will always see IDLE. If (b), we are racing and may see
> > either COMPLETED or IDLE, so we have to check that it's not either of
> > those. Since there's only one other state (STARTED) that was guaranteed
> > prior to entering the timeout handler, we can just make sure it's not
> > that one after the poll to know if abort escalation is needed.
> 
> The point is still that "started" is the wrong check here and relies
> on an implementation detail.  I think we're better off with an explicit
> IDLE check and a big fat comment.

So you want the check to look like this instead?

---
@@ -1362,7 +1362,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
        else
                nvme_poll_irqdisable(nvmeq);

-       if (blk_mq_request_completed(req)) {
+       if (blk_mq_request_completed(req) ||
+           blk_mq_rq_state(req) == MQ_RQ_IDLE) {
                dev_warn(dev->ctrl.device,
                         "I/O %d QID %d timeout, completion polled\n",
                         req->tag, nvmeq->qid);
--

That's essentially a more complicated equivalent to what I have, but
fine with me if you think it's more clear.

Alternatively, I also considered moving the IDLE state setting to when
the request is actually freed, which might make more sense and works
without changing the nvme driver:

---
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -713,6 +713,7 @@ static void __blk_mq_free_request(struct request *rq)
        struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
        const int sched_tag = rq->internal_tag;

+       WRITE_ONCE(rq->state, MQ_RQ_IDLE);
        blk_crypto_free_request(rq);
        blk_pm_mark_last_busy(rq);
        rq->mq_hctx = NULL;
@@ -741,7 +742,6 @@ void blk_mq_free_request(struct request *rq)

        rq_qos_done(q, rq);

-       WRITE_ONCE(rq->state, MQ_RQ_IDLE);
        if (req_ref_put_and_test(rq))
                __blk_mq_free_request(rq);
 }
--

