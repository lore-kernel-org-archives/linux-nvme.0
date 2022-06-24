Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AFEC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jun 2022 10:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w6j763O80htEwrPzIrepIeE/55xh0mEKYNJCmRN8elA=; b=D013UZBAmz78KHsfdMScjQGJ5u
	0aZVLCbDKJknCCpjeiIuARgZ8i0rlBS4u7laIW3nNFC1AL9HMlUH5owlhApWUToViZT7TaLWgUg5i
	BNEHubg1uZgvBi9krw5I2RDF04FppeolGXyn5+eCI2xDpc7UfSPiFcjLIhTNCjEAaIUP9N7EQZWYW
	DFuXyUmr9wx0lu6/hDGc7YtNr5YS+cE21Uvr/C8soycvbg5M4LZugt5ctbRwGLI79yGdxC2ifz09w
	6kY5YaSDA/1M07/XLpMKuIskrrGnP/r5wpSzXd0bwIDMbQKPGGKB7Ru+SPlOrjRgRcjRk7d6FoeWd
	Ra2DbCVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4gS3-001jD5-BA; Fri, 24 Jun 2022 10:22:11 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4gRv-001j6W-MS
	for linux-nvme@lists.infradead.org; Fri, 24 Jun 2022 10:22:06 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220624102152euoutp02ff9f8470f39e16d6ad9900b902155b94~7h1rkvS-j1885118851euoutp02A;
	Fri, 24 Jun 2022 10:21:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220624102152euoutp02ff9f8470f39e16d6ad9900b902155b94~7h1rkvS-j1885118851euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1656066112;
	bh=w6j763O80htEwrPzIrepIeE/55xh0mEKYNJCmRN8elA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KGz+tXEd2QprCWwkakhyIhnVbBcBnzyDA6VJBD6yhlIbfF/lWxV+Eq83J4pNNh+Q7
	 sa0eR252Q02oYbDm6JOpjluqWGuqRw84VNuXWU5llKWnIH6dP52rNL1arfDWCxHLXq
	 xyXe0S5qmK/WyOlxg0vzmOTnU+EORt8TfKq9kYOM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220624102152eucas1p1c6f32e48afe46f6fc0a6ec4f9ebd94fd~7h1rV-i700825308253eucas1p1h;
	Fri, 24 Jun 2022 10:21:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id FB.4D.09580.04095B26; Fri, 24
	Jun 2022 11:21:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220624102151eucas1p27357e5b3285d1915ed9f7002655987e3~7h1q-mn5g2731127311eucas1p22;
	Fri, 24 Jun 2022 10:21:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220624102151eusmtrp23c1221511730a2f0f8dd9b05ff35f643~7h1q_-gMP0509305093eusmtrp2W;
	Fri, 24 Jun 2022 10:21:51 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-df-62b590405658
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 5B.70.09095.F3095B26; Fri, 24
	Jun 2022 11:21:51 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220624102151eusmtip160027547a4c25d3fe612e1c4da8ef9fe~7h1q0b1li3244832448eusmtip1d;
	Fri, 24 Jun 2022 10:21:51 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 24 Jun 2022 11:21:50 +0100
Date: Fri, 24 Jun 2022 12:21:48 +0200
From: Joel Granados <j.granados@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <joshi.k@samsung.com>,
	<gost.dev@samsung.com>, <k.jensen@samsung.com>
Subject: Re: [PATCH v3 2/2] nvme: enable generic interface (/dev/ngXnY) for
 unknown command sets
