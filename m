Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF41CC77B7A
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 17:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qZ/1f+H9JrSTH8ywSfAAbH2Cj7OIgM+7OnWkNZ9G6/M=; b=X0QujvPa79G3tVOi62AHlUF8MP
	mClW0jT5lzDRHqimrqj6BeiF66ppI2KFmsssLrUPKd28nyqTPMjyKZs69ztrY6G96kI6aAVqog74i
	4MNkf/tQLWAZ5N31nsolfOTFuGOzeymoss5Lki2/rfmIZPRscL+2mXGUyYsXJjBbHKXygwRRViwOK
	DT4CUTCDUsa6LG7qvFSYl+EQnWPHZfY7+Xb6vQMQyUGdNwQV07Je/cqJjLIWIFDvNqfmQyM8IGV77
	jIwxb5AoDRJACoz8ngAZxdUjDzEwLqfvjliZ0hgpcoQ8t59PTt3y/km1+di2+c0Rz7uXVkwmvCPcC
	J6jjmROw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3gtS-00BHpL-1s;
	Mon, 29 May 2023 17:42:54 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2wGO-005zVK-0V;
	Sat, 27 May 2023 15:55:29 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64f47448aeaso1448616b3a.0;
        Sat, 27 May 2023 08:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685202927; x=1687794927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZ/1f+H9JrSTH8ywSfAAbH2Cj7OIgM+7OnWkNZ9G6/M=;
        b=p9rMA6qUBSHw1NGegcSUbJlHcKt4DZ3RpCKIsfprL3eaDv1JFy4GEeLFOHplShouqw
         lei23TwMi2DMyR9zXMoI+gpenhRgHyHhWjQDn2B7s31mLIkocnYJCmQWSnIpxY7iaq1x
         LyRkiJwXpkALdjSKgHQ4Lobg5+syom0agOKn06E2rgo8Zim8nDCNsD1Xu0nPq1Yi+kVX
         ngzLNDvj8fkpHrINBrXubUlYKI4kmu3Qm3o30FMA7ACY2VGHEN0PfjvRa/ns1skaGtIk
         /cEOCNzG3VGnum2VeOEAqRAmN316PARZHCX9ARcyq5+zq/81q2yuUf3TO5OU4fK1Z1Wr
         i/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685202927; x=1687794927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZ/1f+H9JrSTH8ywSfAAbH2Cj7OIgM+7OnWkNZ9G6/M=;
        b=lWbTFd0re5dWX58AYQYB6Li2WCFn+vjSM1Y/aZ4ldOGFNYvKUNlSjRrGgbIe2HitRl
         4lcCYQvIRif8CZFXEJLnRqhsuwyxjpYLuLTEjlCgVEcA+KI/c18CAcxtSygqWl9pPCJs
         voohCxgS8G/CyyOg/UTILqoOVSjaoC85DsXVwlpJkf/1OOLQh3CDhMqO/vlcRJKwDKYb
         eCkDjQhcivDlvyGa7hpKgd4lbcYhjD4Z8vLDyjS+NzO8XbxTbrRWkvwVekNfWujEVVdn
         nSDSl1fjEwWauR36t07QyOrBbRzn03KlgusFQ0b1wfTD3mrPdnrJbiVCh8mWDzcEDLzq
         eMwQ==
X-Gm-Message-State: AC+VfDyWCqdoHHqgKCr+B/Vtl/1OL0lJUdIle67Qjg4uTlfsPS2XwMi9
	FIb/JmG+VQQ2xaSySf0jaUVKM9QmEaA+Zv6cgHU=
X-Google-Smtp-Source: ACHHUZ64JnVWGNRmG/FMmCXkRK9umouxfNu5WSYpfqhZWb1yayLJ0QzFvBLSS7/j3llpZaEueVjiGE/MaMAjTCqEuek=
X-Received: by 2002:a05:6a20:4428:b0:ff:a820:e060 with SMTP id
 ce40-20020a056a20442800b000ffa820e060mr4237395pzb.20.1685202926525; Sat, 27
 May 2023 08:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-6-dhowells@redhat.com>
 <20230526175736.7e75dcf9@kernel.org>
In-Reply-To: <20230526175736.7e75dcf9@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 27 May 2023 08:54:50 -0700
Message-ID: <CAKgT0Uf2rPRZqQxGDZGkmdUA2j2=2cw0X1k8i0RpKgNxX0tcCw@mail.gmail.com>
Subject: Re: [PATCH net-next 05/12] mm: Make the page_frag_cache allocator
 handle __GFP_ZERO itself
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jeroen de Borst <jeroendb@google.com>, Catherine Sullivan <csully@google.com>, 
	Shailend Chand <shailend@google.com>, Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230527_085528_193961_92D4C555 
X-CRM114-Status: GOOD (  19.33  )
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

On Fri, May 26, 2023 at 5:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 24 May 2023 16:33:04 +0100 David Howells wrote:
> > Make the page_frag_cache allocator handle __GFP_ZERO itself rather than
> > passing it off to the page allocator.  There may be a mix of callers, s=
ome
> > specifying __GFP_ZERO and some not - and even if all specify __GFP_ZERO=
, we
> > might refurbish the page, in which case the returned memory doesn't get
> > cleared.
>
> I think it's pretty clear that page frag allocator was never supposed
> to support GFP_ZERO, as we don't need it in networking.. So maybe
> you're better off adding the memset() in nvme?
>
> CCing Alex, who I think would say something along those lines :)
> IDK how much we still care given that most networking drivers are
> migrating to page_poll these days.

Yeah, the page frag allocator wasn't meant to handle things like this.
Generally the cache was meant to be used within one context so that
the GFP flags used were consistent between calls. Currently the only
thing passed appears to be GFP_ATOMIC.

Also I am not a big fan of pulling this out of page_alloc.c The fact
is that is where the allocation functions live so it makes sense to
just leave it there. It isn't as if there is enough code added in my
point of view to create yet another file and make it harder to track
git history as a result.

