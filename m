Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90E8C9830E
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 09:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GrJoJ2ytny91PPyFUjjfr4sdS6p1y6Xpxf8VbUCYFbo=; b=BlzBIyuSduW1UPB1pPdYbRRhzr
	GTsuDbhTLtY/fZpObStneBiqvgY5YZnBNJmin5l+sal1EMww2sFnIevhQpkMUdzyDq45Dsn49L14X
	wpS39RU0CD1v7/Ydw8IffsjMxDroM8mCdwQwiPj4mNBqETu9Tzs14eqRQRaIuaK+4G1GRZ0OBZfq0
	eNCtQy0eus9JAzhAQx7pj/Dw9pcWaqlyBjiISrcH7q0FvpOhuPnbBXEeNv2XepKInCJABS8zWlFbu
	2LRJTwzT1436n73zYMndG4nF8CoLFt2PEpxfalyvhJz0R9H/k8qNXYb6YIP3Q7gg4m49Dr0vftmDI
	2spjb/RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA2iV-0000000D4W2-12Kp;
	Fri, 25 Sep 2026 09:59:43 +0000
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA2iS-0000000D4VH-2AR2
	for linux-nvme@lists.infradead.org;
	Fri, 25 Sep 2026 09:59:41 +0000
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-486e1a044c5so542790f8f.3
        for <linux-nvme@lists.infradead.org>; Fri, 25 Sep 2026 02:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790330377; x=1790935177; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GrJoJ2ytny91PPyFUjjfr4sdS6p1y6Xpxf8VbUCYFbo=;
        b=ApPO2noTr7jVqI/JgnSfBnc6FXzjfScQUexEen7jiBeQUKd6f5uKZR4ZY9mlpJ4Lyg
         +k/9UFZUkpxKBbfcTINRgYnyMbDORIKf61ohF7F+dcco3s7ldl8x3aEeUSVNLYbrzp9v
         GjZACn0zTG1dqiAdQihjPwl9eipDJBcoCO9qJ+/YYl9VWRGN31kvVx5UzvJGoD4uIDx2
         +1NBHjMrpo98zdI6xBljsYmpUGYMaDDrQZzNnf7+26Zkh0tCacOkwp8Rr0ggsnApPbyM
         Cv88crk0ZLE2PwWFdJOa2p8gF3snYyAdvydADpiQYmOpwutVEb6k37nqpXaxVl3BgZ85
         nU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790330377; x=1790935177;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GrJoJ2ytny91PPyFUjjfr4sdS6p1y6Xpxf8VbUCYFbo=;
        b=iW1RdIVnpT1IQuMymU/EdQpCUZbUkV5NZ6dy/95tZgO33Gf+erFkGJpxw5zHs4Nqtv
         3ju7LV1v9iiBJyxSdO7p4kEUcVOAoHlxnAe+o3g/3mkELZybs+n3ELhyXwERBqQQzhHO
         wEbNoXJ2c7+6tK8lKlBwa9c2nBkAX/wNAubyfMo8GysIaWwZZvWUR+a8us/whDC3HDco
         WGhRrMnq/7xvrVFspKx0nEiHGzUPy4v9row2GBHzGQ3L2Mmy+X1qG6A3TePKB09LaB7o
         vDotqIvqK+wF7dTI2itO72NlBNwS/pJI6WL2VWbvTMgaeXNntzqeF4lO8qSj0PIOB7Uc
         1QJw==
X-Forwarded-Encrypted: i=1; AKwUvBytM3KhfNsEodvdfcOdTMXsl6SZWHmSh8JIngtWSXmJQCUJw6PT9LhUbVeFDKjebqMmPyxBR+BuPVZN@lists.infradead.org
X-Gm-Message-State: AFuF++l+LsoiIU/UfP7t/jgqGkkJJ27Sfk4Skk6XqTbbFUCLujOOJBee
	Ae8FpIIUW7+NlWiaeFzrOvLTBqXMMMInq8BtnyqKwQEPRftlb6rmpGI3Aw6TGNqkyFY=
