Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC75C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 16:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kCiLQ6D8B+H++sheAqdC6jFFmEMeuBOpYzCwrybZeyU=; b=yUSE5i51OmToqJjeNo21DghNkI
	v9wnOzv36rOBEkCP9+o8pNstFiRr0fDqq+Sg+8Uc8yf8eBNX96cVQAm1brdRffSl51TI4KqWn59AP
	/MFjT0WXh7oCUJwCedeTXpb7k6Pw1evFcaiuJq2p+BM/hbfeekJF19zBkSGREx4Kwofx6QTYmeu0f
	OYZi++5hvXnhxW5WrLWebe/k7STZxclkuMMvsZe6Hp4aJXn5frgRZ4Yi54Va/R2XyvbGF6/shKUom
	o3tlzdKj/nPDwOOGQiF/DyPwMLGHG31h6UvhQFVAXH4QSsQTd7xiCUrkDCOqpPOjAY8x6LW3QXF0T
	+ii0lDpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0Pk7-000M7h-SZ; Wed, 30 Nov 2022 16:15:27 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0Pk5-000M55-Pu
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 16:15:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 25F43B81B4D;
	Wed, 30 Nov 2022 16:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEF2C433C1;
	Wed, 30 Nov 2022 16:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669824921;
	bh=8j57xCWkiHz9AC1wLCSjaYDNWLqAXRsF/C2d9lSaemc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZEWr5/yo4jN6wHYjmF16By7dZPewlB0j7Z+jwmUHQV3RKHjE6fGC7wr2lupDJYbZ
	 J3KeEWRlUObAEK8/Y1UZ3dBGrT1zXX1JU7+rV28LjKMZscRUN+dCs199OXxCHnKNie
	 kNeCZdADWNTtPFBIKz3EVk6RWhvvI1TMPnXgetleWUcG17sMuX3cDzqhUzEK8lNNwF
	 KEIEw0m7nFTaGv7Q5cERgP7ZLsFYeU3Ru21w6goe13YJ2AqUtrGGfkKrYY0qoGLBWH
	 cEiuIy+ZhfaiD61svIkXAyO3LCSWDmdK/44cG8o9BOPq2LPhCjKtbyrtNycoLIc6zT
	 f4plVvAETx/sw==
Date: Wed, 30 Nov 2022 09:15:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <pankydev8@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/9] nvme: use nvme_wait_ready in nvme_shutdown_ctrl
Message-ID: <Y4eBlonMD0198GXr@kbusch-mbp.dhcp.thefacebook.com>
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-3-hch@lst.de>
 <20221129155718.poqztp4zudt47zmq@quentin>
 <CGME20221130135758eucas1p2aaf96c2c7bee29c0f44e5714b0b159bc@eucas1p2.samsung.com>
 <20221130135749.GA4786@lst.de>
 <fc5d0a74-e4e9-38c7-3a93-ff1eb71e0054@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc5d0a74-e4e9-38c7-3a93-ff1eb71e0054@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_081526_009527_757F7C47 
X-CRM114-Status: GOOD (  19.97  )
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

On Wed, Nov 30, 2022 at 03:27:29PM +0100, Pankaj Raghav wrote:
> On 2022-11-30 14:57, Christoph Hellwig wrote:
> > From 2f862232c4428d57dcfdc3b332866a9b2743711d Mon Sep 17 00:00:00 2001
> > From: Christoph Hellwig <hch@lst.de>
> > Date: Wed, 16 Nov 2022 08:54:26 +0100
> > Subject: nvme: use nvme_wait_ready in nvme_shutdown_ctrl
> > 
> > Refactor the code to wait for CSTS state changes so that it can be reused
> > by nvme_shutdown_ctrl.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> One minor nit: I also notice that nvme_wait_ready busy loop sleeps for
> 1~2ms, while the existing shutdown code busy loop sleeps for 100ms. Though,
> I don't think it is an issue.
> 
> Apart from that, the new version looks good to me. Feel free to add to it:

That is indeed a difference, but it's probably a good one. It should
tighten up the time to shutdown more closely to the hardware's
completion, and there's probably some environment where the 10's of
millisecs saved might be meaningful.

