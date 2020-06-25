Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC28FC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 11:31:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFBFC207BB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 11:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SxpvjNM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBFC207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mg20NoH38DXNWmwN94fTSKJ7sFmvmJjGnsKaPrWrGWs=; b=SxpvjNM3oiJW/OoZNp/vMPt1Z
	SZLjbwmpWcFWN3nEhhzS2ZgINRsCwzeZRz9BmH9JVzthsVziGANmukFGPtOVeDsYBw/nuVrXJ/l2P
	o/KpYrEjShYWq/xJ7uZhjjNYIyP3rY+SHOLOU1Eg8e/7xE+3Y5OwKZKBjXzVNSgeFRyib1Hc/CSSm
	kY8nlru+xPT1Qdj+ufscuy3rtdz5uAKx3+VcWRcMMLwUrPW4icc3IYrnjCTcbyFt21ANS4GF17ryf
	2u9i3GGtiqPB+Pvwf1vTMsrwWWvsDrlLo/uelut5iVNrx4ijQwZBU8w/qq0QwQeSVByihoL+cLrDn
	JcFAXv+4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joQ5z-00028j-NS; Thu, 25 Jun 2020 11:31:07 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joQ5x-00028L-Bb
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 11:31:06 +0000
Received: by mail-oi1-f194.google.com with SMTP id a3so4661703oid.4
 for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2020 04:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ceR1V6p7RGNF++3XLjRXzuggrknx1RWLDfnDURTRa10=;
 b=sND8m2knnLQSVmyPbVR4czG0lVTNYIKiYBG+rdOfCRHDQVte9MlEvtAi/qJb4yIXyM
 MYxmalN0FHvWDY/VLuDjB53T+HKbYv1Xlmz42Ntrfq4Tsn7wXDcBfa6aFqfGIJtNwG24
 88PtUCa9mJqQbwe4vaPjiXYSjg9v3VF5je1eaxV7jH1j+ojxjXCtaeVFXGAWNoRcHDYX
 D+A4t8QFTDuAhiljHBp+LTs/V46oVJHKzChFQR4Rb4uEvD3HkomJ4Y5V4k/RPqWHMsw3
 fMEZ02XTih8LVowf0GYbHZgNqtyPRE24/rjYZqhoHT2kjbAgq0QBLLpHYhB9jJ+rGuvz
 6lMQ==
X-Gm-Message-State: AOAM530ylsYWIUWmVg9FpfGjsOFZwiEiijvOMsQsseJDTbNI72WLN9XY
 cq2fX63kMCqhgg94naPObR3jAK2ooIqlMz8dfpc=
X-Google-Smtp-Source: ABdhPJyklNBNQHH5j4xZ+MpbLP5vgIKFp9exs0rtM1iu2YH+8Aw6RTM6P9vtPnorNsBYobo61Jnpn1Fur6T/ALSpXvY=
X-Received: by 2002:a54:4585:: with SMTP id z5mr1822683oib.110.1593084664345; 
 Thu, 25 Jun 2020 04:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200612204820.20111-2-david.e.box@linux.intel.com>
 <20200624211549.GA2586552@bjorn-Precision-5520>
In-Reply-To: <20200624211549.GA2586552@bjorn-Precision-5520>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Jun 2020 13:30:53 +0200
Message-ID: <CAJZ5v0i8dCN=HMFk_+ZX-Wr73P6kdQBtV0i3FtrZrO9cegXsvQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] PCI: Add ACPI StorageD3Enable _DSD support
To: Bjorn Helgaas <helgaas@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
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
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, shyjumon.n@intel.com,
 Keith Busch <kbusch@kernel.org>, "David E. Box" <david.e.box@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 11:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jun 12, 2020 at 01:48:19PM -0700, David E. Box wrote:
