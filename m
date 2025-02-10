Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A095CC021A1
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 00:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k0DFpGyxEz3WuZaLZCB5b105H23UMwoc+gg4QyWHmaA=; b=qsJHx+eo6l7r84FkFQwu4sLUsT
	L7YV3d4FFH77rq+Hsn5+RW++sq50b1NxeUuMxQ8gH/nOmYK8MXZqQBi1mAwMhU8u1kfEWK5r+1QrW
	bLgJHIGJQyTtxkTuhHWOlGjcWB99mK9IAgC+JZUw1rMnkZ8cpEpVtsCizCArBpIXnph8JcNUfo4P6
	0Ct5IoTIhxv8edcGgUjD49sY1XsPXVffsGoWplR/plRj34h6YYk4HhFoN5B5KB0hxDxDc+jfpuczs
	A//XOeBaAqV4qLxyr/yOCB0nWelPr73oHi0jmrV8IxpXpZ0ZFhfDwG7qA7R/s5acVEiRD231HzCyS
	QgViGhCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thHhD-0000000FqUy-44qJ;
	Mon, 10 Feb 2025 00:30:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thHhB-0000000FqS2-0IdJ
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 00:30:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D597F5C5AF9;
	Mon, 10 Feb 2025 00:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8927C4CEE2;
	Mon, 10 Feb 2025 00:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739147440;
	bh=TpPJGIF86MDLZQQ4yxef7P1HMNotPuKvk/TAlP3VUdc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pi7cS3W1Ir9Ym0IcjeBU+cQnqwovjzmzx00T8RDNb2et0KmMlSSY+9OjOnQr9mEGi
	 y3MfSvEhKalomvSkr/HyyFmKdAySnFOvK/WZiDfUXyU1MZ0VaENS4oJxHMnEM3JQ6U
	 juVux3kesxm/x5JwC4GY/OhCQKxVY28W4RueFdo/vOdqilNEUcOCAj9ipvXhLzjpbP
	 XSfvrUb4Y9em9kS7RZr/jMti5fuM1pcdMuV6wACaEMRQdAORv0KBRWntxQRRWgRb1n
	 JplO6Afo66qazuDOqjeNAEKjlfgl3MpJQsj4KbMVP4AzLwi1kxi4zEYTu9lG0cOjnu
	 ZS5E7i5X5pqug==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 1/2] nvme: Cleanup the definition of the controller config register fields
Date: Mon, 10 Feb 2025 09:29:34 +0900
Message-ID: <20250210002935.1744249-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210002935.1744249-1-dlemoal@kernel.org>
References: <20250210002935.1744249-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250209_163041_149397_CBCB90BD 
X-CRM114-Status: UNSURE (   9.86  )
X-CRM114-Notice: Please train this message.
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

Reorganized the enum used to define the fields of the contrller
configuration (CC) register in include/linux/nvme.h to:
1) Group together all the values defined for each field.
2) Add the missing field masks definitions.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 include/linux/nvme.h | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index fe3b60818fdc..a1cf63144b1b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -202,24 +202,35 @@ enum {
 enum {
 	NVME_CC_ENABLE		= 1 << 0,
 	NVME_CC_EN_SHIFT	= 0,
+
 	NVME_CC_CSS_SHIFT	= 4,
-	NVME_CC_MPS_SHIFT	= 7,
-	NVME_CC_AMS_SHIFT	= 11,
-	NVME_CC_SHN_SHIFT	= 14,
-	NVME_CC_IOSQES_SHIFT	= 16,
-	NVME_CC_IOCQES_SHIFT	= 20,
+	NVME_CC_CSS_MASK	= 7 << NVME_CC_CSS_SHIFT,
 	NVME_CC_CSS_NVM		= 0 << NVME_CC_CSS_SHIFT,
 	NVME_CC_CSS_CSI		= 6 << NVME_CC_CSS_SHIFT,
-	NVME_CC_CSS_MASK	= 7 << NVME_CC_CSS_SHIFT,
+
+	NVME_CC_MPS_SHIFT	= 7,
+	NVME_CC_MPS_MASK	= 0xf << NVME_CC_MPS_SHIFT,
+
+	NVME_CC_AMS_SHIFT	= 11,
+	NVME_CC_AMS_MASK	= 7 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_RR		= 0 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_WRRU	= 1 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_VS		= 7 << NVME_CC_AMS_SHIFT,
+
+	NVME_CC_SHN_SHIFT	= 14,
+	NVME_CC_SHN_MASK	= 3 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_NONE	= 0 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_NORMAL	= 1 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_ABRUPT	= 2 << NVME_CC_SHN_SHIFT,
-	NVME_CC_SHN_MASK	= 3 << NVME_CC_SHN_SHIFT,
+
+	NVME_CC_IOSQES_SHIFT	= 16,
+	NVME_CC_IOSQES_MASK	= 0xf << NVME_CC_IOSQES_SHIFT,
 	NVME_CC_IOSQES		= NVME_NVM_IOSQES << NVME_CC_IOSQES_SHIFT,
+
+	NVME_CC_IOCQES_SHIFT	= 20,
+	NVME_CC_IOCQES_MASK	= 0xf << NVME_CC_IOCQES_SHIFT,
 	NVME_CC_IOCQES		= NVME_NVM_IOCQES << NVME_CC_IOCQES_SHIFT,
+
 	NVME_CC_CRIME		= 1 << 24,
 };
 
-- 
2.48.1


