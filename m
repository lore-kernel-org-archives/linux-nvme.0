Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A329AC52D7C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 08:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tvmG/sMa+Qp7dOabskQKJ8ju2mqFsxT02CkXxGsxk9Q=; b=zqgpH15hgQmVDjejZyVV7h9e1y
	BGLX79W/umnUggRUS2xUKp0Wwqa/w7eSOmxN460LVpFR82Oz5suuf3xXMctdSekF66BaTwTabn04v
	YlfQgtKsdC3pL4oxS6Y++5YoTfEkYnp5QiNtH8D00ZvHEkctxPL0zZqmJYcms9T6on67cgKJUFtCO
	xPk53Z7AY0JyaMRtEcBOkNM+7MFRx+fd+utqzEAGvEJg360HHccXXjtILqvw3HinveseOj8p+1nqZ
	XFNR0NxLwfdEIHRrm2ZXbRFSGOAlKXWAaao5Jov0pRr8dwN1tjSj9uk35j52IazI68EYn8VeB16AQ
	8ZnWokMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shPG5-0000000FkG0-2wkU;
	Fri, 23 Aug 2024 08:02:57 +0000
Received: from bee.tesarici.cz ([37.205.15.56])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shPG3-0000000FkF2-0QIk
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 08:02:56 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 2D8C21EFF40;
	Fri, 23 Aug 2024 10:02:53 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724400173; bh=tvmG/sMa+Qp7dOabskQKJ8ju2mqFsxT02CkXxGsxk9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UaMjInLFyWQnfqYiMg3/uumOWVIHR/EHNkJUKfBAIdDHxgnmlxI+sc6jnZlt/X6Ju
	 l8iMbK4HnW6Hm/ExWi2g9Y8cxxiqWWaiohigWu7F06tI1dgJxfXd7f//zLpK+8gMCV
	 zCT0ZTMLplxAAcrWEf1jXuVJ7XNi2qysiG3K3On89gV6KULIvForp9VJj6BFRMQszA
	 7oxN+Xg0KRllxwas/A+U0YTwAcuSXq6WCsU/C9HNpENoXaZLQE+flZg5s7hk591Qd3
	 ml602dwx6ghnW4W8TFbkF/0L+DAYhcOB5lEtVKEQVKqsTdynwT5IE4zJrJ6ZvKFTL/
	 dNY5cWtoRrD2Q==
Date: Fri, 23 Aug 2024 10:02:52 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: mhkelley58@gmail.com
Cc: mhklinux@outlook.com, kbusch@kernel.org, axboe@kernel.dk,
 sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-coco@lists.linux.dev
Subject: Re: [RFC 2/7] dma: Handle swiotlb throttling for SGLs
Message-ID: <20240823100252.4f2a1a43@meshulam.tesarici.cz>
In-Reply-To: <20240822183718.1234-3-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240822183718.1234-3-mhklinux@outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_010255_334163_D0F67174 
X-CRM114-Status: GOOD (  35.71  )
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

On Thu, 22 Aug 2024 11:37:13 -0700
mhkelley58@gmail.com wrote:

> From: Michael Kelley <mhklinux@outlook.com>
> 
> When a DMA map request is for a SGL, each SGL entry results in an
> independent mapping operation. If the mapping requires a bounce buffer
> due to running in a CoCo VM or due to swiotlb=force on the boot line,
> swiotlb is invoked. If swiotlb throttling is enabled for the request,
> each SGL entry results in a separate throttling operation. This is
> problematic because a thread may be holding swiotlb memory while waiting
> for memory to become free.
> 
> Resolve this problem by only allowing throttling on the 0th SGL
> entry. When unmapping the SGL, unmap entries 1 thru N-1 first, then
> unmap entry 0 so that the throttle isn't released until all swiotlb
> memory has been freed.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> This approach to SGLs muddies the line between DMA direct and swiotlb
> throttling functionality. To keep the MAY_BLOCK attr fully generic, it
> should propagate to the mapping of all SGL entries.
> 
> An alternate approach is to define an additional DMA attribute that
> is internal to the DMA layer. Instead of clearing MAX_BLOCK, this
> attr is added by dma_direct_map_sg() when mapping SGL entries other
> than the 0th entry. swiotlb would do throttling only when MAY_BLOCK
> is set and this new attr is not set.
> 
> This approach has a modest amount of additional complexity. Given
> that we currently have no other users of the MAY_BLOCK attr, the
> conceptual cleanliness may not be warranted until we do.
> 
> Thoughts?

If we agree to change the unthrottling logic (see my comment to your
RFC 1/7), we'll need an additional attribute to delay unthrottling when
unmapping sg list entries 1 to N-1. This attribute could convey that
the mapping is the non-initial segment of an sg list and it could then
be also used to disable blocking in swiotlb_tbl_map_single().

> 
>  kernel/dma/direct.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4480a3cd92e0..80e03c0838d4 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -438,6 +438,18 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
>  		arch_sync_dma_for_cpu_all();
>  }
>  
> +static void dma_direct_unmap_sgl_entry(struct device *dev,
> +		struct scatterlist *sgl, enum dma_data_direction dir,

Nitpick: This parameter should probably be called "sg", because it is
never used to do any operation on the whole list. Similarly, the
function could be called dma_direct_unmap_sg_entry(), because there is
no dma_direct_unmap_sgl() either...

> +		unsigned long attrs)
> +
> +{
> +	if (sg_dma_is_bus_address(sgl))
> +		sg_dma_unmark_bus_address(sgl);
> +	else
> +		dma_direct_unmap_page(dev, sgl->dma_address,
> +				      sg_dma_len(sgl), dir, attrs);
> +}
> +
>  /*
>   * Unmaps segments, except for ones marked as pci_p2pdma which do not
>   * require any further action as they contain a bus address.
> @@ -449,12 +461,20 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>  	int i;
>  
>  	for_each_sg(sgl,  sg, nents, i) {
> -		if (sg_dma_is_bus_address(sg))
> -			sg_dma_unmark_bus_address(sg);
> -		else
> -			dma_direct_unmap_page(dev, sg->dma_address,
> -					      sg_dma_len(sg), dir, attrs);
> +		/*
> +		 * Skip the 0th SGL entry in case this SGL consists of
> +		 * throttled swiotlb mappings. In such a case, any other
> +		 * entries should be unmapped first since unmapping the
> +		 * 0th entry will release the throttle semaphore.
> +		 */
> +		if (!i)
> +			continue;
> +		dma_direct_unmap_sgl_entry(dev, sg, dir, attrs);
>  	}
> +
> +	/* Now do the 0th SGL entry */
> +	if (nents)

I wonder if nents can ever be zero here, but it's nowhere enforced and
dma_map_sg_attrs() is exported, so I agree, let's play it safe.

> +		dma_direct_unmap_sgl_entry(dev, sgl, dir, attrs);
>  }
>  #endif
>  
> @@ -492,6 +512,11 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>  			ret = -EIO;
>  			goto out_unmap;
>  		}
> +
> +		/* Allow only the 0th SGL entry to block */
> +		if (!i)

Are you sure? I think the modified value of attrs is first used in the
next loop iteration, so the conditional should be removed, or else both
segment index 0 and 1 will keep the flag.

Petr T

> +			attrs &= ~DMA_ATTR_MAY_BLOCK;
> +
>  		sg_dma_len(sg) = sg->length;
>  	}
>  


