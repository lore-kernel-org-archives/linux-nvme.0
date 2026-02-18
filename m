Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99F3E9A047
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 13:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xFt1XPb+paObrd90JiGIbljodysIKY/280CFO2KoB94=; b=gwWXc3QpAm2IgWZjA+5UqNgfQB
	rllNAqian4YUJryC3KlhL7ZUAvKvzIWGOPzIeWqTBuI7qssf13ZuX2hgUoM2IIwGYZCepuh+jsPUg
	vFGAfIxDtarUOGPTm9Bbo5FviIQo+lPCL3Vb5pqZekst/fx6YwKFem/dWlOTjVbJuuiurWJxsLBNX
	J3TO+nurIisX3ZgnAoefae03Q9z3JLyiIVGAuJTBjYERiyX5UGOejHQ9Z2X81Wm2ZeACB+ocwpeRc
	VxBsXpDGyj20zcidJKgTI1FmG2u4ZJQvGiGAZ16ZFXglkUZtyPaPDFpG+sPhbo5MN5w4jE4vmy7Ix
	WEgIGwjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsi34-00000009vRL-2Xiz;
	Wed, 18 Feb 2026 13:57:02 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsi31-00000009vQv-3Toj
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 13:57:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D2C4D400F7;
	Wed, 18 Feb 2026 13:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54CFC116D0;
	Wed, 18 Feb 2026 13:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771423018;
	bh=JGgOfs9WaIUBZZYEP2cQnIVGfR7+IeafdQ+cHzErtV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RljBZrU4sHzhLNf1zCm5ibiDXiyLXJ/fHNbmq2gSIG3Axq8BhMl86tBpyVeZDikws
	 dH17T0SxzvbAt9/aXf7bybxe8NvF1sUPUz8eEbAHYrzQaEY0Rq8KdFnQOJiWoLFo2K
	 MErxg6Jjk1U1s4/m3503jZUMNp+IKroFyNYsVVMQL1J7s+x/wxGQmWuiwRdhHPI3+M
	 Qa20QUEXQNqb0Ua5uHyIdGKc3AuadNxK4Y1YV4P41zOCrxLU9BWtIjZmE1Q5Wh2xQK
	 snH9J/fy4S5E93cWdIKo1Y9mmCSrdEsBR/1PCYvNYbz280FqMo3D5Q+7SaBxEkHSJT
	 jSHZgYgKeLYnQ==
Date: Wed, 18 Feb 2026 19:26:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, 
	manivannan.sadhasivam@oss.qualcomm.com, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Chia-Lin Kao <acelan.kao@canonical.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <ro2rxvojtlk5etis2wqqtzw555hyzeelwrujz4eitmah4xbgr7@57jmibe2vddf>
References: <7306256a-b380-489b-8248-b774e6d3d80e@nvidia.com>
 <20260122152903.GA1247682@bhelgaas>
 <5z7c25nkb35prvax6vq6ud7eaeuhzsswbf7fqvmlgys3xftgwb@odocboejrdrv>
 <ccf3bfd6-c060-4b88-bf4d-37425aea4cfa@tuxon.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccf3bfd6-c060-4b88-bf4d-37425aea4cfa@tuxon.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_055659_911343_1CFC85B7 
X-CRM114-Status: GOOD (  48.66  )
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

