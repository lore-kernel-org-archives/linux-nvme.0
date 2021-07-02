Return-Path: <SRS0=C+HF=L2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C06DC11F68
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jul 2021 15:07:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC47361405
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jul 2021 15:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC47361405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LDsfVAZ6mLlmy4qvWMkuaFSjC+pk93OldS0xaRIKFaM=; b=DLanE/bm1Z8/NP
	n9MHtRlNzo1vZ3JwiaK+TSKaaWdfc0PWhz8is8DiPE9x8nr+kEgSeTWcP/1jJ94fDSwKPerKATNF1
	ijBQGWT6HLo/pWMRQk19LXpsoBvdVxZS8pfC3c3lieyP3EUe9Mr+7OyLJ6hFApuKYn64K4VKsFZ4A
	pyGhz3m8zgDbaG9Q63MrwoP54bwOwg3L6h0OvHX4/PF9REo8vznFF1BY+YLCU9ngfUBtWbCv1LlSL
	HCyfGGS++48no2zZHCA31N1ZmbwM6V/tkkcNZkM2gbPEk7vIldaXSicd4WtlR54PhwuSCnBot+7ha
	QinBwokyfUy/Bw1l6RoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lzKlI-003MM2-3I; Fri, 02 Jul 2021 15:07:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lzKlF-003MKi-6w
 for linux-nvme@lists.infradead.org; Fri, 02 Jul 2021 15:07:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625238439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F+2oHLpX8JZjv44hGDmtIxG6ORErAm4Mcm9zVkReuXE=;
 b=WEyNke3mYJz47WqtKKaZfcVe/S8gt5IN+VfCw+31lpIR0TwZpiyaQlGCL/PhzoFLPuUexh
 OfUcHSR93q8vhjmGRdU/F4HbmfENOTsVGD6jQFOHX3ZvkjPJOGBIGs2DabGpBRt3ZURcrk
 tH67ZdIoHa2j1l1U+CTJJjEn6PHCLnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-fF7ITqdGMvWsreT9236iwQ-1; Fri, 02 Jul 2021 11:07:18 -0400
X-MC-Unique: fF7ITqdGMvWsreT9236iwQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFC84EC1A0;
 Fri,  2 Jul 2021 15:07:15 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F3ED1893C;
 Fri,  2 Jul 2021 15:07:11 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <damien.lemoal@wdc.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/6] blk-mq: prepare for not deactivating hctx if managed
 irq isn't used
Date: Fri,  2 Jul 2021 23:05:50 +0800
Message-Id: <20210702150555.2401722-2-ming.lei@redhat.com>
In-Reply-To: <20210702150555.2401722-1-ming.lei@redhat.com>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210702_080721_375835_6C94AE16 
X-CRM114-Status: GOOD (  21.25  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

blk-mq deactivates one hctx when the last CPU in hctx->cpumask become
offline by draining all requests originated from this hctx and moving new
allocation on other active hctx. This way is for avoiding inflight IO in
case of managed irq because managed irq is shutdown when the last CPU in
the irq's affinity becomes offline.

However, lots of drivers(nvme fc, rdma, tcp, loop, ...) don't use managed
irq, so they needn't to deactivate hctx when the last CPU becomes offline.
Also, some of them are the only user of blk_mq_alloc_request_hctx() which
is used for connecting io queue. And their requirement is that the connect
request needs to be submitted successfully via one specified hctx even though
all CPUs in this hctx->cpumask have become offline.

Preparing for addressing the requirement for nvme fc/rdma/loop by adding
BLK_MQ_F_MANAGED_IRQ to not deactivate hctxs if managed irq isn't used.
Finally, if one driver uses managed irq, it has to tell blk-mq via
BLK_MQ_F_MANAGED_IRQ.

Meantime blk-mq's cpu hotplug handling can be optimized a bit if managed
irq isn't used.

Given blk_mq_alloc_request_hctx() is always called by driver without
BLK_MQ_F_MANAGED_IRQ, it is safe to take one offline cpu for getting
the sw context.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c |  1 +
 block/blk-mq.c         | 23 +++++++++++++----------
 include/linux/blk-mq.h |  1 +
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4b66d2776eda..17f57af3a4d6 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -247,6 +247,7 @@ static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(NO_SCHED),
 	HCTX_FLAG_NAME(STACKING),
 	HCTX_FLAG_NAME(TAG_HCTX_SHARED),
+	HCTX_FLAG_NAME(MANAGED_IRQ),
 };
 #undef HCTX_FLAG_NAME
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2e9fd0ec63d7..1d45d2922ca7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -427,6 +427,15 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 }
 EXPORT_SYMBOL(blk_mq_alloc_request);
 
+static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
+{
+	int cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);
+
+	if (cpu >= nr_cpu_ids)
+		cpu = cpumask_first(hctx->cpumask);
+	return cpu;
+}
+
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	unsigned int op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
 {
@@ -468,7 +477,10 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	data.hctx = q->queue_hw_ctx[hctx_idx];
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
-	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
+
+	WARN_ON_ONCE(data.hctx->flags & BLK_MQ_F_MANAGED_IRQ);
+
+	cpu = blk_mq_first_mapped_cpu(data.hctx);
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	if (!q->elevator)
@@ -1501,15 +1513,6 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	hctx_unlock(hctx, srcu_idx);
 }
 
-static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
-{
-	int cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);
-
-	if (cpu >= nr_cpu_ids)
-		cpu = cpumask_first(hctx->cpumask);
-	return cpu;
-}
-
 /*
  * It'd be great if the workqueue API had a way to pass
  * in a mask and had some smarts for more clever placement.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index fd2de2b422ed..62fc0393cc3a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -403,6 +403,7 @@ enum {
 	 */
 	BLK_MQ_F_STACKING	= 1 << 2,
 	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
+	BLK_MQ_F_MANAGED_IRQ	= 1 << 4,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
