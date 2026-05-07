Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8968CD3427
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 05:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=mLidg82lVltC/v1nyZddfoNMzn
	sTvv1W1G3OcH8Dr2FxB1PGB/6ZNR0jCnNH07gQQR/SHQFRC+Wu4A1w85LFkPMmQg+2D1hByoOrYNA
	Yk+wIBU2lthkcUdARfJzFZb+LaW5dku+O0B5jQAFRNO6YAX2hNBAZ9cONiEs4Pxsi0lQ5MjKtuV5n
	WFY/XDRvobAPfrhuuFvqC1ThOm/s9Epbtr8rDnau4ReJMnqCGLJkvy6PywxH+e/XsHPRsYQGoOn6J
	HWFwAZapAhtthMbVg1p5JjCJnwn2OWNP/2VulWC1q4jwnqcxDqNuS4ibjf/qmaUtifuBbdki/rwKU
	WfJ6Qntw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKrLh-00000002oYj-3s6h;
	Thu, 07 May 2026 05:32:37 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKrLg-00000002oYW-2g2P;
	Thu, 07 May 2026 05:32:36 +0000
Date: Wed, 6 May 2026 22:32:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, me@alancui.cc,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: make prp passthrough usage less scary
Message-ID: <afwj9CNKfpvnEKTE@infradead.org>
References: <20260506131839.2364791-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506131839.2364791-1-kbusch@meta.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

