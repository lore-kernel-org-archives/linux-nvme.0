Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483BDD64085
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 20:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBl/Yt7Ur9iLYRMrbtQEG9tvxzXglHjGYZ7HH7H2LOA=; b=zrIEUfjKgspNTyrhjbF9pHZlbZ
	6dU0tm0cyHrmF6gJDMY+H7467QUdIwMeTqghu8JG4pMrZb26z3Kyj87/B260I1npOzaiyw8NNPqRY
	IfgmHq1SahGndJQO7Znl25V8zHQnW7FHgPChz4ioF5awZqKfjFPpw7qbaZRE9qIJOO4jzrNNfg2Bm
	DZ0cTJJVTGwYIYXgTWWizVIA7hD2vUlgtxBr+7s5x+UQQ6ifRV9QW1u6Ef+Q+CVww8wQBkXHmsupC
	qnFKrxuWsXKeBlHpTC5YFgnUy9YSDH9uCpa4ctQtKUT0Klt3TkCgIOkghK8Hc9Fsyo5vjdsVkVu/a
	zmQiC56g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9VPT-0000000BrIt-2Dny;
	Fri, 08 Nov 2024 20:16:47 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9VO5-0000000BrCv-2Q5I
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 20:15:23 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8K3bjc003800
	for <linux-nvme@lists.infradead.org>; Fri, 8 Nov 2024 12:15:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=UBl/Yt7Ur9iLYRMrbtQEG9tvxzXglHjGYZ7HH7H2LOA=; b=ngZlM39Jq970
	TbTwbR+2xwN6592prZdfwP3kDscljOqr1YWTIx3gacq3Ap9RSVLNy1yzJzxSFMkl
	OVfGaZcn+oPkTVaW+OheANu8aez3w2QzS/x3NPuvHSI2BHceNJ5ens+1gPuoPCsX
	933rnqDsNyE+Ejlt7ta8jfPqxSr2fvciEEf/aB4BaNMT+bmGOmLGkYlxjm1fAYdH
	F/SYaIDrWbB2/UqSIYT+Jz0mz+0V9u+fIpGlMC5zKLeGsa1cqzz0Mq5HawUG/MRm
	44Ak2e6ZPzytEmvg4qX02stxrn9zpjAaXLAWVKA3CqfEt58wjGpkLGHDrvvMZY0a
	FA0nQazr6Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ssbd02kp-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 08 Nov 2024 12:15:19 -0800 (PST)
Received: from twshared35181.07.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 8 Nov 2024 20:15:05 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id C0B8314E3A03F; Fri,  8 Nov 2024 11:36:58 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <axboe@kernel.dk>
CC: <hch@lst.de>, <martin.petersen@oracle.com>, <asml.silence@gmail.com>,
        <javier.gonz@samsung.com>, <joshi.k@samsung.com>,
        Hui Qi
	<hui81.qi@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
        Hannes
 Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv11 8/9] nvme: enable FDP support
Date: Fri, 8 Nov 2024 11:36:28 -0800
Message-ID: <20241108193629.3817619-9-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241108193629.3817619-1-kbusch@meta.com>
References: <20241108193629.3817619-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LTQSOCTuRj2bT0qOlR_nuU6qn5JEGEnL
X-Proofpoint-ORIG-GUID: LTQSOCTuRj2bT0qOlR_nuU6qn5JEGEnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_121521_770030_78733FB7 
X-CRM114-Status: GOOD (  20.33  )
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

From: Kanchan Joshi <joshi.k@samsung.com>

Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
to control the placement of logical blocks so as to reduce the SSD WAF.
Userspace can send the write hint information using io_uring or fcntl.

Fetch the placement-identifiers if the device supports FDP. The incoming
write-hint is mapped to a placement-identifier, which in turn is set in
the DSPEC field of the write command.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Hui Qi <hui81.qi@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c      | 69 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c |  3 +-
 drivers/nvme/host/nvme.h      |  5 +++
 include/linux/nvme.h          | 37 +++++++++++++++++++
 4 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b5b5d5dd6b517..356bf7ba4f4de 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -668,6 +668,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	ida_free(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
+	kfree(head->plids);
 	kfree(head);
 }
