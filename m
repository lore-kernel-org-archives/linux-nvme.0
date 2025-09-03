Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C20CA100F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 01:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L6KzKFAj5KyI4xTHNVJ+Bav+TRut/F+RyFSESyEfLYI=; b=ihz8b+YpfKjPBrLL3SB619iP6h
	PBI8zjNSAL0g65PTXospzAdVQJxJmx6siAho8lnwuDrb7pmMIMNvi8+WXNCwWoS9WL1eACb0CUIXW
	83m5qnQudvIsCjFokZlJa7JODrAPekKZI0zST02xJi/cV1H/JDrSvvY7l4uQKRhP22B3zU8xnbcUI
	JpEis56TcMng+e6jg6zj7KDro/L35JycQuHkFvD2eS9lbItQnw3UDcxsOPEZF3Hu74xptApl7PLoE
	H6+GMfOoCw9kAC/kKBwBjxSg3ap60ltwfn8IY+0pqk8Y3wvXdyvTCWUBIrtJHPJmaYAUvzI1sVA7B
	KlIjRMGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utcj3-000000038sD-3boW;
	Wed, 03 Sep 2025 01:55:53 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utavw-00000002hTk-2rex
	for linux-nvme@lists.infradead.org;
	Wed, 03 Sep 2025 00:01:07 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-afebb6d4093so997338266b.1
        for <linux-nvme@lists.infradead.org>; Tue, 02 Sep 2025 17:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756857663; x=1757462463; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6KzKFAj5KyI4xTHNVJ+Bav+TRut/F+RyFSESyEfLYI=;
        b=GiEWkGrkR0lkTgzDh7sCI9ZZJw78g7sFgOyu8RFiVOa/9S2A5bhWAwwPJIa5y4IME2
         RI1fiwPpf71Suv7EWGBY5tAnX+D9NHU4r8+f7thBIla79QoNSCz2u8OnSz6OWxkwQYld
         WDq2gtqQvLvps06usO/rvnscX8nL3KJgLqeC4SuYbsIW8nMQve+jzFW0SDihMgFA+1kN
         5ANREVnO4CITSPNJIP9Tz5YqiS503BbS+FCmmdnfsQ2pwbzHAmGp734Njb9BXNQZxcH3
         mXqlS7uoI55KsY0oXIXpZQNaa2gwwG6CurHRCt3Vip5hxAUMcPxXh0QwZ7a3G0iP8Qj6
         V8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756857663; x=1757462463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6KzKFAj5KyI4xTHNVJ+Bav+TRut/F+RyFSESyEfLYI=;
        b=Ahq/t+yohh2fadHAIHBUDgXeZCHiX5gtQ4XPP0iHktuclTmwwMpI2T32dRzpAN5pfK
         l9sf4lTVdRjBjjMuOoF9if3DwW7WCf+StL+pd2A5Xy1ewRD+C6E6BnWgd638a3xUgnPy
         HtA87sLnl5uDO6IvrV9uQUjVvsmzT9KRih5L1QgsDBHn4JWjieMnwVWXM+1Z3AgtLaV/
         1R7YYx+WVqr5iXZZianygDmDzh3vcCe7DdsjA4PGU2051fVpoHh2Oh4YESKMJ13biHnf
         sPkaJb5Ujln3NoSbmLInp4XMrmqRGMZjqTUEnnA8FlthPKJfyocmprHw/aezWVsUuK+q
         mHJA==
X-Forwarded-Encrypted: i=1; AJvYcCWQT74vsitwaQfdj86pF+ouijA7ced0guHyltA0yAyIOh/LXp2uCR8x6vCZs1j2zB/PO1ppwRoiMjYz@lists.infradead.org
X-Gm-Message-State: AOJu0YxhLULo4p6rMTEWSGo2LBIgbbXFBci0jU2hmUF31hcGI+AO51P8
	7T5n5QocVwZNY2qYzGQnJsegfWXFjsBshh3zeciGKhzUgnlxuVKUEIYhoDTwGsdWSZW/KazGnUh
	uBtqzk9dAvLivXwK0twwCGUOViif77Yk=
