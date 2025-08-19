Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBA1CA0EEB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 18:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4vwhOepgsz2onVcv1ONz5WbzRpaH/gQvDGTpqrOUbVE=; b=ELvYlJIN92Y4kQbm4DbQ1LWQPE
	Rb1U/u9Nt5mYMKyqWoMRs4pzf3WWRFnNuPOuUfv9D8P8Mj9ejnAOp/psGmUciO5DGahCHfN96SDpq
	y7uZJIGPcFW6J8ju5heZDETojE6TxATRfthtVxZZKhV2vwarik9UvjnuWWU1zVtYvoDtHoaZraG4L
	G3ddx0v6ZqaOPhNfnJOkkno0ZMJXiaNRQ9FR9oFGV0QdCd8nLmc9Gl9PASFa8WxaiwQ7RNQLeotSW
	+RxQSlAtxlQm6eaA+I7fT76/NnP8MG8MFQwIidSQpZtISp/FV8PwmGGclYIb6a0+FazF7CnCjL+vO
	RdEWLSmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoQqs-0000000BDvQ-3M9z;
	Tue, 19 Aug 2025 18:14:30 +0000
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoMeY-0000000Ae1U-2u7A
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 13:45:32 +0000
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-e934641d4f3so2590002276.0
        for <linux-nvme@lists.infradead.org>; Tue, 19 Aug 2025 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755611129; x=1756215929; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vwhOepgsz2onVcv1ONz5WbzRpaH/gQvDGTpqrOUbVE=;
        b=lR6kh7/z1mp7BeRCSz+SuVLLXobCX8OPLud7OJwlU+GZgr9WplrZPJgVQSGD3rCeQE
         8VklLG+ThakngKeztTlcm6lEJ0jnYDuGC431Ct044i6tn1TOiO0QSc6Nhqg7XNnMgLnX
         xyui8mT/VmzmepjsjYa9M30j4FrwTlrYiU4HgAQOkBVIXhDq5Q0wtoxLKiwJWx6JwYeU
         5hHHqvhs9uuhnpwrl24HHL6utNbPvhxnl5VOIXDfCQHl3MjqV0sE2MDPr2FC81Es7zny
         XkSDT/cFxomZymW1dZibk0SDzz3LZ+J6J8ECU37A+5XgpuRB6n+D4NQesfm6/lCKHKCx
         6Dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755611129; x=1756215929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vwhOepgsz2onVcv1ONz5WbzRpaH/gQvDGTpqrOUbVE=;
        b=gyd5SvglRYASn5MvqPTveOiPpLWy+LvSOBjiPbxoSEhGQbAPU8Ytne/F3P2XNP6Bok
         /vLhQi8oTGOWLCB5bjM3iSc2npxKhZgnsQuSLQd+gYNENiBpW2Qhz97AZQ2N1tjGzmOr
         HFnuHBzJvxzNyWpiCBCbrSr+cV4EzH87KVqifVPvd3/GhDpSKeOhBLqYzQur0dzd/pbi
         FB2hlCVo9vz8GQWOpUa81PvkWWH5O8F5k65uMobJ7Y/790oPnVBoNtH7Bn+FQP+e4uzX
         Fq3ApZjvi3wNnX/LL4jZV2TdRWF3ak4s3u8aSQ6jvnFIy1WDwCoQhjYwb7GU70zNfQwv
         KUWg==
X-Gm-Message-State: AOJu0YyS8z0wc9kYokfv7qNU6sIoKsJ3UOLwlgqDoOzqEVqueR2zS/dR
	mX7DvTMy4YLmeT2oXDoaJCTiK/B/D+qVsaVwqITwlcflQ7W1HJD0KyzKXoc7Pp8tfyrFBVk0f9w
	LaIY5/xWoTVjh8AfZf7SP6BvB5vJMrUA=
X-Gm-Gg: ASbGncsCbNdTs/5WYCOir9qTbm+mpCj3a6I4otP66Yr/ueBcFGZ/UKNOSSDuZotiCiV
	j1KkQbSf9ox7iACsfqZxaQLYoWvp/dps7B1NUio/CLRxX6aD/oUcpw0hOg6VSC0Ote9n1bAuNIh
	sT9zLv6+TO0cqiy4SCcv33HOSFmgS75T/vhQVXkr7v5vD1/nBaOUpO91/cSIV4d/g7FlxNeIkLx
	syBIbgTkClBWHJshQA=
X-Google-Smtp-Source: AGHT+IFNpAlAEv9omuLslIJulEXvPoWriYHA9SLt5pWGPCpy+zfKJ4/KYfJEIIHgWgMW3qNSlRnsrJhBvrDjKG3Xm+w=
X-Received: by 2002:a05:690c:6b13:b0:718:3b9f:f1f0 with SMTP id
 00721157ae682-71f9d63a83dmr29486357b3.26.1755611129147; Tue, 19 Aug 2025
 06:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAAiJnjqKqMHjrPLOvY5sCXiQR0n6pMvm2mS5pQEqy2XY1cD_6Q@mail.gmail.com>
 <aKOT88cdjI2OYi4e@my-developer-toolbox-latest>
In-Reply-To: <aKOT88cdjI2OYi4e@my-developer-toolbox-latest>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Tue, 19 Aug 2025 16:45:17 +0300
X-Gm-Features: Ac12FXy0UGSXoF0pWxD68S-ahMzB5j4F_l1E1ChREBKi678E1bIArBheupr5_LU
Message-ID: <CAAiJnjq1bvZgn5Ud8r=R6_fO=RvYkUhChO0cCooV5=KTOV8NBA@mail.gmail.com>
Subject: Re: Unable to reconnect namespace via NVMe/TCP
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_064530_733695_E25751BD 
X-CRM114-Status: GOOD (  18.26  )
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

> How is the target becoming unavailable?  Is it as network interruption, o=
r is the target being rebooted or reconfigured?

NVMe/TCP target reboot.

> Is the shared snippet the entire "namespaces" section of the
configuration file?

Yes, correct.

Anton

=D0=BF=D0=BD, 18 =D0=B0=D0=B2=D0=B3. 2025=E2=80=AF=D0=B3. =D0=B2 23:58, Chr=
is Leech <cleech@redhat.com>:
>
> On Tue, Aug 12, 2025 at 06:48:29PM +0300, Anton Gavriliuk wrote:
> > Hi
> >
> > There are NVMe/TCP target and initiator servers, both running on
> > RHEL10 (6.12.0-55.25.1.el10_0.x86_64)
> >
> > NVMe/TCP target exports single NVMe SSD
> >
> >       "namespaces": [
> >         {
> >           "device": {
> >             "nguid": "01000000-0000-0000-8ce3-8ee3064aa4f2",
> >             "path": "/dev/nvme0n1"
> >           },
> >           "enable": 1,
> >           "nsid": 1
> >         }
> >       ],
> >
> > If NVMe/TCP target is not available, initiator tries to reconnect
> > every 10 seconds
>
> How is the target becoming unavailable?  Is it as network interruption,
> or is the target being rebooted or reconfigured?
>
> Is the shared snippet the entire "namespaces" section of the
> configuration file?
>
> It looks like the target code will generate a random uuid for a device
> when it's configured, which could then trip up the host attempting to
> reconnect across a target reboot. But I think the uuid can be saved as
> well as the nguid in the target configuration.
>
> - Chris Leech
>

