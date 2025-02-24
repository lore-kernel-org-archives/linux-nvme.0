Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FA0C021BC
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 13:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gB9CIFpntjzwpDFNhZVgOr9zGA9MadIm2WTzFf4ai7o=; b=tsWoNa9jYtNbQ8ar4Hd0iy/r/r
	HCFlpWkg8y14r8LwXihaQJH99tFD6wz2fi4nlZjMqGDWXF5Bq18/Ij4+WUn1Pw7YTubg/SgvO8aYS
	7Tl/5+0BCTXYmEMoLVZ2WxRJPUyY8d3wSNmN53dkDOPxDlxxahkisEOia+GX075sLxkBiP5hXtIa7
	YuOjLKHn7Veybj1KbUK3HE5ejQk1q1JQV9ubiC8xpHk+SRNj1HYHyEzUj0XEXpQI8kC+QddrOOOCr
	+cxoL8BEik5WZM0lWsXIyKVLzimux2TqS+NAhq2HbW1ZUqhILXxeZprV6cqGWQYY/mA81AFnmYqAd
	Aw99WB6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmYI2-0000000DoKu-3eFI;
	Mon, 24 Feb 2025 13:14:30 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXjV-0000000Diaa-0Ljw
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 12:38:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B1DE9611AF;
	Mon, 24 Feb 2025 12:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09D9C4CEE6;
	Mon, 24 Feb 2025 12:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400728;
	bh=2v3DobsMa4qbtsA7sXkXpC/Xtik+5Gowz+QCLFfJqJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=df07kjhJzOXaviOXw0HzKO0YtVK4uGb+TI40Oyjw+p6U5LRtSc+W/d9DB+5xBg19L
	 kTPfi+S3Si+aegA6Ymc76FATLTqe0tM9/s0qCaDQleRQouYuj9fU6GpquSLuKQv29G
	 BKjan/TxBgYB4rbWX/wqwOsZ6a1dpinNMx9qTluxRbIr2Jxl5wLelXzauuW73nwOD7
	 ER5gPGXM201cBluZxxDci9UswbPQXbTeEr9xyymlHtF7wTS8cfsn008EbBiXUpTBA0
	 pwy1B2mJA88dS3fpx1W3RuDzCXkQ1fN0mETRgMaoLo8Z6hZ3fRzjXiO/vP3/IOKwKU
	 wEO4EV7fsszgg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 08/10] nvmet: Add 'sq' argument to alloc_ctrl_args
Date: Mon, 24 Feb 2025 13:38:16 +0100
Message-Id: <20250224123818.42218-9-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250224123818.42218-1-hare@kernel.org>
References: <20250224123818.42218-1-hare@kernel.org>
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

For secure concatenation the result of the TLS handshake will be
stored in the 'sq' struct, so add it to the alloc_ctrl_args struct.

Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/auth.c             |  2 +-
 drivers/nvme/target/core.c             |  2 +-
 drivers/nvme/target/fabrics-cmd-auth.c |  2 +-
 drivers/nvme/target/fabrics-cmd.c      | 11 +++++++----
 drivers/nvme/target/nvmet.h            |  6 ++++--
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index b47d675232d2..d0392ccda2a1 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -139,7 +139,7 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 	return ret;
 }
 
-u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 {
 	int ret = 0;
 	struct nvmet_host_link *p;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 43c9888eea90..c2563c39581b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1631,7 +1631,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	if (args->hostid)
 		uuid_copy(&ctrl->hostid, args->hostid);
 
-	dhchap_status = nvmet_setup_auth(ctrl);
+	dhchap_status = nvmet_setup_auth(ctrl, args->sq);
 	if (dhchap_status) {
 		pr_err("Failed to setup authentication, dhchap status %u\n",
 		       dhchap_status);
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 2022757f08dc..43b684af816c 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -246,7 +246,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
 				 __func__, ctrl->cntlid, req->sq->qid);
 			if (!req->sq->qid) {
-				dhchap_status = nvmet_setup_auth(ctrl);
+				dhchap_status = nvmet_setup_auth(ctrl, req->sq);
 				if (dhchap_status) {
 					pr_err("ctrl %d qid 0 failed to setup re-authentication\n",
 					       ctrl->cntlid);
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index a7ff05b3be29..899aa011936e 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -234,10 +234,12 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	return ret;
 }
 
-static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl)
+static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 {
+	bool needs_auth = nvmet_has_auth(ctrl);
+
 	return (u32)ctrl->cntlid |
-		(nvmet_has_auth(ctrl) ? NVME_CONNECT_AUTHREQ_ATR : 0);
+		(needs_auth ? NVME_CONNECT_AUTHREQ_ATR : 0);
 }
 
 static void nvmet_execute_admin_connect(struct nvmet_req *req)
@@ -247,6 +249,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = NULL;
 	struct nvmet_alloc_ctrl_args args = {
 		.port = req->port,
+		.sq = req->sq,
 		.ops = req->ops,
 		.p2p_client = req->p2p_client,
 		.kato = le32_to_cpu(c->kato),
@@ -299,7 +302,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	args.result = cpu_to_le32(nvmet_connect_result(ctrl));
+	args.result = cpu_to_le32(nvmet_connect_result(ctrl, req->sq));
 out:
 	kfree(d);
 complete:
@@ -357,7 +360,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out_ctrl_put;
 
 	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
-	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl));
+	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl, req->sq));
 out:
 	kfree(d);
 complete:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f4df458df9db..6afe3b4763d5 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -576,6 +576,7 @@ void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
 
 struct nvmet_alloc_ctrl_args {
 	struct nvmet_port	*port;
+	struct nvmet_sq		*sq;
 	char			*subsysnqn;
 	char			*hostnqn;
 	uuid_t			*hostid;
@@ -853,7 +854,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
-u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl);
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
@@ -872,7 +873,8 @@ int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
 int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 			    u8 *buf, int buf_size);
 #else
-static inline u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+static inline u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl,
+				  struct nvmet_sq *sq)
 {
 	return 0;
 }
-- 
2.35.3


