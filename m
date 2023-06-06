Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCA7C77B73
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 14:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:From:
	Content-ID:Content-Type:MIME-Version:Subject:Cc:To:References:In-Reply-To:
	Reply-To:Content-Transfer-Encoding:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tl5oPK3uVnMf7j5Be8wyxIVYpd+Z0ksF6FBEMTvD5A0=; b=LBdUmq+Dmb51IbTxft+KWKKKGW
	AewR3OKuLEwZE/2r6FoUEY0lzFJPL2a7OvovqscCHEb/jUi2RtnUUez7NNuQB23j/TCZJoeH/glmT
	MbS0VR+tHIOYIMJRvUAiviGuWc+9+pOgg4GtRKEEpOwsF0iHZIp7y3WzWHRqWgRHKwe/9iqELQ+7X
	D7ZFVsfxzdFqhDDxF4c5+VNUCHoMurm1rxeLtSZKH/GIMe+MJOdy25izFcaQs81PlWtNbkgSgGKMn
	LYvRH0fNG1cwEPhgyuQUyieayCXi1asebgVigMdEt7J2uIy5yUb0vpnxzV9F0aeCTxXknVJaxb2ck
	Gj8J7+mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Xh7-0021MP-23;
	Tue, 06 Jun 2023 14:29:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6S0L-000nLT-1I
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 08:25:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686039924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tl5oPK3uVnMf7j5Be8wyxIVYpd+Z0ksF6FBEMTvD5A0=;
	b=d3auV/G9P/M/ZVw8e2c29Jm92pfobuvt8ORePZyfjlA5hsOFtPw5V0RF1mYniu0e6F4a9Z
	Nmy6ln+3cZek/MPle+5MYxCu5s4GJWWzJU0Ith6qo4qYXEkP2EKuNVnPCEcBCo71GGAQz1
	f9Ge+sxe6F0+fUclMGS057yNgyS+RqQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-WVBBMtVdOw6x8tgl-6tseQ-1; Tue, 06 Jun 2023 04:25:22 -0400
X-MC-Unique: WVBBMtVdOw6x8tgl-6tseQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52E34811E78;
	Tue,  6 Jun 2023 08:25:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 38D27492B00;
	Tue,  6 Jun 2023 08:25:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <f7919c2c9e1cb6218a0b0f55ddaa9a34f7d2b9a7.camel@gmail.com>
References: <f7919c2c9e1cb6218a0b0f55ddaa9a34f7d2b9a7.camel@gmail.com> <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-5-dhowells@redhat.com> <a819dd80-54cc-695f-f142-e3d42ce815a7@huawei.com>
To: Alexander H Duyck <alexander.duyck@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>,
    David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
    David Ahern <dsahern@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org,
    Jeroen de Borst <jeroendb@google.com>,
    Catherine Sullivan <csully@google.com>,
    Shailend Chand <shailend@google.com>, Felix Fietkau <nbd@nbd.name>,
    John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>,
    Mark Lee <Mark-MC.Lee@mediatek.com>,
    Lorenzo Bianconi <lorenzo@kernel.org>,
    Matthias Brugger <matthias.bgg@gmail.com>,
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
    Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
    Chaitanya Kulkarni <kch@nvidia.com>,
    Andrew Morton <akpm@linux-foundation.org>,
    linux-arm-kernel@lists.infradead.org,
    linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next 04/12] mm: Make the page_frag_cache allocator use multipage folios
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1841893.1686039890.1@warthog.procyon.org.uk>
From: David Howells <dhowells@redhat.com>
Date: Tue, 06 Jun 2023 09:25:13 +0100
Message-ID: <1841913.1686039913@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_012525_512703_18B61FD0 
X-CRM114-Status: GOOD (  26.38  )
X-Mailman-Approved-At: Tue, 06 Jun 2023 07:29:56 -0700
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

Alexander H Duyck <alexander.duyck@gmail.com> wrote:

> Also I have some concerns about going from page to folio as it seems
> like the folio_alloc setups the transparent hugepage destructor instead
> of using the compound page destructor. I would think that would slow
> down most users as it looks like there is a spinlock that is taken in
> the hugepage destructor that isn't there in the compound page
> destructor.

Note that this code is going to have to move to folios[*] at some point.
"Old-style" compound pages are going to go away, I believe.  Matthew Wilcox
and the mm folks are on a drive towards simplifying memory management,
formalising chunks larger than a single page - with the ultimate aim of
reducing the page struct to a single, typed pointer.

So, take, for example, a folio: As I understand it, this will no longer
overlay struct page, but rather will become a single, dynamically-allocated
struct that covers a pow-of-2 number of pages.  A contiguous subset of page
structs will point at it.

However, rather than using a folio, we could define a "page fragment" memory
type.  Rather than having all the flags and fields to be found in struct
folio, it could have just the set to be found in page_frag_cache.

David

[*] It will be possible to have some other type than "folio".  See "struct
slab" in mm/slab.h for example.  struct slab corresponds to a set of pages
and, in the future, a number of struct pages will point at it.


