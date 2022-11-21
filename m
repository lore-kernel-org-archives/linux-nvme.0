Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80451C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 15:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g8KrOm0SeCIJEnuPaMk8xOJJmSWv+xhg+SCSjaADNlo=; b=I1XqDKPbXwEYwCFimJkh722IMh
	TND1R0hZQmWcuxuPR5i9X8DTqkZ40Du4AbZcxQPcFzn3UIUxJfwYSpUJ53PMDavznDVsNYqYE6+1i
	ql0x8DE7RNl5Y330IZ0D8sYcNXFG9y0r/IVwX+bc+yJEUZR3aHEtxxsuc1mnprA9gII1/TjpLhk03
	btXjo8zni05PuZQi3KFS23F8h7cp4TGNP1hF1hAI3DcYhmJzsDdhz/9CoVOlSjKFRFHJu+73BkMbN
	Pec+/rwTjaix6OjmlcPsN0O+4JeF+zu3HWIiM+SZzotUe97Mr6TMIt3oGCeKB6rzo7Tg3+YvNn56G
	a762PtLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox97b-00FQ9z-Eu; Mon, 21 Nov 2022 15:54:11 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox97T-00FQ60-TV
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 15:54:08 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221121155402euoutp0286f606dfb48ef1b14d10df3af10a921f~ppIhb9Prj0168201682euoutp02e;
	Mon, 21 Nov 2022 15:54:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221121155402euoutp0286f606dfb48ef1b14d10df3af10a921f~ppIhb9Prj0168201682euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1669046042;
	bh=g8KrOm0SeCIJEnuPaMk8xOJJmSWv+xhg+SCSjaADNlo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=p+CePpKEoBt3APIX7ouPOBl/Tcf8mwFgydZw4I+F5Ih1FISz96FpjK1SVXtaSWRXN
	 WiPaz6R6W1pvuHBioM0I+o+Kz9cGzHe8KDTrT9ZP3fylU+UuvYBgYNWlPfNRiXfgOq
	 H4zLlUJKn8xBoSjhET3ad4TkfcG0f4Iwav/torAs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221121155402eucas1p218b42a7996270e6ac6a0f32345d2d337~ppIhRKNFl2062220622eucas1p2T;
	Mon, 21 Nov 2022 15:54:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 04.18.10112.91F9B736; Mon, 21
	Nov 2022 15:54:02 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221121155401eucas1p13006cb9dbd8c6772e3db3888bf75b8e3~ppIgpg5Uy0780307803eucas1p1R;
	Mon, 21 Nov 2022 15:54:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221121155401eusmtrp262fa0236ce4243edb4d9f45b7f83d2d9~ppIgobKki3114731147eusmtrp2M;
	Mon, 21 Nov 2022 15:54:01 +0000 (GMT)
X-AuditID: cbfec7f4-d09ff70000002780-5c-637b9f191953
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 34.9D.09026.91F9B736; Mon, 21
	Nov 2022 15:54:01 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221121155401eusmtip246fc7feab8a5cc088fe49184013ade28~ppIgZ_wzs1190811908eusmtip2U;
	Mon, 21 Nov 2022 15:54:01 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 21 Nov 2022 15:54:00 +0000
Date: Mon, 21 Nov 2022 16:54:02 +0100
From: Joel Granados <j.granados@samsung.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "gost.dev@samsung.com"
	<gost.dev@samsung.com>
