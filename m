Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4CBC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jul 2022 12:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uDWJh8HUfSd0mvecpzOO52GTfOl5T3eTYujL6aNPMKw=; b=mBi61I5GwcAboLMaAKPmY1Tu1N
	qaH3roa/GTnvm1VGk2OXJ5TVPcg9Ftjc4oA5qvDBDe2w6VKqLM2awXMkL4ioCA1N/KQw0lSR3u3dZ
	YR2weTiKi4VAbmEW48LRqWCNV0GkYXwbJx1dax+x3vKOnXzi/j3+ItSpnUbbdPbJCB9u4Ms/sZqED
	aNB0NQ6bBn3fiJiUD7qaf16PBPCAwjHMNnoxCZL0jiPttavtY+oAgfp3QPZb/bdDbJ7j8YFXr4Asw
	9J1vjmd+DXlnfFEturwWwqp/bUmLZ7P7djT4abASvaoP6Lx/dYtCfBgZeXVQ6Ba7N/NRNF6TN+Lff
	MMtIyV9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE8ce-0056Q0-99; Wed, 20 Jul 2022 12:16:12 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE8cb-0056N0-2D
	for linux-nvme@lists.infradead.org; Wed, 20 Jul 2022 12:16:11 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220720121557euoutp022964e8c19a5032704085af2a0c2268f4~DiKtfg6yM1760217602euoutp02u;
	Wed, 20 Jul 2022 12:15:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220720121557euoutp022964e8c19a5032704085af2a0c2268f4~DiKtfg6yM1760217602euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1658319357;
	bh=uDWJh8HUfSd0mvecpzOO52GTfOl5T3eTYujL6aNPMKw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gf4d6aZDva9Xk4Z2LCvO17XA56hQ/s685uQhnQLAoBrkI0CYg7lTmpWnzqbHKaZML
	 Q34txycf7fhN6SWo/ilo28p+dbx8mB36YmwI8HQq4Ql2kPLFmBEGB0BmyWi0WoeLLA
	 0Q4ejIvvAjzah1S2aCBer6Zq1mK062mFWzMTUYcQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220720121557eucas1p172627db16a75597f2572d90f4175a136~DiKtJh2XU1810118101eucas1p16;
	Wed, 20 Jul 2022 12:15:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 91.F8.09580.CF1F7D26; Wed, 20
	Jul 2022 13:15:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220720121556eucas1p29df0c6eb85f861022a1a48ff93c52003~DiKskbiLV2501125011eucas1p2M;
	Wed, 20 Jul 2022 12:15:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220720121556eusmtrp2746e92a39719867dc1697a8239da558d~DiKsjyKAQ0203702037eusmtrp2O;
	Wed, 20 Jul 2022 12:15:56 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-30-62d7f1fc5d5f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E5.C1.09038.CF1F7D26; Wed, 20
	Jul 2022 13:15:56 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220720121556eusmtip26a1b84eb76be10174fe06c32303cf0c3~DiKsZl8N11946519465eusmtip2c;
	Wed, 20 Jul 2022 12:15:56 +0000 (GMT)
Received: from localhost (106.210.248.172) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 20 Jul 2022 13:15:51 +0100
Date: Wed, 20 Jul 2022 14:15:44 +0200
From: Joel Granados <j.granados@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: <kbusch@kernel.org>, <sagi@grimberg.me>, <joshi.k@samsung.com>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<k.jensen@samsung.com>, Javier =?utf-8?B?R29uesOhbGV6?=
	<javier.gonz@samsung.com>
