Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB14C87FCA
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Aug 2025 14:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ajnrGzf115r9CcT2YjPN2QN7tWrz3pro28aJJcRMlbg=; b=vz9bLgbK8QuQL3qc5ah4kYPR50
	Ft6wWuIHhdRFo4DfKru4wXiM6dC3kOjBtSUPr+OhdItTHt+djwfhu1KSHyChRhvHsHQYc06xDo/6V
	gW7crD+oXBNUtAif9Ug/tzoWGr8jThdt4kEjNUVRtY3vFThd7fMWIOPG93LPJAn042fbeWLggzUz0
	EZp5U0QzxceZNM2qB1H3YFR1iytksSeRkc6tyDXtcv8cmpRnknn8t7gwBgdht60mKtB1uhGYP0HBq
	xyeFr8nob0CGF5G17z/7Rnllhz9u2wKeNj6JTkxY19sH32mttzoHfQNvb8e2Y7VB5tKvxbTi31BqU
	6q7g6p/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul6vP-00000005ges-1vUS;
	Sun, 10 Aug 2025 14:21:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul6vO-00000005geV-03en
	for linux-nvme@lists.infradead.org;
	Sun, 10 Aug 2025 14:21:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2401227A87; Sun, 10 Aug 2025 16:21:21 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:21:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 7/8] nvme-pci: create common sgl unmapping helper
Message-ID: <20250810142121.GH4262@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-8-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-8-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_072126_199391_C4F0F916 
X-CRM114-Status: GOOD (  18.71  )
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

On Fri, Aug 08, 2025 at 08:58:25AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This can be reused by metadata sgls once that starts using the blk-mq
> dma api.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)

> +static void __nvme_free_sgls(struct device *dma_dev, struct nvme_sgl_desc *sge,
> +		struct nvme_sgl_desc *sg_list, enum dma_data_direction dir)
> +{
> +	unsigned int len = le32_to_cpu(sge->length);
> +	unsigned int i, nr_entries;
> +
> +	if (sge->type == (NVME_SGL_FMT_DATA_DESC << 4)) {
> +		dma_unmap_page(dma_dev, le64_to_cpu(sge->addr), len, dir);
> +		return;
> +	}
> +
> +	nr_entries = len / sizeof(*sg_list);
> +	for (i = 0; i < nr_entries; i++)


We can probably just do away with the nr_entries variable, the compiler
is not going to recompute this for every loop ieration.


>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
>  	struct device *dma_dev = nvmeq->dev->dev;
>  	struct nvme_sgl_desc *sg_list = iod->descriptors[0];
>  	enum dma_data_direction dir = rq_dma_dir(req);
>  
> +	__nvme_free_sgls(dma_dev, sge, sg_list, dir);

Shouldn't we move the calculation of nvmeq, dma_dev and dir into
__nvme_free_sgls as they are going to be the same for data and metadata.
And then maybe rename it to __nvme_free_sgls and just opencode the
iod->descriptors[0] and &iod->cmd.common.dptr.sgl dereferences in
nvme_unmap_data?


