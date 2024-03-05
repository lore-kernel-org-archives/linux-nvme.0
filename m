Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F4AC54798
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 13:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kP6IjCrCtQDnpe3Kioc5v3kxzu1trppQiw50mdHvFFY=; b=fS55QIldYZQ/oBtPBAvz0RHjK1
	JmGpC8PGYebr+EBjwoJMxDSj67zRodOqLf/b4AVrdS8unykuELS+GIDYCzeV5YAfHegAhF+qGw5TW
	rDyPncIZ7djuxF3fh3cxN5uhU+c2eQvUYIZW4drIHR9vtePrAdBgWgURkw4ioSUwylz6EDTiMV7Ez
	PFpOafWsaZ4FsyP8K2h6i4wY8x3XNvWkhSl1xDOzTcc0L50bVL9h4PbPRsaym88V/45LsL9tAu5Vv
	tTEvgIbdFoYp7hQUYLLQ2CqJiuGwhBxJpyODgvGs9YbdbugachBRciXWkAo+jFbgG5acsnw8LcYvv
	kmWU7K7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUyu-0000000DorE-1dRL;
	Tue, 05 Mar 2024 13:37:20 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhRxF-0000000D1Jq-0EYi
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 10:23:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E62EBCE19DF;
	Tue,  5 Mar 2024 10:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C66EC433C7;
	Tue,  5 Mar 2024 10:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709634202;
	bh=4IocgUHLj9eV065W5P3anYxI4nhTW2naxln23AtMtis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0GuP900zplbLktgEsmmpnBJz8A5DTXBEvqynSYrzVoximT499CZl0ZdA4KAdyMTf
	 VOfZ8+ekBAn9Pe+ZnwDdS2+Jp19o9K7KtIJG0ktzMqOOl8MDtYeRwWlE4y1eyFe7Dd
	 Ih8lkeXPO0EoGQ3G2y7yEY9U7ZsKVs15ZX6FWTL6infRGPdmtKPrHArkmHu19pxNOG
	 cTGm3lKjIqVBCm2dNxJDISwkzYc67byN5yXfiMw41JC4H1vi2o5wWtv83pATUYhws0
	 535EUKJH96b02xjGIjVuzcrjaUMWjFF25PeibbiSUn9w/iGo2hrEAEsZSlkFw360Ye
	 hISl9Pp+qOZnQ==
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
Subject: [RFC 14/16] vfio/mlx5: Convert vfio to use DMA link API
Date: Tue,  5 Mar 2024 12:22:15 +0200
Message-ID: <e42ea94ec4de8569f5a4c418b6f44c2a8730ceda.1709631413.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709631800.git.leon@kernel.org>
References: <cover.1709631800.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_022325_496969_B642645B 
X-CRM114-Status: GOOD (  24.10  )
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
Message-ID: <20240305102215.Z0s8xBgshP43dMWiP-ICmmT0_sa7PXBFgb9tZYL4k9Y@z>

From: Leon Romanovsky <leonro@nvidia.com>

Remove intermediate scatter-gather table as it is not needed
if DMA link API is used. This conversion reduces drastically
the memory used to manage that table.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/vfio/pci/mlx5/cmd.c  | 177 ++++++++++++++++-------------------
 drivers/vfio/pci/mlx5/cmd.h  |   8 +-
 drivers/vfio/pci/mlx5/main.c |  50 ++--------
 3 files changed, 91 insertions(+), 144 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index 5e2103042d9b..cfae03f7b7da 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -332,26 +332,60 @@ static u32 *alloc_mkey_in(u32 npages, u32 pdn)
 	return in;
 }
 
-static int create_mkey(struct mlx5_core_dev *mdev, u32 npages,
-		       struct mlx5_vhca_data_buffer *buf, u32 *mkey_in,
+static int create_mkey(struct mlx5_core_dev *mdev, u32 npages, u32 *mkey_in,
 		       u32 *mkey)
 {
+	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in) +
+		    sizeof(__be64) * round_up(npages, 2);
+
+	return mlx5_core_create_mkey(mdev, mkey, mkey_in, inlen);
+}
+
+static void unregister_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
+				 u32 *mkey_in, struct dma_iova_attrs *iova)
+{
+	dma_addr_t addr;
 	__be64 *mtt;
-	int inlen;
+	int i;
 
 	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
 
-	if (buf) {
-		struct sg_dma_page_iter dma_iter;
+	for (i = npages - 1; i >= 0; i--) {
+		addr = be64_to_cpu(mtt[i]);
+		dma_unlink_range(iova, addr);
+	}
+	dma_free_iova(iova);
+}
+
+static int register_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
+			      struct page **page_list, u32 *mkey_in,
+			      struct dma_iova_attrs *iova)
+{
+	dma_addr_t addr;
+	__be64 *mtt;
+	int i, err;
+
+	iova->dev = mdev->device;
+	iova->size = npages * PAGE_SIZE;
+	err = dma_alloc_iova(iova);
+	if (err)
+		return err;
+
+	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
+
+	for (i = 0; i < npages; i++) {
+		addr = dma_link_range(page_list[i], 0, iova, i * PAGE_SIZE);
+		if (dma_mapping_error(mdev->device, addr))
+			goto error;
 
-		for_each_sgtable_dma_page(&buf->table.sgt, &dma_iter, 0)
-			*mtt++ = cpu_to_be64(sg_page_iter_dma_address(&dma_iter));
+		*mtt++ = cpu_to_be64(addr);
 	}
 
-	inlen = MLX5_ST_SZ_BYTES(create_mkey_in) +
-		sizeof(__be64) * round_up(npages, 2);
+	return 0;
 
-	return mlx5_core_create_mkey(mdev, mkey, mkey_in, inlen);
+error:
+	unregister_dma_pages(mdev, i, mkey_in, iova);
+	return -ENOMEM;
 }
 
 static int mlx5vf_dma_data_buffer(struct mlx5_vhca_data_buffer *buf)
