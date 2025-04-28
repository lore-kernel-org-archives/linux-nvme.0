Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A1EC3ABA5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 14:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=52+yGXnF7WmaQpmnHD64Abc8GOERoL17UyX9Asn2VWA=; b=KlTf1EVzQcSI8t0yPan/zXikK6
	gzbcupE33pvxuQTbhfMt/D6YCIIDsGxXpSrsI4wfPxTlmCHLNENFYa8aNQH7M4918ri4Z1jd2O9eT
	RwT7ZXXcGsYuJKxm5jmZs+P5SD8t8GnPB30M5qeO09G+p7nJ1pTijbTLhNWiGNuiNlOM3givHRJfk
	IypzOh0WpmZS+8os2Nr+3iMfyehwGHNnNo11oqDO8QF6dyJCRQERN5oXoq7GjydsbPflcabXcUJR0
	QaaZ3DkoTuja41jwFJon9Uzuq2SKas3LCJEq4dMhHbg3kZIUOfTkD3gYqt5YUC/xep2ZdHnw16AKx
	oWCon3OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9PH8-00000006b59-3eSk;
	Mon, 28 Apr 2025 14:16:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Kir-00000005b38-1EKv
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 09:24:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E9A814A93F;
	Mon, 28 Apr 2025 09:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C09AC4CEE4;
	Mon, 28 Apr 2025 09:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745832260;
	bh=JltzEs94lpehyHx6nl6wHRaPQKIRgU/HyWicrIFjUro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DyqXQ6VBPGUV60WqF+uTbZzXAsUAIJ9C1BCb2KV9m8F42ozYCzXInlnKQFxIS2b36
	 s+SctZer4F7Q5NkzQQld7WJZo9qsmkj9svarVHnHcf2ojzaBTAeBo4/HXSAAYmAED9
	 0xAI51RXFcaNAViqGFTvgw71I5NRyjdQoBDcESxnGQBEZOfbe7wMnLan2Z1+J+qRj+
	 8OEN5Dl/+rgO5hpebjkaj1SMCY1/3eRJ/TzmFUnFCx9NWXXoE71dQT6bHrYlzaqCDj
	 cQfDk5LtjtwfeRrBMl5iLWmlcl+SqiMKCEXYnYeUEY8YsO01MnQzVcNjFdveNAbkls
	 vBmDT0QLSZCQA==
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
Subject: [PATCH v10 24/24] nvme-pci: store aborted state in flags variable
Date: Mon, 28 Apr 2025 12:22:30 +0300
Message-ID: <ef01afea04a2aca3217ce1b52ec99bcd80e99f00.1745831017.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745831017.git.leon@kernel.org>
References: <cover.1745831017.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_022421_379164_14106116 
X-CRM114-Status: GOOD (  14.66  )
X-Mailman-Approved-At: Mon, 28 Apr 2025 05:19:59 -0700
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
index eb835425b496..9f3e2d8cbd04 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -219,6 +219,7 @@ struct nvme_queue {
 enum {
 	IOD_LARGE_DESCRIPTORS = 1 << 0, /* uses the full page sized descriptor pool */
 	IOD_SINGLE_SEGMENT = 1 << 1, /* single segment dma mapping */
+	IOD_ABORTED = 1 << 2, /* abort timed out commands */
 };
 
 /*
@@ -227,7 +228,6 @@ enum {
 struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_command cmd;
-	bool aborted;
 	u8 nr_descriptors;	/* # of PRP/SGL descriptors */
 	u8 flags;
 	unsigned int total_len; /* length of the entire transfer */
@@ -1027,7 +1027,6 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret;
 
-	iod->aborted = false;
 	iod->nr_descriptors = 0;
 	iod->flags = 0;
 	iod->total_len = 0;
@@ -1576,7 +1575,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	 * returned to the driver, or if this is the admin queue.
 	 */
 	opcode = nvme_req(req)->cmd->common.opcode;
-	if (!nvmeq->qid || iod->aborted) {
+	if (!nvmeq->qid || (iod->flags & IOD_ABORTED)) {
 		dev_warn(dev->ctrl.device,
 			 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout, reset controller\n",
 			 req->tag, nvme_cid(req), opcode,
@@ -1589,7 +1588,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
 	}
-	iod->aborted = true;
+	iod->flags |= IOD_ABORTED;
 
 	cmd.abort.opcode = nvme_admin_abort_cmd;
 	cmd.abort.cid = nvme_cid(req);
-- 
2.49.0


