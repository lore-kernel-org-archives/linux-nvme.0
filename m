Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C33C04FFE
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 11:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ugYbuQy66dmJdHI5/jJJSz0mg+CSnItI/sgTs6dvk74=; b=e0fmfmn6ksw47wu2fWK2z7r3GP
	Rk0Nc855CLUrpwa2WvwpEDJqudNPbPY8lIeb5pQb1KWmrfEqTSPg9S2lG9xW1RfWdVIgzZ5HVaOYc
	fKP5tvMX8Dk+vzpIMdV032zzmxEq+tuEDlAaqlNwMlFXZNZyW/Hi1t8RE9yhYa+U0DM0W+/svAe2+
	F73vZXLswrl81Xb5uam0+kpHCXJBgg2IxRaHmTthOhlQm6wjg6y184iepmoydtF5BBlhWUHkykZpY
	mulEz47L/KCLD8BujjqXr4G2At6KdtXiiRQhtKR/zaw6ZfUweLvAvrKr3EjgsmeSHEd52nh8CP0S2
	xxWJPdyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5kok-00000007nBV-1fj4;
	Sat, 11 May 2024 11:23:06 +0000
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5kog-00000007nAz-0VBi
	for linux-nvme@lists.infradead.org;
	Sat, 11 May 2024 11:23:04 +0000
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5b27ad74c40so1278177eaf.3
        for <linux-nvme@lists.infradead.org>; Sat, 11 May 2024 04:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715426580; x=1716031380; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugYbuQy66dmJdHI5/jJJSz0mg+CSnItI/sgTs6dvk74=;
        b=MbPVWIWiaX7JJgeFbAWfha0eUsa3HB1Z0XMlTT5VW6oKPuHPg+ve8Spr4xq+j5vPe/
         wJfQ681AzyVGcJLXUgucxStERYswplgNyV2tIZNEFlh5ZRLp5cLk7fZ4KVV25x1NNinE
         u6W+4Rl4Wprm6eiyNRVZVmHInXjqwLvuog5aZy66+6ePeJocTM65iCOZQfHjh+jArFDt
         OAcGYg2iE6gEb3psz5dtTM6oEPgJ4Yb/oEcfsUFzt/zJMNxF21DewUW7cFyHKIEe1Kqb
         uuhtTNukB6Jp604BJBstAXy/XgQj1FilgOsVReX0OjlHoiMJAsEXKOWelilhJY6BkvF/
         r18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715426580; x=1716031380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugYbuQy66dmJdHI5/jJJSz0mg+CSnItI/sgTs6dvk74=;
        b=q5hmFjo0pO85i4Edf880S2yuHEv5Bv7WFP3SgQUTsNeiHgYsh+4gVVglgvh5eatOkL
         BViv8RZc9lp6VUybka+BWq+5I34U6UFx127zfCgZ3B1LOdYL3iBSNSfImAKttnVWFGAw
         xaKrFFwQ1Jqu2HhGGpYPy+6U0NHr4rCBxr63UYr2VokIRCS+SfTeyclnhk3/cO1mjpnr
         qCd0Ubz/SpiqGG+fhU4XkCEVQZP3HFH74iKUo0G4crv47220zQs6xDmNzuJE4ffAgYku
         fM4m/he8z6+saq3mC29cQq/UHYTp6/mDae0GmRH8qI977xa5T8uFQ60tQXPKnNrZVOyf
         1SLg==
X-Forwarded-Encrypted: i=1; AJvYcCWk4gRReNdOnzG5/h2/+mdEyu6L218+1WQ16Hn20ZXW9ynov5Y4BPuZlplBKeI/IGosIC5smVwoD1zfkp0MuaKgYmdUIhHyCY2mT4Zdr7I=
X-Gm-Message-State: AOJu0Yx3V31xu9oI60XVEEIrkwueeHePymZ29iwP8C5UsR68MhC/9Ndn
	05iBVC4iv+4TeYtdPRltjV9sdJ9NpYpP6WoDq6BimuZ6s+recyEdwNZ+2Zzdhce9gGIhKv6O0Ob
	5N8i9AmHARORcbIWY9OGV2K5jhA==
X-Google-Smtp-Source: AGHT+IH0HqrR5xD8T7Jda86pTOYxQRGn20hm5hY2YNnq/Ty4H5xyl0QD9Bv4dWHY93IlQ7AG63J7WUGrHGA8Zkd+O98=
X-Received: by 2002:a54:4407:0:b0:3c6:d9:2c75 with SMTP id 5614622812f47-3c99707215bmr4762818b6e.30.1715426580344;
 Sat, 11 May 2024 04:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20240510095142epcas5p4fde65328020139931417f83ccedbce90@epcas5p4.samsung.com>
 <20240510094429.2489-1-anuj20.g@samsung.com> <Zj5t9TwrT77KGOyr@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Zj5t9TwrT77KGOyr@kbusch-mbp.dhcp.thefacebook.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sat, 11 May 2024 16:52:23 +0530
Message-ID: <CACzX3Av9JUPLeR5j++yvctgES4UP7M17PQZh37ByZyBP6BemTw@mail.gmail.com>
Subject: Re: [PATCH] block: unmap and free user mapped integrity via submitter
To: Keith Busch <kbusch@kernel.org>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, hch@lst.de, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	martin.petersen@oracle.com, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240511_042302_283924_86367702 
X-CRM114-Status: GOOD (  14.35  )
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

On Sat, May 11, 2024 at 12:31=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Fri, May 10, 2024 at 03:14:29PM +0530, Anuj Gupta wrote:
> > The user mapped intergity is copied back and unpinned by
> > bio_integrity_free which is a low-level routine. Do it via the submitte=
r
> > rather than doing it in the low-level block layer code, to split the
> > submitter side from the consumer side of the bio.
>
> Thanks, this looks pretty good.
>
> >  out_unmap:
> > -     if (bio)
> > +     if (bio) {
> > +             if (bio_integrity(bio))
> > +                     bio_integrity_unmap_free_user(bio);
> >               blk_rq_unmap_user(bio);
> > +     }
>
> Since we're adding more cleanup responsibilities on the caller, and this
> pattern is repeated 4 times, I think a little helper function is
> warranted: 'nvme_unmap_bio(struct bio *bio)', or something like that.

Makes sense, I will add this in the next version.

Thanks,
Anuj Gupta

