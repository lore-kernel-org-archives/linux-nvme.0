Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039C0C47DA9
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jan 2024 14:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3iDitO1XNkEO8CSUvtm1MSYFm/Pm3nL+trS6JqCDr3A=; b=WPJWKEh4vG0VhXJ2301Ckqh5rn
	JDuYSnKWuS0vpQ4efLt3k6e1ahoLXn7rLLfXC8j50l09GJX1aNNeX4NPh4EgRQkDw93skYEdscRQS
	xWTBi9M4jQv+nFNOKUY/73+jOlPeBL2rc+wCuPk+92966HzEPJ1FUVWm2qkxbkyXB6B3nNJ19VTpt
	FzB5HoJXgBM9jfBH9Pnj4/HLmefsKLgcvQM4zqN+lq8sQkbmFgzlJJRpEUNUAZ7EShRZj63SGs12F
	eMMNAPXpL42xbkbEmycKDc9hPQ7nhywT3GWKN5l7llLhjMkG26X/uuUiWoTn4yww9+C4oovR+MDNt
	2N+PNCsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU5lt-00000009afb-33Pv;
	Sun, 28 Jan 2024 14:04:29 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU5lq-00000009ael-16uG
	for linux-nvme@lists.infradead.org;
	Sun, 28 Jan 2024 14:04:27 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2903498ae21so1063554a91.1
        for <linux-nvme@lists.infradead.org>; Sun, 28 Jan 2024 06:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706450665; x=1707055465; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3iDitO1XNkEO8CSUvtm1MSYFm/Pm3nL+trS6JqCDr3A=;
        b=E5SCPdJ33ljTJ0mpTEojjF51LPuLvFU6mcd7vr6pP1NjyyYOf3iMYA7HjUwWeNmdnI
         wDrqueoOMEcpEGbTITNy4y2+8fQScg7hnlo/CxDCdxPWW2oPd8L4lAXNkXZz63dB3RER
         OPA+b5lWxi4JTrxMf1+5MAkQyqs4XvCXvtVTHORt+81vW9pkXYj1OE2JI+pJdp9ymtZN
         OPUyn+s+gdXz4sfDNGtWdtj6g0IWUBXRm9gScS0oPTIbpozJgYPDJf5nnC5f+y0DW5EI
         UFZf19X2QNp0eQzlCZazxKaeO57qNGcgBBGFrrJgvLdrr1QboEi996PamOQkw9WP40lC
         cESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706450665; x=1707055465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iDitO1XNkEO8CSUvtm1MSYFm/Pm3nL+trS6JqCDr3A=;
        b=XOkF4u9qGCrq4yI9WNjOsB8k224AosQnKTiuqHcZ+LjWfUhXyBVYgbqOAal5fU0OxX
         B5n7njuqiG2mDhonIiWr31bLu9gQ4rxsuMuQg+YaqtQuX30WAiXW2yAx8SpF/6xYvB8w
         F3qAo3D0G7i7NxH0CyRfTbl0yJCzCuuMv5xNOSivWcOLrbV0TlLGpXpK6nQ4tEGF8tv3
         tg3K2q9Vl0NX321s1WwUVuysaNABfqmCnF4g7W2qxKwd2x+N7VZv2gZtSqdRS5hvguPR
         dDZnMJ6E5UDuO7XEnhVN2eUrOSEZ1VhYy1S4EcdCPaChxtXV3IxEcB0+uVOzI3elUoT5
         b9kQ==
X-Gm-Message-State: AOJu0YycMjerglit6qxs6iQ+qYpdnkBUpJF9aqGojJLwfz0Gz0l7hlRh
	OLsBv8zEHW8KCSa/boDsTi1I1DhN/sBbBOMc5k1Gh77M035rLkls
X-Google-Smtp-Source: AGHT+IHySygltUDdBeoABvI+VRWCAp7UW1lj4DSCvMTPZndGgwx/hK163rGzw+PEhFUHWMTluhKl0Q==
X-Received: by 2002:a17:902:b492:b0:1d7:8cd6:24d6 with SMTP id y18-20020a170902b49200b001d78cd624d6mr1360293plr.1.1706450664739;
        Sun, 28 Jan 2024 06:04:24 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id o19-20020a170903009300b001d7233f1a92sm3701937pld.221.2024.01.28.06.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 06:04:23 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A9D54184E3308; Sun, 28 Jan 2024 21:04:20 +0700 (WIB)
Date: Sun, 28 Jan 2024 21:04:20 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Frank Tornack <f-tornack@t-online.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: Western Digital SSD freezes on power saving
Message-ID: <ZbZe5OPlqhwi_erM@archie.me>
References: <dfe9213bb86939ca4502b5b3fdd3ab77ef1b6f1b.camel@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kEwaUIh9YENCpawV"
Content-Disposition: inline
In-Reply-To: <dfe9213bb86939ca4502b5b3fdd3ab77ef1b6f1b.camel@t-online.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_060426_349670_AD84B43D 
X-CRM114-Status: GOOD (  26.80  )
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


--kEwaUIh9YENCpawV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 01:26:23PM +0100, Frank Tornack wrote:
> Hash: SHA512
>=20
> Hello Linux kernel developers and experts,
>=20
> I have a question that I think is not tied to a specific distribution
> and goes pretty deep into the Linux kernel. I hope you can help me
> without subscribing to the mailing list and remember to include me in
> the answer discussion.=20
>=20
> In my old notebook I used an nvme-ssd from WD (wds500g1b0c-00s6u0),
> which is affected by a well-known bug. I currently use the parameter
> `nvme_core.default_ps_max_latency_us=3D0` to prevent the system from
> freezing.=20
>=20

What well-known bug?

> I would like to use a new SSD in my new notebook. However, as it is
> difficult to sell used SSDs, I would like to continue using the old SSD
> affected by the bug. I plan to move the SSD to a Thunderbolt enclosure
> for this purpose. I think since Thunderbolt is based on PCIe, the same
> energy saving measures and the associated bugs will probably apply.
>=20
> In the hope that my new SSD doesn't have the same bug, I would prefer
> not to disable the Powersafe in the laptop. Is there a way to set this
> flag only for a specific SSD? By identifying it by name or serial
> number?=20
>=20
> I apologise prophylactically if my question is completely out of place
> and thank you for your help. As a long-time Linux user, I would also
> like to thank you in general. If you have any follow-up questions,
> please do not hesitate to contact me.
>=20

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--kEwaUIh9YENCpawV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZbZe4AAKCRD2uYlJVVFO
o0sTAP0e4mQ3HmibZI7L+IrnI0a7gqHZTwdd3/HRZjxoxkCvrQEAnruBM/+E0z3i
+n7z/qvGHB34EXibxnmxzV6vk6wxggc=
=jxdY
-----END PGP SIGNATURE-----

--kEwaUIh9YENCpawV--

