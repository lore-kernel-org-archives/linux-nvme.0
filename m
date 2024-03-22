Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F181EC6FD1F
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 20:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oy/Nq6PcY2bcQc0QCruyagdbdVr8kaFsWqEhNH327PI=; b=vNkt3tmntWNEQcmTAekAHl54Yx
	gurguso7qljV9qRGUIvEMr0luQFMNQOrHT8P3AvP2yXAmsmkv+P8AaAYjpT2ZhnSPZ1Gw+iXqGhAy
	TdQRd2mQnS3rPWXIWLlEpfEWW34hu2H5TrObIN1txKmxo9Du1v6LngavBE6BU0BWjHg++dFXL6Zfv
	lpYy4AQlacxgp6/SCpm+RISnsbYgOruPW527hrlkKM4cnzYaPZKa0HKs3qPmpCqC+YLZ+qD8pCenE
	uZKXqMs3ea9bjy3mTLtgxKL/zadyJjj7Xbc9AW1FV5hwGYGqqit3Asbw/+g1j0C10REa+GsYgB5q1
	EHpSIboA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnlRB-00000008bSP-0nIq;
	Fri, 22 Mar 2024 20:24:25 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rniyG-00000008DLR-47Au
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 17:46:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4C856CE1867;
	Fri, 22 Mar 2024 17:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06FDC43390;
	Fri, 22 Mar 2024 17:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711129581;
	bh=tPnSfU7iDXbv5Aanu3qQZ/bdHhZW5HEkKrMaj/r/t3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHS5yTT4bbaMRlgftNPH4s3/BHy6Y/pMfuNyl8v8f5cbM9wT0nJywOThE9XO9o+Yo
	 sQrbBVvHpfJ/GkmHADMgsyejjED5TS3WA9xA7CAd8LGMMBj72qkOP6L4xJgAnibISZ
	 qNFyWWuGRtKqmNbYceSiJMbEfqG1Js9LGbaa9G2SXsAMGNlvbn99etRqhzGPHQquR2
	 /pbuuEEFXd6WzmZyO515+46vj9pZRkjqcnsndSlqoffLvES8FRzNSO3QY42zxkNADr
	 DC5hb9KvKEkeYTKUZ64FdwpBihsRuGbAw0oCeOVQ5Q/D7ca6clZI9B8s4YtiHLB9rj
	 nO/n9c2+vHn/w==
Date: Fri, 22 Mar 2024 19:46:17 +0200
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
Message-ID: <20240322174617.GD14887@unreal>
References: <20240306221400.GA8663@lst.de>
 <20240307000036.GP9225@ziepe.ca>
 <20240307150505.GA28978@lst.de>
 <20240307210116.GQ9225@ziepe.ca>
 <20240308164920.GA17991@lst.de>
 <20240308202342.GZ9225@ziepe.ca>
 <20240309161418.GA27113@lst.de>
 <20240319153620.GB66976@ziepe.ca>
 <20240320085536.GA14887@unreal>
 <20240321224013.GB22663@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321224013.GB22663@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_104625_260633_A33478CF 
X-CRM114-Status: GOOD (  14.81  )
X-Mailman-Approved-At: Fri, 22 Mar 2024 13:24:24 -0700
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

On Thu, Mar 21, 2024 at 11:40:13PM +0100, Christoph Hellwig wrote:
> On Wed, Mar 20, 2024 at 10:55:36AM +0200, Leon Romanovsky wrote:
> > Something like this will do the trick.
> 
> As far as I can tell it totally misses the point.  Which is not to never
> return non-P2P if the flag is set, but to return either all P2P or non-P2
> P and not create a boundary in the single call.

You are treating FOLL_PCI_P2PDMA as a hint, but in iov_iter_extract_user_pages()
you set it only for p2p queues. I was under impression that you want only p2p pages
in these queues.

Anyway, I can prepare other patch that will return or p2p or non-p2p pages in one shot.

Thanks

