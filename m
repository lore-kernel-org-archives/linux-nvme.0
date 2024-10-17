Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDD3D374BF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8XyX8u59mNjnQPnGrxzikA04q0KGVl3u3qy1AjZng4g=; b=AKtDXy8LviLSNHQ1m8CzvQ1ng/
	pWe3sWuH7u3I52nO+n/Jbt4wTAPwwZZbj9QR2ao9W3PXyxWWVg7TcO9xsyzT8FkPBKvocUK+bqEYt
	H8JJiigDJ4mDFEsa3yXRFRM4uMKMjtYr+4FHzjG8imLAecE4zb33o/LcAfs/Y7e/azRnD4nucHEY4
	eo/bJWw76BS80TA42CuRdB9+dBridGSvjqtnoRnkYVJU00au4535Ed1J9ukhxEsb7rSDpE3CUKpXw
	v+vh+jDen3VNEC/llFICB6lc6p+WRQpYl42TgfUZKv+e9iPnY3hA6GhOsc4yz5a9j+3WP394Z4C3l
	/9s6zbYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1T5o-0000000FQnJ-26jH;
	Thu, 17 Oct 2024 16:11:16 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1T59-0000000FQVx-2kB0
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 16:10:38 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HChA7R011342
	for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 09:10:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=8XyX8u59mNjnQPnGrxzikA04q0KGVl3u3qy1AjZng4g=; b=IpsQFmON4IMW
	CH/iLUNJvCbdArXLLYsgLxtHPtSmunWocZc6QSNJUgBUeoJdHYieF6TQTIksvdln
	7Z9xPLofaq/X2vsdEDJpYSB3/+UjVzv4sj2ZUn0QEOT0uF2iekQaLEQyctRrWLdX
	a3qhXO7MdefRTbpkdejv4s7txNh2yjT4sESFXtxiAYfC1fNGbxu4rGibsrBrfYLK
	rKsphDuZCxF2Y1Eb+de/UdcJKLurqYJuescb0DpZ73MvSrYZ7iDi+4yWiH1US/Bu
	t5V+xB0T7zDgkhiWoiEfIX1KDgR1Zazem27gFeqbeoJZhg3ePEH9TDn6qMKhn+SC
	6TsjdCIi7g==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 429wsspwkp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 09:10:34 -0700 (PDT)
Received: from twshared4085.05.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 17 Oct 2024 16:10:23 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 2C20E143A4AFC; Thu, 17 Oct 2024 09:10:14 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@kernel.dk>, <hch@lst.de>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv8 4/6] fs: introduce per-io hint support flag
Date: Thu, 17 Oct 2024 09:09:35 -0700
Message-ID: <20241017160937.2283225-5-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017160937.2283225-1-kbusch@meta.com>
References: <20241017160937.2283225-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MQaiV_dwqDRn9IrpNUQvTJdFestOl0W2
X-Proofpoint-GUID: MQaiV_dwqDRn9IrpNUQvTJdFestOl0W2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_091035_853584_F4EB100F 
X-CRM114-Status: GOOD (  13.68  )
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

A block device may support write hints on a per-io basis. The raw block
file operations can effectively use these, but real filesystems are not
ready to make use of this. Provide a file_operations flag to indicate
support, and set it for the block file operations.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c       | 2 +-
 include/linux/fs.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index d0b16d3975fd6..15a63e26161ea 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -869,7 +869,7 @@ const struct file_operations def_blk_fops =3D {
 	.splice_write	=3D iter_file_splice_write,
 	.fallocate	=3D blkdev_fallocate,
 	.uring_cmd	=3D blkdev_uring_cmd,
-	.fop_flags	=3D FOP_BUFFER_RASYNC,
+	.fop_flags	=3D FOP_BUFFER_RASYNC | FOP_PER_IO_HINTS,
 };
=20
 static __init int blkdev_init(void)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 04e875a37f604..026dc9801dc20 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2117,6 +2117,8 @@ struct file_operations {
 #define FOP_HUGE_PAGES		((__force fop_flags_t)(1 << 4))
 /* Treat loff_t as unsigned (e.g., /dev/mem) */
 #define FOP_UNSIGNED_OFFSET	((__force fop_flags_t)(1 << 5))
+/* File system can handle per-io hints */
+#define FOP_PER_IO_HINTS       ((__force fop_flags_t)(1 << 6))
=20
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
--=20
2.43.5


