Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4048C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 06:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GIrxgKvRuUXhd/1jIs+2nraBGjnk/ck55fNInSTFyxk=; b=AWKdHUMC7fBbVkiQ0rey8ks5+j
	44yolSPZEgQiLmLfB3oOIfXa3sbrrcm9AVGTmUG8Fc8bmJgpaSfiioiKx6iYwYChKYi3vLTzVJW9J
	hi0sbacRe517jeS3pKf1oEZTYzqZysNSAXC3/SlhrcYjqhih02eVEFMCQ+rGsO1vvJ5OlUBe3rFf+
	/A30x1mWax+J98aeOr/6RmPZ3Vf+TakmqMsq9MXAdQZ3ye0omf2JJFPqGtL/DZ47npt3ZfdMEFaZm
	8y3TIhgt5v9rLLX9p/BxPmgTyzRapNYAFtThLBjSEuvKKlDcWknPlqIBUPtRPgBYYwwtduhKfWk7Q
	is+Q/Xfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndn7o-006rUU-47; Mon, 11 Apr 2022 06:02:08 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndn7k-006rTE-D2
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 06:02:06 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 3420C5C0159;
 Mon, 11 Apr 2022 02:01:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Mon, 11 Apr 2022 02:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1649656916; x=1649743316; bh=GI
 rxgKvRuUXhd/1jIs+2nraBGjnk/ck55fNInSTFyxk=; b=bg7EjUJ5/JK9YfYXae
 ZssBmJkmIe622mnhbop0oa8x65TJmKTGpWJszA0Q9HHmt68AO4vlFwHtJvK7kA8N
 DemlNoeojl3cEl0G+9WmzaxzDOsNNdHzkdNEG/CrCmW3Dkb+QDiaI9nsp8rp2fSq
 xFYpQ4RNhdBWi9YmLg3J9vp2LrnA+i5E5v2ZE+6i1Ye07Bvgv+0m4LlT3SUu/Xbw
 fFmAmLFKnca9QxC4yO1WJTmG+Dl+UP7qGxTmjk2FiGcqVgSJv1hkiF2IhfwlnR5G
 NguHQBW0ZuhwN4EWlZYmoOXAhFfRqfsU2+meoABxVBrqAsv6dcpgHjV/CFFPXDnp
 ogyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1649656916; x=
 1649743316; bh=GIrxgKvRuUXhd/1jIs+2nraBGjnk/ck55fNInSTFyxk=; b=m
 e1dNUJUmhjSKH/oviU6YvNB8xCvyF4alyez8bHHVqJCg3yAumlT4tAGvYe9rFbS+
 PfSz75S8zkRFwurBDhEYjUy32Ikv2crhWfwmKXN0OKsYhfunM6lmpMd4ROxBjPLU
 psnY1x0nlRdr2O0O8IV+NJTXo9Fais7C9HsvBRFhyHluxsHvf6EFvjScQS1vEWdx
 WfNp+JzyGORNLsjgIZjHYSpAu0UMcsMUO2j80EcDlmLVH2pgaP3gqkfDPBTLPlfz
 QDETugFZWPW3ea0OTekQBAqcC1QFGhAA7JEaTDrT2fa8YRJv3W+BXxB74HqMFafj
 Ba6Re+JbyLre/dBL5Ar9g==
X-ME-Sender: <xms:U8RTYiGv2d5ZqziLLrzfZOyXMhUWMAEnxAuao9_uwYw0eD_YYbkfIg>
 <xme:U8RTYjVTac6ZiTZyLB1xv5BfjYdekSq_MKZXS2nOdN17KUroAtL8l7V2gYtTJRohI
 DEgCgW6gCIXiOswuc4>
X-ME-Received: <xmr:U8RTYsJj1iW5GHXBucmjXUHrHaSfKrOqhtycjdAlUtZsuacVggqWQ6sz30_sCUgvJ7DRd6TbtI3dS642dJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekhedgleejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:U8RTYsExpDEagCjSLCreyMKoouSCx5S-VlH_KQESRenvJ3u6hWpRPw>
 <xmx:U8RTYoVZzB9dJJbnxGLeygsvoaLf_cZm9h8YPLCV5JS7AF358U23QA>
 <xmx:U8RTYvM38n8LYwFj7bHoPlNA-72oKoa2yWXr_QHvjDmgSihPBsvMCQ>
 <xmx:VMRTYmwniYn9CcXhKjyXnD8yHuIC_Dps8H3QaxljZQzLoqX2xM9jdw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 02:01:53 -0400 (EDT)