Message-ID: <20220624102148.pxty7kurqbxsagtt@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="yaxr5v3dvg6ujolu"
Content-Disposition: inline
In-Reply-To: <YrR/Wc/1Wx959Dnu@kbusch-mbp>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7oOE7YmGXyfwmmxcvVRJotJh64x
	Wsxf9pTdgdlj06pONo/NS+o9dt9sYAtgjuKySUnNySxLLdK3S+DKWLLvFFPBDYmK2yt6mBsY
	14p0MXJySAiYSHzce4Opi5GLQ0hgBaPEywsnoJwvjBLT/01ngXA+M0o8aJrNBNPypucfG0Ri
	OaPEvOMHmOCqvs/5ANWyhVGiddFUFpAWFgFVidZPn8Ha2QR0JM6/ucMMYosIKEvcnT+TtYuR
	g4NZoFri6a8EkLCwQJLEz4Y2dpAwr4C5xNPtISBhXgFBiZMzn4BNZBaokNgw9wtUp7TE8n8c
	IGFOAS2JX6vaWSDuVJL4+qaXFcKulTi15RbYmRICHzgkVl/7wQyRcJE40vsf6jFhiVfHt7BD
	2DIS/3fOh4pnS+ycsguqvkBi1smpbCB7JQSsJfrO5ECEHSVW3nrEBBHmk7jxVhDiSj6JSdum
	M0OEeSU62oQgqtUkdjRtZZzAqDwLyV+zkPw1C+EviLCOxILdn9gwhLUlli18zQxh20qsW/ee
	ZQEj+ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzARHT63/GvOxhXvPqod4iRiYPxEKMK
	UPOjDasvMEqx5OXnpSqJ8L74vzlJiDclsbIqtSg/vqg0J7X4EKM0B4uSOG9y5oZEIYH0xJLU
	7NTUgtQimCwTB6dUA5O5cqHQf0P9X65X7A7fFfc25DnbW2/X6M7FuMPy5qqis20TWuyEfZXU
	xf8f8dv57eE7jakh16odH12Zc/Fa+rtfvQ8Or3DtizcLqfqdrV7jWeSr16ChNM/54+S6U1fM
	f9WsdFgj9mKp1VRjzQnVuqsnHPESPXByncls5mma335UnfrBcKX4dcuCTWc4D52PNspvLwmT
	3V6+T9Ve5sh01jMme6VSjtWYblvFd8+DZ96VV6vPf+YomKt03+LT2vYT//Ii9x/Ta157sjlr
	f+q0exd4v0b8+3y+41+BkY+LoH+BWRffYa6jJ5qd1YwsRO7rcUoFysh23tv9OiAn0mzDLpet
	P4+c2sO0/OV53qING3WUWIozEg21mIuKEwFY76n6vwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7r2E7YmGey8rmOxcvVRJotJh64x
	Wsxf9pTdgdlj06pONo/NS+o9dt9sYAtgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
	No+1MjJV0rezSUnNySxLLdK3S9DLmHFgC2PBNYmKJ6vXMjUwrhbpYuTkkBAwkXjT84+ti5GL
	Q0hgKaPEuUs72CASMhKfrnxkh7CFJf5c64Iq+sgosaj5ByOEs4VR4tCVSUwgVSwCqhKtnz6D
	2WwCOhLn39xhBrFFBJQl7s6fydrFyMHBLFAt8fRXAkhYWCBJ4mdDGztImFfAXOLp9hCQsJDA
	RSaJbVeyQWxeAUGJkzOfsIDYzAJlEh0nn7FDTJGWWP6PAyTMKaAl8WtVOwvEmUoSX9/0skLY
	tRKf/z5jnMAoPAvJpFlIJs1CmAQR1pK48e8lE4awtsSyha+ZIWxbiXXr3rMsYGRfxSiSWlqc
	m55bbKhXnJhbXJqXrpecn7uJERiR24793LyDcd6rj3qHGJk4GA8xqgB1Ptqw+gKjFEtefl6q
	kgjvi/+bk4R4UxIrq1KL8uOLSnNSiw8xmgKDcCKzlGhyPjBV5JXEG5oZmBqamFkamFqaGSuJ
	83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MCWGV1hfPG+47Prx6+vveK/8b6tm+O2SN6Nl02OF
	PS2LL4YYT706ccfva4uYZ19NXrtkchlf8Y40YbYbGuldU1LCeLz2P/nO+1d42iOe8wHXrps5
	/XlieEOe93i5m4ACu7yjr4nE8kcPEtqijL9Otlu+z+qV8qrosyksz9lcts9aPMs/6vCOPVlP
	0mc6am565vHWYoF/q/b09Zc2WlSIJdyvW3O1udjm7rWf+hFXt7w86/r/qvMtsTkqhdV6U5eu
	FGxXCJmny8xyi+3T/ntGS0r8fiV3XfHW+SIlfcZHcOl1x9//PTvsCpalT3G2nNG981KkD4f2
	0+nOtT8/ZLDrzZQ3d53aoHJu1ZyITXdW2s1RYinOSDTUYi4qTgQA8IhTS10DAAA=
