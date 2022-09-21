Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAA9C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 10:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S28/Ygv07Y1bESXiy6uA/SpE6s2NEZoJ3hIG8oOnkck=; b=z6/6V4HCknHKiz1CRQN+vLOrxS
	TxVNbKO/6vXScBfwjrIPrFIeOlTlR2VZTzkQ20GO0IJtirkC+T1+MYgX00CPqnkINtT7BvFtjdzKj
	ujmGPFLELMBflnfjk5P+/jMW9bxPhhcNlOh44/S7wPb+TxFaHSq/PpgBcDC0hfORePFx55V4cjpMP
	0a79Egp73d4IEvt3kFj7xSfys3cbHHnackXZcrQg6zQsQSK8okrJc4LvHVaNxekF42j2cSijdlXpM
	bg0MnQcr2hHbEMHcqu73z5DCeP6Rush6MSzb6GM3qRAdUphxVzVAp+PG+AjPA47+QPLRDGrG2KgXi
	zXnNTwvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaxR3-00B1Qr-Uk; Wed, 21 Sep 2022 10:58:33 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaxR0-00B1PM-MN
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 10:58:32 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220921105826euoutp021cdaf253fbc094587551f4653b13dd4d~W2wBd_1Is1030510305euoutp02C;
	Wed, 21 Sep 2022 10:58:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220921105826euoutp021cdaf253fbc094587551f4653b13dd4d~W2wBd_1Is1030510305euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1663757907;
	bh=S28/Ygv07Y1bESXiy6uA/SpE6s2NEZoJ3hIG8oOnkck=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=MNTTE6LuE2HQR4SfonRJA/e3gM/RoMZ5dyXTAcBzhT5RlHW73TPq/cXdZzeevA3rp
	 4z2fseDboXOgnO9NPL7eEsNTitEeuhA0mu1d9bfQ/orAkMDb9T3cPRXqQu0/tMckHi
	 CoAJMDmtCmiFg7enK8LJ+DTpS7OvuzYY2soFp7M8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220921105826eucas1p1a13b09d00a60bb9d163a90714f3edeb8~W2wBSrij81831418314eucas1p1i;
	Wed, 21 Sep 2022 10:58:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 5C.B2.19378.25EEA236; Wed, 21
	Sep 2022 11:58:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220921105826eucas1p16cf05c0a38e4c051ce8a467cad0dc09b~W2wBA01XZ1831418314eucas1p1h;
	Wed, 21 Sep 2022 10:58:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220921105826eusmtrp284458066eed79295548835a0d4debec3~W2wBAKfYQ2611226112eusmtrp2c;
	Wed, 21 Sep 2022 10:58:26 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-80-632aee528a3c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 63.87.10862.25EEA236; Wed, 21
	Sep 2022 11:58:26 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220921105826eusmtip245bc7170c2caa63f0987cdcc5d422a60~W2wAyTclE1041910419eusmtip24;
	Wed, 21 Sep 2022 10:58:26 +0000 (GMT)
