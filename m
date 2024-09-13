Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2A7FC6171
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 19:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ol2Diwm840wEdv83fl13zLXO99ZYV29lYaH8A1zftr8=; b=mgNBbyUnQUOLKy7hw5Vx4+dA48
	AyR38Daz8zJvvlyPN9rTDagR6LKOkdKl/AxZlQ9WG+2H3u4yv+8AG4EJyLXXt1fZDzMZ+iycOvL3O
	SxPYRYW01xK3gNTAPPY4WhBrrfPAQWE+JXiPGBkYRjE/fXWMTdMw++iF3tILw6TPa+2FuHZpjk0hk
	ZZKxzuA2GPCqMLTvbs5bQaK6aS9vHSegDhcIzv2zQzJu82ChiTFJxeOuOZvxt0NTkIqlHx8TDGxIv
	UlwMptdRsGGWA2oLFxti5sdtM5EGlvuOMCT1bc5tdHkwUiXr0/VHxcIMnfVK4oVF6Q4/qn9FsEIWC
	6tlIs2qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spC0i-0000000Gwdy-2rC7;
	Fri, 13 Sep 2024 19:31:16 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spB2h-0000000GoLo-2UV6
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 18:29:32 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DI2LlT003051
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=ol2Diwm840wEdv83fl13zLXO99ZYV29lYaH8A1zftr8=; b=
	FWfIdwSHCEfZy0/YTni/5H8bHV/misFA2GgOj/n3yB5SebLo5TLlhZfU6T0Tf3xF
	IzV8Qv/hEy2VO139ORDsrNn+Plvv7DpxeG5YK+xdCR3LejNSKLi3kqqRC7DTr4TJ
	nRbA5hDFBPaHM008rv+ZX7VYuOhmoKaIxWg7n8hqp0RDc/a6rzWCVcf7HrT2XzLQ
	ZUPJRfw0Nat6+U0UYLAfeS6d4F9rBdbxMzJcs3yIkA2dHUa4emeaR+eORxCU8oM7
	IZX0eUw8cUmvRoZBsrSN7Hiwebd6kau1TsxmASEgXceKWMoQoXpYbswgs55n1/U3
	CK/6wgTwmdC5YqvHrlfQuw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41kha4qjc4-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:14 -0700 (PDT)
Received: from twshared0911.02.ash9.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 13 Sep 2024 18:29:09 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 56D3E12F91043; Fri, 13 Sep 2024 11:29:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 1/9] blk-mq: unconditional nr_integrity_segments
Date: Fri, 13 Sep 2024 11:28:46 -0700
Message-ID: <20240913182854.2445457-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240913182854.2445457-1-kbusch@meta.com>
References: <20240913182854.2445457-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5TP10OFbioOEl-KMJBlP_NWEzdSqQDV-
X-Proofpoint-ORIG-GUID: 5TP10OFbioOEl-KMJBlP_NWEzdSqQDV-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_112916_185373_FD5206BC 
X-CRM114-Status: GOOD (  11.47  )
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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


