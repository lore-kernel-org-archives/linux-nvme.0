Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8D2C4708E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 13:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JuClYPutvs1ch2ceEAMGrA7+Pm2rYxeETYueKiMRxUc=; b=NzcFqqXVKVpBFqryZs3VFrGX5q
	+tMC2ca87vSqw1KYEu2WNZ3hBacvnt6kfbBUZInRL67Vrum30W8mrkf3uY2+SrA2Bn9L8dvUG463N
	m5zUxGfPb30DZqoxr/DI8nx1EfsUaJN2TrBPqQ9/FhWV5KCk/0kk+Mbxes7+5XTdkvC7ZWlE5w+Ug
	SwS7g9bLy09suS1L00GurrBMt9nd93yPcaKMurLg/fgHoKw3mUeC9mK4y5clzR+YCQOIl0cfrYW+A
	orQTtu6dTh+INMRIZ2u6QjlhyrSx/ym1S5MEa6AuLSClL2guyRodVMkQx4X0DQHiSRKYudrvBuESS
	YkT+HxOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2XhG-009XgT-1L; Tue, 06 Dec 2022 13:09:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Xh9-009XZa-T3
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 13:09:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B000068B05; Tue,  6 Dec 2022 14:09:01 +0100 (CET)
Date: Tue, 6 Dec 2022 14:09:01 +0100
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
Subject: Re: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
Message-ID: <20221206130901.GB24358@lst.de>
References: <20221206055816.292304-1-lei.rao@intel.com> <20221206055816.292304-6-lei.rao@intel.com> <20221206062604.GB6595@lst.de> <Y48+AaG5rSCviIhl@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y48+AaG5rSCviIhl@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_050912_151173_E3516A51 
X-CRM114-Status: GOOD (  16.51  )
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

On Tue, Dec 06, 2022 at 09:05:05AM -0400, Jason Gunthorpe wrote:
> In this case Intel has a real PCI SRIOV VF to expose to the guest,
> with a full VF RID.

RID?

> The proper VFIO abstraction is the variant PCI
> driver as this series does. We want to use the variant PCI drivers
> because they properly encapsulate all the PCI behaviors (MSI, config
> space, regions, reset, etc) without requiring re-implementation of this
> in mdev drivers.

I don't think the code in this series has any chance of actually
working.  There is a lot of state associated with a NVMe subsystem,
controller and namespace, such as the serial number, subsystem NQN,
namespace uniqueue identifiers, Get/Set features state, pending AENs,
log page content.  Just migrating from one device to another without
capturing all this has no chance of actually working.

> I don't think we know enough about this space at the moment to fix a
> specification to one path or the other, so I hope the TPAR will settle
> on something that can support both models in SW and people can try
> things out.

I've not seen anyone from Intel actually contributing to the live
migration TPAR, which is almost two month old by now.

