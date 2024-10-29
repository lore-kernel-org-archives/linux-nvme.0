Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791C4D3A661
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aps8B5vbC0snCPQCS1odsvarjIZlBhTaPnTsg871jzs=; b=1MI+MwprCsnTv3Qvbj0BQ6VPSp
	7aKbFwEv7n2hWdn0wi3QMuq9QicZCz8gvQ7mEGgWU1Ym+/ErxzR5m/FC6XE/ZpYNwdWmsbREf17dA
	AIFpG/mnBubrJAiqw1nU2X7B9Nea/9jrbT7EZ5O1iHvASbIggSOh51dyFmCEqzH9htuZtxp8REGSJ
	mg9KZ+UAAka6cVhn3f/COddeWiA9Sh+7rRYPcI+N0WbI4BS/OZiYvgcWfOCT/G8aJpt2fan92eJRN
	gtbQJefP2pCzD78CTtC1XKhlURFQQ7B7Xn9Oda7I6NUauIZO2VZhvyF7Xb8Bsxk/UGlHPmU20hEns
	jv4yyYjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5o3S-0000000EtVe-25eP;
	Tue, 29 Oct 2024 15:22:46 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5o0e-0000000Esd4-2qCu
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:19:54 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEaXlk009750
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 08:19:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=aps8B5vbC0snCPQCS1odsvarjIZlBhTaPnTsg871jzs=; b=CCoMFHMVFLtC
	8TG79XGavrREbxROokffs4StQPUxSVy942Ee4PC6TqUWrkPjxbQSb6or157j9YYm
	JcN5DLuaeS3+ZJFrMrfU6cA+ApxUsUyAj4sq5YuztHEFJCc4cyYCyDx8jRckiSQc
	fslDE+lhnqbUYSckOl+LcV5fdIERSbHFxa72jGQGYfb6DxlQQkx5mW6dVxs/Ayo5
	LfubTbWLFic9jCmlfys5Jc86q+qqi/5nl8RhakEUWAn2AMZ15wlarplWAkIYMwYJ
	zRtW/FhtrT37CA8LuHhRXNTltlYIzt4P35fQ3GsIvdMe1Bud38irtLmseQrSLSmO
	yX1xEkwfUA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42k1m9rd37-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 08:19:51 -0700 (PDT)
Received: from twshared26373.08.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 29 Oct 2024 15:19:47 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 2AD5E14920EAA; Tue, 29 Oct 2024 08:19:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv10 7/9] block: export placement hint feature
Date: Tue, 29 Oct 2024 08:19:20 -0700
Message-ID: <20241029151922.459139-8-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029151922.459139-1-kbusch@meta.com>
References: <20241029151922.459139-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: f9GUISneeFozXiQMn_D3Kq2MijXJ5vHG
X-Proofpoint-ORIG-GUID: f9GUISneeFozXiQMn_D3Kq2MijXJ5vHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_081952_951565_34851F5D 
X-CRM114-Status: GOOD (  11.75  )
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
index 921fb4d334fa4..7e3bb3cec7032 100644
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
index 85f48ca461049..51e0b99c2210a 100644
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
index 90a19ea889276..c577a607591de 100644
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