Date: Mon, 11 Apr 2022 08:01:51 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <YlPET+kw4EVWfPRy@apples>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-5-hch@lst.de> <Yk+KO8hEYpnKdGu3@garbanzo>
 <20220408052907.GA31990@lst.de>
 <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de>
 <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de> <20220411055455.GA14480@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ruJCBWC8djdmxA5a"
Content-Disposition: inline
In-Reply-To: <20220411055455.GA14480@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220410_230205_374683_EA791844 
X-CRM114-Status: GOOD (  30.47  )
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


--ruJCBWC8djdmxA5a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 11 07:54, Christoph Hellwig wrote:
> On Mon, Apr 11, 2022 at 07:05:33AM +0200, Christoph Hellwig wrote:
> > > However, what I'm seeing seems to show that the uuid is same uuid as
> > > well when not using -device nvme-ns but just -device nvme (this is
> > > called legacy now it seems?) without the uuid set you end up in the
> > > situation I described. I just destroyed my guests and started from
> > > scratch a set up using qemu-system-x86_64 v6.2.0 on debian-testing,
> > > and end up in a different situation but it is still a bit perplexing.
> >=20
> > With my usual qemu test setup (built from a git a few weeks ago), no
> > uuid shows up unless explicitly set.
>=20
> Digging a bit deeper this was "fixed" by:
>=20
> 5f4884c4412318a1adc105dea9cc28f7625ce730
> Author: Klaus Jensen <k.jensen@samsung.com>
> Date:   Mon Aug 9 12:34:40 2021 +0200
>=20
>     hw/nvme: fix missing variable initializers
>=20
>     Coverity found that 'uuid', 'csi' and 'eui64' are uninitialized.
>     While we set most of the fields, we do not explicitly set the rsvd2
>     field in the NvmeIdNsDescr header.
> 		        =20
>     Fix this by explicitly zero-initializing the variables.
>=20
> Note that even with the fix the uuid field is always reported, even
> when it shouldn't - it just is that Linux handles a 0 UUID gracefully.
>=20

Right.

> I can also not find any code that would assign a different uuid
> when using a different command line syntax, but given how unusable
> the new syntax is I've not actually been able to try it.
>=20

Are you referring to -device nvme-ns "syntax"? Using -device nvme, you
cannot set uuid.

> So I think for now we'll just need to disable identifier on qemu.
>=20
> It would be great if qemu could switch to a new PCI ID after this is
> fixed as that simplifies the quirking.

Luckily we can do that easier now since we moved away from the Intel id
(which got rid of a bunch of quirks at that time).

I'll see what we can come up with to fix this properly in QEMU.

Thanks for looking into it.

--ruJCBWC8djdmxA5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmJTxDwACgkQTeGvMW1P
DenycAf+Ism4Dzo3ugF7/gT72qbVnz3JcS0158y442GqzYO1vYpdnSVhOaobFDp+
9Hiod4OPzO9Y9TPX/ca97WqqTSiDF2XE0cs9z2v+07YpeCgxZ69ZITTO/sAd+ZZ4
Agd3UrqETONMCdwgJ/7Kq6DluATJDWci3vWEMUv/zynxmHm0LQhghbfzA0qR1FfJ
sCnmNGzVV5ZZYCCNr7uEXrKq0+iFhmSymhfvL2Pll1uCzSjqoMhOhcdmsnqQrIT9
DIGlH9S8barK/+DfbBheNg2yTnsjANLqSu/ddGC0vJGsdkNnbQVzwRZu1GX2MToU
sifD8zZ+AT0vvUxvECzhkjNnSw/ZMw==
=pmZK
-----END PGP SIGNATURE-----

--ruJCBWC8djdmxA5a--