On Mon, Feb 16, 2026 at 07:19:46PM +0200, Claudiu Beznea wrote:
> Hi,
> 
> On 1/22/26 19:01, Manivannan Sadhasivam wrote:
> > On Thu, Jan 22, 2026 at 09:29:03AM -0600, Bjorn Helgaas wrote:
> > > [+cc NVMe folks]
> > > 
> > > On Thu, Jan 22, 2026 at 12:12:42PM +0000, Jon Hunter wrote:
> > > > ...
> > > 
> > > > Since this commit was added in Linux v6.18, I have been observing a suspend
> > > > test failures on some of our boards. The suspend test suspends the devices
> > > > for 20 secs and before this change the board would resume in about ~27 secs
> > > > (including the 20 sec sleep). After this change the board would take over 80
> > > > secs to resume and this triggered a failure.
> > > > 
> > > > Looking at the logs, I can see it is the NVMe device on the board that is
> > > > having an issue, and I see the reset failing ...
> > > > 
> > > >   [  945.754939] r8169 0007:01:00.0 enP7p1s0: Link is Up - 1Gbps/Full -
> > > >    flow control rx/tx
> > > >   [ 1002.467432] nvme nvme0: I/O tag 12 (400c) opcode 0x9 (Admin Cmd) QID
> > > >    0 timeout, reset controller
> > > >   [ 1002.493713] nvme nvme0: 12/0/0 default/read/poll queues
> > > >   [ 1003.050448] nvme nvme0: ctrl state 1 is not RESETTING
> > > >   [ 1003.050481] OOM killer enabled.
> > > >   [ 1003.054035] nvme nvme0: Disabling device after reset failure: -19
> > > > 
> > > >  From the above timestamps the delay is coming from the NVMe. I see this
> > > > issue on several boards with different NVMe devices and I can workaround
> > > > this by disabling ASPM L0/L1 for these devices ...
> > > > 
> > > >   DECLARE_PCI_FIXUP_HEADER(0x15b7, 0x5011, quirk_disable_aspm_l0s_l1);
> > > >   DECLARE_PCI_FIXUP_HEADER(0x15b7, 0x5036, quirk_disable_aspm_l0s_l1);
> > > >   DECLARE_PCI_FIXUP_HEADER(0x1b4b, 0x1322, quirk_disable_aspm_l0s_l1);
> > > >   DECLARE_PCI_FIXUP_HEADER(0xc0a9, 0x540a, quirk_disable_aspm_l0s_l1);
> > > > 
> > > > I am curious if you have seen any similar issues?
> > > > 
> > > > Other PCIe devices seem to be OK (like the realtek r8169) but just
> > > > the NVMe is having issues. So I am trying to figure out the best way
> > > > to resolve this?
> > > 
> > > For context, "this commit" refers to f3ac2ff14834, modified by
> > > df5192d9bb0e:
> > > 
> > >    f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> > >    df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> > > 
> > > The fact that this suspend issue only affects NVMe reminds me of the
> > > code in dw_pcie_suspend_noirq() [1] that bails out early if L1 is
> > > enabled because of some NVMe expectation:
> > > 
> > >    dw_pcie_suspend_noirq()
> > >    {
> > >      ...
> > >      /*
> > >       * If L1SS is supported, then do not put the link into L2 as some
> > >       * devices such as NVMe expect low resume latency.
> > >       */
> > >      if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
> > >        return 0;
> > >      ...
> > > 
> > > That suggests there's some NVMe/ASPM interaction that the PCI core
> > > doesn't understand yet.
> > > 
> > 
> > We have this check in place since NVMe driver keeps the device in D0 and expects
> > the link to be in L1ss on platforms not passing below checks:
> > 
> >          if (pm_suspend_via_firmware() || !ctrl->npss ||
> >              !pcie_aspm_enabled(pdev) ||
> >              (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
> > 
> 
> We noticed a similar issue with the Renesas RZ/G3S host driver and NVMe
> devices. We currently have 2 SoCs where we identified this problem (RZ/G3S
> and RZ/G3E), both present on SoM modules, and the SoM modules could be
> connected to the same carrier board where the PCIe signals are routed and
> connectors exists. On the carrier board we have 2 connectors were we can
> attach NVMe devices, one M.2 Key B and one PCIe x4 connector
> (https://www.amphenol-cs.com/product/10061913111plf.html).
> 
> The issue described in this thread is reproducible for us only after suspend
> and only for the NVMe device connected to the the PCIe x4 connector. The
> device is working correctly just after boot. On suspend, power to the most
> SoC components (including PCIe) is lost but the endpoints remains powered.
> 
> The issue is not reproducible if the following command is executed before
> suspend: echo performance > /sys/module/pcie_aspm/parameters/policy
> 
> The difference we identified in terms of signals connected from the SoC to
> the on board connectors relies in the CLKREQ#. This signal is only connected
> to the PCIe x4 slot.
> 
> On RZ/G3E the CLKREQ# is configured as a individual GPIO pin. On RZ/G3S it
> is muxed by the pin controller with PCIe function. We tried on RZ/G3E to not
> configure the CLKREQ# pin at all and with this the NVMe connected on the
> PCIe x4 slot started to work even after suspend. We cannot reproduce the
> same behavior on RZ/G3S.
> 
> Initially, we considered we might have to update the existing code to do
> specific configuration for the boards were CLKREQ# is not connected (through
> supports-clkreq DT property that some controllers are using).
> 
> Currently, the manual is unclear on how to control CLKREQ#.
> 
> Apart from the suggestions mentioned in [1], could you please let me know if
> you have any others?
> 

If you do not know how to control CLKREQ# and it is broken, then disable L1 PM
Substates in the Root Port L1 PM Susbstates Capabilities register during
controller driver probe.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

