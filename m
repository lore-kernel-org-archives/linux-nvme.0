Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A19C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 08:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OlztrA2PelhRNweSogsFYjSs6DF8vj669aWaoz/QJSU=; b=11EFCXUKIBiTpNlv/ZwHTSH695
	nF+SOU9MPA5+Umxgy8jn5dJicbhDMWAmFtWwtIh6T/j7FSUVbAh0OPvx8E44JLd46qW7tY5B2wZYg
	F4sQCDQ5RXcPumIbxSTkROusIY1L94aCWSwB1G6ZV2+pRspnLHj6jpx8/GbA59DRL+x3X4NjKJ1tW
	XZnAD6rZ57i7lVveg7mG+luVXeK0UXLCdj5Kb7RU9+PQC/jThz81F/6QkihPmoJGqvyrjoCRfp9Ul
	XcbBlQEDNaN0HDC37P4YfkDH4BK9PiMVkmrUk4xyASCY1nPrGUDhi0vkVw3fuOR3PFJHGMce1Qzlm
	QolzAytQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neYYg-0007ur-DE; Wed, 13 Apr 2022 08:41:02 +0000
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neYYc-0007qS-Hp
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 08:41:00 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 9F3965C0046;
 Wed, 13 Apr 2022 04:40:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 13 Apr 2022 04:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1649839251; x=1649925651; bh=Ol
 ztrA2PelhRNweSogsFYjSs6DF8vj669aWaoz/QJSU=; b=LkafVI1vKtiTxn4eqh
 zS0M6iaa68EPT/lQa2wHl/pTb5mZMxM1YURMiNwLYrCaai2F67MIZ6RbB1erlqrz
 zP9mLivvc363sP02rA3b2oFTklaU+DkbUSONr5xbgEEFMGe+/Z+3KodIER/+7ON7
 IV8BgKFg+p3w/Yu6fv6yAqGqckGGJ5DiJsVCnaBrVGjczSLIYPlUOvKNchYFSkru
 PakLyZGmCJKTFm89I1Azwms6JPepTVkACF4Hw5o+XivSP3MP+vgAM3DOXHkxpKGL
 /r8GEMgerIJelRbYICvFR+Fwz6NVqacbR01A1E+WeQr1bM9sE4n29uHd26a82+8S
 7mPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1649839251; x=
 1649925651; bh=OlztrA2PelhRNweSogsFYjSs6DF8vj669aWaoz/QJSU=; b=V
 d4g8OUGDH5z6i7rvZ2KJXFZniwKGy7djb8Bva4M1+WlYrcdfpQZO6msNg10yyNYE
 xAgltmWZwOhsNYzwzPhqb0WpE+kbZBl4X+GcsHEr8FICpjhS/YlfuWB6HBLz4sH+
 idrRBe/nWrpSMPqBEaWlXQABbfJglhXay4hmG9HEO+Ij8Iy2YI3yo6D7PqYvSAbw
 q6C0JlfXJ4cRzy43kjqI+yixPpz6WMF343n9JgVRzxGBOgK+FkIlnhnW/R5FWcu0
 DyDQDjzSxmb84FqBVAg0F/6eWW9wJjkZGvKxsI/HRIJcKjEHZJbPBueMY+6pOMVO
 jiuiUytUcFXcppBK4wDtw==
X-ME-Sender: <xms:koxWYtEmD6VlOkbnoO_O7khEavHUP5X3jv8APC6xXB17TwtvRFsvbQ>
 <xme:koxWYiVp9TKwbWL_6S2NP9mQ-OljkaGhqBvZOU5DOS3AJcgCCa-O0a90mvQjhfprf
 j_ZvUPpDdCPASn2K1E>
X-ME-Received: <xmr:koxWYvJacSqd9Zq6BMQUMUcpv-V30k-qjmZXoS3sOf01NWaCFen4H1Dve54uVVfcg8V7MmEb6kPze7nnrYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeltddgtdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpedtleekfedtueejueehledtudeugfdutdeigeegieehhfdvtedtgeetfefggfdu
 keenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:koxWYjGR9OF-PhxUJRfH1R427gaYUnRx3Mni0pGoU1noyVxzgfFYPg>
 <xmx:koxWYjWcA4NpZIdAaCEwrWUX9DWPQN5x2_Jm5t7I3DqRuu3k7gMdMg>
 <xmx:koxWYuO8o35F5CychyhjuZ8vWiMZWo8OVzdQldPXnGsj0tWgW_1c2A>
 <xmx:k4xWYpcLF2oAxNtTUVBCiR-VXrUy4qbYQCbsj5EYhmnQ0g7u1xkr_A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 04:40:49 -0400 (EDT)
Date: Wed, 13 Apr 2022 10:40:47 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Luis Chamberlain <mcgrof@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/3] nvme-pci: disable namespace identifiers for Qemu
 controllers
Message-ID: <YlaMjz7SoctkLzYo@apples>
References: <20220413044905.376785-1-hch@lst.de>
 <20220413044905.376785-4-hch@lst.de> <YlZ8j70shRKv/tif@x1-carbon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SJE9fphEgyOL6Faq"
Content-Disposition: inline
In-Reply-To: <YlZ8j70shRKv/tif@x1-carbon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_014059_442370_73B1326B 
X-CRM114-Status: GOOD (  13.34  )
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


--SJE9fphEgyOL6Faq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 13 07:34, Niklas Cassel wrote:
> On Wed, Apr 13, 2022 at 06:49:05AM +0200, Christoph Hellwig wrote:
> > Qemu unconditionally reports a UUID, which depending on the qemu version
>=20
> Since it appears that both older and current QEMU versions are not
> implementing this properly, perhaps you should also consider adding
> the pci vendor and device id used by older QEMU versions?
>=20
> QEMU nvme pci vendor and device id was changed in commit:
> https://github.com/qemu/qemu/commit/6eb7a071292a2f11065127ac152fa24248806=
021
>=20
> Which was first included in QEMU v5.2.0.
>=20

That is a good point Niklas. +1 for that. The driver already knows about
that ID.

--SJE9fphEgyOL6Faq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmJWjI4ACgkQTeGvMW1P
DekjJAf/UXGIILmFgUdAFZmwZ89ixZYW9vtJS7woDfFYL2kROV+lMohaQ+S6piyj
XP0TmDpCEQO9w5Y6sddivivLzHJRZRmWx47zvsNoHmllyCbeBTrbu9hOgUmNTa47
6XM4xTE4N8ka+DJOY7wZtvZdXzxb+CRj2Y5CwBPOnVDeyZaaJgwICyMUk12fHU8e
DVAENpVeKrulfxTV9eF/4l4GamkD6plSH9L3/z5X7b+1tXmJFE0p0fjFtkQf1EH4
rvMx+aVKz2YVEAUmSl8wc9NZaOjK6yBg1K0IDE5ZSxBVuUpaJr24e6ZhWYpVk7uj
Kva9YYvl6EDQRMM/kOW2M+UBT40HuQ==
=cpqp
-----END PGP SIGNATURE-----

--SJE9fphEgyOL6Faq--

