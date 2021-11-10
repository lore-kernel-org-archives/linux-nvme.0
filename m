Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A89C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 09:17:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F029460EE4
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 09:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F029460EE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sSpGxH+Rw6W+BJgQbKAT0McUO0L1gdUtv1WBx7RCMo8=; b=Z8vCg8tU+2bkhdkss7h3bZfhpX
	zrYLE41nUGcruc7tWOu8wHyoWrxbkQTf4quIML0z0hb0GXK3uV5qTiybKY5/q5IACtObNdtLjqt4r
	Br1DOMRBINBLSVPagHLoQwzJDvZAbBC4QJqZ630FnKfjGHTbJQ0sSG1WrFbOIKl6wxCZWCQF5ayNT
	ZM802t/Uf4sx6cY/qQqtTkWfFpokEfQs8ZwGkp0xldAOFvHdSQFePiNdyjeUCgxDqZk1eavqD4v74
	pxzdStMI3pFbnzydEgP+AnhkQWATjmVptXxuDisr2KS6A4soKVjskvahB6nfHfBgPYO1LSw11kPWh
	R0jMzXkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkjj7-004y22-I6; Wed, 10 Nov 2021 09:17:05 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkjj4-004y0S-Bp
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 09:17:03 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id EDCAC5C01E3;
 Wed, 10 Nov 2021 04:16:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 10 Nov 2021 04:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=sSpGxH+Rw6W+BJgQbKAT0McUO0L
 1gdUtv1WBx7RCMo8=; b=FUZ14TAIIj5Ez9sbcMXVsRltIl9HdhGbzuUgkn4wIJL
 VTKC0rHZe0hX1HIHC7bwaOlwgaGCSJ+sOddA1UL1cEJWJyOT6KGRdzwDrF0LmOT7
 X4MkCa4WPuwaPP690DJyHoJpKA4S8x9JK9ImsG9sFQ2kzAGweDmxiKQGTEfsAIZC
 EZ04QwqBK14PdriZqNccNY/bOd3EZnw9HvXIekdpQtnd5BQF7QBC6MvaY2j/g3HX
 KXuJoRa4j0dOVKvAvOJPmulWgAYc6hXro5qAfVH4DvcQtEDH5+MGH+ODhVPnx+BC
 AJsDJrBnA/7nxh65wnlQXMxE8Cu31Kj4GUpK3uoYOGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sSpGxH
 +Rw6W+BJgQbKAT0McUO0L1gdUtv1WBx7RCMo8=; b=FWehnPjLwaHvY2OtBPRfsM
 vCZHK4SNEY+/kEz49LEMvpCJa7Yz54EeeUPjVeVyA34lVRmwmqpB5rbJ0azF3Yry
 9KXxuUnui86hrG5nuw+gYP9jfT2ZVFCjXh3gkhtM6vMEcG5CgGOXrZTFrxdnnPS3
 mD97cAqwBn65K13s06dNns048Mj3u+dKzbB9KmT3VqQOHtfCEHOZ5hXZYnjHkrRj
 ae4tOSoei2lSpn3OMVPs7Csv4HeFjuuJLcSnC9fMZ1bABeDxXhFqFul912qeiIzO
 n7KcS036SvCsQw2zyXDJEU1k5dR9qdsmcMbFoQEInv5pYrcOmh9X/cqLxAbNfpZg
 ==
X-ME-Sender: <xms:C46LYdq0tuPd5_k5eAjzNqG6R_s8NpsKVDZF2jG4Uv8YmRB_3uvwaw>
 <xme:C46LYfr4NCiL74_S7nv7orZckfE1E33KuxVs105bZzEIgLZH6Afu-p_6-hRtld6hb
 MBNFlIQbuwWiOIlT6E>
