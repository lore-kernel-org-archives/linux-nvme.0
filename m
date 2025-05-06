Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1584FC3ABBE
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 16:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EXxGmU6aDCPfoWn8iCPhL+6RC10HrMWdYq5g/ZNmkgY=; b=abAsRD+JtVThgTcLJmKoSkqrRl
	3A7sCmbTf4L4cNWFQ447aANYwf384TD7g7YmudvCNYXpUQ/gAPplYbBRaLLnPb7M8ID1veVe4NpcK
	d+FwpNRjk4sTRSqeb6BGy0KgdWX0onVGOVNx3TOrv8bppXXBlAHEVmkmULBK4UunkXCHVewn+52Rb
	VbWV0m5MNEm+4+chnblle+HWJiQtUOXNJUYDHGQcxw2Zf9ApnlRelh/AgUiU3hE4KF6GxOuEPEQH1
	rXtnP/dOobW+5p+kdHp5M7QkYbnoyxhgmfPR4QNF9BZr2z3xeQqCd1KUnXACdU+L8OJtSmXfddGtI
	N5j9ol8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKjG-0000000CaCf-09PJ;
	Tue, 06 May 2025 16:01:10 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCHNm-0000000Bu7o-1f8q
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 12:26:55 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250506122643epoutp024cf6931cfb32b5c574845885751fb05d~878lxFH_g0463604636epoutp02Z
	for <linux-nvme@lists.infradead.org>; Tue,  6 May 2025 12:26:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250506122643epoutp024cf6931cfb32b5c574845885751fb05d~878lxFH_g0463604636epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746534404;
	bh=EXxGmU6aDCPfoWn8iCPhL+6RC10HrMWdYq5g/ZNmkgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qR0Ah4uX8H9gxCdYM9UkfqhxMHL0CnobKeWcxWjWCWq1Qr6ktcf++7EUlKwCaAPF3
	 IwLwhT8pjLr5fXVQo9FGzNmZw4omCaAhWfgIr+92fx7Xd2p6jB+jqQ2xozdEWAaTbJ
	 atTmdSrOrlf8W1u4qGV0S3vlVyqc/S3sfbyL60A0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250506122643epcas5p3b0574413a9631966738d5970fbbd2b6d~878k_JyeO0387503875epcas5p3R;
	Tue,  6 May 2025 12:26:43 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.176]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ZsHh139xpz6B9m5; Tue,  6 May
	2025 12:26:41 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250506122640epcas5p43b5abe6562ad64ee1d7254b1215906d4~878iqKwUC2065220652epcas5p4w;
	Tue,  6 May 2025 12:26:40 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250506122640epsmtrp1d9d5ce74dbb9c3eb0dc030f7234af567~878ipcdSV2555625556epsmtrp17;
	Tue,  6 May 2025 12:26:40 +0000 (GMT)
X-AuditID: b6c32a28-46cef70000001e8a-e7-681a000018fe
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0E.E5.07818.0000A186; Tue,  6 May 2025 21:26:40 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250506122638epsmtip2bc5bc95e5d6f3c8d9175e52eaf5c84cb~878hDgoda1704417044epsmtip2S;
	Tue,  6 May 2025 12:26:38 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org, Hannes
	Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v16 04/11] block: introduce a write_stream_granularity queue
 limit
