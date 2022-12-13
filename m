Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DDCC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Dec 2022 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FB3GTeThf+PxfwcfSkW3UMFO7h6VBRdiAGE3OquQ1yg=; b=KHjT9RMq72Pu88KJQEkehR3A6g
	gBGbDRiGJ4/jNVFVUUrS/zi3dqXSAFZtInjZZvZGPo9rL50ZJQKPH5yt+b8KMRxCBEqLD2Qc1ljOh
	XmPql1NpykGv85SZl7GsubI+MQiLIP7UApIQoQrw2WcgPEa7Z8m+8UxOWnMbekfI0oBVCoojXUeSI
	MNBxoyfVQ4iXmU9Ay0IoziHsW0Ugzgl01QoYV9RD4UagAh+pvX1dBBi+kqDh3bKWUNuMS7MdpY4C8
	/BUVzfG4Lgj2rwJd4IOmLvNbZU4uZOitpSW4kpiFq8xoAhWwIRZv/pIbQBhBY4YM6UCkArH2/RNoO
	7KEfK6Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p511c-00E5jt-3l; Tue, 13 Dec 2022 08:52:32 +0000
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p511X-00E5gY-Vi
	for linux-nvme@lists.infradead.org; Tue, 13 Dec 2022 08:52:31 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 28EE7320034E;
	Tue, 13 Dec 2022 03:52:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 13 Dec 2022 03:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1670921542; x=1671007942; bh=FB
	3GTeThf+PxfwcfSkW3UMFO7h6VBRdiAGE3OquQ1yg=; b=Ra23TVkwDdC5DO3wHi
	rSroRzvXwZiJMYDoYsYQfnFAz6T6sWoYphvE8bt6628DlsM3GoIu0kpt5RWfpB6T
	oXeKgTM9VU43Mgl0AP2DaPouNmm0bZAkXxaz+v675sjyMDuURFrsZTfp5gc9pPqL
	4fLvbOmD5PBflstHuSlEnapdqZATLgMTe8m99x8f4cRZeipfGy5W3XYETctaKnJ7
	R0NrzYVVWNjdREJoxABddO7yuedrnuoFk/Z7uWlldwoDpTB9mIeSydI2MTJVjbZG
	XFdfFdEDznwUNL3ez4B4818fywdfWlWAGWc299QQx5XTxqDz0WoIJou0MS0XRG9z
	pqHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1670921542; x=1671007942; bh=FB3GTeThf+PxfwcfSkW3UMFO7h6V
	BRdiAGE3OquQ1yg=; b=WlsZKabHR0KMxBttNypfS8NJ0GCVpZA8f2UQX+k9eNWj
	j0/NgWY3RDShLRkoOUmPxF+i+bewkwoB91+CX/3x2ibAkHj8tRUCEBbyfLcEaaH3
	8CZWNJJ71D2MTezzrWozqXqgIEzIwg8nomNKaC4vIOWY8eM6y2UwjJznoPnlBZzJ
	lARAygzZS4nM4z96c0s4BHoSNISPgCTT0cfBR1EMI13mzRdgSuyJVyzjqqBtWuAm
	epEKYgnPndXw/VtiBQUhs8K4boBlxw8X4bzg4I/Zo28ucoh6KfrdKxFGJswH6+qk
	ZmAWpCchAXWYO4UXHhy7in8bqX2KHdkHOqfDGnVejA==
X-ME-Sender: <xms:Rj2YY5yih1YhilqionqrrmqsuycQWLDaVkZ7mYZiVTK12QO_tXnkYQ>
    <xme:Rj2YY5SAnivRyqghrMVTyB9WZgiwt8-8I3m-RILz2bKoAfcKyKnldQ_x5prkAVb5S
    7xxmIGTfEw5uYbSg0Y>
X-ME-Received: <xmr:Rj2YYzUP0tF5xiqacPrBOS5aQEMTFB1sxFLUrRwh7XbpZhyT-QEC_C9Ukh5-WweX2UDGtBM86S2epOSjNBidqVe-dXAOcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
    shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
    htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:Rj2YY7iD2U8_9CLOflJYjVSXe9W-bALVhxT_gbqJkf-I8gdD-SeKnQ>
    <xmx:Rj2YY7Ap2KV4yj_cLtgHFg6cf4FqKZDWuRRA6oLOkzwkqAHCYibnuQ>
    <xmx:Rj2YY0J8pGFTAi_pZfLocquXQmuWYFhW843iyMl2us7GbMBFM7A4uA>
    <xmx:Rj2YY9BXuQUY4EVqKvK2-dh2CFEWOymXllrtpLVyey2w03KbLIXgdA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Dec 2022 03:52:20 -0500 (EST)
Date: Tue, 13 Dec 2022 09:52:18 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org, Klaus Jensen <k.jensen@samsung.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] nvme-pci: fix doorbell buffer value endianness
Message-ID: <Y5g9QhH1asYdXpZx@cormorant.local>
References: <20221212150243.41283-1-its@irrelevant.dk>
 <20221213085057.GA3998@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f6KDFeo6ijDRncdJ"
Content-Disposition: inline
In-Reply-To: <20221213085057.GA3998@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_005228_373027_DCCE313D 
X-CRM114-Status: GOOD (  10.24  )
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


--f6KDFeo6ijDRncdJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Dec 13 09:50, Christoph Hellwig wrote:
> On Mon, Dec 12, 2022 at 04:02:43PM +0100, Klaus Jensen wrote:
> > -		old_value =3D *dbbuf_db;
> > -		*dbbuf_db =3D value;
> > +		old_value =3D le32_to_cpu(*dbbuf_db);
> > +		*dbbuf_db =3D cpu_to_le32(value);
>=20
> As the buildbot noticed, this now means dbbuf_dbs needs to be
> a __le32, and the endianess annoations will have to wee through
> quite a few places.
>=20

Yes, I'll fix it :)

--f6KDFeo6ijDRncdJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmOYPUEACgkQTeGvMW1P
DelZbAgAjUBmJQ3Vwc+bf2H2i5eMeE6lMqnNtytTmRAE7zysG9f6Xj4tHORjniAP
IWfnTH8xqTuD+LY2QoHDb8/VlGwy0v8Jx+l71zScPtetvKJbL4ei7YMi195aQPxP
4kH3UyfWgrKZKZT6zlT1mecyvZqNZDM7ie/syoIRY9p4BaQAibKXhp2Oh8hu3Qkf
y3sUo2tVvoeqqeNbFXbQ+f2IaQViNViB47iT13USIDr2K4q87D/lJMsXBGMDKgxd
sJcpLhfd1X/VnfEPHOef/JgqwV0xNFz/7ETwEeOQD42V2Z1lKbprztIs+UBV9fM8
Hl+26hwhmSe2cBmDfGUlQacynyy/cg==
=UqF1
-----END PGP SIGNATURE-----

--f6KDFeo6ijDRncdJ--

