Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A911D5D687
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t6x4wXqI8S4BF2y32y83lFi0n/5qVe5afkxyBlfTHwk=; b=Q/hB+dCNoAZ8CV1aeeYK65Zjbw
	zgsGjkOpbZ6zXuGPobcbMAiOL4a7+7o5ABA6Pl9tDeZAB/PyzeWWzztZk9M5umUuHCigOsNb+9X5g
	WwNPUwDCUtWb7fMy1BH4tZuX34FLYoG4wMHrtF56xminncUFexSR0uR6h9F61AWde4393eP89JHne
	QU6iyJ+kRQxdXqYgNJ4EedAR59vV9XZAk07fLlV4FwlOca5AUuBzvz/4D1tevOPV8S2RLoAaTZWTl
	Qi19yU6cT7tuMJoveLLkkITbGxyJ3wZpLFt7KxLjqutRtv0w9fYZRdaUroK8RiXSvSkHvPwncSzwy
	NXGKh2CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98cM-00000008AM6-48Tu;
	Thu, 07 Nov 2024 19:56:34 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98Lw-000000086c3-0TQa
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:39:37 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImQFt016075
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 11:39:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=t6x4wXqI8S4BF2y32y83lFi0n/5qVe5afkxyBlfTHwk=; b=M3s3ONPt8Rb8
	F5cGn0PpsOuHgZJ1N8yoBR1VuuXKF/Dg5x/BCv1iRkzJbmRqDbmXGvTi4VfkGVqy
	xan/T4rZcS+xrmlB5NSxuQv2o2R+ZOiVejYLfaamX2iLqq47jUycCRHlaCDAh0kl
	kFxSfS/ZjZcFj8J3xlJUo50ql4FV555U6wRx439Z/gZFExpiE8eBhphGpGyTo8kA
	WzHgjZvfY668Nw4Kga7sme0iO/t/rfjZMN7I64XySvJK8LoeF3JNTo31LYUu3i1o
	1c3p5KX3tJyHxGchy8MD+RZ7MzEJ+Q/3W4cBjW1fbaSxQB1bfM34/j0srA8+FbaT
	N8y8XFLNfw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ry2hjj4h-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 11:39:35 -0800 (PST)
Received: from twshared25495.03.ash8.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 7 Nov 2024 19:39:08 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 2FD9014DC39F8; Thu,  7 Nov 2024 11:38:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>, <kch@nvidia.com>,
        <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 03/13] nvmet: implement supported log pages
Date: Thu, 7 Nov 2024 11:38:38 -0800
Message-ID: <20241107193849.995554-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107193849.995554-1-kbusch@meta.com>
References: <20241107193849.995554-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4bBNp4vIQSbdgcjrIuogpVE98HOw_AqW
X-Proofpoint-GUID: 4bBNp4vIQSbdgcjrIuogpVE98HOw_AqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_113936_187076_C664C19E 
X-CRM114-Status: GOOD (  11.16  )
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
 drivers/nvme/target/admin-cmd.c | 27 +++++++++++++++++++++++++++
 include/linux/nvme.h            |  9 +++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index a13242e791c0f..712b962fe77ac 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -71,6 +71,31 @@ static void nvmet_execute_get_log_page_error(struct nv=
met_req *req)
 	nvmet_req_complete(req, 0);
 }
=20
+static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
+{
+	struct nvme_supported_log *logs;
+	u16 status;
+
+	logs =3D kzalloc(sizeof(*logs), GFP_KERNEL);
+	if (!logs) {
+		status =3D NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	logs->lids[NVME_LOG_SUPPORTED] =3D cpu_to_le32(NVME_LIDS_LSUPP);
+	logs->lids[NVME_LOG_ERROR] =3D cpu_to_le32(NVME_LIDS_LSUPP);
+	logs->lids[NVME_LOG_SMART] =3D cpu_to_le32(NVME_LIDS_LSUPP);
+	logs->lids[NVME_LOG_FW_SLOT] =3D cpu_to_le32(NVME_LIDS_LSUPP);
+	logs->lids[NVME_LOG_CHANGED_NS] =3D cpu_to_le32(NVME_LIDS_LSUPP);
+	logs->lids[NVME_LOG_CMD_EFFECTS] =3D cpu_to_le32(NVME_LIDS_LSUPP);
+	logs->lids[NVME_LOG_ANA] =3D cpu_to_le32(NVME_LIDS_LSUPP);
+
+	status =3D nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
+	kfree(logs);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		struct nvme_smart_log *slog)
 {
@@ -323,6 +348,8 @@ static void nvmet_execute_get_log_page(struct nvmet_r=
eq *req)
 		return;
=20
 	switch (req->cmd->get_log_page.lid) {
+	case NVME_LOG_SUPPORTED:
+		return nvmet_execute_get_supported_log_pages(req);
 	case NVME_LOG_ERROR:
 		return nvmet_execute_get_log_page_error(req);
 	case NVME_LOG_SMART:
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 0f263c7e63192..692d606edeed3 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1245,6 +1245,7 @@ enum {
 	NVME_FEAT_WRITE_PROTECT	=3D 0x84,
 	NVME_FEAT_VENDOR_START	=3D 0xC0,
 	NVME_FEAT_VENDOR_END	=3D 0xFF,
+	NVME_LOG_SUPPORTED	=3D 0x00,
 	NVME_LOG_ERROR		=3D 0x01,
 	NVME_LOG_SMART		=3D 0x02,
 	NVME_LOG_FW_SLOT	=3D 0x03,
@@ -1262,6 +1263,14 @@ enum {
 	NVME_FWACT_ACTV		=3D (2 << 3),
 };
=20
+struct nvme_supported_log {
+	__le32	lids[256];
+};
+
+enum {
+	NVME_LIDS_LSUPP	=3D 1 << 0,
+};
+
 /* NVMe Namespace Write Protect State */
 enum {
 	NVME_NS_NO_WRITE_PROTECT =3D 0,
--=20
2.43.5


