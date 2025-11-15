Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841CFCEB2E6
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Nov 2025 17:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qFzc+YcPufitKW9Rs5Vf2RxsuMATU2dwsVOJoOkPDOU=; b=KL/+fzjGxU2Mbwh94EKjAjI8el
	RsDcKUNwiUqRlvYIq6Titfe9Y2Fx0A74kgmwItORjtp9lCM7AQSMlLd2SLlNUv2+bxh61ValLKNov
	ssNqzjX+0p1ok733FT8HL6/UlIfhBiSeLjm64sdiEnc3oro77LMXGjxiU2s1XWzG5KCFQExrtqE8r
	nJVL2WuQQnx1hDJ4u5GRs7AnjPVi9ptqaHZ9xToTe8Jh0Uac2RS/443g0N8CyviVmIQRhUmYHm+D0
	x7wa4SdFW6rURgA8gtaapAIGid3oelkFFzE/yIOvE3musb0L1oXiQbya5Smo8biZpDaUrdusWobc1
	plBK1tcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKK9k-0000000Dx8Z-0c5Q;
	Sat, 15 Nov 2025 17:33:48 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKK9h-0000000Dx8A-2bHL
	for linux-nvme@lists.infradead.org;
	Sat, 15 Nov 2025 17:33:47 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-477770019e4so34962065e9.3
        for <linux-nvme@lists.infradead.org>; Sat, 15 Nov 2025 09:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763228023; x=1763832823; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFzc+YcPufitKW9Rs5Vf2RxsuMATU2dwsVOJoOkPDOU=;
        b=MDWAAhvsdEVE8fpD+qbNbhvFV5EJkFoFR5bLxc6EC0xUP2QpCy16zIMqUfbV5tNHVu
         +CUXi4SVHcT1SRnoCQdk3bhLwQ8UQ34rpu23/gaXpbOAgCOdFic/dfxAyg5zXi+Py92Z
         UpGSPA17oj0/p9mfU/toYBFnhkapyUJYNe2jitWllzj0Wcl5cN6c5+cUO1Y2MUOSV/oK
         oL3AjE9GMiyRtsUPfXFWjhUBb5VG7Q9FNswGcMETaBnUM/g/6n3nz4tZZXyVZkNx9Bz8
         Ds4zFkVPtCexqOa+dR0/1fO9WsdIjEqrqCsKYiVTbVuhJiudnC8310fnaIKZpcGDNGXd
         r7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763228023; x=1763832823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qFzc+YcPufitKW9Rs5Vf2RxsuMATU2dwsVOJoOkPDOU=;
        b=NSjwQ+j4vd3tQaV1D3oHLvh8se/mj9X8YAO73/mULvajuNXISJf/39TaNBanB7ciPs
         IPNZblr6r1IRgvqifYOH8+0TRSord0+mWXuWKk1tewTSGRYLTLGeRScQGQgZrb5FxDNS
         tJqtUORTgPL1Jl4GFoR9OMSSM/oRPbZSNI7PPnzcJ3qOkGeVYlB7QibM4LUtuAEPPHZg
         JpgqwbnxdlzPUL/tbUPAmYUXDWBveiEPojWC8vNce9o7aRJ8zLiPTcISKrLiMtHDMORc
         BR76JyZWpw4Aw40qXQWVtwprX52mLUwBh1MdtfuE+sZMw5i8GD3XPljc2QEzVLdBvI/g
         lHSg==
X-Forwarded-Encrypted: i=1; AJvYcCXfSc0lw0n5Oqnn+2h+nseI9M72QgHl0A3ss2AaJ6jlv9bMN7ovsz8sIzmP5z09dHv7N4DcsjGFlrzP@lists.infradead.org
X-Gm-Message-State: AOJu0YwOz1g1SEdC51aQHbHWcoXkMiId+wOZ9GFjd/an0CemXdsFVAXA
	BAF61t4+8BxGLCGYbIjBqAxo3n1JxiyzJLibFcAktZEYEmsBc+ojh2In
X-Gm-Gg: ASbGnctK25w9l7qrkwFQBj8z1ftr16sdwAcEPt/AgK45zCfyc27tx6xa2DzFx3/eIiN
	98Y6UYc99qO5cj8CcrmkR84UakZ/euQIfP1U9u0qKHCi4elSan/tEDXBrG7C3eLMu1Wiju1ss7P
	0qEUdlLIg2ynK6azFgShdjZpbSaAirYB7SUM92mD9Fvnnrc0y9bc0L80c/W8KVcx0ArlFZ3ujdp
	apLNn56Jraxeoc6mQzl+9tA8oRp75cfM6qH0N0EH/boYypX6jMFAwIRvv4PvNRgjRPd7O0PIJ4P
	QWN/7HblrLRzqyy+nu5dg+lsvOGSg6I3T4HopQXTwM/Byx6eWkJStn6aNWyIORha/Jy6xuEOg3m
	UPVPYRkjBuycVuqVL4bx/P0FODEZ6wMgX4hMU56gOflYa/bvTdHL7Be7teOVJB5KmG92L3dKtNo
	JyVES+EIeD5feNlOe1cbuYrgHiDKq1GZnP0EcBIzIlJpKhrseiCE4f
