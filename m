Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A016D6B6A8
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PhW4VjnvtzkDooyFGath+3T4tsAPk9cdglqFB5sUC1Q=; b=fOHcUeJeeG/U9b2G8RH/Cu85dr
	NiS39VvrFXE1Qf+aA2GBH7LwiwXVBeMa6GQvLADRKS40m65lC0S84CbFWawpflct6uBx/QUZv3j0u
	Py7DEOfJ15MAGvaslWhqrmfc0TA3Eu1Jn5P20zeSKUrrR2GMSKf8pOW7e7NRY1L+/zZ6vP9BDAfSj
	KChCFjcECa14OED3leaFqqt0cw+lEjcQRADkyEBAx4RdBxubf8OCSThHbmYn4zEKZHOEBFenJtwir
	Uyz2yQzBOWX0cO+XDsh/Loq074P8O7hcL8+i8+zyCcCUYsVqwWkI020Env6uS1ajZxJkhRXQ5tYca
	spBd9VCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6BMR-000000012MS-2EKF;
	Wed, 30 Oct 2024 16:15:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AOr-00000000nrx-1kpa
	for linux-nvme@bombadil.infradead.org;
	Wed, 30 Oct 2024 15:14:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=PhW4VjnvtzkDooyFGath+3T4tsAPk9cdglqFB5sUC1Q=; b=S3b/lHx8aR6wjWmf4FoSUZ0Rif
	iFYyq2KABVTP3x6/VE/FXw7BI6LXPiaPoYZoUtMLjJmb5nRPHUs7PCCnBc4NxP4ASn2LWOF+ywigl
	9ljfcMR50BR4jr+bNHL+uzsts5z+Dc6c6+c1fqXl6+DQPu5oR+Idt+5Xwv1yRyhzJrSLsTirzi9N7
	kW1it/EFsAqBQx6av1gX18QKXpYo7mr38dK2245jy2TDl87E53uIn2+QsAGkauR9ns2pXGyOjL4xU
	7VH9fMDXKCM5q6LBcoiFtyRNRYveNzJ97WzhE3MMcJB78QNFbhk7a5uL1jcg2q5ybpby+rA8R3hAY
	3T9sil/Q==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AOn-0000000AHQN-0f25
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 15:14:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D59DCA40257;
	Wed, 30 Oct 2024 15:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57D9C4CED1;
	Wed, 30 Oct 2024 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730301255;
	bh=RCW7z84/26BITUxg8PndrrKsB8pTf34fxPy1qnPVTz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGWltSBfuWLOOW1uCjA96ZkRf/tc9Ofzcqd4yBlthycq0QuFcTDg1vtaJK2d3dEmJ
	 j/O3jro7YQUDUh3DxANT/lEqBGuf8gX8pjaejHU1r3j/TQqSe9feErtiZKD2m9nXSi
	 h+/WR6a7xsDnPgH6Ft8Ec2DlZ+deXW4uSXxyCPluFGBtOcD9zI5UdLjBa+BH4S6Bmo
	 7fF+NgcxheBw9unedEy68XY0Xinsf2FH7Fr7T/5xEp4rTjNIbFI600KVuS+YwrLtfE
	 IT9WlhFIsQyXpXFR9PPqNDFPrigxE1BcEJ9/JHhP9PKeGG4tzzA2iCVhzFS+tEiTDt
	 b1Fmfu9dSheXw==
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
Subject: [PATCH v1 16/17] vfio/mlx5: Rewrite create mkey flow to allow better code reuse
Date: Wed, 30 Oct 2024 17:13:02 +0200
Message-ID: <0cecdfc196d028a8554f1d4564e0e4f3ef75ce70.1730298502.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730298502.git.leon@kernel.org>
References: <cover.1730298502.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_151417_853061_7D49B127 
X-CRM114-Status: GOOD (  23.32  )
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

