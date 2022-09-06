Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D22ECAAD5
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LmEpesDw6VfvTL6Rijs7lGJjL/lx5Sn5e8KT++b2MrM=; b=qv/OjvEfCkY7UBLtK9pTcBdFco
	0NWfcoX3WKVY8nXsaTgOmSPiuPaIF+q6LY7XX8bwXBSK8WMXLymuI5kmWlhYq/afrdDxRez/bWxWO
	oSKV96oH0UJUDI55aGRWPWtMx90zAcaVSSD1T9/DO+019gP6vl9Kc6QM2cqC6QxzVG8LNfT+HTNkW
	kTfPPMZrIrob8mPY7LsjZ3Ve1mwvZ8aggmxtKeYkC6out6/fMW4OBxU5Q4HjA4yiMIng7AAtmdRS6
	vFbfniySEf1YSJ9wbbd950x1d306r/+SrvzNMlJ2q7K2tiFPv3fm/OyIzYa6rd7tdx70StwIpIaU+
	tj59eubA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVbNv-00FNx7-A4; Tue, 06 Sep 2022 16:25:11 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVb7C-00FCin-29
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 16:07:57 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286F3WHx008831
	for <linux-nvme@lists.infradead.org>; Tue, 6 Sep 2022 09:07:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LmEpesDw6VfvTL6Rijs7lGJjL/lx5Sn5e8KT++b2MrM=;
 b=pYrkcji5atrTdkzVN/lAYy4MEi5RVnmhn6m0W9U1k9Oi1bJCIElsCVPZl3lFU9KIayZ0
 4wa+CTsyGaUhxRA3NilIZTCS2OCZX+UrXvFtElTi7vpG5ooEFC29NPzcf5t2UUAsHihl
 QNv8bQiM+w+KWLPWDDBlytU82blqTqeByOs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jc4ruybf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 06 Sep 2022 09:07:49 -0700
Received: from twshared11415.03.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 09:07:48 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id DF2B1847D5B9; Tue,  6 Sep 2022 09:07:42 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/4] nvme-pci: remove nvme_queue from nvme_iod
Date: Tue, 6 Sep 2022 09:07:35 -0700
Message-ID: <20220906160738.2289621-2-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220906160738.2289621-1-kbusch@fb.com>
References: <20220906160738.2289621-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: p4VXPraa5u_wE9-9d90SRwZiIB3-Dhfg
X-Proofpoint-ORIG-GUID: p4VXPraa5u_wE9-9d90SRwZiIB3-Dhfg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_090755_206735_DB5DF50D 
X-CRM114-Status: GOOD (  18.87  )
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
index 4a8cfb360d31..403876ad3234 100644
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
@@ -430,11 +429,6 @@ static int nvme_pci_init_request(struct blk_mq_tag_s=
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
@@ -526,7 +520,7 @@ static void **nvme_pci_iod_list(struct request *req)
=20
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct reques=
t *req)
 {
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
 	int nseg =3D blk_rq_nr_phys_segments(req);
 	unsigned int avg_seg_size;
=20
@@ -534,7 +528,7 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev =
*dev, struct request *req)
=20
 	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
 		return false;
-	if (!iod->nvmeq->qid)
+	if (!nvmeq->qid)
 		return false;
 	if (!sgl_threshold || avg_seg_size < sgl_threshold)
 		return false;
@@ -831,6 +825,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *de=
v, struct request *req,
 	int rc;
=20
 	if (blk_rq_nr_phys_segments(req) =3D=3D 1) {
+		struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
 		struct bio_vec bv =3D req_bvec(req);
=20
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
@@ -838,7 +833,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *de=
v, struct request *req,
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
=20
-			if (iod->nvmeq->qid && sgl_threshold &&
+			if (nvmeq->qid && sgl_threshold &&
 			    nvme_ctrl_sgl_supported(&dev->ctrl))
 				return nvme_setup_sgl_simple(dev, req,
 							     &cmnd->rw, &bv);
@@ -1017,12 +1012,16 @@ static void nvme_queue_rqs(struct request **rqlis=
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
@@ -1270,8 +1269,7 @@ static int adapter_delete_sq(struct nvme_dev *dev, =
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
@@ -1333,7 +1331,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u=
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


