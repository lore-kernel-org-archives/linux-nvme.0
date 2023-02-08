Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099ADC636CC
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 06:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Twx/KJHOr8Yd18bXKKG4hDjHlrnb/9duRr109K1Noxo=; b=gHsLXt6TK2O9vCJkNH9yrV0lQU
	jBH5spdVMHokukDOsJJqMULN7PJewq/7QZSe3RiwvFPT01AIgK0LeV+F08hQKImHKatOF2mv2S2+h
	iIhFvDWsQkRNeXoyN/pCQNsUSzvgMpecTSi7KMloDFBtZakR2ktCZAIRLCiUzxPVLfjClo8s5Dm4H
	DVRJLSWIF+qv8SDB6QdE6qE3sFWPLQEDEMN9vICtBV3a7+m5RSswnl/F7/x0aax7odx6k3T4mvitr
	UIlsUZyoZmnem/9Eq9G3E4CUwDwfNpSbOCRetVTbBQG7htNf97TcJLNux9LQcdNDn6VPE6DzLsT/P
	mVn5bY0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPeAn-00EKSQ-6R; Wed, 08 Feb 2023 06:43:17 +0000
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPeAj-00EKRC-Jg
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 06:43:15 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id B0FC25C0100;
	Wed,  8 Feb 2023 01:43:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 08 Feb 2023 01:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1675838591; x=1675924991; bh=Tw
	x/KJHOr8Yd18bXKKG4hDjHlrnb/9duRr109K1Noxo=; b=MnQlh7jsK0y9thYmHI
	KdC93mygc5V2+PLqSMXeUuZiBC6fFJqH6ptlnPk6Vr7MQjAiTDMrWHDNBsk6Vpqy
	1UMu6UmNl43ctICFuq+bnSBwKkoLAOS/Ca0LmVBiwF/MmMblAypi6ZC/2zug/s8k
	PmowHVhikblf37AaHt3UcyThT7HztkkkfUmXmDT6o8PoG9lKIULTZcdu9yg9bJne
	wQEV7XWlIVbUVeNAhELDEOqMQu96ZpcXPHy0mD1UpVF/PW6tzB7bS5doOqjAKGPJ
	pSn7/KDcNwhWQT2C9hMmWFFMqNJhWV4s3Bszs2hA7ux+NT03RVmcaLL0inAmSnpg
	SpCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1675838591; x=1675924991; bh=Twx/KJHOr8Yd18bXKKG4hDjHlrnb
	/9duRr109K1Noxo=; b=sgdTVz6HA1r8RF2dsNtohmcKHvLToMgfVW9MiQLw2CQ0
	1kfyAsDrl5/5U80e1Sif/wz7NZMhVI63t8Kkpz2lj6KFMPTxosS+16rSdTuCcdNY
	6KUrRJ2ZHORDFAPNNeTltUIAbHvX2XtykoodFSvePEWL0xFB4edFBtbKBdverQki
	8IaH/blhWzw+EcsQBPCr6wEGPBNGKXD6Xh/Zs1JuJmJFOzQB2hp84fhOAi+TTyR4
	n4MgeOP9WeT9/CNn2beEt27pQcqWksCaoUVq3TH1pTUpdW3qNydYhLRMlSPzrMNx
	THy0Q2uIaYRcOA+HKd1hHuOBJuAafTOwgO8993ByRA==
X-ME-Sender: <xms:fkTjY7_BpOLEn8FvJVvTbxt7INE1IwyHOHb_Mv7zeNyfG1YiCfMEEg>
    <xme:fkTjY3s0Qgz45xzyq5oQ4eknoJbjycWR7YK8LVBGOKgbvbz6VLo_dU8YfidY0ySbT
    -OMJ4TrslWBoT6A1TA>
X-ME-Received: <xmr:fkTjY5AyG7YmOWFZT-2NXBVOwS43WI5R8AYcs4Knius2dCsw78wDaTt2MiVorC7NPFWIZKRIJLrfIv3oQQmzU4MyjpCsHrs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegledgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
    shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
    htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:fkTjY3dTpbpZsUyF6moKASsPhWcIAfqlkXYVDOGl7aEzWu0KtDvmtg>
    <xmx:fkTjYwM4WWHZW3J04uDFthXpoPCx0gWrZV-Oy4D2jr3MQMG2ffVV5w>
    <xmx:fkTjY5kn-lgLgSxr0pMNDkDrtjsvQ0pilUKv6klKS4drfAxOKAiy_A>
    <xmx:f0TjYxjfO5RoKU4Gdaa8sO_clII53HykJvBscFyuNjYfp0DhYSi2dQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Feb 2023 01:43:08 -0500 (EST)
Date: Wed, 8 Feb 2023 07:43:07 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
Cc: "Javier.gonz@samsung.com" <Javier.gonz@samsung.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Lewis, Nathaniel" <Nathaniel.Lewis@sony.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <Y+NEe3OWshJeHsNB@cormorant.local>
References: <CGME20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a@eucas1p2.samsung.com>
 <BYAPR13MB2486C2ABA6E7097A86C14D2A81D79@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230206140220.6af2b6k7belue2nh@ArmHalley.local>
 <20230206154218.GA12556@lst.de>
 <Y+EpNeyY/Rc6+Zej@kbusch-mbp>
 <20230206175142.pbs47xamj6gskr7u@ArmHalley.local>
 <BYAPR13MB24863A2B706601D88704181A81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230207082930.i5mz2y5bsabnj2ud@ArmHalley.localdomain>
 <Y+IpsEd8kMoljOAa@cormorant.local>
 <BYAPR13MB248697EB976CDAFEB3FCEC2E81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n+7i8zuS4yRD2Wfw"
Content-Disposition: inline
In-Reply-To: <BYAPR13MB248697EB976CDAFEB3FCEC2E81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_224314_329228_460FF11B 
X-CRM114-Status: UNSURE (   7.86  )
X-CRM114-Notice: Please train this message.
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


--n+7i8zuS4yRD2Wfw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Feb  7 19:05, Grochowski, Maciej wrote:
> Do you have any set of nvme-cli commands that I should issue for these
> drives so you can compare FW revision and other details?

`nvme-cli id-ctrl /dev/nvmeX` should do nicely :)

--n+7i8zuS4yRD2Wfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmPjRHoACgkQTeGvMW1P
DeluiggAh+uyusnmZx8GBqQfYr+M7U/OwclUKRwRAFxeECNlPOqI19U/JUjwHWVe
6ekt0n7eWvlSvIAFlphyAhiXMEge+dkTGRIaLa0sI95TMFAmLmWsn4/HqE6KN+ct
fd9PjsA2ZLLJKxTeUVYD1gMdnlQh0nHgRFdKIhJy4AxoSf+XCpIEHP5pKMBdrdYw
2IdAb85MajGcav04mJmgjb7Cj7oSJhuV7VBrzHNVZaHZ3Ls0itJHXKZUlSCxZ8ga
GMNiL+caKVctCs/scB0oQ7IsMqwy9iJxs2OgcnE70Zx43XXp/lZA6AaWdVFjNV5h
4cc0hiUIlaZugeYwXGDwxFSFIIP6RA==
=8Go9
-----END PGP SIGNATURE-----

--n+7i8zuS4yRD2Wfw--

