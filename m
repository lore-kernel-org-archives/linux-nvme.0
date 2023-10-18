Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B65CDB482
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 15:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZuYobI9FB5FgUYWyl3A8aqmEEA9/aSHKCp9svw5nXYo=; b=uLW3mCo8Ptp3TJnrMNUaqgCwTg
	ydGVW/fxgzEjuWG9Co8JXLHVcNbixTMQMhTXqri0RN3+Qo9PzIuI5Z4lX71P5UkamALM5hLl/iWCf
	Tard3C5L4e7Trc9u6rIU+UuYbt5DxE3BUmwQk673JQYbQ2fxoZpT/aWsCvFIWQDglJXCAlCrfUrjq
	mFIVRuZNMNNRYKDAnNuQz2HS4k6oALG0Af9Foh+MLxApiSm5C01TbzMOIHDnvuVyi4vI571wzEP9J
	baiJNas+QZJhdzPSyny32eFDjx1Plcpyw4z32zHBVt0UPfzIWGxcJaohE/DoehNgiqPrbi86QoFLL
	ykWQjJSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt8Pd-00F27K-2P;
	Wed, 18 Oct 2023 15:24:45 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt8Pb-00F25w-0T
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 15:24:44 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39I84NIQ015181
	for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 08:24:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=ZuYobI9FB5FgUYWyl3A8aqmEEA9/aSHKCp9svw5nXYo=;
 b=S6tLdoKL40BlrJRzHUyP9JJ/8sFcIKhJZBqyBAcmrDx2wACJ5ShPufZQlpwVq+/uaw/J
 LQOIKfrCqGaPdH/X4hzfdgw9epSzhqfYFcbchDgSzcLNmPjA7bG7XS2r/tXmeU53MQsz
 WipJA6kTYd5oXer3bc3k1SjAO6E0Il9aCqV73phYlX+B5ucbApSwK/xv3LxbYf3fhd26
 HpKI076LrotZWQgpN1glqpvmAzufZgSqsRZIAtAQ40xdHkxOPI8ZCIUDWltyhg4w+GAO
 wxTNxg9ex6QBK8OJ854p3cIvJmSWw2o1l+wNW+B3ML0DSkUH+W95GSChWj2x3d14tcSN Gw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3ttbhatctk-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 08:24:41 -0700
Received: from twshared5242.08.ash8.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 18 Oct 2023 08:24:32 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 6DD66205F43B2; Wed, 18 Oct 2023 08:19:39 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/4] block: bio-integrity: add support for user buffers
Date: Wed, 18 Oct 2023 08:18:40 -0700
Message-ID: <20231018151843.3542335-2-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018151843.3542335-1-kbusch@meta.com>
References: <20231018151843.3542335-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DMuo2ma7G8QZgoxUUR5eRVXTxr6xIDsJ
X-Proofpoint-ORIG-GUID: DMuo2ma7G8QZgoxUUR5eRVXTxr6xIDsJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_13,2023-10-18_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_082443_297999_F23492F6 
X-CRM114-Status: GOOD (  24.33  )
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

User space passthrough commands that utilize metadata currently need to
bounce the "integrity" buffer through the kernel. This adds unnecessary
overhead and memory pressure.

Add support for mapping user space directly so that we can avoid this
costly copy. This is similiar to how the bio payload utilizes user
addresses with bio_map_user_iov().

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c | 67 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/bio.h   |  8 ++++++
 2 files changed, 75 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index ec8ac8cf6e1b9..08f70b837a29b 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -91,6 +91,19 @@ struct bio_integrity_payload *bio_integrity_alloc(stru=
ct bio *bio,
 }
 EXPORT_SYMBOL(bio_integrity_alloc);