=20
@@ -985,6 +986,12 @@ static inline blk_status_t nvme_setup_rw(struct nvme=
_ns *ns,
 	if (req->cmd_flags & REQ_RAHEAD)
 		dsmgmt |=3D NVME_RW_DSM_FREQ_PREFETCH;
=20
+	if (req->write_hint && ns->head->nr_plids) {
+		u16 hint =3D max(req->write_hint, ns->head->nr_plids);
+		dsmgmt |=3D ns->head->plids[hint - 1] << 16;
+		control |=3D NVME_RW_DTYPE_DPLCMT;
+	}
+
 	if (req->cmd_flags & REQ_ATOMIC && !nvme_valid_atomic_write(req))
 		return BLK_STS_INVAL;
=20
@@ -2133,6 +2140,52 @@ static int nvme_update_ns_info_generic(struct nvme=
_ns *ns,
 	return ret;
 }
=20
+static int nvme_fetch_fdp_plids(struct nvme_ns *ns, u32 nsid)
+{
+	struct nvme_fdp_ruh_status_desc *ruhsd;
+	struct nvme_ns_head *head =3D ns->head;
+	struct nvme_fdp_ruh_status *ruhs;
+	struct nvme_command c =3D {};
+	int size, ret, i;
+
+	if (head->plids)
+		return 0;
+
+	size =3D struct_size(ruhs, ruhsd, NVME_MAX_PLIDS);
+	ruhs =3D kzalloc(size, GFP_KERNEL);
+	if (!ruhs)
+		return -ENOMEM;
+
+	c.imr.opcode =3D nvme_cmd_io_mgmt_recv;
+	c.imr.nsid =3D cpu_to_le32(nsid);
+	c.imr.mo =3D NVME_IO_MGMT_RECV_MO_RUHS;
+	c.imr.numd =3D cpu_to_le32(nvme_bytes_to_numd(size));
+
+	ret =3D nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
+	if (ret)
+		goto out;
+
+	ns->head->nr_plids =3D le16_to_cpu(ruhs->nruhsd);
+	if (!ns->head->nr_plids)
+		goto out;
+
+	ns->head->nr_plids =3D min(ns->head->nr_plids, NVME_MAX_PLIDS);
+	head->plids =3D kcalloc(ns->head->nr_plids, sizeof(head->plids),
+			      GFP_KERNEL);
+	if (!head->plids) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	for (i =3D 0; i < ns->head->nr_plids; i++) {
+		ruhsd =3D &ruhs->ruhsd[i];
+		head->plids[i] =3D le16_to_cpu(ruhsd->pid);
+	}
+out:
+	kfree(ruhs);
+	return ret;
+}
+
 static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
@@ -2169,6 +2222,19 @@ static int nvme_update_ns_info_block(struct nvme_n=
s *ns,
 			goto out;
 	}
=20
+	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
+		ret =3D nvme_fetch_fdp_plids(ns, info->nsid);
+		if (ret)
+			dev_warn(ns->ctrl->device,
+				"FDP failure status:0x%x\n", ret);
+		if (ret < 0)
+			goto out;
+	} else {
+		ns->head->nr_plids =3D 0;
+		kfree(ns->head->plids);
+		ns->head->plids =3D NULL;
+	}
+
 	blk_mq_freeze_queue(ns->disk->queue);
 	ns->head->lba_shift =3D id->lbaf[lbaf].ds;
 	ns->head->nuse =3D le64_to_cpu(id->nuse);
@@ -2199,6 +2265,9 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
 	if (!nvme_init_integrity(ns->head, &lim, info))
 		capacity =3D 0;
=20
+	lim.max_write_hints =3D ns->head->nr_plids;
+	if (lim.max_write_hints)
+		lim.features |=3D BLK_FEAT_PLACEMENT_HINTS;
 	ret =3D queue_limits_commit_update(ns->disk->queue, &lim);
 	if (ret) {
 		blk_mq_unfreeze_queue(ns->disk->queue);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index 6a15873055b95..1b9d9d6c18e0b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -632,7 +632,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, str=
uct nvme_ns_head *head)
=20
 	blk_set_stacking_limits(&lim);
 	lim.dma_alignment =3D 3;
