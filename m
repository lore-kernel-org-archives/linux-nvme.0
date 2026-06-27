Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D3BC43458
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2026 06:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MqfsBjO22oyS+9rLfQyq3JIhryb7923Ij1b+1n+khmA=; b=UBzZ/TGvRBHqTj1gaDBXQNXU5W
	85rkfkRGOFysFhKsvJ9txwDDx3uLpypYZxW3eZ6Za3dTWCUETvsFbik6cgka9E7MRjqJd0fC7TUWC
	shKLDWtKouKxHWeh3jnr4ysCxlc5poZvFjDPWjsjhVAehHQGlD1COLz9Mi7DSTcPqVpd53UEWcnib
	pUIYLcfrZUHeLCFaDPgyJQNOzCXWoQ+Hgx2SMgZa158etv0aMUrn23qGqvuGIbbv8t15YIdj/e/rE
	ffBx8fGcXKybcE15sKC5TyQOs0wU4dGjotUwrzjsNoKHVRRI4LlYOAo3Ieq9lfk+ZbUk8XbWOlKgM
	QrHE/RKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdMOG-0000000CC4q-0PBr;
	Sat, 27 Jun 2026 06:19:44 +0000
Received: from mail-ua1-x968.google.com ([2607:f8b0:4864:20::968])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdMOD-0000000CC3V-1Fut
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jun 2026 06:19:42 +0000
Received: by mail-ua1-x968.google.com with SMTP id a1e0cc1a2514c-96928fc9678so11971241.0
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2026 23:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782541179; x=1783145979; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MqfsBjO22oyS+9rLfQyq3JIhryb7923Ij1b+1n+khmA=;
        b=J/B5wBCj8Jl6geqA3A3zoDKbr+x9vI5S/OQnGHHw4NRERqvQjkz3IQ2QyFsJyugMFJ
         5974kGSHhRXS3dQGED1LpMNWU6GFxN3F0ZyIbMyX3Rr08qTZrCPjSdRZiTkvpSw9Y3P9
         5j6nrwfzm0XgjaTdVvYr4NPMD6IY9dpehI9pTV9NvaDnAhRG1ur2JVfwYDoB9OvxG/9T
         0ngW1AFFzUU98Pn4Ihs6bM778ZioOwbPdCN00uLLVq0XLnpXW+xfAZ+4qGXHfSSu6r21
         AFel5OPRb86V/l+5UkV8CXu3h7wS+bBEB/jOqXzmEN+8Zun9GCIC9L0HMFIUu2tFPMJz
         QvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782541179; x=1783145979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MqfsBjO22oyS+9rLfQyq3JIhryb7923Ij1b+1n+khmA=;
        b=tB+q1abQwoO/e9DRct9ZMMyn2IRBOzm4D9ba4hMXlglvJbmPZsx/6lt++9h5LXVeNx
         wEnRwVKytf6VygBoAbEq8h8Y+yrArmDi06qfHog+R/lV5oCP6/BxzuDJh3Ls2CgYrWZg
         KpviM0GC+DcWT71CRyZWV9cCp+EMh7+Udf0uPyye42uOB+gpzYuv21dmL9sxHzDbWyhJ
         +0OVlJXAmzQJHVJbL4yfi16t6oMUZMmCO6UUksy9JkFC99JJygMBjzAHC8Yxplra1mtf
         /3QOniN5/WOAduLupyG4OyKWsmibwZqlUpwbUr9UsQ0dYL4geVAQ3m+KSgZek1WMCSeq
         pVdg==
X-Forwarded-Encrypted: i=1; AHgh+RqFrIDGmU6mbvmhtepdR/NvTmQRTf8Zg3ArTtE0UkhYJ7R3O0VPhl57Fem4Rh+iGIRaNCQkRoMdRGns@lists.infradead.org
X-Gm-Message-State: AOJu0YzDKt4ElY0Zm+YPxa7AtA+psGSE2Y+askgxMg6bjeOHGph/ETLt
	RY/F+ofA/W6p2hwr0Kjgs5VFgdNtU38koQ7ZJx/YESxmHIFgvyPBgP0keMArxObgJowgMnczTMn
	LbTSPJvyfYNqdVQQC79jzesFK2/3o5r54fE9NmgB0GUo0c2V4QymG
X-Gm-Gg: AfdE7cnUAsNz7B0uggbe6jcB+zwUOsvy/okHHtC7IZ7mw58FDNy3znrnAkPo0ImJKT1
	+wkCB/8wvkISrAYHTFxlq/YWDcaKrZ3qsbsUfwvNdU4gJk5I/D6reTh+OBZCF8U6Uipo2EsyqYr
	ORN5/n/KH7Jq9CPkFGOxb8EiVas/1VhAF/xDfdysrMK0wQJ7c/V+8rEjmQQB/o5ZM9TLQwCtb4q
	xTQvZCSxwtrENOb7lFn9LhL/4/wEMSObCK7OqH66MGQfh36z+hRhyJ0rnkiYSA/ApKeA9WL0nFc
	2l+oRp10igX8SJexDQS3MwDNXEPropWexcjMpQBGKQUpGP93jIh0PL6e1dhKoYQs1DRuZTwitzb
	pXCjlZGCPaz9XTRKiF+lM4NnTnP8M
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1676645137.1.1782541178797;
        Fri, 26 Jun 2026 23:19:38 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-73568fa2fb3sm414403137.15.2026.06.26.23.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 23:19:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id CBBBA402AE;
	Sat, 27 Jun 2026 00:19:37 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C8D0DE40789; Sat, 27 Jun 2026 00:19:37 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [RFC PATCH 1/2] blk-integrity: add BLK_EXPECTED_REF_TAG_CAPABLE
