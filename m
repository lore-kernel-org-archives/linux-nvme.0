Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,FUZZY_PRICES,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F0BC43460
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 19:02:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238D861246
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 19:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238D861246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=P/RkgThWIHFsuF1/bPju4rPkEpC15dRIGccE/JUCA3c=; b=aYmf31M1FbQRb+iRpElcCtPyLm
	sUulmwPog4/KhW1QHG0GwNXrh354mE9Obev9AR7BUCLmDn0BhPNl5TnL3/HzZUQYw+SDFOf8aq1Mu
	j19jmV/VWNtvuEO1qycuqX5BY2IWq7L/B5/GmZoxbNJ/hFg/YVXNygbvdubK/jYPPHfIIjfrDzYkl
	iNevc1sWMEuwZgjwFiDRYOYPEx9tyENbFs92zxOhP8UjzeIEp8AZnAPrldW7k/G619p9KUnESp4/b
	g7hhu+e07VeLuHmR6cHBqNoziyIShBPsfFtMWOVO+z3wUCJ3pc42HVusGs1zBjAFhXUV8Ko9UyKv2
	IOQsYDVw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljnv5-002OfG-HI; Thu, 20 May 2021 19:01:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljnuq-002Od9-NZ
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 19:01:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:References;
 bh=kgyenWMYnwJ5vLV7yHoHUAJQq5wg8ZP0T/hYansaltQ=; b=kPt2VYsQsSO+NlDPSouIQS72fD
 lnJSn7RYZzkDTzCpaVr6+EEs1doXKPj3N1RuhbiTgixOuF2naeKwNwbjsxzwr7QDjIIK2kdLtUCuc
 NO+L7M0ebIHUDDixaNDfsPAG6PDEljhgoONDOEOJXLedDUhQID0Ifjs95dlLOjnP2LlI1MXt0jYck
 9wqBH/8gj5fudQBTOmn18yjPiPhrKFzc3pGGhj37wvZXpXPYa/sHB/WRcelDHnTnMdmGpJS7X3y4P
 fo/UtjXX228ysBO/yxMsTKXMc44RgSdBrsRICxXm8GeC3jjYSTsBunCyuTpKrZIn9FKnoJrUJo/kF
 m/xPHAQA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljnum-00GamZ-T5
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 19:01:03 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3094B61244;
 Thu, 20 May 2021 19:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621537260;
 bh=yU4tmH370WF7vPMonhLNK25hN7Hi1hgNe8EkTdWzIJQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=aQs7PEGAkeUTVgpKTGjJUEtnkqxVUSHjcx8gdb/fim2WclwNx5JEEPcRz1oqSdjC2
 X/7vB2/O+slnp1hmnhCc8Zd3Lizf94dwZC8+TXuT16FFkMYcmfu3/Jif8vTFnpGHC+
 J3vQITuFHnBctAl+3sowG3EkyOh1874UZ7zcwJu2gcAr2nWYtj/4fbxwtlHY2bnRWg
 j1wlPSJYANQXZFDUgmGhaaP2ByzU+qYaCW7wd3AWEXm91XUVlY1jBVAt3qXvzM3Hvz
 UrZToxwFnUa4sfoTnFRzlZfqh/DkYWvdqqQFQiUZkvf0R4cJk3grHsIm/IcInaDyTa
 xTmf3jEjUj9Pg==
Date: Thu, 20 May 2021 14:00:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Liang, Prike" <Prike.Liang@amd.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Message-ID: <20210520190058.GA347246@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR12MB4488F16CE50BFD4E1F453CFAF72A9@MN2PR12MB4488.namprd12.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_120101_020298_79B9A522 
X-CRM114-Status: GOOD (  72.98  )
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

