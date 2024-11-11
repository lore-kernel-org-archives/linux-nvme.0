Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CED1D3ABDC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 18:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nRYT0duFz5niTmKEgd60WQ1X1Q91jAgRT0FeHmn8Ipc=; b=vgs4PfAaHyKTq4UUcoU6uLk+1k
	ged0mzfrJzhxv6SKGmmlo1KIGTeF0U73RNnU/1NW8SsxEZBsFoDc5TPDR76YX/t5JlohrJ9dYUwuT
	AiOm8ppCvDjV3s2eqimxHhHT5jvkF/Adxv03kL2rwv6FLSvhf5opSxFTKvjZqp1kKk7WsgakIGJzu
	BDKVmg2HbZkOBeKmp1I9yUUF5TiN4S33W35OCQWBdrVERv7utalnxj1ZrFn6Q0JqgApx30kiJTXEN
	O+3SLc2Q4//r8w14fpDCtGLp4ZpS9PQecgzQm3776KW0d38GmL372ENXMSJW4BP1ULqOi4G5zaSLy
	+c8AJ6OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYof-00000000prf-0UZ7;
	Mon, 11 Nov 2024 18:07:09 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYkW-00000000oit-2ilf
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 18:02:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6C8F5A41802;
	Mon, 11 Nov 2024 18:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B31C4CECF;
	Mon, 11 Nov 2024 18:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731348171;
	bh=proCbUkTdFmH0IZ/EmgCIAZUp0dOvtqdeSuQWiYy3tQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LL2iDez358oJOVu5/TGTsf5lTvLB1Sl8lm+P6KhNY/OrPiM++/gss6SEB6/VOgWtv
	 quPX351BC+j4tcs+0hNumqgf6PP6uAXGlvOuYRXHmaRHfLPHwkgeG/1LcR3P6oz89s
	 Gq2A/MqMb8BYjpbu623PFEkR5+I+ZXjcyMVPNY7zTyAoaTxxQyBSOC7Jlni25wzwO3
	 PpsgkDV2qDx0XAnd9xFJc5LVYLRcB7GNiMV8v8Rn9B2tlMOpgT4HeeTmOyAFqZBMiJ
	 YMTZubqutD4hOJm+7uFWSWjPrhsnlAUD2tFtja9jUM1o7vsgXRlSXc0+TrB4Zu/6VS
	 sbaA0CVe49+pQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 11 Nov 2024 19:02:14 +0100
Subject: [PATCH v2 6/6] blk-mq: remove unused queue mapping helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-refactor-blk-affinity-helpers-v2-6-f360ddad231a@kernel.org>
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
X-CRM114-CacheID: sfid-20241111_100252_852959_85E4F4A3 
X-CRM114-Status: GOOD (  14.16  )
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

There are no users left of the pci and virtio queue mapping helpers.
Thus remove them.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/Makefile                |  2 --
 block/blk-mq-pci.c            | 46 -------------------------------------------
 block/blk-mq-virtio.c         | 46 -------------------------------------------
 include/linux/blk-mq-pci.h    | 11 -----------
 include/linux/blk-mq-virtio.h | 11 -----------
 5 files changed, 116 deletions(-)

diff --git a/block/Makefile b/block/Makefile
index ddfd21c1a9ffc9c4f49efca9875bd8a1cbf81e4d..33748123710b368a1a3a7b099bbd90d27b24c69b 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -27,8 +27,6 @@ bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
 obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
 
 obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o
-obj-$(CONFIG_BLK_MQ_PCI)	+= blk-mq-pci.o
-obj-$(CONFIG_BLK_MQ_VIRTIO)	+= blk-mq-virtio.o
 obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
 obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
 obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
