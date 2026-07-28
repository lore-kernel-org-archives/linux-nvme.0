Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED26C53219
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 09:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vc3jXUM2W6zu7lnqk439F+rCtZE+woy4zZvXECQwmSs=; b=Tjcqi07mTXXmj/mwrGyDgwT4xQ
	p5LETENU9DTQD9kLQGN/HbWRnmcJspbdv/FmMoH8TIWIG4idgh2zBZ58sEdayghRsBGKmxuSeogaa
	FfouZ2KquHEU88hCIMJsNHYIvOOHxa3c7E1FYLCRtv6CX4rWteoS6zz1cq6SAS7AeKr8eayNEkk21
	+4780cDlin+xIwvdqmlMvOfjNbrutAxr+cl+ddBopOHb8pnYNA2jblhVofuGIZZ/W4Jbj6BhB8YF+
	g9y8zaayLYdloZyRYsFWdXrgEIQSPRhSA2/T/OxZsoKNCZtmTMhTKju1e+GdqrJ4DTfRKfM/8w9Ub
	SiirNlag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woeOl-00000004s8Q-3u5u;
	Tue, 28 Jul 2026 09:46:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woeOi-00000004s5f-2mnB
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 09:46:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 316C540B8B;
	Tue, 28 Jul 2026 09:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4F21F00A3A;
	Tue, 28 Jul 2026 09:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785232012;
	bh=Vc3jXUM2W6zu7lnqk439F+rCtZE+woy4zZvXECQwmSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kzbH5b++P56dBT9OomdhoXkuWXNgUq9124nIITIO00UmO7d2kz/WodyPnoPMk6ahB
	 JsuTB9mB6kRm6F3TvdesP5Us5SMIfrYqzA9QAbDWhSYcFR3XLI7UvaSITWSMyuMY9l
	 bJoVX/SBjrcu51PRfqHsMsnMCFmxzyyLaY0V7cTcDBoCZFXDRtoC9jpyxoJuOMsH6D
	 UouqB9g/Ua4peA+ENAVqueOWV18YEbIsFtcBNa9lQWAVjAzIgxB9qqU6BfP0Al1BVt
	 w094FNuSvXVRctHB2d2oANXXNcxIOS+iWvTz2ynQ9obJsPoZsjjxgl1+kXZXO6gXgy
	 o4bRA90hu6nFg==
Date: Tue, 28 Jul 2026 03:46:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Hari Mishal <harimishal1@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: drop WARN_ON_ONCE on write_stream bounds check
Message-ID: <amh6ivxaXV9lO_6r@kbusch-mbp>
References: <20260725135111.14041-1-harimishal1@gmail.com>
 <20260725135111.14041-3-harimishal1@gmail.com>
 <amdqKEI44SKwq-K2@kbusch-mbp>
 <2026072748-unpopular-onlooker-4a2b@gregkh>
 <amfg_OFiyDadWb3v@kbusch-mbp>
 <2026072849-uproar-aqua-07c3@gregkh>
 <20260728051838.GA20593@lst.de>
 <2026072834-buffoon-entwine-ed16@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026072834-buffoon-entwine-ed16@gregkh>
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

On Tue, Jul 28, 2026 at 08:58:00AM +0200, Greg Kroah-Hartman wrote:
> I'm tired of it too, but again, if this can be hit by something a user
> does, it ends up being a DoS on the machine :(

Why do you think has something to do with what a user does? The
filesystem and block layers own the write stream, and the contract is it
has to be within the reported limits. If it's not, there's a filesystem
bug; nothing to do with the user.

