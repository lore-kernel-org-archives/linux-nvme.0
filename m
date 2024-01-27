Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE56C46CD2
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 18:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X6dqNNaFcBPAuUj/Qb7BL8mzsncc4vwb10YQ9AHh2wU=; b=Ts470ero1Sttdo6d2JudfkRnNc
	3jiD2NtzF3JJokatyvjNnEk5GXqlWLsGrYoZqfTROQ44BD/Sct/boO2lC4OvNgWHYJdE3EoutYWMg
	nZs5KTiGtVa8P39pV99Xf4tgMEIx8TxRInUFKX1JTXzOMK+MgzXQSlBtK7BZuLm/hPfbhTYHjrb12
	Tbmt4s5QxhomuYpTSm4l6i2WXhipdJS2Z06kSUSZM4IlNaoxX6B7uOc7oYBX92iSLO6Fc+imfpcbA
	5mMyNN3v36Qvo8WWlC6YzMwDFdAgogNMrNNAYGriTlkhygi/vubjvTCM2HyHwlMpls8xbgMm5LfBx
	rqQCfrLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTneX-000000080ce-1VVB;
	Sat, 27 Jan 2024 18:43:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTneV-000000080cS-0uQ7
	for linux-nvme@bombadil.infradead.org;
	Sat, 27 Jan 2024 18:43:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X6dqNNaFcBPAuUj/Qb7BL8mzsncc4vwb10YQ9AHh2wU=; b=lELbwOzzp1TR91on867emJBA1d
	avobqrdJ8X7yB9badToi0BoMO96MowyanbyF5LaeRj65WWbJbwni699zGz/2EG8LVzbhIQIZQHJ66
	ZEOhKelSRC9LdHVTE/Qv/LzJsoEhFTcX3pSrMMHV8vraAYReK0RhQVbAp5wv1iF7LCp+D3iQ4GZ6F
	Ik//ZLI7LL9Eqh3cUFXOhbEM55uQij82k1lfPkCdZw/SJhA7C1ITmkWtfCxI+Q9bSGz2z1LBaiTsZ
	NUS3eWu46fYn809l7rTxCMLJvNvauvvXIIPMCbg/oSIskf8I7CYTgvFKUE4YX58ztH/r9QBdsy2gv
	QxiM558g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTneT-00000000400-0bqE;
	Sat, 27 Jan 2024 18:43:37 +0000
Date: Sat, 27 Jan 2024 18:43:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <ZbVO2RKhw-dLUMvf@casper.infradead.org>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
 <yrswihigbp46vlyxqvi3io5pfngcivfwfb3gdlnjs6tzntldbx@mbnrycaujxb3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yrswihigbp46vlyxqvi3io5pfngcivfwfb3gdlnjs6tzntldbx@mbnrycaujxb3>
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

On Sat, Jan 27, 2024 at 12:57:45PM -0500, Kent Overstreet wrote:
> On Fri, Jan 19, 2024 at 04:24:29PM +0000, Matthew Wilcox wrote:
> >  - What are we going to do about bio_vecs?
> 
> For bios and biovecs, I think it's important to keep in mind the
> distinction between the code that owns and submits the bio, and the
> consumer underneath.
> 
> The code underneath could just as easily work with pfns, and the code
> above got those pages from somewhere else, so it doesn't _need_ the bio
> for access to those pages/folios (it would be a lot of refactoring
> though).
> 
> But I've been thinking about going in a different direction - what if we
> unified iov_iter and bio? We've got ~3 different scatter-gather types
> that an IO passes through down the stack, and it would be lovely if we
> could get it down to just one; e.g. for DIO, pinning pages right at the
> copy_from_user boundary.

Yes, but ...

One of the things that Xen can do and Linux can't is I/O to/from memory
that doesn't have an associated struct page.  We have all kinds of hacks
in place to get around that right now, and I'd like to remove those.

Since we want that kind of memory (lets take, eg, GPU memory as an
example) to be mappable to userspace, and we want to be able to do DIO
to that memory, that points us to using a non-page-based structure right
from the start.  Yes, if it happens to be backed by pages we need to 'pin'
them in some way (I'd like to get away from per-page or even per-folio
pinning, but we'll see about that), but the data structure that we use
to represent that memory as it moves through the I/O subsystem needs to
be physical address based.

So my 40,000 foot view is that we do something like get_user_phyrs()
at the start of DIO, pas the phyr to the filesystem; the filesystem then
passes one or more phyrs to the block layer, the block layer gives the
phyrs to the driver which DMA maps the phyr.

Yes, the IO completion path (for buffered IO) needs to figure out which
folios are decsribed by this phyr, but that's a phys_to_folio() call away.

