Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D485EC4708E
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iWxb3nuVn2YspSt2RVIE4KvG+wkOTWe7xGCkLs7kB1M=; b=fd5QNVWm4B+S3DJroabQhSvxaj
	UzsIC03WhvMZGGu1pOGFkMdMXaeNyr9SUYlPkPKpDHznmNH8F4ICFG0+mZ/coPyvl9OMXo+K63//r
	latkAXbGv2MJsDE7eRZsn2/ZBnJ/M8n2ak38nzldazvzkFpWAceyfSvkYAYlSIO5dO55uS2CMisTW
	Qz3JM8c1Ccz2IgL6AtzAo0TtlSgvHuTAyKEku1SRV8bixd4NPwVhQaZyUbvcLFv4UBewKu/rPxOzY
	vccvah5ICqvTzBRhBtFkAojdFLiU/qVO9cEmhNAOsyXdncUG1d9p0D0XZJDMRZFG/YboJ2FJYYfD7
	buFiF1zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCnTY-004dPy-P6; Tue, 03 Jan 2023 20:01:32 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCmCs-003yIx-V2
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 18:40:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 57514B810AD;
	Tue,  3 Jan 2023 18:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4B3C433F2;
	Tue,  3 Jan 2023 18:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672771211;
	bh=3iJDEg26w5JXxeO2spyA4n8QeKcUd/6tuQpHV6WNuig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wto7t6R7yPqo609aa5lzZx6R1F+hEKgafSqfs4jF7wrc6pBCcbHYbtby/AH88fNCC
	 uctvD9PCWey2o3mnjikpmOwLaRoNmThbO4xgMp7HuZh3eMBfUruNRxGoMMandHaiMz
	 ZUl2zQYzAVun8SVEPMzlkYr7IsVhej8fd8ykgrADSr+7Ebq4satC1DO7Cr6275P7vr
	 yarUDtCJ+VSxRj3fa4j9CLZPNel7UhyMtvzqwiFF4w2pBv+tVomkvI8zDMLHBDcFQ8
	 Q20H0jB7sNHP4ALU4hQcO6gV3OsjQKUDU78rImvyiSTdpLRGiGT6/QkC18tSxIoIvM
	 vUg0kxqFIsY6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.0 3/4] nvmet: use NVME_CMD_EFFECTS_CSUPP instead of open coding it
Date: Tue,  3 Jan 2023 13:39:54 -0500
Message-Id: <20230103183956.2022789-3-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230103183956.2022789-1-sashal@kernel.org>
References: <20230103183956.2022789-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_104015_384787_27C9597C 
X-CRM114-Status: GOOD (  12.77  )
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 61f37154c599cf9f2f84dcbd9be842f8645a7099 ]

Use NVME_CMD_EFFECTS_CSUPP instead of open coding it and assign a
single value to multiple array entries instead of repeated assignments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 35 ++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index fc8a957fad0a..4aaa27cc8d2b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -164,26 +164,29 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 
 static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
 {
-	log->acs[nvme_admin_get_log_page]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_identify]		= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_abort_cmd]		= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_set_features]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_get_features]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_async_event]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_keep_alive]		= cpu_to_le32(1 << 0);
-
-	log->iocs[nvme_cmd_read]		= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_write]		= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_flush]		= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
+	log->acs[nvme_admin_get_log_page] =
+	log->acs[nvme_admin_identify] =
+	log->acs[nvme_admin_abort_cmd] =
+	log->acs[nvme_admin_set_features] =
+	log->acs[nvme_admin_get_features] =
+	log->acs[nvme_admin_async_event] =
+	log->acs[nvme_admin_keep_alive] =
+		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
+
+	log->iocs[nvme_cmd_read] =
+	log->iocs[nvme_cmd_write] =
+	log->iocs[nvme_cmd_flush] =
+	log->iocs[nvme_cmd_dsm]	=
+	log->iocs[nvme_cmd_write_zeroes] =
+		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
 }
 
 static void nvmet_get_cmd_effects_zns(struct nvme_effects_log *log)
 {
-	log->iocs[nvme_cmd_zone_append]		= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_zone_mgmt_send]	= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_zone_mgmt_recv]	= cpu_to_le32(1 << 0);
+	log->iocs[nvme_cmd_zone_append] =
+	log->iocs[nvme_cmd_zone_mgmt_send] =
+	log->iocs[nvme_cmd_zone_mgmt_recv] =
+		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
 }
 
 static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
-- 
2.35.1


