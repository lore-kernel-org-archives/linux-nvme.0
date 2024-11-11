Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F472D12D5F
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 02:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GdEkfAJOsElSV+ujZ/1dK2DOAkU54yl3So/8rs20Jag=; b=mhg5E6FxOufv8jaSW81C4cQ75p
	hgEt/KG4C0TvKIOfSYyrTNmEuG8K4L5F7FcCJ7aKYrVYB7zaZR3pOydv8kbYWpzIaXIASZ+YFctJI
	GxTHBAQUyHGJM8LT8c/rdDtGLUbEWKicSnx/5erhJrWcnMXo2CXY0/M+3dwRyDq8VJk7uMkVOoopK
	PWURtHubmsFxSJEUXTdm5xSJ0UwN0oiOaxudCqeOK7PFpEQixGA0005kROZn3w51su5G08CjTSgxn
	tSQ6bPUe3eDt2qqM6Cf9fpTGecJewxTNTjm9OziAStQoK9uuU7Bj7jMvoJpMFknglURcx1aaVeaQz
	RVCfvxRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAJoP-0000000G5wa-0jZ9;
	Mon, 11 Nov 2024 02:05:53 +0000
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAJoL-0000000G5vp-3Oj7
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 02:05:51 +0000
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so33200361fa.1
        for <linux-nvme@lists.infradead.org>; Sun, 10 Nov 2024 18:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731290747; x=1731895547; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdEkfAJOsElSV+ujZ/1dK2DOAkU54yl3So/8rs20Jag=;
        b=UAbHoIMh0eG8/EGVUpvj1Rl2RFNCxkavc2z93N1TY7fnO2SiaAa4nppiw3qfv0JEqX
         dgU0Dxb1UqMyHjnVOxKHntgCm08sRcmjcbt1BX66O3eqUWLw8KH1B537ejO4zSPIhoWi
         J8NLWb7QdGanUU+qUE/xzPahq3P1qNH2fUuJbXb/A8t/zqicshtH5xOAKOFI6ZVEo7p1
         1Ob03CY47Vbwfxnq4uzHR2RvNn47XpSIgFidVAGKFLkYKrNnmVy2flgvTT5NdixuS9ll
         dljIUwLiV4f98SfvVWYvmsCC28X5D9HaaaoNUww3/fYGqShQgyVOpNyNQXTui13uPQhz
         xlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731290747; x=1731895547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdEkfAJOsElSV+ujZ/1dK2DOAkU54yl3So/8rs20Jag=;
        b=K7056Wqnb2rVmc0D1ywOaPKepigvuBAPTSkepxQL9p0hhgqTx+RvzAe2+tdi83ieji
         AQmxK/681ph3KKyKQdz+6jyKuX17E5jbrgFHpqolEV9VzRjBiYNrYay2FtU9qyrpoAQe
         uryO830NbdIoc78QQ5lse0hpr8HsLOiwpa75fHFV+OHX4fH0Y2irVGYz9JswNWol5OTk
         137g3NcHYbzi5iu9Y88ek1C4z0t8+jxxGjSIUpvxlzkRD60wOWxGQVA0Wijwoe3AVCGq
         j6JbHa7iSp1FfYT15T8nL+HwRXcxMes09tRMgNltGDU3a7wg8BL9nr2sOajAchF5GjpL
         ifaA==
X-Forwarded-Encrypted: i=1; AJvYcCW2+WZQw5BYIeO/M9B1TvxyBVB4WhatFJKJFw44Jvh3SC271+J6WPu/HqReU9yK9zBj8GaxXceRJKf2@lists.infradead.org
X-Gm-Message-State: AOJu0Yydm1A9PauAKMkj4Czhl2a9cXn6J0U+P9gCl5ztExm0qTDmIVGX
	32UHB6t4mBLuPzOwk5AUUM2sOPZtJcoTEBsUVEXvX8Zaan3JRmH8stHAM5V4tbCWD41+85FAH0s
	Bp0NJq9Sqpg4svW8PYI7xZLiZ8w0=
X-Google-Smtp-Source: AGHT+IF0tJPIolZyNYPTT2b/MpCJe82Fg/iZslXB6gzAqlmjhMUqVGRF2M5H+UaSiVlIP433HQ0w2T+2CyxfkrVJL68=
X-Received: by 2002:a2e:bc1d:0:b0:2fb:5014:8eb9 with SMTP id
 38308e7fff4ca-2ff2014ec60mr46592301fa.10.1731290746959; Sun, 10 Nov 2024
 18:05:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1731244445.git.leon@kernel.org> <dca3aecdeeaa962c7842bc488378cdf069201d65.1731244445.git.leon@kernel.org>
