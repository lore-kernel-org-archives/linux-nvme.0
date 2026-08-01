Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519B2C55180
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Aug 2026 06:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ojEbSoOEAjcpRPJZN1aYCrlxFzJ3/XljVJRrzaFsbs=; b=K2HC2MbNO7J7h4cz5hwQ0XsE9F
	/ZY/2pxCuA2KRwaCrQfFDSKntSEn9Dik4y9c1LwO5BRaGNygDFosx1nmOSh8/P9LVk/g+DkGGFFdJ
	WFnZtykgYCzgq6vkO6SmexwFNninA5iMW4bEgdl1oRlPybBu6vICqJmDuiC4boRl/L7bQAb6YAm6y
	x8qWa+92oM0yvNvZgFzIcVx4WKo1C8wMVQFtW6tHqhDPQDZR76Ft8pEpSZ5SM2poxOkx7uDJgTeQL
	D/4ElqTL/LUzmEnUu004H9qH7tNkGMOzn3mbSMOt5+k/NOb7nBHcAkICljESgq6Vn4Imszg2IW2np
	1H2iF2cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqPX7-0000000FOMd-0dTx;
	Sun, 02 Aug 2026 06:18:49 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqBxM-0000000Ep4L-04R0
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 15:49:01 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2cab973140bso24785135ad.3
        for <linux-nvme@lists.infradead.org>; Sat, 01 Aug 2026 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599339; x=1786204139; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ojEbSoOEAjcpRPJZN1aYCrlxFzJ3/XljVJRrzaFsbs=;
        b=sB9tRhCWtZnNO5/meqll18kWME4rNe3pN792tylOfgzn/+f6JEjdcU89588TBuDUqb
         ejqpkY4Ok6JSO8m+jsuOttA4XsPX/8fqkIaCYYuc7fNdHuBLp90wpt4uw1Wxt7YGg9Uw
         ISY85oSdGm7wm2SiyzBFb7kxcBYcbK22Xc506KLucNxFMjJQCi0ZSwGSbkWt24WvH9PD
         qBTEHUV/sGQzTe6NX7La71Lnl7FRV3Mj0WM5SEIFzAUfueHeRg4pWnjsqoCpMY/q2YyZ
         QuMfKg36raB9RrGDxw0WYKy/AXO2rDoB/AuX4TJOHM9sX6cpvsBbX0os3Ni/unybBR7C
         fP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599339; x=1786204139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ojEbSoOEAjcpRPJZN1aYCrlxFzJ3/XljVJRrzaFsbs=;
        b=E8Btv7ZQANEhes/8+MSMT2mAV1lhAcGoAPLAAvHYb1ygri+C4J5ZKBleWyEiv+Jb9K
         vIbHcMtomM6739SidaFncg5ULMVZD7StMdDnLMFqErPeqAOzCBSU03i5Ga6VD8J5hYy8
         MfcDbnyn4+Ha9KoiCGDawMKmV1+/sixxbk1dVV7/M6llxn3BjyFaKjF8Zm31r5If/EDf
         9SCTFE2MRIY/3IE4VRCWRl5jYvcczgCX8huySKMvsTWaY1U/NXVFxw1Ti+spwUa2AAPd
         LFf9ZzNuMYuEgkK3rXWUWJj0uXpCiIRZhZa79D3/Gzudvlf9kVfRAzuF5UG0ItatDhwG
         h92Q==
X-Forwarded-Encrypted: i=1; AHgh+RoXWKg0rHaT2dt9V1ctktRcdhVQ+RQvanVdIztE1fBFPh2HsvZ+ozzK4zZp0jFoNCZMrztxBlj/0zP3@lists.infradead.org
X-Gm-Message-State: AOJu0YyzKBtVjuAr/3Cg6t9ZfCZ1rj76FF9eVU2msEfA3V6JdRI9AUE6
	9gAc0uE56/BFgJF1UHNn13WeagwWnb5myzI6IKQwF3pvfqNvVcWU9PlX
X-Gm-Gg: AR+sD10KGYIkqfCelkVFz4h2IVwpYinA8lnm3QfFyUaDgNtfbEvqdXpx9smGVPR1/hv
	etUOrBWSOhQwnqcxUfOdzhKugznI1JhSU9vtjtDxKF10oNtYb/oUgpVgx5zPFdPyO8ekSW7JmZh
	DzRptoPxdVXZry9Itl+EDPw0UIKYsr7wK1/n5vmTUgZETI1c+0L9PqqQRsMcg/x6GJJj9959WH0
	Vg79H0wWzUkdGZKy3dVRJnotZy1wBzR7x/NvSKWP5+lsasFpeLYdLyXIJ/KcnMxZRohyZTGNbrE
	VEMCjBw3lS5WAD0u7+b2UrdZJeMOtk5lR5DURye7aaAGFfB9gwN63o5WWbNyBI3zR7RP0mIH3If
	qaNOk4fB5YHCZkh4q9blDsIJF26QRKMrRL5d9g2iFX5QJ5AMDi7av8i5/uvRwRMAZyiOY9og7mS
	B08ZR81DwAv+Q/nnnCR22qBGUZMog8+pxMBkIOAYKR8WrKFUvrJ5f8mPUbkJjtO4ZDSg4EI/LpJ
	qzfItO7LQb1A/VWo8pdNbYJ+NtfhX+Nscupdpn+WRqrcEw=
