Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20265C55162
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 16:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kf5ageCsFrap3bA1QWcIlFlQfC1vfoha691k6exf2uE=; b=foV7qLnAP0qm/V8xry3R2nxor0
	w0BkCYqYDOVN5AlbS5Maclw/uEzpWdXDzAdfKk8mvX8y1NlJ6CdfmRPrS24uPiC+ZLoXwj2U03p2T
	UH/tss1a1+maNvZn/dfPZAUYCfNpek3YhbIs0hWQ09DQB+2NiLEm92PSXaMR8q2lK5CG+kjQxwTic
	j8frOKhjhaw0JGCuiG5rAdfXRrPuScJ8KivffDRhqJvx9Fu+4lOyACH/UXIZbP9wvN3/wZfBPawgF
	SE48vuoZ9+sG3oiKzF5//Pp3rBjOxOTtEnDbk+ZVzNepyyDdEjtUQrArNmU6D5QjtZqYxF7IUJMnh
	Mm4QbGpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpTVU-0000000Az00-3uUx;
	Thu, 30 Jul 2026 16:21:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpTVT-0000000Ayzh-2SfB
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 16:21:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BB2EF41993;
	Thu, 30 Jul 2026 16:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229E11F000E9;
	Thu, 30 Jul 2026 16:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428474;
	bh=kf5ageCsFrap3bA1QWcIlFlQfC1vfoha691k6exf2uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uw6mP4KAf2UaS98H1gBHmDVl/BrH9fFspyWL0M23xglW3zzXPUC2NdbYApv6v0Qk+
	 EsWMF6iYOVEOPxb/AUXqBVDD6UCP+PxAT2OThdFT8/mJZgdod6uY+vAHKSigyrfpnx
	 YBZ928aaNoBgFVopfPzaXwMuTIoYHaTrGNlMk4jo=
Date: Thu, 30 Jul 2026 17:02:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Hari Mishal <harimishal1@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: drop WARN_ON_ONCE on write_stream bounds check
Message-ID: <2026073054-visiting-plural-7eb0@gregkh>
References: <2026072748-unpopular-onlooker-4a2b@gregkh>
 <amfg_OFiyDadWb3v@kbusch-mbp>
 <2026072849-uproar-aqua-07c3@gregkh>
 <20260728051838.GA20593@lst.de>
 <2026072834-buffoon-entwine-ed16@gregkh>
 <20260730114123.GB25956@lst.de>
 <2026073003-primp-granular-c176@gregkh>
 <20260730133726.GA2983@lst.de>
 <2026073049-improper-paparazzi-6be7@gregkh>
 <amtfOzqITuEbYL3g@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amtfOzqITuEbYL3g@kbusch-mbp>
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

On Thu, Jul 30, 2026 at 08:27:07AM -0600, Keith Busch wrote:
> On Thu, Jul 30, 2026 at 04:04:03PM +0200, Greg Kroah-Hartman wrote:
> > It's only the systems that have panic-on-warn enabled that need to worry
> > about user-triggered calls to that macro, and those systems know what
> > they are getting themselves into, including the huge number of CVE fixes
> > they then need to be responsible for backporting :)
> 
> This is a bit of a rug pull. We've long held the pattern that WARN is an
> appropriate macro for conditions that should never happen, but don't
> leave the system in an unrecoverable or compromised state. For
> unrecoverable conditions, use BUG. It has been a valuable tool for
> debugging and bug reporting.

Sure, that's fine, just don't have such a path that a user can trigger,
and all is good.  syzbot has been dealing with this for years, it's not
a rug-pull at all.

thanks,

greg k-h

