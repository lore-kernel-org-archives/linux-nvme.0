Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AA4C3DA4A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8aC0iu4ntzgbduxwIsWFSVIL0mxp4STZHoEOULQX0RI=; b=31ZqgGzOVlaWfzckkTVd4OMt3J
	g5+XyVaFkerfq7vuf7rpOIB8wHT8vqLuGdye7phSDZQbw3DR8dOuZkj4246IpESQUgNNSJxylxl0D
	NR5egzBSgqs+QpawiHBH3MBegNqFvn05z0eAijZSBYB/RvHk2/MVPhmi5UQUAC0YPADiTL0BdFyhH
	iYyTG1y1awj8EyJR+Vr94JeS9LiwFCCCFlACY1AMTub/V0YdCR1jbMFW3QApL+GZHW190yO8zleC8
	itpI2B6lIUcosYqTgukD32hxBsqucBmnaw+m4npuhYY40ZcwUBqUtNAe0tvseZnv452CherMOpucF
	S1y4CDeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKjG-0000000CaDM-2zS0;
	Tue, 06 May 2025 16:01:10 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCHNm-0000000Bu7O-1f8a
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 12:26:55 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250506122642epoutp016b552414563e53e6e9c2cdef8b1487fe~878kDy-N32804028040epoutp01b
	for <linux-nvme@lists.infradead.org>; Tue,  6 May 2025 12:26:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250506122642epoutp016b552414563e53e6e9c2cdef8b1487fe~878kDy-N32804028040epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746534402;
	bh=8aC0iu4ntzgbduxwIsWFSVIL0mxp4STZHoEOULQX0RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHwExi6pr6dQMg27zg3uk7spIStYQ7EFVrDFG30UDg8IQ3CUxhltSixDggT6aXj+E
	 25ON2uZ7Ky0/YxDFcJK9i1asw1t9YGCRpVl2Psag0C1nDhQGF2XDRfzK1kxOaEVhbh
	 XgHplos/e9wAUdLUrTBlqhfPc3nySk/SYr05Hzu8=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250506122641epcas5p35019744778d94ee4ce88bbde6da04ef6~878jidzAM0387503875epcas5p3M;
	Tue,  6 May 2025 12:26:41 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.181]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ZsHgz6Ytpz6B9m4; Tue,  6 May
	2025 12:26:39 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250506122638epcas5p364107da78e115a57f1fa91436265edeb~878g9s7uU1254712547epcas5p3E;
	Tue,  6 May 2025 12:26:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250506122638epsmtrp101da3f6a9a86b6e08723a626b726585f~878g9A6w62555625556epsmtrp10;
	Tue,  6 May 2025 12:26:38 +0000 (GMT)
X-AuditID: b6c32a2a-d57fe70000002265-59-6819fffe1864
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B1.6E.08805.EFFF9186; Tue,  6 May 2025 21:26:38 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250506122637epsmtip2acc13ee0a12e95a5610fc0d10b7183c9~878fZJoHZ1679416794epsmtip2a;
	Tue,  6 May 2025 12:26:37 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org, Hannes
	Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v16 03/11] block: introduce max_write_streams queue limit
Date: Tue,  6 May 2025 17:47:24 +0530
Message-Id: <20250506121732.8211-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250506121732.8211-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvO6//5IZBju+aVvMWbWN0WL13X42
	iz2LJjFZrFx9lMniXes5Fouj/9+yWUw6dI3RYu8tbYs9e0+yWMxf9pTdYtvv+cwO3B47Z91l
	97h8ttRj06pONo/NS+o9dt9sYPPo27KK0WPz6WqPz5vkAjiiuGxSUnMyy1KL9O0SuDJ+XPrH
	XNAgU9HyqZOpgXGeRBcjJ4eEgInEhZ65rCC2kMBuRompz5Qg4uISzdd+sEPYwhIr/z0HsrmA
	aj4ySuyd8ZSxi5GDg01AU+LC5FKQGhGBAImXix8zg9QwC3xglNgzcTYjSEJYwFNi+ZsNzCD1
	LAKqEr1rqkDCvALmEuf/z2WDmC8vMfPSd7BdnAIWEsv3zGKEuMdc4sXRI+wQ9YISJ2c+YQGx
	mYHqm7fOZp7AKDALSWoWktQCRqZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBEaGl
	tYNxz6oPeocYmTgYDzFKcDArifDevy+ZIcSbklhZlVqUH19UmpNafIhRmoNFSZz32+veFCGB
	9MSS1OzU1ILUIpgsEwenVAMT04R7xtk/2/YvOJeVNMV1hq5wtET28qfXzzF/52gz/dbj2fRb
	hv2il/Mlx+WXT6++yrNC8qawT/ID+0uMHCH/3mb8rm098epPmcvHqvY+kSPSBWurpB6lPtXb
	eezWnuxUdb2bk0S1z9w+lXx5m1bu8/hi5VkzS16cZDqdlpFX1PREUXqi6WdFlycKq6M5JR75
	X3+mX7CmtrC2rMIm/n8s867Lr/h/R4rP2lxW2tozUYavXuLJ1paiZ4ISsr+6/z2MPjzBOMv+
	QeBBTvMpPbGhN2qsSoUFnjDK+ou1FfekfFF7O+98w6OvhVkPAo/NPJ10LtPLSyL0kMXuqqUv
	Ti7Y1JHx8sDz1BWPXrDpulQosRRnJBpqMRcVJwIAIR4M4vcCAAA=
