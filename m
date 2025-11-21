Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D42CFC28F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 16:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hh93R5tPjAC6W1rTnWq/i2ZvU4feR2Tgy6yZhs+i3/0=; b=wvGJgeycZJFGQk/gzfj4ZR3gTX
	3HMQgKHtQx/ACrLWJ9/Uy/ofebeuTS3wAH2UGEfuo6ZhY8EyiCx4mFqNGdkoymc0lnOpEsoaFZbL/
	mQXIu2kD+0li1xsIbW4HZxaJiaT5g6BVqrOZFfFJp1asMZTn2LCZD3CvNlA95oR5Dh5FbTRTO+N/J
	Q7nrM9ypSc27oGpgng+cnkoKA2MznfaHGclGTFD4v9GKUey/BKDBCK1zWWJKArzdruLiPyXeQUs0m
	B1AEq7X0CkRHsENtOVkcDdG5LL/jvOTqU83Al+qG0cWKHVxJ7EEF1A5x6PHBqjRE9vlxGAAJU7iS3
	/LT771Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMTlf-00000008hDo-35NZ;
	Fri, 21 Nov 2025 16:13:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMTle-00000008hDi-1zPo
	for linux-nvme@bombadil.infradead.org;
	Fri, 21 Nov 2025 16:13:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=hh93R5tPjAC6W1rTnWq/i2ZvU4feR2Tgy6yZhs+i3/0=; b=S5/p+e705Jc6W14C9PLVVs0z0y
	NsLtdglqOlv9pW0bkvkaknf3wmnvJ3f+GmovzoJbQW/CdLpfAiEi12w7kjYsDC4Ebfe8Txf4sCiW0
	z340gZyv2FXLO0HnmH6//nE2AJha2ojMNQqKtqJPuXlCqxzeUhrUL7w5RrnMqWMdADjVoxwDgVqwK
	YhVSDzd4I6ZL/gLbj2LTxCT9Hq/TxPOOJyOtmJt1BGHm/Cb2FgWmOcP8/m4YcLdftidCO8UmYoFnp
	7N21KRX65xTcYttGdFEtlZQw0HB23lzOlrk5GKabPxvNW+8YJnHtmtQe0S5DybGuYoxkLTlGMqres
	msvaxzug==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMStz-0000000HC5I-0vWe
	for linux-nvme@lists.infradead.org;
	Fri, 21 Nov 2025 15:18:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763741616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hh93R5tPjAC6W1rTnWq/i2ZvU4feR2Tgy6yZhs+i3/0=;
	b=iq5ZtkutUGVMco87IEC0Q3etvm4rU/AdKhiHa24FdKQvfyN7gKXBgVLzM1idPgJtVTHK3C
	nJCn5UGY6wIg1ACJBvbZhEl97imErHihYgivy85UOZOhgH6Rq40s07NqbHkL4ow2jfH245
	MJ912EBlL1kN/I3iDJfg9JZVMcxCyic=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763741625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hh93R5tPjAC6W1rTnWq/i2ZvU4feR2Tgy6yZhs+i3/0=;
	b=VattK0Dym/nxRNrTXXxomvk3Rmg/qTq5UThSp/Awmid9yQVxTjltOgQzYpAeR3p8h04xVT
	NLGI7IWkyINBNKN5yJ1xDH0nz9gEPft/JmWeEWoOmbYVFlOTz+BFc2lZYWPgKHSm0bNpqy
	jv0eHg69EtT6P66SLfqkjAuhJ5oFxZQ=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-n0arO-2DO26ixIJn8eWfSQ-1; Fri, 21 Nov 2025 11:13:32 -0500
X-MC-Unique: n0arO-2DO26ixIJn8eWfSQ-1
X-Mimecast-MFC-AGG-ID: n0arO-2DO26ixIJn8eWfSQ_1763741612
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-63e3421b8f3so2705779d50.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 08:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741612; x=1764346412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hh93R5tPjAC6W1rTnWq/i2ZvU4feR2Tgy6yZhs+i3/0=;
        b=TqdKqq8xo0FIRbVmYg2SU9Yu+r1CjevEJB+wYY8DZNZMrxPriBp/Uphnet1u38HuY0
         zmb1I2YdK2mrPuVNLxgVvB4ra3R6snA/YAaqvkkfrfhQNAY5mHvxiSwMyUIff9/M+q0J
         u3yMWkolb7JOdJxibhWs6KDhkjbEEbimCmHcLuhJ+urqEL3aVA338ND1uEHJE37BoBmo
         ypekqTzav6OnRxFE7Hd2oPp050xdf9Z/H4ECcnE1B+u4AooIhQWgXNF2FyKwXB7qwWNh
         b1XpfSlREnVrNEa+NajnR+ztAChOySXchle/NhB/1dwu4q+XcppLQFuu6a+NQ9YVAff4
         bVLw==