Date: Sat, 27 Jun 2026 00:19:32 -0600
Message-ID: <20260627061933.2187447-2-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627061933.2187447-1-csander@purestorage.com>
References: <20260627061933.2187447-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_231941_351544_ED9828CE 
X-CRM114-Status: GOOD (  16.86  )
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

Add BLK_EXPECTED_REF_TAG_CAPABLE to enum blk_integrity_flags to allow a
device to report support for specifying an expected initial ref tag in
I/O. Make blk_integrity_remap() a no-op if the flag is set, as the ref
tag seed used to generate/verify ref tags in the protection information
can be passed as the expected initial ref tag.

Ref tag remapping is necessary to merge bios with non-contiguous ref tag
seeds, as it converts both bios' ref tags to/from absolute integrity
interval numbers, which are contiguous. So don't merge bios to a
BLK_EXPECTED_REF_TAG_CAPABLE device if the next bio's ref tag seed
doesn't match the ref tag that would follow the end of the first bio.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/blk-integrity.c         | 18 ++++++++++++++++++
 block/t10-pi.c                |  3 ++-
 include/linux/blk-integrity.h |  2 ++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 964eebbee14d..85ebe13f0912 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -139,10 +139,12 @@ EXPORT_SYMBOL_GPL(blk_rq_integrity_map_user);
 
 bool blk_integrity_merge_rq(struct request_queue *q, struct request *req,
 			    struct request *next)
 {
 	struct bio_integrity_payload *bip, *bip_next;
+	struct blk_integrity *bi;
+	u64 intervals;
 
 	if (blk_integrity_rq(req) == 0 && blk_integrity_rq(next) == 0)
 		return true;
 
 	if (blk_integrity_rq(req) == 0 || blk_integrity_rq(next) == 0)
@@ -155,10 +157,17 @@ bool blk_integrity_merge_rq(struct request_queue *q, struct request *req,
 
 	if (bip->bip_flags & BIP_CHECK_APPTAG &&
 	    bip->app_tag != bip_next->app_tag)
 		return false;
 
+	bi = blk_get_integrity(req->bio->bi_bdev->bd_disk);
+	intervals = blk_rq_bytes(req) >> bi->interval_exp;
+	if (bip->bip_flags & BIP_CHECK_REFTAG &&
+	    bi->flags & BLK_EXPECTED_REF_TAG_CAPABLE &&
+	    bip->bip_iter.bi_sector + intervals != bip_next->bip_iter.bi_sector)
+		return false;
+
 	if (req->nr_integrity_segments + next->nr_integrity_segments >
 	    q->limits.max_integrity_segments)
 		return false;
 
 	if (integrity_req_gap_back_merge(req, next->bio))
@@ -169,11 +178,13 @@ bool blk_integrity_merge_rq(struct request_queue *q, struct request *req,
 
 bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 			     struct bio *bio)
 {
 	struct bio_integrity_payload *bip, *bip_bio = bio_integrity(bio);
+	struct blk_integrity *bi;
 	int nr_integrity_segs;
+	u64 intervals;
 
 	if (blk_integrity_rq(req) == 0 && bip_bio == NULL)
 		return true;
 
 	if (blk_integrity_rq(req) == 0 || bip_bio == NULL)
@@ -185,10 +196,17 @@ bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 
 	if (bip->bip_flags & BIP_CHECK_APPTAG &&
 	    bip->app_tag != bip_bio->app_tag)
 		return false;
 
+	bi = blk_get_integrity(req->bio->bi_bdev->bd_disk);
+	intervals = blk_rq_bytes(req) >> bi->interval_exp;
+	if (bip->bip_flags & BIP_CHECK_REFTAG &&
+	    bi->flags & BLK_EXPECTED_REF_TAG_CAPABLE &&
+	    bip->bip_iter.bi_sector + intervals != bip_bio->bip_iter.bi_sector)
+		return false;
+
 	nr_integrity_segs = blk_rq_count_integrity_sg(q, bio);
 	if (req->nr_integrity_segments + nr_integrity_segs >
 	    q->limits.max_integrity_segments)
 		return false;
 
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 71367fd082bd..becf3e316b06 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -545,11 +545,12 @@ static void blk_integrity_remap(struct request *rq, unsigned int nr_bytes,
 	struct blk_integrity *bi = &rq->q->limits.integrity;
 	u64 ref = bio_integrity_intervals(bi, blk_rq_pos(rq));
 	unsigned intervals = nr_bytes >> bi->interval_exp;
 	struct bio *bio;
 
-	if (!(bi->flags & BLK_INTEGRITY_REF_TAG))
+	if (!(bi->flags & BLK_INTEGRITY_REF_TAG) ||
+	    bi->flags & BLK_EXPECTED_REF_TAG_CAPABLE)
 		return;
 
 	__rq_for_each_bio(bio, rq) {
 		__blk_reftag_remap(bio, bi, &intervals, &ref, prep);
 		if (!intervals)
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index c82b2f6fe194..e314d22d9922 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -13,10 +13,12 @@ enum blk_integrity_flags {
 	BLK_INTEGRITY_NOGENERATE	= 1 << 1,
 	BLK_INTEGRITY_DEVICE_CAPABLE	= 1 << 2,
 	BLK_INTEGRITY_REF_TAG		= 1 << 3,
 	BLK_INTEGRITY_STACKED		= 1 << 4,
 	BLK_SPLIT_INTERVAL_CAPABLE	= 1 << 5,
+	/* Device I/O specifies expected initial ref tag independent of LBA */
+	BLK_EXPECTED_REF_TAG_CAPABLE	= 1 << 6,
 };
 
 const char *blk_integrity_profile_name(struct blk_integrity *bi);
 bool queue_limits_stack_integrity(struct queue_limits *t,
 		struct queue_limits *b);
-- 
2.54.0


