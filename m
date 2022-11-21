Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6222C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 22:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sixcJrLCo0VbCTIwo8YLI0nUsyNjT0rSTUSx22QHPZQ=; b=peXMI4Z8JebOEOXdmyMhzQR2GR
	hPpps0nDLwEPGsKpurnNXULaAueY4mCLtpUvhyjACVjoVSHo8rGWvUfqP4eti/L8ATqjRGEhDGk09
	u7LV70P+Cm1JcxY0oa+QouAO/7uqztaobqXcw02NKjFYlqp20M9xCnUsRaXAXglgcQtLv3l4QQ5+4
	BTb+VhOxrQFBVnDGvx3K35e/SS6zBBWQfgFLttE5RX6kiu+43uOEmVO4dz6mvYejYSYzKaUA+ELyr
	1At55hyFOKXKsxjXNXzl5vr6frFZMAzO+Q8ffoO01sLdW6UCNvPLsYm55TnYIcMtgf9U9xsKOQCNP
	qxWq5dkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxFZd-000v8g-Av; Mon, 21 Nov 2022 22:47:33 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxFZa-000v6J-Rd
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 22:47:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 3178AB816EC;
	Mon, 21 Nov 2022 22:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AC9C433C1;
	Mon, 21 Nov 2022 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669070848;
	bh=rupfA7QgttNtvcAds+s7jyNT0wRc3bEiCsYNLN49KQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9ZfIsUtxeuA1852d+UCrNWaEOk6PxCV3Z3yvQyDnfHiyDQ04DqsKdUFWQV/ty+tX
	 0Sa1JkpXsANIGE66aeQdWNL4S4YGCENUSga7cW6xmmZcu20mwD6C7mHYNU0S+gBOXP
	 fcmKEQs4aOlTqk1qEgdADFGKrKstRlvKmGVb4KW1JbPkihku+DpIY3sl6XU1f0vacu
	 oJZYySatSWBNhwHzK9qk2pv5VfPIh6sapq3vgr2DEbHgUP8CNn4oX4JdyOg47Rys/8
	 Q6NrpCvUU0SWmL+P7mJt2YO8OmmdPaXFMbF7XhJpq1scpgHCNTLbVHEjJ4KBSyJOW0
	 rHh2dm0ufTObQ==
Date: Mon, 21 Nov 2022 15:47:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] tests/nvme: Add admin-passthru+reset race test
Message-ID: <Y3v//NgG3xw8w/xS@kbusch-mbp>
References: <20221117212210.934-1-jonathan.derrick@linux.dev>
 <Y3vlsF7KcRrY7vCW@kbusch-mbp>
 <e99fef7c-1b48-61e2-b503-a2363968d5fc@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e99fef7c-1b48-61e2-b503-a2363968d5fc@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_144731_079538_2B06A978 
X-CRM114-Status: GOOD (  29.76  )
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

On Mon, Nov 21, 2022 at 03:34:44PM -0700, Jonathan Derrick wrote:
> On 11/21/2022 1:55 PM, Keith Busch wrote:
> > On Thu, Nov 17, 2022 at 02:22:10PM -0700, Jonathan Derrick wrote:
> >> I seem to have isolated the error mechanism for older kernels, but 6.2.0-rc2
> >> reliably segfaults my QEMU instance (something else to look into) and I don't
> >> have any 'real' hardware to test this on at the moment. It looks like several
> >> passthru commands are able to enqueue prior/during/after resetting/connecting.
> > 
> > I'm not seeing any problem with the latest nvme-qemu after several dozen
> > iterations of this test case. In that environment, the formats and
> > resets complete practically synchronously with the call, so everything
> > proceeds quickly. Is there anything special I need to change?
> >  
> I can still repro this with nvme-fixes tag, so I'll have to dig into it myself
> Does the tighter loop in the test comment header produce results?

My qemu's backing storage is a nullblk which makes format a no-op, but I
can try something slower if you think that will have different results.
These kinds of tests are definitely more pleasant to run under
emulation, so having the recipe to recreate there is a boon.
 
> >> The issue seems to be very heavily timing related, so the loop in the header is
> >> a lot more forceful in this approach.
> >>
> >> As far as the loop goes, I've noticed it will typically repro immediately or
> >> pass the whole test.
> > 
> > I can only get possible repro in scenarios that have multi-second long,
> > serialized format times. Even then, it still appears that everything
> > fixes itself after a waiting. Are you observing the same, or is it stuck
> > forever in your observations?
> In 5.19, it gets stuck forever with lots of formats outstanding and
> controller stuck in resetting. I'll keep digging. Thanks Keith

At the moment I'm interested in upstream, so either Linus' latest
6.1-rc, or the nvme-6.2 branch. If you can confirm these are okay (which
appears to be the case on my side), then I can definitely shift focus to
stable back-ports. But if they're not okay, then I want to straighten
that side out first.

