Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F78C7EE23
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 04:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wqe+EMfTqwgCzibqmrP4x167w3kg6AGKeWhHsuYgmqo=; b=rVf/UGHvM+IKsPNLrHDO2OI5bC
	boo0y6MU39rJ9ehVX986eabvBtEG1UGy1xVGOFsvSI4S/BCqoRVvM1QJBP24gTplmGavGx8r6LFgZ
	WDF2FQUJXpwxDzDkoaYICtmcVxajq5XohGgNA+pglCa7dMVaKQZlCcOzWjmHJcjofPNh767OVklhZ
	UDUodC6tl31zchRFht32t9OzkKYQc8X1KydeFckI8t/x23CfvMeRqIxiZUTSQKzPkHyAHuAWVadam
	zKq1BJ49iQEUxO1OZjVn75R+tO+/nCGF3oyai6wRDjy2/zqSIdGRWrYAkRYezOhDSDgHupAv+2LnA
	tZWMR5RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6l6u-004KVk-1M;
	Wed, 07 Jun 2023 04:49:28 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Y9u-0028lK-1g;
	Tue, 06 Jun 2023 14:59:45 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53f70f7c2d2so3337453a12.3;
        Tue, 06 Jun 2023 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686063580; x=1688655580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqe+EMfTqwgCzibqmrP4x167w3kg6AGKeWhHsuYgmqo=;
        b=c89hhqFN81vIg5IN2rpZKauKAqHYf+KMSB7oh1dAt0i49A3ucUMkyTzxUCrj2WWs+g
         /LU3Xr/oSOgiCs+CzGUU8pWhEpDacm5mxkJpE/5clGHyANc/lNkJmfLq/aJVfdcjT8UL
         eBL06dgnIyAp6shIXHNvUuno3W6Sk3jssjkHEmrtsXS0ehGnvMz9fE+mUbSyT7V/DtJ8
         YEYyGAmkm7jdPB+ETVRV6oGB43zryHGlxwY1MiyEjreIcHwBO4xpm30cOGoi+5sxuVuw
         QGY0ItDFmMr8lVYp12VI5cDd1e62KrSFDl9FQbjPsohnlfnzU1oGnGODof+74Twn0KQQ
         vCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686063580; x=1688655580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wqe+EMfTqwgCzibqmrP4x167w3kg6AGKeWhHsuYgmqo=;
        b=M4hOEcknLxRSL60y1Z+v3ayXj9IMQPfeKkc2/P59A8VMr3topVrDiT3tePU6vz+3Y6
         0GNAqUP8/PRvRIPUaPAwLy+AoLc1csVRMUJqlmvSN30YLLYZylydcixxVJVnqaCZEWzR
         UPYkOKLp025ZgqRwir18yTX3mrThH8Zafhsa+3erhExDXFT2wquUMkO9/JeCfXQF1cPg
         xtx6qcuOBOFLWfxREO+yQUggZxf32mJDsTadElaObOGd7Lb9UWOvEaFgxAZ52/P2pYzQ
         KkP8BtgfO+ovGqBuhvQYmd8hjRS75R0Wvcuge6ioSO7NMnyHeIGScipo4c8t6Whp2zHR
         CpSg==
X-Gm-Message-State: AC+VfDwlSQtSUSAcy5QopSpE58BYPdUvlA+V4tMzqVRaVoSQlTMcY7it
	FWho6N5GrxfZZeQlcNCygE7reAOmXrR7t0ieFwQ=
X-Google-Smtp-Source: ACHHUZ7R3wIBiwS3qmIDAIVJhRLmDVW+rENmgn5tSeT1A0bMQm4kGe5M15s7kly86oJcM/F8JJJXG4R4/1qAqmUxppw=
X-Received: by 2002:a05:6a20:3d83:b0:117:a2f3:3c93 with SMTP id
 s3-20020a056a203d8300b00117a2f33c93mr14207pzi.2.1686063579863; Tue, 06 Jun
 2023 07:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-5-dhowells@redhat.com>
 <a819dd80-54cc-695f-f142-e3d42ce815a7@huawei.com> <f7919c2c9e1cb6218a0b0f55ddaa9a34f7d2b9a7.camel@gmail.com>
 <1841913.1686039913@warthog.procyon.org.uk>
In-Reply-To: <1841913.1686039913@warthog.procyon.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 6 Jun 2023 07:59:02 -0700
Message-ID: <CAKgT0Ud=ZWVnpwqbLqGovjPM2VR_V1-Ak=meveqnG01tGWTTeA@mail.gmail.com>
Subject: Re: [PATCH net-next 04/12] mm: Make the page_frag_cache allocator use
 multipage folios
To: David Howells <dhowells@redhat.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jeroen de Borst <jeroendb@google.com>, 
	Catherine Sullivan <csully@google.com>, Shailend Chand <shailend@google.com>, Felix Fietkau <nbd@nbd.name>, 
	John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_075942_604663_806EE3A4 
X-CRM114-Status: GOOD (  33.29  )
X-Mailman-Approved-At: Tue, 06 Jun 2023 21:49:27 -0700
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

On Tue, Jun 6, 2023 at 1:25=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Alexander H Duyck <alexander.duyck@gmail.com> wrote:
>
> > Also I have some concerns about going from page to folio as it seems
> > like the folio_alloc setups the transparent hugepage destructor instead
> > of using the compound page destructor. I would think that would slow
> > down most users as it looks like there is a spinlock that is taken in
> > the hugepage destructor that isn't there in the compound page
> > destructor.
>
> Note that this code is going to have to move to folios[*] at some point.
> "Old-style" compound pages are going to go away, I believe.  Matthew Wilc=
ox
> and the mm folks are on a drive towards simplifying memory management,
> formalising chunks larger than a single page - with the ultimate aim of
> reducing the page struct to a single, typed pointer.

I'm not against making the move, but as others have pointed out this
is getting into unrelated things. One of those being the fact that to
transition to using folios we don't need to get rid of the use of the
virtual address. The idea behind using the virtual address here is
that we can avoid a bunch of address translation overhead since we
only need to use the folio if we are going to allocate, retire, or
recycle a page/folio. If we are using an order 3 page that shouldn't
be very often.

> So, take, for example, a folio: As I understand it, this will no longer
> overlay struct page, but rather will become a single, dynamically-allocat=
ed
> struct that covers a pow-of-2 number of pages.  A contiguous subset of pa=
ge
> structs will point at it.
>
> However, rather than using a folio, we could define a "page fragment" mem=
ory
> type.  Rather than having all the flags and fields to be found in struct
> folio, it could have just the set to be found in page_frag_cache.

I don't think we need a new memory type. For the most part the page
fragment code is really more a subset of something like a
__get_free_pages where the requester provides the size, is just given
a virtual address, and we shouldn't need to be allocating a new page
as often as ideally the allocations are 2K or less in size.

Also one thing I would want to avoid is adding complexity to the
freeing path. The general idea with page frags is that they are meant
to be lightweight in terms of freeing as well. So just as they are
similar to __get_free_pages in terms of allocation the freeing is
meant to be similar to free_pages.

> David
>
> [*] It will be possible to have some other type than "folio".  See "struc=
t
> slab" in mm/slab.h for example.  struct slab corresponds to a set of page=
s
> and, in the future, a number of struct pages will point at it.

I want to avoid getting anywhere near the complexity of a slab
allocator. The whole point of this was to keep it simple so that
drivers could use it and get decent performance. When I had
implemented it in the Intel drivers back in the day this approach was
essentially just a reference count/page offset hack that allowed us to
split a page in 2 and use the pages as a sort of mobius strip within
the ring buffer.

