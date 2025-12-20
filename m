Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8471CE668B5
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Dec 2025 04:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m0a8LllONtNh1UCp+2iZ2NJSy0wT09r5z7SBh1hn+ec=; b=17al8YyvvwZXy4cPfimzGBN4i1
	73+kvY1pLLn97um1m8QQ/M2M32SpLsIEOAPcE7RSjdLU9lyjawkAQmG+yLwL+fjxWCJDK1nb0iEVr
	Libq2CCZlOOjHOHVZSAMI+H8t7DN4NomY569s44tLNWhoxa10AMmrjNVCzcVadUzeNsXvuI3gfz0D
	9K82Nwqv0dDFMVJSv/uO3h5iZJatsQvqwaRbiLGOB3u3TAavhQKU5MPgmqTr3rsiDCMdZ/MMvRDNP
	QAItyBBDQe3Dks2XGBP5OEb/OU5PWCZm3N0EaIRKd0wA01W9RG+kKHAnaBilqrmZXoEOfgq02B6H7
	tciwsLGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWoOG-0000000BGWy-3gFC;
	Sat, 20 Dec 2025 04:16:24 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWoOA-0000000BGOz-28UJ
	for linux-nvme@lists.infradead.org;
	Sat, 20 Dec 2025 04:16:21 +0000
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dYB080kXNzYQthl
	for <linux-nvme@lists.infradead.org>; Sat, 20 Dec 2025 12:15:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6EDD940583
	for <linux-nvme@lists.infradead.org>; Sat, 20 Dec 2025 12:16:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPn5IkZpFwpFAw--.56015S12;
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
Subject: [PATCH 08/13] mm/huge_memory: add helpers to insert huge page during mmap
Date: Sat, 20 Dec 2025 12:04:41 +0800
Message-Id: <20251220040446.274991-9-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20251220040446.274991-1-houtao@huaweicloud.com>
References: <20251220040446.274991-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3WPn5IkZpFwpFAw--.56015S12
X-Coremail-Antispam: 1UD129KBjvJXoWxZryfJFyfCF45JrW8WF47twb_yoW5uF17pF
	97GFn8ZrWIqrnrurnxWFs8Ary3X3yxWayUKFW7WF1ava17t34F9a1kJw15tF15JryUCFs3
	Xa17GFy5uFyUWa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07j4fO7UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_201618_921359_0E8C9F97 
X-CRM114-Status: GOOD (  11.91  )
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

vmf_insert_folio_{pmd,pud}() can be used to insert huge page during page
fault. However, for simplicity, the mapping of p2pdma memory inserts all
necessary pages during mmap. Therefore, add vm_insert_folio_{pmd|pud}
helpers to support inserting pmd-sized and pud-sized page during mmap.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/huge_mm.h |  4 +++
 mm/huge_memory.c        | 66 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index a4d9f964dfde..8cf8bb85be79 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -45,6 +45,10 @@ vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
 				bool write);
 vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
 				bool write);
+int vm_insert_folio_pmd(struct vm_area_struct *vma, unsigned long addr,
+			struct folio *folio);
+int vm_insert_folio_pud(struct vm_area_struct *vma, unsigned long addr,
+			struct folio *folio);
 
 enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 40cf59301c21..11d19f8986da 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1644,6 +1644,41 @@ vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
 }
 EXPORT_SYMBOL_GPL(vmf_insert_folio_pmd);
 
+int vm_insert_folio_pmd(struct vm_area_struct *vma, unsigned long addr,
+			struct folio *folio)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct folio_or_pfn fop = {
+		.folio = folio,
+		.is_folio = true,
+	};
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	vm_fault_t fault_err;
+
+	mmap_assert_write_locked(mm);
+
+	pgd = pgd_offset(mm, addr);
+	p4d = p4d_alloc(mm, pgd, addr);
+	if (!p4d)
+		return -ENOMEM;
+	pud = pud_alloc(mm, p4d, addr);
+	if (!pud)
+		return -ENOMEM;
+	pmd = pmd_alloc(mm, pud, addr);
+	if (!pmd)
+		return -ENOMEM;
+
+	fault_err = insert_pmd(vma, addr, pmd, fop, vma->vm_page_prot,
+			       vma->vm_flags & VM_WRITE);
+	if (fault_err != VM_FAULT_NOPAGE)
+		return -EINVAL;
+
+	return 0;
+}
+
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 {
@@ -1759,6 +1794,37 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
 	return insert_pud(vma, addr, vmf->pud, fop, vma->vm_page_prot, write);
 }
 EXPORT_SYMBOL_GPL(vmf_insert_folio_pud);
+
+int vm_insert_folio_pud(struct vm_area_struct *vma, unsigned long addr,
+			struct folio *folio)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct folio_or_pfn fop = {
+		.folio = folio,
+		.is_folio = true,
+	};
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	vm_fault_t fault_err;
+
+	mmap_assert_write_locked(mm);
+
+	pgd = pgd_offset(mm, addr);
+	p4d = p4d_alloc(mm, pgd, addr);
+	if (!p4d)
+		return -ENOMEM;
+	pud = pud_alloc(mm, p4d, addr);
+	if (!pud)
+		return -ENOMEM;
+
+	fault_err = insert_pud(vma, addr, pud, fop, vma->vm_page_prot,
+			       vma->vm_flags & VM_WRITE);
+	if (fault_err != VM_FAULT_NOPAGE)
+		return -EINVAL;
+
+	return 0;
+}
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 /**
-- 
2.29.2


