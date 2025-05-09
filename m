Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CA3C3ABC9
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3ehD4X2+c1diIKC/s9g+40dT/ZAYokXAyCM5j8yrStc=; b=ZgG7QNBS4qquWDb8tEZsmVSJZX
	kWRrNjYy+53+skHyHh3V07yj9GMO9KfL/El1mn48Pa8Rk489o5ZJ4b086i9fiYKBVrNX5Ytgr/nNg
	DrZbGOqeIpLajgQQYuLrX0M1OmyaKc9H8w/t0xKpvILZmBuqipXqhR+xwgO2yMsX4hfoYZkCoVXUZ
	xv+mLr3iRqurVk1wkNebBEQJd44bA2aHd4bwlP8mT6X6Apd/j9auad3Un/Pwo2aBRdYMnL81APgaj
	G2IflqTcWapBqp/R/faPw0VgfKPaTu0uP9UDTS1iYMUyLyJ+U9sUC2oyY+yB1DfkvyfxZWlDze0et
	ZUkP8vqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDRnN-00000004TiR-3K4R;
	Fri, 09 May 2025 17:46:01 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDPnu-000000047H4-1NN2
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 15:38:28 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549FX6ZC030408
	for <linux-nvme@lists.infradead.org>; Fri, 9 May 2025 08:38:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=3ehD4X2+c1diIKC/s9
	g+40dT/ZAYokXAyCM5j8yrStc=; b=hSPlSbCDlHDSJQPyiNUo3sD+1qu4mSI+JD
	kBiVSalIxtLgX8xfOVYvpxTByevOFG6hskvMZu7joYfW5O+Hdy0wnfjH1sCZYAHd
	pqD3CdPQRk1SdI9uSP8LmhEsW71KtUN1H0eM7uCRFoJlYnGx5zA6CD37l98lhfIE
	e8Z/o/uEPy97lK5qEX+81DZeMclsPO0KR/qcj2BhrHpTo8tLUOxerLms9YV+a4SL
	FU/d0K1dTAGg/fTQ1Rv0/U+/e6iI7PNKmhHf79mIbxT+qp3yxSSOJa22L5j29PKi
	yMgMdgcLCws4sPGu/mGrKFI3+6nfBAvOkESvXUau+gpABXs6jKXA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46hgeu9nfb-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 09 May 2025 08:38:24 -0700 (PDT)
Received: from twshared0377.32.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Fri, 9 May 2025 15:38:18 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 6711C1B843A36; Fri,  9 May 2025 08:38:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <martin.petersen@oracle.com>, <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4] block: always allocate integrity buffer when required
Date: Fri, 9 May 2025 08:38:02 -0700
Message-ID: <20250509153802.3482493-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pSO5xKt_34ep4yInxyoeh8tmTpV4yH2K
X-Authority-Analysis: v=2.4 cv=fbmty1QF c=1 sm=1 tr=0 ts=681e2170 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=JDxxQ0Vu41mlFdkJbZYA:9
X-Proofpoint-ORIG-GUID: pSO5xKt_34ep4yInxyoeh8tmTpV4yH2K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE1NCBTYWx0ZWRfX21L7J2xTEGeF UsnQ8gRAKZAXKiifd6c1rX0pT4hGDIMNpQEX4SfqG9TfggtybcxXh5/+5vjDfEpCacFdj5Yd6gb UkjSc2wzdHEQ9h8p+mFgNIUCWrFTvthOOKbBAC6SZCQJymDfWO9P+XyBlq7tnnB4cHpxo/+AJLT
 6UoUMPIZY9WHM7X9Mu2WleeZ2NYcLVEQV0hX+vWnQRGXMDgp/0RkuBRoAxbGJZ2eQz++QTc1Vh8 NLDHajtN9z9wzj8wgrWVBwlQ6ekoHwxQ0m7kzMMQur5YaPqZXXz6QP0J/jQXzaNCKFVlb6fq4G4 8ryk8SIyFmZ5bWYZZOpblgxCZ9fGpiYQe1ZWM0V+WNa2OzdWE3ZMR1fXLO7mndco/+32/4r2tdi
 /uSLrVMYrTlSOWyKuZ/0QropmgYfNibaw+K9RcrJYruF2ju4HpCExAXvI9Jp4oRO9CtJIK54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_083826_451595_05085BE2 
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

Many nvme metadata formats can not strip or generate the metadata on the
controller side. For these formats, a host provided integrity buffer is
mandatory even if it isn't checked.

The block integrity read_verify and write_generate attributes prevent
allocating the metadata buffer, but we need it when the format requires
it, otherwise reads and writes will be rejected by the driver with IO
errors.

Assume the integrity buffer can be offloaded to the controller if the
metadata size is the same as the protection information size. Otherwise
provide an unchecked host buffer when the read verify or write
generation attributes are disabled. This fixes the following nvme
warning:

 ------------[ cut here ]------------
 WARNING: CPU: 1 PID: 371 at drivers/nvme/host/core.c:1036 nvme_setup_rw+=