Subject: Re: [PATCH 3/5] nvme: refactor namespace probing
Message-ID: <20220720121544.eg7lku5hxgant4ln@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="nier5w5s34vb5ulq"
Content-Disposition: inline
In-Reply-To: <20220720090234.GB18210@lst.de>
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djPc7p/P15PMvjAYbFy9VEmi0mHrjFa
	zF/2lN1i3ev3LA4sHufvbWTx2LSqk81j85J6j903G9gCWKK4bFJSczLLUov07RK4Mr686Gct
	aOSrWLPtDFMDYwtPFyMnh4SAicSL++fZuxi5OIQEVjBKnJ09mwXC+cIoce7zNyYI5zOjxIX1
	q1lhWnrWLmKESCwHqtr1mBWu6t/Rp0wgVUICWxklJk3gB7FZBFQlbnX2sIDYbAI6Euff3GEG
	sUUElCSevjrLCGIzC1xllDi4SgjEFhawlGj49w2shlfAXGLyrDNQtqDEyZlPWCDqKyRmT/zL
	1sXIAWRLSyz/xwES5gQa//nEPTaIQ5Ul5rzewQxh10qsPXYG7E8JgR8cEge7HkAVuUhsf3UN
	6jNhiVfHt7BD2DIS/3fOZ4KwsyV2TtkFNahAYtbJqWB7JQSsJfrO5ECEHSWWN3czQoT5JG68
	FYS4kk9i0rbpzBBhXomONiGIajWJHU1bGScwKs9C8tcsJH/NQvgLIqwjsWD3J0xhbYllC18z
	Q9i2EuvWvWdZwMi+ilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzA5nf53/OsOxhWvPuod
	YmTiYDzEqALU/GjD6guMUix5+XmpSiK8TwuvJwnxpiRWVqUW5ccXleakFh9ilOZgURLnTc7c
	kCgkkJ5YkpqdmlqQWgSTZeLglGpg8pmyPezc0/gtnhOEOt/EJTqeSC7XDdA89mVq+rT/y4vj
	4tRfKq+fbrDvtvQuraXz7PcZljSKfA94fuflIqPajVzzXz7lc3zx+u/BH1MOmvsd/dmpFKSx
	SsT7+A+Z4O8RnzYeeZBY/OKkpnFR+9k77PWVJr63vuzl1uT4IlB98xWv0azHIpyfox7NtD26
	9/bePeLOMQl2NdvYuSdwNS4QO9uZ0M+smhVhOO37t/7pLEuOv0tqsJyQ7j0zwiwuW3j1vhm3
	XK4tcMvL2bkjv/mphWtR6FkFI/Psm0HXVt3/d1kw9bzWzoCk9GX2bu2lJ8I1j+e2ik3dsynl
	+I2nL90+9N1eITllpXieozTDVNtbNUosxRmJhlrMRcWJAP/5O+fJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7p/Pl5PMrhyWcRi5eqjTBaTDl1j
	tJi/7Cm7xbrX71kcWDzO39vI4rFpVSebx+Yl9R67bzawBbBE6dkU5ZeWpCpk5BeX2CpFG1oY
	6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXcv/WJveA/b8XJhWENjE08XYycHBIC
	JhI9axcxdjFycQgJLGWUmLZ8DiNEQkbi05WP7BC2sMSfa11sEEUfGSU+f5vJCuFsZZSYcOQ8
	WAeLgKrErc4eFhCbTUBH4vybO8wgtoiAksTTV2fBapgFrjJKHFwlBGILC1hKNPz7BlbDK2Au
	MXnWGWaIob8ZJT5tn8cKkRCUODnzCQtEc5nElUs3gIo4gGxpieX/OEDCnEC7Pp+4xwZxqbLE
	nNc7mCHsWolX93czTmAUnoVk0iwkk2YhTIIIa0nc+PeSCUNYW2LZwtfMELatxLp171kWMLKv
	YhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzUbcd+btnBuPLVR71DjEwcjIcYVYA6H21YfYFR
	iiUvPy9VSYT3aeH1JCHelMTKqtSi/Pii0pzU4kOMpsBQnMgsJZqcD0wheSXxhmYGpoYmZpYG
	ppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTIWm3GE7Lzjt7j6otGLO4dKTQuW2JhK/
	d+1xytyVettiijrzrn1Z0kX3Nwt+XrOpU/2h+mGmnnX/j4QZMa3Jzk0qene9f1Hsy4tKi+52
	fFvwv0uv5gbX9jlNslUGya/2395S9o+h/+lcZZVzZ6SFGS+kNfAvlPju4pby3rJlt5XY+n0n
	D+Y1sjfOuyn0S32m8HIfLe0dbmL269xO1KeWfJp28exGpud6/2bUmn/7YVoQmWQk7nPqB2dK
	jfmiVZueZ4W++3fU8EDsPb3+B18m8O19HHf5bJDLhzVOd/1fnpebv2bt8e+6bVrG4Xoykoe8
	dcoLt3tmiTJ4pB2LObKHJZpp80mRXObm3oXZVwu1ziuxFGckGmoxFxUnAgA83/TXaQMAAA==
