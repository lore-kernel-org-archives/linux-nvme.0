Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB3BCD343B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 05:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=r6bRJIiuDx0FbJR48EYNPn25M2
	lNw3RKv6wYLjJWCqUKYwdsWMTn9OzJvgCfdUJI4CAtDG0lAfCTHNF7Uv+UXf49sPTdbk7GHgtUnSr
	fa6DTQSD7gcLLEQVG1tb0tKnTMb4MjWBObb2CnACnyVFDmugKJ0Ff/3Z9Kk+7nnQC5HLgWtyala0B
	PixG0zszC7WOGZpMmvzAmf80jm+7bNx0cm2u72xoE9R6AgY01IZfoGbA3hbkulevfVyR5xam+vgSf
	uXa/SFtHh63Js47WtI3VocMZFgibEwwuo6odUp5bEj4XMx3XtbpIbUfJoxQOO1Iuh1pFH85BI7BMd
	K50A2JhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKrMA-00000002ofe-0E6Q;
	Thu, 07 May 2026 05:33:06 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKrM8-00000002of4-2NR9;
	Thu, 07 May 2026 05:33:04 +0000
Date: Wed, 6 May 2026 22:33:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: fix bio leak on mapping failure
Message-ID: <afwkEIcreethPbGk@infradead.org>
References: <20260506131900.2367091-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506131900.2367091-1-kbusch@meta.com>
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


