Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301FFCA0EEB
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Aug 2025 02:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SpF7gDfNfdb16tfYdO08gdnfGgq/XJWxuudJ21yq/RA=; b=ABwpX93mkJRmyhVcb5Divyq10q
	CBAmhzAKyqMNj7BTZ+m3KQRl5Nlc83hl6NCxC1VUj0vwK3lZ7J2Sy8CSoV0Z1Kzzi/jQ1hEh1uJOP
	+Xc63osneBJZPW/LFhDDyVrTAWqcLs07Aq46YssIusdbhxotELVmiTxPSPT8JWZGDZvEVbCFCsIWf
	yG+ju6fJ/0KwTYzwy59rLzLEjkazxPJy5iVg652w6IQTvpXRXktUWApSnzMcAWjT0onqQ3Zucf3ED
	YOM0iOxJcC+C/tlHLBLpaaHameihNHoaNMttrW7DCmnb6oYxv81+BfkMrZvFwbx/LaT6nt9NqTian
	ZY2l7FQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upHI6-00000001FEP-3j5N;
	Fri, 22 Aug 2025 02:14:06 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upC9B-00000000WjQ-27uv
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 20:44:35 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 57LKUEvf1168264
	for <linux-nvme@lists.infradead.org>; Thu, 21 Aug 2025 13:44:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=SpF7gDfNfdb16tfYdO08gdnfGgq/XJWxuudJ21yq/RA=; b=YOPqtQMwVkCo
	DauA3wSxahwIFVEYxMpQM4G+cK5XYqamIaVEjqHPFF2hgaq7gf7oFqAiWreLsiaX
	8cVFrp5KcH3BuFWWZ1a9nuhBZHPs2jf8wNOFptBjRnaH+jjDDbsyxqjvCuNkv2HQ
	FsMZlI/eTRVn0hSTEI/MMyzlENWGEMMP302efNd4shAx6H94lnTuEkfHqhdjE6zy
	zu6JxfnaSJUexkcMOz+78cal3aitn68mkxOuygKKXs6D5FOoQRvrlbsYEwSkdpp0
	ciRHhxMGv1uwG/lmwXoDMWHP9anS/LwmxaHerOOncONpnSZVATVp3VaxEdP15Xxc
	x7qx9wIHvQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 48pagm046j-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 21 Aug 2025 13:44:32 -0700 (PDT)
Received: from twshared17671.07.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 21 Aug 2025 20:44:27 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 36A03DAAF51; Thu, 21 Aug 2025 13:44:23 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/2] nvme: remove virtual boundary for sgl capable devices
Date: Thu, 21 Aug 2025 13:44:20 -0700
Message-ID: <20250821204420.2267923-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250821204420.2267923-1-kbusch@meta.com>
References: <20250821204420.2267923-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=L6VEg+T8 c=1 sm=1 tr=0 ts=68a78530 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=DE5RKVN6jYQ7jVVW-c4A:9
X-Proofpoint-ORIG-GUID: -CubLFZ95X9pIt-lRhTI6QFnkGMC919i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDE3NyBTYWx0ZWRfX6PBsWbrw+shy
 mRc9Gr5R6F9xenKqPw8WTaPdsuAI8iMtWixO0VziArSiCMIv+wJKVkHenpn8AlaoE1djS3mro0k
 k6VJiue6jBVvl7bH/iJqYBqN28sECkAXmbPiwbclsHcLWZJDFcZ2Th2l1H9kNUOS4RN7efM1XtM
 uM+xjjwiJ1mkESIZ6hTajOFKZYmvGJIxf0UFdlnxDIFRPytUq0ECV/8EkjIe/ho6V1j6wcX7yOD
 4L/7tSVSJezr4VfgLytozC1ObSdaHCVm54mzt+4MhoddMig+onIBHTeq1AUP/bsKRe87iUr7M9v
 TgtElWqGjcjesyprrWLFQIZ36tp/WOvX80jtQVMWh4wXusc8yTBxwADBT0reeF3bw3/3Kj88aFO
 1irEVxCYorobCD5Aw3E7dA8n4HisqGGIAxgTpeUp+FeUQMi2NeUJR3SGGu8aXvSktrevB6aE
X-Proofpoint-GUID: -CubLFZ95X9pIt-lRhTI6QFnkGMC919i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_134433_670201_FB7395DA 
X-CRM114-Status: GOOD (  19.62  )
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

