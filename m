Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F8DCA0EFA
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 03:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vouc/RnOn1OR1o/ff5mjM7Yg2TfneybwsfyI/BiiIXk=; b=2nY9AtWi+loOSiRTbhAlUsaW4d
	xju8Whj4S0i1hI5AwSKbwX5sFcF7Ykkk4r1wnUs7/8g9oKiQzvTKzpRRQrHfStlccyweZm3VtTgwr
	1jsbFGJNs3hy/Ux4bk6oM5wiCYENpOHXIZ/cp8NysBUxya/1vjtNx5Xt2AGb+43fKvlGNkmNusdww
	GShg1n+L4bhALFK5ch1V5/1zFYNnS8LYm11U6E97fBoXHBl7OmG/xpAZ+nX/0pzuaQLR+pFDHgtAf
	7Ik5724EP128GflkADEaLKhRQ92Xe5IBiZPeIL9d7ByNZ0TaE6TMuQuW1/3R4VFLQRifaCoBKI6cV
	rGFngzuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uowE7-0000000FhfJ-1q6Z;
	Thu, 21 Aug 2025 03:44:35 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoSTS-0000000BUIa-42uW
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 19:58:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1DCD345455;
	Tue, 19 Aug 2025 19:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D9EC4CEF1;
	Tue, 19 Aug 2025 19:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755633506;
	bh=nA9A0H3LrJ78fHP6AI7J40nKWuK6fskQEP9rQ9tJOXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3cV0SxjdjsbyAxLQAHXL9YQoVkd3oE/w0tg8f+/28wYPFIcCuOtf+n31sKJ+LyN1
	 6N7biz9o/yCuPtFBnn8ELyTNlP5RA151eN7wKi8pNSNB92o83ezmb7znz1ImNM7cWr
	 xClDJ2+EAIi/fyYTQNzUsM/2eAKArOgzFRoBwUKtf83SqZF5p6itYTMDZFBizPzyOj
	 cmndtkVjtFJFxZFPGtELV1/fpgrqmBEwX35+EsRatiowr0CXr7OcQuw39qyPoRCSeg
	 uQXDSW9Z/GPeI4IjUnpByoqXUrISGom24QKuNeZMIoK+/Modr6dLR2faOTSocU7qPz
	 FiaHtir3WFZ4Q==
Date: Tue, 19 Aug 2025 13:58:22 -0600
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
Subject: Re: [PATCH v4 16/16] nvme-pci: unmap MMIO pages with appropriate
 interface
Message-ID: <aKTXXv7kE0pGGn_8@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <545fffb8c364f36102919a5a1d57137731409f3c.1755624249.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <545fffb8c364f36102919a5a1d57137731409f3c.1755624249.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_125827_018902_B230755D 
X-CRM114-Status: GOOD (  10.20  )
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

On Tue, Aug 19, 2025 at 08:37:00PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Block layer maps MMIO memory through dma_map_phys() interface
> with help of DMA_ATTR_MMIO attribute. There is a need to unmap
> that memory with the appropriate unmap function, something which
> wasn't possible before adding new REQ attribute to block layer in
> previous patch.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

