Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A14FA3740
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 12:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lZBDofiGeERTN7kLLngjdEdLDDWfSu8/tUBcLnEsN1M=; b=RM3pP9l5z/t31Vjl3hfSQF8mFL
	ZtkUQvg63b/vWwKBNff+CPgRz0vsmLrrxx8snv3J1kpYRy8PyA8ZLvIToQjgX6qV+XhfXxE4ckn9l
	jiN7gyCz+wgunTUIEWo2//0BcCYMNS4GNAvWXxo1BRJerMpANK0zGd+j3yiQ2+JXCOS3lERYsHCI5
	XAeW7dT/RmmYVPH7mLftRUBhOqmYSf3wayg8aYrsKzFKErpvUS4QhOuMKQnIJVc3wsuHI5SCTx+LF
	a0s1hgScMw6LbhRxyieSVfununhxtxgeJ5U0G7R1BF0Xgq2MRGeJB9jKQqrwbJo4ml0/4sypC8mIj
	y1M9atUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opTqt-00BeiM-47; Mon, 31 Oct 2022 12:25:15 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opTqH-00BeFN-53
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 12:24:39 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221031122428euoutp02e1efa4a06cc07d1ddc0313b0325ae8db~jJujKAebW2816628166euoutp02V;
	Mon, 31 Oct 2022 12:24:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221031122428euoutp02e1efa4a06cc07d1ddc0313b0325ae8db~jJujKAebW2816628166euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1667219068;
	bh=lZBDofiGeERTN7kLLngjdEdLDDWfSu8/tUBcLnEsN1M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=LaRVzC//+gOqVSUli9L1WgD5HLrxoib3SwLcbeYGo2G0GMe3qUtibfL3k1x66+8VK
	 3LF9BeYOH4kuw5i+mQ9UtR3GSuSb1TZJf4sNLInBg66lZ20tmkLtvGznAItaVA8eGP
	 Ou7s9+258T7nrhOt0qgTkGs9e7PksiaV65Q1aW2g=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221031122428eucas1p2c09f1813aaec47d7916b08d7d6557760~jJui6ncT62848228482eucas1p2C;
	Mon, 31 Oct 2022 12:24:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 75.8F.07817.B7EBF536; Mon, 31
	Oct 2022 12:24:27 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221031122427eucas1p11a8ef4c6d2bc626168c280bcbca64643~jJuidWxfU1292912929eucas1p1q;
	Mon, 31 Oct 2022 12:24:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221031122427eusmtrp24972854141c15f1c4283b1ca47cc48a1~jJuicsDbG2606826068eusmtrp2a;
	Mon, 31 Oct 2022 12:24:27 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-0a-635fbe7b830d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id C2.C9.10862.B7EBF536; Mon, 31
	Oct 2022 12:24:27 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221031122427eusmtip1f2842a549b3d93e7c030cab227d2f4ef~jJuiS68EX3072530725eusmtip1L;
	Mon, 31 Oct 2022 12:24:27 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 31 Oct 2022 12:24:25 +0000
Date: Mon, 31 Oct 2022 13:24:20 +0100
From: Joel Granados <j.granados@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: <sagi@grimberg.me>, <hch@lst.de>, <linux-nvme@lists.infradead.org>,
	<gost.dev@samsung.com>, <joshi.k@samsung.com>, <javier.gonz@samsung.com>,
	<p.raghav@samsung.com>
Subject: Re: [RFC 3/3] nvme : Add ioctl to query nvme attributes
Message-ID: <20221031122420.t7u6o73g2bjltot5@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="2bajdyctt4htuxyb"
Content-Disposition: inline
In-Reply-To: <Y1wByyGo6FS/6hmd@kbusch-mbp.dhcp.thefacebook.com>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87rV++KTDXa8tbJYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRXDYpqTmZZalF+nYJXBn3enYy
	FZyRrDj4/gNjA+Ns0S5GTg4JAROJS09mMnYxcnEICaxglPi58jQ7hPOFUWLF82NMEM5nRonP
	iw8DZTjAWn5sy4aIL2eUePPlCiNcUfv8FlaQuUICWxgltj6vAbFZBFQl2o++YwSx2QR0JM6/
	ucMMYosIKEvcnT+TFaSZWWANo0Rr91omkISwgIPEhe+bwRp4BcwlHq3ezgRhC0qcnPmEBcRm
	FqiQOH/mCBPIRcwC0hLL/3GAhDkF7CVenNjNAvGbksTXN72sEHatxKktt8C+kRBo5pSYdmwu
	C8Q3LhIv32ZB1AhLvDq+hR3ClpH4v3M+E4SdLbFzyi5mCLtAYtbJqWwQrdYSfWdyIMKOEue2
	HGKECPNJ3HgrCHEkn8SkbdOZIcK8Eh1tQhDVahI7mrYyTmBUnoXkrVlI3pqF8BZEWEdiwe5P
	bBjC2hLLFr5mhrBtJdate8+ygJF9FaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmByOv3v
	+JcdjMtffdQ7xMjEwXiIUQWo+dGG1RcYpVjy8vNSlUR4689GJwvxpiRWVqUW5ccXleakFh9i
	lOZgURLnZZuhlSwkkJ5YkpqdmlqQWgSTZeLglGpgqv0heWTTsZb8PY/+TOO2/s+1bnvheRfP
	jYnR7x1NV81mzNtmkKCuPve84tl1fYWJs/Y2twsLL7Oa3GqZXrZk//0ra4511LO8Omb8x+Gb
	utuBw1tdws8t8Og683yfjNiUOUYtgeK2FeXvxAJXTO3ujLz51eXdhrdmQq110R+aHE6mqXKr
	1UneaztoVbX9m2jBPbGNnhk9Gb1Ch0Kn6MtvcXhZFxLrXbl9wid1Xvtal02qbs37FuVdq1Nc
	WsTXwVVg+vcP7225/SF970wrn4Xsu80kpPbG99u6Hs3iXV/EZhftv71+fWOoUX3cBtUGzWfP
	w/vfF6a0vWq8+4qr+knxSW+Xnft2LLKZHHFa2fK9EktxRqKhFnNRcSIAok0IHskDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7rV++KTDRZ9lrNYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRejZF+aUlqQoZ+cUltkrRhhZG
	eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlT9p9kKzglWXFg6ymWBsaZol2MHBwS
	AiYSP7ZldzFycQgJLGWUWNX4jqWLkRMoLiPx6cpHdghbWOLPtS42iKKPjBJvPnUzQThbGCU6
	v8xkAqliEVCVaD/6jhHEZhPQkTj/5g4ziC0ioCxxd/5MVpAGZoE1jBKt3WvBGoQFHCQufN8M
	1sArYC7xaPV2sLiQwAFmiTMTSyHighInZz4BO4lZoExidddNdpCzmQWkJZb/4wAJcwrYS7w4
	sRvqaiWJr296WSHsWonPf58xTmAUnoVk0iwkk2YhTIIIa0nc+PeSCUNYW2LZwtfMELatxLp1
	71kWMLKvYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzUbcd+btnBuPLVR71DjEwcjIcYVYA6
	H21YfYFRiiUvPy9VSYS3/mx0shBvSmJlVWpRfnxRaU5q8SFGU2AoTmSWEk3OB6aQvJJ4QzMD
	U0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGJsYTBiXv1lj+lLtSeUxMmbV+
	MZNa9d/G/996Mz4vuLfhqZLS98Ssx69e9l5/UH3s4NH3txca8nn0a3TW1inerMu1fRh0O4nj
	5Z/Dknc279mf9GLHCoX9K9pXqa844xjGd4qpUP8kG6Pc310Wsq+Sy2d8NBO/brHjdQJX2O78
	2wavj228UC/qxfDvtUlu2aZ9Z2UquQMPuG2brX344j3+6kszZ/yTfXhp4qt91tGFLeuZsn9f
	nT4/+/z202fuP7Jlmn7r2qb1kq8l/N80xUjcPJv24uPjgk06K55ezFc+Yafbl31ZxnlvSM/p
	hSlBOwy+nODp+jl9/h2/98c7WHaXbIzVjGHsXXCZvdbanO+Yy+v1SizFGYmGWsxFxYkAyaJh
	tGkDAAA=
