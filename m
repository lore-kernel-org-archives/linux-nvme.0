Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B82C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 22:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ul3T/8sHZLTePXLLUnOYP3zQAzX4ApaF1IY/QaLLFFc=; b=Tx/iKXKHZnIX/xWR1y/tiawgEy
	kjKl+PVcb/OWZxN1XhgmhqpTbrj8PTKLiYCHGrFtpqymDgG2rvQvkLhYHGQaloS7VCTe2LZPEdwHh
	3XgUGxKBDNdUI7A9cySIp3RjS2NUlGMvnuIsArcrW+VDvn4/Ws4HtbIR+0xfCqSxo0VJde1lfM53j
	j7zG8+gztk3oyIggvbggK5qEtuzUTaLahK+sF0YdJcY/SdMbpi8cVZl0Hyj1uWBMv6GuGsguOhee2
	y6nrPXaNtsnQ+YlYK/evg/FfTfbuS6cg01gxY+AG5AKn+d6DasyXalyWTC7q3zcMYi48FuvRcPCcv
	4N12dn4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osWj8-008gz6-Iy; Tue, 08 Nov 2022 22:05:50 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osWj1-008gyI-4O
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 22:05:46 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221108220533euoutp026e4511eefaf5647bf3ff3282124c68cc~lu0LzNZdg0660906609euoutp029;
	Tue,  8 Nov 2022 22:05:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221108220533euoutp026e4511eefaf5647bf3ff3282124c68cc~lu0LzNZdg0660906609euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1667945133;
	bh=ul3T/8sHZLTePXLLUnOYP3zQAzX4ApaF1IY/QaLLFFc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ZEvGlPnql608DVxpvXkkkUrlu2C66xs22rgdo/qK/KQGb+VWIm9bKGRn8f/qAd8ST
	 1RICijsBQ7oJxoll/57TbmKBu71MiD2l4KJrLr1SCh7ZBBfwn2RFV/TyiZxzYOTM/t
	 MqQ5nxjN3KjewImS6CIbmobrdjinJMCMcaWvuhtE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221108220532eucas1p1ed3c3c23191186a2e66bfd17c8b22bd1~lu0K9bJ7z0222502225eucas1p1g;
	Tue,  8 Nov 2022 22:05:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 17.5F.10112.CA2DA636; Tue,  8
	Nov 2022 22:05:32 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221108220531eucas1p2d50e1ae347a95d8f9b3c5af09991c967~lu0KLQ0so2990029900eucas1p2W;
	Tue,  8 Nov 2022 22:05:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221108220531eusmtrp29f4a1c5493229b867439f10782953b54~lu0KKu99T1241112411eusmtrp24;
	Tue,  8 Nov 2022 22:05:31 +0000 (GMT)
X-AuditID: cbfec7f4-cf3ff70000002780-18-636ad2ace842
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id A7.EE.08916.BA2DA636; Tue,  8
	Nov 2022 22:05:31 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221108220531eusmtip25e075de186665f1a3e1979e83c254dcf~lu0J9UjYW2933829338eusmtip2K;
	Tue,  8 Nov 2022 22:05:31 +0000 (GMT)
Received: from localhost (106.210.248.210) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 8 Nov 2022 22:05:30 +0000
Date: Tue, 8 Nov 2022 23:05:29 +0100
From: Joel Granados <j.granados@samsung.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "gost.dev@samsung.com" <gost.dev@samsung.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de"
	<hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvme : Add ioctl to query nvme attributes
