Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102F5D0D170
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 20:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=zzo+3C/hPTxFw/xRNJRkyrKmK7xeVFmoq79bpzpX3Ls=; b=LzC1zomDtD4mLw
	8eCjHUp6vkFj+uJnXNAmgp0BmRBHBYPTZkPuIbF/qs4/bH4SUzpaeF2UHod/cifT6Gb/T6MYmPxRl
	zzZZIT0NknJlibWC9M1UsVR3vQFWOP3jCzN77V8jpJreEXHwnDV8WU7WPuggLSyzsHwPriaewzLJA
	67hqu/UdNdE7hula4QBnJcKzhQJBbo0I+VnNncmPPeqf7sLBfL2kgisdNcIB5AEC0hr1S3mkE9NmE
	A2NuBQl2Mb7IQsFA3AIKiDAz9Hq2f+a19WUUiejNPgI8jp0KOKZHox/Jo5QoRzJBGPz7lUrqkNsg0
	HXKztC82XwI/KtWWlTNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdaF4-0000000FcXj-2c52;
	Wed, 07 Jan 2026 20:34:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdaEv-0000000FcX5-34l0
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 20:34:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 091944414B;
	Wed,  7 Jan 2026 20:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76CFC4CEF1;
	Wed,  7 Jan 2026 20:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767818080;
	bh=AOWaSug2G86K93bzxMiGRrg2OWHdAUJfYh0qmRde9cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Zkagjpi/muS2VGzfUQjIxWGGH6i70N++9x5xZTIbkQuBU/DRrQKhH+4pJNASzSy7j
	 VZVMqRapNWwBVu4ByYANDdpu5Sr1knnVuTrRyvvD9WvCdJEJGw7K64bSO0hKmfhQqY
	 OThU+sNzp56YiPAIE2t6FI8X1MJjVuPhzRzGd7emskjfYVBBhV532eSF+mtSAlV4PM
	 /Bk4PfbiIBZ6xke04u2/c0EbrakDa/8EflVBSSO3zKX1nL5AtFS09ovFmx7BrgOCgU
	 tmdVAzw0ELBLL1dewvzFHL5enSxqyAR/O6JMjvEonF6tFvrO5qIZ2ZFH4+K24yXrjT
	 cQqiR/XDuYSbQ==
Date: Wed, 7 Jan 2026 14:34:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, Hou Tao <houtao@huaweicloud.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, linux-nvme@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, houtao1@huawei.com
Subject: Re: [PATCH 02/13] PCI/P2PDMA: Fix the warning condition in
 p2pmem_alloc_mmap()
Message-ID: <20260107203439.GA446340@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107171724.GA432074@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_123446_054008_15CE13FA 
X-CRM114-Status: GOOD (  19.53  )
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

On Wed, Jan 07, 2026 at 11:17:24AM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 07, 2026 at 03:39:42PM +0100, Christoph Hellwig wrote:
> > On Mon, Dec 22, 2025 at 09:50:18AM -0700, Logan Gunthorpe wrote:
> > > > Fixes: b7e282378773 ("mm/mm_init: move p2pdma page refcount initialisation to p2pdma")
> > > > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > > 
> > > Thanks for the fix
> > > 
> > > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > 
> > Can we get these fixes queued up ASAP while discussing the new
> > feature?
> 
> I assume you mean the first two patches:
> 
>   PCI/P2PDMA: Release the per-cpu ref of pgmap when vm_insert_page() fails
>   PCI/P2PDMA: Fix the warning condition in p2pmem_alloc_mmap()
> 
> I can certainly queue these up.  The second is a warning fix, and the
> first fixes a hang that has apparently been around since v6.2
> (7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through
> sysfs")).
> 
> Given that, I would ordinarily target the v6.20 merge window, but the
> "ASAP" suggests more urgency.  Do you want one or both for v6.19?

I put the patches above on pci/p2pdma for v6.20 until I hear
otherwise.

Bjorn

