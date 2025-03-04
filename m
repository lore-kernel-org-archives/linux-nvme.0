Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1950AC282D2
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Mar 2025 17:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pL43Quyb0ICgUXShUhHF7YtI0r/6haqOAOyn/xgv5nc=; b=MYL77U6V4Co40MpUzojJSKUFB0
	C+rzbcZWETfNmfJ6uIidapyT7ca9oETV6wodkqA4IZ2nGKGHZ96gYPOlvKmrKRvkMYLIQPp26AEYq
	kMZFxu94DxQrB20oPBMtSd+8Qi+/cXVgWFwKH6wfsAviubFkDrQ7djzkNF/8xrJUHK4Ru7YJ97z0u
	9qP+gKk3DF7DZkJnjO7kN0bvjPRx4Qs1WclZzG/xjB14u/mgJWHyasO3OSpE5HjYkcPkxdoyrSLTG
	16i8WtMDJie279Kolh1A9GCIlnLVcw88MHE3UuBhkU/bKFElj3ZwPC7FaML976w6zz2QHnn4anYaJ
	8bcUaivw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpWMC-00000005hTg-1ira;
	Tue, 04 Mar 2025 17:47:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpUuf-00000005Nba-0oVn
	for linux-nvme@bombadil.infradead.org;
	Tue, 04 Mar 2025 16:14:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pL43Quyb0ICgUXShUhHF7YtI0r/6haqOAOyn/xgv5nc=; b=ioDwsSDpQ9ByKM98PVFr7qaGNi
	ST5mF0gVx3oPZQTPM8RRnZZYPYhFxl3wf4Hgbb74Siu4a4vSM6QrDDYg5hbNVVvD2YUhnjQHQSRjU
	+qBTBt6+RTbgRd2HTeeiOB526g0wagPsMbvr30E5ehADsnEgtxqK4aS0jx0QnL0fbQbHDPaiwe/cH
	5Q5mo2PH0cYQTIpj0ZUi1FjKqsiz4qD0TC9lxltij7tHfMbcPlXDV/5q1xyAoMaiSlB3KsT5qAHrW
	4TBYXuHmZxYTU57sjC3Cz2/z4B4u6ZQA5New8VCPd9h6mAWZsRGe7ihZ46UaHmXsuQXzo+DTAa2xp
	PvQJsBeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpUub-00000001h5s-2rJd;
	Tue, 04 Mar 2025 16:14:30 +0000
Date: Tue, 4 Mar 2025 16:14:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Hannes Reinecke <hare@suse.com>, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Kernel oops with 6.14 when enabling TLS
Message-ID: <Z8cm5bVJsbskj4kC@casper.infradead.org>
References: <Z8W8OtJYFzr9OQac@casper.infradead.org>
 <Z8W_1l7lCFqMiwXV@casper.infradead.org>
 <15be2446-f096-45b9-aaf3-b371a694049d@suse.com>
 <Z8XPYNw4BSAWPAWT@casper.infradead.org>
 <edf65d4e-90f0-4b12-b04f-35e97974a36f@suse.cz>
 <95b0b93b-3b27-4482-8965-01963cc8beb8@suse.cz>
 <fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de>
 <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
 <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
 <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
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

On Tue, Mar 04, 2025 at 11:26:07AM +0100, Vlastimil Babka wrote:
> +Cc NETWORKING [TLS] maintainers and netdev for input, thanks.
> 
> The full error is here:
> https://lore.kernel.org/all/fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de/
> 
> On 3/4/25 11:20, Hannes Reinecke wrote:
> > On 3/4/25 09:18, Vlastimil Babka wrote:
> >> On 3/4/25 08:58, Hannes Reinecke wrote:
> >>> On 3/3/25 23:02, Vlastimil Babka wrote:
> >>>> Also make sure you have CONFIG_DEBUG_VM please.
> >>>>
> >>> Here you go:
> >>>
> >>> [  134.506802] page: refcount:0 mapcount:0 mapping:0000000000000000
> >>> index:0x0 pfn:0x101ef8
> >>> [  134.509253] head: order:3 mapcount:0 entire_mapcount:0
> >>> nr_pages_mapped:0 pincount:0
> >>> [  134.511594] flags:
> >>> 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
> >>> [  134.513556] page_type: f5(slab)
> >>> [  134.513563] raw: 0017ffffc0000040 ffff888100041b00 ffffea0004a90810
> >>> ffff8881000402f0
> >>> [  134.513568] raw: 0000000000000000 00000000000a000a 00000000f5000000
> >>> 0000000000000000
> >>> [  134.513572] head: 0017ffffc0000040 ffff888100041b00 ffffea0004a90810
> >>> ffff8881000402f0
> >>> [  134.513575] head: 0000000000000000 00000000000a000a 00000000f5000000
> >>> 0000000000000000
> >>> [  134.513579] head: 0017ffffc0000003 ffffea000407be01 ffffffffffffffff
> >>> 0000000000000000
> >>> [  134.513583] head: 0000000000000008 0000000000000000 00000000ffffffff
> >>> 0000000000000000
> >>> [  134.513585] page dumped because: VM_BUG_ON_FOLIO(((unsigned int)
> >>> folio_ref_count(folio) + 127u <= 127u))
> >>> [  134.513615] ------------[ cut here ]------------
> >>> [  134.529822] kernel BUG at ./include/linux/mm.h:1455!
> >> 
> >> Yeah, just as I suspected, folio_get() says the refcount is 0.

... and it has a page_type of f5 (slab)

> >>> [  134.554509] Call Trace:
> >>> [  134.580282]  iov_iter_get_pages2+0x19/0x30
> >> 
> >> Presumably that's __iov_iter_get_pages_alloc() doing get_page() either in
> >> the " if (iov_iter_is_bvec(i)) " branch or via iter_folioq_get_pages()?

It's the bvec path:

                iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);

> >> Which doesn't work for a sub-size kmalloc() from a slab folio, which after
> >> the frozen refcount conversion no longer supports get_page().
> >> 
> >> The question is if this is a mistake specific for this path that's easy to
> >> fix or there are more paths that do this. At the very least the pinning of
> >> page through a kmalloc() allocation from it is useless - the object itself
> >> has to be kfree()'d and that would never happen through a put_page()
> >> reaching zero.
> >> 
> > Looks like a specific mistake.
> > tls_sw is the only user of sk_msg_zerocopy_from_iter()
> > (which is calling into __iov_iter_get_pages_alloc()).
> > 
> > And, more to the point, tls_sw messes up iov pacing coming in from
> > the upper layers.
> > So even if the upper layers send individual iovs (where each iov might
> > contain different allocation types), tls_sw is packing them together 
> > into full records. So it might end up with iovs having _different_ 
> > allocations.
> > Which would explain why we only see it with TLS, but not with normal
> > connections.

I thought we'd done all the work needed to get rid of these pointless
refcount bumps.  Turns out that's only on the block side (eg commit
e4cc64657bec).  So what does networking need in order to understand
that some iovecs do not need to mess with the refcount?

