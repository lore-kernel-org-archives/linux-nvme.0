Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4544CC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 18:30:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6EDB64E3C
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 18:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EDB64E3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:From:Subject:References:Mime-Version:Message-Id:In-Reply-To:Date:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YGEBs/mG1bcw/8Q38ytBENoqWFLf8Lx/RRxxXUcqlBo=; b=Ps8/DGLwIHL0x59K8gcX3p5ML/
	Si1o1N7LyCWy2oGDZQyFDPdyFF5uabsMvH01S2yWuVDwC3VJGt2iMhZAzfrPyBta2yHaUvBVc6PyD
	Em5TxemMpOyJGgQutHIrkmihWUSsnsc89CrQ4KADrRT2Sph/CUo69kiqxqK8jH81R42fkuxmk4knM
	b8Tv2wVKimKFP4n3wopuFvgVvaHhusjpSrVGuJdRa8iplEEB0QRA/QTj9R/IikNQZVe1PLl4A65Od
	dXnOIy2ZhkkpMY5MYNzu7eUXOBpi7HUR/Hnj9Ug+jw+eDm5K+ZGs+nneL4H9i9GD6V8kD5Zdft9Ay
	fsW0Ku3Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6dy8-0000g8-Jr; Mon, 01 Feb 2021 18:30:36 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6dy4-0000df-QD
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 18:30:33 +0000
Received: by mail-pl1-x64a.google.com with SMTP id z9so10056742plg.19
 for <linux-nvme@lists.infradead.org>; Mon, 01 Feb 2021 10:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to; bh=y7lafpwHwPK5mLUJYNpXf5D/a9FQS9JwhKfquZ6N6PI=;
 b=Lz9RegoyArGD7/Njm0yeOSa9hVKGX5dIR1sKuXMh7YX9fVDPXJYSrsAMuWEk0bii2V
 chvtIy+8dFO6PgQd1YJFNO2TWHWUvywrlNFEhcieuyVZXPKa3Ar53CEbzqDKIILsoX1E
 QMZddPHGcyPHa+g9lscMZg/ciF0UxBTewvkVpBRcEcRYtNcMJLoWOZlomdxonc7YqBqZ
 lYdUc9id12JfatpvDjALnBnLIIIyRGkiLoLPF/V8+eaOpeiGbP6HkMqDoxSbGzR1Xnly
 njCSd4DHvsx5U4XHn2T7vF7reiGURphVkVkf6xhrhut71ZGo1XKvLrhruGNRMT11Ggmy
 JWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to;
 bh=y7lafpwHwPK5mLUJYNpXf5D/a9FQS9JwhKfquZ6N6PI=;
 b=E1ddZrNGqvqNDcg9rIvp2hhXy6saRbcbQJYpCOZbMwSVD4/ZPMuxfb+sNBAk6ZMlDf
 Q3kZVHH7huShfY45UlqNv4ACx9Y5yT81NUr8HfHcQ8ui6FeoLd7pKyBsZHjKm3LG8L9S
 7X7+0u+AFPI1dMDv6sCWETdr+y0W8CXIcLdS+LfNfbNu/TUhhU/OTaj6yrN7cqsJEi9S
 kVo855Lzsg2rxXCloQ7QeMKnSYDQA8Y6rP6smrH/9UozmJRbzg72z0rQwaFU+NV42kmL
 Om/Gs89ALAqcpobcv0hfMrQE5dszpZu+cO5jFPskOZHKn3jp7/+XlT66WqOCt4FM6JXA
 BJpg==
X-Gm-Message-State: AOAM533+guNKyg5hMRO6J5vsxvbFhL5cZ1InfOUscR1FsodEb+vBe7Zi
 BZ87WhmZwS0qchss61DaGHKDlYETBw==
X-Google-Smtp-Source: ABdhPJyxPr/mnKV6SfFRVsYQGdbwoOCXbpgSQ9gKmDR4teO9TwxE5BensFncv9xIqKkCY9ImrCPjV5hgMw==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:695f:7f9e:413c:e3c7])
 (user=jxgao job=sendgmr) by 2002:a17:902:d901:b029:e1:6a7f:564c with SMTP id
 c1-20020a170902d901b02900e16a7f564cmr4367057plz.11.1612204227054; Mon, 01 Feb
 2021 10:30:27 -0800 (PST)
Date: Mon,  1 Feb 2021 10:30:17 -0800
In-Reply-To: <20210201183017.3339130-1-jxgao@google.com>
Message-Id: <20210201183017.3339130-4-jxgao@google.com>
Mime-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask to
 NVMe driver.
From: Jianxiong Gao <jxgao@google.com>
To: jxgao@google.com, erdemaktas@google.com, marcorr@google.com, hch@lst.de, 
 m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org,
 saravanak@google.com, heikki.krogerus@linux.intel.com, 
 rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
 dan.j.williams@intel.com, bgolaszewski@baylibre.com, jroedel@suse.de, 
 iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, kbusch@kernel.org, 
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_133032_925568_945CBC8E 
X-CRM114-Status: GOOD (  15.53  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMe driver relies on the address offset to function properly.
This patch adds the offset preserve mask to NVMe driver when mapping
via dma_map_sg_attrs and unmapping via nvme_unmap_sg. The mask
depends on the page size defined by CC.MPS register of NVMe
controller.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
---
 drivers/nvme/host/pci.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 81e6389b2042..30e45f7e0f75 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -580,12 +580,15 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
 static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-
+	if (dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))
+		dev_warn(dev->dev, "dma_set_min_align_mask failed to set offset\n");
 	if (is_pci_p2pdma_page(sg_page(iod->sg)))
 		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
 				    rq_dma_dir(req));
 	else
 		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
+	if (dma_set_min_align_mask(dev->dev, 0))
+		dev_warn(dev->dev, "dma_set_min_align_mask failed to reset offset\n");
 }
 
 static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
@@ -842,7 +845,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret = BLK_STS_RESOURCE;
-	int nr_mapped;
+	int nr_mapped, offset_ret;
 
 	if (blk_rq_nr_phys_segments(req) == 1) {
 		struct bio_vec bv = req_bvec(req);
@@ -868,12 +871,24 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	if (!iod->nents)
 		goto out_free_sg;
 
+	offset_ret = dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
+	if (offset_ret) {
+		dev_warn(dev->dev, "dma_set_min_align_mask failed to set offset\n");
+		goto out_free_sg;
+	}
+
 	if (is_pci_p2pdma_page(sg_page(iod->sg)))
 		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
 				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
 	else
 		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
 					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
+
+	offset_ret = dma_set_min_align_mask(dev->dev, 0);
+	if (offset_ret) {
+		dev_warn(dev->dev, "dma_set_min_align_mask failed to reset offset\n");
+		goto out_free_sg;
+	}
 	if (!nr_mapped)
 		goto out_free_sg;
 
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
