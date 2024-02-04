Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270AAC48292
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Feb 2024 21:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oUPc0T9g01EBpJOFoKdeHugi9gR06zfpezwQo4Xu2qY=; b=vnPQEkPXjpECcFmcpgq6Jr6jv2
	hCgZSoG3dieqArVJ4XpnCpkz5W7bnwD+7DDFq5MYhbEd2kAk/bEildW3W0uEgvuo2TXrATgRN6YRp
	GQT7+0I991gohkWnj10D+VjoPKHrAqf8aPr15ZdSODl6gj7Uo0jUDgeWQmkzhQ3bzcD6h59XyF4pq
	fcLYlQYyCCrtiSpQXryPRcA285Anmz1irEn+fJ2K3KVTUGl8E31ibu1Fi9qI5pB7P5r+n6l7yW8aL
	5Da8aq1UCv4E1HJ/ed5GmgMoM+1Feyl8kkumf6In0VsAGxqo3WtlXAM+pEQLpde+zCg536Z5WZxML
	r3FCVwnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWk7p-00000001U5a-1VOQ;
	Sun, 04 Feb 2024 21:34:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWk7o-00000001U5O-0kGj
	for linux-nvme@bombadil.infradead.org;
	Sun, 04 Feb 2024 21:34:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oUPc0T9g01EBpJOFoKdeHugi9gR06zfpezwQo4Xu2qY=; b=kjlY18EMquQO4rPsntbj3dj6j9
	N1MmlpTUgmNoPzoUvDd3yGgPhXrBQRJwzwP9CxdAQiv7He8LE68yVAwI0Ei7Njjzmr82gTLKKf8Pj
	OhHhUhmf64OYQIYOD9kQjgngDF2oZqlaFY9KIpl6FzJxtDqbkVND2v1/fSWqDSviYl0TAfWR7vr4+
	MdfTEJIheGzRRQTlMu7dALld7MDz2YZvG5gf2oUm8746PYZm3GwxQfsR0z6xFR0QWxUPKUBPydhlN
	qhT+IXfYIR/q13gE/7DFyxuWDFTtEL4Twt6TiMLpUpn6hGz/oAXBB/WzDAjUs4QcoctYYWO0YXsGr
	q6jzPD5g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWk7l-00000007dDv-24V5;
	Sun, 04 Feb 2024 21:34:01 +0000
Date: Sun, 4 Feb 2024 21:34:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Message-ID: <ZcACya-MJr_fNRSH@casper.infradead.org>
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
 <Zb9pZTmyb0lPMQs8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb9pZTmyb0lPMQs8@kernel.org>
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

On Sun, Feb 04, 2024 at 11:39:33AM +0100, Mike Rapoport wrote:
> On Mon, Jan 29, 2024 at 04:32:03AM +0000, Matthew Wilcox wrote:
> > Our documentation of the current page flags is ... not great.  I think
> > I can improve it for the page cache side of things; I understand the
> > meanings of locked, writeback, uptodate, dirty, head, waiters, slab,
> > mlocked, mappedtodisk, error, hwpoison, readahead, anon_exclusive,
> > has_hwpoisoned, hugetlb and large_remappable.
> > 
> > Where I'm a lot more shaky is the meaning of the more "real MM" flags,
> > like active, referenced, lru, workingset, reserved, reclaim, swapbacked,
> > unevictable, young, idle, swapcache, isolated, and reported.
> > 
> > Perhaps we could have an MM session where we try to explain slowly and
> > carefully to each other what all these flags actually mean, talk about
> > what combinations of them make sense, how we might eliminate some of
> > them to make more space in the flags word, and what all this looks like
> > in a memdesc world.
> > 
> > And maybe we can get some documentation written about it!  Not trying
> > to nerd snipe Jon into attending this session, but if he did ...
> 
> I suspect Jon will be there anyway, but not sure he'd be willing to do the
> writing :)
> 
> I was going to propose the "mm docs" session again, but this one seems more
> useful than talking yet again about how hard it is to get MM documentation
> done.

I'm doing my best to write documentation as I go.  I think we're a bit
better off than we were last year.  Do we have scripts to tell us which
public functions (ie EXPORT_SYMBOL and static inline functions in header
files) have kernel-doc?  And could we run them against kernels from, say,
April 2023, 2022, 2021, 2020, 2019 (and in two months against April 2024)
and see how we're doing in terms of percentage undocumented functions?

There's also the problem of getting long-form documentation done.
But I think that's a different problem from getting kernel-doc written.
Looking at the 55 commits in the last year to Documentation/mm, we seems
to be doing a pretty good job of keeping the documentation we have up
to date.  Just not a great job of adding new documentation.