X-Gm-Gg: ASbGncvUa/ujz91/1ylDuP8HBlI9Le/v3YcjsAB9U6iMqBKgjJAZk/Y0AX5s9Bvtvyd
	cOPKpPuk7uWhibh5WNOtTc9hl9+eKSR0OhzLOkjzIWkGtWks3QCeDNUaJK+sNjGVQc27g7UWuXq
	YrbRxZqaPbe5O9mgK7X384C0ORe1Es8y5vQ+B4nDeH8sK/Fsc5dYZGm/yDJcOjs+z0YyqOvU+31
	HhE7s6I5ja5J3axUodB01zzmRdDjU0HTa4zTA==
X-Google-Smtp-Source: AGHT+IH6AhRllJP7mdg0MDSz8PEOPVrNJ8CX2CFL4+9ZpOzCDEs6FEzJQPkbG4z93klh4esHrxBxLEF4fpZ8sfSm4/8=
X-Received: by 2002:a17:907:9444:b0:b04:53cc:4400 with SMTP id
 a640c23a62f3a-b0453cc4661mr420536966b.27.1756857662823; Tue, 02 Sep 2025
 17:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250902035211.2953174-1-alistair.francis@wdc.com> <2841bd1b7910bd0e1b263b393152f2cb13dd3ae3.camel@gmail.com>
In-Reply-To: <2841bd1b7910bd0e1b263b393152f2cb13dd3ae3.camel@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Sep 2025 10:00:36 +1000
X-Gm-Features: Ac12FXzDj2HtYGSJ8MLBLRHiuUatNFdUj0151ogn2qRiA-uR8AUABjK4lxcy2Wo
Message-ID: <CAKmqyKNtx-eq-dSgcJqoXjajX--QyBvqwfgKyfTfxiTiF-cFBA@mail.gmail.com>
Subject: Re: [PATCH] nvme: Use non zero KATO for persistent discovery connections
To: Martin George <martinus.gpy@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_170104_724273_00EC1FE2 
X-CRM114-Status: GOOD (  23.76  )
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

On Tue, Sep 2, 2025 at 8:35=E2=80=AFPM Martin George <martinus.gpy@gmail.co=
m> wrote:
>
> On Tue, 2025-09-02 at 13:52 +1000, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > The NVMe Base Specification 2.1 states that:
> >
> > """
> > A host requests an explicit persistent connection ... by specifying a
> > non-zero Keep Alive Timer value in the Connect command.
> > """
> >
> > As such if we are starting a persistent connection to a discovery
> > controller and the KATO is currently 0 we need to update KATO to a
> > non
> > zero value to avoid continuous timeouts on the target.
> >
> >
>
> When would this ever happen? Won't nvme-cli & nvme/host/fabrics.c in

It occurs if you perform a `nvme connect` to the discovery nqn of a
Linux target.

> the kernel ensure a PDC (persistent discovery controller) would always
> have the KATO either default set to NVMF_DEF_DISC_TMO (i.e. 30s) or any
> positive int value & not zero?

The kernel doesn't set a default for discovery controllers (hence this patc=
h).

nvme-cli will only set NVMF_DEF_DISC_TMO if the `--persistent`
connection option is supplied to `nvme discover`. But it doesn't set a
KATO for `nvme connect`, even though it's a persistent connection.

Note, that I think that is a bug in nvme-cli and it should be setting
a non zero KATO. I plan on patching that. At the same time if the
kernel knows it's a persistent discovery connection it should also be
setting a default KATO. The kernel is already using a default non-zero
KATO for non discovery nqns (see nvmf_parse_options()). This just
extends the default to apply to persistent discovery controllers.

>
> Do you have a test log for the above scenario where the KATO ends up
> being zero for a PDC?

I do, it's just a lot of keep-alive timeout prints on the target

Alistair

>
> -Martin

