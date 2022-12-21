Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5048CC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Dec 2022 08:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=msnNGWscGPtgnzMc4mPh4lBbTsiSd9S5UaCtr/3RJnM=; b=JTZfaDr2osIEnfyK7ZrhmVA2ih
	3agWJwFRmPJLw1/9TFpjL05hqN+tSqbzZJUdJNrMVrdPZfCn6vm132gryYV1IUtVk35c0CClkd87o
	Q7mueAqk0cz3euYRADwf9zxYmXeW+ySZo4h4fq62YYF/bWDScRAuePMaPIzTvXEfVyk1ei4XlJOZR
	2ggDddOdNJAJOzuoaXuxs6zFwgyfpvrpekZTB7BD9zVEIazJDWDYg9yJpdyAhKymNIKAeQP6AmqAZ
	EkBQHcPMmI8xsiMepWCcgMMlH4o7YR3mlCAfrVHrZeeJr+vRedCGKXFmMrHtdkyY9AbCoAdCqFtRf
	ztACGoFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7uIk-00C3VR-PV; Wed, 21 Dec 2022 08:18:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7uHT-00C2mA-UP
	for linux-nvme@lists.infradead.org; Wed, 21 Dec 2022 08:16:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D1AEC67373; Wed, 21 Dec 2022 09:16:47 +0100 (CET)
Date: Wed, 21 Dec 2022 09:16:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: place chain addresses in iod
Message-ID: <20221221081647.GA23377@lst.de>
References: <20221220182131.465092-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220182131.465092-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_001652_183904_AE9BB41A 
X-CRM114-Status: GOOD (  11.84  )
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

On Tue, Dec 20, 2022 at 10:21:31AM -0800, Keith Busch wrote:
> -#define NVME_MAX_KB_SZ	4096
> -#define NVME_MAX_SEGS	127
> +#define NVME_MAX_KB_SZ	8192
> +#define NVME_MAX_SEGS	128
> +#define NVME_MAX_CHAINS	5

NVME_MAX_CHAINS sounds a bit odd.  Maybe MAX_ALLOCATIONS to match
the nr_allocations field?

>  
>  static int use_threaded_interrupts;
>  module_param(use_threaded_interrupts, int, 0444);
> @@ -232,6 +233,7 @@ struct nvme_iod {
>  	dma_addr_t first_dma;
>  	dma_addr_t meta_dma;
>  	struct sg_table sgt;
> +	void *list[NVME_MAX_CHAINS];

I think this should a union nvme_data_ptr * so that we have some typing
information.

