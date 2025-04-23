Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFBEC369D7
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 11:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QbVlYEvvbEd6r1kmzRub22g5bJ8bELoGo7XxL5O6L6Q=; b=3goPL5Jsfg2DG1qjCAV51+O9Ta
	mzb0MlpvONmORTlRF8DdIylhgh9c0wEMzNXZUpDHwpkdGVChm9JNOREchLhSrXUlG0PnLU6sqUbE7
	7xqIJ6CibgUy2xINhqQL3M8e/wM+WWIFowePIwDs224LlOvOcQKO1zTrEMoXLhBoui2Fg9ZQGYFxU
	i9k/SrAdU1RsuYJCTcAlb+H88WpucgfTLGDZ/qJJkkRMu01YV3DLgzwsWIUMPXQq3G5lKf6mG0PBr
	36Tam4el3ZdpoS0Sd9Ovknky6i5lt2qB0F8NVDgG4imXoqXofjKvL2rpBbI1f1VdIm7Zz8API0Kr8
	D4NKcRMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Y54-0000000AI2C-1Vmk;
	Wed, 23 Apr 2025 11:15:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7VGV-00000009ffm-1KZu
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 08:15:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 854EF4A4F8;
	Wed, 23 Apr 2025 08:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA44FC4CEE2;
	Wed, 23 Apr 2025 08:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745396130;
	bh=hJ7Ip9+BoZAGI5de25k6VVDZHayvfvf2mLK8emkWpDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J12nDPRU3cH7wA88Iu9BFVrY+PzsKtMJ7xncym3a/Q+sMbBCS7mLM3ryCPgfwbt4+
	 VfesgKcyGq1stn/1qMWS0rL0/jhFKx98nQP5G9WUIPyi6U66Kj1H2z5Cp+DRsrjzsp
	 2/XrS33uwHNvshj+OP+6nyD8KmO74H0MbhjK/6yY7scz7tsm8Jsap/FHPMQdW4g0Xu
	 T5CFKk5USJ5XElRY01pmoB94PGC10Pllk2VaLO/uxA0SClhTgNbPWpAKkOAyDN7459
	 8vRn1WHXTwkLPiavmersXQcNwP6Sz1WdbV+biC8HCQeqVCWW6Zf1OZLtauCglURDip
	 0i7XWKreZyV0w==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
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
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v9 24/24] nvme-pci: store aborted state in flags variable
Date: Wed, 23 Apr 2025 11:13:15 +0300
Message-ID: <9432af8b4b3b947ed6b280e722389c188d5c957e.1745394536.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745394536.git.leon@kernel.org>
References: <cover.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_011531_410871_2930766B 
X-CRM114-Status: GOOD (  15.04  )
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

From: Leon Romanovsky <leonro@nvidia.com>

Instead of keeping dedicated "bool aborted" variable, let's reuse
newly introduced flags variable and save space.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/nvme/host/pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index eb60a486331c..f69f1eb4308e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -219,6 +219,7 @@ struct nvme_queue {
 enum {
 	IOD_LARGE_DESCRIPTORS = 1, /* uses the full page sized descriptor pool */
 	IOD_SINGLE_SEGMENT = 2, /* single segment dma mapping */
+	IOD_ABORTED = 3, /* abort timed out commands */
 };
 
 /*
@@ -227,7 +228,6 @@ enum {
 struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_command cmd;
-	bool aborted;
 	u8 nr_descriptors;	/* # of PRP/SGL descriptors */
 	unsigned int flags;
 	unsigned int total_len; /* length of the entire transfer */
@@ -1029,7 +1029,6 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret;
 
-	iod->aborted = false;
 	iod->nr_descriptors = 0;
 	iod->flags = 0;
 	iod->total_len = 0;
@@ -1578,7 +1577,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	 * returned to the driver, or if this is the admin queue.
 	 */
 	opcode = nvme_req(req)->cmd->common.opcode;
-	if (!nvmeq->qid || iod->aborted) {
+	if (!nvmeq->qid || (iod->flags & IOD_ABORTED)) {
 		dev_warn(dev->ctrl.device,
 			 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout, reset controller\n",
 			 req->tag, nvme_cid(req), opcode,
@@ -1591,7 +1590,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
 	}
-	iod->aborted = true;
+	iod->flags |= IOD_ABORTED;
 
 	cmd.abort.opcode = nvme_admin_abort_cmd;
 	cmd.abort.cid = nvme_cid(req);
-- 
2.49.0


