Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1D6E668B7
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Dec 2025 04:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XKsnNvUSr27kee3JjeXFHI5WQ8OlSVuj58nXTCA4NXA=; b=tOHIR8ENkw/F013k5/m2wpS103
	zCtHXTu8DOtXPfRtAmEcfEDY0TZ8wNEygE/pwzioOnC7j9MYX9MRVaEdjTZoT0H/ESTalxkXVDkO5
	3ppgixbayfn3CaqFC0MeCkrkFtHRwy5718PYWEGeIVak/6xs41boA97Kr5sbo5D01oZFVLMYfIQ4H
	k7iR6L7th21gy6Mn3NiX4KOpu3kH3BGGchKv+7iat8GrcyA9dIboa5feNT7o96KKmjxQOrwIvvVon
	/g/FiTBTHIPr6f9FpzJOuDV5EWNHbPlMlPCpM4eSwKdp00Ezh+f/PHi7YikP6TJ1lbjNvQZuoUQp0
	CqahCktg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWoOH-0000000BGY6-2YUG;
	Sat, 20 Dec 2025 04:16:25 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWoOA-0000000BGOu-3F1j
	for linux-nvme@lists.infradead.org;
	Sat, 20 Dec 2025 04:16:21 +0000
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dYB0T6Np5zKHM0S
	for <linux-nvme@lists.infradead.org>; Sat, 20 Dec 2025 12:15:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 11C5A4058A
	for <linux-nvme@lists.infradead.org>; Sat, 20 Dec 2025 12:16:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPn5IkZpFwpFAw--.56015S8;
	Sat, 20 Dec 2025 12:16:06 +0800 (CST)
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
Subject: [PATCH 04/13] kernfs: add support for may_split and pagesize callbacks
Date: Sat, 20 Dec 2025 12:04:37 +0800
Message-Id: <20251220040446.274991-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20251220040446.274991-1-houtao@huaweicloud.com>
References: <20251220040446.274991-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3WPn5IkZpFwpFAw--.56015S8
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWUCw4fWFyfZw15Xr17GFg_yoW8KF15pF
	4fKw15XrW8W3s3Cr9xXF4kZ343t3s7Gay7X34fu3sYy3W3tFnIvFyFgr98Ar15AryrJr4f
	tw42yryYka15Ww7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUxubkUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_201619_203370_1F222E31 
X-CRM114-Status: GOOD (  15.17  )
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

->may_split() and ->pagesize() callbacks are necessary for the support
of compound page. ->may_split() will check whether the splitting of
compound page is allowed during mprotect or remap, and ->pagesize() will
output the correct page size in /proc/${pid}/smap file. These two
callbacks will be used by the following patch to enable the mapping of
compound page of p2pdma memory into userspace, therefore, add the
support for these two callbacks.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/kernfs/file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9773b5734a2c..5df45b1dbb36 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -384,6 +384,46 @@ static void kernfs_vma_open(struct vm_area_struct *vma)
 	kernfs_put_active_of(of);
 }
 
+static int kernfs_vma_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct file *file = vma->vm_file;
+	struct kernfs_open_file *of = kernfs_of(file);
+	int ret;
+
+	if (!of->vm_ops)
+		return 0;
+
+	if (!kernfs_get_active_of(of))
+		return -ENODEV;
+
+	ret = 0;
+	if (of->vm_ops->may_split)
+		ret = of->vm_ops->may_split(vma, addr);
+
+	kernfs_put_active_of(of);
+	return ret;
+}
+
+static unsigned long kernfs_vma_pagesize(struct vm_area_struct *vma)
+{
+	struct file *file = vma->vm_file;
+	struct kernfs_open_file *of = kernfs_of(file);
+	unsigned long size;
+
+	if (!of->vm_ops)
+		return PAGE_SIZE;
+
+	if (!kernfs_get_active_of(of))
+		return PAGE_SIZE;
+
+	size = PAGE_SIZE;
+	if (of->vm_ops->pagesize)
+		size = of->vm_ops->pagesize(vma);
+
+	kernfs_put_active_of(of);
+	return size;
+}
+
 static vm_fault_t kernfs_vma_fault(struct vm_fault *vmf)
 {
 	struct file *file = vmf->vma->vm_file;
@@ -449,9 +489,11 @@ static int kernfs_vma_access(struct vm_area_struct *vma, unsigned long addr,
 
 static const struct vm_operations_struct kernfs_vm_ops = {
 	.open		= kernfs_vma_open,
+	.may_split	= kernfs_vma_may_split,
 	.fault		= kernfs_vma_fault,
 	.page_mkwrite	= kernfs_vma_page_mkwrite,
 	.access		= kernfs_vma_access,
+	.pagesize	= kernfs_vma_pagesize,
 };
 
 static unsigned long kernfs_get_unmapped_area(struct file *file, unsigned long uaddr,
-- 
2.29.2


