Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06568C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 15:21:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B987B60F21
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 15:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B987B60F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MSXSmedk9h2HNd298Tjm9Fq9k2yRXrbpfNGZC3ZMZrM=; b=tt1aA0ZKZCHptziNf7DnLI1hZE
	e75QHxHdHWA8A4HNyDbsjIoxVPiSRVbAW/JTR3pyIMdR+h3tvABjj2N5ccKCP6EDlqVsL/nU6VAfE
	lVTKurXpJBwJnKJJDrnhXKG99RTFwe4qzBGNhJ+mRASr1vOXVlI0+qe9e/n8pOwViSNJQT3hXyXWG
	+Scp6nSoKGPFrGKauqVl04lowedaznv+GMQABTSrShRoMmqyPyATxbkcwkPKUBZAm6LGPaeIpJKQm
	+tMtf34H905vwAXZ027562iAlbQE1T72AAt6q+6N1B7fSW6BNW1CaPgnMJFJ97CggV6gwG45Gn0YT
	BEu/iP0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mag4c-00HKTj-1L; Wed, 13 Oct 2021 15:21:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mag4Y-00HKSo-NM
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 15:21:40 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4CB660F21;
 Wed, 13 Oct 2021 15:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634138498;
 bh=T4wBYaQ3aekYz6lXWXTgH2Ig9nEEhR27CnhKPgE3Xfc=;
 h=From:To:Cc:Subject:Date:From;
 b=jgS0ULbUmuUwftTIQu1vMLvqR9dbDquAZZtM37Bqx1xpqFP8yGY59JtO/PDS+96Yv
 qo3itIhRJUDbyyNjUCLAFuKlW8dnz9zBNPhFJ0ouyAPZmBGJqY9RY1QlhWmsWlzYik
 DxLWuhB7RyoLOxTvGOzSqen78Fdsi7d483oe5PNkFWzA1FFHq1gZuZnS4nCIEL0Dhp
 OVrQoXNJFv1ZIVT7si/tCoR1P5+WzeJQIZxgf5gWGcX/6zs2TReWGf9D2T2Z3g2K0i
 zCTw6iGr3oZ21uy5cqptq+s1BvXR0I3FdAOfwNgELIaK/7ldJHIUIcMicYSrwN+Iho
 7FnVKaGM4yA4Q==
From: Keith Busch <kbusch@kernel.org>
To: sagi@grimberg.me,
	hch@lst.de,
	linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
Subject: [RFCv2] nvme-pci: adjust tagset parameters to match b/w
Date: Wed, 13 Oct 2021 08:21:36 -0700
Message-Id: <20211013152136.1594409-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_082138_813494_4DE4BD57 
X-CRM114-Status: GOOD (  15.56  )
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

See v1 for background:

  http://lists.infradead.org/pipermail/linux-nvme/2021-October/027998.html

Instead of auto-adjusting the timeout to cope with the worst case
scenario, this version adjusts the IO depth and max transfer size so
that the worst case scenario fits within the driver's timeout tolerance.

I also fixed the b/w units since v1, as they are in megabits, not bytes.

I have encoded seemingly arbitrary lower-bounds for depth and transfer
sizes. The values were selected based on anecdotal/empirical observations
where going lower can negatively impact performance.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 89 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7fc992a99624..02a69f4ed6ba 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/mutex.h>
 #include <linux/once.h>
 #include <linux/pci.h>
@@ -2424,11 +2425,84 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 	return true;
 }
 
