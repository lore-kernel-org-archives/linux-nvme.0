Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6923C9832A
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 11:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cmbOxnuFnpgIf6CXrgeSycgmu/EJRvorp1KRLOPWZ6Y=; b=b7/zY+KBPGW/Ww9eMzjpI66aZK
	r+lPpXSgGZujMDbTj/CgjDGDYaRu/8jm1YgTL4J3YUx2LhIGU/het+F5JcUPkyFqWJlEqigRQWlr8
	MFvhvNgCEh13tbR4nOgUbArXnRwxB/Wfbyl9oz1XxxBCUtaALGLdivrjuN1SIfId1aFoldEGtja7H
	81x3XdM3RBcCNWXF9DkUd/swC1MH6DmdJgAblnabEMJPnnf2kAKT8zbfptG3GwFi08n0BsIQuidIY
	TkTSczR0eJ0ravXXYTVOfiCrgAbMjQK5i61xXOK3AM9GG6L5XwnSmEtULEZMyyZtkW8C0OxG+3PgI
	jwFtz1Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA3zz-0000000DBNG-0lOM;
	Fri, 25 Sep 2026 11:21:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA3zv-0000000DBKo-0pbD
	for linux-nvme@lists.infradead.org;
	Fri, 25 Sep 2026 11:21:48 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4a9Br2393217;
	Fri, 25 Sep 2026 11:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cmbOxnuFnpgIf6CXr
	geSycgmu/EJRvorp1KRLOPWZ6Y=; b=KTHcxkq93yhqzE8lC4QT2Beqt67kLhakn
	HingHqAq7Xdf1k7IpzB4qlOCXTpsDGr7S/EIvz3GgRCCi8am8zKUuVowz3GSazfi
	0h42qNH/emPp+a5D8m4bdSZjQUAkJU531em18iXZbjN8yr60lh0GVh73R2OfnnG5
	VCOdLpRVe8mAmcccEgjfUvHcfPu6t+FbLgIJViRk2vNyENoaGNOEWMp2R9lWov88
	oKvLgBOoFY08lP0L+RBiOj9ZLZboxuHvcMpEt3fRdPy1A1o+0SFhz0j1xdNL0e+u
	9XSzgzKmEAE7jTL39pF2vpm546QxH1w4hi/9nBJhsFwcUPPKvkDiA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske26qtc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 11:21:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P9m6v33248950;
	Fri, 25 Sep 2026 11:21:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt323xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 11:21:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PBLYZ438601148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 11:21:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9887920040;
	Fri, 25 Sep 2026 11:21:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0AD220043;
	Fri, 25 Sep 2026 11:21:32 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 11:21:32 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, gjoyce@linux.ibm.com,
        chaitanyak@nvidia.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 2/2] nvmet: fix use-after-free error in passthru I/O hotpath
Date: Fri, 25 Sep 2026 16:51:10 +0530
Message-ID: <20260925112120.790530-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925112120.790530-1-nilay@linux.ibm.com>
References: <20260925112120.790530-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m2o_pDt5aQ_BdIiav75ej2ewRLrwtsnk
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab65943 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=4USIHlrAciljqnLy3GAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfX0kDVRUwxKV8S
 Q1x7dJkHe7TwWsUNaUgrlmFUAUIarAxQ+35BkegGTcQJiTw8cJh6oaTVuyqVPo9Oc3rncQmdjpZ
 29A6yoARjdRs1En4gNdOXUOQkjpkszg=
X-Proofpoint-GUID: m2o_pDt5aQ_BdIiav75ej2ewRLrwtsnk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfXxs5xyPG04+Hn
 RMoBSRTAtACt782e9+g1MiGUzbrC9FsCeivW5LfLn3xaeSmqtTUnQK4m3GLgZIqHRodHawyX6Yd
 FQx1VFVwOF7Yu1jR7igYi6T/myWmxSaq0Mx8WlVlYSfu8l0oW7qkz7HGQUBOXIRqdbBS5djHrYK
 T6IJ2YRY88hjDQyL1szUwhFSMhzXcIqWXtpHn5EhvMbLCZGUrwKob1AiYe1Hl3Ah91Z6kUWEDJ7
 ZQzuZgk+IVPCO9QzBIbZbtCqtSG3dQ4/EN4RlYBSnE385jOqdp1jBvCHNzuhH+GKsr3IhNczwgI
 ng1/QQF6EoGVwEl/JVZpW5U4xzy81CpeSqUSc+YMxM+vgvywCHq1XAzCyZ7zvTx/vBSoRg1PbOp
 qC0x2zJz4IUUzyVnLaOSO2lILhfuCPVOYWWPulibr8GwcSaC0iOcqYm4g9WVWPdjkcFxUh+H69y
 2QcUJ/o6YJ/s5Flyhqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_042147_274191_0B37AAD5 
