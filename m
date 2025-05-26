Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36682C54FB3
	for <linux-nvme@archiver.kernel.org>; Mon, 26 May 2025 05:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PQheV16VevNN/q0/UOqEHhyv6Hi0ZcDs9WhRLgTvdq0=; b=vTv65WwV0O67a3K/6JUreWpkMX
	Fy5gNDGDLuv1u3FEb+hmDCqNTI9UhBhRHGK8BtAmT+LIxYWQunzxns5rNHrYH8rCsH5RQ9l0NkQvA
	eXMQ4DyaQNn0Y+RtCh8cbikGQlwCfbRp+Wieoe6sGWvoUKF4BeflFa21izWD8HZMKGuBrVChZRyf5
	jS849x7dalY+8f0C4RZn5HsQ2tOl9FrdkC3a/1SO2uAXEVt3xKiqxHjOBioa2+V6m+vpSUXnupBZS
	vyvjVvdAM92eM9gxLJmSkWvoifvsLGtSwkwtZ8RZgsP3coOOM8XiEXX7s8UUGN0nBhM3qw1dNi4vO
	HmBxCVVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJQIN-00000008676-3CzV;
	Mon, 26 May 2025 05:22:43 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJQIL-0000000866Z-3b6d;
	Mon, 26 May 2025 05:22:41 +0000
Date: Sun, 25 May 2025 22:22:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] block: add support for copy offload
Message-ID: <aDP6ocJef8JBfFBc@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-3-kbusch@meta.com>
 <aDBuQbsBRVjOc5wU@infradead.org>
 <aDB3lSQRLxjDHTSE@kbusch-mbp>
 <aDB6Hdp9ZQ1gX5gr@infradead.org>
 <aDB8xmc3Up0STRVO@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDB8xmc3Up0STRVO@kbusch-mbp>
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

On Fri, May 23, 2025 at 07:48:54AM -0600, Keith Busch wrote:
> I like that idea.
>  
> >  - bio_add_copy_src not updating bi_size is unexpected and annoying :)
> 
> Ha, I currently have the submitter responsible for bi_size. Your
> suggestion will make this easier to use.

Another thing about bio_add_copy_src:  currently it gets passes a
bio_vec, which doesn't really help it's own implementation much, and
actually makes the callers more cumbersome.  I'd pass the sector and
number of sectors (or maybe byte length to be closer to the other block
x`interfaces?) as separate scalar arguments instead.  For both current
callers of blkdev_copy_range and iterative interface where they build
up the range without having to allocate the bvec array would simply
the code.