+static void nvme_adjust_tagset_parms(struct nvme_dev *dev)
+{
+	static const u32 min_bytes = 128 * 1024;
+	static const u32 min_depth = 128;
+
+	u32 timeout, max_bytes, max_prps, max_prp_lists, max_prp_list_size,
+		total_depth, max_xfer, bw, queue_depth;
+
+	/* bw is returned in Mb/s units */
+	bw = pcie_bandwidth_available(to_pci_dev(dev->dev), NULL, NULL, NULL);
+
+	/*
+	 * PCIe DLLP/TLP overhead based on worst case MPS (128b) achieves
+	 * roughy 86% link efficiency for host data. Also, convert to MiB/s
+	 * from megabits/s.
+	 *
+	 * XXX: Calculate efficiency from current MPS?
+	 */
+	bw = ((bw * 86) / 100) / 8;
+	if (!bw)
+		return;
+
+retry:
+	max_bytes = dev->ctrl.max_hw_sectors << SECTOR_SHIFT;
+	max_prps = DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
+	max_prp_lists = DIV_ROUND_UP(max_prps * sizeof(__le64),
+					 NVME_CTRL_PAGE_SIZE);
+	max_prp_list_size = NVME_CTRL_PAGE_SIZE * max_prp_lists;
+	queue_depth = dev->tagset.queue_depth;
+	total_depth = dev->tagset.nr_hw_queues * queue_depth;
+
+	/* Max outstanding NVMe protocol transfer in MiB */
+	max_xfer = (total_depth * (max_bytes + max_prp_list_size +
+			   sizeof(struct nvme_command) +
+			   sizeof(struct nvme_completion) +
+			   sizeof(struct msi_msg))) >> 20;
+
+	timeout = DIV_ROUND_UP(max_xfer, bw);
+
+	/*
+	 * Double the time to generously allow for device side overhead and
+	 * link sharing.
+	 *
+	 * XXX: Calculate link sharing?
+	 */
+	timeout = (2 * timeout) * HZ;
+
+	if (timeout > NVME_IO_TIMEOUT &&
+	    (max_bytes > min_bytes ||
+	     queue_depth > min_depth)) {
+		if (max_bytes / 2 > min_bytes)
+			dev->ctrl.max_hw_sectors = DIV_ROUND_UP(
+						dev->ctrl.max_hw_sectors, 2);
+		else
+			dev->ctrl.max_hw_sectors = min_t(u32,
+					min_bytes >> SECTOR_SHIFT,
+					dev->ctrl.max_hw_sectors);
+
+		if (queue_depth / 2 > min_depth)
+			dev->tagset.queue_depth = DIV_ROUND_UP(
+						dev->tagset.queue_depth, 2);
+		else
+			dev->tagset.queue_depth = min_t(u32, min_depth,
+						dev->tagset.queue_depth);
+
+		goto retry;
+	}
+}
+
 static void nvme_dev_add(struct nvme_dev *dev)
 {
 	int ret;
 
 	if (!dev->ctrl.tagset) {
+		u32 queue_depth = min_t(unsigned int, dev->q_depth,
+					BLK_MQ_MAX_DEPTH) - 1;
+		u32 max_hw_sectors = dev->ctrl.max_hw_sectors;
+
 		dev->tagset.ops = &nvme_mq_ops;
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
 		dev->tagset.nr_maps = 2; /* default + read */
@@ -2436,12 +2510,23 @@ static void nvme_dev_add(struct nvme_dev *dev)
 			dev->tagset.nr_maps++;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
 		dev->tagset.numa_node = dev->ctrl.numa_node;
-		dev->tagset.queue_depth = min_t(unsigned int, dev->q_depth,
-						BLK_MQ_MAX_DEPTH) - 1;
+		dev->tagset.queue_depth = queue_depth;
 		dev->tagset.cmd_size = sizeof(struct nvme_iod);
 		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 		dev->tagset.driver_data = dev;
 
+		nvme_adjust_tagset_parms(dev);
+
+		if (dev->tagset.queue_depth != queue_depth ||
+		    dev->ctrl.max_hw_sectors != max_hw_sectors) {
+			dev_warn(dev->ctrl.device,
+				 "qdepth (%u) and max sectors (%u) exceed driver timeout tolerance (%ums)\n"
+				 "nvme ctrl qdepth and sectors adjusted to %u %u\n",
+				 queue_depth, max_hw_sectors, NVME_IO_TIMEOUT,
+				 dev->tagset.queue_depth,
+				 dev->ctrl.max_hw_sectors);
+		}
+
 		/*
 		 * Some Apple controllers requires tags to be unique
 		 * across admin and IO queue, so reserve the first 32
-- 
2.25.4


