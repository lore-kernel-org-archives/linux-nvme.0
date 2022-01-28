Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306E2C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 00:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bRKwNbLS7GTorTVqHwjsOSnom3kuz6wsSSmUEePGzuc=; b=enUO6zyqNGocoSbd+8bOnYKoP8
	NU4c2JrGjLA2P08RolxKxU4MKsUqCDCagh7goctYEnQ/11ADf7ADtQ1n4pKjRHTspW00Sh+jXpkK7
	f+yV//pecQgWZ/v/PwJi520bbslmY4FFYKwCCMqtNqePVxstYFtZ7z7JfD/HQ+1u4U6GsGjYFD8Nj
	FoVbQuFufRJ4cOGS0XWSLWfIyQCgGnBLo0WnuND7mqiOLFl/BTOQIt0TX5Bp5lNkhHiFoVPkeslqq
	x+D7BdbvqB3rk+C8cVY2I8IrVoGu2A8FhsSjD3pOQuQ2ri/f7UWAS7JuIRE8G0//uJaow+8zRE+g6
	F6i2PeTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDF6Y-00HSW5-DA; Fri, 28 Jan 2022 00:27:06 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDF5u-00HRw1-NQ
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 00:26:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=bRKwNbLS7GTorTVqHwjsOSnom3kuz6wsSSmUEePGzuc=; b=bbCGCv2EfpiJjjFaP9abLvC1cM
 Sm++joV+vIhFDE3ycOTZUG498KzRrSdEDKEN9SQIIZUdbhc/YoQ0DfjQMkERarIVbrRXVK6w2CSPZ
 AwcM72rvP+JqOvBa+3q4iZDXBxHGKa5KJVDotidYB/zfXPJtcPv9FjbpNJc4lVVYY36VJ1bW1BEBo
 CRlyTYkBXN6VJFG77/h9nzmY6aSthXmwEKGNBwhM4NSTdBkAVdpPgcp8zZPZDr4HFIa4YC4KZX4Yf
 6V9SzQVNljq015M1B9bdjnNhtFDKymD2AgeAianLjdGqdqYecjHiGk8E1Tz1MtYAaWItofLbzhgHj
 e6SlzPQA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5r-005OcX-Pi; Thu, 27 Jan 2022 17:26:24 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5p-0001dT-Uz; Thu, 27 Jan 2022 17:26:22 -0700
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
 Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 27 Jan 2022 17:26:12 -0700
Message-Id: <20220128002614.6136-23-logang@deltatee.com>
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
 ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v5 22/24] mm: use custom page_free for P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_162626_810255_E74BC2E9 
X-CRM114-Status: GOOD (  12.98  )
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

When P2PDMA pages are passed to userspace, they will need to be
reference counted properly and returned to their genalloc after their
reference count returns to 1. This is accomplished with the existing
DEV_PAGEMAP_OPS and the .page_free() operation.

Change CONFIG_P2PDMA to select CONFIG_DEV_PAGEMAP_OPS and add
MEMORY_DEVICE_PCI_P2PDMA to page_is_devmap_managed(),
devmap_managed_enable_[put|get]() and free_devmap_managed_page().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 13 +++++++++++++
 mm/memremap.c        |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index e66694cc9e14..3a24bf5099cf 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -101,6 +101,18 @@ static const struct attribute_group p2pmem_group = {
 	.name = "p2pmem",
 };
 
+static void p2pdma_page_free(struct page *page)
+{
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
+
+	gen_pool_free(pgmap->provider->p2pdma->pool,
+		      (uintptr_t)page_to_virt(page), PAGE_SIZE);
+}
+
+static const struct dev_pagemap_ops p2pdma_pgmap_ops = {
+	.page_free = p2pdma_page_free,
+};
+
 static void pci_p2pdma_release(void *data)
 {
 	struct pci_dev *pdev = data;
@@ -198,6 +210,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	pgmap->range.end = pgmap->range.start + size - 1;
 	pgmap->nr_range = 1;
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
+	pgmap->ops = &p2pdma_pgmap_ops;
 
 	p2p_pgmap->provider = pdev;
 	p2p_pgmap->bus_offset = pci_bus_address(pdev, bar) -
diff --git a/mm/memremap.c b/mm/memremap.c
index 0fc8b85d792e..ced9448ddcb4 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -299,6 +299,10 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 	case MEMORY_DEVICE_GENERIC:
 		break;
 	case MEMORY_DEVICE_PCI_P2PDMA:
+		if (!pgmap->ops->page_free) {
+			WARN(1, "Missing page_free method\n");
+			return ERR_PTR(-EINVAL);
+		}
 		params.pgprot = pgprot_noncached(params.pgprot);
 		break;
 	default:
@@ -460,6 +464,7 @@ void free_zone_device_page(struct page *page)
 {
 	switch (page->pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_PCI_P2PDMA:
 		free_device_page(page);
 		return;
 	case MEMORY_DEVICE_FS_DAX:
-- 
2.30.2