@@ -367,17 +401,16 @@ static int mlx5vf_dma_data_buffer(struct mlx5_vhca_data_buffer *buf)
 	if (buf->dmaed || !buf->npages)
 		return -EINVAL;
 
-	ret = dma_map_sgtable(mdev->device, &buf->table.sgt, buf->dma_dir, 0);
-	if (ret)
-		return ret;
-
 	buf->mkey_in = alloc_mkey_in(buf->npages, buf->migf->pdn);
-	if (!buf->mkey_in) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!buf->mkey_in)
+		return -ENOMEM;
+
+	ret = register_dma_pages(mdev, buf->npages, buf->page_list,
+				 buf->mkey_in, &buf->iova);
+	if (ret)
+		goto err_register_dma;
 
-	ret = create_mkey(mdev, buf->npages, buf, buf->mkey_in, &buf->mkey);
+	ret = create_mkey(mdev, buf->npages, buf->mkey_in, &buf->mkey);
 	if (ret)
 		goto err_create_mkey;
 
@@ -386,32 +419,39 @@ static int mlx5vf_dma_data_buffer(struct mlx5_vhca_data_buffer *buf)
 	return 0;
 
 err_create_mkey:
+	unregister_dma_pages(mdev, buf->npages, buf->mkey_in, &buf->iova);
+err_register_dma:
 	kvfree(buf->mkey_in);
-err:
-	dma_unmap_sgtable(mdev->device, &buf->table.sgt, buf->dma_dir, 0);
 	return ret;
 }
 
+static void free_page_list(u32 npages, struct page **page_list)
+{
+	int i;
+
+	/* Undo alloc_pages_bulk_array() */
+	for (i = npages - 1; i >= 0; i--)
+		__free_page(page_list[i]);
+
+	kvfree(page_list);
+}
+
 void mlx5vf_free_data_buffer(struct mlx5_vhca_data_buffer *buf)
 {
-	struct mlx5_vf_migration_file *migf = buf->migf;
-	struct sg_page_iter sg_iter;
+	struct mlx5vf_pci_core_device *mvdev = buf->migf->mvdev;
+	struct mlx5_core_dev *mdev = mvdev->mdev;
 
-	lockdep_assert_held(&migf->mvdev->state_mutex);
-	WARN_ON(migf->mvdev->mdev_detach);
+	lockdep_assert_held(&mvdev->state_mutex);
+	WARN_ON(mvdev->mdev_detach);
 
 	if (buf->dmaed) {
-		mlx5_core_destroy_mkey(migf->mvdev->mdev, buf->mkey);
+		mlx5_core_destroy_mkey(mdev, buf->mkey);
+		unregister_dma_pages(mdev, buf->npages, buf->mkey_in,
+				     &buf->iova);
 		kvfree(buf->mkey_in);
-		dma_unmap_sgtable(migf->mvdev->mdev->device, &buf->table.sgt,
-				  buf->dma_dir, 0);
 	}
 
-	/* Undo alloc_pages_bulk_array() */
-	for_each_sgtable_page(&buf->table.sgt, &sg_iter, 0)
-		__free_page(sg_page_iter_page(&sg_iter));
-	sg_free_append_table(&buf->table);
-	kvfree(buf->page_list);
+	free_page_list(buf->npages, buf->page_list);
 	kfree(buf);
 }
 
