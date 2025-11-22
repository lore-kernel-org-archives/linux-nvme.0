Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BF1CFC50C
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Nov 2025 07:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eBwVylaCDYZawWaYOaVSH7r235GJ5pL280n6ediNWBA=; b=ZVp1p3UsbFtGuJlLCO3WGY+S52
	ZCifcRYg9sKMk5WIWY5IYvX9ZYLU36vGWFOTpK7BhG4hOeKy21NQpRrTVYJZNrvp6nR6nplcmkV49
	x6J1Jan8aV6RBE5UFqUqUNLImLbZ8qlPzi47agAT7Fd5jTEZMJ3GdrKOfL9tvpU6V9rN3mPf6YiPb
	D0p4mOVv84u9q+cJc0oV/C+nkyl+qsPGNYpMidmbmH6oAQgtRzssBFZqoYXUc1J7OJ3KA8KRiz7nK
	7yElYWdAK5fh0xZD+clrwLOHrhSmLWvCZnXcoywHV+dVZgser6bijAiG2tlPZsga/h1DkYzlsnG/7
	3R4NbV9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMi0G-00000009LIo-1EQK;
	Sat, 22 Nov 2025 07:25:52 +0000
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMi0D-00000009LIQ-0fKJ
	for linux-nvme@lists.infradead.org;
	Sat, 22 Nov 2025 07:25:50 +0000
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4ed7a7ddc27so21668031cf.2
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 23:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763796348; x=1764401148; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBwVylaCDYZawWaYOaVSH7r235GJ5pL280n6ediNWBA=;
        b=J6cvBhmSuR1vXf1v04t13YUszchCAVglLyah1TWUxN3/yts1u5c4edFUe2VZGWKI20
         t+E8NPTaTYqFX1Ltw15vgm+Vx2uV74H0eXHX7ZQTOLg75CHXkOVpK5GLv+BX60B7G7Ak
         xMkA7Da9ddf3P6qdB/UAs5JBdFJzEwEVo/XcAA5M7yWV40BV9rVKQK88LZMdBUxe2RS5
         oDEbeahW3jQEySJ+RuP4YDWSrRJwcq3shsLzoml9DsTuKMlrYnhV81NB1aIz4u7kwzcK
         SbRwx5PJBQGopxSqsO6zvydAahumXDpXCluAI0Ma1yBNkemJ6COoCCk3lN+S/izX2GSB
         pfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763796348; x=1764401148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eBwVylaCDYZawWaYOaVSH7r235GJ5pL280n6ediNWBA=;
        b=RHDu6e7Nd2yWBtPPJMLPezL0wp/fCdZ4L7X+ybfHXOIdE6yw5dqyDF2d1bj0fp885Y
         MOHNHdWq12O+4fyGrMEsdaSUrvuKZVa7q6pfKebQtNInBe6o4zgQlZPhdqQoMgcKUEh+
         Sje/LUUOtHv7ZdkuF96ZwVNyJZXYth63qTvq7OdoHIGo17CxFDzx1vvT8GX9vty3D0rc
         R5j55xAD7xaFC7ohfWobjk9A86dH4MD75erc6vGsY+VqyRFpr6+DhvRuGX6Kfx71jptA
         bEn0uTM3efrIwew1yrcs5RxckgN5FHlecrn4zOO/IcbwiRr5Nv+703eAa6CilkAYDDDA
         hqDg==
X-Forwarded-Encrypted: i=1; AJvYcCViM1MNWDdQ/fhZB836WtKc+zyjMe+XoTZbmhB+QqWNOQzt5iaXADr/tKxwCAo6FLC459+244U4CxzF@lists.infradead.org
X-Gm-Message-State: AOJu0YwzdcYF0bSrMjcL3PQZFEho0o2EbMJFJA4qzps5TvIT/jRAu2rq
	aesfX9cKE8IuNjxfwBNLpwpuYsIWDGnkY4sLT0CSMfFK5MkRSQYJ4snjvCcsmao+PM8zRu1eBFH
	a/zvKDztxxwZhCHRW7BkvYr9oQ0r0+U0=
