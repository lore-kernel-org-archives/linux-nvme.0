Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E90C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 17:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4pEFUu/YcyfpKDLtxlhjY3F3WSTwkSWozbYycXrD8ds=; b=2SvO79CmWwMTU5CcRwEfEnXvhx
	LSsNB5PqLbaxTlVey5OMNY23+CKdtfWZrVRueP7vOkYhM9N/5/eMCB7VAtN+DmxA4+v6Y6rD6ErDU
	e6QIVsCROY+Ns2YZr5BRjUAxDSvsTRdDByd3VFhKLmkKXxz76hw8eCOM76s8CXhYqA7x01cZ/ulCJ
	81VG3+LA3RIVIoBjbmW1iANVdQXaIkZWPMPOFoAkASrJ+rXcY/HRBYtUvb9W8d0Rcldf2BfhK5NP2
	wRvsICyoqJauIk8aZ3hQVbP5/0Mk0v+hVKUs1tBOZDgePez6VNdccGt9dbpBNQWhkT1cT0CsQyaxb
	bfUnfgAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0RLz-001HyD-Ku; Wed, 30 Nov 2022 17:58:39 +0000
Received: from [2001:4bb8:192:26e7:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0R6h-0017Yp-Og; Wed, 30 Nov 2022 17:42:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/5] nvme: only set reserved_tags in nvme_alloc_io_tag_set for fabrics controllers
Date: Wed, 30 Nov 2022 18:42:37 +0100
Message-Id: <20221130174240.227616-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221130174240.227616-1-hch@lst.de>
References: <20221130174240.227616-1-hch@lst.de>
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

The reserved_tags are only needed for fabrics controllers.  Right now only
fabrics drivers call this helper, so this is harmless, but we'll use it
in the PCIe driver soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f31586c4689334..ed163c53976722 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4899,7 +4899,8 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	memset(set, 0, sizeof(*set));
 	set->ops = ops;
 	set->queue_depth = ctrl->sqsize + 1;
-	set->reserved_tags = NVMF_RESERVED_TAGS;
+	if (ctrl->ops->flags & NVME_F_FABRICS)
+		set->reserved_tags = NVMF_RESERVED_TAGS;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
-- 
2.30.2


