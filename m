Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9335EC04A68
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JKxikQUf9RswcBeosByLcjDHf9Z7f7Y7Y8nIxyAhlkw=; b=Kw1eexbBZsqVgOumbXo4y6hW0c
	9rWHNwr6B4/mLWQ/dcJtLwXRVhgpyI7pMl8Tf9sbBwpLGJEj2KUS7IDWEfVREsYD6Zr33NGtFYwWR
	mDDak5XMhY7wi98c/CDyib6ppRd5nuYL4e7pDxgNOzSML1M5G0P/ZrhEoUBvO3IIO8VuZ+o/nNmbW
	3f8+X8Ax8VoVXlnRkT89mhFqncWwwXe941JReAFhXmQ87vFRTwH+60NiB6YQdpZHr0O2DamhyyN9C
	7/wKGX3Qn1TcwX0TipitItQc9um6+NGEFsDvqNQIM2jzsBqPo1e+alRtR3yKWAnb5B16i9WxmNyA/
	j5WpO4+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHSrs-006Nyj-1S; Fri, 29 Jul 2022 16:29:40 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHSrP-006NZ9-DI
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 16:29:13 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26T5HapS006950
	for <linux-nvme@lists.infradead.org>; Fri, 29 Jul 2022 09:29:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=JKxikQUf9RswcBeosByLcjDHf9Z7f7Y7Y8nIxyAhlkw=;
 b=MWXgmMu2nztRRMphAqH7SE3SefdkUZPiPxNEvLmycfEF3Vn1NoU7xwXSDzcYdGcxMAKa
 JR8Y6bUzzII6zifJWPK8svcs2TU7UAnLjLwUplGpxI6kmlXWru8lNnOtAbOKI08R8MD0
 SUwIupIJGyl+F2p7DPRKgGp8+oK/rSUyiBk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hkfskcja6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 29 Jul 2022 09:29:06 -0700
Received: from twshared34609.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 29 Jul 2022 09:29:04 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id AF2CC6BA33DA; Fri, 29 Jul 2022 09:28:52 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/5] nvme-pci: remove nvme_queue from nvme_iod
Date: Fri, 29 Jul 2022 09:28:47 -0700
Message-ID: <20220729162851.1574210-2-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220729162851.1574210-1-kbusch@fb.com>
References: <20220729162851.1574210-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: buNJPjYEUlqpUIpBkF9MHbBdNct8E8AS
X-Proofpoint-ORIG-GUID: buNJPjYEUlqpUIpBkF9MHbBdNct8E8AS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_17,2022-07-28_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_092911_509753_F9F5D914 
X-CRM114-Status: GOOD (  18.19  )
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

We can get the nvme_queue from the req just as easily, so remove the
duplicate path to the same structure to save some space.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 644664098ae7..138d408f7306 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -226,7 +226,6 @@ struct nvme_queue {
 struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_command cmd;
-	struct nvme_queue *nvmeq;
 	bool use_sgl;
 	int aborted;
 	int npages;		/* In the PRP list. 0 means small pool in use */
@@ -431,11 +430,6 @@ static int nvme_pci_init_request(struct blk_mq_tag_s=
et *set,
 {
 	struct nvme_dev *dev =3D set->driver_data;
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
-	int queue_idx =3D (set =3D=3D &dev->tagset) ? hctx_idx + 1 : 0;
-	struct nvme_queue *nvmeq =3D &dev->queues[queue_idx];
-
-	BUG_ON(!nvmeq);
-	iod->nvmeq =3D nvmeq;
=20
 	nvme_req(req)->ctrl =3D &dev->ctrl;
 	nvme_req(req)->cmd =3D &iod->cmd;
@@ -529,7 +523,7 @@ static void **nvme_pci_iod_list(struct request *req)
=20
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct reques=
t *req)
 {
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
 	int nseg =3D blk_rq_nr_phys_segments(req);
 	unsigned int avg_seg_size;
=20
@@ -537,7 +531,7 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev =
*dev, struct request *req)
=20
 	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
 		return false;
-	if (!iod->nvmeq->qid)
+	if (!nvmeq->qid)
 		return false;
 	if (!sgl_threshold || avg_seg_size < sgl_threshold)
 		return false;
@@ -843,6 +837,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *de=
v, struct request *req,
 	int nr_mapped;
=20
 	if (blk_rq_nr_phys_segments(req) =3D=3D 1) {
+		struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
 		struct bio_vec bv =3D req_bvec(req);
=20
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
@@ -850,7 +845,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *de=
v, struct request *req,
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
=20
-			if (iod->nvmeq->qid && sgl_threshold &&
+			if (nvmeq->qid && sgl_threshold &&
 			    nvme_ctrl_sgl_supported(&dev->ctrl))
 				return nvme_setup_sgl_simple(dev, req,
 							     &cmnd->rw, &bv);
@@ -1030,12 +1025,16 @@ static void nvme_queue_rqs(struct request **rqlis=
t)
=20
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
-	struct nvme_dev *dev =3D iod->nvmeq->dev;
+	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
+	struct nvme_dev *dev =3D nvmeq->dev;
+
+	if (blk_integrity_rq(req)) {
+	        struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
=20
-	if (blk_integrity_rq(req))
 		dma_unmap_page(dev->dev, iod->meta_dma,
 			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
+	}
+
 	if (blk_rq_nr_phys_segments(req))
 		nvme_unmap_data(dev, req);
 }
@@ -1283,8 +1282,7 @@ static int adapter_delete_sq(struct nvme_dev *dev, =
u16 sqid)
=20
 static void abort_endio(struct request *req, blk_status_t error)
 {
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq =3D iod->nvmeq;
+	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
=20
 	dev_warn(nvmeq->dev->ctrl.device,
 		 "Abort status: 0x%x", nvme_req(req)->status);
@@ -1346,7 +1344,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u=
32 csts)
 static enum blk_eh_timer_return nvme_timeout(struct request *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq =3D iod->nvmeq;
+	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
 	struct nvme_dev *dev =3D nvmeq->dev;
 	struct request *abort_req;
 	struct nvme_command cmd =3D { };
--=20
2.30.2


