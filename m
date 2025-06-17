Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D103AC71136
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jun 2025 14:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r7RK36FXAmaQb83bgciq2chMJAr+dsJK3G5MVI6cpsM=; b=HHGElwAr/rhzgwE5k8/GVDlEJE
	i0+kx8xhKujxT1NMB5wWVB9lEhAMK3QCP+IU0lyxDvC7e0gwlBIe26o42HENOyXsiRBRv1JR4LlnH
	LW/hCEQ9JjCCL3yNn6hysTns1gY2yNm4B9U1NbUaGqYoAeQYizs6MwmLQ4LNEH7vuFNwI0xhNQQrd
	4wBRsQRITC8dMVWroNUKLiZ0AmoQKC+vTvOD2LZQ/yP0vgw1E2Uf5fujEpbd0i/xaFldNHH5uZzTQ
	LrJTWHAkAXu7HGJS8aHMn+zXxYB5SkRKRIvucpmc9FqStyi1kfyPT4E2QAhD6R3fVIDNQn28CU0gX
	LfmtruDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRWvZ-00000007TH0-2XWu;
	Tue, 17 Jun 2025 14:04:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRWbA-00000007Ogr-0Tjo
	for linux-nvme@lists.infradead.org;
	Tue, 17 Jun 2025 13:43:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AB37B4A37E;
	Tue, 17 Jun 2025 13:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0125DC4CEEE;
	Tue, 17 Jun 2025 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750167815;
	bh=vkcmDs7WGjxfLxosZoIsjGpUt+4BhL+w9Kzg93Ijs90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dEiCsE+erRluo9qPNFrTv/hsTg3Ka9jGx0gzfDA91T6m/I484aVd9RuVekzieGHSl
	 kNCn3K6/Q5bdiSj/NEzsdUTbAo/jdBVT+DsCD3doGvZtT9/P0Aq+0eEPMNQg1t28Wy
	 3d5p7yCaEaBGI2BVoqWgycxMufw3OYGfkubreNMfG/9i7aCB/+D8b1sdEWnpieAwMa
	 Cn3q1iCqf95J5AFFesQgOUIUdnykk8fP1xmZucH3+Lx3HYPZ8uJcOkgKxi9BbIy3jM
	 U3unwgDCdzL8P11zC7+wC4tS1wfdNwQBTGTOnlO+ZIe+w8SMJVBhhaYlPqoHY/IRMb
	 WJTyBAKzdKTSw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 17 Jun 2025 15:43:24 +0200
Subject: [PATCH 2/5] blk-mq: add number of queue calc helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-isolcpus-queue-counters-v1-2-13923686b54b@kernel.org>
References: <20250617-isolcpus-queue-counters-v1-0-13923686b54b@kernel.org>
In-Reply-To: <20250617-isolcpus-queue-counters-v1-0-13923686b54b@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
 storagedev@microchip.com, virtualization@lists.linux.dev, 
 GR-QLogic-Storage-Upstream@marvell.com, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_064336_198103_98BAA8A9 
X-CRM114-Status: GOOD (  14.30  )
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

Add two variants of helper functions that calculate the correct number
of queues to use. Two variants are needed because some drivers base
their maximum number of queues on the possible CPU mask, while others
use the online CPU mask.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-cpumap.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 269161252add756897fce1b65cae5b2e6aebd647..705da074ad6c7e88042296f21b739c6d686a72b6 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -12,10 +12,50 @@
 #include <linux/cpu.h>
 #include <linux/group_cpus.h>
 #include <linux/device/bus.h>
+#include <linux/sched/isolation.h>
 
 #include "blk.h"
 #include "blk-mq.h"
 
+static unsigned int blk_mq_num_queues(const struct cpumask *mask,
+				      unsigned int max_queues)
+{
+	unsigned int num;
+
+	num = cpumask_weight(mask);
+	return min_not_zero(num, max_queues);
+}
+
+/**
+ * blk_mq_num_possible_queues - Calc nr of queues for multiqueue devices
+ * @max_queues:	The maximum number of queues the hardware/driver
+ *		supports. If max_queues is 0, the argument is
+ *		ignored.
+ *
+ * Calculates the number of queues to be used for a multiqueue
+ * device based on the number of possible CPUs.
+ */
+unsigned int blk_mq_num_possible_queues(unsigned int max_queues)
+{
+	return blk_mq_num_queues(cpu_possible_mask, max_queues);
+}
+EXPORT_SYMBOL_GPL(blk_mq_num_possible_queues);
+
+/**
+ * blk_mq_num_online_queues - Calc nr of queues for multiqueue devices
+ * @max_queues:	The maximum number of queues the hardware/driver
+ *		supports. If max_queues is 0, the argument is
+ *		ignored.
+ *
+ * Calculates the number of queues to be used for a multiqueue
+ * device based on the number of online CPUs.
+ */
+unsigned int blk_mq_num_online_queues(unsigned int max_queues)
+{
+	return blk_mq_num_queues(cpu_online_mask, max_queues);
+}
+EXPORT_SYMBOL_GPL(blk_mq_num_online_queues);
+
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
 	const struct cpumask *masks;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index de8c85a03bb7f40501f449ae98919a5352f55db8..2a5a828f19a0ba6ff0812daf40eed67f0e12ada1 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -947,6 +947,8 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 void blk_mq_unfreeze_queue_non_owner(struct request_queue *q);
 void blk_freeze_queue_start_non_owner(struct request_queue *q);
 
+unsigned int blk_mq_num_possible_queues(unsigned int max_queues);
+unsigned int blk_mq_num_online_queues(unsigned int max_queues);
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
 			  struct device *dev, unsigned int offset);

-- 
2.49.0


