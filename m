Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247EFFA3741
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K6XBr7PArzrxYPDufq61ekYBuy1sUqqUbo3XxbZQNbE=; b=WYZZ3wpahtd+Nw4rZ+2eRh9sW8
	ni61tTHu2ageUgvAIgeIqtB9tv2r57GVas7Gmk1J5tCz8reju0aeODJyNlriAjLYkBLjQcrFVAIQ8
	7smMGEdgYbb6BKElpmzby2Z0Ivg9nusa/17RR17N/QA7WcFLV9puV6aKATUMo8IjMHxi0YeY33WPd
	8ig8KfWZJgwwFdtCQCj3AyBvR9+akgEJ7YwiviJ7BmM7BG4SLY6NJotXAQrsTRu8wc0P+42JTfjWc
	tpBx+SW0uQSsdfaoUjDwoi6l8M12KbR+1G7AEV2S/qaWbE10sqCCercejGWB8bxeYNqfBq69MIS6m
	yO53J4+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooMlA-00GiVJ-LP; Fri, 28 Oct 2022 10:38:44 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooMl7-00GiRj-HK
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 10:38:44 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221028103833euoutp0181a94b96088872d41f4b84f48978e856~iNWN3c2dm0605906059euoutp01x;
	Fri, 28 Oct 2022 10:38:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221028103833euoutp0181a94b96088872d41f4b84f48978e856~iNWN3c2dm0605906059euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1666953513;
	bh=K6XBr7PArzrxYPDufq61ekYBuy1sUqqUbo3XxbZQNbE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=b+p8xZlHkW8m1VVDzeADXVnkxLsG7d6bQRjBC4PdwZjlgqT8knPgFcxyXJAAzywj1
	 5tLjKvZ76BeJ4b8NXSS97dm2/ZZWzm27R4h5qKFT1BzHzs2INHR+/g+KnSoUMBA2sT
	 jQb+MGrAue1yTr58y/MVucVZp6VyHewsXZwaQKxc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221028103833eucas1p10576bf841b1cc1a8f719f307a81ab721~iNWNrP67s3062630626eucas1p1g;
	Fri, 28 Oct 2022 10:38:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id D0.38.19378.921BB536; Fri, 28
	Oct 2022 11:38:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221028103832eucas1p2c6ada7c4e552c0abd2dbccdf51395c82~iNWNNKtsQ1495914959eucas1p2x;
	Fri, 28 Oct 2022 10:38:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221028103832eusmtrp24e726b7ba73bf707fe628ec3bdd0129d~iNWNKpJ_E2409424094eusmtrp2z;
	Fri, 28 Oct 2022 10:38:32 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-b5-635bb1299802
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 20.23.07473.821BB536; Fri, 28
	Oct 2022 11:38:32 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221028103832eusmtip12fb7da8003b9a2a97be6068331091552~iNWNAZNbY0673706737eusmtip16;
	Fri, 28 Oct 2022 10:38:32 +0000 (GMT)
Received: from localhost (106.210.248.238) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 28 Oct 2022 11:38:29 +0100
Date: Fri, 28 Oct 2022 12:38:27 +0200
From: Joel Granados <j.granados@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: <sagi@grimberg.me>, <hch@lst.de>, <linux-nvme@lists.infradead.org>,
	<gost.dev@samsung.com>, <joshi.k@samsung.com>, <javier.gonz@samsung.com>,
	<p.raghav@samsung.com>
