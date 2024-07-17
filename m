Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F23C3DA60
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 20:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ncSYgCH2yObWoew5+X7CbTEVtAMvPgWthTFHHeqOzls=; b=AA6RoRvwje/GB7XAlA+RrDbAie
	rDIg4ZVKepgCxKrY5/nZ2RgTvR3jxdiG4SE3B4qzHl7CXqHe8/d056tnLSSw4/3Vz/B7ddVMWHuZr
	4/H+NDC3HDSsxiYrNYtZkJsTSHApz4As1/xTjE4TK6OMnRkLSV6yeBfFyiYIaISInWw+ZDzOhyM9G
	jSS0hFlSZaIMZjakdS97R+tUmfYNFXAabyEZDMeMvGGTr2Xa1mC6WHvXuHeDTpXTWPwqtMSYIS9I0
	XmiuxUZanpn6hryNvFDqaTuqo9UU0AOLagioMbw8i5YdlxHaHTz9FzgibPP/fq22l4dsIKcle+zmZ
	juIuqKQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBEI-0000000Eq5B-3ufg;
	Wed, 17 Jul 2024 20:26:26 +0000
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBEG-0000000Eq4e-1AeD
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 20:26:25 +0000
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5b9778bb7c8so9998eaf.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 13:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721247982; x=1721852782; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncSYgCH2yObWoew5+X7CbTEVtAMvPgWthTFHHeqOzls=;
        b=CNBRPdYMw+Vef3dTarA1n/UGms7WKWuliDyGoL5LyPgQ0/9/fV2pUn+96ivwccXtqx
         U6mE8enUtD3fSPXeSZZYPaiEoyrQbsNJBo8TfkW2alnd3D6w8KnX1PsbP5+XqYRRNzGZ
         yUR4Ss+qhvsVfettqLN+hC71+5cQZbcKfXdA4CZE2GkPwiafzyJu9c5TZn4l6A4vggyL
         URZgO4v/xZ4ajtPoDytfspcsSN3r1ooQ+2joABlZusPGXIcvJIyMEJEtCD1FU554Vr9/
         pmffUVEwiptYvDetXRNJE+rOGDEcBxUdobQS55AvnEyOnHPdOphSuy6eGNLTUmvVPROX
         mWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721247982; x=1721852782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncSYgCH2yObWoew5+X7CbTEVtAMvPgWthTFHHeqOzls=;
        b=dhllAxmjBsrou9S6+gzkvueURIYnzQQAnGIWvCo/OUQwBuJZMZ+YULvLoEjlygGGSC
         UabBcN8EjHaBUCen5P1WByfbTmCbfbuelJCsiFkv6N7Sgtbr6/2e8tvd3xPmUdDfwisK
         NKCpj0H/1ysPGA4dsN2tsHue8q+xAE90HfB3d1we7r6dKxglFdID4yLDtL+HVA/dCHFG
         p+Bz0SQfvG8iFyC0q5XItwqoFr4/BRSe4XCBoV+jCui5BDoa82Sy3XccD++bEKXWWDjo
         T8Jj80ZqWFzloE0rLfrwAKM8aT0BVKpYpbG9HZPsWGurYzcrO8m4rOLhUemW3IjjRy9r
         SaxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYwFn6AWL0K/8WCFuRLlXFbxA/T6pIhabqFXXrFCR+K1iWbERW71dyGda3i9HKf7HgM6LbgMan5lQ1TokRU7u+WXEv/CcirsZR1OWb6C0=
X-Gm-Message-State: AOJu0YyBXAfMQXIn+GqwutCbGRssltq34o0vycLTUITbONsB3FjzDsih
	y/cudwZurOjLhOWr8+m4murbVV/HgZ98pja0QH4lSZMhXifJNWg8hEzcy+EeftExzZjprUKX4ke
	v3waYeRp7JW6RmNazGiMt0SSLiWs=
