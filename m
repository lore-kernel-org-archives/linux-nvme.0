Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA72C54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 10:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SET5l6+2vj+Tj4Xkz4PD7tySehPE670HRnw2/3E9SCg=; b=4nbNfrzy5ddwvsU0hNIUFzeZTk
	5oCHSG8PMV9lBhRC1yy5JhZULe7bX/YRMyLq4gYFwJIU5iiDttQLKLvFEOWKJac8XfE7AFY1P1NNX
	AtleQP9o4gK1cVNzuR1zGkjQC0A3h/n2w1VqowL0ORrRKdQki5aDGx6xlaykc//NjR1/IO8QQBg8L
	ZIyARLfmd5LFnV5S17vRy1uOoEzTYaiwbwx6YuKSnLOpPi38I4ORAIv4Io4r9Bd5rGeseAvWt32Hy
	HCZ3F7SYTMasszpXagTeq1LKAqOH+YCGOYDe4f205aIC4Ok1+2nuEv6RDoX0pwHd/hAWU2GUj+0V6
	OdpA1NbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMR2u-003395-0H; Mon, 30 Jan 2023 10:05:52 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMR2o-00338W-PV; Mon, 30 Jan 2023 10:05:46 +0000
Date: Mon, 30 Jan 2023 02:05:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix potential invalid pointer dereference
Message-ID: <Y9eWenmquvfp6UwI@infradead.org>
References: <20230127154237.349113-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127154237.349113-1-mlombard@redhat.com>
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

nvme_alloc_io_tag_set needs the same fix.

