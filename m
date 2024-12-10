Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09287E7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 20:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OeAFDFh9nDrzvjn6Ci3E1x+se/W+HHmUUWFaWlwZTnk=; b=mjkcIU4Dr9Oy+42Hgn4v6DW3qU
	IUm8C0AghqptqZfATadf0Cf3r9pO4C8mwdfgxSnmdSMgqVmMCNFs+/RmSIE6vgCYQI6cIjLQqXlDm
	7Xq1ktPJGnDTfathxjmnMTbkRu4itGdh51maWE7PQuiYJH+a+YFgRlGdDwKATB93afctVI1OdWgMn
	+qbHs/HM6lrtmBJpCRTqe76tebBEN9T73DmmJz1+7oVX9Hw3EBEyrt19XfcC/jSaq1gvcfikbsruP
	tFEXFKAO2emphTCAXbqy0b2MQ8WpPDXutW4jaEEAme167E7MCt0C4KCDu7rzv+dZlnc2EFgIY+Zgc
	DILdVsyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6in-0000000Ceq8-2gSJ;
	Tue, 10 Dec 2024 20:20:41 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6ik-0000000CepV-40nu
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 20:20:40 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAIaN5B018802
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 12:20:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=OeAFDFh9nDrzvjn6Ci3E1x+se/W+HHmUUWFaWlwZTnk=; b=a9wj6GLMA11F
	WEUqOQTu37AEgKkKLivQe+NgFDwUvbubrwBFIl+6dXGMVweiglEyUfqQkQ3yW+Nf
	mrcjbDvcFwKjBxjd1fL0hn3sGicoowq/3f+UAocB8dWBK+J3XTeDmRbKeSVeVsN5
	DefdKEB0NZNDlyQ9DPjHPHTVWmBmSyHFRbG0HIsjFy6McwPqqdzhVHh+omJ1O3Ic
	EfEtPwRq+zYwdYCMUqoxE7qdWxoIH8YCNQDiwVmE+FzYIda8WqTXExtnMjms01E/
	TABJev7V3INYhRrVjdh9l5idp6eJXiG8uw/0VgUTeKPN+p3WBosm7NMfI+mkhVXT
	EWxMMC9A5Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43eu2s8swg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 12:20:38 -0800 (PST)
Received: from twshared40462.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 10 Dec 2024 20:20:36 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id D0DAD15D5C7D4; Tue, 10 Dec 2024 11:48:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv13 10/11] nvme: register fdp parameters with the block layer
Date: Tue, 10 Dec 2024 11:47:21 -0800
Message-ID: <20241210194722.1905732-11-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241210194722.1905732-1-kbusch@meta.com>
References: <20241210194722.1905732-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BW2SkYvjiEHrjuVyFhehg7tybeWifiHI
X-Proofpoint-ORIG-GUID: BW2SkYvjiEHrjuVyFhehg7tybeWifiHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_122039_004921_224343F3 
X-CRM114-Status: GOOD (  18.16  )
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

Register the device data placement limits if supported. This is just
registering the limits with the block layer. Nothing beyond reporting
these attributes is happening in this patch.

