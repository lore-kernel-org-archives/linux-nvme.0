Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F9DD6B6AD
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 16:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jn4xkdoYTKb+we8aqBa9HhYsA5LP6TAhgFUd855Di9I=; b=rT5rroa13Tzf4PhdeJLVaxuhuF
	VKWHCrjmM7INWetWXM9f2owiC5V1N4qlD1Iy2Sh9sYOFPxIGTFNO0fpweEbAsQp/h6ZyZggE2hBGp
	DM6n04Fbf5NhuoxBWkTGFq2CKzjzTZEuM2R/RxFs9Xlrbyd4RQtKF0GP1BhG+uvuaIZzkplm5SfoH
	vRb2VDdNGJ4Cw3PmRY4yiwa0oYR5qCpeMj3hA5AbGmkH7pwR5+dNLp5Lssx5tUkpdIbFb0XSEMHBE
	KVNreXJWU3VPeiTFBTacvpTThSi2W/fTPMkO5JJdvx2B8woXUN2ws8Edz4+IrgbKf9sFNRr2y28x2
	ErnZN/Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6BoA-000000016so-2eh7;
	Wed, 30 Oct 2024 16:44:34 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Bmh-000000016h6-1X94
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 16:43:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D6C4A5C4D95;
	Wed, 30 Oct 2024 16:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3BBC4CECE;
	Wed, 30 Oct 2024 16:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730306582;
	bh=1/0dSTf4yF624Y/P59xZdCMBVZftwYRQ9Iep0UZhrRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7CnMtXJfg2XLopB7x6q6w/5J3eSeCRzh/JZL9VoA35bCquYGOAVG5jWkAnGrICOY
	 if+jiAhMTec1qdXOp6MhI1zuJOxJMlzM1zTfX0xF/9tAE2hO+sweXnXojynSxYWzZS
	 wDQKbWZI0CNQtEl4kujHFm++/2ynpKrD2aQ4CXwenL8sWP8j4HdXwrbQ6BsWZMMbBh
	 4aos8zVS/b2cJ1/T/iTut+hAG02y6JSty0iLhTiRODcKqeXwQWz147rEpbQvb0T0Q4
	 SHj+SgE0YRXOc4KjPdFRUuRayLBW68UKSM07cUh+btmCCm6RF5JVb/Vi/U2mIyQ2XY
	 Y5cfovAZjagTA==
Date: Wed, 30 Oct 2024 10:42:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <ZyJiEwZwjevelmW2@kbusch-mbp.dhcp.thefacebook.com>
References: <ZyEAb-zgvBlzZiaQ@kbusch-mbp>
 <20241029153702.GA27545@lst.de>
 <ZyEBhOoDHKJs4EEY@kbusch-mbp>
 <20241029155330.GA27856@lst.de>
 <ZyEL4FOBMr4H8DGM@kbusch-mbp>
 <20241030045526.GA32385@lst.de>
 <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com>
 <20241030154556.GA4449@lst.de>
 <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com>
 <20241030155052.GA4984@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030155052.GA4984@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_094303_471060_20033EF0 
X-CRM114-Status: GOOD (  18.86  )
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

On Wed, Oct 30, 2024 at 04:50:52PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 30, 2024 at 09:48:39AM -0600, Keith Busch wrote:
> > What??? You said to map the temperature hints to a write stream. The
> > driver offers that here. But you specifically don't want that? I'm so
> > confused.
> 
> In bdev/fops.c (or file systems if they want to do that) not down in the
> driver forced down everyones throat.  Which was the whole point of the
> discussion that we're running in circles here.

That makes no sense. A change completely isolated to a driver isn't
forcing anything on anyone. It's the upper layers that's forcing this
down, whether the driver uses it or not: the hints are already getting
to the driver, but the driver currently doesn't use it. Finding a way to
use them is not some force to be demonized...

> > > with no way to make actually useful use of the stream separation.
> > 
> > Have you tried it? The people who actually do easily demonstrate it is
> > in fact very useful.
> 
> While I've read the claim multiple times, I've not actually seen any
> numbers.

Here's something recent from rocksdb developers running ycsb worklada
benchmark. The filesystem used is XFS.

It sets temperature hints for different SST levels, which already
happens today. The last data point made some minor changes with
level-to-hint mapping.

Without FDP:

WAF:        2.72
IOPS:       1465
READ LAT:   2681us
UPDATE LAT: 3115us

With FDP (rocksdb unmodified):

WAF:        2.26
IOPS:       1473
READ LAT:   2415us
UPDATE LAT: 2807us

With FDP (with some minor rocksdb changes):

WAF:        1.67
IOPS:       1547
READ LAT:   1978us
UPDATE LAT: 2267us