Subject: Re: [PATCH v3 1/1] nvme : Add ioctl to query nvme attributes
Message-ID: <20221121155402.e6tvt4ehyhejx2ln@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="6euvmiffeee4telo"
Content-Disposition: inline
In-Reply-To: <150ffa65-3798-3f8c-8594-e8b29f7511be@nvidia.com>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djP87pS86uTDb7e5LZ4f/Axq8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGsVlk5Kak1mW
	WqRvl8CVcbBlMWPBXMGKBSv3sDQwPuDrYuTkkBAwkeg+tYGpi5GLQ0hgBaPEhEnfWSGcL4wS
	J9oPs0A4nxklZncsYIVpebb5NjNEYjlQYvJkZriq+z/boYZtYZSY1n+NEaSFRUBV4vTKNjCb
	TUBH4vybO8wgtoiAnsTVWzfYQRqYBe4ySjxctYoJJCEs4Cpx7vByti5GDg5eAXOJtcdVQcK8
	AoISJ2c+YQGxmQUqJNb+vMYOUsIsIC2x/B8HiMkpYCfR2RUGcaiSxNc3vVBH10qc2nIL7DQJ
	gX5OifNb97BDJFwk/ncvhCoSlnh1fAtUXEbi/875TBB2tsTOKbuYIewCiVknp4JdJiFgLdF3
	Jgci7Cjxds4GqDCfxI23ghBH8klM2jadGSLMK9HRJgRRrSaxo2kr4wRG5VlI3pqF5K1ZCG9B
	hHUkFuz+xIYhrC2xbOFrZgjbVmLduvcsCxjZVzGKp5YW56anFhvlpZbrFSfmFpfmpesl5+du
	YgSmrNP/jn/Zwbj81Ue9Q4xMHIyHGFWAmh9tWH2BUYolLz8vVUmEtz6mOlmINyWxsiq1KD++
	qDQntfgQozQHi5I4L9sMrWQhgfTEktTs1NSC1CKYLBMHp1QDk9rekht5B2QXPTO6H6J65Jnh
	EePzgjOzJE+azcy6PUUnTY7/wl/jpL60LVO4/X9dfB5fF7O9VfLEwbN2nm26TCJe7vETSl7t
	Dgw6mZi+5+OPZfK3jPes/sPW8tzvefGZBROf9n+IDZPre3K47a8hi/zE6Sy747PEXrOv2pz3
	amoOf5QSZ31UxdJnrAnbLdL2yGmaLjSz9BK4OaNiUYzOpL9yh1R7mMSDGYT5Vc8/yJ3zuUXn
	d6uDQiL3SqGZO/nnnn+fcPrDFc1lG3z+8+5JfdI2yaEl9ZbOtqp1mQ/8lTZKa+5TecYf+6+H
	sflGtVmF6XS5nMR9ayv/vFuj5L1zmmxB6tP0uTGx0/51PXU9q8RSnJFoqMVcVJwIAK1Wy4jU
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xe7qS86uTDdrWylq8P/iY1WLl6qNM
	FpMOXWO0mL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB59Da/YwtgjdKzKcovLUlV
	yMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeN1ynL1gtmDFuUfi
	DYz3+LoYOTkkBEwknm2+zdzFyMUhJLCUUaK//R07REJG4tOVj1C2sMSfa11sEEUfGSWuPetg
	gXC2MErs7N/NBlLFIqAqcXplGyOIzSagI3H+zR1mEFtEQE/i6q0b7CANzAJ3GSUerlrFBJIQ
	FnCVOHd4OVAzBwevgLnE2uOqIGEhgXVMEtvnVoPYvAKCEidnPmEBsZkFyiT+zGtlBClnFpCW
	WP6PA8TkFLCT6OwKg7hTSeLrm15WCLtW4vPfZ4wTGIVnIRk0C8mgWQiDIMJaEjf+vWTCENaW
	WLbwNTOEbSuxbt17lgWM7KsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECI3fbsZ9bdjCufPVR
	7xAjEwfjIUYVoM5HG1ZfYJRiycvPS1US4a2PqU4W4k1JrKxKLcqPLyrNSS0+xGgKDMOJzFKi
	yfnAlJJXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cDUY37IVfaP
	6P9NTv0Rzp8PrbVatvvQ5TM5nktO2E3MT8l5NT1Z+ZUw586lz79bKLTlGU+6p7DD6W7qtg2/
	73vFH6+fqbFnZXjDmhZlJ6UY30WhD3qaQi5kqO/LCq5eFMuhvmr6W6+Qq1u4HnxiljDc+/R+
	RNo2g3aV05d9BN2zqu7qfVLKzX7/brtu8Huri3Eyz+9NPV2iyt2x/X2a1SbNUKuXn14fYlHi
	vPrml3S6xv+UQzvWsG/6Mtvjw9q1b797tN/dYG2xVbf99sb1luab1tw0/cB19/6EDf+X9vS9
	K7962Xj+pcRNfaWbPAPPTk0Szuz2T8o4Grm70FHt2PE7is4TEgLVs8wYctr4N12JVWIpzkg0
	1GIuKk4EAPxldxtxAwAA
