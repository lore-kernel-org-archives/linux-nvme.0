Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB6ECD4F5E
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 17:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7vuoJlKqLY4uwOe8k3Ue3EmvqurnlriSuNEDqRIV/ys=; b=10IA1dJo7Vgvx1nsc8SmtcBR7j
	vtUJ68J3SYYZvOeagwqJrOZWySGlSalqHUzc+mrcfvqbpgkeavfRYyKuYZZqYAFAF2utr0cRwyr2t
	fq6VLZlaDNCxJLIDHChbDSyOZ9/JktBUj201XGa/d/9/OfAE1bu0ruUwXdOljmcNybESoymK/n7l7
	qnM8EFdDS9vEqHD1Ho+IKnib9lWxDRmbNxTJ0DFLCtG6hm5EbCFAA1AOCkA/bzIlmftyndHTYIaps
	TGA//7fGh1Ip3ROEXSoF/CuGDwj2Ho4q4W5GhRpVD+T3XOECElSm2RNesHn7eDLaG79UrMrRshZ6W
	rgmp2Qiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPOAr-00000002Ng4-3wKM;
	Tue, 19 May 2026 17:24:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPOAq-00000002NeP-2rcD
	for linux-nvme@bombadil.infradead.org;
	Tue, 19 May 2026 17:24:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=7vuoJlKqLY4uwOe8k3Ue3EmvqurnlriSuNEDqRIV/ys=; b=jM3Lnd/+Hm30IKL/6gXwW+wwlu
	+1ZQDw2rSjFQpNt83Yfxm+g3I8DynqflJmJS6TFgl2+y4pZw8IhFAeAOJrHJH+77f61Lh/z4WtFzC
	/ihDfwrS5Adr/w4XxbKUdEsbRoQBSmkuTT9ktlMT2eibfplxs/TYHvy3FitSz0N33t+rRGalKBMeV
	p4o2QTo/Lqt05ePS0oVIEjrxh0C/xC3WvPTlCP1GitchMj69w7v6piqyzsN6/gLklHRBo9GSi+Lq7
	ksZtwJqNwkEr+3IbJyfSoCvNGojiVfNXGZo/ilOAjcRuu6niKbIjsprqKHGiQASaiMnlP5XGyNSqp
	4HdWEXWA==;
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPOAm-0000000EvIy-194f
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 17:24:07 +0000
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J05j5Z2658894
	for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 10:24:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=7vuoJlKqLY4uwOe8k3Ue3EmvqurnlriSuNEDqRIV/ys=; b=DTAz9izwsSlk
	QWx3yl3wkRRB5rXVzBHkOp1mO8H1S28v3gh5tVO8lbIFD3thQZV7BGSde4MRLykO
	YXo6RpdPgn72skUXhATPv9YZJSjPb4V+VrvRItKJQcPeWEk8/+re4llOgmS3qB/i
	QgCDLSBPqKwxs9gXwn7fAnwx1u2tb1e2rqpaWjaTypzAprgPlT0wWpbYHWd5eXVy
	HHFN1yuBr7f33LM6CSp6qlb/Tj3kLPPGK+FSS8P8Q1kyY+GFjKleDq5ifNWEyVYH
	PfTgtcryQCke3JG6Q51k/06QEsLB6b1nu+HQNUv6oF8J4FBQioYnSNH8I0WxNQey
	olJD0Rd51w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e7a7e60y3-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 10:24:00 -0700 (PDT)
Received: from twshared13583.32.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 17:23:57 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id CF47B1A7597C4; Tue, 19 May 2026 10:23:37 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <tom.leiming@gmail.com>,
        <coshi036@gmail.com>, <Igor.Achkinazi@dell.com>, <dlemoal@kernel.org>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCH RFC 5/5] block, nvme: add failed_bio callback for multipath bio failover
Date: Tue, 19 May 2026 10:23:26 -0700
Message-ID: <20260519172326.3462354-6-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519172326.3462354-1-kbusch@meta.com>
References: <20260519172326.3462354-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8mN4adICzUgT4iFdbzSIKaX-h38g2NyO
X-Proofpoint-GUID: 8mN4adICzUgT4iFdbzSIKaX-h38g2NyO
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a0c9cb0 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VwQbUJbxAAAA:8 a=D3KcJY3nKZhVSBQcTW0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3NCBTYWx0ZWRfX8nTNL6Kwp5/W
 tIwx4kbiBqAsFJTaqSgFfqlGeLz+I3OV18jVranm+2BDrIYZOb7enxKPINo3PRKi2Ghl1lf7bq0
 DJV/P0lgBDEc4DI4RoF3h6fI3kUiGmVsVs4OVIb/GQSvBAX0Sm/Gt4hl7BUIqNGUHgf6YSvZn+V
 7+mLTPpS5lUbIenFzkxQ2Kp04+vtITVHerj8kux5aA25oIhla5NOqcTsHCRs6zTEsKb3iu5SWbo
 bbUnQaX/ev6OESQMIrNwltDk+ezldrlJWSv0MEgVWmxosBT+SRePUBkBBl+8FDx4T5/Ov+Mp4mT
 k9fVeUSCjPbaV3zRgsQ6zT8YB28MFfQtPSjEcsrH0SFR9DlLjsIcgWhR+htudL3y6A0fush+4Io
 GqeS5ctnsjGdQN8WuZcaa4bwvprRfxFEgvk6gzduHTqXE3ekw1tDV/u78h28e/7etjZy5hPM7GG
 Jp3tpnqT5kutEPAC1Fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_182405_017593_BF5EC8E9 
