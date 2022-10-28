Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AA5C38A02
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 15:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FNmMUVZ/lM7TBZSQZwCd6/hc7vwS0/PutAIVuwhTYfU=; b=wTTJXWPkS7RF1GpQGRRVrwTJHQ
	ns1jH0c0mn+3SO+V6xyhcd0SFYDUEpEIoPQeCoSJ71jYqR+Rhk+eJJowfhLIAul/KwC2ahpuOn3ri
	6BlcVWjhwF8SV8lr1gQPQYaDLLAUxq6+18hw7wSic+3sebZ5ObJVAtAKk5ZEmltgDc/jhLaxr/MA6
	tlfQLk17ZVTfdaEn+uNBmtmmUqXK3+ocMnSH2zs79umTsUSYPDjpMVJTzrc7kpmC4V+6VPr0VVbkd
	JqnQb+/FtfUyX0bsXoDlUrLcnX6gug/wxLiPnNJwY7Z3cXJ9JfdG4sWOfVg8cEWNE9cg/VwdGA+Be
	G81PW4XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooRk5-000i2x-Td; Fri, 28 Oct 2022 15:57:57 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooRf4-000fhL-MM
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 15:52:48 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221028155234euoutp02348d657de965f3e800ce8fb15a0738c8~iRoYlbAEE0124901249euoutp02h;
	Fri, 28 Oct 2022 15:52:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221028155234euoutp02348d657de965f3e800ce8fb15a0738c8~iRoYlbAEE0124901249euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1666972354;
	bh=FNmMUVZ/lM7TBZSQZwCd6/hc7vwS0/PutAIVuwhTYfU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=iR7P8VcVWuA2FRpupvCKb6ZtREhMpnQ1RSVUTvtv/GMB+RlqCiPAqK9YQtjo0NXXl
	 q52OWoxma9PSTa2bUlNDNb2RpouO3psvWmRjJxbBtLLF3lZuI40L1Qp6nsMh+i5bsk
	 r0VUt6YNUnhnv1uDaktBxloaZWaqrMflEdCMLTU4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221028155233eucas1p27ce569193feb8a42ccf26a5ac751f699~iRoYZPy7C2188321883eucas1p2C;
	Fri, 28 Oct 2022 15:52:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 6F.84.19378.1CAFB536; Fri, 28
	Oct 2022 16:52:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221028155232eucas1p1f5f8d566f2e6ad07488c027e78bac6fd~iRoXcerZo2405324053eucas1p1S;
	Fri, 28 Oct 2022 15:52:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221028155232eusmtrp2befad529913309b3527241e0b470c0ce~iRoXb4Utv1394013940eusmtrp2O;
	Fri, 28 Oct 2022 15:52:32 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-ee-635bfac138a5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 19.3E.07473.0CAFB536; Fri, 28
	Oct 2022 16:52:32 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221028155232eusmtip1808f848557701e9d4fe3acbc37a6b4f3~iRoXRV9RK0089300893eusmtip1Z;
	Fri, 28 Oct 2022 15:52:32 +0000 (GMT)
Received: from localhost (106.210.248.238) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 28 Oct 2022 16:52:31 +0100
Date: Fri, 28 Oct 2022 17:52:30 +0200
From: Joel Granados <j.granados@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: <sagi@grimberg.me>, <hch@lst.de>, <linux-nvme@lists.infradead.org>,
	<gost.dev@samsung.com>, <joshi.k@samsung.com>, <javier.gonz@samsung.com>,
	<p.raghav@samsung.com>
