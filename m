Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B69C47089
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Dec 2022 14:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yu6p8wdO9IBzujoDWE0vJwclrwHQNWLyo+C+w0sdssY=; b=LwgtBgkky9QWupZJKhKyAKOvSH
	o9b2KGEb3OX9DB0aWutVACREQ1Y2RoKBi0l3scWWeZHpfXRCjRG7EVTpAWO/8BvPH+gL/nhwHiqG/
	f0RZN3jryftrBzHPvYbroy44DJa01HVoColi6xdXdgFpQHK7S7ccUMUpN9UyG0bvNMUFMgr71OHqP
	y8Jc+ok2o5N3auSdydWjVJrWpCjkuNw80XKqZGO4uQY6YkoQVnxiunofTEXeqU4HkN1wGsMlwKAvN
	4vZk6dGUdSj1OuR7Hg/Ef1j8mGvS9gscm2qMMk2UMvLQjRouZl5nT4YwNvO0pjptE0Uop92zlCXTE
	uvDQwzSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2CNl-0042H0-01; Mon, 05 Dec 2022 14:23:45 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2CNd-00425I-3y
	for linux-nvme@lists.infradead.org; Mon, 05 Dec 2022 14:23:41 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221205142331euoutp02953c65e22e1b00180a68457c76096a21~t67fKudH90349603496euoutp02i;
	Mon,  5 Dec 2022 14:23:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221205142331euoutp02953c65e22e1b00180a68457c76096a21~t67fKudH90349603496euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1670250211;
	bh=yu6p8wdO9IBzujoDWE0vJwclrwHQNWLyo+C+w0sdssY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=J8BoGMt/O2rTSujiUGYKoKFKLM3FuTC/Qi+S102mh+K/gKYZuGvzrfCHHAV0LCRhX
	 xAPVeTsLcM0G4Lrkft5wYdzaBclByHo+ZlQ6j8BvjKbULnKvV2CoXs5e60kXqvLPNO
	 TLP8vUgW4RtF18LFejvqp7b6Fo1gAlll9HNBdEZg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221205142331eucas1p134ec91872456bbba2015b7212ea80501~t67e9Q5Jc1540015400eucas1p1P;
	Mon,  5 Dec 2022 14:23:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 93.B9.10112.3EEFD836; Mon,  5
	Dec 2022 14:23:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221205142330eucas1p23d77ac8ec33b1b903e53692c469ee579~t67ecw0CF1365813658eucas1p2Y;
	Mon,  5 Dec 2022 14:23:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221205142330eusmtrp118ffb261a671025c721ebfd6871499d5~t67ecDvV31168811688eusmtrp1_;
	Mon,  5 Dec 2022 14:23:30 +0000 (GMT)
X-AuditID: cbfec7f4-d09ff70000002780-2b-638dfee3f76e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B2.28.09026.2EEFD836; Mon,  5
	Dec 2022 14:23:30 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221205142330eusmtip119fff265481f56814e43886c664abf04~t67eStbq22725527255eusmtip1U;
	Mon,  5 Dec 2022 14:23:30 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 5 Dec 2022 14:23:29 +0000
Date: Mon, 5 Dec 2022 15:23:31 +0100
From: Joel Granados <j.granados@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: <sagi@grimberg.me>, <hch@lst.de>, <chaitanyak@nvidia.com>,
	<gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v4 1/1] nvme : Add ioctl to query nvme attributes
