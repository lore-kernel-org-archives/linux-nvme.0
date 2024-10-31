Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1797EE6B278
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2024 14:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n9jNoVWgAyz3OKPEI/xBwz4OBmPP5FmNVgDNrMfFvnU=; b=wFRpji/of61khqxKWkS90fV0c1
	7yLT5AoEA3+6dGjTgIfuX1Keeb8ReWGMktMlJMl7+GcAwQZe9zy/9gfxt/J2V6b6N8/Mm5m/IG/au
	OOkl/bMFwstY+ivDg9ZI43Aaed00gHFDjjyc9zd0MgFRTzcq4+UQQ+JGVWPhlomBys0/RJ+yhMqQz
	ZEhENlm0N3DFrzO8qw8qwYMPZjvR+sbElsruQVJ14wRAgsifIjXz2vy7w7Nzsyq5F9O/iGT2q130g
	MSshX50A3A1NPmqjX3+W/SeDpl+c8vPoWFsqXqhTm9GyATWJ9VPz3zyqxqlY9veL8SiV61Or4MA+h
	gO6j+eOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6sJM-00000007HAG-3RCx;
	Fri, 01 Nov 2024 14:07:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6s5n-00000007Evh-2lta
	for linux-nvme@lists.infradead.org;
	Fri, 01 Nov 2024 13:54:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AE1635C58C6;
	Thu, 31 Oct 2024 20:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7011FC4CEC3;
	Thu, 31 Oct 2024 20:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730407391;
	bh=H9TYKTBvHoQ5rvWOlZrf5R8cp5gm744S0WtiOVj2YhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lr7kPUgI/7iVNgICJResGJ30FaV5ODcyHJ9WGRkVobW4I+2qmOuISPyR7TgVvtOL0
	 SmzSJOoShZhbOMucGyUH2uuWA6uV+MEqkVpWqucL5pewOQIRjkLlpdRuvDl1QVDfWX
	 j1897yIh4R6d4BkCIdg8zDSKqwvM5/ucAQVUt6ez1WZ9F859wkA3oJfZDIz3/BvZ9Q
	 CFmDxviw5iM6FMEQKmQ/YcUbuNijZ7G5KlXaJgFBJfCLtyj90f3jtiAtedA93PWWwn
	 Aojx0RCSHe5LU/8+xXjxLd+N9OOoZAjQdgre/g+5QavM+S81ng8FOAv7tC01+C4SFj
	 e0eXzNVUyHdgQ==
Date: Thu, 31 Oct 2024 22:43:06 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241031204306.GB88858@unreal>
References: <cover.1730298502.git.leon@kernel.org>
 <3144b6e7-5c80-46d2-8ddc-a71af3c23072@kernel.dk>
 <20241031083450.GA30625@lst.de>
 <20241031090530.GC7473@unreal>
 <20241031092113.GA1791@lst.de>
 <20241031093746.GA88858@unreal>
 <8b4500da-4ed8-4cd2-ba3b-0c2d0b5b4551@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4500da-4ed8-4cd2-ba3b-0c2d0b5b4551@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_065335_834665_9904D1CA 
X-CRM114-Status: GOOD (  24.80  )
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

On Thu, Oct 31, 2024 at 11:43:50AM -0600, Jens Axboe wrote:
> On 10/31/24 3:37 AM, Leon Romanovsky wrote:
> > On Thu, Oct 31, 2024 at 10:21:13AM +0100, Christoph Hellwig wrote:
> >> On Thu, Oct 31, 2024 at 11:05:30AM +0200, Leon Romanovsky wrote:
> >>> This series is a subset of the series you tested and doesn't include the
> >>> block layer changes which most likely were the cause of the performance
> >>> regression.
> >>>
> >>> This is why I separated the block layer changes from the rest of the series
> >>> and marked them as RFC.
> >>>
> >>> The current patch set is viable for HMM and VFIO. Can you please retest
> >>> only this series and leave the block layer changes for later till Christoph
> >>> finds the answer for the performance regression?
> >>
> >> As the subset doesn't touch block code or code called by block I don't
> >> think we need Jens to benchmark it, unless he really wants to.
> > 
> > He wrote this sentence in his email, while responding on subset which
> > doesn't change anything in block layer: "just want to make sure
> > something like this doesn't get merged until that is both fully
> > understood and sorted out."
> > 
> > This series works like a charm for RDMA (HMM) and VFIO.
> 
> I don't care about rdma/vfio, nor do I test it, so you guys can do
> whatever you want there, as long as it doesn't regress the iommu side.
> The block series is separate, so we'll deal with that when we get there.
> 
> I don't know why you CC'ed linux-block on the series.

Because of the second part, which is marked as RFC and based on this
one. I think that it is better to present whole picture to everyone
interested in the discussion.

Thanks

> 
> -- 
> Jens Axboe
> 

