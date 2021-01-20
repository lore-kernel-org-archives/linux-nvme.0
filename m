Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E86C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 09:49:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABB422227
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 09:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABB422227
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p7nyhWNnl9D2wz9buYXm54n+MGDG4tj6NB9dWKlUyLQ=; b=UmSdMoPm2LBMxXDAsGNJ4mTbB
	njKStJgCZnsMlxNEMDR6yHDQpvu7kxb/hkqvh93oXB9Vu+sed6tsNtZzRqa9C1yTnYGnK1WNe/dgc
	0OP+WYchjaJlrzvZ+wW8+PCIQPMIUIhUl4nFeroQjkzhC15kRapEqt0SeGmQRRdFzE8RwMfbBtwPU
	7V3LzRI8MgqMi0P0mxNmq2ivZfPza9509FVvIfqozZb/vj8tekC1KSHCkcU4MdN+D93JkTX44EOD6
	tiZczUIUgjzm+tgafzXiKk+IDSsxORtvy9GYvGd2Fr30c/0UFmzShPtSpTvJN0Zf5Wf0U9fD6IHvt
	CR+JFRetA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2A7I-0004Lz-Lo; Wed, 20 Jan 2021 09:49:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2A7H-0004Lr-Vv
 for linux-nvme@merlin.infradead.org; Wed, 20 Jan 2021 09:49:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=aqOFoKuYC5f6jtCsppt3sNLYniit/yqNNmFlKUAQQtI=; b=c30yfRkYG9j7rMXghCpk8RbRfG
 Q8NK81K1CwsZHs61Jc4Fc6pDNojRYFZzYRoq46ijj+0p24Ib/G/DuO8Hg6Au7CyCi2weBycC0CXyI
 DDsDlBPjdxhD/naTmB6F8hNK9FHNQLK9n4bRJHpUcHYG5AXIMD1H8CjKmCYNnZtvVPMKzbovJXNHb
 DiJ01Oq6iECRLcIOtiYfaqpC/3ADq7pn1iOFPfn/U7dSRxrUAqmuA9Fq/Kk0YuA2LTymrns0Isj/U
 tuP5OHhtKVeEl4u/3fnmwNrQgv+IeWPVRjlEDXK5u+zkpGeQMhg3FCTFxIOFJNC0RkQw4Au4X4zh6
 s5s94T7A==;
Received: from [2001:4bb8:188:1954:9564:b169:fdf4:9927] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l2A7B-00FUt3-4N; Wed, 20 Jan 2021 09:49:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-pci: fix error unwind in nvme_map_data
Date: Wed, 20 Jan 2021 10:49:15 +0100
Message-Id: <20210120094915.3198346-3-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120094915.3198346-1-hch@lst.de>
References: <20210120094915.3198346-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Marc Orr <marcorr@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Properly unwind step by step using refactored helpers from nvme_unmap_data
to avoid a potential double dma_unmap on a mapping failure.

Reported-by: Marc Orr <marcorr@google.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e29ece9e4d4b8e..4e93d1b52df202 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -683,7 +683,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 			__le64 *old_prp_list = prp_list;
 			prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 			if (!prp_list)
-				return BLK_STS_RESOURCE;
+				goto free_prps;
 			list[iod->npages++] = prp_list;
 			prp_list[0] = old_prp_list[i - 1];
 			old_prp_list[i - 1] = cpu_to_le64(prp_dma);
@@ -703,14 +703,14 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 		dma_addr = sg_dma_address(sg);
 		dma_len = sg_dma_len(sg);
 	}
-
 done:
 	cmnd->dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
 	cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
-
 	return BLK_STS_OK;
-
- bad_sgl:
+free_prps:
+	nvme_free_prps(dev, req);
+	return BLK_STS_RESOURCE;
+bad_sgl:
 	WARN(DO_ONCE(nvme_print_sgl, iod->sg, iod->nents),
 			"Invalid SGL for payload:%d nents:%d\n",
 			blk_rq_payload_bytes(req), iod->nents);
@@ -782,7 +782,7 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 
 			sg_list = dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
 			if (!sg_list)
-				return BLK_STS_RESOURCE;
+				goto free_sgls;
 
 			i = 0;
 			nvme_pci_iod_list(req)[iod->npages++] = sg_list;
@@ -795,6 +795,9 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 	} while (--entries > 0);
 
 	return BLK_STS_OK;
+free_sgls:
+	nvme_free_sgls(dev, req);
+	return BLK_STS_RESOURCE;
 }
 
 static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
@@ -863,7 +866,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
 	iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
 	if (!iod->nents)
-		goto out;
+		goto out_free_sg;
 
 	if (is_pci_p2pdma_page(sg_page(iod->sg)))
 		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
@@ -872,16 +875,21 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
 					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
 	if (!nr_mapped)
-		goto out;
+		goto out_free_sg;
 
 	iod->use_sgl = nvme_pci_use_sgls(dev, req);
 	if (iod->use_sgl)
 		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw, nr_mapped);
 	else
 		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
-out:
 	if (ret != BLK_STS_OK)
-		nvme_unmap_data(dev, req);
+		goto out_dma_unmap;
+	return BLK_STS_OK;
+
+out_dma_unmap:
+	nvme_unmap_sg(dev, req);
+out_free_sg:
+	mempool_free(iod->sg, dev->iod_mempool);
 	return ret;
 }
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
