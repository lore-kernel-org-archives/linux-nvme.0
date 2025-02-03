Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A68C02192
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vD+7nw2tYMtvjJDa1Yiet8R2DOiSYjvA3pTIKc83e0U=; b=fsPiQ0lgykeuKlErP1rs+Maw5E
	2UzazIO4mqODyXdDm77kjLNb2ebEBrjwkbvS0HsYf8Gake8X5+84g4v9shf5WxyU0P/QUYB1Svxbd
	AwxpVf0yj+YCv3cLgO0kDo6bWVooNbXqYFekAqzaU+rQDrFmHJk3FQ5g1lBnOnRo4raRfhRWG0yHL
	dHLrEJEBRACnlQMkiXYlxLUVyKi6+fkCdZkgN3Ljrk99Ajx6i/8twgLTMFPoNFN92LY3omhw3R/hI
	+4Omarms0/Q3MRUGzrnqSKwKcZYTbfF2k51G3rRuhM/zkqD2qy02lsF55triJrXUJyP7d6ttTyB1f
	aKbCaCHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1gA-0000000GMZQ-099e;
	Mon, 03 Feb 2025 19:00:18 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1QJ-0000000GJ0h-2HAO
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 18:43:56 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513IHpkj029078
	for <linux-nvme@lists.infradead.org>; Mon, 3 Feb 2025 10:43:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=vD+7nw2tYMtvjJDa1Yiet8R2DOiSYjvA3pTIKc83e0U=; b=cb5NDdv286fe
	BxtdSO0DIgVsyN/eMzpAwWDAw2FWXpf7to23pxs4TydYyYthX1L2fHZ/6JsCr456
	EdF+Y7LrMPMgzh1rh9bNfDl0vILtN9A80ZofsjxDwga2OwJqQPJTdSdcxxb4ZHoq
	uUVBHBhZ6BkMjKlRxiMj3zJMdBWNVAQyA9aJrkgGHxTtf8Uk6Ug4TbLUXO4vHsLr
	L73fiaOVT3cn6fmjufx3B7VR47hCaTWSkjSvdkavNztAk6Ld1bzlQ/rzv9Sep99K
	+SVVvwQs+7c2DBnrCUWtWVhgs50Jc+fRBCOq9KbOa+yPcqFHe8oYZKchQPvU7aXd
	6NF/b7+tXA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44k2e9ghex-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 03 Feb 2025 10:43:54 -0800 (PST)
Received: from twshared53813.03.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 3 Feb 2025 18:43:52 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 95317179C2627; Mon,  3 Feb 2025 10:41:34 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <io-uring@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <asml.silence@gmail.com>,
        <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        Keith Busch
	<kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Nitesh Shetty
	<nj.shetty@samsung.com>
Subject: [PATCHv2 03/11] block: introduce max_write_streams queue limit
Date: Mon, 3 Feb 2025 10:41:21 -0800
Message-ID: <20250203184129.1829324-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250203184129.1829324-1-kbusch@meta.com>
References: <20250203184129.1829324-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xJ3Yjceq4ivK2qTh1yTW8P3dASu7POzl
X-Proofpoint-GUID: xJ3Yjceq4ivK2qTh1yTW8P3dASu7POzl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_104355_700623_8BA13A84 
X-CRM114-Status: GOOD (  12.46  )
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

Drivers with hardware that support write streams need a way to export how
many are available so applications can generically query this.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[hch: renamed hints to streams, removed stacking]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 Documentation/ABI/stable/sysfs-block | 7 +++++++
 block/blk-sysfs.c                    | 3 +++
 include/linux/blkdev.h               | 9 +++++++++
 3 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/sta=
ble/sysfs-block
index 0cceb2badc836..f67139b8b8eff 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -506,6 +506,13 @@ Description:
 		[RO] Maximum size in bytes of a single element in a DMA
 		scatter/gather list.
=20
+What:		/sys/block/<disk>/queue/max_write_streams
+Date:		November 2024
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] Maximum number of write streams supported, 0 if not
+		supported. If supported, valid values are 1 through
+		max_write_streams, inclusive.
=20
 What:		/sys/block/<disk>/queue/max_segments
 Date:		March 2010
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e09b455874bfd..8b8f2b0f0c048 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -106,6 +106,7 @@ QUEUE_SYSFS_LIMIT_SHOW(max_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_discard_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_integrity_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_segment_size)
+QUEUE_SYSFS_LIMIT_SHOW(max_write_streams)
 QUEUE_SYSFS_LIMIT_SHOW(logical_block_size)
 QUEUE_SYSFS_LIMIT_SHOW(physical_block_size)
 QUEUE_SYSFS_LIMIT_SHOW(chunk_sectors)
@@ -434,6 +435,7 @@ QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_=
kb");
 QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
 QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
+QUEUE_RO_ENTRY(queue_max_write_streams, "max_write_streams");
 QUEUE_RW_LOAD_MODULE_ENTRY(elv_iosched, "scheduler");
=20
 QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
@@ -568,6 +570,7 @@ static struct attribute *queue_attrs[] =3D {
 	&queue_max_discard_segments_entry.attr,
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
+	&queue_max_write_streams_entry.attr,
 	&queue_hw_sector_size_entry.attr,
 	&queue_logical_block_size_entry.attr,
 	&queue_physical_block_size_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 76f0a4e7c2e5d..f92db4b35f4b6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -397,6 +397,8 @@ struct queue_limits {
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
=20
+	unsigned short		max_write_streams;
+
 	unsigned int		max_open_zones;
 	unsigned int		max_active_zones;
=20
@@ -1245,6 +1247,13 @@ static inline unsigned int bdev_max_segments(struc=
t block_device *bdev)
 	return queue_max_segments(bdev_get_queue(bdev));
 }
=20
+static inline unsigned short bdev_max_write_streams(struct block_device =
*bdev)
+{
+	if (bdev_is_partition(bdev))
+		return 0;
+	return bdev_limits(bdev)->max_write_streams;
+}
+
 static inline unsigned queue_logical_block_size(const struct request_que=
ue *q)
 {
 	return q->limits.logical_block_size;
--=20
2.43.5


