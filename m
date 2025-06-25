Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ACAC77B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 22:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JNApo6K1zSCKjJ+CnWvH6J2aKWzueNbdFDxn/05NFLM=; b=WFs4kiQBlFee+DktKippW69DDa
	DwxL3naSDjqlp3OPzTYk+wHT0bMqOeZ8SgfQCxKPVGlKBGAq02DQ5muSikj4kz9cSXMMcokenGvp/
	jB88iCbpq6gQYUkU8YqafMKSGonu50bdGqbhbXpHf7O2YbFJtIn1aY1UlknDOByzAnddVBujvcd1x
	iB3LMmvS0PiZYzZMN+UxirViKpWr7FdF78Vt4mAPq/QjDNCS9EEBXBx4M7dgsIxcscbOhBstDOHbH
	AY/5D374qOCDSNGrH6QoJVaBPf/AZqt7IoKOplE6JUMqbnql8vsJoQCccH4GS3E0jwa1SRQRY63JS
	+6YnI8iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUYvz-0000000A6gO-38KS;
	Wed, 25 Jun 2025 22:49:39 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUYIB-0000000A2KU-3srd
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 22:08:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5BFF7615F0;
	Wed, 25 Jun 2025 22:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB48C4CEEA;
	Wed, 25 Jun 2025 22:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750889311;
	bh=hrN26zPExB9xhNrlf56hKCAr83ckIJt7dJETQYQ3D5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRQgKZH7Feq91S01GrFh/czkQvzbf8hjPEsaqbd3XTwudWJpHFkZ9DbFV7D3IqLiM
	 oG52TaUxvwJ5UujyoqKlY3HebK0X+Fzv6RQdryAXmuDBYRt0L4iiERFuTB8XWCw18W
	 m2pPJwX4v4xnK7g+aVLi73iFLlK8fHjPEGwT0msSP68Nvj3usWJl1zyGXnMjCHsMdJ
	 i+2GCERoGINTv52ubs2xwqH1B2yr+07DS/H++l3YzLqvU4QXZuTxVA1e9Fsm869rRZ
	 heOKuBuE/NnzGJ4XLCslvWKMY4V7tj6EeqnkhyGgKKgxT9KLwO8sSEly+p2Ehsx3wX
	 obL3ZDs3kZ3ug==
Date: Wed, 25 Jun 2025 16:08:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: uring_cmd specific request_queue for SGLs
Message-ID: <aFxzXOZUFtt6hyPA@kbusch-mbp>
References: <20250624211444.2835077-1-kbusch@meta.com>
 <20250625060915.GB9391@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625060915.GB9391@lst.de>
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

On Wed, Jun 25, 2025 at 08:09:15AM +0200, Christoph Hellwig wrote:
> > User space passthrough IO commands are committed to using the SGL
> > transfer types if the device supports it. The virt_boundary_mask is a
> > PRP specific constraint, and this limit causes kernel bounce buffers to
> > be used when a user vector could have been handled directly. Avoiding
> > unnecessary copies is important for uring_cmd usage as this is a high
> > performance interface.
> 
> Not really more high performance than the normal I/O path.

Right, that's why I said "a" performance path, not "the" performance
path.

If you send a readv/writev with a similar iovec to a O_DIRECT block
device, then it will just get split on the gapped virt boundaries but it
still uses it directly without bouncing. We can't split passthrough
requests though, so it'd be preferable to use the iovec in a single
command if the hardware supports it rather than bounce it.
 
> > For devices that support SGL, create a new request_queue that drops the
> > virt_boundary_mask so that vectored user requests can be used with
> > zero-copy performance. Normal read/write will still use the old boundary
> > mask, as we can't be sure if forcing all IO to use SGL over PRP won't
> > cause unexpected regressions for some devices.
> 
> Note that this directly conflict with the new DMA API.  There we do
> rely on the virt boundary to gurantee that the IOMMU path can always
> coalesce the entire request into a single IOVA mapping.  We could still
> do it for the direct mapping path, where it makes a difference, but
> we really should do that everywhere, i.e. revist the default
> sgl_threshold and see if we could reduce it to 2 * PAGE_SIZE or so
> so that we'd only use PRPs for the simple path where we can trivially
> do the virt_boundary check right in NVMe.

Sure, that sounds okay if you mean 2 * NVME_CTRL_PAGE_SIZE.

It looks straight forward to add merging while we iterate for the direct
mapping result if it returns mergable iova's, but I think we'd have to
commit to using SGL over PRP for everything but the simple case, and
drop the PRP imposed virt boundary. The downside might be we'd lose that
iova pre-allocation optimization (dma_iova_try_alloc) you have going on,
but I'm not sure how important that is. Could the direct mapping get too
fragmented to consistently produce contiguous iova's in this path?

