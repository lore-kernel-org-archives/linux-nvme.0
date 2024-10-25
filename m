Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3B6D149F2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 21:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e9c++zYU75GJQkDC+/04bSzW2n4NadoZumcFoHKXFa0=; b=oxuAk057ACJbBYCufV4YjTLWL/
	+L3JeGrZjIU3VRSqJQgGzFXyis9i469jxgaB8U4qGAQETD1Z5AtFGXqBt+WRzjisrH79+HVX/ysg5
	dBVLnYgy9KqcLSxJ2Jn2y8+8jiGITlwbF1IlqBSQg66gdW9YyeWjCYC/LQTPSKyOKgrtjXiZ4vCuU
	il+qdaIKItXws9mr5qMYzltz5B7THFAdmnjH9+7LlqN3DVnuOmIH2cLORvc26m0FGsBYS26tw7x3B
	P1VjpSt3KBzqmEaEl7/a1W5uJVHglDHuysINEepxqCvyLAXdTMsitngUlV37SI7wmOWwHAkD/LjuK
	NqG6GCiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4S2I-00000005KqP-03gU;
	Fri, 25 Oct 2024 21:39:58 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4S21-00000005KkT-3so9
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 21:39:43 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PKXcYw001095
	for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 14:39:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=e9c++zYU75GJQkDC+/04bSzW2n4NadoZumcFoHKXFa0=; b=iRojtxtQcdUl
	gEOes3yBTnT9SsZUgWOd2A5ruV6tEczbb5Bt3qlBBnuNxi4MQj6/5KV6e5TgzBEa
	2WuvcaHxfqf0Lj7smVfn76i5tAOCeLENeNUyfHAe6eiOPlFHRF4wzgohbUF6g85b
	XylB9ccMT+hqx9fG5KcxtkeKNaEKFB/BINQsbr6KLgoOWHsX60lb1fqImFuMbs8o
	Hl84pJOAYSSN7AdaLpLZt/OMRtMkU7Ak0cu3jpwtRoXwnrVY+dUxq3YO21iVgDb5
	jmh21/LFUqF2wKbjX/mDDGDK8FXM3oi0fawBK7OEbcueHlgPdE74p3NJS0ofvEgy
	XN3lPOB9HA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ga1xv7xe-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 14:39:40 -0700 (PDT)
Received: from twshared13460.05.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 25 Oct 2024 21:39:37 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 74CE31476D739; Fri, 25 Oct 2024 14:37:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv9 2/7] block: introduce max_write_hints queue limit
Date: Fri, 25 Oct 2024 14:36:40 -0700
Message-ID: <20241025213645.3464331-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241025213645.3464331-1-kbusch@meta.com>
References: <20241025213645.3464331-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: v6nvkKwnWcoXZD_d3TJ4w0TB4oCCdMxX
X-Proofpoint-GUID: v6nvkKwnWcoXZD_d3TJ4w0TB4oCCdMxX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_143942_124095_B3535924 
X-CRM114-Status: GOOD (  12.84  )
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
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 Documentation/ABI/stable/sysfs-block |  7 +++++++
 block/blk-settings.c                 |  3 +++
 block/blk-sysfs.c                    |  3 +++
 include/linux/blkdev.h               | 12 ++++++++++++
 4 files changed, 25 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/sta=
ble/sysfs-block
index 8353611107154..f2db2cabb8e75 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -506,6 +506,13 @@ Description:
 		[RO] Maximum size in bytes of a single element in a DMA
 		scatter/gather list.
=20
+What:		/sys/block/<disk>/queue/max_write_hints
+Date:		October 2024
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] Maximum number of write hints supported, 0 if not
+		supported. If supported, valid values are 1 through
+		max_write_hints, inclusive.
=20
 What:		/sys/block/<disk>/queue/max_segments
 Date:		March 2010
diff --git a/block/blk-settings.c b/block/blk-settings.c
index a446654ddee5e..921fb4d334fa4 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -43,6 +43,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->seg_boundary_mask =3D BLK_SEG_BOUNDARY_MASK;
=20
 	/* Inherit limits from component devices */
+	lim->max_write_hints =3D USHRT_MAX;
 	lim->max_segments =3D USHRT_MAX;
 	lim->max_discard_segments =3D USHRT_MAX;
 	lim->max_hw_sectors =3D UINT_MAX;
@@ -544,6 +545,8 @@ int blk_stack_limits(struct queue_limits *t, struct q=
ueue_limits *b,
 	t->max_segment_size =3D min_not_zero(t->max_segment_size,
 					   b->max_segment_size);
=20
+	t->max_write_hints =3D min(t->max_write_hints, b->max_write_hints);
+
 	alignment =3D queue_limit_alignment_offset(b, start);
=20
 	/* Bottom device has different alignment.  Check that it is
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 741b95dfdbf6f..85f48ca461049 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -104,6 +104,7 @@ QUEUE_SYSFS_LIMIT_SHOW(max_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_discard_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_integrity_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_segment_size)
+QUEUE_SYSFS_LIMIT_SHOW(max_write_hints)
 QUEUE_SYSFS_LIMIT_SHOW(logical_block_size)
 QUEUE_SYSFS_LIMIT_SHOW(physical_block_size)
 QUEUE_SYSFS_LIMIT_SHOW(chunk_sectors)
@@ -457,6 +458,7 @@ QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_=
kb");
 QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
 QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
+QUEUE_RO_ENTRY(queue_max_write_hints, "max_write_hints");
 QUEUE_RW_LOAD_MODULE_ENTRY(elv_iosched, "scheduler");
=20
 QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
@@ -591,6 +593,7 @@ static struct attribute *queue_attrs[] =3D {
 	&queue_max_discard_segments_entry.attr,
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
+	&queue_max_write_hints_entry.attr,
 	&queue_hw_sector_size_entry.attr,
 	&queue_logical_block_size_entry.attr,
 	&queue_physical_block_size_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 55bec14fe55f9..a8ad41ee07234 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -393,6 +393,8 @@ struct queue_limits {
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
=20
+	unsigned short		max_write_hints;
+
 	unsigned int		max_open_zones;
 	unsigned int		max_active_zones;
=20
@@ -1183,6 +1185,11 @@ static inline unsigned short queue_max_segments(co=
nst struct request_queue *q)
 	return q->limits.max_segments;
 }
=20
+static inline unsigned short queue_max_write_hints(struct request_queue =
*q)
+{
+	return q->limits.max_write_hints;
+}
+
 static inline unsigned short queue_max_discard_segments(const struct req=
uest_queue *q)
 {
 	return q->limits.max_discard_segments;
@@ -1230,6 +1237,11 @@ static inline unsigned int bdev_max_segments(struc=
t block_device *bdev)
 	return queue_max_segments(bdev_get_queue(bdev));
 }
=20
+static inline unsigned short bdev_max_write_hints(struct block_device *b=
dev)
+{
+	return queue_max_write_hints(bdev_get_queue(bdev));
+}
+
 static inline unsigned queue_logical_block_size(const struct request_que=
ue *q)
 {
 	return q->limits.logical_block_size;
--=20
2.43.5


