Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A600C55ABD
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:02:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3D920720
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YXw1hVz1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="E4md01Ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3D920720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ow6f2CSqkZ2z2bEcbR/FI5tRtU6bAMDtqt04lYiRmXI=; b=YXw1hVz1fT52WyH0SZrjAdTTq
	S79Btq0OQlyabD5o/FvUUe7ggiLU84qx0LsuCAM79wdoH+AJNq4QUEarLHNLhOfL+n3Q0qqpOFxZ4
	lxjgKOG18T7QKeTvDY2tll2cAw4/irpF09eH2jGN7Gsbq6h4ryVezmneLwhpFi3LLzVnJoQXi7B3e
	sq3Ywwcw1bKnpFZ+n5e2OcNDUyoBmNBPi0Esq79HUxwADaiN6l1hTXJqMuiVfsrR/29NFYrgHwH4c
	b5os4GqcZUHl1dq3/fz9jetUo+hATb/SAUCf5pY7UX8BGomoh0JDdhQzGvP8O1+24Vb4BPXnGHACP
	Wv3o5LTvQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb57h-0001Vr-DM; Fri, 06 Nov 2020 17:02:01 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb56e-0000sT-Oe
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 17:00:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3JGE+zyDK4D2O+eP7VElzaTL/57y/ZuAN1RtFkDLi+Y=; b=E4md01RaDgc5ca4VxuE651O53Y
 14g/QSSmSB24bw31bf1ZFImil9U+bjqhrYvHWtpO61bo+XuyxZkMTtWPhWJxJqRGEsgLAJjH5802J
 F9RnesqbKHRcqmJ9KA908uEKak9SHV+DSH47V/C6f0fAAlFYfBOJ8tOMm+bWhXx9mx7hvO9X4vz4G
 4EFqPx6gAqd+FAEa7fjbEBrPZ6tGZkORigKpQuIviHKvGN1VGx87R9X/9PXetfEMmTunOpS7xPyko
 56CW4ryiWfSHOyjDY8AQ11NFDKJMf0wTFlHPwJ3O46OgU+f9Se4wBgJGHsCgQFpwZFAxOwUZ/ZU19
 QKi3CluQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kb56Z-0002PX-5l; Fri, 06 Nov 2020 10:00:53 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kb56U-0004st-Ad; Fri, 06 Nov 2020 10:00:46 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Fri,  6 Nov 2020 10:00:23 -0700
Message-Id: <20201106170036.18713-3-logang@deltatee.com>
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
Subject: [RFC PATCH 02/15] PCI/P2PDMA: Attempt to set map_type if it has not
 been set
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_120056_908388_806B52B4 
X-CRM114-Status: GOOD (  14.31  )
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

Attempt to find the mapping type for P2PDMA pages on the first
DMA map attempt if it has not been done ahead of time.

Previously, the mapping type was expected to be calculated ahead of
time, but if pages are to come from userspace then there's no
way to ensure the path was checked ahead of time.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 94583779c36e..ea8472278b11 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -824,11 +824,17 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct pci_dev *provider,
 						    struct pci_dev *client)
 {
+	enum pci_p2pdma_map_type ret;
+
 	if (!provider->p2pdma)
 		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
 
-	return xa_to_value(xa_load(&provider->p2pdma->map_types,
-				   map_types_idx(client)));
+	ret = xa_to_value(xa_load(&provider->p2pdma->map_types,
+				  map_types_idx(client)));
+	if (ret != PCI_P2PDMA_MAP_UNKNOWN)
+		return ret;
+
+	return upstream_bridge_distance_warn(provider, client, NULL);
 }
 
 static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
@@ -890,7 +896,6 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	case PCI_P2PDMA_MAP_BUS_ADDR:
 		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
 	default:
-		WARN_ON_ONCE(1);
 		return 0;
 	}
 }
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
