Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF061C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 11:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5SosWoAHWyB6TbnbAfulqwAIBVU1Qhynj9mAe9um6CU=; b=dx4RuwH3L4W9d9+qGVlj/kSE/b
	mACuvZNrNE65xmk0bdNKYtRuGHni2zdi8WBW87jSbSvo8DteSztI1w8aeDm4d0f9l+vIKqdjnCXBd
	8uiQrpPAGkTUyO9ygX9mr7r2eh9L7SmwzNu7nIOk1n3d4KfJ4voGYixotyknhAc7fWxUVeGztZNkW
	jo0FW3p6b30yBW0ZgkC1GD5KwunnpHgy21r4BY6XrInzEpTiWLMCzgbZDPFCqpIKkO4pKIftYhCUi
	peZ2Mpac3uIa1mDqb1t8vg+p4yGJu7sPC3dgCFY7SPQLLJ/W+pH2yYvvGs7OGa79sEAGxFd7rar7g
	ZQbDazvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrHpI-001Wm3-92; Wed, 18 May 2022 11:26:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrHle-001UyZ-Me
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 11:23:05 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6D0361F9AC;
 Wed, 18 May 2022 11:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652872973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SosWoAHWyB6TbnbAfulqwAIBVU1Qhynj9mAe9um6CU=;
 b=peyGL9UIT1bmuuoAEkmeKd0Yv+G1DS1J55ijO+UxO8PqG8S33+NSS2aF4c+ZoxO4WQ3Gv/
 1b8FdStevcv1KWXilZuayJEXUfLGKRDxdMeZ9aRXCPp+v1PITzE/7IHxHjMTt3y3vlOEah
 BL+pFjOhGDkHLFM0steevjL9FWb6A5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652872973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SosWoAHWyB6TbnbAfulqwAIBVU1Qhynj9mAe9um6CU=;
 b=DqO5JV57DOyAHaPUOAw1jWBDe0f1R0pIhpdgdeNiFcl+b3DZteMSGb3YQXazZotDW8jult
 WPMNxRs7os5BoEBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 5BE392C14B;
 Wed, 18 May 2022 11:22:53 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 9FA3D5194515; Wed, 18 May 2022 13:22:52 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/11] nvmet: parse fabrics commands on io queues
Date: Wed, 18 May 2022 13:22:31 +0200
Message-Id: <20220518112234.24264-9-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220518112234.24264-1-hare@suse.de>
References: <20220518112234.24264-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_042302_977369_38FEF8A3 
X-CRM114-Status: GOOD (  13.80  )
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

Some fabrics commands can be sent via io queues, so add a new
function nvmet_parse_fabrics_io_cmd() and rename the existing
nvmet_parse_fabrics_cmd() to nvmet_parse_fabrics_admin_cmd().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/admin-cmd.c   |  2 +-
 drivers/nvme/target/core.c        |  4 ++++
 drivers/nvme/target/fabrics-cmd.c | 17 ++++++++++++++++-
 drivers/nvme/target/nvmet.h       |  3 ++-
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 397daaf51f1b..31df40ac828f 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1017,7 +1017,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 	u16 ret;
 
 	if (nvme_is_fabrics(cmd))
-		return nvmet_parse_fabrics_cmd(req);
+		return nvmet_parse_fabrics_admin_cmd(req);
 	if (nvmet_is_disc_subsys(nvmet_req_subsys(req)))
 		return nvmet_parse_discovery_cmd(req);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 90e75324dae0..792f15621173 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -865,8 +865,12 @@ static inline u16 nvmet_io_cmd_check_access(struct nvmet_req *req)
 
 static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 {
+	struct nvme_command *cmd = req->cmd;
 	u16 ret;
 
+	if (nvme_is_fabrics(cmd))
+		return nvmet_parse_fabrics_io_cmd(req);
+
 	ret = nvmet_check_ctrl_status(req);
 	if (unlikely(ret))
 		return ret;
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 70fb587e9413..f23c28729908 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -82,7 +82,7 @@ static void nvmet_execute_prop_get(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req)
+u16 nvmet_parse_fabrics_admin_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
 
@@ -103,6 +103,21 @@ u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req)
 	return 0;
 }
 
+u16 nvmet_parse_fabrics_io_cmd(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+
+	switch (cmd->fabrics.fctype) {
+	default:
+		pr_debug("received unknown capsule type 0x%x\n",
+			cmd->fabrics.fctype);
+		req->error_loc = offsetof(struct nvmf_common_command, fctype);
+		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+	}
+
+	return 0;
+}
+
 static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
 	struct nvmf_connect_command *c = &req->cmd->connect;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 69818752a33a..c37f41eafc2f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -419,7 +419,8 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_bdev_zns_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_parse_admin_cmd(struct nvmet_req *req);
 u16 nvmet_parse_discovery_cmd(struct nvmet_req *req);
-u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req);
+u16 nvmet_parse_fabrics_admin_cmd(struct nvmet_req *req);
+u16 nvmet_parse_fabrics_io_cmd(struct nvmet_req *req);
 
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		struct nvmet_sq *sq, const struct nvmet_fabrics_ops *ops);
-- 
2.29.2


