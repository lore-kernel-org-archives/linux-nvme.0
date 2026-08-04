Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E50C561F8
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xAs/67UepCJv3bXJsEblsHfvUaFup2nJ0LRq74BKbWs=; b=P54TU5hr4cjrgfiQSvYKNuVa5n
	pfzGkmN/JgOXPEOONzDpZyikNVTWkweztGV2eAjfIfM0gpjIi2mg0Vmp95G9jMDqFOteHJDSkwZgD
	9xQvcO6Yvafl9+6umYBc0jm9NQy1ppyiHpzZW+uEVjdNk/MTy16bTcdUIQ+FtLcBJy8RKy01hdItV
	8bowJt0DtvVMHadAEKNK1OcVCrvQRXnYgSexDUXdfk53aaeCl11L53CtBZPilXhyyDGgaxIwU6eEB
	J6lpV3WMMAj25VMmkc4k3Ij1r2F1K1TnShvkThD+XHUcmmArKdCqqftf4DbsKtCXjo8pbJlo/+qRi
	OeFn84pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrIkW-00000002Ssy-34CK;
	Tue, 04 Aug 2026 17:16:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrHwa-00000002Jjt-1vlK
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 16:24:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EEAE06732A; Tue,  4 Aug 2026 18:24:40 +0200 (CEST)
Date: Tue, 4 Aug 2026 18:24:40 +0200
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
Subject: Re: [PATCH v5 07/16] block: introduce dma map backed bio type
Message-ID: <20260804162440.GB12292@lst.de>
References: <cover.1785596451.git.asml.silence@gmail.com> <e26aefbcb383be7092dc76343ce745013e671334.1785596451.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e26aefbcb383be7092dc76343ce745013e671334.1785596451.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_092444_797758_D29FB816 
X-CRM114-Status: GOOD (  24.90  )
X-Mailman-Approved-At: Tue, 04 Aug 2026 10:16:17 -0700
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

On Sat, Aug 01, 2026 at 04:46:19PM +0100, Pavel Begunkov wrote:
> Premapped buffers don't require a generic bio_vec since these have
> already been dma mapped. Repurpose the bi_io_vec space to strore dmabuf
> maps as they are mutually exclusive.
> 
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  block/bio.c               | 15 +++++++++++++--
>  block/blk-merge.c         | 37 +++++++++++++++++++++++++++++++++++++
>  block/fops.c              |  2 +-
>  include/linux/bio.h       |  9 +++++----
>  include/linux/blk-mq.h    |  7 +++++++
>  include/linux/blk_types.h | 14 +++++++++++++-
>  include/linux/bvec.h      |  3 ++-
>  7 files changed, 78 insertions(+), 9 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 898b2f5ef8c8..1602eab05761 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -860,7 +860,11 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
>  	bio->bi_write_hint = bio_src->bi_write_hint;
>  	bio->bi_write_stream = bio_src->bi_write_stream;
>  	bio->bi_iter = bio_src->bi_iter;
> -	bio->bi_io_vec = bio_src->bi_io_vec;
> +
> +	if (op_is_dmabuf(bio->bi_opf))
> +		bio->bi_dmabuf_map = bio_src->bi_dmabuf_map;
> +	else
> +		bio->bi_io_vec = bio_src->bi_io_vec;
>  
>  	if (bio->bi_bdev) {
>  		if (bio->bi_bdev == bio_src->bi_bdev &&
> @@ -1183,16 +1187,23 @@ EXPORT_SYMBOL_GPL(__bio_release_pages);
>  
>  bool bio_iov_iter_set(struct bio *bio, const struct iov_iter *iter)
>  {
> -	if (!iov_iter_is_bvec(iter))
> +	if (!iov_iter_is_bvec(iter) && !iov_iter_is_dmabuf_map(iter))
>  		return false;
>  
>  	WARN_ON_ONCE(bio->bi_max_vecs);
>  
> +	static_assert(offsetof(struct bio, bi_io_vec) ==
> +		      offsetof(struct bio, bi_dmabuf_map));
> +	static_assert(offsetof(struct iov_iter, bvec) ==
> +		      offsetof(struct iov_iter, dmabuf_map));
> +
>  	bio->bi_io_vec = (struct bio_vec *)iter->bvec;
>  	bio->bi_iter.bi_idx = 0;
>  	bio->bi_iter.bi_offset = iter->iov_offset;
>  	bio->bi_iter.bi_size = iov_iter_count(iter);
>  	bio_set_flag(bio, BIO_CLONED);
> +	if (iov_iter_is_dmabuf_map(iter))
> +		bio->bi_opf |= REQ_NOMERGE | REQ_DMABUF;
>  	return true;
>  }
>  
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 258a726071d1..1beedc42a85d 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -9,6 +9,7 @@
>  #include <linux/blk-integrity.h>
>  #include <linux/part_stat.h>
>  #include <linux/blk-cgroup.h>
> +#include <linux/dma-buf-io.h>
>  
>  #include <trace/events/block.h>
>  
> @@ -319,6 +320,28 @@ static inline unsigned int bvec_seg_gap(struct bio_vec *bvprv,
>  	return bv->bv_offset | (bvprv->bv_offset + bvprv->bv_len);
>  }
>  
> +static inline int bio_split_io_at_dmabuf(struct bio *bio,
> +		const struct queue_limits *lim, unsigned *segs,
> +		unsigned max_bytes, unsigned len_align_mask,
> +		unsigned start_align_mask)
> +{
> +	unsigned bytes = min(bio->bi_iter.bi_size, max_bytes);
> +	unsigned seg_shift = bio->bi_dmabuf_map->seg_shift;
> +	unsigned offset = bio->bi_iter.bi_offset & ((1U << seg_shift) - 1);
> +
> +	if ((bio->bi_iter.bi_offset & start_align_mask) ||
> +	    (bio->bi_iter.bi_size & len_align_mask))
> +		return -EINVAL;
> +
> +	/* single contiguous range into the dma-buf */
> +	*segs = 1;
> +
> +	bytes = min(bytes, ((unsigned)lim->max_segments << seg_shift) - offset);

I guess ->seg_shift is some sort of encoding of a max
segment size?

Comments please.

