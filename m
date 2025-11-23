Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C99CFC518
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Nov 2025 03:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sSUmOlF3E259ASbJ7NKM/1Z38SFWeY0yp8l6jgM+Ktg=; b=GMWHLxRKbd9TOWFLbS4Cm/uDob
	43FLYtAfWir6LRtotjK2eTsOHiYJ6tG/eaS32MNJq/lDWdRkOuMkX6H21HsambwhBPTXEG05dYc7Q
	3SfOR0h9wX3dUT1WgBBifouKPfluU+RJRaDt4qsMyWSlzmJ0eI85AM2O4fGKwE8qUdSWaOgPE+1tc
	YFuK7bdXM5RKCVDtP7ecykTFr5UeSTH9idE14QOXgezn4oUKk0Z3DQ/9NjxN9jM5t+Etn/s/vo6Br
	c69F/EHPibDBKMsAe5CRtlf/nSvtH/a4QowAoVvebbbJ7aEtZvY9RUguHFwMgZWELjgXzhEbzLjlj
	2wofv44g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vN0Yv-0000000A5pH-2nSV;
	Sun, 23 Nov 2025 03:14:53 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vN0Ys-0000000A5oY-1ojn
	for linux-nvme@lists.infradead.org;
	Sun, 23 Nov 2025 03:14:51 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4ee19b1fe5dso44769541cf.0
        for <linux-nvme@lists.infradead.org>; Sat, 22 Nov 2025 19:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763867688; x=1764472488; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSUmOlF3E259ASbJ7NKM/1Z38SFWeY0yp8l6jgM+Ktg=;
        b=HtE/c/gCVfbAGOsHn29mBTwJfosMdBG9Ib0kSaf0QSULsAPqIaTAGVJXqWTsn357+6
         J+/XGgYRUJaIqnN32QOQvmqQYRYsLLYi4jYS+oSVdKcQDELBYLq9itxS0yyWKQzhVH5y
         WyaYvwX6gsn3Ncn1790ouXtx1VsK0o5POqg0lNjda8bRvv9WtAYQjV9i58pmigl84fVZ
         MkAmOi5RL5EiiqgKEPG8rxHywzNXATuWjmAQuhdgOZCnkqPFVDOnJEXR0GNPuQqsCeSd
         Fa7rdDvrwx/ytNaC4tLgUrUmX3Xck+RA533FSvsvIyR1o+e/rRcPVIrPDcJ6dOrLxNnM
         aR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763867688; x=1764472488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sSUmOlF3E259ASbJ7NKM/1Z38SFWeY0yp8l6jgM+Ktg=;
        b=MNb8Yn5hv/MxdntHLfyAf8/u4wDdHo6kCtfp6Y+tQMoPf1p1o8SOvoyfZEu4CuaETM
         iEH3UwhQdwa01zqiN38TJTlcND8XxzZCN8Xq+OpfNGJsDSWNJ/UXQgcEAiQk9MlIxHVT
         DdeNJVDcDPgT1gEEGZa7mW6Ez2iPI2q3XhqBB/WrB4ayiZZC59LuFdA3G7qh471JFkzT
         /CkGqY39IZlPxCxz/Zmx5/C4K9WiE4x+mFHrsKu/au8IUH1V1enBx5eVhThk9Tl+pHfn
         OVLStTApRKrivBts4QIYPMIHctoCwsY0os/OtMFZfRKuMhi9/cJP8TUhJbjg/OXI19pC
         Btpg==
X-Forwarded-Encrypted: i=1; AJvYcCXVp6yt0of6mixdtjLGij9+005Dsk3kddnf7z/0NAvsMOuT/hpdJ4lVDhFhZAUNk4Lns4X9xsdarY6F@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/Cusx8VfilchBB7ucySvdsGOrTgX4Xi7k79859jCKGskaI20I
	ceOpgxAgFnv6DHcCcNz8d5bM0kcnCVXKl6a7B6FxBUF62gXcRjZVrOW5xp3e1mpKchrH0yspqI0
	5JhGPd1ksrip90dXj//lLm4yUAvP9TbE=
X-Gm-Gg: ASbGncspIibGDyUsvv+qFTHF50rDDPD0ojTHrvzALSfTziP0Y80wSjikQ4jaIpMMH0H
	va9YqSqsrT37PqrYJiFcBbnps8RSssO4R49xqddxNjj/ImElTnKY5ZALffnb4afSnHqqDHIyDjT
	tuLooNZqorhzjp+V1mQ31uH4U16qkj9cCLbPGx5CUNNYUm1xW809Lasws1uuD8EC/NXQ8KuHmT3
	YzFA/ldy/fHLIVBEES60U7996Xm3aOD43ZuO50hb1mD0MhtFr8j6D+jAAuA6TjJxIhh2t0=
