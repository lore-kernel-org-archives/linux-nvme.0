Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72ACFECAAD8
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 16:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5gkmuO+qoqnmDsP41ZiRbkDae1Udt8/Fk8pl8Xm9Hs0=; b=VFmJhC8P8Wzck1
	j6vLCqScLxfg3eu1Y63QvKc5EljEfp27hOTcZmaH3F5bJBmJo6VE0Rb/jxOeAHAwbeeTuLH0E0lUn
	vkqGBWGNCvfl+Os8AomkqCUgeB247jcb4chals31jIX0E6JOL71d/SGZb4LRx33ofygPmj3PwG5Cz
	nUE6bbBWfaDgKA4fbw7THKG1gcYLzN0Hseb93n0Im3aFkqAsuiJIqD77EOWQrfuVoWFvI2Yf39VED
	XmwPdHBdpndQQvf9KXtWm/fcyraUT3Oj1rxH7eH2Jwt1Asfst/8SEPycaaexaZUCQzvrJynPY1yrc
	i3fkhWsSwdCa9H6jbqTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTn7w-00DMsG-P1; Thu, 01 Sep 2022 16:33:12 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTn7t-00DMpy-84
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 16:33:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=5gkmuO+qoqnmDsP41ZiRbkDae1Udt8/Fk8pl8Xm9Hs0=; b=mOsx/k4psgsJL3q6FjjiML9zVe
	qJ71SG2hugvvrfumPhF5dZZujShfV6qK6vaMaVXOKMOnVglDLQfitdVCYJ+noFk4so4TLGng/SUzQ
	k+TVmZAgcC3pmjLZDA8Op+/DG26pvPZKUF+TgmtapDlPjM3Vu6Lks+x7m61QSlnwTCTa4fYXEY2Tz
	Jy45GIppuKl8F/bICvYHyd4V0iWR/up/OqqQtI45TqUUDbC78aKSRu6CnhXVSUb2DSiVp06jRO59D
	FVQgqVYZVuOUvlsikqOPKgIx51xugfbVrnA5WeUQVeuKUfFG2Eu7pJdzFGniWBCcKj9MkN/ScLbgi
	KbiFhtPg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1oTn7n-00DuUi-W0; Thu, 01 Sep 2022 10:33:04 -0600
Message-ID: <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com>
Date: Thu, 1 Sep 2022 10:32:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, John Hubbard <jhubbard@nvidia.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Stephen Bates <sbates@raithlin.com>
References: <20220825152425.6296-1-logang@deltatee.com>
 <20220825152425.6296-8-logang@deltatee.com> <YxDb2MyRx6o/wDAz@kroah.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YxDb2MyRx6o/wDAz@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v9 7/8] PCI/P2PDMA: Allow userspace VMA allocations
 through sysfs
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_093309_429649_04D73920 
X-CRM114-Status: GOOD (  32.02  )
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




