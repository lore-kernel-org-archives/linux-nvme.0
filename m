Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA21C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 20:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U9hyAJL/mUoED5NPGuUeJsheMR1nqFrC46tRUXi4q4o=; b=Oy5H88Z67nl540qwyxnikbQlKf
	cJivEDvYa9rKrVuzQlVEJEVi0YmjlHMxp4qz95EpOv4jscKZ+WNaaDtYcdMvh4yGVz7RAr4C+IwbC
	mDlh/p0eqDlRkhxw/NwM1p3NXb5TRucsoE3MtZUBOlC89M4ElC8jhjvPP6jnVENa+fd4U3tWnAUqG
	Lt9oSGfrzv2ONhNzp7SmXruVfcy2klRWLdd96OXNkM3N3AM81NhS/jHqStngQ6iGUv52u2cqxDFaj
	WXjX8suExZGiMUn+O+tAfpkW/bI0/Go35QrARxghn361YoxYBUDJZem6G5iUxPU9ZmWGrBBMcmf+P
	8pyWsoQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nejIZ-002dB5-3I; Wed, 13 Apr 2022 20:09:07 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nejIU-002dAS-Kg
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 20:09:04 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 26ED95C030C;
 Wed, 13 Apr 2022 16:08:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 13 Apr 2022 16:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1649880537; x=1649966937; bh=U9
 hyAJL/mUoED5NPGuUeJsheMR1nqFrC46tRUXi4q4o=; b=apn4tvKTOAIJXiXpaU
 XQc/QCybRd7HP0kdihIYFjDUuX2cvQrlylNI2zgYgkdrfPF8/UWviUmtSycOXiqH
 AsS1kE/3H1evedyNX56GqGfTkxVeAHKijIe3WbEKYedPlTLwKJEzNHQxpdEk0PuB
 JGUhYdTADLje1q0U0luCXuj8k+xO3JuCsfOxHYjAV8ULKBX7ndmdOaMJgvhoO5hl
 a/u7PnRzy+lqYYh8b4Zcf6nU7LoJ76Z9Ihi3aEXqoDhTL715+RrnyY8q7ThpXvdX
 uiH5BIoJiJhoxwIw/WUw7zP1LA24/12u6ZOTpfRLO5VC4LEbs2C7AtjmRu5SNmH2
 VnUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1649880537; x=
 1649966937; bh=U9hyAJL/mUoED5NPGuUeJsheMR1nqFrC46tRUXi4q4o=; b=X
 kZoF9SQ/duzXQ+5LjOKB1TUYQWraX988WA9szesYRZroGBdhUgB5tF30Sms9mka9
 dFOZTwF1dAY0DPTvPpGZ6UjztyM1RoaolByvYHp60ZB1ph+mOEAB+95EKqe44VOJ
 lkdwayo/xJz7Qsnz+5qyiMQwiDaHko17DtCeuTWPcl7Pb7jp4owo3BDyH0QgH01G
 HGQWUBWUj11g4ONRIR9CE2b+DR9Las0tyejJMmOB7II/ikQpYyOtJ/k1SzdIlQoC
 q9w7gMOW9gMweBjLqf1LEptQMRfXK+6abHlCQpVdsqHuAW8xj8eKO6yIk+6kZ/Fp
 YWpkwoT+rqgiZGFDi6DgQ==
X-ME-Sender: <xms:1y1XYrYlu--iJK4f8aK-JiQ15mKl7uuyVsSzuQKmmOiy7dlDIPAdxQ>
 <xme:1y1XYqauThZu9SZV2DITdCCFsTrDxTbmcHxkdn8Mj1vWehO5u6efNoUZGmyQYRxXo
 L0FzFAdumtP3lvoPjk>
X-ME-Received: <xmr:1y1XYt_Y0Ry8yjRwJdJ9jvEW4Dsy3cDfMqGJiDwpmks38HsOgmq2cl1YMBjQEWD3TkHdcH245QoLeqWlYKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeluddguddukecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvddu
 ffeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:2C1XYhodqWIUwok48LdobqVCjEVbouoOipUOuirypwgx-JpANaJBDg>
 <xmx:2C1XYmqEYo54R0U0P425nJ6MlmBa2DYALxWCegUbrLiyP4xLbCcSdA>
 <xmx:2C1XYnQ5iKELqub7M8WRwgWJQdv4-85eYBXtKyEf3jrlBr-St9n4Ng>
 <xmx:2S1XYjAjS1GmyWvKmz0RPSmR-MAzxk0wcNHTOFQdXn9MgJXqPzVT9A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 16:08:54 -0400 (EDT)
Date: Wed, 13 Apr 2022 22:08:53 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Luis Chamberlain <mcgrof@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/3] nvme-pci: disable namespace identifiers for Qemu
 controllers
Message-ID: <Ylct1QXgzpoxpHaq@apples>
References: <20220413044905.376785-1-hch@lst.de>
 <20220413044905.376785-4-hch@lst.de> <YlZ8j70shRKv/tif@x1-carbon>
 <YlaMjz7SoctkLzYo@apples> <20220413153432.GA27146@lst.de>
 <YlbxCdgPaVUykcqx@apples> <20220413155047.GA28740@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OEtF1key1Hv8C/Ys"
Content-Disposition: inline
In-Reply-To: <20220413155047.GA28740@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_130903_534383_1CDC5963 
X-CRM114-Status: GOOD (  18.95  )
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


--OEtF1key1Hv8C/Ys
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 13 17:50, Christoph Hellwig wrote:
> On Wed, Apr 13, 2022 at 05:49:29PM +0200, Klaus Jensen wrote:
> > This means that the 'use-intel-id' compatibility parameter may cause a
> > 5.2 nvme device to present itself with the Intel PCI vendor/device id,
> > either because the user explicitly set it, or because the machine is
> > launched using a pre-5.2 machine type (i.e. `-machine pc-q35-5.1`),
> > which you would normally do if you want launch an existing VM on a new
> > version of QEMU.
>=20
> But if it presents an old machine it also shouldn't support a new
> identify call, right?
>=20

You are absolutely right in the case of live-migration, but hw/nvme is
marked unmigratable, so we do not worry about that.

We probably screwed up with the compatibility parameter here, since it
really only guarantees the id and some headaches for you as driver
maintainer. I'm sorry about that - I'll keep this in mind for the
future.

Regardless, the fact remains that it is possible to have a device with a
buggy uuid namespace descriptor using the Intel identifier, so we should
add the quirk for that as well.

--OEtF1key1Hv8C/Ys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmJXLdIACgkQTeGvMW1P
Dekcmwf8DBf6lek+Hrb1K8lKcw5jfAwBZUkt8oHJMUYGi5P2IJHJMSjfQgfGHDGl
EgbDTFi1Wbj94aluCznjrzve3Mv7KHz1CdU6h9cyLyYM38G4omUUUMf34qciwr73
aDTMlKxueBKUhqBRRhs8oDH+B0U5hn70t1h059/uSOrLNFR1VBtzDl5RF0AjGXUF
ayU001j09/u3B7hYIhkHz6Xfg7xoiafImIuq39/nuz05rpq91i1hNHuDKq+FFstp
o255kDhgBbbgbYU41k1eutSO4czVlx5yc1qh9EGgMT8CYe715LkXYT9cpTJP9yQj
L1sbYFQdRJEAcJwWCftb0qXkrGEp9g==
=4nCr
-----END PGP SIGNATURE-----

--OEtF1key1Hv8C/Ys--

