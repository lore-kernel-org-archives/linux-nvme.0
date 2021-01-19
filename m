Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23B5C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 19:25:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E2223103
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 19:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E2223103
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:From:Subject:Mime-Version:Message-Id:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GWBtI/v4o/spk4Ze8JlWXj80KHTBcfgo5X+ShUHdqDQ=; b=nKo3Bn+gXOjl5De1ZLXQZ9gsKz
	2/wscG0h8azMtFSnfjGWap5pL7rBBRe0xl+/ycKiJkhuEvKqFJJCL2tf6y5aL4VVrMqbGDYRkWdav
	pxK5ur0y7+1IOc6YK5bKhKPCwdaaJ6qwKOUMQccRR6Ph8iLaSKS1GSweSbUq9u9M3Djfcnpusbb5m
	qzib1C3qVloFHciWhN/pNWT8nJd7+YXDzMPwcZLHfa5wbNNfuAF2zJQ+MPpMv/vncBA+YzGFTkNKE
	wvAjskP4bW5Vu2m7lc9TqocZHKkoRtoevF6h5LWEjkb8bJ5q6pBpkm4rhHMciWn/ULNIrkJOU677L
	R+26ufSg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1vCU-00028s-IJ; Tue, 19 Jan 2021 17:53:54 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1vCM-00028J-Vl
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 17:53:47 +0000
Received: by mail-pg1-x549.google.com with SMTP id 4so5476242pgm.3
 for <linux-nvme@lists.infradead.org>; Tue, 19 Jan 2021 09:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=evd2Y/DETLO7S33y5Cn5jun9AsciH/vlQsPeXswPTGQ=;
 b=HsVue5Ec3+MrJYXrnCqsn8cYHjurJmmuwHbecRCPMCjed8Z3anU7CJsk4YWTgakhmL
 6+HG7jvR1vAR+6jwws8n2dJuR7UYWO7GaMeRGcK1b/UGAYO/j71736fK6SFYQbzHInbv
 OoHEpgixpTK/i+cqp/q8x0ZoBlOe1mYRTBa25C/U/3KDPmn8CuuuLUSGvQv9EHRsMAoI
 f8NJt34GvNY7S6iYgsUtNWH9Jeb80v5M6bInxNX7tYp583NoURKWEVofkDZBB2ihiZWv
 K4eK2RZ2LDSlY0TUgmGep8OrjYWJN2gI5TlKBDTC9g/HMIOlXfoi58vTIbfcQiSQzotP
 IZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=evd2Y/DETLO7S33y5Cn5jun9AsciH/vlQsPeXswPTGQ=;
 b=shqs1KkfHQsm0HzhSCBmTnYLaW/dXq+MT1gJI/DmWXJEJYGkMppGskQ8oMDwh7XfZl
 U1rPrNOdLhyWSkwkKJscA9rbyI7seo0J2mZ6ilrA5mombhfI6V4XGRp2nFRsfPxNKhou
 i3lNZPlEEvMIjDfODTjI1JosD0XCLbl4mTSohnyIwXymuVI2osj9pBx19lh1esMKVVn/
 yGuesits0AMvgsVQKOOo8+HJ7sMubAsjao/OomIQXTmnIv85wxvEYidoigmFQkSHnea1
 48MXjuzL812o7fJF2El5Pwt9E6hjSgXnCLdtmbbTnwKPOrB70vHZ4Ibyyve8ha86O74a
 kxog==
X-Gm-Message-State: AOAM533CPjbiKuL+GykGoTCpv+mjrbykrBMXizDRhiNXpY5YCGMbjvNd
 +zulAuEUPX/xddLDfQg18N4lodgargAs
X-Google-Smtp-Source: ABdhPJy8kP3297v4O+ic7h8Vn1AVl9EHEVxp7Np60JfNXH60DUd06lHscGscPMlsO4VRIYba1WUePUUbq9iK
X-Received: from marcorr.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1d18])
 (user=marcorr job=sendgmr) by 2002:a17:902:c115:b029:de:8961:47e5
 with SMTP
 id 21-20020a170902c115b02900de896147e5mr5803698pli.46.1611078823356; Tue, 19
 Jan 2021 09:53:43 -0800 (PST)
Date: Tue, 19 Jan 2021 09:53:36 -0800
Message-Id: <20210119175336.4016923-1-marcorr@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] nvme: fix handling mapping failure
From: Marc Orr <marcorr@google.com>
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me, 
 jxgao@google.com, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_125347_050071_6B0BE1A2 
X-CRM114-Status: GOOD (  16.36  )
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
Cc: Marc Orr <marcorr@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch ensures that when `nvme_map_data()` fails to map the
addresses in a scatter/gather list:

* The addresses are not incorrectly unmapped. The underlying
scatter/gather code unmaps the addresses after detecting a failure.
Thus, unmapping them again in the driver is a bug.
* The DMA pool allocations are not deallocated when they were never
allocated.

The bug that motivated this patch was the following sequence, which
occurred within the NVMe driver, with the kernel flag `swiotlb=force`.

* NVMe driver calls dma_direct_map_sg()
* dma_direct_map_sg() fails part way through the scatter gather/list
* dma_direct_map_sg() calls dma_direct_unmap_sg() to unmap any entries
  succeeded.
* NVMe driver calls dma_direct_unmap_sg(), redundantly, leading to a
  double unmap, which is a bug.

Before this patch, I observed intermittent application- and VM-level
failures when running a benchmark, fio, in an AMD SEV guest. This patch
resolves the failures.

Tested-by: Marc Orr <marcorr@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Marc Orr <marcorr@google.com>
---
 drivers/nvme/host/pci.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9b1fc8633cfe..8b504ed08321 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -543,11 +543,14 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 
 	WARN_ON_ONCE(!iod->nents);
 
-	if (is_pci_p2pdma_page(sg_page(iod->sg)))
-		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
-				    rq_dma_dir(req));
-	else
-		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
+	if (!dma_mapping_error(dev->dev, iod->first_dma)) {
+		if (is_pci_p2pdma_page(sg_page(iod->sg)))
+			pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
+					    rq_dma_dir(req));
+		else
+			dma_unmap_sg(dev->dev, iod->sg, iod->nents,
+				     rq_dma_dir(req));
+	}
 
 
 	if (iod->npages == 0)
@@ -836,8 +839,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	else
 		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
 					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
-	if (!nr_mapped)
+	if (!nr_mapped) {
+		iod->first_dma = DMA_MAPPING_ERROR;
+		iod->npages = -1;
 		goto out;
+	}
 
 	iod->use_sgl = nvme_pci_use_sgls(dev, req);
 	if (iod->use_sgl)
-- 
2.30.0.284.gd98b1dd5eaa7-goog


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
