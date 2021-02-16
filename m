Return-Path: <SRS0=dBpD=HS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289EAC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 21:31:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C8264D99
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 21:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C8264D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+mklwMCuB5T5meNJtBtaKi7IT0aGR2aRRACGhmX6k3o=; b=XrMKvErp4DOCxthAxbmRXWP0g
	VgNJUew5AbU3F+6oQ/dEYKwjJA9JSmx/8Pxtei099pv6yhYr4DVBPxQEENoSnY7z+3pLlCkPBhL/0
	+ttn+LVomn1YPFePlAlgqbjd/+1LE9xoHz42YHfZGFqm2mcdzpP0cjovXH5G9VleVwcif7mK+jD8/
	9yTdDUTJAAJ++UfnAdBbb+4zyYMbSLj6w5/18oC+vovp2Pjwa08uOsOiRLZ1wvLYwCyIfuTHH11k0
	5tCZjAbmRWjhGwq3BevL93n8H4wab5BS8065vNKtV4jocGWtIGPP7biYI/id0G0TKc1c59X2HZja8
	mfLSXmV9Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lC7wo-0005Zr-Vj; Tue, 16 Feb 2021 21:31:55 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lC7wl-0005YI-Lo
 for linux-nvme@lists.infradead.org; Tue, 16 Feb 2021 21:31:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613511111; x=1645047111;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X5cWMCqxaP8X2V6zFUmQoJphqoQqVlyvJd2KaVGDAIg=;
 b=YQS8t/uUGkSw0IP+wOAs36Nx5Hv++Pl+RpgyH1QquTPTvJQ9hZw+8H/l
 QKvlZVw1N7rnhPPWv9EobOBLE3RYm3qbLZhmo9jfaowAPgOKyTM6Ddk8g
 1QBYrc5jxMmooskCss6n+zme7kcQAHFj+NnI1mTUr6dUn7NyVpPo3NoCO
 twXxW7dH5Dp9p2BUEvf2FvoXp8GXY1BboUTSXqa8EtJRXQI+nX6AuVyLq
 K7sOE3a9Lh/AKM1fWUvWcXGG7Tj14mAQdyuZbEnlfIysZCxrC1QrVJykH
 xccZxd2hjdBsC2IcYiNDlkZbIya9KJgzaP9XqqIMF/4O18JX+hFMR5gcC Q==;
IronPort-SDR: d98/dsnPt1JT+EsldG95jo3ZovWHwv+mXYCy2NNgZ5uRb+q3x65UmDKWbkWjTFCypovlRubzL8
 fgl6XCsJhPUXWEi18ugrjxCeTkudrvb+TaZ4r3/8mpfb4mGpjXeXRty1pOQxyWuLm8Om7Vt2Wq
 O5M7jCezbnhAQH3yOgjdfEE/Rzt0gM05mPL4ULadJfnX3fWZ5kvoQjdjo5FsdL9tiqkvyu5wJD
 DusY0xpgLO/WAqGtjnb752XHBWQEguMrR8ivxeDO7GU/n2gM2ltiBHtUNpN9rCE2vcmXBxHP3F
 xgk=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="160114359"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 05:31:50 +0800
IronPort-SDR: Hr3K25Zt4qTO1oHTfPOWlR93qhg1yqOHjrRaTCfwuZlJ5yFe78nsJO+aU8C4ooellVFuKZR61X
 U/Y6XIXJlVJXCa9glnhSMoN4erHIyZ90yhl38P1vooANU3wdvvxUQOUK4rCCFv7evypg82KSJ3
 IdJC4c1zTcOVdwub8pNUOFye8CHUNb4BNNsj7iMqbxuphzNGMyqId9uzs6ZxXG0lbA1SgtW/On
 uJ3l4PWr6W3DJlYY0od4DwHMnSR4lmH7NcMMWBElHPLM8dpJBOf5oZ5zuQGKaRKGo/2OnkO9Y9
 AFX6nBIoMXTHUQyzWr5E19Qi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 13:13:35 -0800
IronPort-SDR: c8d1W+yvNjWFtdkf76m/Vo7zGChq7guKCbkvv3WyNe0ViXGlg0G4Fm/4532DcAOiEcKGeWEE91
 YYJvSg/JuwahChxKR1HUszQZbg76SvUYkVbUihVreDQPNBVEoAlpnqZAMmy7XasLyNBBie1OMq
 shActW9QJB8zui4rur/nDgCBDq5MpzAqAYJFQf2Ruj3tpDGw4bsLUXPUrM9zeNJrwV+Fa33zvc
 w9TXbZyqU9fZnlBYPbwUUNiahk6x9DPCp32/NgVG+mGUQ5w6oUFzmxVi4JZ1s53FmYwiG+iBYR
 4UM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 13:31:50 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 4/6] nvmet: remove unnecessary function parameters
