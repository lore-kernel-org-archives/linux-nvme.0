Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C9FD5D683
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bCJXbb14ABFgyfjNvurAUVOUZDn/ktCxiPZacOeEZhE=; b=E5C6S9SsEnpRLBkgFoAYqqM2bZ
	7YiWHOtn3ponW0w27aUoifaqiYwUHOPlyZ0x00hw+e5RECJFBec7VY9LOWisU2XFMjbgkSkMekS+u
	uq8Dw6xLGX0BtZOJUnBQj8Mafd7as/LSJ7KnHa+BLyys0Empcv54ZOx84ejThlB0AjgNEjkHOMCLR
	y0D8VmNH9s4LffOYC1ve3ILa/4fXauwWXOvLWpkRMaMRwTmQOh1llNGg2gesNYv0BRypZcULaSi7u
	0QtbV42GLW8q2vzx2XYtSW/WT4n3d8HOq1YzUrxJ9OL+6dsEkHrTfDsxO/GeTpx6bwf1vS1h7aUk0
	rpnpfjyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98c5-00000008A7w-2zGG;
	Thu, 07 Nov 2024 19:56:17 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98Lq-000000086Z5-2kEm
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:39:31 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImPqw018669
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 11:39:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=bCJXbb14ABFgyfjNvurAUVOUZDn/ktCxiPZacOeEZhE=; b=Yt2AaRE6AHUg
	dV9cAooIul8MQxd0RA4f5RtMB6bJYWV6/nSIa4JAMOxlmCSH+mznAY/QI1n6ACqK
	wIP0Os9ph8e60T1LwTSJ3YXMhpaiIkAhKsUbDh7SWmG6932bAVN3sOP/cRbVmXot
	v0RisUihMx0lf9k3Qw55vmSktDzejKE3ze+cPx8lNcoUPev1tND+jGqtLYyY+tc6
	oWiIXAKnubYt6XT4cPnU4S+M0mho0bjDbTNiB9UoynP4B4R42D7U6UpPKaOTVO+b
	eGd/c8/muGLnvHtYdzQ6YVvID9QMnrMjz17NM5y2os/VQxWwAmf0gAq38T83rWkG
	QhmKBeI9yg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42s12shjp8-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 11:39:30 -0800 (PST)
Received: from twshared13976.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 7 Nov 2024 19:38:59 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 523EF14DC39FA; Thu,  7 Nov 2024 11:38:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>, <kch@nvidia.com>,
        <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 04/13] nvmet: implement supported features log
Date: Thu, 7 Nov 2024 11:38:39 -0800
Message-ID: <20241107193849.995554-5-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107193849.995554-1-kbusch@meta.com>
References: <20241107193849.995554-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Ub6f_ArZy-X0NTmwzdSzB1WTKEnDVPV2
X-Proofpoint-ORIG-GUID: Ub6f_ArZy-X0NTmwzdSzB1WTKEnDVPV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_113930_724957_5EAA38A2 
X-CRM114-Status: GOOD (  11.26  )
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

This log is required for nvme 2.1.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 31 +++++++++++++++++++++++++++++++
 include/linux/nvme.h            | 11 +++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index 712b962fe77ac..7a879e2cd8555 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -89,6 +89,7 @@ static void nvmet_execute_get_supported_log_pages(struc=
t nvmet_req *req)
 	logs->lids[NVME_LOG_CHANGED_NS] =3D cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_CMD_EFFECTS] =3D cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_ANA] =3D cpu_to_le32(NVME_LIDS_LSUPP);
+	logs->lids[NVME_LOG_FEATURES] =3D cpu_to_le32(NVME_LIDS_LSUPP);
=20
 	status =3D nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
 	kfree(logs);
@@ -342,6 +343,34 @@ static void nvmet_execute_get_log_page_ana(struct nv=
met_req *req)
 	nvmet_req_complete(req, status);
 }
=20
+static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
+{
+	struct nvme_supported_features_log *features;
+	u16 status;
+
+	features =3D kzalloc(sizeof(*features), GFP_KERNEL);
+	if (!features) {
+		status =3D NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	features->fis[NVME_FEAT_NUM_QUEUES] =3D cpu_to_le32(NVME_FIS_FSUPP |
+							  NVME_FIS_CSCPE);
+	features->fis[NVME_FEAT_KATO] =3D cpu_to_le32(NVME_FIS_FSUPP |
+						    NVME_FIS_CSCPE);
+	features->fis[NVME_FEAT_ASYNC_EVENT] =3D cpu_to_le32(NVME_FIS_FSUPP |
+							   NVME_FIS_CSCPE);
+	features->fis[NVME_FEAT_HOST_ID] =3D cpu_to_le32(NVME_FIS_FSUPP |
+						       NVME_FIS_CSCPE);
+	features->fis[NVME_FEAT_WRITE_PROTECT] =3D cpu_to_le32(NVME_FIS_FSUPP |
+							     NVME_FIS_NSCPE);
+
+	status =3D nvmet_copy_to_sgl(req, 0, features, sizeof(*features));
+	kfree(features);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, nvmet_get_log_page_len(req->cmd)))
@@ -367,6 +396,8 @@ static void nvmet_execute_get_log_page(struct nvmet_r=
eq *req)
 		return nvmet_execute_get_log_cmd_effects_ns(req);
 	case NVME_LOG_ANA:
 		return nvmet_execute_get_log_page_ana(req);
+	case NVME_LOG_FEATURES:
+		return nvmet_execute_get_log_page_features(req);
 	}
 	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 692d606edeed3..4b896fa651e02 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1256,6 +1256,7 @@ enum {
 	NVME_LOG_TELEMETRY_CTRL =3D 0x08,
 	NVME_LOG_ENDURANCE_GROUP =3D 0x09,
 	NVME_LOG_ANA		=3D 0x0c,
+	NVME_LOG_FEATURES	=3D 0x12,
 	NVME_LOG_DISC		=3D 0x70,
 	NVME_LOG_RESERVATION	=3D 0x80,
 	NVME_FWACT_REPL		=3D (0 << 3),
@@ -1271,6 +1272,16 @@ enum {
 	NVME_LIDS_LSUPP	=3D 1 << 0,
 };
=20
+struct nvme_supported_features_log {
+	__le32	fis[256];
+};
+
+enum {
+	NVME_FIS_FSUPP	=3D 1 << 0,
+	NVME_FIS_NSCPE	=3D 1 << 20,
+	NVME_FIS_CSCPE	=3D 1 << 21,
+};
+
 /* NVMe Namespace Write Protect State */
 enum {
 	NVME_NS_NO_WRITE_PROTECT =3D 0,
--=20
2.43.5


