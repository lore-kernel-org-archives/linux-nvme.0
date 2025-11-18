Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31265CCD19A
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 05:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dwTNpuHcyu2RktZ01zd9bzaq9kCBEG3jtZnKCAFTvnw=; b=S6QTaDlkxtD1UINqFIVvkCquAe
	N8DCI1uoVlXAkDPslV6KoEk/VpLhGhRi39gh+N8awmMUB/U3et46fRxOFZZEJ7GCSAHT1bfbzYgnH
	x1ZkwB0lqPF50d40s5c4Ey9mfAA3XMp3qqKPuVi6tdTt+lYTthgcB0IP7lk5wRHLkw4h5y7+CoVP3
	b2505NMTdq56K0gVsFJ18PvwyKsBFun9g45oEVPVBEwESSm1TDJZUhxH5YnlrvwSh0GvqhMwHfJjs
	A1pbQBW70modVY2m0JyDjrPjZCOWvb8xZIzpEN4jm7m/RCFPycnCNJtv2h0RDFHGhNuBfxAL+enB+
	5msa5B3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLDsF-0000000HP0m-2ZY6;
	Tue, 18 Nov 2025 05:03:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLDsD-0000000HOww-02lR
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 05:03:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A1063227AAA; Tue, 18 Nov 2025 06:03:12 +0100 (CET)
Date: Tue, 18 Nov 2025 06:03:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to
 handle larger sizes
Message-ID: <20251118050311.GA21569@lst.de>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com> <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_210325_192558_E0813241 
X-CRM114-Status: GOOD (  23.14  )
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

On Mon, Nov 17, 2025 at 09:22:43PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> This patch changes the length variables from unsigned int to size_t.
> Using size_t ensures that we can handle larger sizes, as size_t is
> always equal to or larger than the previously used u32 type.
> 
> Originally, u32 was used because blk-mq-dma code evolved from
> scatter-gather implementation, which uses unsigned int to describe length.
> This change will also allow us to reuse the existing struct phys_vec in places
> that don't need scatter-gather.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  block/blk-mq-dma.c      | 8 ++++++--
>  drivers/nvme/host/pci.c | 4 ++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index e9108ccaf4b0..e7d9b54c3eed 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -8,7 +8,7 @@
>  
>  struct phys_vec {
>  	phys_addr_t	paddr;
> -	u32		len;
> +	size_t		len;
>  };

So we're now going to increase memory usage by 50% again after just
reducing it by removing the scatterlist?


