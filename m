Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2CBC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 07:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eU8Bbuh24OE4zz/EoGGUBLjzC0ZhoCvOtqRsWYTx9os=; b=LH5t3uLq3cdfeGctfYDKWrRxsq
	Hd5BKGH5fW8BSb/2kJ4HTRk8bvoBDU4wg/AfX8Nvmo3t6FPd/rGmng6oszwILGe+uvdHgoPPufkb4
	nUVbCLqBLc0IchqAcKBWCiwmW79NhLk3rF+/QFz9+BOn0CPaF89B9MA2XyC1nYchwLGiiFt0S8tBT
	k1vB3kk7vCRerlp6Wr6Kla0lkTOdKY17WY0E0GsGTQ50kFkDwZc3dU8N/iLBPhYe3zwSbRAylxqZP
	rxVW3Hc3k2QIUtvxzIeCC0y3+dUSyO2+voDCBCpbUBb/5fuFmz4s96yKaDFxk9U+q1P9OspgpVEgU
	2yRUnB9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1NnJ-00D6MC-Tg; Wed, 15 Jun 2022 07:50:29 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1NnH-00D6Ko-7N
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 07:50:29 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220615075019euoutp0240a47b40398acb538ce795a84be1fcef~4u9y44mNF2166021660euoutp02G;
	Wed, 15 Jun 2022 07:50:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220615075019euoutp0240a47b40398acb538ce795a84be1fcef~4u9y44mNF2166021660euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655279419;
	bh=eU8Bbuh24OE4zz/EoGGUBLjzC0ZhoCvOtqRsWYTx9os=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=sCTLGMPlBeetO6Nfqb4IFba0GS2qWNcoM4m/nTsa+uQVdsRpCK6959/RpQ8dC/nMr
	 /SMt9rc4Zx7xCP18yokuw0MDOssk8jfUyHzLAmNmbvsPp+9itifS7emx/Dkut4DZ12
	 KGunnOzlZH08BypLLBTwklgnQyPZ6nT9nA0C5bdo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220615075019eucas1p1c92e986366ae87ee6c3dc68291bc1777~4u9ykHQ2W1075810758eucas1p1I;
	Wed, 15 Jun 2022 07:50:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id A6.8B.09664.B3F89A26; Wed, 15
	Jun 2022 08:50:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220615075018eucas1p2a9d848bc55b77c3baa07f360f827f96c~4u9yJG52v3195731957eucas1p20;
	Wed, 15 Jun 2022 07:50:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220615075018eusmtrp29e5eb65e754fd0c15573a6362f3fa35c~4u9yIg9cO1249312493eusmtrp2y;
	Wed, 15 Jun 2022 07:50:18 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-9f-62a98f3bc360
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 6E.4A.09095.A3F89A26; Wed, 15
	Jun 2022 08:50:18 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220615075018eusmtip2480bb8f724b2b01e5214c142e61e1787~4u9x-nMNu1254112541eusmtip2X;
	Wed, 15 Jun 2022 07:50:18 +0000 (GMT)
