Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA2FCD37B7
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 05:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qJAHRqq7Ev5EKiMe2Ok5zxR9FvxXaugdBcK6Nc+PxRQ=; b=j89T0/YS2EllEgBGo79O2k7btj
	1KbKGy3xYu1T5azYdIpWD26Jr0dj01K/4O7Y7XlpFzHmd/EtH7cdcbKunwxNAKszdk00xL+iplq1k
	rYc1X5YV//yaWRHDMH1GMu8aDIKlAGrR+lppNQVTKND0MxNgPNLLarxeuxOdMbZUU7AJnJS/zvZ1Q
	DBzn4d1dNnmg49iDGo5T6ySy/+TlJdmgKpvsW70Vs5VDBEZeQd/kvYp/EyZnQWLcStf8wmO1ceZyC
	DhvLeaHr0SYh2HjmFV85hLtoPzgGwG5Erjssujw7RtxcwcdlgaQaPqNO/oqMtIgCdM6V7RvU7k0gt
	rLXWE2Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMJ2R-0000000CNAA-2o2p;
	Mon, 11 May 2026 05:18:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMJ2M-0000000CN8s-0lFY
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 05:18:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4A7336001A;
	Mon, 11 May 2026 05:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31ABC2BCB0;
	Mon, 11 May 2026 05:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778476717;
	bh=DlsXme9lwoqKsJyGSBaGtI+ozuQkDWi5uzvbU8C2c5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0IPhONnhKqguTZYEEPJfmmarergtLTe7mSrEWz5PN6QF7cnCSYkd/psKMt4cjrOA
	 iPMZg2uf0DMUlg80+8RIvT6HZyor+xgMmBfmWNyMmJMfIDrRn9Dt7l/BQpjFalaRxn
	 H7UXcyE2WHjJMAVqakihPkV1OUbFTRvxNK6I16Vcb6e3rL6der9faCerOOxCyiFn6C
	 sxeaPKDNEjql2Hzl93lyBYKXl9/ShZTiBz6jAoAzt5uhiyhs756PQ2ybYTYgJGs6uI
	 SiAI5AQKrpi7bWoZ+YmwJPK+xeL3gnS8t2PuKFUvZjdbLOxWJ07vze0/pdsRPsoXFS
	 A/cGX5Bsb1I6w==
Date: Mon, 11 May 2026 10:48:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	manivannan.sadhasivam@oss.qualcomm.com, Thierry Reding <treding@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"David E. Box" <david.e.box@linux.intel.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Chia-Lin Kao <acelan.kao@canonical.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <fb6uzh3jfes3hky6fblpsh2vvg3daij5ogecydiuhmytxbglcb@tdqjcoxuymsk>
References: <20260122152903.GA1247682@bhelgaas>
 <8d8b2244-2bf0-48cf-8fb8-9e47e197a62d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d8b2244-2bf0-48cf-8fb8-9e47e197a62d@nvidia.com>
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

On Thu, May 07, 2026 at 11:25:23AM +0100, Jon Hunter wrote:
> Hi Bjorn, Mani,
> 
> On 22/01/2026 15:29, Bjorn Helgaas wrote:
> > [+cc NVMe folks]
> > 
> > On Thu, Jan 22, 2026 at 12:12:42PM +0000, Jon Hunter wrote:
> > > ...
> > 
> > > Since this commit was added in Linux v6.18, I have been observing a suspend
> > > test failures on some of our boards. The suspend test suspends the devices
> > > for 20 secs and before this change the board would resume in about ~27 secs
> > > (including the 20 sec sleep). After this change the board would take over 80
> > > secs to resume and this triggered a failure.
> > > 
> > > Looking at the logs, I can see it is the NVMe device on the board that is
> > > having an issue, and I see the reset failing ...
> > > 
> > >   [  945.754939] r8169 0007:01:00.0 enP7p1s0: Link is Up - 1Gbps/Full -
> > >    flow control rx/tx
> > >   [ 1002.467432] nvme nvme0: I/O tag 12 (400c) opcode 0x9 (Admin Cmd) QID
> > >    0 timeout, reset controller
> > >   [ 1002.493713] nvme nvme0: 12/0/0 default/read/poll queues
> > >   [ 1003.050448] nvme nvme0: ctrl state 1 is not RESETTING
> > >   [ 1003.050481] OOM killer enabled.
> > >   [ 1003.054035] nvme nvme0: Disabling device after reset failure: -19
> > > 
> > >  From the above timestamps the delay is coming from the NVMe. I see this
> > > issue on several boards with different NVMe devices and I can workaround
> > > this by disabling ASPM L0/L1 for these devices ...
> > > 
> > >   DECLARE_PCI_FIXUP_HEADER(0x15b7, 0x5011, quirk_disable_aspm_l0s_l1);
> > >   DECLARE_PCI_FIXUP_HEADER(0x15b7, 0x5036, quirk_disable_aspm_l0s_l1);
> > >   DECLARE_PCI_FIXUP_HEADER(0x1b4b, 0x1322, quirk_disable_aspm_l0s_l1);
> > >   DECLARE_PCI_FIXUP_HEADER(0xc0a9, 0x540a, quirk_disable_aspm_l0s_l1);
> > > 
> > > I am curious if you have seen any similar issues?
> > > 
> > > Other PCIe devices seem to be OK (like the realtek r8169) but just
> > > the NVMe is having issues. So I am trying to figure out the best way
> > > to resolve this?
> > 
> > For context, "this commit" refers to f3ac2ff14834, modified by
> > df5192d9bb0e:
> > 
> >    f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> >    df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> > 
> > The fact that this suspend issue only affects NVMe reminds me of the
> > code in dw_pcie_suspend_noirq() [1] that bails out early if L1 is
> > enabled because of some NVMe expectation:
> > 
> >    dw_pcie_suspend_noirq()
> >    {
> >      ...
> >      /*
> >       * If L1SS is supported, then do not put the link into L2 as some
> >       * devices such as NVMe expect low resume latency.
> >       */
> >      if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
> >        return 0;
> >      ...
> > 
> > That suggests there's some NVMe/ASPM interaction that the PCI core
> > doesn't understand yet.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware-host.c?id=v6.18#n1146
> 
> 
> I want to revisit this issue. From my perspective low-power suspend has now
> been broken on some of our Tegra platforms (that have NVMe devices) since
> v6.19 and so far this is no resolution to this issue. The patch that was
> proposed to fix this [0] has been rejected by qualcomm and although this
> does workaround the issue, my confidence that this is the right fix is now
> low.
> 

The referenced patch is now merged into arm-soc for v7.2:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=7602c0ec0bbfd3985d49f4f0cad281c1414008c9

I hope this takes care of the issue you are dealing with.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

