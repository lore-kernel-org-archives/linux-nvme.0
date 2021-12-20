Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB928C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Dec 2021 20:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=haawZ+Abuts+1S1guhiyz9YATKEVy2EBR+qIq2cSH18=; b=IVbDBs/zD5x2f7mRxdiR55Pdxf
	zGZ/cPCItGr0AcFKgbTz85LRHNzBw9h+bwiODILZlgqxRFrQYHGwBzjVYS8p4yTABotT2AeHonY52
	6H1EgxoQ/lpM/5aEjhBK8GZbNQhJuDuIplcijR/t3Hwo6PJHpQDJjVafBNOngZhZRLR8e2dsGAqDH
	yeSnzIF5lrumpVSj3KeMq2rla8x/YvbW3fcm5FN3NkbDIi7faOJSPsnUysy85qmN9e44PimnNIZPr
	VXUmEQpCy2/iV3pixGAIW4azkWfRtU7w5JbksggGAK3dRk8/WuacjGZgTL4j8inlPN2mV+Ykfvycx
	URCSOzrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzPOz-004Jd5-OI; Mon, 20 Dec 2021 20:36:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzPOx-004Jbp-6X
 for linux-nvme@lists.infradead.org; Mon, 20 Dec 2021 20:36:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 97BAA61044;
 Mon, 20 Dec 2021 20:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82B0C36AE7;
 Mon, 20 Dec 2021 20:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640032612;
 bh=cmt8iiwTichM0pX39LXzYDIDjPQN0t91l/bFA5y8vi0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Mz0dxk2BnvHicDHS5vDYj86dticCxGR65TVAlnkz3wnwRL3xoaZviYw0oxOCs6bBf
 AZXpdOjoFLCWRboI5gA5cBenw0V5FbFBj5xN86ePuk75d2gZnt+aev6E5VYWHupQOJ
 Gsvb2+4xux+lwoWwuhWl1xFMLKCV95TQ4y0nLRhIBHOoUiXkeBBPFjR1zrPVzr0e+x
 T3+J2hSJbV14QqO++TPs8UBcidIaFKSlyJnoBWaxOrxuF4KAA5x4JulHPkdF53GSJb
 1nQeA9sQPGYE0V0y1YxHniA3/an2QXq7H04mAd+HkNsLzvQJQalWt7/5Aa69gtbEne
 N7hudojBRPrNA==
Date: Mon, 20 Dec 2021 12:36:49 -0800
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Message-ID: <20211220203649.GA4170598@dhcp-10-100-145-180.wdc.com>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215162421.14896-2-axboe@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211220_123655_330728_2FE8AA98 
X-CRM114-Status: GOOD (  18.65  )
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

On Wed, Dec 15, 2021 at 09:24:18AM -0700, Jens Axboe wrote:
> +		/*
> +		 * Peek first request and see if we have a ->queue_rqs() hook.
> +		 * If we do, we can dispatch the whole plug list in one go. We
> +		 * already know at this point that all requests belong to the
> +		 * same queue, caller must ensure that's the case.
> +		 *
> +		 * Since we pass off the full list to the driver at this point,
> +		 * we do not increment the active request count for the queue.
> +		 * Bypass shared tags for now because of that.
> +		 */
> +		if (q->mq_ops->queue_rqs &&
> +		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> +			blk_mq_run_dispatch_ops(q,
> +				q->mq_ops->queue_rqs(&plug->mq_list));

I think we still need to verify the queue isn't quiesced within
blk_mq_run_dispatch_ops()'s rcu protected area, prior to calling
.queue_rqs(). Something like below. Or is this supposed to be the
low-level drivers responsibility now?

---
+void __blk_mq_flush_plug_list(struct request_queue *q, struct blk_plug *plug)
+{
+	if (blk_queue_quiesced(q))
+		return;
+	q->mq_ops->queue_rqs(&plug->mq_list);
+}
+
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct blk_mq_hw_ctx *this_hctx;
@@ -2580,7 +2587,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		if (q->mq_ops->queue_rqs &&
 		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
 			blk_mq_run_dispatch_ops(q,
-				q->mq_ops->queue_rqs(&plug->mq_list));
+				__blk_mq_flush_plug_list(q, plug));
 			if (rq_list_empty(plug->mq_list))
 				return;
 		}
--

