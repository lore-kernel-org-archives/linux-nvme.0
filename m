Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6C4C2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:03:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8740620720
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0ixI8sZE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="VWwcxWwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8740620720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TkIdUeyQxQRrDPW7r54OCoUVvB90jmPwogSXM5dgAUE=; b=0ixI8sZEO9lo9w5X8ExydhuTe
	hjK2BCW2UOByeZ8lx0MbwSdm4g3jESyfpDWg7wctdw0vBwqQr9Ui3P9fTwjW7TzZQIexSytFQ7gB9
	xUaxiR33BQKrpzcSDX9z2iTpGuJzctTqZ9/A5Td0K0Q6UbdYPU7iIK4equaZsOiSKdGXeVAEaITkD
	iG7Lg0d+J2mKG6LT/LLFBkobhPzyo/5j9o05bXXHxGoOIkvjl8x8BbEnc+/SGDn/83sxZXrw6vKi+
	6vWvm21jx96wVjbOUM4dQxEdtnZY72vvW8tYjpbwRwYHGW6fRePk3/XsINZpcQJfjSb/isO+EYe6F
	qy2EGDUGQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb58s-0002E8-SR; Fri, 06 Nov 2020 17:03:14 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb56o-0000yo-5b
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 17:01:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3wtYAi0StI8nd0I1iePTfTtLTxyZ466aPXeo9Bi8PoQ=; b=VWwcxWwP1IDqGr3/kp969leU1z
 KFRMv/I9ZyQc6PxdptG26nWupvfqehgZ3fs2A3CyvFTZC3xjQ5s1akXGEjn3bg8cqNRC2fPonKSA5
 s/btudX7LX5JYJShE0vMCz0nIgJFhcF5pRyYqxgdrxA1Nz6RLoCN3TxGy+b7RSyB8r4dpFEHBR9cl
 wSeQClNu5Dyd2TGv/OIVFb25TcsfV5DIE5ngFXj3JRIgnTf5xQnA8Nsg+ClwtHkA2WKVN6zPNi07A
 QLKu6BeAvrXWSGj6sRoiIff60TUjTFD8COo0gRJHeIj8780DdDsRqS1CNOHftC6AGsaQJllSEmfLD
 HrGas1Jg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kb56h-0002PY-Qv; Fri, 06 Nov 2020 10:01:01 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kb56V-0004tB-17; Fri, 06 Nov 2020 10:00:47 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Fri,  6 Nov 2020 10:00:29 -0700
Message-Id: <20201106170036.18713-9-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106170036.18713-1-logang@deltatee.com>
References: <20201106170036.18713-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, dan.j.williams@intel.com,
 iweiny@intel.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org,
 daniel.vetter@ffwll.ch, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH 08/15] nvme-pci: Check DMA ops when indicating support for
 PCI P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_120107_160920_334DB1E6 
X-CRM114-Status: GOOD (  15.71  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: John Hubbard <jhubbard@nvidia.com>, Ira Weiny <iweiny@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Don Dutile <ddutile@redhat.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Introduce a supports_pci_p2pdma() operation in nvme_ctrl_ops to
replace the fixed NVME_F_PCI_P2PDMA flag such that the dma_map_ops
flags can be checked for PCI P2PDMA support.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c |  3 ++-
 drivers/nvme/host/nvme.h |  2 +-
 drivers/nvme/host/pci.c  | 11 +++++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 376096bfc54a..f14316c9b34a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3824,7 +3824,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
-	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
+	if (ctrl->ops->supports_pci_p2pdma &&
+	    ctrl->ops->supports_pci_p2pdma(ctrl))
 		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
 
 	ns->queue->queuedata = ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cc111136a981..a0bfe8709cfc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -465,7 +465,6 @@ struct nvme_ctrl_ops {
 	unsigned int flags;
 #define NVME_F_FABRICS			(1 << 0)
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
-#define NVME_F_PCI_P2PDMA		(1 << 2)
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
@@ -473,6 +472,7 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
+	bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
 };
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index df8f3612107f..ef7ce464a48d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2686,17 +2686,24 @@ static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 	return snprintf(buf, size, "%s\n", dev_name(&pdev->dev));
 }
 
+static bool nvme_pci_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
+{
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+
+	return dma_pci_p2pdma_supported(dev->dev);
+}
+
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
-	.flags			= NVME_F_METADATA_SUPPORTED |
-				  NVME_F_PCI_P2PDMA,
+	.flags			= NVME_F_METADATA_SUPPORTED,
 	.reg_read32		= nvme_pci_reg_read32,
 	.reg_write32		= nvme_pci_reg_write32,
 	.reg_read64		= nvme_pci_reg_read64,
 	.free_ctrl		= nvme_pci_free_ctrl,
 	.submit_async_event	= nvme_pci_submit_async_event,
 	.get_address		= nvme_pci_get_address,
+	.supports_pci_p2pdma	= nvme_pci_supports_pci_p2pdma,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
