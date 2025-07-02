Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AF2C83F04
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d5uJCi9s9vS8Hpriz03hJh5u6B3AAB7GYIxHqaz3Ug0=; b=tj9RpyLu3a4K/7Kj1Z1sd3AWxk
	neMZSG5o+IMfwhNxWuNgfX+ZJzpAx1ynf0nIH3i5/RU0dOKnnpWrp0/5/DPNq0XfpJStP9LS/ubMK
	iGbXcp8J9/BsKwN5gpr6IgC8HVvSELHMXNT5TzNO59onWzqjKuhBJY+KVH9oYuNiI6N73o7Wz8wFE
	cG4NDFq9MxXQnBaBL7gqSFlrDZjkBZd6A6epzxKNuiI5K4h3vR8E6tKOijJfSBo6NmP8q9kRrf0p+
	+w5PwWaS9636mQGeX4iowg02r7aicQ8Q/I/x3yUIIIWmm/NhRK750UBnS4d0sODs8wFpxTHWxAaSe
	SY8knCUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX0x2-000000094QO-0jrs;
	Wed, 02 Jul 2025 17:08:52 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX0PU-00000008xZl-161i
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 16:34:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EAAD543A98;
	Wed,  2 Jul 2025 16:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E857C4CEED;
	Wed,  2 Jul 2025 16:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751474051;
	bh=L2kPQSZAgXrho+8Mjw1nsKm5x3AqLLr+qKmpGSeOxcs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rb9j8v/2ajs+fVfGnUD3ot9OtunvlPAz2BP8YjtAio4giziu44PBVYT241YKMqFgd
	 iFCclTJh4MfBVypDA7BWmozKXPX8uqWNPvhy3ihEBzQ1AWGsGRZUgnOEDhOgEcllLH
	 uVhFCK4Ukn8EeWKIxgiXkiSVSbP8WYMnnE0aWr9WRwL4ef3hMES0bcYCSInOtu0rpb
	 OV/KI85T3Bt/KSV8Pmm9pbksgav5AqWDY1eyekCVmbcacj3PGV0TDR27/1a6Eu3I8D
	 OaoXahr5DqDR3FXwOqqQjNIIQqw76/diFUBi7MrgNstYUgU868Gja2rO6qmTiRk+PL
	 ZIHdcNxDn4kfw==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 02 Jul 2025 18:33:53 +0200
Subject: [PATCH v7 03/10] blk-mq: add
 blk_mq_{online|possible}_queue_affinity
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-isolcpus-io-queues-v7-3-557aa7eacce4@kernel.org>
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
X-CRM114-CacheID: sfid-20250702_093412_350210_EB59C03A 
X-CRM114-Status: GOOD (  12.76  )
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

Introduce blk_mq_{online|possible}_queue_affinity, which returns the
queue-to-CPU mapping constraints defined by the block layer. This allows
other subsystems (e.g., IRQ affinity setup) to respect block layer
requirements.

It is necessary to provide versions for both the online and possible CPU
masks because some drivers want to spread their I/O queues only across
online CPUs, while others prefer to use all possible CPUs. And the mask
used needs to match with the number of queues requested
(see blk_num_{online|possible}_queues).

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-cpumap.c  | 24 ++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 705da074ad6c7e88042296f21b739c6d686a72b6..8244ecf878358c0b8de84458dcd5100c2f360213 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -26,6 +26,30 @@ static unsigned int blk_mq_num_queues(const struct cpumask *mask,
 	return min_not_zero(num, max_queues);
 }
 
+/**
+ * blk_mq_possible_queue_affinity - Return block layer queue affinity
+ *
+ * Returns an affinity mask that represents the queue-to-CPU mapping
+ * requested by the block layer based on possible CPUs.
+ */
+const struct cpumask *blk_mq_possible_queue_affinity(void)
+{
+	return cpu_possible_mask;
+}
+EXPORT_SYMBOL_GPL(blk_mq_possible_queue_affinity);
+
+/**
+ * blk_mq_online_queue_affinity - Return block layer queue affinity
+ *
+ * Returns an affinity mask that represents the queue-to-CPU mapping
+ * requested by the block layer based on online CPUs.
+ */
+const struct cpumask *blk_mq_online_queue_affinity(void)
+{
+	return cpu_online_mask;
+}
+EXPORT_SYMBOL_GPL(blk_mq_online_queue_affinity);
+
 /**
  * blk_mq_num_possible_queues - Calc nr of queues for multiqueue devices
  * @max_queues:	The maximum number of queues the hardware/driver
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2a5a828f19a0ba6ff0812daf40eed67f0e12ada1..1144017dce47af82f9d010e42bfbf26fa4ddf33f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -947,6 +947,8 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 void blk_mq_unfreeze_queue_non_owner(struct request_queue *q);
 void blk_freeze_queue_start_non_owner(struct request_queue *q);
 
+const struct cpumask *blk_mq_possible_queue_affinity(void);
+const struct cpumask *blk_mq_online_queue_affinity(void);
 unsigned int blk_mq_num_possible_queues(unsigned int max_queues);
 unsigned int blk_mq_num_online_queues(unsigned int max_queues);
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);

-- 
2.50.0


