Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88999C369D9
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QESgbLfbNX2Y3UvNxy+rKh4qRh0SduwfR4pzjcuKRTw=; b=X3oxjS3jnWy+FjJ5h1F6et1X6p
	G9po33lq/LretwZQtqXxgFqJLB/v8cvlLrGF2lgGJ2w7EDPkOKcm3pwxvL8qD1Y8NyUzg9i0BZjHa
	a6dPMtBLSWArAih4Ylb0K7C6sFwztAYqCwkFlE0wOTRw6OQvreI19JJji8rfl0TRGcqO4F5D0+MQ/
	SLRPdi6HzpBBCkBFZaT/T/8KDRBqXtuMMJZszqukr2JXkiPX7ueTr7V4pELAwmdCyw2C0bTdaRRoR
	W1i5LciKxvZyG9cJRBrjIya3w8NoeJcYkHPJawTqoaAgbIejCcAWOwvEw4PJd3BQ+n4l4o8Ajb52f
	dwkS+Neg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7f7v-0000000BdAg-2LiG;
	Wed, 23 Apr 2025 18:47:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7eK6-0000000BQzN-2eyJ
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 17:55:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745430948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QESgbLfbNX2Y3UvNxy+rKh4qRh0SduwfR4pzjcuKRTw=;
	b=OylRHPXkMXCdpMWLIFOxBc2A1uH9sxW9o4tx0ZcauxTBJwKeG5WIcwdbnxgDH6LjHcLUcW
	wvcUirnz1gkUdfN7xz54DSgFPtbTS8UMraFhphT4oNnOgVrbM2OcUTc+0xFqhsSL7YCPLy
	CVrfeBnG915GWequEdgdxeXjSfAnOeo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-YVwnaDe7PM220dIlWp3WTw-1; Wed, 23 Apr 2025 13:54:10 -0400
X-MC-Unique: YVwnaDe7PM220dIlWp3WTw-1
X-Mimecast-MFC-AGG-ID: YVwnaDe7PM220dIlWp3WTw_1745430849
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5498d2a8b88so30390e87.1
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 10:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430849; x=1746035649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QESgbLfbNX2Y3UvNxy+rKh4qRh0SduwfR4pzjcuKRTw=;
        b=Byzg8bV0ApA1OkhC45yysSnhjzOxnKQcGL1uopUHO1j89LxJc7BZZYryXuqpcdbSgT
         Rnc49ulouM+IKDPyN1XNRVKTSoI+Z14ZOQ0c2vqHWUCxGH6tffXbjvEKgltmfbMwJhps
         idjs43pp+5EJSci4wTn3TkmaSbivPUpOrH1o/ndjK9VhPMatH2dcvgOQ862ZQ0Xw2hnZ
         5DBX4vOEXUKgYCHH+GtbM0d5XBdxZjjgLPQulyj+pSWbte0lwfhUIJlnj0TLSF8Fkxmh
         NKjSu21iXEI6wOWJmu/h9d/omV42S4dwSHSJkYQE8wwX6WdGU3QrZs/VNQcwJIdVvWLk
         HPEA==
X-Forwarded-Encrypted: i=1; AJvYcCWe0Bo4mibRoyPu4OW4KLsmvXDtdCX/9WuAyMjeZ54lo5vxv/LAv1Mr/NFGv5AEiVawMubA/w3uCBOz@lists.infradead.org
X-Gm-Message-State: AOJu0Yyirzxk7+FQL/IdiC8o8uHdeKkuJr2xcqLNWi4XrwuAPkMeKv6B
	lVeGQXL+LuTDQM6zYYwpQ3UOM7tQFWYcMZKUFnXd2TuQWvd73mvQq35avboOigvi6VZfSy0wGYX
	yIM+IzqCKNErP0LADtKLeyc+ZGkac3yPNCnQjurZCUrYwGaiJk11f7Mr2dmxytMw=
