Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABCAC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 15:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=IuYLHLrvs/hzz9AJ1rC0mPjJK8aRfaw1hMDOZ63Ubdw=; b=j1mcvUCxn2W06u
	Bbl9hFKZPFTl18cnD8PV2lTKi026xZmj7iWAuQcLRAyvltxhtBjTDxPVfOwEf57Z1pfcCep8CwBQ9
	2dOBt5OJOZU6kNPOKbk1I6ZFG2aM1VXHDNgylc7R46P398ePnhoEwjfso1gDNyr10JamUQuKAK1lO
	NOiQp/5wGxwdyQElf8zTAVC0Dzp0fUUV8AmROLTX/9KWQtr/8EBEWKkqqxDwmVoqBEPHY+tBK2/as
	ZxAUpQRwm7Y+/+4mYqn649wOfUKJKrBEYgftczuhevzJ37dqx7oBh1ucHIKqjeK86GFomiEWMVRkg
	hV+TYFn3fiVwBfI6l74A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Ufl-00F8DB-EJ; Wed, 15 Jun 2022 15:11:09 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Ufh-00F8CJ-Fu
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 15:11:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 20426B81D92;
	Wed, 15 Jun 2022 15:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6EAC34115;
	Wed, 15 Jun 2022 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655305862;
	bh=8QqTc264OWMZ8sfVZ4CWeOAu41bS0EzhOXWhbFygifs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LuUNSUq9DJXyVwzCzA1ADZiRM+aAgdaZ1rvQmPrrm6tOe703EoxSyzax9AD3Ob5Vx
	 1CYgRjxUkOFGBjdcbfHO7yOc2eJNLJlD9pN9sNfrYeL2CW40vZdgJIuKj8LzEwnjLX
	 mP1rH4ndRvrtzH/PmaXFpt9gDe/9swcMmY5QYZA725W4jcTrzhgx6fWvurGQKoN7Fw
	 ywtrKnyTDGSmz+OqGb+AXgcpmrljrVdq3yTHpoqZJVN2U7Hm2BxZEPHU9wBBGzWdHx
	 iaF/8OgA3TXGBP6GodtliG3GrAxuEpXt4qCdkGsOfaEucyhgVyPOly5ZhYhZD7CNyG
	 SJh55/XgsR06w==
Date: Wed, 15 Jun 2022 10:11:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
	Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] x86/PCI: Revert: "Clip only host bridge windows for E820
 regions"
Message-ID: <20220615151100.GA937185@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqkeF2uqAyyxiZrQ@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_081105_858301_F32434D1 
X-CRM114-Status: GOOD (  30.23  )
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

On Tue, Jun 14, 2022 at 04:47:35PM -0700, Keith Busch wrote:
> On Tue, Jun 14, 2022 at 06:01:28PM -0500, Bjorn Helgaas wrote:
> > [+cc NVMe folks]
> > 
> > On Tue, Jun 14, 2022 at 07:49:27PM -0300, Guilherme G. Piccoli wrote:
> > > On 14/06/2022 12:47, Hans de Goede wrote:
> > > > [...]
> > > > 
> > > > Have you looked at the log of the failed boot in the Steam Deck kernel
> > > > bugzilla? Everything there seems to work just fine and then the system
> > > > just hangs. I think that maybe it cannot find its root disk, so maybe
> > > > an NVME issue ?
> > > 
> > > *Exactly* that - NVMe device is the root disk, it cannot boot since the
> > > device doesn't work, hence no rootfs =)
> > 
> > Beginning of thread: https://lore.kernel.org/r/20220612144325.85366-1-hdegoede@redhat.com
> > 
> > Steam Deck broke because we erroneously trimmed out the PCI host
> > bridge window where BIOS had placed most devices, successfully
> > reassigned all the PCI bridge windows and BARs, but some devices,
> > apparently including NVMe, didn't work at the new addresses.
> > 
> > Do you NVMe folks know of gotchas in this area?  I want to know
> > because we'd like to be able to move devices around someday to
> > make room for hot-added devices.
> > 
> > This reassignment happened before drivers claimed the devices, so
> > from a PCI point of view, I don't know why the NVMe device
> > wouldn't work at the new address.
> 
> The probe status quickly returns ENODEV. Based on the output (we
> don't log much, so this is just an educated guesss), I think that
> means the driver read all F's from the status register, which
> indicates we can't read it when using the reassigned memory window.
> 
> Why changing memory windows may not work tends to be platform or
> device specific. Considering the renumbered windows didn't cause a
> problem for other devices, it sounds like this nvme device may be
> broken.

It sounds like you've seen this sort of problem before, so we
shouldn't assume that it's safe to reassign BARs.

I think Windows supports rebalancing, but it does look like drivers
have the ability to veto it:

  https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/stopping-a-device-to-rebalance-resources
  https://docs.microsoft.com/en-us/windows-hardware/drivers/wdf/the-pnp-manager-redistributes-system-resources

So I suppose if/when we support rebalancing, it'll have to be an
opt-in thing for each driver.

