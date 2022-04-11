Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86E8C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 06:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P8qPKhWxOvZ+TXRrgKpS4TkSXAie4SZmlxe/WzNBFCw=; b=EA/s2Rlw8ZYSCKhfX5K+rMYHC/
	oew0ZI8qB9xHA0Lyj68ncIEPlZurtRfTYKyXWTfrSJ/svZkgXJflDAW9iwKVYltGjf4uHXHplonQ/
	mx60NRaqXqMF4lgP24LYENPpIBH7TrfBbo7iEHaBZIBU+7Sb0Q3YBk2tFf9b79U6MtVS0VfvMmeBA
	QHZG8IFioD6e7byncEZ11ApAG4wZ3AlQv+bradYGDcxmOdXARQkO+Glzd1jBAhBjVIs2DhA6jiint
	YMLZ9s1RRCggfWcbUgxRCM6Cy0O1q3Zu9wXFRoe4BEUt9FCY9/9rytpMBaNrPS2uXpg27Ht4NG/dY
	TGHVz+uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndnGp-006saV-02; Mon, 11 Apr 2022 06:11:27 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndnGm-006sZA-Bh
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 06:11:25 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 8BB755C005B;
 Mon, 11 Apr 2022 02:11:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Mon, 11 Apr 2022 02:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1649657481; x=1649743881; bh=P8
 qPKhWxOvZ+TXRrgKpS4TkSXAie4SZmlxe/WzNBFCw=; b=KonIyRGHtUZ6ouLV8j
 OsBJ2qKCH7I6djieSY9BkfQwMmW+4+WdXouv/Hb4DrBPzURgY5qGmoTf1394EYv0
 0iFbSZvHbVcVjrBhIg0hD0vY7kpI1Dalwhmy3x64fJ+AiTRDSe59joDuJnJ/PCnx
 4D9k+zuSKoric3MBCI4gYvAjSrbXcU6B90Un/m2vMbXvOSNIeXA4mJgk4tputIMz
 SZLQo0Pg3Gj7O5V9bvVmI94IovB8sCf4IpfQ5tQ5Z3LflcHcQPK2fqU94MlvfR9x
 cOkjmqtpCbMfZsAlwVu7v6zmYgwZ2Vme7TCNP7d4Uk/Wv/1Q2FFQ/Fyj9iKBY9H/
 nb9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1649657481; x=
 1649743881; bh=P8qPKhWxOvZ+TXRrgKpS4TkSXAie4SZmlxe/WzNBFCw=; b=g
 0pnEIqZjx1sDqrRVZ8lAB80alLhrFrfdQOGHwmoTdKs0hI7m79sQdxWJlGxjcTUB
 cRjaAlwJJ6tDqyp/ycnF4pzR2dptPHWMr2CoOrKf/1/reBpFma2lbHetfNSnhBYs
 TLWWGp1FtWhK8IUiHhUVz2eCMFhAsD82g+o3kh5LlXs2HD26M4q9bZJt0LJL9Hsq
 EnGUuC11cvB0qZJVk+tD4LPlpQgRy6z4nhSuieFnoCZCrZTEK8KMPYeN9iuMWfaR
 UIguDdEkzoCW/UyfqzVzVoErciT135bjWWldQLopzUB+gGS0te5hIdBkoP1e9BW5
 Vb/bllil2aUlKW4SN7+0w==
X-ME-Sender: <xms:iMZTYmEoSFGKcW9BBF3RR9GXct2OE557sBbW2NseQLFoiA69PIKjFg>
 <xme:iMZTYnVzYg-234RUhVirFjqBbDxEJnM74EUGD72ZIPXyc0HTuaEs0WIi1vfJk2Ejt
 sMYN6OV853dU-caDmw>
X-ME-Received: <xmr:iMZTYgKf4t2LeneIImRbz-JAtrYDxToW4mROnEbLhH6VL9LKzIb-iYjSAoO_Jiq3Hfk3C8jVE3XSPSWU49w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekhedgleekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:icZTYgHsFKuIGVDrrGpWg_1V9ltT2errGzmcDnkjFZL3zWCEVxwnWw>
 <xmx:icZTYsUmIU8NUHtAJIxfCw6Lz_sDu1Z3U2gQw9ZgMOySa3ScRSOHuQ>
 <xmx:icZTYjMcdY6zh_Pn2cQMeKKxg-2mkT4cCOxTMz1q12xDLVc5CQo8EQ>
 <xmx:icZTYqx-BKodr2ig8WAdVxFwP5PF_KM99Ky3TVdgZ1bvjMKnpWE2oQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 02:11:19 -0400 (EDT)
Date: Mon, 11 Apr 2022 08:11:16 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <YlPGhJalfFhCDC5F@apples>
References: <20220224192845.1097602-5-hch@lst.de> <Yk+KO8hEYpnKdGu3@garbanzo>
 <20220408052907.GA31990@lst.de>
 <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de>
 <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de> <20220411055455.GA14480@lst.de>
 <YlPET+kw4EVWfPRy@apples> <20220411060922.GB14519@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="y0BdgXz0NqM2Keqd"
Content-Disposition: inline
In-Reply-To: <20220411060922.GB14519@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220410_231124_508490_CB101C4A 
X-CRM114-Status: GOOD (  18.95  )
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


--y0BdgXz0NqM2Keqd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 11 08:09, Christoph Hellwig wrote:
> On Mon, Apr 11, 2022 at 08:01:51AM +0200, Klaus Jensen wrote:
> >=20
> > > I can also not find any code that would assign a different uuid
> > > when using a different command line syntax, but given how unusable
> > > the new syntax is I've not actually been able to try it.
> > >=20
> >=20
> > Are you referring to -device nvme-ns "syntax"?
>=20
> Yes.
>=20

Point taken.

> > Luckily we can do that easier now since we moved away from the Intel id
> > (which got rid of a bunch of quirks at that time).
> >=20
> > I'll see what we can come up with to fix this properly in QEMU.
>=20
> Thanks.  Please Cc me on the patches.  My qemu-foo is getting a little
> rusty, but I should still be able to help with the spec side.

Will do. Thanks.

--y0BdgXz0NqM2Keqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmJTxoEACgkQTeGvMW1P
DemGVgf/eNt7Hc8bvKocIBQ28hhQoPZMKpOZXJPtCvw/HlDscnAw2B2AZ3e4lcS2
i3cljDS+uIWywz7ita6WR8EXWUjPGGC7qXDxSD+gEgtAoBerWzkhFP1WffCJxP/7
DK0DPmpsKsm0tzNkEdP4c6J0KwmkcIoWcBvruV0nnQTvN17XANkmO78nKVYuW3P4
tV79JR0CPVPJX2XNZzQxM68cSo0cX1kENabk3XE2ftSM9jPeYcq1AmlroUJMq4y7
qkfXk6Li2LH2rDxIq3bXs5MFhlR/nDHLwkTWVFONBMnPuqS4aUdyCU1aVQCKfnkx
alBKC0nvZXjJaRmUojv32bPKp4ofUw==
=+4Vu
-----END PGP SIGNATURE-----

--y0BdgXz0NqM2Keqd--

