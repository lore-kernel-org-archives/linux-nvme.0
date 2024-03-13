Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D01FC54E68
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oFPojxUGJwzVDoSGUKb9k5Rr3J1glGg6PTtT6ACJHaM=; b=HCu075YZVfDimsTn4B4tl8+b83
	MQkEICS9EJAtUIYIF6hUqU88zNiFh7nU9nvYPDcbGWHH+wzw0kye8FNGaZ+K0dKugXLoegfpc6bde
	VtGVZHeza7RpR1N5Lc+wNV01UDE5zicafiZW/w3EJnxU+vFS06sQuHu65qKlbNM+K8CET4b0YHKeF
	HSZlSU1IZeT/bz1mOqUbwEeQPeVSs0gBcVy5P90OSwG19YHRa9AAQRP5hZTv20KMFDdqmXe2QmhjE
	Qp8Zrh0ObBG9873v5OJz7zk6uVjs0n5ET8M/vH/0B4gR95J5SBtfShOw78NTLx/Olz7YfkUgOV+fM
	TCHAQe7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkQMr-0000000Aa5b-3cur;
	Wed, 13 Mar 2024 15:18:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkJJz-00000009Elq-1Afh
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 07:46:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AAFA16138B;
	Wed, 13 Mar 2024 07:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F8EC433C7;
	Wed, 13 Mar 2024 07:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710316001;
	bh=Kr6b9zwRiK0qe/FQtkWwwcr3AdM/iJQ3Tm5R/ItJ+kI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhEelchk241d2G+Q3NZ+eugtycNa64C11tlGZNDKxCvzTX75Q00BDeucxxI33dSuA
	 4+eCRt8kMMEc5PKj3RKm6EMledYaAfqv5JZuQB7Y+lqGf4dv4bsr9x0TpKJG1q4wXj
	 5wL8HqXvVMagJHMFg5lnkHWIqzUSGVvjZwviYWQ8IepvQMcWBnKkAG8KoyC2Qj/Dk9
	 zhjs+9wAPOXEebb1i/MdTgpoDqE40AetcQZI0F5BBxVL9DwWbmHiXrd3y6wILhONqN
	 9PPx8kGlpLaHCN3ApgnEaZsraA27U8tPpWQjwzmxyOAzAxTPkrSjUTlSjBaxCZCGej
	 iazuJwD6oD4iQ==
Date: Wed, 13 Mar 2024 09:46:36 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240313074636.GV12921@unreal>
References: <20240306174456.GO9225@ziepe.ca>
 <20240306221400.GA8663@lst.de>
 <20240307000036.GP9225@ziepe.ca>
 <20240307150505.GA28978@lst.de>
 <20240307210116.GQ9225@ziepe.ca>
 <20240308164920.GA17991@lst.de>
 <20240308202342.GZ9225@ziepe.ca>
 <20240309161418.GA27113@lst.de>
 <20240310093513.GB12921@unreal>
 <20240312212844.GA3018@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312212844.GA3018@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_004643_384715_10A043CD 
X-CRM114-Status: GOOD (  14.94  )
X-Mailman-Approved-At: Wed, 13 Mar 2024 08:18:07 -0700
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

On Tue, Mar 12, 2024 at 10:28:44PM +0100, Christoph Hellwig wrote:
> On Sun, Mar 10, 2024 at 11:35:13AM +0200, Leon Romanovsky wrote:
> > And you will need to have a way to instruct that pin_user_pages() variant
> > to continue anyway, because you asked for FOLL_PCI_P2PDMA. Without that
> > force, you will have !FOLL_PCI_P2PDMA behaviour.
> 
> I don't understand what you mean.

Jason talked about the need to call to pin_user_pages(..., gup_flags | FOLL_PCI_P2PDMA, ...),
but in your proposal this call won't be possible anymore.

> 
> > When you say "simplify the overall interface", which interface do you mean?
> 
> Primarily the dma mapping interface.  Secondarily also everything around
> it.

OK, thanks

