Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317F2C369D7
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 17:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HP7oDaYte7vMFo9EnmFvJMbXppcQP82+NX+wfpMxHcc=; b=cHHj7e9AR2P6f8o9p0oSmOerAj
	ezyeDyoWN7R+gh6PZO3T/RTiYoMAD6IV//ZBbELpLS8snZ5ldh2YxCTbqCy+ms4Ii+LYsb/8t/JVh
	SDPdVRSgdpP/Z9ZESBjV7LbVs6IbovDdRNRmRvRkg7O6w3X7ZrERHNdtx8pXCtBYIe+Dca+oHDsXn
	Vq9DGK5OjneWRPo5i3UZ5saOTI6lpk4SLGblWQj43urnnaxQvHtS8bf8FzxPN0S8jsMhFcZydQamA
	2YX2fgqhfOb18D3F+JYyBIzv2jNZPk3kSJBmEph1d10ZDvEpHbIOutuTHfBJB1oBnJj2xw21Q47bw
	0YRTtiRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7eN8-0000000BRxo-1yCC;
	Wed, 23 Apr 2025 17:58:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7aKG-0000000Adfm-3I4d
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 13:39:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EAC7E446C3;
	Wed, 23 Apr 2025 13:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C338C4CEE2;
	Wed, 23 Apr 2025 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745415584;
	bh=S0WcvfERookrfqdsNf09r0AEV1z7UbVgPAAe8PW/qEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7fbCECKz3kHNJ+jo+OIrSy4DZWF6VfP/zMT2YhsyEeG8iSKLjTEeP4BGX7t1v67F
	 p+smI3psobdO3tCjGOBUD38dcg+HJceGigztEe+RqIFgjXeSmBqGusz82SrUq7Iqhr
	 6YBAvgVdMKqIXI9geSfRtO4adJnuAwKrlMzGN0FoYiFnp8djUeWrTDRnjGiNRjdms1
	 lVhbJbHhBl3bRbYk7Z4X83FROH2nhn6Tw5OSDGilthlPt/WSsdwmadbLXjVpawj9FS
	 VkdfwLWiAYzGPR8yiCx1MEJV3iIN1dHQZZLErOM+ocSreR4LOhSFYEGHNzjW661Mct
	 C0lSied3DnKWA==
Date: Wed, 23 Apr 2025 16:39:39 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 22/24] nvme-pci: use a better encoding for small prp
 pool allocations
Message-ID: <20250423133939.GJ48485@unreal>
References: <cover.1745394536.git.leon@kernel.org>
 <973ed41249e12766383b3cedac799692f9bda3b8.1745394536.git.leon@kernel.org>
 <20250423090552.GA381@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423090552.GA381@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_063944_860977_B93106B4 
X-CRM114-Status: GOOD (  27.31  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 10:47:25 -0700
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

On Wed, Apr 23, 2025 at 11:05:52AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 23, 2025 at 11:13:13AM +0300, Leon Romanovsky wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > There is plenty of unused space in the iod next to nr_descriptors.
> > Add a separate flag to encode that the transfer is using the full
> > page sized pool, and use a normal 0..n count for the number of
> > descriptors.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Tested-by: Jens Axboe <axboe@kernel.dk>
> > [ Leon: changed original bool variable to be flag as was proposed by Kanchan ]
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/nvme/host/pci.c | 93 ++++++++++++++++++++---------------------
> >  1 file changed, 46 insertions(+), 47 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 638e759b29ad..7e93536d01cb 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -44,6 +44,7 @@
> >  #define NVME_MAX_SEGS	128
> >  #define NVME_MAX_META_SEGS 15
> >  #define NVME_MAX_NR_DESCRIPTORS	5
> > +#define NVME_SMALL_DESCRIPTOR_SIZE 256
> >  
> >  static int use_threaded_interrupts;
> >  module_param(use_threaded_interrupts, int, 0444);
> > @@ -219,6 +220,10 @@ struct nvme_queue {
> >  	struct completion delete_done;
> >  };
> >  
> > +enum {
> > +	IOD_LARGE_DESCRIPTORS = 1, /* uses the full page sized descriptor pool */
> 
> This is used as a ORable flag, I'd make that explicit:
> 
> 	/* uses the full page sized descriptor pool */
> 	IOD_LARGE_DESCRIPTORS		= 1U << 0,
> 
> and similar for the next flag added in the next patch.
> 
> >  	struct nvme_request req;
> >  	struct nvme_command cmd;
> >  	bool aborted;
> > -	/* # of PRP/SGL descriptors: (0 for small pool) */
> > -	s8 nr_descriptors;
> > +	u8 nr_descriptors;	/* # of PRP/SGL descriptors */
> > +	unsigned int flags;
> 
> And this should be limited to a u16 to not bloat the structure.

I'll limit it to u8.

Thanks

> 

