Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F0BC0219D
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 00:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PTKlRpsfBTnSoIRd3+bZw+wyRYrX/B7jX0hrKNFmvyc=; b=rL/0K8z4ZZJLFEb6xclAJ98LTj
	BCcyZ5UK6/sKluh7oYxG/veINhLxVgPvbBwcyZ1RicVwjfX0wBOLeFT0XcJxYbQhtPLu6AisbJxh6
	Vl1FqpSKTqjP75RHopthkpFf6GUt6ZRyalY7MkzJuG/IB+ORRyIqab8dlZQWP+GbkTHHmTFqWQNxm
	WL1ZI0zFvx+9UKqGQ2lCvGPER+cQQPh7SWSVisKCuvWsNpiMHnaDIvXnVI5+zRt2wcck6u3UFRoKE
	e0WFphUVqrePvqP24JBZm4EWA2lTsXNY8y8WWCYPV2hLy8kAMP8sgJ92/4NmKXj/2YKg6xj7bPnPt
	tN0AUASg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thHhF-0000000FqW7-38v6;
	Mon, 10 Feb 2025 00:30:45 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thHhC-0000000FqSb-0GJa
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 00:30:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AEB29A40140;
	Mon, 10 Feb 2025 00:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6DCC4CEE7;
	Mon, 10 Feb 2025 00:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739147441;
	bh=uhgvXVoOSWBU3WaGZh6Uudt7a8W2VmjQesvft83g5bA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h2woIAanQ875h0Wj6IH5uopopM6NPgpKijZdaaUJAlNpcuqQAauEMYcYlYUoFLZWi
	 vTpLzFLgkmilsgX33qxQMkWA9MYsILLpPQ+mHVw6BJGrO0gKqzgDmMBgDOcea/H6z0
	 7GrEqf68jnPPlB+qv9c1scCXgoU+xKNJlikHfyYqi+yaVqu9u8RHcpGJoJkXE6S1eB
	 WCDFwDLYXYIX0bcxNKd56ZL84mT1wLPuhuDmbdrC1pD/PLzHtzSFa5lD37EXC0j4uu
	 +s2sqrAsK9tDi7GfSTB/7omFEAU2U3oXO61/wW+UDL2xBUhAAQjOitRqi3bpEL1p2I
	 JsHt1jwTbpOCw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 2/2] nvmet: Use enum definitions instead of hardcoded values
Date: Mon, 10 Feb 2025 09:29:35 +0900
Message-ID: <20250210002935.1744249-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210002935.1744249-1-dlemoal@kernel.org>
References: <20250210002935.1744249-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250209_163042_168911_E6D3D6CA 
X-CRM114-Status: UNSURE (   9.14  )
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

Change the definition of the inline functions nvmet_cc_en(),
nvmet_cc_css(), nvmet_cc_mps(), nvmet_cc_ams(), nvmet_cc_shn(),
nvmet_cc_iosqes(), and nvmet_cc_iocqes() to use the enum difinitions in
include/linux/nvme.h instead of hardcoded values.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/nvmet.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 4be8d22d2d8d..d2c1233981e1 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -784,37 +784,37 @@ u16 nvmet_report_invalid_opcode(struct nvmet_req *req);
 
 static inline bool nvmet_cc_en(u32 cc)
 {
-	return (cc >> NVME_CC_EN_SHIFT) & 0x1;
+	return (cc & NVME_CC_ENABLE) >> NVME_CC_EN_SHIFT;
 }
 
 static inline u8 nvmet_cc_css(u32 cc)
 {
-	return (cc >> NVME_CC_CSS_SHIFT) & 0x7;
+	return (cc & NVME_CC_CSS_MASK) >> NVME_CC_CSS_SHIFT;
 }
 
 static inline u8 nvmet_cc_mps(u32 cc)
 {
-	return (cc >> NVME_CC_MPS_SHIFT) & 0xf;
+	return (cc & NVME_CC_MPS_MASK) >> NVME_CC_MPS_SHIFT;
 }
 
 static inline u8 nvmet_cc_ams(u32 cc)
 {
-	return (cc >> NVME_CC_AMS_SHIFT) & 0x7;
+	return (cc & NVME_CC_AMS_MASK) >> NVME_CC_AMS_SHIFT;
 }
 
 static inline u8 nvmet_cc_shn(u32 cc)
 {
-	return (cc >> NVME_CC_SHN_SHIFT) & 0x3;
+	return (cc & NVME_CC_SHN_MASK) >> NVME_CC_SHN_SHIFT;
 }
 
 static inline u8 nvmet_cc_iosqes(u32 cc)
 {
-	return (cc >> NVME_CC_IOSQES_SHIFT) & 0xf;
+	return (cc & NVME_CC_IOSQES_MASK) >> NVME_CC_IOSQES_SHIFT;
 }
 
 static inline u8 nvmet_cc_iocqes(u32 cc)
 {
-	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
+	return (cc & NVME_CC_IOCQES_MASK) >> NVME_CC_IOCQES_SHIFT;
 }
 
 /* Convert a 32-bit number to a 16-bit 0's based number */
-- 
2.48.1


