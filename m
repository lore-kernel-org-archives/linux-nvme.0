Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7BDC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:31:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0461D64D9D
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0461D64D9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Sm5sWCAs7M2POa1KQkH57nEqnFhHbylhEjokBCRpPq4=; b=iPlIdajl+k0cz8sefWbjLpj01
	8oQVImbQnEQ3R0XN8smyT7VJd4ljZYE+kESpMt9Y7rJAyAXKK1QVkBSTZRx7s68bIyUHiRAs6CZ8L
	P1Bv4lNNwPGNBvrKr+qY5gkzeCha26wTJJvImQxRkDZIbCbnrj6pqcT4F3VwAl6mxfSsolnvfgufO
	Tw8n1Db1ANpTV+z1bNePFjDVCnmfVbzjQXkCA6CfeDnRQIPPMQIkb1T7Th2leuRT9iwthip1lD2fs
	IelqlApnEKAqd2IrYNXudCGpyIKQAgEx9MNj/O20cY6l8aL6dZS/osIkAeaMG7MrRjXEwxqrFvFZ9
	cLQiv3fnw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7kLU-0008HD-4s; Thu, 04 Feb 2021 19:31:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7kLC-00087n-GB
 for linux-nvme@merlin.infradead.org; Thu, 04 Feb 2021 19:30:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=x8//hYqo7QA5J7KlPRIBWxIN1r3dqOW8pvcBjP4fgD4=; b=r+U9drErryzVNsxBhwiFC41lgS
 bFPlFHhFQgdb4jr/6PDIirPBkDjDUOMM9gFGsTolsd6iRt08CPyO2QWcXYlAZq/UwcbKoEfIsCQRS
 0OLDGd8cHz/VSGHSw6CMhi8/jDazIBFGnUczpv/XSuHrHxhbulyE51bja5unjR1Hnpu6m6KLtOjfI
 hOlJPKMAXqvA/5H43JF1glAY0iDhL79dKokYdu2FP0skudyOZ05fwC3EaKSr9YM90BDVrjT5zaPc+
 4R5yYyk0j0fkvNXwreM1IdeqR5qakaw4/OnNZ1nuP7iOy/pbp1uCCTjS2+xBP5tP8Xh5ocSPFLBZE
 bUOI2cVw==;
Received: from [2001:4bb8:184:7d04:e998:f47:b9fb:7611] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l7kLA-001Jjb-KK; Thu, 04 Feb 2021 19:30:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com,
	gregkh@linuxfoundation.org
Subject: [PATCH 8/8] nvme-pci: set min_align_mask
Date: Thu,  4 Feb 2021 20:30:35 +0100
Message-Id: <20210204193035.2606838-9-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210204193035.2606838-1-hch@lst.de>
References: <20210204193035.2606838-1-hch@lst.de>
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
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org,
 iommu@lists.linux-foundation.org, erdemaktas@google.com, robin.murphy@arm.com,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Jianxiong Gao <jxgao@google.com>

The PRP addressing scheme requires all PRP entries except for the
first one to have a zero offset into the NVMe controller pages (which
can be different from the Linux PAGE_SIZE).  Use the min_align_mask
device parameter to ensure that swiotlb does not change the address
of the buffer modulo the device page size to ensure that the PRPs
won't be malformed.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 81e6389b204205..5d194b4e814719 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2629,6 +2629,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 * Don't limit the IOMMU merged segment size.
 	 */
 	dma_set_max_seg_size(dev->dev, 0xffffffff);
+	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
 
 	mutex_unlock(&dev->shutdown_lock);
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
