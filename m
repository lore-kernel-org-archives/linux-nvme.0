Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C0CC83038
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 17:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8pP7qV5B4Il31XPfnGwtDuXAqulPAyPYXHCZcGYeteM=; b=nDOSd6iuUSgIfVY6MhlLqtR7BS
	8yUMn7IB0rGOkBcRMTx7HXrP+Cf2y2TR5Mss9n1AzzAsEu0R+ivTsVQ5oGGtoDXQQ0968oNNGoNxX
	zzzD703Q9Mh7Ekf+WdMgZlFsyFHRYSXjmKa4dBQiGgRSlF4oq4q424JqsJlmxHJS6EAP6ttBM0rLD
	kfw0pIIdFm3J77+FjGm1jEc0xT373PBo5LkesZ6m8w52SDrxqn2b4wvCqFCk+GerZAguouQFmtkGM
	LYHlS1VZ7iuGiE76Asx91YfWcTIohZEEJK3jIer41+Zhb1KnPSzjl6X14rfAHKC6YYiNw6Iy/o9Tw
	X+V9RaRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX0x7-000000094Xq-1ZdJ;
	Wed, 02 Jul 2025 17:08:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX0Pj-00000008xeh-1QNH
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 16:34:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BB0C0613B2;
	Wed,  2 Jul 2025 16:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC270C4CEE7;
	Wed,  2 Jul 2025 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751474066;
	bh=fvvM2n0UzFN1s1CyT45kO8uaXr9ocdmKAnN2yge/JJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QIAixJVkfiznlZ3dMfBax2i42fg63OIUGFH7jcO3JskS2Ogia/5saECwjWIV559qC
	 SFI7kgJxSYnH2Tu/5hdEGjIaVWem8FOXpGJiDEcFjd6rncC/ZKYMrZ3MhOT/mWYhLK
	 VQHmb5lrZgXvRkJhN5ttKtR/7OxWvlSs07LLf+V7t18lB6sFlU9cEy/WYJPDtkEvHT
	 2f0VH5lrHAD9EQc2cjCbfDRm+3H22G98uuvnJF/peWuNO5buwlB2BhiXkCGyoLSBVt
	 KYWBLjVmrzFaTh6ZVZ1K6Bs9Fw8+ATurDBcgsmqE3BXoOCR0pJcUl6bykkPZv8Hmcn
	 XBpujw3WXm9hw==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 02 Jul 2025 18:33:58 +0200
Subject: [PATCH v7 08/10] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-isolcpus-io-queues-v7-8-557aa7eacce4@kernel.org>
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

Extend the capabilities of the generic CPU to hardware queue (hctx)
mapping code, so it maps houskeeping CPUs and isolated CPUs to the
hardware queues evenly.

A hctx is only operational when there is at least one online
housekeeping CPU assigned (aka active_hctx). Thus, check the final
mapping that there is no hctx which has only offline housekeeing CPU and
online isolated CPUs.

Example mapping result:

  16 online CPUs

  isolcpus=io_queue,2-3,6-7,12-13

Queue mapping:
        hctx0: default 0 2
        hctx1: default 1 3
        hctx2: default 4 6
        hctx3: default 5 7
        hctx4: default 8 12
        hctx5: default 9 13
        hctx6: default 10
        hctx7: default 11
        hctx8: default 14
        hctx9: default 15

IRQ mapping:
        irq 42 affinity 0 effective 0  nvme0q0
        irq 43 affinity 0 effective 0  nvme0q1
        irq 44 affinity 1 effective 1  nvme0q2
        irq 45 affinity 4 effective 4  nvme0q3
        irq 46 affinity 5 effective 5  nvme0q4
        irq 47 affinity 8 effective 8  nvme0q5
        irq 48 affinity 9 effective 9  nvme0q6
        irq 49 affinity 10 effective 10  nvme0q7
        irq 50 affinity 11 effective 11  nvme0q8
        irq 51 affinity 14 effective 14  nvme0q9
        irq 52 affinity 15 effective 15  nvme0q10

A corner case is when the number of online CPUs and present CPUs
differ and the driver asks for less queues than online CPUs, e.g.

  8 online CPUs, 16 possible CPUs

  isolcpus=io_queue,2-3,6-7,12-13
  virtio_blk.num_request_queues=2

Queue mapping:
        hctx0: default 0 1 2 3 4 5 6 7 8 12 13
        hctx1: default 9 10 11 14 15