X-Gm-Gg: ASbGncveiCbsqHAPRGa1m8iV5JnvPG5FcD9LiRF1V3Rtv8G8IsiG3E5xxG+HqO5ifTc
	tg7xa/DcJLpOjS0K2RQwNLWjp4CXkBJBLYIiYZqW02yNehMVtgNpPg4H0dhNu9k5JnU4dUVqRNf
	5Geo8VfuaUCDxOSKCf0AfKuUxCmmE1dWXQdH/sOMBKnT7hMl34xmmX0viizoCf77nZwkL++7JrS
	bjNqBaLLkL9j7EiJiUTJeVk2dUx3LoWEiQX9WqG8lhL6TiqBSuTvInTPiCxiXNlZzQ7buk=
X-Google-Smtp-Source: AGHT+IE9V/QbSlM+tFjYlGuMiqhVjgd2vxC0t40Xg/Gl8NLqAZlhJSgGugagYhyt41bdzYZDASTkKfW3q1PwTWY5MjU=
X-Received: by 2002:ac8:580a:0:b0:4ed:b1fe:f885 with SMTP id
 d75a77b69052e-4ee58848f99mr81632341cf.19.1763796347971; Fri, 21 Nov 2025
 23:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-2-zhangshida@kylinos.cn> <aSA_dTktkC85K39o@infradead.org>
 <CAHc6FU7NpnmbOGZB8Z7VwOBoZLm8jZkcAk_2yPANy9=DYS67-A@mail.gmail.com>
In-Reply-To: <CAHc6FU7NpnmbOGZB8Z7VwOBoZLm8jZkcAk_2yPANy9=DYS67-A@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 22 Nov 2025 15:25:11 +0800
X-Gm-Features: AWmQ_bm3jSl3t5CGtWT-qk2xFeLKlRyvhhYg4MhhBIRyX0iMMBB8sT9lfrjP88A
Message-ID: <CANubcdWaegO8k=_fkNFSvnp2bUYMmPehSFnenCCjVw2sz_1jqg@mail.gmail.com>
Subject: Re: [PATCH 1/9] block: fix data loss and stale date exposure problems
 during append write
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_232549_233532_0FF527EA 
X-CRM114-Status: GOOD (  25.19  )
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

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=88=
22=E6=97=A5=E5=91=A8=E5=85=AD 00:13=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 21, 2025 at 11:38=E2=80=AFAM Christoph Hellwig <hch@infradead=
.org> wrote:
> > On Fri, Nov 21, 2025 at 04:17:40PM +0800, zhangshida wrote:
> > > From: Shida Zhang <zhangshida@kylinos.cn>
> > >
> > > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > > ---
> > >  block/bio.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/block/bio.c b/block/bio.c
> > > index b3a79285c27..55c2c1a0020 100644
> > > --- a/block/bio.c
> > > +++ b/block/bio.c
> > > @@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *=
bio)
> > >
> > >  static void bio_chain_endio(struct bio *bio)
> > >  {
> > > -     bio_endio(__bio_chain_endio(bio));
> > > +     bio_endio(bio);
> >
> > I don't see how this can work.  bio_chain_endio is called literally
> > as the result of calling bio_endio, so you recurse into that.
>
> Hmm, I don't actually see where: bio_endio() only calls
> __bio_chain_endio(), which is fine.
>
> Once bio_chain_endio() only calls bio_endio(), it can probably be
> removed in a follow-up patch.
>
> Also, loosely related, what I find slightly odd is this code in
> __bio_chain_endio():
>
>         if (bio->bi_status && !parent->bi_status)
>                 parent->bi_status =3D bio->bi_status;
>
> I don't think it really matters whether or not parent->bi_status is
> already set here?
>

From what I understand, it wants to pass the bi_status to the very last bio
because end_io is only called for that final one. This allows the
end_io function
to know the overall status of the entire I/O chain.

> Also, multiple completions can race setting bi_status, so shouldn't we
> at least have a WRITE_ONCE() here and in the other places that set
> bi_status?
>

Great, that means I could add two more patches to this series: one to
remove __bio_chain_endio() and another to use WRITE_ONCE()?

This gives me the feeling of becoming rich overnight, since I'm making so
many patch contributions this time! :)

Thanks,
shida

> Thanks,
> Andreas
>

