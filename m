Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C18C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Dec 2022 07:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7VH0/r+dC5pR/Dz6pjUoMttRToMaC0ghPAHbDTLppHE=; b=hGnkX0o1fqVAwzrOsIipUZDW70
	JnzvDaYk77rKvqeUOtPJp4sJ9K40wGiz2EXY0Z9NryMPrb94GVd6VnQ7QPgnbk3uMIzaBpexjLdSp
	r8oy90imCEOOG6prhKe+F+S/Wy97NqKEJJdBtTbqz9OhFirOJJtVyR36WltY/V4SU+o4YwgVLO/kv
	gG7cXgSbMzzM7nE1sV6Almh1nW5ToU9ltLtA7PIsABFYMMVvj5lgDRoM7XaNMCeb8A3sh9QwML28Y
	7nq9oevYOE6KMl6W3Rv4BIfTwhzVQVf1gXoXxq7AHMQtIAnsHcM9pkjpUrEn3Rphd7+m08rvoE5zB
	svtRTMdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8cKH-004hsH-5n; Fri, 23 Dec 2022 07:18:41 +0000
Received: from [2001:4bb8:199:7829:8d88:c8b3:6416:2f03] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8cK0-004hli-LB; Fri, 23 Dec 2022 07:18:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/6] nvmet: set the LBCC bit for commands that modify data
Date: Fri, 23 Dec 2022 08:18:11 +0100
Message-Id: <20221223071814.43564-4-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221223071814.43564-1-hch@lst.de>
References: <20221223071814.43564-1-hch@lst.de>
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

Write, Write Zeroes, Zone append and a Zone Reset through
Zone Management Send modify the logical block content of a namespace,
so make sure the LBCC bit is reported for them.

Fixes: b5d0b38c0475 ("nvmet: add Command Set Identifier support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
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


