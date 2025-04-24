Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BC7C369D5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tIzp6N3l34lb49Vc9P9Z55GvUPVrr2bmL0BMIypyUv8=; b=EQxZ/y6lAjXaypBv4n9CmbAXZ1
	C02wYWmVhg6h6XQHhXU7OQV/uYoUNfgH6RfmemIXdCXMadJF+p/t0n92w8+ovm8NkxItb1pzpeeYi
	Ix+aeIPQUANqKOzRq8dOBXBU7Ys4McENFkQPNGLPU8yiLDs3neeQgWhK0eH6vOcpkzco4K+rfU2w1
	Q7beB7SabZxIBCxmQFGyOKWfNLV1ebgZbpqtLHk4vDIpLxrtI8DspqrRFTfeWpzljdIXkkE7p3hlK
	SiKra6ACA03M8LVc8GH/RVJaG6yAfqmM9JEhe78P3vn7stGJSlPRQrIOTwWAO0G/wdW1dZyUIukA0
	TIKo7vBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u81BI-0000000F0C1-2bCv;
	Thu, 24 Apr 2025 18:20:16 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u81BF-0000000F087-0VlE
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 18:20:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6DE1BA4D089;
	Thu, 24 Apr 2025 18:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802EAC4CEEA;
	Thu, 24 Apr 2025 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745518812;
	bh=AXA4x2vMWdvsJD5ZZl+of9Llu+mBLzfjSGJCkdx0VW0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=how6HOg4xUd6cxF5Runi3vtMopYXzUiZqPCkh7yY5A/H6/k5svrmHDM7XiIz1q3ma
	 SCF02zEuUcIuA5CgDZOYO5ohyY0Hl+8gJ45yLDzOE5zjzceogSpzKcqViPBB1vwyAE
	 adOYVggFJIH2aIm2JAgS6zQEN7IcZngXyv5ZXJdLXkIU4W7Fl7MXvnJ/WcgwzAc1qt
	 2gK72HuBkvXifXx+WDd7V8ycU3/XlsFnP5XDYDE5fm/wBSRGtg5BB/ObPyXrMT+5mf
	 MKDTAQxnd07mHXF6gm14HkmEHDir9usojRd/B6GzJS3AlUT33zOUOq/02ruSNDwxum
	 9pixCn0zcieOg==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 24 Apr 2025 20:19:48 +0200
Subject: [PATCH v6 9/9] blk-mq: prevent offlining hk CPU with associated
 online isolated CPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-isolcpus-io-queues-v6-9-9a53a870ca1f@kernel.org>
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
In-Reply-To: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, 
 linux-scsi@vger.kernel.org, storagedev@microchip.com, 
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_112013_304729_64A9CDE8 
X-CRM114-Status: GOOD (  17.67  )
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

When isolcpus=io_queue is enabled, and the last housekeeping CPU for a
given hctx would go offline, there would be no CPU left which handles
the IOs. To prevent IO stalls, prevent offlining housekeeping CPUs which
are still severing isolated CPUs..

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c2697db591091200cdb9f6e082e472b829701e4c..aff17673b773583dfb2b01cb2f5f010c456bd834 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3627,6 +3627,48 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 	return data.has_rq;
 }
 
+static bool blk_mq_hctx_check_isolcpus_online(struct blk_mq_hw_ctx *hctx, unsigned int cpu)
+{
+	const struct cpumask *hk_mask;
+	int i;
+
+	if (!housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		return true;
+
+	hk_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+
+	for (i = 0; i < hctx->nr_ctx; i++) {
+		struct blk_mq_ctx *ctx = hctx->ctxs[i];
+
+		if (ctx->cpu == cpu)
+			continue;
+
+		/*
+		 * Check if this context has at least one online
+		 * housekeeping CPU in this case the hardware context is
+		 * usable.
+		 */
+		if (cpumask_test_cpu(ctx->cpu, hk_mask) &&
+		    cpu_online(ctx->cpu))
+			break;
+
+		/*
+		 * The context doesn't have any online housekeeping CPUs
+		 * but there might be an online isolated CPU mapped to
+		 * it.
+		 */
+		if (cpu_is_offline(ctx->cpu))
+			continue;
+
+		pr_warn("%s: trying to offline hctx%d but there is still an online isolcpu CPU %d mapped to it\n",
+			hctx->queue->disk->disk_name,
+			hctx->queue_num, ctx->cpu);
+		return true;
+	}
+
+	return false;
+}
+
 static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
 		unsigned int this_cpu)
 {
@@ -3647,7 +3689,7 @@ static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
 
 		/* this hctx has at least one online CPU */
 		if (this_cpu != cpu)
-			return true;
+			return blk_mq_hctx_check_isolcpus_online(hctx, this_cpu);
 	}
 
 	return false;
@@ -3659,7 +3701,7 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 			struct blk_mq_hw_ctx, cpuhp_online);
 
 	if (blk_mq_hctx_has_online_cpu(hctx, cpu))
-		return 0;
+		return -EINVAL;
 
 	/*
 	 * Prevent new request from being allocated on the current hctx.

-- 
2.49.0


