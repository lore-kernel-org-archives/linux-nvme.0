Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3195FC2BBCA
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jun 2024 13:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9vgTbawfVJRZg+Tr2xuaEIBsOwHDrviZ04LuIhBEo38=; b=RaEtYX6t+5XJyI0oc58nZAlRgr
	QeJ9h+bJQBX7lKH8x0hAcTjHxeK4kcX+QQAn8MCEp2mwgJlZ5AS8Aa6QwMIkqJWJ1aggTcO7kDtdO
	lVyx/GhvnIscAf+KCg9IpfE/bKqTWWAt5c+gPOMhcCblwSf5FwAv0GfuoUHUO2MlDp0Yllh6xgkGr
	275mHVBjEfbgK3IsiUst8TekI729OqLST3MqFEC4DPnZu9A/UJDclyLfrjlBYaEUS30Yuf9EOsTLS
	/7dO0D+QTPRHU3kjeNnpFJu0dI0OeMB3K3BbAOovqbLeT+jArqsCZXqMouMeCWIylcC2Dmpc4zgQR
	9wd1xsEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKehr-00000009PBh-2lKv;
	Fri, 21 Jun 2024 13:53:35 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKehn-00000009P9Z-2vfN
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jun 2024 13:53:33 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9AFCADAD7F;
	Fri, 21 Jun 2024 15:53:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1718978000; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9vgTbawfVJRZg+Tr2xuaEIBsOwHDrviZ04LuIhBEo38=;
	b=izHBjOV9qzNUrHn1QTXCahMG2sZ+67sCro2anSHBwsVzasus1sp9ttWaDvtQkaXk9uausg
	ZcPb/oM89pXp2lP16ZOcHV6Hz3+QJY9QU2EssjEHZi/VAsI89J8Sv5VeQFVvPrRqs/GrmW
	bNI0tGVRfQlTQSM+nwro96/1P+jlJeNmATvdb1DKOCQ8/kHlznUiot5VDFN8l0MCbu+18Q
	yB2F+ZuEma1OX40J341Mlcwdyb6tazyuePY6JQP6wvkx4n1u6OeJ6xq7brgkUWHdqZkHpv
	xiSyalgXZsKST/RPYtFSuXYQx5Ho91JBz4kMBlnvvgtEqJrlrbcfH5NcblpQ8w==
From: Daniel Wagner <dwagner@suse.de>
Date: Fri, 21 Jun 2024 15:53:11 +0200
Subject: [PATCH 2/3] nvme-pci: limit queue count to housekeeping cpus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-isolcpus-io-queues-v1-2-8b169bf41083@suse.de>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
In-Reply-To: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
 Christoph Hellwig <hch@lst.de>
Cc: Frederic Weisbecker <fweisbecker@suse.com>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.13.0
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240621_065331_922165_6D055E7C 
X-CRM114-Status: GOOD (  14.89  )
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

The nvme-pci driver is ignoring the isolcpus and allocates IO queues for
all possible CPUs. But this could add noise to the isolated CPU whenever
there is IO issued on the isolated CPU. This is not always what the user
wants. Thus only ask for as many queues as there are housekeeping CPUs.

Note, the placement of the queues will be addressed in the next patch.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 block/blk-mq-cpumap.c   | 13 +++++++++++++
 drivers/nvme/host/pci.c |  4 ++--
 include/linux/blk-mq.h  |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9638b25fd521..43c039900ef6 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -11,10 +11,23 @@
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/group_cpus.h>
+#include <linux/sched/isolation.h>
 
 #include "blk.h"
 #include "blk-mq.h"
 
+unsigned int blk_mq_num_possible_queues(void)
+{
+	const struct cpumask *io_queue_mask;
+
+	io_queue_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+	if (!cpumask_empty(io_queue_mask))
+		return cpumask_weight(io_queue_mask);
+
+	return num_possible_cpus();
+}
+EXPORT_SYMBOL_GPL(blk_mq_num_possible_queues);
+
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
 	const struct cpumask *masks;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 102a9fb0c65f..66999fa13b2c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -81,7 +81,7 @@ static int io_queue_count_set(const char *val, const struct kernel_param *kp)
 	int ret;
 
 	ret = kstrtouint(val, 10, &n);
-	if (ret != 0 || n > num_possible_cpus())
+	if (ret != 0 || n > blk_mq_num_possible_queues())
 		return -EINVAL;
 	return param_set_uint(val, kp);
 }
@@ -2263,7 +2263,7 @@ static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
 	 */
 	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
 		return 1;
-	return num_possible_cpus() + dev->nr_write_queues + dev->nr_poll_queues;
+	return blk_mq_num_possible_queues() + dev->nr_write_queues + dev->nr_poll_queues;
 }
 
 static int nvme_setup_io_queues(struct nvme_dev *dev)
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


