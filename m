Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21EBC369CB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 02:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y6pwEnRnhkHgazDgVxPbcQpa5mERaCMyYK1dziw6UIo=; b=PGar6udKofWN9iSKO5SEQrhXZA
	XhJa581DSjLnBPNPcluXe4sqhLkM5WI8D3o3Flst0P9ry0YkMOF0VsBq/3LiGH0lBMGihq4XaJVRY
	G+PdeBfgfn1OJmqBTWfe7MCV65uF2a6wZImTwEk6gmHP7EYpTI7CpIhY7KfP1wDUHHxbkSU05Y+0H
	PXQ/bYI3XbwO3ylnnR67OvhomyHX3tNjxqCVS2XyHpN74t+i1ZUgEpTIjay4Qk0h71o75C6pIhEgo
	vZ/w6j1Z+SfXXXB+bsY7USfsKmbNhVmPanSxasjuNKm/exZx+BhsplPSbCpu+uywq6tDbIewbLSUA
	4qwywS8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7mn1-0000000Cf7Z-06iY;
	Thu, 24 Apr 2025 02:58:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7eyR-0000000BbIh-36Sf
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 18:37:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745433450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6pwEnRnhkHgazDgVxPbcQpa5mERaCMyYK1dziw6UIo=;
	b=OKUWjwQ33Y3CEfmRTPWjnwt/Yv203NbMviwGsEIX5vlv3km9tJAPGMUScqJkZoTfWyi0A6
	5C7qCbb6z2B+SlphsXI9N8SnmX2CEnsvo3VybIrBdBIt1mrUEnp5/dejjff+fsoniQPaLa
	WB5ZI4VXF9/XN+dqbo0XFtw/ZFCT4Ns=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-LgVhZk5BMRmi3ebeKpO-dA-1; Wed, 23 Apr 2025 14:37:28 -0400
X-MC-Unique: LgVhZk5BMRmi3ebeKpO-dA-1
X-Mimecast-MFC-AGG-ID: LgVhZk5BMRmi3ebeKpO-dA_1745433447
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30bf67adf33so6649371fa.0
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 11:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745433447; x=1746038247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6pwEnRnhkHgazDgVxPbcQpa5mERaCMyYK1dziw6UIo=;
        b=PSUK/CzjfQriilgpneAujL2+bdi2v9Qjr0fa0HLahp+WGjCuJU/fZblxi+cty9gyFk
         9JdQguJ8s7zghJ4Rdud9wLhyDAGAVt4WksXsfkLNe+uW2j8b5atNlZsmdn51PXAkA5rx
         vlMtHQtFngwswYpCp/suHUfISLpotozDp0jlZItrwSPBaeCI+MAlFmym0y5wpxahd2lc
         Y5yWw4SlB1P3SIHaSZC4B/7J6tMhhMspsfm5rqOSLgVAopzwBuImbxuxTy5yn/criiFQ
         FzmPwbcpmZhgqpspd2nBgxFqKlxvO6fngZxwQrwX7Hbc0B8EtqVvhjJ/fJ9iXZ+rEvh3
         tV6g==
X-Forwarded-Encrypted: i=1; AJvYcCUjXL4ouZMHXdGrv6QEE1cow8h0n/eT6hlATMP2AVmujNUOff6p8qaKSpaHolQyy+YLRVIx3KnPRfAV@lists.infradead.org
X-Gm-Message-State: AOJu0YzQwTDd2JBvjZHoakCuKHtrM7Bbrqy0j+ZIOMrE8uFABrCOL6TR
	F+4dbijqC4bVnCX3hqW3Xhud3ELTSUHh0od/caCHJys6zNfaBDM8ZuhqV2mZlJQDOXYxmp9rYdZ
	LG90Y6557vLwVF8jjUOiNf4pRs+iRFz6nrzeGWy46Snebmms6pBAjh3KMYwtXXdA=
