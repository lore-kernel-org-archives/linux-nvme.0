Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D21D1356E
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2024 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AIaNNcm3XUGBo9OgO3ovSINrRXEDBCyPOnC0y7/NQWs=; b=cJ1ON0wNMNlIRcVTcL5+qHRO7s
	eVheixFXwXYjh3mrxsDfo+qG47CksVOoJGBMWbb3vu2TscIz+TbQ82LM47bDMatsG9IbaDnrE8G1L
	ES+YkSoxYSGtdkqITZntEx+OD+HvkqvDiu8L+eKT7PckvNP3qvWYtWlYS9EFUl7oRmnbhxT/HE7VJ
	UxznjpYhqr1876uPYN6VmIDt3vq9B/PqeiQBBxIJr0b4MeciIbqwnjDC0wforg0VRjWHfKrxeF6Ul
	jAg/+AWGnOLcKSqgid2e4SQqvo9YCFnRamLRGL0vqbc2HMLlg+kI9IdTdfVi7zmQWUYW+4kPc3smU
	bRYNJo7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t55Dc-00000008TR1-2Baf;
	Sun, 27 Oct 2024 15:30:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t54AI-00000008Kin-25Qe
	for linux-nvme@bombadil.infradead.org;
	Sun, 27 Oct 2024 14:22:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=AIaNNcm3XUGBo9OgO3ovSINrRXEDBCyPOnC0y7/NQWs=; b=U7iOldFz2k5d5Snx21IuGLufQ4
	xlxkhwSqx154z5gBcIxKxedGJb2li8YGAbF/8lO/NBbWwVHtUMZkR/MDpV9Njpp6s7Rw/iuRPPjN1
	yq3Of6zPJMOizqy+faP4nGhuRy+uuwUr0GlFfGGYmUbR6haVH88m7x3uFi8QUE9nGcPtR9+0FeA7v
	ZjXWxxsd97X0p7FgZ3URT6a0zjzNdx1FnPK3pQAB+ElvWpJmlDmyNKcKRx8u7SPG+uYT9Kq2KkajR
	RH6eXqBtWOz/Y8uNI56dI7Up9utN+/+6qiuTsb+Opo+N/HYTT15UFQBh6nBWEFqg67SJEenjy5lzy
	ZqmsaZtQ==;
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t54AA-00000009QOG-3Ovb
	for linux-nvme@lists.infradead.org;
	Sun, 27 Oct 2024 14:22:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id ECDFDA40FA9;
	Sun, 27 Oct 2024 14:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0785CC4CEE5;
	Sun, 27 Oct 2024 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730038956;
	bh=0oAZb2A1AcGBYwYJqLqYoF06Rd3XR3a/YcihuL4Yd4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XnYNHf81XRJqGaj3hsxMDwA7dy6KsvsmA+yLe06qPkXYN2xa++1K94IKvJFVhF3WJ
	 T4nkxQIbD+/taXB1cTkhu7YVDVMs52CwQsF6Amd9bdNSuoW6OOoIjgXvVDwmEvZguv
	 8WlPW9lCV2ndSXcOd/O3Yle9aIqIcn5rb/jdxIv+xfewF90Snln3D0sQEOog6AYL9f
	 sGWvMWAh24LWTaEyPcu71Fg+Q1qBrTCefvjH+3Eda+IVvo3/EjNd7zcWwc1s35Yx2V
	 0GfmH2Gg2xDEgchvQ6+NhsCw8PELJVVU3eaVeCo4YhOOnUEW7QANXpX8NQDUgVH6hg
	 Njugb3kh4Lfgg==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 17/18] vfio/mlx5: Explicitly store page list
Date: Sun, 27 Oct 2024 16:21:17 +0200
Message-ID: <4c0a2f96d672d395caec3fe7dd6049a48b2582c6.1730037276.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730037276.git.leon@kernel.org>
References: <cover.1730037276.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_142239_583972_2D028BCC 
X-CRM114-Status: GOOD (  15.22  )
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

From: Leon Romanovsky <leonro@nvidia.com>

As a preparation to removal scatter-gather table and unifying
receive and send list, explicitly store page list.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/vfio/pci/mlx5/cmd.c | 29 ++++++++++++-----------------
 drivers/vfio/pci/mlx5/cmd.h |  1 +
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index 1832a6c1f35d..34ae3e299a9e 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -422,6 +422,7 @@ void mlx5vf_free_data_buffer(struct mlx5_vhca_data_buffer *buf)
 	for_each_sgtable_page(&buf->table.sgt, &sg_iter, 0)
 		__free_page(sg_page_iter_page(&sg_iter));
 	sg_free_append_table(&buf->table);
+	kvfree(buf->page_list);
 	kfree(buf);
 }
 
@@ -434,39 +435,33 @@ static int mlx5vf_add_migration_pages(struct mlx5_vhca_data_buffer *buf,
 	unsigned int to_fill;
 	int ret;
 
-	to_fill = min_t(unsigned int, npages, PAGE_SIZE / sizeof(*page_list));
-	page_list = kvzalloc(to_fill * sizeof(*page_list), GFP_KERNEL_ACCOUNT);
+	to_fill = min_t(unsigned int, npages, PAGE_SIZE / sizeof(*buf->page_list));
+	page_list = kvzalloc(to_fill * sizeof(*buf->page_list), GFP_KERNEL_ACCOUNT);
 	if (!page_list)
 		return -ENOMEM;
 
+	buf->page_list = page_list;
+
 	do {
 		filled = alloc_pages_bulk_array(GFP_KERNEL_ACCOUNT, to_fill,
-						page_list);
-		if (!filled) {
-			ret = -ENOMEM;
-			goto err;
-		}
+				buf->page_list + buf->npages);
+		if (!filled)
+			return -ENOMEM;
+
 		to_alloc -= filled;
 		ret = sg_alloc_append_table_from_pages(
-			&buf->table, page_list, filled, 0,
+			&buf->table, buf->page_list + buf->npages, filled, 0,
 			filled << PAGE_SHIFT, UINT_MAX, SG_MAX_SINGLE_ALLOC,
 			GFP_KERNEL_ACCOUNT);
 
 		if (ret)
-			goto err;
+			return ret;
 		buf->npages += filled;
-		/* clean input for another bulk allocation */
-		memset(page_list, 0, filled * sizeof(*page_list));
 		to_fill = min_t(unsigned int, to_alloc,
-				PAGE_SIZE / sizeof(*page_list));
+				PAGE_SIZE / sizeof(*buf->page_list));
 	} while (to_alloc > 0);
 
-	kvfree(page_list);
 	return 0;
-
-err:
-	kvfree(page_list);
-	return ret;
 }
 
 struct mlx5_vhca_data_buffer *
diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index 25dd6ff54591..5b764199db53 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -53,6 +53,7 @@ struct mlx5_vf_migration_header {
 };
 
 struct mlx5_vhca_data_buffer {
+	struct page **page_list;
 	struct sg_append_table table;
 	loff_t start_pos;
 	u64 length;
-- 
2.46.2


