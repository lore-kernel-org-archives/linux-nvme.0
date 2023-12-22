Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD50C41535
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Dec 2023 07:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5DXoDTvrI2mWMm1I9eg06D4Nr/8IY38fu2o2A+1efIw=; b=JW08N/X1TQMKYwh6BImUDuhebI
	IgaNDiM8F1OVAlvnmSwpvthf2Ng+haGvZvwFNSyncD2wHk03jiQj8JV7tkaaSU3kJKdzw6E8VOavc
	4/mC3EmSUYRnhdZimJf2/NMXJQh9K1s3FHRel7L3zQqsV88YlOSosjrRUPI2KIhtnE20B33HYgcOa
	DRUGG5KxUmr35pnnOO32H1IYYM9xlpWF/Qnyd0CnaqjcM3WEBHA54w0zbcjKI3JlLypcfCYM05XGY
	YhP/pPtYj2hGGo8chPYbvoI6LQWnuxtaNqclev0rxegAzBRxSLIyZ2C0EVnUYJAwEcfAHKEHW/Yit
	MaEcSqHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGa1P-0059zZ-1U;
	Fri, 22 Dec 2023 07:32:39 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGa1M-0059wT-11
	for linux-nvme@lists.infradead.org;
	Fri, 22 Dec 2023 07:32:37 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231222073233epoutp0144e3f7d83c5ad4ccf3802d555d8b3f90~jFvuWSlIS0228602286epoutp01N
	for <linux-nvme@lists.infradead.org>; Fri, 22 Dec 2023 07:32:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231222073233epoutp0144e3f7d83c5ad4ccf3802d555d8b3f90~jFvuWSlIS0228602286epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703230353;
	bh=5DXoDTvrI2mWMm1I9eg06D4Nr/8IY38fu2o2A+1efIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLNeER4UBQX1PDr0jg0HZElaWQMh8Iyc0voONyJWtm6vN3C9FdyZyHohUHbgCjkQj
	 Q9lqBWy5+cX18Q3UpnpmsnFF1126HCr2cpCi3z4Aeqe7LIFgdMkml22JqsLuLi/CPY
	 1ZbWaZwr9oVKB2nJoAItDPyn1P+3NR4hemUqm0IE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231222073233epcas5p2c6275650c592fa37f2a425f2acec9f3e~jFvt4zDsg2130021300epcas5p2q;
	Fri, 22 Dec 2023 07:32:33 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SxJsq3yRfz4x9Q1; Fri, 22 Dec
	2023 07:32:31 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4F.A9.19369.F8B35856; Fri, 22 Dec 2023 16:32:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231222062147epcas5p4353805c045bac87c459f488d0f5b8c86~jEx7MZwT80435204352epcas5p4J;
	Fri, 22 Dec 2023 06:21:47 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231222062147epsmtrp219873d3dc5f8da5a57edb2fc5bba60ce~jEx7KnPV21637116371epsmtrp2Q;
	Fri, 22 Dec 2023 06:21:47 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-12-65853b8f7f92
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	85.3D.07368.AFA25856; Fri, 22 Dec 2023 15:21:46 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231222062143epsmtip29f2629f9af58673581da4b45db15f459~jEx3wdbaS0362603626epsmtip2P;
	Fri, 22 Dec 2023 06:21:43 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, dm-devel@lists.linux.dev, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke
	<hare@suse.de>, Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v19 06/12] fs, block: copy_file_range for def_blk_ops for
 direct block device
