Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B35EC3064D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 10:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+Yg7CUQZHgK9nk6EdCMyV4jrkwinZb2rxJuPjD6CYFo=; b=mssAsRIqUsiOGs0RhlPVIQK+Jy
	z7Yyjkt1sT7SHZzLDYSCLdQfVbsZlR8X/u2mRI0aU3ZiaoqxCLqY0mYsCCfVZ9wPPZk9EJgKTB3Wr
	rVMd7Y//NrU09jXY5+GjR106QHdrJYN9sK0j8OEOU//eaRcWaSJjxYrOKhqpeM8WSyfaLSg4eAihx
	TB/PfOUmSDa4bg4aSsDvKnykXEDW33rztwtrTVhMt3c7XoxguXVSqoPrhwUzrSsQVqhaq4A2Mow75
	csHk8xZt75pGS1p0o0GsSRU6nxaTsqXkudq64Uz0oiy6p1CD1fClljUXkcOq7MKYMjPPnRdlXVLDz
	Wx5QVs6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOaxG-00000006Ncg-1orQ;
	Tue, 02 Jul 2024 10:41:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOaxC-00000006NcE-33h8
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 10:41:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719916899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+Yg7CUQZHgK9nk6EdCMyV4jrkwinZb2rxJuPjD6CYFo=;
	b=BFsWSCvBUnlhyDq2uxEhuPD2/WQ+Abr+Xwfwb2fCLYMEpR4Sq2QrgD6xmB+wx84J7R9pDF
	LuubCVLJXZ3vund/zIBuJlO0cbDkXNnRKqYOQYIYlQllVBWv2JBQopA6Hh+Ed2bhF2dxx6
	lNnAjG83edu/Exth3P1vQ4ipPnlRzxI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-_qevNJXoP5WSwB0Ec3vd1g-1; Tue,
 02 Jul 2024 06:41:34 -0400
X-MC-Unique: _qevNJXoP5WSwB0Ec3vd1g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31E3519331BC;
	Tue,  2 Jul 2024 10:41:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B261B19560A3;
	Tue,  2 Jul 2024 10:41:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Lawrence Troup <ltroup@cisco.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3] nvme-pci: allow unmanaged interrupts
Date: Tue,  2 Jul 2024 18:41:12 +0800
Message-ID: <20240702104112.4123810-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_034143_745676_DA3857C5 
X-CRM114-Status: GOOD (  16.43  )
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

From: Keith Busch <kbusch@kernel.org>

People _really_ want to control their interrupt affinity in some
cases, such as Openshift with Performance profile, in which each
irq's affinity is completely specified from userspace. Turns out
that 'isolcpus=managed_irqs' isn't enough.

Add module parameter to allow unmanaged interrupts, just as some
SCSI drivers are doing.

Cc: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
v2->v3:
	- rebase on for-next
	- add openshift use case

v1->v2: skip the the AFFINITY vector allocation if the parameter is
provided instead trying to make the vector code handle all post_vectors.

 drivers/nvme/host/pci.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5d8035218de9..a39c99c9b64d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -63,6 +63,11 @@ MODULE_PARM_DESC(sgl_threshold,
 		"Use SGLs when average request segment size is larger or equal to "
 		"this size. Use 0 to disable SGLs.");
 
+static bool managed_irqs = true;
+module_param(managed_irqs, bool, 0444);
+MODULE_PARM_DESC(managed_irqs,
+		 "set to false for user controlled irq affinity");
+
 #define NVME_PCI_MIN_QUEUE_SIZE 2
 #define NVME_PCI_MAX_QUEUE_SIZE 4095
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp);
@@ -456,7 +461,7 @@ static void nvme_pci_map_queues(struct blk_mq_tag_set *set)
 		 * affinity), so use the regular blk-mq cpu mapping
 		 */
 		map->queue_offset = qoff;
-		if (i != HCTX_TYPE_POLL && offset)
+		if (managed_irqs && i != HCTX_TYPE_POLL && offset)
 			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
 		else
 			blk_mq_map_queues(map);
@@ -2226,6 +2231,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	};
 	unsigned int irq_queues, poll_queues;
 	unsigned int flags = PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY;
+	int ret;
 
 	/*
 	 * Poll queues don't need interrupts, but we need at least one I/O queue
@@ -2251,8 +2257,16 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		irq_queues += (nr_io_queues - poll_queues);
 	if (dev->ctrl.quirks & NVME_QUIRK_BROKEN_MSI)
 		flags &= ~PCI_IRQ_MSI;
-	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues, flags,
+
+	if (managed_irqs)
+		return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues, flags,
 					      &affd);
+
+	flags &= ~PCI_IRQ_AFFINITY;
+	ret = pci_alloc_irq_vectors(pdev, 1, irq_queues, flags);
+	if (ret > 0)
+		nvme_calc_irq_sets(&affd, ret - 1);
+	return ret;
 }
 
 static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
-- 
2.44.0


