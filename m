Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D202AC4708E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4cJRUz2PNxpZaNnFrZTAgq/OfrUNuayCrqNpBAQX3+k=; b=tc2ukKxqqfcxVwdzYc0yYKXbla
	GV62qPTuOKSXIBwZqpT3Z3eay/HZaLs7I2mYQbG0pxLVg4zOLRffVkuJeLUmDQkDDtjy68WKRsxKa
	RGS2q+9NltoG7YTi0g9ass29b8805RSxbb7ji+fMFnTAwAbCm4EmwF+xYn3Oj1TP7YG0oPsuc+TlZ
	NN2Hi8HG545yBe9+iAN/LqDbkSOl1RqQHNaYDiQSFLQFikBFyy05g9hZMCdx61t9WSOLts039kPiV
	PwcTHVPnA9MXngGDhTWWbgg+tDOeJjbgxwXnXhQdqjko/D7TBHnu4fEoomAHfxwifGedo8kPfYerU
	2XiVr1NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Y4b-009g1o-M2; Tue, 06 Dec 2022 13:33:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Y4Z-009g0H-39
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 13:33:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A576E68B05; Tue,  6 Dec 2022 14:33:12 +0100 (CET)
Date: Tue, 6 Dec 2022 14:33:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <pankydev8@gmail.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/9] nvme: use nvme_wait_ready in nvme_shutdown_ctrl
Message-ID: <20221206133312.GA25727@lst.de>
References: <20221129132208.4337-1-hch@lst.de> <20221129132208.4337-3-hch@lst.de> <20221129155718.poqztp4zudt47zmq@quentin> <CGME20221130135758eucas1p2aaf96c2c7bee29c0f44e5714b0b159bc@eucas1p2.samsung.com> <20221130135749.GA4786@lst.de> <fc5d0a74-e4e9-38c7-3a93-ff1eb71e0054@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc5d0a74-e4e9-38c7-3a93-ff1eb71e0054@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_053323_334321_D5319E69 
X-CRM114-Status: GOOD (  11.59  )
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

> One minor nit: I also notice that nvme_wait_ready busy loop sleeps for
> 1~2ms, while the existing shutdown code busy loop sleeps for 100ms. Though,
> I don't think it is an issue.

Thanks, I've added a note about that, and a reference to the commit
that changed from the msleep(100) to the usleep_range for the
enable/disable path.

