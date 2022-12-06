Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BEEC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 07:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cW6vqRfzKBtqceDu/7EjK/0vu/yl7avmqRCQI+IrLog=; b=dMsxTkR5TO+9Pjno4k0eyo2M24
	15v42xP/9Q2B9O69lvLiuLg/3l15r3ADB/irlf7RjtBrAKaZ/1Uiu7tCxjbC4QSzeYOX5UoefJ8Pw
	eiTF2k+fem1sExru/yYvDQDto78pP5lY3GB8CXWbsUV+yREWEh3QRJJPXvYbWw5R/RLv4xRrtPi1J
	TAQwcJxmYSTRTUbGmWxlem2rxyOFl92T3RukRGciTvhgQm3H/knmc87o37rq/nJDhFaq/7YPHZxJx
	9weorz7L4b4uKads7iOTfHCNZowuq/qiQPMAldU5bFMAxhUQ6cNKz7yOlBD8h0LBq6CJ4YQ7kYy0s
	5E0tjBCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2SaZ-003rDQ-PX; Tue, 06 Dec 2022 07:42:03 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2SaV-003qxc-Df
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 07:42:01 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221206074151euoutp010998f911ac5a316a93f3c704c3613dfc~uJGEvIFOM0552405524euoutp01b;
	Tue,  6 Dec 2022 07:41:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221206074151euoutp010998f911ac5a316a93f3c704c3613dfc~uJGEvIFOM0552405524euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1670312511;
	bh=cW6vqRfzKBtqceDu/7EjK/0vu/yl7avmqRCQI+IrLog=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=sgTd1tpknhomSsjUE64aY7WaeQ9G3Elrv7NdLugLUlc0Pn6K99AH/7v4kCdzkoKZU
	 JA67x0N/c3XM7KR3DAURO2U2kVesF+SuZxnVc16AmrysQd/Jjmehw8KL9YjRLaCTd/
	 X0LgboO2OFpjbe3zB36+9fRoSkfodWOrzGH7jBuA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221206074151eucas1p1770e9036ac7476ab75f683d78b5bcb94~uJGEj41dI2706427064eucas1p12;
	Tue,  6 Dec 2022 07:41:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id F7.ED.09561.F32FE836; Tue,  6
	Dec 2022 07:41:51 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221206074150eucas1p14a7a0bd6fcba0332679656c35d8d72cb~uJGEFf30h0745307453eucas1p1e;
	Tue,  6 Dec 2022 07:41:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221206074150eusmtrp20739182af008d01429f23d89083ec637~uJGEE4tCy0287902879eusmtrp27;
	Tue,  6 Dec 2022 07:41:50 +0000 (GMT)
X-AuditID: cbfec7f2-0b3ff70000002559-4f-638ef23f5b1d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 37.A2.09026.E32FE836; Tue,  6
	Dec 2022 07:41:50 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221206074150eusmtip1d3fd66ca8202da130aca3bdefd139102~uJGD7r1AQ2446724467eusmtip1e;
	Tue,  6 Dec 2022 07:41:50 +0000 (GMT)
Received: from localhost (106.210.248.100) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 6 Dec 2022 07:41:48 +0000
Date: Tue, 6 Dec 2022 08:41:46 +0100
From: Joel Granados <j.granados@samsung.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "p.raghav@samsung.com"
	<p.raghav@samsung.com>, "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v5 1/1] nvme : Add ctrl id to allowed passthru commands
