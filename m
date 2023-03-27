Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA16EC761A6
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 18:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V+Yi5h7xQiewEzB4sWh2zf9wxkDk58siKqSwHfcqwjA=; b=b2hXbPOBiCXGzkvx+fVaB1trE1
	qDudy//cJQH5hFJ0FwCvrs133M9GqFawKYyCM5FqWjyQyO3jkX+amWZBpTWtMznI7YkBnbG31Y3XW
	4EtsN4Ni1Baintp/l31S8SPZg6zLBW6HX3Ljod1LPmZq5gKJ3X15dLsr1NRCWUtxy08+WZ+cE8for
	RTNeG9VJI6hzUji5pqvUQhNOqn9rQivSgVImBiI5cT6EjHPINnAXkVm1+MAuVcqZ+2vR0QuKLU6mj
	2n04Dg4XjCeBUs/EDPdyg93ViPC8bkkbBcro0sxd/8SphyXbPF2eIvv8nf3eOF7kWcTWXhvAGaFqc
	EjNuRreg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgrXH-00C2iX-2i;
	Mon, 27 Mar 2023 18:25:39 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgrXE-00C2hX-2z
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 18:25:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 5BEAEB818BA;
	Mon, 27 Mar 2023 18:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462F9C4339B;
	Mon, 27 Mar 2023 18:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679941534;
	bh=NetanH4sd0D3s9kbFvtFNH1FlBRlHB84MpHBbN+Dork=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elydm5rx3TzjkZWgmL/p25yuLBH16WR5Ht67qc/ohRBDyzKhd38+uzGgAG4/WlW0q
	 o5ZviK8axvqlhEcyje6BaoUpPICCrxaEu5okPy3ZshnM7jkgvofnf7fJtg66hLIyMw
	 NWnx4Sow4D3dbMpIzPlgS3UjqAOKcXAarsl3R/Yff0TbJtVUQk6usVmCavpuV8qiJV
	 z54cytk9NNxKC5Ax6LxHcxxrDAWbMep2zQ4eXyhTGtcKQ3utfFFHvWebJfKSx2euOX
	 TgmT2qWHFq4f/d74iizboW0JiaobYY48zC95Zmt7PUklW5kB6iovVMyziiFIb3WSp2
	 mwdCZ2LGkfFIw==
Date: Mon, 27 Mar 2023 12:25:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Aleksander Trofimowicz <alex@n90.eu>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 217251] New: pciehp: nvme not
 visible after re-insert to tbt port]
Message-ID: <ZCHfmmv9WPxM4fD7@kbusch-mbp.dhcp.thefacebook.com>
References: <20230327143359.GA2834753@bhelgaas>
 <ZCHB6hXbCOxiZw+n@kbusch-mbp.dhcp.thefacebook.com>
 <871qlank6o.fsf@n90.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qlank6o.fsf@n90.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_112537_113542_51A8A0F8 
X-CRM114-Status: GOOD (  25.23  )
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

On Mon, Mar 27, 2023 at 05:43:18PM +0000, Aleksander Trofimowicz wrote:
> 
> Keith Busch <kbusch@kernel.org> writes:
> 
> > On Mon, Mar 27, 2023 at 09:33:59AM -0500, Bjorn Helgaas wrote:
> >> Forwarding to NVMe folks, lists for visibility.
> >>
> >> ----- Forwarded message from bugzilla-daemon@kernel.org -----
> >>
> >> https://bugzilla.kernel.org/show_bug.cgi?id=217251
> >> ...
> >>
> >> Created attachment 304031
> >>   --> https://bugzilla.kernel.org/attachment.cgi?id=304031&action=edit
> >> the tracing of nvme_pci_enable() during re-insertion
> >>
> >> Hi,
> >>
> >> There is a JHL7540-based device that may host a NVMe device. After the first
> >> insertion a nvme drive is properly discovered and handled by the relevant
> >> modules. Once disconnected any further attempts are not successful. The device
> >> is visible on a PCI bus, but nvme_pci_enable() ends up calling
> >> pci_disable_device() every time; the runtime PM status of the device is
> >> "suspended", the power status of the 04:01.0 PCI bridge is D3. Preventing the
> >> device from being power managed ("on" -> /sys/devices/../power/control)
> >> combined with device removal and pci rescan changes nothing. A host reboot
> >> restores the initial state.
> >>
> >> I would appreciate any suggestions how to debug it further.
> >
> > Sounds the same as this report:
> >
> >   http://lists.infradead.org/pipermail/linux-nvme/2023-March/038259.html
> >
> > The driver is bailing on the device because we can't read it's status register
> > out of the remapped BAR. There's nothing we can do about that from the nvme
> > driver level. Memory mapped IO has to work in order to proceed.
> >
> Thanks. I can confirm it is the same problem:
> 
> a) the platform is Intel Alderlake
> b) readl(dev->bar + NVME_REG_CSTS) in nvme_pci_enable() fails
> c) reading BAR0 via setpci gives 0x00000004

It's strange too. In your example, kernel says:

  0000:05:00.0: BAR 0: assigned [mem 0x54000000-0x54003fff 64bit]

There is a check right after that message that ensures the kernel reads back
what it wrote. No failures reported means the device really did have the
expected BAR value at one point.

