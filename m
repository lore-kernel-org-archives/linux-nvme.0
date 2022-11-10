Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89586C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Nov 2022 09:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=md6wpojrnXoVCgvOE/GMplXikxNonxembWXrWHxk73o=; b=OcVNRUS3ahTDXtZf2CGyE8WOpJ
	OfQO7fXRZ8x6o6NoT/omRsS+PqdMNNiVG7iG8pM3vLlddnKzbKYyUXmGffWDFx5vKOS95KwkgGR0L
	ye0UsYA0kHhSFILk7uhqATlSY9Mt2SZqSj4+OcFxDUmtPqWJgIk0hivqJEZv4Qmwiz9etmx44/HDq
	qCIi5sBn1MXqtmDQ0oltV1mGSBqLPJpCAn1fNNOizEnJ6/P4WYa191vRXZRJdjha7V+Zxdd8ed3J8
	GB3N4SiBjeIB8Q9qmnW+cYLTp1ZnU1mSITVHUguGCF3KAvXFbLBbYYvHWRUcAQlS61pQY7UJOxTDT
	YvSKm7ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ot3kI-004YJv-8R; Thu, 10 Nov 2022 09:21:14 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ot3k8-004YIG-UA
	for linux-nvme@lists.infradead.org; Thu, 10 Nov 2022 09:21:11 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221110092056euoutp010efe4dea6e9fde699acdc8e075dcbb2b~mLrKtTKLF2981929819euoutp01k;
	Thu, 10 Nov 2022 09:20:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221110092056euoutp010efe4dea6e9fde699acdc8e075dcbb2b~mLrKtTKLF2981929819euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1668072056;
	bh=md6wpojrnXoVCgvOE/GMplXikxNonxembWXrWHxk73o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FEDauq7+Ie//ga8EIvbhueEDaPuxwpnsW9lwSqgF0mKf3IhOPSJTWKEwP3z2euSLT
	 JjTepkAj4NRIGytr+jwRirddip5ROTz8xEHprxbY3uyP4lBzIStp3SYEahirHUQTlF
	 BJ5zt030gtdvX7leNzo+hrZKfoIwwL1hhCbpnemE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221110092056eucas1p14517a8598e63afa6e9fd7eac3edd745c~mLrKfvrEC0160201602eucas1p1q;
	Thu, 10 Nov 2022 09:20:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 2D.42.09561.872CC636; Thu, 10
	Nov 2022 09:20:56 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221110092056eucas1p18029fd272d18a092972907f66f2cb2fb~mLrKNjVWd1610016100eucas1p1V;
	Thu, 10 Nov 2022 09:20:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221110092056eusmtrp2b9e50f9f5ef478b58588c0f8d89b3576~mLrKM9bxF2638426384eusmtrp2k;
	Thu, 10 Nov 2022 09:20:56 +0000 (GMT)
X-AuditID: cbfec7f2-0b3ff70000002559-b2-636cc278fb35
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B7.2D.09026.872CC636; Thu, 10
	Nov 2022 09:20:56 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221110092056eusmtip14be8814ca79e91933ac86156d75dffaf~mLrKDAv8L2151221512eusmtip1n;
	Thu, 10 Nov 2022 09:20:56 +0000 (GMT)
Received: from localhost (106.210.248.210) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 10 Nov 2022 09:20:54 +0000
Date: Thu, 10 Nov 2022 10:20:53 +0100
From: Joel Granados <j.granados@samsung.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "gost.dev@samsung.com" <gost.dev@samsung.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de"
	<hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvme : Add ioctl to query nvme attributes
