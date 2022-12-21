Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA52CC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Dec 2022 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z/riuQ8rf7shGuWnkcmb8HpPE71Nrs/FhW2yT4Ktkyk=; b=Varyp+a58ioZ1wA0anVutQivqz
	4Aw4ZT6A5+hL1u7m2GcTzjJANx58mpQRg2dxnvSkdTQuX5gRAkusBOO1NrpyeDqN+mLWqARw+uDje
	igyipqsPMiYM+v1pEPlRYYbCrbn3hYErBhp5CIxLQS8faPYVwTpkQc3V+zxRfeVHkBMsYC6Qc6A40
	4gtXV4cO4r5L3XcaX/blBHOJyDxsB2pkqQ6SNEZcJJOO1KflWpVa3mrU6+GN2LdOlQ+Fn6o1AiPMp
	zwW34KzdydcQDA/pow7kD3RAAH4CwrUAe0+DSmnE5TsL9V/zom4gPil0JYJy2WuC1ex9jJqw2v3fE
	hB4uScQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p80KL-00FisB-O0; Wed, 21 Dec 2022 14:44:13 +0000
Received: from [2001:4bb8:199:7829:6251:5281:de26:c6d1] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7w3t-00DEIq-2r; Wed, 21 Dec 2022 10:10:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/6] nvme: fix the NVME_CMD_EFFECTS_CSE_MASK definition
Date: Wed, 21 Dec 2022 11:10:45 +0100
Message-Id: <20221221101050.759606-2-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221221101050.759606-1-hch@lst.de>
References: <20221221101050.759606-1-hch@lst.de>
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

3 << 16 does not generate the correct mask for bits 16, 17 and 18.
Use the GENMASK macro to generate the correct mask instead.

Fixes: 84fef62d135b ("nvme: check admin passthru command effects")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/nvme.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d6be2a6861000e..d1cd53f2b6abd9 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -7,6 +7,7 @@
 #ifndef _LINUX_NVME_H
 #define _LINUX_NVME_H
 
+#include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
 
@@ -639,7 +640,7 @@ enum {
 	NVME_CMD_EFFECTS_NCC		= 1 << 2,
 	NVME_CMD_EFFECTS_NIC		= 1 << 3,
 	NVME_CMD_EFFECTS_CCC		= 1 << 4,
-	NVME_CMD_EFFECTS_CSE_MASK	= 3 << 16,
+	NVME_CMD_EFFECTS_CSE_MASK	= GENMASK(18, 16),
 	NVME_CMD_EFFECTS_UUID_SEL	= 1 << 19,
 };
 
-- 
2.35.1


