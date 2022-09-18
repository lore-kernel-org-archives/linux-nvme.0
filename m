Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C752BECAAD8
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Sep 2022 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BAvemUPGm1x4e/9tgG89yyCr09kQhIzyvXTXZ0RyDWM=; b=1XyRm1GiHrJtHV6TS1QHG2gCB0
	lEgVYJUpJe5YnCZdCrMteos2Q4vE0VfdFnaAwFoMxFwTdz+Sj2kGt6af4ymS48XAwXsRKg4HI/tXv
	8vsZUMYh/8tkaVJ06/7uXSf/43VxFIBH0QmivbZcLbxDl4PYSocMVqaUXBhEhdz42fYUObo6Lh5LD
	WKdFQsq9aqYAb+4Ctku3SmMjV801XPQLxWIuXr5wNl5X8GPOSadgpb9Qg+4HTuP21XwyEK3rEIdi2
	vg2IleTBQa/BGJzKTzi4sUhQlg7gC1xbC66k8plX25lPeJclO1R+n5Cd/PqF8xKdk9QM1grijzP7W
	uLpxU7EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZxUL-000nw2-UR; Sun, 18 Sep 2022 16:49:49 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZxUH-000nob-Py
	for linux-nvme@lists.infradead.org; Sun, 18 Sep 2022 16:49:47 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220918164938euoutp01b4b5f7f62b6edefc7d9e7dba56f88ace~WAmzGPIgF1350913509euoutp01B;
	Sun, 18 Sep 2022 16:49:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220918164938euoutp01b4b5f7f62b6edefc7d9e7dba56f88ace~WAmzGPIgF1350913509euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1663519778;
	bh=BAvemUPGm1x4e/9tgG89yyCr09kQhIzyvXTXZ0RyDWM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Cn9MJo2X1M8Pg3CrlgxOKZocrWSsIvq5AIlucQoh8jPe81PD6FBYIKU1lKnPZi9Qs
	 N6Ju64eufUjS3GLHJyXKJ+AVRunk0nOSkIFf3kgCUHiIlJcpkAx3GQKCeCTTWzYjdS
	 PvGbuNiPBO/dlDvYYxRytgHPJvLM6htX3XYDpZ7E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220918164937eucas1p216c910ffbd41ae2441d2734e0ad7ea3d~WAmyCNAF02334423344eucas1p2T;
	Sun, 18 Sep 2022 16:49:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 9C.60.19378.12C47236; Sun, 18
	Sep 2022 17:49:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220918164936eucas1p2a0acde31ca7b978e767a0c426fd7e990~WAmxbctmy2334423344eucas1p2S;
	Sun, 18 Sep 2022 16:49:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220918164936eusmtrp1c04d5ec400aa867a234cbc6d755b7d4e~WAmxa1e2s0203302033eusmtrp1O;
	Sun, 18 Sep 2022 16:49:36 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-96-63274c21687c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 35.FF.07473.02C47236; Sun, 18
	Sep 2022 17:49:36 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220918164936eusmtip1712820dcd1a193c93ed5ff6025537ee8~WAmxMoV383228632286eusmtip1E;
	Sun, 18 Sep 2022 16:49:36 +0000 (GMT)
