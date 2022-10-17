Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31852C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 07:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ud+P59sc6r2ta7ftz9Zh/MeV3JzHkeKKA5V0O2TR/Rc=; b=3AvPs7xNeIMu9sVn5xuvlwCgru
	crrjYmrNbQFnYDISar1VbjY1s9EwccEokFmeCrHzr/UpjxL1xnYEJTKXEUs2ZWolSuDd91uhQLVAM
	8GfMnU16SvYROBiL3EmSOEz3yjLMySjuO4rHidQpJt6VOFhWp6mI519zsoIXY0khix++qC49b3Clg
	dcBdwbkO2LefMEGuWqN0PxclKEnhphXVhxL6v3XlsW4GUwG8y+nfCrn+mA/xWMuSwE+WptfMloz+e
	ZODnsaC2fZs6Q4JbPljpX022ImsfQ3knmH7hO39lNuGnytoeAG4XEXnqxulJflX0Hoj+q7DGVjLYc
	bH+v7rrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okKR4-008QYF-LR; Mon, 17 Oct 2022 07:21:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okKQe-008QJv-T7; Mon, 17 Oct 2022 07:20:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B42768C7B; Mon, 17 Oct 2022 09:20:50 +0200 (CEST)
Date: Mon, 17 Oct 2022 09:20:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-apple: fix DMA-API warning
Message-ID: <20221017072049.GD30661@lst.de>
References: <E1oiaBa-00Dz7S-SK@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1oiaBa-00Dz7S-SK@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_002053_116219_6701180D 
X-CRM114-Status: UNSURE (   8.06  )
X-CRM114-Notice: Please train this message.
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

Thanks, applied with a rewritten commit message and a Fixes tag.

