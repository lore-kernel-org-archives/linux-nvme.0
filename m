Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9737DC4332F
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Nov 2022 09:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TnPNNqWWY+fGisGwBhRe+tqp4FVS2EdVGzZkTA0lZ3M=; b=FJlbP+RSmcMiV06h5vMuTOkq6o
	4zo0jVhyyRdDXGlvnnOZNa+VXZ1ShGXan2TWeDX21JudjYfzPMIYDB4Zq3fqD7xq7ZvGSgJYwLsJa
	QJvw8P0MQDGOMMfJEuU15QhIcQ1rHX42yN6H7Sk4Iy43wJ1+BtHO35NIQ+XWs/ZiofscNVuBYBL0w
	yRUYEg41SgmM5eonOjCKWdR8UUyLmiALK0ZRO/MhppSWpbjQFQqNSPkAo9PfOYOdeDe/o8sNxqXq/
	OUz7b75zGoFQ8A2lzr+8B6qP/WFsYhoxQhiQ38J2bxK7byctM+yk+Sk80HMRfS6SQevk+6b05RPpS
	0Vax4MUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otmyN-004ifR-8B; Sat, 12 Nov 2022 09:38:47 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otmyG-004iWl-Qo
	for linux-nvme@lists.infradead.org; Sat, 12 Nov 2022 09:38:45 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221112093832euoutp01b0431d82c4fa25acb3556dde6e2f1e77~mzNF-hUJD2537325373euoutp01F;
	Sat, 12 Nov 2022 09:38:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221112093832euoutp01b0431d82c4fa25acb3556dde6e2f1e77~mzNF-hUJD2537325373euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1668245912;
	bh=TnPNNqWWY+fGisGwBhRe+tqp4FVS2EdVGzZkTA0lZ3M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=faEJqKoxvaV2UVfGXuUbI//nN+ckqp1SlOWE+WYdRiMUtXQcsdrgguuCYKecoPh44
	 WwBApdsSTXLT6V3YK0inxCBFU5xjgHbNAwJ063H5JHyM0j0kftLrW9P27eSTTxnVqO
	 CR2e69kTuvqNuqxSi3xaVkMdB4KqokzLnPPMRcmY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221112093831eucas1p2c842bcc253d00d82bdb2cedd7b70bdb8~mzNFkUv9x1592415924eucas1p2m;
	Sat, 12 Nov 2022 09:38:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 94.86.09549.7996F636; Sat, 12
	Nov 2022 09:38:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221112093831eucas1p289115bf48e47881ef0cb11d989961a00~mzNFP_nKw2805928059eucas1p26;
	Sat, 12 Nov 2022 09:38:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221112093831eusmtrp1f1e3e96dd44ba6bdd7918759ca705110~mzNFPbjAz2071620716eusmtrp1p;
	Sat, 12 Nov 2022 09:38:31 +0000 (GMT)
X-AuditID: cbfec7f5-f5dff7000000254d-9e-636f69972d4a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 86.DE.09026.7996F636; Sat, 12
	Nov 2022 09:38:31 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221112093831eusmtip11bd0d830c22305a23202978a346539d2~mzNFFBUq22460324603eusmtip1R;
	Sat, 12 Nov 2022 09:38:31 +0000 (GMT)
Received: from localhost (106.210.248.210) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sat, 12 Nov 2022 09:38:29 +0000
Date: Sat, 12 Nov 2022 10:38:27 +0100
From: Joel Granados <j.granados@samsung.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "gost.dev@samsung.com"
	<gost.dev@samsung.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 1/1] nvme : Add ioctl to query nvme attributes
