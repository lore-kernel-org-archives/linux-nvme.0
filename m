Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873FBC47DAF
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jan 2024 23:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jA3IbLFtzAloHVLQrh6taOQq0+ILF1OF3dZLSLc3Sz8=; b=3586DtBAOfjvuZBzPd8S0uBDeM
	PJCn3vwH/Gmp3d7Y6pN4TYZpxHMC+lsQGh9p21Tb22TBzHEQG/+xHqx/cyBO+bqMHBpfSeZd3nBBW
	DGO/E5PJ22zJdPxP177t9rpc4vusbpuyA2p8F13XrEOFxwoC0rq0WqT5/N46pwPJoTnswZ9wgf9vQ
	/LojurYDgbl2FfH6BAba6jLjM2bpwuN/Rtraydz2qxUOMhanW+PpHfFi7mcJ4So6NYqVL3AkyTCT6
	6JnpA5K8/0RVvVo6dlsZ7w+ztlQC0BlR76zc95BYqR623HPWDLPc5KGZ2XZqSzzpyhOlvf8vnvSky
	EjOLVW4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRhdu-00ADZN-39;
	Sun, 21 Jan 2024 23:54:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRhdt-00ADYs-11
	for linux-nvme@bombadil.infradead.org;
	Sun, 21 Jan 2024 23:54:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=jA3IbLFtzAloHVLQrh6taOQq0+ILF1OF3dZLSLc3Sz8=; b=KlrlxiuDarLqJ8jOpV7msSXun3
	trX9vXalyMaMMqKa2fQXZnVPNXv71jjxs1wuHC3UyXAstE5rS6j9lhGOwaPnqcMuiMVrkVLFuWb8x
	6g6muDT0XpImvGHL7zZGiqTe5JfZMV8xl75Brz48rpGm2DO4tmo9qPflaSBNvzUXhpx98HiizJYIV
	hBUV3a1cKFLUQjS/WjUBCJR+eZpUrkUbAafe86MAWfizAkSphOagTE2mlabwZLUv+FJRURa8him/p
	j4A4YZwwVoBHvs8KVL8oHzwbqBPsUhfqk5dYNf+rYss+SPQ0dlxN46jdTQyFzjy0kPRuBI0M5DK/c
	XQlxijgw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRhdr-0000000ENNn-2P5G;
	Sun, 21 Jan 2024 23:54:19 +0000
Date: Sun, 21 Jan 2024 23:54:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: David Rientjes <rientjes@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Sourav Panda <souravpanda@google.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <Za2uq2L7_IU8RQWU@casper.infradead.org>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
 <b04b65df-b25f-4457-8952-018dd4479651@google.com>
 <Za2lS-jG1s-HCqbx@casper.infradead.org>
 <CA+CK2bCAPWhCd37X8syz9fHYSv_pQ0-k+khgXZc1uCPRBnFaWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCAPWhCd37X8syz9fHYSv_pQ0-k+khgXZc1uCPRBnFaWQ@mail.gmail.com>
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

On Sun, Jan 21, 2024 at 06:31:48PM -0500, Pasha Tatashin wrote:
> On Sun, Jan 21, 2024 at 6:14 PM Matthew Wilcox <willy@infradead.org> wrote:
> > I can add a proposal for a topic on both the PCP and Buddy allocators
> > (I have a series of Thoughts on how the PCP allocator works in a memdesc
> > world that I haven't written down & sent out yet).
> 
> Interesting, given that pcp are mostly allocated by kmalloc and use
> vmalloc for large allocations, how memdesc can be different for them
> compared to regular kmalloc allocations given that they are sub-page?

Oh!  I don't mean the mm/percpu.c allocator.  I mean the pcp allocator
in mm/page_alloc.c.

I don't have any Thoughts on mm/percpu.c at this time.  I'm vaguely
aware that it exists ;-)

> > Thee's so much work to be done!  And it's mostly parallelisable and almost
> > trivial.  It's just largely on the filesystem-page cache interaction, so
> > it's not terribly interesting.  See, for example, the ext2, ext4, gfs2,
> > nilfs2, ufs and ubifs patchsets I've done over the past few releases.
> > I have about half of an ntfs3 patchset ready to send.
> 
> > There's a bunch of work to be done in DRM to switch from pages to folios
> > due to their use of shmem.  You can also grep for 'page->mapping' (because
> > fortunately we aren't too imaginative when it comes to naming variables)
> > and find 270 places that need to be changed.  Some are comments, but
> > those still need to be updated!
> >
> > Anything using lock_page(), get_page(), set_page_dirty(), using
> > &folio->page, any of the functions in mm/folio-compat.c needs auditing.
> > We can make the first three of those work, but they're good indicators
> > that the code needs to be looked at.
> >
> > There is some interesting work to be done, and one of the things I'm
> > thinking hard about right now is how we're doing folio conversions
> > that make sense with today's code, and stop making sense when we get
> > to memdescs.  That doesn't apply to anything interacting with the page
> > cache (because those are folios now and in the future), but it does apply
> > to one spot in ext4 where it allocates memory from slab and attaches a
> > buffer_head to it ...
> 
> There are many more drivers that would need the conversion. For
> example, IOMMU page tables can occupy gigabytes of space, have
> different implementations for AMD, X86, and several ARMs. Conversion
> to memdesc and unifying the IO page table management implementation
> for these platforms would be beneficial.

Understood; there's a lot of code that can benefit from larger
allocations.  I was listing the impediments to shrinking struct page
rather than the places which would most benefit from switching to larger
allocations.  They're complementary to a large extent; you can switch
to compound allocations today and get the benefit later.  And unifying
implementations is always a worthy project.

