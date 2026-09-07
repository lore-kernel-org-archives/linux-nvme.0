Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B3BC79F99
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2026 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=97+OIOU3FVs5e16jdVP2eQyN+TbIv2ppCbJRSjhQBf8=; b=fB3Wb3GUnT23KkhcnbV7I8R6Tb
	wbQMAV2FNVTRurXrkFL2DruWy8z6lgB8JvdB/lQjYSlYYBlIpBGbon7oqtM1prmmVfrm/sM2Hb015
	RYcmwt4O0dsrcYR2Evx3ZcVi0g82ZhJqEQLqhVrhn8GDjSAx3eqGqTnoeWwReiTA/Cn508FlMWPnf
	o7fOLvkND8kHw6axkOGNguEcVCG0w9XxV1RIRMj4puB5r324PXPkmsbYRxTutgN4ETH565S2Slko9
	GCe+IwInFbbmvaGFLupTYdk/usbSO2NdUPEToQDiSWXUA4ZyUPEgob4puFsOfzag4pAvSqGUk/OYJ
	59XXtL9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3d0y-00000007TJF-3mHb;
	Mon, 07 Sep 2026 17:20:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3d0x-00000007THZ-2tbw;
	Mon, 07 Sep 2026 17:20:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 241A743BB9;
	Mon,  7 Sep 2026 17:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4AE1F00A3A;
	Mon,  7 Sep 2026 17:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788801615;
	bh=97+OIOU3FVs5e16jdVP2eQyN+TbIv2ppCbJRSjhQBf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CUJ5jmuQm/wfO9+umLYxJakXxI1ArGbpBbYEih7cYop9zMveg0RDrcjW5SH9fjJ0J
	 nYwaBBa3xuRg0qO/7Tr637jz+Nio9SlFp3QjoOz+JTfdING80kAcTDN5zHBTIx4dbJ
	 pHqWLwdpYQVEvA1s9lklHO4C+T90Ta9tfkEb4kQcX46oH+tdt1ALCpmWp+mx1xcChY
	 kGFs2MnM2evTSmjxj+ozFWD2zjV6dYkm6r09ZAzu4Gd2LXS/uo7WBsqsQ9AbGGd7Hy
	 lSZmHL9KupVjupnaKyXj/u7pHMe9n9aw+puqV+dk6LJHWfluT1HOAT8gv7NrRcR5Id
	 LzVcJj7GUpFUQ==
Date: Mon, 7 Sep 2026 18:20:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: nvme: Add apple,t8132-nvme-ans2
 compatible
Message-ID: <20260907-provoking-peculiar-835c812fd019@spud>
References: <20260906-apple-nvme-t8132-v2-0-ac0328590823@cyberchaos.dev>
 <20260906-apple-nvme-t8132-v2-1-ac0328590823@cyberchaos.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KWWMlReF3FRZYBOp"
Content-Disposition: inline
In-Reply-To: <20260906-apple-nvme-t8132-v2-1-ac0328590823@cyberchaos.dev>
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

--KWWMlReF3FRZYBOp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--KWWMlReF3FRZYBOp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCap7ySQAKCRB4tDGHoIJi
0tMiAQCxaFqnJ8/puuY16UC+S1C3igPHNaEUPwH63h8vCXlZwwEArbh0khR951c7
OsyS6qOdcmVhldFbjDikXdJH9bbAmQg=
=Kaxe
-----END PGP SIGNATURE-----

--KWWMlReF3FRZYBOp--

