Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A41FC3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 19:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pHU/I5rNCozmnRpyyo72PTUdxupzW7SjZaMb5JsZIg4=; b=h/j9DgUe3Pqyrehfgr8jn4+Xuo
	ZogVlncJPWjlhBOGwLcnfzV23/oM4yiIfE5lrs0wWUeBSSd8sDKsKsLi+mFGX7LCPOOwmL2iDn2VY
	yraztGeTCfvIPXmgrk2rA3MnrOs/XN5TrOHsqosdFSG0UE0KPSSTJbmzK59qShItfGcvuMl/RC6K4
	0Q4KDboU8ox2vQtgLMelXRkPNexikbG4MUzEuzIuHEZUY4+WUIn9c56QwR/wAlhmOpwdaICeK0zy+
	zso64TafCzmjBWfzwaT+2EKFfOolk9VovEcB4nchpAbbrQ8MOSko4XIpIoMpmhnGVH7vhg/5TaNA0
	abW1G7Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCkEB-0000000GYl9-2gZ4;
	Wed, 07 May 2025 19:14:47 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCkE9-0000000GYkR-3Kco
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 19:14:47 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 547IchRc030013
	for <linux-nvme@lists.infradead.org>; Wed, 7 May 2025 12:14:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=pHU/I5rNCozmnRpyyo
	72PTUdxupzW7SjZaMb5JsZIg4=; b=k+Gbnn70oqcHB4NJD8zL9mDfIlse2Fr7L3
	QXDoLTw9h0kBeP+uoY/GmWfPIGk4ki5a/vrHbIf7Ge/hgLsJqDiPyAVEwBSvv2Xz
	IMYmmFZTengdWXG92l9WDnfpTTbuTaLOFg0DCCjUbymYkXnRVlFg/3CdGFxiWxVF
	yhsBR6jEITe6HI3ueCtxhYFBLBTawNfPk7x8HMqFVZYD+MdjsILwWxwLZcShjZHh
	n/cptZaqTcqU1PrKWDo3mC/Je2mvPyb6KGTUDQUWtLEZ+mv/7Teis/qRa7DZvg/o
	eeACdT14h8URAp5KGT9ltdBqu0pD2NKZDkpglQnK5VBIGDZ60ZTg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 46gcyk09fu-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 07 May 2025 12:14:44 -0700 (PDT)
Received: from twshared35278.32.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 7 May 2025 19:14:41 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 0F6371B75A86A; Wed,  7 May 2025 12:14:33 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        Keith Busch
	<kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens
 Axboe <axboe@kernel.dk>
Subject: [PATCHv2] block: always allocate integrity buffer
Date: Wed, 7 May 2025 12:14:24 -0700
Message-ID: <20250507191424.2436350-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE3NSBTYWx0ZWRfX2A0orx/93VfS w7IpAN2Gajo5ys86j23AAp36kjtyLr/vlszfGFPfED4b46Q2M59qhHg9Ae/y0fBiLQbEBmS2JXi upxzq6YkYOcbRlKhJiTuSnrNAUuw7eyO5MMfh9g+WNvZYwev18bmkGyjmCr0EGseDP/18j+qQys
 sFdIWJIpryD5j5ium9mBF/wvvjfQppWYrtQahW4zLYiXOsxxKjFmN0+AzuA3m4dODY05NpTxPLK 1IifhyMN/1c0+xUP3bvj3jiAEc2f8C9mdMtBSlvk512LLbGxiUDsrfixDJqma9y80T0y/vgAomg IUm0fGdFcIJibcv1RnNBkkn8SHftnFsLM8rJtonLXp0zWEoPZaOlGZpV62wyZrJqKWcOrYP1HHq
 VjlDMCYtAUUqAPppF5VolQ4ru4jbKVxyagobnnrbJppxCtXQ9kEKltYxQpk85Il76fPWNqTc
X-Proofpoint-ORIG-GUID: DQLGMERpNGzVllFP8sOowuseVXGuZe35
X-Authority-Analysis: v=2.4 cv=Xtv6OUF9 c=1 sm=1 tr=0 ts=681bb124 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vwLFUpjMM9WbE7oK-M8A:9
X-Proofpoint-GUID: DQLGMERpNGzVllFP8sOowuseVXGuZe35
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_121445_951207_13325CCF 
X-CRM114-Status: GOOD (  18.11  )
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

