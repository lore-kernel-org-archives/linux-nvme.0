Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D9CCF45AF
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=3xsQVXLwfVFP6CfLeMcZiJ7ZZ/bIA3XEoOt0eQ9EwXU=; b=UXQ3IRI9+HQsJ4
	fNQ7qKXNKDt4iUEFC8QN3KH8TtiGcx7LHc9h8jL/z/slQnhirBKw1MJOQVUcqOq81GinhH5dxs1w3
	bvuFt9VW6f86GDy6vsy09Ru0aUk+uJVPKk6N6I9Mb977GxmGljPFrT5U2Fy8opBVY0MFUb/m5GEfZ
	6jvSyobgu5NvBI3/EuPrLCa/aAm3kC2k3mfoZHj8vu5fpnvMtrE2LB81hu1z7bH/w+b5qukWpyqkU
	stDG0KgAqTpK0tWfK1ufTp+BYDoHNUo5m2246TwvEWcssDKaa7YxYtThaDLAwcor+enmruebmKAXA
	SKa7tSFWXo67HzvuEbYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfLTm-00000005pi5-0eF1;
	Mon, 12 Jan 2026 17:13:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfLTk-00000005phw-37Z9
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jan 2026 17:13:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8C09E6000A;
	Mon, 12 Jan 2026 17:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144AEC116D0;
	Mon, 12 Jan 2026 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768237998;
	bh=CTVrya0benCYisxRFikm+e5pStHqutlTbypDz019q6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SXE+tFKSoL3IJzOL0ppAEPq1Yj7631M2XmO7QzgW1/gIIiFmnoWqfAPWfTBwwxbSM
	 bFp4XbZ9Tun1GbQSuiXmnO35eBQSDD8H1/1xu2uShPTnb8U6Lycln70OJTzwHJ5xb7
	 ZBZqpqy8ntCxqZUB5OrIBKYu0IqEdpxaOMPdTtfWHURIEP8JV0S/nIbkaCiEFVKl11
	 QQzyPFqigdgxEm9DJ/AOJpDmi9cwsGOvdW73h5Oe4dIpZBs6H3kgbxo9tEr957uUHV
	 vb+sz7up2888w2Wal0vkGLAhq3oTi2Lqy9fy8cq6vHZbiAhBq4bMaFzoTvqa+fJOkx
	 7eI9Byrbykzwg==
Date: Mon, 12 Jan 2026 11:13:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: houtao@huaweicloud.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, bhelgaas@google.com,
	logang@deltatee.com, leonro@nvidia.com, gregkh@linuxfoundation.org,
	tj@kernel.org, rafael@kernel.org, dakr@kernel.org,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, houtao1@huawei.com
Subject: Re: [PATCH] PCI/P2PDMA: Reset page reference count when page mapping
 fails
Message-ID: <20260112171316.GA716207@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112005440.998543-1-apopple@nvidia.com>
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

On Mon, Jan 12, 2026 at 11:54:40AM +1100, Alistair Popple wrote:
> When mapping a p2pdma page the page reference count is initialised to
> 1 prior to calling vm_insert_page(). This is to avoid vm_insert_page()
> warning if the page refcount is zero. Prior to setting the page count
> there is a check to ensure the page is currently free (ie. has a zero
> reference count).
> 
> However vm_insert_page() can fail. In this case the pages are freed
> back to the genalloc pool, but that does not reset the page refcount.
> So a future allocation of the same page will see the elevated page
> refcount from the previous set_page_count() call triggering the
> VM_WARN_ON_ONCE_PAGE checking that the page is free.
> 
> Fix this by resetting the page refcount back to zero using
> set_page_count(). Note that put_page() is not used because that
> would result in freeing the page twice due to implicitly calling
> p2pdma_folio_free().
> 
> Fixes: b7e282378773 ("mm/mm_init: move p2pdma page refcount initialisation to p2pdma")
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

Applied to pci/p2pdma for v6.20, thanks!

> ---
> 
> This was found by inspection. I don't currently have a good setup that
> exercises the p2pmem_alloc_mmap() path so this has only been compile
> tested - additional testing would be appreciated.
> ---
>  drivers/pci/p2pdma.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index dd64ec830fdd..3b29246b9e86 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -152,6 +152,12 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>  		ret = vm_insert_page(vma, vaddr, page);
>  		if (ret) {
>  			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
> +
> +			/*
> +			 * Reset the page count. We don't use put_page() because
> +			 * we don't want to trigger the p2pdma_folio_free() path.
> +			 */
> +			set_page_count(page, 0);
>  			percpu_ref_put(ref);
>  			return ret;
>  		}
> -- 
> 2.51.0
> 

