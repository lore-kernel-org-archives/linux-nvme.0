Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047C1C53219
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 07:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xi/js9JPjAay1vvtJel6+1hLrinmfGKez4c3k7FDePM=; b=lbYYwX3Xi/rb1BVhpJPRdphlIh
	1ht0prMdIq/SiQJJg07JExMaUFR7SDPIdlqTedsVYHUoV/ZkPbEnlRigU+0LroFpPErK+yJcb/LR8
	GYhMvTCTqlC+MHwW3qCgRhTqJFDa1WOfhnM30cTwGA1Ugl6wZIs0bN/iaMha2b7/fpDIG7smOflxK
	r+cStOoWOrJNQ4haCMtWNKCf7uINER/qXDOf0ypCnXYoqUHkE0e0C2z6vmWo5CyNieopAfIMaPWba
	6NxurRofacnjQ3tjq3dnw/C8hrd+P8Eczj8Xjw8UckCKSvGIMTcUpWlzAdd1frfTil9IDF9R8Hozx
	bBi+6a/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woyeT-000000076u3-3Upm;
	Wed, 29 Jul 2026 07:24:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woyO4-0000000753q-2Las
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 07:07:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 30BD868AFE; Wed, 29 Jul 2026 09:07:27 +0200 (CEST)
Date: Wed, 29 Jul 2026 09:07:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH v4 06/14] block: introduce dma map backed bio type
Message-ID: <20260729070727.GF9534@lst.de>
References: <cover.1785274111.git.asml.silence@gmail.com> <f97985ac5cfff3d9f7777b93f11456af57e253e2.1785274111.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f97985ac5cfff3d9f7777b93f11456af57e253e2.1785274111.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_000732_903584_7C019F3F 
X-CRM114-Status: GOOD (  24.17  )
X-Mailman-Approved-At: Wed, 29 Jul 2026 00:24:27 -0700
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

> -	bio->bi_io_vec = bio_src->bi_io_vec;
> +
> +	if (op_is_dmabuf(bio->bi_opf)) {
> +		bio->bi_dmabuf_map = bio_src->bi_dmabuf_map;
> +	} else {
> +		bio->bi_io_vec = bio_src->bi_io_vec;
> +	}

No need for the braces.  But given that these are the fields why
even bother doing both sides and not rely on the union?

> +void bio_dmabuf_map_set(struct bio *bio, struct iov_iter *iter)
> +{
> +	WARN_ON_ONCE(bio->bi_max_vecs);
> +
> +	bio->bi_dmabuf_map = iter->dmabuf_map;
> +	bio->bi_vcnt = 0;
> +	bio->bi_iter.bi_offset = iter->iov_offset;
> +	bio->bi_iter.bi_size = iov_iter_count(iter);
> +	bio->bi_opf |= REQ_NOMERGE | REQ_DMABUF;

This seems to be largely copied from bio_iov_bvec_set, but misses
the REQ_CLONE there that we should probably set as well to indicate
that the data descriptor is not owned (although not setting it is
not really a bug).

What about merging these two into a single and easier to use interface
like this:

diff --git a/block/bio.c b/block/bio.c
index cc2bb9183c1a..25393bdd119d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -860,12 +860,9 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_write_stream = bio_src->bi_write_stream;
 	bio->bi_iter = bio_src->bi_iter;
-
-	if (op_is_dmabuf(bio->bi_opf)) {
-		bio->bi_dmabuf_map = bio_src->bi_dmabuf_map;
-	} else {
-		bio->bi_io_vec = bio_src->bi_io_vec;
-	}
+	static_assert(offsetof(struct bio, bi_io_vec) ==
+		      offsetof(struct bio, bi_dmabuf_map));
+	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	if (bio->bi_bdev) {
 		if (bio->bi_bdev == bio_src->bi_bdev &&
@@ -1186,26 +1183,21 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
 
-void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
+bool bio_iov_iter_set(struct bio *bio, const struct iov_iter *iter)
 {
 	WARN_ON_ONCE(bio->bi_max_vecs);
 
+	if (!iov_iter_is_bvec(iter) && !iov_iter_is_dmabuf_map(iter))
+		return false;
+
 	bio->bi_io_vec = (struct bio_vec *)iter->bvec;
 	bio->bi_iter.bi_idx = 0;
 	bio->bi_iter.bi_offset = iter->iov_offset;
 	bio->bi_iter.bi_size = iov_iter_count(iter);
 	bio_set_flag(bio, BIO_CLONED);
-}
-
-void bio_dmabuf_map_set(struct bio *bio, struct iov_iter *iter)
-{
-	WARN_ON_ONCE(bio->bi_max_vecs);
-
-	bio->bi_dmabuf_map = iter->dmabuf_map;
-	bio->bi_vcnt = 0;
-	bio->bi_iter.bi_offset = iter->iov_offset;
-	bio->bi_iter.bi_size = iov_iter_count(iter);
-	bio->bi_opf |= REQ_NOMERGE | REQ_DMABUF;
+	if (iov_iter_is_dmabuf_map(iter))
+		bio->bi_opf |= REQ_NOMERGE | REQ_DMABUF;
+	return true;
 }
 
 /*
@@ -1265,13 +1257,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return -EIO;
 
-	if (iov_iter_is_bvec(iter)) {
-		bio_iov_bvec_set(bio, iter);
-		iov_iter_advance(iter, bio->bi_iter.bi_size);
-		return 0;
-	}
-	if (iov_iter_is_dmabuf_map(iter)) {
-		bio_dmabuf_map_set(bio, iter);
+	if (bio_iov_iter_set(bio, iter)) {
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
 		return 0;
 	}
diff --git a/block/blk-map.c b/block/blk-map.c
index d1d6bbe0ecf1..34816e6e64de 100644
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
index d83cdbab65a6..97fb124a19b2 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -340,17 +340,12 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
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
-	} else if (iov_iter_is_dmabuf_map(iter)) {
-		bio_dmabuf_map_set(bio, iter);
-	} else {
+	/*
+	 * Users don't rely on the iterator being in any particular state for
+	 * async I/O returning -EIOCBQUEUED, hence we can avoid the expensive
+	 * iov_iter_advance() if we could set the bvec/dmabuf directly.
+	 */
+	if (!bio_iov_iter_set(bio, iter)) {
 		ret = blkdev_iov_iter_get_pages(bio, iter, bdev);
 		if (unlikely(ret))
 			goto out_bio_put;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c053e9444514..1eff02a843ef 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -484,8 +484,7 @@ int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 		unsigned len_align_mask);
 
-void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
-void bio_dmabuf_map_set(struct bio *bio, struct iov_iter *iter);
+bool bio_iov_iter_set(struct bio *bio, const struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);