X-Gm-Gg: ASbGncvWcglWS9Ibai4NxMggT8xbeZ6IgPeQgRF2i9f8lpFNfkfOL/4PpYj/SiyB2k3
	tUD827yuInnibz7+YqVSUX0nCdrCh2ZaQCLARZcfUcEJ2NI4yfrmK1hcvd73dtkvUmnlwSrqkza
	rzjl2/KEzPtVmDLJyQaDgq0+WHOVQ9q8PENilXEqe4otnMueF7RHw5QjpMexxYtbHjYaqC9TTdR
	0w48hycm76n5ARuvcFYlwN4yXalv/Co5Y5Larzq7C16M3xXtHOyb0JeZ1vAyhfoTG+3M5Mqgg4n
	usNDnwA6pNJLrfs8OaoJSYnouwe7zexdfh8URA==
X-Received: by 2002:a05:6512:1318:b0:545:2b24:c714 with SMTP id 2adb3069b0e04-54d6e62c9c2mr6285136e87.18.1745430848649;
        Wed, 23 Apr 2025 10:54:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzJrFtBxv3ILf8kxudvvXLLQMA4k/wXdgyXDUK6/Kq+MOMB6h4q33zBlb3xTdNXEt/3B1MQg==
X-Received: by 2002:a05:6512:1318:b0:545:2b24:c714 with SMTP id 2adb3069b0e04-54d6e62c9c2mr6285107e87.18.1745430848074;
        Wed, 23 Apr 2025 10:54:08 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6e540ec1sm1595753e87.85.2025.04.23.10.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 10:54:07 -0700 (PDT)