IRQ mapping
        irq 27 affinity 0 effective 0 virtio0-config
        irq 28 affinity 0-1,4-5,8 effective 5 virtio0-req.0
        irq 29 affinity 9-11,14-15 effective 0 virtio0-req.1

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-cpumap.c | 194 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 191 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 8244ecf878358c0b8de84458dcd5100c2f360213..4cb2724a78e13216e50f0e6b1a18f19ea41a54f8 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -17,12 +17,25 @@
 #include "blk.h"
 #include "blk-mq.h"
 
+static struct cpumask blk_hk_online_mask;
+
 static unsigned int blk_mq_num_queues(const struct cpumask *mask,
 				      unsigned int max_queues)
 {
 	unsigned int num;
 
-	num = cpumask_weight(mask);
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
+		const struct cpumask *hk_mask;
+		struct cpumask avail_mask;
+
+		hk_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+		cpumask_and(&avail_mask, mask, hk_mask);
+
+		num = cpumask_weight(&avail_mask);
+	} else {
+		num = cpumask_weight(mask);
+	}
+
 	return min_not_zero(num, max_queues);
 }
 
@@ -31,9 +44,13 @@ static unsigned int blk_mq_num_queues(const struct cpumask *mask,
  *
  * Returns an affinity mask that represents the queue-to-CPU mapping
  * requested by the block layer based on possible CPUs.
+ * This helper takes isolcpus settings into account.
  */
 const struct cpumask *blk_mq_possible_queue_affinity(void)
 {
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		return housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+
 	return cpu_possible_mask;
 }
 EXPORT_SYMBOL_GPL(blk_mq_possible_queue_affinity);
@@ -46,6 +63,12 @@ EXPORT_SYMBOL_GPL(blk_mq_possible_queue_affinity);
  */
 const struct cpumask *blk_mq_online_queue_affinity(void)
 {
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
+		cpumask_and(&blk_hk_online_mask, cpu_online_mask,
+			    housekeeping_cpumask(HK_TYPE_IO_QUEUE));
+		return &blk_hk_online_mask;
+	}
+
 	return cpu_online_mask;
 }
 EXPORT_SYMBOL_GPL(blk_mq_online_queue_affinity);
@@ -57,7 +80,8 @@ EXPORT_SYMBOL_GPL(blk_mq_online_queue_affinity);
  *		ignored.
  *
  * Calculates the number of queues to be used for a multiqueue
