Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47FFD78321
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=A+W25wl3aNktdu61R3Ww94a1+gtIGaRQSN+fLNNSjcE=; b=WboUaMHzioyoExvHdza/8Jmaau
	yh9zS9m4Wb515c0+/+h601fZIS+xFhhyqUK2cWkrJWzWR4Dxen4YChjk0BCf8f8aN3KZt2x8aolFw
	VqrHcTxI2Vz2WJGUVvHmX9NaZeVYbweM28MdGFCEH5gUc+IExd09qMZeQZdIIM/zbTl6y415M+UoR
	RdYfd+yc8rIqudp8S9bt+pZUyPeWX43lmGTYWsxOHMiXupttUvgo1jCZbPc8itRVzQswPnNpCymqH
	M0gHECQTX8IqWu5gImt0LeUwmvmrlEYZJrvq0x4tzPzOo+tcSGXDMqhEZb6up34IfDi+tVn8GnD7w
	Bcbkk/wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI8X3-00000006gbH-3s3M;
	Mon, 02 Dec 2024 15:40:17 +0000
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI8X0-00000006gZh-3Jsg
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 15:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A+W25wl3aNktdu61R3Ww94a1+gtIGaRQSN+fLNNSjcE=;
  b=SUmU8fGa7dDvvngXUFdfSAfE2Xs/hlz6lw8UtrhTu9K9bbPZmtdDK0Hi
   L0LwIFuycLuPZiQfi/3/2iQ4aB+dqlpJfBDIHoQh7fOeXQlGiP9YXUM45
   4Iim5lBKRw4by5krE8Pr4TcyPGdP8OIxM1JB0pVXzHRom8sA6fMHmrEKu
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.12,202,1728943200"; 
   d="scan'208";a="196904540"
Received: from nr-lil-536.grid5000.fr (HELO gros-110.nancy.grid5000.fr) ([194.254.60.35])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 16:40:09 +0100
From: Keisuke Nishimura <keisuke.nishimura@inria.fr>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Keisuke Nishimura <keisuke.nishimura@inria.fr>
Subject: [PATCH] nvme: Add error path for xa_store in nvme_init_effects
Date: Mon,  2 Dec 2024 16:39:22 +0100
Message-Id: <20241202153921.55766-1-keisuke.nishimura@inria.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_074015_197500_1361BA7B 
X-CRM114-Status: GOOD (  12.18  )
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
adds an error handling path to check the return value.

Fixes: cc115cbe12d9 ("nvme: always initialize known command effects")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
---
 drivers/nvme/host/core.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 758de89b47b4..38eb42f1110e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3219,10 +3219,18 @@ static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	}
 
 	if (!ctrl->effects) {
-		ctrl->effects = kzalloc(sizeof(*ctrl->effects), GFP_KERNEL);
-		if (!ctrl->effects)
+		struct nvme_effects_log *effects, *old;
+
+		effects = kzalloc(sizeof(*effects), GFP_KERNEL);
+		if (effects)
 			return -ENOMEM;
-		xa_store(&ctrl->cels, NVME_CSI_NVM, ctrl->effects, GFP_KERNEL);
+
+		old = xa_store(&ctrl->cels, NVME_CSI_NVM, effects, GFP_KERNEL);
+		if (xa_is_err(old)) {
+			kfree(effects);
+			return xa_err(old);
+		}
+		ctrl->effects = effects;
 	}
 
 	nvme_init_known_nvm_effects(ctrl);
-- 
2.34.1