X-Google-Smtp-Source: AGHT+IFSRPf4iO7FOIYwpaSrJDKwLNrX/hn2v8uBVQCD1+mp0QuUcyPuSVjRdHo2DHuixjUvNAimZaelOjd9P+sqgHg=
X-Received: by 2002:a05:6871:58c:b0:25e:b8c2:8367 with SMTP id
 586e51a60fabf-260d915c40fmr2312531fac.11.1721247982433; Wed, 17 Jul 2024
 13:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240611063618.106485-1-ofir.gal@volumez.com> <20240611063618.106485-5-ofir.gal@volumez.com>
 <2695367b-8c67-47ab-aa2c-3529b50b1a83@volumez.com>
In-Reply-To: <2695367b-8c67-47ab-aa2c-3529b50b1a83@volumez.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 17 Jul 2024 22:26:10 +0200
Message-ID: <CAOi1vP96JtsP02hpsZpeknKN_dh3JdnQomO8aTbuH6Bz247rxA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] libceph: use sendpages_ok() instead of sendpage_ok()
To: Ofir Gal <ofir.gal@volumez.com>
Cc: davem@davemloft.net, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org, 
	ceph-devel@vger.kernel.org, dhowells@redhat.com, edumazet@google.com, 
	pabeni@redhat.com, kbusch@kernel.org, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_132624_346514_1981E294 
X-CRM114-Status: GOOD (  23.61  )
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

On Tue, Jul 16, 2024 at 2:46=E2=80=AFPM Ofir Gal <ofir.gal@volumez.com> wro=
te:
>
> Xiubo/Ilya please take a look
>
> On 6/11/24 09:36, Ofir Gal wrote:
> > Currently ceph_tcp_sendpage() and do_try_sendpage() use sendpage_ok() i=
n
> > order to enable MSG_SPLICE_PAGES, it check the first page of the
> > iterator, the iterator may represent contiguous pages.
> >
> > MSG_SPLICE_PAGES enables skb_splice_from_iter() which checks all the
> > pages it sends with sendpage_ok().
> >
> > When ceph_tcp_sendpage() or do_try_sendpage() send an iterator that the
> > first page is sendable, but one of the other pages isn't
> > skb_splice_from_iter() warns and aborts the data transfer.
> >
> > Using the new helper sendpages_ok() in order to enable MSG_SPLICE_PAGES
> > solves the issue.
> >
> > Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
> > ---
> >  net/ceph/messenger_v1.c | 2 +-
> >  net/ceph/messenger_v2.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
> > index 0cb61c76b9b8..a6788f284cd7 100644
> > --- a/net/ceph/messenger_v1.c
> > +++ b/net/ceph/messenger_v1.c
> > @@ -94,7 +94,7 @@ static int ceph_tcp_sendpage(struct socket *sock, str=
uct page *page,
> >        * coalescing neighboring slab objects into a single frag which
> >        * triggers one of hardened usercopy checks.
> >        */
> > -     if (sendpage_ok(page))
> > +     if (sendpages_ok(page, size, offset))
> >               msg.msg_flags |=3D MSG_SPLICE_PAGES;
> >
> >       bvec_set_page(&bvec, page, size, offset);
> > diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
> > index bd608ffa0627..27f8f6c8eb60 100644
> > --- a/net/ceph/messenger_v2.c
> > +++ b/net/ceph/messenger_v2.c
> > @@ -165,7 +165,7 @@ static int do_try_sendpage(struct socket *sock, str=
uct iov_iter *it)
> >                * coalescing neighboring slab objects into a single frag
> >                * which triggers one of hardened usercopy checks.
> >                */
> > -             if (sendpage_ok(bv.bv_page))
> > +             if (sendpages_ok(bv.bv_page, bv.bv_len, bv.bv_offset))
> >                       msg.msg_flags |=3D MSG_SPLICE_PAGES;
> >               else
> >                       msg.msg_flags &=3D ~MSG_SPLICE_PAGES;
>

Hi Ofir,

Ceph should be fine as is -- there is an internal "cursor" abstraction
that that is limited to PAGE_SIZE chunks, using bvec_iter_bvec() instead
of mp_bvec_iter_bvec(), etc.  This means that both do_try_sendpage() and
ceph_tcp_sendpage() should be called only with

  page_off + len <=3D PAGE_SIZE

being true even if the page is contiguous (and that we lose out on the
potential performance benefit, of course...).

That said, if the plan is to remove sendpage_ok() so that it doesn't
accidentally grow new users who are unaware of this pitfall, consider
this

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya

