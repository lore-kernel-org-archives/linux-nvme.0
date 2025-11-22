Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3664DCFC51D
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Nov 2025 07:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WLckKOB/6XWKdTlMPCvOWJYhseDg7RVjB2FyFDWqsDI=; b=soL/DgWO7+un0i4mdt1hIjJXWG
	0O249pKiYscxJvo+hx5nHzdcjylN/xAQkZ9RvyBJ9N1hQ/znL+j5pFhZagYfeA2JbrKgD+q1aFe8w
	d86pBVaGwX+CtaweI2e7erl2OPZkJFEl5SyD9eDqN4mo7x53bkaXEs7MVNgrPKAgu5tMLoo8MADnN
	YaxI2e0VvRu9t+I0ecPvYzKhwZgeucX8SFldFCcs0uTns3W2XQTHD0vQW29fG/YL0bRu3YNeU/4aU
	IYkijBH4UOGLtaG2puSNNvTuoUje69W1i14YAgM4S7jNG63ImYxN1nCdcuiQ6zbTBI8BuEjqqViVj
	zhKm3Qgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMhdz-00000009KMi-0wz6;
	Sat, 22 Nov 2025 07:02:51 +0000
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMhdw-00000009KML-3rdO
	for linux-nvme@lists.infradead.org;
	Sat, 22 Nov 2025 07:02:50 +0000
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-8b1b8264c86so268539785a.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 23:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763794967; x=1764399767; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLckKOB/6XWKdTlMPCvOWJYhseDg7RVjB2FyFDWqsDI=;
        b=bgzmMgGdotdgRQQUk/bL8eEGI88EdaZn5FoZUQan3xvKIsuxAXvJwuSpvKnX65Cp1P
         l+qX3YZEILKNjbGW+U/gRqhstJhe7vc60Q1Dad+3YizMPz1vpksrnjiJZYF+9RF3wIX8
         euGsR2z0WDYSvBl46Y3+O1CMo8c52EcCxg7UHmX6JxSDSWgf2FLV/081EiuQLqOYN4JD
         yGJjVA2qzc4ZaIUn/3iRTfANpcYF+MEDTa7zrYOypKU9HFF4XePYpbZA95/EmOGvylgl
         dGoqdHmBfWtrEWNkKQQKxI5h9BZ8K5cnd4WWtS4AGw5YA3AR05erDU2eM5JtBWRi0paF
         3MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763794967; x=1764399767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WLckKOB/6XWKdTlMPCvOWJYhseDg7RVjB2FyFDWqsDI=;
        b=mh2dewpooWQV7z+KuonSTYxumwO4rxKHRXRC8X5LxiURQjkiq461ClFOqJ+CWXA/r2
         d4TiGUHJGOr0yikhNjUhHWJe/WioPvrBVP2R0Dzls8G+uTyNW4dU1h5UJrTDBM+x5du+
         grPOXvQJXZbqV5RLqhfet1tj3okTSNMtY6CvWuzxormer6hSMYFKUb/WQs8Mofj5bEnw
         8PEk47ls/16HMnaQzSxydLY1/mOVLhqrooEx2zouowfC8a/BLhny7R9MAr1mjoFFBVqK
         ZFlnDfRzMKISZjkzKAKv4PIq1p+G1e7XCYGtEs2aHLD14hlCgEz+qKBAsmKA7Bc4QYP1
         EgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrda9kcI08uAGHqqedXgThxlwcK9r0PyLw6aAmm1cMdq5TUT44TIH0U8MdmXsmb+i3V0czF6iKWlwr@lists.infradead.org
X-Gm-Message-State: AOJu0YxQ2D3ynAM8IrcR7jb9LZ1020GtSB+6P5M+Yy8ftbH9yUHosnp0
	zd1LKiKBg/SiC0WSaJlOrnUibwzcyZXOgrxavt5TCI3JEsnseTiL/aOpQGAT+4X5RpKvgVVV7Pv
	OHeL8DyddPPaGvgScMCzgrEjZRYeEk+I=
X-Gm-Gg: ASbGncu1wTrvIQoLz+9ab4OAxqSWFP5QqDKvg1o99LssPyNJhFro2FwnMxoFcUOyxV2
	Y1rcucmWmlD98ZkB8qSP4p3R7rKIKPBT8pjm25LrLM8IGiBDey0TUSjIzgcriQ8Xx+ykuJ7kwd2
	3gsM0jP9SWCA5UuOch/mrCqtaZJRbyHfB/TJrt4eJ6s/UREB0To4zti+XF9sr/PmSqVH1TOi5YN
	31FuwE0Wqf3sJJE9gHJ0AG46l/dO+Je9JJdpCft3SIf44C4dmda8pVnA872qqcxScMBIvo=
X-Google-Smtp-Source: AGHT+IEjcPOv6aPW6JO4Bb1jDowgVciSWSsWd+FNjyx3VBhgbx3Pj6ddYbo0M3Mtuw+ANHFx2AKfX0TCp1WB72JEhOk=
X-Received: by 2002:a05:620a:7106:b0:8b2:e5da:d316 with SMTP id
 af79cd13be357-8b33d48b7d4mr603659585a.87.1763794967475; Fri, 21 Nov 2025
 23:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-3-zhangshida@kylinos.cn> <CAHc6FU7eL6Xuoc5dYjm9pYLr=akDH6ETow_yNPR0JpLGcz8QWw@mail.gmail.com>
In-Reply-To: <CAHc6FU7eL6Xuoc5dYjm9pYLr=akDH6ETow_yNPR0JpLGcz8QWw@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 22 Nov 2025 15:02:11 +0800
X-Gm-Features: AWmQ_bnR6g2ivQ9YSC5w0bIwME61y28InS6FucoZ4PBrcXjaLHV0KwJ_bufirnM
Message-ID: <CANubcdXx8Lp1JsqG3ctAE2V6jpuvJL93UH+7yHaAFtdMjHdijw@mail.gmail.com>
Subject: Re: [PATCH 2/9] block: export bio_chain_and_submit
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_230248_968076_2455792D 
X-CRM114-Status: GOOD (  16.62  )
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
22=E6=97=A5=E5=91=A8=E5=85=AD 01:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 21, 2025 at 9:27=E2=80=AFAM zhangshida <starzhangzsd@gmail.co=
m> wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  block/bio.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index 55c2c1a0020..a6912aa8d69 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -363,6 +363,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, =
struct bio *new)
> >         }
> >         return new;
> >  }
> > +EXPORT_SYMBOL_GPL(bio_chain_and_submit);
> >
> >  struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
> >                 unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
> > --
> > 2.34.1
>
> Can this and the following patches please go in a separate patch
> queue? It's got nothing to do with the bug.
>

Should we necessarily separate it that way?
Currently, I am including all cleanups with the fix because it provides a r=
eason
to CC all related communities. That way, developers who are monitoring them
can help identify similar problems if someone asksfor help in the
future, provided
that is the correct analysis and fix.

Thanks,
Shida

> Thanks,
> Andreas
>

