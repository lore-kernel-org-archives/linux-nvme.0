Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93810C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 15:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8S9leOLZMVwIzJ3j95Xgr3KIF8gdHzsyYh52sP6Mxr8=; b=zA9PEg3LY6KWqFWt392UAekZiG
	FB6Yf0UuW5N7EDuQRg5idxvAtma54yakEf1OgMdlSht3BB1ad2JebsSDk7Uh87q4EhSvaT3eg94p7
	qll43pyl+YQoJOqYWsBptsOSjNmDet1fvyo1Bp1DDiapsLitoLFvI7iI+lXGf8FcxEsdRtLuNTIgY
	TwqniUbyxB9YoeMWyusjbDESX19nRxCS3jdpUv9ZmQz6y2Hjokhw3QueW1cBhV8GToEO/lvLIly9m
	bMpAJfsUrIr6DPkKkRDnR6pfYBO5E72AeWl56ZWDXwELWfrwIGlf7JRemPbsX4PdKGnvSStJs7JyG
	DBxXMrRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox94q-00FNba-Hx; Mon, 21 Nov 2022 15:51:20 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox94m-00FNX5-Qj
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 15:51:19 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221121155111euoutp0293a279776e156bb090b68b0dbd320f04~ppGCWsJOW2850028500euoutp02c;
	Mon, 21 Nov 2022 15:51:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221121155111euoutp0293a279776e156bb090b68b0dbd320f04~ppGCWsJOW2850028500euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1669045871;
	bh=8S9leOLZMVwIzJ3j95Xgr3KIF8gdHzsyYh52sP6Mxr8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FpW1UI0DomOEmDQMcb2HU+zuRgNjSjkV+/zOMoexS3RltYnyn3CAFc12BExYqJ78M
	 OJ1P4xBGbcIt94NNz/MblIFtV1zOxtStHxgw8fV/yt2nVcRC+FtZQSVU5e2ZsmSPI7
	 6gFJqmFMt3zdMRq4KaF6Q+II1jq75oyDeDj0Qp90=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221121155111eucas1p128b299f0452edc6e6e043edb266cf884~ppGCOObE70211602116eucas1p1_;
	Mon, 21 Nov 2022 15:51:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 5F.0C.09549.F6E9B736; Mon, 21
	Nov 2022 15:51:11 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221121155111eucas1p228b64e049091ad389966aade0a204477~ppGByw5TM2915029150eucas1p2P;
	Mon, 21 Nov 2022 15:51:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221121155111eusmtrp2fef01ed0b6bd5fec77ebb28c39055362~ppGBx-Be62957829578eusmtrp2j;
	Mon, 21 Nov 2022 15:51:11 +0000 (GMT)
X-AuditID: cbfec7f5-f5dff7000000254d-91-637b9e6fd1e6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id A3.5C.08916.E6E9B736; Mon, 21
	Nov 2022 15:51:10 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221121155110eusmtip14190dcf66c368ee6598c1a565a5eee79~ppGBkoEZw2607926079eusmtip1M;
	Mon, 21 Nov 2022 15:51:10 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 21 Nov 2022 15:51:10 +0000
Date: Mon, 21 Nov 2022 16:51:11 +0100
From: Joel Granados <j.granados@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <chaitanyak@nvidia.com>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>
Subject: Re: [PATCH v3 1/1] nvme : Add ioctl to query nvme attributes
Message-ID: <20221121155111.hksu6l3uqtc4u3p6@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="tormjsy36z77yaxp"
Content-Disposition: inline
In-Reply-To: <Y3gIl1d8tVsx/+NG@kbusch-mbp.dhcp.thefacebook.com>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djPc7r586qTDc5skbZ4f/Axq8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGsVlk5Kak1mW
	WqRvl8CVsadrKlvBS76KM/d2sDYwfubpYuTkkBAwkbhz6z57FyMXh5DACkaJx49WQDlfGCVm
	/1zGDOF8ZpQ4OWsuK0zLotaNUFXLGSV2vD/LAlf18OFxNpAqIYEtjBL96zlAbBYBVYm2vX8Z
	QWw2AR2J82/uMIPYIgLKEnfnzwSbyixQKXFu9jt2EFtYwFXi3OHlYHN4Bcwlrv77yAhhC0qc
	nPmEBaK+QmL+9ilMXYwcQLa0xPJ/YKs4BewlXje+ZYM4VEni65teqKNrJU5tucUEcqeEQDen
	xNxtncwQCReJ74famSBsYYlXx7ewQ9gyEv93zoeKZ0vsnLILqr5AYtbJqWwgeyUErCX6zuRA
	hB0l3s7ZABXmk7jxVhDiSj6JSdumM0OEeSU62oQgqtUkdjRtZZzAqDwLyV+zkPw1C+EviLCO
	xILdn9gwhLUlli18zQxh20qsW/eeZQEj+ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzA
	lHX63/GvOxhXvPqod4iRiYPxEKMKUPOjDasvMEqx5OXnpSqJ8NbHVCcL8aYkVlalFuXHF5Xm
	pBYfYpTmYFES52WboZUsJJCeWJKanZpakFoEk2Xi4JRqYJJNCfIN3mN4aJfFjdzj+7vmbdwT
	0XTbp9l/54+HpxMOuN2+/LP8/ynDuQpr5/PmFJv+W3rj4yWXtwsD3opMM+y3Zn0oulVnidB3
	ya//d3wyabn3wbnrXHiJ0pTVTPNsjsdMF955unCuSWg957GqwlexPDlvNHOD9zUb8K/T0ay8
	ouMs2Rsb3LFd1X9aRUsNt4L/P50aCelfhr6hWrt26m4ts+u/sW1D7Zqi6neLyxtW7lm4pU51
	38eWnV6XFW5MusQ+OeVNlv2Fb7ZKPMtfvX1j1ft1Ntfe/04Lp/BdZYnilHzi9pp/a2yd1LnF
	Z3IWBBx6cGcf073j6Qy7Eqf6r7+c8P367HmHZHbyBc1h57mlxFKckWioxVxUnAgAGu+QStQD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xu7p586qTDRb/srB4f/Axq8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGqVnU5RfWpKq
	kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX0XDoKWvBc76KP5P/
	szYwfuTpYuTkkBAwkVjUupG9i5GLQ0hgKaNEY/9yJoiEjMSnKx/ZIWxhiT/Xutggij4ySry4
	/I0JwtnCKHHu13MWkCoWAVWJtr1/GUFsNgEdifNv7jCD2CICyhJ3589kBbGZBSolzs1+BzZV
	WMBV4tzh5WwgNq+AucTVfx8ZIYb+YpT4OLedESIhKHFy5hMWiOYyiSOb24FsDiBbWmL5Pw6Q
	MKeAvcTrxrdsEJcqSXx908sKYddKfP77jHECo/AsJJNmIZk0C2ESRFhL4sa/l0wYwtoSyxa+
	ZoawbSXWrXvPsoCRfRWjSGppcW56brGhXnFibnFpXrpecn7uJkZg/G479nPzDsZ5rz7qHWJk
	4mA8xKgC1Plow+oLjFIsefl5qUoivPUx1clCvCmJlVWpRfnxRaU5qcWHGE2BoTiRWUo0OR+Y
	WPJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpjmrpKp+5791MhS
	99GCBzvOGl6dxxdXp/jftss1PUi23XxHkaC94fXMp446/nO2fAid8I1ffcOd9fcOB2f6VW8/
	LP9l21vPq5xdgrFVnJ8f+Dhx5Co4iBU6vPHUPR3Ewb1Gz3ha0qQt//51W7VrCdyRVed8YH6p
	YPO3LIdjbBODdUWlS43it9UullBl3dnMn1oltYDR7wL3sWbj/fI2soVt/ad3XFdftab+9MPJ
	115lb3EUV2eUWbHiadILf82PW8OSCsTeOj5aHtrfZ/mkjkPGZPHkC7c2rE7oKNCKeb9szaJf
	W3IfTZ1ldGqJ08TNtetMRCbfEX9h/ObPxs3ss45O7dx8776bEV+51XSNm8JKLMUZiYZazEXF
	iQC9YeMPdAMAAA==
