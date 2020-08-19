Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6724DC433E3
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 15:04:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D962076E
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 15:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z0745qz8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CmFRV9MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D962076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KwxmdJpcuq0aco+jn0+65e+051jGsrKi5oBcYrOY/1Y=; b=Z0745qz8oarCW5khTXILbQwKg
	nT9kQhEftOb1SXZY/RPJI2ZTnhzc/Y64SdDSTJviex7NUvo6jhq63M8j3sgoJtlAtjWXufWXXFGLx
	E7px319+feD5PZJvPpSKr+DgllfNzFOyxQplAWXoCpUsvIgxAnQFYlY20PIcxMM/I9IBXyTwE6wKK
	fW56UKi8+RX1DL7u5PWboJYgB0o4qp6dZKOxt//02TtG6f/wjvxr4WL8hfT2qDof1QakGo42nPf1g
	Ht4LoYj3F6YgCssmCtnkNGeGURcM6JMxkku1QhCe9O0ZUmhiyoUVlqwjr6yBCWvt1HxeVk2OKXEt4
	inqyWj/XQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8PdR-00026t-W1; Wed, 19 Aug 2020 15:04:18 +0000
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8PdO-000252-Sd
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 15:04:16 +0000
Received: by mail-ej1-x642.google.com with SMTP id t10so26682062ejs.8
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gblnYCzc62i56nCc5LRWss+Qf5wc+kIzyZ60hUww65Y=;
 b=CmFRV9MF78Io9lyU3ZTHQoxCUWL8rgrVpgpqOj4nEXWpRTCd1+KGSochi2kuoVhtFt
 PQJJembCFDIORAph3WzrpDoRd2cIGJpwf9VAtP5a9ydpphhRkHDHcmKRPuhZGWASaGfl
 y6rPrnsIqK2MPfXnYUVbYzJtuDwuiigpqdGRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gblnYCzc62i56nCc5LRWss+Qf5wc+kIzyZ60hUww65Y=;
 b=Sc4f3uK9msyHubmf/wvoFLsX0kPW/7BFKu3Dw3QeaPkDrxe15YWRxvULe3W/7ub6AM
 pDeBf/3tCPR/IRn1vV4K8FCMdQnW25iMOrDIinnud9Y+FMeOcMNrbewxyWvFPVaJeoEK
 1Yc2G6yxxXeQczU25mjf9z+k0JP5g27MQ8Z9s4bUzHnixHq4YUL8Wwb6FSzZmLEoMqb6
 CDO8HJb/7in3UF2gelMqLoDJO5lo3PHDPkRzd28m6AsOyxbby+2CyE1OMe/FsDwlc6q3
 mVHhWbmgArV/IZiLVeSwsRwmmITDcChBidjQBlF3aTobERv4T3sgE1bcWT9Go1kSoIzJ
 FdgA==
X-Gm-Message-State: AOAM532Vo56sbTVfJuj3R8+NFSbd3xUfZhef0OcIcGxVQZeS57JBiiKP
 nZrZObAj2XLhnmohaUaBRGKff3jKWFTcNg==
X-Google-Smtp-Source: ABdhPJyMYSNbp7bLe8aicveCFbnikxu6cttgMc6aSDNLJXieip6SEmxBsuLNavAOCYFC70I8wuqTcw==
X-Received: by 2002:a17:907:2067:: with SMTP id
 qp7mr25056233ejb.378.1597849452785; 
 Wed, 19 Aug 2020 08:04:12 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com.
 [209.85.128.44])
 by smtp.gmail.com with ESMTPSA id s9sm20129092edt.36.2020.08.19.08.04.10
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 08:04:10 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id g8so2410296wmk.3
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 08:04:10 -0700 (PDT)
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr5316483wmh.55.1597849448826; 
 Wed, 19 Aug 2020 08:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-20-hch@lst.de>
