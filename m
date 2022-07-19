Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552CEC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jul 2022 21:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WmlbW32iKDQCNhHpUin2/k1xTCBY2LdiP4UAx/saB1c=; b=x0JdPPhYffhe7hG14pAAvtFjCL
	GkM7bcR6XMD+VUPvXzSxwUZuCGi2Kbm8l+tMRXbWxoPhWSlLlohCmWYN/puc1SW/iOrKPW0KTSYAS
	OvNQ/BRU/tBgsYrykFlJugkTBO5n99sDFWINQQekbtp+RIrSM1JhrIpY+71gm3UYnFZIvbTyOnCx6
	I3Ry/D7+Pl5aZew5CTsWEWwaONrSyEb0nSHCJd8CIa8CjTSRnxvcOcuHf7tR717t+KFBlhvlDvpSQ
	UUh+Bp00zNS6jir2yWYM9xPxRn/KKIQ0bLoIQ774hNCB0ts8SuLuXdeNeNSwUOejr5tygA/agtGdP
	Stvl5dNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDubK-00D6a3-R0; Tue, 19 Jul 2022 21:17:54 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDubC-00D6TE-Jr
	for linux-nvme@lists.infradead.org; Tue, 19 Jul 2022 21:17:51 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220719211735euoutp01960ca2721885cb3dfaa02b998351ec7c~DV6Vd-BUq2101321013euoutp01w;
	Tue, 19 Jul 2022 21:17:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220719211735euoutp01960ca2721885cb3dfaa02b998351ec7c~DV6Vd-BUq2101321013euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1658265455;
	bh=WmlbW32iKDQCNhHpUin2/k1xTCBY2LdiP4UAx/saB1c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=L+XOjX/8rbiLvwqdzoT1v5Xyx3PkUiLKU7n1M1oCHGsT2jGHEkEAH5f3lqt5UeBgW
	 WZ4m9YLnlvtAi80IBM3N3mvrn4pjxViVykV0ZZOdwN4eKlWLmuZi7TEWMG2zbtIEYg
	 aKOwJv8EDA9orQzNB9OPc910OdAeRnCBW7z2MMpg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220719211735eucas1p1eaa3ddac73f32d019516aed0d20cb121~DV6VRm7Ku2473524735eucas1p1i;
	Tue, 19 Jul 2022 21:17:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id D3.AE.10067.F6F17D26; Tue, 19
	Jul 2022 22:17:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220719211734eucas1p1f0c4355f840101a53088f08ae02f9ba7~DV6UJrqMa3029530295eucas1p18;
	Tue, 19 Jul 2022 21:17:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220719211734eusmtrp2ba1d5e69f19e42779c4b80dbd688748b~DV6UJGvoQ2729427294eusmtrp2j;
	Tue, 19 Jul 2022 21:17:34 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-d5-62d71f6f8ae9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 97.91.09038.E6F17D26; Tue, 19
	Jul 2022 22:17:34 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220719211733eusmtip12716a3e1e8e29787af2b0808db5393d1~DV6T-r95j1691916919eusmtip1c;
	Tue, 19 Jul 2022 21:17:33 +0000 (GMT)
