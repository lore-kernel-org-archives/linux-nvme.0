Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C53C46CD2
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8FnooJCWSxpBQ7kJMIzkrQtNeGdttnkRA9KqDLumr+o=; b=Dgm0aJeAYb/MRvOAoWM5p1DFHh
	94LjW8XYpk1ZkaYphmHIZBCb82+psz6ulUQEsqTFPvfDmz0lALSSXGun6KfxZA05TLAWZByGgclaH
	Bap05ykRipaxWDs3m0okW/KjvBK9qznfGzENm/o/I1I+EhiLiKpaaiODFWwaGncgQCYsJgcaEzm0G
	5NnInMuWL6cNM4fgwe/yRWKfPfamfEvEoL4wbfXFQ/P0wc29aFgNX8us3jHdm5aMkGjtg0LO+oX/O
	XtEg1rzC+pIYRhPFytSvpFM52w1cn9J+yw8KpWP1mldr5Kj7zPETbavi8TtZgwwFpVvH/6od6pJWO
	ocrWJmKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTmwJ-00000007xds-3LCs;
	Sat, 27 Jan 2024 17:57:59 +0000
Received: from out-181.mta1.migadu.com ([95.215.58.181])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTmwF-00000007xcI-2uiz
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 17:57:58 +0000
Date: Sat, 27 Jan 2024 12:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706378269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8FnooJCWSxpBQ7kJMIzkrQtNeGdttnkRA9KqDLumr+o=;
	b=BPHwnowDbG/6r6CMDf/n/61SkvEjYVDhLgXNOaJA00LRzmXdeRPz07+gcZ+jOsDy6VWYQE
	AYvU1rYFNEjCL6IwxbYd7ffEaJ3JTrWQbcpNjsYzZBHI8QqIdQPkgU10XZ1H+ldxBB0NRt
	bk7XNBThQEMD8l6RHs2aDybHQfjhkys=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <yrswihigbp46vlyxqvi3io5pfngcivfwfb3gdlnjs6tzntldbx@mbnrycaujxb3>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_095756_912102_F261A10F 
X-CRM114-Status: GOOD (  11.42  )
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

On Fri, Jan 19, 2024 at 04:24:29PM +0000, Matthew Wilcox wrote:
>  - What are we going to do about bio_vecs?

For bios and biovecs, I think it's important to keep in mind the
distinction between the code that owns and submits the bio, and the
consumer underneath.

The code underneath could just as easily work with pfns, and the code
above got those pages from somewhere else, so it doesn't _need_ the bio
for access to those pages/folios (it would be a lot of refactoring
though).

But I've been thinking about going in a different direction - what if we
unified iov_iter and bio? We've got ~3 different scatter-gather types
that an IO passes through down the stack, and it would be lovely if we
could get it down to just one; e.g. for DIO, pinning pages right at the
copy_from_user boundary.

