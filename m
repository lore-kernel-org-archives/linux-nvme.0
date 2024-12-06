Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F81DE77179
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 22:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H1449KeqBHH2qLyX/UaGXiOFOGfVyFVyzOCCtWJaXls=; b=ec0l+QtHWFv6ybkVsj8nxr91l3
	/5vaRi6eUW/KVIbP8TVkSjxz/w1kDojG4y6qSvnhxiGqriFoVYOyGwqVaaoUepISO7evNiQ5WXjjS
	UvSVJ/fQNFCmdmqx7m3Kgi4/WxPPjWYIydD+eDaD9tql05sJn6T4bUgp/Ql4OyELSlZzWP1AOFJOX
	PSFeHeNSRZ7xeWJLZK/nzhwJh6JLCjKDm3yLV8O9lfuWiqsIDJpaRRgzjzsmzv4YR+AldIe9wr6cc
	VfDEfAiqsOQ6bHm6edBrD8A2R9VNNrdo0tLaRwzY461Ld0CCRinBlTQU9lmNwa63mnMX5Wt4vyqCP
	/N9Mui/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJglL-00000002tpU-3BSE;
	Fri, 06 Dec 2024 22:25:27 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJgjx-00000002tUw-0mTn
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 22:24:02 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6LhG8n032187
	for <linux-nvme@lists.infradead.org>; Fri, 6 Dec 2024 14:24:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=H1449KeqBHH2qLyX/UaGXiOFOGfVyFVyzOCCtWJaXls=; b=mCc/ziz1dBfW
	1J1Purn95Rx/JCJjC75pAXd9cn0heK+ehBEeStpJdJjZtZlEC9EHehNvxzvHmpve
	G2ePNw3J+n0nxJWISLhrAmuKgTDbUuQqyVUcCEh9TOPqlzfwLIrqOBqNZdxmbwT4
	UiJvWT9lcXaeHO8CM+J7ugANhAowBxQQVgtsh3Dgdgp2ogZegM9zARKIFCsc2Wde
	AgtfD0q3DUgYByOLLnqd2eUsT+DVwdCUXWj45UJ7RfhLlM1hWFPNEa/mtL14Kvf6
	RbVo2M5V3Bykf2HGRFlrWS6vxRtL1Oku7uS+86ImhT1Gq6LeBboAjMsL4lLLsmeA
	2nFiq2TDDQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43bx1gmyam-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Dec 2024 14:23:59 -0800 (PST)
Received: from twshared11082.06.ash8.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 22:23:57 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 2AB7F15B8CB79; Fri,  6 Dec 2024 14:18:27 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv12 05/12] block: introduce a write_stream_granularity queue limit
Date: Fri, 6 Dec 2024 14:17:54 -0800
Message-ID: <20241206221801.790690-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206221801.790690-1-kbusch@meta.com>
References: <20241206221801.790690-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ywD3kZPc9oQcS7afZyNVyPeHjFgsL9P_
X-Proofpoint-GUID: ywD3kZPc9oQcS7afZyNVyPeHjFgsL9P_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_142401_356435_8CF6FF72 
X-CRM114-Status: GOOD (  11.24  )
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

Export the granularity that write streams should be discarded with,
as it is essential for making good use of them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 Documentation/ABI/stable/sysfs-block | 8 ++++++++
 block/blk-sysfs.c                    | 3 +++
 include/linux/blkdev.h               | 7 +++++++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/sta=
ble/sysfs-block
index f67139b8b8eff..c454c68b68fe6 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -514,6 +514,14 @@ Description:
 		supported. If supported, valid values are 1 through
 		max_write_streams, inclusive.
=20
+What:		/sys/block/<disk>/queue/write_stream_granularity
+Date:		November 2024
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] Granularity of a write stream in bytes.  The granularity
+		of a write stream is the size that should be discarded or
+		overwritten together to avoid write amplification in the device.
+
 What:		/sys/block/<disk>/queue/max_segments
 Date:		March 2010
 Contact:	linux-block@vger.kernel.org
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index c514c0cb5e93c..525f4fa132cd3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -105,6 +105,7 @@ QUEUE_SYSFS_LIMIT_SHOW(max_discard_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_integrity_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_segment_size)
 QUEUE_SYSFS_LIMIT_SHOW(max_write_streams)
+QUEUE_SYSFS_LIMIT_SHOW(write_stream_granularity)
 QUEUE_SYSFS_LIMIT_SHOW(logical_block_size)
 QUEUE_SYSFS_LIMIT_SHOW(physical_block_size)
 QUEUE_SYSFS_LIMIT_SHOW(chunk_sectors)
@@ -448,6 +449,7 @@ QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
 QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
 QUEUE_RO_ENTRY(queue_max_write_streams, "max_write_streams");
+QUEUE_RO_ENTRY(queue_write_stream_granularity, "write_stream_granularity=
");
 QUEUE_RW_LOAD_MODULE_ENTRY(elv_iosched, "scheduler");
=20
 QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
@@ -583,6 +585,7 @@ static struct attribute *queue_attrs[] =3D {
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
 	&queue_max_write_streams_entry.attr,
+	&queue_write_stream_granularity_entry.attr,
 	&queue_hw_sector_size_entry.attr,
 	&queue_logical_block_size_entry.attr,
 	&queue_physical_block_size_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ce2c3ddda2411..7be8cc57561a1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -400,6 +400,7 @@ struct queue_limits {
 	unsigned short		max_discard_segments;
=20
 	unsigned short		max_write_streams;
+	unsigned int		write_stream_granularity;
=20
 	unsigned int		max_open_zones;
 	unsigned int		max_active_zones;
@@ -1249,6 +1250,12 @@ static inline unsigned short bdev_max_write_stream=
s(struct block_device *bdev)
 	return bdev_limits(bdev)->max_write_streams;
 }
=20
+static inline unsigned int
+bdev_write_stream_granularity(struct block_device *bdev)
+{
+	return bdev_limits(bdev)->write_stream_granularity;
+}
+
 static inline unsigned queue_logical_block_size(const struct request_que=
ue *q)
 {
 	return q->limits.logical_block_size;
--=20
2.43.5


