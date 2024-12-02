Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5F0D78318
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 12:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8alKWcxxMM1ZJpbjNr1XWjgloPdBpW06ewtzTQgFbjA=; b=K3QVAgt9hvrb4i56xURhRuVH7Z
	tvWC+CMsVrn+NlWv1Bpm94RU7rStsKuBnMyhxdc4r/eamnUpMDsNatTMqP5R+PgJaWbVWmYG0IVmp
	0TgOjtB0sdBwnx5E1LzHTtp3FPJz2GktAjJN13BtnMp/ZnvTKerDBhOg8bca6PdFuz38HSrkjZvWi
	XKlnP93hYg9GVvKBNnYhbd9T3tHDThRUTjKdswp2EhQzjvtU8c/CHA4accE6X31knD4FgjHMLX2je
	veDTcGjMY2QDK4onr26oN/291wQJ5PyvfNFX6C6Gd6wSbOf441l7SWXztcoak71YCa5o06d7J2L8e
	BUZDTfZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI5oV-000000067lh-2hUW;
	Mon, 02 Dec 2024 12:46:07 +0000
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI5lt-000000067E1-3vBt
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 12:43:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8alKWcxxMM1ZJpbjNr1XWjgloPdBpW06ewtzTQgFbjA=;
  b=B4q/oQJL2DPbgsyYP2KsoiBNk4j0vMNAF0Kqy0k9gE2NIgq2VjqnLrCa
   163hG4Zoppx4hqA0ofKC4JsxmGEO4tM1gXuR3NMsLZuTVoSXXF6obJN9N
   JgqcVprwulHlMEQe+TNCEArium9HGR2La8GhhacUuZK3Cm7i7TuikFfvi
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.12,202,1728943200"; 
   d="scan'208";a="103174539"
Received: from nr-lil-536.grid5000.fr (HELO gros-110.nancy.grid5000.fr) ([194.254.60.35])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 13:43:19 +0100
From: Keisuke Nishimura <keisuke.nishimura@inria.fr>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Keisuke Nishimura <keisuke.nishimura@inria.fr>
Subject: [PATCH] nvme: Allocate memory for xa_store in advance in nvme_get_effects_log
Date: Mon,  2 Dec 2024 13:42:40 +0100
Message-Id: <20241202124239.49894-1-keisuke.nishimura@inria.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_044326_362636_FD563B1D 
X-CRM114-Status: GOOD (  11.93  )
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
is no guarantee that the index csi is already used. This code allocates
the memory in advance to ensure the xa_store() succeeds before
nvme_get_log().

Fixes: 1cf7a12e09aa ("nvme: use an xarray to lookup the Commands Supported and Effects log")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a8d32a4a5c3..758de89b47b4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3098,6 +3098,12 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 	if (!cel)
 		return -ENOMEM;
 
+	ret = xa_reserve(&ctrl->cels, csi, GFP_KERNEL);
+	if (ret) {
+		kfree(cel);
+		return ret;
+	}
+
 	ret = nvme_get_log(ctrl, 0x00, NVME_LOG_CMD_EFFECTS, 0, csi,
 			cel, sizeof(*cel), 0);
 	if (ret) {
-- 
2.34.1


