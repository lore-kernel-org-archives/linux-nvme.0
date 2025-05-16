Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC020C3ABDD
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 07:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HDwlbyEf23lOeBTRuwn6GqrnbMwgHdaeJ6nyzI28fzY=; b=bJz8C1lhTS05xYLDvu4LXMDofb
	/U/l1mpSr9VY3lTx7+DVpWbgItAi/oNeSPLoLz2AK53wOgcaIZ+Gh2PC+cEqsCSxcaMOg5EOAhV6E
	dW4sYDnEm85CqPTO6BqyxbcVS3/ht7oY/I1t3RWcnDdySxpdLWvqRqtqnwn6CI6CTJ9dxgtLdYC/U
	g4SCp0/YJ9N+44vyA+6cxWQt2Q3F1+uQZfTv7qbOEaNyWqnJRYrZq6llLlZzBGCNgJ7pKlt4mbJ/3
	VUAajvVZ00QUhVvu9kGYiSw49JuxG7gNLJFrY+bGuRyvwK39Gw9C0pbSMqYG4d6xiIZgKUYp+Unmw
	j9bhovbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFpPU-00000002eYH-3g5S;
	Fri, 16 May 2025 07:23:12 +0000
Received: from 2a02-8389-2341-5b80-8ad1-b0a3-ff78-473d.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8ad1:b0a3:ff78:473d] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFpOF-00000002eSj-3jI1;
	Fri, 16 May 2025 07:21:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org
Cc: sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-pci: derive and better document max segments limits
Date: Fri, 16 May 2025 09:21:52 +0200
Message-ID: <20250516072152.166131-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Redefine the max segments and max integrity limits based on the limiting
factors without changing the final values and add comments explaining
them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0efbc9329291..0b6e54f7ba05 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -35,8 +35,6 @@
 #define SQ_SIZE(q)	((q)->q_depth << (q)->sqes)
 #define CQ_SIZE(q)	((q)->q_depth * sizeof(struct nvme_completion))
 
-#define SGES_PER_PAGE	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc))
-
 #define NVME_SMALL_POOL_SIZE	256
 
 /*
@@ -44,10 +42,24 @@
  * require an sg allocation that needs more than a page of data.
  */
 #define NVME_MAX_KB_SZ	8192
-#define NVME_MAX_SEGS	128
-#define NVME_MAX_META_SEGS 15
 #define NVME_MAX_NR_DESCRIPTORS	5
 
+/*
+ * For data SGLs we support a single descriptors worth of SGL entries, but for
+ * now we also limit it to avoid an allocation larger than PAGE_SIZE for the
+ * scatterlist.
+ */
+#define NVME_MAX_SEGS \
+	min(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc), \
+	    (PAGE_SIZE / sizeof(struct scatterlist)))
+
+/*
+ * For metadata SGLs, only the small descriptor is supported, and the first
+ * entry is the segment descriptor, which for the data pointer sits in the SQE.
+ */
+#define NVME_MAX_META_SEGS \
+	((NVME_SMALL_POOL_SIZE / sizeof(struct nvme_sgl_desc)) - 1)
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
 
@@ -3829,8 +3841,6 @@ static int __init nvme_init(void)
 	BUILD_BUG_ON(sizeof(struct nvme_create_sq) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) != 64);
 	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
-	BUILD_BUG_ON(NVME_MAX_SEGS > SGES_PER_PAGE);
-	BUILD_BUG_ON(sizeof(struct scatterlist) * NVME_MAX_SEGS > PAGE_SIZE);
 	BUILD_BUG_ON(nvme_pci_npages_prp() > NVME_MAX_NR_DESCRIPTORS);
 
 	return pci_register_driver(&nvme_driver);
-- 
2.47.2


