Return-Path: <SRS0=b72z=GS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EABC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 06:12:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00146239EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 06:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00146239EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2uTee8MY6iKs4QKu49oloDOk+kD1h+idKRdFoxqa434=; b=K/cHTK548KTIu2o5F5gV4XUvZ
	60TmNVBV2SOGOxDu6Kheb1Z2QypC8xbPdApeA9oSWmKtm37pyr/jREcgg3kYen7N+4WqcRCLMHVxZ
	GYedHR59T3byc/DCzXlBVZuf4e6ZqaCUdh8+YiXOjSy6YK4h/ifgHABiWRxSRroBWWPMd1uvuMV0N
	IKlq4naOQ8gMJetCTtLEodtb4BNQU6H9uOVJsWnDNHqE6vbd+sCX3zWyr/Q43KvXoPDphK4A+AGQo
	1pV41PlHhaJWFV8mgWEFqFraUHEUv1L6GJUiYOEqqmbBmD/ANiOyOlejqRK9JyzHgAwRcNp45UvEv
	WeLVIjF4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0ILW-0004xG-Jo; Fri, 15 Jan 2021 06:12:30 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0ILO-0004wQ-HC
 for linux-nvme@lists.infradead.org; Fri, 15 Jan 2021 06:12:23 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id A1C9E5C00BE;
 Fri, 15 Jan 2021 01:12:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 15 Jan 2021 01:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=OpaUv9Wj6mU3orLFV7nAjT0ewKj
 hVmLOFCQUxpWEuvU=; b=nUFo4wSURbN1G4cSzaU/N3p5WG3/FHr+ewYpoU1n8PB
 IoOUzssXGIlOTvllY6kZESJ5oauPsQnOTvn0dJASrGSXih8q4YBuED60r8zROs2z
 scQrJW99fqp49mleamzPbPpZc+Dg2j8WUN2tV7MQ3YgJ52IoT5Fc6lkv0IYR7KSa
 dZ3JIbWYGPDSaHGrAyeepcwsaTZ44imoIfg8Dm9FhspGFwhiJc3F5Qxwu8P6PUGL
 S6KRoOSWlzWSOfVrt+pRuIBEOrOuT5kX0jY1fzpD05q/ebLyJeEEeVqu772KsyTG
 /ost2GgwcyVbSob/FYb2/bgLIrG30qnLyCb40zeBEsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OpaUv9
 Wj6mU3orLFV7nAjT0ewKjhVmLOFCQUxpWEuvU=; b=jyI4E0o/GI/qpEGpjC2SJu
 PD+QgN8t4SiR167xTuXun7bgbFmudP6A/+1tTYuPN7FUW5BGjWXpvmQ9zAjnqpiv
 HUEW2ZoO9JjEui7UTff1sBE4bH9VaXt5WKW0Dv/+nsz5QORUpAMNHA+OrnVOwxRc
 GNGg/X4VmCpZGzvRJUGOD3D49Mk6LXNChWx94j63KgGurAMFOf/uaf8m7f0+MGT0
 9z7/OjQaZU8vuGMcXCbI2Ve034C3ZOLZ10DdsOk9P58tbYRyO2yvBlCb8crpByUJ
 ponCLCSMOkRHqeBhOgWamR8NAt7nza6rV/6eP7GT7uVE6tS8Kt5eeyKC21YMrEfw
 ==
X-ME-Sender: <xms:QDIBYHrQ6n80vh3FFGqHCcVfEuYUgpzkRjgVbxIPXrhJ-ssg83LJmw>
 <xme:QDIBYBp8trJxQG4C1TLioK8TzrvV4kwvjwTykzHKRNXHBUoAmOxZuKf0K9tCYP0ZR
 4Aidar4jH722KSr9Jo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddugdelvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtroertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueeuffeihffggfetheejieevleduhfetfffhheeigfehteejieetvddtgedvhedt
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:QDIBYEOLivbr8Dnfn-AKSXnsnCmkwyzqXhOv9XdyxAAUktTuS11xtQ>
 <xmx:QDIBYK7pwjJxbYQrw9Jc2A3vTSPOfV7FXoYe8bO2qY7v24ztImtNJg>
 <xmx:QDIBYG6Xm0epxo8IE6sPVsP_4d1oCOmhuHsbImA_xFPW-CT56zfA_A>
 <xmx:QTIBYB2HVbhAzoIa7w1wmZO3sNtwCQaUPtUStFNfKoTkp_X-B19WoA>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id CC5D81080057;
 Fri, 15 Jan 2021 01:12:15 -0500 (EST)
