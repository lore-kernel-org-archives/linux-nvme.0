Return-Path: <SRS0=/gup=YB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FAKE_REPLY_C,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34383C10F14
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 21:17:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0387F21721
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 21:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jEego9Np";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWsX2rDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0387F21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=aiswCY3hZN+C4qym3ByENpnrN1bE197BKqnfdJWaA9k=; b=jEego9NpHwx5jK
	4ckQBBFWwg2FwsjQfQctNsD0RM53rC4f+oDZFry/7GbMPnrlXWD1MIzHYZ1FN32pCF4U5UEiKnxTR
	TlcY6ih4jiVREhD/WMZrHy/C6vy06EBy2zDAsENv4MDVgCYPrkA4tFz6r08H9Z8wMBiYLz6lwysQZ
	deE18PIB7trVIR4Gz1oOaP6MuprHPbzF7OjwKgwg3Dr9R6/7/MANKrCAZK/KusuK7JkzpDW6BV9uQ
	7G+UGXEYGvTXGmC3KdS2hCRZBmPpILgoGTk2MWGOlJbBhAQ/xJu9WleaWuxjySMDOkVIVFy3zQBwD
	Plf4IWNyt1hT8Ol8hUjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHwqr-00080H-NB; Tue, 08 Oct 2019 21:17:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHwqo-0007zb-QX
 for linux-nvme@lists.infradead.org; Tue, 08 Oct 2019 21:17:00 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B0D0121721;
 Tue,  8 Oct 2019 21:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570569418;
 bh=Uqjzv4/P9OatGQAy44pX7Dr8dKQk8lXYGW74iZDcG4Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=lWsX2rDSQspNs1nahOSrFjhf8LzrmfUK4rnKcRSmKWoYPeMd7QazDZl+mE5hMlzN+
 lOMGd6B0PHzFWgjeZbtyG+Ns0nazdRWbh+Cwy6NXB0BdsQ3l3O+vzZfQLBlP/ee2VQ
 MoEDHX97hkbN2uWl8X1poEgNuuLN8mLLSqedIk/w=
Date: Tue, 8 Oct 2019 16:16:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: PCIe: ASPM: Introduce pcie_aspm_enabled()
Message-ID: <20191008211656.GA163302@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iL4Rv=AQ-Qnma=wWaqBBbOdfRqu9uS9Gesa-G75oQpzQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191008_141658_901678_9FDD6DB7 
X-CRM114-Status: GOOD (  23.88  )
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

On Tue, Oct 08, 2019 at 11:27:51AM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 8, 2019 at 12:34 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Aug 08, 2019 at 11:55:07PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Add a function checking whether or not PCIe ASPM has been enabled for
> > > a given device.
> > >
> > > It will be used by the NVMe driver to decide how to handle the
> > > device during system suspend.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > v2 -> v3:
> > >   * Make the new function return bool.
> > >   * Change its name back to pcie_aspm_enabled().
> > >   * Fix kerneldoc comment formatting.
> > >
> > > -> v2:
> > >   * Move the PCI/PCIe ASPM changes to a separate patch.
> > >   * Add the _mask suffix to the new function name.
> > >   * Add EXPORT_SYMBOL_GPL() to the new function.
> > >   * Avoid adding an unnecessary blank line.
> > >
> > > ---
> > >  drivers/pci/pcie/aspm.c |   20 ++++++++++++++++++++
> > >  include/linux/pci.h     |    3 +++
> > >  2 files changed, 23 insertions(+)
> > >
> > > Index: linux-pm/drivers/pci/pcie/aspm.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/pci/pcie/aspm.c
> > > +++ linux-pm/drivers/pci/pcie/aspm.c
> > > @@ -1170,6 +1170,26 @@ static int pcie_aspm_get_policy(char *bu
> > >  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
> > >       NULL, 0644);
> > >
> > > +/**
> > > + * pcie_aspm_enabled - Check if PCIe ASPM has been enabled for a device.
> > > + * @pci_device: Target device.
> > > + */
> > > +bool pcie_aspm_enabled(struct pci_dev *pci_device)
> > > +{
> > > +     struct pci_dev *bridge = pci_upstream_bridge(pci_device);
> > > +     bool ret;
> > > +
> > > +     if (!bridge)
> > > +             return false;
> > > +
> > > +     mutex_lock(&aspm_lock);
> > > +     ret = bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
> > > +     mutex_unlock(&aspm_lock);
> >
> > Why do we need to acquire aspm_lock here?  We aren't modifying
> > anything, and I don't think we're preventing a race.  If this races
> > with another thread that changes aspm_enabled, we'll return either the
> > old state or the new one, and I think that's still the case even if we
> > don't acquire aspm_lock.
> 
> Well, if we can guarantee that pci_remove_bus_device() will never be
> called in parallel with this helper, then I agree, but can we
> guarantee that?

Hmm, yeah, I guess that's the question.  It's not a race with another
thread changing aspm_enabled; the potential race is with another
thread removing the last child of "bridge", which will free the
link_state and set bridge->link_state = NULL.

I think it should be safe to call device-related PCI interfaces if
you're holding a reference to the device, e.g., from a driver bound to
the device or a sysfs accessor.  Since we call pcie_aspm_enabled(dev)
from a driver bound to "dev", another thread should not be able to
remove "dev" while we're using it.

I know that's a little hand-wavey, but if it weren't true, I think
we'd have a lot more locking sprinkled everywhere in the PCI core than
we do.

This has implications for Heiner's ASPM sysfs patches because we're
currently doing this in sysfs accessors:

  static ssize_t aspm_attr_show_common(struct device *dev, ...)
  {
    ...
    link = pcie_aspm_get_link(pdev);

    mutex_lock(&aspm_lock);
    enabled = link->aspm_enabled & state;
    mutex_unlock(&aspm_lock);
    ...
  }

I assume sysfs must be holding a reference that guarantees "dev" is
valid througout this code, and therefore we should not need to hold
aspm_lock.

Bjorn

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