Received: from localhost (106.210.248.110) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 18 Sep 2022 17:49:31 +0100
Date: Sun, 18 Sep 2022 18:49:30 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: <hch@lst.de>, <axboe@kernel.dk>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<javier.gonz@samsung.com>
Subject: Re: [RFC 0/2] nvme command whitelisting
Message-ID: <20220918164930.zssraggejm5b5tde@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="ajoqral226mxzdhp"
Content-Disposition: inline
In-Reply-To: <20220909163307.30150-1-joshi.k@samsung.com>
X-Originating-IP: [106.210.248.110]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djP87qKPurJBscPiFmsvtvPZrFy9VEm
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTxuHy21GPTqk42j81L6j1232xgC2CN4rJJSc3JLEst
	0rdL4MqYvP4tY8E2+YoXr9cwNjBulOpi5OSQEDCRaNrby9LFyMUhJLCCUeJO624mCOcLo0T/
	yuWsEM5nRomLR8+ywLTM/XyaESKxnFHi1vMmRpAEWNX6D/UQ9lZGiWX/fUBsFgFViZ0fDzKB
	2GwCOhLn39xhBrFFBNQlOqafA1vHLNDLKHHs7jawQcICBhJnT34Fsjk4eAXMJZYuKAMJ8woI
	Spyc+QTsCGaBColra9ewgZQwC0hLLP/HARLmFLCU2LHrFRvEncoSB5cdYoewayXWHjvDDrJK
	QqCbU+L72qmsEAkXibkXbkI1CEu8Or4FqkFG4vTkHqiHsyV2TtnFDGEXSMw6ORVsr4SAtUTf
	mRwI01HixnUpCJNP4sZbQYgj+SQmbZvODBHmlehoE4KYoSaxo2kr4wRG5VlI3pqF5K1ZCG9B
	hHUkFuz+hCmsLbFs4WtmCNtWYt269ywLGNlXMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn525i
	BCar0/+Of93BuOLVR71DjEwcjIcYVYCaH21YfYFRiiUvPy9VSYRX1VMlWYg3JbGyKrUoP76o
	NCe1+BCjNAeLkjhvcuaGRCGB9MSS1OzU1ILUIpgsEwenVANT9PaamCexuiuvvi0sKpb0K6qb
	sz14+XdnjvKUgNAlN3S8v/ydlyeu+ubCXse7NlfNOK0mv4mc5XAwfKpV4c9qn45VM8+w5Vav
	m5UkdY5xTaCRbQJz9IHqSedk2uZyJnAa7W3e8Sp+b97MKMOfJgmexqkxMwouNBp2ntx6s3vJ
	rfs98+IeekUoS0l4OaZfkZkpI/S4WKNs4V7+lqdN01737A5oeHA1s9Bq5u+i2kLF15HyX6MF
	v6o0/To721lrec8Sfivle1+2hCY6zCxq9Tz9MEB40gO7aztvXbwnF5Vpr8Z99lLUhE+xX7RL
	eCY8efE9P39dbM3F2ClvqxdI6Tt5Muxwnbph3WcDzs/5YbFKLMUZiYZazEXFiQAeQwAh0QMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsVy+t/xu7oKPurJBhtXalisvtvPZrFy9VEm
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTxuHy21GPTqk42j81L6j1232xgC2CN0rMpyi8tSVXI
	yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mto6GtiK9giX3F+zjKW
	Bsb1Ul2MnBwSAiYScz+fZuxi5OIQEljKKLHk+GJ2iISMxKcrH6FsYYk/17rYQGwhgY+MEp3b
	kiEatjJKnNzYwAKSYBFQldj58SATiM0moCNx/s0dZhBbREBdomP6OSaQBmaBbkaJ5e2TwBqE
	BQwkzp78CrSag4NXwFxi6YIyiKE9jBIT2y8wgtTwCghKnJz5BKyeWaBMorv5AitIPbOAtMTy
	fxwgYU4BS4kdu16xQRyqLHFw2SGoo2slXt3fzTiBUXgWkkmzkEyahTAJIqwlcePfSyYMYW2J
	ZQtfM0PYthLr1r1nWcDIvopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwdrcd+7l5B+O8Vx/1
	DjEycTAeYlQB6ny0YfUFRimWvPy8VCURXlVPlWQh3pTEyqrUovz4otKc1OJDjKbAUJzILCWa
	nA9MKnkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUym3N/9Zyq4
	yjF42H65dEm6eFaCxkO2Zd4LWW2fcU4v3ayts+Fl7oPV1U+nRM/q/nk3vOuXFduD2KnX65KC
	D5rH1Thb5DJxSbvInJe6/Pe+R13Rj96ND6XkAmKOB/cpL5l3tbHH1HZfx6Gdsd0ik0WiQmft
	XDC/W1+9xdgzXkFlwkaTnmu6l5ROBk3pvLf3cYuogoNSxpmeh3EL9huHs+l+ay9a13/tig0H
	T7t1fcCJPfGLLPbUdptcuOFwmHviE+uUv4J3AmbfXHOJM3OmdJbXK/nJwdsntCYclzOeI2Oc
	d0D81sezsneKChSj1Db9Cm4VNjNh2c7Q9tZYf0dLWXFrZebFdCm379eOzpwprsRSnJFoqMVc
	VJwIAOjRTvpyAwAA
X-CMS-MailID: 20220918164936eucas1p2a0acde31ca7b978e767a0c426fd7e990
X-Msg-Generator: CA
X-RootMTR: 20220909164315epcas5p17de296f5c0796ecf92fe3d0e4a020901
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220909164315epcas5p17de296f5c0796ecf92fe3d0e4a020901
References: <CGME20220909164315epcas5p17de296f5c0796ecf92fe3d0e4a020901@epcas5p1.samsung.com>
	<20220909163307.30150-1-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220918_094946_278408_88830A94 
X-CRM114-Status: GOOD (  28.48  )
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

