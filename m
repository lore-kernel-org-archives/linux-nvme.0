Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CE9D116EA
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 06:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rNBX+tdFCi976CT3NTPOtFudKzRzrB7upXknWDTBPfs=; b=o4bggI3ZBD/hOIHaGbc1bPInly
	ImStsdF7XlCkZ5/1xTG2XQgX5Ay3XSlmQ0L94ZKeYba7lIY7uGckgXVOdlY7vjnoHZmpDAuw6FgCo
	vJblwVCD818U19tvwQzHnWyoObNZHexAk2fxjOOL3ZDyodLQrQmkwDc+Pa7YZgy/eug20NfwXZyNK
	60v9brprwkQ/SHIApdEeZRXNNL7XTjAnG0/O4DpeGAmesoUxOhxGorfjO7OuloaVApVxxDByP0Xe1
	dDjBRjU86MnRF5vN+TysSXKJ+HaV05RKgTUD4lnh2IIGUiPWsuZlUchM/pSm04Os519vuayRCWrNv
	EwdmJLjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOrwy-000000002Gh-0bYX;
	Fri, 28 Nov 2025 06:27:24 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOrwv-000000002GE-2py8
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 06:27:23 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4ed82e82f0fso12808051cf.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Nov 2025 22:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764311240; x=1764916040; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNBX+tdFCi976CT3NTPOtFudKzRzrB7upXknWDTBPfs=;
        b=AP+XrUdbLuAyW0Ddb000o1MrvGZJkH1prna8jascv4WzpiruRh7576sOTQ9VJLO8gf
         HEVz0EamWtwfWTUiIZAkEPfwRC4vS1vzoYR66reAf07/LXQLgvUbz7MODxfQJqk+TQnH
         NJeBDjW6bo1bHU2XyxqBkFpDzMCLTQPVyyaXQYe2UjD5hzDHq/Ym0Pa39wjKqtNgCtEp
         epJCYhViMAE4v0+SjiZBmGL16VROtkPqG4HAbNe6p4pReYW0hJIEGUqLAyvybaTSq2hO
         AjKMgYsEVHJdT7PFWDv+R0A2CkgX8kprSy2Zt14/BgUon0uy9CIXSrRPwdB6lajqsVub
         OUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764311240; x=1764916040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rNBX+tdFCi976CT3NTPOtFudKzRzrB7upXknWDTBPfs=;
        b=SnMyhc9FZU2f1D22JWICBiBXxT5VpTcWku00O2pEsUDckeGZwX8af5SbzfvctWKjN/
         D72eORpUlMS9MoQfvrRUMmeW7rBP6cSBtdcm+P67InIzSbCJVn6N39lhJ8pkyNkeQ3jo
         oVtOZcHHFVGsacaOvZTW2pcr7VzI5NgL22rNUS2C1X9SgCjgh2Oq6aX8VS1H90yAUqdy
         oOvG2E8+4ce1wV36yHZYe4yP9xGLTyY9xBONBIwN3/wrQlSGOya3nNC7vrD6OBLyPFNv
         uyd38i9HqSzCHh6fRJD+tw2fE1nN19E9/3VqiRtmlbZbKdKzE2FUJSL76QYLqaTrck0o
         N0IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhBsqyuscoSfQPez3V2dLvPgPAQvuG1F1J5+rtELj+qWJTreLG6d2P+ZGc0gNQ3UMllHllgfSpHrRD@lists.infradead.org
X-Gm-Message-State: AOJu0YwhjV+dmtrVof8xVktK4oV9oNzugeFGxaSZnUVe7/H2F3q03wYt
	NkJ8p+IzVMx3qrUkgEwT6AVjiuJ51apyWJAn0H8lpWPhC1hrVc5iEDS++6guu+GDy5YjTMERr13
	PH5XvLmZmqjyh2T7JNpFiz7ynZCrhbjY=
X-Gm-Gg: ASbGncthRlZ61a7u2nYms0Jp6xXVjVcXtX9Ratu3SnTJ+5jLFu7F7m3jkS5zUqOj9MC
	P+T9ox8XEsgV85QUd83/7+4vb+TwBPT6xo1o/qKnz+SMk1WyhwKYYMFbfKZiEFc6vi9W6W6bQcF
	eOmyAqRepRxpxFvGonYoObea/SL8+sYhLdVP8/iYb2hWgpTj4Zw+3LrmlgTGlOk/WAi35NQfvsS
	+zvFtpdmdmh3DUojLKP8YmXtolYC7xJuNsKaagaMwNvX0zBk0V17M9pC0J4va4WNRA5y68=
X-Google-Smtp-Source: AGHT+IHqoxxME/wZYacFTCZmpyvjYqen8b7+sN/d+VbUoZE5rC4JPn9P+8N4Y6c+biawDbsHSmqE9yp/CsWDMeNGoss=
X-Received: by 2002:a05:622a:3d4:b0:4ed:43ae:85f6 with SMTP id
 d75a77b69052e-4ee58911262mr343758661cf.47.1764311240290; Thu, 27 Nov 2025
 22:27:20 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-2-zhangshida@kylinos.cn> <aSA_dTktkC85K39o@infradead.org>
 <CAHc6FU7NpnmbOGZB8Z7VwOBoZLm8jZkcAk_2yPANy9=DYS67-A@mail.gmail.com>
 <CANubcdXzxPuh9wweeW0yjprsQRZuBWmJwnEBcihqtvk6n7b=bQ@mail.gmail.com> <aSk5QFHzCwz97Xqw@infradead.org>
In-Reply-To: <aSk5QFHzCwz97Xqw@infradead.org>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 28 Nov 2025 14:26:44 +0800
X-Gm-Features: AWmQ_blfmVuM70WOWxBT6SLO-nBFz1VQq0RiOHlp-O6KawgJbGDwoH1nduOeubA
Message-ID: <CANubcdVTwitvE8ZP2BRtW28u8ZYBvdobxxXQgDSRWP_FbS1Wmg@mail.gmail.com>
Subject: Re: [PATCH 1/9] block: fix data loss and stale date exposure problems
 during append write
To: Christoph Hellwig <hch@infradead.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_222721_740055_82FF9751 
X-CRM114-Status: GOOD (  13.08  )
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

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B411=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=94 13:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 28, 2025 at 11:22:49AM +0800, Stephen Zhang wrote:
> > Therefore, we could potentially change it to::
> >
> >         if (bio->bi_status && !READ_ONCE(parent->bi_status))
> >                 parent->bi_status =3D bio->bi_status;
> >
> > But as you mentioned, the check might not be critical here. So ultimate=
ly,
> > we can simplify it to:
> >
> >         if (bio->bi_status)
> >                 parent->bi_status =3D bio->bi_status;
>
> It might make sense to just use cmpxchg.  See btrfs_bio_end_io as an
> example (although it is operating on the btrfs_bio structure)
>

Thanks for the suggestion! I learned something new today.

Thanks,
Shida

