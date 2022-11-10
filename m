Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D28C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Nov 2022 09:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SKOQ6pNzDLdGsIOFTLzqTgH+ZFV+aB8p2uSelsbcow4=; b=1uNbb4nKg//PhUyPhG3lIk//NQ
	9hWz9Ecq5vmjJnLk6LGBjYzG6sW8m9KPpBXf5YydpfqHDby8xYl/dRNeX/+V8jd+Z54nq4z6J7wQ8
	/rQoXQ0HkQKfpIv6BSovljYL4p3wj9oZ0iif9m9hEX8vGv1CVQI4qr8CuxvoGmN4ZH35uVTYPocM+
	bi23RQ28LX1oEGfH3wjaBFdx3I+3dTTMfT8ohcghIhFSWWtnfkac3ukeIKqU10kxYJLNBF2bbkO+J
	6t5nZSSWAloa6u/QKVy+gMkQ0tlV+SISJftX5mJiH7F5yw5SmQCsOCJUdMZdcat4knvJGSIYMw5rn
	1AteQnPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ot4Ac-004r3k-Cx; Thu, 10 Nov 2022 09:48:26 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ot4AX-004qxK-HW
	for linux-nvme@lists.infradead.org; Thu, 10 Nov 2022 09:48:24 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221110094818euoutp02285b301b16398a538e1e0a46beb75f3c~mMDDfQKo61361813618euoutp02b;
	Thu, 10 Nov 2022 09:48:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221110094818euoutp02285b301b16398a538e1e0a46beb75f3c~mMDDfQKo61361813618euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1668073698;
	bh=SKOQ6pNzDLdGsIOFTLzqTgH+ZFV+aB8p2uSelsbcow4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=S1Z/7HIJkGBF0TjBBHgSR+I6kbYAM11DEGTkk0JbSeiZfJ8lp/ViStqSgT/sJkMLP
	 8UlfWdVhtTsjj9tSbntOZZuPG6RZuSst26aFZPbfIu4ngwiyMNGVB9REuhL9kV9q3b
	 apgvsz5LyF8cWaCUOyBlR334uJUGyJVDmR9FydgY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221110094818eucas1p25366c898fbd378f2abaf308202dfb073~mMDDSgEaC2979329793eucas1p2f;
	Thu, 10 Nov 2022 09:48:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id F4.29.09549.2E8CC636; Thu, 10
	Nov 2022 09:48:18 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221110094817eucas1p222d50ab070203c9b326e477e49c5ccdd~mMDC6vAM62984829848eucas1p20;
	Thu, 10 Nov 2022 09:48:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221110094817eusmtrp1d109d6d51e1fa749d3a54fb073b7113f~mMDC5YRsN0797107971eusmtrp1D;
	Thu, 10 Nov 2022 09:48:17 +0000 (GMT)
X-AuditID: cbfec7f5-f47ff7000000254d-1e-636cc8e2c46a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 62.32.08916.1E8CC636; Thu, 10
	Nov 2022 09:48:17 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221110094817eusmtip2e17e147864ddfd7bd7e8afa6d30c4068~mMDCwl7GM2828228282eusmtip2I;
	Thu, 10 Nov 2022 09:48:17 +0000 (GMT)
Received: from localhost (106.210.248.210) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 10 Nov 2022 09:48:16 +0000
Date: Thu, 10 Nov 2022 10:48:15 +0100
From: Joel Granados <j.granados@samsung.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "gost.dev@samsung.com" <gost.dev@samsung.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de"
	<hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvme : Add ioctl to query nvme attributes
