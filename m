Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0182C32771
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Sep 2022 20:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NSt+7LT1finnOVdsORHWNJxvwfdWBxbW8Q+BIi08Xss=; b=pebC2QNXGfSH258Pkcdbuwun6R
	G6YYCdisWlPrYmWFGCUFKppsqYWIUhENd67eaiSR6TXmG5hQcHptiqA2oQ1CUbOLVxz/6ZRsOWJJn
	SnD5YxRBb1gpAwCYJmK3JnXDtcF0GQp/UZokzjS5zDeBw3vEM/6N0xK36CtdXh0Tqm8n1UyfADQll
	54g0agYNX8xBtf7RrEdetkwGxj0qrVKkVWoYJNjxVHDK1lmd8qGKBpfuB+6m5lm+yBMwEK5LWhwzD
	z+lFwl8c4po6w75Xwl3mvspi0pmGkGUbDgVLug78PO+nPB1AKJVY+wJcbOFe47fS55xjGo8o9SXD7
	w41CvmZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYv55-00GIiv-KP; Thu, 15 Sep 2022 20:03:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYv52-00GIhz-QA
	for linux-nvme@lists.infradead.org; Thu, 15 Sep 2022 20:03:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B49FB62658;
	Thu, 15 Sep 2022 20:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA34DC433C1;
	Thu, 15 Sep 2022 20:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663272198;
	bh=udK+lOAmzxG/NMT2goMXZMyzZqM1fJT+BUBn4h9p0wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pR5yhkO4LgQaH70z60GpP0I2s9RBgukrILG29s8omftFadOSa6GvHoNS049vkaAmP
	 T9b4Bkf/1NScBL52uswzB9frU5NEIt0ZF3vmSczDCvOvCcPBenwvO6e894swpSU0jE
	 ZUVIiBzZfuaJfdNvohvz1s8mLkXqHSw8D45ma2hDCwXesQl0kTszaFbhpIGSUyLH5D
	 XjEnZ1UDezFJVG4mzdUY2OvFwMnNLZWFLDIUpYUI6UkZsk7qWaT8kXExkSdFCGMS2U
	 OCrcRuLuqI5Jwhc/0x2Vuymi6kBaHaNpa7KPuQM5oda0uq8gSD35BbJi09W2gVWAiN
	 BZ7A59Dv1qHyg==
Date: Thu, 15 Sep 2022 21:03:14 +0100
From: Keith Busch <kbusch@kernel.org>
To: Nick Neumann <nick@pcpartpicker.com>, y@kbusch-mbp.dhcp.thefacebook.com
Cc: linux-nvme@lists.infradead.org
Subject: Re: smartctl "kills" specific drives on kernel 5.13 but works fine
 on 5.15 - why?
Message-ID: <YyOFAvJR9mWo+57C@kbusch-mbp.dhcp.thefacebook.com>
References: <CADqNVTpcFuPh8w3Gcx2ftYh_4EjObxpenA2Ps2y=055W0o13=A@mail.gmail.com>
 <CADqNVTp0KfQsegsEQn09-Tuc0b76_jWuir9UbDCe44o+rHr=0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADqNVTp0KfQsegsEQn09-Tuc0b76_jWuir9UbDCe44o+rHr=0w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220915_130324_965320_B6D077CF 
X-CRM114-Status: GOOD (  34.48  )
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

On Thu, Sep 15, 2022 at 12:50:54PM -0500, Nick Neumann wrote:
> On Wed, Sep 14, 2022 at 2:44 PM Nick Neumann <nick@pcpartpicker.com> wrote:
> >
> > I'm running ubuntu 20.04 LTS with HWE, which reports kernel 5.13.0-51
> > generic . Both a crucial P5 1TB and Crucial P5 2TB behave rather
> > poorly. With one drive installed, running
> >
> > sudo smartctl -x /dev/nvme0
> >
> > will output some info, then hang for a while, and then print
> > "NVME_IOCTL_ADMIN_CMD: Interrupted system call"
> >
> > From that point on, the drives are gone from the system until I cut
> > and restore power (reboot is not enough).
> >
> > Running smartctl against the drives works fine in windows and in
> > Ubuntu 22.04 LTS, which reports kernel 5.15.0-43
> >
> > I thought for sure I'd find that a quirk for the drives had been added
> > between kernels 5.13 and 5.15, but alas, I don't see one. The PCI
> > Vendor/Device ID is 1344:5405 for the 1TB model, and while the crucial
> > P2 has a quirk in drivers/nvme/host/pci.c, it has a different vendor
> > ID altogether (c0a9).
> >
> > Any thoughts on where I can look or what I might compare to try to
> > figure out what changed to get the Crucial P5 drives behaving? I was
> > hoping there was some setting I could tweak to get them going without
> > having to move to 22.04 LTS. (I've tried
> > "nvme_core.default_ps_max_latency_us=0" and various values for
> > "pci_aspm" with no luck.)
> 
> Figured this out. It isn't a linux kernel change, but rather a
> smartctl change. (In hindsight I should have started digging there
> first.)
> 
> The issue was https://www.smartmontools.org/ticket/1404, fixed by the
> 7.2 release (and Ubuntu 20.04LTS is on 7.1). The fix in smartmontools
> was to change to reading logs 4KB at a time, just like nvme did in
> https://github.com/linux-nvme/nvme-cli/commit/465a4d. (The device
> advertises that it has an MDTS of 9 so, as far as I understand,
> reading in 4KB chunks should not be necessary; the smartmontools
> author was not certain where the blame for the issue really belonged,
> but changing to work like nvme-cli avoids it.)
> 
> For now I'll avoid reading the error log via smartctl on problematic
> drives until I can move to a later smartmontools version.

Not sure what MDTS has to do with this. The error log was originally defined to
be a max 4k size which is below the smallest possible MDTS.

My guess is smartclt tricked the driver into allocating a PRP List, but the
controller instead accessed it as a PRP entry, which could corrupt memory or
fail the transaction if data direction is enforced by the memory controller.
Why that causes the nvme controller to fail as you've described is weird,
though.

