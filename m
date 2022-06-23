Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA20C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 08:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5/khdWVD0OJx/F3dZQzS14oVmPge505+3le1M4pb5Nc=; b=UoC6l7UsTz/iF4qpZFpJG659jj
	XP9y485oSasYkeaxUNb6Sfm5Xmd1y0nAW5sfamifDE7HP1j8JcOvAqKHkX6rzPjTcWYkS7COUzVEN
	C53elP+tASpoaqIiFUbiQotjmi6SAlZSCKLCY9I0BrmjC/nWYfrrorxfZmJy5TrJevxQnowTFK4f8
	9VlYHui9Sg7bDYmMsF8XQqKhNnSxZRvD7CyKVHY7hBVfcKKMbhtW+vVoUM50524SePNu+e1BwMrWp
	J6v60aAj2f+ZjzjDZ+5qQkOZGTkEsR86d0yNNYdBWqgnbhMDaoVFY+0ORixyEDwLlWkaNcALGRj0M
	ODFsvv8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4INI-00E7xY-M9; Thu, 23 Jun 2022 08:39:40 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4INA-00E7tj-JW
	for linux-nvme@lists.infradead.org; Thu, 23 Jun 2022 08:39:39 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220623083921euoutp012f0652cb6be3eff5c15a95395c3f7a67~7My4WZvGL1169811698euoutp01G;
	Thu, 23 Jun 2022 08:39:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220623083921euoutp012f0652cb6be3eff5c15a95395c3f7a67~7My4WZvGL1169811698euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655973561;
	bh=5/khdWVD0OJx/F3dZQzS14oVmPge505+3le1M4pb5Nc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=isw7FFM2ajAP5mkiZBK+Xi0oUcPock9OmRZ9ol0ry+uslYCVlBhHr65Jr63hK3Gn9
	 tEEtenSzk1cTG70mr3sGhTFzMzwdjRh2Ak2Wccq6Zdk9fOfUUXhrnwM7sX/tfVbtPf
	 FGvPGkFoJM8sFJlQhIsIfGpLFrEgdHEbPUH/oj40=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220623083920eucas1p2cfd6ec98b5009e48faed51d7ce2de324~7My4LhS0I0671906719eucas1p28;
	Thu, 23 Jun 2022 08:39:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 60.92.09580.8B624B26; Thu, 23
	Jun 2022 09:39:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220623083920eucas1p2002154b7c460034a2bc6588fb185ba1b~7My3yJmjT1909419094eucas1p2Y;
	Thu, 23 Jun 2022 08:39:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220623083920eusmtrp12c120eae3d5f24a5815ee5f9158da64b~7My3xVIgu1471914719eusmtrp11;
	Thu, 23 Jun 2022 08:39:20 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-41-62b426b8d62c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 9B.F4.09095.8B624B26; Thu, 23
	Jun 2022 09:39:20 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220623083920eusmtip1f2226d7ab8db918133d8311315781d96~7My3o3irq1540915409eusmtip17;
	Thu, 23 Jun 2022 08:39:20 +0000 (GMT)
Received: from localhost (106.210.248.99) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 23 Jun 2022 09:39:19 +0100
Date: Thu, 23 Jun 2022 10:39:18 +0200
From: Joel Granados <j.granados@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <joshi.k@samsung.com>,
	<gost.dev@samsung.com>, <k.jensen@samsung.com>
Subject: Re: [PATCH v3 2/2] nvme: enable generic interface (/dev/ngXnY) for
 unknown command sets
