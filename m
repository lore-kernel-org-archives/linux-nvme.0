Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9A5C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jul 2022 16:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zRvvqf/soJ+YHmVk4fjT2lplFRBLbHW1+J+sEuwQeuA=; b=2Y2xy8gmmRnkbsQ0WpjivDDwvb
	tjwhzsOrNM0slm7TcJFjlmISiueI4QNPgAqu4BeeKrH3+sXWnoATmasm3mH6zP9WFoR+EF+lhVI8O
	yhfyENSl7Xy7HR6SggXFnerwU5oklJ1rX7w1DubIGP0FgBCl7nst81iAllgJ3XyUov0dSeREGxnna
	kXiuWnxDqTdtEmt8jlPBwG2wOqz8qu7Mwy0ebADGYFdiOlzQgwNvIpGYcBCww/5icxH5ig+EnRBGm
	/9ekdU16o9km8kfrYgDZtvTuxhgnDns6gkM+2armLQmP9B6ZdTS/2UVN6v1RonDI9HDQWn9nVBgYL
	umUJ6RGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9rDo-004o3c-HL; Fri, 08 Jul 2022 16:52:52 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9rCL-004n4C-Nw
	for linux-nvme@lists.infradead.org; Fri, 08 Jul 2022 16:51:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:content-disposition;
	bh=zRvvqf/soJ+YHmVk4fjT2lplFRBLbHW1+J+sEuwQeuA=; b=M+C7MCh5IhiXo+bB1Y7x/O53/T
	bYM37YlM895SHeEuRs3ZbWhoaYCQlOhBf8GwHDGLlSwIi5Xb8IbIZ3FZnoiMEuOafM92vPolonVxA
	NlALP2XdNi6k9ErgcWKJf4q3eiMHH8NISZMcCgZ6wZLYwgnl0xLupoJbJWPlr/S5sJRnwiLK0Yx41
	f1Mac8DOupVrKjsHxnwY+REQ2GxotG87bRZsr/7D+5ZCd0T/4UKc3i1TIDNMfe1oYTcmeBJTp7KbI
	2/ps/9MSnUsrstFXF5zCuC03Po0S8UbJKropq/fSuN53/R95HgGrnbxrTBryQdVbKy9xOmO1dqYFC
	vJ6zB6Ew==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1o9rCF-009xkG-4M; Fri, 08 Jul 2022 10:51:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1o9rC9-0001K4-Uw; Fri, 08 Jul 2022 10:51:09 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org,
	iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Cc: Stephen Bates <sbates@raithlin.com>,
	Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Fri,  8 Jul 2022 10:50:58 -0600
Message-Id: <20220708165104.5005-8-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220708165104.5005-1-logang@deltatee.com>
References: <20220708165104.5005-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, iommu@lists.linux.dev, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v8 07/13] iommu: Explicitly skip bus address marked segments  in __iommu_map_sg()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_095121_889548_3DEBC084 
X-CRM114-Status: GOOD (  11.68  )
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

In order to support PCI P2PDMA mappings with dma-iommu, explicitly skip
any segments marked with sg_dma_mark_bus_address() in __iommu_map_sg().

These segments should not be mapped into the IOVA and will be handled
separately in as subsequent patch for dma-iommu.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 847ad47a2dfd..2844a3e02a89 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2457,6 +2457,9 @@ static ssize_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			len = 0;
 		}
 
+		if (sg_is_dma_bus_address(sg))
+			goto next;
+
 		if (len) {
 			len += sg->length;
 		} else {
@@ -2464,6 +2467,7 @@ static ssize_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			start = s_phys;
 		}
 
+next:
 		if (++i < nents)
 			sg = sg_next(sg);
 	}
-- 
2.30.2


