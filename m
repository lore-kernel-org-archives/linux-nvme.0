Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF55D13596
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 04:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m3x7sfjCk6an/jee3PqRBielnEix2rcYMcqqI8sdlR0=; b=PbZXyH8vVeXCdQyjrCo++tm2Mj
	kZRZTz4VBMVqVpoJy2HOFrGXcVwkwzYcgKaeNS3XWi6ApZcXA9uElWdopq6YV/1nLSwJZQ3ebt69d
	sKjQpbt66DZL0Vu3MYVpLhxm2+Dek3nZB1rLk10RwSgbkJU44T7WeXonSvyxHBVR/ShmpWxTBRal0
	IEBrMw5xoZf7WY9rO27uLXIFXuujDi+1DI3MLGyvV9a+UOwKRBO7VH/hano1pQ+ER2/zbFFQQPtYd
	KZf920VKDL1qno0gF+wyBYDH/9sPQzdgS/rFnjPy3I1KqacV/8HyhE1NHuoLb98ou0hrrvj95XiIu
	RVJjt9kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5HJR-00000009VxC-3Qat;
	Mon, 28 Oct 2024 04:25:05 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5HJP-00000009VwZ-0Zcx
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 04:25:04 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-20e576dbc42so38304405ad.0
        for <linux-nvme@lists.infradead.org>; Sun, 27 Oct 2024 21:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730089501; x=1730694301; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3x7sfjCk6an/jee3PqRBielnEix2rcYMcqqI8sdlR0=;
        b=NZVLKMfcfDxwzPLcZztyUOVgdYWPLmzBMHOpAYiU6HkoRioxNqpBHGjXgG7MhRl6su
         poohKR2hOopo5WlEyRJOwFPt+rPxTdLt/2rDmwTiGA9s8nec5o0kinNvJFHdm+rQRes4
         9oirEajV/m3i9fVoo4DKl0Fwp2yxeeG0vhGahC0s3klYhTr5XewkF3BWuubVYgQytcMG
         hONNFpsDTDOLOEoHS8cpB9xL95LkAVSbPnQ+yrx2RNDk6fjQUjJNfdcq4QBT3RJXtAll
         /mc55g7tLd9nfIeJwaKe4ASOJTYbq2km7SSitXHEp+t2VERRZ/pTWdj0ov081aUZ+i4Q
         jcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730089501; x=1730694301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3x7sfjCk6an/jee3PqRBielnEix2rcYMcqqI8sdlR0=;
        b=SeuPLB7/D3U/bzYQKk0U1Q8KsEhRlcDDFpskdkSI8WOfVpL+dadI9aF4BDnlsiq0J+
         eYDmsk/hj72F5XLukvLhHyG0f4cTJfF5G5R//l7PgQ27wHNb/XajIv/kCAQiaxC0NW7l
         PP/3zs2vB09FV27hEzGe8JHRiYl/DxTMcaTjfCoSS1/1NG+8sjxv31ptl/II+rLibWvv
         DbfP1/gK4QWvpXnoKVrW5ploSGqrZF95vHszPQxyaQ+XjiyB4f8FOz4U0EKdKR9t/C9p
         E0f7iaqg7l4BZtor4+ElXKnkS/8phHYUFQZptc15H2U0F0LmF1PZuQ+zyNCzLzL9iPNK
         tkbA==
X-Forwarded-Encrypted: i=1; AJvYcCW1K1wjeRX/QeNlUifbPc/UNcYYMI9QIQbJ58sgqkRmAGoQWsxJcSFLaO4RiU7au/in96y/ccN4YuMB@lists.infradead.org
X-Gm-Message-State: AOJu0YzOigST+UTtlvWwqa1tjIJ3pBr5eu4zkJS7lXVyzljtvBvNOGdr
	l+oeAl/600Da5F55aZpyH8mIBSiQUiA388MHulrmxT9u3la07+pF79xPvDQR3Cfp5UnQQxny8fI
	j7jxX0Y9QTnWVaNiI9MDNTETUqK0=
X-Google-Smtp-Source: AGHT+IF/XbpZuxphQQOGSTKqE4rMFhTi6L+p1iG+0wHvbb3b0Zmpl46tdIWRMT6RjNj1jqQyIDmtIwt2bzj/qL3GX/U=
X-Received: by 2002:a17:902:db02:b0:20c:b700:6e10 with SMTP id
 d9443c01a7336-210c6c8856cmr116967905ad.34.1730089501376; Sun, 27 Oct 2024
 21:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1730037276.git.leon@kernel.org> <844f3dcf9c341b8178bfbc90909ef13d11dd2193.1730037276.git.leon@kernel.org>
In-Reply-To: <844f3dcf9c341b8178bfbc90909ef13d11dd2193.1730037276.git.leon@kernel.org>
From: Srinivasulu Thanneeru <dev.srinivasulu@gmail.com>
Date: Mon, 28 Oct 2024 09:54:49 +0530
Message-ID: <CAMtOeKJeVrELCp5JpYTC64KdfKpbnW9a8QrnL6ziCYL48nc=qQ@mail.gmail.com>
Subject: Re: [PATCH 05/18] dma: Provide an interface to allow allocate IOVA
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Yishai Hadas <yishaih@nvidia.com>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_212503_210122_4B88A2C4 
X-CRM114-Status: GOOD (  33.65  )
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

On Sun, Oct 27, 2024 at 10:23=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> The existing .map_page() callback provides both allocating of IOVA
> and linking DMA pages. That combination works great for most of the
> callers who use it in control paths, but is less effective in fast
> paths where there may be multiple calls to map_page().

Can you please share perf stats with this patch in fast path, if available?

