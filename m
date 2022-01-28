Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBEAC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 00:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SthFkrlch6Gbtf7JBQRiLJWdMmfUwEHz21EJfjIo+fM=; b=PUvRgBOE5ANI12NtIcm9CofVf+
	GMuizxAXf1LqRmG5ctm7Aic0EJfPJHjDqTWgKPm2/32XMyfj+7UzQ97K9NZtkF9sdVUV0OsQYh9zi
	zAWHe14r8RVJ7Q4X86+f+DOXx7xAC7u8T1Ej1U43zJZu/h7RPleYps1ZKmbo0yIO+t47jE4QLpepV
	6CJmiYRZh2cdyVLs0ncN97IO/FnK7pm+8X+kAQvD5Uqi0x4zfwVX5o+WmJsZpkskAnnZzT5pRch7J
	2gCoXA7sh14aUDGWOCEV2z763rnG7D6700HWBv/p9GIj9IrTp9G1sES6L4bFQYxVHX3AbztSK8Ffi
	CeGBztzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDFBi-00HUKL-Ib; Fri, 28 Jan 2022 00:32:26 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDF63-00HS62-06
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 00:26:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=SthFkrlch6Gbtf7JBQRiLJWdMmfUwEHz21EJfjIo+fM=; b=lVrUYYfTM6XGioXpaDhU8TWgMB
 vgyWwjfvd+30vJr+Otba/J2QVHspa3Wu4+iov+2m7rQKOg5weIdMqzazQUbzDHYz/fRPbobbTjO5b
 UNyFiauFRkM9u2G++t+v4M1vLtkmowFWMS9373R6QZsbG3PhE5YTIr3/j4GDVPVe3OLyDlBMdmJqN
 mFzzocv2QiaF5iml93QU7vLdFzdslWKLSEW57Lr82qElnNWvYeCTRV0ZIo+wIg2pZ9fvKyNQPfiOM
 XaVP54CtEyu7JavZqVHJGtJIBrobriUCTzscqeKhItJJolN6bghr2ERmQE1rWPH+JQMp6U7Sa+gRR
 IfM3RwOQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5t-005OcZ-MY; Thu, 27 Jan 2022 17:26:26 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5o-0001ct-6H; Thu, 27 Jan 2022 17:26:20 -0700
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
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>
Date: Thu, 27 Jan 2022 17:26:03 -0700
Message-Id: <20220128002614.6136-14-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128002614.6136-1-logang@deltatee.com>
References: <20220128002614.6136-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com,
 willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com,
 andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com,
 ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com,
 ckulkarnilinux@gmail.com, logang@deltatee.com, jhubbard@nvidia.com,
 rcampbell@nvidia.com, jgg@nvidia.com, mgurtovoy@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v5 13/24] RDMA/core: introduce ib_dma_pci_p2p_dma_supported()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_162635_199342_576AED32 
X-CRM114-Status: GOOD (  14.43  )
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

Introduce the helper function ib_dma_pci_p2p_dma_supported() to check
if a given ib_device can be used in P2PDMA transfers. This ensures
the ib_device is not using virt_dma and also that the underlying
dma_device supports P2PDMA.

Use the new helper in nvme-rdma to replace the existing check for
ib_uses_virt_dma(). Adding the dma_pci_p2pdma_supported() check allows
switching away from pci_p2pdma_[un]map_sg().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/rdma.c |  2 +-
 include/rdma/ib_verbs.h    | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1deb4043e242..22519739a874 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -415,7 +415,7 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
 	if (ib_dma_mapping_error(ndev->device, r->send_sge.addr))
 		goto out_free_rsp;
 
-	if (!ib_uses_virt_dma(ndev->device))
+	if (ib_dma_pci_p2p_dma_supported(ndev->device))
 		r->req.p2p_client = &ndev->device->dev;
 	r->send_sge.length = sizeof(*r->req.cqe);
 	r->send_sge.lkey = ndev->pd->local_dma_lkey;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 69d883f7fb41..79609ab73014 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4003,6 +4003,17 @@ static inline bool ib_uses_virt_dma(struct ib_device *dev)
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
2.30.2