Message-ID: <20221112093827.l5fetc2eosmapxgf@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="hppcoemaiktksxgs"
Content-Disposition: inline
In-Reply-To: <1a47a82a-af77-8051-2302-dd91304a9f88@nvidia.com>
X-Originating-IP: [106.210.248.210]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djP87rTM/OTDc4tULZ4f/Axq8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGsVlk5Kak1mW
	WqRvl8CV8XTZFraCR8kVX54cYm5gvOjXxcjJISFgInH7yQ+2LkYuDiGBFYwSN2/1MUI4Xxgl
	jr+/xwLhfGaUWPbyAQtMS/u5aUwQieWMEm1/TjDBVe1eMJkVwtnKKPFifQcbSAuLgKrEnvv7
	wNrZBHQkzr+5wwxiiwjoSVy9dYMdpIFZ4CmjxIJvx9lBEsICrhL/Nl9kArF5Bcwl/l96xQph
	C0qcnPkEaBAHUEOFxI5jvhCmtMTyfxwgFZwCdhLnWi8xgoQlBJQlTjzmgDi6VuLUlltgd0oI
	9HNKvJ+7gxWixkXi4VQbiBphiVfHt7BD2DISpyf3QD2cLbFzyi5mCLtAYtbJqWwQrdYSfWdy
	IMKOEp8fnIbayidx460gSJgZyJy0bTozRJhXoqNNCKJaTWJH01bGCYzKs5A8NQvhqVkIT80C
	m6MjsWD3JzYMYW2JZQtfM0PYthLr1r1nWcDIvopRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93
	EyMwXZ3+d/zrDsYVrz7qHWJk4mA8xKgC1Pxow+oLjFIsefl5qUoivPNk8pOFeFMSK6tSi/Lj
	i0pzUosPMUpzsCiJ87LN0EoWEkhPLEnNTk0tSC2CyTJxcEo1MO1s2PZx7m8dOT3n+n9LnF9/
	XnraSvWOyOlLJzhVphz1u8a68qvyw0fPqqZvnakseONG9KM1y3MXa+/apSnwaWWx+5bPy2W/
	B66WKE3Xkw8qWSZjuu/8ihk/jCsaGlY9etci/8DW1rrlCk94YSDL7KDTJQdZd/2u2My/wMki
	Oy0t/kbYvv91wZ8nmoh2Fu6/mfHr6VqDKUt7tW992lQ4KbtQ8f8Fxgt1DhoKO1mtnEqmt/3J
	0Lz9/b1ETvC/75OyraYGtx1VvxPWdtQ02vuNaKH0nBYvnycOC77bTTpoxx5wrk34/gS+2pn9
	02dUHawTzN5oahz+1eXEx02VC4IXsHDkBi1zn92QNNX1X+v15rdKLMUZiYZazEXFiQBMyPLg
	0gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsVy+t/xu7rTM/OTDRpuC1i8P/iY1WLl6qNM
	FpMOXWO0mL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB59Da/YwtgjdKzKcovLUlV
	yMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOHdlC3vBg+SK+f/m
	sDUwnvfrYuTkkBAwkWg/N42pi5GLQ0hgKaPExb9rWCESMhKfrnxkh7CFJf5c62KDKPrIKPHy
	2HNWCGcro8TOphcsIFUsAqoSe+7vA7PZBHQkzr+5wwxiiwjoSVy9dYMdpIFZ4CmjxIJvx8HG
	Cgu4SvzbfJEJxOYVMJf4f+kV1NSfjBLtn9qhEoISJ2c+AZrKAdRdJvFqqyiEKS2x/B8HSAWn
	gJ3EudZLjCBhCQFliROPOSCOrpX4/PcZ4wRG4VlI5sxCmDMLYQ5IBbOAlsSNfy+ZMIS1JZYt
	fM0MYdtKrFv3nmUBI/sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwNjdduznlh2MK1991DvE
	yMTBeIhRBajz0YbVFxilWPLy81KVRHjnyeQnC/GmJFZWpRblxxeV5qQWH2I0BYbhRGYp0eR8
	YFLJK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgCr7iuPSnlvLc
	2Mz22P9ztP+/NU/x/srXYc8wTa1Oa+rrOYG26nf9lbNqWU7cvMtwsH3r3ejvq5SmH79u57/f
	dyW3z3GOpKIs9fdO30WOXTt6avnasi3OlRtW1SrUG/rU9/Lo3f7kWnj5bfj/szVzuu5x/Juz
	anrxUZ8Jy47YmRhtl3U/IsV/+Pz/mENVMRM5OVOMbWUt7y0Pd3xwIEzIfo97+FZttpVagptP
	/b6w47PSo+xPcisX59uKpbyMPqj/9RGL4rEvOXeKV+66VrisOen5i1WPXP5kNbNKWYvmrmZd
	wlu0e/Zivm03jjgtO+5wcMOhD1dP3Fl4rfpbDqd4b5SvzCveezIL48R0LM9z/VdiKc5INNRi
	LipOBADXa9sScgMAAA==
