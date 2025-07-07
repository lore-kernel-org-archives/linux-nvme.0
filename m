Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B251C8303C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sTDalUrNw2z9g3DokIxyhkW5+/gPhyhfQxHkWbiU65A=; b=N0IIRffFs2DdE96j41tyCHE/1P
	8XW15Q9wZOftD1DztQAQ7wTwyqkicBTXdU9nv9WuVib7Pyu6qJJzPhUm6ig6WKUseqhSl3Unk8zed
	CxZt4rMvQWYjTgNHUMekkXeYQI1XLXsL5YtM//+pRw63qzcutNoI6evGMyzcsyqjydqCMXaI5no0z
	B4P2QR9yFOZSuzQJsTsekO9k1A1TUFAIDHKsU/Ise0y+4mqCTwDG4aBN4tpxbizNj0PHP8B3kMmai
	oxiB9N0yFcVP6GpkdGgzQkTBR1LydUSax7CjNmkagECifyhEGCCs9FktnWY1cCfyIlghDohY+rRC+
	ctIvR7kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYnBP-00000002lWI-41ET;
	Mon, 07 Jul 2025 14:51:03 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYn8g-00000002kzX-3wAk;
	Mon, 07 Jul 2025 14:48:14 +0000
Date: Mon, 7 Jul 2025 07:48:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>, Vishal Verma <vishal1.verma@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC 00/12] io_uring dmabuf read/write support
Message-ID: <aGveLlLDcsyCBKuU@infradead.org>
References: <cover.1751035820.git.asml.silence@gmail.com>
 <aGaSb5rpLD9uc1IK@infradead.org>
 <f2216c30-6540-4b1a-b798-d9a3f83547b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2216c30-6540-4b1a-b798-d9a3f83547b2@gmail.com>
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

On Mon, Jul 07, 2025 at 12:15:54PM +0100, Pavel Begunkov wrote:
> > to attach to / detach from a dma_buf, and then have an iter that
> > specifies a dmabuf and offsets into.  That way the code behind the
> > file operations can forward the attachment to all the needed
> > devices (including more/less while it remains attached to the file)
> > and can pick the right dma address for each device.
> 
> By "iter that specifies a dmabuf" do you mean an opaque file-specific
> structure allocated inside the new fop?

I mean a reference the actual dma_buf (probably indirect through the file
* for it, but listen to the dma_buf experts for that and not me).

> Akin to what Keith proposed back
> then. That sounds good and has more potential for various optimisations.
> My concern would be growing struct iov_iter by an extra pointer:

> struct iov_iter {
> 	union {
> 		struct iovec *iov;
> 		struct dma_seg *dmav;
> 		...
> 	};
> 	void *dma_token;	
> };
> 
> But maybe that's fine. It's 40B -> 48B,

Alternatively we could the union point to a struct that has the dma buf
pointer and a variable length array of dma_segs. Not sure if that would
create a mess in the callers, though.

> and it'll get back to
> 40 when / if xarray_start / ITER_XARRAY is removed.

Would it?  At least for 64-bit architectures nr_segs is the same size.