X-Received: by 2002:a17:903:19c7:b0:2d0:4021:bb6b with SMTP id d9443c01a7336-2d0520362cdmr40118035ad.0.1785599339056;
        Sat, 01 Aug 2026 08:48:59 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:48:58 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v5 06/16] block: introduce bio_iov_iter_set()
Date: Sat,  1 Aug 2026 16:46:18 +0100
Message-ID: <4686a0e47fc14f3f888967a80d45a6f66044f1e0.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_084900_244182_BB20714D 
X-CRM114-Status: GOOD (  17.87  )
X-Mailman-Approved-At: Sat, 01 Aug 2026 23:18:43 -0700
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

In preparation to supporting dma-buf backed iterators and bios,
introduce bio_iov_iter_set() which attempts to set up the bio directly
from the given iterator. For now, it only supports bvec and expects
users to check the result and fall back to other means if fails, but
later we'll add more types.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c         | 13 ++++++++-----
 block/blk-map.c     |  2 +-
 block/fops.c        | 16 +++++++---------
 include/linux/bio.h |  2 +-
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 00f99d03ac91..898b2f5ef8c8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1181,8 +1181,11 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
 
-void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
+bool bio_iov_iter_set(struct bio *bio, const struct iov_iter *iter)
 {
+	if (!iov_iter_is_bvec(iter))
+		return false;
+
 	WARN_ON_ONCE(bio->bi_max_vecs);
 
 	bio->bi_io_vec = (struct bio_vec *)iter->bvec;
@@ -1190,6 +1193,7 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
 	bio->bi_iter.bi_offset = iter->iov_offset;
 	bio->bi_iter.bi_size = iov_iter_count(iter);
 	bio_set_flag(bio, BIO_CLONED);
+	return true;
 }
 
 /*
@@ -1284,10 +1288,9 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return -EIO;
 
-	if (iov_iter_is_bvec(iter)) {
-		bio_iov_bvec_set(bio, iter);
-
-		if (!bio_iov_bvec_aligned(bio, mem_align_mask))
+	if (bio_iov_iter_set(bio, iter)) {
+		if (iov_iter_is_bvec(iter) &&
+		    !bio_iov_bvec_aligned(bio, mem_align_mask))
 			return -EINVAL;
 
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
diff --git a/block/blk-map.c b/block/blk-map.c
index 615d29bb840e..9cb9605d1f62 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -473,7 +473,7 @@ static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 	bio = blk_rq_map_bio_alloc(rq, 0, GFP_KERNEL);
 	if (!bio)
 		return -ENOMEM;
-	bio_iov_bvec_set(bio, iter);
+	bio_iov_iter_set(bio, iter);
 
 	ret = blk_rq_append_bio(rq, bio);
 	if (ret)
diff --git a/block/fops.c b/block/fops.c
index 3c2099dfef1d..d11923053afe 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -342,15 +342,13 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	bio->bi_end_io = blkdev_bio_end_io_async;
 	bio->bi_ioprio = iocb->ki_ioprio;
 
-	if (iov_iter_is_bvec(iter)) {
-		/*
-		 * Users don't rely on the iterator being in any particular
-		 * state for async I/O returning -EIOCBQUEUED, hence we can
-		 * avoid expensive iov_iter_advance(). Bypass
-		 * bio_iov_iter_get_pages() and set the bvec directly.
-		 */
-		bio_iov_bvec_set(bio, iter);
-	} else {
+	/*
+	 * Users don't rely on the iterator being in any particular
+	 * state for async I/O returning -EIOCBQUEUED, hence we can
+	 * avoid expensive iov_iter_advance(). Bypass
+	 * bio_iov_iter_get_pages() and set the bvec directly.
+	 */
+	if (!bio_iov_iter_set(bio, iter)) {
 		ret = blkdev_iov_iter_get_pages(bio, iter, bdev);
 		if (unlikely(ret))
 			goto out_bio_put;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f9b8903c6a87..0d27e0c72905 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -522,7 +522,7 @@ int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 		unsigned mem_align_mask, unsigned len_align_mask);
 
-void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
+bool bio_iov_iter_set(struct bio *bio, const struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
-- 
2.54.0


