Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05447C61CE8
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jun 2025 05:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7mDvelvx7qb+/8aoIvHvN6kPvdW6CrivQvSYn0Ffzq8=; b=IXBa+/9bj8Cr7COw43oEyjW4Q2
	otVX3GUIL6kGDPQKOUmfM04/t9P+j5nX9qfvD3LWB7k/4Y8sLX3iDF7mBZMIUHNolzPrFgrOOKVtK
	xECQHh6K+5Xzu0YiYPUiPEdhd6S30ILkLabUPoXVRfwkLgvy0Zrd3JkmRBgVefYYj1DZhRR1uQhOd
	TR4LU+iTBGyR1KfTKfds+rmb6w+IF/m2a2nxDnew8kEbSpWFyhzEF5y6POCCcUiBfTtdwNtnKmEPD
	oqmySTx4I28Q1WTPI1p4X5/XvNst4pbVSiLKjBn2zvgScZAfUnmNHXVHs1y/kLQ5gPVtIlAu89oa6
	TSd+chOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa4U-0000000CBtQ-1gLv;
	Thu, 12 Jun 2025 05:01:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa4Q-0000000CBsr-3jJ0
	for linux-nvme@lists.infradead.org;
	Thu, 12 Jun 2025 05:01:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BDD2868D09; Thu, 12 Jun 2025 07:01:42 +0200 (CEST)
Date: Thu, 12 Jun 2025 07:01:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] nvme-pci: merge the simple PRP and SGL setup into
 a common helper
Message-ID: <20250612050142.GG12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-6-hch@lst.de> <aEnvJ6V3F0Z_pO1U@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEnvJ6V3F0Z_pO1U@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_220147_064871_D18692C4 
X-CRM114-Status: GOOD (  14.69  )
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

On Wed, Jun 11, 2025 at 03:03:35PM -0600, Keith Busch wrote:
> On Tue, Jun 10, 2025 at 07:06:43AM +0200, Christoph Hellwig wrote:
> > -	iod->dma_len = bv->bv_len;
> > +		iod->cmd.common.dptr.prp1 = cpu_to_le64(dma_addr);
> > +		iod->cmd.common.dptr.prp2 = 0;
> > +		if (bv.bv_len > first_prp_len)
> > +			iod->cmd.common.dptr.prp2 =
> > +				cpu_to_le64(dma_addr + first_prp_len);
> 
> Nit, set prp2 to 0 in an 'else' case instead of unconditionally before
> overwriting it?

unconditionally setting it actually generates slightly better code,
assuming the compiler won't just optimize the other form to it anyway.
But if you think it is more readable I can change it around.

