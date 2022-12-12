Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B05C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 07:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lRpJbbda4aza7kCXDaj/IvOV35Xu5GcpVc/Oz1XG05M=; b=p832bP4gnYMSvHNAJnKF6YaX+D
	Oz75t7eOBPRMoIbht5FOZkiuzM7NR0nx3nxOd52bDbeB7eAYlWq6l9ilfJKLr0p1wxQT1KbqpZyui
	SpGuXHJkXSFihDWE1961BVNEfwe21tFDTORnySGUKUy4XEoRnvNIeYdHjZnymomvW4HPDa44dSbjU
	+Sf/s+Ewwx0Pc/mHVqcNNVYRmgqr6aaPje7q/E5iAgHBZnIVZzhMShmoZ+o4TTFO3E5evFFLbsW5J
	a9BPJSmCnwUN4YBq+ucxiUSVz4tWff1gHOj2uOWjEX398TioTxf0S/CpcIOXLaHTwRLjTvuHLigOB
	wB7hZb8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4dfB-009igR-Rt; Mon, 12 Dec 2022 07:55:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4df8-009ibe-7J
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 07:55:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A7EC668AA6; Mon, 12 Dec 2022 08:55:41 +0100 (CET)
Date: Mon, 12 Dec 2022 08:55:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
	Lei Rao <lei.rao@intel.com>, kbusch@kernel.org, axboe@fb.com,
	kch@nvidia.com, sagi@grimberg.me, alex.williamson@redhat.com,
	cohuck@redhat.com, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
	mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
	eddie.dong@intel.com, yadong.li@intel.com, yi.l.liu@intel.com,
	Konrad.wilk@oracle.com, stephen@eideticom.com, hang.yuan@intel.com,
	Oren Duer <oren@nvidia.com>
Subject: Re: [RFC PATCH 1/5] nvme-pci: add function nvme_submit_vf_cmd to
 issue admin commands for VF driver.
Message-ID: <20221212075541.GC11162@lst.de>
References: <Y4+U3VR2LeEh2S7B@ziepe.ca> <20221207075415.GB2283@lst.de> <Y5CWVu08abcOuEQH@ziepe.ca> <20221207135203.GA22803@lst.de> <Y5CsH5PqMYAWYatw@ziepe.ca> <20221207163857.GB2010@lst.de> <Y5DOAKArjyfb6Mcz@ziepe.ca> <20221207183333.GA7049@lst.de> <Y5DyorZJPdtN5WcX@ziepe.ca> <b2ade627-0abb-08a0-c28b-2bf8eb8e4973@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ade627-0abb-08a0-c28b-2bf8eb8e4973@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221211_235546_521678_A199FFA4 
X-CRM114-Status: GOOD (  14.48  )
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

On Sun, Dec 11, 2022 at 01:39:37PM +0200, Max Gurtovoy wrote:
> 1. Need to define a concept of a "virtual subsystem". A primary controller 
> will be able to create a virtual subsystem. Inside this subsystem the 
> primary controller will be the master ("the controlling") of the migration 
> process. It will also be able to add secondary controllers to this virtual 
> subsystem and assign "virtual controller ID" to it.
> something like:
> - nvme virtual_subsys_create --dev=/dev/nvme1 --virtual_nqn="my_v_nqn_1" 
> --dev_vcid = 1
> - nvme virtual_subsys_add --dev=/dev/nvme1 --virtual_nqn="my_v_nqn_1" 
> --secondary_dev=/dev/nvme2 --secondary_dev_vcid=20

Yes. Note that there is a bit more state than just the NQN.  You also
need at least a serial number, and also probably a different vendor
ID (the PCI vendor ID that is also mirror in Identify Controller and
the IEEE OUI), and new unique namespace identifier.

