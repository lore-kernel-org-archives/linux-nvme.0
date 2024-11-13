Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099F1D462AA
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 14:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rKFGBULo3jxZ7tGT5Qv2/qjt1AnWxm26g5UbQ47T0WE=; b=PFsPPP5NNwCSdU/u23To5dZ7Qx
	CVSjJkK0l94UZ1OcGlHCL/ZggCEpvGbwFu2Phv2L1vDA6VKfl1iYR1QSZ2aeMvyFpUtg7Kp+Focvy
	vP5pTzpfazqQ9TqvtWsC/NsU60ETiTZTx0faiPXoI2GdNc06hic4tA7ZSsiDXL4s7fL1m+wpNc9SO
	C7izFXsEptBDJ2nqmVlufPMamz+cLf83oRlkiKEeq3GhcWSEUmWDYxWywV4mDHCs7M6gmtiB4eQX2
	/CvuxApIc/XKfdGreRdelvQ8HqvgRmOMPZdg9/xnSJOMibAz34TEfprrDNl7zd7FQelqYzf1tKig1
	0kf4lgVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEIj-0000000775F-3bU5;
	Wed, 13 Nov 2024 14:24:57 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEIg-0000000773n-2hZj
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 14:24:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8AB1AA400DD;
	Wed, 13 Nov 2024 14:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C09C4CEC3;
	Wed, 13 Nov 2024 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731507893;
	bh=w3KA42vZqZnTiGziMk7b/yRyjsLnkFIFQiy2JpfoeKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHgPtiMbHRVWSqvsp+o6JF3Ks1lyQBMcJu61L4muW6tpaAJaU8Dp4/rg4eIqhipxG
	 Oxh21Zt/B86ukCYl8bekJIFaBOhNOUr0fYaOiTV71YJkpN43f+YzTruUGRG3olbDY1
	 vI4+ydqP9Bd2MJ0r4bnFPrEwEPFdrGAR1dE6gDCg=
Date: Wed, 13 Nov 2024 15:24:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/8] driver core: bus: add irq_get_affinity callback
 to bus_type
Message-ID: <2024111328-cheer-mutate-3ee2@gregkh>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-1-573bfca0cbd8@kernel.org>
 <76da6c05-4f28-41cc-a48e-da2ae16c64c4@oracle.com>
 <2d85aa5e-037a-45c3-9f2d-e46b2159b697@flourine.local>
 <bed15207-c3d8-4e0b-b356-4880f5a4fdff@oracle.com>
 <2024111323-darkening-sappy-23fa@gregkh>
 <5ed6e072-5ff1-4327-aee1-e6cdf673fa67@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed6e072-5ff1-4327-aee1-e6cdf673fa67@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_062454_830952_BB50FA84 
X-CRM114-Status: GOOD (  27.44  )
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

On Wed, Nov 13, 2024 at 02:12:30PM +0000, John Garry wrote:
> On 13/11/2024 13:54, Greg Kroah-Hartman wrote:
> > > diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> > > b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> > > index 342d75f12051..5172af77a3f0 100644
> > > --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> > > +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> > > @@ -3636,6 +3636,7 @@ static struct platform_driver hisi_sas_v2_driver = {
> > >                 .name = DRV_NAME,
> > >                 .of_match_table = sas_v2_of_match,
> > >                 .acpi_match_table = ACPI_PTR(sas_v2_acpi_match),
> > > +               .irq_get_affinity_mask = hisi_sas_v2_get_affinity_mask,
> > >         },
> > > };
> > > 
> > > 
> > > > If no one objects, I go ahead and add the callback to struct
> > > > device_driver.
> > > I'd wait for Christoph and Greg to both agree. I was just wondering why we
> > > use bus_type.
> > bus types are good to set it at a bus level so you don't have to
> > explicitly set it at each-and-every-driver.  Depends on what you want
> > this to be, if it is a "all drivers of this bus type will have the same
> > callback" then put it on the bus.  otherwise if you are going to
> > mix/match on a same bus, then put it in the driver structure.
> 
> Understood, I think all drivers on same bus will use the same callback.
> 
> FWIW, most drivers of interest are pci drivers, so I thought that it would
> simply be a change like this (for those drivers if we use struct
> device_driver):
> 
> @@ -1442,6 +1455,7 @@ int __pci_register_driver(struct pci_driver
> *drv, struct module *owner,
>        drv->driver.mod_name = mod_name;
>        drv->driver.groups = drv->groups;
>        drv->driver.dev_groups = drv->dev_groups;
> +       drv->driver.irq_get_affinity = pci_device_irq_get_affinity;

Yes, you can do that too.  But now you have a pointer-per-driver instead
of just one-per-bus.  It's not a big deal, but again if this is always
going to be the same for everything on a bus, make it a bus pointer
please.

thanks,

greg k-h

