Return-Path: <SRS0=Onny=7V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28505C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 23:16:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A9920823
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 23:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e2Vzm2RW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="01kjMDb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A9920823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hJD0DLcmpIlUVM5NF5bvVwz7PVttzE2c/wGH0u+iREA=; b=e2Vzm2RWJZJsOZ
	U3u/+lEmo0b2UlazwrIeUR0VlIyr7L+bS+rep2v8omgWmVt8X3+RkYXlKDG63SopzcnYEXoMO2+f/
	czQYAfm1aTg9ju+lW6wcYA6BjA9mW90LM2iyvPu4i3YK6OJ0Mz9ZTN0PgQq/zn2wbcJfX24ObWiLc
	71avfbELdZsQMhS2t4bH5l740msusod2pkSvZ3EextMCg4zVIfOiuWdmLiX7O8BBDT2LI4Ukzt6Uv
	rVRRGF4Gs3KRnEDJ6mQ5+E4bb6n1kbC0zQufFG98uhr+wtyXHqPvFWrz8uOVsIGLIbsRXcIiFEP6H
	3BFghW9ulhaDxsNYzXNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jiQzw-000336-2r; Mon, 08 Jun 2020 23:16:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jiQu7-0001kM-MQ
 for linux-nvme@lists.infradead.org; Mon, 08 Jun 2020 23:10:11 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A86A220C56;
 Mon,  8 Jun 2020 23:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591657805;
 bh=m23dLoyLhJjCU66alnaUcLHfXVkJjzbVDLW3x6HWfMs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=01kjMDb/AP1kRQNYo7AAj0DKxqu0R2Lqpq448Jq+DjtXS89myjSmCgM/2754SmGyi
 8xpwwezkF73s/u0BE3G8IZ6o+wNMUe77O6ElqdhfOrFWIrWN457nNeJgY1oXNeOMqp
 2NILtVs5WEPVSFiw5bqGy9fXruI0DDEPV1VIoPKY=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 182/274] nvme-pci: align io queue count with
 allocted nvme_queue in nvme_probe