X-Gm-Gg: ASbGncu2vHQicnkJwxeMNx6cBGeYZ9Dt3/bFBxfBBCCdVMTalHX8CAX8FfC3z+38hCy
	G5ghBJ+OQyLBZM2qycoq0iYvPOOIAejHLIxwR8xPbXbs3n6NbaMFRMxL9Y0m+u3tuRKbxiceTjT
	MvJWF3LOtix1He2KRSIqxipgyLs849UA3LWKEdRVGtDKIMn+3uAfP2Qjx96Uz1bRG/MZj1dcMaj
	YrZtxDGXDpuQoUwpL46F7hRs+zib0DOoa3LSdNyhsnq9kWZDnh18fg8ed6Wbp6ERZWv4iRPtDQF
	doSXkSql3r+spTzGDIeWIRvd5SBwNkAA77atJg==
X-Received: by 2002:a2e:8818:0:b0:308:e956:66e with SMTP id 38308e7fff4ca-3179449456amr500101fa.0.1745433446936;
        Wed, 23 Apr 2025 11:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeLX03zhP8nSlFHqNWBiKFBjf3MShxZQb8tc2EeW+8vLK6+b+87nnEoR+0vFre3XFcDl9w4g==
X-Received: by 2002:a2e:8818:0:b0:308:e956:66e with SMTP id 38308e7fff4ca-3179449456amr499761fa.0.1745433446435;
        Wed, 23 Apr 2025 11:37:26 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3109075e8e9sm19833701fa.12.2025.04.23.11.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 11:37:26 -0700 (PDT)
Message-ID: <36891b0e-d5fa-4cf8-a181-599a20af1da3@redhat.com>
Date: Wed, 23 Apr 2025 21:37:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
 Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Yishai Hadas <yishaih@nvidia.com>,
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
 <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>
 <20250423181706.GT1213339@ziepe.ca>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20250423181706.GT1213339@ziepe.ca>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ntnbZpwZjFUv1irHF6yoEq8EWyIYGotvZE9gjtOX7lk_1745433447
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_113731_863868_79CBFC6B 
X-CRM114-Status: GOOD (  20.16  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 19:58:12 -0700
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


On 4/23/25 21:17, Jason Gunthorpe wrote:
> On Wed, Apr 23, 2025 at 08:54:05PM +0300, Mika Penttilä wrote:
>>> @@ -36,6 +38,13 @@ enum hmm_pfn_flags {
>>>  	HMM_PFN_VALID = 1UL << (BITS_PER_LONG - 1),
>>>  	HMM_PFN_WRITE = 1UL << (BITS_PER_LONG - 2),
>>>  	HMM_PFN_ERROR = 1UL << (BITS_PER_LONG - 3),
>>> +
>>> +	/*
>>> +	 * Sticky flags, carried from input to output,
>>> +	 * don't forget to update HMM_PFN_INOUT_FLAGS
>>> +	 */
>>> +	HMM_PFN_DMA_MAPPED = 1UL << (BITS_PER_LONG - 7),
>>> +
>> How is this playing together with the mapped order usage?
> Order shift starts at bit 8, DMA_MAPPED is at bit 7

hmm bits are the high bits, and order is 5 bits starting from
(BITS_PER_LONG - 8)


> The pfn array is linear and simply indexed. The order is intended for
> page table like HW to be able to build larger entries from the hmm
> data without having to scan for contiguity.
>
> Even if order is present the entry is still replicated across all the
> pfns that are inside the order.
>
> At least this series should replicate the dma_mapped flag as well as
> it doesn't pay attention to order.
>
> I suspect a page table implementation may need to make some small
> changes. Indeed with guarenteed contiguous IOVA there may be a
> significant optimization available to have the HW page table cover all
> the contiguous present pages in the iommu, which would be a higher
> order than the pages themselves. However this would require being able
> to punch non-present holes into contiguous mappings...
>
> Jason
>
--Mika