X-Gm-Gg: AYBFou1pQi1fdxwF2uInEV0PCX1VdITTJDJzsr5mHagxZWvIymx2qWKPvdZ255HOLF/
	smBDLy5gsZeXYefosdHZ1GVfxb8/AiBP0aJ3DzHR3/Q+AhD9GjjW4ZNWDApb4nBs9uwkNkc8fwr
	Uug/mcCsJZFbs6j4nF0FpcJXUrh8r5PNvHWDoAzI8a0hgFKeTpQnvC0KXsrt9IT4svQC0lgz8ki
	WUnAfqkr5vbBTy0vM6STVo8fDfbp72lyaHGEu0uINiOeROu14IeenJf9vLg1uNsnhH/+71Bbdie
	+NmybEagF3L7J8hga8SfDcSkWFDYlgisUvkv2Gb60JWmTgIKBPro+O20A0NO/WQjytjz0/T5R4M
	E5/7vgyvy1gdcMEjpMxevbMMah/HdEOwikD/0IWw8OXugQ7M1dGG30HQ1zs/RAAhurnBN4olsx2
	FwFC4aOO4LccXSU3poEKS0+atORMqi+yJMMOMcjM1XouwvYUnc5UEJKkZZjdxjVE/Lc4407DwJA
	xyiFnwvzQsYfg==
X-Received: by 2002:a05:6000:26d2:b0:488:5af8:eabc with SMTP id ffacd0b85a97d-4887175d8a4mr10728228f8f.26.1790330376886;
        Fri, 25 Sep 2026 02:59:36 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a2acb4dsm5878334f8f.0.2026.09.25.02.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 02:59:36 -0700 (PDT)
Date: Fri, 25 Sep 2026 11:59:34 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: peng yu <yupeng0921@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvmet: add cgroup_path to charge namespace I/O to a
 cgroup
Message-ID: <arZFtIkV0vg_aQR7@localhost.localdomain>
References: <20260923152653.40953-1-yupeng0921@gmail.com>
 <arP0TmdK3FnNfbwH@localhost.localdomain>
 <CAG3TDc0bQJATmJR5dF5j9RoDp1ti-tbAiUkLRGq4zX2CYD3unQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4zjvtwofog4yq6f5"
Content-Disposition: inline
In-Reply-To: <CAG3TDc0bQJATmJR5dF5j9RoDp1ti-tbAiUkLRGq4zX2CYD3unQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_025940_573349_00E81428 
X-CRM114-Status: GOOD (  23.21  )
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


--4zjvtwofog4yq6f5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] nvmet: add cgroup_path to charge namespace I/O to a
 cgroup
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 09:34:48PM -0700, peng yu <yupeng0921@gmail.com> wr=
ote:
> The LVMs are close to my real use case, so I mentioned them to explain why
> I need this feature.
> When I write the testing code, I try to demonstrate the usage in a
> simpler way, so
> I use RAM devices.
> Sorry for the inconsistency.

Understood.

> > > * The subsystems are exported to different users.
> > > * We should provide each user a specific iops/bps quota, thus a noisy
> > >   neighbor won't impact the performance of other logical volumes.
> >
> > Why cannot you place users into respective cgroups and configure
> > appropriate per-device limits?
>=20
> I export the devices to nvme target. Per my understanding, the IOs are
> controlled by kernel threads. The users are remote users, so I can't find
> a way to put them in a local cgroup.

I see, so the core of the issue is that local storage is exported
remotely as NVME (over TCP) and you want to regulate IO on the local
storage.

1) resembles loopback devices where original task's blkcg is transferred
   to the kthread issuing actual IO. Is there any userspace component
   fronting the clients? (whose cgroup the IO could be associated with.)

2) it also resembles FC app ids (blkcg_set_fc_appid()/blkcg_get_fc_appid())
   Could you look at that whether a common concept could be used? (I
   haven't looked into detail how the client side is handled [*].)

Thanks,
Michal

[*] And now when I'm thinking about it, I'm not sure one can trust any
    app ID that is sent over...

--4zjvtwofog4yq6f5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCarZGARsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjBEAD/RgvrgWqx1vN7nwvnz6LZ
kUdSY5YucNYWhEz/l2B6FdIA+wdvKZi11fYFtWArfARj5k2swH2W5L9SKaCFbKx9
EhsJ
=C5Iy
-----END PGP SIGNATURE-----

--4zjvtwofog4yq6f5--

