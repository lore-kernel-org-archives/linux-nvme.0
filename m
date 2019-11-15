Return-Path: <SRS0=/3pY=ZH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE121C432C3
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8245120748
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y5FFudXQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LT6CIKOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8245120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jvi9woMltg0dM3Q5cnwn/Izg3ZZTQd81Ox+5OjmAqVI=; b=Y5FFudXQ1LnFRq
	QAUmVO81oO3AExijgCRkN4yb85eQ9KKLxJaWCCP4KlSZKBhNT2VOQ0nbklj4ik6XY10J2BhlM/YMJ
	zgJE5Zqbw89TLyXhGeDGLMCJ2g9NE/P9dHj+dw9Fe0MGnhhEEMb6isnhv/aEE6fATDGfxNCbron3d
	9JoTe7RHIILGT+VAfOU61B050LCImKwJAUjYFlgpi01Db/nbPAhefaCU8jSv+4f6BTmSM0SL8LDVg
	g0qYNmm2b4XEWFo8KQOvV1RuO1twIhAc/t4Ou4kynu2wsje4LYoygM5qGyB7rR4+8lItjHnkitog1
	wPkb4a9Mk/wFgYv0PMwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iVZ4j-0002j0-Ec; Fri, 15 Nov 2019 10:43:37 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iVZ4P-0002Rb-NK
 for linux-nvme@lists.infradead.org; Fri, 15 Nov 2019 10:43:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573814595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9spnRhGRffTYFRmdJbv3gMbOyOJbQ9BooxBnq4poTrA=;
 b=LT6CIKOrhaAozqLfqJFj0IvAyanFUeK3LNow8+pLhxSVQh0QXZcwGFZheaEBrqTCTIwGzO
 bBzPQkrMapeLNAEyXe/G6h+1Cq/SkiDm1uf5u3u6tRpBr9lxDddGvt0mRJdUJTAbo+SSLL
 j3FNSn/Qt5crRHqbM2DJPfCpHcD0SYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-4CmJ8yvSM5CZU0u0l3VrmA-1; Fri, 15 Nov 2019 05:43:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53A0E1802CE0;
 Fri, 15 Nov 2019 10:43:11 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 750FA5D6BE;
 Fri, 15 Nov 2019 10:43:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RFC 3/3] blk-mq: kill blk_mq_alloc_request_hctx()
Date: Fri, 15 Nov 2019 18:42:38 +0800
Message-Id: <20191115104238.15107-4-ming.lei@redhat.com>
In-Reply-To: <20191115104238.15107-1-ming.lei@redhat.com>
References: <20191115104238.15107-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 4CmJ8yvSM5CZU0u0l3VrmA-1
X-Mimecast-Spam-Score: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191115_024317_856695_8613AA61 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

blk-mq uses static queue mapping between sw queue and hw queue to
retrieve hw queue, then allocate request on the retrieved hw queue's
request pool.

blk_mq_alloc_request_hctx() requires to specify one hctx index and ask
blk-mq to allocate request from this hctx's request pool. This way
is quite ugly given the hctx can become inactive any time because of
CPU hotplug. Kernel oops on NVMe FC/LOOP/RDMA/TCP has been reported
several times because of CPU hotplug.

The only user is NVMe loop, FC, RDMA and TCP driver for submitting
connect command. All these drivers have been conveted to use generic
API of blk_mq_alloc_request() to allocate request for NVMe connect
command.

So kill it now.

Cc: James Smart <james.smart@broadcom.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 46 ------------------------------------------
 include/linux/blk-mq.h |  3 ---
 2 files changed, 49 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5c9adcaa27ac..a360fe70ec98 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -427,52 +427,6 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 }
 EXPORT_SYMBOL(blk_mq_alloc_request);
 
-struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
-	unsigned int op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
-{
-	struct blk_mq_alloc_data alloc_data = { .flags = flags, .cmd_flags = op };
-	struct request *rq;
-	unsigned int cpu;
-	int ret;
-
-	/*
-	 * If the tag allocator sleeps we could get an allocation for a
-	 * different hardware context.  No need to complicate the low level
-	 * allocator for this for the rare use case of a command tied to
-	 * a specific queue.
-	 */
-	if (WARN_ON_ONCE(!(flags & BLK_MQ_REQ_NOWAIT)))
-		return ERR_PTR(-EINVAL);
-
-	if (hctx_idx >= q->nr_hw_queues)
-		return ERR_PTR(-EIO);
-
-	ret = blk_queue_enter(q, flags);
-	if (ret)
-		return ERR_PTR(ret);
-
-	/*
-	 * Check if the hardware context is actually mapped to anything.
-	 * If not tell the caller that it should skip this queue.
-	 */
-	alloc_data.hctx = q->queue_hw_ctx[hctx_idx];
-	if (!blk_mq_hw_queue_mapped(alloc_data.hctx)) {
-		blk_queue_exit(q);
-		return ERR_PTR(-EXDEV);
-	}
-	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
-	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
-
-	rq = blk_mq_get_request(q, NULL, &alloc_data);
-	blk_queue_exit(q);
-
-	if (!rq)
-		return ERR_PTR(-EWOULDBLOCK);
-
-	return rq;
-}
-EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
-
 static void __blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index dc03e059fdff..a0c65de93e8c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -441,9 +441,6 @@ enum {
 
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 		blk_mq_req_flags_t flags);
-struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
-		unsigned int op, blk_mq_req_flags_t flags,
-		unsigned int hctx_idx);
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag);
 
 enum {
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
