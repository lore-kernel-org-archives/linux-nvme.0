Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4A6C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Dec 2021 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lMKPk837s/uDYvbv/dAf972D/1vqmx+M9YeBK61g/x4=; b=vEzwG/D/zz1bmbeHmdadz38fdc
	g9axPi3ihqz18pdFsm97N5yVGald1dXJLR8zi+Xz5mlojRLJ761TfE7k5t6d+WynC/mUbKCpDXPbX
	KS7MfgnhXTOd6iCAa/pAzQAqmXCAX5PD3Hg3tCEPV6pe4DbqC7+VzHIFHb6Zh51AzARRjoXwvxpBC
	TCfQRGUlA1HLdTe9xfc1/b6uuRXg2804jFaIjraH2jDgjfTbgxX8e+iX7/kK1Kfy8Gq7orYSMSCeb
	WgVHpgVDEMtH6HU24fcmzaeR5adldZK0UXzLywPcqVbyZma+U4ZLdEwTErl9OGLfGiltXKMwh6Jnx
	eFUyUVGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzb0H-0060Z1-GQ; Tue, 21 Dec 2021 09:00:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzb0E-0060Wp-Sm
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 09:00:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7A18568AFE; Tue, 21 Dec 2021 10:00:04 +0100 (CET)
Date: Tue, 21 Dec 2021 10:00:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 01/23] lib/scatterlist: cleanup macros into static
 inline functions
Message-ID: <20211221090003.GA7949@lst.de>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117215410.3695-2-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211221_010011_089079_89089559 
X-CRM114-Status: GOOD (  12.94  )
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

On Wed, Nov 17, 2021 at 02:53:48PM -0700, Logan Gunthorpe wrote:
> Convert the sg_is_chain(), sg_is_last() and sg_chain_ptr() macros
> into static inline functions. There's no reason for these to be macros
> and static inline are generally preferred these days.
> 
> Also introduce the SG_PAGE_LINK_MASK define so the P2PDMA work, which is
> adding another bit to this mask, can do so more easily.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

scatterlist.h doesn't have a real maintainer, do you want me to pick
this up through the DMA tree?