X-ME-Received: <xmr:C46LYaP2FgCdAHx1WspHmbroNJmtNtgEXQYN4Pnixl7hZUxcPAg0A0f_V6qMlcK5OFP90ol6UVcQztYLCsgOcdxqJaKZ9sHPZkQ2k0GpCpceIBwG3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgddtudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:C46LYY7hhKidb5Y-HahI3EZc6oJp4SpWYaRxQ98oSvSxmlU_nxBYhQ>
 <xmx:C46LYc5hZXKd_zYtAF0u1qJxpwtzvOVx018PtYnR7cW_c_qis-FbQQ>
 <xmx:C46LYQhV2BkjiYOVlT2kPlHMLbWs33sjitGVHVwdtrwki6Ng8ByTmA>
 <xmx:C46LYba1FiMrBng0Ndyy0NsWgw5UY1Z6puXAUTipTyoEsggumjqbMQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 04:16:57 -0500 (EST)
Date: Wed, 10 Nov 2021 10:16:55 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] nvme: fix write zeroes pi
Message-ID: <YYuOB9VytsFiDox2@apples.localdomain>
References: <20211104181618.864157-1-its@irrelevant.dk>
 <db739cda-2dd7-015a-5ad9-d2d6e44131c6@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ye8ibXikhyU4UpIe"
Content-Disposition: inline
In-Reply-To: <db739cda-2dd7-015a-5ad9-d2d6e44131c6@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_011702_695003_6A6E7B16 
X-CRM114-Status: GOOD (  21.00  )
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


--Ye8ibXikhyU4UpIe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 10 06:10, Chaitanya Kulkarni wrote:
> Klaus,
>=20
> On 11/4/2021 11:16 AM, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > Write Zeroes sets PRACT when block integrity is enabled (as it should),
> > but neglects to also set the reftag which is expected by reads. This
> > causes protection errors on reads.
> >=20
> > Fix this by setting the reftag for type 1 and 2 (for type 3, reads will
> > not check the reftag).
> >=20
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>=20
> Patch looks good to me but did you get a chance to test on
> multiple non-QEMU controllers ?
>=20

Hi Chaitanya,

No, I should of course have mentioned that, my apologies. I hit this on
QEMU, so just tested it with that. I didn't have a pi-capable device on
hand.

Feel free to leave this hanging until it can be tested with real
hardware, I think I can dig something up :) However, the spec is pretty
clear that the reftag must be set when using PRACT. It is, however,
kinda strange that the spec also says that PRCHK must be cleared to
zeroes - in my opinion, the device should check the reftag in type 1 and
2 if requested to do so.

A reason this doesnt bug out on real hardware is probably that the
blocks end up deallocated, which bypasses the pi check. However,
currently, in QEMU, if PRACT is set, QEMU will not deallocate the block
in write zeroes. Honestly, I'm not sure why it doesnt. I dont see any
reason for it to not request the QEMU block layer to deallocate... Yours
truly is the idiot that wrote it so I'll consider fixing that :)

The commit that introduced PRACT for write zeroes (commit aaeb7bb061be5
"nvme: set the PRACT bit when using Write Zeroes with T10 PI") also
mentions that without PRACT reads may have validation errors if the
write zeroes didnt deallocate, and QEMU is one of those devices.

--Ye8ibXikhyU4UpIe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmGLjgYACgkQTeGvMW1P
DemRCAgAhY6rLFxCImjQJF4u0l7EQP2gO0+MNOkHKPjljy54QzBOMaOEErk9ycdp
Bx/km3rIt9hMY7AlrdcTAkO6EivAjdke0muHlDqovvxKTEs3Fp7GGPzvGcaL+n/O
H/fEtjYXv2I0VhhR29bi8h9hQFsU4QFCpvof2lT1Tftym3Xix4NPPOS5bO+JhWJb
2DBoW/0L2Nougm2QKaGhAhmHeGHJGAL486P1Bv9m/XmsVmuV/jcoAQd613+yK/NC
2/PgFXqTeWFDwpR1o8yd9Gq768cW76jz4ptgl4NCc3tvfzlKpHMH00frmSBZef/p
Om0gu1ilaHyAaNj4UwhR9qbQI1Q01A==
=EaqI
-----END PGP SIGNATURE-----

--Ye8ibXikhyU4UpIe--

