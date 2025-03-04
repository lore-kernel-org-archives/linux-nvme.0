Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30607C282D6
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Mar 2025 18:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cRHPazYps1wq7KJ5C8fXLniBimphIu0da+uuMFbtb3s=; b=MBOY2jqVyF4GARspBMybwuZZg7
	W3n/Ckg/n5ya8z0mDLTS9/ORTVYvnvXjyX6Hvar3YqO8rBEnB6im3aZ6UUBPpxOdP69Ph6nrfImOm
	YfaKSlAOCZ/rpDWC9kmK6QifgLP6RHHp3TSajbQG6GQbm1qh9zO1MraVR/NPH8I+87K+T22BIS6e0
	rPycO/spJ+DAPD0nUivPcxNBlhljmtzU2UAkKAY/9Sk5CaJppD+nI858YOzTJZbKnA5XVnUn+qXgt
	Pfr1m9d+NBUOIdIGkZu4bKr0JPzeKXOcfRLHKRmQ9M4tShhOvCufRIN1sle6qu5xQCktPTwk5z11L
	7HDHEoiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpWjX-00000005mVO-1fhD;
	Tue, 04 Mar 2025 18:11:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpVW6-00000005VPM-46bb
	for linux-nvme@bombadil.infradead.org;
	Tue, 04 Mar 2025 16:53:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cRHPazYps1wq7KJ5C8fXLniBimphIu0da+uuMFbtb3s=; b=wRFv1js6bmgBAOVXTa8oSiVAP+
	4BZzmc0J9YF/co2jTAPij/WtgiOPXAF+05gWyH9g3EOeFWOooEAigwevLkNAbGCwJTcQYKi7OooWG
	MHkv9erbQPJxNPA6bKkBDyPT0HNl6Lj+YwIT7PFP0I5NZ+t7wGjPJ6IgVGjYSrIvLGUp0Lh9gTRu9
	Im4d9aIIE+DtMjKu+ll2pYnm9Rik1RGD7oAhEXe3nr4HZbbOtwxNMrTDn1gVyxXjT6C40tcckihZb
	MhTLCdITMBU+yOqheRkwVs9T+H2yjWs7/abkwVF3kE5GI8w8AlGi4zwK18cWM7M0xSNmF4rVrdH0G
	1RHwCWkg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpVW2-000000029No-3nl4;
	Tue, 04 Mar 2025 16:53:10 +0000
Date: Tue, 4 Mar 2025 16:53:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Kernel oops with 6.14 when enabling TLS
Message-ID: <Z8cv9VKka2KBnBKV@casper.infradead.org>
References: <15be2446-f096-45b9-aaf3-b371a694049d@suse.com>
 <Z8XPYNw4BSAWPAWT@casper.infradead.org>
 <edf65d4e-90f0-4b12-b04f-35e97974a36f@suse.cz>
 <95b0b93b-3b27-4482-8965-01963cc8beb8@suse.cz>
 <fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de>
 <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
 <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
 <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
 <Z8cm5bVJsbskj4kC@casper.infradead.org>
 <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
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

On Tue, Mar 04, 2025 at 05:32:32PM +0100, Hannes Reinecke wrote:
> On 3/4/25 17:14, Matthew Wilcox wrote:
> > I thought we'd done all the work needed to get rid of these pointless
> > refcount bumps.  Turns out that's only on the block side (eg commit
> > e4cc64657bec).  So what does networking need in order to understand
> > that some iovecs do not need to mess with the refcount?
> 
> The network stack needs to get hold of the page while transmission is
> ongoing, as there is potentially rather deep queueing involved,
> requiring several calls to sendmsg() and friends before the page is finally
> transmitted. And maybe some post-processing (checksums,
> digests, you name it), too, all of which require the page to be there.
> 
> It's all so jumbled up ... personally, I would _love_ to do away with
> __iov_iter_get_pages_alloc(). Allocating a page array? Seriously?
> 
> And the problem with that is that it's always takes a page(!) reference,
> completely oblivious to the fact whether you even _can_ take a page
> reference (eg for tail pages); we've hit this problem several times now
> (check for sendpage_ok() ...).

Calling get_page() / put_page() on a tail page is fine -- that just
redirects to the head page.  But calling it on a slab never made any
sense; at best it gets you the equivalent of TYPESAFE_BY_RCU -- that is,
the object can be freed and reallocated, but the underlying slab will
not be reallocated to some other purpose.

> But that's not the real issue; real issue is that the page reference is
> taken down in the very bowels of __iov_iter_get_pages_alloc(), but needs
> to be undone by the _caller_. Who might (or might not) have an idea
> that he needs to drop the reference here.
> That's why there is no straightforward conversion; you need to audit
> each and every caller and try to find out where the page reference (if any)
> is dropped.
> Bah.
> 
> Can't we (at the very least) leave it to the caller of
> __iov_iter_get_pages() to get a page reference (he has access to the page
> array, after all ...)? That would make the interface slightly
> better, and it'll be far more obvious to the caller what needs
> to be done.

Right, that's what happened in the block layer.  We mark the bio with
BIO_PAGE_PINNED if the pincount needs to be dropped.  As a transitional
period, we had BIO_PAGE_REFFED which indicated that the page refcount
needed to be dropped.  Perhaps there's something similar that network
could be doing.