X-CRM114-Status: GOOD (  22.33  )
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

Concurrently disabling a passthru controller while passthru I/Os are
in flight can potentially result in a use-after-free. Introduce a
percpu refcount, an atomic flag, and an nvmet request flag to track
reference held by passthru I/Os and protect the passthru controller
lifetime.

When enabling the passthru controller, initialize the percpu refcount
and set the enabled flag. Each passthru I/O acquires a reference before
entering the passthru hot path and sets the nvmet request flag to record
that the reference is held. The reference is released when the I/O
completes and the request flag is set.

When disabling the passthru controller, clear the enabled flag, kill the
percpu refcount, and wait for all in-flight I/Os to release their
references before releasing the passthru controller. Concurrent disable
attempts are serialized by the atomic enabled flag: only the first
disable attempt observes the flag set and proceeds, while subsequent
attempts bail out.

Once disabling starts, new I/Os fail to acquire a live reference and
therefore cannot enter the passthru hot path.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/core.c     |  4 +++
 drivers/nvme/target/nvmet.h    | 23 ++++++++++++++
 drivers/nvme/target/passthru.c | 58 ++++++++++++++++++++++++++++------
 3 files changed, 75 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 9ab07dbe8cbe..0870977eccf6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -819,6 +819,9 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 		nvmet_pr_put_ns_pc_ref(pc_ref);
 	if (ns)
 		nvmet_put_namespace(ns);
+
+	if (req->p.ref_held)
+		nvmet_put_passthru_ref(req);
 }
 
 void nvmet_req_complete(struct nvmet_req *req, u16 status)
@@ -1195,6 +1198,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_sq *sq,
 	req->error_loc = NVMET_NO_ERROR_LOC;
 	req->error_slba = 0;
 	req->pc_ref = NULL;
