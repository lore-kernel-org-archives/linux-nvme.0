Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DEDCD4851
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 08:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hiZZVpKll4YZeQJ1JN84vWj50uFBmUCiz9OajAtYsAw=; b=qILd4LOpUdyrgIQjpRbBBus0y5
	cAzpL5N9IjuqbZb13VrgOZsoTejH+8LmjDFU2XME6p1QCpW6u+Z4VlhUqiFc8BMtKqa2/kGqzL3u/
	TLQqvZ3O0S/eXfwWzbbDdTe7unQWin+zBS9W646WNWTGcRDb/Jcp4LNbMV0zA4Aj8ysxqjV+P7hSu
	CkceNpoA44Jkli+t1ZeZ9RWJ9cgkbJkur5Qj360ySpTD3y2ofRT96IYo5nBUF1Jh7NrGzEe1hxnm7
	761lJySa7DJc07FObtbBl7vGaZVytisWYFmXRy21bsnRfEci+IoOy6rO6OYSZS1lUSsZdav77E0PZ
	KaMc1avQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN56r-00000001lLR-0tok;
	Wed, 13 May 2026 08:38:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN56o-00000001lK5-2toO
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 08:38:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 817E368CFE; Wed, 13 May 2026 10:38:17 +0200 (CEST)
Date: Wed, 13 May 2026 10:38:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
Message-ID: <20260513083817.GC6461@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_013827_093854_5437C8AF 
X-CRM114-Status: GOOD (  23.02  )
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

FYI, I really want SGL support before this get merged, but ignoring that
for now:

> +struct nvme_dmabuf_map {
> +	struct io_dmabuf_map base;
> +	dma_addr_t *dma_list;
> +	struct sg_table *sgt;
> +	unsigned nr_entries;

I'd make dma_list a variable-sized array at the end of the struture to avoid
an extra allocation and pointer derefernece.

>  
> +static void nvme_dmabuf_map_sync(struct nvme_dev *nvme_dev, struct request *req,
> +				 bool for_cpu)
> +{
> +	int length = blk_rq_payload_bytes(req);
> +	struct device *dev = nvme_dev->dev;
> +	enum dma_data_direction dma_dir;
> +	struct bio *bio = req->bio;
> +	struct nvme_dmabuf_map *map;
> +	dma_addr_t *dma_list;
> +	int offset, map_idx;
> +
> +	dma_dir = rq_data_dir(req) == READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
> +	map = container_of(bio->dmabuf_map, struct nvme_dmabuf_map, base);
> +	dma_list = map->dma_list;
> +
> +	offset = bio->bi_iter.bi_bvec_done;
> +	map_idx = offset / NVME_CTRL_PAGE_SIZE;
> +	length += offset & (NVME_CTRL_PAGE_SIZE - 1);

Please initialize the variable at declaration time and use or add proper
helpers to simplify this:

static inline struct nvme_dmabuf_map *
to_nvme_dmabuf_map(struct io_dmabuf_map *map)
{
	return container_of(map, struct nvme_dmabuf_map, base);
}

....

	enum dma_data_direction dma_dir = rq_dma_dir(req);
	struct device *dev = nvme_dev->dev;
	struct bio *bio = req->bio;
	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
	dma_addr_t *dma_list = map->dma_list;
	int offset = bio->bi_iter.bi_bvec_done;
	int mmap_idx = offset / NVME_CTRL_PAGE_SIZE;
	int length = blk_rq_payload_bytes(req) +
		offset & (NVME_CTRL_PAGE_SIZE - 1);

Also a lot of these ints sound like they should be unsigned.

> +
> +	while (length > 0) {
> +		u64 dma_addr = dma_list[map_idx++];
> +
> +		if (for_cpu)
> +			__dma_sync_single_for_cpu(dev, dma_addr,
> +						  NVME_CTRL_PAGE_SIZE, dma_dir);
> +		else
> +			__dma_sync_single_for_device(dev, dma_addr,
> +						     NVME_CTRL_PAGE_SIZE,
> +						     dma_dir);
> +		length -= NVME_CTRL_PAGE_SIZE;
> +	}
> +}

Nothing should be using these __dma_sync helpers that are internal
details. Using them means you call into sync code that should be skipped
on most common server class systems.

Also the for_cpu argument is a bit ugly.  I'd rather have separate
routines as in the core dma-mapping code, even if that means a little bit
of code duplication.

> +static blk_status_t nvme_rq_setup_dmabuf_map(struct request *req,
> +					     struct nvme_queue *nvmeq)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	int length = blk_rq_payload_bytes(req);
> +	u64 dma_addr, prp1_dma, prp2_dma;
> +	struct bio *bio = req->bio;
> +	struct nvme_dmabuf_map *map;
> +	dma_addr_t *dma_list;
> +	dma_addr_t prp_dma;
> +	__le64 *prp_list;
> +	int i, map_idx;
> +	int offset;
> +
> +	nvme_dmabuf_map_sync(nvmeq->dev, req, false);
> +
> +	map = container_of(bio->dmabuf_map, struct nvme_dmabuf_map, base);
> +	dma_list = map->dma_list;
> +
> +	offset = bio->bi_iter.bi_bvec_done;
> +	map_idx = offset / NVME_CTRL_PAGE_SIZE;
> +	offset &= (NVME_CTRL_PAGE_SIZE - 1);
> +	prp1_dma = dma_list[map_idx++] + offset;

Same comments as for the sync helper above.

> +	length -= (NVME_CTRL_PAGE_SIZE - offset);
> +	if (length <= 0) {
> +		prp2_dma = 0;
> +		goto done;
> +	}
> +
> +	if (length <= NVME_CTRL_PAGE_SIZE) {
> +		prp2_dma = dma_list[map_idx];
> +		goto done;
> +	}
> +
> +	if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=
> +	    NVME_SMALL_POOL_SIZE / sizeof(__le64))
> +		iod->flags |= IOD_SMALL_DESCRIPTOR;
> +
> +	prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
> +			&prp_dma);
> +	if (!prp_list)
> +		return BLK_STS_RESOURCE;
> +
> +	iod->descriptors[iod->nr_descriptors++] = prp_list;
> +	prp2_dma = prp_dma;

And I really hate how this duplicates all the nasty PRP building logic,
although right now I don't have a good answer to that.

> +static inline bool nvme_rq_is_dmabuf_attached(struct request *req)
> +{
> +	if (!IS_ENABLED(CONFIG_DMABUF_TOKEN))
> +		return false;
> +	return req->bio && bio_flagged(req->bio, BIO_DMABUF_MAP);
> +}

This is something that should go into the block layer.


