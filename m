Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBEEF8E499
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 00:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LhTXHu2o/0hRksqRr1kKj2ceP06H4JzmPwK3UEzxxqQ=; b=rWqnlJ8yIvE20r4E2zQsdAUoOd
	Khqhno5Deq148HhnSJEB7xMMnuWNKgzK2WGRvZXgkhEvMIfUIupqRWkIXllXUNleN/VdCcbNmspdG
	YHXs5GU1sCsGdH5fDC3pz2cEY5L1ncUfrPGO9oPBAq4+CVHuTi7Z+/5JUzpZUPK+9XIauwWilonHQ
	5qVSv/hsDV7qTkn3oHIPE6HLLowdXgT6R4gvG80XqTYffelvE/VFiUK0CEr3WftY5qvkt/z/DhEtB
	/4N5zjNk0xxUuyLBfbYbNrXwaIxliw6mlbUbJJSMapvK3KyiJBXpXnH/LUJAd1nrYWVggCMSrPfiD
	xFjj+m3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDXOy-00000003FN9-2s4p;
	Fri, 17 Apr 2026 00:49:44 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDXOw-00000003FME-28vQ
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 00:49:43 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-66e8cf72a93so131942a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 16 Apr 2026 17:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776386980; cv=none;
        d=google.com; s=arc-20240605;
        b=V+PXVuMTaUb5+5N3CKucYeVojxETXqGZ5YAarI/lSXOO83knO5wog20ISS/OBcbfwQ
         48hawQdFeDC4KJyraZCXJAF8riujIvsu20ZbPkiTfF590+tzIgeN2eY6MJFnfEwKQoqb
         o3qTbwj30kKQ6D/8B47+WwvrdHuAQKPBmzgd2IkLt5A/uCem4H8fg8P+JhkpEWQrNqA0
         6V+HnelvX6/giy/dY5lRd/z/Yxu23tVjFbeMGQZxeoX5pNR0GNTMPQuqqki/ktlImM6D
         mQH7sYeEuLftPnppwSCFLI9APvGIWQh+nwhwfZNkUsRAm3reZOtHU0/WF4+cvMwQ2h0Y
         x6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LhTXHu2o/0hRksqRr1kKj2ceP06H4JzmPwK3UEzxxqQ=;
        fh=/Aydta8Vvat6gtdCKcUU3629iWgZrnF7JvSl11CZw1Y=;
        b=SzzYmyGmh5+pzoWIgx1ZqRyMxPT6l3jZUkPvU1hpUzz9tzHA5mFIynfNiApgtFe7fb
         QTNEGG16T+V7TCFCqxCZbn5t9m6KA2vTglDR+wVshe8rojnAZlIM0J1xK8woIaR84+2T
         i5dPRnSklsY2XxaxIgferkj1rijkePS/Zcj2OQPIQ4rpY0JHaU3nkiWa+UYV0iuWjNnU
         zZ9BU314uIC1oOht2BAIv9aBt5zaBSIlgsrQzFgj9VVWR4JVD9dIOsIeCI6M3TEfxDc0
         bV90xI1klzgsjM6OXLzUV/sShtltzdYR98dBi8sA8vsODcP7cPrHg6CCCYGVoKZIvgwH
         jCwA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776386980; x=1776991780; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhTXHu2o/0hRksqRr1kKj2ceP06H4JzmPwK3UEzxxqQ=;
        b=Tqd/sjuTKPleI1QmtmnUPByUjRzw7kbJX8Jlw7OYFqjJH5Th4hbt1dQjqsJnF7Suop
         ZMqYm0AQnwxk1i6tiJBuJcB9/1aUXNIJuTL9fqSbK7Ges4Aow5wE6xgXUqGt4aQfetoT
         YKCstTaICyl9Xg2e60KTGap0fg1O1FS8h5IMjQxvYJr3Io/XKKOeZoIJP+9qjJAGNs5a
         MoTobsbRHwlzApAwFAGCuofxzztD5EVvedqw36BCkS+Qqj6wTJQefG56rYJAmZpafPZ6
         o5pAMT+xGdlKn/8p5kjIjJthVnFxAqyQexlucWz3SxbSMmzjI8i75YyUUloMmmPo1xQM
         nYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776386980; x=1776991780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LhTXHu2o/0hRksqRr1kKj2ceP06H4JzmPwK3UEzxxqQ=;
        b=r3Dc8WahV9gMxslTTPyB8yGlwrp1tVGhqklyhR8ZqCk52Zd4vspqCPFG5qR49pams5
         XwQS7c0G8/U630JKES+RE0Z7uobmJlVPimWkI5dkwCbiuCEt3A23Ma5WlSxfh5JqEODC
         DLfyMeXreKcW/DLRoyZqoRfGntYc9XAwksFZp9igCkfAwnITTIWn47GkcBIeWgNVfOek
         6zynfBd4XPT7AbBE29QrTqNqydL/LR2ZjYtZelV4WhBDHtemJdcfZiE9kiZ3n90p96uI
         046rE9brTJAnMc7Kydz5tT33KLPbNVfEUyVx3wHFEWyIY89KEQqTWuNxAqs5qk3dvrUj
         o1Mw==