In-Reply-To: <20200819065555.1802761-20-hch@lst.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 19 Aug 2020 17:03:52 +0200
X-Gmail-Original-Message-ID: <CAAFQd5Bbp-eAVKS1MKS8xtrT4ZoOmBPfZyw9mys=eOmDb6r8Lw@mail.gmail.com>
Message-ID: <CAAFQd5Bbp-eAVKS1MKS8xtrT4ZoOmBPfZyw9mys=eOmDb6r8Lw@mail.gmail.com>
Subject: Re: [PATCH 19/28] dma-mapping: replace DMA_ATTR_NON_CONSISTENT with
 dma_{alloc, free}_pages
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_110415_025800_9B6619C0 
X-CRM114-Status: GOOD (  34.25  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 nouveau@lists.freedesktop.org, linux-nvme@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Matt Porter <mporter@kernel.crashing.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-mips@vger.kernel.org,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Christoph,

On Wed, Aug 19, 2020 at 8:57 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add a new API to allocate and free pages that are guaranteed to be
> addressable by a device, but otherwise behave like pages allocated by
> alloc_pages.  The intended APIs to sync them for use with the device
> and cpu are dma_sync_single_for_{device,cpu} that are also used for
> streaming mappings.
>
> Switch all drivers over to this new API, but keep the usage of the
> crufty dma_cache_sync API for now, which will be cleaned up on a driver
> by driver basis.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/core-api/dma-api.rst        | 68 +++++++++++------------
>  Documentation/core-api/dma-attributes.rst |  8 ---
>  arch/alpha/kernel/pci_iommu.c             |  2 +
>  arch/arm/mm/dma-mapping-nommu.c           |  2 +
>  arch/arm/mm/dma-mapping.c                 |  4 ++
>  arch/ia64/hp/common/sba_iommu.c           |  2 +
>  arch/mips/jazz/jazzdma.c                  |  7 +--
>  arch/powerpc/kernel/dma-iommu.c           |  2 +
>  arch/powerpc/platforms/ps3/system-bus.c   |  4 ++
>  arch/powerpc/platforms/pseries/vio.c      |  2 +
>  arch/s390/pci/pci_dma.c                   |  2 +
>  arch/x86/kernel/amd_gart_64.c             |  2 +
>  drivers/iommu/dma-iommu.c                 |  2 +
>  drivers/iommu/intel/iommu.c               |  4 ++
>  drivers/net/ethernet/i825xx/lasi_82596.c  | 13 ++---
>  drivers/net/ethernet/seeq/sgiseeq.c       | 12 ++--
>  drivers/parisc/ccio-dma.c                 |  2 +
>  drivers/parisc/sba_iommu.c                |  2 +
>  drivers/scsi/53c700.c                     |  8 +--
>  drivers/scsi/sgiwd93.c                    | 12 ++--
>  drivers/xen/swiotlb-xen.c                 |  2 +
>  include/linux/dma-direct.h                |  5 ++
>  include/linux/dma-mapping.h               | 29 ++++++++--
>  include/linux/dma-noncoherent.h           |  3 -
>  kernel/dma/direct.c                       | 51 ++++++++++++++++-
>  kernel/dma/mapping.c                      | 43 +++++++++++++-
>  kernel/dma/ops_helpers.c                  | 35 ++++++++++++
>  kernel/dma/virt.c                         |  2 +
>  sound/mips/hal2.c                         | 20 +++----
>  29 files changed, 254 insertions(+), 96 deletions(-)
>

Thanks for the patch. The general design looks quite nice, but please
see my comments inline.


> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
> index 90239348b30f6f..047fcfffa0e5cf 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -516,48 +516,53 @@ routines, e.g.:::
>         }
>
>
> -Part II - Advanced dma usage
> -----------------------------
> +Part II - Non-coherent DMA allocations
> +--------------------------------------
>
> -Warning: These pieces of the DMA API should not be used in the
> -majority of cases, since they cater for unlikely corner cases that
> -don't belong in usual drivers.
> +These APIs allow to allocate pages that can be used like normal pages
> +in the kernel direct mapping, but are guaranteed to be DMA addressable.

Could we elaborate a bit more on what "like normal pages in kernel
direct mapping" mean from the driver perspective?

>
>  If you don't understand how cache line coherency works between a
>  processor and an I/O device, you should not be using this part of the
> -API at all.
> +API.
>
>  ::
>
>         void *
> -       dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
> -                       gfp_t flag, unsigned long attrs)
> +       dma_alloc_pages(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +                       enum dma_data_direction dir, gfp_t gfp)
> +
> +This routine allocates a region of <size> bytes of consistent memory.  It
> +returns a pointer to the allocated region (in the processor's virtual address
> +space) or NULL if the allocation failed. The returned memory is guanteed to
> +behave like memory allocated using alloc_pages.

There is one aspect that the existing dma_alloc_attrs() handles, but
this new function doesn't: IOMMU support. The function will always
allocate a physically-contiguous block memory, which is a costly
operation and not even guaranteed to succeed, even if enough free
memory is available.

Modern SoCs employ IOMMUs to avoid the need to allocate
physically-contiguous memory and those happen to be also the devices
that could benefit from non-coherent allocations a lot. One of the
tasks of the DMA API was making it possible to allocate suitable
memory for a given device, without having the driver know about the
SoC integration details, such as the presence of an IOMMU.

Today, dma_alloc_attrs() uses the .alloc callback of the dma_ops
struct and the IOMMU-aware implementations, like the dma-iommu helpers
[1], would allocate discontiguous pages. Therefore, while I see the
DMA-aware page allocation functionality as a useful functionality on
its own for scatter-gather-capable hardware, I believe it is not a
complete replacement for dma_alloc_attrs() with the
DMA_ATTR_NON_CONSISTENT attribute.

[1] https://elixir.bootlin.com/linux/v5.9-rc1/source/drivers/iommu/dma-iommu.c#L510

Best regards,
Tomasz

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
