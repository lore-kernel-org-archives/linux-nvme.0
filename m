Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DD9E668B5
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Dec 2025 04:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=coPjan8U2JfRZyHmLaEhcYe8a9WJSP4/FpLVQVNG438=; b=YVqMyCpR1yyEFIjKZrEN1XYN40
	hHnAEgUALdG/VL4nDFavhz1yFE3TkWlgak4ehO4j/b9e/byCWnQPq3XJ00zaIKYCGk7q+zpavcNUz
	Ollv/HtvIT48vKpC2z6MtghgUvR0PhNhdAByoRSN2ADGfQP9ohVNkNnx+at08CuyRjtPT2tE/Sj6a
	iyUxd+6nlcaabndM8EKwzeU6ljpFWAGhinlDJ6UeFLf8odj+U1BV8bCn05Q8vDZFWAm3pCCEdB8vR
	u6ML2CTQCQA0RkoHZtfMHmqXaspmtqO9TQTVi+rNRI7MUQgRNFpFMxPvw57jDvOTRV7ijk1ANU473
	zX7r+uXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWoOE-0000000BGTh-2YX2;
	Sat, 20 Dec 2025 04:16:22 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWoO8-0000000BGP0-2VSz
	for linux-nvme@lists.infradead.org;
	Sat, 20 Dec 2025 04:16:20 +0000
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dYB0819L3zYQthy
	for <linux-nvme@lists.infradead.org>; Sat, 20 Dec 2025 12:15:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7E97640573
	for <linux-nvme@lists.infradead.org>; Sat, 20 Dec 2025 12:16:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPn5IkZpFwpFAw--.56015S13;
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
Subject: [PATCH 09/13] PCI/P2PDMA: support get_unmapped_area to return aligned vaddr
Date: Sat, 20 Dec 2025 12:04:42 +0800
Message-Id: <20251220040446.274991-10-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20251220040446.274991-1-houtao@huaweicloud.com>
References: <20251220040446.274991-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3WPn5IkZpFwpFAw--.56015S13
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1UWFW5JF1UAF15GF15urg_yoW8Kr18pF
	WrtF98JrW8twsrKFWaya1DZry3Wwn5KryjkrWxK34a93W3GFnxWay5Aa4YqF13J34kW3W7
	tanIkr47urWDJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CRM114-CacheID: sfid-20251219_201617_011607_3F289BC2 
X-CRM114-Status: GOOD (  15.03  )
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

P2PDMA memory already supports compound page. When mmapping the P2PDMA
memory in the userspace, the mmap procedure needs to use an aligned
virtual address to match the alignment of P2PDMA memory. Therefore,
implement get_unmapped_area for p2pdma memory to return an aligned
virtual address.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/pci/p2pdma.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 7180dea4855c..e97f5da73458 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -90,6 +90,44 @@ static ssize_t published_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(published);
 
+static unsigned long p2pmem_get_unmapped_area(struct file *filp, struct kobject *kobj,
+					      const struct bin_attribute *attr,
+					      unsigned long uaddr, unsigned long len,
+					      unsigned long pgoff, unsigned long flags)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	struct pci_p2pdma *p2pdma;
+	unsigned long aligned_len;
+	unsigned long addr;
+	unsigned long align;
+
+	if (pgoff)
+		return -EINVAL;
+
+	rcu_read_lock();
+	p2pdma = rcu_dereference(pdev->p2pdma);
+	if (!p2pdma) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+	align = p2pdma->align;
+	rcu_read_unlock();
+
+	/* Fixed address */
+	if (uaddr)
+		goto out;
+
+	aligned_len = len + align;
+	if (aligned_len < len)
+		goto out;
+
+	addr = mm_get_unmapped_area(filp, uaddr, aligned_len, pgoff, flags);
+	if (!IS_ERR_VALUE(addr))
+		return round_up(addr, align);
+out:
+	return mm_get_unmapped_area(filp, uaddr, len, pgoff, flags);
+}
+
 static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 		const struct bin_attribute *attr, struct vm_area_struct *vma)
 {
@@ -175,6 +213,7 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 static const struct bin_attribute p2pmem_alloc_attr = {
 	.attr = { .name = "allocate", .mode = 0660 },
 	.mmap = p2pmem_alloc_mmap,
+	.get_unmapped_area = p2pmem_get_unmapped_area,
 	/*
 	 * Some places where we want to call mmap (ie. python) will check
 	 * that the file size is greater than the mmap size before allowing
-- 
2.29.2


