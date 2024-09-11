Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8BAEE57D0
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 20:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=glK27eRNV5Tvvrk4Gur6XaK1EaNcTcPLRinvoVpWM0k=; b=3Q0Atq8mTvOJZ0com4/gnUg+9p
	uqMl6tNA+2YnTizxyLlX2xFwkG0OfgrLZb8XhQbBRKEC3dktEJCEGK5g8mnEfHN7qH8I/E0ZX3aLF
	hjVQRScbN7LfHDLJ8ZGeQ9muDyZCzU5aeGjcGXiWIelu0g1vnwEmMou7UFcBqtxkl1iVYuIWHAht1
	JyKmPRpiyl8a2GQODCXQwyYdA/LpYOArZSkIqO0NeH/WwJvXz7WmlKrkUn9FBmAtMdu6/PL2H/owk
	xhkFMYzZ7Ex7M0lV/ClUJc6/scbT5poiXrPLg1GWb1GG1F6tQoPZfCGU/hh3rZHq7Lrd1EnMs8ofD
	XfwaP6pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soThx-0000000AqmR-3pNb;
	Wed, 11 Sep 2024 20:12:57 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soThs-0000000AqjQ-2rtD
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 20:12:54 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BHjdxb019460
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=glK27eRNV5Tvvrk4Gur6XaK1EaNcTcPLRinvoVpWM0k=; b=
	mdOBuuJe1joge39y41WQn6lwPVOxDkoMjveWtiAL2Ku0H11+uJcOKa+k7ThsX19Y
	FVqp2rLf3kuE601Sa+lOqKBt+MizPvH83OiexSONF2QDlwIjfqCnhJ/Qg5uASiy8
	DBQGdCRzpeh985yrsXSNZWjp07nFLtZbYvISv9OvHRJZgca5BdBcJl3ShWA6EsIW
	jwlN9wZyjMvb4KFINGXr78Xmze8qo1wDr38xlekJhgfFRyAhZh0zZMzBwZVc+fmW
	vhLnRv6YsYrnvGtuxdHVibVEMBj9FnQRnlB8CFLwUIQNGj/NJ0j3jXOv9mIruHug
	mjSv4Do4BELu7LM1/viLxw==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41kbpe38qg-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:52 -0700 (PDT)
Received: from twshared25838.31.frc3.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Sep 2024 20:12:47 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 3C1DF12E5EDB5; Wed, 11 Sep 2024 13:12:42 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 09/10] block: unexport blk_rq_count_integrity_sg
Date: Wed, 11 Sep 2024 13:12:39 -0700
Message-ID: <20240911201240.3982856-10-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240911201240.3982856-1-kbusch@meta.com>
References: <20240911201240.3982856-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jCWVKVjUj32s_ye1Z9TLamioto-A4A8I
X-Proofpoint-GUID: jCWVKVjUj32s_ye1Z9TLamioto-A4A8I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_01,2024-09-09_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_131252_780857_D0977890 
X-CRM114-Status: GOOD (  10.67  )
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

There are no external users of this.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index ddc742d58330b..1d82b18e06f8e 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -53,7 +53,6 @@ int blk_rq_count_integrity_sg(struct request_queue *q, =
struct bio *bio)
=20
 	return segments;
 }
-EXPORT_SYMBOL(blk_rq_count_integrity_sg);
=20
 /**
  * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
--=20
2.43.5


