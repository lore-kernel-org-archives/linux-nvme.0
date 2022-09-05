Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA20ECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 17:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VbAFdpoPXWbRZlhuN33kyDdubb2U+AU+TS+0sItsAU8=; b=4s4wEkGqDHgvThQO2qlxGstcwV
	oWfvF+AnXlpRQUoV6lLpksb5Ffb+NO2HmUdLL/v8MKKwrO0+pFReI8ZDKoeG4m05G5AsCNA5TSXYu
	Y84iA50JYT5ODRQdS38XZ0Rm8dA1sZnHu/YLrnF/jCHc5EyF1bkN0SwdUCvnoQ0jHZ7f5K3EMwerM
	QwvJXjmlDqqEQQlIR8vqKo2WHlPdHhYvYggnIZbcKFnmxnhx9UGtNtOhRvOdOerLn6I0LnSAGJtrn
	vHKIJa8PX41JbJ1hkKXMwsretTwYkciOlRfM5yxQmL9FouPkb1V/ttCUg2EnpSTDzMzp+57DtSq1I
	K93uSREA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVFaS-007HSQ-Gv; Mon, 05 Sep 2022 17:08:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVDDM-004Y1y-0A
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 14:36:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E999768BFE; Mon,  5 Sep 2022 16:36:34 +0200 (CEST)
Date: Mon, 5 Sep 2022 16:36:34 +0200
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
Subject: Re: [PATCH v9 5/8] block: set FOLL_PCI_P2PDMA in
 __bio_iov_iter_get_pages()
Message-ID: <20220905143634.GD5813@lst.de>
References: <20220825152425.6296-1-logang@deltatee.com> <20220825152425.6296-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825152425.6296-6-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_073641_002569_480C2C63 
X-CRM114-Status: GOOD (  10.49  )
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

On Thu, Aug 25, 2022 at 09:24:22AM -0600, Logan Gunthorpe wrote:
> +	if (bio->bi_bdev && bio->bi_bdev->bd_disk &&
> +	    blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))

bdev->bd_disk is never NULL.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

