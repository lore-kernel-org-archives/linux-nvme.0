Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADEFC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 06:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6OIRukvOuL7zOLvrWWo8a80rJOzZffRcGhFRU5bhMdA=; b=dU740PJ0SCcffayRiZ9tQ9b3wl
	CLX7umtmLasYyHltJAJLOj8oeq5GXsnpbAKHu4U9ZOORIL732uiRkJv+GhfrrSBKL+qYGMSSP9Wyq
	iEPrAU3mgEl9qlPhDzSIm6nhSqOdN4jLMjGXKnwN156nS8LRyurbWm06RSB0JnxrLCdu6RWzgTKq2
	Mem58lJusA3JAx5vk0KMYgwOdUcP0qlqsYx+s0xq9maxHlArygI9TIMBDd7RzFDrEK2f+QrIqhsVR
	dKF8Z14sdPe0bN86I8RRQDU/3ZCWDAOMAwWZupMyVpAmEK/gylphckuDMhl6NHqcm3TLYWKctfSeb
	tE3qK6vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neA64-00Bsle-Sz; Tue, 12 Apr 2022 06:33:52 +0000
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neA61-00Bsig-0f
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 06:33:51 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 07C84320204A;
 Tue, 12 Apr 2022 02:33:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 12 Apr 2022 02:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1649745221; x=1649831621; bh=6O
 IRukvOuL7zOLvrWWo8a80rJOzZffRcGhFRU5bhMdA=; b=BSXq6FobxxoCg5cWAt
 vFDxSaBcvdipDn7WDllHqrg4L4cjL1QA7ot7V7Avb8PrTi0Igajjirjf9VIG8BC6
 GyMG+dLo9zTQisEYagTWFXJSATYRPfe+0vq5p/ZoW+o2Ugfg9YUfA7Q+z/hVEauw
 qT25u2hP1spGLKY+gKS6IOTH973sD0tll9MwoPk15E7QLlrx/oTxaTMke/8BLwZ0
 v7TYBOXng9lF/xWANfVMRAZheVw4ua4nJgX1bL6NHygoYoi3oeS6u/w/TBuI0dyk
 wLOBfYObAKgFeDipsHVhCD7jqsUTzpzemaannbTvb1qpQV0yq5akaA5Efcefsd3s
 Vb7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1649745221; x=
 1649831621; bh=6OIRukvOuL7zOLvrWWo8a80rJOzZffRcGhFRU5bhMdA=; b=c
 cA/sOljmbmCDZQR8VwtwJiO8ic5EK5NmUqOHT72GiQ7AAAvtxSnCFGe31tX7j+WW
 ydMZYdibNN/JdhjY57VUjRRSDWx15BA8A8yJbGWqSfg/0gtyldpsGvT5z3xcaFuT
 pUtYjLARbvlQyRf26OuTACW6sNTkL+6UxmIkNjM1EcguWUawwJaBhHTkDMZBgZlr
 2MzjO931Ay7mwROX6qMtX8AvKOPYtwLlVBGubTNP85Lv4BUDKdi5ZuLtVXmDcGnA
 x9yZQ4OPXJAn+RZyKAKN43dTkFJn706En/d2Q9TlXdzlak4zq2KgaPTVFqPTLiLn
 A8uRuuF5UcUtTRQ6HTV2Q==
X-ME-Sender: <xms:RR1VYvZqtuuLLO8dnspA38ohPm2CdNzsUg9EKx-ydWfAV6tbYHTMiQ>
 <xme:RR1VYuaqgnejJ9a-vzSNtB9nW6j1iis2EB0fi05aVRFEcEoN-Lcs9QP4ZE3YEYH0e
 13B8GgBTHE8hpbNqXc>
X-ME-Received: <xmr:RR1VYh_AlT9P9yF2CkEFAhifbBHVqpOmfJh5_p_D_GPMjP9DEFtk_tejKKLpx03CmC3FBEDPBu4bGkGsxnY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekjedguddtjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvddu
 ffeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:RR1VYloT1uCyPFDw4vrEEj1UpsIBubvCtejHEsnNj3rXLjAYjhpfiQ>
 <xmx:RR1VYqrdxC_drH8wSXYz-AG_FTq7oGdYiqYDTN_RmCqnk_IZfYK_0A>
 <xmx:RR1VYrS5l3tg4yVTcuYQNHvthFP262nSZElW3U2BUeRmN7EqY9CfPA>
 <xmx:RR1VYjlljX4PFP7V8n4Rc7wSx83EZ5U17xZqwcfVbm-5AWeeBe0WWw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 02:33:40 -0400 (EDT)
Date: Tue, 12 Apr 2022 08:33:38 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme-pci: disable namespace identifiers for Qemu
 controllers
Message-ID: <YlUdQjIXwL++K0Uu@apples>
References: <20220412061126.244414-1-hch@lst.de>
 <20220412061126.244414-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y6ol//QIlKGtLmpZ"
Content-Disposition: inline
In-Reply-To: <20220412061126.244414-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_233349_760359_5A602DC3 
X-CRM114-Status: GOOD (  20.02  )
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


--Y6ol//QIlKGtLmpZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 12 08:11, Christoph Hellwig wrote:
> Qemu unconditionally reports a UUID, which depending on the qemu version
> is either all-null (which is incorrect but harmless) or contains a single
> bit set for all controllers.  In addition it can also optionally report
> a eui64 which needs to be manually set.  Disable namespace identifiers
> for Qemu controlles entirely even if in some cases they could be set
> corretly through manual intervention.
>=20
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c386c91483505..b191e7dcf15ca 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3410,6 +3410,8 @@ static const struct pci_device_id nvme_id_table[] =
=3D {
>  	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
>  		.driver_data =3D NVME_QUIRK_IDENTIFY_CNS |
>  				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> +	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
> +		.driver_data =3D NVME_QUIRK_BOGUS_NID, },
>  	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
>  		.driver_data =3D NVME_QUIRK_NO_NS_DESC_LIST, },
>  	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
> --=20
> 2.30.2
>=20

When I fix this in QEMU properly, can we move this quirk to the
core_quirks and match on firmware revision? That way I don't have to
request a new DID.

--Y6ol//QIlKGtLmpZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmJVHUAACgkQTeGvMW1P
DenbcQgAq1krgDepQeiYuMqqHDutBR9PhvX46vZCXb0t/G6b1mf3cKRpRyeItiIf
hhIDOubLJluvn+o0jpIkHkYKJ9gUuR87rInT5oGfhzZSbCKgC1kSEs9uOmD3VKrw
tWe/uoKS/tKjbuAfg+Z/NLGY+OaLQn917fmJvWuQ3BIbf830LWaUrRuoQv9/zV5Z
cYX1wbi0RDQ5Yh3MTN2I7g8sgxIaaRkcrJ0Q2UifDcrN8sMCAHNV2wCgO3JQyN9V
tPsolOax2KM88i/CCyvZuSg3CyOBKSmPXHqV3xvw9aGPM4+dCu64MDtg7K0uW3Bv
i1aP8IK/Fz3QRru1oRSp6PdHVcqHwA==
=Tc8p
-----END PGP SIGNATURE-----

--Y6ol//QIlKGtLmpZ--

