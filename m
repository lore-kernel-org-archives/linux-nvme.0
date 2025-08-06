Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D503C87FDA
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Aug 2025 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1x3Q7Y/VrhoNVJRSqy0Fcj4XeiXf5SuLbr9bYLsjRI8=; b=l2VCJmkxWb3hQZiixsBqHR8yvM
	kCHxjNn0u15enpcztti5GuLkaoWpKt3u9UEjwUY8y1qT7yzm7o7vU8i9H55BczrdNjWnzJAkjduf6
	oN62N0pMr7rck952JlR9kHHrjJMSTYh3DFmWm24U7nGovraPTP3NP84y5htjB50ZUvuws9nODy0cr
	hAmyLp5SGvs6iEcC6xhAxCjNYakPLGmo+XWH9Qz+P3ex5bjtf9Ge5+WcQTRZFySkPI3e7faNdnEF4
	gA76CxvGM44Pmm82WWZZfaugELuYtaD+nmikIGSMc2vcofFMe4oqAItSiN+rwV2XUaZRx7KXb8atB
	xGR6kxsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk267-00000000uPr-0ozs;
	Thu, 07 Aug 2025 15:00:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujj24-0000000G5rE-1Cib
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 18:38:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 534C15C5889;
	Wed,  6 Aug 2025 18:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410C2C4CEE7;
	Wed,  6 Aug 2025 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754505514;
	bh=3VsSAjLVcmccxCZ3hnnn1RvFFPeP1KXfNR/kPK523tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ge50qjueu3yzrmSLvI7mO9n8KQkiFiYfr4PhBvbyi9xJtwRH+3VLE26OL160ezEfS
	 l7n3yTGZYML7usXiAxesUibX5X3uv+Y7zSbVhAbamikh3Xal+W4d9sOmoNJufjNKOd
	 mltqBVBcA3J9CQVjxxN7y8g/410e0ODnTntjvgOrjJZ0GcQu7FKKjy5hCvF14lL7EB
	 GCHlgBFQUU1u6mCSnNeVtRb+60F9YWCMntqEV5h3kpkOIbolMnee/QD5F6iZ+TELym
	 IpJ05UFpUZfqx3imORqYTmOC8S0Z30OtwN23sPhn2SppRACGNtVevxAEaRFm6toCBl
	 Pc8wnVLkh3LNQ==
Date: Wed, 6 Aug 2025 21:38:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v1 03/16] dma-debug: refactor to use physical addresses
 for page mapping
Message-ID: <20250806183831.GW402218@unreal>
References: <cover.1754292567.git.leon@kernel.org>
 <9ba84c387ce67389cd80f374408eebb58326c448.1754292567.git.leon@kernel.org>
 <20250806182630.GC184255@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806182630.GC184255@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_113836_363069_EA85FF2E 
X-CRM114-Status: GOOD (  12.77  )
X-Mailman-Approved-At: Thu, 07 Aug 2025 07:59:41 -0700
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

On Wed, Aug 06, 2025 at 03:26:30PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 04, 2025 at 03:42:37PM +0300, Leon Romanovsky wrote:
> > +void debug_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
> > +		int direction, dma_addr_t dma_addr, unsigned long attrs)
> >  {
> >  	struct dma_debug_entry *entry;
> 
> Should this patch should also absorb debug_dma_map_resource() into
> here as well and we can have the caller of dma_dma_map_resource() call
> debug_dma_map_page with ATTR_MMIO?

It is done in "[PATCH v1 11/16] dma-mapping: export new dma_*map_phys() interface".

Thanks

> 
> If not, this looks OK
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason
> 

