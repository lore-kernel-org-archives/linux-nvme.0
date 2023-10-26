Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08386C25B48
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R5dv8zfofzln5RygoZEpRH+XSZoFwBhyQUWP4KAL/4k=; b=ITl60fIy6nzWH4kl1m+nMPmTYh
	53rLIF+lLIOBTLOVXYODDPeKwQh4vMhFBYGmCwT5AvNSBpsu3a0bFq5YwhSg+gqJzEe5gpz11MqeD
	tppgcIVoUQAmIMm9jx9P8CMym9dUKygyUbjLtHQK2cx7/ynGyEnZKDuTAN/IPCBmGkWmpKvFkAp46
	3z88AtDCDsTgTf0qLIPKEfMq2SNhAXBsFDtOc2jPK1IxQn+0lEIkOkcaXTI+8DTy+jTJAN4gY9GeW
	Zozmtv+R/ukCU9s23ROKxfEgAoARiOvj0j0dMKcGwz/+s3SoX4ZFc8K+ReJn+vXfXAL33Hmukyof/
	gfBAwdjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw1yd-00Eljk-2z;
	Thu, 26 Oct 2023 15:08:51 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw1yb-00EljK-0p
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 15:08:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 34373B81CDA;
	Thu, 26 Oct 2023 15:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC82C433C7;
	Thu, 26 Oct 2023 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698332926;
	bh=9r0/t3eIMrZRQMzSDwyyyhTnAf1WbhVZ8oxn7HT2fco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jse7FHi+s//TJEwFbZgyg+OhkCQ7ou307Uq0i3da3qKSTYCduYnFtSJbGUNBcA8Za
	 GOGCeOSaJ0GQkGSjMd3HoJfAAE4CebEs9m8owlqqWoqcMmoYfRMHrVPvkbOtKkHa5f
	 w2H/eoX0Ju+HLucns/uN+8sSi+HlgkQvqP5zheUo/lnG6hao9BcERdkeJ/jTqGiYve
	 R+P/IQjBm3Aj9x/oinLp/U+FFMyoL1Xw/AqdXhtvDL3uB9Memu2tuH+DBa2C3URROL
	 gKZWdZuG6hQjH87Zc1rAfJmWR3RdZhETui34OjuqLbxzAu2BqQTzH3R1wcn8ty9ihS
	 YLlAU06wjF5eA==
Date: Thu, 26 Oct 2023 09:08:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	vincentfu@gmail.com, ankit.kumar@samsung.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Message-ID: <ZTqA--6dDYJ76Gyk@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
 <20231013051458.39987-1-joshi.k@samsung.com>
 <20231013052612.GA6423@lst.de>
 <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com>
 <ZSlL-6Oa5J9duahR@kbusch-mbp>
 <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com>
 <20231013154708.GA17455@lst.de>
 <CA+1E3rKaUW0YN+bphe9n26ZRTX1rq6M0z7Hpc=zLOJE1AER9hw@mail.gmail.com>
 <20231016054647.GA26170@lst.de>
 <CA+1E3rKcN=bOw3613XWKm_NqPS=dGOz43g4zwwQG_pRQSWkH_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+1E3rKcN=bOw3613XWKm_NqPS=dGOz43g4zwwQG_pRQSWkH_w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_080849_453034_B4695E3A 
X-CRM114-Status: GOOD (  16.39  )
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

On Thu, Oct 26, 2023 at 08:03:30PM +0530, Kanchan Joshi wrote:
> On Mon, Oct 16, 2023 at 11:16 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, Oct 16, 2023 at 12:49:45AM +0530, Kanchan Joshi wrote:
> > > OTOH, this patch implemented a software-only way out. There are some
> > > checks, but someone (either SW or HW) has to do those to keep things
> > > right.
> >
> > It only verifies it to the read/write family of commands by
> > interpreting these commands.  It still leaves a wide hole for any
> > other command.
> 
> Can you please explain for what command do you see the hole? I am
> trying to see if it is really impossible to fix this hole for good.
> 
> We only need to check for specific io commands of the NVM/ZNS command
> set that can do extra DMA.

The spec defines a few commands that may use MPTR, but most of the
possible opcodes that could use it are not defined in spec. You'd have
to break forward compatibility through this interface for non-root users
by limiting its use to only the known opcodes and reject everything
else.