The integrity buffer, whether or not you want it generated or verified, i=
s
mandatory for nvme formats that have metadata. The block integrity attrib=
utes
read_verify and write_generate had been stopping the metadata buffer from=
 being
allocated and attached to the bio entirely. We only want to suppress the
protection checks on the device and host, but we still need the buffer.

Otherwise, reads and writes will just get IO errors and this nvme warning=
:

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

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  The bip_flags are initialized based on the the bi->flags and don't
  change for the lifetime of the bio. Check this instead to avoid any
  races with bi->flags changing by a user modifying the read_verify and
  write_generate attributes.

  Check if we can skip the verify step before scheduling the deferred
  completion work.

 block/bio-integrity-auto.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index e524c609be506..2c43e27b332ca 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -54,12 +54,12 @@ static void bio_integrity_verify_fn(struct work_struc=
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
+	    bip->bip_flags & BIP_CHECK_GUARD) {
 		INIT_WORK(&bid->work, bio_integrity_verify_fn);
 		queue_work(kintegrityd_wq, &bid->work);
 		return false;
@@ -69,6 +69,16 @@ bool __bio_integrity_endio(struct bio *bio)
 	return true;
 }
=20
+static inline void bio_set_bip_flags(struct blk_integrity *bi, u16 *bip_=
flags)
+{
+	if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_IP)
+		*bip_flags |=3D BIP_IP_CHECKSUM;
+	if (bi->csum_type)
+		*bip_flags |=3D BIP_CHECK_GUARD;
+	if (bi->flags & BLK_INTEGRITY_REF_TAG)
+		*bip_flags |=3D BIP_CHECK_REFTAG;
+}
+
 /**
  * bio_integrity_prep - Prepare bio for integrity I/O
  * @bio:	bio to prepare
@@ -83,6 +93,7 @@ bool __bio_integrity_endio(struct bio *bio)
 bool bio_integrity_prep(struct bio *bio)
 {
 	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
+	unsigned short bip_flags =3D BIP_BLOCK_INTEGRITY;
 	struct bio_integrity_data *bid;
 	gfp_t gfp =3D GFP_NOIO;
 	unsigned int len;
@@ -101,19 +112,22 @@ bool bio_integrity_prep(struct bio *bio)
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
 		if (bi->flags & BLK_INTEGRITY_NOVERIFY)
-			return true;
+			break;
+		bio_set_bip_flags(bi, &bip_flags);
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
+		if (bi->flags & BLK_INTEGRITY_NOGENERATE) {
+			gfp |=3D __GFP_ZERO;
+			break;
+		}
 		if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_NONE)
 			gfp |=3D __GFP_ZERO;
+		bio_set_bip_flags(bi, &bip_flags);
 		break;
 	default:
 		return true;
@@ -134,22 +148,15 @@ bool bio_integrity_prep(struct bio *bio)
=20
 	bid->bio =3D bio;
=20
-	bid->bip.bip_flags |=3D BIP_BLOCK_INTEGRITY;
+	bid->bip.bip_flags =3D bip_flags;
 	bip_set_seed(&bid->bip, bio->bi_iter.bi_sector);
=20
-	if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_IP)
-		bid->bip.bip_flags |=3D BIP_IP_CHECKSUM;
-	if (bi->csum_type)
-		bid->bip.bip_flags |=3D BIP_CHECK_GUARD;
-	if (bi->flags & BLK_INTEGRITY_REF_TAG)
-		bid->bip.bip_flags |=3D BIP_CHECK_REFTAG;
-
 	if (bio_integrity_add_page(bio, virt_to_page(buf), len,
 			offset_in_page(buf)) < len)
 		goto err_end_io;
=20
 	/* Auto-generate integrity metadata if this is a write */
-	if (bio_data_dir(bio) =3D=3D WRITE)
+	if (bio_data_dir(bio) =3D=3D WRITE && bid->bip.bip_flags & BIP_CHECK_GU=
ARD)
 		blk_integrity_generate(bio);
 	else
 		bid->saved_bio_iter =3D bio->bi_iter;
--=20
2.47.1


