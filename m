Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8966AC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Dec 2022 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6/49i19ww7B/xcmBcFjP0U5z4N9HY5b8Hm8g3kdlG5g=; b=rDqcevUr94REe9AHnJmqC/mw09
	Vg14aUbxZDBSwYBR9Vi6NBJVL75g2b2pINAIiddjOs0upe4YolNz8wKgXmbXHgboy9oS9kMVtnGi3
	k+8gTiJhsEBkzJbbCUHYAefrMnuuHjpZXnK79leh0ZYLBfdag+6ftgTOmrmnCZe+rXQCUqz4ghgGS
	USeW3IMqZjWQuCT0BvkmHYR75UmW2V0c6iWMfIEt4LDTqYOfLPWcjGVY9m3yblnF3SUYKBna8qlIt
	d11Gin0FphrLXDy+ARc5EImsjn3iEZAQrBZBWkhGBXnfh+gNQDBgW/iSzScoYFPCLyufvw/u95T1R
	S3lLmjLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p55qW-000pQt-Uq; Tue, 13 Dec 2022 14:01:24 +0000
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p55qP-000pPp-O5
	for linux-nvme@lists.infradead.org; Tue, 13 Dec 2022 14:01:19 +0000
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3bfd998fa53so192273197b3.5
        for <linux-nvme@lists.infradead.org>; Tue, 13 Dec 2022 06:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/49i19ww7B/xcmBcFjP0U5z4N9HY5b8Hm8g3kdlG5g=;
        b=hf1kzp+NfEnJnMm4M2VpOttjLAl+nFQGQlH1GlyTF9rPOV0mEt4UTUxrElHLLepo+m
         cWxSmm8Azkpl+WJGFkt5f8WuumXgVt1Jbw69fwg9t37lNPOVaJOSOrHWLyrHXsOCw4vi
         k4YUJNmfyKbWkNhpsJfHCDfeBplpcI9Co2rr6c18BSpkyhYWmA60Z/K7rTZhBy7BlwZc
         ZMZbuRuB9aVodNhrHde4kutbg4d57Mg/UrfPKhEyn5X36Lwx6BuqzywlbAtEYPzdDFeX
         N0rUOi5Fy259ReXgdCdjsXEstDbsQgFWgVXp1W1mqTnCoTSBdL1YihTcxhdKk8MxfdbV
         atrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/49i19ww7B/xcmBcFjP0U5z4N9HY5b8Hm8g3kdlG5g=;
        b=mzyLuiCiAnzRMeXHNVcCkAgNrXtYsAAEMGcwgcxWPDCOCqy8KMRkg5tyvFH0VAQos1
         mCCxf/mFAcr95+FErpTl8LLyQbKaXifZRWxCrifVg59SBgToJmwhSJAybfxrCCvR5rNU
         zMW4iEKxr0ni8WWRk2WMIJP5DFhK8JbEAXV7bmTvVAK7p2bVlSxz+eEn93xoN1dZl0rS
         OCgY2IL8+8TUidP7NZbtGoFET4rM7vighaFfGwJK28d5ax3LHmcfq0gan73Fk0CISnuA
         qlXjSLm4QojDHqZ+Jq2FHRONCcXKmiZGr7r0E/qzhWMw48fR43PEV+nrS1bWRQQAh5hS
         0sWQ==
X-Gm-Message-State: ANoB5pk5HCf5yOIsQoVQHEDbD055r30OUyIeh6RakfgemJX/pccm4/KT
	WXUDk/dXEN2PkshJB1bV4NM2XQ==
X-Google-Smtp-Source: AA0mqf4MGueTut2qLTFaHdf+Zme8qgmXQUV5NUInn//zVT1CrEtYI77vWxcW8B/cVk6VB1BC84VA7g==
X-Received: by 2002:a05:7500:5696:b0:ea:f6ed:7d50 with SMTP id ca22-20020a057500569600b000eaf6ed7d50mr1807617gab.14.1670940065724;
        Tue, 13 Dec 2022 06:01:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id bp32-20020a05620a45a000b006fcaa1eab0esm783696qkb.123.2022.12.13.06.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 06:01:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1p55qB-009VAx-P5;
	Tue, 13 Dec 2022 10:01:03 -0400
Date: Tue, 13 Dec 2022 10:01:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Lei Rao <lei.rao@intel.com>, kbusch@kernel.org, axboe@fb.com,
	kch@nvidia.com, sagi@grimberg.me, alex.williamson@redhat.com,
	cohuck@redhat.com, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
	mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
	eddie.dong@intel.com, yadong.li@intel.com, yi.l.liu@intel.com,
	Konrad.wilk@oracle.com, stephen@eideticom.com, hang.yuan@intel.com
Subject: Re: [RFC PATCH 1/5] nvme-pci: add function nvme_submit_vf_cmd to
 issue admin commands for VF driver.
