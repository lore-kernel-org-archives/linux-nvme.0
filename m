Return-Path: <SRS0=b72z=GS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6448FC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 06:32:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1D8235DD
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 06:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1D8235DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nQA7mV5PWaVZ4QISXEa7CSq7AXa8KusoGNWTMfvuy1o=; b=JPNS1bhDaTlnmfc3R52QSk6r4
	Bg8+YITp3vvidwbUwZSZe/d3pqi4jNY8/uvbWdi8hvQlXuGbZip9YMK8lWqa7jpbTO3azV7QZ/ota
	pvIcGhuFFALdWTIf8UNYh1O3/9jlR1pS/Wxl2PTcH8+3aWM4XsD4B5uk3dJFWzmmxV9eIVIUdxasy
	aLyQ93bqCMlaKsxEbEWHMTr1EgApwnAF3upTYCcmfpFGZuLECkyo0g72jkI6w0BZ9h7zthr5fdG2c
	8gzQMHyxXeiPcR1tuH2KMegMbOqqTfrWVQ6/1IHghoYA7DHL1XwJy3t43g+JyHXq7xks7TA49SMgZ
	9vfsO7JTg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0Ieo-0006FH-J5; Fri, 15 Jan 2021 06:32:26 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0Iem-0006Em-8J
 for linux-nvme@lists.infradead.org; Fri, 15 Jan 2021 06:32:24 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 8CEBB5C00B6;
 Fri, 15 Jan 2021 01:32:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Fri, 15 Jan 2021 01:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=xpEsxA6y9Y1w5nIkSqkW6j0h0Zy
 NX6ec0RTZZ5uLIaY=; b=CY6qIxybOucn3pm5uIh8KIft3iJrkcD07rGWduyDsxn
 1Lwv/E9Va1lni5Q5dfa7nI5WAxTfijP2beAz9ktUjnPrG7d0WSOg2w81677sW8OC
 By6QbiOXwf9FStEbtWUuGF21Enqx0b4Pa+EEcumRm+FhqkpDZn07FxVhqiunExHA
 neLraoaM8Y4kukvSnF738ssUKo7O9doag7yMbaEco7iWPSXOE53DUSslsSbkbZFU
 jR/RaAfBZy/QS7UuNCrOakv74TlgIA+kOWC4gPg0TKDWozsqWGHhJV9Jv7nX65nq
 fjuX6a9doAMVjG25XWuWPuEX3EZKKq7c59GnQmYAkjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xpEsxA
 6y9Y1w5nIkSqkW6j0h0ZyNX6ec0RTZZ5uLIaY=; b=SKuTbMH4rjZArVPxPK6uk+
 y25jqUzeYOd3OEviSfbwUv5g4BRY16SzkyKBQ/eAWmmREr8Jp/3xrRayGxhL/XIa
 9BTr+oHKAhVAHEaVDRMZCZlhn5vFEGUrC3hmW42gphSjcrzIiqvKWSytfaL0N2zl
 WsHRyS72jKxuZ4y3yonQW7yGW07GsSYRLOqIjNpSQM/+p+pvLZzQniOb+Bi3HAxV
 PVDB3GIrbnuhZ5T/kWAZvKJDO85duFY9ELdS9EOpTI/vE1yIi3Gc0i4S9s7w8ulS
 /K+ipfRQO8RUziMZ/xHmAZWqZzl9aGQdUW7a1VGu5/TNn5e+cw6VcOj8Z+qvh72A
 ==
X-ME-Sender: <xms:9DYBYEijSVYR-S5mIYHvE_hrpIHbyN74ENvUsq1tLM9UuV6zec6SfQ>
 <xme:9DYBYNBRYyT9JOsLU7eUmn9-pIDTYR7iEeHfKWvsWeuXdyyOMLepe8LKbdXSISrb8
 u9iUbA1neU5tXTJjfE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddugdeliecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:9DYBYMEN63wEIKVcGXOW9Myd4A02iVMu-KUgi9ANFWqIqbwTW2CLSA>
 <xmx:9DYBYFStP6_Iu-D5ABdAYkNVoWJ1qzaJkqfOeyKqz4rFKH3AWqucCg>
 <xmx:9DYBYBwJirHy8jGQZVs4IYXxjuFM_gg7II0tokIgZaVgTiyzbMjoSQ>
 <xmx:9TYBYEre-4v2S59bOR4niEbVezqw3bg4PNX5ANWHGodeMoJoBnfY8w>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id C7FCA240057;
 Fri, 15 Jan 2021 01:32:19 -0500 (EST)
Date: Fri, 15 Jan 2021 07:32:18 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: allow use of cmb on v1.4 controllers
Message-ID: <YAE28i5Aq0U40fPB@apples.localdomain>
References: <20210115063046.274495-1-its@irrelevant.dk>
MIME-Version: 1.0
In-Reply-To: <20210115063046.274495-1-its@irrelevant.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210115_013224_338521_AB6173B4 
X-CRM114-Status: UNSURE (   8.91  )
X-CRM114-Notice: Please train this message.
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Klaus Jensen <k.jensen@samsung.com>,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: multipart/mixed; boundary="===============6173170466206441181=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============6173170466206441181==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1U8gbzxJNV82M3VG"
Content-Disposition: inline


--1U8gbzxJNV82M3VG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 15 07:30, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Since NVMe v1.4 the Controller Memory Buffer must be explicitly enabled
> by the host.
>=20

Sorry, messed up and missed adding the changes for v2.

v2:
  - Do not explicitly check the NVMe version, rely on the presence of
    the new register instead. (Christoph)
  - Use hi_lo_writeq. (Christoph, Keith)
  - Fix missing offset and use pci_bus_address(). (Keith)

--1U8gbzxJNV82M3VG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmABNuwACgkQTeGvMW1P
DelOBggAsOWPWqP1jQiNj9M5TyKKmCMZXVgMRiAyHX0NIXPQJYePYleMU572MNvQ
HJai6Z0+YpnRZCG6XAmHSj61pJ/jum64DSBwRmVMAIjYyv6r/4n56XvP4QobIr9J
cTQ+HN89ueW77SzLgDDwsAplW+9l/siY4o5UDJE1RIXnVpy/HSoyV1hWrQD1hFze
41G5/O9MAx8srSpGbO90tmY/eZ4EvrI8S4AY/2D/CX/ElOkodJsf9PM7qHz/I0Ly
lrneSiU34OhvufoFunmWcN0OWQowHqHLr4Jpm/RxAgJG8ucaB0WlUuMzMdx0VFI0
KVmU3V/zt54k0UAwJy2jYcXY7WXkNA==
=zs9f
-----END PGP SIGNATURE-----

--1U8gbzxJNV82M3VG--


--===============6173170466206441181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============6173170466206441181==--