Subject: Re: [RFC 3/3] nvme : Add ioctl to query nvme attributes
Message-ID: <20221028103827.o7uhl36qavkpx22d@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="ge3rib6di5jifv3n"
Content-Disposition: inline
In-Reply-To: <Y1q4Cjg1cv9w+YWR@kbusch-mbp.dhcp.thefacebook.com>
X-Originating-IP: [106.210.248.238]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djPc7qaG6OTDSas47BYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRXDYpqTmZZalF+nYJXBnL9j5j
	KTisW/FgxUqWBsbZKl2MnBwSAiYSW19uY+xi5OIQEljBKPHl8AZmCOcLo8SSxefYQaqEBD4z
	SrxfGtnFyAHWcfBWGETNckaJ/l9LoRqAah4uamGFcLYySpybe5EJpJtFQFVi7buFrCA2m4CO
	xPk3d5hBbBEBZYm782eCNTALrGGUaO1eC9YgLOAgceH7ZkYQm1fAXOLZs6VQtqDEyZlPWEBs
	ZoEKid03X7CBnMQsIC2x/B8HSJhTwF7iRkMrK8SlyhKnn3pCvFkrcWrLLSaQVRICzZwSZ1f/
	YoNIuEjsOXGTGcIWlnh1fAs7hC0j8X/nfCYIO1ti55RdUDUFErNOTmWDmG8t0XcmByLsKHFu
	yyFGiDCfxI23ghBH8klM2jadGSLMK9HRJgRRrSaxo2kr4wRG5VlI3pqF5K1ZCG9BhHUkFuz+
	hCmsLbFs4WtmCNtWYt269ywLGNlXMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn525iBCan0/+O
	f93BuOLVR71DjEwcjIcYVYCaH21YfYFRiiUvPy9VSYT37I3wZCHelMTKqtSi/Pii0pzU4kOM
	0hwsSuK8bDO0koUE0hNLUrNTUwtSi2CyTBycUg1MeY6/luTwu79fpPrpibN9dfnHhn2/FrlF
	n9c7meXzIHudrE+JSFaH67a84mPtfXL1rG4RBuwJEetWlGzcHJdzS3+afm+u5vfXLX/do/tj
	bOPXF17RSX1hI2vlrSDlZpvDIlhzZWHTVp8XS1ZxXv35maNBoLOY2+RoV9EGvaALZr5LaldU
	Pnus7eAVnMzPpHBpbVveQ+UDIafln0tvdrA+1fST/eSvL085pfuSrx5PjE2PSX0e3Pyv9l68
	x/rOW3mvFtX8XdDDcXBW3OJln9Yt4FTYan2X6UtFSOwuuUQdJs7iMOcFqR9/bWZrO7rmd6gu
	W9ivXRsf9ITF1RUuNuHnOB26vvCtR0cCq/tjUSWW4oxEQy3mouJEACUUSNjJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7oaG6OTDV7cULZYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRejZF+aUlqQoZ+cUltkrRhhZG
	eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmnXx9mKzioW3Fh3nfGBsaZKl2MHBwS
	AiYSB2+FdTFycggJLGWUmPCfDcSWEJCR+HTlIzuELSzx51oXG0TNR0aJ7VNTuhi5gOytQPVz
	3rKAJFgEVCXWvlvICmKzCehInH9zhxnEFhFQlrg7fyYrSAOzwBpGidbutUwgCWEBB4kL3zcz
	gti8AuYSz54tZYTY8ItRYt7OJIi4oMTJmU/AFjALlEk83/KVBeRoZgFpieX/OEDCnAL2Ejca
	WlkhflGWOP3UE+LmWonPf58xTmAUnoVk0Cwkg2YhDIIIa0nc+PeSCUNYW2LZwtfMELatxLp1
	71kWMLKvYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzRbcd+bt7BOO/VR71DjEwcjIcYVYA6
	H21YfYFRiiUvPy9VSYT37I3wZCHelMTKqtSi/Pii0pzU4kOMpsBAnMgsJZqcD0weeSXxhmYG
	poYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTFoLkr5PlZ61SE29KPSk9aOn
	+06Vs25gVAhuvsVulvR5urP59e0fTl3/o17z0lPgYK/RN9Yr3ZN0X8+9uesqQ/6XHTHly5Xm
	XWiJy+Axv+pyWzCwSiZ5Z9bxqBlPCvfKPT/pU/pU455ODDObX9V0hp27TkwKuaW1u6/Tpcj1
	0KLFd4VPTrzizcK8Ir1xnYuv5u+C0HPcL32dig99q36y7ndIYZuH75lOzglTPP9Ur6sV0Pq4
	LYOn5N2+V5Jhv9zjWw89brcRnXm2p+OIzJnSd3v+PDrzcOYy4Rc5T+pvJPKs5LYU4jvus+HA
	/Feb8/x1O56t7BC6sfMeQ0OISwXP0junws/cbFomZSRbyuZ/yVeJpTgj0VCLuag4EQCN7aw1
	ZgMAAA==
