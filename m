Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EC8C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 11:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FplMSaj45iZU5CKZ4gj7cpx4NSOhVZLopoYGq+rIWcc=; b=i1dm+QWw/+608Y/5YBJhA4Vqug
	5xBd0/o2vjcRN5rWhtzdODCiWm6voRjrvkBBTIkoHdyND+UEJDai83dIXhiWM9JeVoDb/rs2TKx4N
	UqzYV4e7CJer4Q7Mcr4e4l9/T1FROp3Oc0uvm3W3unTSmCCx2jkYltRVC9rSgcWcuTO2P4NaaHhcd
	fOO9xg9rwuFAmo/htaA2tEJ7Ia0g7pyPbpbnQSnX/k+P2DC+I1g3jHbg3WaFlMvVYApsHnmII0z+N
	Enbdx0cP4kY2JLGCj/yFsX9VaXYwBeR/0fd5+C0t7wiBYSJjLq1+EU0baeMFJinXhbqvr7uVOZpxj
	vMJDFDVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofK2Q-005ZMA-HU; Mon, 03 Oct 2022 11:55:10 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofK2M-005ZGo-GU
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 11:55:09 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221003115454euoutp02e8e32d3d6438f8865876dabd20f2087b~ajQv2oGY70561005610euoutp02R;
	Mon,  3 Oct 2022 11:54:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221003115454euoutp02e8e32d3d6438f8865876dabd20f2087b~ajQv2oGY70561005610euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664798094;
	bh=FplMSaj45iZU5CKZ4gj7cpx4NSOhVZLopoYGq+rIWcc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bCnITcTdlhHCcxQ87T3G89G3PTgjxxRLHHu0vqiPO9n3OaDrrzQq1ZAZAec3b6WgE
	 ggZx9tJB3POPBAt6B4xDmCylIJnAQyJ1FgTkac+kMDO77woQFSWwoDY8kbfkDOH46N
	 7gOqofO1RWOC9lSWD0K961sxuhPcjfpm8EBuP57c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221003115454eucas1p1de388610dc4ead6646e88e13086c1b42~ajQvhmP2H1251212512eucas1p1V;
	Mon,  3 Oct 2022 11:54:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C0.BB.07817.E8DCA336; Mon,  3
	Oct 2022 12:54:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221003115453eucas1p1f77d1f816e1e68fd044cd2d4f83fb73d~ajQu8tAGw1252112521eucas1p1U;
	Mon,  3 Oct 2022 11:54:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221003115453eusmtrp168d0fd1e92612721dc47fb0668c1f570~ajQu8Ca2w0882608826eusmtrp1b;
	Mon,  3 Oct 2022 11:54:53 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-ac-633acd8efd49
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id A1.2B.07473.D8DCA336; Mon,  3
	Oct 2022 12:54:53 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221003115453eusmtip1e1d79b2b6d74965f6c51a1fbaf37114a~ajQuuMomm0876008760eusmtip14;
	Mon,  3 Oct 2022 11:54:53 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 3 Oct 2022 12:54:50 +0100
Date: Mon, 3 Oct 2022 13:54:52 +0200
From: Joel Granados <j.granados@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: Kanchan Joshi <joshi.k@samsung.com>, <hch@lst.de>, <axboe@kernel.dk>,
	<sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<javier.gonz@samsung.com>