Message-ID: <20221205142331.rv3fiumgirtkwexl@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="rtrnmk7rgyonhukd"
Content-Disposition: inline
In-Reply-To: <Y4Yd5zPs8KQf5hgr@kbusch-mbp.dhcp.thefacebook.com>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djPc7qP//UmG6x8xGHx/uBjVouVq48y
	WUw6dI3RYv6yp+wW616/Z3Fg9Th/byOLx6ZVnWwem5fUe+y+2cDm0dv8ji2ANYrLJiU1J7Ms
	tUjfLoEro+Hga+aCVqmKyRdWMTcwzhXrYuTkkBAwkbjdcJGli5GLQ0hgBaPEhs5LjBDOF0aJ
	d1t+s0E4nxklfm3tZ4Fp6bvTzQZiCwksB0os9IAr6lv7FGrWZkaJjYuXMYJUsQioSPSeuskK
	YrMJ6Eicf3OHGcQWEVCWuDt/JlicWaBS4tHFF0wgtrCAq0TrxytgNq+AucT63S/YIWxBiZMz
	n7BA1FdI3Jv0F6iXA8iWllj+jwMkzClgL/HqyUF2iEOVJL6+6WWFsGslTm25xQRym4RAM6fE
	3M0vob5xkZizqJsJwhaWeHV8C1SzjMTpyT1QNdkSO6fsYoawCyRmnZzKBrJXQsBaou9MDkTY
	UeLSjG2MEGE+iRtvBSGu5JOYtG06M0SYV6KjTQiiWk1iR9NWxgmMyrOQ/DULyV+zEP6CCOtI
	LNj9iQ1DWFti2cLXzBC2rcS6de9ZFjCyr2IUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhM
	Waf/Hf+yg3H5q496hxiZOBgPMaoANT/asPoCoxRLXn5eqpII74uNvclCvCmJlVWpRfnxRaU5
	qcWHGKU5WJTEeVdM6UgWEkhPLEnNTk0tSC2CyTJxcEo1MOlqubQtbWC5V+cWtzvsuaHG7umv
	kmOKz//wcq41k/qR8L9B1N3Aq9XLUDBjX99JkXMcd9M+PuiarPrr+hQxrTMaT0uMQk6aXZxo
	EW/8tpMlRTNbN7FZKevcY3fuNcJKDtd/qGyx92WOUXo54X7JlAlF065ea578M7b3jbbmudxb
	03/ISR2a61+nUdsXNCdR6bIdA1vq3iyGFJVKFcPCkz9DNifLu/e1Fh0JmcR4b2Xp0gip+Tmu
	Hz7svXFh4vVE1RV/H3Gt3i+Y533ziCfHBZcGE/1fzH2KkjN5o7ym2S1aapcu1FMXwLh/hq1o
	vtZjv5pfeazGTayBuanp11avLs/hvVm3o+LgO8UFrX+VWIozEg21mIuKEwG8dHvd1AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xu7qP/vUmGyw5qGLx/uBjVouVq48y
	WUw6dI3RYv6yp+wW616/Z3Fg9Th/byOLx6ZVnWwem5fUe+y+2cDm0dv8ji2ANUrPpii/tCRV
	ISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv42z3JeaCZqmKB/+P
	sTUwzhbrYuTkkBAwkei7083WxcjFISSwlFHicPsEdoiEjMSnKx+hbGGJP9e6oIo+Mkoc3PqB
	FcLZzCjRvbuVBaSKRUBFovfUTVYQm01AR+L8mzvMILaIgLLE3fkzweLMApUSjy6+YAKxhQVc
	JVo/XgGzeQXMJdbvfsEOMfQHo8T7BRCDeAUEJU7OfMIC0VwmsbBpM2MXIweQLS2x/B8HSJhT
	wF7i1ZODUJcqSXx908sKYddKfP77jHECo/AsJJNmIZk0C2ESRFhL4sa/l0wYwtoSyxa+Zoaw
	bSXWrXvPsoCRfRWjSGppcW56brGRXnFibnFpXrpecn7uJkZg/G479nPLDsaVrz7qHWJk4mA8
	xKgC1Plow+oLjFIsefl5qUoivC829iYL8aYkVlalFuXHF5XmpBYfYjQFhuJEZinR5HxgYskr
	iTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamCqZBYWLJvDesIyynFm
	bsmfi6X1tob8qv3NGVXB6WXuZyaxcPaG/PSuYmryXxDwSOBVjeJL5cM8oRMyfJ4KMaazFC53
	fVzK63WhW+deYeOhWWFHPTtyDmpw30/92bh3z5PU/a/PWc9ef37RjyO1TjNaSy8ZqEgpc/Cy
	2oo39Oy84L66L2zbmweWVXXuJwNrtlioWqcobjob5jNdoybm6J+cp1eeph/QOt++rPrFSsG6
	3xkZf9Y17nCMXmg+cZ65YFnqsSM777tXHdU/KfC+VeVZPEP+813xkRL+VXN3d999qDjtwtMG
	u5y//Wt1PVNefHJ+Gqv09dazNAMeB8/9GsXL1GbtNVk6fSfbVbarzkosxRmJhlrMRcWJAGfw
	LyJ0AwAA