0x122/0x210
 ...
 RIP: 0010:nvme_setup_rw+0x122/0x210
 ...
 Call Trace:
  <TASK>
  nvme_setup_cmd+0x1b4/0x280
  nvme_queue_rqs+0xc4/0x1f0 [nvme]
  blk_mq_dispatch_queue_requests+0x24a/0x430
  blk_mq_flush_plug_list+0x50/0x140
  __blk_flush_plug+0xc1/0x100
  __submit_bio+0x1c1/0x360
  ? submit_bio_noacct_nocheck+0x2d6/0x3c0
  submit_bio_noacct_nocheck+0x2d6/0x3c0
  ? submit_bio_noacct+0x47/0x4c0
  submit_bio_wait+0x48/0xa0
  __blkdev_direct_IO_simple+0xee/0x210
  ? current_time+0x1d/0x100
  ? current_time+0x1d/0x100
  ? __bio_clone+0xb0/0xb0
  blkdev_read_iter+0xbb/0x140
  vfs_read+0x239/0x310
  ksys_read+0x58/0xc0
  do_syscall_64+0x6c/0x180
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v3->v4:

  Assume tuple size and checksum type can be used to infer if the
  host is required to provide an integrity buffer, or if that can be
  offloaded to the device. No need for format specific flags in that
  case.

 block/bio-integrity-auto.c | 62 +++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index e524c609be506..9c66576647920 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -9,6 +9,7 @@
  * not aware of PI.
  */
 #include <linux/blk-integrity.h>
+#include <linux/t10-pi.h>
 #include <linux/workqueue.h>
 #include "blk.h"
=20
@@ -43,6 +44,29 @@ static void bio_integrity_verify_fn(struct work_struct=
 *work)
 	bio_endio(bio);
 }
=20
+#define BIP_CHECK_FLAGS (BIP_CHECK_GUARD | BIP_CHECK_REFTAG | BIP_CHECK_=
APPTAG)
+static bool bip_should_check(struct bio_integrity_payload *bip)
+{
+	return bip->bip_flags & BIP_CHECK_FLAGS;
+}
+
+static bool bi_offload_capable(struct blk_integrity *bi)
+{
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+		return bi->tuple_size =3D=3D sizeof(struct crc64_pi_tuple);
+	case BLK_INTEGRITY_CSUM_CRC:
+	case BLK_INTEGRITY_CSUM_IP:
+		return bi->tuple_size =3D=3D sizeof(struct t10_pi_tuple);
+	default:
+		pr_warn_once("%s: unknown integrity checksum type:%d\n",
+			__func__, bi->csum_type);
+		fallthrough;
+	case BLK_INTEGRITY_CSUM_NONE:
+		return false;
+	}
+}
+
 /**
  * __bio_integrity_endio - Integrity I/O completion function
  * @bio:	Protected bio
@@ -54,12 +78,12 @@ static void bio_integrity_verify_fn(struct work_struc=
t *work)
  */
 bool __bio_integrity_endio(struct bio *bio)
 {
-	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip =3D bio_integrity(bio);
 	struct bio_integrity_data *bid =3D
 		container_of(bip, struct bio_integrity_data, bip);
=20
-	if (bio_op(bio) =3D=3D REQ_OP_READ && !bio->bi_status && bi->csum_type)=
 {
+	if (bio_op(bio) =3D=3D REQ_OP_READ && !bio->bi_status &&
+	    bip_should_check(bip)) {
 		INIT_WORK(&bid->work, bio_integrity_verify_fn);
 		queue_work(kintegrityd_wq, &bid->work);
 		return false;
@@ -84,6 +108,7 @@ bool bio_integrity_prep(struct bio *bio)
 {
 	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_data *bid;
+	bool set_flags =3D true;
 	gfp_t gfp =3D GFP_NOIO;
 	unsigned int len;
 	void *buf;
@@ -100,19 +125,24 @@ bool bio_integrity_prep(struct bio *bio)
=20
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
-		if (bi->flags & BLK_INTEGRITY_NOVERIFY)
-			return true;
+		if (bi->flags & BLK_INTEGRITY_NOVERIFY) {
+			if (bi_offload_capable(bi))
+				return true;
+			set_flags =3D false;
+		}
 		break;
 	case REQ_OP_WRITE:
-		if (bi->flags & BLK_INTEGRITY_NOGENERATE)
-			return true;
-
 		/*
 		 * Zero the memory allocated to not leak uninitialized kernel
 		 * memory to disk for non-integrity metadata where nothing else
 		 * initializes the memory.
 		 */
-		if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_NONE)
+		if (bi->flags & BLK_INTEGRITY_NOGENERATE) {
+			if (bi_offload_capable(bi))
+				return true;
+			set_flags =3D false;
+			gfp |=3D __GFP_ZERO;
+		} else if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_NONE)
 			gfp |=3D __GFP_ZERO;
 		break;
 	default:
@@ -137,19 +167,21 @@ bool bio_integrity_prep(struct bio *bio)
 	bid->bip.bip_flags |=3D BIP_BLOCK_INTEGRITY;
 	bip_set_seed(&bid->bip, bio->bi_iter.bi_sector);
=20
-	if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_IP)
-		bid->bip.bip_flags |=3D BIP_IP_CHECKSUM;
-	if (bi->csum_type)
-		bid->bip.bip_flags |=3D BIP_CHECK_GUARD;
-	if (bi->flags & BLK_INTEGRITY_REF_TAG)
-		bid->bip.bip_flags |=3D BIP_CHECK_REFTAG;
+	if (set_flags) {
+		if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_IP)
+			bid->bip.bip_flags |=3D BIP_IP_CHECKSUM;
+		if (bi->csum_type)
+			bid->bip.bip_flags |=3D BIP_CHECK_GUARD;
+		if (bi->flags & BLK_INTEGRITY_REF_TAG)
+			bid->bip.bip_flags |=3D BIP_CHECK_REFTAG;
+	}
=20
 	if (bio_integrity_add_page(bio, virt_to_page(buf), len,
 			offset_in_page(buf)) < len)
 		goto err_end_io;
=20
 	/* Auto-generate integrity metadata if this is a write */
-	if (bio_data_dir(bio) =3D=3D WRITE)
+	if (bio_data_dir(bio) =3D=3D WRITE && bip_should_check(&bid->bip))
 		blk_integrity_generate(bio);
 	else
 		bid->saved_bio_iter =3D bio->bi_iter;
--=20
2.47.1


