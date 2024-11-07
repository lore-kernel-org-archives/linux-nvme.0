Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EAED5D687
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JO/Wf5bg351dTzgWB9JRVoK4w19z2mx769doWWG1p8g=; b=cXqmqTm5IhaVEwt4770g+dIy4K
	k3NQAXf0t7bhnjVUZTrJYxkMDFO7WaHlFh7dDVj51MoiK+0fLWXF25Buxbzl2gew/cs4L3JS9oApT
	2C+sPDw34K6wc75kAd2tEyQQOFb991wsl69iYobQzUggtdj+nsbY6ziCxnoeRj7onZ0wq8b2AohjY
	0PTU+Jzhitlr8wHM3tyJC4BHbgGuEBY95pktzRUMjBdbF31xVwjGdWxO+jaIwxFQtZYIl+O9DxgrH
	lHlzvjc0ZCOHv80PB88Hy1ZKhExCukIdtrdkiEFEMumJYojwNR2j4rO3KVFbn91SMKDKWHDg+D6Om
	bv5sdFvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98c4-00000008A7U-2veL;
	Thu, 07 Nov 2024 19:56:16 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98Lo-000000086YU-3jlE
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:39:30 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImPqq018669
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 11:39:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=JO/Wf5bg351dTzgWB9JRVoK4w19z2mx769doWWG1p8g=; b=Gojed9baq1fX
	JnYaZ83jAkxMlIsS4oZXI9XT7yZlIkZaYPeqPvhoxKmvEdPlVaGTUCMcs7ERoiB8
	owm5iEbhhNmDknK3CPZ0yByRjAzrc8riXzefsifhDEAv/UgZIK5LeKrGJIcMh55l
	Vvv8zqagxt3GHO9+gOEsvmXRhSFRmOyAW0sixo0+YWZbPa2B0arx28Q1iczRO8CT
	SGfTJtg/sDY/ZsvP7Gaa5sEtN6bCXRwx1mFJg3yQ7oaGHbIoAwjJUk7Plsvb6rwD
	lKSqqvVWqmwdPKJ4DG75vNmA5JF+2yLY8JNc/qp5S6xeRDnqjBTimyPtmNXJUHW+
	/5y7iReMsw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42s12shjp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 11:39:27 -0800 (PST)
Received: from twshared13976.17.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 7 Nov 2024 19:38:59 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 62AED14DC39E8; Thu,  7 Nov 2024 11:38:54 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>, <kch@nvidia.com>,
        <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 02/13] nvmet: implement active command set ns list
Date: Thu, 7 Nov 2024 11:38:37 -0800
Message-ID: <20241107193849.995554-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107193849.995554-1-kbusch@meta.com>
References: <20241107193849.995554-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KcR6lTcXM29fcU08ehvLO1wmz9m__GyD
X-Proofpoint-ORIG-GUID: KcR6lTcXM29fcU08ehvLO1wmz9m__GyD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_113928_960437_30B897BF 
X-CRM114-Status: GOOD (  11.31  )
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

This is required for nvme 2.1 for targets that support multiple command
sets. We support NVM and ZNS, so are required to support this
identification.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 9 +++++++--
 include/linux/nvme.h            | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index 8d06dba42bcb3..a13242e791c0f 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -576,7 +576,7 @@ static void nvmet_execute_identify_ns(struct nvmet_re=
q *req)
 	nvmet_req_complete(req, status);
 }
=20
-static void nvmet_execute_identify_nslist(struct nvmet_req *req)
+static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool ma=
tch_css)
 {
 	static const int buf_size =3D NVME_IDENTIFY_DATA_SIZE;
 	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
@@ -606,6 +606,8 @@ static void nvmet_execute_identify_nslist(struct nvme=
t_req *req)
 	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
 		if (ns->nsid <=3D min_nsid)
 			continue;
+		if (match_css && req->ns->csi !=3D req->cmd->identify.csi)
+			continue;
 		list[i++] =3D cpu_to_le32(ns->nsid);
 		if (i =3D=3D buf_size / sizeof(__le32))
 			break;
@@ -712,7 +714,7 @@ static void nvmet_execute_identify(struct nvmet_req *=
req)
 		nvmet_execute_identify_ctrl(req);
 		return;
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
-		nvmet_execute_identify_nslist(req);
+		nvmet_execute_identify_nslist(req, false);
 		return;
 	case NVME_ID_CNS_NS_DESC_LIST:
 		nvmet_execute_identify_desclist(req);
@@ -743,6 +745,9 @@ static void nvmet_execute_identify(struct nvmet_req *=
req)
 			break;
 		}
 		break;
+	case NVME_ID_CNS_NS_ACTIVE_LIST_CS:
+		nvmet_execute_identify_nslist(req, true);
+		return;
 	}
=20
 	pr_debug("unhandled identify cns %d on qid %d\n",
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b58d9405d65e0..0f263c7e63192 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -522,6 +522,7 @@ enum {
 	NVME_ID_CNS_NS_DESC_LIST	=3D 0x03,
 	NVME_ID_CNS_CS_NS		=3D 0x05,
 	NVME_ID_CNS_CS_CTRL		=3D 0x06,
+	NVME_ID_CNS_NS_ACTIVE_LIST_CS	=3D 0x07,
 	NVME_ID_CNS_NS_CS_INDEP		=3D 0x08,
 	NVME_ID_CNS_NS_PRESENT_LIST	=3D 0x10,
 	NVME_ID_CNS_NS_PRESENT		=3D 0x11,
--=20
2.43.5