X-CMS-MailID: 20220720121556eucas1p29df0c6eb85f861022a1a48ff93c52003
X-Msg-Generator: CA
X-RootMTR: 20220718052519eucas1p23ea18838828398065cf55f6c9ccb245a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220718052519eucas1p23ea18838828398065cf55f6c9ccb245a
References: <20220718052503.235270-1-hch@lst.de>
	<CGME20220718052519eucas1p23ea18838828398065cf55f6c9ccb245a@eucas1p2.samsung.com>
	<20220718052503.235270-4-hch@lst.de>
	<20220720081912.uspwuwnsxna2pgos@localhost> <20220720090234.GB18210@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_051610_353569_9E2D7FA2 
X-CRM114-Status: GOOD (  16.06  )
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

--nier5w5s34vb5ulq
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2022 at 11:02:34AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 20, 2022 at 10:19:12AM +0200, Joel Granados wrote:
> > > +struct nvme_ns_info {
> > > +	struct nvme_ns_ids ids;
> > > +	u32 nsid;
> > > +	__le32 anagrpid;
> > > +	bool is_shared;
> > > +	bool is_ready;
> > > +};
> > Nitpick after looking at this for the second time:
> > Should we use tabs instead of spaces to increase readability here?
>=20
> Not sure why that would help.
Was unsure what the convention was, that is why I asked.

>=20
> > > -	unsigned lbaf =3D nvme_lbaf_index(id->flbas);
> > > +	struct nvme_id_ns *id;
> > > +	unsigned lbaf;
> > Checkpatch.pl has a warning here for use of 'unsigned int' instead of
> > just 'unsigned'
>=20
> checkpatch is, as so often, rather misguided here.
Don't kill the messenger ;). Should we just remove the warning?

--nier5w5s34vb5ulq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmLX8eMACgkQupfNUreW
QU/gLgv+NlvSuDz4pqsc7AqUJCFz269hG0wzmqaPC6disbG40LOMad8RZZdsie00
mkXG28gP3iq0w6OzSAaRMr1ygBT0wqKm6d1L1ei/RN3XaS7rF9SBibMniG5rwdsR
KQS8mQgBl2/wOqST//ZQo1/m17B4Z3z2UfCGgEZUIRDHU7p0P7tzWVbCzZk8fLeX
GZ+1C1Jh7Dwt+SfGtG1JbABVkwzoTL6mRtlWpo5V6xOmlq+S4OINc6BYmGndwNwT
R+wXClBlftJDeqmTTMrIinS5swYG8ewGIREoIwHXoONESY8MhZI8VW2yBMsSTh7C
o9DrjZYeqOtZEi7l7hVVxYlCujQy8/qkgntCBs7EGEb+bv4NScN8++xDrj4EOXCA
7toFBvbryJiBqD+2udXpnoqNogasU9yqJgfl2DHaCctRdBDaXpQloct5GmYKWjgT
FmISFjKk8/AQx+PJaBJiBwnvBQny/gSjL0bXodQFQ/3Dg00JhrrGwqBUw5atv/Fh
D5rtQNi5
=M8HP
-----END PGP SIGNATURE-----

--nier5w5s34vb5ulq--

