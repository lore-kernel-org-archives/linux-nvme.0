Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A38D30CDB
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jan 2026 23:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BSFJmjqkr3SG+Wmzr05iwRwKLgAbLdJHQWRc2GNC65g=; b=4djK8swrF3gNjc
	TUW4rPOxwRdtEIyMCSK3cUoSg9L5qufg2dcSE7BL5gURx5wmSLbMO3xo0pWBXxSAoQMrQ0LGLbljc
	YGv9y5j6d/5EuII2pO428jL3dWRHyqpIHy2+7l/+zvy4Qq4YuXJ/8dpWH2XPInD/uGfpi2xwk+flu
	GMmUTaHvNndwlXNbBGtVW37rU60g2tg39aXTrK7F7vYNkPP1C5Fv2+7l/G17Oo7sgEmgxoECqBccj
	EEYsqVOCC342y52aucvyNDKEfXooMZPnCNfI1L21zLPYPhYwoMvYMjFvQ0bFkmIjOf8VNIZX3pKhr
	AbMe+cDtikK8Q/VLKHhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfnvQ-00000007sSL-0aT8;
	Tue, 13 Jan 2026 23:35:48 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfnvL-00000007sRa-2rqe
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jan 2026 23:35:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=BSFJmjqkr3SG+Wmzr05iwRwKLgAbLdJHQWRc2GNC65g=; b=j2r+6Q9Rd1jlEMASSc+4qmx7gT
	wAMSprno495z+UF0PvP/iZLFC+KkJsLKKbfNeXHjm9yNdml575qdsEtvTg8L7oIl/2UpblCFvdllL
	oDC8D/H3i7ybC4bucF+qUUiDKin2wW90hxwp5txaulpA4sST+834nRRD0Xv+u+lnXBaOy/c5PFyxE
	9/Eo72mJQSkEJnZ7Ozt5V56yP7w9gAJ4xJe6oJa3an+mbmkx3I7KclYQRqIDXKdXZkbXDpjCo42nB
	rnFCeC+sYuIx1NohJPt69cjom2QdSDVIpJ62dRl1DbSRhqYj/Zg+rGOmNCKMFWHi8SusF7VxhkwI8
	VMe4hlOQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vfnvG-00000000mAR-2Lj7;
	Tue, 13 Jan 2026 16:35:39 -0700
Message-ID: <e2e4cbdd-2abe-4e25-9cf2-746af5ede443@deltatee.com>
Date: Tue, 13 Jan 2026 16:34:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alistair Popple <apopple@nvidia.com>, helgaas@kernel.org
Cc: houtao@huaweicloud.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, bhelgaas@google.com, leonro@nvidia.com,
 gregkh@linuxfoundation.org, tj@kernel.org, rafael@kernel.org,
 dakr@kernel.org, akpm@linux-foundation.org, david@kernel.org,
 lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, houtao1@huawei.com
References: <20260112005440.998543-1-apopple@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260112005440.998543-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: apopple@nvidia.com, helgaas@kernel.org, houtao@huaweicloud.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-nvme@lists.infradead.org, bhelgaas@google.com, leonro@nvidia.com, gregkh@linuxfoundation.org, tj@kernel.org, rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, houtao1@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] PCI/P2PDMA: Reset page reference count when page mapping
 fails
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_153543_724782_F54A7001 
X-CRM114-Status: GOOD (  13.73  )
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

Hi Alistair,

On 2026-01-11 17:54, Alistair Popple wrote:
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

I had time today to pull out some old hardware and run this patch
through my old p2pdma smoke tests. I don't think the tests exercise the
change, but it looks correct to me on review.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks for the fix!

Logan

