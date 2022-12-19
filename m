Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F9AC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Dec 2022 21:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yv3uGZG51BxoKHJuxLQsy+MkPevhk5o7x0F52dyjCWk=; b=iYr4urnvJm6Op80QphiRz3qC+x
	FwdAPEA1/RMGcbp8OQbCGjDWoD3nNoiqJunTksa6eS1btua91Sd0uq7N30nbihw03YLUS2OFQXBNt
	8QDAitytNOeiQ2K8vMraVzmp9ID/+2oBTU8Gxa5bF/6S2scpCpTwtRm5Ff6kPu1MJHpn2tFXJ6A6h
	DgWtttjNMXMC/gkGiLFgnyu0f9ywXMIsLIHkMyCadKFVQU1q3HpkfR2zMDT4eRfEsgVKjZ13lPyRm
	BRqEIEHjZO4xfTHjSAomM3lpVinIW6a2z0/uMQXduHZtX97pvoON1pfkQ1CuCY+jJrukWjjDJI3X2
	8pyl1BIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7O6i-0049oa-RE; Mon, 19 Dec 2022 21:55:36 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7O6K-0049cf-Cu
	for linux-nvme@lists.infradead.org; Mon, 19 Dec 2022 21:55:15 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJLHENX021902
	for <linux-nvme@lists.infradead.org>; Mon, 19 Dec 2022 13:55:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=yv3uGZG51BxoKHJuxLQsy+MkPevhk5o7x0F52dyjCWk=;
 b=cBrljh9sSl/+8Vy8zTBfrLcLVkHxNXwNSMbSRrhJGWxEjVOHfDAfW92gc316MjP7cR7t
 UoBmjD0ekPfeYA7aEcoUWBwtpAecgyreaiRP+7qq6ELot1nv5G/S+KGVpH6QTOcdI3DM
 pGP2UEIgoiNMCFlwmFhYx3C5U6RTr+kFIxYJavsITSTEWpw3myFlPprp3kU7SN2NJZaB
 mxOwlbMV/D2H9NZHq7FHTObG+AjiDHF9YjQvyzkD6oLqTsdVg1aqaiOntlHrNC7L7SnO
 ywPuWZ0Kspl72hN6J02XDstVSrEgORHgHv+ENAAdkzH6iaNqEfGFdzSlkXyoNPxlWgFJ 1Q== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mhcd41w04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 19 Dec 2022 13:55:11 -0800
Received: from twshared0551.06.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 13:55:10 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 75A65D333B81; Mon, 19 Dec 2022 13:54:58 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/3] nvme-pci: use mapped entries for sgl decision
Date: Mon, 19 Dec 2022 13:54:57 -0800
Message-ID: <20221219215457.711617-3-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221219215457.711617-1-kbusch@meta.com>
References: <20221219215457.711617-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: xZLirmpcOFq1fsbY8hHOvTVyXU0Aj3rI
X-Proofpoint-ORIG-GUID: xZLirmpcOFq1fsbY8hHOvTVyXU0Aj3rI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221219_135512_646286_8AD66C93 
X-CRM114-Status: GOOD (  15.53  )
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

The driver uses the dma entries for setting up its command's SGL/PRP
lists. The dma mapping might have fewer entries than the virtual
segments, so check the dma mapped count to determine which nvme data
layout method is more optimal.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 07c967f563788..578f384025440 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -514,10 +514,10 @@ static void **nvme_pci_iod_list(struct request *req=
)
 	return (void **)(iod->sgt.sgl + blk_rq_nr_phys_segments(req));
 }
=20
-static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct reques=
t *req)
+static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct reques=
t *req,
+				     int nseg)
 {
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
-	int nseg =3D blk_rq_nr_phys_segments(req);
 	unsigned int avg_seg_size;
=20
 	avg_seg_size =3D DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
@@ -817,7 +817,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *de=
v, struct request *req,
 		goto out_free_sg;
 	}
=20
-	iod->use_sgl =3D nvme_pci_use_sgls(dev, req);
+	iod->use_sgl =3D nvme_pci_use_sgls(dev, req, iod->sgt.nents);
 	if (iod->use_sgl)
 		ret =3D nvme_pci_setup_sgls(dev, req, &cmnd->rw);
 	else
--=20
2.30.2


