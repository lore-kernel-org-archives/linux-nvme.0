Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421A1F43691
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 11:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8SSE2yRaANJ5PaQ+rwC0q48KwoGbvcjqJR3eBMzp984=; b=CQWd4oMhOwWcOhf99VdpU8fyMm
	/Bn6fYjUU0mrEvRSVrirZMHHS/NzNHN3/MhNja93QJQBZPY4EzwNdOpNSyskoAgDWiyHNXIMr3TYX
	V0F0s2l52vyRlX+SqC7sLo8I97u/Kuq2fvHcVqqTPUsRdB+k0FZMxYnvpdd0aOFQNjEWpI0gjrqtP
	+qqsxngfEU+B+vq7zynGmAoKRBtwu8jSjFjQlMr2zRy2P6/60w35RH+Yxoab7HhFmfg99vzqCa2WZ
	FdTB7RqmCZDA7zEyCOqTgrjZMIHjRxuM/z9JhBcvQ96UAWgxWxmEyE+w6DR8PjtBxNOid6fi6FDMf
	PLj93cPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDh6W-00000003xUA-3KAB;
	Fri, 17 Apr 2026 11:11:20 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDh6U-00000003xTp-2V42
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 11:11:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 319B040420;
	Fri, 17 Apr 2026 11:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4B1C19425;
	Fri, 17 Apr 2026 11:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776424278;
	bh=3ZUy4YVkjarPeySIaKJt8bDHdExqFMDvv7aQz4EKkcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nm2rCLtQIQ3tqfXx9mTQqaypfsrORL3CO07f3jkVHSANHErHqjMscHzS1fGL7SaQv
	 GgiRm1dez3R5NS5H/LnWbjbn4bzvRqdno/jCUIhNrBlLn3pFloqDVHVX/O5m3vvYRA
	 RwMdu+LwHloxCK5WKeKGwCB0PsM/w0Z9lLe57Ffg1AXQ+wVccKm98R+Ejuv8MAtrVZ
	 6XsXgPKl4rYbl2kukg90t/BDpbzznUUaCAyz1m0SQd6aVW+/uvWncr3LHCr9FzRMBE
	 Yn/QAJVMNRyMRTCohpZHSyXjOO218TfFkKZB8obJ81Xh0G79UmbFeP/BAFUJBJDmjA
	 QaIZeoakgmq0g==
Date: Fri, 17 Apr 2026 16:41:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: Introduce an API to check if RC/platform can
 retain device context during suspend
Message-ID: <xqwvjygt3bgttbipe6hhnpkfwauczxpoiyfbbakdyzesz6ydcd@en54522wjnar>
References: <20260414-l1ss-fix-v1-1-adbb4555b5ab@oss.qualcomm.com>
 <20260416191855.GA25147@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416191855.GA25147@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_041118_687688_863C9D97 
X-CRM114-Status: GOOD (  40.63  )
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

On Thu, Apr 16, 2026 at 02:18:55PM -0500, Bjorn Helgaas wrote:
> [+cc Rafael]
> 
> On Tue, Apr 14, 2026 at 09:29:39PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > Currently, the PCI endpoint drivers like NVMe checks whether the device
> > context will be retained or not during system suspend, with the help of
> > pm_suspend_via_firmware() API.
> > 
> > But it is possible that the device context might be lost due to some
> > platform limitation as well. Having those checks in the endpoint drivers
> > will not scale and will cause a lot of code duplication.
> > 
> > So introduce an API that acts as a sole point of truth that the endpoint
> > drivers can rely on to check whether they can expect the device context
> > to be retained or not.
> > 
> > If the API returns 'false', then the client drivers need to prepare for
> > context loss by performing actions such as resetting the device, saving
> > the context, shutting it down etc... If it returns 'true', then the drivers
> > do not need to perform any special action and can leave the device in
> > active state.
> > 
> > Right now, this API only incorporates the pm_suspend_via_firmware() check.
> > But will be extended in the future commits.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/pci.c   | 23 +++++++++++++++++++++++
> >  include/linux/pci.h |  7 +++++++
> >  2 files changed, 30 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 8479c2e1f74f..211616467a77 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -33,6 +33,7 @@
> >  #include <asm/dma.h>
> >  #include <linux/aer.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/suspend.h>
> >  #include "pci.h"
> >  
> >  DEFINE_MUTEX(pci_slot_mutex);
> > @@ -2900,6 +2901,28 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
> >  		pm_runtime_put_sync(parent);
> >  }
> >  
> > +/**
> > + * pci_dev_suspend_retention_supported - Check if the platform can retain the device
> > + *					 context during system suspend
> > + * @pdev: PCI device to check
> > + *
> > + * Returns true if the platform can guarantee to retain the device context,
> > + * false otherwise.
> > + */
> > +bool pci_dev_suspend_retention_supported(struct pci_dev *pdev)
> 
> This doesn't seem like the right name.  This isn't a property of the
> *device*; that's all determined by the PCI spec (devices must retain
> all internal state in D0, D1, and D2, they retain it in D3hot if
> No_Soft_Reset, and they never do in D3cold).
> 
> So this seems like something to do with the *platform* behavior.  It
> sounds like this is basically a way to learn whether the device might
> be put in D3cold on system suspend.
> 

That's correct. But I wanted to keep it device specific, since apart from
pm_suspend_via_firmware() there could be other issues causing context to be
lost. Like the issue with RC, brought up in the successive patches. There could
be chances that only one hierarchy might be affected. So making it device
specific would give us the granularity.

- Mani

> > +{
> > +	/*
> > +	 * If the platform firmware (like ACPI) is involved at the end of system
> > +	 * suspend, device context may not be retained.
> > +	 */
> > +	if (pm_suspend_via_firmware())
> > +		return false;
> > +
> > +	/* Assume that the context is retained by default */
> > +	return true;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_dev_suspend_retention_supported);
> > +
> >  static const struct dmi_system_id bridge_d3_blacklist[] = {
> >  #ifdef CONFIG_X86
> >  	{
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 1c270f1d5123..d9bc7ad4eaa4 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -2080,6 +2080,8 @@ pci_release_mem_regions(struct pci_dev *pdev)
> >  			    pci_select_bars(pdev, IORESOURCE_MEM));
> >  }
> >  
> > +bool pci_dev_suspend_retention_supported(struct pci_dev *pdev);
> > +
> >  #else /* CONFIG_PCI is not enabled */
> >  
> >  static inline void pci_set_flags(int flags) { }
> > @@ -2239,6 +2241,11 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> >  static inline void pci_free_irq_vectors(struct pci_dev *dev)
> >  {
> >  }
> > +
> > +static inline bool pci_dev_suspend_retention_supported(struct pci_dev *pdev)
> > +{
> > +	return true;
> > +}
> >  #endif /* CONFIG_PCI */
> >  
> >  /* Include architecture-dependent settings and functions */
> > 
> > -- 
> > 2.51.0
> > 
> > 

-- 
மணிவண்ணன் சதாசிவம்

