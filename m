Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637C7EEE245
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 07:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9V9G9cxrOOEkGUdXRgOzaYirsOTG9LGiI/ZiAMHLcsg=; b=WcMEG5wboQVHvRkjzZztQXzc1H
	sJqTxJHy9OpipEo9VGHOhYcRBGNyd9gaswZiizVsnQw+Sni5Jn9cvg65RaTtGW7WWfKh8wawosCN2
	blXQX1QO5/MxygSNxlgt02/nrJLJOJmrmu+dwOAxGL0IFXBRufSKSfvlxcTkigu8nU2t494PlgmG6
	9GsrSiSCQajvOFculyy1S7ysWimt3yKfUmvCM5JuQqdeHwbaUQIFty5Oy66O+O2dPmMok3P5FBir8
	sJ0WQDnI1dM6AkC4WT4AtNO+wuagMPBQE60rmqx6EO0dlkov4N42IsEwK/n1/nF1w6mxUhbnl96Ob
	nanS4CVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp0wv-0000000FBX7-1Y4f;
	Fri, 13 Sep 2024 07:42:37 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp0ws-0000000FBVP-0Svz
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 07:42:35 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1671CDAD3B;
	Fri, 13 Sep 2024 09:42:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1726213349; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9V9G9cxrOOEkGUdXRgOzaYirsOTG9LGiI/ZiAMHLcsg=;
	b=GtNmrCT3JVxTm5uisu6PWrFFuC5S9xH3VL7t1a66IoOTconyAy9A9cMAZSMC4nG1w66Q4X
	JBkeJ20XSr94kIpQGZn6vKbefzjUsqqXQF7Vm/VDfpSqy5WPPtmDeMFSCjrM2fI6Er+k1Y
	I5CNE8KHSpSBmFesuQMFEebyqR4MCSVHAlByrBc6ih7jIykW//fFInoge/Hm2awP4ld8pZ
	LlZAOK9Z+ygNknB1qyo2Qli463KIOQmIm7i0QS6e1uJyUtCEP6kG2jGtDZEbx4QM19sXp7
	zLJYPY8tdC1mvPVyxAahlU+yb59qplxVYTtSvffEzHaOR0YsVcFokyxAp0odXQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 13 Sep 2024 09:42:01 +0200
Subject: [PATCH 3/6] scsi: hisi_sas: replace blk_mq_pci_map_queues with
 blk_mq_hctx_map_queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-refactor-blk-affinity-helpers-v1-3-8e058f77af12@suse.de>
References: <20240913-refactor-blk-affinity-helpers-v1-0-8e058f77af12@suse.de>
In-Reply-To: <20240913-refactor-blk-affinity-helpers-v1-0-8e058f77af12@suse.de>
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
 Daniel Wagner <dwagner@suse.de>, 
 20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_004234_414285_B3FFE807 
X-CRM114-Status: GOOD (  14.32  )
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

For his_sas_v2_hw.c we have to provide its own callback for retrieving
the affinity because pci_get_blk_mq_affinity is using
pci_irq_get_affinity and not irq_data_get_affinity_mask.

But at least we can replace the open code loop with
blk_mq_hctx_map_queues.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  1 -
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 20 ++++++++++----------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  5 +++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index d223f482488f..010479a354ee 100644
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
index 342d75f12051..31be34f23164 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3549,21 +3549,21 @@ static const struct attribute_group *sdev_groups_v2_hw[] = {
 	NULL
 };
 
+static const struct cpumask *hisi_hba_get_queue_affinity(void *dev_data,
+							 int offset, int queue)
+{
+	struct hisi_hba *hba = dev_data;
+
+	return irq_get_affinity_mask(hba->irq_map[offset + queue]);
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
+	blk_mq_hctx_map_queues(qmap, hisi_hba, CQ0_IRQ_INDEX,
+			       hisi_hba_get_queue_affinity);
 }
 
 static const struct scsi_host_template sht_v2_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index feda9b54b443..1576eee943ba 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3322,8 +3322,9 @@ static void hisi_sas_map_queues(struct Scsi_Host *shost)
 		if (i == HCTX_TYPE_POLL)
 			blk_mq_map_queues(qmap);
 		else
-			blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
-					      BASE_VECTORS_V3_HW);
+			blk_mq_hctx_map_queues(qmap, hisi_hba->pci_dev,
+					       BASE_VECTORS_V3_HW,
+					       pci_get_blk_mq_affinity);
 		qoff += qmap->nr_queues;
 	}
 }

-- 
2.46.0


