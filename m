Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FCCD1F9BA
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QdqWywYRLnjOqYVHKgtj3N4//GIROBVw9oqa0ZS355g=; b=jFx+YZY96LGLcylXf3uvghr/uj
	14UF7MEXNI++SdudGhUvuSyqZVLW2vmFmGfPGdOjDdtEP30i4AQ6dHE0dD0VzUwWYX8bCZLoA8F1s
	iUq+0k2n9sWopwqC1mK4XDv8szTycGyR23fBX+zRMA19s+Y4u9/SakEXSVErhZHmIMqpGOkOk4b6N
	DIG6eKrQMn+IooSbL3Zb/qF5L9l+ifEjiMUY19Dp+LSNUG3NReZcsJwKUEr27ZU/AmrBwg/VQuh9t
	bmp8/t1ocrWNKPaBY/GvCsZzJ94xCbP10n7rcMXUkZl/uR2uNf3EmXU8mv9jBU210ijMhVbpY4Tsv
	NZZ+/n/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR785-00000007tIT-3pww;
	Thu, 04 Dec 2025 11:04:09 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR784-00000007tIE-2op0;
	Thu, 04 Dec 2025 11:04:08 +0000
Date: Thu, 4 Dec 2025 03:04:08 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC v2 07/11] nvme-pci: implement dma_token backed requests
Message-ID: <aTFqqNMR9i89puxB@infradead.org>
References: <cover.1763725387.git.asml.silence@gmail.com>
 <a86bbe2d8d105ed2c342749cd46ece2d1c537821.1763725388.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a86bbe2d8d105ed2c342749cd46ece2d1c537821.1763725388.git.asml.silence@gmail.com>
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

> +static void nvme_sync_dma(struct nvme_dev *nvme_dev, struct request *req,
> +			  enum dma_data_direction dir)
> +{
> +	struct blk_mq_dma_map *map = req->dma_map;
> +	int length = blk_rq_payload_bytes(req);
> +	bool for_cpu = dir == DMA_FROM_DEVICE;
> +	struct device *dev = nvme_dev->dev;
> +	dma_addr_t *dma_list = map->private;
> +	struct bio *bio = req->bio;
> +	int offset, map_idx;
> +
> +	offset = bio->bi_iter.bi_bvec_done;
> +	map_idx = offset / NVME_CTRL_PAGE_SIZE;
> +	length += offset & (NVME_CTRL_PAGE_SIZE - 1);
> +
> +	while (length > 0) {
> +		u64 dma_addr = dma_list[map_idx++];
> +
> +		if (for_cpu)
> +			__dma_sync_single_for_cpu(dev, dma_addr,
> +						  NVME_CTRL_PAGE_SIZE, dir);
> +		else
> +			__dma_sync_single_for_device(dev, dma_addr,
> +						     NVME_CTRL_PAGE_SIZE, dir);
> +		length -= NVME_CTRL_PAGE_SIZE;
> +	}

This looks really inefficient.  Usually the ranges in the dmabuf should
be much larger than a controller page.


> +static void nvme_unmap_premapped_data(struct nvme_dev *dev,
> +				      struct request *req)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +
> +	if (rq_data_dir(req) == READ)
> +		nvme_sync_dma(dev, req, DMA_FROM_DEVICE);
> +	if (!(iod->flags & IOD_SINGLE_SEGMENT))
> +		nvme_free_descriptors(req);
> +}

This doesn't really unmap anything :)

Also the dma ownership rules say that you always need to call the
sync_to_device helpers before I/O and the sync_to_cpu helpers after I/O,
no matters if it is a read or write.  The implementations then makes
them a no-op where possible.

> +
> +	offset = bio->bi_iter.bi_bvec_done;
> +	map_idx = offset / NVME_CTRL_PAGE_SIZE;
> +	offset &= (NVME_CTRL_PAGE_SIZE - 1);
> +
> +	prp1_dma = dma_list[map_idx++] + offset;
> +
> +	length -= (NVME_CTRL_PAGE_SIZE - offset);
> +	if (length <= 0) {
> +		prp2_dma = 0;

Urgg, why is this building PRPs instead of SGLs?  Yes, SGLs are an
optional feature, but for devices where you want to micro-optimize
like this I think we should simply require them.  This should cut
down on both the memory use and the amount of special mapping code.


