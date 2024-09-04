Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBABCD4857
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=egTi6ZnQ87q4SMqOIPKOssZGP60h07A6RuSO4eqy0Ec=; b=wjKqnWeN3BgWcSxO1XaDXrBcbK
	FqvvyrWQDmgbX0J4PVzrkB6s96mxsR87lXxA7OA+kJU0gkKZpY3ZcYxAWYfIT4vxh3ITCfBkI7RxP
	hyLPg/OOI3tg+CfFF/h83B9jxrKfnRvP7Tw5g8SNiAZRkVVwHrTEv+byjgT4ztyI+vgZivs+r6TWc
	14HN5dJnkkzDpuCoqpYb5kTjYVX4exQlGwKVqsgmneNS6YVHAINbcSR8mIesVmxnLIQjT/WjTtdjY
	zzLG8mIyFnj7No7KXmwudjoXcCwp7bOFyu8lgRsbCzvV8ooKxLt/piwMBkj55PtICG1G/aD2tRxwx
	ChyY1Zzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slruB-00000004zWu-2atR;
	Wed, 04 Sep 2024 15:26:47 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slru9-00000004zVi-0EZP
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 15:26:46 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849U2No022336
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 08:26:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=egTi6ZnQ87q4SMqOIPKOssZGP60h07A6RuSO4eqy0Ec=; b=
	NZ46nCG8ND7KWwYTthaKR3mFkW2WvO4AGdAU8J4YDryDRHRbmqJq+xsAAdCtIsrO
	1hNhT/RqHv7eY9a+Fm61GZu3hxF5wE00/FJT6uK5LTaAnXUIs8nIrB7y6uUMQZ4s
	ZuTBC9To3V+F2qrGbaRwgnT+L26aKcQHZoFWCwIR2Uk7oiWBeGimsAK1ErlpQG3e
	ssaC2YGlGKyKm28nh9WDyBYj0HjNoCuvEhhKxna5+E4SraaOosoQ+JQJzz0x/jKz
	sZoyTD2Cm0VDUcs3V9xINzRKXXOhCn0O1rBA9/8Tt0Ehchaaoy8txzHqKVebXl2V
	ThhXLRqGt8LF/jT8w5XaEQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41emyp1w8k-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 08:26:44 -0700 (PDT)
Received: from twshared34253.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 15:26:12 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id BFEAA12A036E9; Wed,  4 Sep 2024 08:26:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 04/10] nvme-rdma: use request helper to get integrity segments
Date: Wed, 4 Sep 2024 08:25:59 -0700
Message-ID: <20240904152605.4055570-5-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904152605.4055570-1-kbusch@meta.com>
References: <20240904152605.4055570-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2TjvgLHxk4MSSfdByKdmR7OAO-8ZmoUM
X-Proofpoint-ORIG-GUID: 2TjvgLHxk4MSSfdByKdmR7OAO-8ZmoUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_082645_125653_D6643AA8 
X-CRM114-Status: GOOD (  13.10  )
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

The request tracks the integrity segments already, so no need to
recount the segements again.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2eb33842f9711..dc0987d42c6b2 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1496,7 +1496,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *=
ibdev, struct request *rq,
 		req->metadata_sgl->sg_table.sgl =3D
 			(struct scatterlist *)(req->metadata_sgl + 1);
 		ret =3D sg_alloc_table_chained(&req->metadata_sgl->sg_table,
-				blk_rq_count_integrity_sg(rq->q, rq->bio),
+				blk_rq_integrity_segments(rq),
 				req->metadata_sgl->sg_table.sgl,
 				NVME_INLINE_METADATA_SG_CNT);
 		if (unlikely(ret)) {
--=20
2.43.5


