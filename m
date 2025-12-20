Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2890E668B3
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Dec 2025 04:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I5FerDu7RqzrPbgAgjJW0uMWeVImqYUIaYQGRqAYz8k=; b=tMaff3YHZ7AF9GSf5eAYpm73YO
	Da9ulF/S3m1FE8pO+qdSX03Jl99I5wiVjhA25rWU5xK4NuqZCq0AFLfET/GxYP9JCStcSMjchSAkp
	faC/NiPK4IfxsmGY4a0ha1xjWMHWl65K/+JAZLclyNjYcVbZV3gXUdFapfwoNubl43Lw2+2eZVb61
	JoF1NUcuz+4EYf6GywR5i+ek9ePCuhz06z+CBhYtoiLGPdJHKXyQRN2VUeFvMlCeJH+mnPisQ3fE7
	tLFs9BgbboFFxkxLsl6ZAmJFimUD+33x4vZimYNYxIehl4BsYxRkA9rC34eP2AoDoso4OtcOgO9EB
	l6IopsPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWoOE-0000000BGTW-1B8S;
	Sat, 20 Dec 2025 04:16:22 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWoO8-0000000BGOx-3OLo
	for linux-nvme@lists.infradead.org;
	Sat, 20 Dec 2025 04:16:20 +0000
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dYB074hqNzYQtf3
	for <linux-nvme@lists.infradead.org>; Sat, 20 Dec 2025 12:15:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 033114056B
	for <linux-nvme@lists.infradead.org>; Sat, 20 Dec 2025 12:16:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPn5IkZpFwpFAw--.56015S7;
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
Subject: [PATCH 03/13] kernfs: add support for get_unmapped_area callback
Date: Sat, 20 Dec 2025 12:04:36 +0800
Message-Id: <20251220040446.274991-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20251220040446.274991-1-houtao@huaweicloud.com>
References: <20251220040446.274991-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3WPn5IkZpFwpFAw--.56015S7
X-Coremail-Antispam: 1UD129KBjvJXoWxArWDZr4ftw1DCry8urWrGrg_yoW5CrW8pF
	s5KryYqrWxJr92kr13JF95Zr1av3s7Ka42va4Ig3sYyw1jqFnxXr4Y9F98Gr1rX34rAw42
	yanFgayYkw45JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	xQzVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_201617_228224_DD8F2DFF 
X-CRM114-Status: GOOD (  15.99  )
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

kernfs has already support ->mmap callback, however it doesn't support
->get_unmapped_area callback to return PMD-aligned or PUD-aligned
virtual address. The following patch will need it to support compound
page for p2pdma device memory, therefore add the necessary support for it.

When the ->get_unmapped_area callback is not defined in kernfs_ops or
the callback returns -EOPNOTSUPP, kernfs_get_unmapped_area() will
fallback to mm_get_unmapped_area().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/kernfs/file.c       | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/kernfs.h |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9adf36e6364b..9773b5734a2c 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -454,6 +454,39 @@ static const struct vm_operations_struct kernfs_vm_ops = {
 	.access		= kernfs_vma_access,
 };
 
+static unsigned long kernfs_get_unmapped_area(struct file *file, unsigned long uaddr,
+					      unsigned long len, unsigned long pgoff,
+					      unsigned long flags)
+{
+	struct kernfs_open_file *of = kernfs_of(file);
+	const struct kernfs_ops *ops;
+	long addr;
+
+	if (!(of->kn->flags & KERNFS_HAS_MMAP))
+		return -ENODEV;
+
+	mutex_lock(&of->mutex);
+
+	addr = -ENODEV;
+	if (!kernfs_get_active_of(of))
+		goto out_unlock;
+
+	ops = kernfs_ops(of->kn);
+	if (ops->get_unmapped_area) {
+		addr = ops->get_unmapped_area(of, uaddr, len, pgoff, flags);
+		if (!IS_ERR_VALUE(addr) || addr != -EOPNOTSUPP)
+			goto out_put;
+	}
+	addr = mm_get_unmapped_area(file, uaddr, len, pgoff, flags);
+
+out_put:
+	kernfs_put_active_of(of);
+out_unlock:
+	mutex_unlock(&of->mutex);
+
+	return addr;
+}
+
 static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct kernfs_open_file *of = kernfs_of(file);
@@ -1017,6 +1050,7 @@ const struct file_operations kernfs_file_fops = {
 	.write_iter	= kernfs_fop_write_iter,
 	.llseek		= kernfs_fop_llseek,
 	.mmap		= kernfs_fop_mmap,
+	.get_unmapped_area = kernfs_get_unmapped_area,
 	.open		= kernfs_fop_open,
 	.release	= kernfs_fop_release,
 	.poll		= kernfs_fop_poll,
@@ -1052,6 +1086,9 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 	unsigned flags;
 	int rc;
 
+	if (ops->get_unmapped_area && !ops->mmap)
+		return ERR_PTR(-EINVAL);
+
 	flags = KERNFS_FILE;
 
 	kn = kernfs_new_node(parent, name, (mode & S_IALLUGO) | S_IFREG,
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index b5a5f32fdfd1..9467b0a2b339 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -324,6 +324,9 @@ struct kernfs_ops {
 
 	int (*mmap)(struct kernfs_open_file *of, struct vm_area_struct *vma);
 	loff_t (*llseek)(struct kernfs_open_file *of, loff_t offset, int whence);
+	unsigned long (*get_unmapped_area)(struct kernfs_open_file *of, unsigned long uaddr,
+					   unsigned long len, unsigned long pgoff,
+					   unsigned long flags);
 };
 
 /*
-- 
2.29.2


