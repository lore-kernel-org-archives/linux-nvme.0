Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5B7C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Dec 2022 14:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6/PGx1qt2/sL12lObDv4FmiN75qaH4x4fmF+p8UhaFo=; b=fxjFU7fjmmIpkizGlLxeT/lFxv
	A7R8GnAZxzk1pfzZinaLkv6sd6LG4qwsgmtdMkcUR91Ud7fHrOuYzKyOSIq/F4hlam40aqRcHqoYs
	lZ9Uhku4OonLdjqP+cyAj4XGywyZEBlqZM22O+j2UKrtptkTPHpw331eIgfVJqswrdkv/bDP9Y5dY
	qp9NWzYzcaubgOKJA56kfgMT8hnTvAQSuTEuBkhdhw8Pq1RMwH1adrznkychbcxWRVhfTM2OhUpHV
	phX/8vu1hwHgQLeMhvscS6kbN6FuXNCmC1REwz+Vm6fYwu92TUhIrk8TzeU0r2wGWFqK4gO8LmJRY
	EGjRkrEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p80KW-00FizZ-NV; Wed, 21 Dec 2022 14:44:24 +0000
Received: from [2001:4bb8:199:7829:6251:5281:de26:c6d1] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7w3z-00DELF-Jn; Wed, 21 Dec 2022 10:11:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/6] nvmet: set the LBCC bit for commands that modify data
Date: Wed, 21 Dec 2022 11:10:47 +0100
Message-Id: <20221221101050.759606-4-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221221101050.759606-1-hch@lst.de>
References: <20221221101050.759606-1-hch@lst.de>
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


