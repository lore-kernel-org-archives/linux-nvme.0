Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B34CD4F24
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1qQvKQPTsZ/4jV6rNtO2asaIfYN6RZeYlB4XS7cfF+o=; b=a3R2ErY25sA/+nHn5ATnpqHiEl
	66OMgtwEsV0Fyxmh4dzqIbtZiJdl6G8Jt5Yx+bL162lwkAw2WM4ESEmOjMXuBC4XrLGFRbYOX4R4q
	6LAcIIMpkogJQG6S0EMtH5V7CjFR1Ba6fxm5pAXiLf1RfsbyN1hvDwXmtwwR7l8Cnm3w2cTuZmVyc
	qRlLyHwXqjGE4zP07FG7gGackZcMn/EWpJaeKQB+1DGSA3nsrRTBlPWLMjYdVzyun78E1iQ802amG
	AwgNhE6I9T1EHMpouoQVsfDYCHru0iNeS4aQwd5FxTfro2kxWXARaFcx0/vlp5V0B4LhTUboNvopQ
	ovyKAn8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slutm-00000005dQy-0Cr9;
	Wed, 04 Sep 2024 18:38:34 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sluti-00000005dN7-1qyl
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 18:38:32 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484GYPoP025595
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 11:38:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=1qQvKQPTsZ/4jV6rNtO2asaIfYN6RZeYlB4XS7cfF+o=; b=
	fOJiuIrIqDT++0zkjOneQSI09H/adQxnC1Cb3wyrrdcr2Gry2Wqpl5SyWaeusnjA
	gliQjuc8iYpCs5zBD6tmeucylyDoj2iRGl6dH1nwcYtlyEz1TGYLuli8EdQI4iPA
	d7bR7eWRkx4WkSfnrjkgFAcAw6gUeVKoQooUNRcwpAjKMqoRizXK+ZWapolneaHX
	9H+1YFSSqInSbAPTZVJMGteQI+bJKE0OKWK32Y4115suJTvlGSfFlFs9zhnhQkvQ
	UijimF0pZ1pHLIBRyGociCQGvA40W9glM6v7lqPZXirmuBiyVntlAhTW0r2ivZiI
	WIqn1W470wyVgzNkYnzEtQ==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41eu6d0x8a-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 11:38:28 -0700 (PDT)
Received: from twshared39016.07.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 18:38:26 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id DDCD912A1F0A4; Wed,  4 Sep 2024 11:38:19 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH-part-2 9/9] nvme: force sgls on user passthrough if possible
Date: Wed, 4 Sep 2024 11:38:17 -0700
Message-ID: <20240904183818.713941-10-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904183818.713941-1-kbusch@meta.com>
References: <20240904183818.713941-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: GKeDL8-5EEJFpAzFoy_hwabu4oZiXkLY
X-Proofpoint-ORIG-GUID: GKeDL8-5EEJFpAzFoy_hwabu4oZiXkLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_113830_683512_78F707E9 
X-CRM114-Status: GOOD (  17.88  )
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

With capable hardware, this is one way to guard against short buffers.
The consequences of getting the interface wrong can cause corruption and
crash kernels, and utilizing the mptr sgl feature leverages the protocol
to catch such incorrect usage. See CVE-2023-6238.

To emphasize the danger with using this interface, the kernel will be
tainted if the user accesses this interface without hardware capable of
guaranteeing transfer lengths.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 17 +++++++++++++++++
 drivers/nvme/host/nvme.h  |  2 ++
 drivers/nvme/host/pci.c   | 20 ++++++++++++++------
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index f1d58e70933f5..cf889a0e79338 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -116,12 +116,22 @@ static int nvme_map_user_request(struct request *re=
q, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, struct io_uring_cmd *ioucmd, unsigned int flags)
 {
+	struct nvme_ctrl *ctrl =3D nvme_req(req)->ctrl;
 	struct request_queue *q =3D req->q;
 	struct nvme_ns *ns =3D q->queuedata;
 	struct block_device *bdev =3D ns ? ns->disk->part0 : NULL;
 	struct bio *bio =3D NULL;
 	int ret;
=20
+	if (bdev) {
+		if (nvme_ctrl_sgl_supported(ctrl)) {
+			nvme_req(req)->flags |=3D NVME_REQ_USE_SGLS;
+		} else {
+			dev_warn_once(ctrl->device, "using unchecked buffer\n");
+			add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+		}
+	}
+
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
=20
@@ -146,6 +156,13 @@ static int nvme_map_user_request(struct request *req=
, u64 ubuffer,
 	if (bdev) {
 		bio_set_dev(bio, bdev);
 		if (meta_buffer && meta_len) {
+			if (nvme_ctrl_meta_sgl_supported(ctrl)) {
+				nvme_req(req)->flags |=3D NVME_REQ_USE_META_SGLS;
+			} else {
+				dev_warn_once(ctrl->device,
+					      "using unchecked meta buffer\n");
+				add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+			}
 			ret =3D bio_integrity_map_user(bio, meta_buffer, meta_len,
 						     meta_seed);
 			if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 699cc36e596fa..3c27486acecdc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -197,6 +197,8 @@ enum {
 	NVME_REQ_USERCMD		=3D (1 << 1),
 	NVME_MPATH_IO_STATS		=3D (1 << 2),
 	NVME_MPATH_CNT_ACTIVE		=3D (1 << 3),
+	NVME_REQ_USE_SGLS		=3D (1 << 4),
+	NVME_REQ_USE_META_SGLS		=3D (1 << 5),
 };
=20
 static inline struct nvme_request *nvme_req(struct request *req)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a0a10451d7da8..eb2ac47f2bd54 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -522,7 +522,8 @@ static inline bool nvme_pci_sgl_capable(struct nvme_d=
ev *dev,
=20
 static inline bool nvme_pci_metadata_use_sgls(struct request *req)
 {
-	return blk_rq_integrity_segments(req) > 1;
+	return blk_rq_integrity_segments(req) > 1 ||
+		nvme_req(req)->flags & NVME_REQ_USE_META_SGLS;
 }
=20
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct reques=
t *req,
@@ -536,13 +537,20 @@ static inline bool nvme_pci_use_sgls(struct nvme_de=
v *dev, struct request *req,
 		return false;
 	if (nvme_pci_metadata_use_sgls(req))
 		return true;
-	return avg_seg_size >=3D sgl_threshold;
+	if (avg_seg_size < sgl_threshold)
+		return nvme_req(req)->flags & NVME_REQ_USE_SGLS;
+	return true;
 }
=20
-static inline bool nvme_pci_use_prps(struct bio_vec *bv)
+static inline bool nvme_pci_use_prps(struct request *req, struct bio_vec=
 *bv)
 {
-	unsigned int off =3D bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
-	return  off + bv->bv_len <=3D NVME_CTRL_PAGE_SIZE * 2;
+	unsigned int off;
+
+	if (nvme_pci_metadata_use_sgls(req))
+		return false;
+
+	off =3D bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
+	return off + bv->bv_len <=3D NVME_CTRL_PAGE_SIZE * 2;
 }
=20
 static void nvme_free_prps(struct nvme_dev *dev, struct request *req)
@@ -835,7 +843,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *de=
v, struct request *req)
 		struct bio_vec bv =3D req_bvec(req);
=20
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (nvme_pci_use_prps(&bv))
+			if (nvme_pci_use_prps(req, &bv))
 				return nvme_setup_prp_simple(dev, req, &bv);
 			if (nvme_pci_sgl_capable(dev, req))
 				return nvme_setup_sgl_simple(dev, req, &bv);
--=20
2.43.5