Subject: Re: [RFC 1/2] nvme: add whitelisting infrastructure
Message-ID: <20221003115452.tkhhqrq66fahcadn@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="xcgt5fucvn6ussdd"
Content-Disposition: inline
In-Reply-To: <YzHQZO/SPOIln/Tu@kbusch-mbp.dhcp.thefacebook.com>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djPc7p9Z62SDZ7+FLFYfbefzWLl6qNM
	FpMOXWO0mL/sKbvFutfvWRxYPc7f28jicflsqcemVZ1sHpuX1HvsvtnAFsAaxWWTkpqTWZZa
	pG+XwJXxck5xwT7Bitm/vrI1MH7h62Lk5JAQMJE496yBqYuRi0NIYAWjxNuWLVDOF0aJBZtu
	sEE4nxkltl59CORwgLVcfRMLEV/OKPF10SpWhKI9p1lB5goJbGaUWNQsCmKzCKhILPr8nR3E
	ZhPQkTj/5g4ziC0ioCxxd/5MsGZmgbmMEusvTwIrEhawkdi0/AEbiM0rYC5xrLmZHcIWlDg5
	8wkLiM0sUCHR/OQlE8hFzALSEsv/cYCEOQXsJeZfucgK8ZuSxNc3vVB2rcTaY2fYQXZJCHRz
	Spyb/YYdIuEice36d6giYYlXx7dAxWUkTk/uYYGwsyV2TtnFDGEXSMw6ORUaEtYSfWdyIMKO
	Eo0/77JChPkkbrwVhLiST2LStunMEGFeiY42IYhqNYkdTVsZJzAqz0Ly1ywkf81C+AsirCOx
	YPcnNgxhbYllC18zQ9i2EuvWvWdZwMi+ilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzBd
	nf53/MsOxuWvPuodYmTiYDzEqALU/GjD6guMUix5+XmpSiK8UxQtk4V4UxIrq1KL8uOLSnNS
	iw8xSnOwKInzss3QShYSSE8sSc1OTS1ILYLJMnFwSjUwKX9QTrv0r8Znb3zT8Z0vkxis7xs0
	OB2//a/4xXTuIxfkDJU8P7isa2HLnBN9oM24PL7B6v6twkC7rnUn3/O8f/VK6OTLj60VWRq+
	N/LkVs46keF0fP1yc/tTW1qNvoapHQzzkHJlOLzVduGq7WbJtTJJV+/eNjm+47xuXekW1g3u
	nY84xOsLe8ofPTfiW9oTsP3/tB1sizxT7ObP/n1gbfguyabm525NQX8ORL28wCizcpPwQyUT
	0958nm3lV1y7hIofOm+/Iqtb9eTvqgPijIuLpZd2fPcNTY1eIsp06UPxuQjJsONaVj4h99d6
	sdg9453zokNzSvyH88UKdevi4w9c4JLOs7zKIXB+qpCkEktxRqKhFnNRcSIAvWUwB9IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsVy+t/xu7q9Z62SDbas1LRYfbefzWLl6qNM
	FpMOXWO0mL/sKbvFutfvWRxYPc7f28jicflsqcemVZ1sHpuX1HvsvtnAFsAapWdTlF9akqqQ
	kV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJexuOkXY8EewYr1a/ax
	NDB+4uti5OCQEDCRuPomtouRk0NIYCmjxJLfMSC2hICMxKcrH9khbGGJP9e62LoYuYBqPjJK
	3H69jBHC2cwo8ff4VEaQKhYBFYlFn7+DdbAJ6Eicf3OHGcQWEVCWuDt/JitIA7PAXEaJ9Zcn
	gRUJC9hIbFr+gA3E5hUwlzjW3MwOMXUek8SLluXMEAlBiZMzn7CA2MwCZRIvzx1mAjmbWUBa
	Yvk/DpAwp4C9xPwrF1khTlWS+PqmF8qulXh1fzfjBEbhWUgmzUIyaRbCJIiwlsSNfy8xhbUl
	li18zQxh20qsW/eeZQEj+ypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzA2N127OfmHYzzXn3U
	O8TIxMF4iFEFqPPRhtUXGKVY8vLzUpVEeKcoWiYL8aYkVlalFuXHF5XmpBYfYjQFBuNEZinR
	5HxgUskriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamCqbp+it2Ai
	5xnX0DjdPOsXq7dtKYsIbrh3xpxdKf9fS5zWIh92O/2/n3zy1HUWLRf5rbzrakfvlP/auvw3
	036n7RWZf+FsgEpi3/27h5q86r9Yiq96cPD4UiPlCS+y7hhxGu2fGWurf3mKqP2Oau/at7cz
	r24pM/BVeNohXyxrWRT1OVB0yedAS63+/aemutj4yZTv59aOUT5Y+/NQpOLX2VV59xl5Wm5v
	Ed1vv+x66ebEAIbHi40+cKckWNW9Y1ql9vzyfAHnkypSO0qqK74XCHL/42tmTr71MU8hbp3Y
	NNctfxKc+M/dKzxc9WI1u0DoszWTngq0SZpqlHZ8OWH4xz5v9uIeuzS7LZq71ZVYijMSDbWY
	i4oTAZsC9CRyAwAA
