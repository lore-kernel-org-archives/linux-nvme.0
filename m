Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3B0D3176C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 17:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Db6ODZig15YXhGD5uML8ys6xpW8NdZsfGI99qKf6m24=; b=RCJkHRdRcPOcAWTz15XwMlOOeX
	AyvfxlyuJEPz9wnDhFDAKZUOv9Wp2ZXAd7ZV1eX310YzYL8Q5XS+Y2OjlHwMNrIbw0YfyUZffCG5F
	tD4C+P5PNicQ1QDVtRiMLXPYOeJZ5E6tQQIHYNJXuUQ1VzgVQj7PSqEhvxzddgx/z4LMuI3z8SNjK
	EvLUYPJ43aQziDwUnviZ0vb16C45vaILz/1q197VfX6/d/T6mOm7xl3LZLZBNedTfaq8TwViBIQIv
	NFwt2P8XOoH/1O4NbxxKxLck67G6/qeF/L9vZuTBThKFiugWOGuPqk5q3TEDt2CXAi5zGFtHI1Q2R
	cKsBKjZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8NgC-00000000GhS-0cuQ;
	Tue, 05 Nov 2024 17:49:24 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ng4-00000000Gce-2SxO
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 17:49:19 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4A5HLAvX027889
	for <linux-nvme@lists.infradead.org>; Tue, 5 Nov 2024 09:49:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=Db6ODZig15YXhGD5uML8ys6xpW8NdZsfGI99qKf6m24=; b=b+ESsJKGp5oB
	50QOYRWHrOZ1/vlowtz9flIZYs1H3kR8EKiNDeGbm4euDcWYfAvHlvkcmbRtoNWA
	xMX06G3ey/Uv+zRMjIn5G++0M+RZtRT1S/LU6Bxs9oucTKz2HQX23Oh7tbUTIaTJ
	l01gVCmeRvRNb1LknU1sSyhcw9bu9ppKSGjds86/aF+A6zZhCSI+h4wZkn8Ybmve
	0PBEMGViDqrElLmjXXoEy3+2XY3OMFSngC67YI/B7qsKOtB9BO2q6XfrWlUKcGnf
	3VGsizM/BBv5MOLFTSTdcogxsIzfeuq0P3QvDxSvOPxv6EG4mwhzdF2xFAinrO0G
	EsDwus/r1g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42qgjbu50d-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 09:49:15 -0800 (PST)
Received: from twshared18321.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 5 Nov 2024 17:49:12 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 8AD9614CB3BE9; Tue,  5 Nov 2024 09:49:06 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3 07/11] nvmet: implement endurance groups
Date: Tue, 5 Nov 2024 09:49:00 -0800
Message-ID: <20241105174904.3612888-8-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241105174904.3612888-1-kbusch@meta.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: jyaY5YyRBm460LG5v3SdnVsDQQRG1RB8
X-Proofpoint-ORIG-GUID: jyaY5YyRBm460LG5v3SdnVsDQQRG1RB8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_094917_250424_09A169E0 
X-CRM114-Status: GOOD (  16.23  )
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

Most of the returned information is just stubbed data. The target must
support these in order to report rotational media. Since this driver
doesn't know any better, each namespace is its own endurance group with
the engid value matching the nsid.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c        |  1 +
 drivers/nvme/target/admin-cmd.c | 85 +++++++++++++++++++++++++++++++++
 include/linux/nvme.h            | 29 ++++++++++-
 3 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3de7555a7de74..02e969a34f9e8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5006,6 +5006,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl_nvm) !=3D NVME_IDENTIFY_DATA_SI=
ZE);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) !=3D 64);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) !=3D 512);
+	BUILD_BUG_ON(sizeof(struct nvme_endurance_group_log) !=3D 512);
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) !=3D 64);
 	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) !=3D 64);
 	BUILD_BUG_ON(sizeof(struct nvme_feat_host_behavior) !=3D 512);
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index c9b38d593fda5..978a298fc6377 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -299,6 +299,45 @@ static u32 nvmet_format_ana_group(struct nvmet_req *=
req, u32 grpid,
 	return struct_size(desc, nsids, count);
 }
=20
+static void nvmet_execute_get_log_page_endgrp(struct nvmet_req *req)
+{
+	u64 host_reads, host_writes, data_units_read, data_units_written;
+	struct nvme_endurance_group_log *log;
+	u16 status;
+
+	req->cmd->common.nsid =3D cpu_to_le32((u32)
+				le16_to_cpu(req->cmd->get_log_page.lsi));
+	status =3D nvmet_req_find_ns(req);
+	if (status)
+		goto out;
+
+	log =3D kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log) {
+		status =3D NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	if (!req->ns->bdev)
+		goto copy;
+
+	host_reads =3D part_stat_read(req->ns->bdev, ios[READ]);
+	data_units_read =3D
+		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[READ]), 1000);
+	host_writes =3D part_stat_read(req->ns->bdev, ios[WRITE]);
+	data_units_written =3D
+		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[WRITE]), 1000);
+
+	put_unaligned_le64(host_reads, &log->hrc[0]);
+	put_unaligned_le64(data_units_read, &log->dur[0]);
+	put_unaligned_le64(host_writes, &log->hwc[0]);
+	put_unaligned_le64(data_units_written, &log->duw[0]);
+copy:
+	status =3D nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	kfree(log);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 {
 	struct nvme_ana_rsp_hdr hdr =3D { 0, };
@@ -390,6 +429,8 @@ static void nvmet_execute_get_log_page(struct nvmet_r=
eq *req)
 		return nvmet_execute_get_log_changed_ns(req);
 	case NVME_LOG_CMD_EFFECTS:
 		return nvmet_execute_get_log_cmd_effects_ns(req);
+	case NVME_LOG_ENDURANCE_GROUP:
+		return nvmet_execute_get_log_page_endgrp(req);
 	case NVME_LOG_ANA:
 		return nvmet_execute_get_log_page_ana(req);
 	case NVME_LOG_FEATURES:
@@ -521,6 +562,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_=
req *req)
=20
 	id->msdbd =3D ctrl->ops->msdbd;
