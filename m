Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45680CA0EE8
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 16:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0lUwFCMGofO6tWukzpZ/9pJw4H5jiLYLGB09QF+xWrY=; b=YvUxOvv7vAd91BMromp7BVCUB1
	jOIXqa2m5Iyeo3n0fYdas0zzHzj2SQO/daKM/ngMDyUJnI6fCNJHLFBUWRSeuF/Uf6Wu3d7puFjSz
	J4dpeVi0tKfKHcXsD1CiHkbCAXldbShUKjkSjLmFxAnL4n9AxlrHeH3QYQ4qA7JcxzFEaSsunSu36
	tw7Rrn1CJCiPfoLa7cOPSS0KGrha4eyTnqT7b6sN+QbK0w5eodmj+thNxe+c17yrdSrvBeS+82W4H
	bkFJ/xwSTbn7QwKAnxy3iAtg7FFQ5/+bsHfuDyF0GRO9J2CG2V6aMNF2PaWfUgO9TyTNEhpxiPgnW
	VhgbRDnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umEO9-0000000EOu1-33NY;
	Wed, 13 Aug 2025 16:31:45 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDSe-0000000ECN5-1Xhn
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 15:32:21 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFB97B031008
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:32:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=0lUwFCMGofO6tWukzpZ/9pJw4H5jiLYLGB09QF+xWrY=; b=dYipxKqIajug
	/xKWaR4YYlk7DJc+kbRCTJaoLO4GTZZWDDYerrkCtVZpklRuKeeIqvO3FdrcVBTW
	lpLRV82QdqaJDdwei/6o3jkDCx8XBvp/kB2w1K7Td/n/wT+Uk7JfxorKjoNMkWdI
	0TmaiiE73kEiIB5XTDGvOnOIIDMazJTopkaST+hkPPiLB2j0xZIhJag/QdF5a/yc
	8co/RsdQ+QFY8RoIuexVWA3r71RZN0JvFS5Ovn3uyqv/clZFYcV05IrzQqpj5cEk
	vHONVxvkobOjDOB24AgdxDiArQeMTZ3JY862UQSyxl9azoEM/wj0vumMVfxMudcd
	0Encr0z1GA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48gpru2kss-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:32:20 -0700 (PDT)
Received: from twshared42488.16.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 13 Aug 2025 15:32:09 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 3D55F97CD7D; Wed, 13 Aug 2025 08:32:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv7 1/9] blk-mq-dma: create blk_map_iter type
Date: Wed, 13 Aug 2025 08:31:45 -0700
Message-ID: <20250813153153.3260897-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com>
References: <20250813153153.3260897-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Z6Bcn7fU8vCntI6mNgGjoUXe9RAah58j
X-Authority-Analysis: v=2.4 cv=JKM7s9Kb c=1 sm=1 tr=0 ts=689cb004 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yZlJt16GNrEBTkNGrycA:9
X-Proofpoint-GUID: Z6Bcn7fU8vCntI6mNgGjoUXe9RAah58j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0NiBTYWx0ZWRfX9haIIiIJeYnc ef6NE3lktQrG0Kz3zBIy6PjuYZfs367u/LKniMF/dSB+K7rVA5ShOlBN8kVPDh9JRuPbkDNEPr+ VnfTblRTyNOLrIyGXBtjpGoAZj2AtxPfn92NX2oYkzxzZtEYO4UhwzUYwwNw1ZamQf1TQmu18j9
 nnV78yJ8u5G6lwSU6nIrXOdUyLPT/VaOxSwQ7JkoGdAm1Wpimh+KsWCgWpqo+46PDAg5D+ruqbn 5q13lFq0S7Qe4bwE0eTupJ4LVHpOTg5kdiUNUB12l4nNke11lAYjP87DzaJsmLV7F6xNfkHe9hO 2gyT6XmEcyrBqOzmjsrkVSDajzcPjpUdQv3tjdRdiP0/1hntxFVvMYsKeE7KWqqBpdpLhFa+nsc
 8a7cLw4LyhOm1yH0nTk5BsKUi6Py4CBOHwlsqPqhCcdHD6wofMmCV+eOwqwcZiO1B6qjjBHq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_083220_410443_7D5AAC67 
X-CRM114-Status: GOOD (  15.50  )
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

The req_iterator happens to have a similar fields to what the dma
iterator needs, but we're not necessarily iterating a request's
bi_io_vec. Create a new type that can be amended for additional future
use.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-dma.c         | 4 ++--
 include/linux/blk-mq-dma.h | 7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index ad283017caef2..51e7a0ff045f9 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -10,7 +10,7 @@ struct phys_vec {
 	u32		len;
 };
=20
-static bool blk_map_iter_next(struct request *req, struct req_iterator *=
iter,
+static bool blk_map_iter_next(struct request *req, struct blk_map_iter *=
iter,
 			      struct phys_vec *vec)
 {
 	unsigned int max_size;
@@ -246,7 +246,7 @@ blk_next_sg(struct scatterlist **sg, struct scatterli=
st *sglist)
 int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
 		    struct scatterlist **last_sg)
 {
-	struct req_iterator iter =3D {
+	struct blk_map_iter iter =3D {
 		.bio	=3D rq->bio,
 	};
 	struct phys_vec vec;
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index c26a01aeae006..6a7e3828673d7 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -5,6 +5,11 @@
 #include <linux/blk-mq.h>
 #include <linux/pci-p2pdma.h>
=20
+struct blk_map_iter {
+	struct bvec_iter		iter;
+	struct bio			*bio;
+};
+
 struct blk_dma_iter {
 	/* Output address range for this iteration */
 	dma_addr_t			addr;
@@ -14,7 +19,7 @@ struct blk_dma_iter {
 	blk_status_t			status;
=20
 	/* Internal to blk_rq_dma_map_iter_* */
-	struct req_iterator		iter;
+	struct blk_map_iter		iter;
 	struct pci_p2pdma_map_state	p2pdma;
 };
=20
--=20
2.47.3


