Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400F8C04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:24:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1AC561004
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AC561004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hWN2LsMSAkVFUDI4oCZV4H9fiR7riwnGSjvz+Nae6R0=; b=TuQmu1yaaY1Sa4IZmNZT3/FKhn
	zRmWDnKtMMG46nZ6yX6nvjmU9IqMAA8RvxLzD8U/KwdnUjGc3NbizIpl0CYkv9ZCgbn5gBcCOLZya
	4vMY+CV8Nj83QEg+ObUUf+OAs+2Z8CNEjC7Gq1Qe4g/JraVQ0/KeqcsWZ75kPJ17Cy3LX7a/rq52M
	Cz2u/8mN2HatZnqsrnvoxwpGhLpB90gQszi9zS52sVceQKxPCsihSEd76xHdvHrirokxVGlgOCPJd
	Gqir8o/X/UTl7brLIA3cr0kDULzWWGGjmS7+kjHurc7NhTDnG4M9MzmlzHdIL6Wg2wIHQzMd3WfX0
	OIVC8rYw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkBh8-001242-92; Fri, 21 May 2021 20:24:30 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkBeb-0011OJ-U4
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 20:21:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=PxJSKfQ9TzamXw/2LBbl868HacptMuvpkC80fx9eSC4=; b=lrB9Gq4mOUFZc42wP0ABNqEGCg
 RltQ1gDsdgNoALGk5O7sH8be827XglERmhYtkwpaXKQ89OxZaBiIL+8cFyIg5FaNthrqaj+ujBBaj
 7aIqe/VnhDA84bwFw7f13YfjNa7UGf7pWSxkbSVf9K1ScsYtZgwLtI+TyvJav+YbWk9gF9hrroweD
 CltNulLGl+Sic1TCfhmkOnl+IWxX12gX11T7+sWXq9lFhD6ybHoNWTIFf5p7mdbwcjACNugnJBNWo
 pvX4DpK75R7P6iCrHwdT/y9SO04AbVSllaixp9KKz9o5ev6kqk+vE2kY+w/ijBsIiutDNSDZbUx3u
 APS206mg==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkBeZ-00HPOk-5b
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 20:21:52 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E5BF6135A;
 Fri, 21 May 2021 20:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621628510;
 bh=6m2eCmCZZnbOPSgGeuvIFaNXuTsftPSL5d8vIqd9YiA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VDa/po8x5pobjA1iL52KQAO3x6AJjhUuomy2MzuBYns0S446ShOGs6o0K1Irhbmmq
 EraBQKEYmpKgswEKNcy3f8OMppHVshuwoKMWnyYgmDs3t5RcFr6EPY0HegYrutbgIg
 Hkw7404JKKNq4f4WQ6y6TBsXfI9CxiDWTfut+MWxTg/ihBgoBDq4nLsNIqc3inn8+j
 xED5kgbWIxzL4RGT6hvViUwKywzTmnwnliUC1VP378Ucfete/wgEB/0gbltDu3qgTQ
 T5+SxP3+Mt6TrTiU8mDfjk7n9NL80PEeXJcwDcYOmpMhVNijC4qZHJvBd9FUmuYQPB
 W7ORlwPTo/Acw==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 4/4] nvme: use return value from blk_execute_rq()
Date: Fri, 21 May 2021 13:21:45 -0700
Message-Id: <20210521202145.3674904-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210521202145.3674904-1-kbusch@kernel.org>
References: <20210521202145.3674904-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_132151_269820_8A8F4D47 
X-CRM114-Status: GOOD (  17.76  )
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
returns an error without dispatching the requested nvme command. Check
the return value from blk_execute_rq() for all passthrough commands so
the caller may know their command was not successful.

If the command is from the target passthrough interface and fails to
dispatch, synthesize the response back to the host as a internal target
error.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Initialize nvme status to 0

  Add helper function for blk_status_t to nvme passthrough return code

 drivers/nvme/host/core.c       | 33 +++++++++++++++++++++++++--------
 drivers/nvme/host/ioctl.c      |  6 +-----
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/target/passthru.c |  8 ++++----
 4 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a73eed61eee..99e10476f377 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -589,6 +589,7 @@ EXPORT_SYMBOL_NS_GPL(nvme_put_ns, NVME_TARGET_PASSTHRU);
 
 static inline void nvme_clear_nvme_request(struct request *req)
 {
+	nvme_req(req)->status = 0;
 	nvme_req(req)->retries = 0;
 	nvme_req(req)->flags = 0;
 	req->rq_flags |= RQF_DONTPREP;
@@ -1012,6 +1013,21 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
 
+/*
+ * Return values:
+ * 0:  success
+ * >0: nvme controller's cqe status response
+ * <0: kernel error in lieu of controller response
+ */
+static int nvme_passthrough_status(struct request *rq, blk_status_t status)
+{
+	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
+		return -EINTR;
+	else if (nvme_req(rq)->status)
+		return nvme_req(rq)->status;
+	return blk_status_to_errno(status);
+}
+
 /*
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
@@ -1022,6 +1038,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		blk_mq_req_flags_t flags)
 {
 	struct request *req;
+	blk_status_t status;
 	int ret;
 
 	if (qid == NVME_QID_ANY)
@@ -1040,13 +1057,10 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 			goto out;
 	}
 
-	blk_execute_rq(NULL, req, at_head);
-	if (result)
+	status = blk_execute_rq(NULL, req, at_head);
+	ret = nvme_passthrough_status(req, status);
+	if (result && ret >= 0)
 		*result = nvme_req(req)->result;
-	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
-		ret = -EINTR;
-	else
-		ret = nvme_req(req)->status;
  out:
 	blk_mq_free_request(req);
 	return ret;
@@ -1134,18 +1148,21 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 	}
 }
 
-void nvme_execute_passthru_rq(struct request *rq)
+int nvme_execute_passthru_rq(struct request *rq)
 {
 	struct nvme_command *cmd = nvme_req(rq)->cmd;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct gendisk *disk = ns ? ns->disk : NULL;
+	blk_status_t status;
 	u32 effects;
 
 	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
-	blk_execute_rq(disk, rq, 0);
+	status = blk_execute_rq(disk, rq, 0);
 	if (effects) /* nothing to be done for zero cmd effects */
 		nvme_passthru_end(ctrl, effects);
+
+	return nvme_passthrough_status(rq, status);
 }
 EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9557ead02de1..4e6bcc3c1c0d 100644
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
index 84bff995a308..9ea827871d67 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -877,7 +877,7 @@ static inline void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
 
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
-void nvme_execute_passthru_rq(struct request *rq);
+int nvme_execute_passthru_rq(struct request *rq);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 void nvme_put_ns(struct nvme_ns *ns);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 39b1473f7204..ba28ce42cb55 100644
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
