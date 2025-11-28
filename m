Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5DDD116F1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 03:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QO8NwmkkI9mg0Fvr/iDdQ4VLLlyo+WunqlauIGsbobw=; b=geebjydA/zGO5+m3zl3pY4Gg8v
	XJ645/d92gvQbTptKuP8wavdI2SkTVc3OF/uE7OfAEzxedUvdYxQsPFi/BFG09oympx4+kYrfUunk
	cHTJkU3mbWGC8e5lcWSPMV6ak3jkPDIBv4Dwl1LEpPwC1FYDWOKYPhQY/MwfJQmcsK1I+8uW5kpGG
	dm+LpQbT5GmNEcVu7X0cxx5nGqHnKquVZ+mxyM/jGCbRliVjZVT5JlOmw26ZR7DSAvsppfonqMMpa
	K8JgFXzf/2h42ct2T7zq9ooWitsRerhBIR378jDcyuqd6CMAZvUinCFOToBO34j+63q6WMuGFBB81
	JNFzhgig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOp4z-0000000HWCm-1cWD;
	Fri, 28 Nov 2025 03:23:29 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOp4x-0000000HWCR-1Abh
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 03:23:28 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4ed6882991aso10961761cf.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Nov 2025 19:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764300206; x=1764905006; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QO8NwmkkI9mg0Fvr/iDdQ4VLLlyo+WunqlauIGsbobw=;
        b=ErePFuQsaEIEieZT/JCtepRWZti3cnjZ0BOUcL8lUq/5JCc4r7oDw4b42a632o1H0B
         2He52IbF/rKE5tRzIsWan6u5Bz95wM1iVYW7DLTqBf4h9ntF15Xj6JPmFJiXfpHAydIf
         X/QUOqE9w6nEXBdvEgWO3Ke3vsf53cbbpXIBjwL5VCVgsL4VXf0BVJd6HArfz1cEgqTg
         btCs9AKcrp1XiBK5+U60G8/yh7w2Z0a6Pf+o9y5m/AB3/vHq13Oo9Ot7Voz+xwintIJs
         ElS1eFSkNer8a1i+i0SAEuc8lSClEhP6uanw87Ul3icPEcUCHE1K8ctNUVVjikHYHjb+
         KKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764300206; x=1764905006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QO8NwmkkI9mg0Fvr/iDdQ4VLLlyo+WunqlauIGsbobw=;
        b=owyuQnobfj+F9WZsUC9iKN+VY0/6MBAP6ln65qoTRLgyXbtNnnL9NNIUl6HvqjzE5I
         scCA/cHp+2kYkaCAfKX24uuHAd6PfZijXY9gftHmBIEdLnCGdq7688JjwR4+8R1wjUnN
         oXwPLSRybYvvlYsj2s/ACOReiHF1GqbA9iONCKO81IkAP1WvxnXKnpJX1lEmXNbG6KaB
         OtMrAqZ3IlORc0ltF5T+lgvy089EzBQXisb/Hl2adqxyQFrYq5bAXq3QjkkA3KwaSt5I
         IDQq6JyfSCFMyiSR3JZExzEALzQfkgQD6/ACW8J0L0vFqnkKshsFqvbraCnSxNkTl4pC
         0P5A==
X-Forwarded-Encrypted: i=1; AJvYcCWtkOKEwkrnwVNiLPJA9vK+gTmPNqR8LTaQhXHqdSItIwJKImxYKoB85dsIXyhY5klqrIA3J1pVnHAT@lists.infradead.org
X-Gm-Message-State: AOJu0YyJcXAg6AQ8ojq9aGT812kHd1otaAQuKo+RmS+COdOdD0KT9Y6h
	a3P9QNS0PXyaySI+jWIF1VjrvA3zjZs3sI65YafsH7MajJdrhVppVk+TtH8AvzZSqO1GU1AutWU
	XQgxKi6MEGUxrUXQDjAS9xxQQbVJuews=
X-Gm-Gg: ASbGncvBgMsB8ctTTGutYqNh3iFqvUpyH6ww9smkXIZJfh5OFtH39cWbFpW5wMas5A+
	hW4NKf8+nXE1qqy+YgotYmYbsxJEmlU/+WZZzJWdoHhORJPVmUW+Nv7nR0oOWXQf+LoyOeoNOzz
	3FC+HgSFCtpcRSkCCkaqb/R8VoTPHnlxC3DvNywmKks9qAPAMvOkp9BoLss5/YdM8nE/n6FckPa
	UfFIh2tqTHNAdMVk24IlOHOBxzowduY0Fz7nBnFc2xP621plfUgdxl1yhU39jO6lyEonDk=
X-Google-Smtp-Source: AGHT+IG9mqJdVZgQj3BVyXnihjqxo6smpev5tsviBeKxWgS8ADskcY34A+TMMILps/HKlL0xyNYCt0kJ8fD8XQas0U8=
X-Received: by 2002:ac8:5e4c:0:b0:4ed:a6b0:5c14 with SMTP id
 d75a77b69052e-4ee4b54fd07mr426909921cf.23.1764300205954; Thu, 27 Nov 2025
 19:23:25 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-2-zhangshida@kylinos.cn> <aSA_dTktkC85K39o@infradead.org>
 <CAHc6FU7NpnmbOGZB8Z7VwOBoZLm8jZkcAk_2yPANy9=DYS67-A@mail.gmail.com>
In-Reply-To: <CAHc6FU7NpnmbOGZB8Z7VwOBoZLm8jZkcAk_2yPANy9=DYS67-A@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 28 Nov 2025 11:22:49 +0800
X-Gm-Features: AWmQ_blj83ISfyC32dpt8HHM0xujFYlidvaYOqxvcTwKucopW11tVoED-TPviuI
Message-ID: <CANubcdXzxPuh9wweeW0yjprsQRZuBWmJwnEBcihqtvk6n7b=bQ@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20251127_192327_349599_4016F19B 
X-CRM114-Status: GOOD (  25.65  )
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
> Also, multiple completions can race setting bi_status, so shouldn't we
> at least have a WRITE_ONCE() here and in the other places that set
> bi_status?
>

I'm considering whether we need to add a WRITE_ONCE() in version 2
 of this series.

From my understanding, WRITE_ONCE() prevents write merging and
tearing by ensuring the write operation is performed as a single, atomic
access. For instance, it stops the compiler from splitting a 32-bit write
into multiple 8-bit writes that could be interleaved with reads from other
CPUs.

However, since we're dealing with a single-byte (u8/blk_status_t) write,
it's naturally atomic at the hardware level. The CPU won't tear a byte-size=
d
write into separate bit-level operations.

Therefore, we could potentially change it to::

        if (bio->bi_status && !READ_ONCE(parent->bi_status))
                parent->bi_status =3D bio->bi_status;

But as you mentioned, the check might not be critical here. So ultimately,
we can simplify it to:

        if (bio->bi_status)
                parent->bi_status =3D bio->bi_status;

Thanks,
shida

> Thanks,
> Andreas
>

