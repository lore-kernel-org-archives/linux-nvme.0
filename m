Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23DFECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Sep 2022 19:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fknC6DakP1y9/qWOC673CDlp6f9DsbYasEs92PkknTc=; b=TJOfIxQthLJmbK7UpXt1HqC9AB
	0Ppf6PZOdtfg6vnVxCRq2LouaQC2ZwdKDfKtKC7QqUyJ9heFiEl2ABVorvYUfNkiyvJXjj5ef0rX2
	Tdw6CeXN7ScOleUDZri5Qm3EmHREOgtUHhQsopK2z/oPnqoU5uWbBSVH83HJ23gOt3nAFyP9wYYRY
	/9xI20PkQk/Zi1f68HH3Ikqymgom9Z4U2g2cVExmE88qQ5Ze+VgamytdElqlbZ8JiLDGHsu9aM8Cu
	r8CBUj1HKnwgRZfeev0QIpjjhxI0kPmr7tRGFArXQQUC3BZvThOZsL6DA21AkPtRqUkLAliCDnY2j
	D5E9zT8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaMaN-00EYky-OT; Mon, 19 Sep 2022 19:37:43 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaMZu-00EX8q-CP
	for linux-nvme@lists.infradead.org; Mon, 19 Sep 2022 19:37:16 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JJMOFP020896
	for <linux-nvme@lists.infradead.org>; Mon, 19 Sep 2022 12:37:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=fknC6DakP1y9/qWOC673CDlp6f9DsbYasEs92PkknTc=;
 b=ZlUDF27VDO3u0lUHU2DIZxhFBUNmAk1rgPuTqGfxqCq9sk0iCQHji/whJvDHZHUgKCJV
 oqHcrtwND/KF/KSh3NJ7j7Ww3dNMvvkSHSMNocYZudTjkyMWEYKBKFXGPyB2X1Q5JoeH
 75dyfjOdw7Dx5mEQNLp3Vzux/frgReKDuYg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jnbyxnbpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 19 Sep 2022 12:37:02 -0700
Received: from twshared6240.04.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 12:37:00 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 4D39A8CCA657; Mon, 19 Sep 2022 12:36:47 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>,
        Jonathan Derrick
	<Jonathan.Derrick@solidigm.com>
Subject: [PATCHv2] nvme: handle effects after freeing the request
Date: Mon, 19 Sep 2022 12:36:46 -0700
Message-ID: <20220919193646.1599162-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: arBjK7EHCpDedHBooTSXrl_XFXMP3lhc
X-Proofpoint-ORIG-GUID: arBjK7EHCpDedHBooTSXrl_XFXMP3lhc
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_123714_626466_9A82B674 
X-CRM114-Status: GOOD (  21.43  )
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

If a reset occurs after the scan work attempts to issue a command, the
reset may quisce the admin queue, which blocks the scan work's command
from dispatching. The scan work will not be able to complete while the
queue is quiesced.

Meanwhile, the reset work will cancel all outstanding admin tags and
wait until all requests have transitioned to idle, which includes the
passthrough request. But the passthrough request won't be set to idle
until after the scan_work flushes, so we're deadlocked.

Fix this by handling the end effects after the request has been freed.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216354
Reported-by: Jonathan Derrick <Jonathan.Derrick@solidigm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Open code the effects end handling in each of the callers instead of
  special casing just the 'flush_work' part.

 drivers/nvme/host/core.c       | 17 ++++++-----------
 drivers/nvme/host/ioctl.c      |  9 ++++++++-
 drivers/nvme/host/nvme.h       |  4 +++-
 drivers/nvme/target/passthru.c |  7 ++++++-
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8c9c1176624d..ea6694fd550f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1111,8 +1111,8 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl=
, struct nvme_ns *ns,
 	return effects;
 }
=20
-static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
-			      struct nvme_command *cmd, int status)
+void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+		       struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
 		nvme_unfreeze(ctrl);
@@ -1148,21 +1148,16 @@ static void nvme_passthru_end(struct nvme_ctrl *ctr=
l, u32 effects,
 		break;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
=20
-int nvme_execute_passthru_rq(struct request *rq)
+int nvme_execute_passthru_rq(struct request *rq, u32 *effects)
 {
 	struct nvme_command *cmd =3D nvme_req(rq)->cmd;
 	struct nvme_ctrl *ctrl =3D nvme_req(rq)->ctrl;
 	struct nvme_ns *ns =3D rq->q->queuedata;
-	u32 effects;
-	int  ret;
=20
-	effects =3D nvme_passthru_start(ctrl, ns, cmd->common.opcode);
-	ret =3D nvme_execute_rq(rq, false);
-	if (effects) /* nothing to be done for zero cmd effects */
-		nvme_passthru_end(ctrl, effects, cmd, ret);
-
-	return ret;
+	*effects =3D nvme_passthru_start(ctrl, ns, cmd->common.opcode);
+	return nvme_execute_rq(rq, false);
 }
 EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
=20
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 27614bee7380..d3281f87cd6e 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -136,9 +136,11 @@ static int nvme_submit_user_cmd(struct request_queue *=
q,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, u64 *result, unsigned timeout, bool vec)
 {
+	struct nvme_ctrl *ctrl;
 	struct request *req;
 	void *meta =3D NULL;
 	struct bio *bio;
+	u32 effects;
 	int ret;
=20
 	req =3D nvme_alloc_user_request(q, cmd, ubuffer, bufflen, meta_buffer,
@@ -147,8 +149,9 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		return PTR_ERR(req);
=20
 	bio =3D req->bio;
+	ctrl =3D nvme_req(req)->ctrl;
=20
-	ret =3D nvme_execute_passthru_rq(req);
+	ret =3D nvme_execute_passthru_rq(req, &effects);
=20
 	if (result)
 		*result =3D le64_to_cpu(nvme_req(req)->result.u64);
@@ -158,6 +161,10 @@ static int nvme_submit_user_cmd(struct request_queue *=
q,
 	if (bio)
 		blk_rq_unmap_user(bio);
 	blk_mq_free_request(req);
+
+	if (effects)
+		nvme_passthru_end(ctrl, effects, cmd, ret);
+
 	return ret;
 }
=20
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1bdf714dcd9e..a0bf9560cf67 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1023,7 +1023,9 @@ static inline void nvme_auth_free(struct nvme_ctrl *c=
trl) {};
=20
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
@@ -215,9 +215,11 @@ static void nvmet_passthru_execute_cmd_work(struct wor=
k_struct *w)
 {
 	struct nvmet_req *req =3D container_of(w, struct nvmet_req, p.work);
 	struct request *rq =3D req->p.rq;
+	struct nvme_ctrl *ctrl =3D nvme_req(rq)->ctrl;
+	u32 effects;
 	int status;
=20
-	status =3D nvme_execute_passthru_rq(rq);
+	status =3D nvme_execute_passthru_rq(rq, &effects);
=20
 	if (status =3D=3D NVME_SC_SUCCESS &&
 	    req->cmd->common.opcode =3D=3D nvme_admin_identify) {
@@ -238,6 +240,9 @@ static void nvmet_passthru_execute_cmd_work(struct work=
_struct *w)
 	req->cqe->result =3D nvme_req(rq)->result;
 	nvmet_req_complete(req, status);
 	blk_mq_free_request(rq);
+
+	if (effects)
+		nvme_passthru_end(ctrl, effects, req->cmd, status);
 }
=20
 static void nvmet_passthru_req_done(struct request *rq,
--=20
2.30.2


