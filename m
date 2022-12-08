Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A1EC3A5A7
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Dec 2022 09:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5x+FcKciRs79amB49PmcrkEQthivoEnSQz9Eca+KXBI=; b=LTvITFS2dYFwDniac1SCUFZkPy
	8ONpbYqBQjpACNCDSH7vNpeERj3FU/LmtkvS53BVsLmd2ivdy9eFfJK1QAbZ4t4a+CvtMP3SOX497
	jEIy/prQci5tvSdGERy1rCT9DCYYzfEYS34T8/BRC7mt2elivyu+vJri84o/S5XdW6hyV66EwsEG2
	tmmwN6VAzmOBBLm/5xTVyhzCRuD7AEvhP3fFbG9kn3M/pprN73mAyBRV0No6G3NNK1B8ge+e97F8g
	Yns436JFTI5pLq9ROjrg3y8+82MauZfxufTAKVgbsjPFdwLnTaAJQs51A8FzkpEb2vMFcQZf604kw
	9z/H8qdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3DJX-00Aye7-WA; Thu, 08 Dec 2022 09:35:36 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3D2y-00AlBn-0c
	for linux-nvme@lists.infradead.org; Thu, 08 Dec 2022 09:18:30 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221208091817euoutp015fe4308a4a565bd7eb4be5b519ed9736~uxs1euXen2080620806euoutp016;
	Thu,  8 Dec 2022 09:18:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221208091817euoutp015fe4308a4a565bd7eb4be5b519ed9736~uxs1euXen2080620806euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1670491097;
	bh=5x+FcKciRs79amB49PmcrkEQthivoEnSQz9Eca+KXBI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=eMvujRQ+iZf+81Ie9c3E70MUvLXMoUxtNAsF28T6r+4/IGuDSKkugpLXsiJkqJKSW
	 w04w/rMO+DDps+IMlJMQgFKcCP/LnO1PutQH4K40X+1AcK/xyBTT7q6EfFDPX2+bIK
	 PLNZ9JF+SlIsqDIa4oXOD0lfBUx79112RLHjBJTA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221208091816eucas1p2b86dee5f7757f187fe41d33f59d394b7~uxs1UXePV2587825878eucas1p2Z;
	Thu,  8 Dec 2022 09:18:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id C2.01.09549.8DBA1936; Thu,  8
	Dec 2022 09:18:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221208091816eucas1p13593b8b36518b4c8cc5b785980dd527c~uxs05RdmZ0342503425eucas1p1B;
	Thu,  8 Dec 2022 09:18:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221208091816eusmtrp255f1e871fa1cce11d164c67cc0bf5a5d~uxs04oiRR0256702567eusmtrp2C;
	Thu,  8 Dec 2022 09:18:16 +0000 (GMT)
X-AuditID: cbfec7f5-f47ff7000000254d-69-6391abd8be49
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 7D.CF.09026.8DBA1936; Thu,  8
	Dec 2022 09:18:16 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221208091816eusmtip2afed536fe989a4d2be1f67a1db8dc835~uxs0tSXp12971929719eusmtip2a;
	Thu,  8 Dec 2022 09:18:16 +0000 (GMT)
Received: from localhost (106.210.248.100) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 8 Dec 2022 09:18:11 +0000
Date: Thu, 8 Dec 2022 10:18:09 +0100
From: Joel Granados <j.granados@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: <kbusch@kernel.org>, <chaitanyak@nvidia.com>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <javier.gonz@samsung.com>,
	<joshi.k@samsung.com>, <p.raghav@samsung.com>
