Return-Path: <SRS0=6M3L=YQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0934CA9EB6
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2019 16:36:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9026620650
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2019 16:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pMxOI1UZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9026620650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:References:
	In-Reply-To:Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3AQ2cjHzuixwe1xoidTRfHlwHnOXdC2rpocvnm1O/vc=; b=pMxOI1UZE4VAlI
	toCa+GYvyEHQPoz0aYCoLVl+gSiUf1TLXaLYaENBk2lqS1jUzEiSNKLCQUo/1zPVv748MSpngtyaE
	uAD+jidFPP89dYTxRZJvEJoSE/EXQmWJYuIdUdYoMfmhlUPmQBnk51qlj4MtF2lQOTiWljP/ZLibt
	GldUt+OaKRSqRk/rTOQuLDDJNgGpN2eUvQEb05rN6yHqKks/+qnjzpFP9+mh6ITp7/ZD08P2ig1MZ
	jFzo9FF3MFeOyL2zGBKd1MGYq3EE9KjvTBX4Ur5G/FKqVopLt2ps1PhVskjLUM5n64oca1IlXBdm2
	5WfPh63f+m8lL8uoQnAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNJcg-00088A-5b; Wed, 23 Oct 2019 16:36:34 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNJc8-0007c8-FP
 for linux-nvme@lists.infradead.org; Wed, 23 Oct 2019 16:36:02 +0000
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <gunthorp@deltatee.com>)
 id 1iNJc4-0006Vv-8G; Wed, 23 Oct 2019 10:35:59 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1iNJc2-00016e-Ro; Wed, 23 Oct 2019 10:35:54 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Wed, 23 Oct 2019 10:35:42 -0600
Message-Id: <20191023163545.4193-5-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023163545.4193-1-logang@deltatee.com>
References: <20191023163545.4193-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com,
 sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 4/7] nvmet: Cleanup discovery execute handlers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191023_093600_849303_4E4D7B9F 
X-CRM114-Status: GOOD (  12.56  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Max Gurtovoy <maxg@mellanox.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Push the lid and cns check into their respective handlers and, while
we're at it, rename the functions to be consistent with other
discovery handlers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[logang@deltatee.com: separated out of a larger draft patch from hch]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/discovery.c | 44 ++++++++++++++-------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 3764a8900850..825e61e61b0c 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -157,7 +157,7 @@ static size_t discovery_log_entries(struct nvmet_req *req)
 	return entries;
 }
 
-static void nvmet_execute_get_disc_log_page(struct nvmet_req *req)
+static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 {
 	const int entry_size = sizeof(struct nvmf_disc_rsp_page_entry);
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -171,6 +171,13 @@ static void nvmet_execute_get_disc_log_page(struct nvmet_req *req)
 	u16 status = 0;
 	void *buffer;
 
+	if (req->cmd->get_log_page.lid != NVME_LOG_DISC) {
+		req->error_loc =
+			offsetof(struct nvme_get_log_page_command, lid);
+		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		goto out;
+	}
+
 	/* Spec requires dword aligned offsets */
 	if (offset & 0x3) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
@@ -227,12 +234,18 @@ static void nvmet_execute_get_disc_log_page(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void nvmet_execute_identify_disc_ctrl(struct nvmet_req *req)
+static void nvmet_execute_disc_identify(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
 	u16 status = 0;
 
+	if (req->cmd->identify.cns != NVME_ID_CNS_CTRL) {
+		req->error_loc = offsetof(struct nvme_identify, cns);
+		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		goto out;
+	}
+
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
 		status = NVME_SC_INTERNAL;
@@ -344,31 +357,12 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 		return 0;
 	case nvme_admin_get_log_page:
 		req->data_len = nvmet_get_log_page_len(cmd);
-
-		switch (cmd->get_log_page.lid) {
-		case NVME_LOG_DISC:
-			req->execute = nvmet_execute_get_disc_log_page;
-			return 0;
-		default:
-			pr_err("unsupported get_log_page lid %d\n",
-			       cmd->get_log_page.lid);
-			req->error_loc =
-				offsetof(struct nvme_get_log_page_command, lid);
-			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
-		}
+		req->execute = nvmet_execute_disc_get_log_page;
+		return 0;
 	case nvme_admin_identify:
 		req->data_len = NVME_IDENTIFY_DATA_SIZE;
-		switch (cmd->identify.cns) {
-		case NVME_ID_CNS_CTRL:
-			req->execute =
-				nvmet_execute_identify_disc_ctrl;
-			return 0;
-		default:
-			pr_err("unsupported identify cns %d\n",
-			       cmd->identify.cns);
-			req->error_loc = offsetof(struct nvme_identify, cns);
-			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
-		}
+		req->execute = nvmet_execute_disc_identify;
+		return 0;
 	default:
 		pr_err("unhandled cmd %d\n", cmd->common.opcode);
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
