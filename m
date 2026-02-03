Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82C2E87852
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 18:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pIcttgH3cFmMWPGAjuYggeDdg1wKRtuQu6GRht+70Pg=; b=RGitl4bhuEhQMOtrEEx8eMBnjt
	0x3fbAbufYrplP3tm6d3PATnqHSxUGZz4Bl8Y8WfUwzxq0314v2Kg7Q+ZHLb/sh9A3AgYSgF4suHF
	Vv4FBnbzmf/mRqHQbPxJFE/AX8he/ITE0AuR3NKa35qGaNW2dO8ek/LBWsx2nP2o1vZGHmllBxj3z
	czQ73B2Irh6YC2+sBNuONavLrxPvjPBeTSJhROzSYVSVuHBdjRIzSHAAH9Rzvl+CUz2Ksztcl4GAW
	/m95FSIl/eMkkyLw9xNLet332s4mVnbFkmvyBuZig+ZNzdmUq+fmpwxzjEsTBy0Rb4Tj0fWE9VgdS
	c0cpVhVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnKnw-000000076Mx-2cNh;
	Tue, 03 Feb 2026 18:07:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnKnu-000000076Mr-45xw
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 18:07:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0B3FE60143;
	Tue,  3 Feb 2026 18:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4323CC116D0;
	Tue,  3 Feb 2026 18:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770142029;
	bh=zZNSaOg7sCN6Wojly0qzoKQIULU4ACMlUo6Dk+c6PKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jET5Dnse80GSDsB+ZN5uKMph0RrRLcxUMzjhoRu1mBsHicvxPy4ivu+303bQI+Z7o
	 Djg5t0SqqsmDXsi02MFpzJhz2r3oNXQka/26pqn9RxTFXI7niFWnz5ussVjDpMHZqc
	 Z9rJz6mO+6Es3gXWgr3uak29jxK3I/ip3WdZ5BUq3a4106YvJidDsMoDhQB6PiJwuE
	 WVXq3woGFmdJyZttAu55Qsg+G1ebC2BtK89+Vre6PthwW86l3stcj+IeYnduCnKO1F
	 /caT+jF1SHzVuJhBAw43oek+IuqjC8bpKmZf1O5EGlCUQ9hag7ySEinp1teEZpNk15
	 nw+EVkQuEiXog==
Date: Tue, 3 Feb 2026 11:07:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Gohad, Tushar" <tushar.gohad@intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
Message-ID: <aYI5S1puAZ-rPvlC@kbusch-mbp>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
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

On Tue, Feb 03, 2026 at 02:29:55PM +0000, Pavel Begunkov wrote:
> Good day everyone,
> 
> dma-buf is a powerful abstraction for managing buffers and DMA mappings,
> and there is growing interest in extending it to the read/write path to
> enable device-to-device transfers without bouncing data through system
> memory. I was encouraged to submit it to LSF/MM/BPF as that might be
> useful to mull over details and what capabilities and features people
> may need.
> 
> The proposal consists of two parts. The first is a small in-kernel
> framework that allows a dma-buf to be registered against a given file
> and returns an object representing a DMA mapping. The actual mapping
> creation is delegated to the target subsystem (e.g. NVMe). This
> abstraction centralises request accounting, mapping management, dynamic
> recreation, etc. The resulting mapping object is passed through the I/O
> stack via a new iov_iter type.
> 
> As for the user API, a dma-buf is installed as an io_uring registered
> buffer for a specific file. Once registered, the buffer can be used by
> read / write io_uring requests as normal. io_uring will enforce that the
> buffer is only used with "compatible files", which is for now restricted
> to the target registration file, but will be expanded in the future.
> Notably, io_uring is a consumer of the framework rather than a
> dependency, and the infrastructure can be reused.
> 
> It took a couple of iterations on the list to get it to the current
> design, v2 of the series can be looked up at [1], which implements the
> infrastructure and initial wiring for NVMe. It slightly diverges from
> the description above, as some of the framework bits are block specific,
> and I'll be working on refining that and simplifying some of the
> interfaces for v3. A good chunk of block handling is based on prior work
> from Keith that was pre DMA mapping buffers [2].
> 
> Tushar was helping and mention he got good numbers for P2P transfers
> compared to bouncing it via RAM. Anuj, Kanchan and Nitesh also
> previously reported encouraging results for system memory backed
> dma-buf for optimising IOMMU overhead, quoting Anuj:
> 
> - STRICT: before = 570 KIOPS, after = 5.01 MIOPS
> - LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
> - PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

Thanks for submitting the topic. The performance wins look great, but
I'm a little surpised passthrough didn't show any difference. We're
still skipping a bit of transformations with the dmabuf compared to not
having it, so maybe it's just a matter of crafting the right benchmark
to show the benefit.

Anyway, I look forward to the next version of this feature. I promise to
have more cycles to review and test the v3.

