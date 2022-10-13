Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C1BC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 00:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=29XhA/ewgTwuBBC6JjIeTtw8390aJtLXUrLFBgeATcA=; b=x16pfO8xvAcMUckBSRb8vMUthC
	h+I+zuUS36A9+s5/kekeKX6Dp9Y8mSgpzLGUDBugWb/LlxkRPOX58ZYrfK/w/2E3WAuXvpJocyxzv
	ThoyIplq+b6BsMnFwC0m9Xv5RAls8gqjygV47KHJlhUj7RN9gFLidhunUNQqbdtCA/QKzK0EUnahA
	4E3JfQJwPEnLYr5twmkvL1COUZpfcFoarNjQBci8YLe0ON9TCTQVTeF1Yr7oOFm2bJw6rA0p/NCjl
	6z85vmENfY79Zemrg2EtVKUZWpb9hljX4G3BnAG1wHwum0rM4SKluXp+iEnHMc7EOcOVj+nsv3oWq
	56IdCveg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oilvV-009n5W-BI; Thu, 13 Oct 2022 00:18:17 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oilvJ-009myC-NH
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 00:18:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 69267B81CBE;
	Thu, 13 Oct 2022 00:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB91C433D6;
	Thu, 13 Oct 2022 00:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665620283;
	bh=P76NqlLy/+PZwCIIZvaC8DZgX9q9lu+DZUsFci9KUYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZwZ7fjSs0lZkvVYfV6CzcZnsudvlwnMKNbioe37B0Bein978fgyMZUbhmA8oqipD
	 HQ6lftNmNnfrUZD/Q5IKsK9wuLWYWjXKfIrbUEmBECa+UxyDu5ksqfgOgr4pTrt4GJ
	 dmf0ejNrEFXVVGXbHpgrQko71o+tVMsizB6PJv80kvKPSVg1L1kS74W8Gmwfs7x9PX
	 8Ii83SQA0RsU9uZjiIQv4fqVpJShcaS+6wFYd1HPOAKhIF8+G6k/yusE1i6SEjLzBm
	 Kaj/lxXro55PGbhrI5g1hCdb/cTqHWWgiGb6V5JZ1XIjZVZcLsXs0oqWwPAusVyrfT
	 INYQEZNveEm0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jonathan Derrick <Jonathan.Derrick@solidigm.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.0 52/67] nvme: handle effects after freeing the request
Date: Wed, 12 Oct 2022 20:15:33 -0400
Message-Id: <20221013001554.1892206-52-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013001554.1892206-1-sashal@kernel.org>
References: <20221013001554.1892206-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_171806_085028_45354ED3 
X-CRM114-Status: GOOD (  18.18  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit bc8fb906b0ff9339b4286698cb7cd9cd5b8c53eb ]

If a reset occurs after the scan work attempts to issue a command, the
reset may quisce the admin queue, which blocks the scan work's command
from dispatching. The scan work will not be able to complete while the
queue is quiesced.

Meanwhile, the reset work will cancel all outstanding admin tags and
wait until all requests have transitioned to idle, which includes the
passthrough request. But the passthrough request won't be set to idle
until after the scan_work flushes, so we're deadlocked.

Fix this by handling the end effects after the request has been freed.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216354
Reported-by: Jonathan Derrick <Jonathan.Derrick@solidigm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chao Leng <lengchao@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c       | 17 ++++++-----------
 drivers/nvme/host/ioctl.c      |  9 ++++++++-
 drivers/nvme/host/nvme.h       |  4 +++-
 drivers/nvme/target/passthru.c |  7 ++++++-
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8d5a7ae19844..7991d28e6a6a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1111,8 +1111,8 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return effects;
 }
 
-static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
-			      struct nvme_command *cmd, int status)
+void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+		       struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
 		nvme_unfreeze(ctrl);
@@ -1148,21 +1148,16 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		break;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
 
-int nvme_execute_passthru_rq(struct request *rq)
+int nvme_execute_passthru_rq(struct request *rq, u32 *effects)
 {
 	struct nvme_command *cmd = nvme_req(rq)->cmd;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
 	struct nvme_ns *ns = rq->q->queuedata;
-	u32 effects;
-	int  ret;
 
-	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
-	ret = nvme_execute_rq(rq, false);
-	if (effects) /* nothing to be done for zero cmd effects */
-		nvme_passthru_end(ctrl, effects, cmd, ret);
-
-	return ret;
+	*effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
+	return nvme_execute_rq(rq, false);
 }
 EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 27614bee7380..d3281f87cd6e 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -136,9 +136,11 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, u64 *result, unsigned timeout, bool vec)
 {
+	struct nvme_ctrl *ctrl;
 	struct request *req;
 	void *meta = NULL;
 	struct bio *bio;
+	u32 effects;
 	int ret;
 
 	req = nvme_alloc_user_request(q, cmd, ubuffer, bufflen, meta_buffer,
@@ -147,8 +149,9 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		return PTR_ERR(req);
 
 	bio = req->bio;
+	ctrl = nvme_req(req)->ctrl;
 
-	ret = nvme_execute_passthru_rq(req);
+	ret = nvme_execute_passthru_rq(req, &effects);
 
 	if (result)
 		*result = le64_to_cpu(nvme_req(req)->result.u64);
@@ -158,6 +161,10 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (bio)
 		blk_rq_unmap_user(bio);
 	blk_mq_free_request(req);
+
+	if (effects)
+		nvme_passthru_end(ctrl, effects, cmd, ret);
+
 	return ret;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1bdf714dcd9e..a0bf9560cf67 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1023,7 +1023,9 @@ static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
-int nvme_execute_passthru_rq(struct request *rq);
+int nvme_execute_passthru_rq(struct request *rq, u32 *effects);
+void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+		       struct nvme_command *cmd, int status);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 void nvme_put_ns(struct nvme_ns *ns);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 6f39a29828b1..94d3153bae54 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -215,9 +215,11 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, p.work);
 	struct request *rq = req->p.rq;
+	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
+	u32 effects;
 	int status;
 
-	status = nvme_execute_passthru_rq(rq);
+	status = nvme_execute_passthru_rq(rq, &effects);
 
 	if (status == NVME_SC_SUCCESS &&
 	    req->cmd->common.opcode == nvme_admin_identify) {
@@ -238,6 +240,9 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	req->cqe->result = nvme_req(rq)->result;
 	nvmet_req_complete(req, status);
 	blk_mq_free_request(rq);
+
+	if (effects)
+		nvme_passthru_end(ctrl, effects, req->cmd, status);
 }
 
 static void nvmet_passthru_req_done(struct request *rq,
-- 
2.35.1


