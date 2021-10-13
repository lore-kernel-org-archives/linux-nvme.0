Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BC3C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 02:28:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2360760E78
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 02:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2360760E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ManYKXFTOKLr8ja+kIMRV61dlZbSSfT/jpdNMNpvOds=; b=IgJOtGGJYLa+6S
	xwrjSobRRPswzLC2s1lpgsEM05H96K3U5xv05pc7J8i0qZHVT88MOwsNruyjU+lbzyyrEHNfdoP9G
	4z8wfE4JIJWuy/3UD3WcwCi/rH1mq2r15s86GRuZxyecwPRo2/TF7b6qOLfDziroOeOEFPPzEz72j
	LSyUnXnVIVcJ5gYcF3f10U9egfpKDoN5f3sOMCZ1x4/0isQb7VHmK7fcMqRHsSAITExhGhRezUD67
	Z88I75k1ZyihD7yyClwdjW47EOIikzg8agtq8B7Uh0lvNbJXQbYX+fhGSZwQ6SqTINVnSOCSJF6WQ
	s3GdGjfkMjhPX5UcLikg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maTzh-00EeAM-4R; Wed, 13 Oct 2021 02:27:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maTze-00Ee9x-Mq
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 02:27:48 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C78D60E78;
 Wed, 13 Oct 2021 02:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634092065;
 bh=2DQ6LH8Yymp2Oxz3lztT4hFSCoQbA3YPkNhkObkrqPI=;
 h=From:To:Cc:Subject:Date:From;
 b=R9Rz/p2v4RX2ZG1vlZxxLj8PpJkWR8h/9HVoAEjLLhamwrVjB8a4+7R/G8TNRZxsA
 C+TzXvF6H1gbfD4IL/QHAFChGQ5H+N5TGnRYSpm5p2ZsoDzlbdu9AqISV7XXXLieJS
 vOHbFXZzg4oee8N747I2TGosfvLGxyRCgpZTO7AUOIejLUbiXrA9Gngt6ayIow1duD
 AuTk6ETb3aqmw82ETrV23Tt3miDEsgTlrvnxkUsyaTnOqhE6BgWaU7ValFMdU4tLXx
 MAiJbPeysZMB2DnH/rBwSFRpNieMR5G/Him30SBkRSnZwDfsPY8EOWBMVyxiMxeIgt
 usXm6frjI84Zw==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-pci: calculate IO timeout
Date: Tue, 12 Oct 2021 19:27:44 -0700
Message-Id: <20211013022744.1357498-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_192746_800459_44ECA8D6 
X-CRM114-Status: GOOD (  14.75  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Existing host and nvme device combinations are more frequently capable
of sustaining outstanding transfer sizes exceeding the driver's default
timeout tolerance, given the available device throughput.

Let's consider a "mid" level server and controller with 128 CPUs and an
NVMe controller with no MDTS limit (the driver will throttle to 4MiB).

If we assume the driver's default 1k depth per-queue, this can allow
128k outstanding IO submission queue entries.

If all SQ Entries are transferring the 4MiB max request, 512GB will be
outstanding at the same time with the default 30 second timer to
complete the entirety.

If we assume a currently modern PCIe Gen4 x4 NVMe device, that amount of
data will take ~70 seconds to transfer over the PCIe link, not
considering the device side internal latency: timeouts and IO failures
are therefore inevitable.

There are some driver options to mitigate the issue:

 a) Throttle the hw queue depth
     - harms high-depth single-threaded workloads
 b) Throttle the number of IO queues
     - harms low-depth multi-threaded workloads
 c) Throttle max transfer size
     - harms large sequential workloads
 d) Delay dispatch based on outstanding data transfer
     - requires hot-path atomics
 e) Increase IO Timeout

This RFC implements option 'e', increasing the timeout. The timeout is
calculated based on the largest possible outstanding data transfer
against the device's available bandwidth. The link time is arbitrarily
doubled to allow for additional device side latency and potential link
sharing with another device.

The obvious downside to this option means it may take a long time for
the driver to notice a stuck controller.

Any other ideas?

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 43 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7fc992a99624..556aba525095 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2424,6 +2424,40 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 	return true;
 }
 
+static u32 nvme_calculate_timeout(struct nvme_dev *dev)
+{
+	u32 timeout;
+
+	u32 max_bytes = dev->ctrl.max_hw_sectors << SECTOR_SHIFT;
+
+	u32 max_prps = DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
+	u32 max_prp_lists = DIV_ROUND_UP(max_prps * sizeof(__le64),
+					 NVME_CTRL_PAGE_SIZE);
+	u32 max_prp_list_size = NVME_CTRL_PAGE_SIZE * max_prp_lists;
+
+	u32 total_depth = dev->tagset.nr_hw_queues * dev->tagset.queue_depth;
+
+	/* Max outstanding NVMe data transfer scenario in MiB */
+	u32 max_xfer = (total_depth * (max_bytes +
+			   sizeof(struct nvme_command) +
+			   sizeof(struct nvme_completion) +
+			   max_prp_list_size + 16)) >> 20;
+
+	u32 bw = pcie_bandwidth_available(to_pci_dev(dev->dev), NULL, NULL,
+					  NULL);
+
+	/*
+	 * PCIe overhead based on worst case MPS achieves roughy 86% link
+	 * efficiency.
+	 */
+	bw = bw * 86/ 100;
+	timeout = DIV_ROUND_UP(max_xfer, bw);
+
+	/* Double the time to generously allow for device side overhead */
+	return (2 * timeout) * HZ;
+
+}
+
 static void nvme_dev_add(struct nvme_dev *dev)
 {
 	int ret;
@@ -2434,7 +2468,6 @@ static void nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.nr_maps = 2; /* default + read */
 		if (dev->io_queues[HCTX_TYPE_POLL])
 			dev->tagset.nr_maps++;
-		dev->tagset.timeout = NVME_IO_TIMEOUT;
 		dev->tagset.numa_node = dev->ctrl.numa_node;
 		dev->tagset.queue_depth = min_t(unsigned int, dev->q_depth,
 						BLK_MQ_MAX_DEPTH) - 1;
@@ -2442,6 +2475,14 @@ static void nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 		dev->tagset.driver_data = dev;
 
+		dev->tagset.timeout = max_t(unsigned int,
+					    nvme_calculate_timeout(dev),
+					    NVME_IO_TIMEOUT);
+
+		if (dev->tagset.timeout > NVME_IO_TIMEOUT)
+			dev_warn(dev->ctrl.device,
+				 "max possible latency exceeds default timeout:%u; set to %u\n",
+				 NVME_IO_TIMEOUT, dev->tagset.timeout);
 		/*
 		 * Some Apple controllers requires tags to be unique
 		 * across admin and IO queue, so reserve the first 32
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