X-CMS-MailID: 20221121155401eucas1p13006cb9dbd8c6772e3db3888bf75b8e3
X-Msg-Generator: CA
X-RootMTR: 20221117141718eucas1p11d0b9f10ff4c0ca6ba865251af775fc8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221117141718eucas1p11d0b9f10ff4c0ca6ba865251af775fc8
References: <20221117141337.3719372-1-j.granados@samsung.com>
	<CGME20221117141718eucas1p11d0b9f10ff4c0ca6ba865251af775fc8@eucas1p1.samsung.com>
	<20221117141337.3719372-2-j.granados@samsung.com>
	<Y3gIl1d8tVsx/+NG@kbusch-mbp.dhcp.thefacebook.com>
	<150ffa65-3798-3f8c-8594-e8b29f7511be@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_075404_271391_E4C9F4DC 
X-CRM114-Status: GOOD (  21.18  )
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

--6euvmiffeee4telo
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 19, 2022 at 12:04:43AM +0000, Chaitanya Kulkarni wrote:
> On 11/18/22 14:35, Keith Busch wrote:
> > On Thu, Nov 17, 2022 at 03:13:37PM +0100, Joel Granados wrote:
> >> +#define NVME_IOCTL_GET_ATTR	_IOWR('N', 0x50, struct nvme_get_attr)
> >=20
> > Isn't the ioctl's number derived from the sizeof the parameter? IOW, if
> > you add new fields to the struct in the future, the ioctl number will
> > change, breaking older applications that were using it. I don't think we
> > want to keep adding new ioctl's to support legacy users, so probably
> > padding that struct with plenty of reserved space is the way to go.
>=20
> This is exactly I've asked explicitly to make the size of the structure
> close to nvme command size (or even better to nvme identify controller
> data structure size) so it will be future proof and we can add new
> parameters.
>=20
> Instead the rsvd field seems to be removed in this patch.

By including the size of the struct in the ioctl we do not need to
pad it. We can add all the struct members that we want in the future as
long as we do not remove any that already existed. In the same way that
it is implemented in https://github.com/torvalds/linux/blob/master/include/=
uapi/linux/vfio.h.

>=20
> -ck
>=20

--6euvmiffeee4telo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmN7nxkACgkQupfNUreW
QU9OLAv/YjrBnQuPieJsAqeFgSXW6oXR9ClpCEO4OMX22ZUQnIZEh/evw3XLpGew
540KJIhaA51HDeDe1rBEl5bs1librQ5ezLJCGEQ9+CEOQPfzDnk2k9bjIQYTogUq
rtdG3oethBlDxFWVA1+7jeNmlP9icHuIk+oRipPIQGTztedkJED1OCgt6WpsTJt0
9k5lxnWpkQUNT/oKrowdBud31ItlPdWNJ+UVvduumPHAO6PYEggS/3/K5jayhqHO
9GllZZrPH5dLb1/ZTj4rYA9PPV3J5z/M1MrdtJz6ZobSGJNX9BHdH6VvUvPjvbWQ
DP9P7oHaQtYP4Km08YSpm6aKkOvCApMuglopZZatkra2EcWYlBKjrMfUoVfPSXwi
g+KqKjWqnL2E4AfeoPq8Pv51znXJQyfVtZ7EJ8+elQKfou55fEj/PiLxojqrZMPE
w6lBRYwKQnhygXhujE1C86FUGY231DKWqzLcpOfkvW6teevZbagF1DmYZyd3DZAn
mMArsy0M
=KDA3
-----END PGP SIGNATURE-----

--6euvmiffeee4telo--