X-CMS-MailID: 20220624102151eucas1p27357e5b3285d1915ed9f7002655987e3
X-Msg-Generator: CA
X-RootMTR: 20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7
References: <20220622135556.2185991-1-j.granados@samsung.com>
	<CGME20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7@eucas1p1.samsung.com>
	<20220622135556.2185991-3-j.granados@samsung.com>
	<YrN5dWNZkUnFpjSH@kbusch-mbp.dhcp.thefacebook.com>
	<20220623083918.kvtkpwyy3ob52sp4@joelS1.panther.com>
	<YrR/Wc/1Wx959Dnu@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220624_032204_251632_8F25EAB8 
X-CRM114-Status: GOOD (  27.75  )
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

--yaxr5v3dvg6ujolu
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2022 at 08:57:29AM -0600, Keith Busch wrote:
> On Thu, Jun 23, 2022 at 10:39:18AM +0200, Joel Granados wrote:
> > On Wed, Jun 22, 2022 at 02:20:05PM -0600, Keith Busch wrote:
> > > On Wed, Jun 22, 2022 at 03:55:56PM +0200, Joel Granados wrote:
> > > >  static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsi=
gned nsid)
> > > >  {
> > > >  	struct nvme_ns_ids ids =3D { };
> > > > -	struct nvme_id_ns_cs_indep *id;
> > > > +	struct nvme_id_ns_cs_indep *id_indep;
> > > >  	struct nvme_ns *ns;
> > > > -	bool ready =3D true;
> > > > =20
> > > >  	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
> > > >  		return;
> > > > =20
> > > > +	if (nvme_identify_ns_cs_indep(ctrl, nsid, &id_indep))
> > > > +		return;
> > > > +
> > >=20
> > > There's no check that the command-set-independent namespace identific=
ation is
> > > supported, so an error should be expected for many controllers instea=
d of
> > > abandoning the namespace.
> > good catch. But is the error really necessary?
> > If the controller supports NVM or ZNS then we can continue with the
> > normal (command-set-dependent) namespace identification.
> >=20
> > I see two situations:
> >=20
> > 1. When we are dealing with NVM or ZNS command sets:
> > 1.1 Should bring up a block device regardless of supporting command-set-
> >     independent namespace identification
> > 1.2 Time-to-ready will be used only if command-set-independent is
> >     supported
> >=20
> > 2. When we are dealing with something that is not NVM nor ZNS:
> > 2.1 Should bring up a char device iff the command-set-independent
> >     namespace identification is supported.
> > 2.2 Should abandon the namespace with a dev_warn if the
> >     command-set-independent namespace identification is not supported.
> >=20
> > Am I missing something?
>=20
> I think your description sounds like what we want to happen, but that's n=
ot
> what the code does. When validating NVM or ZNS namespace, but the control=
ler
> doesn't support CNS 8h, the code returns early instead of allocating the
> namespace.

Will update in V4 so it reflects required behavior. Just wanted to make
sure that the error was not necessary.

Thx


--yaxr5v3dvg6ujolu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmK1kDAACgkQupfNUreW
QU/ZZAv/eG9+61MQo6oA5fEDU6S7rSKsZQq/SHug/cOFGvF9d7+dCNaVP/j/RVwm
XYEaiMysweYsq5SaFPIOGs+EHmOvTs1HqOLB91P4b/SKvmL8qLQXAoXn/EBXVgc8
6KxfxlDze+9XwKIfnFdKVh+AWVvj/afqyn+vtACw46sAbJ0778TALC1n9mtSG0Ru
0pw9NYVhSkJFQ537+S1qWQImiIUG1t4mZ9dGXmYrisDD4kihN6ZAWKBz6brq4XGo
Ry2HZF2WLXQi76OZEDuDJsRQAjQconSLiLgEWkivk50gKrJneG8JV+2l6XsV1IWU
KCx8ikicZXUY6py5/NThSN8iupYwPBOJMHzIBp9w6B7kUT6U9HUAeu5NiyJMsiq5
Bi5+yK9Ofq1UofG8fgR7AJZRtFO5k2pg/2TWdaQDccMXR+f4W6eQ9eDf9Z4tHsjQ
3xZXb6hSKZf1YdiVQLPIRGs+C/giJOSD5zH1rp1UlopuxOmaBi/o6G+H8aiPApj9
NWK8JnfB
=ICoE
-----END PGP SIGNATURE-----

--yaxr5v3dvg6ujolu--

