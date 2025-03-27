Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0A8C3600C
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Mar 2025 17:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e7qhW86gw6ksGrHv917jkoJ0GWbsFORRxJCR5hvi1mw=; b=T9bgCRvugsmQ/Z7XuDnbhX1jfA
	HR6I9E3dci8EdJJJqV3NII5JNxsCTJtvBmh7HkhClYtED2uGlcEN0MFV2eF3nuXPq/R1aKSZDQF/j
	vjasrYKCwTrMLkgpJdmP9WqhrQLIMLbSZ8L2MWOGIiDNl8a1IUf+myYBhN8SqI4cv4NtA0GwBmPdM
	ojrgVX1iDCQ9IxD3K+SmQppFjG3f0AT7/PQyElr8sAgGGSlVSmUd3BKFKZtZS76b8+RmW8h1M9wJt
	3UczuVy9xAZkkmvlFpZKu0bqygmwO/Da4myMkMoJWMkyy0YnwVbnEzZZN/57FMRmSmJ71fgnLSc5b
	+NsfeafQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txrSu-0000000BhQm-1nQs;
	Thu, 27 Mar 2025 17:56:28 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txrSs-0000000BhPv-2sVz;
	Thu, 27 Mar 2025 17:56:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e7qhW86gw6ksGrHv917jkoJ0GWbsFORRxJCR5hvi1mw=; b=AmCJf6kahzOBXmlRcZU8wcX3UF
	vmpXttqhE88Uw9luLugvLY8ttEAe3Qrdn/hrMNYj1RpQrsF+oakUI7Cd3NAYtbi8bVOxVO7VF+pba
	OygCb1bDerYbCdHAEuH9l3HNniJ5IjxjEqEyOV++P1P2pESA00mnNENWicqltuP/mcd+9rVC60uWk
	WAXxKcEQL66uC31I2kut7Ui8EdyOvI8TmSbdySN8Qy/5Ndm5pQcV7UEw0NaBa6acY6rFLUmrc2SNw
	QjEzkFN7uacSjs9MLeTdSwAHAerZ7cznOYlNPS8hVZKhbuUaB0Vvk/3YEdUBeCgRHT3M8IjUyuna/
	vxJ0avNw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txrSi-0000000FIF4-1ITi;
	Thu, 27 Mar 2025 17:56:16 +0000
Date: Thu, 27 Mar 2025 17:56:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 00/17] Provide a new two step DMA mapping API
Message-ID: <Z-WRQOYEvOWlI34w@casper.infradead.org>
References: <cover.1738765879.git.leonro@nvidia.com>
 <20250220124827.GR53094@unreal>
 <1166a5f5-23cc-4cce-ba40-5e10ad2606de@arm.com>
 <20250302085717.GO53094@unreal>
 <e024fe3d-bddf-4006-8535-656fd0a3fada@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e024fe3d-bddf-4006-8535-656fd0a3fada@arm.com>
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

On Fri, Mar 21, 2025 at 04:05:22PM +0000, Robin Murphy wrote:
> > The main issue which we are trying to solve "abuse of SG lists for
> > things without struct page", is not going to disappear by itself.
> 
> What everyone seems to have missed is that while it is technically true that
> the streaming DMA API doesn't need a literal struct page, it still very much
> depends on something which having a struct page makes it sufficiently safe
> to assume: that what it's being given is valid kernel memory that it can do
> things like phys_to_virt() or kmap_atomic() on. A completely generic DMA
> mapping API which could do the right thing for any old PFN on any system
> would be a very hard thing to achieve, and I suspect even harder to do
> efficiently. And pushing the complexity into every caller to encourage and
> normalise drivers calling virt_to_phys() all over (_so_ many bugs there...)
> and pass magic flags to influence internal behaviour of the API
> implementation clearly isn't scalable. Don't think I haven't seen the other
> thread where Christian had the same concern that this "sounds like an
> absolutely horrible design."

Doing I/O to memory which does not have a struct page is the whole point
of this series (and many many more patches to come in the future).

This is very useful functionality to have.  Xen can do it, which is
advantageous for a hypervisor as it really doesn't use the struct page
for anything; that memory is assigned to the guest and the host only
needs the page in order to do I/O on belaf of the guest.

I first came up against this problem with the 3DXP project, which is now
dead but there are other similar projects that involve giving each
machine in a cluster access to a large amount of shared memory, and
there's not really a good place to allocate the memmap from.
And the only reason to allocate memmap is so that we can do I/O to
this memory.

I'm sure there are other use cases.  Given that nVidia are so
interested in this, I would guess that at least one of them involves
a graphics card.

I don't think that phys_to_virt() is something that has ever been
guaranteed to work (HIGHEMEM and so on).  I do think that we should
support kmap_local_phys() for these things -- there's no need to
have a struct page for that.

I haven't looked at the implementation, but I think we need to agree
that this is useful functionality to have, or this isn't going anywhere.

