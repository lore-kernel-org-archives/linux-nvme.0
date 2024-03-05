Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B50AC54E41
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CTugSmgLwJgDA9ipI5mnVckl7fOXK4aUNX016/UL5M0=; b=x+4rVgnsmXiqUjNKbVHK1RTTSs
	iI61JMyKi3LwVpDmjJJT5W3yegMVslENYNzNG45S59Me8IsXhrfBe3HrO0riroaGy6Du3AfnIOfJV
	WHkzW8mgVb2rQEK33kIkjEvFAiT0p7G4KCYp7eUgj56vODyAyX0CR7+iVwd3S+YGh+MViUyyCdkQx
	DQRbXbTJF+Ufs3uipSlauoVSDgQSotYosiVOQek1QwMEVXAW2oeAlei5fi8yNxZAnxeT4y0zUb+br
	Li2RW3S+Va+X+FAGeii/UEj4J+E0ruD9xPS1GybCIxOGskhmlusWdR8uIPciKSI+ozylSU89NLedc
	P3c/hZFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUzH-0000000Dp90-1vFz;
	Tue, 05 Mar 2024 13:37:43 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSpm-0000000DIxW-39Tf
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 11:19:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0AC4D613B3;
	Tue,  5 Mar 2024 11:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980C4C433C7;
	Tue,  5 Mar 2024 11:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709637585;
	bh=WBfM8ZvY1JfgPv87VMT5XwFqFK1pOKYXqtZNVa4/Kmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbsMf9DJdoige6tJLshijtU8Kah4MBtJADzS0kuryTgbhA9Aurzvs2NHr9PC2Sxdk
	 aWMyTQA9cpqJ9BZzF2xzaOYOiC9rT0wRI5JB4o6/Bd19PA6j8h5et4xH1Ybnssusxv
	 ofz4zG1sNo7UQbdSRgvuO4DR++wHk5xf9qd7pP3BUoMIXhUyuiKKBSd7cguagJOd5c
	 2If7Dk3oa46O/Qqcblo2jX+SAbFRpj9bAAcaayM0w5quJX8gW8FLX3ZCbV05DbU0rN
	 OkYxpZQZxj/lFGRv3G3vvw9fuADM/7YcjA+xBr5fSWKCwCH4P1a8ifmHULe6ES3OET
	 IDThNn5c/6MLg==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [RFC RESEND 13/16] vfio/mlx5: Explicitly store page list
Date: Tue,  5 Mar 2024 13:18:44 +0200
Message-ID: <1d0ca7408af6e5f0bb09baffd021bc72287e5ed8.1709635535.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709635535.git.leon@kernel.org>
References: <cover.1709635535.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_031946_946688_0C0E194F 
X-CRM114-Status: GOOD (  16.11  )
X-Mailman-Approved-At: Tue, 05 Mar 2024 05:32:59 -0800
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
 drivers/vfio/pci/mlx5/cmd.c  |  1 +
 drivers/vfio/pci/mlx5/cmd.h  |  1 +
 drivers/vfio/pci/mlx5/main.c | 35 +++++++++++++++++------------------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index 44762980fcb9..5e2103042d9b 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -411,6 +411,7 @@ void mlx5vf_free_data_buffer(struct mlx5_vhca_data_buffer *buf)
 	for_each_sgtable_page(&buf->table.sgt, &sg_iter, 0)
 		__free_page(sg_page_iter_page(&sg_iter));
 	sg_free_append_table(&buf->table);
+	kvfree(buf->page_list);
 	kfree(buf);
 }
 
diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index 83728c0669e7..815fcb54494d 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -57,6 +57,7 @@ struct mlx5_vf_migration_header {
 };
 
 struct mlx5_vhca_data_buffer {
+	struct page **page_list;
 	struct sg_append_table table;
 	loff_t start_pos;
 	u64 length;
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index b11b1c27d284..7ffe24693a55 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -69,44 +69,43 @@ int mlx5vf_add_migration_pages(struct mlx5_vhca_data_buffer *buf,
 			       unsigned int npages)
 {
 	unsigned int to_alloc = npages;
+	size_t old_size, new_size;
 	struct page **page_list;
 	unsigned long filled;
 	unsigned int to_fill;
 	int ret;
 
-	to_fill = min_t(unsigned int, npages, PAGE_SIZE / sizeof(*page_list));
-	page_list = kvzalloc(to_fill * sizeof(*page_list), GFP_KERNEL_ACCOUNT);
+	to_fill = min_t(unsigned int, npages,
+			PAGE_SIZE / sizeof(*buf->page_list));
+	old_size = buf->npages * sizeof(*buf->page_list);
+	new_size = old_size + to_fill * sizeof(*buf->page_list);
+	page_list = kvrealloc(buf->page_list, old_size, new_size,
+			      GFP_KERNEL_ACCOUNT | __GFP_ZERO);
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
+						buf->page_list + buf->npages);
+		if (!filled)
+			return -ENOMEM;
+
 		to_alloc -= filled;
 		ret = sg_alloc_append_table_from_pages(
-			&buf->table, page_list, filled, 0,
+			&buf->table, buf->page_list + buf->npages, filled, 0,
 			filled << PAGE_SHIFT, UINT_MAX, SG_MAX_SINGLE_ALLOC,
 			GFP_KERNEL_ACCOUNT);
-
 		if (ret)
-			goto err;
+			return ret;
+
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
 
 static void mlx5vf_disable_fd(struct mlx5_vf_migration_file *migf)
-- 
2.44.0


