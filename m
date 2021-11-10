Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A30C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 08:43:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DB061106
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 08:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 85DB061106
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=owWYeiWFYkGF/b1JsBUI116OWsEG0GBwjuejxm+3SCs=; b=lh1yBtTkYeidxq4D7k6v7V6oBu
	rIVToB62u8lRtpjCnrP2j/vcxvLSwIv/UVpESMJfGpVyEPaNlKo6e1AJubEMsqPvPPJKXe6PIo4DK
	kurlcyC5s/Y/ZMdn+yL7LQTeRCGwzkJCj1qbESLFjF12I0g8EBhVQph7lKE7c+4y+MJmVcQTj8Sq/
	zg1rNCaZO3Z1siIAGQbdqvfyPffvYo7pHx3sOkzCJpxOvQ5X18uuY0dKH3Ny35H7H5LfBsjEY+5X3
	1M//fZBsk1J4micpiiKfgNwVPfAvg4CF9a5mURT5ApOAG3z7+cG/CeDstfG9r4UGx3RNE8YNXUxe8
	nCjv0M+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkjCo-004ru6-V4; Wed, 10 Nov 2021 08:43:43 +0000
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkjCl-004rp5-FE
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 08:43:40 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id DCEE03200C17;
 Wed, 10 Nov 2021 03:43:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Wed, 10 Nov 2021 03:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=owWYeiWFYkGF/b1JsBUI116OWsE
 G0GBwjuejxm+3SCs=; b=nBaULEZIHdgRiY1v4bet9pErzPVyMLWg+1kD4IQ+aTI
 E0XJyEXzAgQ3xfPRw9Qmzur89MVl6LIvJEjd+jmCsnSXh1Zy+7asVwMfNGrnoPXy
 e9So2SVmyAEs/ZvH5jh2swKVAcd6KjHTpdoMrdWyEkKXinPfKSocbd7Zhs7iWjBl
 inhmk66mgT2Nd7WGz7EoKFJ8RAFNJXCUf+8poDG4Po2QqedyVfozz8OYGn12evGq
 Fv5hg0RuhwV6UXFa8JZrqL1pSol9Zu5ZFCkzoQuK2o5jNER4GPUsNH8gA77NPkHU
 42Jtkf8B0p2p5U4xd9elyaTr62UuIyWZiWWwHkIaDnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=owWYei
 WFYkGF/b1JsBUI116OWsEG0GBwjuejxm+3SCs=; b=co3nDw2vqowJfJLV/AbjvF
 cxEaPUUxg0tOZo+7Xt0LIrCr1vZJz0Lzh2dpM0+4NZjbpoo2/p1H6KLc92z2dshO
 ECdRkNZHoNhct+N9vklzpq+zOJWGB7weLHFHGu6+I3Uzt+KLEOjA7al2Q1YwGFDk
 LlbAWF6QveZnM94MW+v+WwJQ7+pfrOrirdKJYl5x0tz8eg4W2PBZyeUxQ9TCOGGt
 uGzzuQB3SNxVIoccaqlV/dVN1uB5cYYA52FOWw8EzpNmOpmKUt3pmSsdgQallEYH
 c53E7ZbZfcJxIg5AXqyBBy/PVD/awbpRWkzSZUEGx1jm2Nkak4PgBDbYppz47BWA
 ==
X-ME-Sender: <xms:M4aLYbIsvA8AVcsYqCFigDMveaepIp6fGvlOf7O18NK-3HEjo63G4A>
 <xme:M4aLYfIPVZs19rL4xkLSvA0-loFju4Q5SjdYvkSeF0NGc7aqtOMsHPnR0PT5HvJ7u
 9idFqcZxaqRgk4HzT4>
X-ME-Received: <xmr:M4aLYTuOAxY615IMdplMJaSFuUrtiGc-NO1nLdkGAwK2HSyNdNxpZK5tl6h3mvlVAf267l3QdKYym4prZGdLGOTeuWQjeBPxInqWMj7myqwchapJmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudeigddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:M4aLYUb9kx5G1NXrqaeSe1qtchhPEemaO36m4qfKObzvNr4G_858Aw>
 <xmx:M4aLYSZ_W2dSKQufw1TzYrzes5ybm1gHrS4Fcg_qKaxPgP8LVYod-Q>
 <xmx:M4aLYYDjH-JNTXA1onBRfS_IjUJ1wiQIafjeVPwdrasJ4UVNojW3bQ>
 <xmx:NIaLYXMiNiPUqp_y3cKQdf8vw6_5GP62XGF6W0-WHYnnH-ZRpt5GRw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 03:43:30 -0500 (EST)
Date: Wed, 10 Nov 2021 09:43:28 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] nvme: fix write zeroes pi
Message-ID: <YYuGMBYaiZD2vybH@apples.localdomain>
References: <20211104181618.864157-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="q89p0TJFKQIxYF7I"
Content-Disposition: inline
In-Reply-To: <20211104181618.864157-1-its@irrelevant.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_004339_565441_6C948A6D 
X-CRM114-Status: GOOD (  19.02  )
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


--q89p0TJFKQIxYF7I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov  4 19:16, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Write Zeroes sets PRACT when block integrity is enabled (as it should),
> but neglects to also set the reftag which is expected by reads. This
> causes protection errors on reads.
>=20
> Fix this by setting the reftag for type 1 and 2 (for type 3, reads will
> not check the reftag).
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  drivers/nvme/host/core.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3825b596ca16..532bad4de025 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -914,10 +914,15 @@ static inline blk_status_t nvme_setup_write_zeroes(=
struct nvme_ns *ns,
>  		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
>  	cmnd->write_zeroes.length =3D
>  		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
> -	if (nvme_ns_has_pi(ns))
> +
> +	switch (ns->pi_type) {
> +	case NVME_NS_DPS_PI_TYPE1:
> +	case NVME_NS_DPS_PI_TYPE2:
>  		cmnd->write_zeroes.control =3D cpu_to_le16(NVME_RW_PRINFO_PRACT);
> -	else
> -		cmnd->write_zeroes.control =3D 0;
> +		cmnd->write_zeroes.reftag =3D cpu_to_le32(t10_pi_ref_tag(req));
> +		break;
> +	}
> +
>  	return BLK_STS_OK;
>  }
> =20

Ugh. I goofed up. This fails to set PRACT for type 3.

--q89p0TJFKQIxYF7I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmGLhiwACgkQTeGvMW1P
Denhuwf/fZjJnnl4d8Bwdf7F/FdyVyc+Qn0aPsT7lrumoajOSh1Q2tKeTmsAPvWg
J9MA70nNUe1lnpqJSUa+7kQJnFnBATMkGr+kDuOPD4Ris2vwOoaF+8msfxUNE/+g
7qaZyTuA3J/a4x2cM4wr4zMJoiOdR51ounHBHqFnL+feURkhlAIOVqCBiXCK0FBI
SkPmbFHjncMWL4oR4AwRPqeHfC0dGda1F5aIGbVYi80asSyfRZs4DqWW3JXYj0bs
o2Q590Hie+4shf+EmVBldnNrBgaTQqYXpSOZvbB39+GU99uo/LlG59KfEYbhp2qT
VwPJU4byb1S2norsRvJenlGGNAd7Dw==
=Zszk
-----END PGP SIGNATURE-----

--q89p0TJFKQIxYF7I--

