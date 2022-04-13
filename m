Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEFFC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FBNVRDht+7xAUeMyOoRilVhvN8OKILFFJzJUdwiiRM4=; b=piVxtxJPVipO+Q3in4nbdIVr/t
	D3iy4Nx5wN7gdH6KK+e53fwKH4ziifMR5GDpaRnt4afKK+94Qmcq8VPpCEmSO0MfumMofLFfHZYQW
	qgqV8ruQchiweJQjMiGh8lpdT4GJ+u5RdUQynxsJvmroGK7gYOoY++TYu0StZoq249Wx9gw06ftmO
	Uv5/A+j5/lkdFhBjeptvKhVEK1o4jmKhWFW9kIXOqILf0hEDgQc9oOevX12/ULOD/Wv0vBmn7pK+K
	729cCPGu64vquUMJmwy3FRTvL7nIAJJ4M0VJ9AhCkyp1bl62U8tCyJw9pNqBhAlu5stke4KIMbAp2
	jCbQ1zvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nefFX-001fAm-P7; Wed, 13 Apr 2022 15:49:43 +0000
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nefFT-001f8f-B9
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 15:49:41 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 83372320200A;
 Wed, 13 Apr 2022 11:49:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 13 Apr 2022 11:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1649864973; x=1649951373; bh=FB
 NVRDht+7xAUeMyOoRilVhvN8OKILFFJzJUdwiiRM4=; b=LsmZRCDPS9R2vwIWpf
 7ZcBUbOy7GNJw2HDzN0vCX3sYWcAAmPqYl5yy+TlYWAJInIbgCECBrcsl0fnQMCa
 gyEWIKb/Fd+bvrwRRkrBS9UOGLc2CNbJENKP4HQ3m+/2fd7mzldMbBNkNImjIXK0
 9F7a67I68zoJKXdiaMBf8C/NHygLIjWbJh0CbAbpJUKS1Nt5EoP0QSzenRGXKbS4
 d0jIUUCMznVFxFwr9/7LU8zxA7QknoqlSuXaWwK3ubCON53ksy3OTOP8NuR0SzB5
 g/VX8g4HjgYjtVscvjbNV98WrqDjmMDNJcTxcex0W2QOKavOffKuPQHcbHbGD/hK
 ugSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1649864973; x=
 1649951373; bh=FBNVRDht+7xAUeMyOoRilVhvN8OKILFFJzJUdwiiRM4=; b=B
 Lm+R/e971S/nLOVeAhasQ+5WthcHJtGnRoPix0wzFLYkzAoVywfXckvFjyH3GJR9
 K2PgMi0AhtkaNUZ6IOLwai8KJ+DIt+ZnvnI5cIaSHl4Wm+xHTuJk3Mz1QX8Q5+OQ
 D6p/Aew7NItpWTnCdq+JxaPFyt+kydqVRPddBqu8a5Y3NUtEXLGVeWEkKrVzEHmQ
 yFhmOzsHDX+ZUIqjkFa4rDR3/lQpMG0omkN6OujPCi6PpWoLDBsXk0Cy0J3GjPxE
 dYOmyP0FWZOn9IrxEKcAZZGfQWrbfcDIKBBdVKNMK0qM+bp6KXoA+SLYS8FkahyB
 B1UJH4iJx8/mNCZct9vow==
X-ME-Sender: <xms:DPFWYlENyhuFMPxwuSmH2KNzLxezcSDCKv13kVxA3Cibhy2YsLcA2A>
 <xme:DPFWYqWNoCncJJv0ZfUDYaaeYkFq-m2oYQ8HzZ9XdeAXz133osXNrJVof0rhZ-dkg
 QYqXTc8pQjCaZbFKsM>
