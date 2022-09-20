Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A644BC6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5K8BYUYhAIGTgYdE0nguQ0OVupxJffgDyHmdUrma0lw=; b=SXJ3QxKJ0Uwcl7dzuPFocznOx5
	VpvXwe/tijJ9fraslYZDxRLf/NCjA+WvtRstnPPQeRdz7xJnH4NwlW/A7q+rH0kVYrvAiW2ptTqGy
	NkKNF867sYjXjhc1JJNYOKRgHx0g1PByOCilzCFvIG1/L6KEJnXQwtx1flKnixGq4Cz02RNr5Lpvm
	2/oQO/9BEJ3z3nb3VFPK62FtPGD05B3ES+XUgWbx6n2f5Bz0Ld8JuX8Gm2in3bvFtbYMu3IFg8q/V
	9/bjR357amiw9BjTa0vgZro1Xwj8Cgxqp3JRKrE+caRIHh/a+Oyan6HxY6Hb2TFSdP7Jld4pdYaiX
	QefZhk5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagw5-005OWR-UP; Tue, 20 Sep 2022 17:21:30 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaguP-005NT2-P8; Tue, 20 Sep 2022 17:19:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvmet: add helpers to set the result field for connect commands
Date: Tue, 20 Sep 2022 19:19:31 +0200
Message-Id: <20220920171931.1289669-4-hch@lst.de>
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

The code to set the result field for the admin and I/O connect commands
is not only verbose and duplicated, but also violates the aliasing
rules as it accesses both the u16 and u32 members in the union.

Add a little helper to sort all that out.

 Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/fabrics-cmd.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 618f7adca70fd..43b5bd8bb6a52 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -198,6 +198,12 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	return ret;
 }
 
+static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl)
+{
+	return (u32)ctrl->cntlid |
+		(nvmet_has_auth(ctrl) ? NVME_CONNECT_AUTHREQ_ATR : 0);
+}
+
 static void nvmet_execute_admin_connect(struct nvmet_req *req)
 {
 	struct nvmf_connect_command *c = &req->cmd->connect;
@@ -269,10 +275,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
 		ctrl->pi_support ? " T10-PI is enabled" : "",
 		nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
-	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
-
-	if (nvmet_has_auth(ctrl))
-		req->cqe->result.u32 |= cpu_to_le32(NVME_CONNECT_AUTHREQ_ATR);
+	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl));
 out:
 	kfree(d);
 complete:
@@ -328,13 +331,8 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	if (status)
 		goto out_ctrl_put;
 
-	/* pass back cntlid for successful completion */
-	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
-
 	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
-	if (nvmet_has_auth(ctrl))
-		req->cqe->result.u32 |= cpu_to_le32(NVME_CONNECT_AUTHREQ_ATR);
-
+	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl));
 out:
 	kfree(d);
 complete:
-- 
2.30.2