> > StorageD3Enable is a boolean property that indicates that the platform
> > wants to use D3 for PCIe storage drives during suspend-to-idle. It is a
> > BIOS work around that is currently in use on shipping systems like some
> > Intel Comet Lake platforms. It is meant to change default driver policy for
> > suspend that may cause higher power consumption.
> >
> > Add the DSD property for recognition by fwnode calls and provide an
> > exported symbol for device drivers to use to read the property as needed.
> >
> > Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >  drivers/acpi/property.c |  3 +++
> >  drivers/pci/pci-acpi.c  | 59 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci.h     |  2 ++
> >  3 files changed, 64 insertions(+)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index e601c4511a8b..c2e2ae774a19 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -45,6 +45,9 @@ static const guid_t prp_guids[] = {
> >       /* Thunderbolt GUID for WAKE_SUPPORTED: 6c501103-c189-4296-ba72-9bf5a26ebe5d */
> >       GUID_INIT(0x6c501103, 0xc189, 0x4296,
> >                 0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
> > +     /* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
> > +     GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
> > +               0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
> >  };
> >
> >  /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index d21969fba6ab..732df524e09c 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -972,6 +972,65 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >       return val == 1;
> >  }
> >
> > +/**
> > + * pci_acpi_storage_d3 - whether root port requests D3 for idle suspend
> > + * @pdev: PCI device to check
> > + *
> > + * Returns true if the ACPI companion device contains the "StorageD3Enable"
> > + * _DSD property and the value is 1. This indicates that the root port is
> > + * used by a storage device and the platform is requesting D3 for the
> > + * device during suspend to idle in order to support platform pm.
> > + */
> > +bool pci_acpi_storage_d3(struct pci_dev *dev)
> > +{
> > +     const struct fwnode_handle *fwnode;
> > +     struct acpi_device *adev;
> > +     struct pci_dev *root;
> > +     acpi_handle handle;
> > +     acpi_status status;
> > +     bool ret = false;
> > +     u8 val;
> > +
> > +     /*
> > +      * Look for _DSD property specifying that the storage device on
> > +      * the port must use D3 to support deep platform power savings during
> > +      * suspend-to-idle
> > +      */
> > +     root = pci_find_pcie_root_port(dev);
>
> I think this would need to be updated to apply to v5.8-rc1 after
> 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and
> pci_find_pcie_root_port()").
>
> https://git.kernel.org/linus/6ae72bfa656e
>
> > +     if (!root)
> > +             return false;
> > +
> > +     adev = ACPI_COMPANION(&root->dev);
> > +     if (!adev) {
> > +             /*
> > +              * It is possible that the ACPI companion is not yet bound
> > +              * for the root port so look it up manually here.
> > +              */
> > +             if (!adev && !pci_dev_is_added(root))
> > +                     adev = acpi_pci_find_companion(&root->dev);
>
> I see that you copied this "ACPI companion not yet bound" thing from
> acpi_pci_bridge_d3().  But it's ugly.
>
> Isn't there a way we can bind the ACPI companion during normal PCI
> enumeration so we don't need this exception case?
>
> I really do not like the idea of putting this code in the PCI core
> because AFAICT the PCI core can do nothing with this information.
>
> If we could make sure during enumeration that the root port always has
> an ACPI companion, this code could go to the nvme driver itself.  And
> we could also clean up the ugliness in acpi_pci_bridge_d3().
>
> Rafael, is that possible?  I don't really know how the companion
> device gets set.

That's a bit convoluted.

device_add() calls device_platform_notify(), before calling bus_add_device().

device_platform_notify() calls acpi_platform_notify() which invokes
acpi_device_notify() that looks for the companion via
type->find_companion() which for PCI points to
acpi_pci_find_companion().  If found, the companion is attached to the
dev structure as a physical_node, via acpi_bind_one().

So by the time bus_probe_device() runs, the companion should be there
already - if it is there at all.

The parent ACPI companion should be present when the child is probing
too, as per the above.

> Maybe this is could be done somewhere around pci_device_add()?

It is done in there.

It is not necessary to call acpi_pci_find_companion() from
pci_acpi_storage_d3() as long as that function is required to be
called by the target device's driver probe or later.

Ths acpi_pci_bridge_d3() case is different, though, AFAICS, because it
is invoked in the pci_pm_init() path, via pci_bridge_d3_possible(),
and that gets called from pci_device_add() *before* calling
device_add().

Mika, is that why acpi_pci_find_companion() gets callled from
acpi_pci_bridge_d3()?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
