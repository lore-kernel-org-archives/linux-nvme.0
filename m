Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBD2C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 23:02:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F79F61185
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 23:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F79F61185
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=630K8EeA2leYiEGVL9X1L5IXTvlRjWxaXutdUpHWJZ4=; b=k4PlKsptL/a4jd
	BzcV9NMUsKiWQFvx0YDeAfVuxHJyHZDPGb7hJQQHbhG2ljL+0dRfpfdOD2LH8diBzxQNW+x9DdIEe
	EmNFQHG8Ww2DA3mFBEUjCDQGIdmV2S9a7z5Y/tLoynjNr2jMj1MCStrJWHcEUEkPg8OuowqEwhDVz
	uaIgXoQLtTaKIE/fd8/DJe4K50A9KmHCK81CwSAQrEcLgmfmQHYpotZgfQUcz+tqWcoRBy5vSOZhc
	S/aWg4/uEDfF2EBBEQhOG7YmNoviEfBWhReAgKBch6ZbetiM6DvbRll25TnDZf6j+7NeoRVZHyw0+
	xQI4e1mWT/C5D3Lo3LMg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhKKp-006cK5-CW; Thu, 13 May 2021 23:01:39 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsc-006YeP-1X
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 22:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=/1W3j2Rqe8fHNrWCW7Ouw3jhOc5qpB9v4K7ma+z5lU0=; b=YmkTWjL6ogfBDozkFxsJobZqxQ
 hAamV2Zied+KTeuCU0PZ30ZzpS/VJhkzFDNZYM1bnjyg+yJBeRZta/YEjkO00lwwBpOohvOJOgA3U
 EcA4z1mfkrpjkB7rn+tWZyVy74gsJQM5IryDArLKCC/Q071vjqXtBtmQPybx2H/oZdyshWX9Hq/K0
 uPVOvKvK8AqCXcmT+Gdr6JQb2XqvoppdWbg1SLcszb7ouGMz3PDyON9Sk27zu19VeeDH3NHpqdc+c
 1HjvAPxwub2zTnzdZbmkaidxujUctj0mZK3OqJWYDXplluXvswhCPl/koWJ6gfbFbUPUE5gPyeIjy
 1Se7lJRA==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsY-00BZFn-UX
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 22:32:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=/1W3j2Rqe8fHNrWCW7Ouw3jhOc5qpB9v4K7ma+z5lU0=; b=Ys4pV10me/1xi7s30rq3o0HcrG
 aB4TcV8fdKr8P9FqdAXnC+uJWH4g/DCkVcdltpeEHo7vrxZvLuyJYS04WujHSdisVJ9z+X8xfnm89
 nPV6mTDTu7U4R3qCwPPWuVu3Ibr7lluZ+T65TQI2WIzDrri4qiOGtC+/i4ccdOwm9KM5BAwIiU6/M
 HO3PD6J3YEYP3YgDsDigux3bvRjHMEc2WpNd6x16pgnoatpjC88tIxgg+sOCuGsGDFUGKq0GBVzIM
 lBOyhE/5f/QD05itfMHhj7v6z9HN4yKV9i+A7RCLLLktp4zHRL+aH/LVbMAvpJTa1c8yLFs6KV/zf
 GdvxmdxQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsX-0000nB-BA; Thu, 13 May 2021 16:32:26 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsG-0001Sq-O9; Thu, 13 May 2021 16:32:08 -0600
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
Date: Thu, 13 May 2021 16:31:49 -0600
Message-Id: <20210513223203.5542-9-logang@deltatee.com>
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
Subject: [PATCH v2 08/22] dma-mapping: Allow map_sg() ops to return negative
 error codes
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_153227_065285_AA11ADBD 
X-CRM114-Status: GOOD (  23.41  )
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

Allow dma_map_sgtable() to pass errors from the map_sg() ops. This
will be required for returning appropriate error codes when mapping
P2PDMA memory.

Introduce __dma_map_sg_attrs() which will return the raw error code
from the map_sg operation (whether it be negative or zero). Then add a
dma_map_sg_attrs() wrapper to convert any negative errors to zero to
satisfy the existing calling convention.

dma_map_sgtable() will convert a zero error return for old map_sg() ops
into a -EINVAL return and return any negative errors as reported.

