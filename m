Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA0BCA0EDC
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Aug 2025 03:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zm/dCvvK+iI7j714RjSP/vwEDHJVwvkiYDPPSLpMKNg=; b=KrRdNTN2gfuQDR0xeMvuA9AwNU
	KgGkPb0txTY3VfnOO3v9RMK8yxbdRj4ZUQ5bp/3HUy/dJEvHJ5CGzgthokwa/yP2TrMOsSDonvd7m
	UJIPVpIfRT2AxUZbpScT9gE1NhWMPXQUz5FGtJJQrI1cKXef3qdcpMlOHaDu4f79FbobSHP5rk8PS
	98iKKGW379Pkt/d/w//Qg8Z7kXLYcQ4RoQuTB884W6oFZTTAKyo2mK5TNfW6cWNHpH7F3DsqTbAJA
	8WdA787trRk+/bkuDQEVF1qGFdtOaOHK8hiBp8rHPjHv/Io7HYyumn4hRfVWba1tyZSz/vP9Pl6zC
	A3gs9NzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umOxD-0000000FgrB-1uvw;
	Thu, 14 Aug 2025 03:48:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDXh-0000000EDFh-3HHZ
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 15:37:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B00E35C1360;
	Wed, 13 Aug 2025 15:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A911EC4CEEB;
	Wed, 13 Aug 2025 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755099452;
	bh=PQhq5rWxBSi6wo5Tnnh0V92zapg7M+UyVJSAH0kCd/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkqdIE/HRQ5cedE1zyuMfMRaAZJeqzpFBH0/fLyOJbOpD7Q9Y6fUKKVCUSYg6Iu9+
	 +0lhPpaogX+zo7DE625PlBBN7tO+nQtx0LA2aKRv5GqYQcf/TD8I++3mIddUS1oGuS
	 2Xu0FGRyeN7MRl5kxApDBRYf8dHZhW8fLMu9BCMo8fTZeDkfiJH03TaTo8MCeUS3wk
	 Q3N2kSeVd08IYz9d3sNubS0p0XfPjY2fnOy5IU5HLL6nAdg88Wdvo9IzmX54CnrqWQ
	 dCVsQbDhz8GqQ+nB2+l0260S3CZs7QJe8H773Ex1NmDTheYUl2t1VYx6TqiJOtited
	 Jw1XTt4Q0BCbw==
Date: Wed, 13 Aug 2025 18:37:28 +0300
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
Subject: Re: [PATCH v1 16/16] nvme-pci: unmap MMIO pages with appropriate
 interface
Message-ID: <20250813153728.GC310013@unreal>
References: <cover.1754292567.git.leon@kernel.org>
 <5b0131f82a3d14acaa85f0d1dd608d2913af84e2.1754292567.git.leon@kernel.org>
 <20250807134533.GM184255@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807134533.GM184255@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_083733_859381_7115E6F8 
X-CRM114-Status: GOOD (  14.84  )
X-Mailman-Approved-At: Wed, 13 Aug 2025 20:48:37 -0700
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

On Thu, Aug 07, 2025 at 10:45:33AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 04, 2025 at 03:42:50PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Block layer maps MMIO memory through dma_map_phys() interface
> > with help of DMA_ATTR_MMIO attribute. There is a need to unmap
> > that memory with the appropriate unmap function.
> 
> Be specific, AFIACT the issue is that on dma_ops platforms the map
> will call ops->map_resource for ATTR_MMIO so we must have the unmap
> call ops->unmap_resournce
> 
> Maybe these patches should be swapped then, as adding ATTR_MMIO seems
> like it created this issue?

The best variant will be to squash previous patch "block-dma: properly
take MMIO path", but I don't want to mix them as they for different
kernel areas.

Thanks

> 
> Jason
> 

