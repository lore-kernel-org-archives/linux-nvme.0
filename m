Return-Path: <SRS0=BJyz=JK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7202C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 09:40:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010596121E
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 09:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010596121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=71Suk1gdnXG8mUfRtt//q/nLBrOosJxZHZc3dnJyiX4=; b=GduS+K328FFdC6NRNkr5ycEqS
	jFZuxJyn2M067aCOn6YUcI++Q/rZX0p9mAWRUqrQowD+U8rSnPuDCuMJeAXmjxtpFp3x1kSQxJf1R
	Xfl526hAtV6ML2bFUzkE8Ik7zjT3uYJVobFmT1OMkW6YJS5PvvDiZb5yKU9k7gj/tgBIcpO7T23Lg
	rKj59FHUexatuv5bHtrYJ5xQpsSB58ATRKOiMlB9OrowxoCUPVbwPY3rEuX8r+bqrEfnHZxZwcXBx
	nXEai9trttspt2Ug6oGbK2Qh2VH3hfYVCS+xOnHNyOC38OdeZyZDCbMJJxQM4Hy/KMN69Lm6gTy5O
	RSp6+fdHw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWFX4-008kUv-UX; Tue, 13 Apr 2021 09:40:31 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWFWy-008kRW-1o
 for linux-nvme@desiato.infradead.org; Tue, 13 Apr 2021 09:40:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=lktYyQ/+n/kisqteayE6I6QlsRYMLePAEmSgo7L8XGc=; b=nmJk/wYriGNVK2rnGBmEJZ1UFH
 pIRhnXT67xuSK26/HwN56/GVNlWmAmBXw3o5p8AGcVLnsPoKiuvdEhlXZl+WEvMPlsqhq2FVvw7NN
 BpKo9xe7b6N1xHX6Uc3c6MdC1jE+Fse59Nd1wH836/zvk1zk4CPE4x5ByCMaX/FPImdIr7tZqdm43
 M+OYdGeo6Ye6XSXRJTBQHzcyvjkXQzYG9zLPJHzpq2fjGkoY96vhPtqfk0JHNda0QowIMMmtSQo2/
 0iupmptavAgQbIQt34WbKlHm3nDByxbJgBoi0zLd1BZAyrWoe+sYXQbQo1Kfrt1zFMJBjCsivQXmC
 tg0qXipw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWFWv-006t6n-5x
 for linux-nvme@lists.infradead.org; Tue, 13 Apr 2021 09:40:22 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8C2461222;
 Tue, 13 Apr 2021 09:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1618306820;
 bh=13DkOHHCScjxNEkGRoItj/TETxYwomg0ZoTIvQMDWDo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WhxElW9IMpdzxvJizUFrC8sM0X7GOSwmORglck7KYGm/WaBBQubDC6yPD7CtBRtFm
 yrUrXtKFCDo7Sc62L9IGqbCii0RtCDWAFOEDfHBnv9E/PumUD4PFT4rFVExGjZblkB
 EPonzH6iwBv7X43PCCQlc7kUIUpIYe1UzaGiws9Q=
Date: Tue, 13 Apr 2021 11:40:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] nvme: put some AMD PCIE downstream NVME device to simple
 suspend/resume path
Message-ID: <YHVnAdmL9yeN1Z0B@kroah.com>
References: <1618304441-12550-1-git-send-email-Prike.Liang@amd.com>
 <YHVgd+dOAGWIl3+m@kroah.com>
 <BYAPR12MB3238ECDDDE0239CF06249D4AFB4F9@BYAPR12MB3238.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3238ECDDDE0239CF06249D4AFB4F9@BYAPR12MB3238.namprd12.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_024021_292621_9C22A337 
X-CRM114-Status: GOOD (  28.76  )
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

