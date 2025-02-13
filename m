Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7CFC021A7
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s388I+p71OE5QlO1VAVJCfACoeuiSiKECxZkXGonsGE=; b=47eEjW1aBi1EQrlfqH1v2DBD3F
	PQQ18VFJXTzUV+Lg+F1jJ/JYoBeTvvja/Zk1IG02+MdvZFiESoP7ak3yG4vCSxBd4GTEpfCHmCXeZ
	1hW7Ogpbk1uVKlPyuBmR9eTGDQe68xEMjw2GVn6JFsGhCMwE5C74qe9efKUFFZv2xsvG6AlgNBsGk
	I/mC6CE0H/xI6Ns90T0+NkTaKPr/hiRVsFkWfBZ7NbiqjkpCRPaWXEwLrgdrLsViXHjdM1dWvCm5W
	Qb4U9jTgTLi/5vtuNe4afzOJSQehlvd2eU3YBD2o1Kcw3XCt+6h2r9xcecxYf8vg6BY17hDH26c3F
	68Gg+jow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT31-00000009zf2-1Ty7;
	Thu, 13 Feb 2025 06:50:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT2y-00000009zdu-2HVx
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 06:50:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7CFE25C4840;
	Thu, 13 Feb 2025 06:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AE3C4CED1;
	Thu, 13 Feb 2025 06:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739429403;
	bh=M3OpaQFgQPV76u2abwZHYDoGaoTn/smSdddHliynpgk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B23PRg0jo+Ir79ld4NC59RpK5oe5hDRqrIMXYK4WH72hmExABh3OMtoFV0ZZkhUGI
	 Top/Dx81EjvhhpgauwdJsEPD98Kxo2wRTddFQ1Y2pyeUmTUXFBwQjX2vWHCVyBVnkP
	 xn8Z+lNNOPftHEC433C7FrXhlVGDg1OPL1F0Xi2hRlgHYD4wZveDdmjmgxhJQjDDbH
	 XKpMwOE8Aj+gjARrbZgzeubVJ3tLheVo4cuAznWSgNVXS3m1640y6tbmUey8V65qMQ
	 MIGV1swuj+D3QCRBRPiC/gzoVM2OhTesAc6fN42n8QLvoN9bvS14ijB8OqVCwHns1/
	 3QZCwJgeyCq+A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 1/2] nvme: Cleanup the definition of the controller config register fields
Date: Thu, 13 Feb 2025 15:49:59 +0900
Message-ID: <20250213065000.598443-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213065000.598443-1-dlemoal@kernel.org>
References: <20250213065000.598443-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_225004_669705_3925F9F9 
X-CRM114-Status: GOOD (  11.43  )
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
3) Add comments to describe the enum and each field.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 include/linux/nvme.h | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index fe3b60818fdc..2dc05b1c3283 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -199,28 +199,54 @@ enum {
 #define NVME_NVM_IOSQES		6
 #define NVME_NVM_IOCQES		4
 
+/*
+ * Controller Configuration (CC) register (Offset 14h)
+ */
 enum {
+	/* Enable (EN): bit 0 */
 	NVME_CC_ENABLE		= 1 << 0,
 	NVME_CC_EN_SHIFT	= 0,
+
+	/* Bits 03:01 are reserved (NVMe Base Specification rev 2.1) */
+
+	/* I/O Command Set Selected (CSS): bits 06:04 */
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
+	/* Memory Page Size (MPS): bits 10:07 */
+	NVME_CC_MPS_SHIFT	= 7,
+	NVME_CC_MPS_MASK	= 0xf << NVME_CC_MPS_SHIFT,
+
+	/* Arbitration Mechanism Selected (AMS): bits 13:11 */
+	NVME_CC_AMS_SHIFT	= 11,
+	NVME_CC_AMS_MASK	= 7 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_RR		= 0 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_WRRU	= 1 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_VS		= 7 << NVME_CC_AMS_SHIFT,
+
+	/* Shutdown Notification (SHN): bits 15:14 */
+	NVME_CC_SHN_SHIFT	= 14,
+	NVME_CC_SHN_MASK	= 3 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_NONE	= 0 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_NORMAL	= 1 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_ABRUPT	= 2 << NVME_CC_SHN_SHIFT,
-	NVME_CC_SHN_MASK	= 3 << NVME_CC_SHN_SHIFT,
+
+	/* I/O Submission Queue Entry Size (IOSQES): bits 19:16 */
+	NVME_CC_IOSQES_SHIFT	= 16,
+	NVME_CC_IOSQES_MASK	= 0xf << NVME_CC_IOSQES_SHIFT,
 	NVME_CC_IOSQES		= NVME_NVM_IOSQES << NVME_CC_IOSQES_SHIFT,
+
+	/* I/O Completion Queue Entry Size (IOCQES): bits 23:20 */
+	NVME_CC_IOCQES_SHIFT	= 20,
+	NVME_CC_IOCQES_MASK	= 0xf << NVME_CC_IOCQES_SHIFT,
 	NVME_CC_IOCQES		= NVME_NVM_IOCQES << NVME_CC_IOCQES_SHIFT,
+
+	/* Controller Ready Independent of Media Enable (CRIME): bit 24 */
 	NVME_CC_CRIME		= 1 << 24,
+
+	/* Bits 25:31 are reserved (NVMe Base Specification rev 2.1) */
 };
 
 enum {
-- 
2.48.1