X-CMS-MailID: 20221112093831eucas1p289115bf48e47881ef0cb11d989961a00
X-Msg-Generator: CA
X-RootMTR: 20221110110859eucas1p25881553dd9cbe21118561b1f2692ed6c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221110110859eucas1p25881553dd9cbe21118561b1f2692ed6c
References: <20221110110522.1626637-1-j.granados@samsung.com>
	<CGME20221110110859eucas1p25881553dd9cbe21118561b1f2692ed6c@eucas1p2.samsung.com>
	<20221110110522.1626637-2-j.granados@samsung.com>
	<1a47a82a-af77-8051-2302-dd91304a9f88@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221112_013842_293630_C00E59EE 
X-CRM114-Status: GOOD (  44.95  )
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

--hppcoemaiktksxgs
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 10, 2022 at 03:13:04PM +0000, Chaitanya Kulkarni wrote:
> On 11/10/22 03:05, Joel Granados wrote:
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
> >   drivers/nvme/host/ioctl.c       | 58 ++++++++++++++++++++++++++
> >   drivers/nvme/host/nvme.h        | 11 +++++
> >   include/uapi/linux/nvme_ioctl.h | 74 +++++++++++++++++++++++++++++++++
> >   4 files changed, 147 insertions(+), 1 deletion(-)
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
> > index 9273db147872..ce69659f05b6 100644
> > --- a/drivers/nvme/host/ioctl.c
> > +++ b/drivers/nvme/host/ioctl.c
> > @@ -53,6 +53,58 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrva=
l)
> >   	return (void __user *)ptrval;
> >   }
> >  =20
> > +static inline u32 nvme_sectors_to_mps(struct nvme_ctrl *ctrl, u32 unit)
> > +{
> > +	return ilog2(unit) + 9 - 12 - NVME_CAP_MPSMIN(ctrl->cap);
>=20
> please add a detailed comment here what you are doing and why you are
> doing here... using magic numbers like 9 and 12 makes code hard to read
> for others...

Added a comment. We have several places where we use 12 and 9
"magically" to convert from NVMe spec to kernel sector values. Would it
make sense to #define this as NVME_CONST_MPSMIN_POW2_START. We can
definitely work on the name :)