X-CRM114-Status: GOOD (  21.13  )
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

The nvme driver has long utilized a zero capacity to indicate the path
isn't reachable, which creates a race condition with IO dispatch when
paths are being detached on a live system: when the block layer rejects
a bio early due to a capacity check failure, drivers with multipath
support using the original bio have no interception point to redirect
the bio to another path.

We don't want to have to clone the bio just for this condition, so add a
failed_bio callback to block_device_operations, called from
bio_io_error. If the callback returns true, the driver has taken
ownership of the bio and the error completion is skipped.

Implement the callback for NVMe multipath. nvme_failed_bio redirects
failing bios back to the multipath head device's requeue list for
path re-selection, but only when all three conditions are met:

  - The bio came through the multipath head (REQ_NVME_MPATH)
  - The error is a path-related error (blk_path_error)
  - The path is no longer ready (!NVME_NS_READY)

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c      |  1 +
 drivers/nvme/host/multipath.c | 26 ++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  2 ++
 include/linux/bio.h           |  6 ------
 include/linux/blkdev.h        | 16 ++++++++++++++++
 5 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3032d6ad6b1e..ac33b4dd19127 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2650,6 +2650,7 @@ const struct block_device_operations nvme_bdev_ops =
=3D {
 	.get_unique_id	=3D nvme_get_unique_id,
 	.report_zones	=3D nvme_report_zones,
 	.pr_ops		=3D &nvme_pr_ops,
+	.failed_bio	=3D nvme_failed_bio,
 };
=20
 static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index 263161cb8ac06..250d0719d32cf 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -134,6 +134,32 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *=
subsys)
 			blk_freeze_queue_start(h->disk->queue);
 }
=20
+bool nvme_failed_bio(struct bio *bio)
+{
+	unsigned long flags;
+	struct nvme_ns *ns;
+
+	if (!(bio->bi_opf & REQ_NVME_MPATH))
+		return false;
+	if (!blk_path_error(bio->bi_status))
+		return false;
+
+	ns =3D bio->bi_bdev->bd_disk->queue->queuedata;
+	if (test_bit(NVME_NS_READY, &ns->flags))
+		return false;
+	nvme_mpath_clear_current_path(ns);
+
+	bio->bi_status =3D BLK_STS_OK;
+	bio_set_dev(bio, ns->head->disk->part0);
+
+	spin_lock_irqsave(&ns->head->requeue_lock, flags);
+	bio_list_add(&ns->head->requeue_list, bio);
+	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
+
+	kblockd_schedule_work(&ns->head->requeue_work);
+	return true;
+}
+
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns =3D req->q->queuedata;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ccd5e05dac98f..37d4f037b9a8a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1028,6 +1028,7 @@ void nvme_mpath_unfreeze(struct nvme_subsystem *sub=
sys);
 void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys);
+bool nvme_failed_bio(struct bio *bio);
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *he=
ad);
@@ -1079,6 +1080,7 @@ static inline bool nvme_ctrl_use_ana(struct nvme_ct=
rl *ctrl)
 {
 	return false;
 }
+#define nvme_failed_bio	NULL
 static inline void nvme_failover_req(struct request *req)
 {
 }
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 1a83a6753d70d..4f01033c32ced 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -371,12 +371,6 @@ void submit_bio(struct bio *bio);
=20
 extern void bio_endio(struct bio *);
=20
-static inline void bio_io_error(struct bio *bio)
-{
-	bio->bi_status =3D BLK_STS_IOERR;
-	bio_endio(bio);
-}
-
 static inline void bio_wouldblock_error(struct bio *bio)
 {
 	bio_set_flag(bio, BIO_QUIET);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 17270a28c66d5..75cbf496e0efa 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1686,8 +1686,24 @@ struct block_device_operations {
 	 * driver.
 	 */
 	int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
+	bool (*failed_bio)(struct bio *bio);
 };
=20
+static inline void bio_io_error(struct bio *bio)
+{
+	bio->bi_status =3D BLK_STS_IOERR;
+
+	if (bio->bi_bdev) {
+		const struct block_device_operations *ops =3D
+			bio->bi_bdev->bd_disk->fops;
+
+		if (ops->failed_bio && ops->failed_bio(bio))
+			return;
+	}
+
+	bio_endio(bio);
+}
+
 #ifdef CONFIG_COMPAT
 extern int blkdev_compat_ptr_ioctl(struct block_device *, blk_mode_t,
 				      unsigned int, unsigned long);
--=20
2.53.0-Meta


