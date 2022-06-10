Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC6FC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 20:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ngiycs0SqGNoBcBOOiS6n513hBNhAYc94F0OBqdAAPA=; b=ihA/t0jpVzCdrVAbw+N72GR7kx
	eLi3c1VfDYZitPFNexBb3zdu+Q8TQIVE9sBJyXy6oWT3S5f1aLJOYAuuC81THtTs417y1jxGGZd6Q
	WOEl0QpRo0qnHxCoFrmMxVIjbxlcg5Vika5D8+ITLTOpTh/O1dKjpMilJMjG+wOJTzTaPylkczfiW
	mkwxLfqxDBeLIFkmGRbb/WTN+ltNd/SYo1OH1B5cI7b0ZbK8W5m0Oh7ub3QG7k1AVgvAHSiAZrMrE
	8I4w0xDmh5CbPJp3gew4EbTK1fUP9IV9/lVVTCs6xbmt8Cqh0yHjLqEdpCOU1uG+1/KH1e0Qddmpa
	G1kPoK4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzl3M-009fwB-0v; Fri, 10 Jun 2022 20:16:20 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzl3G-009ftm-FR
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 20:16:15 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AIDwan029072
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:16:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ngiycs0SqGNoBcBOOiS6n513hBNhAYc94F0OBqdAAPA=;
 b=NqOkwff1ndriV/TqQJAtJRzR/JpvvR4lbX+fxMfx67z+bs2ijggeFi+39k+wAQGAWNL4
 0gOQgflYbrkdH1971CCxabjXgApJatfZLuB38WHbBwvotbjy77Yi0m31qTPtFQ5SJelR
 Rlr1taJtGb4I6ZY3wNiRa8R9DZEri3nmduE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmb208ph9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:16:13 -0700
Received: from twshared5131.09.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:16:12 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 408614E9D6AC; Fri, 10 Jun 2022 12:58:32 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Date: Fri, 10 Jun 2022 12:58:30 -0700
Message-ID: <20220610195830.3574005-12-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610195830.3574005-1-kbusch@fb.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rHodmA7M_vWhjOdYBxpPVR7ENzu8wfaA
X-Proofpoint-ORIG-GUID: rHodmA7M_vWhjOdYBxpPVR7ENzu8wfaA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_131614_671694_11346E28 
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

Use the address alignment requirements from the block_device for direct
io instead of requiring addresses be aligned to the block size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 370c3241618a..5d098adba443 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -242,7 +242,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	struct inode *inode =3D iter->inode;
 	unsigned int blkbits =3D blksize_bits(bdev_logical_block_size(iomap->bd=
ev));
 	unsigned int fs_block_size =3D i_blocksize(inode), pad;
-	unsigned int align =3D iov_iter_alignment(dio->submit.iter);
 	loff_t length =3D iomap_length(iter);
 	loff_t pos =3D iter->pos;
 	unsigned int bio_opf;
@@ -253,7 +252,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	size_t copied =3D 0;
 	size_t orig_count;
=20
-	if ((pos | length | align) & ((1 << blkbits) - 1))
+	if ((pos | length) & ((1 << blkbits) - 1) ||
+	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
=20
 	if (iomap->type =3D=3D IOMAP_UNWRITTEN) {
--=20
2.30.2


