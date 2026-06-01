Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DA7CD5BD1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 07:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=zE1NDVNpRyp/hB43Xre1cIr6rQ
	JSbC8PIibQNnHjGevtH9c7yPhWhlc/ma7+v0LPlaTLNqep6J3GxgOyENosuV8+oKfBdhzUok8zvPh
	OVTK9fW0qwkNvtAap6JL87qhRucPQpycpPqVgRGUpBZCXvTX9zAMsvlo8AyiYgN3jhgXGVKDIUsY3
	GjHb+M1wwffLuhCsP1XLcakFjbp5ov0Jy/BPmBFjHWziBTv6maYiYQb49eN/Z0lvPen4MGljvyOCQ
	zJjfyDr8FeVupBilLfcYTdef3eUHytVmKYwSdp87XocLkBSrw69TcMDEl1e3/BmDMXuS9TsurZZW7
	szlrBJ3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwjR-0000000AH69-03dX;
	Mon, 01 Jun 2026 07:06:41 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwjP-0000000AH5c-0VmO;
	Mon, 01 Jun 2026 07:06:39 +0000
Date: Mon, 1 Jun 2026 00:06:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/2] nvme-tcp: move nvme_tcp_reclassify_socket()
Message-ID: <ah0vf_GLJZ2ZbFsD@infradead.org>
References: <20260530052045.296749-1-shinichiro.kawasaki@wdc.com>
 <20260530052045.296749-2-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530052045.296749-2-shinichiro.kawasaki@wdc.com>
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


