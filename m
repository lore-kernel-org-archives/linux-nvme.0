Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3390DC87FCB
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Aug 2025 19:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YsTdp/ELGFJx26BYUKvLE4dF3FI9RFqtfczhWgl4Q5c=; b=SYWROt72ue0+XL33tdT5ivJMTh
	8B0ztsXYW7XuA+xc+8SPWE0MTL7J5PU4otGLIRHxs+p9HSDQlWKl+0auMGi0N0HffttmlUXIaSUkg
	7WvQLqE5jMMcgnZ8WbFCtB2QJBSwEmjg4AcMIYxU+pFEOLxbzqR6jDCafboZo2w0WZZRJWtYbhA+a
	2exrJMiHvEO21LnF4GPO8pf2Q3+GjNahZOdt+zzEwo8TmuO6LSP6Z1DBQshJi/kgBYmlHAua0aZsD
	773NqSwAu+n7vavdJrGc8C+OPQLASj55pR0vPwNeovEaZ0136zz4trA82QlLxJwZU7Qh4Q/xAVK4Q
	p4SvsSYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujNoM-0000000DiWt-3cOg;
	Tue, 05 Aug 2025 19:59:02 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujNoG-0000000DiW2-2xM4
	for linux-nvme@lists.infradead.org;
	Tue, 05 Aug 2025 19:58:57 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575Jn8fb006815
	for <linux-nvme@lists.infradead.org>; Tue, 5 Aug 2025 12:58:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=YsTdp/ELGFJx26BYUKvLE4dF3FI9RFqtfczhWgl4Q5c=; b=dV1666bHLNXg
	scXSo7qLa791Jx+j/6YSwhcyEvWh6mwrXn57yaRriD8DWNnPGzxzLbLBwDBUcIiD
	TuiqnQgYe8yM4eC9qCdt4Pnhs9g4EGlyJL0idvN6ccAlnAcwe84S387ToOVralBv
	MMegjFxQ5J7ExmecaUgmQV3a+2+opHd53BtHuTCzfd3SnJro3Mee9QvOiWfU+3eD
	++D6RfHmbSzQ9HpXEZ5qbjKF7K+9rTN65/CPPQF+LzVZzPq41Acr1483GssPNRBB
	geICjoA5HsoVB7jZiV+omSN75yhA0nAntcL3NXYE8vIKdmzPj+5j2g4s120iOj6n
	x1XzOicmqg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48bpwds73a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 05 Aug 2025 12:58:55 -0700 (PDT)
Received: from twshared0973.10.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 5 Aug 2025 19:58:53 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 279D1531300; Tue,  5 Aug 2025 12:56:09 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme: remove virtual boundary for sgl capable devices
Date: Tue, 5 Aug 2025 12:56:08 -0700
Message-ID: <20250805195608.2379107-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250805195608.2379107-1-kbusch@meta.com>
References: <20250805195608.2379107-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDE0MSBTYWx0ZWRfX9gD0XCJcqqKu 46mijq05SvstIH2sd7M5+fVQPXPsBJE/21CG1J5CEHIdjqNcM7vpQdAhwqrw/MU2TMid4N9AqYA fEBIPqVMvqknCMnlXseRh2enxKhycN5oiCI7+Ahga7qBBKBa6KWSv2qLrvLXrMEh/XsAdCpJzSN
 oTpXLkz+jigzv0kDqEgRhOyZbz0WyQxFQb9sZ2VplbfpSXFSaxp8fwRal866gRgAvkO6x8Wk4B1 iuPyHTUu5Knw+Ucr0KfL06W8UUALtYWtJxI2uPfqVQFc/3MHQ0OL3d6KALktebseZotzre7vldM eenSNVY8XpkwV6VSvnJj/5zYezgRVSCMTgyIcGYHe5vdF6PWen8LLyX4ETpxqn6/4ti+knJJ4wo
 krZDB0p/reGcoSRjKqnG5V7x3WbMRaQptq7P8gcveBiZwiekgBN1Y8GU08Hsm7NuG9Qnky5H
X-Proofpoint-GUID: 67ntCNRtfIc0mHPOxwii-DTswQLV5tuj
X-Proofpoint-ORIG-GUID: 67ntCNRtfIc0mHPOxwii-DTswQLV5tuj
X-Authority-Analysis: v=2.4 cv=edI9f6EH c=1 sm=1 tr=0 ts=6892627f cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=fOxSldyNN8qU9nhN34UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_125856_761111_98D2C466 
X-CRM114-Status: GOOD (  16.85  )
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

The nvme virtual boundary is only for the PRP format. Devices that can
use the SGL format don't need it for IO queues. Drop reporting it for
such PCIe devices; fabrics target will continue to use the limit.

Applications can still continue to align to it, and the driver can still
decide to use the PRP format if the IO allows it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 14 +++++++++-----
 drivers/nvme/host/pci.c  |  2 ++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 812c1565114fd..c012c209c7670 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2065,13 +2065,17 @@ static u32 nvme_max_drv_segments(struct nvme_ctrl=
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
+	if (!nvme_ctrl_sgl_supported(ctrl) || admin ||
+	    ctrl->ops->flags & NVME_F_FABRICS)
+		lim->virt_boundary_mask =3D NVME_CTRL_PAGE_SIZE - 1;
+	else
+		lim->virt_boundary_mask =3D 0;
 	lim->max_segment_size =3D UINT_MAX;
 	lim->dma_alignment =3D 3;
 }
@@ -2173,7 +2177,7 @@ static int nvme_update_ns_info_generic(struct nvme_=
ns *ns,
 	int ret;
=20
 	lim =3D queue_limits_start_update(ns->disk->queue);
-	nvme_set_ctrl_limits(ns->ctrl, &lim);
+	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
=20
 	memflags =3D blk_mq_freeze_queue(ns->disk->queue);
 	ret =3D queue_limits_commit_update(ns->disk->queue, &lim);
@@ -2377,7 +2381,7 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
 	ns->head->lba_shift =3D id->lbaf[lbaf].ds;
 	ns->head->nuse =3D le64_to_cpu(id->nuse);
 	capacity =3D nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
-	nvme_set_ctrl_limits(ns->ctrl, &lim);
+	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
 	nvme_set_chunk_sectors(ns, id, &lim);
 	if (!nvme_update_disk_info(ns, id, &lim))
@@ -3580,7 +3584,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctr=
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
index 4a23729f399ac..ec9eb158b43d7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -623,6 +623,8 @@ static inline enum nvme_use_sgl nvme_pci_use_sgls(str=
uct nvme_dev *dev,
 			return SGL_FORCED;
 		if (req->nr_integrity_segments > 1)
 			return SGL_FORCED;
+		if (blk_rq_page_gaps(req) & (NVME_CTRL_PAGE_SIZE - 1))
+			return SGL_FORCED;
 		return SGL_SUPPORTED;
 	}
=20
--=20
2.47.3


