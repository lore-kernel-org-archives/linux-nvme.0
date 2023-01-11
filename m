Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6BFC46467
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jan 2023 04:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+eGO78dS6alY5X7gw/eBrKIrDOWQhzo67KJLqhyBOwQ=; b=ahFDKYrEjRLjTiFKAP9k6W5CDu
	A3RBAzG0EBUcTBPRyPwMj6Pn2pEoLm/cPDMwhkOaDgCTfbbV+bug76kABKHjhl5Jy+w/xWRfa32n2
	oTdOqTaR9wDfGHDfo3IoU4vM5qxnCwWG5edmLFQEnYb7FV9GFLtA20EEt8uUEVd5EATA99OX1oe+/
	Tj45HD6S3rXTE3EAEnRJifTTxHZXk8aUeVOlfgzjqzpA5dMLgyxeJJTmSGbhTl4KbcBAjcg3q+o9j
	rNPKaNpIt45Cz88+hijoIGopEChhp/ENv0FoIZqN62rcCALVFgGWwt1paCPVBzOQPxUd0NrijikCB
	dM9AvxwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFT7x-009bCf-R5; Wed, 11 Jan 2023 04:54:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFT7m-009b9V-QL; Wed, 11 Jan 2023 04:54:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A92C68BEB; Wed, 11 Jan 2023 05:54:03 +0100 (CET)
Date: Wed, 11 Jan 2023 05:54:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Eric Curtin <ecurtin@redhat.com>, Janne Grunau <j@jannau.net>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-apple: Do not try to shut down the controller
 twice
Message-ID: <20230111045402.GB15520@lst.de>
References: <20230111043614.27087-1-marcan@marcan.st> <20230111043614.27087-2-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111043614.27087-2-marcan@marcan.st>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230110_205407_012454_6DF0F9A6 
X-CRM114-Status: GOOD (  15.19  )
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

On Wed, Jan 11, 2023 at 01:36:13PM +0900, Hector Martin wrote:
> The blamed commit stopped explicitly disabling the controller when we do
> a controlled shutdown, but apple_nvme_reset_work was only checking for
> the disable bit before deciding to issue another disable. Check for the
> shutdown state too, to avoid breakage.
> 
> This issue does not affect nvme-pci, since it only issues controller
> shutdowns when the system is actually shutting down anyway.

There's a few other places where nvme-pci does a shutdown like
probe/reset failure and most notably and mostly notably various
power management scenarios.

What path is causing a problem here for nvme-apple?  I fear we're
missing some highler level check here and getting further out of
sync.

