Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FCFC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 06:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UtNVqHqbkwIQORIDHKtpaWaa9ldw8qgql3aAq42hRC4=; b=wKBXM9EWfBtOk47JkatuZacN9/
	s+P3P0dTlzwRu8rv6vrs6p0XWL8YG45HL+Fe81QdNhWd3cVjiEa5/XE4v0ENp2VZ7bjsv0MbblvOf
	01UW0FuE88hnq4aBNYBTyWwz6WQ/S+JWWwyqiTy2mhKJukKCJLg7WAEuHD39L1R8a1/mxGd4LXFsV
	VOLCsl/z3cgfN2aYzQAxReKH3S3F4IvwsVevkibb73Ura8VurbnAEJ/pBH57/VZJuzqoruNHTnbIE
	JVVRPP4jYVYU5IFk4/iMxY+Iin8i5XHq5kgcnwoiyxcdFWB9fXwbnFbaReM128MJvE/8k0V7HElGz
	0FLTbM9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4GA6-00DdTy-09; Thu, 23 Jun 2022 06:17:54 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4G9t-00DdMn-Ah
	for linux-nvme@lists.infradead.org; Thu, 23 Jun 2022 06:17:44 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 081991FB2F;
	Thu, 23 Jun 2022 06:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655965056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtNVqHqbkwIQORIDHKtpaWaa9ldw8qgql3aAq42hRC4=;
	b=TfmgFWO7SZ7V1vAkqIcofsszYUuXU+xqEXOZWIDmIJu5FkPQdLUK3fZ1Mn0vd7bg5ySvVZ
	MP1TJ3xlb61LVDTLbvsmccmhF2+BC58HRDEBzmfxREXSUa3J2eA85wdyrt2a8d4G/ryJN3
	lXtEp+NQvhpMO1Pw3EqqrDYPmYhyFsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655965056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtNVqHqbkwIQORIDHKtpaWaa9ldw8qgql3aAq42hRC4=;
	b=r5lUgfyQqESUcfM/UsaVz4HQJwF1Dp5v807wxVgzkHBopxVTDnEYbnMIr3mWlNXDCLo6lj
	iBEDmkqNkWolZiAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id F39C82C165;
	Thu, 23 Jun 2022 06:17:35 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 30B735194D78; Thu, 23 Jun 2022 08:17:35 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/11] nvmet: parse fabrics commands on io queues
Date: Thu, 23 Jun 2022 08:17:27 +0200
Message-Id: <20220623061730.51490-9-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220623061730.51490-1-hare@suse.de>
References: <20220623061730.51490-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_231741_590683_4DE2E8DF 
X-CRM114-Status: GOOD (  13.58  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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


