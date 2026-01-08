Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A71D1D478
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jan 2026 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=GL/JyBjUJmShYOyJwPO5n+a/X7IaKmCFq2H7t69Lepk=; b=taZRGZVpy1LetV
	vY0wJYuzPVz0zvo3pQ83baKsrB1btO3jxEgs/LnZDpv2/i4vbsPpWVsOR9cM3j4ztncwBDjNOlgg/
	ST9W4I8gLpVN91uTUFBgzFC+EGohC3iVP0d4TLGYjBvwo7OevqP4di53oYbtQCLlEmA4zEY3VVj+z
	Hwc/iV83yBO7U4446OmnbiN+kZvJQd+aboD12hnPciSYCPT+LNfzdT3mTgEsXomYOj94b/77EsKm/
	AsnymJxlyi0pQpBXJX3S4dn3CClDNmqH2Qi5srVFxLlt1pvbYB16AZqXy50AfU9mcD/nNee5fWfkO
	h+xTY/gRUeasf2gHpNaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdsMk-000000000ZG-4Bjy;
	Thu, 08 Jan 2026 15:56:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdsMj-000000000Ys-32Ld
	for linux-nvme@lists.infradead.org;
	Thu, 08 Jan 2026 15:56:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D35EF60130;
	Thu,  8 Jan 2026 15:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFD6C116C6;
	Thu,  8 Jan 2026 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767887760;
	bh=GfulWa/ARu4Yr8rPC67SODwYIn35P8iw0erhJXUkXcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=smTz0YN5YLFmAlOwB/XE8lSG6WmMP9wwqSDofdB02oq65EsOYfnBlUklxTr+EgvDK
	 D8lBV6Neawx+hCoXcQ6EgI+F4Vv4Zrwc9mjuyRoN2D9iz15mp/8X/xXkIDpluV8Z1+
	 2w9Aq1d0cFAIHm7EvNx2GH1ulX6+5eXLtIUGYofhwcoOT947MRxroquuxMdN+9IewD
	 W929EV3dvo4vDZAvAU27sNCWOs2xaEra2+bel24JzUK8CDMgc77ZvAVp3//FojQ+v7
	 kOs71Vya+liqOAZf8HJg6nkTyKyr+a/U1QkBeLh3lRWlYEt1McXz1ecpnZeMxewfMx
	 W9fCRcqMSwgog==
Date: Thu, 8 Jan 2026 09:55:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	houtao1@huawei.com
Subject: Re: [PATCH 01/13] PCI/P2PDMA: Release the per-cpu ref of pgmap when
 vm_insert_page() fails
Message-ID: <20260108155558.GA482755@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46lz5szq44vz3chzj6unh2sff4cfnpyvih7zty6fcnitzyrulu@6a2xdopoafxt>
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

On Thu, Jan 08, 2026 at 02:23:16PM +1100, Alistair Popple wrote:
> On 2025-12-20 at 15:04 +1100, Hou Tao <houtao@huaweicloud.com> wrote...
> > From: Hou Tao <houtao1@huawei.com>
> > 
> > When vm_insert_page() fails in p2pmem_alloc_mmap(), p2pmem_alloc_mmap()
> > doesn't invoke percpu_ref_put() to free the per-cpu ref of pgmap
> > acquired after gen_pool_alloc_owner(), and memunmap_pages() will hang
> > forever when trying to remove the PCIe device.
> > 
> > Fix it by adding the missed percpu_ref_put().
> 
> This pairs with the percpu_ref_tryget_live_rcu() above right? Might
> be worth mentioning that as a comment, but overall looks good to me
> so feel free to add:
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

Added your Reviewed-by, thanks!

Would the following commit log address your suggestion?

  When the vm_insert_page() in p2pmem_alloc_mmap() failed, we did not
  invoke percpu_ref_put() to free the per-CPU pgmap ref acquired by
  percpu_ref_tryget_live_rcu(), which meant that PCI device removal would
  hang forever in memunmap_pages().

  Fix it by adding the missed percpu_ref_put().

Looking at this again, I'm confused about why in the normal, non-error
case, we do the percpu_ref_tryget_live_rcu(ref), followed by another
percpu_ref_get(ref) for each page, followed by just a single
percpu_ref_put() at the exit.

So we do ref_get() "1 + number of pages" times but we only do a single
ref_put().  Is there a loop of ref_put() for each page elsewhere?

> > Fixes: 7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through sysfs")
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >  drivers/pci/p2pdma.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index 4a2fc7ab42c3..218c1f5252b6 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> > @@ -152,6 +152,7 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
> >  		ret = vm_insert_page(vma, vaddr, page);
> >  		if (ret) {
> >  			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
> > +			percpu_ref_put(ref);
> >  			return ret;
> >  		}
> >  		percpu_ref_get(ref);
> > -- 
> > 2.29.2
> > 