@@ -426,7 +466,7 @@ mlx5vf_alloc_data_buffer(struct mlx5_vf_migration_file *migf, u32 npages,
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
 
-	buf->dma_dir = dma_dir;
+	buf->iova.dir = dma_dir;
 	buf->migf = migf;
 	if (npages) {
 		ret = mlx5vf_add_migration_pages(buf, npages);
@@ -469,7 +509,7 @@ mlx5vf_get_data_buffer(struct mlx5_vf_migration_file *migf, u32 npages,
 
 	spin_lock_irq(&migf->list_lock);
 	list_for_each_entry_safe(buf, temp_buf, &migf->avail_list, buf_elm) {
-		if (buf->dma_dir == dma_dir) {
+		if (buf->iova.dir == dma_dir) {
 			list_del_init(&buf->buf_elm);
 			if (buf->npages >= npages) {
 				spin_unlock_irq(&migf->list_lock);
@@ -1253,17 +1293,6 @@ static void mlx5vf_destroy_qp(struct mlx5_core_dev *mdev,
 	kfree(qp);
 }
 
-static void free_recv_pages(struct mlx5_vhca_recv_buf *recv_buf)
-{
-	int i;
-
-	/* Undo alloc_pages_bulk_array() */
-	for (i = 0; i < recv_buf->npages; i++)
-		__free_page(recv_buf->page_list[i]);
-
-	kvfree(recv_buf->page_list);
-}
-
 static int alloc_recv_pages(struct mlx5_vhca_recv_buf *recv_buf,
 			    unsigned int npages)
 {
@@ -1300,56 +1329,16 @@ static int alloc_recv_pages(struct mlx5_vhca_recv_buf *recv_buf,
 	return -ENOMEM;
 }
 
-static void unregister_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
-				 u32 *mkey_in)
-{
-	dma_addr_t addr;
-	__be64 *mtt;
-	int i;
-
-	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
-
-	for (i = npages - 1; i >= 0; i--) {
-		addr = be64_to_cpu(mtt[i]);
-		dma_unmap_single(mdev->device, addr, PAGE_SIZE,
-				 DMA_FROM_DEVICE);
-	}
-}
-
-static int register_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
-			      struct page **page_list, u32 *mkey_in)
-{
-	dma_addr_t addr;
-	__be64 *mtt;
-	int i;
-
-	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
-
-	for (i = 0; i < npages; i++) {
-		addr = dma_map_page(mdev->device, page_list[i], 0, PAGE_SIZE,
-				    DMA_FROM_DEVICE);
-		if (dma_mapping_error(mdev->device, addr))
-			goto error;
-
-		*mtt++ = cpu_to_be64(addr);
-	}
-
-	return 0;
-
-error:
-	unregister_dma_pages(mdev, i, mkey_in);
-	return -ENOMEM;
-}
-
 static void mlx5vf_free_qp_recv_resources(struct mlx5_core_dev *mdev,
 					  struct mlx5_vhca_qp *qp)
 {
 	struct mlx5_vhca_recv_buf *recv_buf = &qp->recv_buf;
 
 	mlx5_core_destroy_mkey(mdev, recv_buf->mkey);
-	unregister_dma_pages(mdev, recv_buf->npages, recv_buf->mkey_in);
+	unregister_dma_pages(mdev, recv_buf->npages, recv_buf->mkey_in,
+			     &recv_buf->iova);
 	kvfree(recv_buf->mkey_in);
-	free_recv_pages(&qp->recv_buf);
+	free_page_list(recv_buf->npages, recv_buf->page_list);
 }
 
 static int mlx5vf_alloc_qp_recv_resources(struct mlx5_core_dev *mdev,
@@ -1370,24 +1359,24 @@ static int mlx5vf_alloc_qp_recv_resources(struct mlx5_core_dev *mdev,
 		goto end;
 	}
 
+	recv_buf->iova.dir = DMA_FROM_DEVICE;
 	err = register_dma_pages(mdev, npages, recv_buf->page_list,
-				 recv_buf->mkey_in);
+				 recv_buf->mkey_in, &recv_buf->iova);
 	if (err)
 		goto err_register_dma;
 
-	err = create_mkey(mdev, npages, NULL, recv_buf->mkey_in,
-			  &recv_buf->mkey);
+	err = create_mkey(mdev, npages, recv_buf->mkey_in, &recv_buf->mkey);
 	if (err)
 		goto err_create_mkey;
 
 	return 0;
 
 err_create_mkey:
-	unregister_dma_pages(mdev, npages, recv_buf->mkey_in);
+	unregister_dma_pages(mdev, npages, recv_buf->mkey_in, &recv_buf->iova);
 err_register_dma:
 	kvfree(recv_buf->mkey_in);
 end:
-	free_recv_pages(recv_buf);
+	free_page_list(npages, recv_buf->page_list);
 	return err;
 }
 
diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index 815fcb54494d..3a046166d9f2 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -57,22 +57,17 @@ struct mlx5_vf_migration_header {
 };
 
 struct mlx5_vhca_data_buffer {
+	struct dma_iova_attrs iova;
 	struct page **page_list;
-	struct sg_append_table table;
 	loff_t start_pos;
 	u64 length;
 	u32 npages;
 	u32 mkey;
 	u32 *mkey_in;
-	enum dma_data_direction dma_dir;
 	u8 dmaed:1;
 	u8 stop_copy_chunk_num;
 	struct list_head buf_elm;
 	struct mlx5_vf_migration_file *migf;
-	/* Optimize mlx5vf_get_migration_page() for sequential access */
-	struct scatterlist *last_offset_sg;
-	unsigned int sg_last_entry;
-	unsigned long last_offset;
 };
 
 struct mlx5vf_async_data {
@@ -137,6 +132,7 @@ struct mlx5_vhca_cq {
 };
 
 struct mlx5_vhca_recv_buf {
+	struct dma_iova_attrs iova;
 	u32 npages;
 	struct page **page_list;
 	u32 next_rq_offset;
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index 7ffe24693a55..668c28bc429c 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -34,35 +34,10 @@ static struct mlx5vf_pci_core_device *mlx5vf_drvdata(struct pci_dev *pdev)
 			    core_device);
 }
 
-struct page *
-mlx5vf_get_migration_page(struct mlx5_vhca_data_buffer *buf,
-			  unsigned long offset)
+struct page *mlx5vf_get_migration_page(struct mlx5_vhca_data_buffer *buf,
+				       unsigned long offset)
 {
-	unsigned long cur_offset = 0;
-	struct scatterlist *sg;
-	unsigned int i;
-
-	/* All accesses are sequential */
-	if (offset < buf->last_offset || !buf->last_offset_sg) {
-		buf->last_offset = 0;
-		buf->last_offset_sg = buf->table.sgt.sgl;
-		buf->sg_last_entry = 0;
-	}
-
-	cur_offset = buf->last_offset;
-
-	for_each_sg(buf->last_offset_sg, sg,
-			buf->table.sgt.orig_nents - buf->sg_last_entry, i) {
-		if (offset < sg->length + cur_offset) {
-			buf->last_offset_sg = sg;
-			buf->sg_last_entry += i;
-			buf->last_offset = cur_offset;
-			return nth_page(sg_page(sg),
-					(offset - cur_offset) / PAGE_SIZE);
-		}
-		cur_offset += sg->length;
-	}
-	return NULL;
+	return buf->page_list[offset / PAGE_SIZE];
 }
 
 int mlx5vf_add_migration_pages(struct mlx5_vhca_data_buffer *buf,
@@ -72,13 +47,9 @@ int mlx5vf_add_migration_pages(struct mlx5_vhca_data_buffer *buf,
 	size_t old_size, new_size;
 	struct page **page_list;
 	unsigned long filled;
-	unsigned int to_fill;
-	int ret;
 
-	to_fill = min_t(unsigned int, npages,
-			PAGE_SIZE / sizeof(*buf->page_list));
 	old_size = buf->npages * sizeof(*buf->page_list);
-	new_size = old_size + to_fill * sizeof(*buf->page_list);
+	new_size = old_size + to_alloc * sizeof(*buf->page_list);
 	page_list = kvrealloc(buf->page_list, old_size, new_size,
 			      GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!page_list)
@@ -87,22 +58,13 @@ int mlx5vf_add_migration_pages(struct mlx5_vhca_data_buffer *buf,
 	buf->page_list = page_list;
 
 	do {
-		filled = alloc_pages_bulk_array(GFP_KERNEL_ACCOUNT, to_fill,
+		filled = alloc_pages_bulk_array(GFP_KERNEL_ACCOUNT, to_alloc,
 						buf->page_list + buf->npages);
 		if (!filled)
 			return -ENOMEM;
 
 		to_alloc -= filled;
-		ret = sg_alloc_append_table_from_pages(
-			&buf->table, buf->page_list + buf->npages, filled, 0,
-			filled << PAGE_SHIFT, UINT_MAX, SG_MAX_SINGLE_ALLOC,
-			GFP_KERNEL_ACCOUNT);
-		if (ret)
-			return ret;
-
 		buf->npages += filled;
-		to_fill = min_t(unsigned int, to_alloc,
-				PAGE_SIZE / sizeof(*buf->page_list));
 	} while (to_alloc > 0);
 
 	return 0;
@@ -164,7 +126,7 @@ static void mlx5vf_buf_read_done(struct mlx5_vhca_data_buffer *vhca_buf)
 	struct mlx5_vf_migration_file *migf = vhca_buf->migf;
 
 	if (vhca_buf->stop_copy_chunk_num) {
-		bool is_header = vhca_buf->dma_dir == DMA_NONE;
+		bool is_header = vhca_buf->iova.dir == DMA_NONE;
 		u8 chunk_num = vhca_buf->stop_copy_chunk_num;
 		size_t next_required_umem_size = 0;
 
-- 
2.44.0


