Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204C3C52D70
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 14:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=36nC1tJdzP6+GYlju6N0sffMCcAgT9UKOFYY1rUGz2E=; b=oQ16LVvTbrtOys2XVwFCoiaFoU
	nXBDUd/jxowUI6y+GdQRe6FrR5/CufoiDW2fyMo2MBAR1WHctHHQuiBE82RGeq2Dozeldcd3vouqI
	qh44OXumr7eZ4U85MzRqNSZKPxbPTL884Xl9oSXHROofl/9SRXJDwEOt6PRNN6j77xS6NGeLMNnnJ
	9hSN1tsXMe7HIbgDH5zc3OygFsiDbKIF8RTlrK9wGDbJ5RB9Nejj3b+Vyx+CZ2MSGYi+2XBqbASSL
	aO1icXt8h1Bv9kx7WKNIRWaOzkXXq/6Q3XVeQ8Uoamsy79SduV5Sp/FtavbX+tgRzQ4S9PeWn/dxS
	8Z+ve1tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbLXl-000000023Hu-2GUn;
	Tue, 06 Aug 2024 14:52:09 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIyV-00000001R4o-0F88
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 12:07:36 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF951DAE1F;
	Tue,  6 Aug 2024 14:07:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1722946053; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=36nC1tJdzP6+GYlju6N0sffMCcAgT9UKOFYY1rUGz2E=;
	b=kLEV4NcaLu+42mjnHzlW5bUaHbHANVJh4avtRkvlXG72tKiz5G214AwEiioNKGy/Hm1/6d
	hgx7dnhy/9RBMNNxhxgfG8oAs3eba2YvI+jcSiF5JSDu5uZwUhzYYydMs8reRdyuRc1I/p
	2evUnio4SgDaCDZ5hIsMjCqRfkeegwJTZ7HlxR+Bco+7BzZ1qpXiItRzkivnnbq1N1613n
	9ewedKY+cSM2esbnzWhRCRELnbP1wa9p3Ac+bWHdx2niQuMKVJDaZX4/wua+1fhu00dK2O
	gzi7eiSL1sr4OyPyxDs1a5V4QfGyBmd2VnXRGI8h8mTIFvQZplY3gq64dadotA==
From: Daniel Wagner <dwagner@suse.de>
Date: Tue, 06 Aug 2024 14:06:42 +0200
Subject: [PATCH v3 10/15] blk-mq: add number of queue calc helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-isolcpus-io-queues-v3-10-da0eecfeaf8b@suse.de>
References: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
In-Reply-To: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
 Christoph Hellwig <hch@lst.de>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 John Garry <john.g.garry@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Kashyap Desai <kashyap.desai@broadcom.com>, 
 Sumit Saxena <sumit.saxena@broadcom.com>, 
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, 
 Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, 
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, 
 Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, 
 Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
 virtualization@lists.linux.dev, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-doc@vger.kernel.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_050735_424401_34D293A1 
X-CRM114-Status: GOOD (  13.33  )
X-Mailman-Approved-At: Tue, 06 Aug 2024 07:51:53 -0700
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
when isolcpus=io_queue is set. This avoids that the isolated CPUs get
disturbed with OS workload.

Add two variants of helpers which calculates the correct number of
queues which should be used. The need for two variants is necessary
because some drivers calculate their max number of queues based on the
possible CPU mask, others based on the online CPU mask.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 block/blk-mq-cpumap.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 7037a2dc485f..c1277763aeeb 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -11,10 +11,55 @@
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/group_cpus.h>
+#include <linux/sched/isolation.h>
 
 #include "blk.h"
 #include "blk-mq.h"
 
+static unsigned int blk_mq_num_queues(const struct cpumask *mask,
+				      unsigned int max_queues)
+{
+	unsigned int num;
+
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
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
index cfc96d6a3136..bcd5ef712af7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -931,6 +931,8 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 
 typedef const struct cpumask *(get_queue_affinty_fn)(void *dev_data,
 					      int dev_off, int queue_idx);
+unsigned int blk_mq_num_possible_queues(unsigned int max_queues);
+unsigned int blk_mq_num_online_queues(unsigned int max_queues);
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_dev_map_queues(struct blk_mq_queue_map *qmap,
 			   void *dev_data, int dev_off,

-- 
2.46.0