deleted file mode 100644
index d47b5c73c9eb715be7627a2952ad0ef921dd5bc6..0000000000000000000000000000000000000000
--- a/block/blk-mq-pci.c
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2016 Christoph Hellwig.
- */
-#include <linux/kobject.h>
-#include <linux/blkdev.h>
-#include <linux/blk-mq-pci.h>
-#include <linux/pci.h>
-#include <linux/module.h>
-
-#include "blk-mq.h"
-
-/**
- * blk_mq_pci_map_queues - provide a default queue mapping for PCI device
- * @qmap:	CPU to hardware queue map.
- * @pdev:	PCI device associated with @set.
- * @offset:	Offset to use for the pci irq vector
- *
- * This function assumes the PCI device @pdev has at least as many available
- * interrupt vectors as @set has queues.  It will then query the vector
- * corresponding to each queue for it's affinity mask and built queue mapping
- * that maps a queue to the CPUs that have irq affinity for the corresponding
- * vector.
- */
-void blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev *pdev,
-			   int offset)
-{
-	const struct cpumask *mask;
-	unsigned int queue, cpu;
-
-	for (queue = 0; queue < qmap->nr_queues; queue++) {
-		mask = pci_irq_get_affinity(pdev, queue + offset);
-		if (!mask)
-			goto fallback;
-
-		for_each_cpu(cpu, mask)
-			qmap->mq_map[cpu] = qmap->queue_offset + queue;
-	}
-
-	return;
-
-fallback:
-	WARN_ON_ONCE(qmap->nr_queues > 1);
-	blk_mq_clear_mq_map(qmap);
-}
-EXPORT_SYMBOL_GPL(blk_mq_pci_map_queues);
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
deleted file mode 100644
index 68d0945c0b08a2be116125f46c3a56fcdb02aea8..0000000000000000000000000000000000000000
--- a/block/blk-mq-virtio.c
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2016 Christoph Hellwig.
- */
-#include <linux/device.h>
-#include <linux/blk-mq-virtio.h>
-#include <linux/virtio_config.h>
-#include <linux/module.h>
-#include "blk-mq.h"
-
-/**
- * blk_mq_virtio_map_queues - provide a default queue mapping for virtio device
- * @qmap:	CPU to hardware queue map.
- * @vdev:	virtio device to provide a mapping for.
- * @first_vec:	first interrupt vectors to use for queues (usually 0)
- *
- * This function assumes the virtio device @vdev has at least as many available
- * interrupt vectors as @set has queues.  It will then query the vector
- * corresponding to each queue for it's affinity mask and built queue mapping
- * that maps a queue to the CPUs that have irq affinity for the corresponding
- * vector.
- */
-void blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
-		struct virtio_device *vdev, int first_vec)
-{
-	const struct cpumask *mask;
-	unsigned int queue, cpu;
-
-	if (!vdev->config->get_vq_affinity)
-		goto fallback;
-
-	for (queue = 0; queue < qmap->nr_queues; queue++) {
-		mask = vdev->config->get_vq_affinity(vdev, first_vec + queue);
-		if (!mask)
-			goto fallback;
-
-		for_each_cpu(cpu, mask)
-			qmap->mq_map[cpu] = qmap->queue_offset + queue;
-	}
-
-	return;
-
-fallback:
-	blk_mq_map_queues(qmap);
-}
-EXPORT_SYMBOL_GPL(blk_mq_virtio_map_queues);
diff --git a/include/linux/blk-mq-pci.h b/include/linux/blk-mq-pci.h
deleted file mode 100644
index ca544e1d3508f34ab6e198b0bb17efe88de4d14d..0000000000000000000000000000000000000000
--- a/include/linux/blk-mq-pci.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_BLK_MQ_PCI_H
-#define _LINUX_BLK_MQ_PCI_H
-
-struct blk_mq_queue_map;
-struct pci_dev;
-
-void blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev *pdev,
-			   int offset);
-
-#endif /* _LINUX_BLK_MQ_PCI_H */
diff --git a/include/linux/blk-mq-virtio.h b/include/linux/blk-mq-virtio.h
deleted file mode 100644
index 13226e9b22dd53e4289d506d49c52671de036ee8..0000000000000000000000000000000000000000
--- a/include/linux/blk-mq-virtio.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_BLK_MQ_VIRTIO_H
-#define _LINUX_BLK_MQ_VIRTIO_H
-
-struct blk_mq_queue_map;
-struct virtio_device;
-
-void blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
-		struct virtio_device *vdev, int first_vec);
-
-#endif /* _LINUX_BLK_MQ_VIRTIO_H */

-- 
2.47.0


