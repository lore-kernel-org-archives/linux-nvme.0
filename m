Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DD7C2BA1A
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 20:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=0KIIkB9fhcgxzd8JQWKQwkhIAzIDd9dkel10Bf8Vh40=; b=wEAhJOtTHHIt/zI9aN+702kqXb
	Wi1q1dlapLLaCCJoDxOIZohi3y82Ebz3VMbQZwrH91QC59+EagNXKMCKwRGZMOYuJw76zg5anp4y/
	zHV19oC4AewKMy0ZEgAmPBrnhzsopQ3ufuVPsBms5EZOasX3q61rmoCy6w+OfKaB/KKOIhX9LIujt
	uEGECCjPiDiJNWHwedTLdi9SAEUO3M5u2qlAmHMECokgPwSkOq3tuXzgcb+RAoH85LeWybze1sEMf
	iabjG8UG07ii0HNrdcC397eyesjnf2BrXxZ+lMit5kP2NTjrBHvrbZhdC6kN6uc1g4EhAEAVrNN7z
	En3pJhMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJflU-0000000GYZA-3guQ;
	Tue, 18 Jun 2024 20:49:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJflT-0000000GYY6-0WqQ
	for linux-nvme@bombadil.infradead.org;
	Tue, 18 Jun 2024 20:49:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:References;
	bh=0KIIkB9fhcgxzd8JQWKQwkhIAzIDd9dkel10Bf8Vh40=; b=gRrlOOOZwnzLMqt3yhLcaXWvAe
	n84Yl2lTAQ1fnzfucGA5HL4hQLfkTetl1Qkf+a+WZMQnvc368HJQ6vvNRDKkt//hnIKXgSGFZX59v
	ijfaZ36mi6bKjO0exZP0Dqw+8FTmbGWayIrsyZh+6AQmdGnXvzQPtt8PPmlwDOp/LSerpJhL3nSLZ
	5iXlfiDwlZe+cFxNcSTf+deBmlw+DHzp50bEUfounT02Ql9QiOsyU4PQKFegxBoOR7lZvbzDVKbbM
	gu+t/XXIwSMC+ObcKNV2goqWZWDGJ1bURv+RsDKveO+sQKS/q/9oby3A3QYVTb5PI8KnvFtKVuQtQ
	mGcHcWJg==;
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJfl3-00000007Ddm-3E3P
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 20:49:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8E1CECE12BE;
	Tue, 18 Jun 2024 20:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87306C3277B;
	Tue, 18 Jun 2024 20:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718743719;
	bh=vifOR8wqTe33GN1ZxE0aE3JJoX2X6ojZd3vgLTYu4qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kkroOP1XahDe8y0PCYQZWwyr7NzPoNIwKnMyP+cVjWRCKFcCxKBzRGDNp5obZrYbz
	 TXvRrpIY6765aIvN+9QFQnMrnolLmfu4CvKLK7bKU1bY4quBie2SutBEJe4aty31YW
	 46peRLKOHaHiKEX9ERj/dQSuM/jhak/eoJ05OYZUB2jh7Nr0wShO63IhXLoT/4I5hU
	 /GzijQeVV3O7i0uDFm9QjeJHWAIhkUsrRqB83M7ASE/xRb/Aj64+dtmUD6SN8zZ5CE
	 cnAZbMmfem036ZIZuOAsM99HquNtT9GWtVtxfwcD78kDR96olXaYPTHaR4isWpg+AR
	 IpRfOm6YY/erQ==
Date: Tue, 18 Jun 2024 15:48:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bagasdotme@gmail.com,
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org,
	kch@nvidia.com, hch@lst.de, gloriouseggroll@gmail.com,
	kbusch@kernel.org, sagi@grimberg.me, hare@suse.de
Subject: Re: [PATCH v8 2/3] PCI/AER: Disable AER service on suspend
Message-ID: <20240618204837.GA1262769@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p7O51mG7LMrEobEgGrD8tsDFO3ZFSPAu02Dk-R0W3mkvg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_214904_902297_C7FC10D7 
X-CRM114-Status: GOOD (  48.14  )
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