>=20
> > +}
> > +
> > +static int nvme_ctrl_export_attrs(struct nvme_ctrl *ctrl,
> > +				  struct nvme_get_attr __user *arg)
> > +{
> > +	struct nvme_get_attr nvme_get_attr =3D {0};
>=20
> following will not work ? thats what we have in the code :-
> struct nvme_get_attr nvme_get_attr =3D { };
Sure. lets go with the way nvme driver chose to do it.

>=20
> > +	__u32 usize, retsize;
> > +	int ret;
> > +
> > +	BUILD_BUG_ON(sizeof(struct nvme_get_attr) < NVME_IOCTL_GET_ATTR_V0SZ);
> > +	BUILD_BUG_ON(sizeof(struct nvme_get_attr) !=3D NVME_IOCTL_GET_ATTR_CU=
RSZ);
> > +
>=20
> what prevents us from moving this to _nvme_check_size() ?
That seems like a better place. thx for pointing it out.

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
> > +	/* Enforce backwards compatibility */
> > +	ret =3D copy_struct_from_user(&nvme_get_attr, NVME_IOCTL_GET_ATTR_CUR=
SZ,
> > +				    arg, usize);
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
> > +	ret =3D copy_to_user((struct nvme_get_attr __user *)arg, &nvme_get_at=
tr, retsize);
> > +	if (ret)
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> >   static void *nvme_add_user_metadata(struct request *req, void __user =
*ubuf,
> >   		unsigned len, u32 seed)
> >   {
> > @@ -613,6 +665,8 @@ static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, =
unsigned int cmd,
> >   		return nvme_user_cmd(ctrl, NULL, argp, mode);
> >   	case NVME_IOCTL_ADMIN64_CMD:
> >   		return nvme_user_cmd64(ctrl, NULL, argp, false, mode);
> > +	case NVME_IOCTL_GET_ATTR:
> > +		return nvme_ctrl_export_attrs(ctrl, argp);
> >   	default:
> >   		return sed_ioctl(ctrl->opal_dev, cmd, argp);
> >   	}
> > @@ -659,6 +713,8 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsign=
ed int cmd,
> >   		return nvme_user_cmd64(ns->ctrl, ns, argp, false, mode);
> >   	case NVME_IOCTL_IO64_CMD_VEC:
> >   		return nvme_user_cmd64(ns->ctrl, ns, argp, true, mode);
> > +	case NVME_IOCTL_GET_ATTR:
> > +		return nvme_ctrl_export_attrs(ns->ctrl, argp);
> >   	default:
> >   		return -ENOTTY;
> >   	}
> > @@ -950,6 +1006,8 @@ long nvme_dev_ioctl(struct file *file, unsigned in=
t cmd,
> >   			return -EACCES;
> >   		nvme_queue_scan(ctrl);
> >   		return 0;
> > +	case NVME_IOCTL_GET_ATTR:
> > +		return nvme_ctrl_export_attrs(ctrl, argp);
> >   	default:
> >   		return -ENOTTY;
> >   	}
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index a29877217ee6..07c0d12747b7 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -291,6 +291,9 @@ struct nvme_ctrl {
> >   	u16 crdt[3];
> >   	u16 oncs;
> >   	u32 dmrsl;
> > +	u64 dmsl;
> > +	u8 vsl;
> > +	u8 wusl;
> >   	u16 oacs;
> >   	u16 sqsize;
> >   	u32 max_namespaces;
> > @@ -815,6 +818,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q,=
 struct nvme_command *cmd,
> >   		union nvme_result *result, void *buffer, unsigned bufflen,
> >   		int qid, int at_head,
> >   		blk_mq_req_flags_t flags);
> > +
> >   int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
> >   		      unsigned int dword11, void *buffer, size_t buflen,
> >   		      u32 *result);
> > @@ -1072,4 +1076,11 @@ static inline const unsigned char *nvme_get_admi=
n_opcode_str(u8 opcode)
> >   }
> >   #endif /* CONFIG_NVME_VERBOSE_ERRORS */
> >  =20
> > +/*
> > + * List of all nvme ioctl controller attribute calls. Use size of nvme=
_get_attr
> > + * as the version which enables us to use copy_struct_from_user
> > + */
> > +#define NVME_IOCTL_GET_ATTR_V0SZ		32u
> > +#define NVME_IOCTL_GET_ATTR_CURSZ		NVME_IOCTL_GET_ATTR_V0SZ
> > +
> >   #endif /* _NVME_H */
> > diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_=
ioctl.h
> > index 2f76cba67166..f15d2f7363fb 100644
> > --- a/include/uapi/linux/nvme_ioctl.h
> > +++ b/include/uapi/linux/nvme_ioctl.h
> > @@ -92,6 +92,79 @@ struct nvme_uring_cmd {
> >   	__u32   rsvd2;
> >   };
> >  =20
> > +
> > +/*
> > + * This struct is populated from the following nvme commands:
> > + * [1] Identify Controller Data Structure
> > + * [2] I/O Command Set Specific Identify Controller Data Structure for=
 the
> > + *     NVME Command Set. Usually contained in struct nvme_id_ctrl_nvm
> > + * [3] Controller capabilities on controller initialization
> > + */
> > +struct nvme_get_attr {
> > +	__u32	argsz;
> > +	__u32	flags;
> > +
> > +	/*
> > +	 * Memory Page Size MINimum : The host should not configure a page si=
ze that
> > +	 * is larger than (2 ^ (12 + mpsmin)). Comes from [3]
> > +	 */
>=20
> we are not spelling out these fileds explicitely since description
> already present in the spec, so just to make sure abbrivations match
> to the fields in the spec (which I think you hv done it pretty nicely).
>=20
> Please remove these comments as these are inconsistent with what
> we have, see host/nvme.h:struct nvme_ctrl {}.
>=20
>=20
> > +	__u32	mpsmin;
> > +
> > +	/*
> > +	 * Verify Size Limit : Recommended or supported data size for a verify
> > +	 * command. From [2].
> > +	 */
>=20
> same here
>=20
> > +	__u8	vsl;
> > +
> > +	/*
> > +	 * Write Zeroes Size Limit : Recommended or supported data size for a
> > +	 * zeroes command. From [2].
> > +	 */
> > +	__u8	wzsl;
> > +
>=20
> same here
> > +	/*
> > +	 * Write Uncorrected Size Limit : Recommended or supported data size =
for
> > +	 * an uncorrected command. From [2].
> > +	 */
> > +	__u8	wusl;
> > +
>=20
> same here
>=20
> > +	/*
> > +	 * Dataset Management Ranges Limit : Recommended or supported maximum
> > +	 * number of logical block ranges for the Dataset Management Command.
> > +	 * From [2].
> > +	 */
> > +	__u8	dmrl;
> > +
>=20
> same here
>=20
> > +	/*
> > +	 * Dataset Management Size Limit : Recommended or supported maximum of
> > +	 * total number of logical blocks for a Dataset Management Command.
> > +	 * From [2].
> > +	 */
> > +	__u64	dmsl;
> > +
>=20
> same here
>=20
> > +	/*
> > +	 * Dataset Management Range Size Limit : Recommended or supported max=
imum
> > +	 * number of logical blocks in a range of a Dataset Management Comman=
d.
> > +	 * From [2].
> > +	 */
> > +	__u32	dmrsl;
>=20
> same here
>=20
> > +
> > +	/*
> > +	 * Optional NVM Command Support. Is needed to make sense of attributes
> > +	 * like vsl, wzsl, wusl... Comes from [1].
> > +	 */
> > +	__u16	oncs;
> > +
>=20
> same here
>=20
>=20
> > +	/*
> > +	 * Maximum data transfer size. Commands should not exceed this size.
> > +	 * Comes from [1].
> > +	 */
> > +	__u8	mdts;
> > +
>=20
> same here
>=20
>=20
> > +	__u8	rsvd0;
> > +
>=20
> reserving only 8 bits seems not so future proof, why can't we increase
> the size of the rsvd to something like
> NVMe command size - total size of this struct to make it future proof ?

I actually added this to plug a hole that I saw in pahole on my 64 bit
machine, It has nothing to do with future proofing the ioctl.
Future proofing is implemented in the nvme_ctrl_export_attrs function
by handling different struct sizes with copy_struct_from_user.

Will remove it.

Thx again for the feedback
>=20
> > +};
> > +
> >   #define nvme_admin_cmd nvme_passthru_cmd
> >  =20
> >   #define NVME_IOCTL_ID		_IO('N', 0x40)
> > @@ -104,6 +177,7 @@ struct nvme_uring_cmd {
> >   #define NVME_IOCTL_ADMIN64_CMD	_IOWR('N', 0x47, struct nvme_passthru_=
cmd64)
> >   #define NVME_IOCTL_IO64_CMD	_IOWR('N', 0x48, struct nvme_passthru_cmd=
64)
> >   #define NVME_IOCTL_IO64_CMD_VEC	_IOWR('N', 0x49, struct nvme_passthru=
_cmd64)
> > +#define NVME_IOCTL_GET_ATTR	_IOWR('N', 0x50, struct nvme_get_attr)
> >  =20
> >   /* io_uring async commands: */
> >   #define NVME_URING_CMD_IO	_IOWR('N', 0x80, struct nvme_uring_cmd)
>=20
>=20
> -ck
>=20

--hppcoemaiktksxgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmNvaZAACgkQupfNUreW
QU/KAgv7BLDYGra6BT4+HchgcPCEqy3ZkY7lHOojPylPUe3MK57BnnCIlTVnmZfg
BtveTtxd1fVnrtOMuWnF5VGX/yL9wutgSzb6RsfukswteDqusYK18hpLMFn1KaUX
XFXXfRum0ga9yrN0dmfes8RRvEukLqycVx1YRJmbAXP0Ogr9aiJIhNrFY5HEyJYI
pHCUwdzNAlnIjU1sFMR/aO0dOYAHLe/Z6aDYAMJsMgOc4d6DkIBi6arFoZxduJzR
RFjex/RwYyUcjcFJp+ZzK/t4/wg7adhB5sLTWjg3xasXatCodXrf7B7c1v+HX1Ti
oJtEt62HZuqm04tsKEVLPEbCHTlWVr/set3Y4/yNeD5Wi+l4jfAUcqy9us48bKZR
CTApVaP1A53iIKfqo43i+XHcmCASy8TIp7SxsBTw2eVKAxgSThyvBovxiExTZhtB
neSDSf9ZGR7A/uYgl1kxlGPp6FoFG5VvjtCuKJqK64ei+b4mfggtuPjEvsF4NRYm
MIuPyRkM
=UtF9
-----END PGP SIGNATURE-----

--hppcoemaiktksxgs--

