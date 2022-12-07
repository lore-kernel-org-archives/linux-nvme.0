Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91455C63705
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 13:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l6xJr+k1Rglf8MP4WV7CssKD0Zhdk6N8F5ziwJ65c+E=; b=EgbkuDijUUJ/I9zW8ZDF/7ud7/
	b2YZj/hBhjJr0DLRURBW+YtFkLfy2OncIHbQ6g2jSPvK8PoOQ0+mtaF97ljY1gws6oj9k0nNhJht9
	4Iga3PUjUeZ9leixBs3oxlx8AnC+GcLdSkxww5QcTcrtO5r3Tx1okTuSnuz3VI1S1i634nOeE/AKt
	I49X8tA11lG3zrW0iFc0foGGf0QsiuN1hzQjNJSfdLUShvqiEqJEIiai5qtaeCxz+BsDE1zvUyAWW
	cbXBHZ1Xh94nqBclqB0xu5mojaIV6ZNeIviGuWCJPjIMfp/FRayNi3DoC91KOfIj7KwfvIcvpfAZl
	5+r5JXQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2uZ3-003eOJ-LL; Wed, 07 Dec 2022 13:34:21 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2uZ0-003eGw-Fh
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 13:34:20 +0000
Received: by mail-qt1-x82f.google.com with SMTP id x28so15006611qtv.13
        for <linux-nvme@lists.infradead.org>; Wed, 07 Dec 2022 05:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l6xJr+k1Rglf8MP4WV7CssKD0Zhdk6N8F5ziwJ65c+E=;
        b=WHJVaTgaT4PNH+QudjAp44gzIj2kA06/emtbgyqhca7ByTe7tRve3x+VbVfVY4H3nL
         doA/AKmFKI4LZGyBGKoYAZTt9HD63XICxmeh7io6fkDoKx5ATTsJ/QlgDbj0wkmQ8Zpt
         46qN8QrBTRR+DeKKtFTFRYdyKEKshbig7w0o+6L3IL0BNU0DFKi/nBQm3QMcQ4LdotZj
         WFriWBSrr5zvlcsyxwrJG5X68S8Oz4KrbF6OnCq6u3v6FgPk9KnzGgYlOfajKFE2r4U4
         w/7bA1tjMT3RPbe2OZPgArHAAkZQE++UZ5V/F+8PhthPBl6wDBtZwI92D5oUpsZkKH3g
         Ocyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6xJr+k1Rglf8MP4WV7CssKD0Zhdk6N8F5ziwJ65c+E=;
        b=JVTuJvurgzJ/U9fj45PU6UrhOwr4bf/HyQICndvzfjQ+mtQKDrS6OTkf3PWWKFbmSO
         rCbnvtdHK2G7uLPtS1KGBBZLIltHeEGIXyzm1O9Pa7CQn2AadHC7YhAZqIL1d2M+qh57
         G7TFHrmOM7TM29yilQhtEPFvooaO9uA2xX8ICJFgCS64lTZYR+PmTK+w/A5kA81exVUh
         eRnNsaCR55G4swGZ9hRx6whB+s7ELlN3dhKxFqWa5Hco1T9HqtUXiQt2VFmxArFZ4p0v
         0vDrSV5xkvd/BLfbf7vPyfFOpeSgfm0JuxOZt7EaqoEB+IfIBI1TYRPn3fWB1zy5szG6
         Z6zQ==
X-Gm-Message-State: ANoB5pns1jN1LxLi+Tpa9W1z/WMT7lTvt5gKQAQgHZ0hoXTXEqhq4k76
	aTRsUB1Q29RSAT6lQJsBZTbBAw==
X-Google-Smtp-Source: AA0mqf6OBFWho/zwcOD2yDk6+4VVFeBbc9/jSzH+8hz4umfWOI5B8acMwsylGVXQnMfPrHPr96lxEQ==
X-Received: by 2002:ac8:548:0:b0:3a5:2fd6:cf82 with SMTP id c8-20020ac80548000000b003a52fd6cf82mr83999346qth.62.1670420056314;
        Wed, 07 Dec 2022 05:34:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id z18-20020ac87112000000b0039853b7b771sm13614698qto.80.2022.12.07.05.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 05:34:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1p2uYw-005CTN-Gj;
	Wed, 07 Dec 2022 09:34:14 -0400
