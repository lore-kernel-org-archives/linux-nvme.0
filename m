Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFC3C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:34:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C994461354
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C994461354
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bhtp67gzeysOGylRYt+yg1UAM5HRDtm5jAg0eSo3RFY=; b=bnn48kgoztPaA2
	ZY5J3DZZwSGEFOyZX0wIyzS9rBYnADxEVjSwkqS0EPGile5R7qYcUuNsc5M6MneQBPenG79OHYZml
	g8p0t2TLHhOuzh84xFpe4U4H3moyMlLrsSKvb3ny3MDGPSimABXcPn/ofYGE3ZIqpCGMXtlHcC4ZE
	IvLdJDy8sK0jzLw8pCHiIutLvDgrCDdJ8XBKs9lMYSoxYaSxwldewrpI2/sOy3wkja+cz0YVo1sBT
	51akfujBCuRqaDLZmjO1Q7uvg1w0hZ99JfOLMx386lp0OeSWd/pQ1rT8EhpFSKn2DhK0BFzdaf2w8
	FPGcL/Ig/3d2rJvlWeAw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhJuT-006YvQ-Pl; Thu, 13 May 2021 22:34:25 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsV-006Ycd-4t
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 22:32:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Vu2C8BB1vuWksLygZzsmKzcGYioNTg5VVbRwzB7NOHg=; b=j1So9zi/hGcAm0tiYWcJSNn+Sy
 RIaH9RKLF5cantIwa9WmFRiQUWHZO9kKdwiCjzXA0moLja0+uttDJ6FrPzf4rp44tS4Pv4kpbWtIn
 ZqObHbaajmGu83m9/H66BBIAxp2ofddQT6g2gCKopMaj2z7AfRY0cP/WKrKRxg9X0xEO4M95nVkIG
 nLW44NoRkLYoKpzj+trUdmXiNbUL3rl+4LRJHQCAJ804lFl14e0P/keyAsWbArlXp9YeHM83yGDHa
 v+i4E6tE96a54JsNF9mGTLj/8y4jPwHn17oaPz+cgrBKd7I/BJFWuU53pGNmsdRqlHFSho85dQ66b
 us/qvOYw==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsQ-00BZAx-Kl
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 22:32:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=Vu2C8BB1vuWksLygZzsmKzcGYioNTg5VVbRwzB7NOHg=; b=CdROGG4lwhPQLSc3XOmk76jt9k
 sYhan3fs/XPKzzVkBYm4ug3FcyIq+vzgucYCx7leUhoFLXKX/9tYffNff9ruUyw6lAluFrwrui8bV
 bJSoCraFGZstoPg9RkzrBvcljA4s3tj0J7C+wkoMUk7agBrjeu+10NvT7f3VfZe0diQq8RM8Q1puC
 poVaRv5pF5uCbECgxBQRC/a1R28A8wU6ExRg+tWDryVab/mqOooEd0FUOxHcBjpNsavat2KqxBlPt
 WKmYhWmHUdd26hidMW/qJ4zqQB/NDWTKoNAKyhjMcqPs1U5GHidXH9lYJGZjfksKg6vYarEyNcwtM
 DzuqO0JA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsO-0000nC-Vp; Thu, 13 May 2021 16:32:17 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsI-0001TT-TP; Thu, 13 May 2021 16:32:10 -0600
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
Date: Thu, 13 May 2021 16:32:02 -0600
Message-Id: <20210513223203.5542-22-logang@deltatee.com>
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
Subject: [PATCH v2 21/22] RDMA/rw: use dma_map_sgtable()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_153218_736731_D05927F5 
X-CRM114-Status: GOOD (  19.12  )
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

dma_map_sg() now supports the use of P2PDMA pages so pci_p2pdma_map_sg()
is no longer necessary and may be dropped.

Switch to the dma_map_sgtable() interface which will allow for better
error reporting if the P2PDMA pages are unsupported.

The change to sgtable also appears to fix a couple subtle error path
bugs:

  - In rdma_rw_ctx_init(), dma_unmap would be called with an sg
    that could have been incremented from the original call, as
    well as an nents that was not the original number of nents
    called when mapped.
  - Similarly in rdma_rw_ctx_signature_init, both sg and prot_sg
    were unmapped with the incorrect number of nents.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/infiniband/core/rw.c | 75 +++++++++++++++---------------------
 include/rdma/ib_verbs.h      | 19 +++++++++
 2 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index a588c2038479..68f2dda56138 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -273,26 +273,6 @@ static int rdma_rw_init_single_wr(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	return 1;
 }
 