X-Forwarded-Encrypted: i=1; AJvYcCWo6FyAqHRyw+lMfRLaMRzJ3FuhHBrxntsEx/S56Hx6479JlrnzN6RQAZ+nAXLi/AV5RRR4+VodnKjr@lists.infradead.org
X-Gm-Message-State: AOJu0YwnUAKc0huNG/x98wEnjnS740Q4lDUWOvLmf3M9RYCZzTG/9GP5
	EkP+d72KWZj3RATSO67Hcc3eJ+PRR/BX0id9MhVIJ86gXdsYkJ11LOqH9cDnH2uT5N77BOMYF62
	O6BTiHVlabKn/kHxC2vUgC9s5EY7EWS/SvZIL0YUsWIT8adOov8EeLfeDS9gikqygsFuCWJiW4E
	xjbtQOMf2D0fWSGtsflvxyYaiDRjsp15JZeZsZ8JMP8ok=
X-Gm-Gg: ASbGnct6btRmVrAuYc0Bp//qfjPOk0QJkJZOqHdC0TtZi0Jlur5SxXnt7xC8VknKA0M
	8LwU7IgMqP9re8PKuDGo8qrlapna9rkqlinArOkTq3tFwtw73xaqF+U6cMDRavNBQ63d+NuXxvf
	SHRxQmWN9zi8mEwYecwgn9tHyfGyVeU73aVcG76CmghhEPEjWWpdQkj1tkWWfoBVxL
X-Received: by 2002:a05:690e:1699:b0:641:f5bc:6979 with SMTP id 956f58d0204a3-64302b122d9mr1963770d50.85.1763741612187;
        Fri, 21 Nov 2025 08:13:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQHJg27kBmo+3qPSDwMS0FzdloscgwgQdqDmCn0XCLoSgo3nmRsjJwwBETY525KvvMg6grxlgTavlZWQ/uK4U=
X-Received: by 2002:a05:690e:1699:b0:641:f5bc:6979 with SMTP id
 956f58d0204a3-64302b122d9mr1963750d50.85.1763741611792; Fri, 21 Nov 2025
 08:13:31 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-2-zhangshida@kylinos.cn> <aSA_dTktkC85K39o@infradead.org>
In-Reply-To: <aSA_dTktkC85K39o@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 21 Nov 2025 17:13:20 +0100
X-Gm-Features: AWmQ_bmosC4btoZ-wa-ksr6NsYAdeqQOhz6k6QYvia4F3jK6NJjmea5Iy6uFTHo
Message-ID: <CAHc6FU7NpnmbOGZB8Z7VwOBoZLm8jZkcAk_2yPANy9=DYS67-A@mail.gmail.com>
Subject: Re: [PATCH 1/9] block: fix data loss and stale date exposure problems
 during append write
To: Christoph Hellwig <hch@infradead.org>
Cc: zhangshida <starzhangzsd@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FV7K802ikU9qNNXsoR-SRm5mkE1AIfAw_AaD-LbAptY_1763741612
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_151823_418321_ED0ECD59 
X-CRM114-Status: GOOD (  17.73  )
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

On Fri, Nov 21, 2025 at 11:38=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> On Fri, Nov 21, 2025 at 04:17:40PM +0800, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  block/bio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index b3a79285c27..55c2c1a0020 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *bi=
o)
> >
> >  static void bio_chain_endio(struct bio *bio)
> >  {
> > -     bio_endio(__bio_chain_endio(bio));
> > +     bio_endio(bio);
>
> I don't see how this can work.  bio_chain_endio is called literally
> as the result of calling bio_endio, so you recurse into that.

Hmm, I don't actually see where: bio_endio() only calls
__bio_chain_endio(), which is fine.

Once bio_chain_endio() only calls bio_endio(), it can probably be
removed in a follow-up patch.

Also, loosely related, what I find slightly odd is this code in
__bio_chain_endio():

        if (bio->bi_status && !parent->bi_status)
                parent->bi_status =3D bio->bi_status;

I don't think it really matters whether or not parent->bi_status is
already set here?

Also, multiple completions can race setting bi_status, so shouldn't we
at least have a WRITE_ONCE() here and in the other places that set
bi_status?

Thanks,
Andreas


