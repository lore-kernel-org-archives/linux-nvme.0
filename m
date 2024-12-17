Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AB4E7718A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2024 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zu3PJd7igAEOuURhCl2JDIScQCWsHu7bcIJGnsFHvac=; b=KOg6exSnsW5lmbKCpQWhSR2XcK
	LNRlSnEcp/EGjHl8f98HqwnwSPxa/UK4GpFAQE9SIMY/fuBHID03+aLTtR7HYdYiSmIkWDiS342L9
	eAr5+sMdQrAY3tQ2c9ABPRkCS7ddS9Rdn+4WJmOlN28gbagl6iFWDTStQleSKNn7JsrBWA4Oc8fKQ
	5hGAoUwOl70zq9hlg2OjtEb+KPyhpM2L5w5RQ4kDWZsl/5kk2LauK+2RuxMUwgo5ie2xZHxOjZppi
	YGG7HaSZC7eu+Tx4oZjxhMF30DgZzcNe8gVwKH7YcxH6N9a+sYp0woNpynLDDPpzKyZLr9cWCPP6v
	wsRwGrzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOIth-00000002EFg-3wgg;
	Thu, 19 Dec 2024 15:57:09 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNcKa-0000000EXy9-2uKt
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 18:30:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E5F2A5C0427;
	Tue, 17 Dec 2024 18:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42921C4CED7;
	Tue, 17 Dec 2024 18:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734460203;
	bh=9E4zdKJB+GZ5hrunhZ5waPqGhd3dwl22GY+jZTRcQo0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BDHSDkkvfIdjOsCZGAiSlESOhzhq3J7LUMxwgaAxl5kZg7RFqjj/btldHd+64aqZk
	 oI1xoOIEUIVsrXX1VWCujqMT33H3SJS1Mx3BDXav0RJfxLDAgIU0F4IO8ip8UKqQnE
	 zKniqALFx/TJVF8kZTTbX+5in5wUD25vHR8uMSnJL6+g8xP6G0iVipOYJLor976yU6
	 39TErU2jdYCBGMucm7kSGh9d92bOerL7sz4vk5jcUSt1hxRXK9LwW02LBoPO8fvSHU
	 QQ9FYF+Mz/ui8JVfXNzrA0a2n+yRnpQ5X8/xJEhuAqTNSKo1t0Qb/qhGAsFW/U8gHG
	 nV1bUxsaaDcRQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 17 Dec 2024 19:29:42 +0100
Subject: [PATCH v4 8/9] blk-mq: use hk cpus only when isolcpus=managed_irq
 is enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-isolcpus-io-queues-v4-8-5d355fbb1e14@kernel.org>
References: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
In-Reply-To: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Kashyap Desai <kashyap.desai@broadcom.com>, 
 Sumit Saxena <sumit.saxena@broadcom.com>, 
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, 
 Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, 
 Don Brace <don.brace@microchip.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Costa Shulyupin <costa.shul@redhat.com>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, 
 Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
 storagedev@microchip.com, virtualization@lists.linux.dev, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_103004_842346_A04E1ECC 
X-CRM114-Status: GOOD (  16.69  )
X-Mailman-Approved-At: Thu, 19 Dec 2024 07:56:32 -0800
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

When isolcpus=managed_irq is enabled all hardware queues should run on
the housekeeping CPUs only. Thus ignore the affinity mask provided by
the driver. Also we can't use blk_mq_map_queues because it will map all
CPUs to first hctx unless, the CPU is the same as the hctx has the
affinity set to, e.g. 8 CPUs with isolcpus=managed_irq,2-3,6-7 config

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

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-cpumap.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index b3a863c2db3231624685ab54a1810b22af4111f4..38016bf1be8af14ef368e68d3fd12416858e3da6 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -61,11 +61,74 @@ unsigned int blk_mq_num_online_queues(unsigned int max_queues)
 }
 EXPORT_SYMBOL_GPL(blk_mq_num_online_queues);
 
+/*
+ * blk_mq_map_hk_queues - Create housekeeping CPU to hardware queue mapping
+ * @qmap:	CPU to hardware queue map
+ *
+ * Create a housekeeping CPU to hardware queue mapping in @qmap. If the
+ * isolcpus feature is enabled and blk_mq_map_hk_queues returns true,
+ * @qmap contains a valid configuration honoring the managed_irq
+ * configuration. If the isolcpus feature is disabled this function
+ * returns false.
+ */
+static bool blk_mq_map_hk_queues(struct blk_mq_queue_map *qmap)
+{
+	struct cpumask *hk_masks;
+	cpumask_var_t isol_mask;
+	unsigned int queue, cpu, nr_masks;
+
+	if (!housekeeping_enabled(HK_TYPE_MANAGED_IRQ))
+		return false;
+
+	/* map housekeeping cpus to matching hardware context */
+	nr_masks = qmap->nr_queues;
+	hk_masks = group_cpus_evenly(&nr_masks);
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
+		       housekeeping_cpumask(HK_TYPE_MANAGED_IRQ));
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
 	nr_masks = qmap->nr_queues;
 	masks = group_cpus_evenly(&nr_masks);
 	if (!masks) {
@@ -121,6 +184,9 @@ void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
 	if (!dev->bus->irq_get_affinity)
 		goto fallback;
 
+	if (blk_mq_map_hk_queues(qmap))
+		return;
+
 	for (queue = 0; queue < qmap->nr_queues; queue++) {
 		mask = dev->bus->irq_get_affinity(dev, queue + offset);
 		if (!mask)

-- 
2.47.1


