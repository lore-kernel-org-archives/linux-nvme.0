Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A528D0D145
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 17:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=qqRRXfsnDn/JT992sHlX9c5HhYEqI89XeJWo7L/gqTk=; b=0ed7ipxp3EoOgs
	gtjxbc2xkBODXAcauT/zpNVC0/6iYvtDqEzdRq4uTYQPYAh6oCussQGSbRn56+ZCRRrxmNF2JNjMT
	Ylj7ox047ReHZsto2aoNBIZyriZ4MrOksFhnBQ1WsebqcaNPxBEJqXnLE0nR42NPUbIsbwqHKJoH/
	VTfRiHh/73VUChj85eR5BmG/UBj1JRdXQWEuJZkKKYYuao+vwXuDIIc2LxnlVnJjsjjUYPMDpo/Ky
	LN1bpk0Dlb1HkxCQAyWtQf5zRP41E3QKLk2da2fKs/F0iC4D53Ro7Af4N8JySm1jsAUz6++RGmzEM
	Es8y15L8361QFBBDtA2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdXA4-0000000FMSj-3lGQ;
	Wed, 07 Jan 2026 17:17:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdX9z-0000000FMSG-0yKu
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 17:17:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5471E60007;
	Wed,  7 Jan 2026 17:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80D5C4CEF1;
	Wed,  7 Jan 2026 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767806246;
	bh=q4ABnJ3CuJh6SWMrNmKQBlZ1gSO4Xo85FUt+DD5A26g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eNubg6mCK0SobRhjYoJFNql7uzoEIcWdOyZJ+7syVmoIAFPWxpQ5qk1OOcXtWvMZ/
	 EbPHNXCZGtKZWWLsyI8zNvbSgvEieOwFWos8HvgZ4qWEKGQTKr05nmNdPviq5otgrV
	 JoQ/n69F/t8qi0aHv/HswTkB3At6+u3ybtrUr1olX76MWaOP4a8ReA8a6ROjFZW+WV
	 QJ2qg+4PSGtZcaScVyLanjOBFEZqkgn8fNRL3vAt6Z6WgA/y3ZaRgAa8awY6iNpQcY
	 4Ye4/PyvwQpPnPzETDMuanANGjYLf2TXtc13gr512AogQUIbY3aQO3Wdt+503UOuhx
	 yoqZd+rSkrJdg==
Date: Wed, 7 Jan 2026 11:17:24 -0600
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
Message-ID: <20260107171724.GA432074@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107143942.GB14904@lst.de>
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

On Wed, Jan 07, 2026 at 03:39:42PM +0100, Christoph Hellwig wrote:
> On Mon, Dec 22, 2025 at 09:50:18AM -0700, Logan Gunthorpe wrote:
> > > Fixes: b7e282378773 ("mm/mm_init: move p2pdma page refcount initialisation to p2pdma")
> > > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > 
> > Thanks for the fix
> > 
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Can we get these fixes queued up ASAP while discussing the new
> feature?

I assume you mean the first two patches:

  PCI/P2PDMA: Release the per-cpu ref of pgmap when vm_insert_page() fails
  PCI/P2PDMA: Fix the warning condition in p2pmem_alloc_mmap()

I can certainly queue these up.  The second is a warning fix, and the
first fixes a hang that has apparently been around since v6.2
(7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through
sysfs")).

Given that, I would ordinarily target the v6.20 merge window, but the
"ASAP" suggests more urgency.  Do you want one or both for v6.19?

Bjorn

