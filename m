Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A30C5516E
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 19:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=joufjy/apGCVE+4nEKl82cCBExTx7DXE8UP2G1JaeWU=; b=sAI7ipMIXXGi1qXjY73irlYkRV
	Q5JlKzwkkS7x2skhJ3sIW0xUzBw74Z8oj/fr56wkN8XP7f940RxnkhPdf466qop0zxXKNkTjmnuh6
	X9qUnwkeTi7Gnbmx5wmZj6jfZ9FSjekIbxTDhVsLdmE4Lvp99tVwAX5/S14wmGF7Tt3p9IEoKabrn
	LoJ+VafuS65UyFkqwY2GcwOkPlCXGd8jH/ixPtUL1gFhPUTOH60wa793fEyPXmbcmoJR7zcOYOk7u
	BByE9lmqho50ptp8mV4bo6UqG0DkBBCTltPzKYpXCeM/Ml7Mzsv4JXk8f9dbKdhFtvrGZeA2KhhlL
	UN/r9d+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpWVp-0000000BFpA-3Lbk;
	Thu, 30 Jul 2026 19:33:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpWVo-0000000BFoW-1ewh
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 19:33:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B877540636;
	Thu, 30 Jul 2026 19:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4111B1F000E9;
	Thu, 30 Jul 2026 19:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785440027;
	bh=joufjy/apGCVE+4nEKl82cCBExTx7DXE8UP2G1JaeWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iGtf2ttuPpdBnquWx8cuYyeKcaXnIxqb/gCGc2XsMwrDOAA8rpAKOCZHfebBZH6ah
	 XF/4Co7xzm0Ius+ddZnZy08xn0zBVP2MeChEkll651ksu5RWJI8MJdACCVxxZufcxK
	 ZXiFpRP/J8bikVOBMjh4f0FEoiv6efwJYMTf0Ohww/7eaSqZgSqeyI9IbYn0R6K8iB
	 Y9zRrtVhnuIn3fx8LYiWCxp0W92R8znT3tm6nypDj2LizfdN6ZqRPbRmbxS71VXIRp
	 uITiBZyCQwoTOe+XTP778y7kJLuqaNwjL8MEJ94lhOqk72iT2B18kh2NT7/YIBPy9l
	 1eGPzIzULzN5g==
Date: Thu, 30 Jul 2026 13:33:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Hari Mishal <harimishal1@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: drop WARN_ON_ONCE on write_stream bounds check
Message-ID: <amunGUdPcXuMsFBH@kbusch-mbp>
References: <amfg_OFiyDadWb3v@kbusch-mbp>
 <2026072849-uproar-aqua-07c3@gregkh>
 <20260728051838.GA20593@lst.de>
 <2026072834-buffoon-entwine-ed16@gregkh>
 <20260730114123.GB25956@lst.de>
 <2026073003-primp-granular-c176@gregkh>
 <20260730133726.GA2983@lst.de>
 <2026073049-improper-paparazzi-6be7@gregkh>
 <amtfOzqITuEbYL3g@kbusch-mbp>
 <2026073054-visiting-plural-7eb0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026073054-visiting-plural-7eb0@gregkh>
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

On Thu, Jul 30, 2026 at 05:02:32PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 30, 2026 at 08:27:07AM -0600, Keith Busch wrote:
> > On Thu, Jul 30, 2026 at 04:04:03PM +0200, Greg Kroah-Hartman wrote:
> > > It's only the systems that have panic-on-warn enabled that need to worry
> > > about user-triggered calls to that macro, and those systems know what
> > > they are getting themselves into, including the huge number of CVE fixes
> > > they then need to be responsible for backporting :)
> > 
> > This is a bit of a rug pull. We've long held the pattern that WARN is an
> > appropriate macro for conditions that should never happen, but don't
> > leave the system in an unrecoverable or compromised state. For
> > unrecoverable conditions, use BUG. It has been a valuable tool for
> > debugging and bug reporting.
> 
> Sure, that's fine, just don't have such a path that a user can trigger,
> and all is good.  syzbot has been dealing with this for years, it's not
> a rug-pull at all.

I think we're all on board that the kernel and drivers should fix their
existing WARN's in user triggerable paths to something that doesn't
raise that alarm. It's just that WARN in general can now mean "panic",
and that's concerning with how we're supposed to use it.

