Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2B7C55160
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hOAvUC518EXALy6zl7jVlRaNZkP1D+eSt8w9CZxi8xU=; b=cF2Frr8ORmnc3PkqATIvAzS/v1
	MW5uSyRvyhfEFgV50sVBGyod8M3jc8ftJB8kUOJoFpnYpeOk3dVHQadKHsJMw48uwkFSAldbITM7D
	yYlJ0uD/mISZwoVMjCWLfqQdS5fny1gXV7StK/qOXd47c2ZnmgPPwm3e5e0IAMjvb15ra6TLRi7Qq
	Go9QCx68L7dUHHgh0k9+mua+nQFJzo1FhYTS2d7ZGn+ZpTjjQ9WLLCZIcwPKsqJ87tISCoQZ/UeEa
	SCKIDGvoq4hJkwppLAkbYM2fP8JgwVI8I2DPBvYaXtr9tdU59rlI/oW2X2FjoQidB7m/I7c9fE3Jl
	peZkW1zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpQgf-0000000AZrE-2x5p;
	Thu, 30 Jul 2026 13:20:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpQge-0000000AZr2-3fsO
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 13:20:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4973860A5A;
	Thu, 30 Jul 2026 13:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D961F000E9;
	Thu, 30 Jul 2026 13:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785417636;
	bh=hOAvUC518EXALy6zl7jVlRaNZkP1D+eSt8w9CZxi8xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KqMI/6DguEU6rNvtLKmdLaxFImzjbizwvDDu/hMkpM4ezOPzsGpe5jMk7njbrw+HH
	 fTVd0kfPeJukJ0eaMRM+mYrljDwP5rBCKUJj0Mqf7kvxBGFXte4PBmLLEu1VTJLhU2
	 Voo4LVK8lPlFv2Ht+mUN8IdodDvPJTwTIn4HAlLw=
Date: Thu, 30 Jul 2026 15:18:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Hari Mishal <harimishal1@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: drop WARN_ON_ONCE on write_stream bounds check
Message-ID: <2026073003-primp-granular-c176@gregkh>
References: <20260725135111.14041-1-harimishal1@gmail.com>
 <20260725135111.14041-3-harimishal1@gmail.com>
 <amdqKEI44SKwq-K2@kbusch-mbp>
 <2026072748-unpopular-onlooker-4a2b@gregkh>
 <amfg_OFiyDadWb3v@kbusch-mbp>
 <2026072849-uproar-aqua-07c3@gregkh>
 <20260728051838.GA20593@lst.de>
 <2026072834-buffoon-entwine-ed16@gregkh>
 <20260730114123.GB25956@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730114123.GB25956@lst.de>
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

On Thu, Jul 30, 2026 at 01:41:23PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 28, 2026 at 08:58:00AM +0200, Greg Kroah-Hartman wrote:
> [... monster quote mostly dropped, please stick mail netiquette]
> > > but a debug setup you get what you pay for, and I'm really tired of
> > > all these totally stupid attempts to make WARN_ON the new BUG_ON.
> > > It is not, and that's for a reason.
> > 
> > I'm tired of it too, but again, if this can be hit by something a user
> > does, it ends up being a DoS on the machine :(
> 
> So let's kill parnic_on_warn?  Or tain the kernel when it is set so
> that anyone enaling it knows they have to keep the pieces when it
> breaks?

I know why the cloud-boxes want panic-on-warn enabled, as they are
cattle and want any potential problem to just reboot the box and keep on
going.  And Samsung likes it for their billions of devices for the same
reason (it's "safe" to reboot a phone I guess...)

So as much as I would _love_ to drop it, we seem to have real users.

sorry,

greg k-h