Date: Tue, 16 Feb 2021 13:31:10 -0800
Message-Id: <20210216213112.20078-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210216213112.20078-1-chaitanya.kulkarni@wdc.com>
References: <20210216213112.20078-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_163151_895844_30B525EF 
X-CRM114-Status: GOOD (  17.17  )
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

The function nvmet_ctrl_find_get() accepts subsysnqn, hostnqn, cntlid,
nvmet_req, and out pointer to nvmet_ctrl structure. The parameters
subsysnqn, hostnqn and cntlid can be derived from the caller's
struct nvmf_connect_data.

Replace these parameters with structure pointer nvmf_connect_data *d.

Also, this function returns the same error value from two places. First
on failure to find subsystem from connect data and failure to find ctrl
from cntlid connect data:- NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR.

Move this to the caller to change the return type so we can return ctrl.

Now that we can change the return type instead of taking the pointer to
pointer to the nvmet_ctrl structure remove that function parameter and
return the valid nvmet_ctrl pointer on success and NULL on failure.

Also, add and rename the goto labels for more readability with comment.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c        | 30 +++++++++++++++---------------
 drivers/nvme/target/fabrics-cmd.c | 10 +++++-----
 drivers/nvme/target/nvmet.h       |  4 ++--
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index df2d3de0de62..518dadc395b3 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1179,45 +1179,45 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 	ctrl->cap |= NVMET_QUEUE_SIZE - 1;
 }
 
-u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
-		struct nvmet_req *req, struct nvmet_ctrl **ret)
+struct nvmet_ctrl *nvmet_ctrl_find_get(struct nvmf_connect_data *d,
+				       struct nvmet_req *req)
 {
+	struct nvmet_ctrl *ctrl = NULL;
 	struct nvmet_subsys *subsys;
-	struct nvmet_ctrl *ctrl;
-	u16 status = 0;
 
-	subsys = nvmet_find_get_subsys(req->port, subsysnqn);
+	subsys = nvmet_find_get_subsys(req->port, d->subsysnqn);
 	if (!subsys) {
 		pr_warn("connect request for invalid subsystem %s!\n",
-			subsysnqn);
+			d->subsysnqn);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
-		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+		goto out;
 	}
 
 	mutex_lock(&subsys->lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
-		if (ctrl->cntlid == cntlid) {
-			if (strncmp(hostnqn, ctrl->hostnqn, NVMF_NQN_SIZE)) {
+		if (ctrl->cntlid == le16_to_cpu(d->cntlid)) {
+			if (strncmp(d->hostnqn, ctrl->hostnqn, NVMF_NQN_SIZE)) {
 				pr_warn("hostnqn mismatch.\n");
 				continue;
 			}
 			if (!kref_get_unless_zero(&ctrl->ref))
 				continue;
 
-			*ret = ctrl;
-			goto out;
+			/* ctrl found */
+			goto found;
 		}
 	}
 
+	ctrl = NULL; /* ctrl not found */
 	pr_warn("could not find controller %d for subsys %s / host %s\n",
-		cntlid, subsysnqn, hostnqn);
+		le16_to_cpu(d->cntlid), d->subsysnqn, d->hostnqn);
 	req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
-	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 
-out:
+found:
 	mutex_unlock(&subsys->lock);
 	nvmet_subsys_put(subsys);
-	return status;
+out:
+	return ctrl;
 }
 
 u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd)
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index cf0baa911db2..46578f98abcc 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -223,7 +223,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 {
 	struct nvmf_connect_command *c = &req->cmd->connect;
 	struct nvmf_connect_data *d;
-	struct nvmet_ctrl *ctrl = NULL;
+	struct nvmet_ctrl *ctrl;
 	u16 qid = le16_to_cpu(c->qid);
 	u16 status = 0;
 
@@ -250,11 +250,11 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	status = nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
-				     le16_to_cpu(d->cntlid),
-				     req, &ctrl);
-	if (status)
+	ctrl = nvmet_ctrl_find_get(d, req);
+	if (!ctrl) {
+		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 		goto out;
+	}
 
 	if (unlikely(qid > ctrl->subsys->max_qid)) {
 		pr_warn("invalid queue id (%d)\n", qid);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index cdfa537b1c0a..e8211a63eac3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -433,8 +433,8 @@ void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
 void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
 u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp);
-u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
-		struct nvmet_req *req, struct nvmet_ctrl **ret);
+struct nvmet_ctrl *nvmet_ctrl_find_get(struct nvmf_connect_data *d,
+				       struct nvmet_req *req);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
 u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd);
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
