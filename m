Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7DEFA3723
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 07:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qJRG//ZQGo+L4jpM1tEP3oB74zzSoIQHH+B9SgLTCus=; b=PJbgQPxKhpeJ4r5wnk0rKvkfu3
	Ym8Of1rpc1YHXFa69TipZzroZeOvzslYEJzq0CuVjX9yrB8R5TOeLJWABZNra5tPZvJQGfcZ+BIik
	WuQll1iU6o/le0zM53bJ/R8uoj/Klu2AlpSYl1s5Kxk8KqEWUv3PuHpp7ujCMRWbvcFWiQ7o2mrsS
	OqptFBSu8yao7VhLc+iTRrHeNMifMOil5LzlHFw4DMZkQjsvayhKS8nR/OpZo/xGwmFEWrOFqbcRX
	tD39kyoRrqb1RY2UsJgLSnhrWKnrDbhyKl/BlMVKGNvFr6CfpJ6TkfqjoYD3uOJppJ3xy7SGCtiRK
	c8MJwwKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp0x5-0000000FBfz-0plD;
	Fri, 13 Sep 2024 07:42:47 +0000
Received: from mail.nearlyone.de ([2a01:4f8:1c1e:abde::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp0wv-0000000FBX0-11Ib
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 07:42:39 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3082DAD4D;
	Fri, 13 Sep 2024 09:42:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1726213354; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qJRG//ZQGo+L4jpM1tEP3oB74zzSoIQHH+B9SgLTCus=;
	b=crCXW7wBJBPfXyoTAs3TOynEUFM4HHEdNUZl+wcVZOhrWFZZ8+W+oXfL5cdXpnLwRD0tAe
	+bT928XnGpOZMAAh9yWJZvOlfiCGhwCuzrKI3R2IO4hN9Ng5x3Jq2DRZlRqweMZRw7ySSn
	HNDlXkmKcdwZixIn3i2xGOGzDpKkMJliwBdWhJMo6dAAui+XzVkWRJZXNRGHqLfU8mQoGk
	rzndNx9CGnECpMsy9Wo9wNA2ky3q9mxDg6TxMvsK4A00Y6ptXrIv1c6GPWXdKnDFexSOmt
	/Uvu0blpHEQKLJwGMIsCwD3uLjXBW6I3CFRSdHEjracMo3Eq0GUD7C+Ncke8OQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 13 Sep 2024 09:42:04 +0200
Subject: [PATCH 6/6] blk-mq: remove unused queue mapping helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-refactor-blk-affinity-helpers-v1-6-8e058f77af12@suse.de>
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
X-CRM114-CacheID: sfid-20240913_004237_730317_391431C7 
X-CRM114-Status: GOOD (  13.26  )
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

There are no users left of the pci and virtio queue mapping helpers.
Thus remove them.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 block/Makefile                |  2 --
 block/blk-mq-pci.c            | 46 -------------------------------------------
 block/blk-mq-virtio.c         | 46 -------------------------------------------
 include/linux/blk-mq-pci.h    | 11 -----------
 include/linux/blk-mq-virtio.h | 11 -----------
 5 files changed, 116 deletions(-)

diff --git a/block/Makefile b/block/Makefile
index ddfd21c1a9ff..33748123710b 100644
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
index d47b5c73c9eb..000000000000
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
index 68d0945c0b08..000000000000
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
index ca544e1d3508..000000000000
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
index 13226e9b22dd..000000000000
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
2.46.0


