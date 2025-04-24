Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527B3C369D5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jgR8G+IJ5sSheVhKWEZIg+SPg9GugANQktEJG9W/RU4=; b=ygCZk97x4GTzLVGmJxUxuuH/U9
	IjjBYXjbK0rAt9tVGB/BxckxFFjY0MbhvkfaWSLt4wNXl1PVEkYpO/tLjcz2LzStuSSchf7F3d3RL
	mhmnckbhE7qKIknvKV8Stifg8Ro0q6ylkXyQz1m3zF39g83+Yb+1CY24qC4KOksoZxfobOuQB0TOr
	M8wx8DcducrOkZj0Xjd/feLEWo7Nf8pgxJWriJ0WhkKLDv4dEh0ElYBquOe50JGLxr7ocAzloxNAV
	Mj4AwY0NTk7gc3t8RArLCjmQkqBUkuEASXhvEVEFcYHYs4bKI2PZ1vfxnZEalJbb5ro97TPDgJkAV
	eeBi3M+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u829R-0000000FAt6-3Ttf;
	Thu, 24 Apr 2025 19:22:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u81BC-0000000F05f-14rX
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 18:20:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 66D215C04A3;
	Thu, 24 Apr 2025 18:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FC0C4AF0B;
	Thu, 24 Apr 2025 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745518809;
	bh=ZzXctOeUvdzZq7E43MFmzj1XIDOOZfBrFh235iH0XOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P3yHszTIDoFLhLy3ZcAgleg8u8tq9hRoxYf6mN/qZfyjKT80K5YBhxRY4YWIpbLv4
	 r5xCswJlpgyG13Ij4q8+suYqHAqUz9sffsVS3zhABMsdCSA5tsi1DdViS9bZwj27Y+
	 vs1E0iCBQz/JxNf0O+JqYIDHpvS3jJcKBCBSRNcoDuqQOlbbZjC8eNb3+mUkMfC9v3
	 PxBlmjblcB66XahWpNtmlPfRcJfJyfprb9aObxPQSkSX6NUZPDEZwRRmg58k4z8ZGk
	 VUCmc94aYwc5CkKWt2TYIWhcNN6erq/G7iunk0FuSFtqdMWvoNKF30pYy51lEd7U7Y
	 79mQ7Eg/gBTcQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 24 Apr 2025 20:19:47 +0200
Subject: [PATCH v6 8/9] blk-mq: use hk cpus only when isolcpus=io_queue is
 enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-isolcpus-io-queues-v6-8-9a53a870ca1f@kernel.org>
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
X-CRM114-CacheID: sfid-20250424_112010_383722_FD163F8B 
X-CRM114-Status: GOOD (  18.26  )
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

When isolcpus=io_queue is enabled all hardware queues should run on
the housekeeping CPUs only. Thus ignore the affinity mask provided by
the driver. Also we can't use blk_mq_map_queues because it will map all
CPUs to first hctx unless, the CPU is the same as the hctx has the
affinity set to, e.g. 8 CPUs with isolcpus=io_queue,2-3,6-7 config

  queue mapping for /dev/nvme0n1
        hctx0: default 2 3 4 6 7
        hctx1: default 5
        hctx2: default 0
        hctx3: default 1

  PCI name is 00:05.0: nvme0n1
        irq 57 affinity 0-1 effective 1 is_managed:0 nvme0q0
        irq 58 affinity 4 effective 4 is_managed:1 nvme0q1
        irq 59 affinity 5 effective 5 is_managed:1 nvme0q2
        irq 60 affinity 0 effective 0 is_managed:1 nvme0q3
        irq 61 affinity 1 effective 1 is_managed:1 nvme0q4

