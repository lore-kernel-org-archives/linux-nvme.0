Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A14C83F03
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RKa6MAT2DHN83s/gS79gNiLInGEVzfWziRfEJcO+yW0=; b=pmsXjm5l7F8OxakVEafBT923BK
	Jnt5zk2Ad+6NrcwmB54mUoe4O7LKgowg3bxR9pGKqydJ7YvhXJenuxJYsogfE3H7Ydq3vqchcWfg9
	Lz11g73K9l/ukdgexAO5tvuxZCqm0icLIRXnGafxXO2qRnD9ZBSm9R8hW8SGt8dWdBPCZhxRXA51v
	kqlWOh+8qK+En9VvWkpkdnRNciGcH34iRmQenF8S0sWDlioXp32ELBrCR8vbvAPfApvYSgJ7d62m3
	X/f8wXKMFdnyET3V/LcuLJvI6A/LHrUMwttGZGj9Cm45d3W/X93ldJM8/LomM1kuIHjIYj5dBWUEF
	i6NoZiyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX0x8-000000094ZF-1RjW;
	Wed, 02 Jul 2025 17:08:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX0Pl-00000008xfa-2peK
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 16:34:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5B2A443A98;
	Wed,  2 Jul 2025 16:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0E5C4CEE7;
	Wed,  2 Jul 2025 16:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751474069;
	bh=23j3KSCA64Mgm0T8Sek4hATHwAlMZA3/GjuzRB7crDc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s7wAi7y2o1DL6JllRa1VtciP4EQmr1mB0MRo0dTiVfDYh65PnoG4GYIyLKZt2c4L0
	 b2W+70CYPuwhX6T2da+c2AOfc0h/4I7g4dXHd0ZTviVJPF1X+ABG+9CeZxqMHR6h7R
	 1BaZ8gaKVypEO0rduEfLlAzfEoyCxyzG+QcG7w6Ws4qjT2495qy01DlQJfg9WuEmKX
	 dzedhsXifh51x268vpDeVXpUXmk9rxKf05VxSk9jWPGR6ytUxPbxTCFwyPRcxZ8LQc
	 Iye7z9OndxqV1/ldX/fLvoCDYb/2T02pzRKFGJ6vMuSoMPEpDWzwPl6NA0C+beAgsL
	 iE4TRAceikqRg==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 02 Jul 2025 18:33:59 +0200
Subject: [PATCH v7 09/10] blk-mq: prevent offlining hk CPUs with associated
 online isolated CPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-isolcpus-io-queues-v7-9-557aa7eacce4@kernel.org>
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
In-Reply-To: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
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
X-CRM114-CacheID: sfid-20250702_093429_755749_6D48EB40 
X-CRM114-Status: GOOD (  16.92  )
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
given hctx goes offline, there would be no CPU left to handle I/O. To
prevent I/O stalls, prevent offlining housekeeping CPUs that are still
serving isolated CPUs.

When isolcpus=io_queue is enabled and the last housekeeping CPU
for a given hctx goes offline, no CPU would be left to handle I/O.
To prevent I/O stalls, disallow offlining housekeeping CPUs that are
still serving isolated CPUs.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0c61492724d228736f975f1d8f195515603801b6..87240644f73ed0490a5459e042c68e0e168f727d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3681,6 +3681,43 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 	return data.has_rq;
 }
 
+static bool blk_mq_hctx_can_offline_hk_cpu(struct blk_mq_hw_ctx *hctx,
+					   unsigned int this_cpu)
+{
+	const struct cpumask *hk_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+
+	for (int i = 0; i < hctx->nr_ctx; i++) {
+		struct blk_mq_ctx *ctx = hctx->ctxs[i];
+
+		if (ctx->cpu == this_cpu)
+			continue;
+
+		/*
+		 * Check if this context has at least one online
+		 * housekeeping CPU; in this case the hardware context is
+		 * usable.
+		 */
+		if (cpumask_test_cpu(ctx->cpu, hk_mask) &&
+		    cpu_online(ctx->cpu))
+			break;
+
+		/*
+		 * The context doesn't have any online housekeeping CPUs,
+		 * but there might be an online isolated CPU mapped to
+		 * it.
+		 */
+		if (cpu_is_offline(ctx->cpu))
+			continue;
+
+		pr_warn("%s: trying to offline hctx%d but there is still an online isolcpu CPU %d mapped to it\n",
+			hctx->queue->disk->disk_name,
+			hctx->queue_num, ctx->cpu);
+		return false;
+	}
+
+	return true;
+}
+
 static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
 		unsigned int this_cpu)
 {
@@ -3712,6 +3749,11 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
 			struct blk_mq_hw_ctx, cpuhp_online);
 
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
+		if (!blk_mq_hctx_can_offline_hk_cpu(hctx, cpu))
+			return -EINVAL;
+	}
+
 	if (blk_mq_hctx_has_online_cpu(hctx, cpu))
 		return 0;
 

-- 
2.50.0