In-Reply-To: <dca3aecdeeaa962c7842bc488378cdf069201d65.1731244445.git.leon@kernel.org>
From: anish kumar <yesanishhere@gmail.com>
Date: Sun, 10 Nov 2024 18:05:35 -0800
Message-ID: <CABCoZhAN-eeu=E5r+ZbZGTNwQta5yUw86sy8e_Je+Yri-+iuoQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] docs: core-api: document the IOVA-based API
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Yishai Hadas <yishaih@nvidia.com>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_180549_897337_F9E3698C 
X-CRM114-Status: GOOD (  29.17  )
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

On Sun, Nov 10, 2024 at 5:50=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Christoph Hellwig <hch@lst.de>
>
> Add an explanation of the newly added IOVA-based mapping API.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Documentation/core-api/dma-api.rst | 70 ++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/=
dma-api.rst
> index 8e3cce3d0a23..61d6f4fe3d88 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -530,6 +530,76 @@ routines, e.g.:::
>                 ....
>         }
>
> +Part Ie - IOVA-based DMA mappings
> +---------------------------------
> +
> +These APIs allow a very efficient mapping when using an IOMMU.  They are=
 an

"They" doesn't sound nice.
> +optional path that requires extra code and are only recommended for driv=
ers
> +where DMA mapping performance, or the space usage for storing the DMA ad=
dresses
> +matter.  All the considerations from the previous section apply here as =
well.

These APIs provide an efficient mapping when using an IOMMU. However, they
are optional and require additional code. They are recommended primarily fo=
r
drivers where performance in DMA mapping or the storage space for DMA
addresses are critical. All the considerations discussed in the previous se=
ction
also apply in this case.

You can disregard this comment, as anyone reading this paragraph will
understand the intended message.

> +
> +::
> +
> +    bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *s=
tate,
> +               phys_addr_t phys, size_t size);
> +
> +Is used to try to allocate IOVA space for mapping operation.  If it retu=
rns
> +false this API can't be used for the given device and the normal streami=
ng
> +DMA mapping API should be used.  The ``struct dma_iova_state`` is alloca=
ted
> +by the driver and must be kept around until unmap time.
> +
> +::
> +
> +    static inline bool dma_use_iova(struct dma_iova_state *state)
> +
> +Can be used by the driver to check if the IOVA-based API is used after a
> +call to dma_iova_try_alloc.  This can be useful in the unmap path.
> +
> +::
> +
> +    int dma_iova_link(struct device *dev, struct dma_iova_state *state,
> +               phys_addr_t phys, size_t offset, size_t size,
> +               enum dma_data_direction dir, unsigned long attrs);
> +
> +Is used to link ranges to the IOVA previously allocated.  The start of a=
ll
> +but the first call to dma_iova_link for a given state must be aligned
> +to the DMA merge boundary returned by ``dma_get_merge_boundary())``, and
> +the size of all but the last range must be aligned to the DMA merge boun=
dary
> +as well.
> +
> +::
> +
> +    int dma_iova_sync(struct device *dev, struct dma_iova_state *state,
> +               size_t offset, size_t size);
> +
> +Must be called to sync the IOMMU page tables for IOVA-range mapped by on=
e or
> +more calls to ``dma_iova_link()``.
> +
> +For drivers that use a one-shot mapping, all ranges can be unmapped and =
the
> +IOVA freed by calling:
> +
> +::
> +
> +   void dma_iova_destroy(struct device *dev, struct dma_iova_state *stat=
e,
> +               enum dma_data_direction dir, unsigned long attrs);
> +
> +Alternatively drivers can dynamically manage the IOVA space by unmapping
> +and mapping individual regions.  In that case
> +
> +::
> +
> +    void dma_iova_unlink(struct device *dev, struct dma_iova_state *stat=
e,
> +               size_t offset, size_t size, enum dma_data_direction dir,
> +               unsigned long attrs);
> +
> +is used to unmap a range previously mapped, and
> +
> +::
> +
> +   void dma_iova_free(struct device *dev, struct dma_iova_state *state);
> +
> +is used to free the IOVA space.  All regions must have been unmapped usi=
ng
> +``dma_iova_unlink()`` before calling ``dma_iova_free()``.
>
>  Part II - Non-coherent DMA allocations
>  --------------------------------------
> --
> 2.47.0
>
>

