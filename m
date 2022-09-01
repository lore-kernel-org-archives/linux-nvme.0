Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF66ECAAD3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 16:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZluxlTbPzCznTr0q57w/gJQwi0RYMyF063uK0zUOZkw=; b=tI6hlojDYmBF+pwZIEqRht9AKG
	W63O1s4amtmS3/RHf7oP6ZBrCIqh6ctBVF647uffQ0ptc9pLK7viycU//96eKTWaRKOmdBLXQw85B
	OnacqgZBMSOEKQ5w0z3+qkUFbDsbNtK5gJmnfM8lPpaI+KCMGmp73L2LH9M/0FTY8/eRHtRDycyPt
	KnA3zdgp4sVW/LpSiMvwh0wH0SVrNEwz0alEhqw5vMb4Skn2OVSLa2BSKtGeW2Qm0Fqd8eFcBeUY2
	cBx+91mnwgPAXwO64Y00DqO+wDIfrt4bQB5ygel9gqVNOP7r17ERDNjYlGRDWgl7nCFGPYJ29SeqM
	Z1rzrfig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTnHU-00DPBa-2h; Thu, 01 Sep 2022 16:43:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTnHR-00DPAi-F6
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 16:43:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 23B2461FBC;
	Thu,  1 Sep 2022 16:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D49C433D6;
	Thu,  1 Sep 2022 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1662050579;
	bh=3ultyHhs+P42rFCD6PYzoGIxBj3armn1gF+wVWlPCis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xzxJw5Nrr4+Xzt8TcWJ0s8mU3IKt/rHgX4+s4eAqlbUlchGc+T5YxaPpT5Xw8iay6
	 BfSUJQBqHY145kF0eDC+pHEBvfiBoGS1ClV3wSWCa2cvRwQKlg9ys1Q9boBRqLeExT
	 GmltmQHS0TRtufvykQ22YazvRirYbC5ooeg4+DVA=
Date: Thu, 1 Sep 2022 18:42:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 7/8] PCI/P2PDMA: Allow userspace VMA allocations
 through sysfs
Message-ID: <YxDhEO9ycZDTnbZm@kroah.com>
References: <20220825152425.6296-1-logang@deltatee.com>
 <20220825152425.6296-8-logang@deltatee.com>
 <YxDb2MyRx6o/wDAz@kroah.com>
 <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_094301_628229_3DC35C0D 
X-CRM114-Status: GOOD (  41.15  )
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