Merges parts from a patch by Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-nvme/20241119121632.1225556-15-hch@ls=
t.de/=20

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 139 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |   2 +
 2 files changed, 141 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2a3585a3fa59..f7aeda601fcd6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -38,6 +38,8 @@ struct nvme_ns_info {
 	u32 nsid;
 	__le32 anagrpid;
 	u8 pi_offset;
+	u16 endgid;
+	u64 runs;
 	bool is_shared;
 	bool is_readonly;
 	bool is_ready;
@@ -1613,6 +1615,7 @@ static int nvme_ns_info_from_identify(struct nvme_c=
trl *ctrl,
 	info->is_shared =3D id->nmic & NVME_NS_NMIC_SHARED;
 	info->is_readonly =3D id->nsattr & NVME_NS_ATTR_RO;
 	info->is_ready =3D true;
+	info->endgid =3D le16_to_cpu(id->endgid);
 	if (ctrl->quirks & NVME_QUIRK_BOGUS_NID) {
 		dev_info(ctrl->device,
 			 "Ignoring bogus Namespace Identifiers\n");
@@ -1653,6 +1656,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvm=
e_ctrl *ctrl,
 		info->is_ready =3D id->nstat & NVME_NSTAT_NRDY;
 		info->is_rotational =3D id->nsfeat & NVME_NS_ROTATIONAL;
 		info->no_vwc =3D id->nsfeat & NVME_NS_VWC_NOT_PRESENT;
+		info->endgid =3D le16_to_cpu(id->endgid);
 	}
 	kfree(id);
 	return ret;
@@ -2147,6 +2151,127 @@ static int nvme_update_ns_info_generic(struct nvm=
e_ns *ns,
 	return ret;
 }
=20
+static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
+				      struct nvme_ns_info *info, u8 fdp_idx)
+{
+	struct nvme_fdp_config_log hdr, *h;
+	struct nvme_fdp_config_desc *desc;
+	size_t size =3D sizeof(hdr);
+	int i, n, ret;
+	void *log;
+
+	ret =3D nvme_get_log_lsi(ctrl, 0, NVME_LOG_FDP_CONFIGS, 0,
+			       NVME_CSI_NVM, &hdr, size, 0, info->endgid);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "FDP configs log header status:0x%x endgid:%x\n", ret,
+			 info->endgid);
+		return ret;
+	}
+
+	size =3D le32_to_cpu(hdr.sze);
+	h =3D kzalloc(size, GFP_KERNEL);
+	if (!h) {
+		dev_warn(ctrl->device,
+			 "failed to allocate %lu bytes for FDP config log\n",
+			 size);
+		return -ENOMEM;
+	}
+
+	ret =3D nvme_get_log_lsi(ctrl, 0, NVME_LOG_FDP_CONFIGS, 0,
+			       NVME_CSI_NVM, h, size, 0, info->endgid);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "FDP configs log status:0x%x endgid:%x\n", ret,
+			 info->endgid);
+		goto out;
+	}
+
+	n =3D le16_to_cpu(h->numfdpc) + 1;
+	if (fdp_idx > n) {
+		dev_warn(ctrl->device, "FDP index:%d out of range:%d\n",
+			 fdp_idx, n);
+		/* Proceed without registering FDP streams */
+		ret =3D 0;
+		goto out;
+	}
+
+	log =3D h + 1;
+	desc =3D log;
+	for (i =3D 0; i < fdp_idx; i++) {
+		log +=3D le16_to_cpu(desc->dsze);
+		desc =3D log;
+	}
+
+	if (le32_to_cpu(desc->nrg) > 1) {
+		dev_warn(ctrl->device, "FDP NRG > 1 not supported\n");
+		ret =3D 0;
+		goto out;
+	}
+
+	info->runs =3D le64_to_cpu(desc->runs);
+out:
+	kfree(h);
+	return ret;
+}
+
+static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *=
info)
+{
+	struct nvme_ns_head *head =3D ns->head;
+	struct nvme_ctrl *ctrl =3D ns->ctrl;
+	struct nvme_fdp_ruh_status *ruhs;
+	struct nvme_fdp_config fdp;
+	struct nvme_command c =3D {};
+	size_t size;
+	int ret;
+
+	/*
+	 * The FDP configuration is static for the lifetime of the namespace,
+	 * so return immediately if we've already registered this namespaces's
+	 * streams.
+	 */
+	if (head->nr_plids)
+		return 0;
+
+	ret =3D nvme_get_features(ctrl, NVME_FEAT_FDP, info->endgid, NULL, 0,
+				&fdp);
+	if (ret) {
+		dev_warn(ctrl->device, "FDP get feature status:0x%x\n", ret);
+		return ret;
+	}
+
+	if (!(fdp.flags & FDPCFG_FDPE))
+		return 0;
+
+	ret =3D nvme_query_fdp_granularity(ctrl, info, fdp.fdpcidx);
+	if (!info->runs)
+		return ret;
+
+	size =3D struct_size(ruhs, ruhsd, S8_MAX - 1);
+	ruhs =3D kzalloc(size, GFP_KERNEL);
+	if (!ruhs) {
+		dev_warn(ctrl->device,
+			 "failed to allocate %lu bytes for FDP io-mgmt\n",
+			 size);
+		return -ENOMEM;
+	}
+
+	c.imr.opcode =3D nvme_cmd_io_mgmt_recv;
+	c.imr.nsid =3D cpu_to_le32(head->ns_id);
+	c.imr.mo =3D NVME_IO_MGMT_RECV_MO_RUHS;
+	c.imr.numd =3D cpu_to_le32(nvme_bytes_to_numd(size));
+	ret =3D nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
+	if (ret) {
+		dev_warn(ctrl->device, "FDP io-mgmt status:0x%x\n", ret);
+		goto free;
+	}
+
+	head->nr_plids =3D le16_to_cpu(ruhs->nruhsd);
+free:
+	kfree(ruhs);
+	return ret;
+}
+
 static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
@@ -2183,6 +2308,12 @@ static int nvme_update_ns_info_block(struct nvme_n=
s *ns,
 			goto out;
 	}
=20
+	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
+		ret =3D nvme_query_fdp_info(ns, info);
+		if (ret < 0)
+			goto out;
+	}
+
 	blk_mq_freeze_queue(ns->disk->queue);
 	ns->head->lba_shift =3D id->lbaf[lbaf].ds;
 	ns->head->nuse =3D le64_to_cpu(id->nuse);
@@ -2216,6 +2347,12 @@ static int nvme_update_ns_info_block(struct nvme_n=
s *ns,
 	if (!nvme_init_integrity(ns->head, &lim, info))
 		capacity =3D 0;
=20
+	lim.max_write_streams =3D ns->head->nr_plids;
+	if (lim.max_write_streams)
+		lim.write_stream_granularity =3D max(info->runs, U32_MAX);
+	else
+		lim.write_stream_granularity =3D 0;
+
 	ret =3D queue_limits_commit_update(ns->disk->queue, &lim);
 	if (ret) {
 		blk_mq_unfreeze_queue(ns->disk->queue);
@@ -2318,6 +2455,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, =
struct nvme_ns_info *info)
 			ns->head->disk->flags |=3D GENHD_FL_HIDDEN;
 		else
 			nvme_init_integrity(ns->head, &lim, info);
+		lim.max_write_streams =3D ns_lim->max_write_streams;
+		lim.write_stream_granularity =3D ns_lim->write_stream_granularity;
 		ret =3D queue_limits_commit_update(ns->head->disk->queue, &lim);
=20
 		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c1995d89ffdb8..4b412cd8001f1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -491,6 +491,8 @@ struct nvme_ns_head {
 	struct device		cdev_device;
=20
 	struct gendisk		*disk;
+
+	u16			nr_plids;
 #ifdef CONFIG_NVME_MULTIPATH
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
--=20
2.43.5


