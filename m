Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,FUZZY_PRICES,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A881EC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 17:00:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C96A6139A
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 17:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C96A6139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=UohZjPKTqqHNUMueM3VueU12AnnflbmA7LyrFVfv/4g=; b=PrEgVB3wnKU9HiniSk10XvFlH4
	NxkBwYffczN0XSVcWtkOtDEI+ZNu0e/H/nVb/WnaDYj/42aRNtVZb8E/7jlL8mqU0BXXZNREk3R4H
	mwfYHkp4Ulk+has/cBx29ze2jCzp0bwJdooWV8X3o3j1gH/tLeCcerdK7CivH3nO2aqu3uuW0meL3
	YMCpV1jviAGmaj1eZeFDqqs0FUDZU1Hci02BsVmUL3Tar5wn/J6c/9P5RChwBnAhEHVhoXtSp1Isn
	hn1qmk/ssBlx+YJVvhT47+fRqbAy1NtMy6b5Pe9T6QvFvukoWIy7ooYmNWRXhOixfpQHfi9ipyMMg
	pEAzRjiw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljm0d-0021nZ-I1; Thu, 20 May 2021 16:58:55 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljm0b-0021my-Lc
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 16:58:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:References;
 bh=In6Cj6iSzDy/b7xf/Q5qj2SZzYo1YE1I6mh93fxKMhQ=; b=Qw/1U3fKXm1d8gl2wO7NXIFOYU
 bzpbPNCoH60Vvx9+biCsGt30sww2dD+ivMa7/5lpwhnghMbcvyrMeFzzFbd8JrFrRUtl78mMpIVXu
 nNl12WIvLamLkjk0eOOHpVNoE8+a+Rn/wAfVJwKClEiklLotPXf93Pk5nESDvv+ZfTF9nUMCnCLdO
 pRXOmuf8l5mqYfbEpCKli4HdQ2S8JVPHRL3YOF63mByI0tVKFaj6d3nPjuBcyiSL+mA8YQdE0X1+8
 u+jtlotcsPO5hWLM+zl5hXFHp1jMuaoqAzzESvJGkWUpGWlIVb+h69k9s5iMTUEMTWR0HXEnBfr4u
 t6rr3QfQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljm0Y-00GWhT-B6
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 16:58:52 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 993926139A;
 Thu, 20 May 2021 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621529930;
 bh=4O3oJ11IU9YipP9ATpX6X5/7wCQw6yswcOHW1svuVZY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=LzRQ3DXZkrmE4p0wyhSFex3X3mFMTDrm/3rA6+I1qPpobbgPTV2yCEBCFCYlhlfPe
 Bb66SweX0ZTJFhUfp2PgSYLMGBHzioSO1z1KOuGuxNlXfA952D7YUB+jNrkkNtPcNX
 axq1UhPXKm5NIYt/QYseeIy9z75jWBjd9K6/fNDIx0XzNYI7SwuCqbyowZoajMykvM
 6lI7XdkcuxvlBftvJKgfkexuUrOU+ZAgY0sUoSoMnuwgDzzV2nLrZNXv6d2MtU5K7P
 ZlLQ9/QkxzkzaKT9I49A6YG5Mv+6bzoEFsw+QdbxdI2R/b8FkVS29dbleio7xy6zzf
 6Eei9CCSHMMzA==
