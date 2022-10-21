Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CCCFA373D
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 17:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8GUuV45G7YtMgQfBehNNQJaCCPQKMrASN4qZDBTJuk4=; b=Jgx4nbxUaAgfD6WrlsM+E2Idzd
	ZMahRWms/GkoB1qSt81RaRSqt2vvkv6ceXxvCjna+qPFbZVKEevZ/w21s1I2WYUQCSv7R9bUlODVc
	VrGfUA19lAyP6pIChWKmlgnM1G2mVsQq657Bf8ai+YH0TDL5TL/LQIW9urD9czdvpPMc4bapJ4Ahk
	DoMUPme74IgkTMVlrTxnJP8oueDZtYx3UA/rPkQRgAsPHvMJ5v5v24s8cJLQObPNcayFmkPRgrRnh
	hWy2ds6odiM23EhpwUv8RjAz5YJSa8SZcNxpV2aUDFoVOxsRoC79wOSlLgJB6f7Z11yEBd+OmJn2d
	pnTn0+Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olw2f-009FJP-3f; Fri, 21 Oct 2022 17:42:45 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olw1R-009ER5-17
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 17:41:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:content-disposition;
	bh=8GUuV45G7YtMgQfBehNNQJaCCPQKMrASN4qZDBTJuk4=; b=SGMHgfPyjpZdNV1yPglw9xAFVD
	5K8GJqwjITRCE9JS1twdXXYPyVhO/yYw0q6tIvK+WxfhCBbv1Zq9AaZ6kzJpLDe2rf3hqtZfxmjAq
	djXxro96iIwr0wndhuehbkDgKLi6EpkhQbBjPgoVB3kpO3/S/7KK5XXgtCMmuWPlZ0N1JlTQmX8wH
	7p+9zNyABDn2580JORxOMxesVvxgTcTKauvYzzP68ata4iXtP3mcQqZgptCbfsOaMUO/4fdAEvLLq
	8cJDozGqvku50rURuQt3sDSA5B3GDaFmW9QpLv4A+lag3mBfk5Bnd9Bd26bJqTszun87KITK8FwPX
	qCSHvbAg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1olw1L-00DoI0-AP; Fri, 21 Oct 2022 11:41:24 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1olw1G-0001tR-Bm; Fri, 21 Oct 2022 11:41:18 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org
Cc: Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Stephen Bates <sbates@raithlin.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 21 Oct 2022 11:41:15 -0600
Message-Id: <20221021174116.7200-9-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221021174116.7200-1-logang@deltatee.com>
References: <20221021174116.7200-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, sbates@raithlin.com, logang@deltatee.com, bhelgaas@google.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v11 8/9] PCI/P2PDMA: Allow userspace VMA allocations through sysfs
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_104129_256700_BCB52E6D 
X-CRM114-Status: GOOD (  25.09  )
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

Create a sysfs bin attribute called "allocate" under the existing
"p2pmem" group. The only allowable operation on this file is the mmap()
call.

When mmap() is called on this attribute, the kernel allocates a chunk of
memory from the genalloc and inserts the pages into the VMA. The
dev_pagemap .page_free callback will indicate when these pages are no
longer used and they will be put back into the genalloc.

On device unbind, remove the sysfs file before the memremap_pages are
cleaned up. This ensures unmap_mapping_range() is called on the files
inode and no new mappings can be created.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/p2pdma.c | 124 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 88dc66ee1c46..27539770a613 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -89,6 +89,90 @@ static ssize_t published_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(published);
 
