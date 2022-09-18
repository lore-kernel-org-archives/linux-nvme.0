Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56A0ECAAD8
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Sep 2022 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JNz1TTXsHfSTuFw95amKPu2DGbpEYNL79ynH0novgLU=; b=ro7QbtsI/8OckOPTWCjg503F+3
	HgtkrQKtCVx99ElSBtHqK3TE3T9WXGrelhaIpVRCFj+NwitX5NCcP8hIjrpjnxCOZEeKHRNcuJxwm
	J4wfKMURuJmpwQIFHaZf/JHotDQnlNi18BB18mPj91wikKdkYU4H4FGyFJbh59PmeovCeJGzcyUkJ
	8FxJ90K9WXhEXWV8dC6+eCEix+LW4YhFtZFdQ4pFLT/M9M2STr4Si1IFvwRUGvYEZryyph7WP7938
	NfCmhKot81PrrTxZFvVA50whvlRHUY6zGj/5TlKMKp4FVl2wJHCZyIdD7nA1dQlknWhMmeB2U2Clb
	kHpxDUYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZx1D-000Wqr-RA; Sun, 18 Sep 2022 16:19:43 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZx1A-000WjM-G7
	for linux-nvme@lists.infradead.org; Sun, 18 Sep 2022 16:19:42 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220918161928euoutp01f7e896204e620610b962b1f38199f31e~WAMdQAFl22797827978euoutp01q;
	Sun, 18 Sep 2022 16:19:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220918161928euoutp01f7e896204e620610b962b1f38199f31e~WAMdQAFl22797827978euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1663517968;
	bh=JNz1TTXsHfSTuFw95amKPu2DGbpEYNL79ynH0novgLU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KAtSPlLvJCV+k3/cjbjRwURBwjm2eS9C2TPvVfG2heip/1bYIrIOZbwVO/Et5SQWn
	 9l+0G8J+5UmxcKeN+m6BWByI80o06BEgHTIhlUOH6c0PuiE+1bwUAAlutQupZGodlt
	 9DEoRWF3+JoWuPjfa8QuNDUMAygHGTH76pOolwu8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220918161927eucas1p2fd2712f7ab61bd4e7a3eabd453570717~WAMcuzcSB2510125101eucas1p2H;
	Sun, 18 Sep 2022 16:19:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id A0.5F.19378.F0547236; Sun, 18
	Sep 2022 17:19:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220918161927eucas1p1a9c3b181b5b18bcacdd0143f672033dc~WAMcaT-I82725127251eucas1p1O;
	Sun, 18 Sep 2022 16:19:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220918161927eusmtrp2fbc128b9b192a1447cc7cb0c8efa882d~WAMcZpSVA0811008110eusmtrp2I;
	Sun, 18 Sep 2022 16:19:27 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-98-6327450f1806
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 47.BF.07473.F0547236; Sun, 18
	Sep 2022 17:19:27 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220918161927eusmtip191bcdcc6b39f40825413bcf0968bfc7d~WAMcHVbds1275412754eusmtip1D;
	Sun, 18 Sep 2022 16:19:27 +0000 (GMT)
