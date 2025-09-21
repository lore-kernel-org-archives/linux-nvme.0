Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A260CAC5B0
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Sep 2025 06:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xtIvv4lw44pUlJuaLKbzEHjJi6xJvnBBYTGn1zOuzT8=; b=WFycX6QSYZ6w11Nr0OEcEKNt7J
	Yt66/iGOLSytZhtCAxObsDsA6AP7iuQpsX9evPng6bIWJO2PWU29+1gljqVItXe2A2r7quGQNtb0t
	7PC7uc4t+lr52A3AO8n2fd0WutdfFDhlZ9kC4HzXFzwmfT5UtMJ3Y8uc9TjCq444gONsTzwNA9FNJ
	NwVsuzhGHfyndiSjfAzptD0b3ch/b0bhraStoCdG9wmPKgRyaIhdatS3MCYaSgxn5INmmWO+/7K+Y
	tqvxOSNGp/XhBc+B7XEc3SPbQm3H0grnJTfXUsvuYwmwOJhEyOmcqFpyXgY2Xstc3Nkje59JtSZ0o
	pAFlJF3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2ORA-00000007f8z-378z;
	Sat, 27 Sep 2025 06:29:40 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v08En-000000069di-2fcU
	for linux-nvme@lists.infradead.org;
	Sun, 21 Sep 2025 00:47:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 70099600AC;
	Sun, 21 Sep 2025 00:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F266C4CEEB;
	Sun, 21 Sep 2025 00:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758415652;
	bh=aFgKZNQUQCaJ2vrroedLHD+DNPOlwj6GGUlnWjzhG5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLUxwzDvBQpVLTwxkVcEMGkM0isY6OG/nLB20SsNVXIRKxxZrAbNIPP/lH+JLvuUn
	 Kib9NA0Qx8ucaR4Lud4LpP66fHzAfy4YMg/WGXGCNSBD/snmzPLJ/GJr5uZM4GRPA4
	 FmPuCrywKU63yNMwT+i1LUerAAz4LYMUpnupPis0tcH13QBvBt9TCQlrhzdIw9AGje
	 8PZjHxaN7jKNeL5CBfGmMNjS4nLwafvguDKC8M88c1TuvUDa7uTmWsQUU6EjD9ZRCh
	 q7PhsUzYYnzKkPRC+D+A2gtlVl3c6gXMUqXDS+5w81SLBHHJjwyUZmv9q7TG8Bge2K
	 OMtCSqZskSdHw==
Date: Sat, 20 Sep 2025 18:47:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	David Hildenbrand <david@redhat.com>, iommu@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>,
	Juergen Gross <jgross@suse.com>, kasan-dev@googlegroups.com,
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
Subject: Re: [PATCH v6 00/16] dma-mapping: migrate to physical address-based
 API
Message-ID: <aM9LH6WSeOPGeleY@kbusch-mbp>
References: <CGME20250909132821eucas1p1051ce9e0270ddbf520e105c913fa8db6@eucas1p1.samsung.com>
 <cover.1757423202.git.leonro@nvidia.com>
 <0db9bce5-40df-4cf5-85ab-f032c67d5c71@samsung.com>
 <20250912090327.GU341237@unreal>
 <aM1_9cS_LGl4GFC5@kbusch-mbp>
 <20250920155352.GH10800@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920155352.GH10800@unreal>
X-Mailman-Approved-At: Fri, 26 Sep 2025 23:29:38 -0700
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

On Sat, Sep 20, 2025 at 06:53:52PM +0300, Leon Romanovsky wrote:
> On Fri, Sep 19, 2025 at 10:08:21AM -0600, Keith Busch wrote:
> > On Fri, Sep 12, 2025 at 12:03:27PM +0300, Leon Romanovsky wrote:
> > > On Fri, Sep 12, 2025 at 12:25:38AM +0200, Marek Szyprowski wrote:
> > > > >
> > > > > This series does the core code and modern flows. A followup series
> > > > > will give the same treatment to the legacy dma_ops implementation.
> > > > 
> > > > Applied patches 1-13 into dma-mapping-for-next branch. Let's check if it 
> > > > works fine in linux-next.
> > > 
> > > Thanks a lot.
> > 
> > Just fyi, when dma debug is enabled, we're seeing this new warning
> > below. I have not had a chance to look into it yet, so I'm just
> > reporting the observation.
> 
> Did you apply all patches or only Marek's branch?
> I don't get this warning when I run my NVMe tests on current dmabuf-vfio branch.

This was the snapshot of linux-next from the 20250918 tag. It doesn't
have the full patchset applied.

One other thing to note, this was runing on arm64 platform using smmu
configured with 64k pages. If your iommu granule is 4k instead, we
wouldn't use the blk_dma_map_direct path.

