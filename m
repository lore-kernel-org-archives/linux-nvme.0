Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C218C7EE33
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 17:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:
	Content-Transfer-Encoding:Content-ID:Content-Type:MIME-Version:Subject:cc:To:
	References:In-Reply-To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7wL75rzvxRHHweMkIElV/+uTCkQTaYtKC4NiLzMuw0M=; b=QSb3jOn5oDjHMvENEZfDsBN5fE
	CSXxc8AFPGguGtysJpLUaheHr2J29Wk1/Lg+D9p8v7Z7IwMGmmWsFJ8LjfV/r+z2l6Ts0IaRnbBxI
	bvtH9iBqvda1GRUjLLuGPRIep6HkplMdcIlpNsnQ7XeJMb47AQmwpvonZtnHkkOCZNMZHgl2EUKaM
	GZzZgTMGL9tWOQOyny53U/Vtz2zJtYY1wGMEpzGevRk4RZuqpM7DW8XNk8VWKj7rI+gHvI79j0HJh
	wZz2aS4PpzZBBQOKbfYIk6TqF82nFyJ9ZGUwFFEmQB5Iz6R14vIoJ/rhn84zR5n1cX9eNYB02Xvx2
	v8AZIxIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3gtL-00BHid-1q;
	Mon, 29 May 2023 17:42:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Wqe-002WVS-0y
	for linux-nvme@lists.infradead.org;
	Fri, 26 May 2023 12:47:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685105231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wL75rzvxRHHweMkIElV/+uTCkQTaYtKC4NiLzMuw0M=;
	b=Aq5nl1aWB1JuRjOFASFkWAfR8hir6DkHqa0T946u8YDra0ysgJ4E4JMSw2EjSrm6CYRF8q
	EPv7quDgoTj2fTqaLaAsf1JWtPS22GsVldMlW9r3aAOIsTsIeO/r+eM3tBY7zRAiN8A8hv
	B2J+U/VC++ZNNA8BELaUqc9o2cz61KM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-xgCvy8lSNa2E1PbJrJo26w-1; Fri, 26 May 2023 08:47:08 -0400
X-MC-Unique: xgCvy8lSNa2E1PbJrJo26w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F54A811E8E;
	Fri, 26 May 2023 12:47:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7742C8162;
	Fri, 26 May 2023 12:47:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <a819dd80-54cc-695f-f142-e3d42ce815a7@huawei.com>
References: <a819dd80-54cc-695f-f142-e3d42ce815a7@huawei.com> <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-5-dhowells@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>,
    Matthew Wilcox <willy@infradead.org>
cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
    David Ahern <dsahern@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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
Content-ID: <739165.1685105220.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 May 2023 13:47:00 +0100
Message-ID: <739166.1685105220@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230526_054712_438063_7D031095 
X-CRM114-Status: GOOD (  37.99  )
X-Mailman-Approved-At: Mon, 29 May 2023 10:42:39 -0700
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

Yunsheng Lin <linyunsheng@huawei.com> wrote:

> > Change the page_frag_cache allocator to use multipage folios rather th=
an
> > groups of pages.  This reduces page_frag_free to just a folio_put() or
> > put_page().
> =

> put_page() is not used in this patch, perhaps remove it to avoid
> the confusion?

Will do if I need to respin the patches.

> Also, Is there any significant difference between __free_pages()
> and folio_put()? IOW, what does the 'reduces' part means here?

I meant that the folio code handles page compounding for us and we don't n=
eed
to work out how big the page is for ourselves.

If you look at __free_pages(), you can see a PageHead() call.  folio_put()
doesn't need that.

> I followed some disscusion about folio before, but have not really
> understood about real difference between 'multipage folios' and
> 'groups of pages' yet. Is folio mostly used to avoid the confusion
> about whether a page is 'headpage of compound page', 'base page' or
> 'tailpage of compound page'? Or is there any abvious benefit about
> folio that I missed?

There is a benefit: a folio pointer always points to the head page and so =
we
never need to do "is this compound? where's the head?" logic to find it.  =
When
going from a page pointer, we still have to find the head.

Ultimately, the aim is to reduce struct page to a typed pointer to massive=
ly
reduce the amount of space consumed by mem_map[].  A page struct will then
point at a folio or a slab struct or one of a number of different types.  =
But
to get to that point, we have to stop a whole lot of things from using pag=
e
structs, but rather use some other type, such as folio.

Eventually, there won't be a need for head pages and tail pages per se - j=
ust
memory objects of different sizes.

> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 306a3d1a0fa6..d7c52a5979cc 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -420,18 +420,13 @@ static inline void *folio_get_private(struct fol=
io *folio)
> >  }
> >  =

> >  struct page_frag_cache {
> > -	void * va;
> > -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> > -	__u16 offset;
> > -	__u16 size;
> > -#else
> > -	__u32 offset;
> > -#endif
> > +	struct folio	*folio;
> > +	unsigned int	offset;
> >  	/* we maintain a pagecount bias, so that we dont dirty cache line
> >  	 * containing page->_refcount every time we allocate a fragment.
> >  	 */
> > -	unsigned int		pagecnt_bias;
> > -	bool pfmemalloc;
> > +	unsigned int	pagecnt_bias;
> > +	bool		pfmemalloc;
> >  };
> =

> It seems 'va' and 'size' field is used to avoid touching 'stuct page' to
> avoid possible cache bouncing when there is more frag can be allocated
> from the page while other frags is freed at the same time before this pa=
tch?

Hmmm... fair point, though va is calculated from the page pointer on most
arches without the need to dereference struct page (only arc, m68k and spa=
rc
define WANT_PAGE_VIRTUAL).

David