X-Forwarded-Encrypted: i=1; AFNElJ+7ROJnZH/s1XAmfkDtWu9ofMvUszua2xSkvafR1zDgPrFTLrPT/kUnLqva6lVwJpHdN65WQuqktKzX@lists.infradead.org
X-Gm-Message-State: AOJu0YxrAQMoIeh8Uews3O43jFiV9amHB1rSblcowkOyPZMsvsZkXtj1
	4hVR6WGf87vGwStkdON9iynmLtEGOP+JB6u2wvuSzF+7GoVVVsHRzQJjnq3uq/nQzaWGZkv55t/
	VH8TkSI4pMJZGLdpXfxTadCaZsStnxQQ=
X-Gm-Gg: AeBDieutia8nEEKshoni6XFnw0mJm+z/uc7IwGudJsS1WHF6EOZdwTvHPcdvuVr7NeQ
	uaw8hWOA/qxaFhekb111elPa5IIrJrb2ldBnysSTAY2DMyLyAo6Mzwz8hQKdtlStejqIqU5Ymp8
	cmcD7ShKAaB5qa5fNkUAAzBJyYonJpA7WbzOR3GL4W+x4f/Ex4BYCYNObsUhVXKwyrx/HxL1VTn
	fyPVffc5j6sjjOQR3rVpdbplW+REIio7C68X3dgs7Pwu4kcvlzQ1XcfDNhn+iBOsBA5Vm8SLbY0
	OvaTu74MWGfXlkS+iiyXiYScrD7C+vleb2Qw+lrsWkwx3eKF
X-Received: by 2002:a17:907:3f83:b0:b97:e4a9:baa4 with SMTP id
 a640c23a62f3a-ba415ea4a0amr37642766b.0.1776386980272; Thu, 16 Apr 2026
 17:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260415230250.2783414-1-alistair.francis@wdc.com>
 <959f800d-b92e-406e-a174-680fb09c884e@suse.de> <20260416-landlord-encounter-c93f2733de5f@redhat.com>
In-Reply-To: <20260416-landlord-encounter-c93f2733de5f@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2026 10:49:13 +1000
X-Gm-Features: AQROBzDD04mch1uvuQU7s4MjBPfv5sS88qUmjrUElNAPcPcUhgN4y8FZ2cgvOD4
Message-ID: <CAKmqyKOdcv7ojr2WdbNSdkaXQaSuwqmD3daE8yP3JckDpOKdpQ@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: Ensure old keys are freed before replacing new ones
To: Chris Leech <cleech@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	kbusch@kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, yi.zhang@redhat.com, mlombard@arkamax.eu, 
	linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_174942_573890_C7350FA6 
