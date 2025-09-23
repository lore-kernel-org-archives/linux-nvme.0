Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DA1CAC5B9
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Sep 2025 06:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f74v45qTfX4rd0AIVdvbIhhb3jagTfRC+ZZltoOMjTc=; b=DoV+IHcKtatF/jXyjLojhncuJS
	2R+7/iow9/NdjTINGnIaxYsdljXPw38FE2SfCd9Mtf2s8Yju8RDXvFfVY3ND4CBRFY9t940+8WrGL
	j7vlLaQ8HQP4jj4w2061BMMF/tF6DS0LNAxPk+raFq6YnotSYNKmK0dxkspKZr5L9iw2kDfl3kP3C
	iKsVSKDXtSSYLm7Npx73mPdFduCkExomN1xfyy4qQV1eGkeVqXBeCzsqgT+6kkMbfHEXgUWCBZP3g
	TsOVMzWNQmfS2O1NgdMPv0MUwtdOZXerN+ogTunISztTTGPIq22BmPsVyrFT3GJ08sMdTW/QYmEQt
	sUGBgBFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2ORC-00000007f9y-0ICO;
	Sat, 27 Sep 2025 06:29:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v17n2-0000000EXiQ-1NVW
	for linux-nvme@lists.infradead.org;
	Tue, 23 Sep 2025 18:31:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6BC3A4393E;
	Tue, 23 Sep 2025 18:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB030C4CEF5;
	Tue, 23 Sep 2025 18:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758652259;
	bh=gxKH7wZVbZJUgsdcRmV6yXRnCWQ9TqZ9bpedLe1yt7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4ZXIaWM41Ablw/mVVeAaJkiSYgUA1XjiTWt5LSH4qwLIacOxMZE3jScnz0xix1Wv
	 SAp5BLuT2R2dCAYXxRdOCtJez17N/cBe9kv8+xOmcpzYoZ/UpcFkDX5GmNuOLJGCFV
	 Bcs4RLVyhjVQyFhRGAbe1bDHxUFJbKgGu/3vW1Mt1BkujhZ/XZn25PIvUn5jT3S9nw
	 YVX4n2lhWFpC/hhBuXD/s3h9/tXRxQArUIgc5V0sUKhDNiOC8ABgtjM7Q3+LQGe+ys
	 cSfhtq2Jd52bcQy4LLrP2uqO++/e9zs0F7UgxrbinfFgheCfADXwZVzyKQ2yU+i53A
	 XGP2nnt2Bp5Ig==
Date: Tue, 23 Sep 2025 12:30:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
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
Message-ID: <aNLnXwAJveHIqfz0@kbusch-mbp>
References: <CGME20250909132821eucas1p1051ce9e0270ddbf520e105c913fa8db6@eucas1p1.samsung.com>
 <cover.1757423202.git.leonro@nvidia.com>
 <0db9bce5-40df-4cf5-85ab-f032c67d5c71@samsung.com>
 <20250912090327.GU341237@unreal>
 <aM1_9cS_LGl4GFC5@kbusch-mbp>
 <20250920155352.GH10800@unreal>
 <aM9LH6WSeOPGeleY@kbusch-mbp>
 <20250923170936.GA2614310@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923170936.GA2614310@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_113100_388690_6D48F912 
X-CRM114-Status: GOOD (  18.70  )
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

On Tue, Sep 23, 2025 at 02:09:36PM -0300, Jason Gunthorpe wrote:
> On Sat, Sep 20, 2025 at 06:47:27PM -0600, Keith Busch wrote:
> > 
> > One other thing to note, this was runing on arm64 platform using smmu
> > configured with 64k pages. If your iommu granule is 4k instead, we
> > wouldn't use the blk_dma_map_direct path.
> 
> I spent some time looking to see if I could guess what this is and
> came up empty. It seems most likely we are leaking a dma mapping
> tracking somehow? The DMA API side is pretty simple here though..

Yeah, nothing stood out to me here either.
 
> Not sure the 64k/4k itself is a cause, but triggering the non-iova
> flow is probably the issue.
> 
> Can you check the output of this debugfs:

I don't have a system in this state at the moment, so we checked
previous logs on machines running older kernels. It's extermely
uncommon, but this error was happening prior to this series, so I don't
think this introduced any new problem here. I'll keeping looking, but I
don't think we'll make much progress if I can't find a more reliable
reproducer.

Thanks!

