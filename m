Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA4C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 21:24:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E98206BE
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 21:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HiSqEacV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E98206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZDXGAJ8zCRCs9k3rdnfW6y8ICk4gimT3fpr96pBh7Lg=; b=HiSqEacVz3OQ1B5fj8x1aH7XD/
	qmpmYydyma6wc+WfOlptgLVzvIRaDqM+erHd4BYMCUmQb0/Cm34xLaDs48gpfMPBFa0HZY0cOINDH
	ziiOmJvK8IdDQm5WDAkzXpUhSn8bhbvgWEWkE6tM4OzBeKShU63csotSntZw8qm4ESjI2vwtuNfCO
	ZS3fQwJHe4Cojn+/Q1FF7SHlEQ+Cj4syGqm9lziovYl61EswSH9A+dbIKxaw7+sglECcBN9wkQyn6
	9Ue7ZULCvbBHhi75YQiUIDhGK8vBG9doIegU8VtuRNeOJxJUDnmhjCL2KYsf3a7biOdpwRxJ49RQe
	uDUZ/9wA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsv54-0007Sc-Um; Tue, 07 Jul 2020 21:24:46 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsv50-0007S7-5H
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 21:24:43 +0000
IronPort-SDR: gsKSwvbeZ3sXgRmVD3oZiyXCPgEWsaJLMoWp4V0T4uGbMetQE4p6yDapWOXovG6HmZ+HBEz6nE
 CsnpzrCOJKtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="209226064"
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; d="scan'208";a="209226064"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 14:24:32 -0700
IronPort-SDR: Qkmn4wSntn37RbEtWnsNsY6QDV+ZNtUJJ3Wg94H9QgCsFTy1T0uotSF9/siKuUkKAK2apt4DUF
 sb3LTU32mAdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; d="scan'208";a="483202700"
Received: from linux.intel.com ([10.54.29.200])
 by fmsmga006.fm.intel.com with ESMTP; 07 Jul 2020 14:24:31 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com
 [10.7.201.137])
 by linux.intel.com (Postfix) with ESMTP id DAF5E5807C8;
 Tue,  7 Jul 2020 14:24:31 -0700 (PDT)
Message-ID: <1c75a6ba5d0b84dd868e350674f8565fa9154147.camel@linux.intel.com>
Subject: Re: [PATCH v4] drivers/nvme: Add support for ACPI StorageD3Enable
 property
From: "David E. Box" <david.e.box@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 07 Jul 2020 14:24:31 -0700
In-Reply-To: <CAJZ5v0hC5OZQ+SpP4Pp99OvMjQCQ8M6_bkfMd_8nnuNNSh9q0w@mail.gmail.com>
References: <20200612204820.20111-1-david.e.box@linux.intel.com>
 <20200702225011.10932-1-david.e.box@linux.intel.com>
 <CAJZ5v0hC5OZQ+SpP4Pp99OvMjQCQ8M6_bkfMd_8nnuNNSh9q0w@mail.gmail.com>
Organization: David E. Box
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_172442_667650_3E10C0B1 
X-CRM114-Status: GOOD (  42.73  )
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
Reply-To: david.e.box@linux.intel.com
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, "Rafael
 J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, shyjumon.n@intel.com,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2020-07-06 at 16:57 +0200, Rafael J. Wysocki wrote:
