Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B80DC369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 14:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TYvXi1TpKC1h5IFpnBbfMBEHpcp7CB83EeRxS4K9NPQ=; b=0idlCKCrhX24wLIR9Mn5la283J
	t424erQbpxJNzTLcMJxzq+lYt48Rxa2Z2YVgPscu+ERnaNTTZBQi0/2vAyM2gW35gsfLOCNAzsRTT
	CjjmbWKfD7WhEV8vwRzvHvSJ6xXOhpa2LlfPjr9MHlTFCHyHp0mP6b1PuYcJP4Bh3e1M5/Ptt2fwb
	3i62McbuZT6jRrbzhJLi/5xEbKZErL5XlJqNoRpOJ77pxnoOvzLY8tvj8ZPJDJhTfSYkiWBKWjkfm
	9YtCHNzrHchAbFvVLJ7ga75K8xRjyhtXtay5ZH2P+Ij3QlMgtortzJLIxbhrzxJk3MzO3yKXQgqae
	QTqkMMpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7EjF-00000007Wf3-3U7z;
	Tue, 22 Apr 2025 14:36:05 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Bvm-00000006yJg-3hu2
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 11:36:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 103FCA4B95E;
	Tue, 22 Apr 2025 11:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA605C4CEE9;
	Tue, 22 Apr 2025 11:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745321809;
	bh=r6X7KW5xA2Bid9qqNeraU4aDSG9uP20Keu4UbEk1LHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJq30b87/TflnB9DVVipFNU57Znk7OWclwNiEv1U1CkREJE7TpnQD5/hqoZtIuTZJ
	 dTPGGSPbMLaLEb2zNkLd3Q778H6VAa8OOBofqBahNpMdxezfgyVohmR6Rd9GiEqit6
	 rqQQDP3Pc8mFmUp7rVwkCwExrNjkUbpZzr5cC8mMpJGiZVgmXx+K5vas3ebglhBMWf
	 RVeOeSh6BNTXES/fWcmFmi51oMgzzUf4ye8EeNe7AB8tBKDLrYmlZv3p0jO5PK+S/3
	 YSBQMCWgd1JztmQ+CpvrmAO4qjEfa68n3WyOSSCxk7QhEyBqnidI1p8GTad9JjjkB8
	 RxKZi4poFx/gQ==
Date: Tue, 22 Apr 2025 14:36:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v8 24/24] nvme-pci: optimize single-segment handling
Message-ID: <20250422113643.GE48485@unreal>
References: <cover.1744825142.git.leon@kernel.org>
 <670389227a033bd5b7c5aa55191aac9943244028.1744825142.git.leon@kernel.org>
 <20250422043955.GA28077@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422043955.GA28077@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_043651_050159_13EB32FD 
X-CRM114-Status: GOOD (  25.39  )
X-Mailman-Approved-At: Tue, 22 Apr 2025 07:26:59 -0700
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

On Tue, Apr 22, 2025 at 06:39:56AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 18, 2025 at 09:47:54AM +0300, Leon Romanovsky wrote:
> > From: Kanchan Joshi <joshi.k@samsung.com>
> > 
> > blk_rq_dma_map API is costly for single-segment requests.
> > Avoid using it and map the bio_vec directly.
> 
> This needs to be folded into the earlier patches or split prep patches
> instead of undoing work done earlier, preferably combined with a bit
> of code movement so that the new nvme_try_setup_prp_simple stays in
> the same place as before and the diff shows it reusing code.
> 
> E.g. change
> 
> "nvme-pci: use a better encoding for small prp pool allocations" to
> already use the flags instead of my boolean, and maybe include 
> abort in the flags instead of using a separate bool so that we
> don't increase hte iod size.
> 
> Slot in a new patch after that that dropping the single SGL segment
> fastpath if we think we don't need that, although if we need the PRP
> one I suspect that one would still be very helpful as well.
> 
> Add a patch if we want the try_ version of, although when keeping
> the optimization for SGLs as well that are will look a bit different.

I uploaded new tag dma-split-Apr-22 with the changes. At the end, I
decided to keep SGL optimized path too, but didn't create separate
patch for try_* variants as they require block iterator, which is
introduced in conversion patch only.

> 
> I'm happy to give away my patch authorship credits if that helps with
> the folding.

I kept you as an author. Please advise if I need to change it to be someone else.

Thanks