X-CMS-MailID: 20250506122638epcas5p364107da78e115a57f1fa91436265edeb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250506122638epcas5p364107da78e115a57f1fa91436265edeb
References: <20250506121732.8211-1-joshi.k@samsung.com>
	<CGME20250506122638epcas5p364107da78e115a57f1fa91436265edeb@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_052649_380421_6AC8696E 
X-CRM114-Status: GOOD (  18.81  )
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
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 Documentation/ABI/stable/sysfs-block | 7 +++++++
 block/blk-sysfs.c                    | 3 +++
 include/linux/blkdev.h               | 9 +++++++++
 3 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 11545c9e2e93..8bbe1eca28df 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -547,6 +547,13 @@ Description:
 		[RO] Maximum size in bytes of a single element in a DMA
 		scatter/gather list.
 
+What:		/sys/block/<disk>/queue/max_write_streams
+Date:		November 2024
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] Maximum number of write streams supported, 0 if not
+		supported. If supported, valid values are 1 through
+		max_write_streams, inclusive.
 
 What:		/sys/block/<disk>/queue/max_segments
 Date:		March 2010
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1f9b45b0b9ee..986cdba4f550 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -134,6 +134,7 @@ QUEUE_SYSFS_LIMIT_SHOW(max_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_discard_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_integrity_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_segment_size)
+QUEUE_SYSFS_LIMIT_SHOW(max_write_streams)
 QUEUE_SYSFS_LIMIT_SHOW(logical_block_size)
 QUEUE_SYSFS_LIMIT_SHOW(physical_block_size)
 QUEUE_SYSFS_LIMIT_SHOW(chunk_sectors)
@@ -488,6 +489,7 @@ QUEUE_LIM_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
 QUEUE_LIM_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_LIM_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
 QUEUE_LIM_RO_ENTRY(queue_max_segment_size, "max_segment_size");
+QUEUE_LIM_RO_ENTRY(queue_max_write_streams, "max_write_streams");
 QUEUE_RW_ENTRY(elv_iosched, "scheduler");
 
 QUEUE_LIM_RO_ENTRY(queue_logical_block_size, "logical_block_size");
@@ -642,6 +644,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_max_discard_segments_entry.attr,
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
+	&queue_max_write_streams_entry.attr,
 	&queue_hw_sector_size_entry.attr,
 	&queue_logical_block_size_entry.attr,
 	&queue_physical_block_size_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a9bd945e87b9..3747fbbd65fa 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -402,6 +402,8 @@ struct queue_limits {
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
 
+	unsigned short		max_write_streams;
+
 	unsigned int		max_open_zones;
 	unsigned int		max_active_zones;
 
@@ -1285,6 +1287,13 @@ static inline unsigned int bdev_max_segments(struct block_device *bdev)
 	return queue_max_segments(bdev_get_queue(bdev));
 }
 
+static inline unsigned short bdev_max_write_streams(struct block_device *bdev)
+{
+	if (bdev_is_partition(bdev))
+		return 0;
+	return bdev_limits(bdev)->max_write_streams;
+}
+
 static inline unsigned queue_logical_block_size(const struct request_queue *q)
 {
 	return q->limits.logical_block_size;
-- 
2.25.1