Message-ID: <Y5iFnw5i3vI9iMFY@ziepe.ca>
References: <Y4+U3VR2LeEh2S7B@ziepe.ca>
 <20221207075415.GB2283@lst.de>
 <Y5CWVu08abcOuEQH@ziepe.ca>
 <20221207135203.GA22803@lst.de>
 <Y5CsH5PqMYAWYatw@ziepe.ca>
 <20221207163857.GB2010@lst.de>
 <Y5DOAKArjyfb6Mcz@ziepe.ca>
 <20221207183333.GA7049@lst.de>
 <Y5DyorZJPdtN5WcX@ziepe.ca>
 <20221212075046.GB11162@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212075046.GB11162@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_060118_142735_3932C493 
X-CRM114-Status: GOOD (  43.47  )
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

On Mon, Dec 12, 2022 at 08:50:46AM +0100, Christoph Hellwig wrote:
> On Wed, Dec 07, 2022 at 04:08:02PM -0400, Jason Gunthorpe wrote:
> > However hisilicon managed to do their implementation without this, or
> > rather you could say their "controlling function" is a single MMIO BAR
> > page in their PCI VF and their "controlled function" is the rest of
> > the PCI VF.
> 
> Eww.  So you need to carefully filter the BAR and can't actually do
> any DMA at all?  I'm not sure that is actually practical, especially
> not for something with a lot of state.

Indeed, but it is what they did and the HW should be supported by the
kernel, IMO.

> > If the kernel knows this information then we can find a way for the
> > vfio_device to have pointers to both controlling and controlled
> > objects. I have a suggestion below.
> 
> So now we need to write a vfio shim for every function even if there
> is absolutely nothing special about that function?  Migrating really
> is the controlling functions behavior, and writing a new vfio bit
> for every controlled thing just does not scale.

Huh? "does not scale?" We are looking at boilerplates of around 20-30
lines to make a VFIO driver for a real PCI device. Why is that even
something we should worry about optimizing?

And when you get into exciting future devices like SIOV you already
need to make a special VFIO driver anyhow.

> Yes, and that's the problem, because they are associated with the
> controlled function, and now we have a communication problem between
> that vfio driver binding to the controlled function and the drive
> that actually controlls live migration that is associated with the
> controlling function.  In other words: you've created a giant mess.

So far 100% of the drivers that have been presented, including the two
RFC ones, have entanglements between live migration and vfio. Shifting
things to dev/live_migration doesn't make the "communication problem"
away, it just shifted it into another subsystem.

This is my point, I've yet to even see a driver that meets your
theoretical standard that it can exist without vfio entanglement. So
I'd be much more interested in this idea if we had a stable of drivers
that obviously were harmed by VFIO. We don't have that, and I don't
even think that we ever will, considering both RFC drivers have
devices that also stepped on the mlx5 FLR problem too.

The FLR thing actually makes sense, becauase it is not actually the
controlling function that is doing the live migration inside the
devices. The controlling function is just a *proxy* to deliver
commands to the controlled function. So FLR on the controlled device
effects commands being executed on the controlling function. It is a
pain.

As it is, live migration is only useful with VFIO, so they are put
together to keep things simpler. The only complexity is the
controlled/controlling issue and for all existing SRIOV PF/VF
relationships we have an OK solution (at least it isn't buggy).

nvme's higher flexability needs more work, but that doesn't mean the
idea is so wrong. I think you are reall overstating the "mess"

> I'm not proposing to ignore them.  But they should not be needed most
> of the time.

I'm not seeing that in the drivers I've looked at.

> > Which is really why this is in VFIO in the first place. It actually is
> > coupled in practice, if not in theory.
> 
> So you've created a long term userspace API around working around
> around buggy and/or misdesigned early designs and now want to force
> it down everyones throat?

No, we coupled live migration and VFIO because they are never useful
apart, and we accept that we must find reasonable solutions to linking
the controlling/controlled device because it is necessary in all cases
we've seen.

> > If we accept that drivers/vfio can be the "live migration subsystem"
> > then lets go all the way and have the controlling driver to call
> > vfio_device_group_register() to create the VFIO char device for the
> > controlled function.
> 
> While creating the VFs from the PF driver makes a lot more sense,
> remember that vfio is absolutely not the only use case for VFs.
> There are plenty use cases where you want to use them with the normal
> kernel driver as well.  So the interface to create VFs needs a now
> to decide if it should be vfio exported, or use the normal kernel
> binding.

Yes, that is why this problem has been open for so long. Fixing it
well requires some reconsideration of how the driver core works :(

It is worse than just VFIO vs one kernel driver, like mlx5 could spawn
a controlled function that is NVMe, VDPA, mlx5, virtio-net, VFIO,
etc.

When we create the function we really want to tell the device what
kind of function it is, and that also tells the kernel what driver
should be bound to it.

mlx5 even has weird limitations, like a controlled function that is
live migration capable has fewer features than a function that is
not. So the user must specify what parameters it wants the controlled
function to have..

Jason