Change the creation of mkey to be performed in multiple steps:
data allocation, DMA setup and actual call to HW to create that mkey.

In this new flow, the whole input to MKEY command is saved to eliminate
the need to keep array of pointers for DMA addresses for receive list
and in the future patches for send list too.

In addition to memory size reduce and elimination of unnecessary data
movements to set MKEY input, the code is prepared for future reuse.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/vfio/pci/mlx5/cmd.c | 156 ++++++++++++++++++++----------------
 drivers/vfio/pci/mlx5/cmd.h |   4 +-
 2 files changed, 90 insertions(+), 70 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index fdc3e515741f..1832a6c1f35d 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -313,39 +313,21 @@ static int mlx5vf_cmd_get_vhca_id(struct mlx5_core_dev *mdev, u16 function_id,
 	return ret;
 }
 
-static int _create_mkey(struct mlx5_core_dev *mdev, u32 pdn,
-			struct mlx5_vhca_data_buffer *buf,
-			struct mlx5_vhca_recv_buf *recv_buf,
-			u32 *mkey)
+static u32 *alloc_mkey_in(u32 npages, u32 pdn)
 {
-	size_t npages = buf ? buf->npages : recv_buf->npages;
-	int err = 0, inlen;
-	__be64 *mtt;
+	int inlen;
 	void *mkc;
 	u32 *in;
 
 	inlen = MLX5_ST_SZ_BYTES(create_mkey_in) +
-		sizeof(*mtt) * round_up(npages, 2);
+		sizeof(__be64) * round_up(npages, 2);
 
-	in = kvzalloc(inlen, GFP_KERNEL);
+	in = kvzalloc(inlen, GFP_KERNEL_ACCOUNT);
 	if (!in)
-		return -ENOMEM;
+		return NULL;
 
 	MLX5_SET(create_mkey_in, in, translations_octword_actual_size,
 		 DIV_ROUND_UP(npages, 2));
-	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, in, klm_pas_mtt);
-
-	if (buf) {
-		struct sg_dma_page_iter dma_iter;
-
-		for_each_sgtable_dma_page(&buf->table.sgt, &dma_iter, 0)
-			*mtt++ = cpu_to_be64(sg_page_iter_dma_address(&dma_iter));
-	} else {
-		int i;
-
-		for (i = 0; i < npages; i++)
-			*mtt++ = cpu_to_be64(recv_buf->dma_addrs[i]);
-	}
 
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
 	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_MTT);
@@ -359,9 +341,29 @@ static int _create_mkey(struct mlx5_core_dev *mdev, u32 pdn,
 	MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
 	MLX5_SET(mkc, mkc, translations_octword_size, DIV_ROUND_UP(npages, 2));
 	MLX5_SET64(mkc, mkc, len, npages * PAGE_SIZE);
-	err = mlx5_core_create_mkey(mdev, mkey, in, inlen);
-	kvfree(in);
-	return err;
+
+	return in;
+}
+
+static int create_mkey(struct mlx5_core_dev *mdev, u32 npages,
+		       struct mlx5_vhca_data_buffer *buf, u32 *mkey_in,
+		       u32 *mkey)
+{
+	__be64 *mtt;
+	int inlen;
+
+	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
+	if (buf) {
+		struct sg_dma_page_iter dma_iter;
+
+		for_each_sgtable_dma_page(&buf->table.sgt, &dma_iter, 0)
+			*mtt++ = cpu_to_be64(sg_page_iter_dma_address(&dma_iter));
+	}
+
+	inlen = MLX5_ST_SZ_BYTES(create_mkey_in) +
+		sizeof(__be64) * round_up(npages, 2);
+
+	return mlx5_core_create_mkey(mdev, mkey, mkey_in, inlen);
 }
 
 static int mlx5vf_dma_data_buffer(struct mlx5_vhca_data_buffer *buf)
