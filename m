Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544C8C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 20:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HUKpLb6JXEKmTJ5lKkPoJzYMJoy996fk0USUyFanhJ4=; b=suwpKcVyajj+hu1FBFzM7uIrso
	Ix1ZUWXBqjqsXgTQhI4Y/7a1KFo9ctPj1Lm5i09n3wD7uw36w5CPPRoXI0YdCTXSWfmqg2tvGssYP
	niPf+v8TskNVG4qbxHE70TlbjJX6mcUtWOTdULcex4OSHHxOacm4Ff/bu8fYhu+SpYGfqtZoJH+o2
	TrxFpuCkwZEX1/oncZc3l0srlJ+kLDNJqsrhEACRqMxEtNpk3OYGA4Azjtng82uuFbXqDWrtwUSyF
	zMnh4554KTH5QYqu+6CimQ9r1VnbucmLV96ASUcA9KdTUX8OXa/e7lbRrWSPFAh0wmYxgmHHssbmL
	7r7B4FuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o711d-001TsE-CV; Thu, 30 Jun 2022 20:44:33 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7103-001T5f-9h
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 20:42:57 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UEi8Gq008104
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=HUKpLb6JXEKmTJ5lKkPoJzYMJoy996fk0USUyFanhJ4=;
 b=No9ShFEhPbtaMuDPoG7tj+iRu2Tlj7cZpA+ZuBaA2IurJtG6ueraW1U4GqaAveht1dqe
 SXl0KJE36C4QR9ypmk3tZ9f6ZJM4F6dlR6WJEblESHBCE2XYCB+r8uO+SVrGNojMzP9u
 FfSuCeg49qLwpYIez6V5aMqac0abdPWONUA= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h0qgr34bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:54 -0700
Received: from twshared14577.08.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:53 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 987AC5932DBA; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 04/12] iomap: use common blkdev alignment check
Date: Thu, 30 Jun 2022 13:42:04 -0700
Message-ID: <20220630204212.1265638-5-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: wawNiiUig95CSZ96vyGNE6Hvr4bUGqZk
X-Proofpoint-ORIG-GUID: wawNiiUig95CSZ96vyGNE6Hvr4bUGqZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_134255_482133_3F7790F7 
X-CRM114-Status: GOOD (  15.06  )
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

The block layer provides a generic io alignment check, so use that.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/iomap/direct-io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 40cbf2025386..10a113358365 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -241,7 +241,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	const struct iomap *iomap =3D &iter->iomap;
 	struct inode *inode =3D iter->inode;
 	struct block_device *bdev =3D iomap->bdev;
-	unsigned int blksz =3D bdev_logical_block_size(bdev);
 	unsigned int fs_block_size =3D i_blocksize(inode), pad;
 	loff_t length =3D iomap_length(iter);
 	loff_t pos =3D iter->pos;
@@ -253,8 +252,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	size_t copied =3D 0;
 	size_t orig_count;
=20
-	if ((pos | length) & (blksz - 1) ||
-	    !bdev_iter_is_aligned(bdev, dio->submit.iter))
+	if (blkdev_dio_unaligned(bdev, pos | length, dio->submit.iter))
 		return -EINVAL;
=20
 	if (iomap->type =3D=3D IOMAP_UNWRITTEN) {
--=20
2.30.2


