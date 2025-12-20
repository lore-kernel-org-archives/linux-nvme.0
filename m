Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D425E668B4
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Dec 2025 04:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oPgOjkwgvrQvJR2MazjYU23Ktqe3nsfuni11l9o53JQ=; b=mAPl+QEuZ8WURww4xqhTczaR9a
	4rYw+fD4t/cfWb93oIu4tQWDiVsLd2ZeBAzPntbXvQGkqXEdnpPaEYepDZonzL7Takqy+qM1vmJUj
	1Tw2wiyyh4EbzgS/Qrk4zjmH3oIFdVKgDt5UJpKRXDmJ2rLLeV5JQnmDyB4HK4uUI5pz0Hi+XaEOz
	2r1lqJJKl4S08XmGXP24i2ga0Mf4+FflZ3K1fujP3mqmex6Twce0s1LPUIGesTZup3wCGOJWbZBev
	KaSE32vM0ENKzRJMrK07nQt4yy3+vjAJcppW3QOjTkkcA8xn442zaOMQ1M+Bp7y9fTsJIOjDc4N4Y
	3MIogoKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWoOG-0000000BGWa-2BYR;
	Sat, 20 Dec 2025 04:16:24 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWoO8-0000000BGOy-2Nm8
	for linux-nvme@lists.infradead.org;
	Sat, 20 Dec 2025 04:16:20 +0000
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dYB081SxGzYQtj5
	for <linux-nvme@lists.infradead.org>; Sat, 20 Dec 2025 12:15:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8C3B240579
	for <linux-nvme@lists.infradead.org>; Sat, 20 Dec 2025 12:16:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPn5IkZpFwpFAw--.56015S14;
	Sat, 20 Dec 2025 12:16:07 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nvme@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Alistair Popple <apopple@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	houtao1@huawei.com
Subject: [PATCH 10/13] PCI/P2PDMA: support compound page in p2pmem_alloc_mmap()
Date: Sat, 20 Dec 2025 12:04:43 +0800
Message-Id: <20251220040446.274991-11-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20251220040446.274991-1-houtao@huaweicloud.com>
References: <20251220040446.274991-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3WPn5IkZpFwpFAw--.56015S14
X-Coremail-Antispam: 1UD129KBjvJXoWxurykGr1DCF13Gw1UJF4xJFb_yoWrWr4rpF
	WrK3WqqayrGw42gw13Aa1DuFyavw1vg3yUta4xK34I9F1aqFWY9F18JFyYqF4YkrykWr1S
	qF4Dtr1UuFs0k3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07j4fO7UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_201616_967402_6F4B2953 
X-CRM114-Status: GOOD (  18.41  )
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

From: Hou Tao <houtao1@huawei.com>

P2PDMA memory has already supported compound page and the helpers which
support inserting compound page into vma is also ready, therefore, add
support for compound page in p2pmem_alloc_mmap() as well. It will reduce
the overhead of mmap() and get_user_pages() a lot when compound page is
enabled for p2pdma memory.

The use of vm_private_data to save the alignment of p2pdma memory needs
explanation. The normal way to get the alignment is through pci_dev. It
can be achieved by either invoking kernfs_of() and sysfs_file_kobj() or
defining a new struct kernfs_vm_ops to pass the kobject to the
may_split() and ->pagesize() callbacks. The former approach depends too
much on kernfs implementation details, and the latter would lead to
excessive churn. Therefore, choose the simpler way of saving alignment
in vm_private_data instead.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/pci/p2pdma.c | 48 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index e97f5da73458..4a133219ac43 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -128,6 +128,25 @@ static unsigned long p2pmem_get_unmapped_area(struct file *filp, struct kobject
 	return mm_get_unmapped_area(filp, uaddr, len, pgoff, flags);
 }
 
+static int p2pmem_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	size_t align = (uintptr_t)vma->vm_private_data;
+
+	if (!IS_ALIGNED(addr, align))
+		return -EINVAL;
+	return 0;
+}
+
+static unsigned long p2pmem_pagesize(struct vm_area_struct *vma)
+{
+	return (uintptr_t)vma->vm_private_data;
+}
+
+static const struct vm_operations_struct p2pmem_vm_ops = {
+	.may_split = p2pmem_may_split,
+	.pagesize = p2pmem_pagesize,
+};
+
 static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 		const struct bin_attribute *attr, struct vm_area_struct *vma)
 {
@@ -136,6 +155,7 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 	struct pci_p2pdma *p2pdma;
 	struct percpu_ref *ref;
 	unsigned long vaddr;
+	size_t align;
 	void *kaddr;
 	int ret;
 
@@ -161,6 +181,16 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 		goto out;
 	}
 
+	align = p2pdma->align;
+	if (vma->vm_start & (align - 1) || vma->vm_end & (align - 1)) {
+		pci_info_ratelimited(pdev,
+				     "%s: unaligned vma (%#lx~%#lx, %#lx)\n",
+				     current->comm, vma->vm_start, vma->vm_end,
+				     align);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	kaddr = (void *)gen_pool_alloc_owner(p2pdma->pool, len, (void **)&ref);
 	if (!kaddr) {
 		ret = -ENOMEM;
@@ -178,7 +208,7 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 	}
 	rcu_read_unlock();
 
-	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
+	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += align) {
 		struct page *page = virt_to_page(kaddr);
 
 		/*
@@ -188,7 +218,12 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 		 */
 		VM_WARN_ON_ONCE_PAGE(page_ref_count(page), page);
 		set_page_count(page, 1);
-		ret = vm_insert_page(vma, vaddr, page);
+		if (align == PUD_SIZE)
+			ret = vm_insert_folio_pud(vma, vaddr, page_folio(page));
+		else if (align == PMD_SIZE)
+			ret = vm_insert_folio_pmd(vma, vaddr, page_folio(page));
+		else
+			ret = vm_insert_page(vma, vaddr, page);
 		if (ret) {
 			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
 			percpu_ref_put(ref);
@@ -196,10 +231,15 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 		}
 		percpu_ref_get(ref);
 		put_page(page);
-		kaddr += PAGE_SIZE;
-		len -= PAGE_SIZE;
+		kaddr += align;
+		len -= align;
 	}
 
+	/* Disable unaligned splitting due to vma merge */
+	vm_flags_set(vma, VM_DONTEXPAND);
+	vma->vm_ops = &p2pmem_vm_ops;
+	vma->vm_private_data = (void *)(uintptr_t)align;
+
 	percpu_ref_put(ref);
 
 	return 0;
-- 
2.29.2


