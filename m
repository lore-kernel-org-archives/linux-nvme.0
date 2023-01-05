Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663AAC3DA7A
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Jan 2023 23:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lz8emp/RS1/APVCdAB305QHkRZMBa9uQReaPUwKsNls=; b=gBWRLX89UQfCBt3Now4X9HSvxJ
	jac0+ewUmp5C7yZp7F9zXvdltzS9w36kgzfI2y7OXuIxRy035+NLvfG9PktVUKW3QbYae8gAfEzDB
	A9l5yEv0Qo5URDJnFsCsNu5H+9bwPVJbdsbfWTF+gOofNVmf6MKPRAMUrr2AqI9jB/ZPlDWWxixHY
	Uh33C5cOjmiiA2AqZe0Gx1zegjCzObEpi0vHlEkPab009qJzoGYRYj6HJfDmOJjA0ukBJWmLz2wXR
	E1NRKrqGwaiHMaBoIiJlMeg0BLMSD5lzpSwUo7DWUCBIMxNEPPX+Guv9DmKEel1osIISo24F90U8+
	m8C5C1pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDZXk-00G53R-N6; Thu, 05 Jan 2023 23:21:04 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDWr3-00EYN1-Cu
	for linux-nvme@lists.infradead.org; Thu, 05 Jan 2023 20:28:52 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305HtFsF011951
	for <linux-nvme@lists.infradead.org>; Thu, 5 Jan 2023 12:28:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=Lz8emp/RS1/APVCdAB305QHkRZMBa9uQReaPUwKsNls=;
 b=l+FB/T5Maulxex2h63wdXFyaCM2RZEHIVkkbiRabUx+G/KNfqrJ4xvOB0KIFiu6INCNF
 mit0sM6RyToVezhcxNgg+BtjXev/RMF+GQS8XXxCiR9/ugrvo5KU4KRLnZ/jCD3rKtbx
 G56TzVXKcFDt093KL007Gpl1THGXQV8tRSC/prPKAsnXh6mC5T9MvKLKwahM5wmhcuED
 W1wHiDYO7ppBPl0mvuUG380pn/VFP4Qma+y6gvUCB5Qa8dGxz2RKk5HHqtEmIaKNPq5n
 YLTRBH3SZH19FF18ClV3KSEp+G0MR1Ls9J+MhQxWT/RZaWl8a4P0di/7GRrlmn1X62KW dw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mwnjyn8b5-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Jan 2023 12:28:47 -0800
Received: from twshared41876.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 5 Jan 2023 12:28:42 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 3FBDAE457D7D; Thu,  5 Jan 2023 12:28:35 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/4] nvme-pci: use mapped entries for sgl decision
Date: Thu, 5 Jan 2023 12:28:31 -0800
Message-ID: <20230105202833.3225645-3-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230105202833.3225645-1-kbusch@meta.com>
References: <20230105202833.3225645-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BhR0kzRpDmw2iq4sNdXwhvZaC4ecR3tT
X-Proofpoint-GUID: BhR0kzRpDmw2iq4sNdXwhvZaC4ecR3tT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_11,2023-01-05_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230105_122849_480940_E4BD54C7 
X-CRM114-Status: GOOD (  16.21  )
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
lists. The dma mapping might have fewer entries than the physical
segments, so check the dma mapped count to determine which nvme data
layout method is more optimal.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 693c6e5495846..08ae1d69bf8c4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -515,10 +515,10 @@ static void **nvme_pci_iod_list(struct request *req=
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
@@ -818,7 +818,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *de=
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


