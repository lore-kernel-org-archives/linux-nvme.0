Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73773D44001
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ekq/o5AgnAGqHMdm056DzNuXX+q3TUdWMi2q1GOsMJ4=; b=1c1xTjXNNKODifG237NCCxRfZ6
	iSJVRBREffGSOnbpKFQQpAXidb+vs2985z9bFGv4E2lPCYSE6hy6/81YAG9VRI5NghB2JELuxn5w4
	NvNDfDwtUUUYT2VVFraaH9ZPKvTH16Q108u7xuNWTt/6c51p+3MA+ubNXHpc1KUj0IZHXfwStiMyY
	Y022LQycAEAmVHPcAlIXGhV8oQNQijVb/YhWdVAVJufDZp3ZMW+5ymwe0LlB1IS8YXV61EJ6Ab9So
	lWlaFR3vqrKjuH1tWDNYNfF3dCsf5wajVr/rZnnORV1ToayrOk3+oEphaTpbebsH9YVOVbNDR6Jas
	un70xRQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD48c-00000009zLT-3PxE;
	Mon, 18 Nov 2024 15:58:06 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD48H-00000009zHd-1OQB
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 15:57:46 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8NFLC031315
	for <linux-nvme@lists.infradead.org>; Mon, 18 Nov 2024 07:57:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=Ekq/o5AgnAGqHMdm056DzNuXX+q3TUdWMi2q1GOsMJ4=; b=bpqyrSkXj2K4
	zr22vFwJIaS03XEjy9Qg5V4q4wLHywF6fAaVRSTE94pkTbq1L08uoX9czodNjIA7
	0kmoqT4yqBO5FZe+kHOL8EDPtRcjS73e4pDp48fwGeDYDGUlgVf+2lMeALjbIBeK
	Q0jKtETS78b5sWyVOIRa3q2eiIx0GppxjuNZtfMVcT0buzlJWpT7oSAs6EvXR8U+
	9SARs0i2wj+JpDIAN2op17bNKKefB3pzZulL6UtzBr0TGzqYC8wt6/zpBd59/0s7
	ru8kJ9BCpt/7NCgokiW5vgnSeAGV6kt2RGFZIwyF3kyrvNa/Byd3u5unQatOF7su
	bxEsq1OKxw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43021b28vs-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 18 Nov 2024 07:57:43 -0800 (PST)
Received: from twshared15700.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 18 Nov 2024 15:57:41 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 0709E152D6265; Mon, 18 Nov 2024 07:57:38 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/3] nvme: define the remaining used sgls constants
Date: Mon, 18 Nov 2024 07:57:37 -0800
Message-ID: <20241118155738.2737423-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241118155738.2737423-1-kbusch@meta.com>
References: <20241118155738.2737423-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: i3I1pDA5Qw3F3rDkO4RBfGnXKIfIQQ9p
X-Proofpoint-GUID: i3I1pDA5Qw3F3rDkO4RBfGnXKIfIQQ9p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_075745_449633_B551124B 
X-CRM114-Status: GOOD (  13.35  )
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

This provides a little more context when reading the code than hardcoded
magic numbers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/nvme.h        | 3 ++-
 drivers/nvme/host/rdma.c        | 4 ++--
 drivers/nvme/target/admin-cmd.c | 7 ++++---
 include/linux/nvme.h            | 4 ++++
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5ef284a376cc7..611b02c8a8b37 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1123,7 +1123,8 @@ static inline void nvme_start_request(struct reques=
t *rq)
=20
 static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
 {
-	return ctrl->sgls & ((1 << 0) | (1 << 1));
+	return ctrl->sgls & (NVME_CTRL_SGLS_BYTE_ALIGNED |
+			     NVME_CTRL_SGLS_DWORD_ALIGNED);
 }
=20
 static inline bool nvme_ctrl_meta_sgl_supported(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 24a2759798d01..baf7d24901528 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1019,7 +1019,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ct=
rl *ctrl, bool new)
 		goto destroy_admin;
 	}
=20
-	if (!(ctrl->ctrl.sgls & (1 << 2))) {
+	if (!(ctrl->ctrl.sgls & NVME_CTRL_SGLS_KSDBDS)) {
 		ret =3D -EOPNOTSUPP;
 		dev_err(ctrl->ctrl.device,
 			"Mandatory keyed sgls are not supported!\n");
@@ -1051,7 +1051,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ct=
rl *ctrl, bool new)
 		ctrl->ctrl.sqsize =3D ctrl->ctrl.maxcmd - 1;
 	}
=20
-	if (ctrl->ctrl.sgls & (1 << 20))
+	if (ctrl->ctrl.sgls & NVME_CTRL_SGLS_SAOS)
 		ctrl->use_inline_data =3D true;
=20
 	if (ctrl->ctrl.queue_count > 1) {
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index 934b401fbc2ff..4fa8496a4d967 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -601,11 +601,12 @@ static void nvmet_execute_identify_ctrl(struct nvme=
t_req *req)
 	id->awun =3D 0;
 	id->awupf =3D 0;
=20
-	id->sgls =3D cpu_to_le32(1 << 0);	/* we always support SGLs */
+	/* we always support SGLs */
+	id->sgls =3D cpu_to_le32(NVME_CTRL_SGLS_BYTE_ALIGNED);
 	if (ctrl->ops->flags & NVMF_KEYED_SGLS)
-		id->sgls |=3D cpu_to_le32(1 << 2);
+		id->sgls |=3D cpu_to_le32(NVME_CTRL_SGLS_KSDBDS);
 	if (req->port->inline_data_size)
-		id->sgls |=3D cpu_to_le32(1 << 20);
+		id->sgls |=3D cpu_to_le32(NVME_CTRL_SGLS_SAOS);
=20
 	strscpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));
=20
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 5873ce859cc8b..2baf9a80b470a 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -389,7 +389,11 @@ enum {
 	NVME_CTRL_CTRATT_PREDICTABLE_LAT	=3D 1 << 5,
 	NVME_CTRL_CTRATT_NAMESPACE_GRANULARITY	=3D 1 << 7,
 	NVME_CTRL_CTRATT_UUID_LIST		=3D 1 << 9,
+	NVME_CTRL_SGLS_BYTE_ALIGNED             =3D 1,
+	NVME_CTRL_SGLS_DWORD_ALIGNED            =3D 2,
+	NVME_CTRL_SGLS_KSDBDS			=3D 1 << 2,
 	NVME_CTRL_SGLS_MSDS                     =3D 1 << 19,
+	NVME_CTRL_SGLS_SAOS                     =3D 1 << 20,
 };
=20
 struct nvme_lbaf {
--=20
2.43.5


