Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B80AC83F1A
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 07:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4W+tJ36X69caQLLT5PKmnnniwzFPcUBrjoKuaArnS18=; b=S9YQtt/iHQGzraMETBWnQps413
	FJe+M+nhnVqyfiWNaEy3NH7cu3N2ndrfSmtqgKywrV3P9AZ6QDsQw4O+ki7VYge7nP1kb2kUI6vU6
	xpKbmLJkRchC7wRbo243bxaI3BJ79RHKrO999HlYLpOFuIFQ2KKhlf4lW8tKPHmVtjQPSP8x1pFh1
	JUvRoypN3mvmjW1ckch4VUKQezyP8jJH22sYHQKc7s8irN+SGP1UZQpZ155vnv3tqQg3Rnl+tBJKO
	i1SzKQPQPXSC5ft9L5dm6BTI1IINuR2A5lefyzJQw3sdb1E5Fu+mcnlgp8/9QsYhloBrQeMapt4a9
	epYtAJww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udl9T-0000000GWFK-2dlI;
	Mon, 21 Jul 2025 07:41:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udl5H-0000000GVWV-1smK
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 07:37:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D35D068B05; Mon, 21 Jul 2025 09:37:10 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:37:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/7] blk-mq-dma: move the bio and bvec_iter to
 blk_dma_iter
Message-ID: <20250721073710.GA32034@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_003715_631793_733F64AA 
X-CRM114-Status: GOOD (  11.16  )
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

On Sun, Jul 20, 2025 at 11:40:34AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The req_iterator just happens to have a similar fields to what the dma
> iterator needs, but we're not necessarily iterating a bio_vec here. Have
> the dma iterator define its private fields directly. It also helps to
> remove eyesores like "iter->iter.iter".

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