Subject: Re: [RFC 3/3] nvme : Add ioctl to query nvme attributes
Message-ID: <20221028155230.cf2iktk6ut3qbzns@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="qnaz3v773thgqina"
Content-Disposition: inline
In-Reply-To: <Y1vskd0uY308uSf4@kbusch-mbp.dhcp.thefacebook.com>
X-Originating-IP: [106.210.248.238]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSWUwTURSGvZ1hOi2pDgXDEbdYBE1FkCChxhWjhmoUQ6IPLRFLGcEU2tKC
	gpFQRVBBwaCNUqMUbcoqWmgR5EGpC7Lji6JxSRA0ikpQ3EXteDWa+Pad//z/uecklybEDq8A
	eqc2gzVoVakSSkg23frcu7Dti1K9qMg9RVZde5MnK3XfRbJy+zBfVj8ySq4iY/oeO8iYhprD
	VEyjLTem9b6J2kwqhMuS2NSdu1hD2IrtwpRxW7C+wTvr+dBtLxPKExYiAQ3MYihyuHgci5kq
	BBVnBIVI6OFxBJcODPxuvEPgeuIJ0DjwNA57KhHU2d4gXHg8dysrKFy4EFQfusbn0iQTBCcK
	v1IcU0wI9L16SHDsxwTCo/IyLy5AMHUI8osu/HrOl1kF/R8bEcciJgoqrvWTmH2go2yI5NYg
	mCwoLQSM06HyO805BMxKmDhylY8XDYSuYTk+Mgc6nQ94mPMEUP0VMK+BFwOHEWZfeNnu5GOe
	AT9ayn/7NdBy4gqBWQ+WDjOFxy+F4u5ULEdDr9ONsDwZBl77cDLhwdKmkwSWRXCoQIzdwdC8
	34WOoUDLP0dZ/h5l+XuU5decELC2vqX+kxeAvWKEwLwc6utHSSvi1yB/NtOYlswaI7Ts7lCj
	Ks2YqU0OVevSGpDnJ3V9b3/fjKpejoW6EY9GbjTXEx68VNuPAkitTstK/ES5PUq1WJSkyt7D
	GnQJhsxU1uhG02lS4i+iTknVYiZZlcFqWFbPGv50ebQgwMSLrvW2lQaNtK/P3hSlKDBfj1sd
	Z469kWJrPnX1niF8o2WFKfEkL18xPHrhmzvXtXGmX6SiRK7tihjMd+Y4VlcGpo9FJ32z+q/8
	EG3n3bHzmZKt6uIhxZctJREhpx9JjjePnj74TvpCkc4fzEtqLXq6oam4LirSYVU6Ws7XzGsL
	OyDd0XiOls9eu6GWBHp+jrIjVpOc8GlvWOe6SIt87EZe1jb7NHNG/OXBJZM1+/qr9LLn4bfC
	r4zbnMpZ+k1zu2b4au81FZimhvSkx+q6zzWmVLV9nKRbIL+YGKRfW9ZHjfdKbfc79KyMemZ9
	PHF0ops1l3vHv5lzNrFvSfYZjU+whDSmqMKlhMGo+gl1iBuFxAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7oHfkUnG1ycpWuxcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAlii9GyK8ktLUhUy8otLbJWiDS2M
	9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DKWPf/CXLCBu2L/4afsDYyNXF2MHBwS
	AiYS3Y+Duhi5OIQEljJKzH94ir2LkRMoLiPx6cpHKFtY4s+1LjaIoo+MEp3bdzNBOFsZJfYt
	+8wMUsUioCoxpes3G4jNJqAjcf7NHbC4iICyxN35M1lBGpgF1jBKtHavZQJJCAs4SFz4vpkR
	xOYVMJdYeOACC4gtJHCXSeLu5hiIuKDEyZlPwOLMAmUS+6ZNZwQ5m1lAWmL5Pw6QMKeAvcTf
	nv3sEN8oS5x+6glxdK3E57/PGCcwCs9CMmgWkkGzEAZBhLUkbvx7yYQhrC2xbOFrZgjbVmLd
	uvcsCxjZVzGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTG6bZjPzfvYJz36qPeIUYmDsZDjCpA
	nY82rL7AKMWSl5+XqiTCW382OlmINyWxsiq1KD++qDQntfgQoykwECcyS4km5wMTSF5JvKGZ
	gamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA5N4KNe1lade792o35/xNn0j
	y/XuWYt3M5la6/2edafpp2zZLT7j81uvrL26ITCkO+oJ20vGBr3KT2r+Jd3z3vm9DbLXE/ni
	YnH/1Hn7il0cyqVGt8StZsxa/Gu5yZW9X9Zqrtzb8i6/ZcGhvWLJhl+lVu67rMfxOOikhcPd
	9p7Je457Gn6pir4Xox772j72lxZb29HSF7MXpi9mFMzfslLjbaVVCbdW01feS2I3K1wiLpn3
	HFjWtErXctW1CwEe++8yKZe6rvxkmjMl457PhSkRtVN2bbnDlTCBS3vqtYQvk7vlubN5L5Ql
	Zf16bHGETWkx45GZLF929bm5LT6exvQxdMdi9ffG+6xSebNiJ21TYinOSDTUYi4qTgQAux5N
	gGgDAAA=
X-CMS-MailID: 20221028155232eucas1p1f5f8d566f2e6ad07488c027e78bac6fd
X-Msg-Generator: CA
X-RootMTR: 20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab
References: <20221027155724.1161670-1-j.granados@samsung.com>
	<CGME20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab@eucas1p2.samsung.com>
	<20221027155724.1161670-4-j.granados@samsung.com>
	<Y1q4Cjg1cv9w+YWR@kbusch-mbp.dhcp.thefacebook.com>
	<20221028103827.o7uhl36qavkpx22d@localhost>
	<Y1vskd0uY308uSf4@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_085247_031542_DED8C933 
X-CRM114-Status: GOOD (  13.72  )
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

--qnaz3v773thgqina
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 08:52:01AM -0600, Keith Busch wrote:
> On Fri, Oct 28, 2022 at 12:38:27PM +0200, Joel Granados wrote:
> > 3. And the variables that are not in struct nvme_ctrl. Here, we have not
> >    option but to make an IO.
>=20
> You do have another option: we have historically added new fields to
> nvme_ctrl to cache parameters that are repeatedly referenced in other
> contexts, and this usage appears to qualify.

Agreed. That is yet another option. Will do that for my V1.
Thx for the feedback

Best

--qnaz3v773thgqina
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmNb+r0ACgkQupfNUreW
QU8h4wv7BsZc8Qr6cIZNUelRzi5WWEL17IDrf+JkF5KNhJN1J7IDhc/GGlChftKS
8ygpWsXskgyqHU3TdY5P5GLDTYarrFQ4srrYGak3F95GvpwqD+P8CZrJTVJgwV+m
nVMAWnf+2gQl1DVAq1uScJqHaQBA+ob+AG9oiyO3AmIkx2NekPpOiKkaOYuWh8aW
R0DZDBKlHkeevqMCX4jxYVHFmXrYh8+qgtFc7kx0f17UbNP57/hPJ0Iv1tRfzfHQ
3CDgSWcSRLmiRZ1NmCzxqUdkpAXPiA9gRuVIQ3zw20tcPNPleSJEjWC1ZoKrDrK4
vc4FIu49TXXo0Ak04xIu9m7mA1Wa1Tn7nwzSJdU6H/rygvR0y/M4cOHKhLZh3CL8
Kw/wqMYSfcvK1LV78kCm3u/yCu8OEaAc+OtWihQIc47sbu+5kAKkMfJiRk1rksPC
If5xgWymEVehInZ+kXX/Bx83WZmEtydaL+Ms9y8S9Rh2DIQmmXWUE1F/12JfNZSh
HQycWPwH
=58X8
-----END PGP SIGNATURE-----

--qnaz3v773thgqina--

