Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41B2C43381
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 00:39:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A7B64DCE
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 00:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A7B64DCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:From:Subject:References:Mime-Version:Message-Id:In-Reply-To:Date:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PhMT4zAZel5u77OhSub6G2PNDItHBEP0q78S5IM5zmA=; b=3UWTudl4R8RBY6ytWZLt17mMWy
	h7aqX5abMF4MApjYe8TZSvc0F/ww5DaDj0kYm05Eh2Ji+vWVxI8C7t56IusXyrixdeqnvBIE09Cdt
	QZAtuHcAF31XYgprppO7IwiRJQ3Bu9pENjjFlHRXEweIcdPpI0kUUaViOeltcisLxfSnRYr0pM18O
	RNjPW5PBoE3loEMIWh0XVXYmguLvfyrGs/gF8AYLgDbbX4QzSmtiIzXEueB+LKmZnSFIscuzIBp2/
	Xnh0PJ3/30Ux0CHr0qQsXClQVSc4s795HcTmUZDIRktnQehA/QmM5taTypiwcgn/vkKgqD5LSm7pN
	Eud9yiFw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4vKt-0006Gx-Cy; Thu, 28 Jan 2021 00:38:59 +0000
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4vKl-0006F3-J4
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 00:38:52 +0000
Received: by mail-yb1-xb4a.google.com with SMTP id y1so4099213ybe.11
 for <linux-nvme@lists.infradead.org>; Wed, 27 Jan 2021 16:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to; bh=S76UV5kxidYXbgCR1VuCa1vuB9V23gC9gqu6RBvYKNI=;
 b=fz1zYJOGH62ztoJUartn4VEw2vyYszv5Q1bITcQeeg34HhxJNH56QOsyD61zYCGfxd
 O7A+iQPhET5O5Iva7LqnCizGtkPKW4pfNGMbubFOMH1RBYzMSGU6xD3q6/QrXA18Ff8/
 5G8BPmR7JcKzxA4ITYT/eKsnQTpPWpXcI/M9cTyZChpy28GxXqVXqWhRuu2H7is+0Nz1
 iIQrn6/kJilKpc9BmD7xkjcwDbgncjcB4rjOZKh56EcTNP8lVA/tlr0fWqnoMSCAJSqF
 yoceWAFFLD9BpXjDiLmsgFwfEl0Gu/npahweWe2ZfSjj7rurxZpp86jkHhmxZ3VXcOXU
 PX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to;
 bh=S76UV5kxidYXbgCR1VuCa1vuB9V23gC9gqu6RBvYKNI=;
 b=og5AGQ9AYkVYp7nAxJ10eJwsYfcQRrCBYmPRKa2/GMlLXzJFieQzgli6k1y2y4wfPJ
 T9yyU8n2l9jD69mPEmjgfLqjxv86N1K9zcE7nfRd+rGgtoxTSiX0cLDBsahegzqx4+zG
 geLH8UMqd2iF7FoTKc+i7ljf9k6y0ELIXHRREdp5uidgbbk2L3uCKat9Vbpe2ZtXWVH9
 7jYbgV0T6lZKBCdEimRa9lp4NO6uDb62PmIjQDxdWKVix6IQe0+PiW9uh6YjtFU9JgyO
 TsBC2z8bl68OjGBqZombUdARgzxhJ3gdZOdomKUup8cRvAqXKt5otMqFIr4UQsiD/aeu
 kHZw==
X-Gm-Message-State: AOAM532f1XQi+xJyE6QD98s/tAFsLRTkscdqegsgiKF0W8XEX/jp1YmA
 8Hsqjp5gd9gPTEkjXXE4mfwBRw4hww==
X-Google-Smtp-Source: ABdhPJxhW9bnAu6awThXrNNK9h8pR96zH9JI9NukbN8uc2eD0HCU4F2glSXLYN/SAof/oTTUS9ZxUoM4Wg==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:4d90:620d:7a68:ffc5])
 (user=jxgao job=sendgmr) by 2002:a5b:30f:: with SMTP id
 j15mr19901700ybp.431.1611794326856; 
 Wed, 27 Jan 2021 16:38:46 -0800 (PST)
Date: Wed, 27 Jan 2021 16:38:29 -0800
In-Reply-To: <20210128003829.1892018-1-jxgao@google.com>
Message-Id: <20210128003829.1892018-4-jxgao@google.com>
Mime-Version: 1.0
References: <20210128003829.1892018-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 3/3] Adding device_dma_parameters->offset_preserve_mask to
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
X-CRM114-CacheID: sfid-20210127_193851_734761_C1D98122 
X-CRM114-Status: GOOD (  14.08  )
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
index 856aa31931c1..0b23f04068be 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -580,12 +580,15 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
 static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-
+	if (dma_set_page_offset_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))
+		dev_warn(dev->dev, "dma_set_page_offset_mask failed to set offset\n");
 	if (is_pci_p2pdma_page(sg_page(iod->sg)))
 		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
 				    rq_dma_dir(req));
 	else
 		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
+	if (dma_set_page_offset_mask(dev->dev, 0))
+		dev_warn(dev->dev, "dma_set_page_offset_mask failed to reset offset\n");
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
 
+	offset_ret = dma_set_page_offset_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
+	if (offset_ret) {
+		dev_warn(dev->dev, "dma_set_page_offset_mask failed to set offset\n");
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
+	offset_ret = dma_set_page_offset_mask(dev->dev, 0);
+	if (offset_ret) {
+		dev_warn(dev->dev, "dma_set_page_offset_mask failed to reset offset\n");
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
