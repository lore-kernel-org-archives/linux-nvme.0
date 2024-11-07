Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C72D5D688
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dc6E6ZnSwOoq/ruDHXGgTI1ZbIHEKMWfn+oooLU36eQ=; b=ohWm7VHbAeGsbIHbee33UypnCc
	HoXuAUK7KPdVofsemRnfMjWdGyMZoLNHFt3szfpUz001De6UDevKUf7Lg9pxjkpB6ByV3pF6vLSwY
	cveswQx/fRC2BDnUl70Y1g+aMBU0bzfyhC317TcuCS0tR2vwjqXH/Jfw4qEPfztSH0+kuT7V5cGsz
	dkHaYEqo9B8P0bFLFPzvcaDW/te+9xq2sFlTW2XquNP0T6zSzI8XjT8BLhUP+lm708UXb0txLk/oE
	KlfaxxTStaBqJiFyTrAB2RZnb1ElAwi+8Pi0yZOXVdXsAQZ2oFSo3W6+xB5rEV5KkdUL8vZIidrjt
	XUxn0xpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98c6-00000008A8u-2uiS;
	Thu, 07 Nov 2024 19:56:18 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98Lr-000000086ZK-2Y0Y
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:39:33 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImN6B015665
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 11:39:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=dc6E6ZnSwOoq/ruDHXGgTI1ZbIHEKMWfn+oooLU36eQ=; b=ZfktPeVGAV5Y
	b38mVgGAYg9RcvLFynAdRyAhknk423gTzk+62vUS9R1t9n1kVOXAmTYEqaDX5YjF
	y+BA0cOYGdxl9GjHeggdXeD1Ytt7KGp/fQeHk0g/VitrtWrlO2s9N4qbSP/gsEPx
	2mxc4ycE6mxkSsY00kxpXbfkSAgBdbt4tpEnS6WNetTdXwKJ9OE34Z8P0re15Z3f
	rZwalaftkOosPlkKhtreRpjkb8HFoauntSZltWcSR93EI4d4aGIUCFSTYaCvtrEe
	DyC2OjKVMcINo9IwwpGkK6JiXMFS8tl2fMa8/kNaNAcUOQ1nrJii+lLNEZlTP6Y8
	qzPNgFomxw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42s2fhrsrg-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 11:39:30 -0800 (PST)
Received: from twshared13976.17.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 7 Nov 2024 19:38:59 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 76E5A14DC3A00; Thu,  7 Nov 2024 11:38:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>, <kch@nvidia.com>,
        <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 07/13] nvmet: implement endurance groups
Date: Thu, 7 Nov 2024 11:38:42 -0800
Message-ID: <20241107193849.995554-8-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107193849.995554-1-kbusch@meta.com>
References: <20241107193849.995554-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dSfHpnCp_pbEyFyk0ZR6Ckr0xsHdiM7W
X-Proofpoint-ORIG-GUID: dSfHpnCp_pbEyFyk0ZR6Ckr0xsHdiM7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_113931_798838_D27A711C 
X-CRM114-Status: GOOD (  16.18  )
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
 drivers/nvme/target/admin-cmd.c | 95 +++++++++++++++++++++++++++++++++
 include/linux/nvme.h            | 29 +++++++++-
 3 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e9aac07f4c26d..426d4b90ecd7e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5001,6 +5001,7 @@ static inline void _nvme_check_size(void)
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
index 7a879e2cd8555..db26cd50be909 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -88,6 +88,7 @@ static void nvmet_execute_get_supported_log_pages(struc=
t nvmet_req *req)
 	logs->lids[NVME_LOG_FW_SLOT] =3D cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_CHANGED_NS] =3D cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_CMD_EFFECTS] =3D cpu_to_le32(NVME_LIDS_LSUPP);
+	logs->lids[NVME_LOG_ENDURANCE_GROUP] =3D cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_ANA] =3D cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_FEATURES] =3D cpu_to_le32(NVME_LIDS_LSUPP);
=20
@@ -298,6 +299,49 @@ static u32 nvmet_format_ana_group(struct nvmet_req *=
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
+	/*
+	 * The target driver emulates each endurance group as its own
+	 * namespace, reusing the nsid as the endurance group identifier.
+	 */
+	req->cmd->common.nsid =3D cpu_to_le32(le16_to_cpu(
+					    req->cmd->get_log_page.lsi));
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
@@ -394,6 +438,8 @@ static void nvmet_execute_get_log_page(struct nvmet_r=
eq *req)
 		return nvmet_execute_get_log_changed_ns(req);
 	case NVME_LOG_CMD_EFFECTS:
 		return nvmet_execute_get_log_cmd_effects_ns(req);
+	case NVME_LOG_ENDURANCE_GROUP:
+		return nvmet_execute_get_log_page_endgrp(req);
 	case NVME_LOG_ANA:
 		return nvmet_execute_get_log_page_ana(req);
 	case NVME_LOG_FEATURES:
@@ -525,6 +571,13 @@ static void nvmet_execute_identify_ctrl(struct nvmet=
_req *req)
=20
 	id->msdbd =3D ctrl->ops->msdbd;
=20
+	/*
+	 * Endurance group identifier is 16 bits, so we can't let namespaces
+	 * overflow that since we reuse the nsid
+	 */
+	BUILD_BUG_ON(NVMET_MAX_NAMESPACES > USHRT_MAX);
+	id->endgidmax =3D cpu_to_le16(NVMET_MAX_NAMESPACES);
+
 	id->anacap =3D (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4);
 	id->anatt =3D 10; /* random value */
 	id->anagrpmax =3D cpu_to_le32(NVMET_MAX_ANAGRPS);
@@ -609,6 +662,12 @@ static void nvmet_execute_identify_ns(struct nvmet_r=
eq *req)
 	id->nmic =3D NVME_NS_NMIC_SHARED;
 	id->anagrpid =3D cpu_to_le32(req->ns->anagrpid);
=20
+	/*
+	 * Since we don't know any better, every namespace is its own endurance
+	 * group.
+	 */
+	id->endgid =3D cpu_to_le16(req->ns->nsid);
+
 	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
=20
 	id->lbaf[0].ds =3D req->ns->blksize_shift;
@@ -634,6 +693,39 @@ static void nvmet_execute_identify_ns(struct nvmet_r=
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
+		list[i++] =3D cpu_to_le16(ns->nsid);
+		if (i =3D=3D buf_size / sizeof(__le16))
+			break;
+	}
+
+	list[0] =3D cpu_to_le16(i - 1);
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
@@ -806,6 +898,9 @@ static void nvmet_execute_identify(struct nvmet_req *=
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
index 4b896fa651e02..9b5867f1aa591 100644
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
@@ -1302,7 +1326,8 @@ struct nvme_identify {
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


