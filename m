Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC96E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 12:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SXIlbUgSg+7v3Rm02pIY03f6grNjw5eDdvQfJvMYEZo=; b=Zud8v1EPIQQHe0YoaZrmbBzfCY
	83DeuJ72C4FzgLrXl8J+2ASj9+j/THHdtP5FNtxcCszVVVsquw2wUHpfrZhJTLb+7z+ZWbIpOd5Hn
	/Q6AMWFroCDEMqnrdKC4cEqtNUBv2rWfNf7attCX2wrcn3mBS4FaOOexXvFRmn159+TMbUR1aoDqF
	uvFjUkyOYJY/yWhpSE+nNa0ntBRE6HfcvnzU91NSVrrOAHirlWIJP11LRt7R04wTZmw5mstihvSv3
	Blx34RXuVPKWndngxRY5X/BpHhIgz9Fnw4eCa+txd/waXpDQfVLgCc9c+hSpkO/nEVp+dB4sLNnpQ
	JaNFHuww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tObjq-00000004qm8-2NO8;
	Fri, 20 Dec 2024 12:04:14 +0000
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tObha-00000004qLf-3bH9
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 12:01:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SXIlbUgSg+7v3Rm02pIY03f6grNjw5eDdvQfJvMYEZo=;
  b=tDH+tv25GoAP289DzB+2nLLJwXsSYeEpWKu7FEa0TJO2UcxMHbe7RzNw
   5GXv+43kSWAVEQ3ywsijAZGybkpZfjhBMTk4rxFCildQQe1Rn3FyURS9S
   04T1kHOry0w6Di8zpx8RwBp+IPZH27BVlx5TtW6FrVd7ZWClweJYxEz87
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.12,250,1728943200"; 
   d="scan'208";a="104872538"
Received: from nr-lil-536.grid5000.fr (HELO gros-91.nancy.grid5000.fr) ([194.254.60.35])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:01:53 +0100
From: Keisuke Nishimura <keisuke.nishimura@inria.fr>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Keisuke Nishimura <keisuke.nishimura@inria.fr>
Subject: [PATCH] nvme: Add error check for xa_store in nvme_get_effects_log
Date: Fri, 20 Dec 2024 13:00:47 +0100
Message-Id: <20241220120046.13559-1-keisuke.nishimura@inria.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216155229.GC23786@lst.de>
References: <20241216155229.GC23786@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_040155_184450_90E59815 
X-CRM114-Status: GOOD (  14.62  )
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
is no guarantee that the index csi is already used. This fix adds an
error check of the return value of xa_store() in nvme_get_effects_log().

Fixes: 1cf7a12e09aa ("nvme: use an xarray to lookup the Commands Supported and Effects log")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
---
 drivers/nvme/host/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a8d32a4a5c3..d4028ce5ad8d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3088,7 +3088,7 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 				struct nvme_effects_log **log)
 {
-	struct nvme_effects_log	*cel = xa_load(&ctrl->cels, csi);
+	struct nvme_effects_log *old, *cel = xa_load(&ctrl->cels, csi);
 	int ret;
 
 	if (cel)
@@ -3105,7 +3105,11 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 		return ret;
 	}
 
-	xa_store(&ctrl->cels, csi, cel, GFP_KERNEL);
+	old = xa_store(&ctrl->cels, csi, cel, GFP_KERNEL);
+	if (xa_is_err(old)) {
+		kfree(cel);
+		return xa_err(old);
+	}
 out:
 	*log = cel;
 	return 0;
-- 
2.34.1


