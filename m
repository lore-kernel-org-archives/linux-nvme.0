Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C397CD37B7
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Sep 2023 11:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HpLzCpp4ouGz/OEm3hygeNnaRFyXfqnZwX2nHo6Wzok=; b=UDOp/T927tcn6c8BEOLl7BEX+X
	zpx6qK0L2f8vEIX/adSDBK3619C8pjKCcWEDu7TvbkLRXDsqQTWqf1RP1em+1T3W7IuBqMklFgHMq
	qNe0OaKhGZlnJlXbeB3lzIAfjXzr0J6h/4IyGNCBaetP4kehZXKj81mogHZSJFs0JyJgurkCJbH4V
	mqfvl1679xyliPMy9dSGBhAh45RzA8489HHrvxtECjGSrLZgcHprCEnvY/aZexrRosCusU930UN3Q
	rxyGUs9te+HIKfYqFDB8xV/IaiPLLJjsdLZ1Tsb2m6FFmA3jbhfgLI/otnMpLoWAiDEAZMDxtf3Rt
	zJvBH41g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qhTWe-00CSmc-0A;
	Sat, 16 Sep 2023 11:31:48 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qhTWb-00CSmH-02
	for linux-nvme@lists.infradead.org;
	Sat, 16 Sep 2023 11:31:46 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so2789532b3a.1
        for <linux-nvme@lists.infradead.org>; Sat, 16 Sep 2023 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694863903; x=1695468703; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpLzCpp4ouGz/OEm3hygeNnaRFyXfqnZwX2nHo6Wzok=;
        b=JXsGRlNCPqcxgoBD7/n70Awut2LwcM94zqnMgC7v3NkLGpIL/FbxAoHCmlAdSzR7ON
         OntPaaN2RpN6YA4EMCfegmco82o1X0Pn1Z2afE7HOZ+DoUjCo7QP2gCGmQnvSeqedYoh
         J8z4SyPcM3Y6/ojMuOVhWds+mkFDFNme4AXdm57ZbR7hXnN0XDd0hK7WW8W7cRCRp38C
         UdkeO7dmhxBD+EhTi9kBM3y88j9u8TBcJ3mgXOe9uEv1/FPts6KO1pYhk5uAYZiQ9Bt0
         c/ul+NppS5/tqNWGs9R0LNayYxIA889J81A8rP+PFJZ73z/cX5o3oeJW6s9p6MgtQY62
         R29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694863903; x=1695468703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpLzCpp4ouGz/OEm3hygeNnaRFyXfqnZwX2nHo6Wzok=;
        b=Aq2I7tc6522HE/acVeEoxlwrcZAQuzBOMc3YYaCNL2gkPfQ7q0LdX6EJjqVJiFNPM3
         PUoif/VnGF/xEizObRNGo2skusPsUS/KAHGvbsp9FhWRH8RKv119Na3R6TbSp/hmlAar
         PHkXg+O6XnAJydHwPF+7cSjRlwHC+n9+9Ngomy79O9p8VBszq4CfOF6Wzcq3L2pEZZvc
         pQZMAcg3RAW9LWyGhOZw+J5Yk14axEaKGL3PKjGmuj4hcSNGUEesa6DKmIUZ5mVyJnF8
         GIEAp6UnDGuDwUHvui20TpJcYfJ16km77V7uBvOqenpQs9cCOxrUrIp4KH2Ln0hHrzqg
         tHUA==
X-Gm-Message-State: AOJu0YzKdDVIyCYEAkPa67FK8tMH0K4+bxkD9Zlnm/uedMGu5T0pMPBG
	7S8Ad+5ILKxy5MPmnEg+MN4=
X-Google-Smtp-Source: AGHT+IHDxN5uOoCGgHPaH8q22KkvGNEbjL2HT742QPMNqY91zkWwoVYJ2tFXAtM7jdsgjHTPrU6UOQ==
X-Received: by 2002:a05:6a20:a127:b0:15a:56b9:43f6 with SMTP id q39-20020a056a20a12700b0015a56b943f6mr5367048pzk.37.1694863903045;
        Sat, 16 Sep 2023 04:31:43 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id v3-20020a62a503000000b00682bec0b680sm4354978pfm.89.2023.09.16.04.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 04:31:42 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id EA6A182F4CC2; Sat, 16 Sep 2023 18:31:37 +0700 (WIB)
Date: Sat, 16 Sep 2023 18:31:34 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: xiaohui li <buhuiyuanyuan1984@gmail.com>
Cc: Linux NVMe <linux-nvme@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Hanjun Guo <guohanjun@huawei.com>, Christoph Hellwig <hch@lst.de>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: =?utf-8?B?44CQQnVn44CRdXNlLWFmdGVyLWZy?= =?utf-8?Q?ee?= in NVMe
 request double completion detected by kasan
Message-ID: <ZQWSFgDrkLgw0tO2@debian.me>
References: <CAEVrx8CEFY21BBpbpq5CmshyzgDY_WYg7VGh6Br1bZac7kBiTA@mail.gmail.com>
 <ZQQRaj6WFizrDZHM@debian.me>
 <CAEVrx8APjinyO043+DOcciqDo_iygnB8x91g8XgeMFkCueiQ9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6zWCu6giBt3n2KWK"
Content-Disposition: inline
In-Reply-To: <CAEVrx8APjinyO043+DOcciqDo_iygnB8x91g8XgeMFkCueiQ9A@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230916_043145_073549_6BF2DE53 
X-CRM114-Status: GOOD (  16.09  )
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


--6zWCu6giBt3n2KWK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2023 at 02:23:21PM +0800, xiaohui li wrote:
> This bug only appears during concurrent stress testing, It has nothing
> to do with what kinds of nvme disk to use.
> Especially when conducting DDR stress testing, the consumption of DDR
> bandwidth is high. Once the NVME driver is under pressure, the NVME IO
> request times out=EF=BC=8C
> and then this use-after-free bug appears with high probability.
>=20
> and i find other pepole have also encountered this bug. such as below:
> https://access.redhat.com/solutions/6993136   (System crash due to
> use-after-free in NVMe request double completion)
>=20
> i have no v6.6-rc1 kernel,
> shall some one can give a bug-fix patch on 5.10.x linux kernel ?   many t=
hanks.
Please don't top-post; reply inline with appropriate context instead. Reply=
ing
inline allows readers to follow the conversation flow.

Again, as I repeat, please test mainline kernel first. Since you're about
to compile your own kernel, there is a kernel documentation on it [1]. Or
you can follow Rocky Linux's guide ([2]) (as it is based on RedHat).

Thanks.

[1]: https://docs.kernel.org/admin-guide/quickly-build-trimmed-linux.html
[2]: https://docs.rockylinux.org/guides/custom-linux-kernel/

--=20
An old man doll... just what I always wanted! - Clara

--6zWCu6giBt3n2KWK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQWSCwAKCRD2uYlJVVFO
o6ZLAP44nW9Uh09dS3YJqOWwZbUWii6MnJMKuHqStNANLwD9vgEAqoDn8nNZXNcc
ynVJXTo4j5E5ibBS4KIps59eIfcXPA4=
=qnVn
-----END PGP SIGNATURE-----

--6zWCu6giBt3n2KWK--