On 2022-09-01 10:20, Greg Kroah-Hartman wrote:
> On Thu, Aug 25, 2022 at 09:24:24AM -0600, Logan Gunthorpe wrote:
>> Create a sysfs bin attribute called "allocate" under the existing
>> "p2pmem" group. The only allowable operation on this file is the mmap()
>> call.
>>
>> When mmap() is called on this attribute, the kernel allocates a chunk of
>> memory from the genalloc and inserts the pages into the VMA. The
>> dev_pagemap .page_free callback will indicate when these pages are no
>> longer used and they will be put back into the genalloc.
>>
>> On device unbind, remove the sysfs file before the memremap_pages are
>> cleaned up. This ensures unmap_mapping_range() is called on the files
>> inode and no new mappings can be created.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  drivers/pci/p2pdma.c | 124 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 124 insertions(+)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 4496a7c5c478..a6ed6bbca214 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -89,6 +89,90 @@ static ssize_t published_show(struct device *dev, struct device_attribute *attr,
>>  }
>>  static DEVICE_ATTR_RO(published);
>>  
>> +static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>> +		struct bin_attribute *attr, struct vm_area_struct *vma)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
>> +	size_t len = vma->vm_end - vma->vm_start;
>> +	struct pci_p2pdma *p2pdma;
>> +	struct percpu_ref *ref;
>> +	unsigned long vaddr;
>> +	void *kaddr;
>> +	int ret;
>> +
>> +	/* prevent private mappings from being established */
>> +	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
>> +		pci_info_ratelimited(pdev,
>> +				     "%s: fail, attempted private mapping\n",
>> +				     current->comm);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (vma->vm_pgoff) {
>> +		pci_info_ratelimited(pdev,
>> +				     "%s: fail, attempted mapping with non-zero offset\n",
>> +				     current->comm);
>> +		return -EINVAL;
>> +	}
>> +
>> +	rcu_read_lock();
>> +	p2pdma = rcu_dereference(pdev->p2pdma);
>> +	if (!p2pdma) {
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	kaddr = (void *)gen_pool_alloc_owner(p2pdma->pool, len, (void **)&ref);
>> +	if (!kaddr) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * vm_insert_page() can sleep, so a reference is taken to mapping
>> +	 * such that rcu_read_unlock() can be done before inserting the
>> +	 * pages
>> +	 */
>> +	if (unlikely(!percpu_ref_tryget_live_rcu(ref))) {
>> +		ret = -ENODEV;
>> +		goto out_free_mem;
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
>> +		ret = vm_insert_page(vma, vaddr, virt_to_page(kaddr));
>> +		if (ret) {
>> +			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
>> +			return ret;
>> +		}
>> +		percpu_ref_get(ref);
>> +		put_page(virt_to_page(kaddr));
>> +		kaddr += PAGE_SIZE;
>> +		len -= PAGE_SIZE;
>> +	}
>> +
>> +	percpu_ref_put(ref);
>> +
>> +	return 0;
>> +out_free_mem:
>> +	gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
>> +out:
>> +	rcu_read_unlock();
>> +	return ret;
>> +}
>> +
>> +static struct bin_attribute p2pmem_alloc_attr = {
>> +	.attr = { .name = "allocate", .mode = 0660 },
>> +	.mmap = p2pmem_alloc_mmap,
>> +	/*
>> +	 * Some places where we want to call mmap (ie. python) will check
>> +	 * that the file size is greater than the mmap size before allowing
>> +	 * the mmap to continue. To work around this, just set the size
>> +	 * to be very large.
>> +	 */
>> +	.size = SZ_1T,
>> +};
>> +
>>  static struct attribute *p2pmem_attrs[] = {
>>  	&dev_attr_size.attr,
>>  	&dev_attr_available.attr,
>> @@ -96,11 +180,32 @@ static struct attribute *p2pmem_attrs[] = {
>>  	NULL,
>>  };
>>  
>> +static struct bin_attribute *p2pmem_bin_attrs[] = {
>> +	&p2pmem_alloc_attr,
>> +	NULL,
>> +};
>> +
>>  static const struct attribute_group p2pmem_group = {
>>  	.attrs = p2pmem_attrs,
>> +	.bin_attrs = p2pmem_bin_attrs,
>>  	.name = "p2pmem",
>>  };
>>  
>> +static void p2pdma_page_free(struct page *page)
>> +{
>> +	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
>> +	struct percpu_ref *ref;
>> +
>> +	gen_pool_free_owner(pgmap->provider->p2pdma->pool,
>> +			    (uintptr_t)page_to_virt(page), PAGE_SIZE,
>> +			    (void **)&ref);
>> +	percpu_ref_put(ref);
>> +}
>> +
>> +static const struct dev_pagemap_ops p2pdma_pgmap_ops = {
>> +	.page_free = p2pdma_page_free,
>> +};
>> +
>>  static void pci_p2pdma_release(void *data)
>>  {
>>  	struct pci_dev *pdev = data;
>> @@ -152,6 +257,19 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
>>  	return error;
>>  }
>>  
>> +static void pci_p2pdma_unmap_mappings(void *data)
>> +{
>> +	struct pci_dev *pdev = data;
>> +
>> +	/*
>> +	 * Removing the alloc attribute from sysfs will call
>> +	 * unmap_mapping_range() on the inode, teardown any existing userspace
>> +	 * mappings and prevent new ones from being created.
>> +	 */
>> +	sysfs_remove_file_from_group(&pdev->dev.kobj, &p2pmem_alloc_attr.attr,
>> +				     p2pmem_group.name);
> 
> Wait, why are you manually removing the sysfs file here?  It's part of
> the group, if you do this then it is gone for forever, right?  Why
> manually do this the sysfs core should handle this for you if the device
> is removed.

We have to make sure the mappings are all removed before the cleanup of
devm_memremap_pages() which will wait for all the pages to be freed. If
we don't do this any userspace mapping will hang the cleanup until those
uses are unmapped themselves.

> And worst case, just pass in the device, not the pci device.

Ok, I'll make that change for v10.

Logan

