Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF83D462B1
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vzEgHLoCv4lT2XoB01iIHG8M75izx1EH6I0tRgRczV0=; b=3quzyqzF8qskf2HcqeEwRtJMKH
	R7U37hQ+oxW4mHW0y28iag/khoyFw4cZQQBkwitBHusnpcK7gAgYFxd5OjRpfLDi5aAQ/IGqOCcSz
	7C70fNI5ijMzibLbrV5W4I8uuCwe7/4mfarPzBZWqicD18xkg1dGfpF8fOT+Kh9tk/3quhWx5blbg
	CmKU6co3II+i90qJjcLkiR6jNedWXmkXqRrxbX1s9PYviY7zp/6rkp66dTHFM4ByMPsWYv/ipXt1T
	lk/pnnZk+XcXLdvJ/UdnPQZU6lc1BNTZoeyfzF+W54Bu8KEE9NqBQFN+S14rOefZBraMAFPhfSdxy
	hrh6JkaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEKW-000000077zq-46dY;
	Wed, 13 Nov 2024 14:26:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEKR-000000077v2-1RsV
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 14:26:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0329B5C0352;
	Wed, 13 Nov 2024 14:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98734C4CEE0;
	Wed, 13 Nov 2024 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731508002;
	bh=ofx9glE+KKfPfE3vbCUElyASjdPTiaZBTdjXeeRdot8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ek8erP6ujKVuchhURI/oUFZn12QoJ5X9uu8bOqQj6pi3xEWDjxi8WTIWaQwTB+2N/
	 MsQd+9NV0PGoCY1U8OFjhKaEPdasIHqYhxTdXZpX1LIRMxciFe7Mlz/YmCSZb/zlpY
	 oHkPamuOtIRmSmd0NOEd8FoTyOIpgVncnIVlhZnHnwXRIi7kWkJGFGHG/zFXbLc4wj
	 x9KdJ76gmPMyj8Q0RxGKU2fntpNCu3rb7WWJZGq5zIKbtgojQgvHIFZ6w6fOPa/21Y
	 eb0sxTMsUmABqtDJWEvAo+MomikiM2fnIC+u32CzJmU26TlWtKuuUkLl1HMBWsHdfX
	 WjpwEz896Ed8Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 13 Nov 2024 15:26:19 +0100
Subject: [PATCH v4 05/10] blk-mq: introduce blk_mq_hctx_map_queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-refactor-blk-affinity-helpers-v4-5-dd3baa1e267f@kernel.org>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
In-Reply-To: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_062643_651060_221A4CAE 
X-CRM114-Status: GOOD (  15.35  )
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

blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
hardware queue mapping based on affinity information. These two function
share common code and only differ on how the affinity information is
retrieved. Also, those functions are located in the block subsystem
where it doesn't really fit in. They are virtio and pci subsystem
specific.

Thus introduce provide a generic mapping function which uses the
irq_get_affinity callback from bus_type.

Originally idea from Ming Lei <ming.lei@redhat.com>

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-cpumap.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9638b25fd52124f0173e968ebdca5f1fe0b42ad9..3506f1c25a02d331d28212a2a97fb269cb21e738 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/group_cpus.h>
+#include <linux/device/bus.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -54,3 +55,45 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
 
 	return NUMA_NO_NODE;
 }
+
+/**
+ * blk_mq_hctx_map_queues - Create CPU to hardware queue mapping
+ * @qmap:	CPU to hardware queue map.
+ * @dev:	The device to map queues.
+ * @offset:	Queue offset to use for the device.
+ *
+ * Create a CPU to hardware queue mapping in @qmap. The struct bus_type
+ * irq_get_affinity callback will be used to retrieve the affinity.
+ */
+void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
+			    struct device *dev, unsigned int offset)
+
+{
+	const struct cpumask *(*irq_get_affinity)(struct device *dev,
+						  unsigned int irq_vec);
+	const struct cpumask *mask;
+	unsigned int queue, cpu;
+
+	if (dev->driver->irq_get_affinity)
+		irq_get_affinity = dev->driver->irq_get_affinity;
+	else if (dev->bus->irq_get_affinity)
+		irq_get_affinity = dev->bus->irq_get_affinity;
+	else
+		goto fallback;
+
+	for (queue = 0; queue < qmap->nr_queues; queue++) {
+		mask = irq_get_affinity(dev, queue + offset);
+		if (!mask)
+			goto fallback;
+
+		for_each_cpu(cpu, mask)
+			qmap->mq_map[cpu] = qmap->queue_offset + queue;
+	}
+
+	return;
+
+fallback:
+	WARN_ON_ONCE(qmap->nr_queues > 1);
+	blk_mq_clear_mq_map(qmap);
+}
+EXPORT_SYMBOL_GPL(blk_mq_hctx_map_queues);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2035fad3131fb60781957095ce8a3a941dd104be..1a85fdcb443c154390cd29f2b1f2a807bf10bfe3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -923,6 +923,8 @@ void blk_mq_unfreeze_queue_non_owner(struct request_queue *q);
 void blk_freeze_queue_start_non_owner(struct request_queue *q);
 
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
+void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
+			    struct device *dev, unsigned int offset);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);

-- 
2.47.0


