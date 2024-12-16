Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF06E7717F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZROgGiSS8n3KNKYhqRXBR2PT5JriCeyXWK5pt7Zm32g=; b=hZnua44i+RpLWvYur/+N1rnl50
	VNLcIAoH4pEYfRmHNfSEUvyXlCorRcDBFD80iwLzdunDHDdw8w8S4xx3xJ07ZZ5wH9ysS8fvS/8om
	hzVnvEJ9O1GhcUw2nY76H2rRlB5QaHFdjFJUJgmRE0b9He5FMsxUNx+iFQMcAnuH3jFq3VfeMRgZP
	t/PZQxMBsp1f7BiSVCY3A8PK6Vaa04EJmMMUv/7R22/9DqEOSt1HnMJPebSXJZWIf8FA4zbO4W+Tj
	mbrVj3j2AoCT90RRdSIs4LOStpmKSe71/w0o/zjMkVRj4w8kO/Fekn0vcapeRxZLsnFu1+ksJFEFB
	whwSor1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tND3T-0000000APid-27T1;
	Mon, 16 Dec 2024 15:30:43 +0000
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tND2q-0000000APcQ-2sV4
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 15:30:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZROgGiSS8n3KNKYhqRXBR2PT5JriCeyXWK5pt7Zm32g=;
  b=QVSRFAeCyHFzR40wkzWtUpUwK8yEPhqvFwsE4/Dcdm3dECDxjpPh7KUj
   AneApQ3zJuzHKNScViNS5p7eSFMNzKnlFTb+NUKfHoOaTOBoPQErX5MxS
   R2FmDhMGLgMvqISg1Fz6tXOFwJagRBgj8t3Rki2vp6P7DbKtYY5zV1AUP
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.12,238,1728943200"; 
   d="scan'208";a="199445658"
Received: from nr-lil-536.grid5000.fr (HELO gros-90.nancy.grid5000.fr) ([194.254.60.35])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 16:29:59 +0100
From: Keisuke Nishimura <keisuke.nishimura@inria.fr>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Keisuke Nishimura <keisuke.nishimura@inria.fr>
Subject: [PATCH v2] nvme: Add error path for xa_store in nvme_init_effects
Date: Mon, 16 Dec 2024 16:27:20 +0100
Message-Id: <20241216152719.17923-1-keisuke.nishimura@inria.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_073006_057362_D578348C 
X-CRM114-Status: GOOD (  13.33  )
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

The xa_store() may fail due to memory allocation failure because there
is no guarantee that the index NVME_CSI_NVM is already used. This fix
introduces a new function to handle the error path.

Fixes: cc115cbe12d9 ("nvme: always initialize known command effects")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
---
 drivers/nvme/host/core.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 758de89b47b4..ce8b70dc45b2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3173,6 +3173,25 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
+static int nvme_init_effects_log(struct nvme_ctrl *ctrl,
+		u8 csi, struct nvme_effects_log **log)
+{
+	struct nvme_effects_log *effects, *old;
+
+	effects = kzalloc(sizeof(*effects), GFP_KERNEL);
+	if (effects)
+		return -ENOMEM;
+
+	old = xa_store(&ctrl->cels, csi, effects, GFP_KERNEL);
+	if (xa_is_err(old)) {
+		kfree(effects);
+		return xa_err(old);
+	}
+
+	*log = effects;
+	return 0;
+}
+
 static void nvme_init_known_nvm_effects(struct nvme_ctrl *ctrl)
 {
 	struct nvme_effects_log	*log = ctrl->effects;
@@ -3219,10 +3238,9 @@ static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	}
 
 	if (!ctrl->effects) {
-		ctrl->effects = kzalloc(sizeof(*ctrl->effects), GFP_KERNEL);
-		if (!ctrl->effects)
-			return -ENOMEM;
-		xa_store(&ctrl->cels, NVME_CSI_NVM, ctrl->effects, GFP_KERNEL);
+		ret = nvme_init_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
+		if (ret < 0)
+			return ret;
 	}
 
 	nvme_init_known_nvm_effects(ctrl);
-- 
2.34.1


