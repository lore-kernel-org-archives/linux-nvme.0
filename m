Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF958CF64B1
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Nov 2025 07:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TOU5zUa9ExH2UPIf77XppaYiXONJBt1V6maHsn7ikzg=; b=EfPN65lskRnAdqPmISGIhYLLoH
	z3k9bABNomRPZRhUqwGBn4Ap9/gqIVSJ0Vd6+8owooXmDHmBkWoUrkdAxCB3IUnIOlTYr9IS/qnUU
	TJn7+4cyymP+I835lJeBKAFdNZ5tijIHw0JIlJ4yoS4lNJeUIXklufBoxeqY5xtSSayrZyTSfJEaT
	vwqP6/ebh6XkwYAer4rk1wU+uX/KE92BZtQae94BwO0/RMhaL+yTowEDYc7web/bl33t0RUwS/45U
	gQ6lrwKP9cAuGV43Tqe1fiOZwi4UCsNwURCH50YfOqJ0GUqSNYCw007eDG8oXb59buQSY7tXaaVDj
	lZT6i0tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMhkF-00000009KfT-07uz;
	Sat, 22 Nov 2025 07:09:19 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMhkC-00000009Kf1-18Nn
	for linux-nvme@lists.infradead.org;
	Sat, 22 Nov 2025 07:09:17 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4ed75832448so36761111cf.2
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 23:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763795355; x=1764400155; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOU5zUa9ExH2UPIf77XppaYiXONJBt1V6maHsn7ikzg=;
        b=VWuSRA5TOwBxXzBgI+se6Kdhjec8JyFgc2PUyQKRaioKmbByNgGkFY1cBkTwtDKKOh
         uXeuTfJzvovhhvj08qsZQlwZgwpfFxemxC/m7bhOa7sTpJV+hV8M572fxo9Nkvcymk2A
         3kfxhxKv9lHGG/qwBt6jeBEQ+KBNrjMD0a7r14c7tzLnREPjwt++O3enFSQ8eip9b9um
         vLUcRVrghz3SmS28THcw9yUCMf/PyDI4JnIc0ETTY4f3MU5Ip6UvfC0rZ7++qUlLuhv2
         FrrPlUTjJKUDwcGsTLBOcGgPkfrgosIYAp5Dy/LNZs7sO+TG6pMZw0kigWchHAU4+S0r
         HRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763795355; x=1764400155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOU5zUa9ExH2UPIf77XppaYiXONJBt1V6maHsn7ikzg=;
        b=EGmXKYH898JNqNfeq4bxKxvy/tR0XFj13RN4H3tSqoCnTfG8iHBBIb/MtLjAQ26Ixa
         qVFHsymnoDNFEsVF9dsNqmWb2ZLzUMA8DZM9WaMWqWDPXScE0MCy9HfQk0SMeYkzdytd
         8VS7WUHe2coWUobEWJ81vj2FEjtMCXFE7vSD7/Amu5sV85gNV8YBFLo0ZiBPHqhv3wlo
         D/ph7CbQEvrYkluxfZPz/+uGvUuJS9fULLZGDTPtf5A+3XO4vBZDLCMeEhaHz/Jlp+Pk
         Zgy7kVfeygskBHX5APcjMcmyob+gbF/J3leilpaPRm3d9odc5j8NPz43UBscAdAs9ZUn
         YeXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkcXD84RaRi6VNfOzLZwySVNzhmarJtB2V+7b4pG1c2xL2thGL9s1d4y73cY8aZpgO3VyZYN2uJ/hv@lists.infradead.org
X-Gm-Message-State: AOJu0YwMpSiu3lSnVaLt3m+xGiRcsPHK0eFiOetj8bR+ei0Ne0+0LBtI
	wywQPMZgbzjGAc+JYwNkLUkkioz9RX+pGDR+Pwmk84R7mT+d9vaTZn8wiUGUmkCo7tIMoXkGgnU
	qa66owpnvLkIUn8e80e/Ff9LIFPVlxNY=
X-Gm-Gg: ASbGncsp/3gdQoFs49Ww3DVAB/67CrD5+Ko7WY0SpD/kHAvVTfyzX725ifghHgQ1dve
	dwWCpjx+vrRBBvJRHEdUJUOv38IAkdvczaePTU65RNOZGLzW8qjof5w4RhBqdDH/ruC2gXuDLUp
	SMHVcEkRf6/awCbYzKFOqoFvL+/OV/eTOrzDYpFue153T9nMvrfAleuIpP9wfWGaDzvRDAlrhAW
	gT5KVb4IOKDTgflgZDmtXR559EkB9IvJXizhxm4OU7LuXpmWsO17KMs81A6LHJoN+068ZE=
X-Google-Smtp-Source: AGHT+IH732VY2HEOL1GTjGnjiDpMpgHpw4qhxelOjeL0bgVDWuC8OicLazoWJuAvAFEObeAlgbjBNJsbaZaVBgshjVg=
X-Received: by 2002:a05:622a:1207:b0:4ee:1563:2829 with SMTP id
 d75a77b69052e-4ee58b04a99mr71664381cf.72.1763795354707; Fri, 21 Nov 2025
 23:09:14 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-2-zhangshida@kylinos.cn> <72fb4c90-0a75-43df-8f5a-154d9e050c09@wdc.com>
In-Reply-To: <72fb4c90-0a75-43df-8f5a-154d9e050c09@wdc.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 22 Nov 2025 15:08:38 +0800
X-Gm-Features: AWmQ_bkaHk0wh-SvlSCw46Rlr82grFve_Y0_m2bfS2qbhv3bWWgwLzC0W1VLkPA
Message-ID: <CANubcdVx3MkWwncj1S0cS4FN+Stt8FpHD89dCFeStsd2QE=2sg@mail.gmail.com>
Subject: Re: [PATCH 1/9] block: fix data loss and stale date exposure problems
 during append write
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>, "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "zhangshida@kylinos.cn" <zhangshida@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_230916_334927_901D60EB 
X-CRM114-Status: GOOD (  15.05  )
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

Johannes Thumshirn <Johannes.Thumshirn@wdc.com> =E4=BA=8E2025=E5=B9=B411=E6=
=9C=8821=E6=97=A5=E5=91=A8=E4=BA=94 17:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On 11/21/25 9:19 AM, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
>
>
> Regardless of the code change, this needs documentation what you are
> doing and why it is correct
>

Okay, will do that if I can get the chance to make a v2 version.

Thanks,
Shida

> > ---
> >   block/bio.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index b3a79285c27..55c2c1a0020 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *bi=
o)
> >
> >   static void bio_chain_endio(struct bio *bio)
> >   {
> > -     bio_endio(__bio_chain_endio(bio));
> > +     bio_endio(bio);
> >   }
> >
> >   /**
>
>

