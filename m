Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE03C83F3D
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Jul 2025 18:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uFYZiHqar0PhYyDghRITTrb8q/vpzZmQzOf8RBuV3po=; b=ey8gD99Xf/nRMgTMU6AKx5PGC5
	Fmpj9bv9W7zSAhoUs2qNvSn65FW5NoJjRYe/23uUez/tj2PKx5ESmwMhG9AtQBsXzNHQdOECVruqS
	RwVbYYLftqnY+kpwpNrXxyNJ1pUSJfqeYETKW9JS1GmuSzHbuO/5pYxchzMNbB06+HaI/Np8O7ldT
	JPzjrZGTawFGHu9Pd5tN6b/6s3Hw89q4+RGsvuORtzFTRieXeqDv2b/ltokg4ONrKVeWL1jaRyVkD
	zKvAY2jm2QlSu8s9LcPVS503HNFORVa6UNEu7nL0zV4aHAAex/di/mwTCc1z4/o5lELvVPp0S/mSA
	Ll3BOaLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ3S-0000000Fc66-1Qrs;
	Sun, 20 Jul 2025 18:46:34 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ13-0000000Fbpq-0bq5
	for linux-nvme@lists.infradead.org;
	Sun, 20 Jul 2025 18:44:06 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KIDUid023780
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=uFYZiHqar0PhYyDghRITTrb8q/vpzZmQzOf8RBuV3po=; b=VUWjfBBoOLw7
	ky3zU06UH0C4UEEWvaAWxBDn+l8pVqjJ9oG7xtXegYQTEcF/+UHvhO111xVaad5t
	Rc7LLNCfUELSzPFbcvjLLfW3WCI6lAdLr5WoL2+8oGiOLYMh+8PBOmsO9h4T1m7H
	VhxhOaTgY77AbErn/DgNibyJEMslxrF7zd90VJp619e/q8RQ/n6qajyt5YECbzim
	DeOexr0PGO81KPFTuM/EgxNgFrUg93/B+sBJpkYTn4s/xut+o2tbEYI8PxLCdLtY
	O+B52Culi80azR0yLSLtOGSonDZ/HpsqVa2pmrOi5O9tYaP+x/4DSuLKnZWH3D+5
	3UkYKdP4mg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4815hs02a1-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:04 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Sun, 20 Jul 2025 18:43:59 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 7D49E178C78A; Sun, 20 Jul 2025 11:40:49 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/7] blk-mq-dma: move the bio and bvec_iter to blk_dma_iter
Date: Sun, 20 Jul 2025 11:40:34 -0700
Message-ID: <20250720184040.2402790-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250720184040.2402790-1-kbusch@meta.com>
References: <20250720184040.2402790-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=N8QpF39B c=1 sm=1 tr=0 ts=687d38f4 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=HQsFWgszj3sHHAXvbW0A:9
X-Proofpoint-GUID: RSLBDAKGeSi-wKi64BSUPGuQJoEI7Cxz
X-Proofpoint-ORIG-GUID: RSLBDAKGeSi-wKi64BSUPGuQJoEI7Cxz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfX/mH0xxVn4X4e TAcJsnnIyCGFS1gUNZFFZBb0qJevw/eI50a/34LOs+lW8XIpJLLtg62QD58zWwZi2a3Qk7Pm52I 66KKTofFtWvA66E9nepQELUs9R4jrOc9ZWSMaXiCN2UzqSVRGXczKILF1kFhmZlohuQ1hsLETKo
 WZfluwSHI6WWyFGSoSlcSFWwQ7HZnW67tc83OmCdMKghpxVZP3rHHDqPajGLeSQMZBK7VMU+ose p9Y2MpaqelNOfNOwqNsE2J2Cu/Bj7hBNzHST+DNFBnpTDKL3Ouctsj/s/rW4Df0A2Kx/CobgT00 utZgaURt9iKUXmvvkti/uRugCvCdZ6qDaWcm8u9OtBOw3vei+wDj8rqXUUaEic/eg/6m3uXIkeU
 D7ypLzDPUyeKSC4tfrWVUgaRc63ocL0YGSsmm7pNdFY8Xel5AAQaXMCeW38KCdU11Hn5ifRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250720_114405_187423_E621D124 
X-CRM114-Status: GOOD (  14.49  )
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

The req_iterator just happens to have a similar fields to what the dma
iterator needs, but we're not necessarily iterating a bio_vec here. Have
the dma iterator define its private fields directly. It also helps to
remove eyesores like "iter->iter.iter".

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c         | 14 +++++++-------
 include/linux/blk-mq-dma.h |  3 ++-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index ad283017caef2..21da3d8941b23 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -10,7 +10,7 @@ struct phys_vec {
 	u32		len;
 };
=20
-static bool blk_map_iter_next(struct request *req, struct req_iterator *=
iter,
+static bool blk_map_iter_next(struct request *req, struct blk_dma_iter *=
iter,
 			      struct phys_vec *vec)
 {
 	unsigned int max_size;
@@ -114,7 +114,7 @@ static bool blk_rq_dma_map_iova(struct request *req, =
struct device *dma_dev,
 		if (error)
 			break;
 		mapped +=3D vec->len;
-	} while (blk_map_iter_next(req, &iter->iter, vec));
+	} while (blk_map_iter_next(req, iter, vec));
=20
 	error =3D dma_iova_sync(dma_dev, state, 0, mapped);
 	if (error) {
@@ -153,8 +153,8 @@ bool blk_rq_dma_map_iter_start(struct request *req, s=
truct device *dma_dev,
 	unsigned int total_len =3D blk_rq_payload_bytes(req);
 	struct phys_vec vec;
=20
-	iter->iter.bio =3D req->bio;
-	iter->iter.iter =3D req->bio->bi_iter;
+	iter->bio =3D req->bio;
+	iter->iter =3D req->bio->bi_iter;
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
=20
@@ -162,7 +162,7 @@ bool blk_rq_dma_map_iter_start(struct request *req, s=
truct device *dma_dev,
 	 * Grab the first segment ASAP because we'll need it to check for P2P
 	 * transfers.
 	 */
-	if (!blk_map_iter_next(req, &iter->iter, &vec))
+	if (!blk_map_iter_next(req, iter, &vec))
 		return false;
=20
 	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && (req->cmd_flags & REQ_P2PDMA)) {
@@ -213,7 +213,7 @@ bool blk_rq_dma_map_iter_next(struct request *req, st=
ruct device *dma_dev,
 {
 	struct phys_vec vec;
=20
-	if (!blk_map_iter_next(req, &iter->iter, &vec))
+	if (!blk_map_iter_next(req, iter, &vec))
 		return false;
=20
 	if (iter->p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
@@ -246,7 +246,7 @@ blk_next_sg(struct scatterlist **sg, struct scatterli=
st *sglist)
 int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
 		    struct scatterlist **last_sg)
 {
-	struct req_iterator iter =3D {
+	struct blk_dma_iter iter =3D {
 		.bio	=3D rq->bio,
 	};
 	struct phys_vec vec;
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index c26a01aeae006..e1c01ba1e2e58 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -14,7 +14,8 @@ struct blk_dma_iter {
 	blk_status_t			status;
=20
 	/* Internal to blk_rq_dma_map_iter_* */
-	struct req_iterator		iter;
+	struct bvec_iter		iter;
+	struct bio			*bio;
 	struct pci_p2pdma_map_state	p2pdma;
 };
=20
--=20
2.47.1