Received: from localhost (106.210.248.172) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 19 Jul 2022 22:17:33 +0100
Date: Tue, 19 Jul 2022 23:17:31 +0200
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/1] nvme: Remove unused enum constants in nvme.h
Message-ID: <20220719211731.zwdeglvake3egytl@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="74w574gqmvi5k5ty"
Content-Disposition: inline
In-Reply-To: <20220622084859.1937878-1-j.granados@samsung.com>
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VSe0hTYRTn2727u1qzu2V5tChSi0jTHpaCJUkFMyFEJDCNda0PFec2tllW
	VjKsbJD00NQhalQ+W7m5zGUPWvhKSzMorcASnWnWLEdklLZ5FwX99zu/F+fAoQlxHd+PTpdr
	sErOyvwpT7KpbfrZWsXyVynrbhhFEbX1rbyIi9aXKKKiakSwjZCY6s5SksZrJyUtA7lUHLHX
	c8tBLEs/hFWhUfs90+xvyvjKclG2sTApF4156ZAHDUwY1DzsI3XIkxYzNQgezfa4B4dzaB/n
	c8MUgqunf1J/Ig7LGMEJ1QgmWh4hlzDnKnq7gxNuIyjVPZlLkMxKKG4c5LswxQRDz8RbZ5qm
	vZ38g7ytLppgAuFO/yueCy9kdsJ12zmBCwuZcLDmjyMOi6CzdJjk/Nkw2WycqyGYJVA9Q7to
	DyYK6mu/87g9A6DsYzPB4eNgaOsWuFYDZpiGwfdlfFcWmB1w6Z6M8yyE8XazgMNLYdZS4e7J
	AEvhXXePEvSdRRQXjYSCbnc0Gu4bCtyNXtD/ScQt6QUXm4oJjhZC/mkx514Fzdrb6DwK0P9z
	lv6fs/R/z+LoYKhs+Ur9RwdB1ZWPBIe3ws2bdrISCeqQD85SZ6Zi9QY5PhyiZjPVWfLUkAOK
	TBNyvlDXTLujGVWPfwmxIh6NrCjQGR5qqO9FfqRcIcf+3kLv4y9SxMKD7JGjWKWQqrJkWG1F
	S2jS30d4IL2BFTOprAZnYKzEqj8qj/bwy+UtVj5rtNuoSwXzBkok4dZBCmYVxyqOhmpnVoi0
	pR9yHjwtr8TlU69FFyTJSR0FXlrfGptMl8zaxy730UXfgnarpMFSy0zQmfhWHNawqNrQZXqx
	YCzt/vOX8b7bV3vvNJQYO6wrYoyRm0zLNhvieqPN33lFhflDsWu0TUM/MmLyoqdPtdskifOF
	Ik3tj06/d0N9XXklU9EnnvT6NpIp10yWdcgWyR9tep7wSeYwSx/ui9WcG9mlUVDYHHpGFzDL
	eFyOYtpyXk+2KqVXP2+6tacnabi8MFi1URjKjtbpNWbH9ETCxOOOrlO/unlSvIocmSQ+9yTm
	We1Mckj9fn9SncauX0Oo1OxvHozLRr0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7p58teTDPq7WCxWrj7KZDHp0DVG
	i/nLnrI7MHtsWtXJ5rF5Sb3H7psNbAHMUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG
	5rFWRqZK+nY2Kak5mWWpRfp2CXoZa5fGFMwRrLiy4CxrA+Nzvi5GTg4JAROJLztfMoPYQgJL
	GSWenE6CiMtIfLrykR3CFpb4c62LDaLmI6PE7LmWXYxcQPZWRon5xx+xgiRYBFQlpm++D2az
	CehInH9zB2goB4cIUHxfiy1ImFlARWL7jetMILawgKvE0me9YPN5BcwlDnW8YoSYOZFRYv2L
	pywQCUGJkzOfsEA0l0nsarrECjKTWUBaYvk/DpAwp4CdxOqVP5gg7lSWmPN6BzOEXSvx6v5u
	xgmMwrOQTJqFZNIshEkQYS2JG/9eMmEIa0ssW/iaGcK2lVi37j3LAkb2VYwiqaXFuem5xUZ6
	xYm5xaV56XrJ+bmbGIHxuO3Yzy07GFe++qh3iJGJg/EQowpQ56MNqy8wSrHk5eelKonwitRe
	ThLiTUmsrEotyo8vKs1JLT7EaAoMxInMUqLJ+cBEkVcSb2hmYGpoYmZpYGppZqwkzutZ0JEo
	JJCeWJKanZpakFoE08fEwSnVwLSpKGqR1ufylT7GPnzpMse5XNfv155wNnvOHleh5qb2n+m6
	q2aEZB37HcEcUBVwcN0u2ddJd9RMGj9Xlb9mOqXwS/KkcmTVP8MdYioLj8WWcbOfO2u/5ZtZ
	TmKmAOe7U/0z1PiqjS4seeRu6XtaISM5KayDPeULi5fZ2m8NEVrBkS4eoulzK8Oc1GuehG1w
	fXMx6K6WgJesko+D8B+bjjy97ZMD2TjP8ynOCrO+4LLKY26A5ZJnp47qvc7tDUluKfY72f5u
	hrejZ2q28vWp+asZfV0W3nv6aMHp+N+i208d3Vd1VO/vz11xs5kV3n5lnGE9da1f1Tfb+Tp3
	2p9aay3JaxT+J8G6+dN2m/4vSizFGYmGWsxFxYkAEs8l3FwDAAA=