X-CMS-MailID: 20221031122427eucas1p11a8ef4c6d2bc626168c280bcbca64643
X-Msg-Generator: CA
X-RootMTR: 20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab
References: <20221027155724.1161670-1-j.granados@samsung.com>
	<CGME20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab@eucas1p2.samsung.com>
	<20221027155724.1161670-4-j.granados@samsung.com>
	<Y1q4Cjg1cv9w+YWR@kbusch-mbp.dhcp.thefacebook.com>
	<20221028103827.o7uhl36qavkpx22d@localhost>
	<Y1vskd0uY308uSf4@kbusch-mbp.dhcp.thefacebook.com>
	<20221028155230.cf2iktk6ut3qbzns@localhost>
	<Y1wByyGo6FS/6hmd@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_052437_840765_58E64D74 
X-CRM114-Status: GOOD (  28.83  )
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

--2bajdyctt4htuxyb
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 10:22:35AM -0600, Keith Busch wrote:
> On Fri, Oct 28, 2022 at 05:52:30PM +0200, Joel Granados wrote:
> > On Fri, Oct 28, 2022 at 08:52:01AM -0600, Keith Busch wrote:
> > > On Fri, Oct 28, 2022 at 12:38:27PM +0200, Joel Granados wrote:
> > > > 3. And the variables that are not in struct nvme_ctrl. Here, we hav=
e not
> > > >    option but to make an IO.
> > >=20
> > > You do have another option: we have historically added new fields to
> > > nvme_ctrl to cache parameters that are repeatedly referenced in other
> > > contexts, and this usage appears to qualify.
> >=20
> > Agreed. That is yet another option. Will do that for my V1.
> > Thx for the feedback
>=20
> Just for the record, I don't really like this approach, but I don't have
> a better suggestion right now other than opening up the admin queue or
> exporting a ton of sysfs attributes (and each carry a different set of
> concerns..).
>=20
> My concern here is that drives implementing new specs may have new
> constraints that applications need to know, but older kernels won't
> accomodate. You are handling this by error'ing out the query, so it
> relies on the application implementing a sane fallback (assuming such a
> fallback for future attributes even exists). This just does not feel
> very future-proof.

There might be an additional route to handle the case where the user has
new kernel headers and is running the ioctl on an older kernel: We can
use copy_struct_from_user f5a1a536fa14 ("lib: introduce
copy_struct_from_user() helper").
In summary it has a clear behavior/assumptions for the three possible
cases:
1. When kernel and user space have the same header version it just
   copies the struct.
2. When the kernel has a higher version of the struct, it only copies
   what the user space requested in argsz.
3. When user has an old kernel (The case that you are worried about) it
   will only fill up the members that the kernel knows about provided
   that members that are not contained in the kernel struct are zeroed
   out.

What do you think?

I did not implement this at the outset because I was wanting to avoid
the additional call to copy_struct_from_user. But if this provides a
suitable solution for you case, then it is trivial to include it in the
patch.

Best

Joel



--2bajdyctt4htuxyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmNfvmkACgkQupfNUreW
QU8CTgv/WdU2t4PZFBtDAei86DAwKLSXhoeCltavK8oW3J/qQC8S+I8ygrpN8CEp
95navI7DAaG49dl8ZIJAu+J++Gpt5id7n5KdNHpXU3WngzyggX/viGyPd2FwVR2Q
Kv3wqXXqJPv/B5K1gLsaHid0vGhmKNkNcYxW3KM41xDx77NLb1zCj8oEEjncVIii
rhmvUJ7fPiuuXgCt+8anuGGotjebhyIKwkzwHh64ayxlsd1nwcKR1UVM4FAtOIlH
0TWhy6Hk1DZKmi7vBhyVt8E7skXUxGJI8+sMnERBqaRaMEmk5uzTHR0EddnpESju
bGwQuHWOCNYuzGZb1EDcrKvWmHyenA5EUBICM5eTKZtVooKnCfxN2AmKSE8DkkWw
WG+hUenxfMTlH7dgNEtutYJze4Nyj/mg+tXcc8fU2LGvVIu+57PkdqQOd6Cp9UVE
3PkA6jP0s/CtCcuMpHYw+fe0Yq84WpcaNKIA0I+UcNQEVM8OhqlHBGU+Y+Lm6ede
Xzy56jlP
=eCz6
-----END PGP SIGNATURE-----

--2bajdyctt4htuxyb--