On Thu, May 20, 2021 at 05:40:54PM +0000, Deucher, Alexander wrote:
> [AMD Public Use]
> 
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Thursday, May 20, 2021 12:59 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: linux-pci@vger.kernel.org; kbusch@kernel.org; axboe@fb.com;
> > hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; Deucher,
> > Alexander <Alexander.Deucher@amd.com>; stable@vger.kernel.org; S-k,
> > Shyam-sundar <Shyam-sundar.S-k@amd.com>; Chaitanya Kulkarni
> > <chaitanya.kulkarni@wdc.com>; Rafael J. Wysocki <rjw@rjwysocki.net>;
> > linux-pm@vger.kernel.org
> > Subject: Re: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
> >
> > On Thu, May 20, 2021 at 06:57:41AM +0000, Liang, Prike wrote:
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > Sent: Thursday, May 20, 2021 5:34 AM
> > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > Cc: linux-pci@vger.kernel.org; kbusch@kernel.org; axboe@fb.com;
> > > > hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org;
> > > > Deucher, Alexander <Alexander.Deucher@amd.com>;
> > > > stable@vger.kernel.org; S-k, Shyam-sundar
> > > > <Shyam-sundar.S-k@amd.com>; Chaitanya Kulkarni
> > > > <chaitanya.kulkarni@wdc.com>; Rafael J. Wysocki <rjw@rjwysocki.net>;
> > > > linux-pm@vger.kernel.org
> > > > Subject: Re: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme
> > > > shutdown opt
> > > >
> > > > [+cc Rafael (probably nothing of interest to you), linux-pm]
> > > >
> > > > On Tue, May 18, 2021 at 10:24:34AM +0800, Prike Liang wrote:
> > > > > In the NVMe controller default suspend-resume seems only
> > > > > save/restore the NVMe link state by APST opt and the NVMe remains
> > > > > in D0 during this time.  Then the NVMe device will be shutdown by
> > > > > SMU firmware in the s2idle entry and then will lost the NVMe power
> > > > > context during s2idle resume.Finally, the NVMe command queue
> > > > > request will be processed abnormally and result in access
> > > > > timeout.This issue can be settled by using PCIe power set with
> > > > > simple suspend-resume process path instead of APST get/set opt.
> > > >
> > > > I can't parse the paragraph above, sorry.  I'm sure this means
> > > > something to NVMe developers, but since you're adding this to the
> > > > PCI core, not the NVMe core, it needs to be intelligible to ordinary
> > > > PCI folks.
> > > >
> > > [Prike]  I'm sorry to make confusion here. Those patches addressed a
> > > s2idle resume broken problem that the NVMe driver's default
> > > suspend-resume policy of using NVMe APST during suspend-to-idle
> > > prevents the PCI root port from going to D3.
> > >
> > > > For example, since you only use this flag in the NVMe driver, you
> > > > should explain why the PCI core needs to keep track of the flag for
> > > > you.  Normally I would assume the driver could figure this out in
> > > > its .probe() function.
> > > >
> > > [Prike] Yeah, we can assign the quirk flag in the .probe function or
> > > add it in nvme_id_table and this also the primary solution we tried
> > > out. However, that seems not possible to enumerate every uncertain
> > > NVMe device then assign quirk flag to them. In this case, in order to
> > > handle various NVMe device we can use the root complex device ID to
> > > identify the question platform.
> > >
> > > > Quirks are usually used to work around a defect in a device.
> > > > What's the defect in this case?  Ideally we can point to a section
> > > > of the PCIe spec with a requirement that the device violates.
> > >
> > > [Prike] In this case the quirk is only used to identify the question
> > > platform which requires the NVMe device go to D3 in the s2idle
> > > suspend.
> > >
> > > > What does "opt" mean?
> > > >
> > > [Prike] I'm also not dedicate working on the NVMe driver, but from the
> > > software perspective the APST opt is used for handling the power state
> > > S&R without PCI interfering during s2idle legacy suspend-resume.
> > >
> > > > What is SMU firmware?  Why is it relevant?
> > > >
> > > [Prike] SMU firmware is a proprietary micro component which
> > > responsible for device power management. Without the quirk flag, NVMe
> > > device will not enter D3 during s2idle suspend then SMU firmware will
> > > shut down the NVMe device, unfortunately since NVMe is a third-party
> > > device the SMU firmware only restore NVMe root port power state during
> > > s2ilde wake up process. Eventually, the NVMe device power state will
> > > be lost when back to OS s2idle resume  and then result in NVMe command
> > > request failed.
> > >
> > > > Is this a problem only with s2idle?  Why or why not?
> > > >
> > > [Prike] Yeah, this issue is only found in the s2idle scenario, and
> > > that's because s2idle will check whether each device will enter its
> > > own minimum power level defined in the LPI constrains table.
> > >
> > > > The quirk applies to [1022:1630].  An lspci I found on the web says
> > > > this is a "00:00.0 Host bridge: AMD Renoir Root Complex"
> > > > device.  So it looks like this will result in
> > > > PCI_BUS_FLAGS_DISABLE_ON_S2I being set for every PCI bus in the
> > > > entire system.  But the description talks about an issue
> > > > specifically with NVMe.
> > > >
> > > > Is there a defect in this AMD PCIe controller that affects all
> > > > devices?
> > > >
> > > [Prike] In this solution by checking root complex DID to identify the
> > > question platform which need the quirk flag. So far, only NVMe device
> > > need check this flag for special processing of NVMe s2idle suspend.
> >
> > We're really not getting anywhere.  The commit log needs to explain how this
> > is related to PCI.  Apparently the issue is related to NVMe APST and NVMe
> > device state being lost.  AFAICT, APST has to do with power states of the
> > NVMe controller itself.  Those states are internal to NVMe and are not
> > directly visible to the Root Port.
> >
> > Maybe there's a connection with ASPM or the Link state, or putting the
> > device in D3cold, or ...?
> >
> > Ideally it would describe something about this AMD PCIe controller that
> > doesn't work according to spec.
> >
> > It should say something about why this flag needs to apply to *all* devices
> > below this controller, even though we currently only use it for NVMe.
> 
> It doesn't really have anything to do with PCI.  The PCI link is
> just a proxy for specific AMD platforms.  It's platform firmware
> behavior we are catering to.  This was originally posted as an nvme
> quirk, but during the review it was recommended to move the quirk
> into PCI because the quirk is not specific a particular NVMe device,
> but rather a set of AMD platforms.  Lots of other platforms seems to
> do similar things in the nvme driver based on ACPI or DMI flags,
> etc.  On our hardware this nvme flag is required for all cezanne and
> renoir platforms.

