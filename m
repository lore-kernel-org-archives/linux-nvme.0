Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC2EC3ABC0
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 18:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HmJzFzAFkRF/5tT0VMrsBSy50bXGMAVvFOqr9BZ5g1w=; b=AqXADGQ7Yrkcs6vklYKpsEnLgE
	qLi++rAhQYsLAuetJgFtuVRY/mzE/3keG+oKpUVzMbpgHiO80uX4eWw0FiaCwiLmLfNvA3QxjaYpA
	Os3f0W87IaCP6wX1TNIKko5MlzYGUyjX/dGG6DA4etd0Cl5uBT/HGlL2J8lX9ny+mGJh22A/TVVyx
	pwj95AIjHg8ovwQn1s+OHKOniDRrDBHzDLeWl/+LJh/54SjfE/qe+CrvNW86MU5/Qb33gekCAcoiX
	Ycyvo8es9HUd7oAtLPXAraLgapAqikLArutkMuYCVIaQONW7uxeQcxXLQuuSBCcRq2x7TnbQ3z4jZ
	79t6z89w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD5YW-00000001UU4-2qHx;
	Thu, 08 May 2025 18:01:12 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD5W3-00000001UB1-2Sw6
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 17:58:40 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548HWlua022714
	for <linux-nvme@lists.infradead.org>; Thu, 8 May 2025 10:58:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=HmJzFzAFkRF/5tT0VM
	rsBSy50bXGMAVvFOqr9BZ5g1w=; b=d25tfjuN0kyld0AzTvJ3bjkUS1+8NTxQWq
	bnEP+jLZmXhjpFDLdMvEMq49ByKFaEoIuvhw/sQXm5Ye2HKCuWXqT2bgiMg/bP78
	MkZndMkJzzphBXhtZGBnddMK57uoT1+jjLA72+za0WGXYC2RbP3tsmb1b6aQSiBo
	AQJTitlkPODuuZMGHLa/YoH6efq6UvCJLydf0q7pLeyl4BuopZ7BoYTrMmvSdQec
	sEM1hORscd4ZOEnnyg0rR/YlUZisLDYAB/BtkD7d4ffHI3yPmKz7pH9VpEBys2aB
	AaLCxRPRO9LTNwT4rL5ntptPy7PkTT2FCIIWJQoj+hWa5xrYlXKQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46gh0bx79h-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 08 May 2025 10:58:36 -0700 (PDT)
Received: from twshared18153.09.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 8 May 2025 17:58:27 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id DB9061B7D02E0; Thu,  8 May 2025 10:58:15 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <martin.petersen@oracle.com>, <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block: always allocate integrity buffer when required
Date: Thu, 8 May 2025 10:58:14 -0700
Message-ID: <20250508175814.1176459-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=frzcZE4f c=1 sm=1 tr=0 ts=681cf0cc cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=MMEpNDq4WQhFf5z5bX4A:9
X-Proofpoint-ORIG-GUID: FZ5WvFzAppqz9v3dfJFaVUxxnpw90nbn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE1OSBTYWx0ZWRfXx32/1TFBqtiC j8GsOkv+Alen6AWgMK9RdmkjQXSeO2z4IaPTEIbuh4vUYc25VoLBNR66xRgr5+U4hygbthVuTHd MXQcjV35xOK2CvO7Q9YuITkTRzL+BY40K/w04RN5mMINBfKwK8JozulZ6K3GWD+V1VE2v3rZxe4
 0ywX+n9Xm5GmksUFlb1l5X3slJHDlRvcF0HUhBYZrvioj7nfdHUTe5jvxkje7/Eb7VWfCRIPW9b cfDRVJkc55G3IzqNI/ajZqHzJEz4o25sUP5lnfJUX9BZpRZgm3yY8v2GHHgdWjDEsh9oh9XOdB7 WsSEtMGAgRjbdb4oZA6wBf/dh2if68UnCMTlgmqb2xQEn6ZjTN1fNOlAE6VY2/GG6LxoG0qfuLm
 ABj2cmXBAOvkq7y+RC+JYvVG5jxwOafu/FNHDXKb9Lh14J7TNMJW90dbj4XUFRvWN6ROAi82