+	req->p.ref_held = false;
 
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8f5dccee7d26..2953102a90bd 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -320,6 +320,11 @@ struct nvmet_ctrl {
 };
 
 struct nvmet_passthru {
+	struct percpu_ref	ref;
+	struct completion	disable_done;
+#define NVMET_PASSTHRU_ENABLED	0
+	unsigned long		flags;
+
 	struct nvme_ctrl	*ctrl;
 	char			*ctrl_path;
 	struct config_group	group;
@@ -478,6 +483,7 @@ struct nvmet_req {
 			struct request		*rq;
 			struct work_struct      work;
 			bool			use_workqueue;
+			bool			ref_held;
 		} p;
 #ifdef CONFIG_BLK_DEV_ZONED
 		struct {
@@ -799,6 +805,16 @@ static inline bool nvmet_is_passthru_subsys(struct nvmet_subsys *subsys)
 {
 	return subsys->passthru.ctrl;
 }
+
+static inline bool nvmet_get_passthru_ref(struct nvmet_req *req)
+{
+	return percpu_ref_tryget_live(&nvmet_req_subsys(req)->passthru.ref);
+}
+
+static inline void nvmet_put_passthru_ref(struct nvmet_req *req)
+{
+	percpu_ref_put(&nvmet_req_subsys(req)->passthru.ref);
+}
 #else /* CONFIG_NVME_TARGET_PASSTHRU */
 static inline void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
 {
@@ -818,6 +834,13 @@ static inline bool nvmet_is_passthru_subsys(struct nvmet_subsys *subsys)
 {
 	return NULL;
 }
+static inline bool nvmet_get_passthru_ref(struct nvmet_req *req)
+{
+	return NULL;
+}
+static inline void nvmet_put_passthru_ref(struct nvmet_req *req)
+{
+}
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 
 static inline bool nvmet_is_passthru_req(struct nvmet_req *req)
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 81ac220da8ba..c18b1dda2a18 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -305,9 +305,9 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 
 static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 {
-	struct nvmet_passthru *passthru = &nvmet_req_subsys(req)->passthru;
-	struct nvme_ctrl *ctrl = passthru->ctrl;
-	struct request_queue *q = ctrl->admin_q;
+	struct nvmet_passthru *passthru;
+	struct nvme_ctrl *ctrl;
+	struct request_queue *q;
 	struct nvme_ns *ns = NULL;
 	struct request *rq = NULL;
 	unsigned int timeout;
@@ -315,6 +315,16 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	u16 status;
 	int ret;
 
+	req->p.ref_held = nvmet_get_passthru_ref(req);
+	if (!req->p.ref_held) {
+		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
+		goto out;
+	}
+
+	passthru = &nvmet_req_subsys(req)->passthru;
+	ctrl = passthru->ctrl;
+	q = ctrl->admin_q;
+
 	if (likely(req->sq->qid != 0)) {
 		u32 nsid = le32_to_cpu(req->cmd->common.nsid);
 
@@ -387,11 +397,18 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
  */
 static void nvmet_passthru_set_host_behaviour(struct nvmet_req *req)
 {
-	struct nvme_ctrl *ctrl = nvmet_req_subsys(req)->passthru.ctrl;
+	struct nvme_ctrl *ctrl;
 	struct nvme_feat_host_behavior *host;
 	u16 status = NVME_SC_INTERNAL;
 	int ret;
 
+	req->p.ref_held = nvmet_get_passthru_ref(req);
+	if (!req->p.ref_held) {
+		status |= NVME_STATUS_DNR;
+		goto out_complete_req;
+	}
+	ctrl = nvmet_req_subsys(req)->passthru.ctrl;
+
 	host = kzalloc(sizeof(*host) * 2, GFP_KERNEL);
 	if (!host)
 		goto out_complete_req;
@@ -585,6 +602,14 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 	}
 }
 
+static void nvmet_release_passthru_ctrl(struct percpu_ref *ref)
+{
+	struct nvmet_passthru *passthru = container_of(ref,
+				struct nvmet_passthru, ref);
+
+	complete(&passthru->disable_done);
+}
+
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 {
 	struct nvmet_passthru *passthru = &subsys->passthru;
@@ -628,9 +653,15 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 	if (old)
 		goto out_put_file;
 
+	ret = percpu_ref_init(&passthru->ref, nvmet_release_passthru_ctrl,
+			0, GFP_KERNEL);
+	if (ret) {
+		xa_erase(&passthru_subsystems, ctrl->instance);
+		goto out_put_file;
+	}
+	init_completion(&passthru->disable_done);
 	passthru->ctrl = ctrl;
 	subsys->ver = ctrl->vs;
-
 	if (subsys->ver < NVME_VS(1, 2, 1)) {
 		pr_warn("nvme controller version is too old: %llu.%llu.%llu, advertising 1.2.1\n",
 			NVME_MAJOR(subsys->ver), NVME_MINOR(subsys->ver),
@@ -639,6 +670,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 	}
 	nvme_get_ctrl(ctrl);
 	__module_get(passthru->ctrl->ops->module);
+	set_bit(NVMET_PASSTHRU_ENABLED, &passthru->flags);
 	ret = 0;
 
 out_put_file:
@@ -652,11 +684,17 @@ static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
 {
 	struct nvmet_passthru *passthru = &subsys->passthru;
 
-	if (passthru->ctrl) {
-		xa_erase(&passthru_subsystems, passthru->ctrl->instance);
-		module_put(passthru->ctrl->ops->module);
-		nvme_put_ctrl(passthru->ctrl);
-	}
+	if (!test_and_clear_bit(NVMET_PASSTHRU_ENABLED, &passthru->flags))
+		return;
+
+	percpu_ref_kill(&passthru->ref);
+	wait_for_completion(&passthru->disable_done);
+	percpu_ref_exit(&passthru->ref);
+
+	xa_erase(&passthru_subsystems, passthru->ctrl->instance);
+	module_put(passthru->ctrl->ops->module);
+	nvme_put_ctrl(passthru->ctrl);
+
 	passthru->ctrl = NULL;
 	subsys->ver = NVMET_DEFAULT_VS;
 }
-- 
2.53.0