This allows map_sg implementations to start returning multiple
negative error codes. Legacy map_sg implementations can continue
to return zero until they are all converted.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/dma-map-ops.h |  8 ++++++--
 include/linux/dma-mapping.h | 41 ++++++++++++++++++++++++++++++++-----
 kernel/dma/mapping.c        | 13 +++++-------
 3 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 0d53a96a3d64..eaa969be8284 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -41,8 +41,12 @@ struct dma_map_ops {
 			size_t size, enum dma_data_direction dir,
 			unsigned long attrs);
 	/*
-	 * map_sg returns 0 on error and a value > 0 on success.
-	 * It should never return a value < 0.
+	 * map_sg should return a negative error code on error.
+	 * dma_map_sgtable() will return the error code returned and convert
+	 * a zero return (for legacy implementations) into -EINVAL.
+	 *
+	 * dma_map_sg() will always return zero on any negative or zero
+	 * return to satisfy its own calling convention.
 	 */
 	int (*map_sg)(struct device *dev, struct scatterlist *sg, int nents,
 			enum dma_data_direction dir, unsigned long attrs);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 183e7103a66d..2b0ecf0aa4df 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -105,7 +105,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		unsigned long attrs);
 void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs);
-int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
+int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
 void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 				      int nents, enum dma_data_direction dir,
@@ -164,7 +164,7 @@ static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 }
-static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
+static inline int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	return 0;
@@ -343,6 +343,34 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
 	return dma_sync_single_for_device(dev, addr + offset, size, dir);
 }
 
+/**
+ * dma_map_sg_attrs - Map the given buffer for DMA
+ * @dev:	The device for which to perform the DMA operation
+ * @sg:	The sg_table object describing the buffer
+ * @dir:	DMA direction
+ * @attrs:	Optional DMA attributes for the map operation
+ *
+ * Maps a buffer described by a scatterlist passed in the sg argument with
+ * nents segments for the @dir DMA operation by the @dev device.
+ *
+ * Returns the number of mapped entries (which can be less than nents)
+ * on success. Zero is returned for any error.
+ *
+ * dma_unmap_sg_attrs() should be used to unmap the buffer with the
+ * original sg and original nents (not the value returned by this funciton).
+ */
+static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	int ret;
+
+	ret = __dma_map_sg_attrs(dev, sg, nents, dir, attrs);
+	if (ret < 0)
+		ret = 0;
+
+	return ret;
+}
+
 /**
  * dma_map_sgtable - Map the given buffer for DMA
  * @dev:	The device for which to perform the DMA operation
@@ -357,16 +385,19 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
  * ownership of the buffer back to the CPU domain before touching the
  * buffer by the CPU.
  *
- * Returns 0 on success or -EINVAL on error during mapping the buffer.
+ * Returns 0 on success or a negative error code on error
  */
 static inline int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	int nents;
 
-	nents = dma_map_sg_attrs(dev, sgt->sgl, sgt->orig_nents, dir, attrs);
-	if (nents <= 0)
+	nents = __dma_map_sg_attrs(dev, sgt->sgl, sgt->orig_nents, dir, attrs);
+	if (nents == 0)
 		return -EINVAL;
+	else if (nents < 0)
+		return nents;
+
 	sgt->nents = nents;
 	return 0;
 }
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 2b06a809d0b9..700a2bb7cc9e 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -177,11 +177,7 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 }
 EXPORT_SYMBOL(dma_unmap_page_attrs);
 
-/*
- * dma_maps_sg_attrs returns 0 on error and > 0 on success.
- * It should never return a value < 0.
- */
-int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
+int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -197,12 +193,13 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
 	else
 		ents = ops->map_sg(dev, sg, nents, dir, attrs);
-	BUG_ON(ents < 0);
-	debug_dma_map_sg(dev, sg, nents, ents, dir);
+
+	if (ents > 0)
+		debug_dma_map_sg(dev, sg, nents, ents, dir);
 
 	return ents;
 }
-EXPORT_SYMBOL(dma_map_sg_attrs);
+EXPORT_SYMBOL(__dma_map_sg_attrs);
 
 void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 				      int nents, enum dma_data_direction dir,
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
