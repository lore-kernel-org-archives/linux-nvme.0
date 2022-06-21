Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BB5C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 06:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mozGsvjV8IlGd/qZcJpuF33IOCmaLUEmwhVVOMCoO0c=; b=evAWk+pP8YgAcc6uA9TN4jjTQY
	yYn4lGkiPNQtqV8MOavd3YmfyboehVMEFLq+VMvYx3gxjZARKue075IWnW8/Kdyc6Sz5Yr9bz2nIf
	w7B02IF19Ws3qiZwJSv6K0qS/bVAd54GAhsAcafcnXOVCQUd/9+q+MvNxwTd4/Sx8UafzGGK3ghKv
	cFxc/U/wHFW2YeLvTd1VLBJL2SRCCnE4OZfcbWhqAN5bp+uFtZcT6+Jzm0LlxqtfALCnWF708xKZD
	G6Gw3wDe/E8eRpjKiPslX0/fSkLIf2alBlfih7/IB3V3OBD6QF0zeZQsC5nfemmpYzMn98XzhSIT6
	cDd2m87A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3Xn0-003uZr-CJ; Tue, 21 Jun 2022 06:55:06 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3Xmx-003uX2-2u
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 06:55:05 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220621065450euoutp02dd2f7184d2acf912b7c07c28f99fa76b~6kFEXkXPl2091520915euoutp02V;
	Tue, 21 Jun 2022 06:54:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220621065450euoutp02dd2f7184d2acf912b7c07c28f99fa76b~6kFEXkXPl2091520915euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655794491;
	bh=mozGsvjV8IlGd/qZcJpuF33IOCmaLUEmwhVVOMCoO0c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KJEsYjCOPVwemPjPLOh1VKc/Dnl/IvGTi/IVRXt9aYFF4MdC/AytXZiZmg4GmtwQU
	 X+/hj+i6WjpQv7oU1i2VK+FJv3oupwjzMrzdd/gLCCG7x/3AmKXrRhjN8THFLEDVzy
	 NzQOP07rOQbZ3N5LzB5TqfsTGnvsnMoACScrweUg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220621065450eucas1p205c445125904d0bb40e1270ba3436f04~6kFEETpxU0128401284eucas1p2-;
	Tue, 21 Jun 2022 06:54:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id B7.CC.09580.A3B61B26; Tue, 21
	Jun 2022 07:54:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220621065450eucas1p2bf4dc8d82edec5e8626bca62fee73101~6kFDyS1AJ0282402824eucas1p2M;
	Tue, 21 Jun 2022 06:54:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220621065450eusmtrp13e5fdc186412e0452bf19a9cb58c1537~6kFDxsjYG2403124031eusmtrp1m;
	Tue, 21 Jun 2022 06:54:50 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-ae-62b16b3a38f8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id CC.42.09095.A3B61B26; Tue, 21
	Jun 2022 07:54:50 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220621065450eusmtip115a955737bcac274c94b5a51ca7d564a~6kFDoHNHF2098520985eusmtip1B;
	Tue, 21 Jun 2022 06:54:50 +0000 (GMT)
Received: from localhost (106.210.248.101) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 21 Jun 2022 07:54:49 +0100
Date: Tue, 21 Jun 2022 08:54:47 +0200
From: Joel Granados <j.granados@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <joshi.k@samsung.com>,
	<gost.dev@samsung.com>
