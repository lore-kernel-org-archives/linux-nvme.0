Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334ECC369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 11:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/1XSPdcVZFEd9Vs+ac3IuU60oWbClklexpnxG4uCm4=; b=GO/W3YuIJPRIQOkIlM+3PlawW+
	72mewbBbgkOJr8rMzBibqk9DIcukBRrs3YQfbpJUe3aoV/iIjhb78TrNWTIvRmZR+Lrt4ZWW/IzV5
	gzqGMKiCKeY0IcoBaOTQuiKjKMV7HngOR9Ja3h2sizHNwZZ2fc4b2e8yBb82oWSFrhl7TaL8Ptwrg
	WeKhj/FpJ9QJqzsjjL0MAj0T//cYrDowHFxsmkhx1/dc6EcdbbqN44tG4xaFzM0Oy7gaqhlbdPmWF
	sLBH1HcFvM1AHSqDMMtsGisjczqadj9/I5ywwGvlY3xdyaMk+L5obIhFxbKm9MRrLgqVPzVrz/c6K
	Paq2F1YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7YON-0000000AMiy-2Y8t;
	Wed, 23 Apr 2025 11:35:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7WLV-00000009x52-31s7
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 09:24:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E67E268AFE; Wed, 23 Apr 2025 11:24:37 +0200 (CEST)
Date: Wed, 23 Apr 2025 11:24:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v9 23/24] nvme-pci: convert to blk_rq_dma_map
Message-ID: <20250423092437.GA1895@lst.de>
References: <cover.1745394536.git.leon@kernel.org> <7c5c5267cba2c03f6650444d4879ba0d13004584.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c5c5267cba2c03f6650444d4879ba0d13004584.1745394536.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_022446_040476_942AAF5E 
X-CRM114-Status: GOOD (  20.60  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 03:40:46 -0700
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

I don't think the meta SGL handling is quite right yet, and the
single segment data handling also regressed.  Totally untested
patch below, I'll try to allocate some testing time later today.

Right now I don't have a test setup for metasgl, though.  Keith,
do you have a good qemu config for that?  Or anyone else?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f69f1eb4308e..80c21082b0c6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -634,7 +634,11 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 	dma_addr_t dma_addr;
 
 	if (iod->flags & IOD_SINGLE_SEGMENT) {
-		dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp1);
+		if (iod->cmd.common.flags &
+		    (NVME_CMD_SGL_METABUF | NVME_CMD_SGL_METASEG))
+			dma_addr = le64_to_cpu(iod->cmd.common.dptr.sgl.addr);
+		else
+			dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp1);
 		dma_unmap_page(dev->dev, dma_addr, iod->total_len,
 				rq_dma_dir(req));
 		return;
@@ -922,35 +926,37 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req)
 	return nvme_pci_setup_prps(dev, req);
 }
 
-static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
-						struct request *req)
+static void nvme_unmap_metadata(struct nvme_dev *dev, struct request *req)
 {
 	unsigned int entries = req->nr_integrity_segments;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_sgl_desc *sg_list = iod->meta_list;
 	enum dma_data_direction dir = rq_dma_dir(req);
-	dma_addr_t dma_addr;
 
-	if (iod->flags & IOD_SINGLE_SEGMENT) {
-		dma_addr = le64_to_cpu(iod->cmd.common.dptr.sgl.addr);
-		dma_unmap_page(dev->dev, dma_addr, iod->total_len, rq_dma_dir(req));
+	/*
+	 * If the NVME_CMD_SGL_METASEG flag is not set and we're using the
+	 * non-SGL linear meta buffer we know that we have a single input
+	 * segment as well.
+	 *
+	 * Note that it would be nice to always use the linear buffer when
+	 * using IOVA mappings and kernel buffers to avoid the SGL
+	 * indirection, but that's left for a future optimization.
+	 */
+	if (!(iod->cmd.common.flags & NVME_CMD_SGL_METASEG)) {
+		dma_unmap_page(dev->dev,
+			le64_to_cpu(iod->cmd.common.dptr.prp1),
+			iod->total_len, rq_dma_dir(req));
 		return;
 	}
 
 	if (!blk_rq_dma_unmap(req, dev->dev, &iod->dma_meta_state,
 			      iod->total_meta_len)) {
-		if (iod->cmd.common.flags & NVME_CMD_SGL_METASEG) {
-			unsigned int i;
+		unsigned int i;
 
-			for (i = 0; i < entries; i++)
-				dma_unmap_page(dev->dev,
-				       le64_to_cpu(sg_list[i].addr),
-				       le32_to_cpu(sg_list[i].length), dir);
-		} else {
-			dma_unmap_page(dev->dev, iod->meta_dma,
-				       rq_integrity_vec(req).bv_len, dir);
-			return;
-		}
+		for (i = 0; i < entries; i++)
+			dma_unmap_page(dev->dev,
+			       le64_to_cpu(sg_list[i].addr),
+			       le32_to_cpu(sg_list[i].length), dir);
 	}
 
 	dma_pool_free(dev->prp_small_pool, iod->meta_list, iod->meta_dma);

