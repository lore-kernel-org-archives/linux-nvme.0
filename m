Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A09E77184
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2024 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0cZdGuPma+4JNVA2aWWoiClsz2Z8tDhniQcal79Mo4Q=; b=pmhfFbgHyFLaxKtwDVXY3A+qAV
	6/fhJLzlUtWAujl9q5OmOK8nqAfU1WvooiczseLjPUpSBDF028ahC0/v/YjKW52gzTkHQiSDTk2uy
	sGV011k3YD6dDLxfZidAOwP7sBFPaiNFEo0aj1YCg89EXCyUxPJWsNl0KRbigYaSMwLr7PEZkmjuj
	wt4OFFSgrbkom/aOm5xFiycOifwmoNCpgj4rYm+bY1bsPjhAp47FA51cSe7nh+k4X13VMBxJDtvtd
	H621cAg6apnvDKBYpr7A2IAljeOEmavWzb2tpFiJgUjcOOI+U/x2O/IBM1zEZiiMGLq0MpUJynQCv
	rOcjfusA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOItd-00000002EBR-4BGh;
	Thu, 19 Dec 2024 15:57:06 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNcKO-0000000EXpd-2zZ5
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 18:29:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2F1D0A41F44;
	Tue, 17 Dec 2024 18:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BE3C4CEDF;
	Tue, 17 Dec 2024 18:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734460191;
	bh=J8AQ9XfymIw2GabflSCTi0yfwCmZTc/3XvdEqwuuAXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lYcE5ER4WqHafND2JV2YcmsMXvebT7xabLiuYqWbNUv5yN4UICqQu62xU4mKGC8og
	 16QjYsmOFoy3qOB73Qskervz60t9UQE8Hij7bIulPxKtsUyWT1B+5kflUjghgMRnhx
	 qr9reApEvmjcZWP0qGaCry7raoaM+oZT/wDYaW/cccY9slC/ptFO5DZ+rIbOTvvdYX
	 9x5zTaSm6kdHbxP31bj/hLMZlMQwQNDObpjrDK0PTQNCWtHbwCwMVH4ms4Gvv96bGW
	 +ujZuNGrq4jOpo2XBn8/5Ez5t8PtiET+jXDzAIR8b8Ljw+B1iHREBQ0T2TTSEcuh3N
	 SL6/lwveSYqwg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 17 Dec 2024 19:29:37 +0100
Subject: [PATCH v4 3/9] blk-mq: add number of queue calc helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-isolcpus-io-queues-v4-3-5d355fbb1e14@kernel.org>
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
X-CRM114-CacheID: sfid-20241217_102952_898923_2AFF1011 
X-CRM114-Status: GOOD (  14.80  )
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

Multiqueue devices should only allocate queues for the housekeeping CPUs
when isolcpus=managed_irq is set. This avoids that the isolated CPUs get
disturbed with OS workload.

Add two variants of helpers which calculates the correct number of
queues which should be used. The need for two variants is necessary
because some drivers calculate their max number of queues based on the
possible CPU mask, others based on the online CPU mask.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-cpumap.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 85c0a7073bd8bff5d34aad1729d45d89da4c4bd1..b3a863c2db3231624685ab54a1810b22af4111f4 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -12,10 +12,55 @@
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
+	if (housekeeping_enabled(HK_TYPE_MANAGED_IRQ))
+		mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
+
+	num = cpumask_weight(mask);
+	return min_not_zero(num, max_queues);
+}
+
+/**
+ * blk_mq_num_possible_queues - Calc nr of queues for multiqueue devices
+ * @max_queues:	The maximal number of queues the hardware/driver
+ *		supports. If max_queues is 0, the argument is
+ *		ignored.
+ *
+ * Calculate the number of queues which should be used for a multiqueue
+ * device based on the number of possible cpu. The helper is considering
+ * isolcpus settings.
+ */
+unsigned int blk_mq_num_possible_queues(unsigned int max_queues)
+{
+	return blk_mq_num_queues(cpu_possible_mask, max_queues);
+}
+EXPORT_SYMBOL_GPL(blk_mq_num_possible_queues);
+
+/**
+ * blk_mq_num_online_queues - Calc nr of queues for multiqueue devices
+ * @max_queues:	The maximal number of queues the hardware/driver
+ *		supports. If max_queues is 0, the argument is
+ *		ignored.
+ *
+ * Calculate the number of queues which should be used for a multiqueue
+ * device based on the number of online cpus. The helper is considering
+ * isolcpus settings.
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
index 769eab6247d4921e574e0828ab41a580a5a9f2fe..4f0f2ea64de2057750e88c2a3ff7d49e13a7bfc5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -920,6 +920,8 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 void blk_mq_unfreeze_queue_non_owner(struct request_queue *q);
 void blk_freeze_queue_start_non_owner(struct request_queue *q);
 
+unsigned int blk_mq_num_possible_queues(unsigned int max_queues);
+unsigned int blk_mq_num_online_queues(unsigned int max_queues);
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
 			  struct device *dev, unsigned int offset);

-- 
2.47.1