On Thu, Apr 25, 2024 at 03:33:01PM +0800, Kai-Heng Feng wrote:
> On Fri, Apr 19, 2024 at 4:35 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, Apr 16, 2024 at 12:32:24PM +0800, Kai-Heng Feng wrote:
> > > When the power rail gets cut off, the hardware can create some electric
> > > noise on the link that triggers AER. If IRQ is shared between AER with
> > > PME, such AER noise will cause a spurious wakeup on system suspend.
> > >
> > > When the power rail gets back, the firmware of the device resets itself
> > > and can create unexpected behavior like sending PTM messages. For this
> > > case, the driver will always be too late to toggle off features should
> > > be disabled.
> > >
> > > As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power
> > > Management", TLP and DLLP transmission are disabled for a Link in L2/L3
> > > Ready (D3hot), L2 (D3cold with aux power) and L3 (D3cold) states. So if
> > > the power will be turned off during suspend process, disable AER service
> > > and re-enable it during the resume process. This should not affect the
> > > basic functionality.
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=209149
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=218090
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >
> > Thanks for reviving this series.  I tried follow the history about
> > this, but there are at least two series that were very similar and I
> > can't put it all together.
> >
> > > ---
> > > v8:
> > >  - Add more bug reports.
> > >
> > > v7:
> > >  - Wording
> > >  - Disable AER completely (again) if power will be turned off
> > >
> > > v6:
> > > v5:
> > >  - Wording.
> > >
> > > v4:
> > > v3:
> > >  - No change.
> > >
> > > v2:
> > >  - Only disable AER IRQ.
> > >  - No more check on PME IRQ#.
> > >  - Use helper.
> > >
> > >  drivers/pci/pcie/aer.c | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > index ac6293c24976..bea7818c2d1b 100644
> > > --- a/drivers/pci/pcie/aer.c
> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -28,6 +28,7 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/kfifo.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/suspend.h>
> > >  #include <acpi/apei.h>
> > >  #include <acpi/ghes.h>
> > >  #include <ras/ras_event.h>
> > > @@ -1497,6 +1498,28 @@ static int aer_probe(struct pcie_device *dev)
> > >       return 0;
> > >  }
> > >
> > > +static int aer_suspend(struct pcie_device *dev)
> > > +{
> > > +     struct aer_rpc *rpc = get_service_data(dev);
> > > +     struct pci_dev *pdev = rpc->rpd;
> > > +
> > > +     if (pci_ancestor_pr3_present(pdev) || pm_suspend_via_firmware())
> > > +             aer_disable_rootport(rpc);
> >
> > Why do we check pci_ancestor_pr3_present(pdev) and
> > pm_suspend_via_firmware()?  I'm getting pretty convinced that we need
> > to disable AER interrupts on suspend in general.  I think it will be
> > better if we do that consistently on all platforms, not special cases
> > based on details of how we suspend.
> 
> Sure. Will change in next revision.
> 
> > Also, why do we use aer_disable_rootport() instead of just
> > aer_disable_irq()?  I think it's the interrupt that causes issues on
> > suspend.  I see that there *were* some versions that used
> > aer_disable_irq(), but I can't find the reason it changed.
> 
> Interrupt can cause system wakeup, if it's shared with PME.
> 
> The reason why aer_disable_rootport() is used over aer_disable_irq()
> is that when the latter is used the error still gets logged during
> sleep cycle. Once the pcieport driver resumes, it invokes
> aer_root_reset() to reset the hierarchy, while the hierarchy hasn't
> resumed yet.
> 
> So use aer_disable_rootport() to prevent such issue from happening.

I think the issue is more likely on the resume side.

aer_disable_rootport() disables AER interrupts, then clears
PCI_ERR_ROOT_STATUS, so the path looks like this:

  aer_suspend
    aer_disable_rootport
      aer_disable_irq()
      pci_write_config_dword(PCI_ERR_ROOT_STATUS)    # clear

This happens during suspend, so at this point I think the link is
still active and the spurious AER errors haven't happened yet and it
probably doesn't matter that we clear PCI_ERR_ROOT_STATUS *here*.

My guess is that what really matters is that we disable the AER
interrupt so it doesn't happen during suspend, and then when we
resume, we probably want to clear out the status registers before
re-enabling the AER interrupt.

In any event, I think we need to push this forward.  I'll post a v9
based on this but dropping the pci_ancestor_pr3_present(pdev) and
pm_suspend_via_firmware() tests so we do this unconditionally.

> > > +     return 0;
> > > +}
> > > +
> > > +static int aer_resume(struct pcie_device *dev)
> > > +{
> > > +     struct aer_rpc *rpc = get_service_data(dev);
> > > +     struct pci_dev *pdev = rpc->rpd;
> > > +
> > > +     if (pci_ancestor_pr3_present(pdev) || pm_resume_via_firmware())
> > > +             aer_enable_rootport(rpc);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  /**
> > >   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> > >   * @dev: pointer to Root Port, RCEC, or RCiEP
> > > @@ -1561,6 +1584,8 @@ static struct pcie_port_service_driver aerdriver = {
> > >       .service        = PCIE_PORT_SERVICE_AER,
> > >
> > >       .probe          = aer_probe,
> > > +     .suspend        = aer_suspend,
> > > +     .resume         = aer_resume,
> > >       .remove         = aer_remove,
> > >  };
> > >
> > > --
> > > 2.34.1
> > >

