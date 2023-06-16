Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A037EB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 13:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i0G7Semk72J4t3p4kyn3yyN8DMzzZ6FPSFQ8xY4ugkA=; b=fZeXUFXppqnU4baK9KugSs/U24
	ethjQLH+WErXupGUsHRO9MeMKcl2b0aavGJZ49thFem37DgT7OZpxLEgxMdmVrS1MdFwRt3uMg0tz
	m2yGB18aL+d+8PppqgA8Gzf6w91GwZsaBEM4YfJgJyFiOH5pkW4Tz1hzcKxgUnnecI7MykW3cGkkH
	x8Wg8YLXquGzlBJu0unlPgOBRFAZOPgSyBM0Sm2xPQkRW9Nah5XIaP6sdf3jiXzfIFcCJFdKWBwtO
	dbmBSFP0/TFj181BeWnFMIn1W2uQhA94bM5BjhQmKC8AyLaxubYbRt4eEGGWFRzdOYVLqOHv+ty4g
	KnukDNow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbSd-00BOoD-0J;
	Tue, 20 Jun 2023 13:31:55 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qAByc-0012yE-2M;
	Fri, 16 Jun 2023 16:07:08 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-54fb1bbc3f2so700186a12.0;
        Fri, 16 Jun 2023 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686931616; x=1689523616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0G7Semk72J4t3p4kyn3yyN8DMzzZ6FPSFQ8xY4ugkA=;
        b=QJxa1vOcE8rQhWgizO0XuACCRpq0Uppp+jXsxnRuMncxkb5yrQAJI7qMt9LkqwDd7R
         PV4tqzr1iPuNsJDpvBqlHB3nUCCP+5vPD4k/JFpxC6D2gIqRxggYDkFesv3ZaS0K5JWR
         /wStYTXp5//TcktuJR64Fxd4pr2R0sEWY0m47BO9hDIuN63Ec8bwdE+rThvAM1ZuwIYB
         T4D7AS/ndymzYcYgPRbSXFzXppRmJq+lUstVt85ocmqnAIrsGY2pYWGxCV5+ba5qqfVe
         7asrMrMMPg+hNewml/KmL5O24wKjWcrKsI4SumLxsurmw4hkhn74w6QWTdZc48isQ1H9
         oVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686931616; x=1689523616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0G7Semk72J4t3p4kyn3yyN8DMzzZ6FPSFQ8xY4ugkA=;
        b=Zf4+ss64a0A01pqo5kbyRWkobKT+en32lYzn6GIdU2r01Olsl/U0dzS5XOxG19vyTO
         Rrvgqhn/ORTmilsbNIitSXYTsePDd6dyWUBK7UOqdMCmIaaUXx8PRr+2yfzC8NqBznek
         4GT/ctW4LSohYzhVfKXl/Ji4BMC2GO0cUdlWgs202xYiGON0l3zf9QALYJKLoU5Vr+X+
         8z1fCPGWpbb5Yb8rwsHrktvel3JOAnu68CYI3QjUqaMCa3TlCL2T2DyvIturk6vgk77s
         Oll9vUhjgd+rGK3pn5pnyi79lPdvy7atZDa3Z6Hqil5LllFjUo5wNBDILBiECm1mdFBe
         wUtA==
X-Gm-Message-State: AC+VfDxgKi/wt7X5nKtxGmKMFdoJ4yHKTCbFOAodUyyLUt84ohd9RS85
	GHaR6Zl3xpSzb0pzyLSuSC0GwyFoUY2KvuJP/yY=
X-Google-Smtp-Source: ACHHUZ4zyg1zxLBKfeGMzytzy/B6r1BRDnE5XaflvwrOKH/X5QyBu86XsC2LkWsG5g54K9PtAga9SKJKTFxIvXCStmo=
X-Received: by 2002:a17:90a:6c63:b0:25b:fbdc:dd8 with SMTP id
 x90-20020a17090a6c6300b0025bfbdc0dd8mr1991263pjj.24.1686931616191; Fri, 16
 Jun 2023 09:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-4-dhowells@redhat.com>
 <51161740e832334594960ed43430b868a6f892c3.camel@gmail.com> <617059.1686929309@warthog.procyon.org.uk>
In-Reply-To: <617059.1686929309@warthog.procyon.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 16 Jun 2023 09:06:19 -0700
Message-ID: <CAKgT0Udfud_wVKLiZbi4Okuzor7OKzRi_PwvvCwnsiOdw7ir7A@mail.gmail.com>
Subject: Re: [PATCH net-next 03/12] mm: Make the page_frag_cache allocator
 alignment param a pow-of-2
To: David Howells <dhowells@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
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
X-CRM114-CacheID: sfid-20230616_090706_775690_80AE2086 
X-CRM114-Status: GOOD (  16.47  )
X-Mailman-Approved-At: Tue, 20 Jun 2023 06:31:53 -0700
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

On Fri, Jun 16, 2023 at 8:28=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Alexander H Duyck <alexander.duyck@gmail.com> wrote:
>
> > The requirement should only be cache alignment, not power of 2
> > alignment.
>
> Sure, but, upstream, page_frag_alloc_align() allows the specification of =
an
> alignment and applies that alignment by:
>
>         offset &=3D align_mask;
>
> which doesn't really make sense unless the alignment boils down to being =
a
> power of two.  Now, it might make sense to kill off the align_mask parame=
ter
> and just go with SMP_CACHE_BYTES (which will be a power of two).
>
> Note, though, that most users seem to use an align_mask of ~0u which feel=
s a
> bit dodgy (it's not an unsigned long), but is probably fine.

Yeah, now that I think about it this should be fine. I must have been
responding to this without enough sleep. When I originally read it I
saw it as limiting it to a power of 2 allocation, not limiting the
alignment mask to a power of 2.