Message-ID: <20220623083918.kvtkpwyy3ob52sp4@joelS1.panther.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="74uqgvozbenrqrui"
Content-Disposition: inline
In-Reply-To: <YrN5dWNZkUnFpjSH@kbusch-mbp.dhcp.thefacebook.com>
X-Originating-IP: [106.210.248.99]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7o71LYkGezfqGuxcvVRJotJh64x
	Wsxf9pTdgdlj06pONo/NS+o9dt9sYAtgjuKySUnNySxLLdK3S+DK2DXxO2vBBuGKbT0PWRsY
	9wl0MXJySAiYSFxdcIy5i5GLQ0hgBaPE0Xd3WSGcL4wSM79MYoNwPjNKnDw3kQ2m5cW0+4wQ
	ieWMEvuPHGGGq9p7vZsJwtnCKPH5znNWkBYWAVWJS3cXMoLYbAI6Euff3GEGsUUElCXuzp8J
	VMPBwSxQLfH0VwJIWFggSeJnQxs7iM0r4CDxbf4NNghbUOLkzCcsIDazQIXEhhO3GSFapSWW
	/+MACXMK2Et0XzzIDnGoksS5hmYmCLtW4tSWW2CnSQi84ZDY9fYfM0TCReLujKusELawxKvj
	W6CaZSROT+5hgbCzJXZO2QVVXyAx6+RUNpC9EgLWEn1nciDCjhIrbz1iggjzSdx4KwhxJZ/E
	pG3TmSHCvBIdbUIQ1WoSO5q2Mk5gVJ6F5K9ZSP6ahfAXRFhHYsHuT2wYwtoSyxa+ZoawbSXW
	rXvPsoCRfRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgKjr97/jXHYwrXn3UO8TIxMF4
	iFEFqPnRhtUXGKVY8vLzUpVEeF/835wkxJuSWFmVWpQfX1Sak1p8iFGag0VJnDc5c0OikEB6
	YklqdmpqQWoRTJaJg1Oqgak791++nWbi2bmND5vrn9nYJPaZyid9OnTp1P1p+xV7ODyB0TyD
	h5kjPE+XVXuxyp7p63xvHo15ear1v7iNPuei6FwT1b+J9lJZ39kjtGSq/kj4TXSTDN5s1sz2
	ek5N1ocTqTuZjUtYvLfPr5rwivViSmhRxtedWlJ/q/p5Zyk/joqaKbk57veOO7sU0ldVpD94
	ZCYitHdP5Xpz9j2PCl/WeRnWSTonrXhQ7LpaRC/pQ8nuGz3SHkvUvF4UbPhnu++iZYTWo22H
	zzyaViil8u+30JdZj7X6wzWEbqQYTlNZ7KR4TtDYp547wnBJ4kvmJd+DDpt4bLRszRAXOXmb
	0aBl+7wJa6OEm/w0tpcqsRRnJBpqMRcVJwIAbzqS48ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7o71LYkGRybImqxcvVRJotJh64x
	Wsxf9pTdgdlj06pONo/NS+o9dt9sYAtgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
	No+1MjJV0rezSUnNySxLLdK3S9DLmDBzDmvBOuGKO/0P2BoY9wh0MXJySAiYSLyYdp+xi5GL
	Q0hgKaNE585JjBAJGYlPVz6yQ9jCEn+udbFBFH1klNg0fy0rSEJIYAujxMo59SA2i4CqxKW7
	C8Ga2QR0JM6/ucMMYosIKEvcnT8TqJ6Dg1mgWuLprwSQsLBAksTPhjaw+bwCDhLf5t9ggxj5
	i1Fi0q9qiLigxMmZT1hAbGaBMokPLb3sEGOkJZb/4wAJcwrYS3RfPAh1ppLEuYZmJgi7VuLz
	32eMExiFZyGZNAvJpFkIkyDCWhI3/r1kwhDWlli28DUzhG0rsW7de5YFjOyrGEVSS4tz03OL
	DfWKE3OLS/PS9ZLzczcxAiNy27Gfm3cwznv1Ue8QIxMH4yFGFaDORxtWX2CUYsnLz0tVEuF9
	8X9zkhBvSmJlVWpRfnxRaU5q8SFGU2AYTmSWEk3OB6aKvJJ4QzMDU0MTM0sDU0szYyVxXs+C
	jkQhgfTEktTs1NSC1CKYPiYOTqkGJutTxwTX3f15vaV9i5Kb87aSRTKrizVcpbPZrm29euzw
	nZWPRPpf/Hdd9rJH7+HuZU3nDa9qxM/evD5ul8J2l10rt830efFXTtVqCefy7XfWOm1ZMWeZ
	dajv3g72XvMP2jPU5sy5x1+25mjRNneHS/qh1eYpLvvWaSc3zrl7/9xHpctzTs5KP2/RmBRn
	U3iR78QBCZ9A3ptGxSu7VGWW6oe95kz+tqp8mUGXSf7D7cW+/oIaM1daBl35y3xmxxbN876e
	pZZ7Kv7MeOPiuONrQI3uDXPfguBw++Yg9S3LM23/NTKEdZ3JeFoYwvb13HtZjtl8Z2989zH9
	V9y4evXlR0+czt04oj2rQLsg4pvK3CIlluKMREMt5qLiRACIGVPtXQMAAA==