If it has nothing to do with PCI, and you need to detect the platform,
why not a DMI or similar quirk?

> Here's the original nvme patch discussions:
> http://lists.infradead.org/pipermail/linux-nvme/2021-March/023973.html
> http://lists.infradead.org/pipermail/linux-nvme/2021-March/024017.html
> http://lists.infradead.org/pipermail/linux-nvme/2021-April/024291.html

These contain no additional information.  Certainly nothing that would
explain why this should be a PCI quirk.

> > > > > In this patch prepare a PCIe RC bus flag to identify the platform
> > > > > whether need the quirk.
> > > > >
> > > > > Cc: <stable@vger.kernel.org> # 5.10+
> > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> > > > > [ck: split patches for nvme and pcie]
> > > > > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > > > > Suggested-by: Keith Busch <kbusch@kernel.org>
> > > > > Acked-by: Keith Busch <kbusch@kernel.org>
> > > > > ---
> > > > > Changes in v2:
> > > > > Fix the patch format and check chip root complex DID instead of
> > > > > PCIe RP to avoid the storage device plugged in internal PCIe RP by USB
> > adaptor.
> > > > >
> > > > > Changes in v3:
> > > > > According to Christoph Hellwig do NVME PCIe related identify opt
> > > > > better in PCIe quirk driver rather than in NVME module.
> > > > >
> > > > > Changes in v4:
> > > > > Split the fix to PCIe and NVMe part and then call the
> > > > > pci_dev_put() put the device reference count and finally refine the
> > commit info.
> > > > >
> > > > > Changes in v5:
> > > > > According to Christoph Hellwig and Keith Busch better use a
> > > > > passthrough device(bus) gloable flag to identify the NVMe shutdown
> > > > > opt rather than look up the device BDF.
> >
> > The changelog above bears little resemblance to reality.  I dug up all the
> > previous postings, hoping there was a hint about why this is relevant to PCI,
> > but I didn't find anything.  For the archives, here are the versions I found and
> > notes about what really changed:
> >
> >   v1 2021-04-14  2:18
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Fr%2F1618366694-14092-1-git-send-email-
> > Prike.Liang%40amd.com%2F&amp;data=04%7C01%7CAlexander.Deucher%4
> > 0amd.com%7C7773f0f2af054b0ab45408d91bb08ad8%7C3dd8961fe4884e608e
> > 11a82d994e183d%7C0%7C0%7C637571267348438733%7CUnknown%7CTWFp
> > bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> > I6Mn0%3D%7C1000&amp;sdata=KFiTsmHEIbv9Qe7UI4yjKjXr1mWSusA2LYV
> > M07GUGAY%3D&amp;reserved=0
> >
> >   v2 2021-04-14  6:19
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Fr%2F1618381200-14856-1-git-send-email-
> > Prike.Liang%40amd.com%2F&amp;data=04%7C01%7CAlexander.Deucher%4
> > 0amd.com%7C7773f0f2af054b0ab45408d91bb08ad8%7C3dd8961fe4884e608e
> > 11a82d994e183d%7C0%7C0%7C637571267348438733%7CUnknown%7CTWFp
> > bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> > I6Mn0%3D%7C1000&amp;sdata=I2rKN%2Bixmn2NcXcZ20seu9LQC%2BekwH
> > azH9oqzym7eeE%3D&amp;reserved=0
> >     (Not tagged as v2 in the posting.)
> >     Check result of pci_get_domain_bus_and_slot() for NULL.
> >
> >   v3 2021-04-14  8:18
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Fr%2F1618388281-15629-1-git-send-email-
> > Prike.Liang%40amd.com%2F&amp;data=04%7C01%7CAlexander.Deucher%4
> > 0amd.com%7C7773f0f2af054b0ab45408d91bb08ad8%7C3dd8961fe4884e608e
> > 11a82d994e183d%7C0%7C0%7C637571267348438733%7CUnknown%7CTWFp
> > bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> > I6Mn0%3D%7C1000&amp;sdata=7T9VcWinB8XQTR4tVKMZ4WkCI5oGKBBuH
> > n33wxIZzbI%3D&amp;reserved=0
> >     (Not tagged as v3 in the posting.)
> >     Drop reference acquired by pci_get_domain_bus_and_slot().
> >     Return "true" (not NVME_QUIRK_SIMPLE_SUSPEND) from bool
> >     nvme_acpi_storage_d3().
> >
> >   v4 2021-04-15  3:52
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Fr%2F1618458725-17164-1-git-send-email-
> > Prike.Liang%40amd.com%2F&amp;data=04%7C01%7CAlexander.Deucher%4
> > 0amd.com%7C7773f0f2af054b0ab45408d91bb08ad8%7C3dd8961fe4884e608e
> > 11a82d994e183d%7C0%7C0%7C637571267348438733%7CUnknown%7CTWFp
> > bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> > I6Mn0%3D%7C1000&amp;sdata=aTgZtIfWMeoWZ3HoHcjclrJPW8qknIsuoVaz
> > hZnoDHo%3D&amp;reserved=0
> >     Reorder Signed-off-by tags.
> >     No code change at all.
> >
> >   v5 2021-04-16  6:54
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Fr%2F1618556075-24589-1-git-send-email-
> > Prike.Liang%40amd.com%2F&amp;data=04%7C01%7CAlexander.Deucher%4
> > 0amd.com%7C7773f0f2af054b0ab45408d91bb08ad8%7C3dd8961fe4884e608e
> > 11a82d994e183d%7C0%7C0%7C637571267348438733%7CUnknown%7CTWFp
> > bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> > I6Mn0%3D%7C1000&amp;sdata=5yzUyXfIDKxTE%2B%2FJy5fgOS9yCsU10uw
> > n4CjGd2mLLc0%3D&amp;reserved=0
> >     Move flag from pci_dev_flags to pci_bus_flags.
> >     Rename flag to PCI_BUS_FLAGS_DISABLE_ON_S2I.
> >     Inherit PCI_BUS_FLAGS_DISABLE_ON_S2I in all child buses of AMD
> >     0x1630.
> >     Check dev->bus->bus_flags instead of using
> >     pci_get_domain_bus_and_slot().
> >
> > > > > ---
> > > > >  drivers/pci/probe.c  | 5 ++++-
> > > > >  drivers/pci/quirks.c | 7 +++++++
> > > > >  include/linux/pci.h  | 2 ++
> > > > >  3 files changed, 13 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c index
> > > > > 953f15a..34ba691e 100644
> > > > > --- a/drivers/pci/probe.c
> > > > > +++ b/drivers/pci/probe.c
> > > > > @@ -558,10 +558,13 @@ static struct pci_bus *pci_alloc_bus(struct
> > > > pci_bus *parent)
> > > > >     INIT_LIST_HEAD(&b->resources);
> > > > >     b->max_bus_speed = PCI_SPEED_UNKNOWN;
> > > > >     b->cur_bus_speed = PCI_SPEED_UNKNOWN;
> > > > > +   if (parent) {
> > > > >  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> > > > > -   if (parent)
> > > > >             b->domain_nr = parent->domain_nr;  #endif
> > > > > +           if (parent->bus_flags & PCI_BUS_FLAGS_DISABLE_ON_S2I)
> > > > > +                   b->bus_flags |= PCI_BUS_FLAGS_DISABLE_ON_S2I;
> > > > > +   }
> > > > >     return b;
> > > > >  }
> > > > >
> > > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > > > > 653660e3..7c4bb8e 100644
> > > > > --- a/drivers/pci/quirks.c
> > > > > +++ b/drivers/pci/quirks.c
> > > > > @@ -312,6 +312,13 @@ static void quirk_nopciamd(struct pci_dev
> > > > > *dev) }  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,
> > > >       PCI_DEVICE_ID_AMD_8151_0,       quirk_nopciamd);
> > > > >
> > > > > +static void quirk_amd_s2i_fixup(struct pci_dev *dev) {
> > > > > +   dev->bus->bus_flags |= PCI_BUS_FLAGS_DISABLE_ON_S2I;
> > > > > +   pci_info(dev, "AMD simple suspend opt enabled\n"); }
> > > > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1630,
> > > > > +quirk_amd_s2i_fixup);
> > > > > +
> > > > >  /* Triton requires workarounds to be used by the drivers */
> > > > > static void quirk_triton(struct pci_dev *dev)  { diff --git
> > > > > a/include/linux/pci.h b/include/linux/pci.h index 53f4904..dc65219
> > > > > 100644
> > > > > --- a/include/linux/pci.h
> > > > > +++ b/include/linux/pci.h
> > > > > @@ -240,6 +240,8 @@ enum pci_bus_flags {
> > > > >     PCI_BUS_FLAGS_NO_MMRBC  = (__force pci_bus_flags_t) 2,
> > > > >     PCI_BUS_FLAGS_NO_AERSID = (__force pci_bus_flags_t) 4,
> > > > >     PCI_BUS_FLAGS_NO_EXTCFG = (__force pci_bus_flags_t) 8,
> > > > > +   /* Driver must pci_disable_device() for suspend-to-idle */
> > > > > +   PCI_BUS_FLAGS_DISABLE_ON_S2I    = (__force pci_bus_flags_t) 16,
> > > > >  };
> > > > >
> > > > >  /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
> > > > > --
> > > > > 2.7.4
> > > > >

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
