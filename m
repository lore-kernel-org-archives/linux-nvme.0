Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07971C54E94
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 17:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MBGZYAKsCr0WEkKwmNGqQedgIhl6h5oQgiMCVoOPd8c=; b=Pzkt7JxKYZ3HTkSjM3Nzv63TC4
	C2t4LOGtdpNA60zSPfRg3i+GMutJLKS42H3FAqXXlBqUi8SHfPdLFLnKoVx9Bu5tGE9GKYS2zLT+W
	XcDssIBdZj7r4CTM6IglbpCkbcdxdygQNQEZuGJ3/IAjze/bP2JRYbWZk55X7TWV8j585smupM3et
	ymRk6KyiQsOh29XCTcU1gdH0ltkM3795m34QwLCy0ogVJZcedz/BjT1vtMs3UUDH0DOBRAu3ywTkf
	uAZRqdnf/Q03kxw27MxVR+BV4kJFhVq+OFjLYFU8SvZDuTHJlw6dTj4TkDapLXd4AAt9i1aRlMym2
	ypEck28A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKNP1-004sF3-AJ; Tue, 24 Jan 2023 17:48:11 +0000
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKNOx-004sDh-OE
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 17:48:09 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id C1984320099A;
	Tue, 24 Jan 2023 12:48:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 24 Jan 2023 12:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1674582482; x=1674668882; bh=MB
	GZYAKsCr0WEkKwmNGqQedgIhl6h5oQgiMCVoOPd8c=; b=WeOjK1tjS7oZ0uolTW
	wZVYdvzhqWdczZUn6W2Hmn0zE3TVjhwtFTRXnFcp7lq/c3JWTFLyz7Adz6E+v6kt
	NhKvpVrUSNW5HLUqsPUFJ0ScBVU+xCc0zQsb4j/PUggNGSw/gG49op7lI4+ckWvS
	AgEAo8yPrXjDpKtJrzg1e114FOLGEEgvj1E0s96R+sMdQxrnRr/la+O/A81rTwCd
	5lPukC84VNa8WGlzPtovethWslaxFPhhmGxK6Spw64qMZYuEaeoR6uY27C/sxE3f
	+kkh0OsrcUxlIaq8Duy9Va8BA+ykZv0JCtf4Yj16BiFBxl3ZX2ZLUzgYwIBOJ8v0
	vXmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1674582482; x=1674668882; bh=MBGZYAKsCr0WEkKwmNGqQedgIhl6
	h5oQgiMCVoOPd8c=; b=pcCATgE4mJnjnikbDz0pPkub6rQvW4tHBWmOL0GHJ589
	Z9muaMPGjzuUg06ckUgjLWwWA2VxcooGLgnUfU1pkyqHLe8w/GwY7dJkgUL4GNKJ
	xyeMljeBPoHiKI92fzCg/E0pXMwNiIlRWv5Q0xsNtVXhTuwIKd2JyzqGtU18cbn3
	bDt9TGciud6+lXo87rjfkoINd/e0KDORYbYelCcISGLj7X3L4oCOac7t17H4v5ZM
	qsniWC6+ZVozXFxLhmaUtVftB4fbD0PXJWKPayPKaID4tXHGiAdVyMnxDI0W3UZ0
	fx0vR0Ts77mBrJXsrNa1o/SAqif1BXPKaOEQj7eMOQ==
X-ME-Sender: <xms:0RnQYz4rK2DZICzSe90KokMUL_r1o0scMYCung0x4LdxsPikPMA-Iw>
    <xme:0RnQY445WaStqk7FgTj2f52AxxP1VWQ5GqQ2K4C2KM7dzNVQ8VYkWrVyPv-O1h-II
    YcfkQAGEk_9oa_zi8w>
X-ME-Received: <xmr:0RnQY6dt-01Kk6pv4CZWgU-3af4xNEgX3w66xGbkForJbtSF43mBERM_0JhvTcndiZ9OdAdeNmKmWybPZmLqIdbW_yZ5Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvtddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
    uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
    htthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteff
    ffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:0RnQY0ImaUUBRAg1YRb2Aru6Wh-qBGvZ0BcAaRFMWdQIAp6Z4ggjQA>
    <xmx:0RnQY3JaQMPjsJcYR6EI_0qBGF_Xx--H9NMLeCin2P4Duc8XWiVUGg>
    <xmx:0RnQY9yKp7HYYMNTwRlT2rzU2dII8kkXZl41B9FWtBJcRCZAc-HBOg>
    <xmx:0hnQY9hjPYDKvu_8csV1G1FCIjH5dvIhHIDPy7XFWhm0VqPSI_nobQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jan 2023 12:47:59 -0500 (EST)
Date: Tue, 24 Jan 2023 18:47:57 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] nvme-pci: flush initial scan_work for async probe
Message-ID: <Y9AZzXo5WlCHQwaJ@cormorant.local>
References: <20230124171738.2311160-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jFUcwqxxpdWf249m"
Content-Disposition: inline
In-Reply-To: <20230124171738.2311160-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230124_094808_280472_3D75FB74 
X-CRM114-Status: GOOD (  13.30  )
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


--jFUcwqxxpdWf249m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 24 09:17, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>=20
> The nvme device may have a namespace with the root partition, so make
> sure we've completed scanning before returning from the async probe.
>=20
> Fixes: eac3ef262941 ("nvme-pci: split the initial probe from the rest pat=
h")
> Reported-by: Klaus Jensen <its@irrelevant.dk>
> Tested-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b294b41a149a7..ff97426749976 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3046,6 +3046,7 @@ static int nvme_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
> =20
>  	nvme_start_ctrl(&dev->ctrl);
>  	nvme_put_ctrl(&dev->ctrl);
> +	flush_work(&dev->ctrl.scan_work);
>  	return 0;
> =20
>  out_disable:
> --=20
> 2.30.2
>=20

Thanks Keith,

Tested-by: Klaus Jensen <k.jensen@samsung.com>

--jFUcwqxxpdWf249m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmPQGc0ACgkQTeGvMW1P
DekGEQgAnttGaqxVcE3XTUTEa3bhMb0iqWH3HTQHLKUKNTRoUgQEY9qbnnpjOkw6
9XP4J/5djzAoZWxW54+gEH8kGPN308aHuKiVVgDYZl6JsN9VLpwPWWQyzmL92eyx
3uUXN5XA5Qlw6gq6jgT3SiKccIBpNr3PF/pmswTDP+wgZZoTWFp4K4ClXbVGRCP3
gfMOvIkunnvs436suTki6vp7bP8EK12bKquitzA/gcGhkSvH7/GAmhtg9lmQZpjU
Pv/JewVUo8iAWK4zpPvtqyDIetyg/zXZM9msnYylXXSHgi9XbnQRXYE/rbgWaybu
xp21ug2HkbDPSBvt+IghQqIgF/AAbQ==
=Zq3l
-----END PGP SIGNATURE-----

--jFUcwqxxpdWf249m--

