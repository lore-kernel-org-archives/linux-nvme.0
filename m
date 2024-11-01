Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADBCE6F062
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2024 14:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sQKrF8DdnX9rYRg9UuFHq/EVJpdZV6+7OgwTd++CQGc=; b=wBCKkQMpUaRkCtQYHUq6JCfRzy
	4I+GsQsw5NM97xCaF4utzzUViisy/nhrrlDzbNHKFbR/1odnBFaed7zhn+OWDz4n0qKQjjFMV02jI
	fiYVpT6b0CdwQFFhep9DnCI/aCKSotd/UCyQ35qMMSHHw/VIAIgmnICig11FkZTfYyg9hB4jhuCK6
	h8zLdVgA2ict6qt8zwcHL/H1hHfSn0faPqAyQ3oEoh5+mVcvt8n/zBjr9A8KGkkz7CWTAYf9xCXav
	eW2g535MnN8BMadAREKPRkYsde5zu4/sZr4e2Q/j2JTvjc6RnErabn+VBa7i3yoCCilDBblPUifLn
	JDNZqPyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6szR-00000007OvZ-34tn;
	Fri, 01 Nov 2024 14:51:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6sxk-00000007OZj-29tl
	for linux-nvme@lists.infradead.org;
	Fri, 01 Nov 2024 14:49:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D9B405C30B4;
	Fri,  1 Nov 2024 14:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFBFC4CECD;
	Fri,  1 Nov 2024 14:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730472555;
	bh=k7EVw74ih8Q0h2JSgjLP3Pfx29kLuoxz2HYyitmb5QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqviswlYX1BHKuPR5ekMMzxSlcNtysICRu79OUByTD9UMQIsGrpVy/A721KYFuHMe
	 TZgNQ9laCdOQKoOOdHw+RLLXTRMtPDyj+1aOdIvd/CmVB1QDlxAT1sXJW1ILqbhgQj
	 r2chJflG1cLWi+WegmVeWDFEgaGMQ1D/J7Vs55mWI6YhP5xHJdg5e1ZqnThl3RcSmW
	 A/t4EPA6eJxanq/Ag7wG+RZpB6Hdw1r++uL8XIiNJqWdiYaNtOJY5lcWERoBA2hDsR
	 ustDb/50m8C5CtlUteDhkjp1SoqsrgvAqVnupo9cwHKs137vxOIFE7gwnytEzws0Ol
	 0wDEgDRoQz2Pw==
Date: Fri, 1 Nov 2024 08:49:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hans Holmberg <hans@owltronix.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <ZyTqZ3UR39VTHSA2@kbusch-mbp.dhcp.thefacebook.com>
References: <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com>
 <20241030154556.GA4449@lst.de>
 <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com>
 <20241030155052.GA4984@lst.de>
 <ZyJiEwZwjevelmW2@kbusch-mbp.dhcp.thefacebook.com>
 <20241030165708.GA11009@lst.de>
 <ZyK0GS33Qhkx3AW-@kbusch-mbp.dhcp.thefacebook.com>
 <CANr-nt35zoSijRXYr+ommmWGfq0+Ye0tf3SfHfwi0cfpvwB0pg@mail.gmail.com>
 <ZyOO4PojaVIdmlOA@kbusch-mbp.dhcp.thefacebook.com>
 <CANr-nt30gQzFFsnJt9Tzs1kRDWSj=2w0iTC1qYfu+7JwpszwQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANr-nt30gQzFFsnJt9Tzs1kRDWSj=2w0iTC1qYfu+7JwpszwQQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_074920_659597_7350DDDD 
X-CRM114-Status: GOOD (  22.12  )
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

On Fri, Nov 01, 2024 at 08:16:30AM +0100, Hans Holmberg wrote:
> On Thu, Oct 31, 2024 at 3:06 PM Keith Busch <kbusch@kernel.org> wrote:
> > On Thu, Oct 31, 2024 at 09:19:51AM +0100, Hans Holmberg wrote:
> > > No. The meta data IO is just 0.1% of all writes, so that we use a
> > > separate device for that in the benchmark really does not matter.
> >
> > It's very little spatially, but they overwrite differently than other
> > data, creating many small holes in large erase blocks.
> 
> I don't really get how this could influence anything significantly.(If at all).

Fill your filesystem to near capacity, then continue using it for a few
months. While the filesystem will report some available space, there
may not be many good blocks available to erase. Maybe.
 
> > Again, I absolutely disagree that this locks anyone in to anything.
> > That's an overly dramatic excuse.
> 
> Locking in or not, to constructively move things forward (if we are
> now stuck on how to wire up fs support) 

But we're not stuck on how to wire up to fs. That part was settled and
in kernel 10 years ago. We're stuck on wiring it down to the driver,
which should have been the easiest part.

> I believe it would be worthwhile to prototype active fdp data
> placement in xfs and evaluate it. Happy to help out with that.

When are we allowed to conclude evaluation? We have benefits my
customers want on well tested kernels, and wish to proceed now.

I'm not discouraing anyone from continuing further prototypes,
innovations, and improvements. I'd like to spend more time doing that
too, and merging something incrementally better doesn't prevent anyone
from doing that.

> Fdp and zns are different beasts, so I don't expect the results in the
> presentation to be directly translatable but we can see what we can
> do.
> 
> Is RocksDB the only file system user at the moment?

Rocks is the only open source one I know about. There are propietary
users, too.

