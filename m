Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782D8D3ABDE
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 18:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CA7WtqQgB4RCrE7TTPqW/vU8qNFYI+z9E5zVKwn8eAc=; b=kfrRh7pMjOUajowosVb5dAm9IQ
	6/u2GKJSQQsdLyp91PtA27cBqqtaAiO3Z8l/9WtG1ToziizWggIcTluunkarq8XulosL4EYbsFUCi
	H7EQuuFd4d8gUDfmYEuGucbIr9ppZYSdTgfZCignw+Olvf2FPPQ+arSXZCX2lmZdQB/XSnICvg/zR
	TXH4IqqJNh16Ed3FvUyLpOLaKIkXaM8mwl0dHovPqOMI5FOgbt0crvDAOsZSAl5/F0SmUUwTmRp55
	1q6JCxn6JPrWlakkcNQj2vy0VA4Hy5iVRp5FzLwawoac1+BI96m9tTxAWARPTKEu0jSDo2N2OxmmI
	iDQhSXcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYoa-00000000po8-2Aa5;
	Mon, 11 Nov 2024 18:07:04 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYkO-00000000ofV-3RLp
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 18:02:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B85B3A417FE;
	Mon, 11 Nov 2024 18:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF57C4CED5;
	Mon, 11 Nov 2024 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731348163;
	bh=9sP0iy9vNDvvulLRRTbPROgoFCL1cPRRjbHOX7L9p84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O7VWKUmMXeZ7nUGRFniku/BXyk9vT5a5ksJLICMRhzu+Ax8h1/0Hoe0HqByE8WOwd
	 Mhw0T222KrPnK9Y7LRPxx7qJb6/rOQ9/htYyPHhzHQjN08N81opjfFjRQdvbSA4ZsD
	 pVnSE92OLZMGXaAUj/PWObivcIGmlV+ddC7H/krnQk8/lNkN6V9NTTTTyYPu2K8NFb
	 uOQ/WpJPyJqGSLuZMp9XH3Kw1CvbncOQp5agInR7Bn/1MEr+ozad2C6tZCe+KsyV/y
	 yfd0hGKKh0asKLmrSVJW7EDkTitfMdNf8b/vYTlRnjCDZBq5rYByqoe4pFj2p7+YFI
	 xxHSqhkjFf4HQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 11 Nov 2024 19:02:11 +0100
Subject: [PATCH v2 3/6] scsi: hisi_sas: replace blk_mq_pci_map_queues with
 blk_mq_hctx_map_queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-refactor-blk-affinity-helpers-v2-3-f360ddad231a@kernel.org>
References: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org>
In-Reply-To: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_100245_034574_33390C61 
X-CRM114-Status: GOOD (  15.85  )
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

From: Daniel Wagner <dwagner@suse.de>

Replace all users of blk_mq_pci_map_queues with the more generic
blk_mq_hctx_map_queues. This in preparation to retire
blk_mq_pci_map_queues.

For his_sas_v2_hw.c needs its own callback for retrieving the affinity.
The generic bus_type get queue affinity callback is using
pci_irq_get_affinity and not irq_data_get_affinity_mask.

This allows it to replace the open code loop with
blk_mq_hctx_map_queues at least.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  1 -
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 22 +++++++++++-----------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  4 ++--
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index d223f482488fc6cebc2838e92ae7ec70fb4e1437..010479a354eeeb47bbee24102e450aa3b7ea6197 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -9,7 +9,6 @@
 
 #include <linux/acpi.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/dmapool.h>
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 342d75f12051d28fb1a0692b45ff568dd5b6f814..fd2f63e64376d1a444efe511a3aaa0988d9747f2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3372,7 +3372,7 @@ static int interrupt_init_v2_hw(struct hisi_hba *hisi_hba)
 	for (queue_no = 0; queue_no < hisi_hba->cq_nvecs; queue_no++) {
 		struct hisi_sas_cq *cq = &hisi_hba->cq[queue_no];
 
-		cq->irq_no = hisi_hba->irq_map[queue_no + 96];
+		cq->irq_no = hisi_hba->irq_map[queue_no + CQ0_IRQ_INDEX];
 		rc = devm_request_threaded_irq(dev, cq->irq_no,
 					       cq_interrupt_v2_hw,
 					       cq_thread_v2_hw, IRQF_ONESHOT,
@@ -3549,21 +3549,21 @@ static const struct attribute_group *sdev_groups_v2_hw[] = {
 	NULL
 };
 
+static const struct cpumask *hisi_hba_get_queue_affinity(struct device *dev,
+							 unsigned int queue)
+{
+	struct hisi_hba *hba = dev->driver_data;
+
+	return irq_get_affinity_mask(hba->irq_map[queue]);
+}
+
 static void map_queues_v2_hw(struct Scsi_Host *shost)
 {
 	struct hisi_hba *hisi_hba = shost_priv(shost);
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
-	const struct cpumask *mask;
-	unsigned int queue, cpu;
 
-	for (queue = 0; queue < qmap->nr_queues; queue++) {
-		mask = irq_get_affinity_mask(hisi_hba->irq_map[96 + queue]);
-		if (!mask)
-			continue;
-
-		for_each_cpu(cpu, mask)
-			qmap->mq_map[cpu] = qmap->queue_offset + queue;
-	}
+	blk_mq_hctx_map_queues(qmap, hisi_hba->dev, CQ0_IRQ_INDEX,
+			       hisi_hba_get_queue_affinity);
 }
 
 static const struct scsi_host_template sht_v2_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 4cd3a3eab6f1c47c962565a74cd7284dad1db12e..031db7b744e6352eb23d0dcac2c4a947c56f63d1 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3322,8 +3322,8 @@ static void hisi_sas_map_queues(struct Scsi_Host *shost)
 		if (i == HCTX_TYPE_POLL)
 			blk_mq_map_queues(qmap);
 		else
-			blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
-					      BASE_VECTORS_V3_HW);
+			blk_mq_hctx_map_queues(qmap, &hisi_hba->pci_dev->dev,
+					       BASE_VECTORS_V3_HW, NULL);
 		qoff += qmap->nr_queues;
 	}
 }

-- 
2.47.0