Received: from localhost (106.210.248.110) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 18 Sep 2022 17:19:20 +0100
Date: Sun, 18 Sep 2022 18:19:17 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: <hch@lst.de>, <axboe@kernel.dk>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<javier.gonz@samsung.com>
Subject: Re: [RFC 1/2] nvme: add whitelisting infrastructure
Message-ID: <20220918161917.mrfruzz4zd44kreu@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="lwhbmhr5qautispf"
Content-Disposition: inline
In-Reply-To: <20220909163307.30150-2-joshi.k@samsung.com>
X-Originating-IP: [106.210.248.110]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djP87r8rurJBg1vtSxW3+1ns1i5+iiT
	xaRD1xgt5i97ym6x7vV7FgdWj/P3NrJ4XD5b6rFpVSebx+Yl9R67bzawBbBGcdmkpOZklqUW
	6dslcGUs2rOZseCSRMWd5afYGhiviXQxcnJICJhI9E9+z9rFyMUhJLCCUeLiqg9sEM4XRonX
	z1exglQJCXxmlLi6zAqmY8K/9UwQRcsZJTb3NEJ1ABV1Hz3NDtGxlVGi7UohiM0ioCpx8fE/
	FhCbTUBH4vybO8wgtoiAukTH9HNgk5gFehkljt3dxgiSEBawkdi0/AEbiM0rYC7x+sZrKFtQ
	4uTMJ2CDmAUqJN40/AUaxAFkS0ss/8cBEuYUsJTovP6OHeJSZYmDyw5B2bUSa4+dYQfZJSHQ
	zilxaOYxsF4JAReJI98EIWqEJV4d3wJVLyPxf+d8Jgg7W2LnlF3MEHaBxKyTU9kgWq0l+s7k
	QIQdJRp/3mWFCPNJ3HgrCHEkn8SkbdOhFvFKdLQJQVSrSexo2so4gVF5FpK3ZiF5axbCWxBh
	HYkFuz+xYQhrSyxb+JoZwraVWLfuPcsCRvZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsY
	genq9L/jX3cwrnj1Ue8QIxMH4yFGFaDmRxtWX2CUYsnLz0tVEuFV9VRJFuJNSaysSi3Kjy8q
	zUktPsQozcGiJM6bnLkhUUggPbEkNTs1tSC1CCbLxMEp1cAUMjtue51e4P61Yp0fnJlTJ3X3
	bROfVaTw3fZ3+Amme0tuX/Iyu+H5dbOkwcXnis+ZxfOvLxWcpu4VGab+/f6Cw3N8lt1Ydmvr
	q3trp13f4/s/iXU1/7PVr7iX/f4b9dGupjxQLKuwcV3pnKMKXyaeu8h7wfPP55hrUq6/7gQe
	EV7km5DD48vy9mOY8lzHLd2ndQJsY5RXnykK01iVwPchaLaM4Wddzy733e19+dETpWU36TI0
	T5183d6q4mzW4UtfD7NxxafulrTgOXYkr3v3gjff/Yr4NyrxdoU1zHNj754Y9sTegPXe5ddp
	rxm9kvZPvhJ9t/nDiTajeWeV5mfsOTXvjR9DxMk1c6YG5gXpK7EUZyQaajEXFScCAGZXnxPS
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xu7r8rurJBut+iVusvtvPZrFy9VEm
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTxuHy21GPTqk42j81L6j1232xgC2CN0rMpyi8tSVXI
	yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MtoO/yApeCCRMWCyWvY
	GhiviHQxcnJICJhITPi3nqmLkYtDSGApo8SZCS9YIBIyEp+ufGSHsIUl/lzrYoMo+sgo8ezn
	JEYIZyujxK7zC9hAqlgEVCUuPv4H1s0moCNx/s0dZhBbREBdomP6ObAVzALdjBLL2yeBFQkL
	2EhsWv4ArJlXwFzi9Y3XUCt2M0qcaz/KCpEQlDg58wlYA7NAmcTuR8+ApnIA2dISy/9xgIQ5
	BSwlOq+/gzpVWeLgskNQdq3Eq/u7GScwCs9CMmkWkkmzECZBhLUkbvx7yYQhrC2xbOFrZgjb
	VmLduvcsCxjZVzGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTG77ZjPzfvYJz36qPeIUYmDsZD
	jCpAnY82rL7AKMWSl5+XqiTCq+qpkizEm5JYWZValB9fVJqTWnyI0RQYjBOZpUST84GJJa8k
	3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1Oqgakxu3yq6kL1421NMq1N
	T5fPzuZUnGiUraLA/iZiTtmUxa8s5l5ws1tXzLpdWHuBxqku5juzfk1uWa/9cs9U7UcnsyyO
	K/0smHz55JOZG34krCxP2r7TMTzuuuCieY2ePpOVd4crfjz+vKfezHXJr8UnF3y6s//6JbmJ
	EyrFLLxUDsoULloeXXgq6WqAWMP8075/fjx5dr1qTsb/oAxTdm7WWZeEhY4+XHrvWMSFN0wq
	rvvLAj9UfBI6XvPUY96R6ULGGpfjFl668P7FrJfseXxTo7Y5LEvw+33gsET4nP+xD/6nGLbb
	vz8fEFkQUPDQf2Pq6V3zNqVEcez9kqp9pLX407/kT+HtIdP6nT8YXU3MV2Ipzkg01GIuKk4E
	AOm5ntZ0AwAA