X-CMS-MailID: 20221003115453eucas1p1f77d1f816e1e68fd044cd2d4f83fb73d
X-Msg-Generator: CA
X-RootMTR: 20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d
References: <20220909163307.30150-1-joshi.k@samsung.com>
	<CGME20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d@epcas5p1.samsung.com>
	<20220909163307.30150-2-joshi.k@samsung.com>
	<20220918161917.mrfruzz4zd44kreu@localhost>
	<YzHQZO/SPOIln/Tu@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_045506_975768_F82EBB63 
X-CRM114-Status: GOOD (  21.63  )
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

--xcgt5fucvn6ussdd
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Kieth

On Mon, Sep 26, 2022 at 10:16:36AM -0600, Keith Busch wrote:
> On Sun, Sep 18, 2022 at 06:19:17PM +0200, Joel Granados wrote:
> > On Fri, Sep 09, 2022 at 10:03:06PM +0530, Kanchan Joshi wrote:
> > > =20
> > > +bool nvme_io_cmd_allowed(u8 opcode, fmode_t mode)
> > > +{
> > > +	/* allow write/read based on what was allowed for open */
> > > +	/* TBD: try to use nvme_is_write() here */
> > > +	if (opcode & 1)
> > I know that this is an RFC, but this would eventually be nvme_cmd_write
> > instead of 1.
> > right?
>=20
> '1' is the data direction bit of the opcdoe, and nvme_cmd_write is just an
> opcode that happens to also be '1'.

Thx for the clarification, but as I read it the nvme_is_write function
actually checks for this direction. In his new patch
(https://lore.kernel.org/linux-nvme/20220927183620.12583-1-joshi.k@samsung.=
com/)
Kanchan actually did what he originally intended which is to use
the nvme_is_write function.

I see that there is a data transfer direction of the command in the
nvme base specification:
00b -> no transfer,
01b -> host to controller,
10b -> controller to host
11b -> bidirectional.
The nvme_is_write() function in the kernel checks the direction.
And there is, of course, a write opcode named nvme_cmd_write.

Best

Joel

--xcgt5fucvn6ussdd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmM6zYUACgkQupfNUreW
QU/urgv6AggDeLczrlikaL0CxyODhRyb9IW5pMdtRzrw3hLjzN5hZ5xQePx3f9v1
UXbXsoYi8NX6O0FYRLzP6Kk3AqCg4alwJu6ABy87lBigw9o+BaNWZTsFZRumvbJG
r6tz8O75cL5AY3cvOpW/uUMqhqhGO7OaOveJMJ5wm1QT6uHL1WWBuwGoZXTUpSkU
amvuTj1E8/NTbn7y3AMfP/dxbcLAgx0WJzt8pvl73ERjyQ+WG6wVPr32duJOCK+a
rx7AKtlqKZg2x0HwhqSrG6Ab8NjtiMoaQtG0bOcNBTgT3GdA623mTRStb6SmYI5u
SnsFqGaCLfoMuLOieboyHnWK3IYbWTw1TkY2bxxwG7qyiAUAOyVLnSrF+LhtFmry
1wC/Y2+o9EQfysVLjjucKUaEX/2kVFQNjH13lBo0E0oNVvomlZicaEfwtskNjMl0
vRPQrci9nbtmjt0+awpRJZvqTwxal2mJwBFOp4w0TH+ljVlooQ73PWS5npaxi+Tp
eRZWPBbe
=OzgJ
-----END PGP SIGNATURE-----

--xcgt5fucvn6ussdd--