Date: Tue,  6 May 2025 17:47:25 +0530
Message-Id: <20250506121732.8211-5-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250506121732.8211-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvC4Dg1SGwdIrShZzVm1jtFh9t5/N
	Ys+iSUwWK1cfZbJ413qOxeLo/7dsFpMOXWO02HtL22LP3pMsFvOXPWW32PZ7PrMDt8fOWXfZ
	PS6fLfXYtKqTzWPzknqP3Tcb2Dz6tqxi9Nh8utrj8ya5AI4oLpuU1JzMstQifbsEroxbL/Yz
	FtyVqDj/lbOBcb9oFyMnh4SAicTWE5fZuxi5OIQEdjNK3Ds8kxkiIS7RfO0HO4QtLLHy33Oo
	oo+MEk0Tt7F0MXJwsAloSlyYXApSIyIQIPFy8WNmkBpmgQ+MEnsmzmYESQgLBEnMbv4ENpRF
	QFXizepFTCC9vALmEn17CyDmy0vMvPQdbBengIXE8j2zwFqFgEpeHD0CFucVEJQ4OfMJC4jN
	DFTfvHU28wRGgVlIUrOQpBYwMq1ilEwtKM5Nz002LDDMSy3XK07MLS7NS9dLzs/dxAiOCC2N
	HYzvvjXpH2Jk4mA8xCjBwawkwnv/vmSGEG9KYmVValF+fFFpTmrxIUZpDhYlcd6VhhHpQgLp
	iSWp2ampBalFMFkmDk6pBqaJD4PNP+hkxfSLXnDu99lmJWb/6IX/jcKeeT+mzOQ+uavE9FyY
	U73Y5UVibN/qci4uiOs9ufJ9xJ7ka4t7Fs5NK9C+25np38cgep15R0f/ySsC63Ze2fIoL7RO
	ouvF/ZoVlr+kMl9kFig8P6dbvXyDtbfbar4GvySnQpfnh9bNDOBjYDruPdfuevnxJjuV3L9F
	LJmbPNI2rd/85kT4hJjUl+t4yo9zhp9KuhpkxfovxOEzyx6plbPqUi0vcZ4K7Z05W0VkGovU
	9unnTl1mlXwozNK36G76p+2aax3DgtmPS82dr79N58Ue5/3L/RfMX7ma90PEsQ91z1ekV8/h
	qLv9QGR9xq13OR/3qZ5W+9ekxFKckWioxVxUnAgA6vArCPcCAAA=
X-CMS-MailID: 20250506122640epcas5p43b5abe6562ad64ee1d7254b1215906d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250506122640epcas5p43b5abe6562ad64ee1d7254b1215906d4
References: <20250506121732.8211-1-joshi.k@samsung.com>
	<CGME20250506122640epcas5p43b5abe6562ad64ee1d7254b1215906d4@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_052649_384293_F6E6174C 
X-CRM114-Status: GOOD (  15.51  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 Documentation/ABI/stable/sysfs-block | 8 ++++++++
 block/blk-sysfs.c                    | 3 +++
 include/linux/blkdev.h               | 1 +
 3 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 8bbe1eca28df..4ba771b56b3b 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -555,6 +555,14 @@ Description:
 		supported. If supported, valid values are 1 through
 		max_write_streams, inclusive.
 
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
index 986cdba4f550..ed00dedfb9ce 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -135,6 +135,7 @@ QUEUE_SYSFS_LIMIT_SHOW(max_discard_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_integrity_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_segment_size)
 QUEUE_SYSFS_LIMIT_SHOW(max_write_streams)
+QUEUE_SYSFS_LIMIT_SHOW(write_stream_granularity)
 QUEUE_SYSFS_LIMIT_SHOW(logical_block_size)
 QUEUE_SYSFS_LIMIT_SHOW(physical_block_size)
 QUEUE_SYSFS_LIMIT_SHOW(chunk_sectors)
@@ -490,6 +491,7 @@ QUEUE_LIM_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_LIM_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
 QUEUE_LIM_RO_ENTRY(queue_max_segment_size, "max_segment_size");
 QUEUE_LIM_RO_ENTRY(queue_max_write_streams, "max_write_streams");
+QUEUE_LIM_RO_ENTRY(queue_write_stream_granularity, "write_stream_granularity");
 QUEUE_RW_ENTRY(elv_iosched, "scheduler");
 
 QUEUE_LIM_RO_ENTRY(queue_logical_block_size, "logical_block_size");
@@ -645,6 +647,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
 	&queue_max_write_streams_entry.attr,
+	&queue_write_stream_granularity_entry.attr,
 	&queue_hw_sector_size_entry.attr,
 	&queue_logical_block_size_entry.attr,
 	&queue_physical_block_size_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3747fbbd65fa..886009b6c3e5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -403,6 +403,7 @@ struct queue_limits {
 	unsigned short		max_discard_segments;
 
 	unsigned short		max_write_streams;
+	unsigned int		write_stream_granularity;
 
 	unsigned int		max_open_zones;
 	unsigned int		max_active_zones;
-- 
2.25.1