=20
+	id->endgidmax =3D cpu_to_le16((u16)NVMET_MAX_NAMESPACES);
+
 	id->anacap =3D (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4);
 	id->anatt =3D 10; /* random value */
 	id->anagrpmax =3D cpu_to_le32(NVMET_MAX_ANAGRPS);
@@ -605,6 +648,12 @@ static void nvmet_execute_identify_ns(struct nvmet_r=
eq *req)
 	id->nmic =3D NVME_NS_NMIC_SHARED;
 	id->anagrpid =3D cpu_to_le32(req->ns->anagrpid);
=20
+	/*
+	 * Since we don't know any better, every namespace is its own endurance
+	 * group.
+	 */
+	id->endgid =3D cpu_to_le16((u16)req->ns->nsid);
+
 	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
=20
 	id->lbaf[0].ds =3D req->ns->blksize_shift;
@@ -630,6 +679,39 @@ static void nvmet_execute_identify_ns(struct nvmet_r=
eq *req)
 	nvmet_req_complete(req, status);
 }
=20
+static void nvmet_execute_identify_endgrp_list(struct nvmet_req *req)
+{
+	u16 min_endgid =3D le16_to_cpu(req->cmd->identify.cnssid);
+	static const int buf_size =3D NVME_IDENTIFY_DATA_SIZE;
+	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
+	struct nvmet_ns *ns;
+	unsigned long idx;
+	__le16 *list;
+	u16 status;
+	int i =3D 1;
+
+	list =3D kzalloc(buf_size, GFP_KERNEL);
+	if (!list) {
+		status =3D NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
+		if (ns->nsid <=3D min_endgid)
+			continue;
+
+		list[i++] =3D cpu_to_le16((u16)ns->nsid);
+		if (i =3D=3D buf_size / sizeof(__le16))
+			break;
+	}
+
+	list[0] =3D cpu_to_le16((u16)i - 1);
+	status =3D nvmet_copy_to_sgl(req, 0, list, buf_size);
+	kfree(list);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool ma=
tch_css)
 {
 	static const int buf_size =3D NVME_IDENTIFY_DATA_SIZE;
@@ -802,6 +884,9 @@ static void nvmet_execute_identify(struct nvmet_req *=
req)
 	case NVME_ID_CNS_NS_ACTIVE_LIST_CS:
 		nvmet_execute_identify_nslist(req, true);
 		return;
+	case NVME_ID_CNS_ENDGRP_LIST:
+		nvmet_execute_identify_endgrp_list(req);
+		return;
 	}
=20
 	pr_debug("unhandled identify cns %d on qid %d\n",
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b1238691bd491..49b32dc74c24a 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -327,7 +327,8 @@ struct nvme_id_ctrl {
 	__le32			sanicap;
 	__le32			hmminds;
 	__le16			hmmaxd;
-	__u8			rsvd338[4];
+	__le16			nvmsetidmax;
+	__le16			endgidmax;
 	__u8			anatt;
 	__u8			anacap;
 	__le32			anagrpmax;
@@ -531,6 +532,7 @@ enum {
 	NVME_ID_CNS_SCNDRY_CTRL_LIST	=3D 0x15,
 	NVME_ID_CNS_NS_GRANULARITY	=3D 0x16,
 	NVME_ID_CNS_UUID_LIST		=3D 0x17,
+	NVME_ID_CNS_ENDGRP_LIST		=3D 0x19,
 };
=20
 enum {
@@ -618,6 +620,28 @@ enum {
 	NVME_NIDT_CSI		=3D 0x04,
 };
=20
+struct nvme_endurance_group_log {
+	__u8	egcw;
+	__u8	egfeat;
+	__u8	rsvd2;
+	__u8	avsp;
+	__u8	avspt;
+	__u8	pused;
+	__le16	did;
+	__u8	rsvd8[24];
+	__u8	ee[16];
+	__u8	dur[16];
+	__u8	duw[16];
+	__u8	muw[16];
+	__u8	hrc[16];
+	__u8	hwc[16];
+	__u8	mdie[16];
+	__u8	neile[16];
+	__u8	tegcap[16];
+	__u8	uegcap[16];
+	__u8	rsvd192[320];
+};
+
 struct nvme_smart_log {
 	__u8			critical_warning;
 	__u8			temperature[2];
@@ -1284,7 +1308,8 @@ struct nvme_identify {
 	__u8			cns;
 	__u8			rsvd3;
 	__le16			ctrlid;
-	__u8			rsvd11[3];
+	__le16			cnssid;
+	__u8			rsvd11;
 	__u8			csi;
 	__u32			rsvd12[4];
 };
--=20
2.43.5


