Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DA4CA0EEB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 03:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jxMRJz5w5n4PxTFk/2BTZWr0cMwftnWj3iBsc1w/fNg=; b=zz5By10X4oC315Nvu0kDkCzQ34
	c0lkV6+p3bUdJdNiAz5Z9FD0IcGkMGf6iom3916ghuWsZdK/s2sLwBgKgtzGZnkQSz+vXb7zyvODZ
	nPwxCzdltCpIbfTSCPkaeABjDYPvro2fS6zPlPwCzLtIxMu7MgCY927FZvlM+10+d1iGgscsoBvIm
	3n/BY5pXkJ0EhQyssr/3nQ321gYFOzp+A9a+WJBmn7mkB8W3US8PPIl05MxhJXU9hAmTuNaGCZN+H
	lZxq5G2LcY3sHdgBOAeQYGRkAU7kNu9U+kH4XAEGQGtfY/4LwucV5c0Bd5wxSvNaWTs1jCPFldgGf
	9XKcWUkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uowE3-0000000FhXS-2mJp;
	Thu, 21 Aug 2025 03:44:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoQwY-0000000BHD8-0evn
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 18:20:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C14C74588D;
	Tue, 19 Aug 2025 18:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0BDC4CEF1;
	Tue, 19 Aug 2025 18:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755627608;
	bh=vJQ95/awDQN15gMxlaXB+Tcfic806+eL4EX36Buoiiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXjytkUFHZiUoUGI84YdHLEqkOvvneMczP1tcgM6yHssC3PZa14NlekO8OwnhQkoH
	 1tKFJyNzeoXibR5866EB9AlD853dT6hX/BHgsXNW4sH7pbBGpZs3bWwj08oPN1sJoj
	 hWrw/W8bx/Ed7fmJOvpwVh//YcUPC4H4piBW1ARVWVGtVpPRrRKbwDEj6sLZPN6zpp
	 WYxb2QFL4WZg9ljpPs9MR4UmpIcWbSmNlEaUUOSNEz9VaSvb+A8MMAVV0hqzSSr9AT
	 hd29ClRf6ZWgUwXusfUehQO9rXf61PDcTKf5hXEkAaN2POaxHzJVqre4wL9NW9YYur
	 pp6mAS1uKCUqA==
Date: Tue, 19 Aug 2025 12:20:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-nvme@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 14/16] block-dma: migrate to dma_map_phys instead of
 map_page
Message-ID: <aKTAVOBp0u6ZSC4w@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <22b824931bc8ba090979ab902e4c1c2ec8327b65.1755624249.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b824931bc8ba090979ab902e4c1c2ec8327b65.1755624249.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_112022_214424_CBF03F52 
X-CRM114-Status: GOOD (  11.66  )
X-Mailman-Approved-At: Wed, 20 Aug 2025 20:44:16 -0700
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

On Tue, Aug 19, 2025 at 08:36:58PM +0300, Leon Romanovsky wrote:
>  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
>  		struct blk_dma_iter *iter, struct phys_vec *vec)
>  {
> -	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
> -			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
> +	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
> +			rq_dma_dir(req), 0);

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

Just a random thought when I had to double back to check what the "0"
means: many dma_ api's have a default macro without an "attrs" argument,
then an _attrs() version for when you need it. Not sure if you want to
strictly follow that pattern, but merely a suggestion.