X-Proofpoint-GUID: FZ5WvFzAppqz9v3dfJFaVUxxnpw90nbn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_105839_825670_FBE3E924 
X-CRM114-Status: GOOD (  21.12  )
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
controller side. For these, a host provided integrity buffer is
mandatory, even if it isn't checked.

The block integrity read_verify and write_generate attributes prevent
allocating the metadata buffer, but we need it when the format requires
it, otherwise reads and writes will be rejected by the driver with IO
errors.

Add a new blk_integrity flag to indicate if the disk format requires an
integrity buffer. When this flag is set, provide an unchecked buffer if
the sysfs attributes disabled verify or generation. This fixes the
following nvme warning:

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
v2->v3:

  Use a helper function to test if an integrity payload needs to be
  checked. And use all the different kinds of check flags.

  Allocate an unchecked buffer only if the integrity format requires it.
  The nvme formats that don't work with PRACT is the first subscriber to
  this new flag.

 block/bio-integrity-auto.c    | 44 +++++++++++++++++++++++------------
 drivers/nvme/host/core.c      |  3 +++
 include/linux/blk-integrity.h |  1 +
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index e524c609be506..da07212087e06 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -43,6 +43,12 @@ static void bio_integrity_verify_fn(struct work_struct=
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
 /**
  * __bio_integrity_endio - Integrity I/O completion function
  * @bio:	Protected bio
@@ -54,12 +60,12 @@ static void bio_integrity_verify_fn(struct work_struc=
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
@@ -84,6 +90,7 @@ bool bio_integrity_prep(struct bio *bio)
 {
 	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_data *bid;
+	bool set_flags =3D true;
 	gfp_t gfp =3D GFP_NOIO;
 	unsigned int len;
 	void *buf;
@@ -100,19 +107,24 @@ bool bio_integrity_prep(struct bio *bio)
=20
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
-		if (bi->flags & BLK_INTEGRITY_NOVERIFY)
-			return true;
+		if (bi->flags & BLK_INTEGRITY_NOVERIFY) {
+			if (!(bi->flags & BLK_INTEGRITY_BUFFER_REQUIRED))
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
+			if (!(bi->flags & BLK_INTEGRITY_BUFFER_REQUIRED))
+				return true;
+			gfp |=3D __GFP_ZERO;
+			set_flags =3D false;
+		} else if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_NONE)
 			gfp |=3D __GFP_ZERO;
 		break;
 	default:
@@ -137,19 +149,21 @@ bool bio_integrity_prep(struct bio *bio)
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
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af871d268fcb6..f0992a4e59512 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1867,6 +1867,9 @@ static bool nvme_init_integrity(struct nvme_ns_head=
 *head,
 		break;
 	}
=20
+	if (!nvme_ns_has_pi(head))
+		bi->flags |=3D BLK_INTEGRITY_BUFFER_REQUIRED;
+
 	bi->tuple_size =3D head->ms;
 	bi->pi_offset =3D info->pi_offset;
 	return true;
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index c7eae0bfb013f..ad657d086e715 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -13,6 +13,7 @@ enum blk_integrity_flags {
 	BLK_INTEGRITY_DEVICE_CAPABLE	=3D 1 << 2,
 	BLK_INTEGRITY_REF_TAG		=3D 1 << 3,
 	BLK_INTEGRITY_STACKED		=3D 1 << 4,
+	BLK_INTEGRITY_BUFFER_REQUIRED	=3D 1 << 5,
 };
=20
 const char *blk_integrity_profile_name(struct blk_integrity *bi);
--=20
2.47.1


