Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE71CA5FA5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 11:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PUiNxY24NJfNRGG6Ot8bTgCYp5IZy1NivizQEVPP87Y=; b=aZcYiMoJNnY5vbBYKKd9jS5H9g
	uRTTkIs4Ar5lICAUxGcF8IrC5bhSIutcf4jf6G0N3ndUl4LfqLp1bJ1AefCktU7xdNHlq0NiSO55N
	R7SEdBmZ1CnfqfztBf3dTR4HT0CuEYUlqOoh7MLMPyKV/FBYK3/4HaIHVT/ObJGnvv6VTD3a66jRV
	nc8BJVqPm4uwog4aknyT04TNVDX7jHFzPl5ZJD4HjquAoWO8/cPeP58AQmpOxFqjfNmd0kze8+1Ph
	FI/+tHdUbC/dLsa6ugEeAv21GszlFNlc8K9F5nz/hSTLBbWdj/cavEX7j131q9dYCeAm7Ezpod3Zv
	7bOXe9Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBW0f-00000003PDb-1EuL;
	Tue, 29 Sep 2026 11:28:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBW0e-00000003PD8-00k8
	for linux-nvme@bombadil.infradead.org;
	Tue, 29 Sep 2026 11:28:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=PUiNxY24NJfNRGG6Ot8bTgCYp5IZy1NivizQEVPP87Y=; b=GNdsWJfIiP9F7A94/92z6NrDsp
	wLbBUT5+LHgxzUImEZiNaXRsA3sRoTBPe1yOzIB+22amjyaf48N2kxup0N4JhuFKzShDwgQb+aNP5
	XjNBTPQq2bYCBZeYEojM6PfbYAxNlHCqPQZEhmMN+gpyfhP4mBKEaKYhCgt6VrkaOMhdsD7O0nW95
	eWQZFJs8YmuGfMKbGZVBMA10kyipFqFXnELzf1YHLf5zIz2r7CgXSsj8+1tYkm8N36Fw4ZW9hp5gT
	Kubkasmyw/HLBsiFdcA2Ev08pdHI9ROz4MbZRsyF7c8O2h2rJlXbwS2jFOqsvF3P0XBEKGlBechz3
	K1LXKxXQ==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xBW0a-00000002Ydp-1VmC
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 11:28:30 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5YIr2187974;
	Tue, 29 Sep 2026 11:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PUiNxY24NJfNRGG6O
	t8bTgCYp5IZy1NivizQEVPP87Y=; b=Zte4SRKscKs1JaxxZnwTCzmD2uWzhYSZG
	EQmWNcAmDE1A3MxjjdhxlJ5FjDqffL2za7dTbRelBHOZ3JF87qE1iqwHPpRvlMIA
	yMPfGKpNMxvY9WzJF+Qy21j+oCC0A4Z3FAo7B7Epn1AjGOq6BeJAqeJyvXy9cHl5
	fYSsTIVVEYoc5ZwtTwOgzQh2BpdUIeEn17ruN1IVBzBDdviRGb2nZnNcY5hMQMmb
	flNQoFFiF6ok2Ih5HfHyHSNUmfvpnKb4CUhmDKYsaX1clonPKNQM0E8prU2705DC
	X0J/ru5pGI1xRDtShUlMN11dk0LpDdeYALvd9GABCx+N7ZeFFxP9Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr6ns9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:28:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlU211667667;
	Tue, 29 Sep 2026 11:28:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhhdjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:28:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TBSB1c38339012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 11:28:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5886320043;
	Tue, 29 Sep 2026 11:28:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DC5220040;
	Tue, 29 Sep 2026 11:28:07 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.28.159])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 11:28:07 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, gjoyce@linux.ibm.com,
        chaitanyak@nvidia.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 2/2] nvmet: fix use-after-free in passthru I/O hotpath
