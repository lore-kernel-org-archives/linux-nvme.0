Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60D7C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6/PGx1qt2/sL12lObDv4FmiN75qaH4x4fmF+p8UhaFo=; b=Vv6Y6YEAANpWiAIPjvNw9Rta5G
	Jg2yQRDh4cSWo3XRW7TX3W5HaY7QbNQnThyD7/sRU68Fzx27QlGp/m4NBsiz3aQQOyjzcvw+ukt+O
	ZYCb9QAHvlYBxPlFE36tVUXic0N6C53z+Y1SAgNeXyRTE/ZX2Y6XmT/YA+qBctWrgVgN5trtxAfj/
	Mq056tRwtYOeCbLcx2ZLAHTH5OPWpMy+LJJjnxons8wy8NN7NcEVjrP8y/ZDnEBfJwr3RAEc928W2
	bI9E9xbM6U/mkaYRrXMnwFUdWofaa+KCNhl9JKodOrlQ9aN5AWXMEdBPDTeHzmbrh7FCt6UsN718A
	qHTKvVug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UOS-000VOz-H3; Wed, 14 Dec 2022 16:14:04 +0000
Received: from [2001:4bb8:192:2f53:94cc:fc26:a27c:8f96] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UOJ-000VL5-TI; Wed, 14 Dec 2022 16:13:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/9] nvmet: set the LBCC bit for commands that modify data
Date: Wed, 14 Dec 2022 17:13:40 +0100
Message-Id: <20221214161347.764071-3-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221214161347.764071-1-hch@lst.de>
References: <20221214161347.764071-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Write, Write Zeroes, Zone append and a Zone Reset through
Zone Management Send modify the logical block content of a namespace,
so make sure the LBCC bit is reported for them.

Fіxes: b5d0b38c0475 ("nvmet: add Command Set Identifier support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 111a5cb6403fb0..6a54ed6fb12144 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -174,17 +174,19 @@ static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
 
 	log->iocs[nvme_cmd_read] =
-	log->iocs[nvme_cmd_write] =
 	log->iocs[nvme_cmd_flush] =
 	log->iocs[nvme_cmd_dsm]	=
-	log->iocs[nvme_cmd_write_zeroes] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
+	log->iocs[nvme_cmd_write] =
+	log->iocs[nvme_cmd_write_zeroes] =
+		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC);
 }
 
 static void nvmet_get_cmd_effects_zns(struct nvme_effects_log *log)
 {
 	log->iocs[nvme_cmd_zone_append] =
 	log->iocs[nvme_cmd_zone_mgmt_send] =
+		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC);
 	log->iocs[nvme_cmd_zone_mgmt_recv] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
 }
-- 
2.35.1


