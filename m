Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC600C7115B
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 05:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aAe9fTixTYSF9L3yNIwim37sHzAbQ562M3nrSj0MSwU=; b=GDwCBtlEvXTBdw3Nzf2tGiiVS7
	2kkzZ3aGphZI5uJSTQkbMIN9XRFctixzqbA8x2whVATs8qo9YFZdbE7/9bM361kW8/zFpLj8T5k3V
	pKquS5G9NKqtZSFuIf87GmSARY4FYxorsOmNmG+osD5MW9XSx2n3Bi6JYMkr2plqP5brg+9fjtG8T
	jrqvvyyCpxwMESFFAkeYU2QYOkFmU4ltObnukhBDtltgHCOwWqHeiFKGvOIQPjisB+1YBDIUAMhVK
	h1wD2cfTGZsLPDYiREYG7SKfu+6YCMwlmv5kq3WotV8JiI0QPju1k2Ty+ZIp9po+uxS5D57OuN9sN
	NGc+vtHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUetJ-0000000AcjN-1mTM;
	Thu, 26 Jun 2025 05:11:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUetG-0000000Acic-2Vqa
	for linux-nvme@lists.infradead.org;
	Thu, 26 Jun 2025 05:11:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FC8B68B05; Thu, 26 Jun 2025 07:11:07 +0200 (CEST)
Date: Thu, 26 Jun 2025 07:11:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, leon@kernel.org, joshi.k@samsung.com,
	sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme: convert metadata mapping to dma iter
Message-ID: <20250626051106.GB23248@lst.de>
References: <20250625204445.1802483-1-kbusch@meta.com> <20250625204445.1802483-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625204445.1802483-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_221114_780729_600E4982 
X-CRM114-Status: GOOD (  15.43  )
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

On Wed, Jun 25, 2025 at 01:44:45PM -0700, Keith Busch wrote:
>  static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
>  {
>  	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct nvme_dev *dev = nvmeq->dev;
>  	struct nvme_sgl_desc *sg_list;
> +	struct blk_dma_iter iter;
>  	dma_addr_t sgl_dma;
> +	int i = 0;
>  
> +	if (!blk_rq_integrity_dma_map_iter_start(req, dev->dev, &iter))
> +		return iter.status;

If blk_rq_dma_map_coalesce returns true after this, which it will do for
all mappings when using an IOMMU, we can simply set up a single contiguous
metadata pointers here, which will be a lot more efficient than using an
SGL.

> +	for (i = 1; i <= iod->nr_meta_descriptors; i++)
> +		dma_unmap_page(dev->dev, le64_to_cpu(sg_list[i].addr),
> +				le32_to_cpu(sg_list[i].length), dir);

This should walk based on the size of SGL segment descriptor pointed to
by the metadata pointer, similar to what we do for the data SGLs.  The
descriptors if counted as by the data mapping path are always one for
SGL mappings (and could in fact just be replaced with a flag if we
cared enough).


