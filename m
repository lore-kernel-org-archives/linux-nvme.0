Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6234FD78326
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q194IhLmi1bQFnUdOLWhwhPqfo+HcZd2RHbWcsv0KKo=; b=EiyrqgzgR593K5jb0n/rQebB7V
	fV9mRlCULZtPlkvXrnixRWGN9IwbLs4aU3SywFO6AO4GVebcvDkl/ZXEYlAo+cFPbnYpOzTvGzW5Y
	uSmgkE0k+7iUJDx5rY47nZnS/utPHF/8kHCfNH7vJqre3OK8aTxNkso5/zY9x/u1PDU0t+W5q8jMm
	JDCeTj8bXD4TVcWcPhAF00pgLCvsUR3/uxDM5pJ1a/6p0TqhKg/xzm9qV2b54rZRuPjY6fV8NWhax
	C2KWr6BOGK77Rbe/zJYkVUNOmN+zsXufmVyGVTKu5xdtH8n/F19YyyUzq+KGKkph9X/CUunWOL++P
	fuUwLNtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI70c-00000006Kun-2s5K;
	Mon, 02 Dec 2024 14:02:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI6yc-00000006KQ8-399c
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 14:00:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 378A25C4CEA;
	Mon,  2 Dec 2024 13:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E27C4CED1;
	Mon,  2 Dec 2024 14:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733148037;
	bh=oiRZfIMzG93CdE5+W1Yfh1LVTVWiPOGwTq77sR/QFhQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uvJ6nElaC/JBzCm2r6Q7yHyEoaBl9uNq8v1eit7MP25eKm26wgrZsfcqX9HPT7QzU
	 /RpfoUS+NWdHwqlZKQg/RduaYDLq3eLPM2YXVppR5OCgw4HB2/0WlKsnuwVXh2gWnz
	 x2TDK0d+6df/Lhyfq+SldGhQFl7l2059sgnhjwVxdTY6qtJKI/0nW3aEb/lZsuOn9y
	 l8ks3asmw50yvQ2c3/6pEH+1PwuPOlfkRX+eAvq39zF40YHbMnhGJR6ftlz14xsnzL
	 tB8I58g1b+oNF8itfATtXVpuxPkGkUb6aN1ZB8ZCXNRNcnDsQ6Xg0QXKpOZUi1Wa6h
	 SipYF94hZI1Lw==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 02 Dec 2024 15:00:12 +0100
Subject: [PATCH v6 4/8] blk-mq: introduce blk_mq_map_hw_queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-refactor-blk-affinity-helpers-v6-4-27211e9c2cd5@kernel.org>
References: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
In-Reply-To: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_060038_875284_42A7E891 
X-CRM114-Status: GOOD (  16.00  )
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-cpumap.c  | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9638b25fd52124f0173e968ebdca5f1fe0b42ad9..ad8d6a363f24ae11968b42f7bcfd6a719a0499b7 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/group_cpus.h>
+#include <linux/device/bus.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -54,3 +55,39 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
 
 	return NUMA_NO_NODE;
 }
+
+/**
+ * blk_mq_map_hw_queues - Create CPU to hardware queue mapping
+ * @qmap:	CPU to hardware queue map
+ * @dev:	The device to map queues
+ * @offset:	Queue offset to use for the device
+ *
+ * Create a CPU to hardware queue mapping in @qmap. The struct bus_type
+ * irq_get_affinity callback will be used to retrieve the affinity.
+ */
+void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
+			  struct device *dev, unsigned int offset)
+
+{
+	const struct cpumask *mask;
+	unsigned int queue, cpu;
+
+	if (!dev->bus->irq_get_affinity)
+		goto fallback;
+
+	for (queue = 0; queue < qmap->nr_queues; queue++) {
+		mask = dev->bus->irq_get_affinity(dev, queue + offset);
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
+EXPORT_SYMBOL_GPL(blk_mq_map_hw_queues);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index c596e0e4cb751ab00f2150cf086fcdc5ad32b02e..769eab6247d4921e574e0828ab41a580a5a9f2fe 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -921,6 +921,8 @@ void blk_mq_unfreeze_queue_non_owner(struct request_queue *q);
 void blk_freeze_queue_start_non_owner(struct request_queue *q);
 
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
+void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
+			  struct device *dev, unsigned int offset);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);

-- 
2.47.0


