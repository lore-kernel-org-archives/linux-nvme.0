Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70C7CA0FFE
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 12:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5zSMrOVSNClOrdiZ1EgFy9NdG3HEevOLe/lENj4ZGeg=; b=1/gt3L36XRRR6aq7NIPebEf7Lo
	7Kf4b4F/TFl6H+uo0Ne1mgy4JJNiIBBVfU7p9Cbkayv7Ei7iQ5hBAfFVhkYv4oXWWiJ4xJ5X4GX+/
	4OzSu1WKQqYji3wh8ginONxqtdGDf7kCkWFePtCQMXuCk+bTKryUEg/DMIzRop3pjIh/P/ox7Bef2
	/g0PT22KYiSNmr96Je0pJ/FEh10JT9ipEX8sacK3YrGeC9dVlaCWUSyXbiD/e5FiHPTaVsN2zk2hc
	QvcwZ6UJ6e9UHlsOGVZd9+IZObtuKpWbkPDabQKesn8VvtshWeIEHUj44/cfZ4eEOtQShNQtOrWX5
	t0lee71Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utQ6T-0000000HDm9-0sEj;
	Tue, 02 Sep 2025 12:27:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uryK9-00000005g4p-0dWA
	for linux-nvme@lists.infradead.org;
	Fri, 29 Aug 2025 12:35:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1499A60054;
	Fri, 29 Aug 2025 12:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DF0C4CEF0;
	Fri, 29 Aug 2025 12:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756470919;
	bh=fPmX8Rp8udx+VwVXpgZe9FXorpOePyV4Ef8DrCTRpmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mxl8/qU6Vvz0COFBLrmB8UJZ9govt1w/+9MvHsezQkHTR5DIoYs7xgXKhzSYkVOm1
	 ZyticaiPv1YXSMvOVriZNEtfWFF/4gFAB5LRbmsuDZl1qYUJ6QJjS6y5kT84iXSP4h
	 c3O0x8clzW4t74drhw57szBCRrci0dZsz7TkMKYvpu6q9eSqR6y+QLN+NF1mWqnv0Y
	 TV+utnoubo+22XzKDO5zQdJ90tzO09TUxr04pRitKlRur46am/LMf882y9Fd21W1eK
	 Oe5n+rwQMv7g1wcRBxrA0L1C89sfgumKn452/Ld/OiWS5hXm6vNk/t7OjLj/in2qzE
	 hQrPqQ39Y1fww==
Date: Fri, 29 Aug 2025 06:35:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
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
Subject: Re: [PATCH v4 15/16] block-dma: properly take MMIO path
Message-ID: <aLGehMVsTEXrP_R5@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <642dbeb7aa94257eaea71ec63c06e3f939270023.1755624249.git.leon@kernel.org>
 <aLBzeMNT3WOrjprC@kbusch-mbp>
 <20250828165427.GB10073@unreal>
 <aLCOqIaoaKUEOdeh@kbusch-mbp>
 <20250828184115.GE7333@nvidia.com>
 <aLCpqI-VQ7KeB6DL@kbusch-mbp>
 <20250828191820.GH7333@nvidia.com>
 <aLDCC4rXcIKF8sRg@kbusch-mbp>
 <20250828234542.GK7333@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828234542.GK7333@nvidia.com>
X-Mailman-Approved-At: Tue, 02 Sep 2025 05:11:04 -0700
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

On Thu, Aug 28, 2025 at 08:45:42PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 28, 2025 at 02:54:35PM -0600, Keith Busch wrote:
> 
> > In truth though, I hadn't tried p2p metadata before today, and it looks
> > like bio_integrity_map_user() is missing the P2P extraction flags to
> > make that work. Just added this patch below, now I can set p2p or host
> > memory independently for data and integrity payloads:
> 
> I think it is a bit more than that, you have to make sure all the meta
> data is the same, either all p2p or all cpu and then record this
> somehow so the DMA mapping knows what kind it is.

Sure, I can get all that added in for the real patch.
 
> Once that is all done then the above should still be OK, the dma unmap
> of the data can follow Leon's new flag and the dma unmap of the
> integrity can follow however integrity kept track (in the
> bio_integrity_payload perhaps?) ??

We have available bits in the bio_integrity_payload bip_flags, so that
sounds doable. I think we'll need to rearrange some things so we can
reuse the important code for data and metadata mapping/unmapping, but
doesn't look too bad. I'll get started on that.