> These advanced callers already manage their data in some sort of
> database and can perform IOVA allocation in advance, leaving range
> linkage operation to be in fast path.
>
> Provide an interface to allocate/deallocate IOVA and next patch
> link/unlink DMA ranges to that specific IOVA.
>
> The API is exported from dma-iommu as it is the only implementation
> supported, the namespace is clearly different from iommu_* functions
> which are not allowed to be used. This code layout allows us to save
> function call per API call used in datapath as well as a lot of boilerpla=
te
> code.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/dma-iommu.c   | 79 +++++++++++++++++++++++++++++++++++++
>  include/linux/dma-mapping.h | 15 +++++++
>  2 files changed, 94 insertions(+)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c422e36c0d66..0644152c5aad 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1745,6 +1745,85 @@ size_t iommu_dma_max_mapping_size(struct device *d=
ev)
>         return SIZE_MAX;
>  }
>
> +static bool iommu_dma_iova_alloc(struct device *dev,
> +               struct dma_iova_state *state, phys_addr_t phys, size_t si=
ze)
> +{
> +       struct iommu_domain *domain =3D iommu_get_dma_domain(dev);
> +       struct iommu_dma_cookie *cookie =3D domain->iova_cookie;
> +       struct iova_domain *iovad =3D &cookie->iovad;
> +       size_t iova_off =3D iova_offset(iovad, phys);
> +       dma_addr_t addr;
> +
> +       if (WARN_ON_ONCE(!size))
> +               return false;
> +       if (WARN_ON_ONCE(size & DMA_IOVA_USE_SWIOTLB))
> +               return false;
> +
> +       addr =3D iommu_dma_alloc_iova(domain,
> +                       iova_align(iovad, size + iova_off),
> +                       dma_get_mask(dev), dev);
> +       if (!addr)
> +               return false;
> +
> +       state->addr =3D addr + iova_off;
> +       state->__size =3D size;
> +       return true;
> +}
> +
> +/**
> + * dma_iova_try_alloc - Try to allocate an IOVA space
> + * @dev: Device to allocate the IOVA space for
> + * @state: IOVA state
> + * @phys: physical address
> + * @size: IOVA size
> + *
> + * Check if @dev supports the IOVA-based DMA API, and if yes allocate IO=
VA space
> + * for the given base address and size.
> + *
> + * Note: @phys is only used to calculate the IOVA alignment. Callers tha=
t always
> + * do PAGE_SIZE aligned transfers can safely pass 0 here.
> + *
> + * Returns %true if the IOVA-based DMA API can be used and IOVA space ha=
s been
> + * allocated, or %false if the regular DMA API should be used.
> + */
> +bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state=
,
> +               phys_addr_t phys, size_t size)
> +{
> +       memset(state, 0, sizeof(*state));
> +       if (!use_dma_iommu(dev))
> +               return false;
> +       if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
> +           iommu_deferred_attach(dev, iommu_get_domain_for_dev(dev)))
> +               return false;
> +       return iommu_dma_iova_alloc(dev, state, phys, size);
> +}
> +EXPORT_SYMBOL_GPL(dma_iova_try_alloc);
> +
> +/**
> + * dma_iova_free - Free an IOVA space
> + * @dev: Device to free the IOVA space for
> + * @state: IOVA state
> + *
> + * Undoes a successful dma_try_iova_alloc().
> + *
> + * Note that all dma_iova_link() calls need to be undone first.  For cal=
lers
> + * that never call dma_iova_unlink(), dma_iova_destroy() can be used ins=
tead
> + * which unlinks all ranges and frees the IOVA space in a single efficie=
nt
> + * operation.
> + */
> +void dma_iova_free(struct device *dev, struct dma_iova_state *state)
> +{
> +       struct iommu_domain *domain =3D iommu_get_dma_domain(dev);
> +       struct iommu_dma_cookie *cookie =3D domain->iova_cookie;
> +       struct iova_domain *iovad =3D &cookie->iovad;
> +       size_t iova_start_pad =3D iova_offset(iovad, state->addr);
> +       size_t size =3D dma_iova_size(state);
> +
> +       iommu_dma_free_iova(cookie, state->addr - iova_start_pad,
> +                       iova_align(iovad, size + iova_start_pad), NULL);
> +}
> +EXPORT_SYMBOL_GPL(dma_iova_free);
> +
>  void iommu_setup_dma_ops(struct device *dev)
>  {
>         struct iommu_domain *domain =3D iommu_get_domain_for_dev(dev);
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 6075e0708deb..817f11bce7bc 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -11,6 +11,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/bug.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/iommu.h>
>
>  /**
>   * List of possible attributes associated with a DMA mapping. The semant=
ics
> @@ -77,6 +78,7 @@
>  #define DMA_BIT_MASK(n)        (((n) =3D=3D 64) ? ~0ULL : ((1ULL<<(n))-1=
))
>
>  struct dma_iova_state {
> +       dma_addr_t addr;
>         size_t __size;
>  };
>
> @@ -307,11 +309,24 @@ static inline bool dma_use_iova(struct dma_iova_sta=
te *state)
>  {
>         return state->__size !=3D 0;
>  }
> +
> +bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state=
,
> +               phys_addr_t phys, size_t size);
> +void dma_iova_free(struct device *dev, struct dma_iova_state *state);
>  #else /* CONFIG_IOMMU_DMA */
>  static inline bool dma_use_iova(struct dma_iova_state *state)
>  {
>         return false;
>  }
> +static inline bool dma_iova_try_alloc(struct device *dev,
> +               struct dma_iova_state *state, phys_addr_t phys, size_t si=
ze)
> +{
> +       return false;
> +}
> +static inline void dma_iova_free(struct device *dev,
> +               struct dma_iova_state *state)
> +{
> +}
>  #endif /* CONFIG_IOMMU_DMA */
>
>  #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
> --
> 2.46.2
>
>

