Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4DAC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 03:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oc2eqbMXkAVLIaVnQZ8lbsbNYnsCeobEtpDB3bTLDUU=; b=rnzWIc/vaLiH1VmtthmjALuuSx
	M0pT8fkXLC5X1De13tfmmIi9ffNK2+vHar53EVHbyYPDFyHNR6AFlSNSZtn6vW7bhys05Z+JiFAta
	xgTuhblhVhgXpUjvmkoKkKWStfUq9tWsqmwxojYtA3J9BTiuwPYRA/w8gxFOXJCeS2JyL0yFzNmcm
	rF/n8Vgqh4aX7fldi6E+qKsTQLFirJuHdekA8UiSRtN+baCEx6+2yqr1lmAR5czjHiMUvYYZaeE+x
	YkBcvn0eWCuXvKLvFx0R5sVP4ei6k6iwaXYLsl2zevUkc+gwLS1PwyRapVhysWX3PcOAmbG9djMqu
	+Si/siHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHEyD-0000000AwAj-3cQf;
	Wed, 12 Jun 2024 03:48:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH3gX-00000009NeS-12Bi
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 15:45:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1FC1860F00;
	Tue, 11 Jun 2024 15:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EE2C2BD10;
	Tue, 11 Jun 2024 15:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718120719;
	bh=alWpFRyGJPPxpA/qvEhIVLYBDfG5gKLw2O2vjFdIXBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Em6r9Li64MS4dfA1Fm6Omrjb4w5oyfw2XsNlofj9qeCLh5G5cxfGwuZ4yQPTUgZzW
	 6kxO2WwG1YbfeA57p9rgmFg6DOXF7B/o2lriNTV968OIdIJj6h+vJ28mFcLCklf+8k
	 loMrtXfftGiWNK48qosW/nixEPYc2CM6BDV0pD+OBtk1iB7sMjJs6yl/UgKehavFC0
	 ucx5PHa+Nq4Qc5SPa5Zz1cwEjWeiDWr0yVMVZnqrufT33mec/2ulkMu2y2JlMDYEFe
	 LOKNY2IV8maq2WwEhsDrM6P7s8EXMvED5vtpoqf+uru1kkwcRDd4cMFZ+KsLRjANr5
	 5MbGSb9lFaR2g==
Date: Tue, 11 Jun 2024 18:45:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Zeng, Oak" <oak.zeng@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Brost, Matthew" <matthew.brost@intel.com>,
	"Hellstrom, Thomas" <thomas.hellstrom@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	"Bommu, Krishnaiah" <krishnaiah.bommu@intel.com>,
	"Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240611154515.GC4966@unreal>
References: <cover.1709635535.git.leon@kernel.org>
 <SA1PR11MB6991CB2B1398948F4241E51992182@SA1PR11MB6991.namprd11.prod.outlook.com>
 <20240503164239.GB901876@ziepe.ca>
 <PH7PR11MB70047236290DC1CFF9150B8592C62@PH7PR11MB7004.namprd11.prod.outlook.com>
 <20240610161826.GA4966@unreal>
 <PH7PR11MB7004A071F27B4CF45740B87E92C62@PH7PR11MB7004.namprd11.prod.outlook.com>
 <20240610172501.GJ791043@ziepe.ca>
 <PH7PR11MB7004DDE9816D92F690A5C0B692C62@PH7PR11MB7004.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB7004DDE9816D92F690A5C0B692C62@PH7PR11MB7004.namprd11.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_084521_509773_84B7C013 
X-CRM114-Status: GOOD (  28.96  )
X-Mailman-Approved-At: Tue, 11 Jun 2024 20:48:17 -0700
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

On Mon, Jun 10, 2024 at 09:28:04PM +0000, Zeng, Oak wrote:
> Hi Jason, Leon,
> 
> I was able to fix the issue from my side. Things work fine now. I got two questions though:
> 
> 1) The value returned from dma_link_range function is not contiguous, see below print. The "linked pa" is the function return.
> I think dma_map_sgtable API would return some contiguous dma address. Is the dma-map_sgtable api is more efficient regarding the iommu page table? i.e., try to use bigger page size, such as use 2M page size when it is possible. With your new API, does it also have such consideration? I vaguely remembered Jason mentioned such thing, but my print below doesn't look like so. Maybe I need to test bigger range (only 16 pages range in the test of below printing). Comment?

