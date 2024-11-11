Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E54BD3ABCE
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 17:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uh0nQUvxg6+TnkFetevOACRB2nEv0KhooHol7nlAap8=; b=HG0VAAVZ2KtZlnKBfdHJUKNas/
	4MiXM0sWjlxeTNnpWQStAx6PLWmcaTkS3EIXFfY3b5jJtuRBLZVVzZS1X40nFKkSC4HJJcCtVySLU
	1AXAma12/VZeNjVJK7vu3P/W5SxmXMnP1X6H8cnCqPeAz5WrxQqR0NMFNozWokTmbVcAuk+V6vJpe
	62Zcza/cUfX8Rm92CCs7AKIQ5LnaD7FXtV9297LxT621AIj7NTc4UdTDPzAGjmMRX8kB9vEHGD9CY
	KMTm3gPIwsMUU+Kts84b/GJjMXMsSXZnRDY2iDuYxdH9wzWUMUGMhL5AEiyZ+gyvzx5dC5PJ2l60z
	E59FXfWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAXv6-00000000fnu-4Bu3;
	Mon, 11 Nov 2024 17:09:45 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAXv5-00000000fnN-0cAC
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 17:09:44 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-71e5130832aso3635120b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 11 Nov 2024 09:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731344981; x=1731949781; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uh0nQUvxg6+TnkFetevOACRB2nEv0KhooHol7nlAap8=;
        b=ZrFu5x72QzI+NEuRFKH2VK+mj6U5S1g6X5pf1j+N1+GKtBB1zTGXG6/A7tGGBrRt+g
         LvI7kHi5HuJdouCBoH4d+jX7EwdyT3+xNFd529/LVzzMt1URmLt1BOuktxvZWjUcMQh6
         +52LuaybsLlPsvrxRrYXedeYhT2bPxmgvkw5qcijhL3fLQkbl5rziQV+/1FKELRbUTj7
         G7V8RSp6zVvj1mt4aUnjwgkxFHmM8RyQlaoZuEZzqHdr81Q0JWVr8z/0aNc+0b9VIOuk
         /vks+rIsBt9RLDo6nBHiYcBhmgzGDj5jEHWj0mqquUoCIT1Ig8R+vq5ZZgF6dNpA1WSP
         49lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731344981; x=1731949781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uh0nQUvxg6+TnkFetevOACRB2nEv0KhooHol7nlAap8=;
        b=qd5ge4227wEOuuymU0cf/6g+xHLzCYGAaVQ+/UqjTxJWS3+UuG1ec/lZXt+Pnm5oaE
         Ne7FJ+Oy6I/ylPnYLRYIcmgRAx8Gz0y7n5kXlK7U8HizQcQ56GW0VGSZbHyx1iH8TfuT
         SG+JJR++25Iudr3B4Mt+g5+peB+vOB6ORcWLZTZzwRDTJulXyOk59H8G7bzhqvET0Bsj
         +rxvoEn8j43gGm79UcgJnKzbjfkqOUfgAqtOO9k3uhHyxSYDh8pZFsNIrGEF8LXRr0T/
         +qO0qY4FjKkVxka2PtJ8rbpUSzYyeQuEiBNMvgGTQAHGFZUqXt0i2UVqzQHBiYhKbqlv
         KiJQ==
X-Gm-Message-State: AOJu0Yx8sKpktvhx0ilUbZxPzTcRiwtv/G9QnRH7HdyInMGijbmPeDzC
	kUfxadkRPNRO9X6nNoKSTd9mGhg6/ee3dDgBHGiqcu86lUeftWVs7cItcQ==
X-Google-Smtp-Source: AGHT+IGi+4rgYdgAF/4ohwUpFKWb4Y8ghzXAFnOrIVzJHvVEgkA4p7l+Apj70LCJjsTIpuPjzAnZqQ==
X-Received: by 2002:a05:6a00:8d0:b0:714:1d96:e6bd with SMTP id d2e1a72fcca58-724132c4725mr17431252b3a.13.1731344981155;
        Mon, 11 Nov 2024 09:09:41 -0800 (PST)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:5124:544d:ebc3:1364])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7d0fsm9323951b3a.72.2024.11.11.09.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 09:09:40 -0800 (PST)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme: use BIT_MASK and GENMASK for NVME definitions