X-CMS-MailID: 20220623083920eucas1p2002154b7c460034a2bc6588fb185ba1b
X-Msg-Generator: CA
X-RootMTR: 20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7
References: <20220622135556.2185991-1-j.granados@samsung.com>
	<CGME20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7@eucas1p1.samsung.com>
	<20220622135556.2185991-3-j.granados@samsung.com>
	<YrN5dWNZkUnFpjSH@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_013934_080573_ADBA0B54 
X-CRM114-Status: GOOD (  19.92  )
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

--74uqgvozbenrqrui
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2022 at 02:20:05PM -0600, Keith Busch wrote:
> On Wed, Jun 22, 2022 at 03:55:56PM +0200, Joel Granados wrote:
> >  static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned=
 nsid)
> >  {
> >  	struct nvme_ns_ids ids =3D { };
> > -	struct nvme_id_ns_cs_indep *id;
> > +	struct nvme_id_ns_cs_indep *id_indep;
> >  	struct nvme_ns *ns;
> > -	bool ready =3D true;
> > =20
> >  	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
> >  		return;
> > =20
> > +	if (nvme_identify_ns_cs_indep(ctrl, nsid, &id_indep))
> > +		return;
> > +
>=20
> There's no check that the command-set-independent namespace identificatio=
n is
> supported, so an error should be expected for many controllers instead of
> abandoning the namespace.
good catch. But is the error really necessary?
If the controller supports NVM or ZNS then we can continue with the
normal (command-set-dependent) namespace identification.

I see two situations:

1. When we are dealing with NVM or ZNS command sets:
1.1 Should bring up a block device regardless of supporting command-set-
    independent namespace identification
1.2 Time-to-ready will be used only if command-set-independent is
    supported

2. When we are dealing with something that is not NVM nor ZNS:
2.1 Should bring up a char device iff the command-set-independent
    namespace identification is supported.
2.2 Should abandon the namespace with a dev_warn if the
    command-set-independent namespace identification is not supported.

Am I missing something?

--74uqgvozbenrqrui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmK0JqoACgkQupfNUreW
QU8tKwv/ZK4ZgyFjIvfsQg3YTCp/PCrw6IOS4VsvmkEWs+5fjzo+jUBfAb4L14ug
xNyk6MKW6wJh2AO+HvduhBb4GlZoTiV2mQNRo1tRmZ3uyGTOfPCHAOuhh0J8gWS7
N7RWGwxm5P0j9/epXbdMFhI/B4XZWtJKOu0IKCQ7tUfG5zq/laz21IEgKjvTq9ld
XPx2RY/t6jIztQYQoqfdc7HKrwTs9bVvE3eP5fNWqqbhwrQeNi2cDDe0uMa7GevD
57cu6KQ3BXTO2lJfE9xQ4quzJ+jUSjrhV/uT+1/esFCGOAWM2/8S77L3lSWv69jU
m3vT594swurB8iZCZcYu807se/N7ufEmTHD7nEiZqCdH8lq9a05DWOgpkkIqJWSX
JBfPANMxQNyWMWYQtL7+EY4l3CYoWEwQzWtoUpgfXa/8bBp8Qn+WVPQ2//ASSBrR
hY4Yz8Tec31KM3TsVXRsgvybkiSxp1SuHNPpsJWSRlRbdarCBoJ4GOG7RsXUxY9O
2xNh268p
=RBli
-----END PGP SIGNATURE-----

--74uqgvozbenrqrui--

