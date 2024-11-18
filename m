Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1499ED49204
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 09:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fy4ixObamn97nOsBXqbG75Py+IFWINDXq0gYVa7tddM=; b=S34uL7uY0+iBc/bdvXwubicwZX
	40F4UyTVk5FEv5qlhidGC0qJgCwzQnGjAUpStf2NsXhRVzA5UL7VKoHP/+wuYmqq25WrRz8fyTcDR
	9Y+kfc3AXuOLQ/xCIqkLyHwdocWJuQDFXn6MqS0v7U0HmwpnECNZPqlWWfWOrlUSvIQ6oEt2Zsqwi
	PMAl7qkCoqC01UTZmrAbqYsEf20OtOYmLv6P6qLTHP/EI08t71/9IyphNLkIdRcMGPHBpl2w3EOzR
	MujUDn4KgjEWwbwVcc+R/byC8OOp32Aaqb+mGi0oTjJJsrEdAsudEzGsahqoFC7v4eOfApHRQxNlf
	Exyfm5rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tCy74-00000008vFi-04O5;
	Mon, 18 Nov 2024 09:32:06 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tCy71-00000008vF8-3HLe
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 09:32:04 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a9a4031f69fso662647066b.0
        for <linux-nvme@lists.infradead.org>; Mon, 18 Nov 2024 01:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731922321; x=1732527121; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fy4ixObamn97nOsBXqbG75Py+IFWINDXq0gYVa7tddM=;
        b=ly9439skCPWU0FXf2vMq3ao2yEJ0ITOH021jLbY5uWyUXyEYm6/vzBLI37SOeXv9Yu
         c+/5KwkQvBZiAMdwCMx8GaZWWOBUkWLalSVugmHPcOx8Ia6t7T32Ns9Ks7ZfkcaeVGRl
         qYesr033XZLO8lPmE3Jce4MogsNHD4v97GttY58XmreeFIw72NwhGeeCjEwrQy0D69Pd
         pQiROZmJBtO/pTOw2H3oKqQkBBfheXH2mJjUvGNoeAnSSlftVy7jrNbi4zCzHnjrAzpj
         XxVY2APZ1rXrq9Jv8bgPzX+hIkPPZS4N1Lq5f91yYFX97PPNtFK2iHEh8ecVyfYtk0sw
         Fp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731922321; x=1732527121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fy4ixObamn97nOsBXqbG75Py+IFWINDXq0gYVa7tddM=;
        b=kV49YPFEW7L3tYzV5wZKwMYa1r2rapu11N+ZF+wkXilboCNx9C55BNB1qTdWFhTC4L
         PDcIiUw8IdD9zzv973Z9AMVuCnpjjHcHARKhed4TNDy4rU9sNk/hUFPb1kG1lEwqJbf6
         CWcb6gaUqKaRuF+KD8BpoTl99qFakwfW4tm+HXQT7QMA2Fv7FpxU1MynVPfw3R7fxhG0
         rm8mx89eFv71fDyq+eefoLgrjzF79vD2Qq2QTK2H36gz1Df5m99JvQ/kfoHn4N2D4mvm
         GYjCfg6CQObSGCfNlUaLUr/RNr3H4Of4UuA4cm5SYy8Nd4CoXM7RLnKo/s+wPyAa/7fc
         50AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBwXhlsvkb+l2WOeA6Co9w5MG37FUu3uDnj4NZmz3PQ/JWor4Bg4vpX2Xt9fZBtA56PFZNgceSt0aH@lists.infradead.org
X-Gm-Message-State: AOJu0YxkqrS6WXrKVkh4wLrsFX9VcBc4a+hOqoBA60BgPCGnCHMOevKN
	JWS46D/ZvwybJn/xVm5jCMqieQRP8uw8mOK+YhUdJTi2ok3o2bLjGMy9Vw2EGC2njFpXISScG+f
	7HQWE0VEMmhIOEqcqyKjvLc8obWM=
X-Google-Smtp-Source: AGHT+IGC5RYyMKK90mJAubvXog6tv+abEEuNMCzFa4Ieqn/ccbsHboNCDwZDKJ1qvit9SakzhQM3ud23RXYyB7QJKe4=
X-Received: by 2002:a17:907:3f8f:b0:a99:ebcc:bfbe with SMTP id
 a640c23a62f3a-aa483485e4bmr1020829266b.27.1731922321256; Mon, 18 Nov 2024
 01:32:01 -0800 (PST)
MIME-Version: 1.0
References: <20241115083727.30005-1-brookxu.cn@gmail.com> <20241115170411.GA23437@lst.de>
 <CADtkEec84+ECj_s4Seue5uC+xv3dBu6T4kaqeHMe9PLiLV6tUw@mail.gmail.com> <20241118062627.GA32372@lst.de>
In-Reply-To: <20241118062627.GA32372@lst.de>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Mon, 18 Nov 2024 17:31:49 +0800
Message-ID: <CADtkEefQoDY5k5_V4QEGVD+DD2iTjMLWj8KXO+PnuVT+0wHsjA@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-core: auto add the new ns while UUID changed
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_013203_819597_8CFB071F 
X-CRM114-Status: GOOD (  11.69  )
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

Christoph Hellwig <hch@lst.de> =E4=BA=8E2024=E5=B9=B411=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=B8=80 14:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Nov 16, 2024 at 08:49:12AM +0800, =E8=AE=B8=E6=98=A5=E5=85=89 wro=
te:
> > Yes, now we have remove the old ns and log the change to dmesg,  but I =
am
> > confused why not auto add the ns with new UUID, we should treat it as a=
 new
> > ns? so that we can avoid an active controller with no ns, but actually =
it have
> > one.
>
> Because as far as the specification is concerned it is.  The whole point =
of
> these identifiers is that they are stable over the life time of the
> namespace.
Noted, Thanks very much~

