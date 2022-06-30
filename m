Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3186BC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 20:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IzuejAZDXVoGY3HRUSZnk1+5V9y94rIoG6LLgWhRwEE=; b=Hq91oRYiWqEiHaEO7oGhm0jHu4
	S/7jJljTu0SMORl4W80Q/TyqmYdyyWn1jcaKKlxin459QCMlVJd7qXJD8p4e2fwufQcu1XrLU/Am/
	sEs7OKQFWkdGD0pz9na8qFXAuWNSY7KNtsX8v8g2SuHr7npWwsNc7kBaFxKc7ZCOevXfxmOU9qSu3
	Uu6QesGX0D40al49bJi5tTvKSN5O+kb/AdZGHA2jlYq2IXWAashTA5pHZkekmHeTRW/1pjAaczpIM
	s1mVPUckKsWmpdNtXrt4V+PVFw8yGhactJ4fiwJ/b38DEOGsnJDWTRoNlYtAEKUgP9/2m5LLSq95n
	kAR4+Taw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o710o-001TWi-AY; Thu, 30 Jun 2022 20:43:42 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7100-001T2y-5B
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 20:42:54 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UFU3tN009972
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=IzuejAZDXVoGY3HRUSZnk1+5V9y94rIoG6LLgWhRwEE=;
 b=SlUBWCdviGqGE1WMXHze8ouHun4HiWUxERQZZdyyO2ELdOV9nvt3yQex7RJzcLig7Ddb
 BZb8x+q6GlVJT4IXTvwEtU7NEUR6+Z/kp0JBWHFjXdKilZTX3z9aKTORfHWgmD497k4P
 5AnmJXq0vTXXhTITAG2TeADrC4P3ziStfhQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h0tdshrk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:51 -0700
Received: from twshared25478.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:50 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 575A65932DB9; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 03/12] iomap: get logical block size directly
Date: Thu, 30 Jun 2022 13:42:03 -0700
Message-ID: <20220630204212.1265638-4-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hT3UcSU2c_5OE1I0_5LCcl1NW6YYy4xF
X-Proofpoint-GUID: hT3UcSU2c_5OE1I0_5LCcl1NW6YYy4xF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_134252_260229_D9950D98 
X-CRM114-Status: GOOD (  16.74  )
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

Don't transform the logical block size to a bit shift only to shift it
back out to the size. Just use the size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/iomap/direct-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d478a95efdf..40cbf2025386 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -241,7 +241,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	const struct iomap *iomap =3D &iter->iomap;
 	struct inode *inode =3D iter->inode;
 	struct block_device *bdev =3D iomap->bdev;
-	unsigned int blkbits =3D blksize_bits(bdev_logical_block_size(bdev));
+	unsigned int blksz =3D bdev_logical_block_size(bdev);
 	unsigned int fs_block_size =3D i_blocksize(inode), pad;
 	loff_t length =3D iomap_length(iter);
 	loff_t pos =3D iter->pos;
@@ -253,7 +253,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	size_t copied =3D 0;
 	size_t orig_count;
=20
-	if ((pos | length) & ((1 << blkbits) - 1) ||
+	if ((pos | length) & (blksz - 1) ||
 	    !bdev_iter_is_aligned(bdev, dio->submit.iter))
 		return -EINVAL;
=20
--=20
2.30.2


