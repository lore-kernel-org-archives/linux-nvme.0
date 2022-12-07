Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DB8C352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 18:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V7UOXlrIQM+DeLCjauT2NFD9iSDfL7jVpFYnpCrBdbw=; b=oqGz+0hUheS2W6POg8+J4umGGS
	Kk/HzxS2k/GUJQ3Iui3T65g/PHKS7atgYLBwbl7T4J/FiCYhRJ+0mFkPCzLYZYzAopzS5pe8KvSRg
	/PAyQjPm6G3SGTlbfDzDAqRgvbXptZUyPyOPSkW2Auq7LGAmrK763gCTRZhD8RM8+SKDh7ofJ3B24
	qm3O5XNEdC76mJIVHtH8kIzYj8IxfU9fcq6rz3tImIcsIs+PvxLjrkNAb9J3xq1XBAidEz12EoPhN
	YPaT57eoI34+Q2HB9edkhPqggjLyfojugp4Ehf45yDC21jReyKG7/RnMTdRpfH0zAC6KLJlB1GHhs
	9emltRQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2zEo-008pEd-Fs; Wed, 07 Dec 2022 18:33:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2zEk-008p1F-8q
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 18:33:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D192568AFE; Wed,  7 Dec 2022 19:33:33 +0100 (CET)
Date: Wed, 7 Dec 2022 19:33:33 +0100
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
Message-ID: <20221207183333.GA7049@lst.de>
References: <20221206153811.GB2266@lst.de> <Y49k++D3i8DfLOLL@ziepe.ca> <20221206165503.GA8677@lst.de> <Y4+U3VR2LeEh2S7B@ziepe.ca> <20221207075415.GB2283@lst.de> <Y5CWVu08abcOuEQH@ziepe.ca> <20221207135203.GA22803@lst.de> <Y5CsH5PqMYAWYatw@ziepe.ca> <20221207163857.GB2010@lst.de> <Y5DOAKArjyfb6Mcz@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5DOAKArjyfb6Mcz@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_103342_479486_A3D4846C 
X-CRM114-Status: GOOD (  16.96  )
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

On Wed, Dec 07, 2022 at 01:31:44PM -0400, Jason Gunthorpe wrote:
> > Sorry, I meant VF.  Your continued using of SR-IOV teminology now keeps
> > confusing my mind so much that I start mistyping things.
> 
> Well, what words do you want to use?

The same I've used through this whole thread:  controlling and
controlled function.

> So I don't think I've learned anything more about your objection.
> 
> "fundamentally broken" doesn't help

The objection is that:

 - in hardware fundamentally only the controlling funtion can
   control live migration features on the controlled function,
   because the controlled function is assigned to a VM which has
   control over it.
 - for the same reason there is no portable way to even find
   the controlling function from a controlled function, unless
   you want to equate PF = controlling and VF = controlled,
   and even that breaks down in some corner cases
 - if you want to control live migration from the controlled
   VM you need a new vfio subdriver for a function that has
   absolutely no new functionality itself related to live
   migration (quirks for bugs excepted).

So by this architecture you build a convoluted mess where you
need tons of vfio subdrivers that mostly just talk to the
driver for the controlling function, which they can't even
sanely discover.  That's what I keep calling fundamentally
broken.