- * device based on the number of possible CPUs.
+ * device based on the number of possible CPUs. This helper
+ * takes isolcpus settings into account.
  */
 unsigned int blk_mq_num_possible_queues(unsigned int max_queues)
 {
@@ -72,7 +96,8 @@ EXPORT_SYMBOL_GPL(blk_mq_num_possible_queues);
  *		ignored.
  *
  * Calculates the number of queues to be used for a multiqueue
- * device based on the number of online CPUs.
+ * device based on the number of online CPUs. This helper
+ * takes isolcpus settings into account.
  */
 unsigned int blk_mq_num_online_queues(unsigned int max_queues)
 {
@@ -80,11 +105,169 @@ unsigned int blk_mq_num_online_queues(unsigned int max_queues)
 }
 EXPORT_SYMBOL_GPL(blk_mq_num_online_queues);
 
+static bool blk_mq_hk_validate(struct blk_mq_queue_map *qmap,
+			       const struct cpumask *active_hctx)
+{
+	/*
+	 * Verify if the mapping is usable.
+	 *
+	 * First, mark all hctx which have at least online houskeeping
+	 * CPU assigned.
+	 */
+	for (int queue = 0; queue < qmap->nr_queues; queue++) {
+		int cpu;
+
+		if (cpumask_test_cpu(queue, active_hctx)) {
+			/*
+			 * This htcx has at least one online houskeeping
+			 * CPU thus it is able to serve any assigned
+			 * isolated CPU.
+			 */
+			continue;
+		}
+
+		/*
+		 * There is no online houskeeping CPU for this hctx, all
+		 * good as long as all isolated CPUs are also offline.
+		 */
+		for_each_online_cpu(cpu) {
+			if (qmap->mq_map[cpu] != queue)
+				continue;
+
+			pr_warn("Unable to create a usable CPU-to-queue mapping with the given constraints\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
+/*
+ * blk_mq_map_hk_queues - Create housekeeping CPU to
+ *                        hardware queue mapping
+ * @qmap:	CPU to hardware queue map
+ *
+ * Create a housekeeping CPU to hardware queue mapping in @qmap. @qmap
+ * contains a valid configuration honoring the isolcpus configuration.
+ */
+static void blk_mq_map_hk_queues(struct blk_mq_queue_map *qmap)
+{
+	cpumask_var_t active_hctx __free(free_cpumask_var) = NULL;
+	struct cpumask *hk_masks __free(kfree) = NULL;
+	const struct cpumask *mask;
+	unsigned int queue, cpu, nr_masks;
+
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+	else
+		goto fallback;
+
+	if (!zalloc_cpumask_var(&active_hctx, GFP_KERNEL))
+		goto fallback;
+
+	/* Map housekeeping CPUs to a hctx */
+	hk_masks = group_mask_cpus_evenly(qmap->nr_queues, mask, &nr_masks);
+	if (!hk_masks)
+		goto fallback;
+
+	for (queue = 0; queue < qmap->nr_queues; queue++) {
+		unsigned int idx = (qmap->queue_offset + queue) % nr_masks;
+
+		for_each_cpu(cpu, &hk_masks[idx]) {
+			qmap->mq_map[cpu] = idx;
+
+			if (cpu_online(cpu))
+				cpumask_set_cpu(qmap->mq_map[cpu], active_hctx);
+		}
+	}
+
+	/* Map isolcpus to hardware context */
+	queue = cpumask_first(active_hctx);
+	for_each_cpu_andnot(cpu, cpu_possible_mask, mask) {
+		qmap->mq_map[cpu] = (qmap->queue_offset + queue) % nr_masks;
+		queue = cpumask_next_wrap(queue, active_hctx);
+	}
+
+	if (!blk_mq_hk_validate(qmap, active_hctx))
+		goto fallback;
+
+	return;
+
+fallback:
+	/*
+	 * Map all CPUs to the first hctx to ensure at least one online
+	 * housekeeping CPU is serving it.
+	 */
+	for_each_possible_cpu(cpu)
+		qmap->mq_map[cpu] = 0;
+}
+
+/*
+ * blk_mq_map_hk_irq_queues - Create housekeeping CPU to
+ *                            hardware queue mapping
+ * @dev:	The device to map queues
+ * @qmap:	CPU to hardware queue map
+ * @offset:	Queue offset to use for the device
+ *
+ * Create a housekeeping CPU to hardware queue mapping in @qmap. @qmap
+ * contains a valid configuration honoring the isolcpus configuration.
+ */
+static void blk_mq_map_hk_irq_queues(struct device *dev,
+				     struct blk_mq_queue_map *qmap,
+				     int offset)
+{
+	cpumask_var_t active_hctx __free(free_cpumask_var) = NULL;
+	cpumask_var_t mask __free(free_cpumask_var) = NULL;
+	unsigned int queue, cpu;
+
+	if (!zalloc_cpumask_var(&active_hctx, GFP_KERNEL))
+		goto fallback;
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+		goto fallback;
+
+	/* Map housekeeping CPUs to a hctx */
+	for (queue = 0; queue < qmap->nr_queues; queue++) {
+		for_each_cpu(cpu, dev->bus->irq_get_affinity(dev, offset + queue)) {
+			qmap->mq_map[cpu] = qmap->queue_offset + queue;
+
+			cpumask_set_cpu(cpu, mask);
+			if (cpu_online(cpu))
+				cpumask_set_cpu(qmap->mq_map[cpu], active_hctx);
+		}
+	}
+
+	/* Map isolcpus to hardware context */
+	queue = cpumask_first(active_hctx);
+	for_each_cpu_andnot(cpu, cpu_possible_mask, mask) {
+		qmap->mq_map[cpu] = qmap->queue_offset + queue;
+		queue = cpumask_next_wrap(queue, active_hctx);
+	}
+
+	if (!blk_mq_hk_validate(qmap, active_hctx))
+		goto fallback;
+
+	return;
+
+fallback:
+	/*
+	 * Map all CPUs to the first hctx to ensure at least one online
+	 * housekeeping CPU is serving it.
+	 */
+	for_each_possible_cpu(cpu)
+		qmap->mq_map[cpu] = 0;
+}
+
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
 	const struct cpumask *masks;
 	unsigned int queue, cpu, nr_masks;
 
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
+		blk_mq_map_hk_queues(qmap);
+		return;
+	}
+
 	masks = group_cpus_evenly(qmap->nr_queues, &nr_masks);
 	if (!masks) {
 		for_each_possible_cpu(cpu)
@@ -139,6 +322,11 @@ void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
 	if (!dev->bus->irq_get_affinity)
 		goto fallback;
 
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
+		blk_mq_map_hk_irq_queues(dev, qmap, offset);
+		return;
+	}
+
 	for (queue = 0; queue < qmap->nr_queues; queue++) {
 		mask = dev->bus->irq_get_affinity(dev, queue + offset);
 		if (!mask)

-- 
2.50.0


