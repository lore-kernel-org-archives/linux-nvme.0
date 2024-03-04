Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747A0C48BF6
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CdAdTrJK0mHHqv53cYp5SY8i6/LmLTzTv4WzZNNbBWo=; b=SQXHT1tUcaqn/IgG+7mIfBfwAX
	AJEa2lAPlqhBc+HS/uyacHSK1cn+ZmmE/aTjIs8iYi05xkbxF7dIzCgcQx6L6RfJi4Qws8OF+vVHs
	ocIjoJ5VrQpjt9LYqcJJneySwIBOohFHn3nHJbaxbDwFqKqvDBpCAZv0GAFYUDgVSUAAiUucG5sbj
	5WaM0h2Ml5Een51sc3ezQY+7Tv85AzJ7RhIVPPChblj+okmNcSS0h5QAia+uudZ14Dd3KHSLq7Cvc
	rYtFpF9juCrEPdrOm57AeoieP4zPYNtcTmfBsvcKCbcDgwxNBxMoSzUTN7mL54qFUct5aBoX5GgNb
	2r6Oljow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8wo-00000009Hs4-3tKT;
	Mon, 04 Mar 2024 14:05:42 +0000
Received: from [206.0.71.24] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8wl-00000009Hp6-2QEI;
	Mon, 04 Mar 2024 14:05:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 06/16] nvme: move blk_integrity_unregister into nvme_init_integrity
Date: Mon,  4 Mar 2024 07:04:50 -0700
Message-Id: <20240304140500.78583-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304140500.78583-1-hch@lst.de>
References: <20240304140500.78583-1-hch@lst.de>
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

Move uneregistering the existing integrity profile into the helper
dealing with all the other integrity / metadata setup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1ecddb6f5ad9eb..40fab7c47eae24 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1727,6 +1727,8 @@ static bool nvme_init_integrity(struct gendisk *disk, struct nvme_ns_head *head)
 {
 	struct blk_integrity integrity = { };
 
+	blk_integrity_unregister(disk);
+
 	if (!head->ms)
 		return true;
 
@@ -1980,8 +1982,6 @@ static void nvme_update_disk_info(struct nvme_ctrl *ctrl, struct gendisk *disk,
 		bs = (1 << 9);
 	}
 
-	blk_integrity_unregister(disk);
-
 	atomic_bs = phys_bs = bs;
 	if (id->nabo == 0) {
 		/*
-- 
2.39.2