Message-ID: <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>
Date: Wed, 23 Apr 2025 20:54:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Chuck Lever <chuck.lever@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Dan Williams
 <dan.j.williams@intel.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yYKoq5rsZU24EJ4EytjdjsKBhJiPeqGezrhc2udNnP4_1745430849
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_105550_752093_9C41561E 
X-CRM114-Status: GOOD (  30.47  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 11:34:49 -0700
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

Hi,

On 4/23/25 11:13, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Introduce new sticky flag (HMM_PFN_DMA_MAPPED), which isn't overwritten
> by HMM range fault. Such flag allows users to tag specific PFNs with
> information if this specific PFN was already DMA mapped.
>
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/linux/hmm.h | 17 +++++++++++++++
>  mm/hmm.c            | 51 ++++++++++++++++++++++++++++-----------------
>  2 files changed, 49 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 126a36571667..a1ddbedc19c0 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -23,6 +23,8 @@ struct mmu_interval_notifier;
>   * HMM_PFN_WRITE - if the page memory can be written to (requires HMM_PFN_VALID)
>   * HMM_PFN_ERROR - accessing the pfn is impossible and the device should
>   *                 fail. ie poisoned memory, special pages, no vma, etc
> + * HMM_PFN_DMA_MAPPED - Flag preserved on input-to-output transformation
> + *                      to mark that page is already DMA mapped
>   *
>   * On input:
>   * 0                 - Return the current state of the page, do not fault it.
> @@ -36,6 +38,13 @@ enum hmm_pfn_flags {
>  	HMM_PFN_VALID = 1UL << (BITS_PER_LONG - 1),
>  	HMM_PFN_WRITE = 1UL << (BITS_PER_LONG - 2),
>  	HMM_PFN_ERROR = 1UL << (BITS_PER_LONG - 3),
> +
> +	/*
> +	 * Sticky flags, carried from input to output,
> +	 * don't forget to update HMM_PFN_INOUT_FLAGS
> +	 */
> +	HMM_PFN_DMA_MAPPED = 1UL << (BITS_PER_LONG - 7),
> +

How is this playing together with the mapped order usage?


> HMM_PFN_ORDER_SHIFT = (BITS_PER_LONG - 8),
>  
>  	/* Input flags */
> @@ -57,6 +66,14 @@ static inline struct page *hmm_pfn_to_page(unsigned long hmm_pfn)
>  	return pfn_to_page(hmm_pfn & ~HMM_PFN_FLAGS);
>  }
>  
> +/*
> + * hmm_pfn_to_phys() - return physical address pointed to by a device entry
> + */
> +static inline phys_addr_t hmm_pfn_to_phys(unsigned long hmm_pfn)
> +{
> +	return __pfn_to_phys(hmm_pfn & ~HMM_PFN_FLAGS);
> +}
> +
>  /*
>   * hmm_pfn_to_map_order() - return the CPU mapping size order
>   *
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 082f7b7c0b9e..51fe8b011cc7 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -39,13 +39,20 @@ enum {
>  	HMM_NEED_ALL_BITS = HMM_NEED_FAULT | HMM_NEED_WRITE_FAULT,
>  };
>  
> +enum {
> +	/* These flags are carried from input-to-output */
> +	HMM_PFN_INOUT_FLAGS = HMM_PFN_DMA_MAPPED,
> +};
> +
>  static int hmm_pfns_fill(unsigned long addr, unsigned long end,
>  			 struct hmm_range *range, unsigned long cpu_flags)
>  {
>  	unsigned long i = (addr - range->start) >> PAGE_SHIFT;
>  
> -	for (; addr < end; addr += PAGE_SIZE, i++)
> -		range->hmm_pfns[i] = cpu_flags;
> +	for (; addr < end; addr += PAGE_SIZE, i++) {
> +		range->hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
> +		range->hmm_pfns[i] |= cpu_flags;
> +	}
>  	return 0;
>  }
>  
> @@ -202,8 +209,10 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
>  		return hmm_vma_fault(addr, end, required_fault, walk);
>  
>  	pfn = pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> -	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++)
> -		hmm_pfns[i] = pfn | cpu_flags;
> +	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
> +		hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
> +		hmm_pfns[i] |= pfn | cpu_flags;
> +	}
>  	return 0;
>  }
>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> @@ -230,14 +239,14 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>  	unsigned long cpu_flags;
>  	pte_t pte = ptep_get(ptep);
>  	uint64_t pfn_req_flags = *hmm_pfn;
> +	uint64_t new_pfn_flags = 0;
>  
>  	if (pte_none_mostly(pte)) {
>  		required_fault =
>  			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
>  		if (required_fault)
>  			goto fault;
> -		*hmm_pfn = 0;
> -		return 0;
> +		goto out;
>  	}
>  
>  	if (!pte_present(pte)) {
> @@ -253,16 +262,14 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>  			cpu_flags = HMM_PFN_VALID;
>  			if (is_writable_device_private_entry(entry))
>  				cpu_flags |= HMM_PFN_WRITE;
> -			*hmm_pfn = swp_offset_pfn(entry) | cpu_flags;
> -			return 0;
> +			new_pfn_flags = swp_offset_pfn(entry) | cpu_flags;
> +			goto out;
>  		}
>  
>  		required_fault =
>  			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
> -		if (!required_fault) {
> -			*hmm_pfn = 0;
> -			return 0;
> -		}
> +		if (!required_fault)
> +			goto out;
>  
>  		if (!non_swap_entry(entry))
>  			goto fault;
> @@ -304,11 +311,13 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>  			pte_unmap(ptep);
>  			return -EFAULT;
>  		}
> -		*hmm_pfn = HMM_PFN_ERROR;
> -		return 0;
> +		new_pfn_flags = HMM_PFN_ERROR;
> +		goto out;
>  	}
>  
> -	*hmm_pfn = pte_pfn(pte) | cpu_flags;
> +	new_pfn_flags = pte_pfn(pte) | cpu_flags;
> +out:
> +	*hmm_pfn = (*hmm_pfn & HMM_PFN_INOUT_FLAGS) | new_pfn_flags;
>  	return 0;
>  
>  fault:
> @@ -448,8 +457,10 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
>  		}
>  
>  		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> -		for (i = 0; i < npages; ++i, ++pfn)
> -			hmm_pfns[i] = pfn | cpu_flags;
> +		for (i = 0; i < npages; ++i, ++pfn) {
> +			hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
> +			hmm_pfns[i] |= pfn | cpu_flags;
> +		}
>  		goto out_unlock;
>  	}
>  
> @@ -507,8 +518,10 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
>  	}
>  
>  	pfn = pte_pfn(entry) + ((start & ~hmask) >> PAGE_SHIFT);
> -	for (; addr < end; addr += PAGE_SIZE, i++, pfn++)
> -		range->hmm_pfns[i] = pfn | cpu_flags;
> +	for (; addr < end; addr += PAGE_SIZE, i++, pfn++) {
> +		range->hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
> +		range->hmm_pfns[i] |= pfn | cpu_flags;
> +	}
>  
>  	spin_unlock(ptl);
>  	return 0;