X-ME-Received: <xmr:DPFWYnLlGppRc8cnbx9VLFZC5930jH8oZFuSfnprLp18-fPZivWSR983MJUr1t9CRuYZgaMzgcuY0FH0dH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeluddgieejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtdorredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeehheekffffudejheefleekffejteffhfehfeekkedthfefffdvteegudefhfdv
 geenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:DPFWYrGJk23Yxed5iJpzSQY4wykcBE-GUSPegviJs6uQPPkDpWzSzg>
 <xmx:DPFWYrVq9t5OACx-lOkjsQpAvpEDZsBrgND5eziWA5y3y5iKvoshgA>
 <xmx:DPFWYmOpjCj7tRgpaLEMk8rEbiLm6nUiP_Xbrdwquq9J_vSDTur3ng>
 <xmx:DfFWYhecbKnFi4bLOVomBCSmF1bf82WlGluz9yR6-kkhDGXoNOHPZg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 11:49:31 -0400 (EDT)
Date: Wed, 13 Apr 2022 17:49:29 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Luis Chamberlain <mcgrof@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/3] nvme-pci: disable namespace identifiers for Qemu
 controllers
Message-ID: <YlbxCdgPaVUykcqx@apples>
References: <20220413044905.376785-1-hch@lst.de>
 <20220413044905.376785-4-hch@lst.de> <YlZ8j70shRKv/tif@x1-carbon>
 <YlaMjz7SoctkLzYo@apples> <20220413153432.GA27146@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AsCgfri5fr6iM24J"
Content-Disposition: inline
In-Reply-To: <20220413153432.GA27146@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_084940_222845_B9C165B1 
X-CRM114-Status: GOOD (  20.40  )
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


--AsCgfri5fr6iM24J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 13 17:34, Christoph Hellwig wrote:
> On Wed, Apr 13, 2022 at 10:40:47AM +0200, Klaus Jensen wrote:
> > On Apr 13 07:34, Niklas Cassel wrote:
> > > On Wed, Apr 13, 2022 at 06:49:05AM +0200, Christoph Hellwig wrote:
> > > > Qemu unconditionally reports a UUID, which depending on the qemu ve=
rsion
> > >=20
> > > Since it appears that both older and current QEMU versions are not
> > > implementing this properly, perhaps you should also consider adding
> > > the pci vendor and device id used by older QEMU versions?
> > >=20
> > > QEMU nvme pci vendor and device id was changed in commit:
> > > https://github.com/qemu/qemu/commit/6eb7a071292a2f11065127ac152fa2424=
8806021
> > >=20
> > > Which was first included in QEMU v5.2.0.
> > >=20
> >=20
> > That is a good point Niklas. +1 for that. The driver already knows about
> > that ID.
>=20
> 5.2.0 is also the first qemu that supports the namespace descriptor
> list, that's why I didn't include it.

However, backwards compatibility in QEMU mandates that a compatibility
parameter is added when a device changes identity like this (i.e. PCI
vendor id).

This means that the 'use-intel-id' compatibility parameter may cause a
5.2 nvme device to present itself with the Intel PCI vendor/device id,
either because the user explicitly set it, or because the machine is
launched using a pre-5.2 machine type (i.e. `-machine pc-q35-5.1`),
which you would normally do if you want launch an existing VM on a new
version of QEMU.

--AsCgfri5fr6iM24J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmJW8QYACgkQTeGvMW1P
Den0ZAf/XMOERB1OWPBQ8kITNoV38Nh4nHXZHhB2tmJeFA0u3mXNP/kvkiffZ5eC
5pW1o7n05lref0weqmiZyh1n5U+t3wgruL3/cIbsfz/csaQmZgnExgPvAelAEBJU
sUx708x+tS1O5eH/Q3xKSkjxnMRL/tpDgpG46DeWaFAURRz45m6Z/Tgh5Bb0stwo
7MNCth0qbPz2QBZehcBhPpkJl8yeZwfpfS7uArcQU8+p7jiaH9B18i3UNRk8qEWT
YoHF5sE0yHwrSqOx/pNlsVSkKHUfYTYy/7Cp9E0xyE8dOkOv/Y6B80o1Owm4I7Ea
7AvKTSTBt4bIH3d7d7EZoGtpNmTWhQ==
=ZTI3
-----END PGP SIGNATURE-----

--AsCgfri5fr6iM24J--

