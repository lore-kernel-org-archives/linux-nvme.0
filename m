Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA13BC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Dec 2022 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rnFPb58I09W8gIjTd8aStfCn1RSG3VY48MUv47v6QpY=; b=raid24+SQ8OJCcamr5eQhWvlxr
	GR3uaxqixgIQzUwm1v+4uw0GhXwRV8Dn08QqGE9fv1PLsrlzCxHVTlQcPU5ucq0pu1hN773ElidmA
	QPhrbJwsliR8W1J/TuOO/2j7ki04OZ2O7fWSVtIs0MxAc8WK6WYXoRJv+mcNqEKA5twnMlwlVouwP
	x6TzqBoPcG4Zt39AN6EOPAM9Kb4CrYbstyRWMAIDIRLS/Oh5nBcfbEnkPSVI+sk+aq6G0n5QQf0bg
	EkJaBFAou+npfYaXoyKj6QQx3L/gXe7OzqHElQ8jZ70z1mYD5Cdjab34t+PHXcEV0uHvsARRy63rT
	X3VAyDxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p585c-002ogI-SC; Tue, 13 Dec 2022 16:25:08 +0000
Received: from [2001:4bb8:192:2f53:30b:ddad:22aa:f9f9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p585V-002oc9-BP; Tue, 13 Dec 2022 16:25:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/7] nvmet: set the LBCC bit for commands that modify data
Date: Tue, 13 Dec 2022 17:24:48 +0100
Message-Id: <20221213162453.584965-3-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221213162453.584965-1-hch@lst.de>
References: <20221213162453.584965-1-hch@lst.de>
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