On Thu, Sep 01, 2022 at 10:32:55AM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2022-09-01 10:20, Greg Kroah-Hartman wrote:
> > On Thu, Aug 25, 2022 at 09:24:24AM -0600, Logan Gunthorpe wrote:
> >> Create a sysfs bin attribute called "allocate" under the existing
> >> "p2pmem" group. The only allowable operation on this file is the mmap()
> >> call.
> >>
> >> When mmap() is called on this attribute, the kernel allocates a chunk of
> >> memory from the genalloc and inserts the pages into the VMA. The
> >> dev_pagemap .page_free callback will indicate when these pages are no
> >> longer used and they will be put back into the genalloc.
> >>
> >> On device unbind, remove the sysfs file before the memremap_pages are
> >> cleaned up. This ensures unmap_mapping_range() is called on the files
> >> inode and no new mappings can be created.
> >>
> >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >> ---
> >>  drivers/pci/p2pdma.c | 124 +++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 124 insertions(+)
> >>
> >> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> >> index 4496a7c5c478..a6ed6bbca214 100644
> >> --- a/drivers/pci/p2pdma.c
> >> +++ b/drivers/pci/p2pdma.c
> >> @@ -89,6 +89,90 @@ static ssize_t published_show(struct device *dev, struct device_attribute *attr,
> >>  }
> >>  static DEVICE_ATTR_RO(published);
> >>  
> >> +static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
> >> +		struct bin_attribute *attr, struct vm_area_struct *vma)
> >> +{
> >> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> >> +	size_t len = vma->vm_end - vma->vm_start;
> >> +	struct pci_p2pdma *p2pdma;
> >> +	struct percpu_ref *ref;
> >> +	unsigned long vaddr;
> >> +	void *kaddr;
> >> +	int ret;
> >> +
> >> +	/* prevent private mappings from being established */
> >> +	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
> >> +		pci_info_ratelimited(pdev,
> >> +				     "%s: fail, attempted private mapping\n",
> >> +				     current->comm);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (vma->vm_pgoff) {
> >> +		pci_info_ratelimited(pdev,
> >> +				     "%s: fail, attempted mapping with non-zero offset\n",
> >> +				     current->comm);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	rcu_read_lock();
> >> +	p2pdma = rcu_dereference(pdev->p2pdma);
> >> +	if (!p2pdma) {
> >> +		ret = -ENODEV;
> >> +		goto out;
> >> +	}
> >> +
> >> +	kaddr = (void *)gen_pool_alloc_owner(p2pdma->pool, len, (void **)&ref);
> >> +	if (!kaddr) {
> >> +		ret = -ENOMEM;
> >> +		goto out;
> >> +	}
> >> +
> >> +	/*
> >> +	 * vm_insert_page() can sleep, so a reference is taken to mapping
> >> +	 * such that rcu_read_unlock() can be done before inserting the
> >> +	 * pages
> >> +	 */
> >> +	if (unlikely(!percpu_ref_tryget_live_rcu(ref))) {
> >> +		ret = -ENODEV;
> >> +		goto out_free_mem;
> >> +	}
> >> +	rcu_read_unlock();
> >> +
> >> +	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
> >> +		ret = vm_insert_page(vma, vaddr, virt_to_page(kaddr));
> >> +		if (ret) {
> >> +			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
> >> +			return ret;
> >> +		}
> >> +		percpu_ref_get(ref);
> >> +		put_page(virt_to_page(kaddr));
> >> +		kaddr += PAGE_SIZE;
> >> +		len -= PAGE_SIZE;
> >> +	}
> >> +
> >> +	percpu_ref_put(ref);
> >> +
> >> +	return 0;
> >> +out_free_mem:
> >> +	gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
> >> +out:
> >> +	rcu_read_unlock();
> >> +	return ret;
> >> +}
> >> +
> >> +static struct bin_attribute p2pmem_alloc_attr = {
> >> +	.attr = { .name = "allocate", .mode = 0660 },
> >> +	.mmap = p2pmem_alloc_mmap,
> >> +	/*
> >> +	 * Some places where we want to call mmap (ie. python) will check
> >> +	 * that the file size is greater than the mmap size before allowing
> >> +	 * the mmap to continue. To work around this, just set the size
> >> +	 * to be very large.
> >> +	 */
> >> +	.size = SZ_1T,
> >> +};
> >> +
> >>  static struct attribute *p2pmem_attrs[] = {
> >>  	&dev_attr_size.attr,
> >>  	&dev_attr_available.attr,
> >> @@ -96,11 +180,32 @@ static struct attribute *p2pmem_attrs[] = {
> >>  	NULL,
> >>  };
> >>  
> >> +static struct bin_attribute *p2pmem_bin_attrs[] = {
> >> +	&p2pmem_alloc_attr,
> >> +	NULL,
> >> +};
> >> +
> >>  static const struct attribute_group p2pmem_group = {
> >>  	.attrs = p2pmem_attrs,
> >> +	.bin_attrs = p2pmem_bin_attrs,
> >>  	.name = "p2pmem",
> >>  };
> >>  
> >> +static void p2pdma_page_free(struct page *page)
> >> +{
> >> +	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
> >> +	struct percpu_ref *ref;
> >> +
> >> +	gen_pool_free_owner(pgmap->provider->p2pdma->pool,
> >> +			    (uintptr_t)page_to_virt(page), PAGE_SIZE,
> >> +			    (void **)&ref);
> >> +	percpu_ref_put(ref);
> >> +}
> >> +
> >> +static const struct dev_pagemap_ops p2pdma_pgmap_ops = {
> >> +	.page_free = p2pdma_page_free,
> >> +};
> >> +
> >>  static void pci_p2pdma_release(void *data)
> >>  {
> >>  	struct pci_dev *pdev = data;
> >> @@ -152,6 +257,19 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
> >>  	return error;
> >>  }
> >>  
> >> +static void pci_p2pdma_unmap_mappings(void *data)
> >> +{
> >> +	struct pci_dev *pdev = data;
> >> +
> >> +	/*
> >> +	 * Removing the alloc attribute from sysfs will call
> >> +	 * unmap_mapping_range() on the inode, teardown any existing userspace
> >> +	 * mappings and prevent new ones from being created.
> >> +	 */
> >> +	sysfs_remove_file_from_group(&pdev->dev.kobj, &p2pmem_alloc_attr.attr,
> >> +				     p2pmem_group.name);
> > 
> > Wait, why are you manually removing the sysfs file here?  It's part of
> > the group, if you do this then it is gone for forever, right?  Why
> > manually do this the sysfs core should handle this for you if the device
> > is removed.
> 
> We have to make sure the mappings are all removed before the cleanup of
> devm_memremap_pages() which will wait for all the pages to be freed.

Then don't use devm_ functions.  Why not just use the manual functions
instead as you know when you want to tear this down.

> If
> we don't do this any userspace mapping will hang the cleanup until those
> uses are unmapped themselves.

Just do this in the remove call yourself and you should be fine.

thanks,

greg k-h

