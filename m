Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD2DC021A9
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1i9Emcjb5DhCu1sDTCj+JPR09cf1qiZQ3FbAGwk5+s0=; b=K9pb8RUslV8UnSh9BrorJz9fQC
	xVcBH3J7CFlONNAaxtN7jjQ/e+48cyVXDdndU1YGkP20IyNRc8My2HueQnt2RUu4eFVxg8vKvOkPP
	WL3W2SDSMVRdff+Tlmi0/JH98NCG38Viv6OFmUw3w+q8srrCq8VAG/WvpUe9fz9RBnwJKCY2J+wxu
	NVQXyLQ1CZxQ4qdxl+YLTeLZ/kJ5AbvwTXAdCayewRTPFDc8MsYzDtNkKT1X4YDj3IPpZy3ro7hZW
	f4BrjAztCRAcSX7+UuK1CSYLiRvH35bQJUCq+MJ94LMoe7MPA4uvc60uxJdbndBU3nPGsJ4wbIVMo
	JHtDjdtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT31-00000009zfU-3ueb;
	Thu, 13 Feb 2025 06:50:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT2z-00000009zeG-26VJ
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 06:50:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 80DD45C48F5;
	Thu, 13 Feb 2025 06:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B6FC4CEE7;
	Thu, 13 Feb 2025 06:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739429404;
	bh=l6tERJa7GsXWcJS7/PXHwkkqQQZVOyWrK35zhmux718=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Z5HOrqNFLWgj7lRlCC49LYLyT9hbjFPvFsmtAPh2aNVWbgyQ72bts+Hm0xS42I+mA
	 3+XGHjtvTibpM7lYktf7atYWmmdaJgHVTDk+HVSNR2Fsk62S0ZMyCGojwAqUqpvJ1+
	 FD1hhLKIcZaENecgFLA/j9v8GQVyGCWC/a1c6h2sPGQZFcwCdizedZDsV9fhRkaCk8
	 RRjjU0NP82hBV6PN2GVKyqPZdFiXLdkyAhT9vxDHGmL9mkyXxuHIymDqzw+miX8g40
	 b/+WBeq6BQc2DHxYkFyJI4TKScN/q+6z1xU6aukJIVBe7gyDM2bA5p/5RweQn68A+1
	 lOoEfEwl/8M/Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 2/2] nvmet: Use enum definitions instead of hardcoded values
Date: Thu, 13 Feb 2025 15:50:00 +0900
Message-ID: <20250213065000.598443-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213065000.598443-1-dlemoal@kernel.org>
References: <20250213065000.598443-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_225005_581643_8C590B52 
X-CRM114-Status: UNSURE (   8.60  )
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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


