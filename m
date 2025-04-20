Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2872BC369AB
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 15:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QvoL8n038tRQQThSj8dghpYys9J1HTJG96WFUhEbnK0=; b=D11cJ4J951aJLgk8K7tj4KrT7c
	Pd5k//I8Ry4XbaX6xbMe1TDhl4JJBGyZsbKs0QOzvoUDUnWiEbSpsfQuwPBRSOVN3a7EAC7uu/cHW
	K6N1qpNoJkXPs+W02hhdy/5+yC7pjccJpP2xAMKgrg/CjZfAsTReiQr9k45h49hDSp2VeiEeqySEW
	hXHCkvOpEfvVe+NU8X1cvSIMQSZf9rfbBoIXqqhCvyKP8LOVfcoiQP4ONTqtyB3uhOaMpOfZPgMKo
	ByaNCcSxzJQR0TfsM8ORykR5B3CCjj+saOMYiC1Q6BulwKc3+Zrs5eZkKsp4Aj167+xy9hVkm6tnS
	BfCSM7Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6shX-00000004Wue-2P48;
	Mon, 21 Apr 2025 15:04:51 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6OoM-00000002J9y-2YJt
	for linux-nvme@lists.infradead.org;
	Sun, 20 Apr 2025 07:09:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5D0AA60007;
	Sun, 20 Apr 2025 07:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858A7C4CEE2;
	Sun, 20 Apr 2025 07:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745132991;
	bh=DnPJAtQCAT1601If/hRz83wTZ4UHqcQsShHrfo6H7rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDz9qVfpkRY4EAI36WaskxJdBPEHUlHFbAqFkCaVljTQw2lc/CZWqFZnCOm8MUu+u
	 UrnadqItcqjJX8psssUB220xLgoCNkTErsCMMfM+LcQNv/lN9+7iyBAixDzSSYRERs
	 9QvymfQ6DxqnBDFAPnDfrK3vcmVwiHkXZQebyeCwLRbHisYArdA1/1Ng8W7pTvxGdN
	 ExFInLH9/9MK/zmr0slhL5h+cLRxxF3IiVZqx3CiPDDOuIqmNXHF3wJ8GD6rscX14G
	 v8WEpFME6iQdRojmcM1vpWqjFnfXt8wLrQZoE00EvORp7GOiurN3OrarLMgd6b2C6G
	 j2uwfP3dJ++Dg==
Date: Sun, 20 Apr 2025 10:09:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
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
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v8 20/24] blk-mq: add scatterlist-less DMA mapping helpers
Message-ID: <20250420070946.GA10635@unreal>
References: <cover.1744825142.git.leon@kernel.org>
 <87b151a3791d71e58ec6f1b42bcf5fe06304cf80.1744825142.git.leon@kernel.org>
 <65b0070e-3386-4725-8e8a-15b0409b8368@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b0070e-3386-4725-8e8a-15b0409b8368@oracle.com>
X-Mailman-Approved-At: Mon, 21 Apr 2025 08:03:40 -0700
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

On Fri, Apr 18, 2025 at 11:33:09PM +0530, ALOK TIWARI wrote:
> 
> 
> > + * Start DMA mapping @req to @dma_dev.  @state and @iter are provided by the
> > + * caller and don't need to be initialized.  @state needs to be stored for use
> > + * at unmap time, @iter is only needed at map time.
> > + *
> > + * Returns %false if there is no segment to map, including due to an error, or
> > + * %true it it did map a segment.
> 
> typo - it it -> if it

Thanks, will fix all types on my dma-split-wip branch.