Message-ID: <20221206074146.h5aytkglqy76k54f@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="g6h26pd2d3wzumwj"
Content-Disposition: inline
In-Reply-To: <bbb80606-688d-f84e-6695-38127227d9f0@nvidia.com>
X-Originating-IP: [106.210.248.100]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djP87r2n/qSDW69F7F4f/Axq8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGsVlk5Kak1mW
	WqRvl8CVceNjC3tBI29FR+cblgbGDdxdjJwcEgImEh1n77N2MXJxCAmsYJRoWneCHcL5wiix
	4swyJgjnM6PE5c4FTDAt3Q8XQCWWM0rs7dzHCJKAqNocAJHYwihx+uhrdpAEi4CKxPT/c8G6
	2QR0JM6/ucMMYosI6ElcvXUDbB+zwEkmiTmbX4MVCQt4S6xesgDoKg4OXgFziVXHOEDCvAKC
	EidnPmEBsZkFKiRuvp3OBFLCLCAtsfwfWAmngJ3E048drBCHKkuc2TaTDcKulTi15RbY0RIC
	/ZwSs64fZoRIuEgcnryNGcIWlnh1fAs7hC0j8X/nfKiPsyV2TtkFVVMgMevkVDaQvRIC1hJ9
	Z3Igwo4S7c//QYX5JG68FYS4kk9i0rbpzBBhXomONiGIajWJHU1bGScwKs9C8tcsJH/NQvgL
	IqwjsWD3JzYMYW2JZQtfM0PYthLr1r1nWcDIvopRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93
	EyMwZZ3+d/zTDsa5rz7qHWJk4mA8xKgC1Pxow+oLjFIsefl5qUoivC829iYL8aYkVlalFuXH
	F5XmpBYfYpTmYFES510xpSNZSCA9sSQ1OzW1ILUIJsvEwSnVwMRbrKK9NOznT8mvH1VkklTb
	rdNj0wU1pB9NSbM98Gla2p22aemLgu/X3qvm4z8i33m8lefFD0+X5s8nuMRmTxL8dMjwfMnM
	o0puS7bZcxl6bbsRoHCgscdBLL5z+cxdp2T6SmoDZHcF8rNsqfa/NtvqzOvIU3I3s56F+jI/
	+xeqrN8048uUL6v21j1xcjKx8axKuF1Q9TGjicPgsMXrlkMsotaLfXorXeXWbOOct7BSn0/l
	yLP9E5fP79g7iW/TZofAb6+e2+9PSgjK/HR2n4m42LPmxy1NzaZbHXknxcafffVq75n15+J1
	FT61cwQ5/Fxpy793VpPv19pHtybyLH+5tungFk+/nKCY2nyT6UosxRmJhlrMRcWJAAOwKOvU
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xu7p2n/qSDb7tNLF4f/Axq8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGqVnU5RfWpKq
	kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX0Xz3EEvBf56K7vsL
	mRsY13F3MXJySAiYSHQ/XMDUxcjFISSwlFFi1+01TBAJGYlPVz6yQ9jCEn+udbFBFH1klLhw
	aAILhLOFUaL/7gtGkCoWARWJ6f/ngnWzCehInH9zhxnEFhHQk7h66wY7SAOzwEkmic7+T6wg
	CWEBb4nVSxYA2RwcvALmEquOcUAM/ckosXfhPrBmXgFBiZMzn7CA2MwCZRL3T1xiA6lnFpCW
	WP6PAyTMKWAn8fRjByvEpcoSZ7bNZIOwayU+/33GOIFReBaSSbOQTJqFMAkirCVx499LJgxh
	bYllC18zQ9i2EuvWvWdZwMi+ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzB+tx37uWUH48pX
	H/UOMTJxMB5iVAHqfLRh9QVGKZa8/LxUJRHeFxt7k4V4UxIrq1KL8uOLSnNSiw8xmgJDcSKz
	lGhyPjCx5JXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MM1V3t7m
	Yr/02i4XnkenNwqy63ZcswwKe3Qk0j73Wsty8fiTC3OOC5xYsaXUSPz3zYQr/vN/PQlffJNh
	dUnX1BX5zjznqlzzujw235HRvOrCN+2Onhhn9Y/EpV31Pa+de+taU2/GrdB9deuNjnhtoJ9c
	/LEE11DehvRHuWyVf+fH/t/x598Tk4knEvXs/stau2Z/Ur/z4OY6rb5jE9VuZc0uf1zzu+iZ
	+2HFI9G/i6LrbL78ic79Wui07efJPCvmhW/2Xjt/1Ohruujxa1V+TQ1LeBbsbnVLSG+aOv+x
	jZ+fzFz26ly5gzESXCkN1if0t8jsWfaVc3ZK56adwswRlerpbezSGyy/l/ku8DinrsRSnJFo
	qMVcVJwIAHpdD3p0AwAA
X-CMS-MailID: 20221206074150eucas1p14a7a0bd6fcba0332679656c35d8d72cb
X-Msg-Generator: CA
X-RootMTR: 20221205143143eucas1p2c4044196a8ff0cb9b563f99d2a5183ce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221205143143eucas1p2c4044196a8ff0cb9b563f99d2a5183ce
References: <20221205142746.1026912-1-j.granados@samsung.com>
	<CGME20221205143143eucas1p2c4044196a8ff0cb9b563f99d2a5183ce@eucas1p2.samsung.com>
	<20221205142746.1026912-2-j.granados@samsung.com>
	<bbb80606-688d-f84e-6695-38127227d9f0@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_234200_110121_1D82F822 
X-CRM114-Status: GOOD (  15.47  )
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

--g6h26pd2d3wzumwj
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2022 at 04:25:59AM +0000, Chaitanya Kulkarni wrote:
> On 12/5/22 06:27, Joel Granados wrote:
> > Add NVME_ID_CNS_CS_CTRL and NVME_ID_CNS_CTRL to the nvme admin commands
> > that are allowed in unprivileged passthru. This will allow access to
> > attributes that are needed to effectively write to the char device in
> > passthru.
> >=20
>=20
> Perhaps mention what attributes are needed for clarity.

I'll add two examples of the attribute names to the commit message and
leave it at that. Hope that is OK, as having a list of all attributes
that might be used for a write operation will get long.

>=20
> Either way, looks good.
>=20
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>=20
> -ck
>=20

--g6h26pd2d3wzumwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmOO8jgACgkQupfNUreW
QU9FDwv/Vkd8JSxWovszJ6jO6Glgs1Z79S2wWxfHtuJ9pbAOwAzbhR6nbi9fDapZ
Z87z4Ig4jF+jsiuo9F5eZhImrlN8bmXoiIJDvUOGBYwOgEd852h2WZDIZOTa/UIb
ZkfC26EfUahhxz/FBel4Pf5Oajmza498wGJzeClT7Zl52a1nGQeuCIGupneX4SNu
dZZHssAOhQRQuTxx6EOMR+HmRsy9UM+8Rm4lCrCBhJ+VUG62aLJU3QibfMmVOTEI
+Q8XgC57WKZUYoJ8f5IXRCftDRqZ1MTPTtwZQCVuEN3s2cqKSwbai4RcwS8qd/Qd
t5ecQx7gS9aYgM2AfUmx9thOTrcZKvF18wZ5S1Ad/Se6bzxvMJLbKJ9+htl51HkB
IdETabBdPVdpcA7Qxfa9tOwMk+lLH6Duj0ScOusFUnA5+fYI4ywTaHv6BaMIxwvg
KYF3ipXizlyJQ2aYAfwWX4mYPjJBIucn7TzSTkxEVYfR/xGlCqozYnbWysryFWj7
nLHh4GGY
=bLKZ
-----END PGP SIGNATURE-----

--g6h26pd2d3wzumwj--