Date: Tue, 29 Sep 2026 16:56:48 +0530
Message-ID: <20260929112751.2985483-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929112751.2985483-1-nilay@linux.ibm.com>
References: <20260929112751.2985483-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfXysf8EMQwDxSy
 Rxmq/X53F/RQx/XVInZGRrdcIHwhKjjrFOWlpvzVAYsdqvUy69LzHsjaQum9UhI8UinlqT+bizs
 TgPy97bLayeteq0shSan5/frhjWHzyPFlVJzW6B6oAcAiBkOYrHg+KV5Y2ZjmWlFBo5ih8F/GVd
 UDuF32JO2x4l656lX2Dl4B5STyC/W59XhRgQx6/vU809nYm94gh6TMl22HRNnMyp6wRvtamtISI
 lGC6zTH3CPOgrv6fQwYnDmILPl2v7ZnABxk10diWU0wOxahgCzwHyCmnaNzYP+eipnDAh0ZejLJ
 N05bnvMJ7eQLEPa/YSDW6JFNOkJ4weyIHESpAmORN1J57z4kUyIeym+2lK9XdYZh/tYx/RgDudM
 lcctQW8Cb4I11Md+p7nW3ucTpdrJO2bRk07JfdIEDSAdh+Qq7x76JHxxZL7452CRp/OBZKXKRTI
 pwFXW1fx/7cg40xTOVw==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abba0d0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=4USIHlrAciljqnLy3GAA:9
X-Proofpoint-ORIG-GUID: zFU3I3C7pATiTzPEeJXGD6aH67lmW1SP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfXymQha9ENsxzU
 SmhD+lAE+c42qj23CZQOYrZRosO5H/kGY0gLXXCXqSeruCyecNS8OtZiIiJjwUKM9PQz94j5Gm7
 2wbzFVCp93yAScbdTiE4SSVoxrYZKB8=
X-Proofpoint-GUID: zFU3I3C7pATiTzPEeJXGD6aH67lmW1SP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_122829_133184_F76BF0C9 
X-CRM114-Status: GOOD (  25.36  )
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
percpu refcount, an atomic flag, and an nvmet request flag to protect
the passthru controller lifetime.

When enabling the passthru controller, initialize the percpu refcount
and set the enabled flag. Each passthru I/O acquires a reference before
entering the passthru hotpath and sets an nvmet request flag to record
that the reference is held. The reference is released when the I/O
completes.

When disabling the passthru controller, clear the enabled flag, kill
the percpu refcount, and wait for all in-flight I/Os to release their
references before releasing the passthru controller.

Disable operations are serialized by subsys->lock. The enabled flag
ensures that only the first disable operation proceeds and subsequent
attempts observe the flag as cleared and return.

Once disabling starts, new I/Os either fail to be routed to the
passthru path or fail to acquire a live reference, and therefore cannot
dereference the passthru controller and thus avoid use-after-free.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/core.c     |  3 ++
 drivers/nvme/target/nvmet.h    | 34 +++++++++++++++++-
 drivers/nvme/target/passthru.c | 65 +++++++++++++++++++++++++++++-----
 3 files changed, 92 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b09681cb4a1f..fa1420065e30 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -819,6 +819,8 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 		nvmet_pr_put_ns_pc_ref(pc_ref);
 	if (ns)
 		nvmet_put_namespace(ns);
+
+	nvmet_put_passthru_ref(req);
 }
 
 void nvmet_req_complete(struct nvmet_req *req, u16 status)
@@ -1195,6 +1197,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_sq *sq,
 	req->error_loc = NVMET_NO_ERROR_LOC;
 	req->error_slba = 0;
 	req->pc_ref = NULL;
+	req->p.ref_held = false;
 
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index eb0f965b1a7e..04dc33004cb7 100644
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
 	unsigned int		admin_timeout;
@@ -478,6 +483,7 @@ struct nvmet_req {
 			struct request		*rq;
 			struct work_struct      work;
 			bool			use_workqueue;
+			bool			ref_held;
 		} p;
 #ifdef CONFIG_BLK_DEV_ZONED
 		struct {
@@ -797,7 +803,8 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req);
 u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req);
 static inline bool nvmet_is_passthru_subsys(struct nvmet_subsys *subsys)
 {
-	return subsys->passthru && subsys->passthru->ctrl;
+	return subsys->passthru &&
+		test_bit(NVMET_PASSTHRU_ENABLED, &subsys->passthru->flags);
 }
 
 static inline struct nvmet_passthru *nvmet_subsys_passthru(
@@ -812,6 +819,24 @@ static inline struct nvmet_passthru *nvmet_subsys_passthru(
 	}
 	return subsys->passthru;
 }