--ajoqral226mxzdhp
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Kanchan

On Fri, Sep 09, 2022 at 10:03:05PM +0530, Kanchan Joshi wrote:
> Hi All,
>=20
> Passthrough has turned much more useful than it used to be. Specifically
> it has begun to offer
> - Availability: via /dev/ngXnY, for any current/future nvme command-set
> - Efficiency: via io_uring driven passthrough
>=20
> Now that user-space has more reasons to pick this path than before, the
> existing CAP_SYS_ADMIN based checks are worth a revisit. Nvme-native
> applications requires 'querying' certain information (such as lba-format,
> namespace size, log-pages/get-feature etc.) to start doing io on the
> device.
> Currently both io and admin commands are kept under a
> coarse-granular CAP_SYS_ADMIN check, even if device has successfully been
> opened with write access. In example below, ng0n1 appears as if it may
> allow unprivileged read/write operations but it does not (same as ng0n2).
>=20
> $ ls -l /dev/ng*
> crw-rw-rw- 1 root root 242, 0 Sep  9 19:20 /dev/ng0n1
> crw------- 1 root root 242, 1 Sep  9 19:20 /dev/ng0n2
>=20
> This series attempts a shift from CAP_SYS_ADMIN to fine-granular whitelis=
ting,
Please correct me if I'm wrong but the objective is to base the
whitelisting on the mode of the device file. Right? So if the mode is
write all the "Write" operations will be allowed. And "Write" is
anything that leads to a change of state in the drive. right?

> similar to what SCSI already has.
>=20
> Patch 1: contains the whitelisting implementation. Patch-description
> outlines the policy.
>=20
> Patch 2: Changes the sync/async passthrough to employ whitelisting.
>=20
> Purpose of the RFC is to seek feedback on below two points and path
> forward hereon.
> - Whitelisting scheme as described in patch 1
IMO, Whitelisting is the way to go, It protects against new operations
being allowed when they pop up (They can be added to the white list if
needed).

There is a patch by Stefano Garzarellas
(https://lore.kernel.org/all/20200827145831.95189-4-sgarzare@redhat.com/) t=
o the
io_uring infrastructure where he whitelists the io_uring calls that can
be executed by the guest. Could we piggyback on this io_uring
infrastructure and create an extension for the nvme passthrough?

> - Driver-defined static list (current one) vs dynamic list
>   (mutable through sysfs or new admin-only ioctl)
I like that the control is left to the kernel in the driver-defined
static list, but I also like how the user can just decide what he wants
to do with the hardware for the dynamic list. And with a static white
list there is also the possibility of breaking some configuration that
someone is using out there (e.g. the one described here
https://lwn.net/Articles/193516/).
This is definitely a tough decision.

Best

Joel

>=20
> Kanchan Joshi (2):
>   nvme: add whitelisting infrastructure
>   nvme: CAP_SYS_ADMIN to nvme-whitelisting
>=20
>  drivers/nvme/host/ioctl.c | 106 ++++++++++++++++++++++++++------------
>  1 file changed, 74 insertions(+), 32 deletions(-)
>=20
> --=20
> 2.25.1
>=20

--ajoqral226mxzdhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmMnTA8ACgkQupfNUreW
QU8hBwv8DTvkRrwtCd1lat4EiVIFAQjT09Z3ZjkN7fFWmtk+EzrqeJIJsFp0QT34
cwmmlQCdwHIYYZbmKCyf5SWJKxzE23if50hiHnLXjdy4jUKDjEiKWKw0UZRtNycB
lZwFnOX6F8U3yM1kvTf173bysPR6rb0AnTUNo6vc946fZICpi7d6Tj5qcM8T7gaw
eUtV5JfNUViZUHlsWrK3mabiKe1dNwnSCWr4W2n/8mlOfabmBOpf99IDeXFcBoBN
y50coa9lrBbzpU4XaEOrOagt96nxO/7OG9sVEmhyP7kswxxN4pLEkNPkULYrUPIi
nB5+zooI1FALJi9TeoCXRfFsIT2rx2J8PiuVDLTPo68WmKa7UmUbFrrJsAaHAPq3
jM69/OYSO04ds3uSz+1QMJTcXBsF/YmeEh0xad3fen3IFKmKNf4WypSpv2/d7Ta7
S2fjDuFnVudSmX+W+cVrYG24e1OdLhS9Vdzy8gkDsqkX9zSQZxCU5pU+yEiDn25o
Bk7wvZ9p
=qlsb
-----END PGP SIGNATURE-----

--ajoqral226mxzdhp--

