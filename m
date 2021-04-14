Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD939C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 07:49:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6FA613C7
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 07:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6FA613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XWWzFeIKtUUBtQ+VaKTz6iFvfFb3/3pVNJxsK389bBA=; b=h4EjYo+hRWigpHr7ZgHrEnRxF
	rR5v4EjOtrupxC3D9lgQAKibnx+yWuz5bcaSaODgKGKv6K6X3wldXaC5BB6FvhaApir1SfNrtq8pd
	5D1flHACnpJqUqFYsVqUD1KCMxZrrUVo1FLaoIN+d1dU7PQEg2PZd3wMKGr4oPAmpnSkaHuJXRqXh
	4GgS9TzCiDcTmsxhp4268fvdXxlolqEylxRY2R2fMRp6DsuQahwwTPAU29rhL2ztUGxIVz+DZKTwa
	K+FjUBM04JMHvOMpoqHNPNlBKSZ3HCS4DXlHrAdFdmtR1wGRvSr0UHExP/p32KoG6WbP/Arvz6Kez
	jS/0YkFLw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWaGo-00BsxT-Tk; Wed, 14 Apr 2021 07:49:07 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWaGk-00Bswd-Kr
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 07:49:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TTkCx2vnkxcegjfzbmRNTw/NF1o6LqSdwnPhRPpshxk=; b=129wFuqOjmd2jVgmGrIGOpUztW
 SrgaX9+iQfg+TD3xHKnKE6d1CpFhXWaSooo1Gs4VrjpCyjoUdJNUscVDGfdHBTxu5QdXO4o+re9Ne
 LdwXZ3vbpGrjec8xXeb7rMe+df1M57aimVA1t4zY5kCU5qVQATHdg0fUsqfLZnZuxVyAvZuSrBats
 IaxkXjYKHGjQgXM+NZrZkOE6aiaqI9htfmj/lyZsDBHeTWTdEMKeUJzAnW1Uas81GKHR7L6ehMFAd
 o38GNSS2RpEx/fTPsO8rp3MRWEy28qBcwgS+Ual83R5g9pY2OvGMeanRPLgjdmei9k3krF/AnUE0q
 8ZIjOcdQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWaGh-007aBK-Nu
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 07:49:01 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E23C3613C4;
 Wed, 14 Apr 2021 07:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1618386538;
 bh=vmUTkhJhcxKjbTntrU4ig4GdlaiPtJChHqBeU5k4FXc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PKE3q0Zva8vUkp86YISfX7vX2j/0NfZ7BaapfRbsUtgkiH61urmyP6A1exCr9cKWS
 Z/UaNexlWkrhmQK9uayvGFFS/9464v9tb8xwW7t8mcS3BZzIIImY8kGN/DI1Kirvrj
 agG/kyL1yuZEcUDIM0WbSpxOQALQnS+oHBbKZ9Tk=
Date: Wed, 14 Apr 2021 09:48:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "hch@infradead.org" <hch@infradead.org>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "# 5 . 11+" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] nvme-pci: add AMD PCIe quirk for suspend/resume
Message-ID: <YHaeZ/auMUYGSy1K@kroah.com>
References: <1618381200-14856-1-git-send-email-Prike.Liang@amd.com>
 <1618381200-14856-2-git-send-email-Prike.Liang@amd.com>
 <YHaOJDm3GCZ8baAV@kroah.com>
 <BYAPR12MB3238544752DD86202469CA1EFB4E9@BYAPR12MB3238.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3238544752DD86202469CA1EFB4E9@BYAPR12MB3238.namprd12.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210414_004859_922330_04F291D7 
X-CRM114-Status: GOOD (  22.63  )
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

On Wed, Apr 14, 2021 at 07:13:15AM +0000, Liang, Prike wrote:
> [AMD Public Use]
> 
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Wednesday, April 14, 2021 2:40 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: linux-nvme@lists.infradead.org; kbusch@kernel.org;
> > Chaitanya.Kulkarni@wdc.com; hch@infradead.org; S-k, Shyam-sundar
> > <Shyam-sundar.S-k@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; # 5 . 11+ <stable@vger.kernel.org>
> > Subject: Re: [PATCH 2/2] nvme-pci: add AMD PCIe quirk for suspend/resume
> >
> > On Wed, Apr 14, 2021 at 02:20:00PM +0800, Prike Liang wrote:
> > > The NVME device pluged in some AMD PCIE root port will resume timeout
> > > from s2idle which caused by NVME power CFG lost in the SMU FW restore.
> > > This issue can be workaround by using PCIe power set with simple
> > > suspend/resume process path instead of APST. In the onwards ASIC will
> > > try do the NVME shutdown save and restore in the BIOS and still need
> > > PCIe power setting to resume from RTD3 for s2idle.
> > >
> > > Update the nvme_acpi_storage_d3() _with previously added quirk.
> > >
> > > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > > [ck: split patches for nvme and pcie]
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> > > Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > > Cc: <stable@vger.kernel.org> # 5.11+
> > > ---
> > >  drivers/nvme/host/pci.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index
> > > 6bad4d4..5a9a192 100644
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
> > > +if (rdev && (rdev->dev_flags &
> > PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND))
> > > +return NVME_QUIRK_SIMPLE_SUSPEND;
> > > +
> > >  adev = ACPI_COMPANION(&root->dev);
> > >  if (!adev)
> > >  return false;
> > > --
> > > 2.7.4
> > >
> >
> > This is still broken, why resend it?
> Sorry can't get how come the reference count leaked, could you help give more detail about this.

Please read the documentation for the call you are making here.  For
once, it is actually written down what needs to be done :)


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
