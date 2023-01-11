Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD46C5479D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jan 2023 04:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9JZ0wz7CTzxTiGMuroi1nJZu6AEB2HdsujhTS175WUw=; b=t9yYaOzOydYBtErro5ZVyUr1DT
	IIudToBIeJijDfEK9KGxuIMO9acJTK5s4YvpwNtNtzA5SGapiJQY/CyYlKJ8Ge9DGqDodplM7eKHr
	5766RZrgfA6JStaAI2OoOtaDeHbb64UcdFW2e4aXrB6D2f9kKlimijza9sYaN50pndGMCJTnu0/or
	rLRjdeIIDd+sd8ZwgMVkT4MVygkANHHNY3H2w7LVtodN65B64Dh1Rfb4gD4DzvpeOXvOpfO5Nczfc
	HpjcXfdghqAXNpSApxHz4k20dM4QXVYSf9R6Rzot7x0SYg6401ui+9wXVdci38xdZO5GOapNPokYs
	fGft7Zqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFT4e-009ah3-2l; Wed, 11 Jan 2023 04:50:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFT4P-009af8-EI; Wed, 11 Jan 2023 04:50:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53F5368BEB; Wed, 11 Jan 2023 05:50:32 +0100 (CET)
Date: Wed, 11 Jan 2023 05:50:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Eric Curtin <ecurtin@redhat.com>, Janne Grunau <j@jannau.net>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: Handle shut down controllers during
 initialization
Message-ID: <20230111045032.GA15520@lst.de>
References: <20230111043614.27087-1-marcan@marcan.st> <20230111043614.27087-3-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111043614.27087-3-marcan@marcan.st>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230110_205037_644375_021663B8 
X-CRM114-Status: GOOD (  11.79  )
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

On Wed, Jan 11, 2023 at 01:36:14PM +0900, Hector Martin wrote:
> According to the spec, controllers need an explicit reset to become
> active again after a controller shutdown. Check for this state in
> nvme_enable_ctrl and issue an explicit disable if required, which will
> trigger the required reset.

I don't think this belongs into nvme_enable_ctrl.  It seems like
nvme-apple is missing the equivalent to the nvme_disable_ctrl call
in nvme_pci_configure_admin_queue, though.

