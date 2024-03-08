Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67398C5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 16:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JUeIfZJ43gO8lAwOVHd9gk61hYVExWZlcr16GPR9ZJ8=; b=DYJUDXuQW9dah8z50RgzS321Hj
	sJKaXWLUVxuBCfMJNpKV9itohAjvYvtVIvc24vMZEQo/CCq6Mj/SR8MDiybeaeUj+AxDwo4quLzn5
	RinlGGzAtQk3XPk1wawPSGr2PSapp57Hm/hSOdN45TBaRBLTmX2BueEOeUktvVAE6oXr61IvP1vnj
	y1oRZfJierb4Y4gFsDOJ7EBAlT9XcsRDcQx/kdpg/zg8ZWtmvM5VIMZ0d8pZDWuxH5QTKxJIhl6Ji
	lP8VZU5lbT41n3rXElfs3C287x+pRbOHUicFbaMSE14jVJsDE8wRYI7Lle2+hUfPrOt0sEa93dI4d
	QcAUCrtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rid9s-0000000ACvS-3g7r;
	Fri, 08 Mar 2024 16:33:20 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rid9q-0000000ACuQ-1yhw
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 16:33:20 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a458eb7db13so336291066b.2
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 08:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709915596; x=1710520396; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUeIfZJ43gO8lAwOVHd9gk61hYVExWZlcr16GPR9ZJ8=;
        b=eEQnyjvQU2dXSDkLYeEO7jFgfmJpzpa2UAMY+pS0fdSbg/uYEdAzk5+hzYzT6AeCVC
         +riu3A6DAj5UPIcQAmWPLugjwHbK24GIMGPFTNidVkLxsHmIcugvylH0kcA4Y/X9OjpQ
         MHAr1B/iTZdRqvLbCtyPLzOFMEasy6Yhy8HtBVUu6p38C0PjsC7cDNF0AlrsPkAz8xjV
         lqiVr6tbkTc9kK1eCg7SGTw9KMDqy+FXffnSkjvsDk9CBUdwX3ZrhczwfxoeVUguHsQe
         vsGjdhmDyWWUjA4jUMkBxGG2WSFFrF6kZi33XWrGnBoyMVjX4JlOIlMETJMuPYn/nEzX
         HIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709915596; x=1710520396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUeIfZJ43gO8lAwOVHd9gk61hYVExWZlcr16GPR9ZJ8=;
        b=hCJVXs+QREsJdutMOZenfnBhF9XBqOcU0I2Bc9G/bgw7m/gKXReY+XaoY3MpfwVJ+N
         YDjqu0HwRosOjj/wh62fpm2F9qNnkZrjGiK0N4H0p+fmNIbyo8l0HCmRrii/81W10+Vi
         9tRhZYOjRnAYX2cUFopAAloYAZ0pwdtZklP79DgVzNBj0AznQYahA2/tDHWuFTzLr5P/
         AFrYZktMKOHQMaHcY3ToHTXnLtokcXLZYOBKKlUyCpuvwZ0u9loJfOujmYTY0biSzZVH
         AF5dcznyLilAVeAb5/peRXRBPemdpKDfr7IMOvdVv/lREqfa3VTKBkq0YCQ9qvOkKgSh
         JAAw==
X-Forwarded-Encrypted: i=1; AJvYcCXWzgMhoMZS6fttjhAewEG2Btqwgz4b8v84Xt3Z4uEgMc1V73TUaFjBmEB/6aH6flBvriQp5bLcUPkCthr8933sfJlb3K6HOA62mhnPBb8=
X-Gm-Message-State: AOJu0YxaIdsVpXtKHDNe1RmWCB2EuZPTqh38dVowAQAKE1ONq8vSTApl
	RqJ//T3eIqo/865v+xWQXKl3actYGR5VIbV/9oFiZA32c0t6sgTz6wuAS5nvGtJk2sDMy9MaQSb
	y7jGLYfFNB3uNkTjXEbxqAaIeZg0=
X-Google-Smtp-Source: AGHT+IFufWYJDsITgpL7UXaFj2BN8cigArfb1h/ryoZ7D9OkY/0oqOqz+QCWLnkhrwH1vzy0xR2WiJinQTfCeoaPrYA=
X-Received: by 2002:a17:906:ce26:b0:a44:415d:fa3a with SMTP id
 sd6-20020a170906ce2600b00a44415dfa3amr14864468ejb.40.1709915596471; Fri, 08
 Mar 2024 08:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20240308015435.100968-1-brookxu.cn@gmail.com> <20240308144208.GA9194@lst.de>
 <CADtkEefTzbYN4qEAgAXDTB-+HMxfENw2m+xcoxzy83YW-bGEhA@mail.gmail.com> <20240308163100.GA17078@lst.de>
In-Reply-To: <20240308163100.GA17078@lst.de>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Sat, 9 Mar 2024 00:33:07 +0800
Message-ID: <CADtkEeeZfkJnW9-3B5r_rujjRWq7oDdJG4TtEKg8aB8+WHB1ig@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag allocation
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_083318_553237_8E320582 
X-CRM114-Status: GOOD (  15.17  )
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

noted, sounds great.

Christoph Hellwig <hch@lst.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=889=E6=97=A5=
=E5=91=A8=E5=85=AD 00:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Mar 09, 2024 at 12:29:27AM +0800, =E8=AE=B8=E6=98=A5=E5=85=89 wro=
te:
> > This works now, but I donot know whether
> > nvme_alloc_admin_tag_set()/nvme_alloc_io_tag_set()
> > will be suitable for all driver in future, such as driver for apple
> > device not use these two funcs
> > to init tagset (anyway it not use these two macros too), so maybe new
> > driver would use these
> > value in other position.
>
> nvme-apply should realy be converted to use the generic helpers,
> I just need some help from the maintainers.  I'll ping them.
>
> But I'm fine with just taking this bug fix as-is and clean this up
> later.

