Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A459AECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 17:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wyLsFcR27tbHYfIHcr8kAUx99eC0PkqGX2lPeHPbot8=; b=E15hYlz4Hm/Ota9d3bWGbk3lb7
	LmL6AxEmRh72QC4TXxPTbvKZarpK/2f+Jv8MYF6mfVp5Ed6/PuRnsDvfFaFT7wQHKtEn+uH8Fu3Kg
	ak4qJ8dtO3PU7CS5HyE6rLN+lbV9DoXnei/FlBMax/F6Pqo3qo9Py8AFDK1YAB8QaiaRODDSMEWzu
	fdLVmuwmDGGtCANu6c1x4UBR8FlwZYvfqa19/0BG/mnTrBNFBd+LO5ZhSklFFlQGc98dRcJRIDooD
	Hd3K0yAIAWCLgLE2bUqFjqcajQPGV/nKh5K3mYsD9ChXbciz+xMPSLI+pURr1ALglO1ypa5mawk/0
	UTsYBuZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVFaf-007Hbo-1g; Mon, 05 Sep 2022 17:08:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVDDc-004YJK-7K
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 14:37:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C02168BFE; Mon,  5 Sep 2022 16:36:53 +0200 (CEST)
Date: Mon, 5 Sep 2022 16:36:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 6/8] block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
Message-ID: <20220905143653.GE5813@lst.de>
References: <20220825152425.6296-1-logang@deltatee.com> <20220825152425.6296-7-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825152425.6296-7-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_073713_813618_5CBFEFEC 
X-CRM114-Status: GOOD (  11.82  )
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

On Thu, Aug 25, 2022 at 09:24:23AM -0600, Logan Gunthorpe wrote:
> When a bio's queue supports PCI P2PDMA, set FOLL_PCI_P2PDMA for
> iov_iter_get_pages_flags(). This allows PCI P2PDMA pages to be
> passed from userspace and enables the NVMe passthru requests to
> use P2PDMA pages.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

