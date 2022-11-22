Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB8DC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 08:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PADjG1qRGw8ap41PGbGNiTgnuCFlHH3z9MLyTMnsN0s=; b=QyfHD6TKN96ULN9+eMnAWnsOyJ
	AJYdIjSo6ON+rXz4yhn2b11ecIVgmVa8TLEcJSoUsj4LKEDYH5zvDhY7UJpIdSijDN8YV5HtrfkaO
	GVmfNpcpeYfy+wQHOKUq1GLGb0UOrTbOqMrARC6zoem6dIZXN3qYxhJtMMY5xM4Kvk1JunZlJqwZL
	wXXrVgPzRc9juv84/2ZdwE8xcsej3Vhd6Q6skiXwLvVEq6Gi5ahmn7IXBJl69uIXY4+rF7qglKlH3
	8i3ZrZLyw5jJv7NtRY5DMSNGkcz5eoA1RUpJrshBAcEMD1rFj+O8ppVm6e8LUn66Xt7pGYdHYD99Y
	bEFdUnAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxOcG-006EnY-LJ; Tue, 22 Nov 2022 08:26:52 +0000
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxOcD-006Ek7-DX
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 08:26:51 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 94D9132003AC;
	Tue, 22 Nov 2022 03:26:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 22 Nov 2022 03:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1669105602; x=1669192002; bh=PA
	DjG1qRGw8ap41PGbGNiTgnuCFlHH3z9MLyTMnsN0s=; b=gPcLfii5rKYW4d5JnX
	P7EZqCRvRgXYneZuLO/7itIHDe+fkCcSdKXCgK2CJIXS5CytIJmH+j8T8jKkyogv
	+icHU2t3hMbJTQETV8SwermbygMzBEOnGsqHDLk5WPjXALzBgC2DlqWv99ZMxr5U
	9abRG0gqFMaFkdYcuObPdK3mPAddWCOwIkV6oZwONVyqITifwie19K1OUaM8wk1O
	z9Z8osfAJ+8nVtGM/CL4o2SFK7s+DkGDpqnL/efAKQaie0POSJznI5jMkVL4+U9W
	yS5Ujx+W6Kzya2Gw+ZKeXLFoLDSXgJYu6mrUbRZjozECU3VgyDeejhHG8FbMlJ5b
	Lsvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1669105602; x=1669192002; bh=PADjG1qRGw8ap41PGbGNiTgnuCFl
	HH3z9MLyTMnsN0s=; b=StGQRgoA7kKBmgX05AV2sqFECVJkmEESvfREQmLuUdBT
	rfrsi0NhyFfmRKRDt504Bl3hLVEx9szEBM96kSNE7aInUbZRQ+0rXpcpzLRaGEHB
	Bt/GKAKUwAt9+Fz2E7tS+p6JcLt6IaeoGU2TIJP4mPsqtz33enSBTvCyZW+JXrDz
	+g0B+CXjX7Uv/aAkfY744FAGXpkLen5edSMLqOxCVwO83TwLbaxgfjbsQUVj4Boh
	DW1SL0alcTEjCpxhPI5nJ4EpgJiaMzVjcuHe+EjnVoMZm1ikKre90nj+lCGNaf8x
	hmPTXVSt4Wdt2coHGf7hQiAkZNaT1A7cbn5sarIHww==
X-ME-Sender: <xms:wYd8Yw9pUMZLIu41_Py8UuWvhyBRb1tnjbDilfW2eWxImIJ2pMYJfQ>
    <xme:wYd8Y4tRatKbNs_Gbw1WkIY7d7EUeNNUFDbaszQCW-2Fc-ze_xsdWonaelfR1i9K6
    WJJnPAIf0-nkGliDRk>
X-ME-Received: <xmr:wYd8Y2DyC8oLZYyeb13g9PPXXRjFXQWZqMKfOhZn-JJky3lMNI9zxfQnaYzEOets3EXA6fcM34flsSAEl0qt_IKlnldlbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheejgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
    shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
    htvghrnhepffduvdfhheejudfgieejueeileegveduvdelhfekhffgteetffdtvdekveei
    leefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:wYd8YwffO7iAQ1J3Vc2wZMMIM7oPPZ_jMgjQRaKf8kUNDJ_MTHffqw>
    <xmx:wYd8Y1MEliTg9-jd0JGdyLaZjAj4IKsZYHMAr6eIPKCh44GvTCSLuA>
    <xmx:wYd8Y6kFLdOsw6wiZGF3x2QGgmSpeo51YgwektltzI5qfiV5hdGiuA>
    <xmx:wod8Y4dUB0f5OuSbuzDyaL7nVgq6balCKPEShp5pJjLk1JXg-hYnOw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Nov 2022 03:26:39 -0500 (EST)