Message-ID: <20221110092053.ji3fewzvw6o6v6ai@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="sti6ysokk2yssdey"
Content-Disposition: inline
In-Reply-To: <9a55bbf8-1c38-3302-97be-376a3f2ec180@nvidia.com>
X-Originating-IP: [106.210.248.210]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSe0jTURTHu7/XfltNf1uSJ1cEq5VUm0VSg9TsPSIoKLAX1dBfupybbK4s
	zKxIbVr2ssdMMgsro5GvsQyiRi8zM3q5lqSk1nKa6SqwQnPeXtB/n/u553vuOXBZUnqTDmN1
	hjTeZNDq5YyIctzrb1Smu/TxM4qPTFH33G6j1Zev3CXUR10vkfpsWYdAbff1ULG0pvFNBaWp
	LD/AaKou7NbceJXFaA7u+8ispNeJohJ4vW4bb4qI2SxK6u/0UKldyvSc4510FnqlsCKWBS4S
	eh8IrUjISrlLCC57CCsSDfFnBDcv3CHxwY/gzjsf8TvQki/D/iKCosar9J8iT/M7Bh9qEDTX
	vhAE+lKcAvw/sqkAM9x0aOxqJgMcwqnghcctCARIrgNBVbFjODCaWwAH22+hAIu5ObD3WBWB
	WQJ1p9uHG5FcOjyrc9CBkUhOBhcH2IAWcjHg/NZP4UknwoO2YQ3cLnhY7SEwFwgh/8QYzIsg
	7/RTGvNo6LxfLcA8Dgavn/1VnwzXj9eSmFPBVlfI4PZz4dAjPdbzobu8+9erQeDuluAZg+Co
	4ySJtRhys6W4ejI499agw2ii7Z+tbP9sZfu7FdbToeRGH/OfngZl53wk5miw23uoEiQoR6G8
	xZySyJtnGvjtKrM2xWwxJKrijSmVaOhb1Q/c73Oi4s5elQsRLHKhSUPht9euPEFhlMFo4OUh
	4pHhyfFScYJ2x07eZNxksuh5swvJWEoeKmZOTY2XconaND6Z51N50+9bghWGZRHG2V1fP806
	lta2YBxLt0wgvAvjvNEr4iZFULVpwc+8TdZTVp9FrlAO6C3fDrdukPlZa5JRGbz/3jIJ8WWt
	l13VVZAhKzFVOhhbTj278bujIFuBjkiWlEZmjv0RRPYqhB2qwuDcsd+bmprJhvetFdG6XA0h
	t/dqi0rjBksfmresI4QJmscDZ5bmx4oVLXapW+XXNX1a7p+VEJKdUc0syjnf/tobe1u13tm2
	TSKqGT/vs3u3r5XNC89beEDh/NqzIf/D4Ai3P8pf6CJuLc7Ure7bU9FelhG5STBKGpMps1vq
	w99srW1I3ldUHHXo+ZrQ8ClKz9M59TuFzlU5qcvllDlJO3MqaTJrfwIUrBrV0QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsVy+t/xu7oVh3KSDToWi1i8P/iY1WLl6qNM
	FpMOXWO0mL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB59Da/YwtgjdKzKcovLUlV
	yMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLWPn3IGvBK92KXbf2
	MTYwXlftYuTgkBAwkbjfI93FyMkhJLCUUaL/uBCILSEgI/Hpykd2CFtY4s+1LrYuRi6gmo+M
	EpN/fmWEcLYyStzs+88CUsUioCrx+U8bmM0moCNx/s0dZhBbREBP4uqtG+wgDcwCTxklNs/d
	BjZWWMBJovfJAUYQm1fAXKJp8mYmiKk/GSWm3m5ggkgISpyc+QRsKrNAmcThJVfYQM5mFpCW
	WP6PAyTMKWAnsePXTxaIb5QlTjzmgLi6VuLz32eMExiFZyEZNAvJoFkIgyDCWhI3/r1kwhDW
	lli28DUzhG0rsW7de5YFjOyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAmN327GfW3Ywrnz1
	Ue8QIxMH4yFGFaDORxtWX2CUYsnLz0tVEuHl1shOFuJNSaysSi3Kjy8qzUktPsRoCgzFicxS
	osn5wKSSVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAxH8n/tm0
	4n31L10Uq/MXfN0yN+LE7l0tc0P1c72mf5nCJ5TaXBfKEuBlZ1dQtftXdsfU4wsSDkS+8U4V
	22SrEvvvzcE73bNdWr78FdonlWPXNEWZsYab7UJETISg/MZlnA7r58ntDfu8qcRR79TxSyVK
	1lJ/Dt+QCg2bJ2HUrDu9lVv7Ae8j/xg5/WNJBx9OvnR7nWzpPceq9Wvucn1wm5PCnXEjVGPf
	xRxtRZmtc9cekd5yZUEVf/PbLdoCbcvOxkfmXY1bo3HWZf8RYfF8aelQK9bV+t2LfV7m1lQ2
	ijy1zXrq9Pu06MvF6y/8meAs/pl7neLdDgvneHaf2FezvOO7ouZuP5z9KKetcvkWJZbijERD
	Leai4kQAgkHHvXIDAAA=
X-CMS-MailID: 20221110092056eucas1p18029fd272d18a092972907f66f2cb2fb
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
X-CRM114-CacheID: sfid-20221110_012107_999525_78DB6125 
X-CRM114-Status: GOOD (  33.41  )
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

--sti6ysokk2yssdey
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
Looking at this now and I see that we cannot follow the usual style as
copy_to_user will return the number of bytes that were not copied.
Therefore we return something more logical like -EFAULT.
I follow the pattern used in the other calls to copy_to_user in the
file.

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

--sti6ysokk2yssdey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmNswnIACgkQupfNUreW
QU8fowv8CZ69CANxfyvu7fFJR6uxzi+rI4LA8DBbk6Ty6grjtCzXB9GTCmDnFIzg
SpRCSk8oplvVlqUTdSs3UrC7zsVGwaJY8UG7jioN6vofIxG/E5OinMQXm8drq1cS
UGr18b+xPSXVAFNqff1Usk+yjDoV0E82DgKjoSMBALTJiv5l6WCwKLiDIb2KpNJq
yLDpmPGKvvYLl/+YPvnyOdCtiINc9FRPSofA0l1UPAHZ/p+m9WMueEnOv80JhP0Q
rF85JHcdyfcOLj3Xzj5t7XpBN0JLNduTIPoAcSnxCjAhKU6kvXoIEykTHY/AisTu
zUhfLWSopSyqSocZop8NoaShwCatEqRIY7nybKhYqW1JRIgROnTKeDfwKMtatd8w
lYMhD8CpeuPfcg2ep12PvenGZV/hvdJBxmZL4l5EkcDTm+FLoQg9Bxrwi9q6kuyY
PS1Jq0+SY9GDVOh33mYhy1MH8ve0tLbYKCCHLK2//Y8oiO6g6x8wl0WBxYp9KiFC
HboQkl6S
=pEZj
-----END PGP SIGNATURE-----

--sti6ysokk2yssdey--

