Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E25C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I3AkLKKsypHzF4tPUfK76vUaltemIeQiSmCeLvKExpA=; b=g2zpe6gTDlOBQcoaN9dd4jYBYI
	cvgDtfGWXfAQwTMo9s8tHCz6uKArMvM78DBIdUDx8extOT8xOavD+rqg8PF5FpXrBxErM6uOKg00C
	m9Z1/d94heAgCQxSV7prrIH0cR7v2qITlN7jRDI04CrX53imu0FKV/pBpqHbOgXkHqi/O1S1Dchb7
	GBJ8w2+XFEWavqtFPBh12Alu80cL0lpVfWKy2wlYfGNPRBJbhSrntsZEVHcCDdQfS9MF0GBB9748x
	bAb4rhWdhD3SXQLeAkGyKpYeCHMSXloqcRjxmTKEOTgF4MHTxV0Y8OOyP7L/9EJsj2nd9K/c+Q0r9
	NaQz+CHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaguw-005Nlb-Pg; Tue, 20 Sep 2022 17:20:18 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaguH-005NO7-Uv; Tue, 20 Sep 2022 17:19:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] nvmet-auth: don't try to cancel a non-initialized work_struct
Date: Tue, 20 Sep 2022 19:19:29 +0200
Message-Id: <20220920171931.1289669-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920171931.1289669-1-hch@lst.de>
References: <20220920171931.1289669-1-hch@lst.de>
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

Currently blktests nvme/002 trips up debugobjects if CONFIG_NVME_AUTH is
enabled, but authentication is not on a queue.  This is because
nvmet_auth_sq_free cancels sq->auth_expired_work unconditionaly, while
auth_expired_work is only ever initialized if authentication is enabled
for a given controller.

Fix this by calling most of what is nvmet_init_auth unconditionally
when initializing the SQ, and just do the setting of the result
field in the connect command handler.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/core.c             |  1 +
 drivers/nvme/target/fabrics-cmd-auth.c | 13 ++++---------
 drivers/nvme/target/fabrics-cmd.c      |  6 ++++--
 drivers/nvme/target/nvmet.h            |  7 ++++---
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a1345790005f4..8e3cf0c3588ce 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -830,6 +830,7 @@ int nvmet_sq_init(struct nvmet_sq *sq)
 	}
 	init_completion(&sq->free_done);
 	init_completion(&sq->confirm_done);
+	nvmet_auth_sq_init(sq);
 
 	return 0;
 }
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 84601e38a335a..7970a7640e585 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -23,17 +23,12 @@ static void nvmet_auth_expired_work(struct work_struct *work)
 	sq->dhchap_tid = -1;
 }
 
-void nvmet_init_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
+void nvmet_auth_sq_init(struct nvmet_sq *sq)
 {
-	u32 result = le32_to_cpu(req->cqe->result.u32);
-
 	/* Initialize in-band authentication */
-	INIT_DELAYED_WORK(&req->sq->auth_expired_work,
-			  nvmet_auth_expired_work);
-	req->sq->authenticated = false;
-	req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
-	result |= (u32)NVME_CONNECT_AUTHREQ_ATR << 16;
-	req->cqe->result.u32 = cpu_to_le32(result);
+	INIT_DELAYED_WORK(&sq->auth_expired_work, nvmet_auth_expired_work);
+	sq->authenticated = false;
+	sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
 }
 
 static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index c1dfdfb92ebf0..c7e903589d377 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -272,7 +272,8 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
 
 	if (nvmet_has_auth(ctrl))
-		nvmet_init_auth(ctrl, req);
+		req->cqe->result.u32 |=
+			cpu_to_le32((u32)NVME_CONNECT_AUTHREQ_ATR << 16);
 out:
 	kfree(d);
 complete:
@@ -333,7 +334,8 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 
 	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
 	if (nvmet_has_auth(ctrl))
-		nvmet_init_auth(ctrl, req);
+		req->cqe->result.u32 |=
+			cpu_to_le32((u32)NVME_CONNECT_AUTHREQ_ATR << 16);
 
 out:
 	kfree(d);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6ffeeb0a1c49e..dfe3894205aa7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -704,7 +704,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
 int nvmet_setup_auth(struct nvmet_ctrl *ctrl);
-void nvmet_init_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
+void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
 int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id);
@@ -726,8 +726,9 @@ static inline int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 {
 	return 0;
 }
-static inline void nvmet_init_auth(struct nvmet_ctrl *ctrl,
-				   struct nvmet_req *req) {};
+static inline void nvmet_auth_sq_init(struct nvmet_sq *sq)
+{
+}
 static inline void nvmet_destroy_auth(struct nvmet_ctrl *ctrl) {};
 static inline void nvmet_auth_sq_free(struct nvmet_sq *sq) {};
 static inline bool nvmet_check_auth_status(struct nvmet_req *req)
-- 
2.30.2


