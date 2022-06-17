Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180D4C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jun 2022 20:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1xtvgfXYDHdIljqEw6y4bHykLlx/UFNI9bC13DmJEH0=; b=I05a2HqIz1AVmEEp6PzOCacqTp
	4Lu0e2szj4H/SP0TlTNkxmvpbJjSuGxaEUwvkkWMLsVhyqTPIT3bMaZtLsCPAzA/a5XpIP8WBtr25
	cPIo9uMMu28QmR5facmX/oaepDpgFDsvHadRlgOsiEMbo8i5P5sF8fvQS66KVW+0ovIDK2HBHTHIj
	BanzgZ6SQGgn8LHW62WFbm6WCqet1NYOBp2ww6TAtvGGc6zgWxVEBRpo9ApxjyRSRyejc0V2QPM3s
	rP3WvV201Uv0e4N8ki1SyTLceUQD5QiqmnV8GFzJvWjHsLIV/kpVldmIwRxX9pgemftdiV8OruaGb
	ONCGMOag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2IZK-008wUS-Qf; Fri, 17 Jun 2022 20:27:50 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2IZH-008wT9-QE
	for linux-nvme@lists.infradead.org; Fri, 17 Jun 2022 20:27:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 99A25B82BC3;
	Fri, 17 Jun 2022 20:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76E9C3411B;
	Fri, 17 Jun 2022 20:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655497664;
	bh=1h7MPvCH+0ac659Y59O+LN7H9yf7FDL7AzRyBezl7Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAdK1iR7a1WmLfVx5wRu4og+zBfk6P1uN39+gS6uvwC1k/3eefV6ILqmVxxWnZygQ
	 bBBOoIxihb0QmMQWOSV4VTF/L2bWEchyx/e//N/c6pYQvi8xU2lKBgwnYRqy701IKG
	 ssin1X/FApCNiJh7UqRMIBdBF9N8dHd9ROFutNCfyAobYjQv5VoAedCEVbGiDMcB6b
	 oU7ul27EaaCoZMvopX6aBu27/m86c8BzFJVWs6TSb4O8xF5Q/pWYL/CNBCGDGXrx4S
	 rgd2ceX8FSUrsv+DobF4lumuhsMka6+CtL70oaOV8GR5nfOmNwERtvTdMDNEnMURGm
	 v2a45NA/RU2YA==
Date: Fri, 17 Jun 2022 14:27:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <YqzjvO34ebaRpraz@kbusch-mbp.dhcp.thefacebook.com>
References: <YqkeF2uqAyyxiZrQ@kbusch-mbp.dhcp.thefacebook.com>
 <20220615151100.GA937185@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615151100.GA937185@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_132748_160723_12A859A2 
X-CRM114-Status: GOOD (  33.44  )
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

On Wed, Jun 15, 2022 at 10:11:00AM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 14, 2022 at 04:47:35PM -0700, Keith Busch wrote:
> > On Tue, Jun 14, 2022 at 06:01:28PM -0500, Bjorn Helgaas wrote:
> > > [+cc NVMe folks]
> > > 
> > > On Tue, Jun 14, 2022 at 07:49:27PM -0300, Guilherme G. Piccoli wrote:
> > > > On 14/06/2022 12:47, Hans de Goede wrote:
> > > > > [...]
> > > > > 
> > > > > Have you looked at the log of the failed boot in the Steam Deck kernel
> > > > > bugzilla? Everything there seems to work just fine and then the system
> > > > > just hangs. I think that maybe it cannot find its root disk, so maybe
> > > > > an NVME issue ?
> > > > 
> > > > *Exactly* that - NVMe device is the root disk, it cannot boot since the
> > > > device doesn't work, hence no rootfs =)
> > > 
> > > Beginning of thread: https://lore.kernel.org/r/20220612144325.85366-1-hdegoede@redhat.com
> > > 
> > > Steam Deck broke because we erroneously trimmed out the PCI host
> > > bridge window where BIOS had placed most devices, successfully
> > > reassigned all the PCI bridge windows and BARs, but some devices,
> > > apparently including NVMe, didn't work at the new addresses.
> > > 
> > > Do you NVMe folks know of gotchas in this area?  I want to know
> > > because we'd like to be able to move devices around someday to
> > > make room for hot-added devices.
> > > 
> > > This reassignment happened before drivers claimed the devices, so
> > > from a PCI point of view, I don't know why the NVMe device
> > > wouldn't work at the new address.
> > 
> > The probe status quickly returns ENODEV. Based on the output (we
> > don't log much, so this is just an educated guesss), I think that
> > means the driver read all F's from the status register, which
> > indicates we can't read it when using the reassigned memory window.
> > 
> > Why changing memory windows may not work tends to be platform or
> > device specific. Considering the renumbered windows didn't cause a
> > problem for other devices, it sounds like this nvme device may be
> > broken.
> 
> It sounds like you've seen this sort of problem before, so we
> shouldn't assume that it's safe to reassign BARs.

I haven't seen this type of problem in years, but as I recall, it was always
low-end consumer crap that couldn't deal with changing BARs; you're stuck with
whatever was set after it was initially powered on. The PCI topology will
reflect the expected renumbering, but whatever is happening on the other side
of the PCI function seems to be unaware of the change.

