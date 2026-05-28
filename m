Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5D8CD5BD1
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 08:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sZ5OvIZO8GVzCbj5Yu5+ty6E0NrjHzB6Ox3bXueRGX8=; b=DMnMiMp6jdq7Tn6m+sFN0+2FMZ
	sUJ3O1ZSoqMiMPY1XgyAbfSFhJVbTiFNhrk2xMhJcu0iVfZfabbKUcVywAvvjltRuDu9pVF/Stitd
	XkAd6h3IME9hG0fDJx197Pqb0MLul9KJ/RY07EDDHAaGksxF0iSmpP7xuk0BHAap90jZ5JSVClkoX
	1XRqyJJe3AuYbJTNA3LUxgFaLCiYjZ9YJAG1eQuqgsNeIhZ83szAg/NYLC0Fm9Gb7nEAy7hkR/avO
	YjT4tZcBD99FJd7ovSh9HSju1YwOthjsaAPnL4z3QtxNteX7NpUR1bBkII0xMrYT4YqIyMWtkgLJt
	8hoaKoOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSWLy-00000005QF1-0pPC;
	Thu, 28 May 2026 08:44:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSWLv-00000005QEK-1NDG
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 08:44:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B70E068C4E; Thu, 28 May 2026 10:44:28 +0200 (CEST)
Date: Thu, 28 May 2026 10:44:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, guzebing <guzebing1612@gmail.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Guzebing <guzebing@bytedance.com>
Subject: Re: [RFC PATCH 0/1] nvme-pci: detect I/O queue depth changes after
 reset
Message-ID: <20260528084428.GA8248@lst.de>
References: <20260527075320.3178600-1-guzebing1612@gmail.com> <20260527131951.GA11071@lst.de> <ahewZiV3n6qG1Jhm@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahewZiV3n6qG1Jhm@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_014431_507743_98200E1E 
X-CRM114-Status: GOOD (  17.41  )
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

On Wed, May 27, 2026 at 09:03:02PM -0600, Keith Busch wrote:
> On Wed, May 27, 2026 at 03:19:51PM +0200, Christoph Hellwig wrote:
> > On Wed, May 27, 2026 at 03:53:19PM +0800, guzebing wrote:
> > > This RFC instead takes the smaller approach of detecting the reset-time
> > > CAP.MQES change and making it visible.  If the live I/O queue depth
> > > shrinks, reset recovery is failed before recreating I/O queues.  If it
> > > grows, the driver warns and continues with the existing queue resources.
> > 
> > Unlike the other version this at least sounds doable without creating
> > a complete mess.  So if we can live with this version that'd make me
> > much happier.
> 
> Abandoning the device here sounds pretty harsh when blk-mq already
> supports user space decreasing the q-depth on a live queue. Why can't
> the driver do the same thing?

Reducing capabilities with a firmware upgrade is a losing proposition,
there's just way too many things that can go wrong.

And reducing the queue depth is one of the haіriest operation in
blk-mq.  I wish we had never supported it, but allowing it with a
remove trigger sounds really bad.

