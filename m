Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2606EE57D3
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 20:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vsWJ1tyzQEJgxec9rmC6OH4EJf2VkiCpPCBFVPp8kHY=; b=Cykoa1WXa4X6uU/3bMTRaSpaSP
	l4J6nQvFzm5EdX/dpsoh76iep+VaKZpeqCw2P9uTFLgPHboM07LXOe2KaW78MlRL4s8oCYFUKtzH5
	zcgEsqOu6vXUGCx9jpo2g22dy5qODg8Zrh4wPp021CMJnTPqRFDdEfK7KoqAxULKCmcq5nx04MwMY
	pxSDF6gfQpwt7EVnBJ2pQo2lZy11SKRzp9NGYb0eHiqdjPK7SdFzpkm+8KmnGeOFu11cXSok8bxns
	Mxy11nUallALCV4WETBTpxPRC+Dgz/GAlKaTnahTGPTWf+T3wWL009Efk+Wyueyw8c1DnT4/uXFB0
	sbbh5Xkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soThv-0000000AqkT-2LLF;
	Wed, 11 Sep 2024 20:12:55 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soThq-0000000AqiZ-2lel
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 20:12:52 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BHja1J023861
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=vsWJ1tyzQEJgxec9rmC6OH4EJf2VkiCpPCBFVPp8kHY=; b=
	DNZV5ZR4Zrg9sf9ap/zFilwq+iA2YPhe/8du1eZ2sdeaA/ab56r+pVyOFJjIuFOd
	l35xrfT7kL3P/MQtH2CukPbv58YkO2z8W3JxsRD/gmMWQrc6uMQ9YU/mIdHHDpw1
	/49iQoP3J75bq+60b57JSbdCaCBiLrHLERnLubj/rv8DAbZnZW2tCsipUwptCjJI
	7sH1pk+ueNtCCI796H/bec/EYkZfBjRkDuJIW4Lo9IRntF+WQHqNmWDuStLXQwxa
	1q+e1PIox20+TWq8bPdgC5/NDxx5B6aHd7yjR8QQb5J5G5NJgHZZxUPXo9WKf5HD
	x5ceSlSCxerVvktgXzNsYw==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41k87cmcqt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:49 -0700 (PDT)
Received: from twshared25838.31.frc3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Sep 2024 20:12:47 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id BE5DA12E5EDA5; Wed, 11 Sep 2024 13:12:41 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 01/10] blk-mq: unconditional nr_integrity_segments
Date: Wed, 11 Sep 2024 13:12:31 -0700
Message-ID: <20240911201240.3982856-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240911201240.3982856-1-kbusch@meta.com>
References: <20240911201240.3982856-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: iSxiJIrts_PHqTOdq24GFf-iYv3eKj26
X-Proofpoint-ORIG-GUID: iSxiJIrts_PHqTOdq24GFf-iYv3eKj26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_01,2024-09-09_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_131250_812653_349EF2FF 
X-CRM114-Status: GOOD (  11.65  )
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

Always defining the field will make using it easier and less error prone
in future patches.

There shouldn't be any downside to this: the field fits in what would
otherwise be a 2-byte hole, so we're not saving space by conditionally
leaving it out.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c         | 2 --
 include/linux/blk-mq.h | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3f1f7d0b3ff35..ef3a2ed499563 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -376,9 +376,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_=
mq_alloc_data *data,
 	rq->io_start_time_ns =3D 0;
 	rq->stats_sectors =3D 0;
 	rq->nr_phys_segments =3D 0;
-#if defined(CONFIG_BLK_DEV_INTEGRITY)
 	rq->nr_integrity_segments =3D 0;
-#endif
 	rq->end_io =3D NULL;
 	rq->end_io_data =3D NULL;
=20
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8d304b1d16b15..4fecf46ef681b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -149,10 +149,7 @@ struct request {
 	 * physical address coalescing is performed.
 	 */
 	unsigned short nr_phys_segments;
-
-#ifdef CONFIG_BLK_DEV_INTEGRITY
 	unsigned short nr_integrity_segments;
-#endif
=20
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct bio_crypt_ctx *crypt_ctx;
--=20
2.43.5


