Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B02C87FCB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 14:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EUdqfmdZHtM83qnoVWI7yM5/PTc5KV7PRGFJ/JFMKvk=; b=TaxssiHQuuEpQeKZHw/7cyPVMg
	/unPSuF5T3iKDWFDVM1zxeXv3N4kzFvI4o/RVijf2mFNf+hKi8vLW805OBtmHJhMnEPir9ebB1K2+
	CNZnDIu+zpT0PQcXYzizqbNbV0KrkFRUJqV1RsP0fe22w/voIpd3sp6Zw+xpNMYEYjS0FbW+jan6e
	UP8lNGaj/e9Q9KWXBFUOiiX5SN12BsF/OhPzYWpnhH/eYXSpgsoP3oZm/3y7+pcgm+ODFtVHXmFFf
	VrARH47UYrPhsquowyZP4C3nCVRV6nzL/5dGnylbp3PZ4JL34qKLvBQeHO4EYgCBnDHe/4Vk5grBh
	lhgiiOMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh7gC-00000001ivs-1wx7;
	Wed, 30 Jul 2025 14:21:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh7dX-00000001iX0-0OPA
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 14:18:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 304DE6113A;
	Wed, 30 Jul 2025 14:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C90C4CEE3;
	Wed, 30 Jul 2025 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753885109;
	bh=5QG/cxwfN36EtLhLypaOb64DY9SBJPkXgy9O7I/pmU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUyG+PxCK7rXERFWp8Qs+h68JBAUb9gurZ52iqE26peUYzk4MKbt4owEdJqVsTFWv
	 OwIVtJ/HE0E9xzjUa5b9qRn7oGlQSbVebo9PFEUvetcMKc0iNE1iwdFBYZfhP3g/5d
	 W363sMgoRUevsds5lWlJXKghTgsqyQ75Kk0tLFT0unhOv4XN6mJnPpdxcnYT84DAwe
	 3MpeZdW/cRHdYN3m2Qlgu1xoLKwj0pfdufYx7fs5uZ13qogiH+3WGWvL2AyEaFayQb
	 yctoPwEfeGgJRXm0arZyw5zme7+E0FCoJIufJgpKtELogQcgEviVtM+UA1y+uqlvzT
	 XuXyyhJlsjyaQ==
Date: Wed, 30 Jul 2025 08:18:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
	leonro@nvidia.com
Subject: Re: [PATCHv3 2/7] blk-mq-dma: provide the bio_vec list being iterated
Message-ID: <aIopsymJJaQ0AAZC@kbusch-mbp>
References: <20250729143442.2586575-1-kbusch@meta.com>
 <CGME20250729143610epcas5p12a897510ef6da6563d32c7a41ed21659@epcas5p1.samsung.com>
 <20250729143442.2586575-3-kbusch@meta.com>
 <8a4e7512-a997-4ff1-b465-2597bc6fa778@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4e7512-a997-4ff1-b465-2597bc6fa778@samsung.com>
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

On Wed, Jul 30, 2025 at 05:45:27PM +0530, Kanchan Joshi wrote:
> On 7/29/2025 8:04 PM, Keith Busch wrote:
> > @@ -151,6 +146,11 @@ bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
> >   	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
> >   	iter->status = BLK_STS_OK;
> >   
> > +	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
> > +		iter->iter.bvec = &req->special_vec;
> 
> I am not certain yet, but thinking whether this is enough to handle 
> RQF_SPECIAL_PAYLOAD correctly.
> Maybe "req->special_vec.bv_len" also need to be included here to 
> initialize the iter.

Yeah, I think you're right. I had only tested 'discard' for the special
payload, and it appeared to be okay, but I suspect for the wrong
reasons. I'll fix it up.