-static void rdma_rw_unmap_sg(struct ib_device *dev, struct scatterlist *sg,
-			     u32 sg_cnt, enum dma_data_direction dir)
-{
-	if (is_pci_p2pdma_page(sg_page(sg)))
-		pci_p2pdma_unmap_sg(dev->dma_device, sg, sg_cnt, dir);
-	else
-		ib_dma_unmap_sg(dev, sg, sg_cnt, dir);
-}
-
-static int rdma_rw_map_sg(struct ib_device *dev, struct scatterlist *sg,
-			  u32 sg_cnt, enum dma_data_direction dir)
-{
-	if (is_pci_p2pdma_page(sg_page(sg))) {
-		if (WARN_ON_ONCE(ib_uses_virt_dma(dev)))
-			return 0;
-		return pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
-	}
-	return ib_dma_map_sg(dev, sg, sg_cnt, dir);
-}
-
 /**
  * rdma_rw_ctx_init - initialize a RDMA READ/WRITE context
  * @ctx:	context to initialize
@@ -313,12 +293,16 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
 {
 	struct ib_device *dev = qp->pd->device;
+	struct sg_table sgt = {
+		.sgl = sg,
+		.orig_nents = sg_cnt,
+	};
 	int ret;
 
-	ret = rdma_rw_map_sg(dev, sg, sg_cnt, dir);
-	if (!ret)
-		return -ENOMEM;
-	sg_cnt = ret;
+	ret = ib_dma_map_sgtable(dev, &sgt, dir, 0);
+	if (ret)
+		return ret;
+	sg_cnt = sgt.nents;
 
 	/*
 	 * Skip to the S/G entry that sg_offset falls into:
@@ -354,7 +338,7 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 	return ret;
 
 out_unmap_sg:
-	rdma_rw_unmap_sg(dev, sg, sg_cnt, dir);
+	ib_dma_unmap_sgtable(dev, &sgt, dir, 0);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_init);
@@ -387,6 +371,14 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 						    qp->integrity_en);
 	struct ib_rdma_wr *rdma_wr;
 	int count = 0, ret;
+	struct sg_table sgt = {
+		.sgl = sg,
+		.orig_nents = sg_cnt,
+	};
+	struct sg_table prot_sgt = {
+		.sgl = prot_sg,
+		.orig_nents = prot_sg_cnt,
+	};
 
 	if (sg_cnt > pages_per_mr || prot_sg_cnt > pages_per_mr) {
 		pr_err("SG count too large: sg_cnt=%d, prot_sg_cnt=%d, pages_per_mr=%d\n",
@@ -394,18 +386,14 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		return -EINVAL;
 	}
 
-	ret = rdma_rw_map_sg(dev, sg, sg_cnt, dir);
-	if (!ret)
-		return -ENOMEM;
-	sg_cnt = ret;
+	ret = ib_dma_map_sgtable(dev, &sgt, dir, 0);
+	if (ret)
+		return ret;
 
 	if (prot_sg_cnt) {
-		ret = rdma_rw_map_sg(dev, prot_sg, prot_sg_cnt, dir);
-		if (!ret) {
-			ret = -ENOMEM;
+		ret = ib_dma_map_sgtable(dev, &prot_sgt, dir, 0);
+		if (ret)
 			goto out_unmap_sg;
-		}
-		prot_sg_cnt = ret;
 	}
 
 	ctx->type = RDMA_RW_SIG_MR;
@@ -426,10 +414,11 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 
 	memcpy(ctx->reg->mr->sig_attrs, sig_attrs, sizeof(struct ib_sig_attrs));
 
-	ret = ib_map_mr_sg_pi(ctx->reg->mr, sg, sg_cnt, NULL, prot_sg,
-			      prot_sg_cnt, NULL, SZ_4K);
+	ret = ib_map_mr_sg_pi(ctx->reg->mr, sg, sgt.nents, NULL, prot_sg,
+			      prot_sgt.nents, NULL, SZ_4K);
 	if (unlikely(ret)) {
-		pr_err("failed to map PI sg (%d)\n", sg_cnt + prot_sg_cnt);
+		pr_err("failed to map PI sg (%d)\n",
+		       sgt.nents + prot_sgt.nents);
 		goto out_destroy_sig_mr;
 	}
 
@@ -468,10 +457,10 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 out_free_ctx:
 	kfree(ctx->reg);
 out_unmap_prot_sg:
-	if (prot_sg_cnt)
-		rdma_rw_unmap_sg(dev, prot_sg, prot_sg_cnt, dir);
+	if (prot_sgt.nents)
+		ib_dma_unmap_sgtable(dev, &prot_sgt, dir, 0);
 out_unmap_sg:
-	rdma_rw_unmap_sg(dev, sg, sg_cnt, dir);
+	ib_dma_unmap_sgtable(dev, &sgt, dir, 0);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_signature_init);
@@ -604,7 +593,7 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		break;
 	}
 
-	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy);
 
@@ -632,8 +621,8 @@ void rdma_rw_ctx_destroy_signature(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	kfree(ctx->reg);
 
 	if (prot_sg_cnt)
-		rdma_rw_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
-	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+		ib_dma_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
+	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy_signature);
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 724e80a656f7..3db6de41aa2d 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4053,6 +4053,25 @@ static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
 				   dma_attrs);
 }
 
+static inline int ib_dma_map_sgtable(struct ib_device *dev,
+				     struct sg_table *sgt,
+				     enum dma_data_direction direction,
+				     unsigned long dma_attrs)
+{
+	if (ib_uses_virt_dma(dev))
+		return ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
+	return dma_map_sgtable(dev->dma_device, sgt, direction, dma_attrs);
+}
+
+static inline void ib_dma_unmap_sgtable(struct ib_device *dev,
+					struct sg_table *sgt,
+					enum dma_data_direction direction,
+					unsigned long dma_attrs)
+{
+	if (!ib_uses_virt_dma(dev))
+		dma_unmap_sgtable(dev->dma_device, sgt, direction, dma_attrs);
+}
+
 /**
  * ib_dma_map_sg - Map a scatter/gather list to DMA addresses
  * @dev: The device for which the DMA addresses are to be created
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
