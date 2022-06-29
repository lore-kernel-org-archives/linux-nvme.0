Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66672C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 06:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=BGN0TBcTQ3zryqOfHxpV374zvQ
	pEuXmnH5r91iT57s0UNH4gwKlfwtk/tKF+SjgTEvYmPFFIpiG+lTUR36knAclC/AvudAMSBtEUavN
	/PaVcESXedsFab4Skr0QqC6hgavlCpnP+lQCQZU3PHLmR2g/hKg9wYqskXUiFZ7lKtZ2jWbYudnUn
	l1mJPfL2HZO8bVUpkkLfzngu5jKLkBcELhe/ZlUmF9ByLtCgPuGdc5VuZnoYDc2Yu/0O5Zb0LxWJO
	4o1943q+bNxS30RpzhWUd8MdFc4xSeIU0dPJ7AZR2UlDK5lWvpEofNtqimnsLFgifqREbJEjCtvc3
	zn7JAsGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6ROt-009q4n-9W; Wed, 29 Jun 2022 06:42:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6ROm-009pzc-2d
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 06:42:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2EB6C67373; Wed, 29 Jun 2022 08:42:01 +0200 (CEST)
Date: Wed, 29 Jun 2022 08:42:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
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
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v7 10/21] nvme-pci: convert to using dma_map_sgtable()
Message-ID: <20220629064200.GJ17234@lst.de>
References: <20220615161233.17527-1-logang@deltatee.com> <20220615161233.17527-11-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615161233.17527-11-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_234204_319881_7564A0D2 
X-CRM114-Status: UNSURE (   9.14  )
X-CRM114-Notice: Please train this message.
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