Received: from localhost (106.210.248.172) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 15 Jun 2022 08:50:18 +0100
Date: Wed, 15 Jun 2022 09:50:16 +0200
From: Joel Granados <j.granados@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: <kbusch@kernel.org>, <joshi.k@samsung.com>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<k.jensen@samsung.com>
Subject: Re: [PATCH v2 1/2] nvme-multipath: refactor nvme_mpath_add_disk
Message-ID: <20220615075016.d55jktqugigaixe5@joelS1.panther.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="fz2i7dxqiqv4iwjt"
Content-Disposition: inline
In-Reply-To: <20220613181620.GA16299@lst.de>
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djPc7rW/SuTDNZ0i1isXH2UyWLSoWuM
	FvOXPWV3YPbYtKqTzWPzknqP3Tcb2AKYo7hsUlJzMstSi/TtErgy1ux8xFKwk6vi+fmZLA2M
	Czm7GDk4JARMJJafM+pi5OIQEljBKHH2+0XmLkZOIOcLo8S+Q1YQic+MEvuPPGMHSYA0tG6+
	zAaRWM4osefCV0a4qtfnLrJDtG9llNi2lhvEZhFQlbhyZRrYWDYBHYnzb+6A2SICShJPX50F
	a2YWaGGUuHB6HgtIQljAQ+Ji5xawQbwCDhKPJv5hhLAFJU7OfAJWwyxQITF75SQ2kB+YBaQl
	lv/jADE5geb/bo6BOFRZYs7rHcwQdq3E2mNnoB54wiHx7pcQhO0i0dH+jhXCFpZ4dXwLVI2M
	xP+d85kg7GyJnVN2Qc0pkJh1ciobJOSsJfrO5ECEHSVubf/CDBHmk7jxVhDiRj6JSdumQ4V5
	JTraoJaqSexo2so4gVF5FpKvZiH5ahbCVxBhHYkFuz9hCmtLLFv4mhnCtpVYt+49ywJG9lWM
	4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBSej0v+OfdjDOffVR7xAjEwfjIUYVoOZHG1Zf
	YJRiycvPS1US4TULXpkkxJuSWFmVWpQfX1Sak1p8iFGag0VJnDc5c0OikEB6YklqdmpqQWoR
	TJaJg1OqgYlNb6Vsm7VG+UOfvRl7DwX86Q9mjBVyLlB+vDTi8iU3BVn739k/LBy/Jya/j+q5
	ey48mXO+49tM/n3Wuw49Y/bcvPZV/qqo/39CX3hXrFTac+ijVoVDoqeh4DG1CfP0nu7+2HFu
	2dqz6p+2BDpVW9yRnJE257KqSLY9O6vKof+78qdtuxBmmPzsZ8uvJibG2/rCwlYv2wVnLfa4
	KhwWnSNZ3XzF1vXFm53651xWadUv7P+8OuTtXRnDmR/65++9Kx1jeflprqcdt1XpJC+hzvKa
	ZZFvFY2USj71Xmd9ulAsVO6MGMfai4U13wyzndw3HSycyi3JnJP0on6vWtnPc7vfzeEN7RB3
	mvmkc1qirhJLcUaioRZzUXEiAArHRty9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xe7pW/SuTDE5fNrZYufook8WkQ9cY
	LeYve8ruwOyxaVUnm8fmJfUeu282sAUwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
	m8daGZkq6dvZpKTmZJalFunbJehlbJ1lVLCdq2L3raWMDYzzObsYOTkkBEwkWjdfZuti5OIQ
	EljKKDFt8h82iISMxKcrH9khbGGJP9e6wOJCAh8ZJS7MNoBo2Moo8a+/jQUkwSKgKnHlyjRm
	EJtNQEfi/Js7YLaIgJLE01dnGUEamAVagJpPzwNrEBbwkLjYuQVsA6+Ag8SjiX8YIaY+Z5Q4
	MecPK0RCUOLkzCdADRxA3WUS7aezIUxpieX/OEBMTqBdv5tjIO5UlpjzegczhF0r8er+bsYJ
	jMKzkMyZhTBnFsIckApmAS2JG/9eMmEIa0ssW/iaGcK2lVi37j3LAkb2VYwiqaXFuem5xYZ6
	xYm5xaV56XrJ+bmbGIHxuO3Yz807GOe9+qh3iJGJg/EQowpQ56MNqy8wSrHk5eelKonwmgWv
	TBLiTUmsrEotyo8vKs1JLT7EaAoMw4nMUqLJ+cBEkVcSb2hmYGpoYmZpYGppZqwkzutZ0JEo
	JJCeWJKanZpakFoE08fEwSnVwCT6cNtUs7UzfxScjZzueDpFaPe032EhjT2VStlhvaU/gpl3
	WUn1S7ru/bb1tfA2G5fiCVr/3+v5Llivbz/5gufp2QIftnuq+he6cXs2fcv7If1d72es41b/
	hbt1dxXK67lvV8vbav7vPs96nw+KDSc7+aUznc4dPsNTYRrftNNNf+r1yT1hCdEPf9TsfHO8
	9j53sf9iQ++mmHd7Mvp/N1bffHN/9jxBLqsXd/dJ9G5wEs1VTpG4W9P/OjnyqsK1mKuLXzbV
	vfW3+P+sXEni5JTO7Y95uq0jKraVid78PFmHO9K2zb6shCMpOm9uarVV/eRTP983btn96Yjp
	0mmNOm8W2T0pmdFqnXYq3ri6S4mlOCPRUIu5qDgRAGH9FOFcAwAA
X-CMS-MailID: 20220615075018eucas1p2a9d848bc55b77c3baa07f360f827f96c
X-Msg-Generator: CA
X-RootMTR: 20220607134311eucas1p1182fc0038fe6137fc0cef23403343f7b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220607134311eucas1p1182fc0038fe6137fc0cef23403343f7b
References: <20220607134055.1742162-1-j.granados@samsung.com>
	<CGME20220607134311eucas1p1182fc0038fe6137fc0cef23403343f7b@eucas1p1.samsung.com>
	<20220607134055.1742162-2-j.granados@samsung.com>
	<20220613181620.GA16299@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_005027_731580_0D369D83 
X-CRM114-Status: GOOD (  16.39  )
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

--fz2i7dxqiqv4iwjt
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2022 at 08:16:20PM +0200, Christoph Hellwig wrote:
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (c) 2017-2018 Christoph Hellwig.
> >   */
> > =20
> > +#include "linux/types.h"
>=20
> Please always use <> style includes for system headers.  But I don't
> think we even need this include.

I'll just remove this line for the next version. Thx.

Joel

--fz2i7dxqiqv4iwjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmKpjzEACgkQupfNUreW
QU+6cwv/VjLqtTxjMIRMORk5MciRRGnn7u2F3FWBcmABc+cylBZ1X8EcJATLFF9m
4eWN1QkMFpSsyWmlTA4DezCOW+5JNwXLWtJZUJkRZXTQMIk3IcIlVkYMD1eZcpPT
PFs6PZJugY1NRAsvAeMGUIz0PIQ8UMUrUMxAA8z7sezl23O67xj2yFyKrEsz23lG
e1xxqmqMPYJB4Z1c6iImCdf41Wgv2mwwK6dXRXBNElMaH3meh319XalIhQE19xmj
nLp+u4qWP4DIu8pPbJtrO7fspKQv4j0O+gvh5Sy0v0HQwS466yO3il9MP7fSWhvi
S0+g68Tx8+fUPcKFZS9Qg8OJyLNq0rabULGHi11BRwvcigb0AT+8NK/ueiI3vOYr
Tkk50Mw3BR4we5d+PdbU1oIKrXJZJ6IyqzTurYsIMA0lR2o91QfIjtk1iPwrLlzV
qN4AL6Z3ZTd7CyMg/5mTQzvOqGHvSBA2E/sIHznSztf7F7QXIp+iKNaKMA43aZd1
zq0uYm1c
=19Zp
-----END PGP SIGNATURE-----

--fz2i7dxqiqv4iwjt--

