Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578A9C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Dec 2021 03:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IoAOzQu199jitCRpPWpeDUIrsMhEQLhTqV1OeHiWJ3k=; b=yEoaMliwH+KBfbClcv+WyH0S5G
	Yro2I7bJkhMil4Jv3CQEHUKLO9XJFqkZJW52N056bYs4C4DkIKEHk91xv4jvpeI1hvjMAHczvScus
	Vy1eR/3Vn0WYcX64V5vQnazC+WHd6fANDp+2XYvV4dLZF4RUza5QQnMfJm07nQWvZ6wE9/WfTsDQC
	M0AvupTuyClUAgJ4Fiyy33hPLt6OaTs3EgmuEsu0tCbrpWRxiPAwy0BMLHTlWzTPGy6LYYS7yqaIM
	6tT96wd4GHMsCYDk//NQsjNeOhnLdFUglIYlF2/rMIKEl8PsvJ4NqgnX0JOMVpsZrq9Km4Rd0n6Sd
	VLMoJclA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mscKO-00Aed2-Fv; Thu, 02 Dec 2021 03:00:08 +0000
Received: from smtpbg467.qq.com ([59.36.132.50] helo=qq.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mscKG-00AebZ-RV
 for linux-nvme@lists.infradead.org; Thu, 02 Dec 2021 03:00:03 +0000
X-QQ-mid: bizesmtp43t1638413977t48bc942
Received: from localhost.localdomain (unknown [113.200.76.118])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 02 Dec 2021 10:59:07 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000B00A0000000
X-QQ-FEAT: PdU/eI8FBMB02zViZ6l0lHbSXQYZNl4exvthbl11uU6F1IkkLTJUtjeg6yEkN
 YBA3FCMb894nJjMysqsxuO7DPfcOVGL6htiRCQG8FslOv3na0htSDV3nzzi3wFK4nJtfhpr
 8arMORmmqXaXER8XeWe8U40G+YDgHxVlRyISpyrF4y9NTiZFm+GMIZ028INc9+gBAL/RE6j
 TrHXEGiTwW+K/TykxhC8VEej0PGV8NaP5O5pvUTiAVfh3IT3Bt5eT7EX1aqudYG/vt1K+O+
 VVvq42n8EAHSkHqUcQSWYDj+iMS/S0bk2H0Zvq7ztdGVz5td/RiGvEBqHmGzYYgL6q0FZNO
 a1w9hDsgawX5dRnYCn+Yloc59CPGQ==
X-QQ-GoodBg: 2
From: caojun <caojun@uniontech.com>
To: keith.busch@intel.com,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 caojun <caojun@uniontech.com>
Subject: [PATCH] add Intel 760p/Pro 7600p nvme disk
Date: Thu,  2 Dec 2021 10:58:13 +0800
Message-Id: <20211202025813.15693-1-caojun@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211201_190001_244388_65D00B3F 
X-CRM114-Status: GOOD (  12.17  )
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

Signed-off-by: caojun <caojun@uniontech.com>
---
 drivers/nvme/host/core.c | 16 +++++++++-------
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  |  2 ++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e64310f22..8e0dbfb6a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2155,14 +2155,16 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 	size_t nqnlen;
 	int off;
 
-	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
-	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
-		strncpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
-		return;
-	}
+	if(!(ctrl->quirks & NVME_QUIRK_IGNORE_DEV_SUBNQN)) {
+		nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
+		if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
+			strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
+			return;
+		}
 
-	if (ctrl->vs >= NVME_VS(1, 2, 1))
-		dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
+		if (ctrl->vs >= NVME_VS(1, 2, 1))
+			dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
+	}
 
 	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
 	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 276975506..5f5a91518 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -90,6 +90,11 @@ enum nvme_quirks {
 	 * Set MEDIUM priority on SQ creation
 	 */
 	NVME_QUIRK_MEDIUM_PRIO_SQ		= (1 << 7),
+
+	/*
+	 * Ignore device provided subnqn.
+	 */
+	NVME_QUIRK_IGNORE_DEV_SUBNQN		= (1 << 8),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d7cf3202c..fcac05528 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2713,6 +2713,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_MEDIUM_PRIO_SQ },
+	{ PCI_VDEVICE(INTEL, 0xf1a6),	/* Intel 760p/Pro 7600p */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
-- 
2.20.1