X-CMS-MailID: 20221028103832eucas1p2c6ada7c4e552c0abd2dbccdf51395c82
X-Msg-Generator: CA
X-RootMTR: 20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab
References: <20221027155724.1161670-1-j.granados@samsung.com>
	<CGME20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab@eucas1p2.samsung.com>
	<20221027155724.1161670-4-j.granados@samsung.com>
	<Y1q4Cjg1cv9w+YWR@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_033841_893080_002C3057 
X-CRM114-Status: GOOD (  24.34  )
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

--ge3rib6di5jifv3n
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 27, 2022 at 10:55:38AM -0600, Keith Busch wrote:
> On Thu, Oct 27, 2022 at 05:57:24PM +0200, Joel Granados wrote:
> > +{
> > +	int ret;
> > +	struct nvme_id_ctrl *id_ctrl;
> > +	struct nvme_get_attr nvme_get_attr =3D {0};
> > +	struct nvme_id_ctrl_nvm *id_ctrl_nvm;
> > +	__u32 usize;
> > +
> > +	BUILD_BUG_ON(sizeof(struct nvme_get_attr) < NVME_IOCTL_GET_ATTR_V0SZ);
> > +	BUILD_BUG_ON(sizeof(struct nvme_get_attr) !=3D NVME_IOCTL_GET_ATTR_CU=
RSZ);
> > +
> > +	if (copy_from_user(&nvme_get_attr, arg, 2 * sizeof(__u32)))
> > +		return -EFAULT;
> > +
> > +	if (nvme_get_attr.flags !=3D 0)
> > +		return -EINVAL;
> > +
> > +	switch (nvme_get_attr.argsz) {
> > +	case NVME_IOCTL_GET_ATTR_V0SZ:
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	usize =3D nvme_get_attr.argsz;
> > +
> > +	ret =3D nvme_identify_ctrl(ctrl, &id_ctrl);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D nvme_identify_cs_ctrl(ctrl, &id_ctrl_nvm);
> > +	if (ret)
> > +		return ret;
> > +
> > +	nvme_get_attr.argsz =3D NVME_IOCTL_GET_ATTR_CURSZ;
> > +	nvme_get_attr.mpsmin =3D NVME_CAP_MPSMIN(ctrl->cap);
> > +	nvme_get_attr.vsl =3D id_ctrl_nvm->vsl;
> > +	nvme_get_attr.wzsl =3D id_ctrl_nvm->wzsl;
> > +	nvme_get_attr.wusl =3D id_ctrl_nvm->wusl;
> > +	nvme_get_attr.dmrl =3D id_ctrl_nvm->dmrl;
> > +	nvme_get_attr.dmsl =3D id_ctrl_nvm->dmsl;
> > +	nvme_get_attr.dmrsl =3D id_ctrl_nvm->dmrsl;
> > +	nvme_get_attr.oncs =3D id_ctrl->oncs;
> > +	nvme_get_attr.mdts =3D id_ctrl->mdts;
>=20
> You already have the 'struct nvme_ctrl' that saves nearly all these
> values. We shouldn't need to send new IO when you can just reference the
> cached values instead.

There are three types of variables here:
1. The variables that are adjusted from what the device actually
   returns. Like wzsl that is in max_zeroes_sectors but is already
   adjusted with MSPMIN. Here we can de-adjust them if we want to save
   an IO call
2. The variables that are not adjusted and are the same in struct
   nvme_ctrl in the device. Here we can just use the ctrl member.
3. And the variables that are not in struct nvme_ctrl. Here, we have not
   option but to make an IO.


> > +	nvme_get_attr.vsl =3D id_ctrl_nvm->vsl;
Not in ctrl (type 3)

> > +	nvme_get_attr.wzsl =3D id_ctrl_nvm->wzsl;
Exported as ctrl->max_zeroes_sector and adjusted with MPSMIN (type 1)

> > +	nvme_get_attr.wusl =3D id_ctrl_nvm->wusl;
Not in ctrl (type 3)

> > +	nvme_get_attr.dmrl =3D id_ctrl_nvm->dmrl;
In ctrl->max_discard_segments (type 2)

> > +	nvme_get_attr.dmsl =3D id_ctrl_nvm->dmsl;
Not in ctrl (type 3)

> > +	nvme_get_attr.dmrsl =3D id_ctrl_nvm->dmrsl;
In ctrl->dmrsl (type 2)

> > +	nvme_get_attr.oncs =3D id_ctrl->oncs;
In ctrl->oncs (type 2)

> > +	nvme_get_attr.mdts =3D id_ctrl->mdts;
Exported as ctrl->max_hw_sectors and adjusted with MPSMIN (type1)


So I see 3 members in struct id_ctrl_nvm that are not contained in
struct nvme_ctrl, therefore we need an IO to populate these.

To save an IO for the 2 last members (oncs and mdts), then I'll
de-adjust mdts and leave oncs as it is in nvme_ctrl.


>
>=20
> > +struct nvme_get_attr {
> > +	__u32	argsz;
> > +	__u32	flags;
> > +
> > +	/*
> > +	 * Memory Page Size MINimum : The host should not configure a page si=
ze that
> > +	 * is larger than (2 ^ (12 + mpsmin)). Comes from [3]
> > +	 */
> > +	__u32	mpsmin;
> > +
> > +	/*
> > +	 * Verify Size Limit : Recommended or supported data size for a verify
> > +	 * command. From [2].
> > +	 */
> > +	__u8	vsl;
> > +
> > +	/*
> > +	 * Write Zeroes Size Limit : Recommended or supported data size for a
> > +	 * zeroes command. From [2].
> > +	 */
> > +	__u8	wzsl;
> > +
> > +	/*
> > +	 * Write Uncorrected Size Limit : Recommended or supported data size =
for
> > +	 * an uncorrected command. From [2].
> > +	 */
> > +	__u8	wusl;
> > +
> > +	/*
> > +	 * Dataset Management Ranges Limit : Recommended or supported maximum
> > +	 * number of logical block ranges for the Dataset Management Command.
> > +	 * From [2].
> > +	 */
> > +	__u8	dmrl;
> > +
> > +	/*
> > +	 * Dataset Management Size Limit : Recommended or supported maximum of
> > +	 * total number of logical blocks for a Dataset Management Command.
> > +	 * From [2].
> > +	 */
> > +	__le64	dmsl;
> > +
> > +	/*
> > +	 * Dataset Management Range Size Limit : Recommended or supported max=
imum
> > +	 * number of logical blocks in a range of a Dataset Management Comman=
d.
> > +	 * From [2].
> > +	 */
> > +	__le32	dmrsl;
> > +
> > +	/*
> > +	 * Optional NVM Command Support. Is needed to make sense of attributes
> > +	 * like vsl, wzsl, wusl... Comes from [1].
> > +	 */
> > +	__le16	oncs;
>=20
> Don't use the little-endian format for values that are not going over
> the wire.

oops. That is mistake. thx

--ge3rib6di5jifv3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmNbsRIACgkQupfNUreW
QU/JawwAkDZ+TVYNzQuHIR6D5OEfXtK//tUQyseFCYTf7lkau4m823NhZAQ/GNJT
W1T0GSqJVWk13wA0oDN0KWxtEmomI96aNnMq2s9HWB0UaTGj9Bh13+sZtlp87RZy
gBEQtEYgvwES/LLFcHMCDuo69urevRXObKQ67XB8c69LxwzpID5dRQHH9VnSHiSH
lW192Y1nGzZYmxKVi0OSywUSZxZYj0ZuuqZ9gHacWH0IxjZT2prFYsegPZF5m+LC
zf9kTz9IKyclygHApV6JfG4Fc5gC/x6wm7WylxF2Ya3qARn6HA5EeaJKltDoZYtO
zvXnysQgyQ4yJCnwBSoDGgBk+kgyCJjk/+ZvxP91Q0Ald/1P5NiODhhmrkCV8TPh
3AQzEu/u6PtvEOKMt5PRCCwoWG6JLj08OA/yDIF/h+8Ab8NmBra4qoY9rO2feAR6
5yrKSIWlQVCoQhZuHuzqZy2+Ks0ij4YovHmxSTDCu0HorkZ/RGrE7NX+OSYzMcou
keCJjPED
=YQU5
-----END PGP SIGNATURE-----

--ge3rib6di5jifv3n--

