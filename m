Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA828C63705
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 20:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vr5WiCvTh3UIK/ZVLkYO3CxfyfQu9sqezzU1lem3qSI=; b=A4lW8Kj0HDMO9JX6/XeHBmDf2O
	PPACvsiOl3liJjrZz59zgP0MRpK2USGPxIDXAGnRQXMC5q2IAqYue6HozxjAhuTYCZpOoCkrbcm9d
	ZNxZUGw2v10Rh5B9Q1p5ozkAJy6cB5E7GKLv6VJ3izGxyqFhaTcUtfTzjHkwn9Jjr1lE5AB6zSImJ
	K9AE83gk36wu4H3cpilqeOUH9UuMxpH4LQOjtf/T4D1ONDVnLyA1DLmQ4QIotlQndhl6URDaFWMxg
	DohPmI4mFhqEopm0jvWkAJmUsiE+dyenRqGoccKy13kVNqk0kY86kSszOitDa/DgbOFFl0t9TvaRG
	0ZxQXRiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p30iA-00BZIv-V9; Wed, 07 Dec 2022 20:08:11 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p30i7-00BZCU-Bc
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 20:08:09 +0000
Received: by mail-qv1-xf33.google.com with SMTP id i12so13445935qvs.2
        for <linux-nvme@lists.infradead.org>; Wed, 07 Dec 2022 12:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vr5WiCvTh3UIK/ZVLkYO3CxfyfQu9sqezzU1lem3qSI=;
        b=YCUg4PpbC8tWQcP/j2pX6xtXhkhIANkGRKqwa0o8UMps3pEfjeu5/R4N/tGf3nha2v
         CHvipOOXOXX3KqsLbyV5E6K4gQ1fvj6f2baLUE9My4QvRrN+EzRAoztf8iO0QBdU++QW
         VcALPMS+0FXsZdgsBC2tnHCZpqz0RoA6J145my+5ci8rOi8MjU05ML5Koaw30WwbnhtF
         dW1tx0K1qE5Z9Ae+uOAW7t0dpfckaNDalca944KTZRmEnnZwC6yASRPqvrNrYQBk9KCb
         9vXtSy1YbzDIzj608LLFV97I8x+9AMWk3g5re44m9SF1nGl4OLuf+n6KYOJDa+cjD28u
         Ll1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vr5WiCvTh3UIK/ZVLkYO3CxfyfQu9sqezzU1lem3qSI=;
        b=VprwY9h73VHOAm6M+0j71uwO1ivztA0nd2tMnRrCC9ZIpHAvzuZOf+W0IJeMcyxn0H
         Bbuv5K8izJXS3DE6t1DqxhL/gwy99d5jIJt4SqcBV2AepdtpEAlDmlC4saL9CdN5CEDK
         +rBjM/rwYosFFoPEGh8nMNVn8Dlz551rtiYlpC0685KBqSyXFYqz15vpxQuj2ZOWW6BL
         Q47psS2jhMmFqfO4552r0fc+Mfw9kNLWYNPdP6KIPH/iEiGEDBDi5uuf+CHp5p2d53Jm
         haarlTqDJrOQVuOFdCWrDKW2ghY3045fq8CpIawic9UFrrZYmsCDIe7Vmb0GNs9MoVLD
         SnMw==
X-Gm-Message-State: ANoB5pkvXaCj83vG32s4lRm0Sz0BQg/WrErOBbGEED7xefF+qqkAGDfX
	EE1tkN7l0XRUBBrbQI8VGh1UZg==
X-Google-Smtp-Source: AA0mqf5w89FO6T+zn7AhtSpDQo0RQb6vBJBRzeDWVezZlB+35JGB8LIDTcRdxHgklWspWMK3KABlxg==
X-Received: by 2002:a0c:f94e:0:b0:4c7:5d3a:69bf with SMTP id i14-20020a0cf94e000000b004c75d3a69bfmr16196245qvo.9.1670443683420;
        Wed, 07 Dec 2022 12:08:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id bl12-20020a05620a1a8c00b006fbb4b98a25sm17638764qkb.109.2022.12.07.12.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:08:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1p30i2-005Luz-2M;
	Wed, 07 Dec 2022 16:08:02 -0400
