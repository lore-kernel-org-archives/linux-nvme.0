Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DC6E6F060
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2024 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IFtadrMJSRC2bhRhwtJqH1xosuWz+cF6ZPVZbQmWVFU=; b=cs4FLXqmJduq7XQJxxZcQAxxBB
	UIvXfslkFy0IyPhqfx85RgU7jxpzqOtRseEOVABFMFhYvd/L0KGPWNblMQsZHtrYDDJFTqiB1kRvr
	SgIIE7H5cp3IiX/NI7dfJbumndvgpL4o/wHOCzSVdozVEVw92A3WM9rrg5+wpv+gHdm4RSJUOzk9F
	vYC0f9wcbAGPMf2yeIxk0U5PPbI10qCDJVglxjkKssMtG6E4LtoiHlDQ7AbCZeeCJV1Qzrd/TiGyg
	UNW225of5hXLMiYoEhMvf6kzlmiuw1VJnBRObqSOy7DCOEInkGrvAx1pyC2tLZisp0DHU0NVjZfdd
	wCZmD8sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6sa3-00000007KJ9-3oKC;
	Fri, 01 Nov 2024 14:24:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6s9R-00000007Fpw-0hzv
	for linux-nvme@lists.infradead.org;
	Fri, 01 Nov 2024 13:59:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 230E35C9565;
	Thu, 31 Oct 2024 09:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04050C4CEC3;
	Thu, 31 Oct 2024 09:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730367470;
	bh=tqzJLh5GYRL2KEmKB06uhDKvLABRYtBWXtB3Y8bMEKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTQP7PS+/MTyTtUMPwFCdUdEd1qWr3BPPQ8pvyYPVrtbourx/L8sdNPTr9lPj1QPB
	 g933lrXQqvAJxMV1kQiG2xyG7NF8LnS9wKQBA9lsBXrn5RHD1+siwDoEBnl+zfB8NV
	 DrhOyVxwnAVdg5G2IeaEo3cxX9HtNdkNEj0b51HcYMeCY5S9sSDgNsPLzN1l7uwEAl
	 8UAGh7dlC4XLOOvyRno1rlDrgXdZkQFymJIkdmkKL/RzKkO8mH98WS4qTpitL+TrzB
	 j4UfpaLbeZXfuUbC0SIp4WAe0T7KDxaEbIsTC03s3SAkoAGz9+Sya4ZfdJPQPVNS6T
	 b1awtly2cL7Qw==
Date: Thu, 31 Oct 2024 11:37:46 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <20241031093746.GA88858@unreal>
References: <cover.1730298502.git.leon@kernel.org>
 <3144b6e7-5c80-46d2-8ddc-a71af3c23072@kernel.dk>
 <20241031083450.GA30625@lst.de>
 <20241031090530.GC7473@unreal>
 <20241031092113.GA1791@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031092113.GA1791@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_065721_316871_AA064BEA 
X-CRM114-Status: GOOD (  19.45  )
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

On Thu, Oct 31, 2024 at 10:21:13AM +0100, Christoph Hellwig wrote:
> On Thu, Oct 31, 2024 at 11:05:30AM +0200, Leon Romanovsky wrote:
> > This series is a subset of the series you tested and doesn't include the
> > block layer changes which most likely were the cause of the performance
> > regression.
> > 
> > This is why I separated the block layer changes from the rest of the series
> > and marked them as RFC.
> > 
> > The current patch set is viable for HMM and VFIO. Can you please retest
> > only this series and leave the block layer changes for later till Christoph
> > finds the answer for the performance regression?
> 
> As the subset doesn't touch block code or code called by block I don't
> think we need Jens to benchmark it, unless he really wants to.

He wrote this sentence in his email, while responding on subset which doesn't change
anything in block layer: "just want to make sure something like this doesn't get merged
until that is both fully understood and sorted out."

This series works like a charm for RDMA (HMM) and VFIO.

Thanks