X-CMS-MailID: 20221205142330eucas1p23d77ac8ec33b1b903e53692c469ee579
X-Msg-Generator: CA
X-RootMTR: 20221122092632eucas1p2648479360860fa80e35c964d99b54f0b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221122092632eucas1p2648479360860fa80e35c964d99b54f0b
References: <20221122092244.899894-1-j.granados@samsung.com>
	<CGME20221122092632eucas1p2648479360860fa80e35c964d99b54f0b@eucas1p2.samsung.com>
	<20221122092244.899894-2-j.granados@samsung.com>
	<Y4Yd5zPs8KQf5hgr@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_062338_612095_87745CED 
X-CRM114-Status: GOOD (  24.54  )
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

--rtrnmk7rgyonhukd
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 29, 2022 at 07:57:43AM -0700, Keith Busch wrote:
> On Tue, Nov 22, 2022 at 10:22:44AM +0100, Joel Granados wrote:
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
>=20
> I think what you have here is fine given the constraints you have work
> with, though inventing new structures to report things in existing
> structures still seems off to me. Is there actually any privileged
This is a very good point that I 100% share (Less is more! Specially
when you are maintaining it :).

This relates directly to Kanchans patch for allow-listing the nvme
passthru commands (https://lore.kernel.org/linux-nvme/20221020070205.57366-=
3-joshi.k@samsung.com/)
as we were originally going to add the controller identify commands to
that list but decided not to after discussions in ALPSS.

> information contained within the controller scope identifications that
I have not come across anything that points to privileged information
leaking through this command. Discussions have touched on excluding
fabrics and vendor specific commands in IO queues
(https://lore.kernel.org/linux-nvme/20220910053536.GB23158@lst.de/) as
well as noting that there is not need to check the read permissions on
the device for the allow list
(https://lore.kernel.org/linux-nvme/47e19485-f321-cd2a-3408-173434b04d01@ke=
rnel.dk/)
as the device file has already been opened at that point.

> require the driver prevent non-admin users from seeing? If not, I think
> relaxing that access restriction will set us up for longer term success.
Also agree here. In order to access everything contained in this patch
we would have to add both NVME_ID_CNS_CS_CTRL (vsl, wusl, dmrl, dmsl, dmrsl,
oncs, wzsl) and NVME_ID_CNS_CTRL (mdts) to kanchans patch.
I will send a V5 that contains this approach as the next progression of
the patch. We can have further discussion there if needed.

Thx for the feedback.

Joel

--rtrnmk7rgyonhukd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmON/tgACgkQupfNUreW
QU84Fwv9H/iM6BIeWOnmz4jcogbnsriCpFtTcOJnvzPmZjrnrXepqUhUaq1f+/+P
fd2wO71aCneN2RWSwrgg80lC94hh/qa92F3MAjIVpKZtcuNOJwzMiazhYHhvzYT8
85Op6RuzVaAjUL/uz/1V6QvmvrLTQ0YWDFMjwz3lQxPZEgo/cK7JJHaMlwmeZc+Y
azpnK9rhD2XvSQWTnljfmxpXwKWCQG2UXcOJ8yJ1onNHltmCWE8I2Ej7RlDrI4Da
Hzqzb2IFZSvHun7RuLANpdAu4f9n/xF+awTuxl4BPRiRVY77a/PYGQLV2O1TVCnn
GAP42PuceKlRnZ88YYmNCBJYrupdOwz3TPDw8EEOVC7M6d/bYww2Ewf73XrKVZdc
FTzjZxvPEz5TGznflv1Atab0AuZcYNN6TgPP+8shplgTn2keii8IragGO8VpYTar
99MsV0r8o3aMSl/1ZjjSpSgsGxekBtBTQY7e8AerwfprLnDFTy7ca58kKmb+YJ8z
E4kAnHeq
=ANvS
-----END PGP SIGNATURE-----

--rtrnmk7rgyonhukd--

