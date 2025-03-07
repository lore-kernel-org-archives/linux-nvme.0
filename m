Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DE7C282DE
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Mar 2025 23:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lS1vXLBa4wvuGriHio2hx33Q2EKSwIcJRsxLKqgqALg=; b=md1ZDrrRvEA0mD2VhZcPBncD0W
	4nu1lFqIWIRUwBHQ7WbDK0IqGhnpuTKD5FwPZDjMG7Vz6DStB3Yan7747mvfSVZ0OD3wBgP6UMjDT
	eBgx5tg7xSZGAXKqbp7lgmCVLre89lUC/ET2LoghFNsTlpmXr9Sgq51VTCsxvwBTQ7CcMjVflgs7+
	QyfcQD7mAwnx+csAUJ4S36clJe4UbJCQzrbP597y7HJjQu5P1j7Yy9odtrVuSWjOcKn+jxW4sHqge
	9o5oIB+hBBTpcg8K6++Ts53HDh3PLkW1IxDDQtLzZr4WK1I6LMS4wdM+FxHoZFxQPwFXfo9pAtmNv
	7+VHi4rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqh62-0000000Fnet-3nV8;
	Fri, 07 Mar 2025 23:27:14 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqh60-0000000FneT-1ZO4
	for linux-nvme@lists.infradead.org;
	Fri, 07 Mar 2025 23:27:13 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527IxXMa005818
	for <linux-nvme@lists.infradead.org>; Fri, 7 Mar 2025 15:27:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=lS1vXLBa4wvuGriHio
	2hx33Q2EKSwIcJRsxLKqgqALg=; b=MxqlXvGi/b7zWOA2IxPZhppGhtpVz6XvDp
	1//W/XQQrglXHTmCDC8bSXdbRLRPx/ZROWYwaLcCBf1CBhwlezOXRuTWEbnghWq7
	7+W0KsLXVKkoh7HhzIQBlYn45DFICJSjVe/AJ51EOwAOSryxJf9nKeiYsPejKJhq
	5zeh5luRj+gjhqHgPia7EMo4ylJKNCsRx/o38bYu8WL/WLK0sJSskg4etwdJib+W
	lj6VneY//fHdPzAR3/R4UjoW/nDjFHK12cqCGWLtJ4Ql3hB0NlEXFAgADLlz9uWE
	iLvSRSxvQ1Yb0Pne5v++pF9R6dUrnPF37HSm6niqLlSdj64Rsfwg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 457ybawpjj-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 07 Mar 2025 15:27:11 -0800 (PST)
Received: from twshared3815.08.ash9.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 7 Mar 2025 23:27:10 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id EF9F818D70494; Fri,  7 Mar 2025 15:26:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: simplify request ready check for pci
Date: Fri, 7 Mar 2025 15:26:55 -0800
Message-ID: <20250307232655.2143570-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tGpeYjQjq8Zs6VY46rXiWcYJHlh-Snu5
X-Proofpoint-ORIG-GUID: tGpeYjQjq8Zs6VY46rXiWcYJHlh-Snu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_08,2025-03-07_03,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_152712_428877_15509963 
X-CRM114-Status: GOOD (  16.30  )
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

The criteria for pci transports' request ready check is simpler than
fabrics. Move the pci check to a different function. This also makes the
existing ready check simpler since it doesn't need to repeatedly test if
the controller is a fabrics type.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/apple.c |  2 +-
 drivers/nvme/host/core.c  | 35 ++++++++++++++++-------------------
 drivers/nvme/host/nvme.h  | 10 +++++++++-
 drivers/nvme/host/pci.c   |  2 +-
 4 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index a060f69558e76..8009eba9dd205 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -750,7 +750,7 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq=
_hw_ctx *hctx,
 	if (unlikely(!READ_ONCE(q->enabled)))
 		return BLK_STS_IOERR;
=20
-	if (!nvme_check_ready(&anv->ctrl, req, true))
+	if (!nvme_pci_check_ready(&anv->ctrl, req))
 		return nvme_fail_nonready_command(&anv->ctrl, req);
=20
 	ret =3D nvme_setup_cmd(ns, req);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f028913e2e622..6007cd7fdc3f4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -780,25 +780,22 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, str=
uct request *rq,
 	if (rq->q =3D=3D ctrl->admin_q && (req->flags & NVME_REQ_USERCMD))
 		return false;
=20
-	if (ctrl->ops->flags & NVME_F_FABRICS) {
-		/*
-		 * Only allow commands on a live queue, except for the connect
-		 * command, which is require to set the queue live in the
-		 * appropinquate states.
-		 */
-		switch (state) {
-		case NVME_CTRL_CONNECTING:
-			if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
-			    (req->cmd->fabrics.fctype =3D=3D nvme_fabrics_type_connect ||
-			     req->cmd->fabrics.fctype =3D=3D nvme_fabrics_type_auth_send ||
-			     req->cmd->fabrics.fctype =3D=3D nvme_fabrics_type_auth_receive))
-				return true;
-			break;
-		default:
-			break;
-		case NVME_CTRL_DEAD:
-			return false;
-		}
+	/*
+	 * Only allow commands on a live queue, except for the connect command,
+	 * which is require to set the queue live in the appropinquate states.
+	 */
+	switch (state) {
+	case NVME_CTRL_CONNECTING:
+		if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
+		    (req->cmd->fabrics.fctype =3D=3D nvme_fabrics_type_connect ||
+		     req->cmd->fabrics.fctype =3D=3D nvme_fabrics_type_auth_send ||
+		     req->cmd->fabrics.fctype =3D=3D nvme_fabrics_type_auth_receive))
+			return true;
+		break;
+	default:
+		break;
+	case NVME_CTRL_DEAD:
+		return false;
 	}
=20
 	return queue_live;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7be92d07430e9..9f9e742c714da 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -849,11 +849,19 @@ static inline bool nvme_check_ready(struct nvme_ctr=
l *ctrl, struct request *rq,
=20
 	if (likely(state =3D=3D NVME_CTRL_LIVE))
 		return true;
-	if (ctrl->ops->flags & NVME_F_FABRICS && state =3D=3D NVME_CTRL_DELETIN=
G)
+	if (state =3D=3D NVME_CTRL_DELETING)
 		return queue_live;
 	return __nvme_check_ready(ctrl, rq, queue_live, state);
 }
=20
+static inline bool nvme_pci_check_ready(struct nvme_ctrl *ctrl,
+					struct request *rq)
+{
+	return likely(nvme_ctrl_state(ctrl) =3D=3D NVME_CTRL_LIVE) ||
+		!(nvme_req(rq)->flags & NVME_REQ_USERCMD) ||
+		rq->q->disk;
+}
+
 /*
  * NSID shall be unique for all shared namespaces, or if at least one of=
 the
  * following conditions is met:
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 710f3dfef3663..f60e04ec8a246 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -972,7 +972,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ct=
x *hctx,
 	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
 		return BLK_STS_IOERR;
=20
-	if (unlikely(!nvme_check_ready(&dev->ctrl, req, true)))
+	if (unlikely(!nvme_pci_check_ready(&dev->ctrl, req)))
 		return nvme_fail_nonready_command(&dev->ctrl, req);
=20
 	ret =3D nvme_prep_rq(dev, req);
--=20
2.47.1