Date: Thu, 20 May 2021 11:58:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Message-ID: <20210520165848.GA324094@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3238055D4B08CC91D9ABFD39FB2A9@BYAPR12MB3238.namprd12.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_095850_452506_8C224A3B 
X-CRM114-Status: GOOD (  60.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 20, 2021 at 06:57:41AM +0000, Liang, Prike wrote:
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Thursday, May 20, 2021 5:34 AM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: linux-pci@vger.kernel.org; kbusch@kernel.org; axboe@fb.com;
> > hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; Deucher,
> > Alexander <Alexander.Deucher@amd.com>; stable@vger.kernel.org; S-k,
> > Shyam-sundar <Shyam-sundar.S-k@amd.com>; Chaitanya Kulkarni
> > <chaitanya.kulkarni@wdc.com>; Rafael J. Wysocki <rjw@rjwysocki.net>;
> > linux-pm@vger.kernel.org
> > Subject: Re: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
> >
> > [+cc Rafael (probably nothing of interest to you), linux-pm]
> >
> > On Tue, May 18, 2021 at 10:24:34AM +0800, Prike Liang wrote:
> > > In the NVMe controller default suspend-resume seems only
> > > save/restore the NVMe link state by APST opt and the NVMe
> > > remains in D0 during this time.  Then the NVMe device will be
> > > shutdown by SMU firmware in the s2idle entry and then will lost
> > > the NVMe power context during s2idle resume.Finally, the NVMe
> > > command queue request will be processed abnormally and result in
> > > access timeout.This issue can be settled by using PCIe power set
> > > with simple suspend-resume process path instead of
> > > APST get/set opt.
> >
> > I can't parse the paragraph above, sorry.  I'm sure this means
> > something to NVMe developers, but since you're adding this to the
> > PCI core, not the NVMe core, it needs to be intelligible to
> > ordinary PCI folks.
> >
> [Prike]  I'm sorry to make confusion here. Those patches addressed a
> s2idle resume broken problem that the NVMe driver's default
> suspend-resume policy of using NVMe APST during suspend-to-idle
> prevents the PCI root port from going to D3.
>
> > For example, since you only use this flag in the NVMe driver, you
> > should explain why the PCI core needs to keep track of the flag
> > for you.  Normally I would assume the driver could figure this out
> > in its .probe() function.
> >
> [Prike] Yeah, we can assign the quirk flag in the .probe function or
> add it in nvme_id_table and this also the primary solution we tried
> out. However, that seems not possible to enumerate every uncertain
> NVMe device then assign quirk flag to them. In this case, in order
> to handle various NVMe device we can use the root complex device ID
> to identify the question platform.
> 
> > Quirks are usually used to work around a defect in a device.
> > What's the defect in this case?  Ideally we can point to a section
> > of the PCIe spec with a requirement that the device violates.
>
> [Prike] In this case the quirk is only used to identify the question
> platform which requires the NVMe device go to D3 in the s2idle
> suspend.
>
> > What does "opt" mean?
> >
> [Prike] I'm also not dedicate working on the NVMe driver, but from
> the software perspective the APST opt is used for handling the power
> state S&R without PCI interfering during s2idle legacy
> suspend-resume.
>
> > What is SMU firmware?  Why is it relevant?
> >
> [Prike] SMU firmware is a proprietary micro component which
> responsible for device power management. Without the quirk flag,
> NVMe device will not enter D3 during s2idle suspend then SMU
> firmware will shut down the NVMe device, unfortunately since NVMe is
> a third-party device the SMU firmware only restore NVMe root port
> power state during s2ilde wake up process. Eventually, the NVMe
> device power state will be lost when back to OS s2idle resume  and
> then result in NVMe command request failed.
> 
> > Is this a problem only with s2idle?  Why or why not?
> >
> [Prike] Yeah, this issue is only found in the s2idle scenario, and
> that's because s2idle will check whether each device will enter its
> own minimum power level defined in the LPI constrains table.
>
> > The quirk applies to [1022:1630].  An lspci I found on the web
> > says this is a "00:00.0 Host bridge: AMD Renoir Root Complex"
> > device.  So it looks like this will result in
> > PCI_BUS_FLAGS_DISABLE_ON_S2I being set for every PCI bus in the
> > entire system.  But the description talks about an issue
> > specifically with NVMe.
> >
> > Is there a defect in this AMD PCIe controller that affects all
> > devices?
> >
> [Prike] In this solution by checking root complex DID to identify
> the question platform which need the quirk flag. So far, only NVMe
> device need check this flag for special processing of NVMe s2idle
> suspend.

We're really not getting anywhere.  The commit log needs to explain
how this is related to PCI.  Apparently the issue is related to NVMe
APST and NVMe device state being lost.  AFAICT, APST has to do with
power states of the NVMe controller itself.  Those states are internal
to NVMe and are not directly visible to the Root Port.

Maybe there's a connection with ASPM or the Link state, or putting the
device in D3cold, or ...?  

Ideally it would describe something about this AMD PCIe controller
that doesn't work according to spec.

It should say something about why this flag needs to apply to *all*
devices below this controller, even though we currently only use it
for NVMe.

> > > In this patch prepare a PCIe RC bus flag to identify the
> > > platform whether need the quirk.
> > >
> > > Cc: <stable@vger.kernel.org> # 5.10+
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> > > [ck: split patches for nvme and pcie]
> > > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > > Suggested-by: Keith Busch <kbusch@kernel.org>
> > > Acked-by: Keith Busch <kbusch@kernel.org>
> > > ---
> > > Changes in v2:
> > > Fix the patch format and check chip root complex DID instead of PCIe
> > > RP to avoid the storage device plugged in internal PCIe RP by USB adaptor.
> > >
> > > Changes in v3:
> > > According to Christoph Hellwig do NVME PCIe related identify opt
> > > better in PCIe quirk driver rather than in NVME module.
> > >
> > > Changes in v4:
> > > Split the fix to PCIe and NVMe part and then call the pci_dev_put()
> > > put the device reference count and finally refine the commit info.
> > >
> > > Changes in v5:
> > > According to Christoph Hellwig and Keith Busch better use a
> > > passthrough device(bus) gloable flag to identify the NVMe shutdown opt
> > > rather than look up the device BDF.

The changelog above bears little resemblance to reality.  I dug up all
the previous postings, hoping there was a hint about why this is
relevant to PCI, but I didn't find anything.  For the archives, here
are the versions I found and notes about what really changed:

  v1 2021-04-14  2:18 https://lore.kernel.org/r/1618366694-14092-1-git-send-email-Prike.Liang@amd.com/

  v2 2021-04-14  6:19 https://lore.kernel.org/r/1618381200-14856-1-git-send-email-Prike.Liang@amd.com/
    (Not tagged as v2 in the posting.)
    Check result of pci_get_domain_bus_and_slot() for NULL.

  v3 2021-04-14  8:18 https://lore.kernel.org/r/1618388281-15629-1-git-send-email-Prike.Liang@amd.com/
    (Not tagged as v3 in the posting.)
    Drop reference acquired by pci_get_domain_bus_and_slot().
    Return "true" (not NVME_QUIRK_SIMPLE_SUSPEND) from bool
    nvme_acpi_storage_d3().

  v4 2021-04-15  3:52 https://lore.kernel.org/r/1618458725-17164-1-git-send-email-Prike.Liang@amd.com/
    Reorder Signed-off-by tags.
    No code change at all.

  v5 2021-04-16  6:54 https://lore.kernel.org/r/1618556075-24589-1-git-send-email-Prike.Liang@amd.com/
    Move flag from pci_dev_flags to pci_bus_flags.
    Rename flag to PCI_BUS_FLAGS_DISABLE_ON_S2I.
    Inherit PCI_BUS_FLAGS_DISABLE_ON_S2I in all child buses of AMD
    0x1630.
    Check dev->bus->bus_flags instead of using
    pci_get_domain_bus_and_slot().

> > > ---
> > >  drivers/pci/probe.c  | 5 ++++-
> > >  drivers/pci/quirks.c | 7 +++++++
> > >  include/linux/pci.h  | 2 ++
> > >  3 files changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c index
> > > 953f15a..34ba691e 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -558,10 +558,13 @@ static struct pci_bus *pci_alloc_bus(struct
> > pci_bus *parent)
> > >     INIT_LIST_HEAD(&b->resources);
> > >     b->max_bus_speed = PCI_SPEED_UNKNOWN;
> > >     b->cur_bus_speed = PCI_SPEED_UNKNOWN;
> > > +   if (parent) {
> > >  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> > > -   if (parent)
> > >             b->domain_nr = parent->domain_nr;
> > >  #endif
> > > +           if (parent->bus_flags & PCI_BUS_FLAGS_DISABLE_ON_S2I)
> > > +                   b->bus_flags |= PCI_BUS_FLAGS_DISABLE_ON_S2I;
> > > +   }
> > >     return b;
> > >  }
> > >
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > > 653660e3..7c4bb8e 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -312,6 +312,13 @@ static void quirk_nopciamd(struct pci_dev *dev)
> > > }
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,
> >       PCI_DEVICE_ID_AMD_8151_0,       quirk_nopciamd);
> > >
> > > +static void quirk_amd_s2i_fixup(struct pci_dev *dev) {
> > > +   dev->bus->bus_flags |= PCI_BUS_FLAGS_DISABLE_ON_S2I;
> > > +   pci_info(dev, "AMD simple suspend opt enabled\n"); }
> > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1630,
> > > +quirk_amd_s2i_fixup);
> > > +
> > >  /* Triton requires workarounds to be used by the drivers */  static
> > > void quirk_triton(struct pci_dev *dev)  { diff --git
> > > a/include/linux/pci.h b/include/linux/pci.h index 53f4904..dc65219
> > > 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -240,6 +240,8 @@ enum pci_bus_flags {
> > >     PCI_BUS_FLAGS_NO_MMRBC  = (__force pci_bus_flags_t) 2,
> > >     PCI_BUS_FLAGS_NO_AERSID = (__force pci_bus_flags_t) 4,
> > >     PCI_BUS_FLAGS_NO_EXTCFG = (__force pci_bus_flags_t) 8,
> > > +   /* Driver must pci_disable_device() for suspend-to-idle */
> > > +   PCI_BUS_FLAGS_DISABLE_ON_S2I    = (__force pci_bus_flags_t) 16,
> > >  };
> > >
> > >  /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
> > > --
> > > 2.7.4
> > >

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
