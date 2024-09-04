Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EB2CD4847
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 18:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sKC/Bpu083bG/QfzDONU+Lfh1qWj4RlpPpleg4qm+zE=; b=hwCyJdFlGU1kJqPKTZGARe/bMS
	OMR+bPphOlLLFMTPQ4utQtFYO8II6fveFiCpmWCDX5uT6FQCjFEEFhpQOLpVTtGejAE/zOyYoW8wj
	7bWZxuZdei6xHS8473w1Zuw+jfeEdlAIothcRrNFCoxbDXKrBqyNF38bDCv5WQnixtvjKkGI+laGS
	Izwg5cQeYF6vtea54vlFzj2CLt/BVvqFRssqnT8K6j5czs7HQW6qWHyoefSSTSPGO/5BtuPAW5esU
	rBWTbYq3gCvYoVNiZgtChQv7lSw31UmEo2KqagUMiVF3qvMr19nDgit+MjIhDqyB/Y53ecxTLCVEL
	RdhMuFDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slutu-00000005dYU-2cee;
	Wed, 04 Sep 2024 18:38:42 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slutp-00000005dTq-3sta
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 18:38:39 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484FdGWq022481
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 11:38:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=sKC/Bpu083bG/QfzDONU+Lfh1qWj4RlpPpleg4qm+zE=; b=
	iHHt5GIxK3EUn/JzXNPWVMOU/LnCrD2XvWJqkGnA8LI6ZX0vSsLN5qeeY68Tgx5+
	6nYPUXrn7BS76mH8krb65iUZS/xAJiLLKTyw9GvqjrW3TxNkHH8tSt1RaEfxWug1
	LWrnR1oYOBiOyHNuQ7VogW7PyHxVjfMqxLLpMWti2eB9E13i6YIWwlwhfDkclfaf
	3iV/Ove2+eubw1tXVXAMbwF7RFr8tyeZdg17/7uFjYFClFk0QHPnLGchTlFNBkD4
	WzovEDIKC4t8fHgEcMPpHOyynNSJ0+/XlSUAkM9mur5SfI1z7Hj0+OYaJgx7Awa1
	TtTMFC3DMMFX+YlH0y/2Vw==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41eh7v4brk-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 11:38:37 -0700 (PDT)
Received: from twshared9929.07.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 18:38:30 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 8B41F12A1F095; Wed,  4 Sep 2024 11:38:19 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH-part-2 1/9] nvme-pci: use sgl capable helper function
Date: Wed, 4 Sep 2024 11:38:09 -0700
Message-ID: <20240904183818.713941-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904183818.713941-1-kbusch@meta.com>
References: <20240904183818.713941-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: s2YLPtvxQTBcatfplj0GWDRlW6Es0oiY
X-Proofpoint-GUID: s2YLPtvxQTBcatfplj0GWDRlW6Es0oiY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_113838_026040_C9E45BCE 
X-CRM114-Status: GOOD (  13.47  )
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

This check is done twice, and is complex enough, so introduce a helper
function and use it from both places.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6cd9395ba9ec3..21f6aeb236a6f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -504,21 +504,28 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *h=
ctx)
 	spin_unlock(&nvmeq->sq_lock);
 }
=20
-static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct reques=
t *req,
-				     int nseg)
+static inline bool nvme_pci_sgl_capable(struct nvme_dev *dev,
+					struct request *req)
 {
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
-	unsigned int avg_seg_size;
-
-	avg_seg_size =3D DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
=20
 	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
 		return false;
 	if (!nvmeq->qid)
 		return false;
-	if (!sgl_threshold || avg_seg_size < sgl_threshold)
+	return sgl_threshold;
+}
+
+static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct reques=
t *req,
+				     int nseg)
+{
+	unsigned int avg_seg_size;
+
+	avg_seg_size =3D DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
+
+	if (!nvme_pci_sgl_capable(dev, req))
 		return false;
-	return true;
+	return avg_seg_size >=3D sgl_threshold;
 }
=20
 static void nvme_free_prps(struct nvme_dev *dev, struct request *req)
@@ -774,7 +781,6 @@ static blk_status_t nvme_map_data(struct nvme_dev *de=
v, struct request *req,
 	int rc;
=20
 	if (blk_rq_nr_phys_segments(req) =3D=3D 1) {
-		struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
 		struct bio_vec bv =3D req_bvec(req);
=20
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
@@ -783,8 +789,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *de=
v, struct request *req,
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
=20
-			if (nvmeq->qid && sgl_threshold &&
-			    nvme_ctrl_sgl_supported(&dev->ctrl))
+			if (nvme_pci_sgl_capable(dev, req))
 				return nvme_setup_sgl_simple(dev, req,
 							     &cmnd->rw, &bv);
 		}
--=20
2.43.5