@@ -374,20 +376,28 @@ static int mlx5vf_dma_data_buffer(struct mlx5_vhca_data_buffer *buf)
 	if (mvdev->mdev_detach)
 		return -ENOTCONN;
 
-	if (buf->dmaed || !buf->npages)
+	if (buf->mkey_in || !buf->npages)
 		return -EINVAL;
 
 	ret = dma_map_sgtable(mdev->device, &buf->table.sgt, buf->dma_dir, 0);
 	if (ret)
 		return ret;
 
-	ret = _create_mkey(mdev, buf->migf->pdn, buf, NULL, &buf->mkey);
-	if (ret)
+	buf->mkey_in = alloc_mkey_in(buf->npages, buf->migf->pdn);
+	if (!buf->mkey_in) {
+		ret = -ENOMEM;
 		goto err;
+	}
 
-	buf->dmaed = true;
+	ret = create_mkey(mdev, buf->npages, buf, buf->mkey_in, &buf->mkey);
+	if (ret)
+		goto err_create_mkey;
 
 	return 0;
+
+err_create_mkey:
+	kvfree(buf->mkey_in);
+	buf->mkey_in = NULL;
 err:
 	dma_unmap_sgtable(mdev->device, &buf->table.sgt, buf->dma_dir, 0);
 	return ret;
@@ -401,8 +411,9 @@ void mlx5vf_free_data_buffer(struct mlx5_vhca_data_buffer *buf)
 	lockdep_assert_held(&migf->mvdev->state_mutex);
 	WARN_ON(migf->mvdev->mdev_detach);
 
