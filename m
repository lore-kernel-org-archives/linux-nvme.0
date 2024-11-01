Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D67E674A3
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2024 04:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DSOpLu8KZm+hOPfSQvK1kLzHmNdBOHeN68aiiWzsBwY=; b=nQ1CBb1KHO6JsHfEOgJplETCk+
	7qqotOFODjJ+kPkTAtw1/Ck1TvcY91mlYomnGVvPDb3YIkhR7WoLcUJ19/7oC9Qxy4dZ2hTdTCVYI
	E3j1H8X2KkVMAx84Bsu7R945uh3Y06ttIDM+c+yvwIwqX/RBuwNAkM8HsWsivxqztdPu2HdiR/iyY
	hAOVL/cUhoxnfagA7G6q++5VkTc7nV9TIhyYt7rQkoCwYKrzpcv54IHk74IMmLeK45/lCbdNFHgVd
	kqbNdbPSpJdbaU7qKX+zD+6XIsLnDT+QSkOd9osuikpWrnPlT80mkCNQgYtrRCJvK0SXtdgutwUpv
	rQrYs9wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6jSQ-00000005lbt-0Oal;
	Fri, 01 Nov 2024 04:40:22 +0000
Received: from 2a02-8389-2341-5b80-5ae8-ad80-e9c6-3f1e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ae8:ad80:e9c6:3f1e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6jSN-00000005lbg-2pBh;
	Fri, 01 Nov 2024 04:40:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: create single-segment HMBs when using IOMMU
Date: Fri,  1 Nov 2024 05:40:03 +0100
Message-ID: <20241101044016.405265-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

NVMe controllers usually have a limit of how many HMB descriptors they
support, and even if they support multiple they usually prefer less of
them.  When running with an IOMMU, the DMA API can coalesce virtually
discontiguous segments, and using the right API doesn't even eat up
vmalloc space for that.

Diffstat:
 pci.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 12 deletions(-)