Date: Tue, 22 Nov 2022 09:26:38 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Cc: Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] tests/nvme: Add admin-passthru+reset race test
Message-ID: <Y3yHvg27tKo11YCF@cormorant.local>
References: <20221117212210.934-1-jonathan.derrick@linux.dev>
 <Y3vlsF7KcRrY7vCW@kbusch-mbp>
 <e99fef7c-1b48-61e2-b503-a2363968d5fc@linux.dev>
 <7dcb9e3c-aa3e-b7b9-fc30-59281d581fd0@linux.dev>
 <Y3wED5m5JHOFMMg2@kbusch-mbp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w41FLNgbXu+RbZ/D"
Content-Disposition: inline
In-Reply-To: <Y3wED5m5JHOFMMg2@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_002649_805647_2EDE7E45 
X-CRM114-Status: GOOD (  24.21  )
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


--w41FLNgbXu+RbZ/D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 21 16:04, Keith Busch wrote:
> [cc'ing Klaus]
>=20
> On Mon, Nov 21, 2022 at 03:49:45PM -0700, Jonathan Derrick wrote:
> > On 11/21/2022 3:34 PM, Jonathan Derrick wrote:
> > > On 11/21/2022 1:55 PM, Keith Busch wrote:
> > >> On Thu, Nov 17, 2022 at 02:22:10PM -0700, Jonathan Derrick wrote:
> > >>> I seem to have isolated the error mechanism for older kernels, but =
6.2.0-rc2
> > >>> reliably segfaults my QEMU instance (something else to look into) a=
nd I don't
> > >>> have any 'real' hardware to test this on at the moment. It looks li=
ke several
> > >>> passthru commands are able to enqueue prior/during/after resetting/=
connecting.
> > >>
> > >> I'm not seeing any problem with the latest nvme-qemu after several d=
ozen
> > >> iterations of this test case. In that environment, the formats and
> > >> resets complete practically synchronously with the call, so everythi=
ng
> > >> proceeds quickly. Is there anything special I need to change?
> > >> =20
> > > I can still repro this with nvme-fixes tag, so I'll have to dig into =
it myself
> > Here's a backtrace:
> >=20
> > Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 0x7ffff7554400 (LWP 531154)]
> > 0x000055555597a9d5 in nvme_ctrl (req=3D0x7fffec892780) at ../hw/nvme/nv=
me.h:539
> > 540         return sq->ctrl;
> > (gdb) backtrace
> > #0  0x000055555597a9d5 in nvme_ctrl (req=3D0x7fffec892780) at ../hw/nvm=
e/nvme.h:539
> > #1  0x0000555555994360 in nvme_format_bh (opaque=3D0x5555579dd000) at .=
=2E/hw/nvme/ctrl.c:5852
>=20
> Thanks, looks like a race between the admin queue format's bottom half,
> and the controller reset tearing down that queue. I'll work with Klaus
> on that qemu side (looks like a well placed qemu_bh_cancel() should do
> it).
>=20

Yuck. Bug located and quelched I think.

Jonathan, please try

  https://lore.kernel.org/qemu-devel/20221122081348.49963-2-its@irrelevant.=
dk/

This fixes the qemu crash, but I still see a "nvme still not live after
42 seconds!" resulting from the test. I'm seeing A LOT of invalid
submission queue doorbell writes:

  pci_nvme_ub_db_wr_invalid_sq in nvme_process_db: submission queue doorbel=
l write for nonexistent queue, sqid=3D0, ignoring

Tested on a 6.1-rc4.

--w41FLNgbXu+RbZ/D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmN8h70ACgkQTeGvMW1P
Del4HAf9HmpKjKKpmkVjwjX5KgJ6sEc5C0Uk4yo65S75JRYGaTWBqqPbUvKDfUHX
W1qZW3cKohqXU0FjVbRxFdcieBVXCRt6BaHG/0ICFO9qDf7R7YJR/dQo7JyHkVuM
T+mWXl6xcVE5JbgyE+6s1wYaqtJv+v+zTCMFiHCuXvmGtVDjtnkaSggYy5l0bXKI
rjn7AhSQqI/FIFCKK/J03Cq9q8AZoN5QdP35kKg26lzFyvxjgNFKq/29EWu9LX1e
c88iWyrKod/6poMv3dHVWcvTMJUqsYOG0d3kihdbicoCuqlEPUFRauHxv7ji7pMK
0U+O5S+bykNNIvxi5DLPgZ09D0nFIQ==
=SbmM
-----END PGP SIGNATURE-----

--w41FLNgbXu+RbZ/D--

