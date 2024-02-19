Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BBEC48BC3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 20:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jchb+LZCv2qEJtD+Rt9qzwfdoWc+U+2jiOKWjU4NWow=; b=r8f77nUVPgCcOQaY23dTWKQmhj
	LvLPxGYVBDD1ShydMZZgj6D3FlLUX7ukR4x8ZJWLX4AEjm3tXb4w3gUmGW7cPgCh7ba3QFm7Bd9+W
	vuOEEzPJgzuqPzgMWY9RZTanJqTc4FF17UQno9LV3e3ofAsrVS4jzDNbsakv3OGNpwmvsNKl/jvCJ
	eK1RUG3a46aR8Qjvh9PWrzFOSwKZTshBPNb+0njRG9XQMXI3TA+oxtJpHUve0N0qoFqRyRFAl6m06
	tG8e58LGUxx2lJB/4xAYMMHC9ezxgy1Uwio3CYnI9GbI6MWgH4yc+OstqiryUnM1X+LOxu5llsc0R
	zeng+jDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcA1M-0000000C2sJ-45Ev;
	Mon, 19 Feb 2024 20:13:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcA1L-0000000C2rA-1QLY
	for linux-nvme@bombadil.infradead.org;
	Mon, 19 Feb 2024 20:13:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jchb+LZCv2qEJtD+Rt9qzwfdoWc+U+2jiOKWjU4NWow=; b=J3w1tZlHo7drwooqkjX3y5SPfH
	elaMwmvPoX1hmpg+4MB+cvamg309guKr/Ij2Y6t81FG4QQUXolrnW9AUb0SOp3+MK6Ie3VVQP3a+B
	4qZ90X44sLH/lAnfmD3eeelqIMhkJOgeoLSevHh91GjJ5TmJfsDTNFaAKSCd23L28KzNUXaDcUunY
	HPTk5lWwmN0VUSVaPnhMxLoHcMDre1m70lSGojq4FjeyhUPbbSR9IKfD/GuJzTrpogXa4wracCW9z
	ZnjwkrluXe78+suPeKnfQquNV1HZkGZ9jbVhHpsSobEIXAOMuEZZgbrzezqoSfQhfvl4dUmSsYV28
	ZmkmHbGA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcA1I-0000000DgB5-1OL3;
	Mon, 19 Feb 2024 20:13:44 +0000
Date: Mon, 19 Feb 2024 20:13:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Message-ID: <ZdO2eABfGoPNnR07@casper.infradead.org>
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
 <Zb9pZTmyb0lPMQs8@kernel.org>
 <ZcACya-MJr_fNRSH@casper.infradead.org>
 <ZcOnEGyr6y3jei68@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOnEGyr6y3jei68@kernel.org>
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

On Wed, Feb 07, 2024 at 05:51:44PM +0200, Mike Rapoport wrote:
> On Sun, Feb 04, 2024 at 09:34:01PM +0000, Matthew Wilcox wrote:
> > I'm doing my best to write documentation as I go.  I think we're a bit
> > better off than we were last year.  Do we have scripts to tell us which
> > public functions (ie EXPORT_SYMBOL and static inline functions in header
> > files) have kernel-doc?  And could we run them against kernels from, say,
> > April 2023, 2022, 2021, 2020, 2019 (and in two months against April 2024)
> > and see how we're doing in terms of percentage undocumented functions?
> 
> We didn't have such script, but it was easy to compare "grep
> EXPORT_SYMBOL\|static inline" with ".. c:function" in kernel-doc.
> We do improve slowly, but we are still below 50% with kernel-doc for
> EXPORT_SYMBOL functions and slightly above 10% for static inlines.

Thanks for doing this!  Data is good ;-)

I just came across an interesting example of a function which I believe
should NOT have kernel-doc.  But it should have documentation for why it
doesn't have kernel-doc!  Any thoughts about how we might accomplish that?

The example is filemap_range_has_writeback().  It's EXPORT_SYMBOL_GPL()
and it's a helper function for filemap_range_needs_writeback().
filemap_range_needs_writeback() has kernel-doc, but nobody should be
calling filemap_range_has_writeback() directly, so it shouldn't even
exist in the htmldocs.  But we should have a comment on it saying
"Use filemap_range_needs_writeback(), don't use this", in case anyone
discovers it.  And the existance of that comment should be enough to
tell our tools to not flag this as a function that needs kernel-doc.


