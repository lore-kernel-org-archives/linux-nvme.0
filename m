Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB417C55160
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 13:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WHfxDXQIRYn7LAtuINReoYseo7byYMKWWI7ySQ/PUgI=; b=mpheRjjmo1FnqMIILKF6aKjLHS
	0AHUxI+dfN8jz2ONH6HG1pMXAhBUQ/Pssm99rwFfUrYOLdUWsqLPasKBp7XkzgNEQCpGD+Wxw5hyJ
	t4Fxoe0vUmGpmO6fE4j40tPO33RK2BtsZfM3n7MQiecWDhOMsfzwQrkNIlYtm0sLNF/EiZ6hTY9Kn
	XW/zIoSQwXHnF92YYvpoHOiXb+SAGSMoJszB3xXHIZfr1ymAW7l7R9zLuDmTMTnUPW2Ila0MKWiKe
	zLv+jePy/FnFpIJgbXSQNGeRffLjvyZX6IRBtP46Ueb0Z3d5G5xfSyXGFuWMiDM5GrLOlUuzMjB4C
	x14vKCyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpQx7-0000000Ad9D-2TDN;
	Thu, 30 Jul 2026 13:37:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpQx4-0000000Ad8S-0f4C
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 13:37:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2BB0468BFE; Thu, 30 Jul 2026 15:37:27 +0200 (CEST)
Date: Thu, 30 Jul 2026 15:37:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Hari Mishal <harimishal1@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: drop WARN_ON_ONCE on write_stream bounds
 check
Message-ID: <20260730133726.GA2983@lst.de>
References: <20260725135111.14041-1-harimishal1@gmail.com> <20260725135111.14041-3-harimishal1@gmail.com> <amdqKEI44SKwq-K2@kbusch-mbp> <2026072748-unpopular-onlooker-4a2b@gregkh> <amfg_OFiyDadWb3v@kbusch-mbp> <2026072849-uproar-aqua-07c3@gregkh> <20260728051838.GA20593@lst.de> <2026072834-buffoon-entwine-ed16@gregkh> <20260730114123.GB25956@lst.de> <2026073003-primp-granular-c176@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026073003-primp-granular-c176@gregkh>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_063734_350581_1448A68C 
X-CRM114-Status: GOOD (  25.86  )
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

On Thu, Jul 30, 2026 at 03:18:21PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 30, 2026 at 01:41:23PM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 28, 2026 at 08:58:00AM +0200, Greg Kroah-Hartman wrote:
> > [... monster quote mostly dropped, please stick mail netiquette]
> > > > but a debug setup you get what you pay for, and I'm really tired of
> > > > all these totally stupid attempts to make WARN_ON the new BUG_ON.
> > > > It is not, and that's for a reason.
> > > 
> > > I'm tired of it too, but again, if this can be hit by something a user
> > > does, it ends up being a DoS on the machine :(
> > 
> > So let's kill parnic_on_warn?  Or tain the kernel when it is set so
> > that anyone enaling it knows they have to keep the pieces when it
> > breaks?
> 
> I know why the cloud-boxes want panic-on-warn enabled, as they are
> cattle and want any potential problem to just reboot the box and keep on
> going.  And Samsung likes it for their billions of devices for the same
> reason (it's "safe" to reboot a phone I guess...)
> 
> So as much as I would _love_ to drop it, we seem to have real users.

Then at least add a taint to make it clear to them that they are
getting themselves into trouble instead of trying taking the only
useful debug tool away because of bad choices of a few.


