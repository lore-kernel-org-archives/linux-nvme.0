Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CB8E7719D
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 16:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rmx5HG/+ZPmzowIjfAXhpHM3IykM3Fd8XTzB+pIQh6M=; b=pdkVxOos4oEiXjYSWWGkbjueix
	+NaXLOk2RPZX30HWfgCp/cOrA0dmP0hCt5eblpUDkV03SupDNjxR8oGI6eZPmHdeA+iOCX6BEkqi9
	TqY/3k5sEHO5+Qj8U48WLk2oaak/w4r/kA4Mc5Wzfk1qUwUDjgiO4pFAM9iBrWr7NrOEl8PDQdthz
	jDupnAEAk3R2QLGyo01hcTEmOJGwI/E9KDgxvncvf22SFk/pB3az1KzmKLbXu8egEa3UAo0WwQCq7
	QmAsRmK2SCVZwwJKAlqen2n/sE50LI2/TdKhPzVjjcw9ZGRBs6otaWOnPJkxEdB+A7mgbc+v6SASp
	jkttWYtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHvC-0000000GGjq-03rM;
	Fri, 10 Jan 2025 16:31:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHqk-0000000GF0u-3gIA
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 16:27:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 43ECC5C4363;
	Fri, 10 Jan 2025 16:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAC7C4CED6;
	Fri, 10 Jan 2025 16:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736526425;
	bh=m9BSbBAD2bW8ZLYqHByMdg0GNOBvxPgl189ozbJAOes=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r+5ItLis6ADqjLZ00Y7vBeSuGNRtzNTJVGEtwoh4kB07EhnoA3SxtoGr/dXPCT3c1
	 kz15npsjmJ678zcsqURO9gI2VwV24kQrHFJH8kkBl1rqSWY9Q2rdrW45LjMvFwfE3q
	 gUZkNLyyS9gTBOQnQnKkYjVkcbaG4phZN0R2UQq8zj8yfYEgh3JzreHw95snCkDf3U
	 dzuAbKq/fk3DMi0Dlj8MuyNuzMUii/lRG/JyH7Qaxk62A+NN9twYCnys7GuW4Lu7Z4
	 XqvJ09YHEorEWgLvrag9v77l7BFp3nytx8ftJV8BEkJMxPVELC21G/pDlrM1pE9FXG
	 4hJk67zGncQoQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 10 Jan 2025 17:26:46 +0100
Subject: [PATCH v5 8/9] blk-mq: issue warning when offlining hctx with
 online isolcpus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-isolcpus-io-queues-v5-8-0e4f118680b0@kernel.org>
References: <20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org>
In-Reply-To: <20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, 
 linux-scsi@vger.kernel.org, storagedev@microchip.com, 
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_082706_999232_EA73BB45 
X-CRM114-Status: GOOD (  17.40  )
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

When isolcpus=managed_irq is enabled, and the last housekeeping CPU for
a given hardware context goes offline, there is no CPU left which
handles the IOs anymore. If isolated CPUs mapped to this hardware
context are online and an application running on these isolated CPUs
issue an IO this will lead to stalls.

The kernel will not schedule IO to isolated CPUS thus this avoids IO
stalls.

Thus issue a warning when housekeeping CPUs are offlined for a hardware
context while there are still isolated CPUs online.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2e6132f778fd958aae3cad545e4b3dd623c9c304..43eab0db776d37ffd7eb6c084211b5e05d41a574 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3620,6 +3620,45 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 	return data.has_rq;
 }
 
+static void blk_mq_hctx_check_isolcpus_online(struct blk_mq_hw_ctx *hctx, unsigned int cpu)
+{
+	const struct cpumask *hk_mask;
+	int i;
+
+	if (!housekeeping_enabled(HK_TYPE_MANAGED_IRQ))
+		return;
+
+	hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
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
+		pr_warn("%s: offlining hctx%d but there is still an online isolcpu CPU %d mapped to it, IO stalls expected\n",
+			hctx->queue->disk->disk_name,
+			hctx->queue_num, ctx->cpu);
+	}
+}
+
 static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
 		unsigned int this_cpu)
 {
@@ -3639,8 +3678,10 @@ static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
 			continue;
 
 		/* this hctx has at least one online CPU */
-		if (this_cpu != cpu)
+		if (this_cpu != cpu) {
+			blk_mq_hctx_check_isolcpus_online(hctx, this_cpu);
 			return true;
+		}
 	}
 
 	return false;

-- 
2.47.1


