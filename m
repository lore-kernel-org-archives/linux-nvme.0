Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EE8CFD2F6
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 02:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rihsM/MbquITk52HblBTEqieTE9a8UregXTIhN3Xc4g=; b=cUgQHzMKoxpeIxBOxFaHSpxEp/
	YjFPu25UkoEHJW8GBes2wgnaYdPfRHB8gceHgNyzjzk5W4zTH0pBSrys6O2r7DFpvICzd2yDhfQBR
	Aqtcze6V/Ll070dXZXR5xfFnHG/SpC5rgSvyNRwe7ZLmj3qwZlncQfgFtzAZ4yvpiFutCgC5Lf2iL
	rcIlqN0NI99VpqaDCpgeNHVfq6A4jJD+oiTIsIjKMCTfLcsPAaNtcwcYVi9O39CVKVGy5cMKZGQRB
	PqjL5WvtmrXfEIwwG7q7s1NC5CDr3RE9L54wdQ88OHRHouYmeoE36EJpjSsmA9u60CE+TuZ7WWedt
	ncZVEHug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNLtL-0000000Axc2-083U;
	Mon, 24 Nov 2025 02:01:23 +0000
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNLtI-0000000AxbY-1ZYr
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 02:01:21 +0000
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-8b3016c311bso480365885a.1
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 18:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763949679; x=1764554479; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rihsM/MbquITk52HblBTEqieTE9a8UregXTIhN3Xc4g=;
        b=W4TCebNPF2sF9LD7R9YiqDnB0xLSI2y++0e/7TSPqBHZZJON4pdgmZNJ9mCUerpWZt
         5eaiVseXDxJUZu+ko9DZ3soSuDVy3Y9EfyMfFRYITjujtxgi+EWRJF1hKfnJsywJz8Tq
         Lv9wJHT5RHNyDtXtSksaGog79ala+lTuuTIYBty9xTJikdfPiKWzpK4sCCM0HoRE5yM2
         6F5QIFNl01aDUyrZZZIWzjfXDyYL7WI23mUnk1vXUMeamxn2bjkmLdyAqrWEmTMRNBWi
         QE1gszvbih1FP/QAljarHmNdD4p9DSzi/crR9VMuhIE76rjFwoZoWxj/fMLB0b9fNZpH
         8+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763949679; x=1764554479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rihsM/MbquITk52HblBTEqieTE9a8UregXTIhN3Xc4g=;
        b=XP2pS5VtF98t/lM2z7VyV+0lvooZzRMWXbtKPwru0niXCyO4X0/K1h1/xRduPk7xnl
         rqloszsGKOKHYNaM6PSM2YWBsjl5JWptdHnIcxo7mq9pj+XNg9BGm+ReVaFKtKoEmf8J
         iEHJLfe4/7P6MgSaj6VOFTpv0OtsNTN2Y574OquW/5CXeIlLB9K8TzVxcf6EwBG4OxTt
         Jn3S5rarkOydZ3I8//JM3endFj70sfumK7qhUEBSLgOhJOtWhrz/A58uI8p0WiPZlXyC
         mUvEiyOMxFkO6X2qi8greGI/5cok+cDV6+wOlzuBq91WAX8Rm3bSjVkJ52wo9UplKbEC
         I5JA==
X-Forwarded-Encrypted: i=1; AJvYcCXZjfy9MDIE9WVoaJKh9dGgydcAYsDoNtSemyhp+cnTE9QV8AYAV+aBgGujcKq3xBY0TKW4MxHJoKt+@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6kV2O5YKIjUdWXJ3uW+lvFJcS8A4wVaiwO5PaLP7ty+/88sKZ
	7I4VjW8vemSXyddEVliU/Nvaba45xAmetWpX4MXDBElSNY6e444wZFQTqRgqT8uzCvdzhg9p8an
	pyzLbHGuI0EJXHPcqn0mst0E8GwWYfRo=
X-Gm-Gg: ASbGncv0gSoKRTcmi1BhHDlNq0gkMgvSqwxH7ppepD9BEQh+GI5x0kEnNw8mo8JYyCu
	5xV1Wwu5VM9/oCLn1r7TsQOGWeIvgsL3xzjSLaa6Z0ahKwGfuejSwomxFoa5Ra+dNbXG2lPO84m
	ag9b3K80yki5/8pDBY0vgGcR4/hjanXceTnNCzL9lurDKozLDAGWMPgxgaIYcgYtmjmIiZamsj2
	sqVgtwu9VJDjg7NiQ0jvlxslKhwl3p8o1pzeO5gkuwKyr6QuccmyclYmZObFUtDZ/BNar4=
