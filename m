Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DC1C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IRrQC6GUIj0m02qYZjyjYmIvaB50eFASYXdLqBy73WY=; b=QtM/8CW2daoxkTxqui+DSHkYcf
	QVXzgu1LsdalPh9aT/Q2WiNQJWr9jB1AdAfsQGfgaxySzbJabsjaWDNOJ/Vom+XZydXjhCLHX/Qc1
	7ep4N3XPeQ/7ynuvDOboX/+JByx/JLD4DPUERQ6lDuiBQsrtU9k4d8uJgs3G9AxH7dUTeKfw4yS26
	9dem+88yTfaprbNPN7qqcqo5NXNu+M3ezk/QXPkR61D5mFJa+yPckMZml/JugPChGg5McJgI+Sedd
	eKr0DzmqPbUGBCnzQilF8HUopkS6cQkldQ+NGFDUxyGvriVzqip9a3L82FeU8PjdJ+MourlWiS+UC
	BQ19XBgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7EjC-00000007WcF-0tbD;
	Tue, 22 Apr 2025 14:36:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u77FK-00000005zK7-1j90
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 06:36:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6011C4A049;
	Tue, 22 Apr 2025 06:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66D0C4CEEA;
	Tue, 22 Apr 2025 06:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745303801;
	bh=HfetzUxRXy4rCDFO2Jid01crVoBGhZcgFFPhx3Tl4zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qAJ9ve3OT0ZJnEWm3PYqcpUZBluuU64tZMSjgqeGPlLsklDQcSPGF19PJHu4OVyak
	 +mfowzS/d2IZFkhAaKZSZmz3bFxaaljwCLKAbX4CkMGSTFnCxZYKExIhX8brBVrDIn
	 EnlOR/RtUrvb5TEsQ3vHZY8rvQVuJb4STE7Le7iVPo+vTGVmuK4GjktT2YA8InWPCx
	 uofgjFe0OVXsEodcivnhb8/7guwb3Azqlc/8/cOSiqu4hlvpFTrOi2w+4KOno8BYEF
	 ZAUjL+s5coWHLBK4MTAwZgXnOjZruNtZfPNGBTDgLtup3GvGYhpyREXyrFYAhySxzj
	 pUOOurdEnqncw==
Date: Tue, 22 Apr 2025 09:36:38 +0300
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
Subject: Re: [PATCH v8 20/24] blk-mq: add scatterlist-less DMA mapping helpers
Message-ID: <20250422063638.GB48485@unreal>
References: <cover.1744825142.git.leon@kernel.org>
 <87b151a3791d71e58ec6f1b42bcf5fe06304cf80.1744825142.git.leon@kernel.org>
 <20250422042727.GC27723@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422042727.GC27723@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_233642_503671_80382E82 
X-CRM114-Status: GOOD (  11.79  )
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

On Tue, Apr 22, 2025 at 06:27:27AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 18, 2025 at 09:47:50AM +0300, Leon Romanovsky wrote:
> > +#define blk_phys_to_page(_paddr) \
> > + 	(pfn_to_page(__phys_to_pfn(_paddr)))
> 
> The code can use phys_to_page now that that is provided kernel-wide
> instead this temporary helper.

Thanks, will change.

