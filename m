Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79310D3EE92
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jan 2026 17:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=54p9g8vSSJDjb6KlqhENRBPu8QnNRceDLyJcyGjqGUY=; b=2zFPMQlfxMJFqlt8+yKF5AOox6
	kh4fo1DVAtQjWPcdtRRxC13AItVdTifCz2x/3eNdEN9yhyqCswVJfjhmc5qSGhQL7A8bbZNp9dhrE
	xVjoZGHjgW1G9Qs3mi+7yEZXMkNfjwtfbnbett0dqvMMsdMJAnvGanEZH6DCQWvZ5R52l/aeohG7/
	i2DHrNFGK8CiJusE+wz1b7jzcf88NAArfWEme9nHfAMIystw19cwkVuPEiVJhzrKhH9+DO6qhbe0I
	J/iSB626PH3sjIYfukpIWXiwyqKqQprQI/58CFNjFdA2YLzdAECXwR17AbQEJiI+rcW5fhBRNHAcu
	d5hnj3cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viy4M-00000007Wmk-0qAZ;
	Thu, 22 Jan 2026 17:02:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viy4I-00000007WmK-2v2P
	for linux-nvme@lists.infradead.org;
	Thu, 22 Jan 2026 17:02:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5664642A8E;
	Thu, 22 Jan 2026 17:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DF7C116C6;
	Thu, 22 Jan 2026 17:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769101321;
	bh=TPAxVo8Je7LBB6w1OgAl2SBsCio85y7ZhAg7mwaob/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldyC/2RNsLzuo+dmdhcSQl2Lsm+MaFjhwWiz5vU/CE4I0SNwJMniv9WdvqPIzub/8
	 WSTzATYjUAS6k5btQyOu2yTVqC/4902f+3Xcw75W9mDW/fxsVB7YzCXK4i8gCtWPs+
	 4RA/xoorE+BmqGY6suSZi0NSUZ48nW/FfqRjkPpgYdRCa8qxF7oX7WO6MXXhvqLSyy
	 Wrwlth1qliNglURiJ/PbS/dWl6+xeNZygwO6N7oHIEjr/79TJKSOddy0fmWex3tkB9
	 0us42nFupsxpVha6bt5xAEeZh27srjXhoo3NHYw8VrH4ZMUOE5ewERi648ucFoD5YY
	 JcHAhXSpb4xIw==
Date: Thu, 22 Jan 2026 22:31:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
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
Message-ID: <5z7c25nkb35prvax6vq6ud7eaeuhzsswbf7fqvmlgys3xftgwb@odocboejrdrv>
References: <7306256a-b380-489b-8248-b774e6d3d80e@nvidia.com>
 <20260122152903.GA1247682@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122152903.GA1247682@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_090202_802933_F12A58ED 
X-CRM114-Status: GOOD (  41.46  )
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

On Thu, Jan 22, 2026 at 09:29:03AM -0600, Bjorn Helgaas wrote:
> [+cc NVMe folks]
> 
> On Thu, Jan 22, 2026 at 12:12:42PM +0000, Jon Hunter wrote:
> > ...
> 
> > Since this commit was added in Linux v6.18, I have been observing a suspend
> > test failures on some of our boards. The suspend test suspends the devices
> > for 20 secs and before this change the board would resume in about ~27 secs
> > (including the 20 sec sleep). After this change the board would take over 80
> > secs to resume and this triggered a failure.
> > 
> > Looking at the logs, I can see it is the NVMe device on the board that is
> > having an issue, and I see the reset failing ...
> > 
> >  [  945.754939] r8169 0007:01:00.0 enP7p1s0: Link is Up - 1Gbps/Full -
> >   flow control rx/tx
> >  [ 1002.467432] nvme nvme0: I/O tag 12 (400c) opcode 0x9 (Admin Cmd) QID
> >   0 timeout, reset controller
> >  [ 1002.493713] nvme nvme0: 12/0/0 default/read/poll queues
> >  [ 1003.050448] nvme nvme0: ctrl state 1 is not RESETTING
> >  [ 1003.050481] OOM killer enabled.
> >  [ 1003.054035] nvme nvme0: Disabling device after reset failure: -19
> > 
> > From the above timestamps the delay is coming from the NVMe. I see this
> > issue on several boards with different NVMe devices and I can workaround
> > this by disabling ASPM L0/L1 for these devices ...
> > 
> >  DECLARE_PCI_FIXUP_HEADER(0x15b7, 0x5011, quirk_disable_aspm_l0s_l1);
> >  DECLARE_PCI_FIXUP_HEADER(0x15b7, 0x5036, quirk_disable_aspm_l0s_l1);
> >  DECLARE_PCI_FIXUP_HEADER(0x1b4b, 0x1322, quirk_disable_aspm_l0s_l1);
> >  DECLARE_PCI_FIXUP_HEADER(0xc0a9, 0x540a, quirk_disable_aspm_l0s_l1);
> > 
> > I am curious if you have seen any similar issues?
> > 
> > Other PCIe devices seem to be OK (like the realtek r8169) but just
> > the NVMe is having issues. So I am trying to figure out the best way
> > to resolve this?
> 
> For context, "this commit" refers to f3ac2ff14834, modified by
> df5192d9bb0e:
> 
>   f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
>   df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> 
> The fact that this suspend issue only affects NVMe reminds me of the
> code in dw_pcie_suspend_noirq() [1] that bails out early if L1 is
> enabled because of some NVMe expectation:
> 
>   dw_pcie_suspend_noirq()
>   {
>     ...
>     /*
>      * If L1SS is supported, then do not put the link into L2 as some
>      * devices such as NVMe expect low resume latency.
>      */
>     if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>       return 0;
>     ...
> 
> That suggests there's some NVMe/ASPM interaction that the PCI core
> doesn't understand yet.
> 

We have this check in place since NVMe driver keeps the device in D0 and expects
the link to be in L1ss on platforms not passing below checks:

        if (pm_suspend_via_firmware() || !ctrl->npss ||
            !pcie_aspm_enabled(pdev) ||
            (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))

Since the majority of the DWC platforms do not pass the above checks, we don't
transition the device to D3Cold or link to L2/L3 in dw_pcie_suspend_noirq() if
the link is in L1ss. Though I think we should be checking for D0 state instead
of L1ss here.

I think what is going on here is that since before commits f3ac2ff14834 and
df5192d9bb0e, !pcie_aspm_enabled() check was passing as ASPM was not enabled for
the device (and upstream port) and after those commits, this check is not
passing and the NVMe driver is not shutting down the controller and expects the
link to be in L0/L1ss. But the Tegra controller driver initiates L2/L3
transition, and also turns off the device. So all the NVMe context is lost
during suspend and while resuming, the NVMe driver got confused due to lost
context.

Jon, could you please try the below hack and see if it fixes the issue?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0e4caeab739c..4b8d261117f5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3723,7 +3723,7 @@ static int nvme_suspend(struct device *dev)
         * state (which may not be possible if the link is up).
         */
        if (pm_suspend_via_firmware() || !ctrl->npss ||
-           !pcie_aspm_enabled(pdev) ||
+           pcie_aspm_enabled(pdev) ||
            (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
                return nvme_disable_prepare_reset(ndev, true);
 
This will confirm whether the issue is due to Tegra controller driver breaking
the NVMe driver assumption or not.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