Date: Tue, 12 Nov 2024 02:09:27 +0900
Message-ID: <20241111170935.4540-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_090943_217592_2BC6D633 
X-CRM114-Status: GOOD (  12.42  )
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

Only some definitions used GENMASK so unify to use it.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 include/linux/nvme.h | 218 +++++++++++++++++++++----------------------
 1 file changed, 109 insertions(+), 109 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b58d9405d65e..b454e370b8b9 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -177,29 +177,28 @@ enum {
 #define NVME_CRTO_CRWMT(crto)	((crto) & 0xffff)
 
 enum {
-	NVME_CMBSZ_SQS		= 1 << 0,
-	NVME_CMBSZ_CQS		= 1 << 1,
-	NVME_CMBSZ_LISTS	= 1 << 2,
-	NVME_CMBSZ_RDS		= 1 << 3,
-	NVME_CMBSZ_WDS		= 1 << 4,
+	NVME_CMBSZ_SQS		= BIT_MASK(0),
+	NVME_CMBSZ_CQS		= BIT_MASK(1),
+	NVME_CMBSZ_LISTS	= BIT_MASK(2),
+	NVME_CMBSZ_RDS		= BIT_MASK(3),
+	NVME_CMBSZ_WDS		= BIT_MASK(4),
 
 	NVME_CMBSZ_SZ_SHIFT	= 12,
-	NVME_CMBSZ_SZ_MASK	= 0xfffff,
+	NVME_CMBSZ_SZ_MASK	= GENMASK(19, 0),
 
 	NVME_CMBSZ_SZU_SHIFT	= 8,
-	NVME_CMBSZ_SZU_MASK	= 0xf,
+	NVME_CMBSZ_SZU_MASK	= GENMASK(3, 0),
 };
 
 /*
  * Submission and Completion Queue Entry Sizes for the NVM command set.
  * (In bytes and specified as a power of two (2^n)).
  */
-#define NVME_ADM_SQES       6
+#define NVME_ADM_SQES		6
 #define NVME_NVM_IOSQES		6
 #define NVME_NVM_IOCQES		4
 
 enum {
-	NVME_CC_ENABLE		= 1 << 0,
 	NVME_CC_EN_SHIFT	= 0,
 	NVME_CC_CSS_SHIFT	= 4,
 	NVME_CC_MPS_SHIFT	= 7,
@@ -207,45 +206,46 @@ enum {
 	NVME_CC_SHN_SHIFT	= 14,
 	NVME_CC_IOSQES_SHIFT	= 16,
 	NVME_CC_IOCQES_SHIFT	= 20,
-	NVME_CC_CSS_NVM		= 0 << NVME_CC_CSS_SHIFT,
+	NVME_CC_ENABLE		= BIT_MASK(NVME_CC_EN_SHIFT),
+	NVME_CC_CSS_NVM		= 0,
 	NVME_CC_CSS_CSI		= 6 << NVME_CC_CSS_SHIFT,
-	NVME_CC_CSS_MASK	= 7 << NVME_CC_CSS_SHIFT,
-	NVME_CC_AMS_RR		= 0 << NVME_CC_AMS_SHIFT,
-	NVME_CC_AMS_WRRU	= 1 << NVME_CC_AMS_SHIFT,
+	NVME_CC_CSS_MASK	= GENMASK(NVME_CC_CSS_SHIFT + 2, NVME_CC_CSS_SHIFT),
+	NVME_CC_AMS_RR		= 0,
+	NVME_CC_AMS_WRRU	= BIT_MASK(NVME_CC_AMS_SHIFT),
 	NVME_CC_AMS_VS		= 7 << NVME_CC_AMS_SHIFT,
-	NVME_CC_SHN_NONE	= 0 << NVME_CC_SHN_SHIFT,
-	NVME_CC_SHN_NORMAL	= 1 << NVME_CC_SHN_SHIFT,
+	NVME_CC_SHN_NONE	= 0,
+	NVME_CC_SHN_NORMAL	= BIT_MASK(NVME_CC_SHN_SHIFT),
 	NVME_CC_SHN_ABRUPT	= 2 << NVME_CC_SHN_SHIFT,
-	NVME_CC_SHN_MASK	= 3 << NVME_CC_SHN_SHIFT,
+	NVME_CC_SHN_MASK	= GENMASK(NVME_CC_SHN_SHIFT + 1, NVME_CC_SHN_SHIFT),
 	NVME_CC_IOSQES		= NVME_NVM_IOSQES << NVME_CC_IOSQES_SHIFT,
 	NVME_CC_IOCQES		= NVME_NVM_IOCQES << NVME_CC_IOCQES_SHIFT,
-	NVME_CC_CRIME		= 1 << 24,
+	NVME_CC_CRIME		= BIT_MASK(24),
 };
 
 enum {
-	NVME_CSTS_RDY		= 1 << 0,
-	NVME_CSTS_CFS		= 1 << 1,
-	NVME_CSTS_NSSRO		= 1 << 4,
-	NVME_CSTS_PP		= 1 << 5,
-	NVME_CSTS_SHST_NORMAL	= 0 << 2,
-	NVME_CSTS_SHST_OCCUR	= 1 << 2,
+	NVME_CSTS_RDY		= BIT_MASK(0),
+	NVME_CSTS_CFS		= BIT_MASK(1),
+	NVME_CSTS_NSSRO		= BIT_MASK(4),
+	NVME_CSTS_PP		= BIT_MASK(5),
+	NVME_CSTS_SHST_NORMAL	= 0,
+	NVME_CSTS_SHST_OCCUR	= BIT_MASK(2),
 	NVME_CSTS_SHST_CMPLT	= 2 << 2,
-	NVME_CSTS_SHST_MASK	= 3 << 2,
+	NVME_CSTS_SHST_MASK	= GENMASK(3, 2),
 };
 
 enum {
-	NVME_CMBMSC_CRE		= 1 << 0,
-	NVME_CMBMSC_CMSE	= 1 << 1,
+	NVME_CMBMSC_CRE		= BIT_MASK(0),
+	NVME_CMBMSC_CMSE	= BIT_MASK(1),
 };
 
 enum {
-	NVME_CAP_CSS_NVM	= 1 << 0,
-	NVME_CAP_CSS_CSI	= 1 << 6,
+	NVME_CAP_CSS_NVM	= BIT_MASK(0),
+	NVME_CAP_CSS_CSI	= BIT_MASK(6),
 };
 
 enum {
-	NVME_CAP_CRMS_CRWMS	= 1ULL << 59,
-	NVME_CAP_CRMS_CRIMS	= 1ULL << 60,
+	NVME_CAP_CRMS_CRWMS	= BIT_ULL_MASK(59),
+	NVME_CAP_CRMS_CRIMS	= BIT_ULL_MASK(60),
 };
 
 struct nvme_id_power_state {
@@ -267,14 +267,14 @@ struct nvme_id_power_state {
 };
 
 enum {
-	NVME_PS_FLAGS_MAX_POWER_SCALE	= 1 << 0,
-	NVME_PS_FLAGS_NON_OP_STATE	= 1 << 1,
+	NVME_PS_FLAGS_MAX_POWER_SCALE	= BIT_MASK(0),
+	NVME_PS_FLAGS_NON_OP_STATE	= BIT_MASK(1),
 };
 
 enum nvme_ctrl_attr {
-	NVME_CTRL_ATTR_HID_128_BIT	= (1 << 0),
-	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
-	NVME_CTRL_ATTR_ELBAS		= (1 << 15),
+	NVME_CTRL_ATTR_HID_128_BIT	= BIT_MASK(0),
+	NVME_CTRL_ATTR_TBKAS		= BIT_MASK(6),
+	NVME_CTRL_ATTR_ELBAS		= BIT_MASK(15),
 };
 
 struct nvme_id_ctrl {
@@ -365,29 +365,29 @@ struct nvme_id_ctrl {
 };
 
 enum {
-	NVME_CTRL_CMIC_MULTI_PORT		= 1 << 0,
-	NVME_CTRL_CMIC_MULTI_CTRL		= 1 << 1,
-	NVME_CTRL_CMIC_ANA			= 1 << 3,
-	NVME_CTRL_ONCS_COMPARE			= 1 << 0,
-	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
-	NVME_CTRL_ONCS_DSM			= 1 << 2,
-	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
-	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
-	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
-	NVME_CTRL_VWC_PRESENT			= 1 << 0,
-	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
-	NVME_CTRL_OACS_NS_MNGT_SUPP		= 1 << 3,
-	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
-	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
-	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= 1 << 1,
-	NVME_CTRL_CTRATT_128_ID			= 1 << 0,
-	NVME_CTRL_CTRATT_NON_OP_PSP		= 1 << 1,
-	NVME_CTRL_CTRATT_NVM_SETS		= 1 << 2,
-	NVME_CTRL_CTRATT_READ_RECV_LVLS		= 1 << 3,
-	NVME_CTRL_CTRATT_ENDURANCE_GROUPS	= 1 << 4,
-	NVME_CTRL_CTRATT_PREDICTABLE_LAT	= 1 << 5,
-	NVME_CTRL_CTRATT_NAMESPACE_GRANULARITY	= 1 << 7,
-	NVME_CTRL_CTRATT_UUID_LIST		= 1 << 9,
+	NVME_CTRL_CMIC_MULTI_PORT		= BIT_MASK(0),
+	NVME_CTRL_CMIC_MULTI_CTRL		= BIT_MASK(1),
+	NVME_CTRL_CMIC_ANA			= BIT_MASK(3),
+	NVME_CTRL_ONCS_COMPARE			= BIT_MASK(0),
+	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= BIT_MASK(1),
+	NVME_CTRL_ONCS_DSM			= BIT_MASK(2),
+	NVME_CTRL_ONCS_WRITE_ZEROES		= BIT_MASK(3),
+	NVME_CTRL_ONCS_RESERVATIONS		= BIT_MASK(5),
+	NVME_CTRL_ONCS_TIMESTAMP		= BIT_MASK(6),
+	NVME_CTRL_VWC_PRESENT			= BIT_MASK(0),
+	NVME_CTRL_OACS_SEC_SUPP			= BIT_MASK(0),
+	NVME_CTRL_OACS_NS_MNGT_SUPP		= BIT_MASK(3),
+	NVME_CTRL_OACS_DIRECTIVES		= BIT_MASK(5),
+	NVME_CTRL_OACS_DBBUF_SUPP		= BIT_MASK(8),
+	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= BIT_MASK(1),
+	NVME_CTRL_CTRATT_128_ID			= BIT_MASK(0),
+	NVME_CTRL_CTRATT_NON_OP_PSP		= BIT_MASK(1),
+	NVME_CTRL_CTRATT_NVM_SETS		= BIT_MASK(2),
+	NVME_CTRL_CTRATT_READ_RECV_LVLS		= BIT_MASK(3),
+	NVME_CTRL_CTRATT_ENDURANCE_GROUPS	= BIT_MASK(4),
+	NVME_CTRL_CTRATT_PREDICTABLE_LAT	= BIT_MASK(5),
+	NVME_CTRL_CTRATT_NAMESPACE_GRANULARITY	= BIT_MASK(7),
+	NVME_CTRL_CTRATT_UUID_LIST		= BIT_MASK(9),
 };
 
 struct nvme_lbaf {
@@ -482,12 +482,12 @@ struct nvme_id_ns_nvm {
 };
 
 enum {
-	NVME_ID_NS_NVM_STS_MASK		= 0x7f,
+	NVME_ID_NS_NVM_STS_MASK		= GENMASK(6, 0),
 	NVME_ID_NS_NVM_GUARD_SHIFT	= 7,
-	NVME_ID_NS_NVM_GUARD_MASK	= 0x3,
+	NVME_ID_NS_NVM_GUARD_MASK	= GENMASK(1, 0),
 	NVME_ID_NS_NVM_QPIF_SHIFT	= 9,
-	NVME_ID_NS_NVM_QPIF_MASK	= 0xf,
-	NVME_ID_NS_NVM_QPIFS		= 1 << 3,
+	NVME_ID_NS_NVM_QPIF_MASK	= GENMASK(3, 0),
+	NVME_ID_NS_NVM_QPIFS		= BIT_MASK(3),
 };
 
 static inline __u8 nvme_elbaf_sts(__u32 elbaf)
@@ -551,33 +551,33 @@ enum {
 };
 
 enum {
-	NVME_NS_FEAT_THIN	= 1 << 0,
-	NVME_NS_FEAT_ATOMICS	= 1 << 1,
-	NVME_NS_FEAT_IO_OPT	= 1 << 4,
-	NVME_NS_ATTR_RO		= 1 << 0,
-	NVME_NS_FLBAS_LBA_MASK	= 0xf,
+	NVME_NS_FEAT_THIN	= BIT_MASK(0),
+	NVME_NS_FEAT_ATOMICS	= BIT_MASK(1),
+	NVME_NS_FEAT_IO_OPT	= BIT_MASK(4),
+	NVME_NS_ATTR_RO		= BIT_MASK(0),
+	NVME_NS_FLBAS_LBA_MASK	= GENMASK(3, 0),
 	NVME_NS_FLBAS_LBA_UMASK	= 0x60,
 	NVME_NS_FLBAS_LBA_SHIFT	= 1,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
-	NVME_NS_NMIC_SHARED	= 1 << 0,
+	NVME_NS_NMIC_SHARED	= BIT_MASK(0),
 	NVME_LBAF_RP_BEST	= 0,
 	NVME_LBAF_RP_BETTER	= 1,
 	NVME_LBAF_RP_GOOD	= 2,
 	NVME_LBAF_RP_DEGRADED	= 3,
-	NVME_NS_DPC_PI_LAST	= 1 << 4,
-	NVME_NS_DPC_PI_FIRST	= 1 << 3,
-	NVME_NS_DPC_PI_TYPE3	= 1 << 2,
-	NVME_NS_DPC_PI_TYPE2	= 1 << 1,
-	NVME_NS_DPC_PI_TYPE1	= 1 << 0,
-	NVME_NS_DPS_PI_FIRST	= 1 << 3,
-	NVME_NS_DPS_PI_MASK	= 0x7,
+	NVME_NS_DPC_PI_LAST	= BIT_MASK(4),
+	NVME_NS_DPC_PI_FIRST	= BIT_MASK(3),
+	NVME_NS_DPC_PI_TYPE3	= BIT_MASK(2),
+	NVME_NS_DPC_PI_TYPE2	= BIT_MASK(1),
+	NVME_NS_DPC_PI_TYPE1	= BIT_MASK(0),
+	NVME_NS_DPS_PI_FIRST	= BIT_MASK(3),
+	NVME_NS_DPS_PI_MASK	= GENMASK(2, 0),
 	NVME_NS_DPS_PI_TYPE1	= 1,
 	NVME_NS_DPS_PI_TYPE2	= 2,
 	NVME_NS_DPS_PI_TYPE3	= 3,
 };
 
 enum {
-	NVME_NSTAT_NRDY		= 1 << 0,
+	NVME_NSTAT_NRDY		= BIT_MASK(0),
 };
 
 enum {
@@ -595,8 +595,8 @@ static inline __u8 nvme_lbaf_index(__u8 flbas)
 
 /* Identify Namespace Metadata Capabilities (MC): */
 enum {
-	NVME_MC_EXTENDED_LBA	= (1 << 0),
-	NVME_MC_METADATA_PTR	= (1 << 1),
+	NVME_MC_EXTENDED_LBA	= BIT_MASK(0),
+	NVME_MC_METADATA_PTR	= BIT_MASK(1),
 };
 
 struct nvme_ns_id_desc {
@@ -653,14 +653,14 @@ struct nvme_fw_slot_info_log {
 };
 
 enum {
-	NVME_CMD_EFFECTS_CSUPP		= 1 << 0,
-	NVME_CMD_EFFECTS_LBCC		= 1 << 1,
-	NVME_CMD_EFFECTS_NCC		= 1 << 2,
-	NVME_CMD_EFFECTS_NIC		= 1 << 3,
-	NVME_CMD_EFFECTS_CCC		= 1 << 4,
+	NVME_CMD_EFFECTS_CSUPP		= BIT_MASK(0),
+	NVME_CMD_EFFECTS_LBCC		= BIT_MASK(1),
+	NVME_CMD_EFFECTS_NCC		= BIT_MASK(2),
+	NVME_CMD_EFFECTS_NIC		= BIT_MASK(3),
+	NVME_CMD_EFFECTS_CCC		= BIT_MASK(4),
 	NVME_CMD_EFFECTS_CSER_MASK	= GENMASK(15, 14),
 	NVME_CMD_EFFECTS_CSE_MASK	= GENMASK(18, 16),
-	NVME_CMD_EFFECTS_UUID_SEL	= 1 << 19,
+	NVME_CMD_EFFECTS_UUID_SEL	= BIT_MASK(19),
 	NVME_CMD_EFFECTS_SCOPE_MASK	= GENMASK(31, 20),
 };
 
@@ -992,9 +992,9 @@ struct nvme_rw_command {
 };
 
 enum {
-	NVME_RW_LR			= 1 << 15,
-	NVME_RW_FUA			= 1 << 14,
-	NVME_RW_APPEND_PIREMAP		= 1 << 9,
+	NVME_RW_LR			= BIT_MASK(15),
+	NVME_RW_FUA			= BIT_MASK(14),
+	NVME_RW_APPEND_PIREMAP		= BIT_MASK(9),
 	NVME_RW_DSM_FREQ_UNSPEC		= 0,
 	NVME_RW_DSM_FREQ_TYPICAL	= 1,
 	NVME_RW_DSM_FREQ_RARE		= 2,
@@ -1004,18 +1004,18 @@ enum {
 	NVME_RW_DSM_FREQ_ONCE		= 6,
 	NVME_RW_DSM_FREQ_PREFETCH	= 7,
 	NVME_RW_DSM_FREQ_TEMP		= 8,
-	NVME_RW_DSM_LATENCY_NONE	= 0 << 4,
-	NVME_RW_DSM_LATENCY_IDLE	= 1 << 4,
+	NVME_RW_DSM_LATENCY_NONE	= 0,
+	NVME_RW_DSM_LATENCY_IDLE	= BIT_MASK(4),
 	NVME_RW_DSM_LATENCY_NORM	= 2 << 4,
 	NVME_RW_DSM_LATENCY_LOW		= 3 << 4,
-	NVME_RW_DSM_SEQ_REQ		= 1 << 6,
-	NVME_RW_DSM_COMPRESSED		= 1 << 7,
-	NVME_RW_PRINFO_PRCHK_REF	= 1 << 10,
-	NVME_RW_PRINFO_PRCHK_APP	= 1 << 11,
-	NVME_RW_PRINFO_PRCHK_GUARD	= 1 << 12,
-	NVME_RW_PRINFO_PRACT		= 1 << 13,
-	NVME_RW_DTYPE_STREAMS		= 1 << 4,
-	NVME_WZ_DEAC			= 1 << 9,
+	NVME_RW_DSM_SEQ_REQ		= BIT_MASK(6),
+	NVME_RW_DSM_COMPRESSED		= BIT_MASK(7),
+	NVME_RW_PRINFO_PRCHK_REF	= BIT_MASK(10),
+	NVME_RW_PRINFO_PRCHK_APP	= BIT_MASK(11),
+	NVME_RW_PRINFO_PRCHK_GUARD	= BIT_MASK(12),
+	NVME_RW_PRINFO_PRACT		= BIT_MASK(13),
+	NVME_RW_DTYPE_STREAMS		= BIT_MASK(4),
+	NVME_WZ_DEAC			= BIT_MASK(9),
 };
 
 struct nvme_dsm_cmd {
@@ -1118,9 +1118,9 @@ enum {
 /* Features */
 
 enum {
-	NVME_TEMP_THRESH_MASK		= 0xffff,
+	NVME_TEMP_THRESH_MASK		= GENMASK(15, 0),
 	NVME_TEMP_THRESH_SELECT_SHIFT	= 16,
-	NVME_TEMP_THRESH_TYPE_UNDER	= 0x100000,
+	NVME_TEMP_THRESH_TYPE_UNDER	= BIT_MASK(20),
 };
 
 struct nvme_feat_auto_pst {
@@ -1128,8 +1128,8 @@ struct nvme_feat_auto_pst {
 };
 
 enum {
-	NVME_HOST_MEM_ENABLE	= (1 << 0),
-	NVME_HOST_MEM_RETURN	= (1 << 1),
+	NVME_HOST_MEM_ENABLE	= BIT_MASK(0),
+	NVME_HOST_MEM_RETURN	= BIT_MASK(1),
 };
 
 struct nvme_feat_host_behavior {
@@ -1209,10 +1209,10 @@ enum nvme_admin_opcode {
 		nvme_admin_opcode_name(nvme_admin_get_lba_status))
 
 enum {
-	NVME_QUEUE_PHYS_CONTIG	= (1 << 0),
-	NVME_CQ_IRQ_ENABLED	= (1 << 1),
-	NVME_SQ_PRIO_URGENT	= (0 << 1),
-	NVME_SQ_PRIO_HIGH	= (1 << 1),
+	NVME_QUEUE_PHYS_CONTIG	= BIT_MASK(0),
+	NVME_CQ_IRQ_ENABLED	= BIT_MASK(1),
+	NVME_SQ_PRIO_URGENT	= 0,
+	NVME_SQ_PRIO_HIGH	= BIT_MASK(1),
 	NVME_SQ_PRIO_MEDIUM	= (2 << 1),
 	NVME_SQ_PRIO_LOW	= (3 << 1),
 	NVME_FEAT_ARBITRATION	= 0x01,
@@ -1256,8 +1256,8 @@ enum {
 	NVME_LOG_ANA		= 0x0c,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
-	NVME_FWACT_REPL		= (0 << 3),
-	NVME_FWACT_REPL_ACTV	= (1 << 3),
+	NVME_FWACT_REPL		= 0,
+	NVME_FWACT_REPL_ACTV	= BIT_MASK(3),
 	NVME_FWACT_ACTV		= (2 << 3),
 };
 
@@ -2004,8 +2004,8 @@ enum {
 	NVME_SC_HOST_PATH_ERROR		= 0x370,
 	NVME_SC_HOST_ABORTED_CMD	= 0x371,
 
-	NVME_SC_MASK			= 0x00ff, /* Status Code */
-	NVME_SCT_MASK			= 0x0700, /* Status Code Type */
+	NVME_SC_MASK			= GENMASK(7, 0), /* Status Code */
+	NVME_SCT_MASK			= GENMASK(10, 8), /* Status Code Type */
 	NVME_SCT_SC_MASK		= NVME_SCT_MASK | NVME_SC_MASK,
 
 	NVME_STATUS_CRD			= 0x1800, /* Command Retry Delayed */
-- 
2.45.2