=20
+static void bio_integrity_unmap_user(struct bio_integrity_payload *bip)
+{
+	bool dirty =3D bio_data_dir(bip->bip_bio) =3D=3D READ;
+	struct bvec_iter iter;
+	struct bio_vec bv;
+
+	bip_for_each_vec(bv, bip, iter) {
+		if (dirty && !PageCompound(bv.bv_page))
+			set_page_dirty_lock(bv.bv_page);
+		unpin_user_page(bv.bv_page);
+	}
+}
+
 /**
  * bio_integrity_free - Free bio integrity payload
  * @bio:	bio containing bip to be freed
@@ -105,6 +118,8 @@ void bio_integrity_free(struct bio *bio)
=20
 	if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
 		kfree(bvec_virt(bip->bip_vec));
+	else if (bip->bip_flags & BIP_INTEGRITY_USER)
+		bio_integrity_unmap_user(bip);;
=20
 	__bio_integrity_free(bs, bip);
 	bio->bi_integrity =3D NULL;
@@ -160,6 +175,58 @@ int bio_integrity_add_page(struct bio *bio, struct p=
age *page,
 }
 EXPORT_SYMBOL(bio_integrity_add_page);
=20
+int bio_integrity_map_user(struct bio *bio, void __user *ubuf, unsigned =
int len,
+			   u32 seed, u32 maxvecs)
+{
+	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
+	unsigned long align =3D q->dma_pad_mask | queue_dma_alignment(q);
+	struct page *stack_pages[UIO_FASTIOV];
+	size_t offset =3D offset_in_page(ubuf);
+	unsigned long ptr =3D (uintptr_t)ubuf;
+	struct page **pages =3D stack_pages;
+	struct bio_integrity_payload *bip;
+	int npages, ret, i;
+
+	if (bio_integrity(bio) || ptr & align || maxvecs > UIO_FASTIOV)
+		return -EINVAL;
+
+	bip =3D bio_integrity_alloc(bio, GFP_KERNEL, maxvecs);
+	if (IS_ERR(bip))
+		return PTR_ERR(bip);
+
+	ret =3D pin_user_pages_fast(ptr, UIO_FASTIOV, FOLL_WRITE, pages);
+	if (unlikely(ret < 0))
+		goto free_bip;
+
+	npages =3D ret;
+	for (i =3D 0; i < npages; i++) {
+		u32 bytes =3D min_t(u32, len, PAGE_SIZE - offset);
+		ret =3D bio_integrity_add_page(bio, pages[i], bytes, offset);
+		if (ret !=3D bytes) {
+			ret =3D -EINVAL;
+			goto release_pages;
+		}
+		len -=3D ret;
+		offset =3D 0;
+	}
+
+	if (len) {
+		ret =3D -EINVAL;
+		goto release_pages;
+	}
+
+	bip->bip_iter.bi_sector =3D seed;
+	bip->bip_flags |=3D BIP_INTEGRITY_USER;
+	return 0;
+
+release_pages:
+	unpin_user_pages(pages, npages);
+free_bip:
+	bio_integrity_free(bio);
+	return ret;
+}
+EXPORT_SYMBOL(bio_integrity_map_user);
+
 /**
  * bio_integrity_process - Process integrity metadata for a bio
  * @bio:	bio to generate/verify integrity metadata for
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 41d417ee13499..144cc280b6ad3 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -324,6 +324,7 @@ enum bip_flags {
 	BIP_CTRL_NOCHECK	=3D 1 << 2, /* disable HBA integrity checking */
 	BIP_DISK_NOCHECK	=3D 1 << 3, /* disable disk integrity checking */
 	BIP_IP_CHECKSUM		=3D 1 << 4, /* IP checksum */
+	BIP_INTEGRITY_USER	=3D 1 << 5, /* Integrity payload is user address */
 };
=20
 /*
@@ -720,6 +721,7 @@ static inline bool bioset_initialized(struct bio_set =
*bs)
=20
 extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, g=
fp_t, unsigned int);
 extern int bio_integrity_add_page(struct bio *, struct page *, unsigned =
int, unsigned int);
+extern int bio_integrity_map_user(struct bio *, void __user *, unsigned =
int, u32, u32);
 extern bool bio_integrity_prep(struct bio *);
 extern void bio_integrity_advance(struct bio *, unsigned int);
 extern void bio_integrity_trim(struct bio *);
@@ -789,6 +791,12 @@ static inline int bio_integrity_add_page(struct bio =
*bio, struct page *page,
 	return 0;
 }
=20
+static inline int bio_integrity_map_user(struct bio *bio, void __user *u=
buf,
+					 unsigned int len, u32 seed, u32 maxvecs)
+{
+	return -EINVAL
+}
+
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
=20
 /*
--=20
2.34.1


