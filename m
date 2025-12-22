Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1551DE67801
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Dec 2025 17:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UhEdYDLpAvxS3FC6ZENa/gvzH1E2CyhCMJEO+Kd10VA=; b=gdj2c6ORCobt8t
	jG4QOKhMRgnSrWhm1Hfvbx5SCPbAbJ39XkByMEYlPjA97P/EJSnWONMlIFI8L3B5A9h0rdA9jWNXR
	ReoqER+zx5cTJk1sAlCs9PEm3EUrbsJHO3n4tntTwLfp9jBmfanC2OlALip3Spz4bzLnjodnyFHbo
	MP0eBE2n84OOxuDNUdYRIFq3Hxh7crYvyW0y2VG/G0i0rCq3Rws801/qUy1PmOQ+Rde1zwyUe8m7j
	EqwB+9qyViSB2spYSLRu7ZXz8YpuAlssr5WXp4pUOucYTpS4Xo+47ec/n9+lHD+Azz2qpgkFP2IOr
	B59POenN52bL9CuJRJbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXjKh-0000000E0Ou-1lYR;
	Mon, 22 Dec 2025 17:04:31 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXjKf-0000000E0OE-1Q0a
	for linux-nvme@lists.infradead.org;
	Mon, 22 Dec 2025 17:04:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=UhEdYDLpAvxS3FC6ZENa/gvzH1E2CyhCMJEO+Kd10VA=; b=Z8RW9LHXz3jTEXW9CLMsrh9IU4
	L2CbiFl6A0PCVnrkPJGCRBSosZD2qPXxEA/95JHxyPYkBZLwjg2XYOMPfLvxe3HFAsJdnV3do7YpB
	/cxaiCMuRMNy3uU4JX7Z/PT9n9mH8nWhSImLNeM8+6Dbb1+ydFsuBp/V0+B7poTx9tXF3XwQ3rEyF
	XsPAPTy8qkc4hxELW92MXPQNxnIJqeupxf6EyiRBHMGG/+vYl9m8pcFWHAsCtDglAH4lcWW02m8SA
	3O4a2K1yKGiuzaKL7C7raxEjbjGKaDdhIIFAaCaGRumg9i8t4ZTDW/P16HPVwA+5MRlZnir7/OUeZ
	OBVdU8aQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vXjKd-00000008JyE-3VcS;
	Mon, 22 Dec 2025 10:04:28 -0700
Message-ID: <07a785e5-5d2e-4c81-a834-1237c79fdd51@deltatee.com>
Date: Mon, 22 Dec 2025 10:04:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 Alistair Popple <apopple@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 houtao1@huawei.com
References: <20251220040446.274991-1-houtao@huaweicloud.com>
 <20251220040446.274991-11-houtao@huaweicloud.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20251220040446.274991-11-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: houtao@huaweicloud.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-nvme@lists.infradead.org, bhelgaas@google.com, apopple@nvidia.com, leonro@nvidia.com, gregkh@linuxfoundation.org, tj@kernel.org, rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, houtao1@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 10/13] PCI/P2PDMA: support compound page in
 p2pmem_alloc_mmap()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251222_090429_387454_231DD3ED 
X-CRM114-Status: GOOD (  28.21  )
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



On 2025-12-19 21:04, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> P2PDMA memory has already supported compound page and the helpers which
> support inserting compound page into vma is also ready, therefore, add
> support for compound page in p2pmem_alloc_mmap() as well. It will reduce
> the overhead of mmap() and get_user_pages() a lot when compound page is
> enabled for p2pdma memory.
> 
> The use of vm_private_data to save the alignment of p2pdma memory needs
> explanation. The normal way to get the alignment is through pci_dev. It
> can be achieved by either invoking kernfs_of() and sysfs_file_kobj() or
> defining a new struct kernfs_vm_ops to pass the kobject to the
> may_split() and ->pagesize() callbacks. The former approach depends too
> much on kernfs implementation details, and the latter would lead to
> excessive churn. Therefore, choose the simpler way of saving alignment
> in vm_private_data instead.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  drivers/pci/p2pdma.c | 48 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index e97f5da73458..4a133219ac43 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -128,6 +128,25 @@ static unsigned long p2pmem_get_unmapped_area(struct file *filp, struct kobject
>  	return mm_get_unmapped_area(filp, uaddr, len, pgoff, flags);
>  }
>  
> +static int p2pmem_may_split(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	size_t align = (uintptr_t)vma->vm_private_data;
> +
> +	if (!IS_ALIGNED(addr, align))
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static unsigned long p2pmem_pagesize(struct vm_area_struct *vma)
> +{
> +	return (uintptr_t)vma->vm_private_data;
> +}
> +
> +static const struct vm_operations_struct p2pmem_vm_ops = {
> +	.may_split = p2pmem_may_split,
> +	.pagesize = p2pmem_pagesize,
> +};
> +
>  static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>  		const struct bin_attribute *attr, struct vm_area_struct *vma)
>  {
> @@ -136,6 +155,7 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>  	struct pci_p2pdma *p2pdma;
>  	struct percpu_ref *ref;
>  	unsigned long vaddr;
> +	size_t align;
>  	void *kaddr;
>  	int ret;
>  
> @@ -161,6 +181,16 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>  		goto out;
>  	}
>  
> +	align = p2pdma->align;
> +	if (vma->vm_start & (align - 1) || vma->vm_end & (align - 1)) {
> +		pci_info_ratelimited(pdev,
> +				     "%s: unaligned vma (%#lx~%#lx, %#lx)\n",
> +				     current->comm, vma->vm_start, vma->vm_end,
> +				     align);
> +		ret = -EINVAL;
> +		goto out;
> +	}

I'm a bit confused by some aspects of these changes. Why does the
alignment become a property of the PCI device? It appears that if the
CPU supports different sized huge pages then the size and alignment
restrictions on P2PDMA memory become greater. So if someone is only
allocating a few KB these changes will break their code and refuse to
allocate single pages.

I would have expected this code to allocate an appropriately aligned
block of the p2p memory based on the requirements of the current
mapping, not based on alignment requirements established when the device
is probed.

Logan




