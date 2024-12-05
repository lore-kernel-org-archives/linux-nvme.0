Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30ECE7716E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 23:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=wUSSo/BNF0LJ0W5EYbVNqlYcklpS8ZF2q6pUNGHybPE=; b=Qa89/qhMJdi/X3
	H87d7NYSbqZNSBzFr5mYS+0+w1XL0xUCdCi6xpHw2QVV0NPLrsPqK806QPD8r3yMR55NYH0RojcOj
	qLLRZAO112eVSo6VYW3eH0J+LX97djcLPjkh+ozGwRLNd/b4zVSE35X+QGjKVyuJkfB3wULdb9km0
	lepF7mk0r84b88mDoTSrwrDgJj5vDXbHfieRIGVmr/MJCcLZKRuF2PmoqXCSK04Ab2bwYgurp+6P1
	TgXEC1sCGBs20Z4pVY6IoUyb4ny0aVaS+Rnh1+DUIcR7WOR0gxHj1MZZftTQ53/baE3HdXA4XnKHs
	zlcXhd8/mKJBeTr5jqrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJLHO-0000000HZ98-3Eh6;
	Thu, 05 Dec 2024 23:29:06 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJLHM-0000000HZ8l-36Zc
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 23:29:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8B597A4209A;
	Thu,  5 Dec 2024 23:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113D2C4CED1;
	Thu,  5 Dec 2024 23:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733441343;
	bh=+bqKJcKuzym60bZGjQJ4GJHjOSqCprR+fLaTkzPT5Ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=deFtp5yecINLqt7hqACqQZa9xtYMkfvZ3pYK9207V2ZF5/fe01hdz8xJoILkxKsmg
	 ot4TK+2A2p464xs/eMmyVle+Yq3PlX9Cup71VwZdzSFJ16+SDADdexq2dCK1tJckbc
	 tI+alEjKL9qFJmwOBaa1TtSeF8CTgxLAe1gZvo9vJ5ULyDqI9TAjlicQJlU1tWfJ+m
	 1Uoj5QSBDEzWRnwZmnoM0oGbRN/owKjCrlVJjahrRUDtprmIlTY1bzjGykqyTaKbIl
	 hKjtEBnOve0/h+w05KpIWRq/cEr0p0jdTLpG2bVuU3hUv52rYnrByxGAosDpoFPWfT
	 LYDR4dPqTqMxg==
Date: Thu, 5 Dec 2024 17:29:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241205232900.GA3072557@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123090113.semecglxaqjvlmzp@thinkpad>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_152904_909523_E48AFA8B 
X-CRM114-Status: GOOD (  40.23  )
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

On Sat, Nov 23, 2024 at 02:31:13PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 22, 2024 at 04:20:50PM -0600, Bjorn Helgaas wrote:
> > On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> > > PCI core allows users to configure the D3Cold state for each PCI
> > > device through the sysfs attribute
> > > '/sys/bus/pci/devices/.../d3cold_allowed'. This attribute sets
> > > the 'pci_dev:d3cold_allowed' flag and could be used by users to
> > > allow/disallow the PCI devices to enter D3Cold during system
> > > suspend.
> > >
> > > So make use of this flag in the NVMe driver to shutdown the NVMe
> > > device during system suspend if the user has allowed D3Cold for
> > > the device.  Existing checks in the NVMe driver decide whether
> > > to shut down the device (based on platform/device limitations),
> > > so use this flag as the last resort to keep the existing
> > > behavior.
> > > 
> > > The default behavior of the 'pci_dev:d3cold_allowed' flag is to
> > > allow D3Cold and the users can disallow it through sysfs if they
> > > want.
> > 
> > What problem does this solve?  I guess there must be a case where
> > suspend leaves NVMe in a higher power state than you want?
> 
> Yeah, this is the case for all systems that doesn't fit into the
> existing checks in the NVMe suspend path:
> 
> 1. ACPI based platforms
> 2. Controller doesn't support NPSS (hardware issue/limitation)
> 3. ASPM not enabled
> 4. Devices/systems setting NVME_QUIRK_SIMPLE_SUSPEND flag
> 
> In my case, all the Qualcomm SoCs using Devicetree doesn't fall into
> the above checks. Hence, they were not fully powered down during
> system suspend and always in low power state. This means, I cannot
> achieve 'CX power collapse', a Qualcomm specific SoC powered down
> state that consumes just enough power to wake up the SoC. Since the
> controller driver keeps the PCI resource vote because of NVMe, the
> firmware in the Qualcomm SoCs cannot put the SoC into above
> mentioned low power state.

IIUC nvme_suspend() has two paths:

  - Do nvme_disable_prepare_reset() without calling pci_save_state(),
    so the PCI core chooses and sets the low-power state.

  - Put the device in an NVMe-specific low-power state and call
    pci_save_state(), which prevents the PCI core from putting the
    device in a low-power state.

    (The PCI core part is in pci_pm_suspend_noirq(),
    pci_pm_poweroff_noirq(), pci_pm_runtime_suspend())

And I guess you want the first path for basically all systems?  The
only systems that would use the NVMe-specific path are those where:

  - !pm_suspend_via_firmware() (not an ACPI system), AND

  - ctrl->npss (device supports NVMe power states), AND

  - pcie_aspm_enabled(), AND

  - !NVME_QUIRK_SIMPLE_SUSPEND (it's not something with a weird
    quirk), AND

  - !pdev->d3cold_allowed (user has cleared it via sysfs)

This frankly seems almost unintelligible to me, so I'm glad I'm not
responsible for nvme :)

> > I'm not sure the use of pdev->d3cold_allowed here really expresses
> > your underlying intent.  It suggests that you're really hoping for
> > D3cold, but that's only a possibility if firmware supports it, and
> > we have no visibility into that here.
> 
> I'm not relying on firmware to do anything here. If firmware has to
> decide the suspend state, it should already satisfy the
> pm_suspend_via_firmware() check in nvme_suspend(). ...

I'm confused about this because we want to use PCI core power
management, which chooses the new state with pci_target_state(),
which looks like it will choose D3hot unless we're on an ACPI system
and acpi_pci_choose_state() returns D3cold.

But your system is not an ACPI system, so we should get D3hot, but yet
you decide based on D3*cold* being allowed?

> Here, the controller driver takes care of putting the device into
> D3Cold.  Currently, the controller drivers cannot do it (on DT
> platforms) because of NVMe driver's behavior.

I'm missing the connection to the controller driver (I assume you mean
qcom-pcie?).  Maybe it's that having the NVMe device in a PCI
low-power state allows qcom_pcie_suspend_noirq() to reduce the ICC
bandwidth vote and do other power-saving things?  And it can't do
those things if we're using the NVMe low-power state because that
state is not visible to qcom-pcie?

> We did attempt to solve this problem in multiple ways, but the
> lesson learned was, kernel cannot decide the power mode without help
> from userspace. That's the reason I wanted to make use of this
> 'd3cold_allowed' sysfs attribute to allow userspace to override the
> D3Cold if it wants based on platform requirement.

It seems sub-optimal that this only works how you want if the user
intervenes.

Bjorn

