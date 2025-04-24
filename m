Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE26C369D7
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 12:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EsiBb2Ci+XsuTB/2BgrSnjUWCz2t1GZNQ6Z1M0C6om8=; b=UBulF6wxu02HLizwTTdDconPXU
	ek9TVCr9Id7N2v155wlOV109pjhOAaMsnEQmKN8sKfYiDhYumwpFFRvJ4FWMvIVJLlcO0Gv3cbwx8
	IE017b80e9yJk4Q0X7+AXdDsazEQaCscNjDE+2ZcOOU+nJpZPl4l2SgPqyEpVHpV7gGNXpw1Njx9x
	m7+ZuxFPJVIukYjO88exDyhHNuDu882KkCTQ/1zpYVonnhk7d6qile/mKXx+zHgB68xjbS5XoP3bR
	3aR4kuv17/Tf6PY+pV51y4Op5+L88/zE+Ry8Ilver/yqSILrZaiFw+NuBcgME865HU7QOe0SzRMGX
	YdQvU34Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7vSB-0000000DzOx-0h8e;
	Thu, 24 Apr 2025 12:13:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7rcg-0000000DHSL-37oA
	for linux-nvme@bombadil.infradead.org;
	Thu, 24 Apr 2025 08:07:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=EsiBb2Ci+XsuTB/2BgrSnjUWCz2t1GZNQ6Z1M0C6om8=; b=cwT0FAnM7bwzVv9zcHQ4n4P0qL
	o6lejH8JeiqmCK9lfTcRJbxeAa1bIm3jQVEAVFb0NcGYGCoQlfqegOhaU173OqUMkBvQgfTYw5M3d
	k/eslKbceCGbxs1yD8DbvHAR/XuLUEYo3CzS36FXpQG78m78+BNlNErY8dEwVU8rlm5N3Dol3K+KZ
	Nk37T0DXHAHrDZBm1hdAVH9lZVjjVWwpdBtcjPxNR9up9hQRTUhv/rayO8bbB9xXdYeQ+Db83SkMy
	iWWe474qAkrvmbijTLJ9iUFMChrTcG37w6LSONYGibYXcKLrl53A/HmT7BXsIkYvUJrw2VZJ5i2/S
	Jr87oxMg==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7rcd-0000000Bb97-3vfX
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 08:07:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 269065C62FF;
	Thu, 24 Apr 2025 08:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED08C4CEEB;
	Thu, 24 Apr 2025 08:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745482069;
	bh=gQ9J0xOhC6db6xC9+l1fS/rU8P/+uRvFwj9Ophiqh+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODyOD7bZFe6psyTBbbqHrGyTN9bbO06+mLsjpOZpZAtyeVZhSMtIzzHp4uk/bPwRF
	 Fg+5AuYPCHFaO1iJ7AZ0hnuzbSatu3RKpWWB0igu+ysf5GxyCdAj0/zoHi8abPgms6
	 UyWqrFeuVLz7KWExbAlMl6sGk3pIBXhjJdgkeyS5U7v4meyETDlnI/bCnajjhgK5ip
	 tIFTA4qEdRjUs4v9+5Yqy4cTSqzgz9evKITnLdxHo0yebJZSxHX+clynB3yYqiaA9g
	 TAOPbev3sVV+FH5Ob1WbUIU/+f8jJU3YQkiM1kHRm7HKmFAywX5r91KPZh1EV5IySo
	 WbMrUBYNBAOvw==
Date: Thu, 24 Apr 2025 11:07:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
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
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20250424080744.GP48485@unreal>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
 <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>
 <20250423181706.GT1213339@ziepe.ca>
 <36891b0e-d5fa-4cf8-a181-599a20af1da3@redhat.com>
 <20250423233335.GW1213339@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250423233335.GW1213339@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_090752_153022_F79B8917 
X-CRM114-Status: GOOD (  15.97  )
X-Mailman-Approved-At: Thu, 24 Apr 2025 04:18:00 -0700
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

On Wed, Apr 23, 2025 at 08:33:35PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 23, 2025 at 09:37:24PM +0300, Mika Penttilä wrote:
> > 
> > On 4/23/25 21:17, Jason Gunthorpe wrote:
> > > On Wed, Apr 23, 2025 at 08:54:05PM +0300, Mika Penttilä wrote:
> > >>> @@ -36,6 +38,13 @@ enum hmm_pfn_flags {
> > >>>  	HMM_PFN_VALID = 1UL << (BITS_PER_LONG - 1),
> > >>>  	HMM_PFN_WRITE = 1UL << (BITS_PER_LONG - 2),
> > >>>  	HMM_PFN_ERROR = 1UL << (BITS_PER_LONG - 3),
> > >>> +
> > >>> +	/*
> > >>> +	 * Sticky flags, carried from input to output,
> > >>> +	 * don't forget to update HMM_PFN_INOUT_FLAGS
> > >>> +	 */
> > >>> +	HMM_PFN_DMA_MAPPED = 1UL << (BITS_PER_LONG - 7),
> > >>> +
> > >> How is this playing together with the mapped order usage?
> > > Order shift starts at bit 8, DMA_MAPPED is at bit 7
> > 
> > hmm bits are the high bits, and order is 5 bits starting from
> > (BITS_PER_LONG - 8)
> 
> I see, so yes order occupies 5 bits [-4,-5,-6,-7,-8] and the
> DMA_MAPPED overlaps, it should be 9 not 7 because of the backwardness.

Thanks for the fix.