Date: Wed, 7 Dec 2022 16:08:02 -0400
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
Message-ID: <Y5DyorZJPdtN5WcX@ziepe.ca>
References: <Y49k++D3i8DfLOLL@ziepe.ca>
 <20221206165503.GA8677@lst.de>
 <Y4+U3VR2LeEh2S7B@ziepe.ca>
 <20221207075415.GB2283@lst.de>
 <Y5CWVu08abcOuEQH@ziepe.ca>
 <20221207135203.GA22803@lst.de>
 <Y5CsH5PqMYAWYatw@ziepe.ca>
 <20221207163857.GB2010@lst.de>
 <Y5DOAKArjyfb6Mcz@ziepe.ca>
 <20221207183333.GA7049@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207183333.GA7049@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_120807_528699_F20DE143 
X-CRM114-Status: GOOD (  35.94  )
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

On Wed, Dec 07, 2022 at 07:33:33PM +0100, Christoph Hellwig wrote:
> On Wed, Dec 07, 2022 at 01:31:44PM -0400, Jason Gunthorpe wrote:
> > > Sorry, I meant VF.  Your continued using of SR-IOV teminology now keeps
> > > confusing my mind so much that I start mistyping things.
> > 
> > Well, what words do you want to use?
> 
> The same I've used through this whole thread:  controlling and
> controlled function.
> 
> > So I don't think I've learned anything more about your objection.
> > 
> > "fundamentally broken" doesn't help
> 
> The objection is that:
> 
>  - in hardware fundamentally only the controlling funtion can
>    control live migration features on the controlled function,
>    because the controlled function is assigned to a VM which has
>    control over it.

Yes

However hisilicon managed to do their implementation without this, or
rather you could say their "controlling function" is a single MMIO BAR
page in their PCI VF and their "controlled function" is the rest of
the PCI VF.

>  - for the same reason there is no portable way to even find
>    the controlling function from a controlled function, unless
>    you want to equate PF = controlling and VF = controlled,
>    and even that breaks down in some corner cases

As you say, the kernel must know the relationship between
controlling->controlled. Nothing else is sane.

If the kernel knows this information then we can find a way for the
vfio_device to have pointers to both controlling and controlled
objects. I have a suggestion below.

>  - if you want to control live migration from the controlled
>    VM you need a new vfio subdriver for a function that has
>    absolutely no new functionality itself related to live
>    migration (quirks for bugs excepted).

I see it differently, the VFIO driver *is* the live migration
driver. Look at all the drivers that have come through and they are
99% live migration code. They have, IMHO, properly split the live
migration concern out of their controlling/PF driver and placed it in
the "VFIO live migration driver".

We've done a pretty good job of allowing the VFIO live migration
driver to pretty much just focus on live migration stuff and delegate
the VFIO part to library code.

Excepting quirks and bugs sounds nice, except we actually can't ignore
them. Having all the VFIO capabilities is exactly how we are fixing
the quirks and bugs in the first place, and I don't see your vision
how we can continue to do that if we split all the live migration code
into yet another subsystem.

For instance how do I trap FLR like mlx5 must do if the
drivers/live_migration code cannot intercept the FLR VFIO ioctl?

How do I mangle and share the BAR like hisilicon does?

Which is really why this is in VFIO in the first place. It actually is
coupled in practice, if not in theory.

> So by this architecture you build a convoluted mess where you need
> tons of vfio subdrivers that mostly just talk to the driver for the
> controlling function, which they can't even sanely discover.  That's
> what I keep calling fundamentally broken.

The VFIO live migration drivers will look basically the same if you
put them under drivers/live_migration. This cannot be considered a
"convoluted mess" as splitting things by subsystem is best-practice,
AFAIK.

If we accept that drivers/vfio can be the "live migration subsystem"
then lets go all the way and have the controlling driver to call
vfio_device_group_register() to create the VFIO char device for the
controlled function.

This solves the "sanely discover" problem because of course the
controlling function driver knows what the controlled function is and
it can acquire both functions before it calls
vfio_device_group_register().

This is actually what I want to do anyhow for SIOV-like functions and
VFIO. Doing it for PCI VFs (or related PFs) is very nice symmetry. I
really dislike that our current SRIOV model in Linux forces the VF to
instantly exist without a chance for the controlling driver to
provision it.

We have some challenges on how to do this in the kernel, but I think
we can overcome them. VFIO is ready for this thanks to all the
restructuring work we already did.

I'd really like to get away from VFIO having to do all this crazy
sysfs crap to activate its driver. I think there is a lot of appeal to
having, say, a nvmecli command that just commands the controlling
driver to provision a function, enable live migration, configure it
and then make it visible via VFIO. The same API regardless if the
underlying controlled function technology is PF/VF/SIOV.

At least we have been very interested in doing that for networking
devices.

Jason

