Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41C5C4708E
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 16:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1GaFqgPXmAfwDzAsLHQhkzY6GeCahZTSrWGKHKleOfE=; b=jbHy7kKmHDGfC0GMtOKhpFfl5a
	J4koUWqwaxzS2H+N8HfIy6Em/UqMgyiIV5WurHqMjEorMGQj+KCIuKsF2MgoGVETz0ijsooEmSrhZ
	UVJV7kdO0mYhWwpRkLCAUpEQALdecjuKaaUCpuvZ6csmdHDGQkAVpP65NFTK3tRA6cFgKYXZwM8kL
	nTekyLsBFsQjVci3+x3m8dEO2M9HGXpTrhRDswjZdBg3lnUJUzrakVsPXbdiKFw3UmaE0ddLUOukq
	HR3XHLvITZcrKDrZ8tx1XSepbf5XoHJkSP7laf411+NxSQt2pOgDZtg0ohXNAMqH1lJqIj/X7JbON
	sqQumJAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2xRo-006nrO-O5; Wed, 07 Dec 2022 16:39:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2xRl-006noB-VY
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 16:39:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 83FB967373; Wed,  7 Dec 2022 17:38:57 +0100 (CET)
Date: Wed, 7 Dec 2022 17:38:57 +0100
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
Message-ID: <20221207163857.GB2010@lst.de>
References: <20221206135810.GA27689@lst.de> <Y49eObpI7QoSnugu@ziepe.ca> <20221206153811.GB2266@lst.de> <Y49k++D3i8DfLOLL@ziepe.ca> <20221206165503.GA8677@lst.de> <Y4+U3VR2LeEh2S7B@ziepe.ca> <20221207075415.GB2283@lst.de> <Y5CWVu08abcOuEQH@ziepe.ca> <20221207135203.GA22803@lst.de> <Y5CsH5PqMYAWYatw@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5CsH5PqMYAWYatw@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_083902_184921_7DF50840 
X-CRM114-Status: GOOD (  24.28  )
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

On Wed, Dec 07, 2022 at 11:07:11AM -0400, Jason Gunthorpe wrote:
> > And while that is a fine concept per see, the current incarnation of
> > that is fundamentally broken is it centered around the controlled
> > VM.  Which really can't work.
> 
> I don't see why you keep saying this. It is centered around the struct
> vfio_device object in the kernel, which is definately NOT the VM.

Sorry, I meant VF.  Your continued using of SR-IOV teminology now keeps
confusing my mind so much that I start mistyping things.

> > Even then you need a controlling and a controlled entity.  The
> > controlling entity even in SIOV remains a PCIe function.  The
> > controlled entity might just be a bunch of hardware resoures and
> > a PASID.  Making it important again that all migration is driven
> > by the controlling entity.
> 
> If they are the same driver implementing vfio_device you may be able
> to claim they conceptually exist, but it is pretty artificial to draw
> this kind of distinction inside a single driver.

How are they in this reply?  I can't parse how this even relates to
what I wrote.

> > Also the whole concept that only VFIO can do live migration is
> > a little bogus.  With checkpoint and restart it absolutely
> > does make sense to live migrate a container, and with that
> > the hardware interface (e.g. nvme controller) assigned to it.
> 
> I agree people may want to do this, but it is very unclear how SRIOV
> live migration can help do this.

SRIOV live migration doesn't, because honestly there is no such
thing as "SRIOV" live migration to start with.

> Let alone how to solve the security problems of allow userspace to
> load arbitary FW blobs into a device with potentially insecure DMA
> access..

Any time you assign a PCI device to userspace you might get into that.