+static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
+		struct bin_attribute *attr, struct vm_area_struct *vma)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	size_t len = vma->vm_end - vma->vm_start;
+	struct pci_p2pdma *p2pdma;
+	struct percpu_ref *ref;
+	unsigned long vaddr;
+	void *kaddr;
+	int ret;
+
+	/* prevent private mappings from being established */
+	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
+		pci_info_ratelimited(pdev,
+				     "%s: fail, attempted private mapping\n",
+				     current->comm);
+		return -EINVAL;
+	}
+
+	if (vma->vm_pgoff) {
+		pci_info_ratelimited(pdev,
+				     "%s: fail, attempted mapping with non-zero offset\n",
+				     current->comm);
+		return -EINVAL;
+	}
+
+	rcu_read_lock();
+	p2pdma = rcu_dereference(pdev->p2pdma);
+	if (!p2pdma) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	kaddr = (void *)gen_pool_alloc_owner(p2pdma->pool, len, (void **)&ref);
+	if (!kaddr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * vm_insert_page() can sleep, so a reference is taken to mapping
+	 * such that rcu_read_unlock() can be done before inserting the
+	 * pages
+	 */
+	if (unlikely(!percpu_ref_tryget_live_rcu(ref))) {
+		ret = -ENODEV;
+		goto out_free_mem;
+	}
+	rcu_read_unlock();
+
+	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
+		ret = vm_insert_page(vma, vaddr, virt_to_page(kaddr));
+		if (ret) {
+			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
+			return ret;
+		}
+		percpu_ref_get(ref);
+		put_page(virt_to_page(kaddr));
+		kaddr += PAGE_SIZE;
+		len -= PAGE_SIZE;
+	}
+
+	percpu_ref_put(ref);
+
+	return 0;
+out_free_mem:
+	gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+static struct bin_attribute p2pmem_alloc_attr = {
+	.attr = { .name = "allocate", .mode = 0660 },
+	.mmap = p2pmem_alloc_mmap,
+	/*
+	 * Some places where we want to call mmap (ie. python) will check
+	 * that the file size is greater than the mmap size before allowing
+	 * the mmap to continue. To work around this, just set the size
+	 * to be very large.
+	 */
+	.size = SZ_1T,
+};
+
 static struct attribute *p2pmem_attrs[] = {
 	&dev_attr_size.attr,
 	&dev_attr_available.attr,
@@ -96,11 +180,32 @@ static struct attribute *p2pmem_attrs[] = {
 	NULL,
 };
 
+static struct bin_attribute *p2pmem_bin_attrs[] = {
+	&p2pmem_alloc_attr,
+	NULL,
+};
+
 static const struct attribute_group p2pmem_group = {
 	.attrs = p2pmem_attrs,
+	.bin_attrs = p2pmem_bin_attrs,
 	.name = "p2pmem",
 };
 
+static void p2pdma_page_free(struct page *page)
+{
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
+	struct percpu_ref *ref;
+
+	gen_pool_free_owner(pgmap->provider->p2pdma->pool,
+			    (uintptr_t)page_to_virt(page), PAGE_SIZE,
+			    (void **)&ref);
+	percpu_ref_put(ref);
+}
+
+static const struct dev_pagemap_ops p2pdma_pgmap_ops = {
+	.page_free = p2pdma_page_free,
+};
+
 static void pci_p2pdma_release(void *data)
 {
 	struct pci_dev *pdev = data;
@@ -152,6 +257,19 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	return error;
 }
 
+static void pci_p2pdma_unmap_mappings(void *data)
+{
+	struct pci_dev *pdev = data;
+
+	/*
+	 * Removing the alloc attribute from sysfs will call
+	 * unmap_mapping_range() on the inode, teardown any existing userspace
+	 * mappings and prevent new ones from being created.
+	 */
+	sysfs_remove_file_from_group(&pdev->dev.kobj, &p2pmem_alloc_attr.attr,
+				     p2pmem_group.name);
+}
+
 /**
  * pci_p2pdma_add_resource - add memory for use as p2p memory
  * @pdev: the device to add the memory to
@@ -198,6 +316,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	pgmap->range.end = pgmap->range.start + size - 1;
 	pgmap->nr_range = 1;
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
+	pgmap->ops = &p2pdma_pgmap_ops;
 
 	p2p_pgmap->provider = pdev;
 	p2p_pgmap->bus_offset = pci_bus_address(pdev, bar) -
@@ -209,6 +328,11 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 		goto pgmap_free;
 	}
 
+	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
+					 pdev);
+	if (error)
+		goto pages_free;
+
 	p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
 	error = gen_pool_add_owner(p2pdma->pool, (unsigned long)addr,
 			pci_bus_address(pdev, bar) + offset,
-- 
2.30.2


