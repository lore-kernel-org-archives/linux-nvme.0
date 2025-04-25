Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEA7C369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 18:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1CfGXA88R8hMMyIBt8aOhC7AURfnCYMI4bHM+e4cOiU=; b=ZsuYT3lOn/k7vfGNLCvqj3SbYL
	VMzshnx+g7bKPwcA2HOn2RXD8jQmWBYebY8HiYTJgH6vDrcjepwfokJLBU/TNmHZpABev5/mwYU5j
	eQ8dPEom2hr3riCplrT6Gvn5SJzPU0S7FA5O4nmlGGlzNiRbV+rwSBiEn9gWTsxdbYMsowCVtKgI7
	rQeJb8mIKf1obEYng/huo4Zj9/BjDRs6toPWQWLPO37kP3ysdKggVLj4KTdPG2cva6R1SLgROs0Qi
	cVOdFaEf4WmXcmwKrdCs2a8E0Lv4iglhodSTBPOsf1YDFUf5BaLWNkRj5JWlsG/fNp7mvq7n7Mua9
	QhSwj23Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8NlA-00000000X20-1Wzo;
	Fri, 25 Apr 2025 18:26:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8NO7-00000000UCW-2qyu
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 18:03:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D80745C6A2E;
	Fri, 25 Apr 2025 18:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFD1C4CEE4;
	Fri, 25 Apr 2025 18:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745604178;
	bh=GlHZ3nQIl/lKAjbzyAfvCDkSdKESLA3OEmyBcQjujck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rgkfw+BQTICZthivqCvV/L24rzpWQHbDcyxggr1y+m/v43rfeZ8mVc0gW9um7fv0b
	 8UafxsdBy2OSnbMDS5NFMohqw/JUMNlm1lLeRM9bksCbnWhkpvG1sMaT+pD4u+ffRH
	 8pIUlmyLfoSlvzGXqDwnfiebUuADE431RCYOd6tbrbLbvBjoynuBlQ5zFLUwzx+Bi4
	 rGux6Foo2lHXO20hT1/pHPb+gHQz9MKCOsluoedgGVWhhJf8tGKuOY5k2+/cT7G2O3
	 Lha8hXq2f86SbjO/kQE7iwnWqluHmT2utJrQpEDxaiqrLaVadzaMFYa480cXg0cBjW
	 /ZIf/+bOW5TJw==
Date: Fri, 25 Apr 2025 12:02:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] nvme/pci: make PRP list DMA pools per-NUMA-node
Message-ID: <aAvOT8meWyuBpUpS@kbusch-mbp.dhcp.thefacebook.com>
References: <20250422220952.2111584-1-csander@purestorage.com>
 <20250422220952.2111584-4-csander@purestorage.com>
 <20250424141249.GA18970@lst.de>
 <aApbYhyeYcCifoYI@kbusch-mbp.dhcp.thefacebook.com>
 <20250425132111.GA5797@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425132111.GA5797@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_110259_769223_6404E9C7 
X-CRM114-Status: GOOD (  14.59  )
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

On Fri, Apr 25, 2025 at 03:21:11PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 24, 2025 at 09:40:18AM -0600, Keith Busch wrote:
> > The dmapool allocates dma coherent memory, and it's mapped for the
> > remainder of lifetime of the pool. Allocating slab memory and dma
> > mapping per-io would be pretty costly in comparison, I think.
> 
> True.  Although we don't even need dma coherent memory, a single
> cache writeback after writing the PRPs/SGLs would probably be more
> efficient on not cache coherent platforms.  But no one really cares
> about performance on those anyway..

Sure, but it's not just about non-coherent platform performance
concerns. Allocations out of the dma pool are iommu mapped if necessary
too. We frequently allocate and free these lists, and the dmapool makes
it quick and easy to reuse previously mapped memory.