The nvme virtual boundary is only required for the PRP format. Devices
that can use SGL for DMA don't need it for IO queues. Drop reporting it
for such PCIe devices; fabrics controllers will continue to use the
limit as they currently don't report any boundary requirements.

Applications may continue to align to the same virtual boundaries for
optimization purposes if they want, and the driver will continue to
decide whether to use the PRP format the same as before if the IO allows
it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 21 ++++++++++++++++-----
 drivers/nvme/host/pci.c  | 16 +++++++++++++---
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 812c1565114fd..cce1fbf2becd8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2065,13 +2065,24 @@ static u32 nvme_max_drv_segments(struct nvme_ctrl=
 *ctrl)
 }
=20
 static void nvme_set_ctrl_limits(struct nvme_ctrl *ctrl,
-		struct queue_limits *lim)
+		struct queue_limits *lim, bool admin)
 {
 	lim->max_hw_sectors =3D ctrl->max_hw_sectors;
 	lim->max_segments =3D min_t(u32, USHRT_MAX,
 		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments));
 	lim->max_integrity_segments =3D ctrl->max_integrity_segments;
-	lim->virt_boundary_mask =3D NVME_CTRL_PAGE_SIZE - 1;
+
+	/*
+	 * The virtual boundary mask is not necessary for PCI controllers that
+	 * support SGL for DMA. It's only necessary when using PRP. Admin
+	 * queues only support PRP, and fabrics drivers currently don't report
+	 * what boundaries they require, so set the virtual boundary for
+	 * either.
+	 */
+	if (!nvme_ctrl_sgl_supported(ctrl) || admin ||
+	    ctrl->ops->flags & NVME_F_FABRICS)
+		lim->virt_boundary_mask =3D NVME_CTRL_PAGE_SIZE - 1;
+
 	lim->max_segment_size =3D UINT_MAX;
 	lim->dma_alignment =3D 3;
 }
@@ -2173,7 +2184,7 @@ static int nvme_update_ns_info_generic(struct nvme_=
ns *ns,
 	int ret;
=20
 	lim =3D queue_limits_start_update(ns->disk->queue);
-	nvme_set_ctrl_limits(ns->ctrl, &lim);
+	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
=20
 	memflags =3D blk_mq_freeze_queue(ns->disk->queue);
 	ret =3D queue_limits_commit_update(ns->disk->queue, &lim);
@@ -2377,7 +2388,7 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
 	ns->head->lba_shift =3D id->lbaf[lbaf].ds;
 	ns->head->nuse =3D le64_to_cpu(id->nuse);
 	capacity =3D nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
-	nvme_set_ctrl_limits(ns->ctrl, &lim);
+	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
 	nvme_set_chunk_sectors(ns, id, &lim);
 	if (!nvme_update_disk_info(ns, id, &lim))
@@ -3580,7 +3591,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctr=
l)
 		min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
=20
 	lim =3D queue_limits_start_update(ctrl->admin_q);
-	nvme_set_ctrl_limits(ctrl, &lim);
+	nvme_set_ctrl_limits(ctrl, &lim, true);
 	ret =3D queue_limits_commit_update(ctrl->admin_q, &lim);
 	if (ret)
 		goto out_free;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d8a9dee55de33..6e848aa4531b6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -619,9 +619,19 @@ static inline enum nvme_use_sgl nvme_pci_use_sgls(st=
ruct nvme_dev *dev,
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
=20
 	if (nvmeq->qid && nvme_ctrl_sgl_supported(&dev->ctrl)) {
-		if (nvme_req(req)->flags & NVME_REQ_USERCMD)
-			return SGL_FORCED;
-		if (req->nr_integrity_segments > 1)
+		/*
+		 * A request with page gaps within the controller's mask can
+		 * not use the PRP format.
+		 *
+		 * We force user commands to use SGL because that lets the
+		 * device validate the requested transfer lengths.
+		 *
+		 * Multiple integrity segments must use SGL as that's the only
+		 * way to describe such a command.
+		 */
+		if (req->page_gap & (NVME_CTRL_PAGE_SIZE - 1) ||
+		    nvme_req(req)->flags & NVME_REQ_USERCMD ||
+		    req->nr_integrity_segments > 1)
 			return SGL_FORCED;
 		return SGL_SUPPORTED;
 	}
--=20
2.47.3