My API gives you the flexibility to use any page size you want. You can
use 2M pages instead of 4K pages. The API doesn't enforce any page size.

> 
> [17584.665126] drm_svm_hmmptr_map_dma_pages iova.dma_addr = 0x0, linked pa = 18ef3f000
> [17584.665146] drm_svm_hmmptr_map_dma_pages iova.dma_addr = 0x0, linked pa = 190d00000
> [17584.665150] drm_svm_hmmptr_map_dma_pages iova.dma_addr = 0x0, linked pa = 190024000
> [17584.665153] drm_svm_hmmptr_map_dma_pages iova.dma_addr = 0x0, linked pa = 178e89000
> 
> 2) in the comment of dma_link_range function, it is said: " @dma_offset needs to be advanced by the caller with the size of previous page that was linked + DMA address returned for the previous page".
> Is this description correct? I don't understand the part "+ DMA address returned for the previous page ".
> In my codes, let's say I call this function to link 10 pages, the first dma_offset is 0, second is 4k, third 8k. This worked for me. I didn't add the previously returned dma address.
> Maybe I need more test. But any comment?

You did it perfectly right. This is the correct way to advance dma_offset.

Thanks

> 
> Thanks,
> Oak
> 
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Monday, June 10, 2024 1:25 PM
> > To: Zeng, Oak <oak.zeng@intel.com>
> > Cc: Leon Romanovsky <leon@kernel.org>; Christoph Hellwig <hch@lst.de>;
> > Robin Murphy <robin.murphy@arm.com>; Marek Szyprowski
> > <m.szyprowski@samsung.com>; Joerg Roedel <joro@8bytes.org>; Will
> > Deacon <will@kernel.org>; Chaitanya Kulkarni <chaitanyak@nvidia.com>;
> > Brost, Matthew <matthew.brost@intel.com>; Hellstrom, Thomas
> > <thomas.hellstrom@intel.com>; Jonathan Corbet <corbet@lwn.net>; Jens
> > Axboe <axboe@kernel.dk>; Keith Busch <kbusch@kernel.org>; Sagi
> > Grimberg <sagi@grimberg.me>; Yishai Hadas <yishaih@nvidia.com>;
> > Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>; Tian, Kevin
> > <kevin.tian@intel.com>; Alex Williamson <alex.williamson@redhat.com>;
> > Jérôme Glisse <jglisse@redhat.com>; Andrew Morton <akpm@linux-
> > foundation.org>; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-block@vger.kernel.org; linux-rdma@vger.kernel.org;
> > iommu@lists.linux.dev; linux-nvme@lists.infradead.org;
> > kvm@vger.kernel.org; linux-mm@kvack.org; Bart Van Assche
> > <bvanassche@acm.org>; Damien Le Moal
> > <damien.lemoal@opensource.wdc.com>; Amir Goldstein
> > <amir73il@gmail.com>; josef@toxicpanda.com; Martin K. Petersen
> > <martin.petersen@oracle.com>; daniel@iogearbox.net; Williams, Dan J
> > <dan.j.williams@intel.com>; jack@suse.com; Zhu Yanjun
> > <zyjzyj2000@gmail.com>; Bommu, Krishnaiah
> > <krishnaiah.bommu@intel.com>; Ghimiray, Himal Prasad
> > <himal.prasad.ghimiray@intel.com>
> > Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to
> > two steps
> > 
> > On Mon, Jun 10, 2024 at 04:40:19PM +0000, Zeng, Oak wrote:
> > > Thanks Leon and Yanjun for the reply!
> > >
> > > Based on the reply, we will continue use the current version for
> > > test (as it is tested for vfio and rdma). We will switch to v1 once
> > > it is fully tested/reviewed.
> > 
> > I'm glad you are finding it useful, one of my interests with this work
> > is to improve all the HMM users.
> > 
> > Jason