Message-ID: <20221108220529.ma5l45p6l6snoz6n@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="lp6yzrbnpe7kdwww"
Content-Disposition: inline
In-Reply-To: <9a55bbf8-1c38-3302-97be-376a3f2ec180@nvidia.com>
X-Originating-IP: [106.210.248.210]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djP87prLmUlGyy9zGvx/uBjVouVq48y
	WUw6dI3RYv6yp+wW616/Z3Fg9Th/byOLx6ZVnWwem5fUe+y+2cDm0dv8ji2ANYrLJiU1J7Ms
	tUjfLoErY/O1P8wFbXoVs3ctZGxgfKTaxcjJISFgIjGh+SAziC0ksIJRYtProi5GLiD7C6PE
	7y0rGSGcz4wSh1fNZIPpePDvGzNEYjmjxMr389nhqrZuvQ7VsoVRYt2/l+wgLSwCKhJz5zYz
	gthsAjoS59/cAVsoIqAncfXWDbBuZoGnjBKb524DaxAWcJLofXIArIFXwFyid88MJghbUOLk
	zCcsIDazQIXE7BUzgeIcQLa0xPJ/HCBhTgE7iR2/frKAhCUElCVOPOaAuLpW4tSWW0wgqyQE
	ujklzh2+xwyRcJG439XCBGELS7w6voUdwpaR+L9zPlQ8W2LnlF1Q9QUSs05OZYOYby3RdyYH
	Iuwo8XbVW6i1fBI33gpCHMknMWnbdGaIMK9ER5sQRLWaxI6mrYwTGJVnIXlrFpK3ZiG8BRHW
	kViw+xMbhrC2xLKFr5khbFuJdevesyxgZF/FKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kR
	mLJO/zv+ZQfj8lcf9Q4xMnEwHmJUAWp+tGH1BUYplrz8vFQlEd4167KShXhTEiurUovy44tK
	c1KLDzFKc7AoifOyzdBKFhJITyxJzU5NLUgtgskycXBKNTAFLLwQs8hw7t7+x0F6vxouhQgw
	Bfm+yOk56HeZs6o2dWasEPNzjvXp6/0NM/cYfZu04YM2U9QGb5VLIT57939q2DPpwoXVmndZ
	5/YxPdq6enbrv6OX5MQlpCStJoqZ3WHZV2VhrGdwyi33Vt5dzjmPjM7/Ydq7sHWNZurpG2vt
	dCbxd76faRLV03Yz3DpK8mNHQ/HCF3E8/Xenr2Hf3h91MVTlQ99ZqaBdG6YfLWDet49Hd1lV
	TUWIskTyyVNvkhikpsz4tN8mOq4oeZpfOpdxeuFS2x/71b6GbXzxX1k17oj9gqec3V47/yxW
	ltJl+fFBquGaG+vp9S8WzU/dcD2HT1Fk9/S1H9d/Pm9sEmmrxFKckWioxVxUnAgARVz9qNQD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsVy+t/xe7qrL2UlG6xtELN4f/Axq8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGqVnU5RfWpKq
	kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX0f5pFmNBi15F/8X4
	BsYHql2MnBwSAiYSD/59Y+5i5OIQEljKKLHnz002iISMxKcrH9khbGGJP9e62CCKPjJKLFi/
	ghXC2cIose/lB0aQKhYBFYm5c5vBbDYBHYnzb+4wg9giAnoSV2/dYAdpYBZ4yiixee42sLHC
	Ak4SvU8OgDXwCphL9O6ZwQQx9SejxNTbDUwQCUGJkzOfsIDYzAJlEgtubAJazQFkS0ss/8cB
	EuYUsJPY8esnC0hYQkBZ4sRjDoirayU+/33GOIFReBaSQbOQDJqFMAgirCVx499LJgxhbYll
	C18zQ9i2EuvWvWdZwMi+ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzB6tx37uXkH47xXH/UO
	MTJxMB5iVAHqfLRh9QVGKZa8/LxUJRHeNeuykoV4UxIrq1KL8uOLSnNSiw8xmgJDcSKzlGhy
	PjCt5JXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MMk3rfHk4NCc
	Klp/5pXKv9o1DTkV7h0XZFfYbHL0exn8Yxl7zC5ep1gbhT3cb+I1NpuEPY9llPyza2vCiVx9
	vbP/U6bWz7zXZrN1vYai5m+2VdlPDGsb7h0TTr915lyJUvXMxAi3K4VCL3JFJ0sI8KVfnRLW
	IuMx71GIgu1G3cZt8q4+p5Y1VbA8v3cu+lNA4sSLE12bj1jvDNxlebVB7mE+11KmNYkPQ+Zr
	Jhywnrti7eODe1lUzHZsbHhROSHxYIrb2kXLDBZMES9i5o3f/OdEcu5m08SA9j2/T3/XLrks
	nBQ+JdzXYf3/raysD/5bF219tobfKsjhEIv2tdWLlv3dy6dxIPyU+yVN54Mu2UosxRmJhlrM
	RcWJAG3lq8BzAwAA