X-CMS-MailID: 20221121155111eucas1p228b64e049091ad389966aade0a204477
X-Msg-Generator: CA
X-RootMTR: 20221117141718eucas1p11d0b9f10ff4c0ca6ba865251af775fc8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221117141718eucas1p11d0b9f10ff4c0ca6ba865251af775fc8
References: <20221117141337.3719372-1-j.granados@samsung.com>
	<CGME20221117141718eucas1p11d0b9f10ff4c0ca6ba865251af775fc8@eucas1p1.samsung.com>
	<20221117141337.3719372-2-j.granados@samsung.com>
	<Y3gIl1d8tVsx/+NG@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_075117_483973_98CC4B6B 
X-CRM114-Status: GOOD (  16.95  )
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

--tormjsy36z77yaxp
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2022 at 03:35:03PM -0700, Keith Busch wrote:
> On Thu, Nov 17, 2022 at 03:13:37PM +0100, Joel Granados wrote:
> > +#define NVME_IOCTL_GET_ATTR	_IOWR('N', 0x50, struct nvme_get_attr)
>=20
> Isn't the ioctl's number derived from the sizeof the parameter? IOW, if
> you add new fields to the struct in the future, the ioctl number will
> change, breaking older applications that were using it. I don't think we
> want to keep adding new ioctl's to support legacy users, so probably
> padding that struct with plenty of reserved space is the way to go.
My bad.

That is NOT supposed to be an '_IOWR' it was meant to be an '_IO'. In
this way we do not have the size of the structure changing the ioctl
number and we handle the extensibility with the first two arguments of
the ioctl. In the same way that it is handled in
https://github.com/torvalds/linux/blob/master/include/uapi/linux/vfio.h.

I'll send another version fixing this.

Thx

--tormjsy36z77yaxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmN7nlcACgkQupfNUreW
QU986gv/Wa1swf4AUJnG3paWQM83MQsuqc1tdLlprgnvzjnXqi7WfM9K0gmLmSyu
gOHNk4Goit/nYtuhFt0joLYxWwhjJ28fbeScl6UafuMrVeg+hM0oOMxpRpp8HEiP
HCIHTimY7tdIHDSyDyT780V4ye+3W8iTVECkdxjnr1zrHmy2F6nPu7tBgwMnjCLS
zvaknvl/IrNT75DGroi61gyK3ROu3ViyprQiyJZSHkVi5C+UOfAzVkorkgWtq9L9
9ERPLp9tTbaEhq+n2SQIuutIBt51GAt1O7P+5PqWitCtozV4jqll+ngNv8D+G+JP
h8jtDXVrtw83PEviFiPIYgnAXQv9OADcl9eQ8Osub8ACwFAtpkxIw34JqDK5VsEN
SgFJ2OMliTPozdiXaIVXruZyqozbjvvl9wYXlPrIXcMdT4JjEXnrkJvS2lTeI3MA
dxi/cEOF8nV+BOatcldl0da/aRRSYsi2+PPc96OkxO3NyZ5Bh1cX+HyJui6lQ/HM
ChoQaSpj
=/jUj
-----END PGP SIGNATURE-----

--tormjsy36z77yaxp--

