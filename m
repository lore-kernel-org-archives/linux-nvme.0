Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65395C83F03
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 16:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fdwQ7VoCdy9EDfz8qdHjHeqLPa9H8WWCarPWLj8vDE4=; b=pE4L0Onsz8AoxJDdrh6glPCUyg
	rE4dvwPdIRBV+B5N+zy6uGSoipgpGXyC9CS47QN64X3tZ4lgSG68yt2RBjbhWwRvGVEG8ULBYLkEK
	Shxffp9wX269EyB8gOpb+2uS/0JA+dTuvkEoQpDURz7Iaizjc99h2rRf2/kPrxTWIUVu2eDPJYn3o
	nI+lGwExB5iQqquqBh7jNz3mpEr7xlAB0+kAvUvy/hh4UKWomPQenNgyAIPNBFWOjGVJX5pfMxC+D
	0JOXWFAH3ncUfGEvvsI1B+FrGzfOnL+QxbTa5W0oVGc0wBsbo0eRbeBtyh3Se2r1/K/vlsgb/uMyS
	DE2M/Xjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXMwq-0000000C18f-09b0;
	Thu, 03 Jul 2025 16:38:08 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXKql-0000000BeR1-44Zb;
	Thu, 03 Jul 2025 14:23:43 +0000
Date: Thu, 3 Jul 2025 07:23:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, David Wei <dw@davidwei.uk>,
	Vishal Verma <vishal1.verma@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC 00/12] io_uring dmabuf read/write support
Message-ID: <aGaSb5rpLD9uc1IK@infradead.org>
References: <cover.1751035820.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751035820.git.asml.silence@gmail.com>
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

[Note: it would be really useful to Cc all relevant maintainers]

On Fri, Jun 27, 2025 at 04:10:27PM +0100, Pavel Begunkov wrote:
> This series implements it for read/write io_uring requests. The uAPI
> looks similar to normal registered buffers, the user will need to
> register a dmabuf in io_uring first and then use it as any other
> registered buffer. On registration the user also specifies a file
> to map the dmabuf for.

Just commenting from the in-kernel POV here, where the interface
feels wrong.

You can't just expose 'the DMA device' up file operations, because
there can be and often is more than one.  Similarly stuffing a
dma_addr_t into an iovec is rather dangerous.

The model that should work much better is to have file operations
to attach to / detach from a dma_buf, and then have an iter that
specifies a dmabuf and offsets into.  That way the code behind the
file operations can forward the attachment to all the needed
devices (including more/less while it remains attached to the file)
and can pick the right dma address for each device.

I also remember some discussion that new dma-buf importers should
use the dynamic imported model for long-term imports, but as I'm
everything but an expert in that area I'll let the dma-buf folks
speak.


