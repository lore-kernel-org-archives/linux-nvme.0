Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95ADC87FCB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aqd8GppnA9LGhePYAO8oJBoxHOWklKXHjgvg0kyOuK8=; b=c9joOyzNp7raExaPa5DZwDRfZk
	0Mt4QvJeNOxFr1tcdEOFq2Nr9rvFhvVTWjP5IeGgxywvfCnr2Nm00xK7dGSb98ZP5i6wdjh5fBtoE
	b+He9ZkP0qv4MYw0uvjj84Sh7J4d47tI7YqU6YgHXYAXJxGep9wTKhjTdfi786gV1S4KLxu/KQx/G
	qRvj6qPgosrqzZHwnNyK2i7u9jsfB2ex1GV/QV9JqBJWnZKpINeVIny13m/iY6hUH582QC3ENVbXW
	qKgjNCtRILbyRz3Tue2vKp8vxDDbdWpN+o7gM5zpwCOqzfoozAG5st6GvkpxBpMztRAD0TtpPA8y5
	SvM8E58w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulsss-0000000BbQk-0czj;
	Tue, 12 Aug 2025 17:34:02 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulpRZ-0000000AyvD-1mL4
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 13:53:38 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDnqqW012173
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:53:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=aqd8GppnA9LGhePYAO8oJBoxHOWklKXHjgvg0kyOuK8=; b=uvJlWBmvSRUX
	kVCgZiXOOjFT/MTJQzz9chdxQpnvkfIvn2GisrAmaY598SOu3cu5Q0F03Zf2yyKZ
	M2NIWCcUpdOR8anXvOWbbhJ0rTWeZ0bFSQqKimr3e2znUCEiyZ+7nHy9lR2YaJY3
	r3BBpe1pxFFvb29TQ7nq99Y4e3BvR3XiDlYr5jEveznr7CFsqwHR/XJxTOKwjgcg
	FHtUGuSmIKrMKmL5nSwZM57IbCCO8A/I7b0PpXmQbUpISC0jWINFq1YvXWhsF5r+
	YBd1PKI2mzyRduxKSteHkyeIo+j3JuEIRe26+Tvomzqk7hukoFyI+KwhfqH5hIdX
	bCCYBdXSBQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48g5s6rs0t-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:53:33 -0700 (PDT)
Received: from twshared51809.40.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 12 Aug 2025 13:52:18 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 820078D4076; Tue, 12 Aug 2025 06:52:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv6 1/8] blk-mq-dma: create blk_map_iter type
Date: Tue, 12 Aug 2025 06:52:03 -0700
Message-ID: <20250812135210.4172178-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812135210.4172178-1-kbusch@meta.com>
References: <20250812135210.4172178-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: yjBxr17logQ_0GTfK_bbafclVKygdYjl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzNCBTYWx0ZWRfX95vkV8+i8S6H qu5FI6DFIi/52nGBlQFx2THZhHyvxJ5sSLMxJmIiMsmuSn6npXdLDHinpTFFfNYrRleTykZ4xSn CLVObjLBqfMlxQSpGp0/3SJJAnZK2X9IxYHLbIJdjQqbL7xn0JldPAke6BsoJ9Gx0Sx8WW3vWYQ
 686SE2KHsXf8yxyEnnqDpIxzbeRu0Xoo1W8TeGZp+1nEmOkzARwECQ9fkSzmlGVwprPoHbyVmol QqMlfrw4JKh7ruosujBNBsQVwUf8wd43wQG6fAwhTIQg5QB0fmpEBRRDMJx/0rCpjsrv1BCxauw JeiNYMz8I1VwaStHoe3evV95Dopcb+ymGGO2lFPptmB1+mFmqSyyvAb5pe4hGWrcO1GhGZLRA0a
 /tJa+HRVMcPM5NtZszJfPE1Z67xk9ETqpa9qSqjD+mdlzb0JOA5sZOxhwUz//hD/rqUtrhm3
X-Proofpoint-ORIG-GUID: yjBxr17logQ_0GTfK_bbafclVKygdYjl
X-Authority-Analysis: v=2.4 cv=H4vbw/Yi c=1 sm=1 tr=0 ts=689b475e cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=1inAjTl7Go1hButXYeIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_065337_503931_92EC5DC7 
X-CRM114-Status: GOOD (  15.69  )
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

The req_iterator happens to have similar fields to what the dma iterator
needs, but we're not necessarily iterating a request's bi_io_vec. Create
a new type specific to the blk-dma api that can be amended for new
future uses.

Signed-off-by: Keith Busch <kbusch@kernel.org>
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


