Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D99D1A63E
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jan 2026 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=N995FToeNi5XPxdDB7HyMTCG9fgYlsEvICbTLmRQ/LE=; b=iPUreqAaMUKWhH
	8ejmXvcSig9ZS9k1UPVEQeoOulZd/4NvdglL5ZhzoXxWCW25kEiMtQg4RwIu43Hu0U5jF4NdBJgoJ
	XL1BaDhxnfpIg7Nm9nSg1V82OAl1OyWs6Dysr47z9hsqO2ZmoKWmDA6CU/a4fzNI6xoGRzIuH87IU
	NK5b3hBE0i13yP1kVnTSMs8NpbQdXFRrM+/Ios6mhQl0XZRtnn4r5muzCO0eOvymmcywuf75D+YAm
	w2u9zShtpq8PpX8L/V8g0bpNVSZv+KJ9R3jF6r9xNVNylB2YDiiZXYg7ZjjsyM60JwZrVjZ2MAiaL
	SDRS+mgsSm/LHqXj2+jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veE1j-00000002RwY-1ems;
	Fri, 09 Jan 2026 15:03:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veE1h-00000002RwB-07qx
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jan 2026 15:03:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2988D43DDD;
	Fri,  9 Jan 2026 15:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD764C4CEF1;
	Fri,  9 Jan 2026 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767971024;
	bh=WAuchXVNbi1E8wL1YCiS1onMwk8fVlA590vyUaYKxYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SE4DXA4MOciW8xfdJXBrN01CZqLwFW5mbrXNqOB717rS3DPhir3IKMAYUPUlfNCNG
	 oSrp086ZYAXSL92LzUrIGHD4hAMVrqHne4K/V4honA0Sdc4MqOJ8m/SnSRKVmJ0nGi
	 yGsgXO5bbNoYRyAMxPGH75OGylwqPrB+zIruHZWk3i7kqFtCvAPPS+qiHfd/83dKyO
	 2bHw1C4FufwAKVvlPtucN+I0YXw1NbI79//5/k6RUspiS6PykxjoXoOCJpJXiC1s8e
	 7hOlLlnIwjuXvIvuSS1dFMQOPoSDlmkrIkQ3PQlSDmp5lxci8og+C55Pk+FojGBUfa
	 zkKk4VDitU6fw==
Date: Fri, 9 Jan 2026 09:03:42 -0600
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
Message-ID: <20260109150342.GA544448@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vrti6maahtwfrd6xrdmyupunprioodhl7x5alpi2r6kyi4qcyr@ga6a5yrdvmb2>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260109_070345_088634_49E096D4 
X-CRM114-Status: GOOD (  20.11  )
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

On Fri, Jan 09, 2026 at 11:41:51AM +1100, Alistair Popple wrote:
> On 2026-01-09 at 02:55 +1100, Bjorn Helgaas <helgaas@kernel.org> wrote...
> > On Thu, Jan 08, 2026 at 02:23:16PM +1100, Alistair Popple wrote:
> > > On 2025-12-20 at 15:04 +1100, Hou Tao <houtao@huaweicloud.com> wrote...
> > > > From: Hou Tao <houtao1@huawei.com>
> > > > 
> > > > When vm_insert_page() fails in p2pmem_alloc_mmap(), p2pmem_alloc_mmap()
> > > > doesn't invoke percpu_ref_put() to free the per-cpu ref of pgmap
> > > > acquired after gen_pool_alloc_owner(), and memunmap_pages() will hang
> > > > forever when trying to remove the PCIe device.
> > > > 
> > > > Fix it by adding the missed percpu_ref_put().
> ...

> > Looking at this again, I'm confused about why in the normal, non-error
> > case, we do the percpu_ref_tryget_live_rcu(ref), followed by another
> > percpu_ref_get(ref) for each page, followed by just a single
> > percpu_ref_put() at the exit.
> > 
> > So we do ref_get() "1 + number of pages" times but we only do a single
> > ref_put().  Is there a loop of ref_put() for each page elsewhere?
> 
> Right, the per-page ref_put() happens when the page is freed (ie. the struct
> page refcount drops to zero) - in this case free_zone_device_folio() will call
> p2pdma_folio_free() which has the corresponding percpu_ref_put().

I don't see anything that looks like a loop to call ref_put() for each
page in free_zone_device_folio() or in p2pdma_folio_free(), but this
is all completely out of my range, so I'll take your word for it :)  

Bjorn

