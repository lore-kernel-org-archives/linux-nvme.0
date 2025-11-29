Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDD0D116EA
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Nov 2025 02:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QAPySlCz6W7rFB53xcBPcWM3i1+fAM460YdX4Fw6oEA=; b=nbPuCbm/eXY07k1HMqYgZ0+mfH
	BJt80ZHqle0IJ10ZgS1v2KTlskxvmT2KI5Zi8lu/hBuvOSzkfvAafSk/SeQaqY6xgkv6r4c7QtB+L
	f5VLnk730TpaDmsMd747HXglgHXMmH/U2Go37ptvHjvLOi8jwYbHU6N1hopNp3zJXyyelLR1fB5kX
	XC2bFeDGOLZvsSFOqilCpF0pfNjOD/9I/dsWjmSqsUk0652Kb0fOwbZ3jpdEUssPm79DXpJZD9oV9
	t1820UzoNeYHe9lXPPeAM2e8Wy0jJfImRgzsZRnaIct3iEw+pE1na01KShNpKCmSsqlpYYduj8dlD
	E0ZAf1xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPAtH-00000001C6W-2J2A;
	Sat, 29 Nov 2025 02:40:51 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPAtF-00000001C67-2ESy
	for linux-nvme@lists.infradead.org;
	Sat, 29 Nov 2025 02:40:50 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4ed82ee9e57so31828711cf.0
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 18:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764384048; x=1764988848; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAPySlCz6W7rFB53xcBPcWM3i1+fAM460YdX4Fw6oEA=;
        b=eX0n+XEh4Rz0Slh06kzjRk9OADMc8eLKXc+GxYi7g751iC9yWtcCFmyldY3s/unsTl
         fquuAMnMng1bsiu5C8NhGRmW2DYYczS11bG8xSvv6kZSdBwKp3SfgOMoEI7WQYQ+fS0E
         EiVVxiAZgKAVWwj+68qFShbjLkrywYkYkXFgkERjJMvH4Ph5ADyIudS/ufzobtr+yNj/
         YvE6+Dfv84l87bIouxYlgTGcdjKUk4qm/jd5L8I/EobYBuu78W6b/MhQ6Gtw+BmLnbzS
         iWyOkaGLuqX4JvSnZysM6MHtdOjPAZNtDhF2yUfYJkonA9lgED7uz8byQhs53POIynlM
         tVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764384048; x=1764988848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QAPySlCz6W7rFB53xcBPcWM3i1+fAM460YdX4Fw6oEA=;
        b=dLVsgJmiIfrkReZOvJvK/c7ZZTyIlzPoBpdzFgg8phtIUaMuuiEwzN/qnW2nHkM6VJ
         U20/EEZSvozNMrXvWig40H6RNt772GbsVxfwnsFUCs+NtJLtVfVL7IFqyLCAGDzOCiqk
         FRErUZmuiNJauUIb1qWByjcPZWd8uIOXUSlIEtyvzynk9saWXJ2SF9Q57drcftOsndUt
         PpRCjuuzZC6h+rBP2M9ZiQ/B0KXJOBWjx4ORaZKnRdxFbtNoocoWVoIxT8D4Tufw7Q3p
         AuZFbtpH0h1tGd3Lds070gDi64Lx/72A1jh+3va0IXjOn0KRHuh0QPywUVRLNlG00MxO
         LP2g==
X-Forwarded-Encrypted: i=1; AJvYcCVfKJt9S9Y9YTslk39yWTMw4uBSMBDv8zbfZSFODqFJjPvx3+U6fZtWm9UVjUtODAZbG/xLezevzsLg@lists.infradead.org
X-Gm-Message-State: AOJu0Yy08YB2D1LW/rKQoGSs2dBAhnidvXLT7YPT8vlWlOxWYw8gdud7
	Wp9nvbR/ozoHHyXuWCJ4M9NV8lLz1R8r2sNzv3+ZOruqRWdrE2cicE2y64yQV32z2pcU9O/sdK7
	RYBOdSFoStvyyUG/UbhLIADLWerNWKLg=
X-Gm-Gg: ASbGnctkRfuTSoUBY0bnLWh6faiOPY2XrmdYbWJcS6TenMmgmDME/5xVJ53QT+PifO+
	1hDZ7ryqWWLsf8XujGCeRMNxSxjMqnQql6Bf3ly876OJTSV++1GRDP53/NNHFb8uYGuqGJxsMLg
	I6Z7NSe34YJQespzPXIkuQ4MDbgzaBUXOE9YO40dznUNYDvfE+lxPw20rEj871eZKhSWD74co00
	SzR+vO/Erv9e/x2u30A6qUldXEVSBFcXHghzZOPFMk/DLAUjJRiVJbJhq4nj4sUFhaw6w==
X-Google-Smtp-Source: AGHT+IEc3jQjTSh2wGwA1eyD2xP/eWtKWxB49pbTJ6uDNzgYaFeaO9lvwOhTEy0qjR7rLP4x3OvjjW+3HSCvva4PQqk=
X-Received: by 2002:ac8:5753:0:b0:4ee:1b36:b5c2 with SMTP id
 d75a77b69052e-4ee58af12d0mr418152811cf.68.1764384048425; Fri, 28 Nov 2025
 18:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-7-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-7-zhangshida@kylinos.cn>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 29 Nov 2025 10:40:12 +0800
X-Gm-Features: AWmQ_bkvl1bn1ab0FbiQv1s_-KpnO8A0jbXWmROhOJd-0tcEov6J9fzUaa8ydUI
Message-ID: <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_184049_575438_803AACE7 
X-CRM114-Status: GOOD (  12.26  )
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

zhangshida <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=94 16:33=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Replace duplicate bio chaining logic with the common
> bio_chain_and_submit helper function.
>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  fs/gfs2/lops.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 9c8c305a75c..0073fd7c454 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -487,8 +487,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, u=
nsigned int nr_iovecs)
>         new =3D bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOI=
O);
>         bio_clone_blkg_association(new, prev);
>         new->bi_iter.bi_sector =3D bio_end_sector(prev);
> -       bio_chain(new, prev);
> -       submit_bio(prev);
> +       bio_chain_and_submit(prev, new);

This one should also be dropped because the 'prev' and 'new' are in
the wrong order.

Thanks,
Shida

>         return new;
>  }
>
> --
> 2.34.1
>