X-Google-Smtp-Source: AGHT+IGdga/kzhdwCVG7yVfSoR3Y4Mpj0tXp1Phothz1pnN4zZDpqFPu9X4DmFfSbiDItMnyiKDLP9Ui4prcpSBpeyE=
X-Received: by 2002:a05:622a:409:b0:4ec:ef62:8c81 with SMTP id
 d75a77b69052e-4ee588cb739mr81789031cf.47.1763867688428; Sat, 22 Nov 2025
 19:14:48 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSEvg8z9qxSwJmZn@fedora> <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
 <aSGmBAP0BA_2D3Po@fedora> <CAHc6FU7+riVQBX7L2uk64A355rF+DfQ6xhP425ruQ76d_SDPGA@mail.gmail.com>
In-Reply-To: <CAHc6FU7+riVQBX7L2uk64A355rF+DfQ6xhP425ruQ76d_SDPGA@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sun, 23 Nov 2025 11:14:12 +0800
X-Gm-Features: AWmQ_bkhV3WFHcWH6ezrZh5TyYLHctF2XYDfyBPe3dT3HiPXGugPAFouComClV0
Message-ID: <CANubcdXOZvW9HjG4NA0DUWjKDbG4SspFnEih_RyobpFPXn2jWQ@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn, linux-bcache@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251122_191450_484951_33061BB4 
X-CRM114-Status: GOOD (  21.46  )
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
22=E6=97=A5=E5=91=A8=E5=85=AD 22:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Nov 22, 2025 at 1:07=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wr=
ote:
> > > static void bio_chain_endio(struct bio *bio)
> > > {
> > >         bio_endio(__bio_chain_endio(bio));
> > > }
> >
> > bio_chain_endio() never gets called really, which can be thought as `fl=
ag`,
>
> That's probably where this stops being relevant for the problem
> reported by Stephen Zhang.
>
> > and it should have been defined as `WARN_ON_ONCE(1);` for not confusing=
 people.
>
> But shouldn't bio_chain_endio() still be fixed to do the right thing
> if called directly, or alternatively, just BUG()? Warning and still
> doing the wrong thing seems a bit bizarre.
>
> I also see direct bi_end_io calls in erofs_fileio_ki_complete(),
> erofs_fscache_bio_endio(), and erofs_fscache_submit_bio(), so those
> are at least confusing.
>
> Thanks,
> Andreas
>

Thank you, Ming and Andreas, for the detailed explanation. I will
remember to add the `WARN()`/`BUG()` macros in `bio_chain_endio()`.

Following that discussion, I have identified a similar and suspicious
call in the
bcache driver.

Location:`drivers/md/bcache/request.c`
```c
static void detached_dev_do_request(struct bcache_device *d, struct bio *bi=
o,
                                    struct block_device *orig_bdev,
unsigned long start_time)
{
    struct detached_dev_io_private *ddip;
    struct cached_dev *dc =3D container_of(d, struct cached_dev, disk);

    /*
     * no need to call closure_get(&dc->disk.cl),
     * because upper layer had already opened bcache device,
     * which would call closure_get(&dc->disk.cl)
     */
    ddip =3D kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
    if (!ddip) {
        bio->bi_status =3D BLK_STS_RESOURCE;
        bio->bi_end_io(bio); // <-- POTENTIAL ISSUE
        return;
    }
    // ...
}
```
Scenario Description:
1.  A chained bio is created in the block layer.
2.  This bio is intercepted by the bcache layer to be routed to the appropr=
iate
backing disk.
3.  The code path determines that the backing device is in a detached state=
,
leading to a call to `detached_dev_do_request()` to handle the I/O.
4.  The memory allocation for the `ddip` structure fails.
5.  In the error path, the function directly invokes `bio->bi_end_io(bio)`.

The Problem:
For a bio that is part of a chain, the `bi_end_io` function is likely set t=
o
`bio_chain_endio`. Directly calling it in this context would corrupt the
`bi_remaining` reference count, exactly as described in our previous
discussion.

Is it  a valid theoretical scenario?

And there is another call:
```
static void detached_dev_end_io(struct bio *bio)
{
        struct detached_dev_io_private *ddip;

        ddip =3D bio->bi_private;
        bio->bi_end_io =3D ddip->bi_end_io;
        bio->bi_private =3D ddip->bi_private;

        /* Count on the bcache device */
        bio_end_io_acct_remapped(bio, ddip->start_time, ddip->orig_bdev);

        if (bio->bi_status) {
                struct cached_dev *dc =3D container_of(ddip->d,
                                                     struct cached_dev, dis=
k);
                /* should count I/O error for backing device here */
                bch_count_backing_io_errors(dc, bio);
        }

        kfree(ddip);
        bio->bi_end_io(bio);
}
```

Would you mind me adding the bcache to the talk?
[Adding the bcache list to the CC]

Thanks,
Shida

