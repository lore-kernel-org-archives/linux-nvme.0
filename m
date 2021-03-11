Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E29C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 15:59:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3C464F37
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 15:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3C464F37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ynhpnJMT+ogF/s7g14kpvfjYPvmpcYJiMeYQqCN2oKs=; b=UUxnzeGk1QtnqvUgANsKhI/OP
	J9C4rIPF//TE3TaSQI/1s9DYPOF9r28mk59e3SzoFIScqR5Kyut1CTi3HoqBILRdCXUZ1uc20di7g
	/FlUcQdUwKYbKZ9TB8N7fA/i2wQTVUAUpsKyvBqVEsx2O/pcnHMfjNLeDb5kR32Kul7/FYaB18C2o
	FO3NB2xS6oTFEkZHLk8VVTgXEO5c95ZJB9aCzJffmRdzta4qdlwICSNPIZjdqVOXAesRxdUe4R1pt
	UpOm8Y6Rm4h2q4MWbstlq1qtAqCrdUrE/ueFTTpce6VBegiAghmxWveRoB/0BMpn1en/trrc7uEri
	5YJKtD1Sg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKNih-009WIq-6n; Thu, 11 Mar 2021 15:59:27 +0000
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKNia-009WHx-Ju
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 15:59:22 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 8C9C85C00EE;
 Thu, 11 Mar 2021 10:59:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 11 Mar 2021 10:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=Wv3/nS7MD1xrsFND2QSk9M5v4G3
 4Ky5NkoJSv3Gn2VM=; b=RMbUGJLDvIl2N2L1ytdU4f2G4W+Nvt5rhklEvxVCg45
 BTCi1nN94yQhi+HtrjUzpHu9xgoFGX4Lu+P7Ddj1vee99DEPjPsjGYO4YRTwaVak
 RBIxsmI1RtQurSprW2rC7YUcCGDJwI7FGFZ4z8myi3RmEkO1Q8kLKHoNo7kxFyxm
 HOip5CJGAUPu1ppiaSnS6bkpJKYlEA7BFve4+HmzBon06f3x14Bm7Vfv93S6Ibcs
 iKKpuSugO5+pL5PxqpuM9Dvq+MrCHUADMYEKaPnXUB2zS8StrrrB0z0YACe3zAAc
 KP5UZb4fwg+x+0oJ8rnwtvbDtvLinfO7YO37xnBn7Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Wv3/nS
 7MD1xrsFND2QSk9M5v4G34Ky5NkoJSv3Gn2VM=; b=N5uaLQzxCNLA6xRhmtVZYr
 IPEiWDj8QuxXGL3fiTYafkcUONjC8/dXwQ0Wsqpl/IjKH/e08U4kKSIM3aT7C6nH
 9UAam1efwdHRQ83dGogjGeEZPvgROb6pPn72Ga8g/R1ZWYzInMHOZ7iGNKoQPyab
 at37MNrPQfhuKGYCYxG9Iwcr7HMLdveY3+R7BGZojHFVApS8z8heDBEXuhiPXqqv
 6d5qxiqQAGAJ6iCY4smeNxu9HtROvA65sutCb+nynEYoEUkU2YpDxE12mlINfREY
 P1fe1QHuGAaEsyEAsvWB4zmtwZwIxBpX3OzR9DNOBxpKWL/6D8SCLgu6L4h2d6Tw
 ==
X-ME-Sender: <xms:Uz5KYHBUmNz04HQIbG7tda6Oox9UlbeStYE-zn9uBwE8xLUopK_Fag>
 <xme:Uz5KYNiv7gdlVxL4w123ZkAgOEus6hkPt7J-ZFdKUI9VYsrizWhNiXoRNYqVTgX8b
 dAbgLlTDzAhMa6XKHI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvtddgkeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:Uz5KYClHHTU_JBbb55UJOVNuVLvYThDpefBiFMdjEiL_xBUlCUIvCQ>
 <xmx:Uz5KYJyOFVgWmYYzN3fJ0p96jrX3kk5S2rZM657lHvVQkvgL2ERLXw>
 <xmx:Uz5KYMSkYdsoW3eA4Rf1KaafIszuU2UcCtUNbu_yKLQj4c46xtgZ_g>
 <xmx:VD5KYHcGCzYGWIVAHvKNqItgjE1GBczDdmH8boEPAvebkPsb2aadkQ>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5B4A9240054;
 Thu, 11 Mar 2021 10:59:14 -0500 (EST)
Date: Thu, 11 Mar 2021 16:59:12 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Subject: Re: [PATCH] nvme: implement non-mdts command limits
Message-ID: <YEo+UOu6paVwzdXY@apples.localdomain>
References: <20210310195726.3377288-1-kbusch@kernel.org>
 <YEmv3nNynyBHggoz@apples.localdomain>
 <20210311154952.GB27105@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
In-Reply-To: <20210311154952.GB27105@redsun51.ssa.fujisawa.hgst.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_155920_924151_7D01C3A9 
X-CRM114-Status: GOOD (  11.48  )
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
Content-Type: multipart/mixed; boundary="===============7514427121786137774=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============7514427121786137774==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J4xBgjK0q8gmG5kG"
Content-Disposition: inline


--J4xBgjK0q8gmG5kG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 12 00:49, Keith Busch wrote:
> On Thu, Mar 11, 2021 at 06:51:26AM +0100, Klaus Jensen wrote:
> > On Mar 10 11:57, Keith Busch wrote:
> > > +	if (id->dmrsl)
> > > +		ctrl->max_discard_sectors =3D le32_to_cpu(id->dmrsl);
> >=20
> > Since DMRSL is in terms of LBAs, should this use nvme_lba_to_sect?
>=20
> We need a namespace for that, but we only have a controller for this
> Identify.

Ah yes.

I remember now that I also complained loudly about this mistake in the
spec when we implemented it in QEMU.

--J4xBgjK0q8gmG5kG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmBKPk4ACgkQTeGvMW1P
DemCqAgArpZVzpevAXNQ/ubbtQZO82/BbRhEzeCkSvdxQi8cE8ViSzMNVufuB4WI
a/BLhRMWukoeOBuBFL20gfdQcxDAFusLnsujRkC3d4sds5QMT1PfHkoAdgacZYdc
5aPyM2Xxs4CMRfYT40BGtMwWCh7+4dY03kA7bh8hyL0XmnhrFazU13R3lTrMMHYz
rtbJsa36ChLj09AnOE7BgWCvFW18RiF/YywmvJpq1Yp27hftQuh/RmC/IihhMrSB
Ye4jnKoIHGCAtMV45ju3A/5ZRk/Iwh9A6Ec8yNb3xLNy45+iE2MTtATejkz/GTEg
ZyfqgHcchGRePCFNJiimB4MoV8M5ow==
=NDZh
-----END PGP SIGNATURE-----

--J4xBgjK0q8gmG5kG--


--===============7514427121786137774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============7514427121786137774==--

