Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC19BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 20:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BHVjc1X+IModu4+WVA5+FjFMUYPNgMAtgbIiZbytk6I=; b=ElM0tYP99fHMDW9X4sVhGNZIpY
	uKkHmxMB9xujk3Xb/sw+tAW5Y4dUx/fFey/JRgtT6Elx//zCdG3fIDZiJv0jwS8X7OCyaA+US1rgq
	z4jiwSULUSlc2XrkLUm7Gcgsp0HHqSoYXuFLDBqeD2jb9s0h+iIAyxmj8v7SmESHIhGBMQKce61z+
	hKmsRfZm2N3IwLvMnBmVsihndOdxaJRipISnLGaQcJiIoelIVvcFIvHpDijG3upRGSiuFgzmXpUrw
	ClEZ2NtuvsMez4Kn4NpuQz8cfMmIqY8z4ckZurBIlLh/BEtc986fP/LsLCTottRAbMrdvcoYPMnKd
	cD+e0KaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neNMh-00FjvU-P8; Tue, 12 Apr 2022 20:43:55 +0000
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neNMf-00Fjud-3L
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 20:43:54 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 727FA3200B8B;
 Tue, 12 Apr 2022 16:43:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Tue, 12 Apr 2022 16:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1649796229; x=1649882629; bh=BH
 Vjc1X+IModu4+WVA5+FjFMUYPNgMAtgbIiZbytk6I=; b=jg3dEDq8dqSajH+Znq
 dkooZwzNkrr/LMNnROxRhkG3UrskK/knNSd1y5K4ILcK5937qq2bNoE+afuBLluG
 Ozueox7Gq+IbXyZm7op05nyuI8DuidBW80T0ALqgejXO/+ZSEqyvPYT8AftunpkQ
 ru4xtBf3RU02r6HluK3v132nvRx9s20T1AFOPrP8OndG8RYYxB2kJ7lSUAUIkR1p
 F9ERtyq0mxdoClsrQFB2E7yM9uSa91g+DbGNH0COPMvvgMU+JeWhpsiBu41gP2XA
 0o7RnjfZ/Wi72A1tvBcbXx79+cHiJ2n11q78cYSXEtnBbTVWghf4DP6S/wNEk/nh
 Y/cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1649796229; x=
 1649882629; bh=BHVjc1X+IModu4+WVA5+FjFMUYPNgMAtgbIiZbytk6I=; b=E
 y6qk/N4OMmSwLavWBqx8WWsc7MWm7+gbewZxsybhhgRFXIhP89Q/MHLaGGMMhvur
 OXNND0+Dj6Qxl9Ca53XB1VJBdHX0k/rcLgmn5PE6Qs6ls8Lnc1MBhto7Kt2shJ6Q
 7jG/lQXrZ0qTxp4XlLuEPDqcm/INEm4wCVkQkPSORN7V5RiqB0Do0XlM6swFyW/U
 d42TEswfnK61M0w9w2Rxp5QxuUmDsWtyD3yeehC6eyARqouAEqlSefUTKDKSQgC3
 1xwX8ccGIFEgN12hDDprg7sDK4WeG5gQTw5PcvZIIWy/othLXwCfbtwOTDrP9EIR
 8H2wiPCrSGcwRMcaZZFEA==
X-ME-Sender: <xms:hORVYurZw8sTJMvahdX3Bsio4tvwBEE3AvpjJdH3dGXfr6PAKYb4-g>
 <xme:hORVYsog2s_UWIjHj4PWYiuRh_9yJJwD7HgGKNwijKwz-zOVyzK_adZhJ-01hO2be
 qpHJkY1D-NUEP_sdi4>
X-ME-Received: <xmr:hORVYjPK7dZKCzY6VnjsFwbjmWwj2Ej4ncAQxflGicLdMw2zuwUcg9PxdZQaSfQo1xjJirFx9M_CQnTX8WM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekkedgudehudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvddu
 ffeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:hORVYt5V0AzfXfgIYc1nSab00074tnQ15Mqs3fw50_DgM1WPp-pYUQ>
 <xmx:hORVYt7HxYrh8s58HFkOtcIjuvSpYIEWjiDzeA6BRsrmtHr7J2aqwA>
 <xmx:hORVYtgpVg29LKU0EMAW8G__-yhOMex-CXSi6mo2dMVo3Ky6_FMTDQ>
 <xmx:heRVYg2T95LvxrPAmsntq3mje_IUIhex4FIPNjWCHBmOIyckJrCrBQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 16:43:47 -0400 (EDT)
Date: Tue, 12 Apr 2022 22:43:45 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme-pci: disable namespace identifiers for Qemu
 controllers
Message-ID: <YlXkgUBxo7AuJuMO@apples>
References: <20220412061126.244414-1-hch@lst.de>
 <20220412061126.244414-4-hch@lst.de> <YlUdQjIXwL++K0Uu@apples>
 <20220412114533.GA31047@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="orBG/FcYl37nm/BB"
Content-Disposition: inline
In-Reply-To: <20220412114533.GA31047@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_134353_203183_FDEA7C37 
X-CRM114-Status: GOOD (  16.90  )
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


--orBG/FcYl37nm/BB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 12 13:45, Christoph Hellwig wrote:
> On Tue, Apr 12, 2022 at 08:33:38AM +0200, Klaus Jensen wrote:
> > > +	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
> > > +		.driver_data =3D NVME_QUIRK_BOGUS_NID, },
> > >  	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
> > >  		.driver_data =3D NVME_QUIRK_NO_NS_DESC_LIST, },
> > >  	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
> > > --=20
> > > 2.30.2
> > >=20
> >=20
> > When I fix this in QEMU properly, can we move this quirk to the
> > core_quirks and match on firmware revision? That way I don't have to
> > request a new DID.
>=20
> Do we known that only one firmware revision reported by Qemu is actually
> broken?  For now I'd like to get the regression fixed ASAP, and I don't
> think Qemu ever fully got identifiers right so far.  We can always
> change it later if needed.
>=20

To my knowledge, QEMU has only ever used 1.0 in FR, but I will check.

In any case, I did not want you to change this *now*, so I am totally
fine with this getting changed later if required.

--orBG/FcYl37nm/BB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmJV5HwACgkQTeGvMW1P
Den9wwf/UGDBKRt/hWUKgp7DdFjOr9yguRnPKNnwjfPuoz+VttQA95LmsAOiQjbO
YuwxMpO5vEu+C9mR8O+6q0DUC0WLZl8EJXdkcGHwj+7Rgz7v+Y0Gge1YmMpun34j
W5RHzP3lOKohL8deDdLXAZ5AhpntnjZIkPkXXNgedNBp/tb+s29+RNKMLXYUMrQI
EYIZkhOSXpSosdzAERaxUWXLGweMo0aAIMji1q9rYe0ZgnbNXxv4NhIVUaihxTLq
r60Xy2F1yjGmBBumaI7a2g7HbNsx1szT/VSWzmRVCBvnJh7jNzdTM8bEHJff0RYr
9GanQ/TYLogczhc6sJ915jJX68fwUA==
=cuL6
-----END PGP SIGNATURE-----

--orBG/FcYl37nm/BB--

