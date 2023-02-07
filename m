Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D34C636CD
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Feb 2023 10:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C0n2iVjnFfeiUBJ7pYFhtvW1AIbF/PnnV7eWWMaRrUQ=; b=iFW+fvEO+3cFeTXGoq1NbSth8D
	o9Jh5FkmPR7CACYvyfsEsfRKHLRT34vr0aep4xW9DEFjfH2sbphEQZ3Uwz9eU0F4jyh4LwdpAsynn
	P6SmQLnNrxpXYFNG1rArr8gdxHTs9R129D3k4rdGqNQMASC7w7qeCpLN9RhJzMaCDAqx29VX+VW6Q
	Hrp0HbWG6A33PVrtKaZHmkfEunq8KcqScwlVrQsR8p7bmcj/wuBmIHwTLjD1Cua/GVTrAp3nyQyxS
	IbxTJoth4qBkZI6C2G7zhURlwrxpSFVSqvTSa2in6/PiYV/LGehk3vVIP17PjeMXUfIZP8mxq4E6r
	pyZkeYVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPLLG-00Bk4h-JY; Tue, 07 Feb 2023 10:36:50 +0000
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPLL8-00Bk1L-6r
	for linux-nvme@lists.infradead.org; Tue, 07 Feb 2023 10:36:44 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 6CD7C32002FB;
	Tue,  7 Feb 2023 05:36:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 Feb 2023 05:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1675766197; x=1675852597; bh=C0
	n2iVjnFfeiUBJ7pYFhtvW1AIbF/PnnV7eWWMaRrUQ=; b=K3afYQgv+62bJ2h4gn
	5d5GNCq6tbSZCE9rKa0hMdu056lp6EwRx1kzHFNhUD97tTiYWwAHra7lrpO342Oe
	AbigcJlwnwpohYIVb0NPl153J0OyxPuMWdj3OkqE+inU9nLZJzGD8e8JZsFJloEV
	vl24tAbAjExIf9U5YV0nK70uzoN7NRTzkax9lKv24srgZqxihDGbRix0tBXMuW2E
	4lB2YZ3XJlexjhpsEAdy5YwDVaczSypENQUJ2oW5lAUEGhddhuUoIKFOGooWQtgp
	kr10uI52eyohhWYIK2AR4DGYxgjmkWz4EblxRk+dX6loK2UiYoc0NPTCTx0QieY4
	P6SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1675766197; x=1675852597; bh=C0n2iVjnFfeiUBJ7pYFhtvW1AIbF
	/PnnV7eWWMaRrUQ=; b=hc6nZsghfa27oiZLKOaLj7Lwt8dzwG5TuPUgn2YpaIEv
	/0N12h4ZHiA08C5pycO3SRx99JItTUTelegZbX4NJlZEjJuUuQTFGNOiY+KQkJpu
	So9ZADSp89yyxberrCB06vbtTDIkwEuzVKVCcrO8hxNqffgoc+ayeA0HWpqJ+g6N
	ibMmUjHlLYfb3t9r5xaFnSyWPUILulZejMxfy32qhkFZZASXjhgpUJrsovXWp/2a
	Ay83cx9eBFaCgSrGUQyBKZ3W0C5wMAagAAnezbjGP9PprHEVtq58IiA6WDwhCVDH
	bCq44KjkBFvjYK2g4G/B2h3SnJauko1PbERPcZkP+w==
X-ME-Sender: <xms:syniY912NiCAqZkhVOmwsp50_9Ic8TZu0sa2G50gHkItFEuw8RgA1g>
    <xme:syniY0FGrSfJUcCkQZMNyfcfw3XZowVAgmApU1Rqvp8FhSfM5Aag1gjJ0HYtJoVUm
    TnAP2sMrzryycTIBIo>
X-ME-Received: <xmr:syniY96nMas3smjZjadKq-W57uKXPCLEmwRUYmrLV6WbY1PwkqYHNlHFvRjDdfsNCEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegkedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
    shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
    htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:syniY61ZgQqTdo5NLNx8dWOz6f9SW8PvtlS5vER5JBL-aDiQ9ygK0w>
    <xmx:syniYwFhZJ3GW8yDF4peHpzgKk1VNEHbgn1_ieDYsxi5ChNtvrYD5w>
    <xmx:syniY7_Ptv6X5o1Vvuv-3fWDlbDjrreQ1FTTtc9rJeanryqWxxuK_Q>
    <xmx:tSniY-ZDMmMVzS5VFKDh1TYk_JZsPzQl2EG5NJJafqHECf0y822AWg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Feb 2023 05:36:34 -0500 (EST)
