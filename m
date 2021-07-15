Return-Path: <SRS0=3azT=MH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E714DC07E96
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 12:09:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9362611C0
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 12:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9362611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cVvdDDGm2TW9d2LbZW8Ciuf9vQsUdLgXjugSgw+CZwc=; b=38IKSHtBhtwJs7
	NxvmAk0gtzoZ8mjBOvAXYuTibNZPEYEJcg3pBZKc98CG1ViCjyq4is1E2weZFO/45nJcQVqHVeDSh
	oQHzrc4TBs8ADsLri2CQf3FrgowfIa1ril3CyZW9Iw+EMJL+FMgcq2W0Da0ty4OITfydlHqYKtPJh
	zi1oCh0RgQsAdIOuBN+hz7gIR/TSziGjwsa2CVP5asX2piUvecc9ntdz9m+mP6AC+s9tkR8jHF1+b
	7scwunJEC7KB+Ow4WxgrPiQfd5yOTLIWtgYtdeAIqCjRmUrOURcqepmWaxf0tZsf6xnFFRKF/pF7U
	DtPEVoFH8pTT9MbBG0vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m40BX-000hsL-Iy; Thu, 15 Jul 2021 12:09:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m40BA-000hi3-6Y
 for linux-nvme@lists.infradead.org; Thu, 15 Jul 2021 12:09:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626350963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEyeHofMx8tj7VEsxrvtta8tXqNSRwnjfqPdjz6a1lM=;
 b=E48lh5KslV834wfz3cenaJ+gXXtS320nxVeiqUSkSjW+wYN4zuiRjlm3dJcGwptQ4RM50A
 EbrhflBPbrH8LdM8B7yVlIK1DuuFG2LOAYyPSL8OgiCNgaUwRPHUEy7ak0++gkYdn4oKow
 +alpI1nvRqwhI8bNU/B28aTXXZkQtiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-m9vk4FB5PIWaxLVzrqPSmw-1; Thu, 15 Jul 2021 08:09:19 -0400
X-MC-Unique: m9vk4FB5PIWaxLVzrqPSmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3CEB800D62;
 Thu, 15 Jul 2021 12:09:17 +0000 (UTC)
Received: from localhost (ovpn-12-61.pek2.redhat.com [10.72.12.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C2E119C45;
 Thu, 15 Jul 2021 12:09:12 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 3/3] blk-mq: don't deactivate hctx if managed irq isn't used
Date: Thu, 15 Jul 2021 20:08:44 +0800
Message-Id: <20210715120844.636968-4-ming.lei@redhat.com>
In-Reply-To: <20210715120844.636968-1-ming.lei@redhat.com>
References: <20210715120844.636968-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210715_050924_372329_C2299C88 
X-CRM114-Status: GOOD (  22.41  )
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

Addressing the requirement for nvme fc/rdma/loop by allowing to
allocate request from one hctx when all CPUs in this hctx are offline,
since these drivers don't use managed irq.

Finally don't deactivate one hctx when it doesn't use managed irq.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 27 +++++++++++++++++----------
 block/blk-mq.h |  8 ++++++++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c4ac51e54eb..591ab07c64d8 100644
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
+	WARN_ON_ONCE(blk_mq_hctx_use_managed_irq(data.hctx));
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
@@ -2556,6 +2559,10 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
 			struct blk_mq_hw_ctx, cpuhp_online);
 
+	/* hctx needn't to be deactivated in case managed irq isn't used */
+	if (!blk_mq_hctx_use_managed_irq(hctx))
+		return 0;
+
 	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
 	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
 		return 0;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d08779f77a26..7333b659d8f5 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -119,6 +119,14 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 	return ctx->hctxs[type];
 }
 
+static inline bool blk_mq_hctx_use_managed_irq(struct blk_mq_hw_ctx *hctx)
+{
+	if (hctx->type == HCTX_TYPE_POLL)
+		return false;
+
+	return hctx->queue->tag_set->map[hctx->type].use_managed_irq;
+}
+
 /*
  * sysfs helpers
  */
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
