Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA246EEB591
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kry8TBp/PimGl5X7TNs+j/9P8+WUWzEQfu0ZW+M89Ng=; b=KG770hOjlwJXOLqvxOs6Zs+7s0
	wKG8+xGjH8nh1k8qp7HQllKC7/tv42OBGsN29RKmQZZbVuyWoW2TEnIStQHuzytHvYOQNDCNyVevS
	Xwtpv5q2UAPI6pyVqaeGfprqSmJGzvj5xtNPB2qmpGRxpZ7F2WUeBPBVhvcT9PhC+yArerqCk9ep3
	30QfwB/TT5aANDfQ2k7HX1kCEQp7vgCjJ296sP2KMWe1ItVEkCisaRw3zxS24qMXGFMpdjACP7X9d
	WjKun6SX9HkdSEJlUdMOsu1o7pAWHo21Sbz6T8JbngWyXrQyLR9yoYrTQgam40LKGsCxmw0+4809q
	gfNr/knA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohoE-0000000CnNZ-1zEF;
	Thu, 12 Sep 2024 11:16:22 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soho9-0000000CnIM-0q60
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 11:16:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9AC32A45255;
	Thu, 12 Sep 2024 11:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4577FC4CECE;
	Thu, 12 Sep 2024 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726139776;
	bh=wOAE2cOF8fAnldbeI2zuqZ+UOONgwZZm16iJWxrv2PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oqy5RZrK9GLnKls1wNDOUPi+7NtU2JS4w8JdmoFHMUazCDp35ubbfNk+eD2Ky3+kD
	 c9dh8XOv6xn8eUdWkXYq/ky1ASXhJwYbPSmlWO7OggXZokzWbb0xc++iuMk1NnstOZ
	 9G+LadC3Vfaio8VU/li3IVUb1dbRspKdNLjwGfwSKTIlBcbij2YVopnafSpz+igh2w
	 8q3vtsyRvLIliApnPdT+nobPr5chNkY+1N1mtTKAQdsI0f3f4yiiv78QQi0zQHlzvS
	 4okcMEZtIu1uoplQgT2/NieLqCfTUhXBYZSEndngVTH5rsuHS4qYvHNtl2e/+MdkFi
	 0ds6D1OQO+Iuw==
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
Subject: [RFC v2 04/21] dma-mapping: initialize IOVA state struct
Date: Thu, 12 Sep 2024 14:15:39 +0300
Message-ID: <cae6ddc4bad0045919758ae3a65f98ef84f6406d.1726138681.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726138681.git.leon@kernel.org>
References: <cover.1726138681.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_041617_445209_BFD1D143 
X-CRM114-Status: UNSURE (   9.99  )
X-CRM114-Notice: Please train this message.
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

Allow callers to properly initialize the IOVA state struct by providing
a new function to do so. This will make sure that even users who doesn't
zero their allocated memory will have a valid IOVA state struct.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-mapping.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f693aafe221f..285075873077 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -76,6 +76,20 @@
 
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
 
+struct dma_iova_state {
+	struct device *dev;
+	enum dma_data_direction dir;
+};
+
+static inline void dma_init_iova_state(struct dma_iova_state *state,
+				       struct device *dev,
+				       enum dma_data_direction dir)
+{
+	memset(state, 0, sizeof(*state));
+	state->dev = dev;
+	state->dir = dir;
+}
+
 #ifdef CONFIG_DMA_API_DEBUG
 void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 void debug_dma_map_single(struct device *dev, const void *addr,
-- 
2.46.0


