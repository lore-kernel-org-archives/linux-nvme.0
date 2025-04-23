Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA70C369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 18:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E9B/0QMHygfpdDt2ACSpgv9duqOa8pRwTtbjr6Wt4fs=; b=i2ttExNaZKNyanfOfybNs/1i9t
	tjjxrJ3aLgIjtOTWGInHnyyYIms5e9LYv+HFY5abAwSuT8jiqzPwtv5GM8lODfjFmdxT4o1ZlRpqP
	QOFff+5Z9JwcyyXhvR+7v2bSasskBp/YKf2eTTU5C2qXMVD79gLta5nXcWI3eJTTrwvQn+MPP9+hx
	XQYVn0jFk1hZ5l2sXe+mWuhk8sCZR0XHaf2tzByMsURmxMHB9y4/TGtZlLUGpmjOdnAVhfou923hl
	mrlk/uUl8vgKs9n/wBtH1nAuPC+DwwGDMijNddxmCprwfLcn7GWyJdPlkhP5P6h26NjuvIIKw6lVS
	sATz78Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ezc-0000000BbUT-1eH9;
	Wed, 23 Apr 2025 18:38:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7bfd-0000000AuMC-1Y94
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 15:05:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7A0754A459;
	Wed, 23 Apr 2025 15:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901EFC4CEE3;
	Wed, 23 Apr 2025 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745420752;
	bh=+pgwEq/v7P8f/AIzuDnfFPRQJNNWeIXj7j55MF1ARFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFJx/822j4GTOfsd2flNm5Ey/TaUnXvZT5qb1IFKN8MDVYAFjFrSYj2QuqzBXOI34
	 cCL2AjpTOhK3gqFdVzm60QZZvEA+ZIjYjEMhAIT2Om4kk9CpVlY+UMwZFizRz2A4FV
	 x2Kc0vTLaMJFho4pwEjsYBGAdyZMrqxDedEJqMD9wYE2ukoG/n7seIhucFhuW31zDW
	 UmvL8uviiKFbeGy65gClBxfYw6dpkBtsqH4du4EF8WICj2EuxnuXGLSAWwcwRzUmrc
	 x84yDhW8Ij5YIQpP/JKhV3PMooMVAUA5y9/B5QkJayW+yclq7f2CrbG5CDNIkG4bD0
	 7IzL5VKJcHazg==
Date: Wed, 23 Apr 2025 09:05:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Jake Edge <jake@lwn.net>,
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v9 23/24] nvme-pci: convert to blk_rq_dma_map
Message-ID: <aAkBzDgjiWkbeP8P@kbusch-mbp.dhcp.thefacebook.com>
References: <cover.1745394536.git.leon@kernel.org>
 <7c5c5267cba2c03f6650444d4879ba0d13004584.1745394536.git.leon@kernel.org>
 <20250423092437.GA1895@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423092437.GA1895@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_080553_431909_A4A7EF43 
X-CRM114-Status: GOOD (  12.09  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 11:34:49 -0700
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

On Wed, Apr 23, 2025 at 11:24:37AM +0200, Christoph Hellwig wrote:
> Right now I don't have a test setup for metasgl, though.  Keith,
> do you have a good qemu config for that?  Or anyone else?

QEMU does support it, and reports support for it by default (you may
need to upgrade qemu if yours is more than a year old). You just need to
format your namespace with metadata then you can send commands with
either SGL or MPTR.

QEMU supports 0, 8, 16, and 64 metadata bytes on either 512b or 4k block
sizes.

If you want 8 bytes for metadata on start up, attach parameter "ms=8" to
the '-device nvme-ns' qemu setup.

Alternatively, you can use the 'nvme format' command after booting to
change it whenever you want.

