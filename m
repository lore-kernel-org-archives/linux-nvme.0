Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6D2EEB593
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 11:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vXUTI8GNy8HG3SImA/IuHNiER0tJEICmf+Jwlta/u6c=; b=fGNdpD49/PWopQ7ORuyZAx8f+o
	JTU9wt7zMXUZZ3IC6X5ShmpR/zmx9mcVX3nPKu0rEZaysSw5EIKVeIbRrgajPsMJJQ9FvgJY8vkUM
	jwd9M87YlbZThFGrrIF/4hb12wrcfya5lFDNGQPkxUacG3ZJJA9FixH7XsdATne7c9buaQoryCR3v
	13IfzqXjM07rwDpTvf9i4ouAS3pY13r+NNTW/Fo6WA3r9N7ExgVXQzqvrU7aog85AVK9iBjp4jGNM
	KQA448/XByK7ATLM42jOVaAs4yVIJXlQq7VYQ33XDGa2t6rXNAMCg37Bc3uLnK8+vjaw6XIzrKjx4
	M5EqQ5KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohpY-0000000CoWD-3oFu;
	Thu, 12 Sep 2024 11:17:44 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohpR-0000000CoQI-0QAU
	for linux-nvme@bombadil.infradead.org;
	Thu, 12 Sep 2024 11:17:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=vXUTI8GNy8HG3SImA/IuHNiER0tJEICmf+Jwlta/u6c=; b=oOmuKqI1H3ZmLkFU06zkIg6WHb
	+bQ7jH5nPM1MHhN25DhlOALxzf9RiS5DGhs7xT0VHUNiP1cSZmzP0vYzQWJRXj2fXAy5MrLUg8U7T
	0nzJ5bwwYE8zXoLP+rT+mh9VJA4zdi0HBBwrW5bPspNiSzgJw4wRM43caxZ8eAc55dgA0xIPBaJ7x
	7PmY3aUAW0TTRteHrEIxJAzHv9J8Y7rPQjBmX92MXcMB6ZPpi1t1HWe1Wi1idcLSAZ+C56G3kMlbG
	AWYLw0L0Pl8i2Z+eb9RlNNJ6kDk/knOkKJoSSPVLEXSz9LnosmRKmpMv0tfw/i5NryXrpebbzSrU3
	jPDcxcYA==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by casper.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sohpN-000000071gx-3EUG
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 11:17:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8B718A4527A;
	Thu, 12 Sep 2024 11:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B911C4CECE;
	Thu, 12 Sep 2024 11:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726139849;
	bh=Ch307cuLMtu9IkxYPq9fEPmV/1GlNElaatF0p6+K/3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rjQEVR0WNIDFIumqiRWFBZ/LeaRIQrWt7cRNRpwd5Qr3Ery2891OThDNpX5O70OkA
	 3u+K7SybOwx4RJVpNWxWVcp9dPJOARjRDtQ5bfDWc6ZBdwjeLjroi/LGRBt7k8iEnk
	 rrKGRP00PzsLM6BQjTbD0bOTaSYxwnYo6ipA4GhON7Q3sfr8WoiFk8o1QO2Fv+ILhF
	 /xfjffj8UsYtxpX9Wuzy0IcN8Uxvpj7UQIuJSgTBOPVfFQgt+1eyO4AqZDO/l5tLYd
	 5CdaCvA6GAmBErDw8MkhJzDPoXCGNeg9rN3Ks4+pahOUrr4xwY6R/1BbLfmuF5yF5c
	 mxeUvTEss0paA==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC v2 19/21] nvme-pci: precalculate number of DMA entries for each command
Date: Thu, 12 Sep 2024 14:15:54 +0300
Message-ID: <8c5b0e5ab1716166fc93e76cb2d3e01ca9cf8769.1726138681.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726138681.git.leon@kernel.org>
References: <cover.1726138681.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_121733_999642_21EDE791 
X-CRM114-Status: GOOD (  12.28  )
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

Calculate the number of DMA entries for each command in the request in
advance.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/nvme/host/pci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a9a66f184138..2b236b1d209e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -231,6 +231,7 @@ struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_command cmd;
 	bool aborted;
+	u8 nr_dmas;
 	s8 nr_allocations;	/* PRP list pool allocations. 0 means small
 				   pool in use */
 	dma_addr_t first_dma;
@@ -766,6 +767,23 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 	return BLK_STS_OK;
 }
 
+static u8 nvme_calc_num_dmas(struct request *req)
+{
+	struct bio_vec bv;
+	u8 nr_dmas;
+
+	if (blk_rq_nr_phys_segments(req) == 0)
+		return 0;
+
+	nr_dmas = DIV_ROUND_UP(blk_rq_payload_bytes(req), NVME_CTRL_PAGE_SIZE);
+	bv = req_bvec(req);
+	if (bv.bv_offset && (bv.bv_offset + bv.bv_len) >= NVME_CTRL_PAGE_SIZE)
+		/* Accommodate for unaligned first page */
+		nr_dmas++;
+
+	return nr_dmas;
+}
+
 static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -779,6 +797,8 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	if (ret)
 		return ret;
 
+	iod->nr_dmas = nvme_calc_num_dmas(req);
+
 	if (blk_rq_nr_phys_segments(req)) {
 		ret = nvme_map_data(dev, req, &iod->cmd);
 		if (ret)
-- 
2.46.0


