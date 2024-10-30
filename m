Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E49BD6B6B3
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 16:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mk/h8KnNmXQRPRpoeDp3/0UNorjdkIjKwmvKvvqhoYE=; b=LbxS0rP1Y9SfHdDu5BQzEW86j3
	l91Z2JgnA06HYFIW82nkXWItOE7uHM0kd5PO6cothcx4LtftyI0FAJfxMiWok+FnasEqCpTlXnX2Q
	ZMUykGkcwngooB+OgA1dYsttpz92JDgTi3oRtxkD4go2RPRsp9i9fmzpAsg5lsWR6C1s6Crt4M+tL
	C6lIREK15NHjzo8ezCUCtnKP4HsInL4eZUVFO/8BdPnW0fvqV4aaf1MOhnnlInRLhbUCD7yb+GaNV
	UUVi1d7v2g1rAPjVt9tu1byjCgCnKRPkeuLhTpTms3IDBzTnPPwKfo9RSWQa17cbBdEujaRzobgOc
	uSicvtAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6C0X-0000000194A-2rkj;
	Wed, 30 Oct 2024 16:57:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6C0U-0000000191Z-0Smv
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 16:57:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3A309227A8E; Wed, 30 Oct 2024 17:57:09 +0100 (CET)
Date: Wed, 30 Oct 2024 17:57:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <20241030165708.GA11009@lst.de>
References: <20241029153702.GA27545@lst.de> <ZyEBhOoDHKJs4EEY@kbusch-mbp> <20241029155330.GA27856@lst.de> <ZyEL4FOBMr4H8DGM@kbusch-mbp> <20241030045526.GA32385@lst.de> <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com> <20241030154556.GA4449@lst.de> <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com> <20241030155052.GA4984@lst.de> <ZyJiEwZwjevelmW2@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyJiEwZwjevelmW2@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_095718_316215_623D57FF 
X-CRM114-Status: GOOD (  24.23  )
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

On Wed, Oct 30, 2024 at 10:42:59AM -0600, Keith Busch wrote:
> On Wed, Oct 30, 2024 at 04:50:52PM +0100, Christoph Hellwig wrote:
> > On Wed, Oct 30, 2024 at 09:48:39AM -0600, Keith Busch wrote:
> > > What??? You said to map the temperature hints to a write stream. The
> > > driver offers that here. But you specifically don't want that? I'm so
> > > confused.
> > 
> > In bdev/fops.c (or file systems if they want to do that) not down in the
> > driver forced down everyones throat.  Which was the whole point of the
> > discussion that we're running in circles here.
> 
> That makes no sense. A change completely isolated to a driver isn't
> forcing anything on anyone. It's the upper layers that's forcing this
> down, whether the driver uses it or not: the hints are already getting
> to the driver, but the driver currently doesn't use it.

And once it uses by default, taking it away will have someone scream
regresion, because we're not taking it away form that super special
use case.

> Here's something recent from rocksdb developers running ycsb worklada
> benchmark. The filesystem used is XFS.

Thanks for finally putting something up.

> It sets temperature hints for different SST levels, which already
> happens today. The last data point made some minor changes with
> level-to-hint mapping.

Do you have a pointer to the changes?

> Without FDP:
> 
> WAF:        2.72
> IOPS:       1465
> READ LAT:   2681us
> UPDATE LAT: 3115us
> 
> With FDP (rocksdb unmodified):
> 
> WAF:        2.26
> IOPS:       1473
> READ LAT:   2415us
> UPDATE LAT: 2807us
> 
> With FDP (with some minor rocksdb changes):
> 
> WAF:        1.67
> IOPS:       1547
> READ LAT:   1978us
> UPDATE LAT: 2267us

Compared to the Numbers Hans presented at Plumbers for the Zoned XFS code,
which should work just fine with FDP IFF we exposed real write streams,
which roughly double read nad wirte IOPS and reduce the WAF to almost
1 this doesn't look too spectacular to be honest, but it sure it something.

I just wish we could get the real infraѕtructure instead of some band
aid, which makes it really hard to expose the real thing because now
it's been taken up and directly wired to a UAPI.
one

