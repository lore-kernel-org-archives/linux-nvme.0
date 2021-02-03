Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA9CC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 13:37:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903C964E2E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 13:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903C964E2E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vVZ5GYGjXJLiCfY0HqDEqlzcJF469N2zZ5BwTxMEUnQ=; b=3XO+T10IfxmLb7xaEoZqwpDVl
	sKaaBNjzfqM6XfhN9I7SGeg4cSdOAsTcUQhBkORhdP8ZXH8LlSC681tp29OpP3oGdiXtkaEKvycXG
	bEGPdC63g/dtNB7CBiJdSZmS0UObDmzFfwCdCgoT5SxyAEEHVnswQjbhVXJF66p2tUSokNVRc/e8X
	Ka2rFI9mWTy+zkc94GiTowU/lF84KhWiamRfBG1RJ13PjMF4ljrICDr38k9h5/f/QSXgKNY37j5G3
	UWSb7FA2NzNfd81ppIxxlNMfDHjlDH5rhr6yzLtYCnSGKOjFTvXDxFDChSkJhgrgMzOHadmG5y8fz
	+iSJobbuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7ILS-0005LJ-2y; Wed, 03 Feb 2021 13:37:22 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7ILO-0005JJ-A8
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 13:37:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6150367357; Wed,  3 Feb 2021 14:37:12 +0100 (CET)
Date: Wed, 3 Feb 2021 14:37:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: [PATCH V2 3/3] Adding
 device_dma_parameters->offset_preserve_mask to NVMe driver.
Message-ID: <20210203133712.GA24674@lst.de>
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
 <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
 <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_083718_520674_A9ED168A 
X-CRM114-Status: GOOD (  13.68  )
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
Cc: heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 Saravana Kannan <saravanak@google.com>, bgolaszewski@baylibre.com,
 Marc Orr <marcorr@google.com>, gregkh@linuxfoundation.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 axboe@fb.com, Erdem Aktas <erdemaktas@google.com>,
 iommu@lists.linux-foundation.org, jroedel@suse.de,
 Keith Busch <kbusch@kernel.org>, dan.j.williams@intel.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Please try with this extra patch:

---
From 212764c3c15ce859e6f55d2146f450ea4ca6fdb9 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 3 Feb 2021 14:27:13 +0100
Subject: nvme-pci: fix 2nd PRP setup in nvme_setup_prp_simple

Use the dma address instead of the bio_vec offset for the arithmetics
to find the address for the 2nd PRP.

Fixes: dff824b2aadb ("nvme-pci: optimize mapping of small single segment requests")
Reported-by: Jianxiong Gao <jxgao@google.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 30e45f7e0f750c..4ae51735d72f4a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -808,8 +808,7 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 		struct bio_vec *bv)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	unsigned int offset = bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
-	unsigned int first_prp_len = NVME_CTRL_PAGE_SIZE - offset;
+	dma_addr_t next_prp;
 
 	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->first_dma))
@@ -817,8 +816,9 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 	iod->dma_len = bv->bv_len;
 
 	cmnd->dptr.prp1 = cpu_to_le64(iod->first_dma);
-	if (bv->bv_len > first_prp_len)
-		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma + first_prp_len);
+	next_prp = round_down(iod->first_dma + bv->bv_len, NVME_CTRL_PAGE_SIZE);
+	if (next_prp > iod->first_dma)
+		cmnd->dptr.prp2 = cpu_to_le64(next_prp);
 	return BLK_STS_OK;
 }
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