-	if (buf->dmaed) {
+	if (buf->mkey_in) {
 		mlx5_core_destroy_mkey(migf->mvdev->mdev, buf->mkey);
+		kvfree(buf->mkey_in);
 		dma_unmap_sgtable(migf->mvdev->mdev->device, &buf->table.sgt,
 				  buf->dma_dir, 0);
 	}
@@ -779,7 +790,7 @@ int mlx5vf_cmd_load_vhca_state(struct mlx5vf_pci_core_device *mvdev,
 	if (mvdev->mdev_detach)
 		return -ENOTCONN;
 
-	if (!buf->dmaed) {
+	if (!buf->mkey_in) {
 		err = mlx5vf_dma_data_buffer(buf);
 		if (err)
 			return err;
@@ -1380,56 +1391,54 @@ static int alloc_recv_pages(struct mlx5_vhca_recv_buf *recv_buf,
 	kvfree(recv_buf->page_list);
 	return -ENOMEM;
 }
+static void unregister_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
+				 u32 *mkey_in)
+{
+	dma_addr_t addr;
+	__be64 *mtt;
+	int i;
+
+	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
+	for (i = npages - 1; i >= 0; i--) {
+		addr = be64_to_cpu(mtt[i]);
+		dma_unmap_single(mdev->device, addr, PAGE_SIZE,
+				DMA_FROM_DEVICE);
+	}
+}
 
-static int register_dma_recv_pages(struct mlx5_core_dev *mdev,
-				   struct mlx5_vhca_recv_buf *recv_buf)
+static int register_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
+			      struct page **page_list, u32 *mkey_in)
 {
-	int i, j;
+	dma_addr_t addr;
+	__be64 *mtt;
+	int i;
 
-	recv_buf->dma_addrs = kvcalloc(recv_buf->npages,
-				       sizeof(*recv_buf->dma_addrs),
-				       GFP_KERNEL_ACCOUNT);
-	if (!recv_buf->dma_addrs)
-		return -ENOMEM;
+	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
 
-	for (i = 0; i < recv_buf->npages; i++) {
-		recv_buf->dma_addrs[i] = dma_map_page(mdev->device,
-						      recv_buf->page_list[i],
-						      0, PAGE_SIZE,
-						      DMA_FROM_DEVICE);
-		if (dma_mapping_error(mdev->device, recv_buf->dma_addrs[i]))
+	for (i = 0; i < npages; i++) {
+		addr = dma_map_page(mdev->device, page_list[i], 0, PAGE_SIZE,
+				    DMA_FROM_DEVICE);
+		if (dma_mapping_error(mdev->device, addr))
 			goto error;
+
+		*mtt++ = cpu_to_be64(addr);
 	}
+
 	return 0;
 
 error:
-	for (j = 0; j < i; j++)
-		dma_unmap_single(mdev->device, recv_buf->dma_addrs[j],
-				 PAGE_SIZE, DMA_FROM_DEVICE);
-
-	kvfree(recv_buf->dma_addrs);
+	unregister_dma_pages(mdev, i, mkey_in);
 	return -ENOMEM;
 }
 
-static void unregister_dma_recv_pages(struct mlx5_core_dev *mdev,
-				      struct mlx5_vhca_recv_buf *recv_buf)
-{
-	int i;
-
-	for (i = 0; i < recv_buf->npages; i++)
-		dma_unmap_single(mdev->device, recv_buf->dma_addrs[i],
-				 PAGE_SIZE, DMA_FROM_DEVICE);
-
-	kvfree(recv_buf->dma_addrs);
-}
-
 static void mlx5vf_free_qp_recv_resources(struct mlx5_core_dev *mdev,
 					  struct mlx5_vhca_qp *qp)
 {
 	struct mlx5_vhca_recv_buf *recv_buf = &qp->recv_buf;
 
 	mlx5_core_destroy_mkey(mdev, recv_buf->mkey);
-	unregister_dma_recv_pages(mdev, recv_buf);
+	unregister_dma_pages(mdev, recv_buf->npages, recv_buf->mkey_in);
+	kvfree(recv_buf->mkey_in);
 	free_recv_pages(&qp->recv_buf);
 }
 
@@ -1445,18 +1454,29 @@ static int mlx5vf_alloc_qp_recv_resources(struct mlx5_core_dev *mdev,
 	if (err < 0)
 		return err;
 
-	err = register_dma_recv_pages(mdev, recv_buf);
-	if (err)
+	recv_buf->mkey_in = alloc_mkey_in(npages, pdn);
+	if (!recv_buf->mkey_in) {
+		err = -ENOMEM;
 		goto end;
+	}
+
+	err = register_dma_pages(mdev, npages, recv_buf->page_list,
+				 recv_buf->mkey_in);
+	if (err)
+		goto err_register_dma;
 
-	err = _create_mkey(mdev, pdn, NULL, recv_buf, &recv_buf->mkey);
+	err = create_mkey(mdev, npages, NULL, recv_buf->mkey_in,
+			  &recv_buf->mkey);
 	if (err)
 		goto err_create_mkey;
 
 	return 0;
 
 err_create_mkey:
-	unregister_dma_recv_pages(mdev, recv_buf);
+	unregister_dma_pages(mdev, npages, recv_buf->mkey_in);
+err_register_dma:
+	kvfree(recv_buf->mkey_in);
+	recv_buf->mkey_in = NULL;
 end:
 	free_recv_pages(recv_buf);
 	return err;
diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index 7d4a833b6900..25dd6ff54591 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -58,8 +58,8 @@ struct mlx5_vhca_data_buffer {
 	u64 length;
 	u32 npages;
 	u32 mkey;
+	u32 *mkey_in;
 	enum dma_data_direction dma_dir;
-	u8 dmaed:1;
 	u8 stop_copy_chunk_num;
 	struct list_head buf_elm;
 	struct mlx5_vf_migration_file *migf;
@@ -133,8 +133,8 @@ struct mlx5_vhca_cq {
 struct mlx5_vhca_recv_buf {
 	u32 npages;
 	struct page **page_list;
-	dma_addr_t *dma_addrs;
 	u32 next_rq_offset;
+	u32 *mkey_in;
 	u32 mkey;
 };
 
-- 
2.46.2


