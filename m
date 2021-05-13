Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D573C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:34:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D0961396
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D0961396
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HXC18Pd07iEeK4q77jFSN7BjAlL//z87T2vwt5DOG9Q=; b=Sfp2tNAxH3mFKa
	4qX3YqVgga5910hKWZDm8DqIbz8BbXQA/ghItA+qZTuQFGvASaXPxQaakfF8G/CmDPJ5+SG5lWgWa
	T4QrDc7Om7FNJRxwx8bWvymPG24iSMj1JzTI/aWJAvMRiWJIejt3jolqq2IYN++KAEvyu3zosG009
	xXupvqhLxOAkn4ZPDEVoKN86fT3Yc0cS076HE03Ac9Rykppl/Q0NzlCsPsB0+pOoZzYWz6N7uD3k3
	oLAphkFkZNjm3MGVJnRfAwAvdMbKO8bogOYT3pjUFcHMu4l9lPUheXEg23jnCa9XLWwTh2c9GEh5u
	6u3vkgWwvCuvfVsT87Cw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhJu4-006Yr7-MJ; Thu, 13 May 2021 22:34:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsU-006YcV-UI
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 22:32:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=/UEifQb1uV56XbCPPXZkMtwQU9Qf0p/pPMKOkgy5W2o=; b=H4zSD1vjy5+YnPETrkLav+q6ia
 hi0I/wn8YmvQLsLGYAJuUnf9AGK61xmFZn6GPOI3aEmDZi2fE/76G7JIj2n260c3FLrgkI2s0nbio
 bQwTSkj4krUZO/lJPno2QClb0Q1k2lL9cvAdUvzxUNnOWBlnpSjFzXwDnMzRwc6PTcPfirLqqVznf
 ql70NCXfRjH0+8kWIRGoG8CP3M5dxDgmITKh8lAQ1WjlPXhYo19nkq8smQ0Y7bzluEw5nZE8W3bFY
 nf7iBGzEhanLN7SujPe/p6Q8TgSZoXPNb5nV2VgH5VihczBNhPhmpOCX63PIlKbOSF+cZfHRyeFkq
 F2zIz8fA==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsR-00BZBG-DA
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 22:32:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=/UEifQb1uV56XbCPPXZkMtwQU9Qf0p/pPMKOkgy5W2o=; b=jGA49pPoSP1ZCvD0TfobRIVRDR
 FIAQmqkwAg1zlBcl1n/OGvVOqKPlcNeUGsb0kayWRZK8tV0rW1/Cyb+1PQ2V1uxm6+NvchWV+Bbw1
 Z9jMg+9ALkS/wte/xLYYmDLrdap12nQ4YXCfUydQ8ahBWlVlU0fWOUSvB9gSFiNmfX8mWJt3uocug
 vlrGF2Cr4QEwXR/KNxuGtYh7rltUK9P7RlD8kVtkQJ4kPwe1jTrK3+/k7PmgpZmUhMXS2BncTwBp/
 Ee7JVIX23YSUiTWmGaXRNDV/njXNxifIDUnf17SPJVovjR14pVCJzOqc8UcFzzKTZSp+Y9gSHmVQH
 EEP0t7ng==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsP-0000nD-EI; Thu, 13 May 2021 16:32:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsI-0001TQ-OW; Thu, 13 May 2021 16:32:10 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 13 May 2021 16:32:01 -0600
Message-Id: <20210513223203.5542-21-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210513223203.5542-1-logang@deltatee.com>
References: <20210513223203.5542-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org,
 dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 20/22] RDMA/core: Introduce ib_dma_pci_p2p_dma_supported()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_153219_475073_5607C8C4 
X-CRM114-Status: GOOD (  14.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Introduce the helper function ib_dma_pci_p2p_dma_supported() to check
if a given ib_device can be used in P2PDMA transfers. This ensures
the ib_device is not using virt_dma and also that the underlying
dma_device supports P2PDMA.

Use the new helper in nvme-rdma to replace the existing check for
ib_uses_virt_dma(). Adding the dma_pci_p2pdma_supported() check allows
switching away from pci_p2pdma_[un]map_sg().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/rdma.c |  2 +-
 include/rdma/ib_verbs.h    | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 6c1f3ab7649c..86f0bf4dc1ca 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -414,7 +414,7 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
 	if (ib_dma_mapping_error(ndev->device, r->send_sge.addr))
 		goto out_free_rsp;
 
-	if (!ib_uses_virt_dma(ndev->device))
+	if (ib_dma_pci_p2p_dma_supported(ndev->device))
 		r->req.p2p_client = &ndev->device->dev;
 	r->send_sge.length = sizeof(*r->req.cqe);
 	r->send_sge.lkey = ndev->pd->local_dma_lkey;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7e2f3699b898..724e80a656f7 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3943,6 +3943,17 @@ static inline bool ib_uses_virt_dma(struct ib_device *dev)
 	return IS_ENABLED(CONFIG_INFINIBAND_VIRT_DMA) && !dev->dma_device;
 }
 
+/*
+ * Check if a IB device's underlying DMA mapping supports P2PDMA transfers.
+ */
+static inline bool ib_dma_pci_p2p_dma_supported(struct ib_device *dev)
+{
+	if (ib_uses_virt_dma(dev))
+		return false;
+
+	return dma_pci_p2pdma_supported(dev->dma_device);
+}
+
 /**
  * ib_dma_mapping_error - check a DMA addr for error
  * @dev: The device for which the dma_addr was created
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