Subject: Re: [PATCH v2] nvme: Fix CRMS masks for TP4084 - Time-to-ready
Message-ID: <20220621065447.alqvdo35vgomcnzb@joelS1.panther.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="jz47ubdz4nbde3zn"
Content-Disposition: inline
In-Reply-To: <YrCTTzUnBAy0F6zE@kbusch-mbp.dhcp.thefacebook.com>
X-Originating-IP: [106.210.248.101]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djP87pW2RuTDI43qVisXH2UyWLSoWuM
	FvOXPWV3YPbYtKqTzWPzknqP3Tcb2AKYo7hsUlJzMstSi/TtErgyZt/dw1bwnr/i0J8+pgbG
	M7xdjJwcEgImEtd2XWXrYuTiEBJYwShxZ/0rVgjnC6PEooYVUJnPjBITDn1jhGl51fqdHSKx
	nFFi96QHjHBVjVffQjlbGSWunN/LBtLCIqAq8eXMdrB2NgEdifNv7jCD2CICyhJ3589kBbGZ
	BZIl/n29wwRiCwu4S3w6f44FxOYVcJD4MecblC0ocXLmExaI+gqJ009fAtkcQLa0xPJ/HCBh
	TgF7iTvTdrFBXKosMevUOWYIu1bi1JZbTCC3SQi84JDYv3UuO0ivhICLxIMOe4gaYYlXx7ew
	Q9gyEqcn97BA2NkSO6fsgppTIDHr5FQ2iFZrib4zORCmo8S5D/kQJp/EjbeCEDfySUzaNp0Z
	Iswr0dEmBDFDTWJH01bGCYzKs5B8NQvJV7MQvoII60gs2P2JDUNYW2LZwtfMELatxLp171kW
	MLKvYhRPLS3OTU8tNs5LLdcrTswtLs1L10vOz93ECExEp/8d/7qDccWrj3qHGJk4GA8xqgA1
	P9qw+gKjFEtefl6qkgivDfeGJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8yZkbEoUE0hNLUrNT
	UwtSi2CyTBycUg1M+Wbn16R/zDhgOScsbfeJKxXp5x6Gv2/wypykk3/ZOX3yLt+1QqmTza1s
	lHcfyL3joH7+j+e6yTlROn/mX7zuPUGQz+HDrZn905t8Snp2zdU2ff30TOG/JV6CwUluxqEP
	LtySEPuWfEDzT5632ZP4X/Gt2jrXricIcLw97cty57LsnIjkWLvctXPPza4MrPmfdDdO5tN6
	Lva5eiuNtUK2+loyH7pwqOBz430tz8J5j7v+Nij31fhYTBILWX/jWrHaQr36uomm6p+tv5e4
	bLh98JqExrnjgXZTu+Tcpk6QuLGVr5nL+gSXocqkbQ6PVU4Xf7/PxnJIjNmuWdt9qp9q7XmF
	dPWfn7PU5dQ/pzcrsRRnJBpqMRcVJwIA82L6er8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7pW2RuTDHru81usXH2UyWLSoWuM
	FvOXPWV3YPbYtKqTzWPzknqP3Tcb2AKYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
	zWOtjEyV9O1sUlJzMstSi/TtEvQyVv1qYy14y19xZfpaxgbGU7xdjJwcEgImEq9av7N3MXJx
	CAksZZQ4svwEM0RCRuLTlY/sELawxJ9rXWwQRR8ZJaZ13mSCcLYySrx58IcJpIpFQFXiy5nt
	jCA2m4COxPk3d8AmiQgoS9ydP5MVxGYWSJb49/UOWL2wgLvEp/PnWEBsXgEHiR9zvoHZQgJH
	GSX+fg+GiAtKnJz5BCjOAdRbJrH/ahWEKS2x/B8HSAWngL3EnWm72CDuVJaYdeoc1P21Ep//
	PmOcwCg8C8mgWQiDZiEMmgV2mpbEjX8vmTCEtSWWLXzNDGHbSqxb955lASP7KkaR1NLi3PTc
	YkO94sTc4tK8dL3k/NxNjMCI3Hbs5+YdjPNefdQ7xMjEwXiIUQWo89GG1RcYpVjy8vNSlUR4
	bbg3JAnxpiRWVqUW5ccXleakFh9iNAUG4URmKdHkfGCqyCuJNzQzMDU0MbM0MLU0M1YS5/Us
	6EgUEkhPLEnNTk0tSC2C6WPi4JRqYJq7/WpiXrRhY5f4LJPFyvpNB7/7L+zUV7+xZG2Fb+Oh
	Zwy3109jte/s9hPbsdnwFt+3WdIZS4VcuTrzKk48iCx+fXphtrmP4QqT65u7nXddd+0W3+cV
	IiFdcFhpK0PaNq+83ORjmnafr53b015xPD3RRv5uXLXtnW9Oc2tes39KubR/8Z6SrasY2Rbu
	ZlY7kJQeuyOg6/AVi9mGUUsPmLxbEsB2yfCD7G2/xBPtT+cz6V8KVxA/dLCjkVfpp3uTtYBI
	tGCtuvTEnR8eP1QK/XY29cPeq3sfGkd1bTof6rC2onOCUuOXlu52jq4fmcHC6Xta7k96cac0
	v2/quwmlp/iZjP42rbZlP29TF53wR4mlOCPRUIu5qDgRACNmPtRdAwAA