X-CMS-MailID: 20221108220531eucas1p2d50e1ae347a95d8f9b3c5af09991c967
X-Msg-Generator: CA
X-RootMTR: 20221103123121eucas1p1b1919ee3bc9a86d6af56e5e5694e07f2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221103123121eucas1p1b1919ee3bc9a86d6af56e5e5694e07f2
References: <20221103122746.3599480-1-j.granados@samsung.com>
	<CGME20221103123121eucas1p1b1919ee3bc9a86d6af56e5e5694e07f2@eucas1p1.samsung.com>
	<20221103122746.3599480-2-j.granados@samsung.com>
	<9a55bbf8-1c38-3302-97be-376a3f2ec180@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_140543_764335_E39D24E1 
X-CRM114-Status: GOOD (  34.33  )
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

--lp6yzrbnpe7kdwww
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 04:56:21PM +0000, Chaitanya Kulkarni wrote:
> On 11/3/22 05:27, Joel Granados wrote:
> > An ioctl (NVME_IOCTL_GET_ATTR) is added to query nvme controller
> > attributes needed to effectively write to the char device without needi=
ng
> > to be a privileged user.  They are also provided on block devices for
> > convenience. The attributes here are meant to complement what you can
> > already get with the allowed identify commands.
> >=20
> > New members are added to the nvme_ctrl struct: dmsl, vsl and wusl from
> > the I/O Command Set Specific Identify Controller Data Structure in the =
nvme
> > spec.
> >=20
> > We add NVME_IOCTL_GET_ATTR_{V0SZ,CURZS} in order to make the ioctl
> > extensible. These serve as both size and version. The caller is expecte=
d to
> > pass the structure size as the first member of the struct. For example:
> >=20
> > 	{...
> > 	struct nvme_get_attr nvme_get_attr =3D {0};
> > 	nvme_get_attr.argsz =3D sizeof(struct nvme_get_attr);
> > 	...}
> >=20
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > ---
> >   drivers/nvme/host/core.c        |  5 ++-
> >   drivers/nvme/host/ioctl.c       | 57 +++++++++++++++++++++++++
> >   drivers/nvme/host/nvme.h        | 11 +++++
> >   include/uapi/linux/nvme_ioctl.h | 74 +++++++++++++++++++++++++++++++++
> >   4 files changed, 146 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 0090dc0b3ae6..267f28592b9d 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3062,9 +3062,12 @@ static int nvme_init_non_mdts_limits(struct nvme=
_ctrl *ctrl)
> >  =20
> >   	if (id->dmrl)
> >   		ctrl->max_discard_segments =3D id->dmrl;
> > -	ctrl->dmrsl =3D le32_to_cpu(id->dmrsl);
> >   	if (id->wzsl)
> >   		ctrl->max_zeroes_sectors =3D nvme_mps_to_sectors(ctrl, id->wzsl);
> > +	ctrl->dmrsl =3D le32_to_cpu(id->dmrsl);
> > +	ctrl->dmsl =3D le64_to_cpu(id->dmsl);
> > +	ctrl->vsl =3D id->vsl;
> > +	ctrl->wusl =3D id->wusl;
> >  =20
> >   free_data:
> >   	kfree(id);
> > diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> > index 9273db147872..2197a2b7ab56 100644
> > --- a/drivers/nvme/host/ioctl.c
> > +++ b/drivers/nvme/host/ioctl.c
> > @@ -53,6 +53,57 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrva=
l)
> >   	return (void __user *)ptrval;
> >   }
> >  =20
> > +static inline u32 nvme_sectors_to_mps(struct nvme_ctrl *ctrl, u32 unit)
> > +{
> > +	return ilog2(unit) + 9 - 12 - NVME_CAP_MPSMIN(ctrl->cap);
> > +}
> > +
> > +static int nvme_ctrl_export_attrs(struct nvme_ctrl *ctrl,
> > +				  struct nvme_get_attr __user *arg)
> > +{
> > +	struct nvme_get_attr nvme_get_attr =3D {0};
> > +	__u32 usize, retsize;
> > +	int ret;
> > +
> > +	BUILD_BUG_ON(sizeof(struct nvme_get_attr) < NVME_IOCTL_GET_ATTR_V0SZ);
> > +	BUILD_BUG_ON(sizeof(struct nvme_get_attr) !=3D NVME_IOCTL_GET_ATTR_CU=
RSZ);
> > +
>=20
> Is there a common helper function where al the sizes validated ?
> if so please move it there ....
I have not seen one. But will look again in case I have missed it.
I know that openat2 does not use a helper function. might be a good idea
to create one.

>=20
> > +	if (copy_from_user(&nvme_get_attr, arg, 2 * sizeof(__u32)))
> > +		return -EFAULT;
> > +
> > +	if (nvme_get_attr.flags !=3D 0)
> > +		return -EINVAL;
> > +
> > +	if (nvme_get_attr.argsz < NVME_IOCTL_GET_ATTR_V0SZ)
> > +		return -EINVAL;
> > +	usize =3D nvme_get_attr.argsz;
> > +
> > +	// Enforce backwards compatibility
>=20
> /**/ style comments only ...

Thx
>=20
> > +	ret =3D copy_struct_from_user(&nvme_get_attr, NVME_IOCTL_GET_ATTR_CUR=
SZ, arg, usize);
>=20
> overly long line ?
Does not appear in check-patch, but can shorten it just the same.

>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	nvme_get_attr.argsz =3D NVME_IOCTL_GET_ATTR_CURSZ;
> > +	nvme_get_attr.mpsmin =3D NVME_CAP_MPSMIN(ctrl->cap);
> > +	nvme_get_attr.vsl =3D ctrl->vsl;
> > +	nvme_get_attr.wusl =3D ctrl->wusl;
> > +	nvme_get_attr.dmrl =3D ctrl->max_discard_segments;
> > +	nvme_get_attr.dmsl =3D ctrl->dmsl;
> > +	nvme_get_attr.dmrsl =3D ctrl->dmrsl;
> > +	nvme_get_attr.oncs =3D ctrl->oncs;
> > +	if (ctrl->max_zeroes_sectors > 0)
> > +		nvme_get_attr.wzsl =3D nvme_sectors_to_mps(ctrl, ctrl->max_zeroes_se=
ctors);
> > +	if (ctrl->max_hw_sectors > 0)
> > +		nvme_get_attr.mdts =3D nvme_sectors_to_mps(ctrl, ctrl->max_hw_sector=
s);
> > +
> > +	retsize =3D min(usize, NVME_IOCTL_GET_ATTR_CURSZ);
> > +	if (copy_to_user((struct nvme_get_attr __user *)arg, &nvme_get_attr,
> > +			 retsize))
>=20
> normal function style is
>=20
> ret =3D function_call();
> if(ret)
> 	return ret;

Thx. for the feedback. Will add all these to the next version.
>=20
>=20
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
>=20
> -ck
>=20
>=20

--lp6yzrbnpe7kdwww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmNq0qYACgkQupfNUreW
QU+JQwv/WmhDDiDY6rJ+dC+rj9XikJVzAwnljZCsBtGlKtHKcYkwjgRmxKN7jbvg
ac5GAVqfvx4O64afuEIsjgXC2J3JYnkVX9rZFpNNWXZnPCqokNVcWm3O9k5DGIo1
2lI9ZWWj65rn9L64/n04ZT1gQnfVifBV9swSTTCfTUO3ZKrZ4gNEQzxbVATct05p
FtG2JuW0jpSIl5CASFH3V5ZfvRJgDCErEXLrSg8DrZT+iLzregywEx6duHdv7DR4
7GZukmQnE93Al0Y/EFwYwZnBAbhMCkx/F+P5NOUCigZ8Xj28mNChNDX7JiqXaPsr
FGgpY6nkLcnAHE0ZzqJ23Llwy8CYY2oN+AFY1oIyjxg2+loiB+XOe+yg+gO9RbD6
1n2zvCIG1uLjxiEiKDp9Qcmxs4J3VS1A88k/4gHhZA5V8kvGOkMdL4aefu/iVW88
1ovAuKGstMnPRRDT8YcPIdaG6N9ZooCnAkgT9k+qYEsZ2flo5cPO/eIppBFRK/wh
nRznGwLc
=/OqJ
-----END PGP SIGNATURE-----

--lp6yzrbnpe7kdwww--