> On Fri, Jul 3, 2020 at 12:49 AM David E. Box
> <david.e.box@linux.intel.com> wrote:
> > This patch implements a solution for a BIOS hack used on some
> > currently
> > shipping Intel systems to change driver power management policy for
> > PCIe
> > NVMe drives. Some newer Intel platforms, like some Comet Lake
> > systems,
> > require that PCIe devices use D3 when doing suspend-to-idle in
> > order to
> > allow the platform to realize maximum power savings. This is
> > particularly
> > needed to support ATX power supply shutdown on desktop systems. In
> > order to
> > ensure this happens for root ports with storage devices, Microsoft
> > apparently created this ACPI _DSD property as a way to influence
> > their
> > driver policy. To my knowledge this property has not been discussed
> > with
> > the NVME specification body.
> > 
> > Though the solution is not ideal, it addresses a problem that also
> > affects
> > Linux since the NVMe driver's default policy of using NVMe APST
> > during
> > suspend-to-idle prevents the PCI root port from going to D3 and
> > leads to
> > higher power consumption for these platforms. The power consumption
> > difference may be negligible on laptop systems, but many watts on
> > desktop
> > systems when the ATX power supply is blocked from powering down.
> > 
> > The patch creates a new nvme_acpi_storage_d3 function to check for
> > the
> > StorageD3Enable property during probe and enables D3 as a quirk if
> > set.  It
> > also provides a 'noacpi' module parameter to allow skipping the
> > quirk if
> > needed.
> > 
> > Tested on:
> > PM961 NVMe SED Samsung 512GB
> > INTEL SSDPEKKF512G8
> > 
> > Link: 
> > https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> > Changes from V3:
> >         - Use pcie_find_root_port() instead of
> > pci_find_pcie_root_port(),
> >           changed in 5.8.
> >         - Remove "Cc:" emails that ended up at top of V3 commit
> > message.
> >         - Fix changelog numbering.
> > 
> > Changes from V2:
> >         - Remove check for "not yet bound" ACPI companion device
> > since
> >           this will not be a concern at driver probe time per
> > Rafael.
> >         - Move storage_d3 function out of PCI core and into NVMe
> > driver
> >           since there's nothing the PCI core can do with this code
> > as
> >           noted by Bjorn.
> > 
> > Changes from V1:
> >         - Export the pci_acpi_storage_d3 function for use by
> > drivers as
> >           needed instead of modifying the pci header.
> >         - Add missing put on acpi device handle.
> >         - Add 'noacpi' module parameter to allow undoing this
> > change.
> >         - Add info message that this is a platform quirk.
> > 
> >  drivers/acpi/property.c |  3 +++
> >  drivers/nvme/host/pci.c | 55
> > +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 58 insertions(+)
> > 
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index e601c4511a8b..c2e2ae774a19 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -45,6 +45,9 @@ static const guid_t prp_guids[] = {
> >         /* Thunderbolt GUID for WAKE_SUPPORTED: 6c501103-c189-4296-
> > ba72-9bf5a26ebe5d */
> >         GUID_INIT(0x6c501103, 0xc189, 0x4296,
> >                   0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
> > +       /* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-
> > 99a5189762d0 */
> > +       GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
> > +                 0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
> >  };
> > 
> >  /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-
> > 1319f52a966b */
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index e2bacd369a88..a3d3a82b0437 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -4,6 +4,7 @@
> >   * Copyright (c) 2011-2014, Intel Corporation.
> >   */
> > 
> > +#include <linux/acpi.h>
> >  #include <linux/aer.h>
> >  #include <linux/async.h>
> >  #include <linux/blkdev.h>
> > @@ -94,6 +95,10 @@ static unsigned int poll_queues;
> >  module_param_cb(poll_queues, &io_queue_count_ops, &poll_queues,
> > 0644);
> >  MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled
> > IO.");
> > 
> > +static bool noacpi;
> > +module_param(noacpi, bool, 0444);
> > +MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
> > +
> >  struct nvme_dev;
> >  struct nvme_queue;
> > 
> > @@ -2757,6 +2762,46 @@ static unsigned long
> > check_vendor_combination_bug(struct pci_dev *pdev)
> >         return 0;
> >  }
> > 
> > +static bool nvme_acpi_storage_d3(struct pci_dev *dev)
> > +{
> > +       const struct fwnode_handle *fwnode;
> > +       struct acpi_device *adev;
> > +       struct pci_dev *root;
> > +       acpi_handle handle;
> > +       acpi_status status;
> > +       bool ret = false;
> > +       u8 val;
> > +
> > +       /*
> > +        * Look for _DSD property specifying that the storage
> > device on
> > +        * the port must use D3 to support deep platform power
> > savings during
> > +        * suspend-to-idle
> > +        */
> > +       root = pcie_find_root_port(dev);
> > +       if (!root)
> > +               return false;
> > +
> > +       adev = ACPI_COMPANION(&root->dev);
> > +       if (!adev)
> > +               return false;
> > +
> > +       status = acpi_get_handle(adev->handle, "PXSX", &handle);
> > +       if (ACPI_FAILURE(status))
> > +               return false;
> > +
> > +       adev = acpi_bus_get_acpi_device(handle);
> 
> This function needs to be exported to modules for nvme to be able to
> use it when modular.

Missed that they weren't exported when I moved from pci-acpi to nvme as
it worked with my config. But looking again I see there's already an
acpi_bus_get_device() that's exported and should work here.
Unfortunately, it would be the only function that's not stubbed out so
per Cristoph's later comment, this will need a CONFIG_ACPI wrapper.

David


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
