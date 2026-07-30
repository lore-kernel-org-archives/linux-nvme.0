Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94162C55162
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 14:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sc9xPAqFWs3rxpzHpDrswg/F94fu2SpvgRmyO3t56CM=; b=Zys/LaOt58jy2n1deegwQsILmL
	Po1tLNLcIbN8fq9HQ3iGM17cnREpZHnlgmv73bhdd+EJIt44Vc/srCq21wr1wgtyk4TNUsha75/Lw
	h7dyr/CAEXRygnuhpu2sLMCYOBifov6yxPXsWZjrZEPdN5jLfgtYs+GE9lhQ3nA1PUW3cT+P1J3pS
	96wWMGqVtJ6Wo5Qvu7naK5PFEQUPBq7U+XksOKUUMTldeBhJDqSXLrsjhAzg8BfYjqzjdNJSEoJry
	fPFRg88mestdJHZdnzQdSBBB4ZIHNQsyiWuJfDikb9y6mrK2di6Zlvm/lVOWTXl4Zhu3kTzmUsVUf
	YiEUJbDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpRMx-0000000AhHZ-3Kei;
	Thu, 30 Jul 2026 14:04:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpRMw-0000000AhGv-2YfD
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 14:04:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E4978418C6;
	Thu, 30 Jul 2026 14:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492C81F000E9;
	Thu, 30 Jul 2026 14:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785420257;
	bh=Sc9xPAqFWs3rxpzHpDrswg/F94fu2SpvgRmyO3t56CM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A9kppZGM7MB3y8nY4TySZN28Z4Ci/r9XB5Tx5JRC+aUN3yEFxeig8wLrOhhOviS/F
	 HSSC3bJyoYiucxnE+h8iJL/KshDdj/5PYEVGRHZGyLG3R6NaekOrea8X2GchKaQALx
	 DsncTL+WW6EGLxNHf3wt7Ln93wOoaOVEULqCTvI0=
Date: Thu, 30 Jul 2026 16:04:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Hari Mishal <harimishal1@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: drop WARN_ON_ONCE on write_stream bounds check
Message-ID: <2026073049-improper-paparazzi-6be7@gregkh>
References: <20260725135111.14041-3-harimishal1@gmail.com>
 <amdqKEI44SKwq-K2@kbusch-mbp>
 <2026072748-unpopular-onlooker-4a2b@gregkh>
 <amfg_OFiyDadWb3v@kbusch-mbp>
 <2026072849-uproar-aqua-07c3@gregkh>
 <20260728051838.GA20593@lst.de>
 <2026072834-buffoon-entwine-ed16@gregkh>
 <20260730114123.GB25956@lst.de>
 <2026073003-primp-granular-c176@gregkh>
 <20260730133726.GA2983@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730133726.GA2983@lst.de>
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

On Thu, Jul 30, 2026 at 03:37:26PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 30, 2026 at 03:18:21PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jul 30, 2026 at 01:41:23PM +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 28, 2026 at 08:58:00AM +0200, Greg Kroah-Hartman wrote:
> > > [... monster quote mostly dropped, please stick mail netiquette]
> > > > > but a debug setup you get what you pay for, and I'm really tired of
> > > > > all these totally stupid attempts to make WARN_ON the new BUG_ON.
> > > > > It is not, and that's for a reason.
> > > > 
> > > > I'm tired of it too, but again, if this can be hit by something a user
> > > > does, it ends up being a DoS on the machine :(
> > > 
> > > So let's kill parnic_on_warn?  Or tain the kernel when it is set so
> > > that anyone enaling it knows they have to keep the pieces when it
> > > breaks?
> > 
> > I know why the cloud-boxes want panic-on-warn enabled, as they are
> > cattle and want any potential problem to just reboot the box and keep on
> > going.  And Samsung likes it for their billions of devices for the same
> > reason (it's "safe" to reboot a phone I guess...)
> > 
> > So as much as I would _love_ to drop it, we seem to have real users.
> 
> Then at least add a taint to make it clear to them that they are
> getting themselves into trouble instead of trying taking the only
> useful debug tool away because of bad choices of a few.
> 

syzbot has this same issue, if it ever hits a WARN() output, it stops
and spits out a report.  See the long thread on linux-next about this
right now for a more recent discussion about this.

As for a taint, I'm not sure what you are asking here.  If panic-on-warn
is not enabled, wonderful, a WARN() will spit out a great debugging
message and everyone moves on just fine.

It's only the systems that have panic-on-warn enabled that need to worry
about user-triggered calls to that macro, and those systems know what
they are getting themselves into, including the huge number of CVE fixes
they then need to be responsible for backporting :)

thanks,

greg k-h