-	lim.features |=3D BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
+	lim.features |=3D BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL |
+			BLK_FEAT_PLACEMENT_HINTS;
 	if (head->ids.csi =3D=3D NVME_CSI_ZNS)
 		lim.features |=3D BLK_FEAT_ZONED;
 	else
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 093cb423f536b..a2a97fd3fde16 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -454,6 +454,8 @@ struct nvme_ns_ids {
 	u8	csi;
 };
=20
+#define NVME_MAX_PLIDS   (NVME_CTRL_PAGE_SIZE / sizeof(u16))
+
 /*
  * Anchor structure for namespaces.  There is one for each namespace in =
a
  * NVMe subsystem that any of our controllers can see, and the namespace
@@ -490,6 +492,9 @@ struct nvme_ns_head {
 	struct device		cdev_device;
=20
 	struct gendisk		*disk;
+
+	u16                     nr_plids;
+	u16			*plids;
 #ifdef CONFIG_NVME_MULTIPATH
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b58d9405d65e0..8930f643bdc11 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -275,6 +275,7 @@ enum nvme_ctrl_attr {
 	NVME_CTRL_ATTR_HID_128_BIT	=3D (1 << 0),
 	NVME_CTRL_ATTR_TBKAS		=3D (1 << 6),
 	NVME_CTRL_ATTR_ELBAS		=3D (1 << 15),
+	NVME_CTRL_ATTR_FDPS		=3D (1 << 19),
 };
=20
 struct nvme_id_ctrl {
@@ -843,6 +844,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_register	=3D 0x0d,
 	nvme_cmd_resv_report	=3D 0x0e,
 	nvme_cmd_resv_acquire	=3D 0x11,
+	nvme_cmd_io_mgmt_recv	=3D 0x12,
 	nvme_cmd_resv_release	=3D 0x15,
 	nvme_cmd_zone_mgmt_send	=3D 0x79,
 	nvme_cmd_zone_mgmt_recv	=3D 0x7a,
@@ -864,6 +866,7 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_register),	\
 		nvme_opcode_name(nvme_cmd_resv_report),		\
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
+		nvme_opcode_name(nvme_cmd_io_mgmt_recv),	\
 		nvme_opcode_name(nvme_cmd_resv_release),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
@@ -1015,6 +1018,7 @@ enum {
 	NVME_RW_PRINFO_PRCHK_GUARD	=3D 1 << 12,
 	NVME_RW_PRINFO_PRACT		=3D 1 << 13,
 	NVME_RW_DTYPE_STREAMS		=3D 1 << 4,
+	NVME_RW_DTYPE_DPLCMT		=3D 2 << 4,
 	NVME_WZ_DEAC			=3D 1 << 9,
 };
=20
@@ -1102,6 +1106,38 @@ struct nvme_zone_mgmt_recv_cmd {
 	__le32			cdw14[2];
 };
=20
+struct nvme_io_mgmt_recv_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__le64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__u8			mo;
+	__u8			rsvd11;
+	__u16			mos;
+	__le32			numd;
+	__le32			cdw12[4];
+};
+
+enum {
+	NVME_IO_MGMT_RECV_MO_RUHS	=3D 1,
+};
+
+struct nvme_fdp_ruh_status_desc {
+	u16 pid;
+	u16 ruhid;
+	u32 earutr;
+	u64 ruamw;
+	u8  rsvd16[16];
+};
+
+struct nvme_fdp_ruh_status {
+	u8  rsvd0[14];
+	__le16 nruhsd;
+	struct nvme_fdp_ruh_status_desc ruhsd[];
+};
+
 enum {
 	NVME_ZRA_ZONE_REPORT		=3D 0,
 	NVME_ZRASF_ZONE_REPORT_ALL	=3D 0,
@@ -1822,6 +1858,7 @@ struct nvme_command {
 		struct nvmf_auth_receive_command auth_receive;
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
+		struct nvme_io_mgmt_recv_cmd imr;
 	};
 };
=20
--=20
2.43.5