X-CMS-MailID: 20220918161927eucas1p1a9c3b181b5b18bcacdd0143f672033dc
X-Msg-Generator: CA
X-RootMTR: 20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d
References: <20220909163307.30150-1-joshi.k@samsung.com>
	<CGME20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d@epcas5p1.samsung.com>
	<20220909163307.30150-2-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220918_091940_964843_0A1AC6E2 
X-CRM114-Status: GOOD (  24.13  )
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

--lwhbmhr5qautispf
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 09, 2022 at 10:03:06PM +0530, Kanchan Joshi wrote:
> If CAP_SYS_ADMIN is present, nothing else is checked, as before.
> If CAP_SYS_ADMIN is not present, take the decision based on
> - type of nvme command (io or admin)
> - nature of nvme-command (write or read)
> - mode with which file was opened (read-only, read-write etc.)
>=20
> io-commands that write/read are allowed only if matching file mode is
> present.
> for admin-commands, few read-only admin command are allowed and that too
> when mode matches.
>=20
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  drivers/nvme/host/ioctl.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 548aca8b5b9f..0d99135a1745 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -20,6 +20,42 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
>  	return (void __user *)ptrval;
>  }
> =20
> +bool nvme_io_cmd_allowed(u8 opcode, fmode_t mode)
> +{
> +	/* allow write/read based on what was allowed for open */
> +	/* TBD: try to use nvme_is_write() here */
> +	if (opcode & 1)
I know that this is an RFC, but this would eventually be nvme_cmd_write
instead of 1.
right?

> +		return (mode & FMODE_WRITE);
> +	else
> +		return (mode & FMODE_READ);
> +}
> +
> +bool nvme_admin_cmd_allowed(u8 opcode, fmode_t mode)
> +{
> +	/* allowed few read-only commands post the mode check */
> +	switch (opcode) {
> +	case nvme_admin_identify:
> +	case nvme_admin_get_log_page:
> +	case nvme_admin_get_features:
> +		return (mode & FMODE_READ);
> +	default:
> +		return false;
> +	}
> +}
> +
> +bool nvme_cmd_allowed(struct nvme_ns *ns, u8 opcode, fmode_t mode)
> +{
> +	bool ret;
> +	/* root can do anything */
> +	if (capable(CAP_SYS_ADMIN))
> +		return true;
> +	if (ns =3D=3D NULL)
> +		ret =3D nvme_admin_cmd_allowed(opcode, mode);
> +	else
> +		ret =3D nvme_io_cmd_allowed(opcode, mode);
> +	return ret;
> +}
> +
>  static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
>  		unsigned len, u32 seed, bool write)
>  {
> --=20
> 2.25.1
>=20

--lwhbmhr5qautispf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmMnRP8ACgkQupfNUreW
QU+Hggv+PSdcUrgo2pYcbBQB04qa5G5GqSoAzhg7RVlGLbN6Wb18BB34CBnTENnE
ZnO7wRY4zs5JIaEeCVX2R+RCwm1A+LIbnhN4xE0CHHu4jaINNgC8Bed8v6is97vz
uVSwblHWA0fSDupr1Y6Pasfoc3yKWRK6ho2Ny1urJSuvJJEoCBxQJowiXKd/rezv
8jRRaZEREHxK5Z5bmwoy/gjD5hXpk8G36UdKDgiOzBiOxFBEcdqHcSshh8NqKB1e
yNl02wRf0E0tUWbEE31HOAMqxdI7KeGmB3VbT7+hvOIzrm5wMIYHcZ/fyQGCM+1e
fy3WoxzeahsTbwN6ik7Gst0zGZk3I72WGhJ96tHJarjebjHla9d+4d0SurIhPqKw
Kn5lCuVz1DsFJj1yH5EYXZXtOyiecW9dStVctOA3MUkPf2sWcLm5tAQ9duuyX41f
FkhYIb9rMIl90LinPPwDa5LIKvujPMeYSIru+giNz4PO2aw6y0P4rP7t4VESE72p
VbX+orig
=lUXl
-----END PGP SIGNATURE-----

--lwhbmhr5qautispf--

