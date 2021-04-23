Return-Path: <SRS0=/503=JU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C564C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 22:07:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B73661468
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 22:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B73661468
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2MY0X+MdR20iCMEi31ewV2p1lMtW1E9Ykcb47/DhcLc=; b=JPzpT1+9rRwRcbNic7KnPYJQI
	J5rivcd3rkAI/yShkfIU4+E/iAD4jFGJ1psXbjS7cWng5FQkreNITVRqFYlODuOdj/RW83O103MT8
	THR5lMgB7xAbzotj/srbcQuKPgKzHgWrLyqqScIeGlMOA0zZrfnpspfPhecpT7hMPA18/ZdWMRcJ8
	QLDmyJ+rixKiFCqbmARKrwP0woo1t6zq85XwNcRklS1taayZo0o4Vgj2XEIerLQnGasX0eJadj21B
	Zn4eEBJd2YqSsycEMpLPNPZBO32YauJJ4d4x6kNu40dR97FbmuIuAvHxrXthfg2omrKgr1bNhVKUQ
	iVJzD9xDA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1la3xL-002TNd-OI; Fri, 23 Apr 2021 22:07:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la3w7-002TDt-87
 for linux-nvme@desiato.infradead.org; Fri, 23 Apr 2021 22:06:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=36XanKNaIjtzWAb5M4chknpYrGeEdjFTwRB5qveHtfA=; b=PM+4Tbs9rh1yYSyv+U0MJ/3IXQ
 xMrpkQiqtaGlaNlC+9OnTc/KQRoAxjRBnfSUdvV2XkrSHHsZ0D1ieEXT0e8Gw3a3/OBjAcjFBr7X6
 +KaSlurumiSpEwTg1OMFwxlAUksJBvnOruLUOFj2NPOLK3Ai7XCvtCaUiQvTprou9WRyCMZrWtGOZ
 345oj/YHblNeMObY4i4DzeKJQpYFwuX6qYIYIpILkV4YDTk+0wNZ2Lnvg4NoftT+aMUzYN50LT/Er
 iWAHufATB2QlSgtGXgk8lU7JoUbaRx0nV1QeLk/q5sphJp8Xmjp9uagRy6fjvchQHFJewxowZNent
 Bgg/ijOQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la3w4-00Ej8q-GZ
 for linux-nvme@lists.infradead.org; Fri, 23 Apr 2021 22:06:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B8B76146D;
 Fri, 23 Apr 2021 22:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619215564;
 bh=0DSvxqZxeybLVLkBKLwRn//YdD8ZMmnsCFzoyFW8puk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f/9fYTDlxoomU7IzKPtRk0iI/v55bCqtXtY3sIHGK/RSK9V5RbLpONaFwWIGP0LRO
 1YGoHykmdvvMgX+lHgXohFPKSUjiPBu94KT9dIfHKwlO/SqJMkXOgezs4Fk0560ANa
 FScoQCxc84cdSROmIJhYoCl1H+5VySfhnDnNFOY1y4CO+8fXMlL0V3vKuSF53acg9L
 D35ChJ+HZDSp61wpQsyiCjeAlFaltSlULlyl/+czIA7T0do0ilW7MEAFEa4IOkcqCE
 UV8RHe+a5faZhiOtxNdkbn5OrOr1ngeUxD7iLqClmOaELyRnw7oGRZV/eNV5IfHhx6
 LLK7BSbYvn1Pw==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 4/5] nvme: use return value from blk_execute_rq()
Date: Fri, 23 Apr 2021 15:05:57 -0700
Message-Id: <20210423220558.40764-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210423220558.40764-1-kbusch@kernel.org>
References: <20210423220558.40764-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_150604_613126_EB3BF223 
X-CRM114-Status: GOOD (  16.46  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We don't have an nvme status to report if the driver's .queue_rq()
returns an error without dispatching the requested nvme command. Use the
return value from blk_execute_rq() for all passthrough commands so the
caller may know their command was not successful.

If the command is from the target passthrough interface and fails to
dispatch, synthesize the response back to the host as a internal target
error.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c       | 16 ++++++++++++----
 drivers/nvme/host/ioctl.c      |  6 +-----
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/target/passthru.c |  8 ++++----
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 10bb8406e067..62af5fe7a0ce 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -972,12 +972,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 			goto out;
 	}
 
-	blk_execute_rq(NULL, req, at_head);
+	ret = blk_execute_rq(NULL, req, at_head);
 	if (result)
 		*result = nvme_req(req)->result;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
-	else
+	else if (nvme_req(req)->status)
 		ret = nvme_req(req)->status;
  out:
 	blk_mq_free_request(req);
@@ -1066,18 +1066,26 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 	}
 }
 
-void nvme_execute_passthru_rq(struct request *rq)
+int nvme_execute_passthru_rq(struct request *rq)
 {
 	struct nvme_command *cmd = nvme_req(rq)->cmd;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct gendisk *disk = ns ? ns->disk : NULL;
 	u32 effects;
+	int ret;
 
 	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
-	blk_execute_rq(disk, rq, 0);
+	ret = blk_execute_rq(disk, rq, 0);
 	if (effects) /* nothing to be done for zero cmd effects */
 		nvme_passthru_end(ctrl, effects);
+
+	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
+		ret = -EINTR;
+	else if (nvme_req(rq)->status)
+		ret = nvme_req(rq)->status;
+
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 8e05d65c9e93..9cdd8bfebb80 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -93,11 +93,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		}
 	}
 
-	nvme_execute_passthru_rq(req);
-	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
-		ret = -EINTR;
-	else
-		ret = nvme_req(req)->status;
+	ret = nvme_execute_passthru_rq(req);
 	if (result)
 		*result = le64_to_cpu(nvme_req(req)->result.u64);
 	if (meta && !ret && !write) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c8f6ec5b8d2b..76a7ed0728b9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -847,7 +847,7 @@ static inline void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
 
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
-void nvme_execute_passthru_rq(struct request *rq);
+int nvme_execute_passthru_rq(struct request *rq);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 void nvme_put_ns(struct nvme_ns *ns);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 2798944899b7..d9a649d9903b 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -153,11 +153,10 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, p.work);
 	struct request *rq = req->p.rq;
-	u16 status;
+	int status;
 
-	nvme_execute_passthru_rq(rq);
+	status = nvme_execute_passthru_rq(rq);
 
-	status = nvme_req(rq)->status;
 	if (status == NVME_SC_SUCCESS &&
 	    req->cmd->common.opcode == nvme_admin_identify) {
 		switch (req->cmd->identify.cns) {
@@ -168,7 +167,8 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 			nvmet_passthru_override_id_ns(req);
 			break;
 		}
-	}
+	} else if (status < 0)
+		status = NVME_SC_INTERNAL;
 
 	req->cqe->result = nvme_req(rq)->result;
 	nvmet_req_complete(req, status);
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
