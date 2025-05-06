Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB244C3ABBE
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=unJTCCEaXXXg5wwDLxh3fhnhvj31mJgiMXpUO+QUVoU=; b=GYDyDe5wOGusjxydfsLNB9XOUE
	59twkGHTBrSkoHFlpMgcavnlh1+zxyfXBcIPCp+VcjzT8OPG1XXbb313QGbraVu38SsAjE69x+lPD
	KqcYCTGE/zToM5GNFqdEQufYnSQlhndBW86EX2D1EeYvROyYokb0YXKpiTMdpwr6gIbvbf344QqaM
	TUvVkSWS9kbrXbZITGpEj1+Lm241UhXe3IrxjTApig/N7gu+q/Vgc54IKLrS/WcVEpKLnxrs1CldI
	0bXv8ILv6fAwkJRIP4JRL4+TIIu2Wnn7Sg7m8X9jOdoFw/mcPod31MKUiIbuCDOfYN0dhd8Z4CfCf
	pe01tGuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKjF-0000000CaBn-1hhz;
	Tue, 06 May 2025 16:01:09 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCHNn-0000000Bu8i-0tA7
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 12:26:54 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250506122645epoutp021019b1a79407be271dfc965c5e089de1~878nQMz5T0463604636epoutp02b
	for <linux-nvme@lists.infradead.org>; Tue,  6 May 2025 12:26:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250506122645epoutp021019b1a79407be271dfc965c5e089de1~878nQMz5T0463604636epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746534405;
	bh=unJTCCEaXXXg5wwDLxh3fhnhvj31mJgiMXpUO+QUVoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Py3eGWMuuoiWYpqYm6d9XuxO0+OeGeICb+3ygrLo19E9SKvDL+i0uNAQulRfEYGaG
	 uuJK9Zr0VQ11obPEmgfV03el7L1LjxX1SOomxkCrnhUmGDjvTr/IOSvsVzQmsIRHaf
	 V4T4wqThPiddIIyPorVAbFezO71fuVVhNgnziby8=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250506122645epcas5p44fd15f89441c0df298a9b93e64b028f8~878mvrcdp0663906639epcas5p4z;
	Tue,  6 May 2025 12:26:45 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.181]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ZsHh32mF2z6B9m4; Tue,  6 May
	2025 12:26:43 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250506122642epcas5p267fef037060e55d1e9c0055b0dfd692e~878kab1vq2629526295epcas5p2F;
	Tue,  6 May 2025 12:26:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250506122642epsmtrp18afea66031e60e23bd1a87beac41edaf~878kYxaoB2592625926epsmtrp1B;
	Tue,  6 May 2025 12:26:42 +0000 (GMT)
X-AuditID: b6c32a29-55afd7000000223e-91-681a00025fa8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CC.B6.08766.2000A186; Tue,  6 May 2025 21:26:42 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250506122640epsmtip25724ed78f8c9f291b05de63988079d32~878ixpy5s1679416794epsmtip2c;
	Tue,  6 May 2025 12:26:40 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org, Hannes
	Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v16 05/11] block: expose write streams for block device
 nodes
