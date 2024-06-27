Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE9EC2BD09
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 14:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BNoWuT7UuG2Nbrf+bgTkJFKZb6gx8cFnWOjFFjkii6s=; b=HVaIZnt6Fe0TLkjK0KwUz5iFVD
	IaOwSwx+oxP0iXU0rbZfVuTWL9PuHuvKrBPwgKALGQhlZv+KNW2cCYYLJqlBwq1HUXxqoavd0rheK
	ObWxl/udHTaV65iTg1yg1xaCDzS4cOIuDBRKwQMPZbSCqCP7Xf+c0RuwK+TOvRysprNFMyzxMwanF
	+3abtij2Dq8L4qPjcvY0Yorl2QxrV8iU+jA2Gm/IEh+s00QuKbNyqGaJKcPL/GBEoJ5j9kNKLwWP8
	G4J2qvREUQGRSSHGgu7syaEYjLK+u30kVNFj6BJ7xf5CiEr/8amqztrKGnOkoU5SMBy5ctxP6nbrK
	0YEj6cGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMpqT-0000000Aaca-15tc;
	Thu, 27 Jun 2024 14:11:29 +0000
Received: from mail.nearlyone.de ([2a01:4f8:1c1e:abde::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMpqM-0000000AaVL-1k24
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 14:11:24 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13CF2DAD4C;
	Thu, 27 Jun 2024 16:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1719497474; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BNoWuT7UuG2Nbrf+bgTkJFKZb6gx8cFnWOjFFjkii6s=;
	b=TOv9ofVQ1gOF3fSkFSbOab6RiJ5vO26sBn9Hu5tJIhE7rQaK0GUz4k2D3kl86fHi+BZ+R9
	cDbnih4Y432teCGAXpn5Z2hiVZKGVWbgW+af/r+Myz+rj8GtSP8YqcaQ+983d3Msdn0FsM
	yfQqo+Btm7Ms27KEmHVWLfYBrQfmS/YgFB6trKQ/E5SN7eIl/q0DzjKvH8i4hlKNWvu+a4
	QjWYihlNS+drQSFWEilX734flAsOs29QmaM4d1j2FrmlcnVhvhXl4h1AfZYrJ6QGdugpGf
	RQXX9EDIXZMVNk1wKXsiCFfGlaGy75abK0RgA28ZZhV9HlzK7UFyu5DiDEm6IQ==
From: Daniel Wagner <dwagner@suse.de>
Date: Thu, 27 Jun 2024 16:10:51 +0200
Subject: [PATCH v2 1/3] blk-mq: add blk_mq_num_possible_queues helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-isolcpus-io-queues-v2-1-26a32e3c4f75@suse.de>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
In-Reply-To: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
 Christoph Hellwig <hch@lst.de>
Cc: Frederic Weisbecker <fweisbecker@suse.com>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240627_071122_856944_5A0561FA 
X-CRM114-Status: GOOD (  12.85  )
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

Multi queue devices which use managed IRQs should only allocate queues
for the housekeeping CPUs when isolcpus is set. This avoids that the
isolated CPUs get disturbed with OS workload.

Add a helper which calculates the correct number of queues which should
be used.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 block/blk-mq-cpumap.c  | 20 ++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9638b25fd521..9717e323f308 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -11,10 +11,30 @@
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/group_cpus.h>
+#include <linux/sched/isolation.h>
 
 #include "blk.h"
 #include "blk-mq.h"
 
+/**
+ * blk_mq_num_possible_queues - Calc nr of queues for managed devices
+ *
+ * Calculate the number of queues which should be used for a multiqueue
+ * device which uses the managed IRQ API. The helper is considering
+ * isolcpus settings.
+ */
+unsigned int blk_mq_num_possible_queues(void)
+{
+	const struct cpumask *hk_mask;
+
+	hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
+	if (!cpumask_empty(hk_mask))
+		return cpumask_weight(hk_mask);
+
+	return num_possible_cpus();
+}
+EXPORT_SYMBOL_GPL(blk_mq_num_possible_queues);
+
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
 	const struct cpumask *masks;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 89ba6b16fe8b..2105cc78ca67 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -900,6 +900,7 @@ void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
 
+unsigned int blk_mq_num_possible_queues(void);
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 

-- 
2.45.2