Date: Wed, 7 Dec 2022 09:34:14 -0400
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
Message-ID: <Y5CWVu08abcOuEQH@ziepe.ca>
References: <20221206055816.292304-2-lei.rao@intel.com>
 <20221206061940.GA6595@lst.de>
 <Y49HKHP9NrId39iH@ziepe.ca>
 <20221206135810.GA27689@lst.de>
 <Y49eObpI7QoSnugu@ziepe.ca>
 <20221206153811.GB2266@lst.de>
 <Y49k++D3i8DfLOLL@ziepe.ca>
 <20221206165503.GA8677@lst.de>
 <Y4+U3VR2LeEh2S7B@ziepe.ca>
 <20221207075415.GB2283@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207075415.GB2283@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_053418_881831_856DFF96 
X-CRM114-Status: GOOD (  32.09  )
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

On Wed, Dec 07, 2022 at 08:54:15AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 06, 2022 at 03:15:41PM -0400, Jason Gunthorpe wrote:
> > What the kernel is doing is providing the abstraction to link the
> > controlling function to the VFIO device in a general way.
> > 
> > We don't want to just punt this problem to user space and say 'good
> > luck finding the right cdev for migration control'. If the kernel
> > struggles to link them then userspace will not fare better on its own.
> 
> Yes.  But the right interface for that is to issue the userspace
> commands for anything that is not normal PCIe function level
> to the controlling funtion, and to discover the controlled functions
> based on the controlling functions.

I don't think we should mix up how the HW works, what PCI function the
commands are executed at, with how the uAPI is designed.

The VFIO design assumes that the "vfio migration driver" will talk to
both functions under the hood, and I don't see a fundamental problem
with this beyond it being awkward with the driver core.

It is done this way deliberately. When we did the work on it we found
there are problems with some device models, like when you suspend them
and then wrongly MMIO touch them they can trigger AER and maybe even a
machine check crash. One of the roles of the VFIO driver is to fix
these HW bugs and make the uAPI safe. Eg by revoking mmaps or
whatever.

Even more importantly, we do not want migration to ever be operated
unless VFIO is in control of the device. In general, migration resume
basically allows userspace to command the device to do effectively any
DMA. This is a kernel security problem if the device is not
constrained by a user iommu_domain - for security we must not allow
userspace to resume a VF that is under kernel control and potentially
linked to an passthrough iommu_domain.

VFIO provides the security model to make all of this safe - the two
concepts cannot become disconnected. Even if we create a new migration
uAPI it just means that the nvme driver has to be awkwardly aware of
VFIO VF drivers and interlock with their state, and the uAPI is
useless unless you already have a VFIO FD open.

Even the basic assumption that there would be a controlling/controlled
relationship is not universally true. The mdev type drivers, and 
SIOV-like devices are unlikely to have that. Once you can use PASID
the reasons to split things at the HW level go away, and a VF could
certainly self-migrate.

VFIO's goal is to abstract all of the above stuff. You get one char
device that inherently provides the security guarentees required to
operate migration. It provides all the necessary hooks to fix up HW
issues, which so far every merged device has:

 - mlx5 has a weird issue where FLR on the VF resets the migration
   context, we fix that in the VFIO driver (in mlx5 even though the
   commands are issued via the PF they are logically executed inside
   the VF context)

 - hi-silicon has security problems because it doesn't have
   controlling/controlled, so it needs to carve out BAR MMIO maps and
   other stuff

So while I agree that, in principle, migration and the VFIO VF are
seperate concerns our broken reality makes them linked.

Even the idea that started this thread - that PF/PF could be a problem
- seems to have been explored by the Pensando RFC which is using the
aux devices to connect arbitrary PF/PF for their model.

The logical model we have been using on complex multi-function devices
(like every DPU driver) has been to split the driver into subsystem
local code and thread all the pieces together with aux devices.

The model has a PCI driver that operates the lowest level of the
device, eg the 'admin queue' and then aux devices create
subsystem-local drivers (netdev, rdma, vdpa, iscsi, vfio, etc, etc)
that ride on the common API exported by the PCI driver.

So, when you see both Intel and Pensando proposing this kind of
layered model for NVMe where migration is subsystem-local to VFIO, I
think this is where the inspiration is coming from. Their native DPU
drivers already work this way.

Jason

