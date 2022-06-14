Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2FFC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 23:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tOUdjm+nDQmq+Bz9s+u1VV+eU95fEsTseHkAZ5csNLw=; b=Lwe/sEX2KdLIisIomc+AIWXB7Y
	9N54rvVDX5xFQFWd5fUATFiqOpDV4WF8BbRTCHTPPoLIGioACV2RuTTaHNojXMs7Eu44IEZlVEDoe
	VWOqdCdPjZE+jNB42ZkFwg14rb8szvHUDG9QWDekPaqK3R2avI9JfR2n0Fj91Bx+ySo8MJtmHW3jt
	WqgLoZO6HbIHvn/GEdsrzo3qqbWkNeEZdtbJ7TBs+U7B7O1uq98CPY7H7GwBWjZbjxrSbD/ZK0qwx
	cFNnWoplsZ76L77q0TFwUwEPhz8l3MfImZOJXtSqmzCpt1gHaZ1esHfLM5j0fJQ7MSmfd9VG8AqWC
	a7ajYhWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1GG7-00BpIG-6z; Tue, 14 Jun 2022 23:47:43 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1GG4-00BpH1-Lj
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 23:47:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D0FD9618FB;
	Tue, 14 Jun 2022 23:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD23C3411B;
	Tue, 14 Jun 2022 23:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655250458;
	bh=1JsanDZNOK4cubwngvXHwGnNaBFzu4Cguyto6qNV48I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VN1Hvl0IQM48SGQ7YHPXBdJOzdiOiBDn7Zt7dlUADf3kWtMYuH+lYphpc0zPYVpiN
	 cBbmii9DwcKc3lsH4T06FKQ0RvTknVQzQ/2x7TtdITd9ofPGdHxB4K5mmkYpeQ78CR
	 i9aefKOoTd7uTYxVFvVLXfb4UOYAM/5sNmRCL5RiYL2enpd7sBLsFyB7P7XzollYMT
	 wG5XHGs/AEaKmscEKnyHJ2gpZP9qEGtPizNT6jeeh7In1SG4DfjV/2+cOfciiJV2ga
	 XUoGp2FK5XYSWYEDKS9eaQ3auP0VWaNgDv1Eb/HxrlmiFNAgSNBMwkcaYj48EEi7v4
	 JGxS2brKeGYTg==
Date: Tue, 14 Jun 2022 16:47:35 -0700
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
Message-ID: <YqkeF2uqAyyxiZrQ@kbusch-mbp.dhcp.thefacebook.com>
References: <6eae37ce-dd44-9c32-3f68-2b4e102dce8e@igalia.com>
 <20220614230128.GA901712@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614230128.GA901712@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220614_164740_833471_9D04407B 
X-CRM114-Status: GOOD (  25.69  )
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

On Tue, Jun 14, 2022 at 06:01:28PM -0500, Bjorn Helgaas wrote:
> [+cc NVMe folks]
> 
> On Tue, Jun 14, 2022 at 07:49:27PM -0300, Guilherme G. Piccoli wrote:
> > On 14/06/2022 12:47, Hans de Goede wrote:
> > > [...]
> > > 
> > > Have you looked at the log of the failed boot in the Steam Deck kernel
> > > bugzilla? Everything there seems to work just fine and then the system
> > > just hangs. I think that maybe it cannot find its root disk, so maybe
> > > an NVME issue ?
> > 
> > *Exactly* that - NVMe device is the root disk, it cannot boot since the
> > device doesn't work, hence no rootfs =)
> 
> Beginning of thread: https://lore.kernel.org/r/20220612144325.85366-1-hdegoede@redhat.com
> 
> Steam Deck broke because we erroneously trimmed out the PCI host
> bridge window where BIOS had placed most devices, successfully
> reassigned all the PCI bridge windows and BARs, but some devices,
> apparently including NVMe, didn't work at the new addresses.
> 
> Do you NVMe folks know of gotchas in this area?  I want to know
> because we'd like to be able to move devices around someday to make
> room for hot-added devices.
> 
> This reassignment happened before drivers claimed the devices, so from
> a PCI point of view, I don't know why the NVMe device wouldn't work at
> the new address.

The probe status quickly returns ENODEV. Based on the output (we don't log
much, so this is just an educated guesss), I think that means the driver read
all F's from the status register, which indicates we can't read it when using
the reassigned memory window.

Why changing memory windows may not work tends to be platform or device
specific. Considering the renumbered windows didn't cause a problem for other
devices, it sounds like this nvme device may be broken.