Date: Fri, 22 Dec 2023 11:43:00 +0530
Message-Id: <20231222061313.12260-7-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231222061313.12260-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUZRSf797L3bvmyuXh+LFMhhsMgcGyudCHCORozm1sAsfpHyiXHbg8
	WvbR7pJoU0GwukosC0rlFg+BInk/xAFcxCB5GQkxrEARTbNgEygKLkwQGstC+d/v/M75fef8
	zjeHwl2LOHwqRaFl1QppqoDcRlzr9vMPyAvTsUElfXxUP9CDo0e2VQJ9alzDUfVkHolmuxcA
	st48C1BpWRGBxm+2YchcVoChK9W3MFTQZQFoetSEoY6JvejymQoCmTv6CTTS/jWJSr6d5qCc
	u60kqux9gqEx4zRA+fpRDLVaMwG6tlqCo7rZeQL1TXiiO2u9Tq/xmTbTJIe581sjwYwMpjFN
	VedIprniE+bP5kuAuT6eQTLlhgtOTG7WA5J5ND1BMPM3RknGcLUKMM23P2QWm3YzTdb7WLRz
	jOxAMitNYNVerCJemZCiSAoXHD0uOSQJDgkSBYhC0asCL4VUzoYLDr8ZHXAkJXV9JQKvD6Sp
	aetUtFSjEQgjDqiVaVrWK1mp0YYLWFVCqkqsCtRI5Zo0RVKggtXuFwUFvRK8XhgnS+68P0So
	rjunj9wIzwC9288DLgVpMazp+xk/D7ZRrrQZwH5bjpMjWADwckU7xxEsAVjZcIuzJZmfadmU
	dABoKarEHIEOg82DmesZiiLpvfD2U8oucKdrcNjWKLLX4HQxDpv/6MXsCTdaAq16C7BjgvaB
	NvMwacc8ej/s/GGOY38H0kKYN+Vip7l0GLy3Uu7kKHGB/ZeshB3j9Aswq+WrjYEg3cyFdb+O
	Acekh+HCxQbCgd3gX71XNx3w4eKDDtKBT8IrF78jHeJsAE13TZviSKgbyNswg9N+sL5d6KCf
	h4UDdZij8Q6Yu2rFHDwPthZv4RdhTX3p5vse0LKcuYkZ+PvD4s2VGgAsX+gARuBlesaQ6RlD
	pv9blwK8CvBZlUaexMYHq0QBCvbkf98cr5Q3gY078Y9uBdUNa4FdAKNAF4AULnDnKV/OZl15
	CdJTp1m1UqJOS2U1XSB4feP5OH9nvHL90BRaiUgcGiQOCQkRh+4LEQl28WZ1RQmudJJUy8pY
	VsWqt3QYxeVnYAcT9HMetntZsbldhf67BwrknYd8vjz2ud8vndXYTyMD7554R2dQxw7FZh/Z
	B6mlE88xS3UeGufajEnj9PsfxWHKmc8iwr+JyvMRJh7TF5wyxLho3y5t76z1fhpj22W0LMnc
	+bW8vPJhnSXWsCexrsQjSWYjz65E+Sq6/xn09T5YHKlddDsXVmOKP/pj0sMvvn9J3xdV6Nxk
	2BN57vVJfdwM97F1xNzTlvP4Y8+w9PqS93h839MS73zZckP2UG5V1BR6429G17pCbWfkWfXK
	xuM7lmWSlpzVOS47bGbeShf5lD1xMkYoxJmeO6MkwgsFQv9YajxxLDtbPe/TM5V1hiMgNMlS
	kT+u1kj/BUBCJ9ewBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRjHec85Ho/W8rQpvdp9Isksa1Dx0o0Iq9PKyvoQFGIjjxp5WZsr
	MyVrlbVIlxfIqa3MJtpF28VZXlnW2iy01iql2QWX3VQs1FJntSzo25//7/c8PPBQOLeDCKL2
	J6ey0mRxIp/0JWrv8ecuGhWcYpcUORGqtj3A0eDQGIFOqNw4uu7MJdHne18B6mnJBuhyWSmB
	OlvuYKihLA9DldfvYyjP/Bwgl0ONocauMHTldDmBGhqtBLLfLSGRRuvyRude1JGowjKBoZcq
	F0AXzjgwVNdzHKDaMQ2Obn0eINDDrpmo3W3xWhvE3FE7vZn27tsEY38sZ3RVZ0lGX36M+aAv
	Akx9ZxbJXM3J92LOK/pJZtDVRTADTQ6SyTFUAUbfdpT5ppvD6Hr6sO1+u31XxbKJ+w+x0sVr
	9vomNPd1EJJ6vzR70+osYJmqBD4UpJfCgfdGXAl8KS5dD6DJ8chrEgRCrbsVn8w8WDnR6z0p
	KTA4PnbpN6Aokg6DbT8pT+9P1+Hwx00F5hnA6Rs4NJRyPA6PjobvtCJPTdAhcKjhCenJHHoF
	bG794u1RIL0Y5r6e7ql96JWwd/TqnxO4vxVrr/6vPh1ai3qIye1zocJYjKsArf4Pqf9DlwFW
	BQJZiSwpPmmfUCJMZg+Hy8RJMnlyfPi+lCQd+PN0QWgd6NZMhJsBRgEzgBTO9+ekLDzJcjmx
	4iPprDQlRipPZGVmMJMi+DM4wovFsVw6XpzKHmBZCSv9RzHKJygLU/OqQ3abm/tWlnUctOnc
	ji2qYHdIxUiL5YC9MmbKsqcFG2rfpJovaoNfFWTGjkYN+y2/YQ5N31E4Q3Nf1FWSLR2xuXjP
	OGEBTTtFkraATy+pdKOrtdqoBLPdq05bC53guWBPBs+Urr40zdQWudWl9P8umjWqWT8vxzmh
	wq8dFa1Tx+/KN7QSmzvtt2SFJeMWXKN8ckUyRZC/LaO21zAsLx04F2yy2R9EhibO2RW0KUT7
	vYK7jdvuFRe9MebN9rfCoULzx+Vu+jEZV6Oe/yg6Yrg/A1Z0K2wBCYbxExEf7taU57zO3dO4
	OZcwRfkZ5TWzbbR2xBo1lLkAT9Ov4ROyBLFQgEtl4l80qWJJYwMAAA==
