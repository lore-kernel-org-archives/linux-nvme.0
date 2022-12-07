Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD06C352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 13:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MFKNh80dzIIpEyweaTCY011xl4hhNd3bRFmb/w3ouyc=; b=bPdXpY2gZcSFsH0D5WKIgzd5D8
	LujeS6bd+IFd3+Q6uylophfI3kfWEksNsZcEFUb8ex+850vbeEsnupBgnNgRW9+9iL2/TdT98BKxc
	f0k+W4NotmnUNaDn2NPutrs1t+qqTAT0nk6r1VxQCnhSHDcYh2vPLxHQ2HJoCFHkwTHuvEfuCGMCU
	WdrIuaJHJyMremdtT+u/QuGPrq5nUyvt5LZeOeosHloDtdoOawUcCHND3JWcWsYnQTLI2E+Kj8nXE
	aLcxnMyRry2/ypzceZVTmnSWOpLTYEA913O87Zi7zRSwA1p+z69fp91FOXWLDqrLHSxGtsmhFIzNk
	ceY9sAVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2uqI-004ESX-R1; Wed, 07 Dec 2022 13:52:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2uqG-004EQf-DT
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 13:52:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E599267373; Wed,  7 Dec 2022 14:52:03 +0100 (CET)
Date: Wed, 7 Dec 2022 14:52:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Lei Rao <lei.rao@intel.com>,
	kbusch@kernel.org, axboe@fb.com, kch@nvidia.com, sagi@grimberg.me,
	alex.williamson@redhat.com, cohuck@redhat.com, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
	mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
	eddie.dong@intel.com, yadong.li@intel.com, yi.l.liu@intel.com,
	Konrad.wilk@oracle.com, stephen@eideticom.com, hang.yuan@intel.com
Subject: Re: [RFC PATCH 1/5] nvme-pci: add function nvme_submit_vf_cmd to
 issue admin commands for VF driver.
Message-ID: <20221207135203.GA22803@lst.de>
References: <20221206061940.GA6595@lst.de> <Y49HKHP9NrId39iH@ziepe.ca> <20221206135810.GA27689@lst.de> <Y49eObpI7QoSnugu@ziepe.ca> <20221206153811.GB2266@lst.de> <Y49k++D3i8DfLOLL@ziepe.ca> <20221206165503.GA8677@lst.de> <Y4+U3VR2LeEh2S7B@ziepe.ca> <20221207075415.GB2283@lst.de> <Y5CWVu08abcOuEQH@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5CWVu08abcOuEQH@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_055208_621094_6910E53F 
X-CRM114-Status: GOOD (  19.22  )
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

On Wed, Dec 07, 2022 at 09:34:14AM -0400, Jason Gunthorpe wrote:
> The VFIO design assumes that the "vfio migration driver" will talk to
> both functions under the hood, and I don't see a fundamental problem
> with this beyond it being awkward with the driver core.

And while that is a fine concept per see, the current incarnation of
that is fundamentally broken is it centered around the controlled
VM.  Which really can't work.

> Even the basic assumption that there would be a controlling/controlled
> relationship is not universally true. The mdev type drivers, and 
> SIOV-like devices are unlikely to have that. Once you can use PASID
> the reasons to split things at the HW level go away, and a VF could
> certainly self-migrate.

Even then you need a controlling and a controlled entity.  The
controlling entity even in SIOV remains a PCIe function.  The
controlled entity might just be a bunch of hardware resoures and
a PASID.  Making it important again that all migration is driven
by the controlling entity.

Also the whole concept that only VFIO can do live migration is
a little bogus.  With checkpoint and restart it absolutely
does make sense to live migrate a container, and with that
the hardware interface (e.g. nvme controller) assigned to it.

> So, when you see both Intel and Pensando proposing this kind of
> layered model for NVMe where migration is subsystem-local to VFIO, I
> think this is where the inspiration is coming from. Their native DPU
> drivers already work this way.

Maybe they should have talked to someone not high on their own
supply before designing this.