X-CRM114-Status: GOOD (  38.23  )
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

On Fri, Apr 17, 2026 at 1:27=E2=80=AFAM Chris Leech <cleech@redhat.com> wro=
te:
>
> On Thu, Apr 16, 2026 at 08:16:14AM +0200, Hannes Reinecke wrote:
> > On 4/16/26 01:02, alistair23@gmail.com wrote:
> > > From: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > Previously after the host sends a REPLACETLSPSK we freed the TLS keys=
 as
> > > part of calling nvmet_auth_sq_free() on success. A recent change ensu=
red
> > > we don't free the keys, allowing REPLACETLSPSK to work.
> > >
> > > But that fix results in a kernel memory leak when running
> > >
> > > ```
> > > nvme_trtype=3Dloop ./check nvme/041 nvme/042 nvme/043 nvme/044 nvme/0=
45 nvme/051 nvme/052
> > > echo scan > /sys/kernel/debug/kmemleak
> > > cat /sys/kernel/debug/kmemleak
> > > ```
> > >
> > > We can't free the keys on a successful DHCHAP operation, otherwise th=
e
> > > next REPLACETLSPSK will fail, so instead let's free them before we
> > > replace them as part of nvmet_auth_challenge().
> > >
> > > This ensures that REPLACETLSPSK works, while also avoiding any memory
> > > leaks.
> > >
> > > Fixes: 2e6eb6b277f59 ("nvmet-tcp: Don't free SQ on authentication suc=
cess")
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >   drivers/nvme/target/fabrics-cmd-auth.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/ta=
rget/fabrics-cmd-auth.c
> > > index b9ab80c7a6941..58185184478a4 100644
> > > --- a/drivers/nvme/target/fabrics-cmd-auth.c
> > > +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> > > @@ -412,6 +412,13 @@ static int nvmet_auth_challenge(struct nvmet_req=
 *req, void *d, int al)
> > >     int hash_len =3D nvme_auth_hmac_hash_len(ctrl->shash_id);
> > >     int data_size =3D sizeof(*d) + hash_len;
> > > +   /*
> > > +    * If replacing the keys then we have previous successful keys
> > > +    * that might be leaked, so we need to free them here.
> > > +    */
> > > +   if (req->sq->dhchap_c1)
> > > +           nvmet_auth_sq_free(req->sq);
> > > +
> > >     if (ctrl->dh_tfm)
> > >             data_size +=3D ctrl->dh_keysize;
> > >     if (al < data_size) {
> > I am not sure.
> > The authentication variables should be freed as soon as the authenticat=
ion
> > completes; the session key is ephemeral and
> > should not be stored longer than necessary and will _never_
> > be used again once authentication completes.
> > The TLS key, OTOH, is used throughout the session and needs
> > to be present while the session is active
> > As such, both sets have vastly different lifetimes, and
> > I would argue that this
> >
> > void nvmet_auth_sq_free(struct nvmet_sq *sq)
> > {
> >       cancel_delayed_work(&sq->auth_expired_work);
> > #ifdef CONFIG_NVME_TARGET_TCP_TLS
> >       sq->tls_key =3D NULL;
> > #endif
> >       kfree(sq->dhchap_c1);
> >       sq->dhchap_c1 =3D NULL;
> >
> > is actually wrong as we should not modify 'tls_key' here.
>
> I agree with Hannes, and was just about to respond with the same
> feedback.  I think the freeing of the auth temporaries needs to be
> returned to fix the memleak, and the real problem is the setting of
> tls_key to NULL.  That doesn't seem like the right lifetime for tls_key,
> and it looks to be a reference count leak as well.

Yep, agreed. Patches sent to revert the free and remove the
`sq->tls_key =3D NULL;`

>
> Is the presence of sq->tls_key the best check to see if the socket is
> currently in a kTLS mode?  (it might be, I'm not as up on the target
> code)

I think it is correct, the issue is just that we are setting sq->tls_key to=
 NULL

Alistair

