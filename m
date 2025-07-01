Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2ACAC83038
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GgHqexxiwa77u3Z5YOk3UNEKMTHwKP2/90bhpYz0EQg=; b=m8ozqO3ic3NSmLIgk4NDGiLnpi
	IoFfDfP8iEH2mPrKYTHl5a8msqjGbMUBIoGkKEp3hu+u9DNXIJunAQYgHXfc2MkWmdyrfloa9qFEG
	ndx29roTRWF2OcnoZFTboFlCBsiR4Y6OG2/D59w6/SofK4hZYeMUj2nZhnNb2lVkgBNncVB5U9vpD
	BJyDC/PqAVMkMwoG5dyZQrAd8pyNz1BU8uOXGi4TpGYRinmIUjqDSI0k075a5VIHGOGPJoGqRs/EP
	0d41A9JUiWU3uwpm+qZ/+6aNrM4x9brinX3yghtVpDPyueoHOefq7JDFBsKvg7RY/tkGiQgPMr0JE
	7KCmVxcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWcW6-00000005p93-2wJ1;
	Tue, 01 Jul 2025 15:03:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWb3T-00000005W7z-41dX
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 13:29:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 17A3B68AA6; Tue,  1 Jul 2025 15:29:37 +0200 (CEST)
Date: Tue, 1 Jul 2025 15:29:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ben Copeland <ben.copeland@linaro.org>,
	linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk,
	sagi@grimberg.me, iommu@lists.linux.dev,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <20250701132936.GA18807@lst.de>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com> <20250630133343.GA26040@lst.de> <aGLyswGYD6Zai_sI@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGLyswGYD6Zai_sI@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_062948_290342_33523012 
X-CRM114-Status: GOOD (  21.22  )
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

On Mon, Jun 30, 2025 at 02:25:23PM -0600, Keith Busch wrote:
> I think the PRP handling is broken. At the very least, handling the last
> element is wrong if it appears at the end of the list, so I think we
> need something like this:

Yeah.

> But even that, the PRP setup doesn't match the teardown. We're calling
> dma_map_page() on each PRP even if consecutive PRP's came from the same
> dma mapping segment. So even if it had been coalesced, but if the device
> doesn't support SGLs, then it would use the prp unmap path.

Yes, that's broken, and I remember fixing it before.  A little digging
shows that my fixes disappeared between the oct 30 version of Leon's
dma-split branch and the latest one somewhere.  Below is what should
restore it, but at least when forcing my Intel IOMMU down this path it
still has issues with VPTEs already set.  So maybe Bob should not try
it quite yet.  I'll try to get to it, but my availability today and
tomorrow is a bit limited.


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 38be1505dbd9..02bb5cf5db1a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -678,40 +678,55 @@ static void nvme_free_prps(struct request *req)
 	enum dma_data_direction dir = rq_dma_dir(req);
 	int length = iod->total_len;
 	dma_addr_t dma_addr;
-	int i, desc;
+	int prp_len, i, desc;
 	__le64 *prp_list;
+	dma_addr_t dma_start;
 	u32 dma_len;
 
 	dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp1);
-	dma_len = min_t(u32, length,
-		NVME_CTRL_PAGE_SIZE - (dma_addr & (NVME_CTRL_PAGE_SIZE - 1)));
-	length -= dma_len;
+	prp_len = NVME_CTRL_PAGE_SIZE - (dma_addr & (NVME_CTRL_PAGE_SIZE - 1));
+	prp_len = min(length, prp_len);
+	length -= prp_len;
 	if (!length) {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
+		dma_unmap_page(dma_dev, dma_addr, prp_len, dir);
 		return;
 	}
 
+	dma_start = dma_addr;
+	dma_len = prp_len;
+	dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp2);
+
 	if (length <= NVME_CTRL_PAGE_SIZE) {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-		dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp2);
-		dma_unmap_page(dma_dev, dma_addr, length, dir);
-		return;
+		if (dma_addr != dma_start + dma_len) {
+			dma_unmap_page(dma_dev, dma_start, dma_len, dir);
+			dma_start = dma_addr;
+			dma_len = 0;
+		}
+		dma_len += length;
+		goto done;
 	}
 
 	i = 0;
 	desc = 0;
 	prp_list = iod->descriptors[desc];
 	do {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
 		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
 			prp_list = iod->descriptors[++desc];
 			i = 0;
 		}
 
 		dma_addr = le64_to_cpu(prp_list[i++]);
-		dma_len = min(length, NVME_CTRL_PAGE_SIZE);
-		length -= dma_len;
+		if (dma_addr != dma_start + dma_len) {
+			dma_unmap_page(dma_dev, dma_start, dma_len, dir);
+			dma_start = dma_addr;
+			dma_len = 0;
+		}
+		prp_len = min(length, NVME_CTRL_PAGE_SIZE);
+		dma_len += prp_len;
+		length -= prp_len;
 	} while (length);
+done:
+	dma_unmap_page(dma_dev, dma_start, dma_len, dir);
 }
 
 static void nvme_free_sgls(struct request *req)