Date: Tue, 7 Feb 2023 11:36:32 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: "Javier.gonz@samsung.com" <Javier.gonz@samsung.com>
Cc: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Lewis, Nathaniel" <Nathaniel.Lewis@sony.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <Y+IpsEd8kMoljOAa@cormorant.local>
References: <BYAPR13MB248665DEEDB9A9B60925655381D79@BYAPR13MB2486.namprd13.prod.outlook.com>
 <Y9xlPgExhiYuVHts@kbusch-mbp.dhcp.thefacebook.com>
 <CGME20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a@eucas1p2.samsung.com>
 <BYAPR13MB2486C2ABA6E7097A86C14D2A81D79@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230206140220.6af2b6k7belue2nh@ArmHalley.local>
 <20230206154218.GA12556@lst.de>
 <Y+EpNeyY/Rc6+Zej@kbusch-mbp>
 <20230206175142.pbs47xamj6gskr7u@ArmHalley.local>
 <BYAPR13MB24863A2B706601D88704181A81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230207082930.i5mz2y5bsabnj2ud@ArmHalley.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nrhTwKF+u1s+50Rs"
Content-Disposition: inline
In-Reply-To: <20230207082930.i5mz2y5bsabnj2ud@ArmHalley.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_023642_758340_87F3C0A4 
X-CRM114-Status: GOOD (  19.93  )
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


--nrhTwKF+u1s+50Rs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb  7 09:29, Javier.gonz@samsung.com wrote:
> On 07.02.2023 01:51, Grochowski, Maciej wrote:
> > I have tried suggested approach, with some modification: pci_device in
> > pci_reset_secondary_bus is actually the bridge not NVMe device itself,
> > thus I checked devices behind that bridge to see if any has D0 bit and
> > base on that logic I run the custom delay.
> >=20
> > Unfortunately even with this approach I see the same issue for both
> > Samsung drives, and based on kernel logs I can see that wait for
> > secondary bus reset get increased.  Thus seems like this quirk don't
> > work for some reason. (I tried also increasing delays to different
> > values but it didn't work).
>=20
> Too bad.
>=20
> I will write you separately to get som dumps from the device. We have
> not seen this before, so we need to understand this a bit better.
>=20
> Regarding the quirk, we are looking into it. Will come with something in
> this thread later. Cc'ing Kanchan and Klaus.
>=20

I dug up a PM1733 and I am not immediately able to reproduce on 6.2-rc7.

With an aer-inject error file,

  AER
  PCI_ID 0000:04:00.0
  UNCOR_STATUS MALF_TLP
  HEADER_LOG 0 1 2 3

I'm getting a Fatal error with type "Inaccessible, (Unregistered Agent
ID)", but it still recovers successfully:

  pcieport 0000:00:01.2: aer_inject: Injecting errors 00000000/00040000 int=
o device 0000:04:00.0
  pcieport 0000:00:01.2: AER: Uncorrected (Fatal) error received: 0000:04:0=
0.0
  nvme 0000:04:00.0: AER: PCIe Bus Error: severity=3DUncorrected (Fatal), t=
ype=3DInaccessible, (Unregistered Agent ID)
  nvme nvme1: frozen state error detected, reset controller
  pcieport 0000:03:00.0: AER: Downstream Port link has been reset (0)
  nvme nvme1: restart after slot reset
  nvme nvme1: Shutdown timeout set to 10 seconds
  nvme nvme1: 32/0/0 default/read/poll queues
  pcieport 0000:03:00.0: AER: device recovery successful

Maciej, can you share firmware revision information and a bit more
details on your reproducer/setup that might allow us to replicate?


Thanks,
Klaus

--nrhTwKF+u1s+50Rs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmPiKa8ACgkQTeGvMW1P
Dekrngf+LaeFxchKUHRjL8lotLeSIDXTA8ydkkP2nqKbw1K8I0ZTIjclbtKvq7En
GO1bwwF3oHetU/Xhn0pDjoJIS1PSSasjBdRfRt3EJfDgs2fq7Hd4tXLtX3O/zSpx
0+HjsnxmypTDXAqtFI0K9orWZ/qjf+d+MFNhsmOa2684j2QLLB4gNqBen8p333V+
P4/JR3J+sTRsSBq2AXkO5FF8J2h6fxHbF5pFXnHs6CIsmUwzQvMBvXbTEgxMHh3m
yK0XRAwCsdmL0bd6x+3OVJT2nbl+0tNc8vQdwsg3DlCmBlIW4e1Qsum1GMW98Ccu
1HZgV0tmBc0Y12h++jLyR9O7cTv9Pg==
=mkVq
-----END PGP SIGNATURE-----

--nrhTwKF+u1s+50Rs--