Message-ID: <20221110094815.rd7z6xmfpuuxmwy3@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="mdnpvabokim5bgl6"
Content-Disposition: inline
In-Reply-To: <9a55bbf8-1c38-3302-97be-376a3f2ec180@nvidia.com>
X-Originating-IP: [106.210.248.210]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djP87qPTuQkG3xYzm7x/uBjVouVq48y
	WUw6dI3RYv6yp+wW616/Z3Fg9Th/byOLx6ZVnWwem5fUe+y+2cDm0dv8ji2ANYrLJiU1J7Ms
	tUjfLoEr49P6v6wFt/Qq/k3bxd7AuEGti5GTQ0LAROJh/0OWLkYuDiGBFYwSl//tYoRwvjBK
	nF25HCrzmVHiasNLJpiWZ83LoaqWM0rMWb6dDa7q4Z//UJmtjBJPe2+wg7SwCKhK/JvZwApi
	swnoSJx/c4cZxBYR0JO4egukhouDWeApo8TmudvAGoQFnCR6nxxgBLF5BcwlZjR8YIawBSVO
	znzCAmIzC1RInP58AOgmDiBbWmL5Pw6QMKeAncSOXz9ZQMISAsoSJx5zQFxdK3Fqyy2oD/o5
	Je70JEPYLhK7295CxYUlXh3fwg5hy0icntzDAmFnS+ycsosZwi6QmHVyKhvEeGuJvjM5EGFH
	iber3kJt5ZO48VYQ4kY+iUnbpjNDhHklOtqEIKrVJHY0bWWcwKg8C8lXs5B8NQvhK4iwjsSC
	3Z/YMIS1JZYtfM0MYdtKrFv3nmUBI/sqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwJR1
	+t/xrzsYV7z6qHeIkYmD8RCjClDzow2rLzBKseTl56UqifBya2QnC/GmJFZWpRblxxeV5qQW
	H2KU5mBREudlm6GVLCSQnliSmp2aWpBaBJNl4uCUamAqzJ6UvDdXxVTF+/Msg7LtD0v4VR44
	tf5kfNbK8f6PyceHXaG5H3bJaau7hye0FITHKL3uWutv4VhU7qqa8dTq99wKuwX7Ws0DuT9c
	/p6xQphjkprAHEXtia+Ti9xceEL6pzZ/9r9lOzUvXL63vGPX7PkWiRnfr21Z+vBn4puks1/6
	otobXbuFTpv9vXRO4dm21CWf4y6W6DIWZTDcYprjnen1RMn45Ms52udzj0+t803aV+fx4GLX
	i43i+9ZZz079fMfINrNO+tV3yYu6vI11oWx9W1du2/L7WdRcqZbVarKTTW42/565LW/j30LD
	1eY1TE4ML7vf/Tx3aKbqZP+/jQ/mCM/4IiVYm/badYcSS3FGoqEWc1FxIgAfVIzD1AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xe7oPT+QkG6z5qGfx/uBjVouVq48y
	WUw6dI3RYv6yp+wW616/Z3Fg9Th/byOLx6ZVnWwem5fUe+y+2cDm0dv8ji2ANUrPpii/tCRV
	ISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4+TqbqaCG3oVL9/v
	YG5gXKfWxcjJISFgIvGseTljFyMXh5DAUkaJizt2MkMkZCQ+XfnIDmELS/y51sUGUfSRUeLC
	/78sEM5WRom7L66zgVSxCKhK/JvZwApiswnoSJx/cwdskoiAnsTVWzfYQRqYBZ4ySmyeuw1s
	rLCAk0TvkwOMIDavgLnEjIYPzBBTfzJKTL3dwASREJQ4OfMJC4jNLFAm8fvRUaAGDiBbWmL5
	Pw6QMKeAncSOXz9ZQMISAsoSJx5zQFxdK/H57zPGCYzCs5AMmoVk0CyEQRBhLYkb/14yYQhr
	Syxb+JoZwraVWLfuPcsCRvZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgfG77djPzTsY5736
	qHeIkYmD8RCjClDnow2rLzBKseTl56UqifBya2QnC/GmJFZWpRblxxeV5qQWH2I0BYbiRGYp
	0eR8YGLJK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgynXW+Z/a
	v0u9WZBpQsqP5MpLxks++u14UGq6+eTGmYUnW2budefb/fJFFL+Lekeifs3un3Ibp0TefrSw
	ZM+ht9MSq841Orc0N4euXDm1fdGb44sWm0R+lpdUWb5jxSyxXy8PSUtt+Whmfe3DnbM/zuXU
	yVuxqX7+yx65779IfnnPyyWxCfa/O491/mLv3tTdLL3Zbpnh9qO9Oy3NeziOpT+M6Fzw/mpx
	7+5/wc4P1wTsvLLe8Jn6oYPpL7zDKsxXa2/tre0JmHXLp6/dhn/30ek7bzo3f/DrFz5TWhq6
	hUv4XeRCeZO3PGJav66wzVsz9YaOm+JW/dfXVflqrrQ6GHGn7rg4P4TnX8l3q47fx5VYijMS
	DbWYi4oTAfAMCx10AwAA
X-CMS-MailID: 20221110094817eucas1p222d50ab070203c9b326e477e49c5ccdd
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
X-CRM114-CacheID: sfid-20221110_014822_223097_0500F3BC 
X-CRM114-Status: GOOD (  34.10  )
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

--mdnpvabokim5bgl6
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
Quickly looked at all the uses that we have of copy_struct_from_user and
some use the build check and some others don't. It might be a good idea
to either change the call to include the V0 and VCurrent check. Or have
a macro that does that for you. Then update the copy_struct_from_user
usages where it make sense.

This is outside the scope of the current ioctl patch series.

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
>=20
> > +	ret =3D copy_struct_from_user(&nvme_get_attr, NVME_IOCTL_GET_ATTR_CUR=
SZ, arg, usize);
>=20
> overly long line ?
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

--mdnpvabokim5bgl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmNsyN0ACgkQupfNUreW
QU+Q5Av+PWIKhuRi2TWQTfRn0E12XvU0UzcU08I4qlXdv7dKpAVZxfXkkCmNLyzR
DmMJSV2lPqUg0jU3R15lPzWfuJegUF9a7KOQd/OKaPOP2xZgEDLhOf6Q4LJbuczC
OJZVoiKr6Rf4pbp8jTI9FEKdBYobBaoe25y4R5ywsxbaPXv9Gl43xjShKhKGIDce
zAi0KKflGQj6ETGVUe+mEzfOW+MpkiDDM96iYwn5emGvqlB+/3NCDXj3zPaWbCqs
uCyeVs2ANSoDGa43gzPdfuht+f2+gTRhuhj62DF2OtEtO0Gbzhir1LXtiEF+kV+1
A2dil7v/auWhjTUtP6SZoTxsOXmiVXDWxFB0sAjSW4BqYO+1MGniI49vgp8Trc21
2XXGG1Wck/UZ4hy/ewGvpztcuoJ1z4mOac/3klL0s+w2iJTBvvcwPd7xYEA9WyM8
oCx4GA89jrG5G45bSbeRRJZnVW8dgZoJbsYfzcQiHrhNAVSDzZ/Xn3v+5/iL/23k
n3H0QqN2
=+LPp
-----END PGP SIGNATURE-----

--mdnpvabokim5bgl6--