Date: Fri, 15 Jan 2021 07:12:14 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: allow use of cmb on v1.4 controllers
Message-ID: <YAEyPrRkvJiRaoTr@apples.localdomain>
References: <20210114132441.193782-1-its@irrelevant.dk>
 <20210114173313.GA31028@lst.de>
MIME-Version: 1.0
In-Reply-To: <20210114173313.GA31028@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210115_011222_832412_AC0CEB60 
X-CRM114-Status: GOOD (  23.16  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Klaus Jensen <k.jensen@samsung.com>
Content-Type: multipart/mixed; boundary="===============8000926051700885360=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============8000926051700885360==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wUsAb1c1D8a8ijgm"
Content-Disposition: inline


--wUsAb1c1D8a8ijgm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 14 18:33, Christoph Hellwig wrote:
> On Thu, Jan 14, 2021 at 02:24:41PM +0100, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > Since NVMe v1.4 the Controller Memory Buffer must be explicitly enabled
> > by the host.
>=20
> Thanks, this has been on my TODO list for a while.
>=20
> > +	vs =3D readl(dev->bar + NVME_REG_VS);
> > +
> > +	if (vs >=3D NVME_VS(1, 4, 0)) {
> > +		if (!NVME_CAP_CMBS(dev->ctrl.cap))
> > +			return;
>=20
> We should not check the version here, but the presence of the new
> register so that controllers claiming an older version complicance
> that implement the new scheme are supported as well.
>=20

Understood!

> Given that the old scheme is highly dangerous in virtualized enviroments
> we should also warn about it and eventually required an explicit opt-in
> to use it.
>=20

Not completely sure what warning you'd want, so I'll leave it to you to
add an 'else dev_warn(...)'. :)

> > +	if (vs >=3D NVME_VS(1, 4, 0)) {
> > +		cmbmsc =3D pci_resource_start(pdev, bar);
> > +		cmbmsc |=3D (NVME_CMBMSC_CRE | NVME_CMBMSC_CMSE);
> > +
> > +		/*
> > +		 * Writing the low bits may cause the controller to check the
> > +		 * validity of the 52 bit controller base address in the CMBMSC
> > +		 * register, so write the high bits first.
> > +		 */
> > +		writel(cmbmsc >> 32, dev->bar + NVME_REG_CMBMSC + 4);
> > +		writel(cmbmsc, dev->bar + NVME_REG_CMBMSC);
>=20
> I think we should just use writeq here, with the hilo wrapper for 32-bit
> platforms here.  The reason why NVMe has so avoided the 64-bit access
> is for buggy Apple controllers, but they are unlikely to implement CMB.

Right, I tried writeq, but on QEMU I observed two 4 byte writes in wrong
order anyway.

hi_lo_writeq looks good.

--wUsAb1c1D8a8ijgm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmABMjwACgkQTeGvMW1P
DemQ0Af9GVL2DKaPmgSleZJH4p5LL2yNq+81QhPqPupD80DEBF4DEVywDM1NPTNU
3O0V0rYxzSrAgorlGh8UJnHKTGQUbCXcoWR6daBF+n4PSwrx4nUr4WqVEN1Cv8gL
9KXBM5bloVDuywliKW/Rj7JA5dtM5tcJCuXqw5/YFbPn9eq8L5FVmpDO+94XTubG
CCcCbulVFdWj7us4wj4VPQpU5bdhJKi7r9UKtoRQaRPdUXtX3ZxhB4YsXEjG2jQb
ykpD/3p4DrbAk1i69uerkBL0kwmeYKEUcVBw+nRvF/WwDGczA5VSWqBT1CErSmKL
BJRYB0cgS9A5V78/wj5Zybmju07CMQ==
=uxb+
-----END PGP SIGNATURE-----

--wUsAb1c1D8a8ijgm--


--===============8000926051700885360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============8000926051700885360==--