X-CMS-MailID: 20220621065450eucas1p2bf4dc8d82edec5e8626bca62fee73101
X-Msg-Generator: CA
X-RootMTR: 20220620121113eucas1p1905756d7a2c84f82b215eaa87544d644
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220620121113eucas1p1905756d7a2c84f82b215eaa87544d644
References: <CGME20220620121113eucas1p1905756d7a2c84f82b215eaa87544d644@eucas1p1.samsung.com>
	<20220620120842.829292-1-j.granados@samsung.com>
	<YrCTTzUnBAy0F6zE@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_235504_392717_57C005A4 
X-CRM114-Status: GOOD (  20.82  )
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

--jz47ubdz4nbde3zn
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2022 at 09:33:35AM -0600, Keith Busch wrote:
> On Mon, Jun 20, 2022 at 02:08:42PM +0200, Joel Granados wrote:
> > Adjust the values of NVME_CAP_CRMS_CRIMS and NVME_CAP_CRMS_CRWMS masks =
as
> > they are different from the ones in TP4084 - Time-to-ready.
> >=20
> > Fixes: 354201c53e61 ("nvme: add support for TP4084 - Time-to-Ready Enha=
ncements").
> >=20
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > ---
> >  include/linux/nvme.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> > index 29ec3e3481ff..bbe8b03e7452 100644
> > --- a/include/linux/nvme.h
> > +++ b/include/linux/nvme.h
> > @@ -233,8 +233,8 @@ enum {
> >  };
> > =20
> >  enum {
> > -	NVME_CAP_CRMS_CRIMS	=3D 1ULL << 59,
> > -	NVME_CAP_CRMS_CRWMS	=3D 1ULL << 60,
> > +	NVME_CAP_CRMS_CRIMS	=3D 1ULL << 60,
> > +	NVME_CAP_CRMS_CRWMS	=3D 1ULL << 59,
> >  };
>=20
> Oops, thanks for the catch. Could you just rearrange them so they appear =
in
> ascending order?

Sure. Let me send a V2

Joel

--jz47ubdz4nbde3zn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmKxazcACgkQupfNUreW
QU94Hgv5AadHEIgixkzlfKiHGQ1ri1Ijugs+taN7YKH7YUmpbwgQdU5sDtY3RkRZ
cnL0Z1mpFJyzf/HGZFOn67u0LAaRjqaqWo7COUMGhCykyFG67jffgKDHqHKGJKHT
pkY+i6mFA3D9U0a7BORMOpYFF4Hw0MdnATAKVfIUMLMJROA+e0//SNEWzNb9OxGB
vZv1I/cSCZWxP4/EHUq8i+wjVWSeYbsIAfWnRmHwEmjzDy0fAzjWaVF9nMEUNoh1
bwiSlgxLA+SOQM6aiN+gYJM8+fHiqDXzLKMzZdPS6WErwwb/JXOOa7PqN42j49Ku
PJ91UY+5GAtY8azuZcOK16/CUH+N1DJ/aFn8ILz8AcEvlkCnerp9FmMK4qtNNBum
MTc0YzGX5xNkVhEiD5U2iNdYhqtBM0RpqXiEURxCcEr43F6xk7viij/eu0r7hAhT
sWO0jHoRqxX14STFG2OlIb1iX5Zy59SnuXVwsmhqXfoClnvUZMpYY3bHm1UphJJL
/+5EH1xo
=orXy
-----END PGP SIGNATURE-----

--jz47ubdz4nbde3zn--