X-Google-Smtp-Source: AGHT+IFK0j8LOMDrS9m/1v8ASo3ky7d0+WiDpTykg8BeSrWtC+6aSCAuT2UVyteglGE8TJ8JAm0pjMBxqVbt9nw2ETI=
X-Received: by 2002:a05:620a:4415:b0:85b:8a42:eff9 with SMTP id
 af79cd13be357-8b33d4a706fmr1352114785a.53.1763949678764; Sun, 23 Nov 2025
 18:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSEvg8z9qxSwJmZn@fedora> <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
 <aSGmBAP0BA_2D3Po@fedora> <CAHc6FU7+riVQBX7L2uk64A355rF+DfQ6xhP425ruQ76d_SDPGA@mail.gmail.com>
 <aSMQyCJrqbIromUd@fedora> <CANubcdX4oOFkwt8Z5OEJMm7L5pusVZW0OaRiN8JyYoPN_F0DpA@mail.gmail.com>
In-Reply-To: <CANubcdX4oOFkwt8Z5OEJMm7L5pusVZW0OaRiN8JyYoPN_F0DpA@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Mon, 24 Nov 2025 10:00:42 +0800
X-Gm-Features: AWmQ_blmSEmZQDursBh3YUhqjicM04mA6N_YKxn2rH4yPFBEnFOKPn_NEARJprU
Message-ID: <CANubcdUG_3VwagV-cSfhp4+95Dj_e-wkxegzCdmuNieWqrehug@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Ming Lei <ming.lei@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn, Coly Li <colyli@fnnas.com>, linux-bcache@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_180120_446529_1C582702 
X-CRM114-Status: GOOD (  23.96  )
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

Stephen Zhang <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8824=
=E6=97=A5=E5=91=A8=E4=B8=80 09:28=E5=86=99=E9=81=93=EF=BC=9A
>
> Ming Lei <ming.lei@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8823=E6=97=
=A5=E5=91=A8=E6=97=A5 21:49=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sat, Nov 22, 2025 at 03:56:58PM +0100, Andreas Gruenbacher wrote:
> > > On Sat, Nov 22, 2025 at 1:07=E2=80=AFPM Ming Lei <ming.lei@redhat.com=
> wrote:
> > > > > static void bio_chain_endio(struct bio *bio)
> > > > > {
> > > > >         bio_endio(__bio_chain_endio(bio));
> > > > > }
> > > >
> > > > bio_chain_endio() never gets called really, which can be thought as=
 `flag`,
> > >
> > > That's probably where this stops being relevant for the problem
> > > reported by Stephen Zhang.
> > >
> > > > and it should have been defined as `WARN_ON_ONCE(1);` for not confu=
sing people.
> > >
> > > But shouldn't bio_chain_endio() still be fixed to do the right thing
> > > if called directly, or alternatively, just BUG()? Warning and still
> > > doing the wrong thing seems a bit bizarre.
> >
> > IMO calling ->bi_end_io() directly shouldn't be encouraged.
> >
> > The only in-tree direct call user could be bcache, so is this reported
> > issue triggered on bcache?
> >

I need to confirm the details later. However, let's assume our analysis pro=
vides
a theoretical model that explains all the observed phenomena without any
inconsistencies. Furthermore, we have a real-world problem that exhibits al=
l
these same phenomena exactly.

In such a scenario, the chances that our analysis is incorrect are very low=
.

Even if bcache is not part of the running configuration, our later invetiga=
tion
will revolve around that analysis.

Therefore, what I want to explore further is: does this analysis can
really hold up
and perfectly explain everything without inconsistencies, assuming we can
introduce as much complex runtime configuration as possible?

Thanks,
Shida

> > If bcache can't call bio_endio(), I think it is fine to fix
> > bio_chain_endio().
> >
> > >
> > > I also see direct bi_end_io calls in erofs_fileio_ki_complete(),
> > > erofs_fscache_bio_endio(), and erofs_fscache_submit_bio(), so those
> > > are at least confusing.
> >
> > All looks FS bio(non-chained), so bio_chain_endio() shouldn't be involv=
ed
> > in erofs code base.
> >
>
> Okay, will add that.
>
> Thanks,
> Shida
>
> >
> > Thanks,
> > Ming
> >

