Return-Path: <SRS0=7vxi=YC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FAKE_REPLY_C,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87484ECE58D
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 12:49:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BBF721835
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 12:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="soevJ53L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH2fwKYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBF721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=6bvPoERNx/yknr8ulsZzKuzqjVxt2nzG6zO2yMgwmEQ=; b=soevJ53L3nox7b
	JSsO1/Xj12JHsXHYImuj3pMVwcoFzfexdVh6l9dlgWBjRz/fc9VqCu0jW2AwG7DGaj2ASnjRDgtyO
	aH2xRsLpPCHolSwAMvDCiI0fm/y0ZwsZoR4MpGcVac021AjNte9uh/h+Fsj8LB+H9qjNpwlFvWbOQ
	uiIVL978TYq+IJjJx96V14apjEFLPAFQs65o8rtkjRuFNdgBfOn1AqfhA4k+Ls4fDP3sIeRxctLQ5
	kvPpw+9wlRvk7twEgp7cdxmIOUwsfQ0dwD2v/ZcwF1mZlT1rPLP16jb0DoehXo6DLADU534myFCrY
	FVjd/l1wWcbF9sQ4GOmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iIBPW-0000LH-4J; Wed, 09 Oct 2019 12:49:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIBPR-0000Ko-TN
 for linux-nvme@lists.infradead.org; Wed, 09 Oct 2019 12:49:43 +0000
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C2C920B7C;
 Wed,  9 Oct 2019 12:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570625380;
 bh=BS4jso9hypNio5lXJwUJxoGbh/2wvN6PY7GhM+KUNGo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=jH2fwKYGgUAT3yvVwlPaj40RpZcpMd28Pv1P0XTRASzDbfUec6elVvevVNgQPnl5L
 SUolQjQLJky2IL2PxOIjStpZNm3Mnb717g61/tSzlO+i2tTIQjv1Iuy6WMQv+h9rJA
 n0oJqlQTsS8MU9UPyPVj6ija2LN0Ad0y9AwzM7es=
Date: Wed, 9 Oct 2019 07:49:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: PCIe: ASPM: Introduce pcie_aspm_enabled()
Message-ID: <20191009124938.GA67585@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j-uSM2gheHViommWcrSaLVfzbwV3M7OOWz3GyzhHSwRA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191009_054941_988194_E2011168 
X-CRM114-Status: GOOD (  32.39  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Mario Limonciello <Mario.Limonciello@dell.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Keith Busch <kbusch@kernel.org>,
 Rajat Jain <rajatja@google.com>, Christoph Hellwig <hch@lst.de>,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 09, 2019 at 12:54:37AM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 8, 2019 at 11:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, Oct 08, 2019 at 11:27:51AM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Oct 8, 2019 at 12:34 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Thu, Aug 08, 2019 at 11:55:07PM +0200, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Add a function checking whether or not PCIe ASPM has been enabled for
> > > > > a given device.
> > > > >
> > > > > It will be used by the NVMe driver to decide how to handle the
> > > > > device during system suspend.
> > > > >
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >
> > > > > v2 -> v3:
> > > > >   * Make the new function return bool.
> > > > >   * Change its name back to pcie_aspm_enabled().
> > > > >   * Fix kerneldoc comment formatting.
> > > > >
> > > > > -> v2:
> > > > >   * Move the PCI/PCIe ASPM changes to a separate patch.
> > > > >   * Add the _mask suffix to the new function name.
> > > > >   * Add EXPORT_SYMBOL_GPL() to the new function.
> > > > >   * Avoid adding an unnecessary blank line.
> > > > >
> > > > > ---
> > > > >  drivers/pci/pcie/aspm.c |   20 ++++++++++++++++++++
> > > > >  include/linux/pci.h     |    3 +++
> > > > >  2 files changed, 23 insertions(+)
> > > > >
> > > > > Index: linux-pm/drivers/pci/pcie/aspm.c
> > > > > ===================================================================
> > > > > --- linux-pm.orig/drivers/pci/pcie/aspm.c
> > > > > +++ linux-pm/drivers/pci/pcie/aspm.c
> > > > > @@ -1170,6 +1170,26 @@ static int pcie_aspm_get_policy(char *bu
> > > > >  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
> > > > >       NULL, 0644);
> > > > >
> > > > > +/**
> > > > > + * pcie_aspm_enabled - Check if PCIe ASPM has been enabled for a device.
> > > > > + * @pci_device: Target device.
> > > > > + */
> > > > > +bool pcie_aspm_enabled(struct pci_dev *pci_device)
> > > > > +{
> > > > > +     struct pci_dev *bridge = pci_upstream_bridge(pci_device);
> > > > > +     bool ret;
> > > > > +
> > > > > +     if (!bridge)
> > > > > +             return false;
> > > > > +
> > > > > +     mutex_lock(&aspm_lock);
> > > > > +     ret = bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
> > > > > +     mutex_unlock(&aspm_lock);
> > > >
> > > > Why do we need to acquire aspm_lock here?  We aren't modifying
> > > > anything, and I don't think we're preventing a race.  If this races
> > > > with another thread that changes aspm_enabled, we'll return either the
> > > > old state or the new one, and I think that's still the case even if we
> > > > don't acquire aspm_lock.
> > >
> > > Well, if we can guarantee that pci_remove_bus_device() will never be
> > > called in parallel with this helper, then I agree, but can we
> > > guarantee that?
> >
> > Hmm, yeah, I guess that's the question.  It's not a race with another
> > thread changing aspm_enabled; the potential race is with another
> > thread removing the last child of "bridge", which will free the
> > link_state and set bridge->link_state = NULL.
> >
> > I think it should be safe to call device-related PCI interfaces if
> > you're holding a reference to the device, e.g., from a driver bound to
> > the device or a sysfs accessor.  Since we call pcie_aspm_enabled(dev)
> > from a driver bound to "dev", another thread should not be able to
> > remove "dev" while we're using it.
> >
> > I know that's a little hand-wavey, but if it weren't true, I think
> > we'd have a lot more locking sprinkled everywhere in the PCI core than
> > we do.
> >
> > This has implications for Heiner's ASPM sysfs patches because we're
> > currently doing this in sysfs accessors:
> >
> >   static ssize_t aspm_attr_show_common(struct device *dev, ...)
> >   {
> >     ...
> >     link = pcie_aspm_get_link(pdev);
> >
> >     mutex_lock(&aspm_lock);
> >     enabled = link->aspm_enabled & state;
> >     mutex_unlock(&aspm_lock);
> >     ...
> >   }
> >
> > I assume sysfs must be holding a reference that guarantees "dev" is
> > valid througout this code, and therefore we should not need to hold
> > aspm_lock.
> 
> In principle, pcie_aspm_enabled() need not be called via sysfs.
> 
> In the particular NVMe use case, it is called from the driver's own PM
> callback, so it would be safe without the locking AFAICS.

Right, pcie_aspm_enabled() is only used by drivers (actually only by
the nvme driver so far).  And aspm_attr_show_common() is only used via
new sysfs code being added by Heiner.

> I guess it is safe to drop the locking from there, but then it would
> be good to mention in the kerneldoc that calling it is only safe under
> the assumption that the link_state object cannot go away while it is
> running.

I'll post a patch to that effect.  Thanks!

Bjorn

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