Subject: Re: [PATCH v6 0/1] nvme : Add ctrl id to allowed passthru commands
Message-ID: <20221208091809.vuzep7zyxj2vo56s@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="olajcm27hgs57z25"
Content-Disposition: inline
In-Reply-To: <20221206081637.GA8675@lst.de>
X-Originating-IP: [106.210.248.100]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djPc7o3Vk9MNrizwNzi/cHHrBYrVx9l
	sph06BqjxfxlT9kt1r1+z+LA6nH+3kYWj02rOtk8Ni+p99h9s4HNo7f5HVsAaxSXTUpqTmZZ
	apG+XQJXxrJLz1gLfnBU/Lw5jamBsZ+ji5GTQ0LARGL7vuuMXYxcHEICKxglnq/9xwySEBL4
	wijx4TUrROIzo0TntaVADgdYx5Z1mhA1yxkl+l67wNU0bv/PBuFsYZTo3XGJCaSKRUBFYltz
	P9hUNgEdifNv7oDZIgJKEk9fnQVbzQzS8K5/HxvIBmEBb4nOx6ogNbwC5hInmu4zQdiCEidn
	PmEBsZkFKiSmz7wIVs4sIC2x/B/YN5wC2hK7js1ig/hMWeLMtplQdq3EqS23mEBWSQh0c0rM
	6/zIDJFwkTj14h47hC0s8er4FihbRuL/zvlMEHa2xM4pu6DqCyRmnZzKBgkIa4m+MzkQYUeJ
	tqcboeHDJ3HjrSDElXwSk7ZNZ4YI80p0tAlBVKtJ7GjayjiBUXkWkr9mIflrFsJfEGEdiQW7
	P2EKa0ssW/iaGcK2lVi37j3LAkb2VYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIHp6vS/
	4193MK549VHvECMTB+MhRhWg5kcbVl9glGLJy89LVRLhXbZsYrIQb0piZVVqUX58UWlOavEh
	RmkOFiVx3hVTOpKFBNITS1KzU1MLUotgskwcnFINTCnRi13vsa28bOnR9vnDQvaA6e0Cff+9
	BdWvyh02OKOd+GzXef+2I/ODDsofMAx+snJLZKeXhdt3P9bV37ctKZhWnNm7otD/Vh/rAoHT
	LU9vJ9zsiDpbfPXigQPPP9ZH6zgKsT08e8L4XMh3vx4rQ4m151w2V0V/+T9JXSKl5EP2wYCk
	p48efzrulKD+9LdnqqvrvZeXvAOdz8+cxCav4Shp3/A0Mnkp19nDPaZ+5QqX1z0876ceF3Qg
	cpO927vG5WEt0zIU/DKOaiWK53b/u8cvtoHBsJzB3qL8kenBv/0JRp9DLkoHvpZn81ATt56p
	P7FB7V+RWN/CDD8h1633Zt+zkd3E80LrcIOX/oQMJZbijERDLeai4kQAP8NU7dIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsVy+t/xe7o3Vk9MNvjTJWXx/uBjVouVq48y
	WUw6dI3RYv6yp+wW616/Z3Fg9Th/byOLx6ZVnWwem5fUe+y+2cDm0dv8ji2ANUrPpii/tCRV
	ISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvo/3CfJaCbxwV67vb
	GRsYezm6GDk4JARMJLas0+xi5OIQEljKKHH27F/WLkZOoLiMxKcrH9khbGGJP9e62CCKPjJK
	zNm6nRHC2cIocefpCzaQKhYBFYltzf3MIDabgI7E+Td3wGwRASWJp6/OgjUwgzS869/HBrJa
	WMBbovOxKkgNr4C5xImm+0wQQzcxSlzceoMVIiEocXLmExYQm1mgTOLPlXlgvcwC0hLL/3GA
	hDkFtCV2HZvFBnGpssSZbTOh7FqJz3+fMU5gFJ6FZNIsJJNmIUyCCGtJ3Pj3kglDWFti2cLX
	zBC2rcS6de9ZFjCyr2IUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM3m3Hfm7Zwbjy1Ue9Q4xM
	HIyHGFWAOh9tWH2BUYolLz8vVUmEd9myiclCvCmJlVWpRfnxRaU5qcWHGE2BoTiRWUo0OR+Y
	VvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpjMmPU/CPQF6dtV
	TVkzyWvJ3/P5U+r/aL1NsdMM3WVwI3KSanjtyTe2Ly4e/qxfrPVxMdsdo4Kz2/n0KmLKA1RS
	I7hiZj1NmBZQJaYjkP+P43em78GqB5JXJiRO2a3/YIZhXOCE8P+5kt5PGarMjAQmf9yyJeX0
	0dRdW7raV3F9fpAqZpU8sX6O56tD91q5NnQJ7Wf50MJa0LhTxuHh95vvV6z7IRAsUmUhkZj+
	yMnn6Z/CbfN3bz2xXzz7WwyHQltOHae16LaiRJ6zSusuna266xZ8/vG6nu33s/IOTG5YOM/j
	9Nmj+W+TRZ4bu/kvyG94qnT/y3VTNoN7Z/6ppDBYHTlv91Nf5h1PPovr1T4lluKMREMt5qLi
	RABBDcircwMAAA==
X-CMS-MailID: 20221208091816eucas1p13593b8b36518b4c8cc5b785980dd527c
X-Msg-Generator: CA
X-RootMTR: 20221206074301eucas1p2e2e5f28171cd08cfe6a8ec7623e5f1e5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221206074301eucas1p2e2e5f28171cd08cfe6a8ec7623e5f1e5
References: <CGME20221206074301eucas1p2e2e5f28171cd08cfe6a8ec7623e5f1e5@eucas1p2.samsung.com>
	<20221206073914.1243191-1-j.granados@samsung.com>
	<20221206081637.GA8675@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221208_011828_689693_5B652ED4 
X-CRM114-Status: GOOD (  12.02  )
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

--olajcm27hgs57z25
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2022 at 09:16:37AM +0100, Christoph Hellwig wrote:
> Thanks,
>=20
> I've applied this to the nvme-6.2 branch with a rewritten commit log to
> explain a bit better why this feature is useful.
Thx.

--olajcm27hgs57z25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmORq9EACgkQupfNUreW
QU+5Twv/WZchmLbumBGP174YyDUTl3JTVAebGdcBficzNBWtVnzaEBP27UmcEYC2
D3hDuOiet3f7SqUi3D9h+QD9tqCSCGp9f0ZWAcRrpveLy+kxINsKCWWNoqkcnWiL
BIIhgfWv2EbxmKFYQe/LGaY7VtPJOTlyW2E7hupaSgEjOUFqd9kpdT16vYqD3Zz2
qGu0a+9jBn4Ml5JUcdXXBqemuq/tslm6tZb/u11pAkwxAu3vJI/IIZrwARVJFWh8
8PStAD4nzsk45VrScYoqgxbrxgFPvJxmeBTGc29IP0651omzWUPrpxVhliNrp3/l
otwQ6NnWWtVhE5tPpo39oDrlNIxSN52dDhKjPam+7cfcO29ESa++76kYLwiHt6nE
W1sDKHSyQo4VR1IGz31YGQVh31WOjRk3PLRA9W4TnnKxVxzS4r+j3SKNPiSe1dCP
JBGTSqnrtw3SyTVFn9vOInm5G50z9UwrEp+/HuH+xfiFFn8tMpWP5QI9clMdUPAW
iMt2o583
=TCy/
-----END PGP SIGNATURE-----

--olajcm27hgs57z25--