X-Google-Smtp-Source: AGHT+IHQ+EmtUAqO9yz3yFBpoimIZKZZzroUXyQeIyUrb6pbi8e+SUv2VPyJAkhU4fQ+Jp/lAq9i1A==
X-Received: by 2002:a05:600c:8b21:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-4778fe883e3mr76104755e9.30.1763228023039;
        Sat, 15 Nov 2025 09:33:43 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb34278sm72414165e9.4.2025.11.15.09.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 09:33:42 -0800 (PST)
Date: Sat, 15 Nov 2025 17:33:41 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251115173341.4a59c97f@pumpkin>
In-Reply-To: <20251115-nvme-phys-types-v1-1-c0f2e5e9163d@kernel.org>
References: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
	<20251115-nvme-phys-types-v1-1-c0f2e5e9163d@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251115_093345_709335_BB94EF10 
X-CRM114-Status: GOOD (  25.30  )
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

On Sat, 15 Nov 2025 18:22:45 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> This patch changes the length variables from unsigned int to size_t.
> Using size_t ensures that we can handle larger sizes, as size_t is
> always equal to or larger than the previously used u32 type.

Where are requests larger than 4GB going to come from?

> Originally, u32 was used because blk-mq-dma code evolved from
> scatter-gather implementation, which uses unsigned int to describe length.
> This change will also allow us to reuse the existing struct phys_vec in places
> that don't need scatter-gather.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  block/blk-mq-dma.c      | 14 +++++++++-----
>  drivers/nvme/host/pci.c |  4 ++--
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index e9108ccaf4b0..cc3e2548cc30 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -8,7 +8,7 @@
>  
>  struct phys_vec {
>  	phys_addr_t	paddr;
> -	u32		len;
> +	size_t		len;
>  };
>  
>  static bool __blk_map_iter_next(struct blk_map_iter *iter)
> @@ -112,8 +112,8 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
>  		struct phys_vec *vec)
>  {
>  	enum dma_data_direction dir = rq_dma_dir(req);
> -	unsigned int mapped = 0;
>  	unsigned int attrs = 0;
> +	size_t mapped = 0;
>  	int error;
>  
>  	iter->addr = state->addr;
> @@ -296,8 +296,10 @@ int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
>  	blk_rq_map_iter_init(rq, &iter);
>  	while (blk_map_iter_next(rq, &iter, &vec)) {
>  		*last_sg = blk_next_sg(last_sg, sglist);
> -		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
> -				offset_in_page(vec.paddr));
> +
> +		WARN_ON_ONCE(overflows_type(vec.len, unsigned int));

I'm not at all sure you need that test.
blk_map_iter_next() has to guarantee that vec.len is valid.
(probably even less than a page size?)
Perhaps this code should be using a different type for the addr:len pair?

> +		sg_set_page(*last_sg, phys_to_page(vec.paddr),
> +			    (unsigned int)vec.len, offset_in_page(vec.paddr));

You definitely don't need the explicit cast.

	David

>  		nsegs++;
>  	}
>  
> @@ -416,7 +418,9 @@ int blk_rq_map_integrity_sg(struct request *rq, struct scatterlist *sglist)
>  
>  	while (blk_map_iter_next(rq, &iter, &vec)) {
>  		sg = blk_next_sg(&sg, sglist);
> -		sg_set_page(sg, phys_to_page(vec.paddr), vec.len,
> +
> +		WARN_ON_ONCE(overflows_type(vec.len, unsigned int));
> +		sg_set_page(sg, phys_to_page(vec.paddr), (unsigned int)vec.len,
>  				offset_in_page(vec.paddr));
>  		segments++;
>  	}
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9085bed107fd..de512efa742d 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -290,14 +290,14 @@ struct nvme_iod {
>  	u8 flags;
>  	u8 nr_descriptors;
>  
> -	unsigned int total_len;
> +	size_t total_len;
>  	struct dma_iova_state dma_state;
>  	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
>  	struct nvme_dma_vec *dma_vecs;
>  	unsigned int nr_dma_vecs;
>  
>  	dma_addr_t meta_dma;
> -	unsigned int meta_total_len;
> +	size_t meta_total_len;
>  	struct dma_iova_state meta_dma_state;
>  	struct nvme_sgl_desc *meta_descriptor;
>  };
> 


