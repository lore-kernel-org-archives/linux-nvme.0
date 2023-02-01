Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D840C05027
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 13:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lsy9K5NFAda7MQAC4/uMyCagRtBadcZcXPFHN+mvW3U=; b=Iw4fWQmiQyN5Wc00xHYAfNDn6D
	XqR8wM3VRbdUWT7D1P038pVBVwEJfpry/Jd7eCJiY93c/oMNKvE7gq1UxyLYT5fgtBgT/KDcX9spT
	NSus8HwShe3kSphNIOxDqqci7POMmabbo4AYkYzChXD4R41bmEuf0HRix6Gb1bLfS2KdVc39KQz+E
	qQi/inLbRPXyCZN7LtipLnf5li6nT3sjUEAMiZXhYCIizyZCH2n/O6NLlIze1o8S1ku2WGPQH8nhe
	/+GlhZNERUBn/fzs6IuyOQA/hkPClvGSqLm2QRUrXWu7Fjs7A5Dw2KO6N93TyyHLiGc7zIR3vELUx
	xnctMNWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pND33-00C1DL-L6; Wed, 01 Feb 2023 13:21:13 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pND31-00C1Cf-Uq; Wed, 01 Feb 2023 13:21:11 +0000
Date: Wed, 1 Feb 2023 05:21:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Daniel Wagner <dwagner@suse.de>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] nvme-auth: use workqueue dedicated to authentication
 works
Message-ID: <Y9pnR0KdoIbNBq8M@infradead.org>
References: <20230131092644.1428477-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131092644.1428477-1-shinichiro.kawasaki@wdc.com>
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

Thanks,

applied to nvme-6.2.