Received: from localhost (106.210.248.110) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 21 Sep 2022 11:58:23 +0100
Date: Wed, 21 Sep 2022 12:58:22 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: <hch@lst.de>, <axboe@kernel.dk>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<javier.gonz@samsung.com>
Subject: Re: [RFC 1/2] nvme: add whitelisting infrastructure
Message-ID: <20220921105822.nhy6bg3tda4ln5yo@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="hzpwhprj3msl7flw"
Content-Disposition: inline
In-Reply-To: <20220909163307.30150-2-joshi.k@samsung.com>
X-Originating-IP: [106.210.248.110]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djP87pB77SSDXY/1rFYfbefzWLl6qNM
	FpMOXWO0mL/sKbvFutfvWRxYPc7f28jicflsqcemVZ1sHpuX1HvsvtnAFsAaxWWTkpqTWZZa
	pG+XwJXR0vWZreCsRMWqP//YGxgviXQxcnBICJhIPN9W3MXIxSEksIJR4t7FvSwQzhdGidMb
	97BCOJ8ZJbbengjkcIJ1vFtxAapqOaPEr6fzmOCqbpw/DtWylVHi5dsPYC0sAqoSaxeeZAGx
	2QR0JM6/ucMMYosIqEt0TD8H1s0s0MsocezuNkaQhLCAjcSm5Q/YQGxeAXOJU9+vs0PYghIn
	Zz4BG8QsUCFxbvFDZpAvmAWkJZb/4wAJcwpYSnRef8cOcaqyxMFlh6DsWom1x86wg+ySEOjm
	lGi9vp0REgIuEn1H4iBqhCVeHd8CVS8j8X/nfCYIO1ti55RdzBB2gcSsk1PZIFqtJfrO5ECE
	HSUaf95lhQjzSdx4KwhxJJ/EpG3TmSHCvBIdbUIQ1WoSO5q2Mk5gVJ6F5K1ZSN6ahfAWRFhH
	YsHuT2wYwtoSyxa+ZoawbSXWrXvPsoCRfRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZg
	wjr97/jXHYwrXn3UO8TIxMF4iFEFqPnRhtUXGKVY8vLzUpVEeGff0UwW4k1JrKxKLcqPLyrN
	SS0+xCjNwaIkzss2QytZSCA9sSQ1OzW1ILUIJsvEwSnVwKT3v1r9/YbVvGtz84/1cU8JDU7T
	Zit/479E7K2NFlPP1G9r7KJsQl3TemzOLr3089WqFVP4JymKPDnqWNyrdeul4wxF8cfbNlh+
	epO40j/XRO9NFvemPYIr1eef75B6v636X6hiyPpdYof8P68JjJbv36UXmZMUPX9huP6Pgy5R
	L0S+Xb9c+o53k9EKS3WJv5mXma9JTt6tdoBzTumS8+k+b1vklC4d4L5boi3xaLfRtGnc6dL3
	fu9ed+KhzXPtSPf14YnTrombvVdyP93OfmiD6z++oPqu6OyirU/7njvZvhR+36wdeWPNlImb
	H8+vebRkwvlC7Vs/H9iGnvEzzom6uqz1V9GtLeuTyhgN3t1TYinOSDTUYi4qTgQAO5PMTdMD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsVy+t/xe7pB77SSDU4tE7NYfbefzWLl6qNM
	FpMOXWO0mL/sKbvFutfvWRxYPc7f28jicflsqcemVZ1sHpuX1HvsvtnAFsAapWdTlF9akqqQ
	kV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJdxo0mi4LRExYd9c5gb
	GC+IdDFyckgImEi8W3GBpYuRi0NIYCmjxJ8DE9ggEjISn658ZIewhSX+XOsCiwsJfGSUaD1e
	AdGwlVHi9PyZzCAJFgFVibULT7KA2GwCOhLn39wBi4sIqEt0TD/HBNLALNDNKLG8fRJYkbCA
	jcSm5Q/ApvIKmEuc+n6dHWLqbkaJc+1HWSESghInZz4Ba2AWKJO4/nsiYxcjB5AtLbH8HwdI
	mFPAUqLz+juoS5UlDi47BGXXSry6v5txAqPwLCSTZiGZNAthEkRYS+LGv5dMGMLaEssWvmaG
	sG0l1q17z7KAkX0Vo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYOxuO/Zzyw7Gla8+6h1iZOJg
	PMSoAtT5aMPqC4xSLHn5ealKIryz72gmC/GmJFZWpRblxxeV5qQWH2I0BQbjRGYp0eR8YFLJ
	K4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgkj399tdtd/n0Hde9
	/kzh/DznwNXgHf4ZGxu55i+02H5sft48td+yd43WNgaciaq0/Gj3/u7PuEDz/jh2p3WO05bq
	mx/b8/dS336NvSEnb+yOFWo74xV8sqzkeXK39YH3wSnsk+W53+f/rRZ92KTTfUHzgfhXxiVF
	B+UW/mdaOsPgX+qxX0eSnarUOJNDY3eleb1KeTuzKunncpbQ6l8bVy56k/kq3U3h3NzFsrNv
	1vcwzosNfhe0ZPObD4xnHwe8neqnoybfMNtKb7s628Gie8tVz12UVTvhc9UoPCXoL4906+V3
	KybdST7fcWzhu5PRLcZ/S7iuvkxKOWTz7feUq/HBs61lFrEW97ztsrcQclFiKc5INNRiLipO
	BACPZueOcgMAAA==
X-CMS-MailID: 20220921105826eucas1p16cf05c0a38e4c051ce8a467cad0dc09b
X-Msg-Generator: CA
X-RootMTR: 20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d
References: <20220909163307.30150-1-joshi.k@samsung.com>
	<CGME20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d@epcas5p1.samsung.com>
	<20220909163307.30150-2-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_035831_023607_F531219E 
X-CRM114-Status: GOOD (  24.56  )
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

--hzpwhprj3msl7flw
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
These all should be static functions. right? So we keep the scope within
the file?

Best
> +{
> +	/* allow write/read based on what was allowed for open */
> +	/* TBD: try to use nvme_is_write() here */
> +	if (opcode & 1)
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

--hzpwhprj3msl7flw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmMq7k4ACgkQupfNUreW
QU9iWQv6Ag9TTGo7e+lYP5+M8tdzgvEyU6ypXW1+93dB66QHkJCYIBEZ/Y9/KU3C
lfDC5SzMwZALGpKh96I/vBTAwUEfaxG5A89tqC0ZiToWSgygREk6AwPf66v9nmSH
TduuUNer+RSO7rQ3rmn9dry+erW38Cvgo5zAg5qOGI3JJdjxHiYw4pFDEM/3GQs2
pw6C2YXLgeHxaz4jWpvhASLtCDqqkkVQBE5ZVJhYrETOFDmxkHswre0p8igKYc1G
Mxo7do8AQ73CFWzjZhBhOW7fMqdx7BmU8qpxYlZeD95T555iUp9FXunwJPkq9a6S
dr0Xduc9geHr4yr9E7NQ5tbitZeBdpHlAP+sJl5wMym1RPf9xQn5L290db1hFbgm
PhIsg7HdRiqSyV6giKxBaohfYveoBlw8L3gVGlEoWlYfAq4hJITF3reDaeeACa2w
PpSM5LqbwrkkVGNuTiP2Gc7mGENmyHA2BulM5RKy1JMY16sQjvF6EGYAvvg9zBcX
Aseuwou3
=knS1
-----END PGP SIGNATURE-----

--hzpwhprj3msl7flw--