X-CMS-MailID: 20231222062147epcas5p4353805c045bac87c459f488d0f5b8c86
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231222062147epcas5p4353805c045bac87c459f488d0f5b8c86
References: <20231222061313.12260-1-nj.shetty@samsung.com>
	<CGME20231222062147epcas5p4353805c045bac87c459f488d0f5b8c86@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_233236_663206_AE5364C5 
X-CRM114-Status: GOOD (  20.80  )
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

For direct block device opened with O_DIRECT, use copy_file_range to
issue device copy offload, or use generic_copy_file_range in case
device copy offload capability is absent or the device files are not open
with O_DIRECT.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/fops.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 0abaac705daf..6ca46ea1f358 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -747,6 +747,30 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
+				      struct file *file_out, loff_t pos_out,
+				      size_t len, unsigned int flags)
+{
+	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
+	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
+	ssize_t copied = 0;
+
+	if ((in_bdev == out_bdev) && bdev_max_copy_sectors(in_bdev) &&
+	    (file_in->f_iocb_flags & IOCB_DIRECT) &&
+	    (file_out->f_iocb_flags & IOCB_DIRECT)) {
+		copied = blkdev_copy_offload(in_bdev, pos_in, pos_out, len,
+					     NULL, NULL, GFP_KERNEL);
+		if (copied < 0)
+			copied = 0;
+	} else {
+		copied = generic_copy_file_range(file_in, pos_in + copied,
+						 file_out, pos_out + copied,
+						 len - copied, flags);
+	}
+
+	return copied;
+}
+
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
 		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
@@ -851,6 +875,7 @@ const struct file_operations def_blk_fops = {
 	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
+	.copy_file_range = blkdev_copy_file_range,
 };
 
 static __init int blkdev_init(void)
-- 
2.35.1.500.gb896f729e2


