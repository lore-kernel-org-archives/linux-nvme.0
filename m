Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824C1D64083
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 19:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JLqB0bINPP9TBHWvbswRy3CLboznVSFjr0ykLJ11WFw=; b=m9uAE6Wa2gdxe7mkj6cTiwH6VV
	8AOGrbK56hnv3ebpRwHVHPEwmIiE6rbVgOv7iRxQEoHnJejcA2S2nmV8pcDUgAJIO8vMPXJu1f/N/
	SFXVVeSBB1GFNWbYXlSeQ+apb0FXu6d+oSjmLT+ZlgFA/Z8Vh+VmAX5qnHEBO74pOJuJBS5O8AGUL
	muN+XpUM89NYXDJz/OZSfWXc4jRpxN6EmK1NiWlzAaXucI+ACAOpHqKSCTHW7Y5yh6EWFEMYvR4Hi
	6W61mvLE8U8KnDYZpeqsYfxhBDT1EztoH9iadF0rTEGPz5pRALiF39eK9zCF4itcQSh4FGEVpDSzh
	QtSHUPCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Uyd-0000000BmZf-1oJX;
	Fri, 08 Nov 2024 19:49:03 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Uya-0000000BmYs-3cfN
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 19:49:02 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8HPKrI022316
	for <linux-nvme@lists.infradead.org>; Fri, 8 Nov 2024 11:49:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=JLqB0bINPP9TBHWvbswRy3CLboznVSFjr0ykLJ11WFw=; b=GCRfzGRk8Fz7
	NWWUK9RaGJV34qXK/bfT4kLefN/JzfpmbDtW2YQ9/9pIOnjGLACNxzuS21SzmIMo
	VUQ7Iaq/SR/ZV7ihdHa/JDs4PQC3cUKio9eH1S7TyJgR5gV+WZl/Pf/PFbpYbxOx
	J+Sydl3vFVHjYEr7yOIShdnqVuxUljOOigu1Gw2edelmhuMH4/PF7UAonflFnZoZ
	U708qZwsXc3GFN/AaM7SylKsYds6+mrXBf8GHxpsSHrgPZyM93oDqSqYvllASXkI
	849H/JwFLrJWH0IOlM4NW2zrPT/ATGLPu0wy9shNZ+jFROj8SNwj8RMxWJq+VjuS
	kSoL6TGGxA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42sn58a41r-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 08 Nov 2024 11:49:00 -0800 (PST)
Received: from twshared8596.05.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 8 Nov 2024 19:48:55 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id B281E14E3A03D; Fri,  8 Nov 2024 11:36:58 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <axboe@kernel.dk>
CC: <hch@lst.de>, <martin.petersen@oracle.com>, <asml.silence@gmail.com>,
        <javier.gonz@samsung.com>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv11 7/9] block: export placement hint feature
Date: Fri, 8 Nov 2024 11:36:27 -0800
Message-ID: <20241108193629.3817619-8-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241108193629.3817619-1-kbusch@meta.com>
References: <20241108193629.3817619-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: u2yaOIJMD2SAnTTXOIZ7-8bOszi9F5jO
X-Proofpoint-GUID: u2yaOIJMD2SAnTTXOIZ7-8bOszi9F5jO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_114900_941776_25F8C6CD 
X-CRM114-Status: GOOD (  10.51  )
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

Add a feature flag for devices that support generic placement hints in
write commands. This is in contrast to data lifetime hints.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-settings.c   | 2 ++
 block/blk-sysfs.c      | 3 +++
 include/linux/blkdev.h | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index f9f831f104615..b809f31ad84f2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -518,6 +518,8 @@ int blk_stack_limits(struct queue_limits *t, struct q=
ueue_limits *b,
 		t->features &=3D ~BLK_FEAT_NOWAIT;
 	if (!(b->features & BLK_FEAT_POLL))
 		t->features &=3D ~BLK_FEAT_POLL;
+	if (!(b->features & BLK_FEAT_PLACEMENT_HINTS))
+		t->features &=3D ~BLK_FEAT_PLACEMENT_HINTS;
=20
 	t->flags |=3D (b->flags & BLK_FLAG_MISALIGNED);
=20
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1925ea23bd290..6280c5f89b8b7 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -260,6 +260,7 @@ static ssize_t queue_##_name##_show(struct gendisk *d=
isk, char *page)	\
 QUEUE_SYSFS_FEATURE_SHOW(poll, BLK_FEAT_POLL);
 QUEUE_SYSFS_FEATURE_SHOW(fua, BLK_FEAT_FUA);
 QUEUE_SYSFS_FEATURE_SHOW(dax, BLK_FEAT_DAX);
+QUEUE_SYSFS_FEATURE_SHOW(placement_hints, BLK_FEAT_PLACEMENT_HINTS);
=20
 static ssize_t queue_zoned_show(struct gendisk *disk, char *page)
 {
@@ -497,6 +498,7 @@ QUEUE_RW_ENTRY(queue_poll_delay, "io_poll_delay");
 QUEUE_RW_ENTRY(queue_wc, "write_cache");
 QUEUE_RO_ENTRY(queue_fua, "fua");
 QUEUE_RO_ENTRY(queue_dax, "dax");
+QUEUE_RO_ENTRY(queue_placement_hints, "placement_hints");
 QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
 QUEUE_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
 QUEUE_RO_ENTRY(queue_dma_alignment, "dma_alignment");
@@ -626,6 +628,7 @@ static struct attribute *queue_attrs[] =3D {
 	&queue_wc_entry.attr,
 	&queue_fua_entry.attr,
 	&queue_dax_entry.attr,
+	&queue_placement_hints_entry.attr,
 	&queue_poll_delay_entry.attr,
 	&queue_virt_boundary_mask_entry.attr,
 	&queue_dma_alignment_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1477f751ad8bd..2ffe9a3b9dbff 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -333,6 +333,9 @@ typedef unsigned int __bitwise blk_features_t;
 #define BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE \
 	((__force blk_features_t)(1u << 15))
=20
+/* supports generic write placement hints */
+#define BLK_FEAT_PLACEMENT_HINTS	((__force blk_features_t)(1u << 16))
+
 /*
  * Flags automatically inherited when stacking limits.
  */
--=20
2.43.5