Date: Tue,  6 May 2025 17:47:26 +0530
Message-Id: <20250506121732.8211-6-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250506121732.8211-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvC4Tg1SGwccJYhZzVm1jtFh9t5/N
	Ys+iSUwWK1cfZbJ413qOxeLo/7dsFpMOXWO02HtL22LP3pMsFvOXPWW32PZ7PrMDt8fOWXfZ
	PS6fLfXYtKqTzWPzknqP3Tcb2Dz6tqxi9Nh8utrj8ya5AI4oLpuU1JzMstQifbsErozDm68w
	F/wUqZh26glbA+MKwS5GTg4JAROJ3xtusXYxcnEICexmlNjTtpsNIiEu0XztBzuELSyx8t9z
	doiij4wSq64fY+pi5OBgE9CUuDC5FKRGRCBA4uXix8wgNcwCH4AGTZzNCJIQFvCVeP5lPQtI
	PYuAqkTjzTCQMK+AucSVc78ZIebLS8y89B1sF6eAhcTyPbPA4kJANS+OHmGHqBeUODnzCQuI
	zQxU37x1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjgkt
	zR2M21d90DvEyMTBeIhRgoNZSYT3/n3JDCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE
	0hNLUrNTUwtSi2CyTBycUg1MXlFGJ2/tyH/h+Tujxkd67eN3ryXbHhjIXvb+ysJ/sMw3cMXc
	3d/vLvle92l3Wq2vqli38qOT0j8O3KmRZKn13vG8ZYbrxp/JER659lY3LNV+TPpyl+FB4Yzt
	7xlt90Q63vq2d8uOwzWfHWLlSj3n/wren7Na8kzP3306E+I9Vlq+6DMUTdW+uI83LGi6u/7F
	A4y3zFy57xhOvanWaPNuzuZjJXtbFgQbXb24gzXvdMibR53WDSbbb7x7cqs+LefI3ReT/Zua
	blgefNq+dalX6xH/2xOZ36Rsu7KwyPlv8oK/xhtdjIyVEpO3fN4Qt/HSyRDvyaq2kw2TD3m7
	qkptin1jedHaYsrh75LvubM+liqxFGckGmoxFxUnAgDBeGbl+AIAAA==
X-CMS-MailID: 20250506122642epcas5p267fef037060e55d1e9c0055b0dfd692e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250506122642epcas5p267fef037060e55d1e9c0055b0dfd692e
References: <20250506121732.8211-1-joshi.k@samsung.com>
	<CGME20250506122642epcas5p267fef037060e55d1e9c0055b0dfd692e@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_052649_357351_191FA0A4 
X-CRM114-Status: GOOD (  17.80  )
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

From: Christoph Hellwig <hch@lst.de>

Use the per-kiocb write stream if provided, or map temperature hints to
write streams (which is a bit questionable, but this shows how it is
done).

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
[kbusch: removed statx reporting]
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/fops.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index b6d7cdd96b54..1309861d4c2c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -73,6 +73,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	}
 	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 	bio.bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
+	bio.bi_write_stream = iocb->ki_write_stream;
 	bio.bi_ioprio = iocb->ki_ioprio;
 	if (iocb->ki_flags & IOCB_ATOMIC)
 		bio.bi_opf |= REQ_ATOMIC;
@@ -206,6 +207,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	for (;;) {
 		bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 		bio->bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
+		bio->bi_write_stream = iocb->ki_write_stream;
 		bio->bi_private = dio;
 		bio->bi_end_io = blkdev_bio_end_io;
 		bio->bi_ioprio = iocb->ki_ioprio;
@@ -333,6 +335,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	dio->iocb = iocb;
 	bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 	bio->bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
+	bio->bi_write_stream = iocb->ki_write_stream;
 	bio->bi_end_io = blkdev_bio_end_io_async;
 	bio->bi_ioprio = iocb->ki_ioprio;
 
@@ -398,6 +401,26 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (blkdev_dio_invalid(bdev, iocb, iter))
 		return -EINVAL;
 
+	if (iov_iter_rw(iter) == WRITE) {
+		u16 max_write_streams = bdev_max_write_streams(bdev);
+
+		if (iocb->ki_write_stream) {
+			if (iocb->ki_write_stream > max_write_streams)
+				return -EINVAL;
+		} else if (max_write_streams) {
+			enum rw_hint write_hint =
+				file_inode(iocb->ki_filp)->i_write_hint;
+
+			/*
+			 * Just use the write hint as write stream for block
+			 * device writes.  This assumes no file system is
+			 * mounted that would use the streams differently.
+			 */
+			if (write_hint <= max_write_streams)
+				iocb->ki_write_stream = write_hint;
+		}
+	}
+
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
 	if (likely(nr_pages <= BIO_MAX_VECS)) {
 		if (is_sync_kiocb(iocb))
-- 
2.25.1


