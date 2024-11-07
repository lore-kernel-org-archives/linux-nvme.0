Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A818D5D687
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t3NwbGKZGrqHwhEwdA2rnJbdGqdGz2tJlV7RNYtu0YE=; b=v89S4Z0TeAekfsqBEjMFUmJzev
	/GBN5+QrTA4XJ6J+2KgpP9Z/3aOOcaxgDKW+DiCgwYLgNpA+cmVhgAa2hRNDZ/XAyw1/7WhpSpdZS
	30Ue5q7eWH7DDLS8O/liom5tCVoSnT1T9dAH4CJKGLsvzSbFppHuLEpdjSZhKtmKOWqbE6armszlg
	OARHJyRRwbeK7gDuZxIyWWBhFlza35PZxMdbO9xhtWxrHD/QK1nRTSLWFZ3fq84vTLVhjGMuHtHmO
	KfZaOshYuleP+iQWxW2Mt39zJs5BwODLV5uwcfVrfP4Y47HDE9Fg7knZ/yVE6SE0SNN4ENl3gnfQm
	DCx1a8kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98cA-00000008ABd-2M0z;
	Thu, 07 Nov 2024 19:56:22 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98Lt-000000086aJ-1Dr8
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:39:35 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImPr2018669
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 11:39:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=t3NwbGKZGrqHwhEwdA2rnJbdGqdGz2tJlV7RNYtu0YE=; b=l5t7VAWnsO71
	QqI45AufoY+SS9BVQVw7mcofy0vlEbJkKhd7ikv/+K/9/ssCUSZJ09UTmTVsUg4d
	DsG5fEN2Fhb87CKMmVZBcwwsJqvF1WeVagQTp1HodvQQ8a6xj4cJyajIlBz+/nwt
	PRcM62H8bjlK0fakNTOLPy73xvIjz2GSN/HJQBRCZxotIT7TeJa1ijmROwe2TA4O
	lDbpWRa1W3sFJBrCnIY/TTg7Pdw5FElYHoJ3uGfdb2bTVJ55OUt3pdyh+aq/Ij0R
	KF3SzkWUNLthf8omXSDOTAZ3n6feY20jFTxdR/XhOkU25S63S8jwFveMKsUAr9PN
	udYlEfwMLA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42s12shjp8-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 11:39:32 -0800 (PST)
Received: from twshared23455.15.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 7 Nov 2024 19:39:05 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 8334B14DC3A02; Thu,  7 Nov 2024 11:38:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>, <kch@nvidia.com>,
        <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 08/13] nvmet: implement rotational media information log
Date: Thu, 7 Nov 2024 11:38:43 -0800
Message-ID: <20241107193849.995554-9-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107193849.995554-1-kbusch@meta.com>
References: <20241107193849.995554-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PLyUlXsWrbvGRCL2TZKNVoqdd5GpgIl3
X-Proofpoint-ORIG-GUID: PLyUlXsWrbvGRCL2TZKNVoqdd5GpgIl3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_113933_376445_0A339BBD 
X-CRM114-Status: GOOD (  15.03  )
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

Most of the information is stubbed. Supporting this log is a requirement
for supporting rotational media.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c        |  1 +
 drivers/nvme/target/admin-cmd.c | 42 +++++++++++++++++++++++++++++++++
 include/linux/nvme.h            | 15 +++++++++++-
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 426d4b90ecd7e..279b0f445904d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5002,6 +5002,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) !=3D 64);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) !=3D 512);
 	BUILD_BUG_ON(sizeof(struct nvme_endurance_group_log) !=3D 512);
+	BUILD_BUG_ON(sizeof(struct nvme_rotational_media_log) !=3D 512);
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) !=3D 64);
 	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) !=3D 64);
 	BUILD_BUG_ON(sizeof(struct nvme_feat_host_behavior) !=3D 512);
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index db26cd50be909..6d3a1d2103bf3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -91,6 +91,7 @@ static void nvmet_execute_get_supported_log_pages(struc=
t nvmet_req *req)
 	logs->lids[NVME_LOG_ENDURANCE_GROUP] =3D cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_ANA] =3D cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_FEATURES] =3D cpu_to_le32(NVME_LIDS_LSUPP);
+	logs->lids[NVME_LOG_RMI] =3D cpu_to_le32(NVME_LIDS_LSUPP);
=20
 	status =3D nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
 	kfree(logs);
@@ -157,6 +158,45 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req =
*req,
 	return NVME_SC_SUCCESS;
 }
=20
+static void nvmet_execute_get_log_page_rmi(struct nvmet_req *req)
+{
+	struct nvme_rotational_media_log *log;
+	struct gendisk *disk;
+	u16 status;
+
+	req->cmd->common.nsid =3D cpu_to_le32(le16_to_cpu(
+					    req->cmd->get_log_page.lsi));
+	status =3D nvmet_req_find_ns(req);
+	if (status)
+		goto out;
+
+	if (!req->ns->bdev || bdev_nonrot(req->ns->bdev)) {
+		status =3D NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto out;
+	}
+
+	if (req->transfer_len !=3D sizeof(*log)) {
+		status =3D NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
+		goto out;
+	}
+
+	log =3D kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log)
+		goto out;
+
+	log->endgid =3D req->cmd->get_log_page.lsi;
+	disk =3D req->ns->bdev->bd_disk;
+	if (disk && disk->ia_ranges)
+		log->numa =3D cpu_to_le16(disk->ia_ranges->nr_ia_ranges);
+	else
+		log->numa =3D cpu_to_le16(1);
+
+	status =3D nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	kfree(log);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 {
 	struct nvme_smart_log *log;
@@ -444,6 +484,8 @@ static void nvmet_execute_get_log_page(struct nvmet_r=
eq *req)
 		return nvmet_execute_get_log_page_ana(req);
 	case NVME_LOG_FEATURES:
 		return nvmet_execute_get_log_page_features(req);
+	case NVME_LOG_RMI:
+		return nvmet_execute_get_log_page_rmi(req);
 	}
 	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9b5867f1aa591..93a0abfab5b0e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -642,6 +642,18 @@ struct nvme_endurance_group_log {
 	__u8	rsvd192[320];
 };
=20
+struct nvme_rotational_media_log {
+	__le16	endgid;
+	__le16	numa;
+	__le16	nrs;
+	__u8	rsvd6[2];
+	__le32	spinc;
+	__le32	fspinc;
+	__le32	ldc;
+	__le32	fldc;
+	__u8	rsvd24[488];
+};
+
 struct nvme_smart_log {
 	__u8			critical_warning;
 	__u8			temperature[2];
@@ -1281,6 +1293,7 @@ enum {
 	NVME_LOG_ENDURANCE_GROUP =3D 0x09,
 	NVME_LOG_ANA		=3D 0x0c,
 	NVME_LOG_FEATURES	=3D 0x12,
+	NVME_LOG_RMI		=3D 0x16,
 	NVME_LOG_DISC		=3D 0x70,
 	NVME_LOG_RESERVATION	=3D 0x80,
 	NVME_FWACT_REPL		=3D (0 << 3),
@@ -1435,7 +1448,7 @@ struct nvme_get_log_page_command {
 	__u8			lsp; /* upper 4 bits reserved */
 	__le16			numdl;
 	__le16			numdu;
-	__u16			rsvd11;
+	__le16			lsi;
 	union {
 		struct {
 			__le32 lpol;
--=20
2.43.5


