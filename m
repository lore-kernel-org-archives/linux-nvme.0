Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77D0C4321E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 08:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W+Eh7AHh/qmenO2TcEwYvdcULPQZUnnxUVce0QlRu9I=; b=G2yZF7XgBe+Qy82b9Z6zREU31w
	r6I4QRXBZT2DTiVuNtK+NrRmIqW/o4TwDhr76QZlhd+0RnLtgjLO/9o55j8ioqB3qI7+iJ7ulhwa3
	5f8I/fLEKWxFElCs7+EQWdhMNGl6gBoKQp5ExZ8OTOG0mQiaZDNlKHscu7a4g7HLa4ZMLZkTa93bl
	eRCh/gsumXATbDJs6ePEwcxCwAKP6lUzIaR7AAJS2CtJQfb5SwsZ268bXlKwEYVmcUZg1G/5FSmYq
	BIyX/eKK8zTAzmupBHYqhAx/ozruh0DZ6p6WY+oi/ZDI+yVmBoudzvh/HEHugwy6qPjCQk/dn2hCU
	7IQk+JVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0IZN-00Eagz-P1; Wed, 30 Nov 2022 08:35:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0IYq-00EaIj-FP
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 08:35:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4475167373; Wed, 30 Nov 2022 09:35:14 +0100 (CET)
Date: Wed, 30 Nov 2022 09:35:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Caleb Sander <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH] nvme: fix (S)RCU protection of nvme_ns_head list
 (alternate)
Message-ID: <20221130083514.GA15442@lst.de>
References: <20221118232756.1457075-1-csander@purestorage.com> <20221124002432.3715594-1-csander@purestorage.com> <20221129083905.GA25314@lst.de> <c3f8ebd7-8da5-a29f-bbc6-f4f893f7ef60@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3f8ebd7-8da5-a29f-bbc6-f4f893f7ef60@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_003520_719326_D318ACBE 
X-CRM114-Status: GOOD (  16.61  )
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

On Wed, Nov 30, 2022 at 10:25:19AM +0200, Sagi Grimberg wrote:
> I understand what you mean in general, but in this particular case
> I don't understand what is not working.

How does this work?

> But, if this is too confusing we can make everything srcu protected
> and be done with it.

To me the original patch looks like correct and reasonable, so I'd
prefer to go with that.  We can then look into optimizing the
SRCU usage later if needed.

