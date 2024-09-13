Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CFDFA3723
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 07:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UPyA4EoVaPPB8Jix49sllO4oSal2U9oXOp5QNqpeuog=; b=syA0dkWMpEp9vp7RARCf/fcuuo
	2fGJGXUeSGEhEhBshFDTszpsuh+Hiio6LAUZHT5Jf2cKAhKE5AH5pjZBd3QBEZv0vvZ38PNPcLUTq
	tMkny33IzLYaiuetybvENmKa9pi7shpxXGH5cQI3VqaG2I0RbdkmUUdCZg9ExkO4LbgRtyg1+E4UD
	2QLKBJUqlifmtVIjptLzMt8Qb2nbcLWS1JEDvtnrgc/vZzx2QlTtvIvNeTIO8j2+jk33Hvj381G+U
	mTC1hm8nisM33JOj6tbj9sbfLgVQVwXeNHpoeAZiKyOn5iP/NAZeKDqEyFcAk+XgZ0J60FgyxkPZO
	wg6Kbnaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp0x0-0000000FBbD-0gts;
	Fri, 13 Sep 2024 07:42:42 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp0ws-0000000FBVK-2och
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 07:42:37 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A358EDAD3A;
	Fri, 13 Sep 2024 09:42:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1726213348; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UPyA4EoVaPPB8Jix49sllO4oSal2U9oXOp5QNqpeuog=;
	b=nEqf9XgXM85QFSQxGdVactBNCG2S7wIvdpCILOsniyW4nVpwYIRrTcxrMvts35aTZ1jTTL
	Yocb0It4hQbZt5N7UYWBBf3h/EkZQcf3v/hU1rD/j06GKUv8u1VNWehhZnxdiSC+bZRAar
	j4mIU3FRdc+TdMXpduBj2XFV1QCvEG+pVuQWkLazJbUkmvfrcSJ5Sr0kyPdir3ItBXFrLF
	7TbvpKOpQ988y8zEDuGfpqopnOZC2mrBlkLxL1na9YDRnjHK9GwFcEPyl4pXH6t9i7RRf+
	/85n954cC9slWL3cyeYVCctEF7vJizZwZkJug/tGKaUBbBeVuoBuP3PRrFaXWQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 13 Sep 2024 09:42:00 +0200
Subject: [PATCH 2/6] scsi: replace blk_mq_pci_map_queues with
 blk_mq_hctx_map_queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-refactor-blk-affinity-helpers-v1-2-8e058f77af12@suse.de>
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
X-CRM114-CacheID: sfid-20240913_004235_086413_3265313A 
X-CRM114-Status: GOOD (  13.31  )
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

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/fnic/fnic_main.c             | 4 ++--
 drivers/scsi/megaraid/megaraid_sas_base.c | 4 ++--
 drivers/scsi/mpi3mr/mpi3mr.h              | 1 -
 drivers/scsi/mpi3mr/mpi3mr_os.c           | 3 ++-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      | 4 ++--
 drivers/scsi/pm8001/pm8001_init.c         | 3 ++-
 drivers/scsi/pm8001/pm8001_sas.h          | 1 -
 drivers/scsi/qla2xxx/qla_nvme.c           | 4 ++--
 drivers/scsi/qla2xxx/qla_os.c             | 4 ++--
 drivers/scsi/smartpqi/smartpqi_init.c     | 8 ++++----
 10 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 29eead383eb9..77ad1971351e 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -16,7 +16,6 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <linux/if_ether.h>
-#include <linux/blk-mq-pci.h>
 #include <scsi/fc/fc_fip.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_transport.h>
@@ -601,7 +600,8 @@ void fnic_mq_map_queues_cpus(struct Scsi_Host *host)
 		return;
 	}
 
-	blk_mq_pci_map_queues(qmap, l_pdev, FNIC_PCI_OFFSET);
+	blk_mq_hctx_map_queues(qmap, l_pdev, FNIC_PCI_OFFSET,
+			       pci_get_blk_mq_affinity);
 }
 
 static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 6c79c350a4d5..597bf8476bbc 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -37,7 +37,6 @@
 #include <linux/poll.h>
 #include <linux/vmalloc.h>
 #include <linux/irq_poll.h>
-#include <linux/blk-mq-pci.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -3193,7 +3192,8 @@ static void megasas_map_queues(struct Scsi_Host *shost)
 	map = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 	map->nr_queues = instance->msix_vectors - offset;
 	map->queue_offset = 0;
-	blk_mq_pci_map_queues(map, instance->pdev, offset);
+	blk_mq_hctx_map_queues(map, instance->pdev, offset,
+			       pci_get_blk_mq_affinity);
 	qoff += map->nr_queues;
 	offset += map->nr_queues;
 
diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index dc2cdd5f0311..8e502e34e18b 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -12,7 +12,6 @@
 
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/delay.h>
 #include <linux/dmapool.h>
 #include <linux/errno.h>
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 69b14918de59..1002c19aa2d1 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -4031,7 +4031,8 @@ static void mpi3mr_map_queues(struct Scsi_Host *shost)
 		 */
 		map->queue_offset = qoff;
 		if (i != HCTX_TYPE_POLL)
-			blk_mq_pci_map_queues(map, mrioc->pdev, offset);
+			blk_mq_hctx_map_queues(map, mrioc->pdev, offset,
+					       pci_get_blk_mq_affinity);
 		else
 			blk_mq_map_queues(map);
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 97c2472cd434..162d3da5d8d0 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -53,7 +53,6 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/raid_class.h>
-#include <linux/blk-mq-pci.h>
 #include <asm/unaligned.h>
 
 #include "mpt3sas_base.h"
@@ -11890,7 +11889,8 @@ static void scsih_map_queues(struct Scsi_Host *shost)
 		 */
 		map->queue_offset = qoff;
 		if (i != HCTX_TYPE_POLL)
-			blk_mq_pci_map_queues(map, ioc->pdev, offset);
+			blk_mq_hctx_map_queues(map, ioc->pdev, offset,
+					      pci_get_blk_mq_affinity);
 		else
 			blk_mq_map_queues(map);
 
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 33e1eba62ca1..47a0917fb2a0 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -101,7 +101,8 @@ static void pm8001_map_queues(struct Scsi_Host *shost)
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 
 	if (pm8001_ha->number_of_intr > 1) {
-		blk_mq_pci_map_queues(qmap, pm8001_ha->pdev, 1);
+		blk_mq_hctx_map_queues(qmap, pm8001_ha->pdev, 1,
+				       pci_get_blk_mq_affinity);
 		return;
 	}
 
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index ced6721380a8..c46470e0cf63 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -56,7 +56,6 @@
 #include <scsi/sas_ata.h>
 #include <linux/atomic.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-pci.h>
 #include "pm8001_defs.h"
 
 #define DRV_NAME		"pm80xx"
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 8f4cc136a9c9..ea1ef2fae7dd 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -8,7 +8,6 @@
 #include <linux/delay.h>
 #include <linux/nvme.h>
 #include <linux/nvme-fc.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/blk-mq.h>
 
 static struct nvme_fc_port_template qla_nvme_fc_transport;
@@ -841,7 +840,8 @@ static void qla_nvme_map_queues(struct nvme_fc_local_port *lport,
 {
 	struct scsi_qla_host *vha = lport->private;
 
-	blk_mq_pci_map_queues(map, vha->hw->pdev, vha->irq_offset);
+	blk_mq_hctx_map_queues(map, vha->hw->pdev, vha->irq_offset,
+			      pci_get_blk_mq_affinity);
 }
 
 static void qla_nvme_localport_delete(struct nvme_fc_local_port *lport)
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index bc3b2aea3f8b..521ae591898d 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -13,7 +13,6 @@
 #include <linux/mutex.h>
 #include <linux/kobject.h>
 #include <linux/slab.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/refcount.h>
 #include <linux/crash_dump.h>
 #include <linux/trace_events.h>
@@ -8068,7 +8067,8 @@ static void qla2xxx_map_queues(struct Scsi_Host *shost)
 	if (USER_CTRL_IRQ(vha->hw) || !vha->hw->mqiobase)
 		blk_mq_map_queues(qmap);
 	else
-		blk_mq_pci_map_queues(qmap, vha->hw->pdev, vha->irq_offset);
+		blk_mq_hctx_map_queues(qmap, vha->hw->pdev, vha->irq_offset,
+				       pci_get_blk_mq_affinity);
 }
 
 struct scsi_host_template qla2xxx_driver_template = {
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 24c7cb285dca..9f8c2e16d55b 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -19,7 +19,6 @@
 #include <linux/bcd.h>
 #include <linux/reboot.h>
 #include <linux/cciss_ioctl.h>
-#include <linux/blk-mq-pci.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
@@ -6533,10 +6532,11 @@ static void pqi_map_queues(struct Scsi_Host *shost)
 	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
 
 	if (!ctrl_info->disable_managed_interrupts)
-		return blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
-			      ctrl_info->pci_dev, 0);
+		blk_mq_hctx_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
+				       ctrl_info->pci_dev, 0,
+				       pci_get_blk_mq_affinity);
 	else
-		return blk_mq_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT]);
+		blk_mq_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT]);
 }
 
 static inline bool pqi_is_tape_changer_device(struct pqi_scsi_dev *device)

-- 
2.46.0