X-CMS-MailID: 20220719211734eucas1p1f0c4355f840101a53088f08ae02f9ba7
X-Msg-Generator: CA
X-RootMTR: 20220622085123eucas1p25f724850a5397fa90a0e26eb4d5af92f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220622085123eucas1p25f724850a5397fa90a0e26eb4d5af92f
References: <CGME20220622085123eucas1p25f724850a5397fa90a0e26eb4d5af92f@eucas1p2.samsung.com>
	<20220622084859.1937878-1-j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_141748_698572_0EF0BD5B 
X-CRM114-Status: GOOD (  21.20  )
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

--74w574gqmvi5k5ty
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2022 at 10:48:58AM +0200, Joel Granados wrote:
> While working in include/linux/nvme.h, I noticed that there are enum
> constants that are not being used by the kernel. They are also not includ=
ed
> in any UAPI directory. These variables were synced to keep up with nvme-c=
li
> in 48c9e85b2346 ("nvme: resync include/linux/nvme.h with nvmecli"). Since
> nvme-cli now uses libnvme which defines all the structures within itself,
> there is no need to synchronize any longer.
>=20
> There have been discussions to introduce functionality into the kernel th=
at
> use some of these variables like in
> https://lore.kernel.org/all/1558278418-5702-1-git-send-email-akinobu.mita=
@gmail.com/
> but to my knowledge they have not made it upstream.
>=20
> This patch removes the enumerations that are not being used within the
> kernel.
>=20
> Please get back to me if I have missed something and these variables are
> indeed being used.
>=20
> Best
>=20
> Joel Granados (1):
>   nvme: Remove unused enum constants
>=20
>  include/linux/nvme.h | 32 --------------------------------
>  1 file changed, 32 deletions(-)
>=20
> --=20
> 2.30.2
>=20
>=20

Ping. Does this make sense? Or are we keeping these around for future
use?

Best

--74w574gqmvi5k5ty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmLXH14ACgkQupfNUreW
QU+ePQwAkkdWXiz3Z+UuDTD3Ij2130XbNs6XFlnyRXpkeC/XnvEorGRozZT1W6Kv
rDh5UBqxYKonTwnUthrEjpR3xklVvyP4WqYvLY/H8EDmXBHtMTi0pQxEhFODI/AX
Y/M9OZpeG3vnlVWnVuzLWpTHiLsJpfKC+t+3jKmK7rvflcEpEk9L1WXMurfu6DNa
Mh9wVfTr8P8FlMEFK+SBVspqPkGibJfoIqS06R03xF+sOcYUe197Womqk2+yUfdT
joqZ2OhhnBLXu0B/5cwdsdx8UhlWJnRCjnLMgwptvQezoytvgDVDkyN3oUdXrYji
szPUdc5JwGxXCHUU5KTHrEutr/oiUpTBhyvX5oCIDSh3Vsvk6B3P5OVk3FMUDjci
j6uwtvVO4ZkPVMt2ICbUKywh+/x4D6nzLF/IK6B5bIGxno7excWXpZPsk1/qXNvY
op/r6iwquni+PjYHJ/EveoVLtakGAgnePsVUjtURybbM6EIdd5xmSOyYfGyEX3eN
ADjLRDG6
=5zhk
-----END PGP SIGNATURE-----

--74w574gqmvi5k5ty--