On Tue, Apr 13, 2021 at 09:30:13AM +0000, Liang, Prike wrote:
> [AMD Public Use]
> 
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, April 13, 2021 5:12 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: linux-nvme@lists.infradead.org; kbusch@kernel.org;
> > Chaitanya.Kulkarni@wdc.com; stable@vger.kernel.org; S-k, Shyam-sundar
> > <Shyam-sundar.S-k@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH] nvme: put some AMD PCIE downstream NVME device to
> > simple suspend/resume path
> >
> > On Tue, Apr 13, 2021 at 05:00:41PM +0800, Prike Liang wrote:
> > > The NVME device pluged in some AMD PCIE root port will resume timeout
> > > from s2idle which caused by NVME power CFG lost in the SMU FW restore.
> > > This issue can be workaround by using PCIe power set with simple
> > > suspend/resume process path instead of APST. In the onwards ASIC will
> > > try do the NVME shutdown save and restore in the BIOS and still need
> > > PCIe power setting to resume from RTD3 for s2idle.
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> > > Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > > Cc: <stable@vger.kernel.org> # 5.11+
> > > ---
> > >  drivers/nvme/host/pci.c |  5 +++++
> > >  drivers/pci/quirks.c    | 10 ++++++++++
> > >  include/linux/pci.h     |  2 ++
> > >  include/linux/pci_ids.h |  1 +
> > >  4 files changed, 18 insertions(+)
> > >
> > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index
> > > 6bad4d4..dd46d9e 100644
> > > --- a/drivers/nvme/host/pci.c
> > > +++ b/drivers/nvme/host/pci.c
> > > @@ -2832,6 +2832,7 @@ static bool nvme_acpi_storage_d3(struct pci_dev
> > > *dev)  {
> > >  struct acpi_device *adev;
> > >  struct pci_dev *root;
> > > +struct pci_dev *rdev;
> > >  acpi_handle handle;
> > >  acpi_status status;
> > >  u8 val;
> > > @@ -2845,6 +2846,10 @@ static bool nvme_acpi_storage_d3(struct
> > pci_dev *dev)
> > >  if (!root)
> > >  return false;
> > >
> > > +rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> > > +if (rdev->dev_flags &
> > PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND)
> > > +return NVME_QUIRK_SIMPLE_SUSPEND;
> > > +
> > >  adev = ACPI_COMPANION(&root->dev);
> > >  if (!adev)
> > >  return false;
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > > 653660e3..0b175ce 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -312,6 +312,16 @@ static void quirk_nopciamd(struct pci_dev *dev)
> > > }
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,
> > PCI_DEVICE_ID_AMD_8151_0,quirk_nopciamd);
> > >
> > > +static void quirk_amd_nvme_fixup(struct pci_dev *dev) {
> > > +struct pci_dev *rdev;
> > > +
> > > +dev->dev_flags |= PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND;
> > > +pci_info(dev, "AMD simple suspend opt enabled\n");
> > > +
> > > +}
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,
> > PCI_DEVICE_ID_AMD_CZN_RP,
> > > +quirk_amd_nvme_fixup);
> > > +
> > >  /* Triton requires workarounds to be used by the drivers */  static
> > > void quirk_triton(struct pci_dev *dev)  { diff --git
> > > a/include/linux/pci.h b/include/linux/pci.h index 53f4904..a6e1b1b
> > > 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -227,6 +227,8 @@ enum pci_dev_flags {
> > >  PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
> > >  /* Don't use Relaxed Ordering for TLPs directed at this device */
> > >  PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t)
> > (1 <<
> > > 11),
> > > +/* AMD simple suspend opt quirk */
> > > +PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND = (__force
> > pci_dev_flags_t) (1
> > > +<< 12),
> > >  };
> > >
> > >  enum pci_irq_reroute_variant {
> > > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h index
> > > d8156a5..a82443f 100644
> > > --- a/include/linux/pci_ids.h
> > > +++ b/include/linux/pci_ids.h
> > > @@ -602,6 +602,7 @@
> > >  #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS0x780b
> > >  #define PCI_DEVICE_ID_AMD_HUDSON2_IDE0x780c
> > >  #define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
> > > +#define PCI_DEVICE_ID_AMD_CZN_RP0x1630
> >
> > Why add this here when it is not needed in this file?  Please read the top of
> > the file...
> >
> [Prike]  I'm sorry can't get you meaning before. Do you mean the pci_id header used only for the global PCI ID definition and in this case only need put the 0x1630 DID in the quirk entry directly?

Yes, it is not needed to be added to the pci_ids.h file unless it is
used in multiple .c files, which is not the case here.

thanks,

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