Date: Mon,  8 Jun 2020 19:04:35 -0400
Message-Id: <20200608230607.3361041-182-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200608_161008_454833_18E6E6FB 
X-CRM114-Status: GOOD (  19.01  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
 Weiping Zhang <zhangweiping@didiglobal.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Weiping Zhang <zhangweiping@didiglobal.com>

[ Upstream commit 2a5bcfdd41d68559567cec3c124a75e093506cc1 ]

Since commit 147b27e4bd08 ("nvme-pci: allocate device queues storage
space at probe"), nvme_alloc_queue does not alloc the nvme queues
itself anymore.

If the write/poll_queues module parameters are changed at runtime to
values larger than the number of allocated queues in nvme_probe,
nvme_alloc_queue will access unallocated memory.

Add a new nr_allocated_queues member to struct nvme_dev to record how
many queues were alloctated in nvme_probe to avoid using more than the
allocated queues after a reset following a change to the
write/poll_queues module parameters.

Also add nr_write_queues and nr_poll_queues members to allow refreshing
the number of write and poll queues based on a change to the module
parameters when resetting the controller.

Fixes: 147b27e4bd08 ("nvme-pci: allocate device queues storage space at probe")
Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
[hch: add nvme_max_io_queues, update the commit message]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 57 ++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cc46e250fcac..dcf597fbafad 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -128,6 +128,9 @@ struct nvme_dev {
 	dma_addr_t host_mem_descs_dma;
 	struct nvme_host_mem_buf_desc *host_mem_descs;
 	void **host_mem_desc_bufs;
+	unsigned int nr_allocated_queues;
+	unsigned int nr_write_queues;
+	unsigned int nr_poll_queues;
 };
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
@@ -209,25 +212,14 @@ struct nvme_iod {
 	struct scatterlist *sg;
 };
 
-static unsigned int max_io_queues(void)
+static inline unsigned int nvme_dbbuf_size(struct nvme_dev *dev)
 {
-	return num_possible_cpus() + write_queues + poll_queues;
-}
-
-static unsigned int max_queue_count(void)
-{
-	/* IO queues + admin queue */
-	return 1 + max_io_queues();
-}
-
-static inline unsigned int nvme_dbbuf_size(u32 stride)
-{
-	return (max_queue_count() * 8 * stride);
+	return dev->nr_allocated_queues * 8 * dev->db_stride;
 }
 
 static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
 {
-	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
+	unsigned int mem_size = nvme_dbbuf_size(dev);
 
 	if (dev->dbbuf_dbs)
 		return 0;
@@ -252,7 +244,7 @@ static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
 
 static void nvme_dbbuf_dma_free(struct nvme_dev *dev)
 {
-	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
+	unsigned int mem_size = nvme_dbbuf_size(dev);
 
 	if (dev->dbbuf_dbs) {
 		dma_free_coherent(dev->dev, mem_size,
@@ -2003,7 +1995,7 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
 {
 	struct nvme_dev *dev = affd->priv;
-	unsigned int nr_read_queues;
+	unsigned int nr_read_queues, nr_write_queues = dev->nr_write_queues;
 
 	/*
 	 * If there is no interupt available for queues, ensure that
@@ -2019,12 +2011,12 @@ static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
 	if (!nrirqs) {
 		nrirqs = 1;
 		nr_read_queues = 0;
-	} else if (nrirqs == 1 || !write_queues) {
+	} else if (nrirqs == 1 || !nr_write_queues) {
 		nr_read_queues = 0;
-	} else if (write_queues >= nrirqs) {
+	} else if (nr_write_queues >= nrirqs) {
 		nr_read_queues = 1;
 	} else {
-		nr_read_queues = nrirqs - write_queues;
+		nr_read_queues = nrirqs - nr_write_queues;
 	}
 
 	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
@@ -2048,7 +2040,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	 * Poll queues don't need interrupts, but we need at least one IO
 	 * queue left over for non-polled IO.
 	 */
-	this_p_queues = poll_queues;
+	this_p_queues = dev->nr_poll_queues;
 	if (this_p_queues >= nr_io_queues) {
 		this_p_queues = nr_io_queues - 1;
 		irq_queues = 1;
@@ -2078,14 +2070,25 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 		__nvme_disable_io_queues(dev, nvme_admin_delete_cq);
 }
 
+static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
+{
+	return num_possible_cpus() + dev->nr_write_queues + dev->nr_poll_queues;
+}
+
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct nvme_queue *adminq = &dev->queues[0];
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int result, nr_io_queues;
+	unsigned int nr_io_queues;
 	unsigned long size;
+	int result;
 
-	nr_io_queues = max_io_queues();
+	/*
+	 * Sample the module parameters once at reset time so that we have
+	 * stable values to work with.
+	 */
+	dev->nr_write_queues = write_queues;
+	dev->nr_poll_queues = poll_queues;
 
 	/*
 	 * If tags are shared with admin queue (Apple bug), then
@@ -2093,6 +2096,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 */
 	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
 		nr_io_queues = 1;
+	else
+		nr_io_queues = min(nvme_max_io_queues(dev),
+				   dev->nr_allocated_queues - 1);
 
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
@@ -2767,8 +2773,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!dev)
 		return -ENOMEM;
 
-	dev->queues = kcalloc_node(max_queue_count(), sizeof(struct nvme_queue),
-					GFP_KERNEL, node);
+	dev->nr_write_queues = write_queues;
+	dev->nr_poll_queues = poll_queues;
+	dev->nr_allocated_queues = nvme_max_io_queues(dev) + 1;
+	dev->queues = kcalloc_node(dev->nr_allocated_queues,
+			sizeof(struct nvme_queue), GFP_KERNEL, node);
 	if (!dev->queues)
 		goto free;
 
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