where as with blk_mq_hk_map_queues we get

  queue mapping for /dev/nvme0n1
        hctx0: default 2 4
        hctx1: default 3 5
        hctx2: default 0 6
        hctx3: default 1 7

  PCI name is 00:05.0: nvme0n1
        irq 56 affinity 0-1 effective 1 is_managed:0 nvme0q0
        irq 61 affinity 4 effective 4 is_managed:1 nvme0q1
        irq 62 affinity 5 effective 5 is_managed:1 nvme0q2
        irq 63 affinity 0 effective 0 is_managed:1 nvme0q3
        irq 64 affinity 1 effective 1 is_managed:1 nvme0q4

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-cpumap.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 6e6b3e989a5676186b5a31296a1b94b7602f1542..2d678d1db2b5196fc2b2ce5678fdb0cb6bad26e0 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -22,8 +22,8 @@ static unsigned int blk_mq_num_queues(const struct cpumask *mask,
 {
 	unsigned int num;
 
-	if (housekeeping_enabled(HK_TYPE_MANAGED_IRQ))
-		mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
 
 	num = cpumask_weight(mask);
 	return min_not_zero(num, max_queues);
@@ -61,11 +61,73 @@ unsigned int blk_mq_num_online_queues(unsigned int max_queues)
 }
 EXPORT_SYMBOL_GPL(blk_mq_num_online_queues);
 
+/*
+ * blk_mq_map_hk_queues - Create housekeeping CPU to hardware queue mapping
+ * @qmap:	CPU to hardware queue map
+ *
+ * Create a housekeeping CPU to hardware queue mapping in @qmap. If the
+ * isolcpus feature is enabled and blk_mq_map_hk_queues returns true,
+ * @qmap contains a valid configuration honoring the io_queue
+ * configuration. If the isolcpus feature is disabled this function
+ * returns false.
+ */
+static bool blk_mq_map_hk_queues(struct blk_mq_queue_map *qmap)
+{
+	struct cpumask *hk_masks;
+	cpumask_var_t isol_mask;
+	unsigned int queue, cpu, nr_masks;
+
+	if (!housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		return false;
+
+	/* map housekeeping cpus to matching hardware context */
+	hk_masks = group_cpus_evenly(qmap->nr_queues, &nr_masks);
+	if (!hk_masks)
+		goto fallback;
+
+	for (queue = 0; queue < qmap->nr_queues; queue++) {
+		for_each_cpu(cpu, &hk_masks[queue % nr_masks])
+			qmap->mq_map[cpu] = qmap->queue_offset + queue;
+	}
+
+	kfree(hk_masks);
+
+	/* map isolcpus to hardware context */
+	if (!alloc_cpumask_var(&isol_mask, GFP_KERNEL))
+		goto fallback;
+
+	queue = 0;
+	cpumask_andnot(isol_mask,
+		       cpu_possible_mask,
+		       housekeeping_cpumask(HK_TYPE_IO_QUEUE));
+
+	for_each_cpu(cpu, isol_mask) {
+		qmap->mq_map[cpu] = qmap->queue_offset + queue;
+		queue = (queue + 1) % qmap->nr_queues;
+	}
+
+	free_cpumask_var(isol_mask);
+
+	return true;
+
+fallback:
+	/* map all cpus to hardware context ignoring any affinity */
+	queue = 0;
+	for_each_possible_cpu(cpu) {
+		qmap->mq_map[cpu] = qmap->queue_offset + queue;
+		queue = (queue + 1) % qmap->nr_queues;
+	}
+	return true;
+}
+
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
 	const struct cpumask *masks;
 	unsigned int queue, cpu, nr_masks;
 
+	if (blk_mq_map_hk_queues(qmap))
+		return;
+
 	masks = group_cpus_evenly(qmap->nr_queues, &nr_masks);
 	if (!masks) {
 		for_each_possible_cpu(cpu)
@@ -120,6 +182,9 @@ void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
 	if (!dev->bus->irq_get_affinity)
 		goto fallback;
 
+	if (blk_mq_map_hk_queues(qmap))
+		return;
+
 	for (queue = 0; queue < qmap->nr_queues; queue++) {
 		mask = dev->bus->irq_get_affinity(dev, queue + offset);
 		if (!mask)

-- 
2.49.0


