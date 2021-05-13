Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9604C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:52:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8EC613F2
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8EC613F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TOcMP8J7+Gk0V3Xh68cesVpn5r92EYRcP6jfZ0jqKgU=; b=JkN91+PxFJybxc
	Z5TnpD9aeyElj13+7NQg2IQF0G5cAAKOlOVX/5wzX9Qi6Ui1bS1oRo+qrTLxebCean58NYXD8Vmoy
	tEX46ou9S3lNijeBkIcckafGB3NfKH++/m7lFZXM0yH2pCWjLK/jGHo893vDZZeeiVKzchcuR0EM4
	efgsW8ijAVJiQ5K3QWrCoipzWawdvKxyTOaRvDccpeWO2PMx041U3CCL2zm3VLbeDoxChuUAhLWNM
	Tt2PLqDy/Qi7B39dzhCNnXJIB6Bsg9rlDe+RYHsqI4UKrfzgo46n7vp/MV8n9t4qaEtbco3iVCLh1
	YWix6cL4H3gqAmMESUiA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhKBe-006bBV-G6; Thu, 13 May 2021 22:52:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsa-006Ydx-BQ
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 22:32:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=vkGnwru3sQ7lO5atwHiZHcltrNizNA3cWMJVaLsOWJc=; b=HCPiljQQfT4hBd9kRZpLr4D6rq
 YW09S+FZHtC3jMGkRG+MTFdWUpVo+hgrkMHjb7QwcnG9pvkdkAp4dZDMBK3hxws8UYB//YZVGRnM9
 V8np+dlwH7bD4zZB3fUTmG5Bwf1UtRHnv5S9HXUyTZp1CFnZ6IS+t5ZdlZu3c/XDViXQbuDTOdopL
 UdpNPu+1erHur6vxmhIg8oo3LI13QpcnIwpEgjEaPLEQtqS8ypetrlmyqaaCodj3alF+saZSevBsj
 K8cB+IiWttdzhzPGWU6LD/jtfnNoxf/fiZd8QL6FrF13rl6EdVW/OxV4cv9AelCBqRc/+q7ZASPsE
 /ZEjFAtQ==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsX-00BZEk-O8
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 22:32:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=vkGnwru3sQ7lO5atwHiZHcltrNizNA3cWMJVaLsOWJc=; b=P3FzMtKpuxP/na0lxGo+61Gd76
 0j3+AT9C1QYj/XR3N3e77V/zIrBjzN99OnkEtVD6o6Xiv2x1gQIwFhOSCS7Jz4Zq7vy/HhZRnsplY
 A5NWYYKxedlpogAxfT4ir8f/8Im2Z1qqAhrBzvd3ZujSSZ21AxalLS/hoe9rxCQcer8VPxOviG7ev
 ifv7gtKFG3B33K8MK1kD4YPc+iajyZWCwMN0NL9yxT+uziWOX2JxGl3FG/SqVQ4C4/etKeJdGdKwu
 yiVtDqeKFiGrNXwT+A/HPD9twTwAWWrVF1UL5qRAfeN1xGkEj/h0qFToQMN+qhzA/udZIYjNDNwV2
 TmB57ZpA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsW-0000nD-DH; Thu, 13 May 2021 16:32:25 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsH-0001Sw-59; Thu, 13 May 2021 16:32:09 -0600
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
Date: Thu, 13 May 2021 16:31:51 -0600
Message-Id: <20210513223203.5542-11-logang@deltatee.com>
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
Subject: [PATCH v2 10/22] iommu: Return full error code from
 iommu_map_sg[_atomic]()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_153225_803278_BCA48006 
X-CRM114-Status: GOOD (  13.59  )
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

Convert to ssize_t return code so the return code from __iommu_map()
can be returned all the way down through dma_iommu_map_sg().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/iommu.c | 15 +++++++--------
 include/linux/iommu.h | 22 +++++++++++-----------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70d5df5..df428206ea6e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2567,9 +2567,9 @@ size_t iommu_unmap_fast(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_unmap_fast);
 
-static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
-			     struct scatterlist *sg, unsigned int nents, int prot,
-			     gfp_t gfp)
+static ssize_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+		struct scatterlist *sg, unsigned int nents, int prot,
+		gfp_t gfp)
 {
 	const struct iommu_ops *ops = domain->ops;
 	size_t len = 0, mapped = 0;
@@ -2610,19 +2610,18 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 	/* undo mappings already done */
 	iommu_unmap(domain, iova, mapped);
 
-	return 0;
-
+	return ret;
 }
 
-size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
-		    struct scatterlist *sg, unsigned int nents, int prot)
+ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+		     struct scatterlist *sg, unsigned int nents, int prot)
 {
 	might_sleep();
 	return __iommu_map_sg(domain, iova, sg, nents, prot, GFP_KERNEL);
 }
 EXPORT_SYMBOL_GPL(iommu_map_sg);
 
-size_t iommu_map_sg_atomic(struct iommu_domain *domain, unsigned long iova,
+ssize_t iommu_map_sg_atomic(struct iommu_domain *domain, unsigned long iova,
 		    struct scatterlist *sg, unsigned int nents, int prot)
 {
 	return __iommu_map_sg(domain, iova, sg, nents, prot, GFP_ATOMIC);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..9369458ba1bd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -414,11 +414,11 @@ extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 extern size_t iommu_unmap_fast(struct iommu_domain *domain,
 			       unsigned long iova, size_t size,
 			       struct iommu_iotlb_gather *iotlb_gather);
-extern size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
-			   struct scatterlist *sg,unsigned int nents, int prot);
-extern size_t iommu_map_sg_atomic(struct iommu_domain *domain,
-				  unsigned long iova, struct scatterlist *sg,
-				  unsigned int nents, int prot);
+extern ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+		struct scatterlist *sg, unsigned int nents, int prot);
+extern ssize_t iommu_map_sg_atomic(struct iommu_domain *domain,
+				   unsigned long iova, struct scatterlist *sg,
+				   unsigned int nents, int prot);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
@@ -679,18 +679,18 @@ static inline size_t iommu_unmap_fast(struct iommu_domain *domain,
 	return 0;
 }
 
-static inline size_t iommu_map_sg(struct iommu_domain *domain,
-				  unsigned long iova, struct scatterlist *sg,
-				  unsigned int nents, int prot)
+static inline ssize_t iommu_map_sg(struct iommu_domain *domain,
+				   unsigned long iova, struct scatterlist *sg,
+				   unsigned int nents, int prot)
 {
-	return 0;
+	return -ENODEV;
 }
 
-static inline size_t iommu_map_sg_atomic(struct iommu_domain *domain,
+static inline ssize_t iommu_map_sg_atomic(struct iommu_domain *domain,
 				  unsigned long iova, struct scatterlist *sg,
 				  unsigned int nents, int prot)
 {
-	return 0;
+	return -ENODEV;
 }
 
 static inline void iommu_flush_iotlb_all(struct iommu_domain *domain)
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
