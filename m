Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F8DE77183
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 11:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tsCutuI8Hn3MWvJYnjmPdzQAX2S7AWluOqUK+WqkRQE=; b=SyQOxo/F+vFgPi4Mm97M0ncpvf
	eeUiEIXnxKc7bTdB+KoUQLsnwRV7Ym7wSISFuR4a0oTJDU06u3NaH1vItDxtDGRgm2z8Y+/LI3qMZ
	U2l6Jt19UqmF833BI63bldlijawHxPb4LoU3S6Jp7WLr4SEr3sPk62wXnwLufYzxSZqmlHHVXvLga
	+u80ax3jeOoEhyQ6mXLquKjOqbWDD0zQ4IML3WCI1InxD8e3uE0BpOu1qL1efV/pBXFlIAZHtMuEY
	jWhdl1T8EsohAEg8fiCR+xEtkMmofe1sd6c/1G7bto6eAKUYmce1GDFuszmyFLCEQdG+pezoeqvWW
	2B1zbjFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLhUO-00000000DO3-3nGl;
	Thu, 12 Dec 2024 11:36:16 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLhTN-00000000Cr2-37DY
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 11:35:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C8F69A42770;
	Thu, 12 Dec 2024 11:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BE0C4CEDD;
	Thu, 12 Dec 2024 11:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734003312;
	bh=LCdJhbh9sa35egWXE9gEmBxg9VBjHkPXT4o+hzVpsMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=osU0MxmA/A9Cj5pY/+0beHzY2LlDtKD1IX6sfw1G/CtfSXQPnU8n0AaciYvqZgDMJ
	 E3oaW740wT9fztqwhFvEa4Y2ll7IudaNXyy1f2fYaQ5zFbh2lI+PAsG2XRhfHxGfl8
	 jewNugnfZrMH6VG35ELWfMi6raqKXx8050b8riE2prXj/Z/mSxDoZ78ykooqGoxsJE
	 1g92C69YCMWGqmD2E2TMBo/n8EsMhLuwNx1G3rdzAECV1bORHDHL7uu5olJ2TFjFVV
	 7ZDSzqjqWCUfeAzyLC2y9iEJfwBKwba86FhT3a282i9N5qLXEsY0o47HSbhux3iXUb
	 eMfXrFmsrFbww==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 03/18] nvmet: Export nvmet_update_cc() and nvmet_cc_xxx() helpers
Date: Thu, 12 Dec 2024 20:34:25 +0900
Message-ID: <20241212113440.352958-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212113440.352958-1-dlemoal@kernel.org>
References: <20241212113440.352958-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_033513_907933_C8A82C78 
X-CRM114-Status: UNSURE (   9.83  )
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

Make the function nvmet_update_cc() available to target drivers by
exporting it. To also facilitate the manipulation of the cc register
bits, move the inline helper functions nvmet_cc_en(), nvmet_cc_css(),
nvmet_cc_mps(), nvmet_cc_ams(), nvmet_cc_shn(), nvmet_cc_iosqes(), and
nvmet_cc_iocqes() from core.c to nvmet.h so that these functions can be
reused in target controller drivers.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/core.c  | 36 +-----------------------------------
 drivers/nvme/target/nvmet.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1f4e9989663b..4b5594549ae6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1166,41 +1166,6 @@ void nvmet_req_free_sgls(struct nvmet_req *req)
 }
 EXPORT_SYMBOL_GPL(nvmet_req_free_sgls);
 
-static inline bool nvmet_cc_en(u32 cc)
-{
-	return (cc >> NVME_CC_EN_SHIFT) & 0x1;
-}
-
-static inline u8 nvmet_cc_css(u32 cc)
-{
-	return (cc >> NVME_CC_CSS_SHIFT) & 0x7;
-}
-
-static inline u8 nvmet_cc_mps(u32 cc)
-{
-	return (cc >> NVME_CC_MPS_SHIFT) & 0xf;
-}
-
-static inline u8 nvmet_cc_ams(u32 cc)
-{
-	return (cc >> NVME_CC_AMS_SHIFT) & 0x7;
-}
-
-static inline u8 nvmet_cc_shn(u32 cc)
-{
-	return (cc >> NVME_CC_SHN_SHIFT) & 0x3;
-}
-
-static inline u8 nvmet_cc_iosqes(u32 cc)
-{
-	return (cc >> NVME_CC_IOSQES_SHIFT) & 0xf;
-}
-
-static inline u8 nvmet_cc_iocqes(u32 cc)
-{
-	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
-}
-
 static inline bool nvmet_css_supported(u8 cc_css)
 {
 	switch (cc_css << NVME_CC_CSS_SHIFT) {
@@ -1277,6 +1242,7 @@ void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new)
 		ctrl->csts &= ~NVME_CSTS_SHST_CMPLT;
 	mutex_unlock(&ctrl->lock);
 }
+EXPORT_SYMBOL_GPL(nvmet_update_cc);
 
 static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e4a31a37c14b..e68f1927339c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -732,6 +732,41 @@ void nvmet_passthrough_override_cap(struct nvmet_ctrl *ctrl);
 u16 errno_to_nvme_status(struct nvmet_req *req, int errno);
 u16 nvmet_report_invalid_opcode(struct nvmet_req *req);
 
+static inline bool nvmet_cc_en(u32 cc)
+{
+	return (cc >> NVME_CC_EN_SHIFT) & 0x1;
+}
+
+static inline u8 nvmet_cc_css(u32 cc)
+{
+	return (cc >> NVME_CC_CSS_SHIFT) & 0x7;
+}
+
+static inline u8 nvmet_cc_mps(u32 cc)
+{
+	return (cc >> NVME_CC_MPS_SHIFT) & 0xf;
+}
+
+static inline u8 nvmet_cc_ams(u32 cc)
+{
+	return (cc >> NVME_CC_AMS_SHIFT) & 0x7;
+}
+
+static inline u8 nvmet_cc_shn(u32 cc)
+{
+	return (cc >> NVME_CC_SHN_SHIFT) & 0x3;
+}
+
+static inline u8 nvmet_cc_iosqes(u32 cc)
+{
+	return (cc >> NVME_CC_IOSQES_SHIFT) & 0xf;
+}
+
+static inline u8 nvmet_cc_iocqes(u32 cc)
+{
+	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
+}
+
 /* Convert a 32-bit number to a 16-bit 0's based number */
 static inline __le16 to0based(u32 a)
 {
-- 
2.47.1