+
+static inline bool nvmet_get_passthru_ref(struct nvmet_req *req)
+{
+	if (!percpu_ref_tryget_live(&nvmet_req_subsys(req)->passthru->ref))
+		return false;
+
+	req->p.ref_held = true;
+	return true;
+}
+
+static inline void nvmet_put_passthru_ref(struct nvmet_req *req)
+{
+	if (!req->p.ref_held)
+		return;
+
+	req->p.ref_held = false;
+	percpu_ref_put(&nvmet_req_subsys(req)->passthru->ref);
+}
 #else /* CONFIG_NVME_TARGET_PASSTHRU */
 static inline void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
 {
@@ -836,6 +861,13 @@ static inline struct nvmet_passthru *nvmet_subsys_passthru(
 {
 	return NULL;
 }
+static inline bool nvmet_get_passthru_ref(struct nvmet_req *req)
+{
+	return false;
+}
+static inline void nvmet_put_passthru_ref(struct nvmet_req *req)
+{
+}
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 
 static inline bool nvmet_is_passthru_req(struct nvmet_req *req)
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 16cd3fdf98ec..6b67880c7bb2 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -305,9 +305,9 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 
 static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 {
-	struct nvmet_passthru *passthru = nvmet_req_subsys(req)->passthru;
-	struct nvme_ctrl *ctrl = passthru->ctrl;
-	struct request_queue *q = ctrl->admin_q;
+	struct nvmet_passthru *passthru;
+	struct nvme_ctrl *ctrl;
+	struct request_queue *q;
 	struct nvme_ns *ns = NULL;
 	struct request *rq = NULL;
 	unsigned int timeout;
@@ -315,6 +315,15 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	u16 status;
 	int ret;
 
+	if (!nvmet_get_passthru_ref(req)) {
+		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
+		goto out;
+	}
+
+	passthru = nvmet_req_subsys(req)->passthru;
+	ctrl = passthru->ctrl;
+	q = ctrl->admin_q;
+
 	if (likely(req->sq->qid != 0)) {
 		u32 nsid = le32_to_cpu(req->cmd->common.nsid);
 
@@ -387,11 +396,17 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
  */
 static void nvmet_passthru_set_host_behaviour(struct nvmet_req *req)
 {
-	struct nvme_ctrl *ctrl = nvmet_req_subsys(req)->passthru->ctrl;
+	struct nvme_ctrl *ctrl;
 	struct nvme_feat_host_behavior *host;
 	u16 status = NVME_SC_INTERNAL;
 	int ret;
 
+	if (!nvmet_get_passthru_ref(req)) {
+		status |= NVME_STATUS_DNR;
+		goto out_complete_req;
+	}
+	ctrl = nvmet_req_subsys(req)->passthru->ctrl;
+
 	host = kzalloc(sizeof(*host) * 2, GFP_KERNEL);
 	if (!host)
 		goto out_complete_req;
@@ -585,6 +600,14 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
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
 	struct nvmet_passthru *passthru;
@@ -629,6 +652,13 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
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
 
@@ -640,6 +670,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 	}
 	nvme_get_ctrl(ctrl);
 	__module_get(passthru->ctrl->ops->module);
+	set_bit(NVMET_PASSTHRU_ENABLED, &passthru->flags);
 	ret = 0;
 
 out_put_file:
@@ -653,14 +684,30 @@ static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
 {
 	struct nvmet_passthru *passthru = subsys->passthru;
 
+	lockdep_assert_held(&subsys->lock);
+
 	if (!passthru)
 		return;
 
-	if (passthru->ctrl) {
-		xa_erase(&passthru_subsystems, passthru->ctrl->instance);
-		module_put(passthru->ctrl->ops->module);
-		nvme_put_ctrl(passthru->ctrl);
-	}
+	if (!test_and_clear_bit(NVMET_PASSTHRU_ENABLED, &passthru->flags))
+		return;
+
+	mutex_unlock(&subsys->lock);
+	/*
+	 * Now new I/Os should not enter passthru hotpath as we cleared the
+	 * enabled flag. Kill percpu reference and wait for in-flight I/Os
+	 * to drain.
+	 */
+	percpu_ref_kill(&passthru->ref);
+	wait_for_completion(&passthru->disable_done);
+	percpu_ref_exit(&passthru->ref);
+
+	mutex_lock(&subsys->lock);
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


