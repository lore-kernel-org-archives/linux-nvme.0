Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA3FC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 20:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Un4NLPzCwa9kRECQYiM/bb2nQGDf07xC9htX3/5DtNA=; b=hAJDQbV6VdVNyUhfoxCjdrqAVC
	DPEIeS0kHIULragVzF8W/471g5rxyvYcNzXHL9ZqMtWRb1ZcER0GnpEh1tzxwi7OoDmqBay9dI659
	Bd7HBfIaKKBykPOGRvBQgAsqTkjjvioCXvNQAHJCR6VsKtVW5KxX+PfWdEYy5yiKz3W5QFTHh2/cW
	GT9i1cBPfKzxgNqEoGo7w9keuHhyianYQOQMFvRP47ibA/u9eyLaKjwo2GTonQCl0j7gqLc1wkSKP
	s55mZ1IsF9fkgKxBrc6hEhSeO5ax27o2jsIz5Poh0Mbfhww7Oo6FbnnKtTbhOQmlk9eKcsULHz5we
	r9pQifJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o711M-001Tkb-Iy; Thu, 30 Jun 2022 20:44:16 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7102-001T4v-BJ
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 20:42:55 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UI6je4021278
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Un4NLPzCwa9kRECQYiM/bb2nQGDf07xC9htX3/5DtNA=;
 b=ek3A4jZu7HYu0B2lUbVx87zg1N2CK9KDJ7Vg5nwa6+xnHz8tqpDYALGsIleQ/ZLzQ72Z
 zMZh8d98Tk2VWQ9QzrkleZSsCwgArhgxnGQtJ9KZQgGy6MEZcYPF3GrYJtkVhtij7g9o
 4VhPhrVJIiMsiJmws3pssN82ePFS+sbnp8k= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h17fmn80s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:53 -0700
Received: from twshared14577.08.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:53 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id F00125932DC1; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 09/12] block: add partial sector parameter helper
Date: Thu, 30 Jun 2022 13:42:09 -0700
Message-ID: <20220630204212.1265638-10-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: MSzAftgdBDQM0qsnKNJuAAFXUqk9uy-x
X-Proofpoint-ORIG-GUID: MSzAftgdBDQM0qsnKNJuAAFXUqk9uy-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_134254_500013_5473B822 
X-CRM114-Status: GOOD (  15.30  )
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

Check if an iov is a read, and aligned to a partial sector access. If so
set the skipped and truncated bytes.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blkdev.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4396fcf04bb8..e631cdd01df4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1362,6 +1362,27 @@ static inline bool blkdev_dio_unaligned(struct blo=
ck_device *bdev, loff_t p,
 		!bdev_iter_is_aligned(bdev, iter);
 }
=20
+static inline bool blkdev_bit_bucket(struct block_device *bdev, loff_t p=
os,
+				loff_t len, struct iov_iter *iter, u16 *skip,
+				u16 *trunc)
+{
+	unsigned int blksz =3D bdev_logical_block_size(bdev);
+
+	if (iov_iter_rw(iter) !=3D READ ||
+	    !blk_queue_bb(bdev_get_queue(bdev)) ||
+	    iter->nr_segs > 1)
+		return false;
+
+	if (!iov_iter_is_aligned(iter, bdev_dma_alignment(bdev),
+				 bdev_dma_alignment(bdev)))
+	        return false;
+
+	*skip =3D pos & (blksz - 1);
+	*trunc =3D blksz - ((pos + len) & (blksz - 1));
+
+	return true;
+}
+
 static inline int blk_rq_aligned(struct request_queue *q, unsigned long =
addr,
 				 unsigned int len)
 {
--=20
2.30.2


