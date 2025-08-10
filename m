Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78676C87FCA
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Aug 2025 14:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3P8eKRiRE3RWWJeeAdj13aIGMpDYc7vRG85gZXiLlWQ=; b=vfnfFGDToJgjCsdBDmUgrAw8E5
	LzkqaMMX0QZgjPIJvjRKHz5yY0zsM5Rr9GAbZkdvy6ZqamMxo9BCwVKgawELPGmgGiaaQhwBwAoHL
	VUw+THOJo3ff+quJEO18Rh/uJ52gHgmhvzmdIR6N38klZEJ632SnQR85q6bUvnB3DLI5zpN7V62o8
	qs3kXXGfBLGTGIICcyJxCIfoAyDjyNqUdrJklaNaC7z/c7ZJ4SDDhYSWKG2mRIJqbPu21ta7FAgwx
	f/U4Y4jN2IunRrZc43LOorCEpl0dXwux83e5NpmMK8P3q5/KDy7BtRnuFL+EAUAW3uxgrAoPnkcPr
	N2jUb4Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul71j-00000005h8Q-412U;
	Sun, 10 Aug 2025 14:27:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul71h-00000005h60-2EZg
	for linux-nvme@lists.infradead.org;
	Sun, 10 Aug 2025 14:27:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 61D3C227A87; Sun, 10 Aug 2025 16:27:48 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:27:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 8/8] nvme-pci: convert metadata mapping to dma iter
Message-ID: <20250810142748.GA4717@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-9-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-9-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_072757_714101_42B79794 
X-CRM114-Status: GOOD (  18.52  )
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

On Fri, Aug 08, 2025 at 08:58:26AM -0700, Keith Busch wrote:
>  
>  struct nvme_dma_vec {
> @@ -281,13 +285,14 @@ struct nvme_iod {
>  	u8 nr_descriptors;
>  
>  	unsigned int total_len;
> +	unsigned int meta_total_len;
>  	struct dma_iova_state dma_state;
> +	struct dma_iova_state meta_dma_state;
>  	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
>  	struct nvme_dma_vec *dma_vecs;
>  	unsigned int nr_dma_vecs;
>  
>  	dma_addr_t meta_dma;
> -	struct sg_table meta_sgt;
>  	struct nvme_sgl_desc *meta_descriptor;

Maybe keep the meta fields together as much as we can to ensure they
are in the same cacheline(s)?

> +static void nvme_unmap_metadata(struct request *req)
> +{
> +	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> +	enum dma_data_direction dir = rq_dma_dir(req);
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct device *dma_dev = nvmeq->dev->dev;
> +
> +	if (iod->flags & IOD_META_MPTR) {
> +		dma_unmap_page(dma_dev, iod->meta_dma,
> +			       rq_integrity_vec(req).bv_len,
> +			       rq_dma_dir(req));
> +		return;
> +	}
> +
> +	if (!blk_rq_dma_unmap(req, dma_dev, &iod->meta_dma_state,
> +				iod->meta_total_len,
> +				iod->flags & IOD_META_P2P_BUS_ADDR)) {
> +		if (nvme_pci_cmd_use_meta_sgl(&iod->cmd))
> +			nvme_free_meta_sgls(iod, dma_dev, dir);
> +		else
> +			dma_unmap_page(dma_dev, iod->meta_dma,
> +				       iod->meta_total_len, dir);
> +	}

IOD_META_MPTR above really should be named IOD_SINGLE_META_SEGMENT as
it's all about avoiding the dma iterator, which could also create a
single segment case handled just above.

>  static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
>  {
>  	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> +	unsigned int entries = req->nr_integrity_segments;
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct nvme_dev *dev = nvmeq->dev;
>  	struct nvme_sgl_desc *sg_list;
> +	struct blk_dma_iter iter;
>  	dma_addr_t sgl_dma;
> +	int i = 0;
>  
> +	if (!blk_rq_integrity_dma_map_iter_start(req, dev->dev,
> +						&iod->meta_dma_state, &iter))
> +		return iter.status;
>  
> +	if (iter.p2pdma.map == PCI_P2PDMA_MAP_BUS_ADDR)
> +		iod->flags |= IOD_META_P2P_BUS_ADDR;
> +	else if (blk_rq_dma_map_coalesce(&iod->meta_dma_state))
> +		entries = 1;
> +
> +	if (entries == 1 && !(nvme_req(req)->flags & NVME_REQ_USERCMD)) {
> +		iod->cmd.common.metadata = cpu_to_le64(iter.addr);
> +		iod->meta_total_len = iter.len;
> +		iod->meta_dma = iter.addr;
> +		iod->meta_descriptor = NULL;
> +		return BLK_STS_OK;

Maybe throw in a comment explaining that we fall back to a single metadata
pointer here if we can, and why we don't for passthrough requests?


