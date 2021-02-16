Return-Path: <SRS0=dBpD=HS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94F7C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 21:32:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FACC64D99
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 21:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FACC64D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GlQftivHoC17H7ji5MT1K1r0Nu/oEwQE6/WcMO/XZkg=; b=qgvKBNulPNSMNhvoS5JSgS++q
	KUExIwT0vdIuKXhjv6zBtFkdsIxTQ9y+L2YA9KS02QZuScXWXFytpx+63e4NM7WWT9TSomXTAByRy
	PTz3IJ4IMyV2Sp7etJ0sbHvCNkuH/hZu0b1D5QyPRkEqQXygRMX5nPsMVl1wzqOWV7xk1XGaIE/nr
	KlI90hCOpBYeStkCngXOKRZocc5eM1KyhVzEWdGS5gE7wnY2Zf3TgbHWPGNJQt8XVJmm7kluEj9Q1
	H5OXWn+licca2GEnR4DEKa/IqmecYS5IPZ38/Q8aG16QW4XNv8LHlyHDncNHTq8TA9nrhbGjxanFU
	ntBYxn7qQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lC7wy-0005dJ-7I; Tue, 16 Feb 2021 21:32:04 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lC7wt-0005bf-5r
 for linux-nvme@lists.infradead.org; Tue, 16 Feb 2021 21:32:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613511119; x=1645047119;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UVDxubdQQ4dCD6nV0lrrzJETvDPEMYEZPuFqEk42gvk=;
 b=O4spusYx5uiIrh12MIHX+l23yNT3WdIwAnT7sgf/vqIOM0PRCFPiI2jH
 O+FZQlBZsx4GOqrftQ8hXjgT6e0lHdxu7Vi6GvDg7wqsUxlYnFSsKWJGi
 01b8+7fLFCEWgBXy/cNHJKYaVK+zdBLLmuzOCwsnzD4c1WmpMSfA46Ddd
 IWnRM/e9g/pK/xEa8xBbMDhWL7LRjCzOceoMa5pQD7T4mYYX+qY9p7YZE
 EYDNTaqAPxPJabDjjGJP9EkwkK4dz39JZkce8gyrjGKRsc7ZApst5OIgd
 1Q6A7NePQNc6XQAviiKSvJPkBRWKoFQYvKmVGbuvt6vcPvGJwxzg4Vgw5 A==;
IronPort-SDR: ggR3piCrmU1c8D3NXwICX0LvSL09uHnrCGXKNh9FSpYKq5DC6DmQP5/G7Fdvs44LKZVVh49WQj
 /zCeRBP0bd8Zag7IiI3MKbLfOPMohacVQkw55DfFC3QhEIOVdmANh/lK4r4SledwTql0kMykH9
 6pJYuW2hBBBYVFyo6J0siX9tQDAhkkhCDYZq7ZwqaxSPKhcksxZIIF3QyfJH1t6xvFQYBtP17Q
 09vAdtg05ZR+2SVKBcbaio6HTSruJHe/gkK6cUnCYewcG7QL6tXc1DMbGdPjafKCXbluJ5SQNA
 C98=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="270620050"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 05:31:58 +0800
IronPort-SDR: kOiYH4ZwZuWB4X+Argxm1k7zwhlzFPff4ChyWCndMtrA8NIA3GlxMKNEiBqO/tEAtHO11XAbIk
 +kZIHaC1bH6HvlPnk3gTY6UTJr/waX1goFtQxKM6/Gm82C3folcfi3llXPsQ4yG1Hb0qZjTIrF
 gM79ESmYyeFKx6rY9Ioco5IMZdOxa91pcoS6EcyG+CK/+uM6oAmDXj+K+H1oOhFRtSz8/zNE7+
 3T64jLO90XGsfPfHVVmcmeJYIUfsZmfK9Zba824LT+nzbgSAkW/fterLNLbiM2sAewp03KQDnG
 jupdc5Dzm2/Lq6UWmz7jIy06
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 13:15:30 -0800
IronPort-SDR: XVLMFEysDpag7+7TAnJPXgB5JpPVSQtkkVJg01w5W+Aegc4Wax9EQChlvD+8lheZsBJyGcpL19
 rRkFBjgg96xvhDw6iLvtxyXuunjlRxTAXUY2LnqQBw801rY9hhGFF6NHHFuKTME2XPmy2BrVbm
 JMrpH8ukuNhxTwiXwW7z5R76UQ2W5L/v5GxWfM1rIR0Vr2Ax85Tg14WYtQx82bGgyIxBpe1r35
 6qYV7f0Zz1JLtqOgudbFzTRPlgpcaV5gFirJlEbLP52Z59e5XBYo2wJGBiN4Bp2u7/cjtMiAD2
 82c=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 13:31:58 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 5/6] nvmet: remove unnecessary function parameter
Date: Tue, 16 Feb 2021 13:31:11 -0800
Message-Id: <20210216213112.20078-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210216213112.20078-1-chaitanya.kulkarni@wdc.com>
References: <20210216213112.20078-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_163200_844925_4EC484CD 
X-CRM114-Status: GOOD (  12.14  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvmet_check_ctrl_status() cmd can be derived from nvmet_req. Remove
the local variable cmd in the nvmet_check_ctrl_status() and function
parameter cmd for nvmet_check_ctrl_status(). Derive the cmd value from
req parameter in the nvmet_check_ctrl_status().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 drivers/nvme/target/core.c      | 9 ++++-----
 drivers/nvme/target/nvmet.h     | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index bc6a774f2124..e15a2191500a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -926,7 +926,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 	if (nvmet_req_subsys(req)->type == NVME_NQN_DISC)
 		return nvmet_parse_discovery_cmd(req);
 
-	ret = nvmet_check_ctrl_status(req, cmd);
+	ret = nvmet_check_ctrl_status(req);
 	if (unlikely(ret))
 		return ret;
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 518dadc395b3..5915b7cc65a6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -864,10 +864,9 @@ static inline u16 nvmet_io_cmd_check_access(struct nvmet_req *req)
 
 static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 {
-	struct nvme_command *cmd = req->cmd;
 	u16 ret;
 
-	ret = nvmet_check_ctrl_status(req, cmd);
+	ret = nvmet_check_ctrl_status(req);
 	if (unlikely(ret))
 		return ret;
 
@@ -1220,17 +1219,17 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(struct nvmf_connect_data *d,
 	return ctrl;
 }
 
-u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd)
+u16 nvmet_check_ctrl_status(struct nvmet_req *req)
 {
 	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
 		pr_err("got cmd %d while CC.EN == 0 on qid = %d\n",
-		       cmd->common.opcode, req->sq->qid);
+		       req->cmd->common.opcode, req->sq->qid);
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 	}
 
 	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
 		pr_err("got cmd %d while CSTS.RDY == 0 on qid = %d\n",
-		       cmd->common.opcode, req->sq->qid);
+		       req->cmd->common.opcode, req->sq->qid);
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 	}
 	return 0;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e8211a63eac3..2dd4a91e5e0e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -436,7 +436,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 struct nvmet_ctrl *nvmet_ctrl_find_get(struct nvmf_connect_data *d,
 				       struct nvmet_req *req);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
-u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd);
+u16 nvmet_check_ctrl_status(struct nvmet_req *req);
 
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		enum nvme_subsys_type type);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
