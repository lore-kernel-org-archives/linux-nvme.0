Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760FFC352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 07:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cUCLAh+st4VgUdVt1mfKix9JBujpG3Vn8xrRD4knPLA=; b=L/vyI8dn0Tsq35L8GL42cHWyRB
	temLD/mq5cyiEemwJ5v1rTDTfoanSnQV96qC2BxocUTPKL84m1nqw9rTIyk3G7rSij7aoDvhb8Bcw
	XvgsLWf8afgUGIx9OyICYeXvI2bZmnp7AxVAsWqw22KZDxHvsKRq6Dzg+w0JUOXLZHvEMj6eRg/xU
	DeyCt1qcX5kit6QpiykjUFuGJWf0ZWc2R1Gtn1QQ2IsQdxMWA+F+QSVZ9SsscJBsnCXkGM4FqxgfK
	wJ5m6AyjnaZHqRB4fjJy74cSEtxwwzVjdBk0jy4QCEBwKgb8DKqPrVbxqcIFRGrWUDNdiBZEhTQso
	3rHOYeZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2pG8-00EQ8B-Qa; Wed, 07 Dec 2022 07:54:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2pG4-00EPq6-RH
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 07:54:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2111768AA6; Wed,  7 Dec 2022 08:54:15 +0100 (CET)
Date: Wed, 7 Dec 2022 08:54:15 +0100
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
Message-ID: <20221207075415.GB2283@lst.de>
References: <20221206055816.292304-1-lei.rao@intel.com> <20221206055816.292304-2-lei.rao@intel.com> <20221206061940.GA6595@lst.de> <Y49HKHP9NrId39iH@ziepe.ca> <20221206135810.GA27689@lst.de> <Y49eObpI7QoSnugu@ziepe.ca> <20221206153811.GB2266@lst.de> <Y49k++D3i8DfLOLL@ziepe.ca> <20221206165503.GA8677@lst.de> <Y4+U3VR2LeEh2S7B@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4+U3VR2LeEh2S7B@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_235425_070479_70F60A23 
X-CRM114-Status: GOOD (  17.58  )
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

On Tue, Dec 06, 2022 at 03:15:41PM -0400, Jason Gunthorpe wrote:
> What the kernel is doing is providing the abstraction to link the
> controlling function to the VFIO device in a general way.
> 
> We don't want to just punt this problem to user space and say 'good
> luck finding the right cdev for migration control'. If the kernel
> struggles to link them then userspace will not fare better on its own.

Yes.  But the right interface for that is to issue the userspace
commands for anything that is not normal PCIe function level
to the controlling funtion, and to discover the controlled functions
based on the controlling functions.

In other words:  there should be absolutely no need to have any
special kernel support for the controlled function.  Instead the
controlling function enumerates all the function it controls exports
that to userspace and exposes the functionality to save state from
and restore state to the controlled functions.

> Especially, we do not want every VFIO device to have its own crazy way
> for userspace to link the controlling/controlled functions
> together. This is something the kernel has to abstract away.

Yes.  But the direction must go controlling to controlled, not the
other way around. 

