Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05218C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jul 2022 08:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=erNx8ffuiHU8/iF+FG52cTXHwR2nFrTb3r+8Roe34yc=; b=W/t4HhVtZ3dBbFDyUWR2eFXxen
	xmi5jJzO+O+gHplJHzPYjEsGMH64wdRszc1/3rstVwqXDsPsp8mlkeBbNJGsfIjlXQC7B7+/+rlpr
	lEQogCODtGpe7Z6R1HqfMghj9G58Tp6d15kvwEUXWPpU31ZFCnvdSDjPJtbkWfnf//N5Mcy4ihW+c
	awAdyfSTnlQaMoe7TLmhVVotq5Gxwhfui4B7BsnV34yRJ/KibzlYJbJ5JK/AUHT1RgXwJ43OYEkeJ
	qSmTv7z7moXF0uVJCzwHkX3XrDZ7UGGzW7zDxwMMCI/E8IFC/XnnFQlp5P4nfypt+6nOOt4ph3oYh
	CASqkhGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE5Aa-002dwx-QO; Wed, 20 Jul 2022 08:35:00 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE5AY-002ds3-6G
	for linux-nvme@lists.infradead.org; Wed, 20 Jul 2022 08:35:00 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220720083449euoutp01b89e24b379819b2ffa3ef6b648043d74~DfJpIifUh1589415894euoutp01Y;
	Wed, 20 Jul 2022 08:34:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220720083449euoutp01b89e24b379819b2ffa3ef6b648043d74~DfJpIifUh1589415894euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1658306089;
	bh=erNx8ffuiHU8/iF+FG52cTXHwR2nFrTb3r+8Roe34yc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HHUVizJOL67uMgAW/yME5+Rb/Lo0CAqwVzpM1Qz+jAEs2NN9sE3R3GVYvuo+wvAHH
	 TNRcL0zS70boWgYed/YVFVHv0yYcxOIg7r0jrsOiRW0DmZD5jz4bdMrczxvQaGwSbn
	 OKkwo1MS0LMa7hCCvNqisMnzJnVkXvXBYPCaOQqA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220720083449eucas1p253404bb5fe49be5b7822b5b1b8bd5004~DfJoxueDu0239702397eucas1p2B;
	Wed, 20 Jul 2022 08:34:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id F1.60.10067.92EB7D26; Wed, 20
	Jul 2022 09:34:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220720083449eucas1p1b80794cfa420bd4132b1426cd478db62~DfJoabSb_1749617496eucas1p1C;
	Wed, 20 Jul 2022 08:34:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220720083449eusmtrp24f926a0d38ec0bc88acfbd0e8ef19d3b~DfJoZveQr0166301663eusmtrp2e;
	Wed, 20 Jul 2022 08:34:49 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-08-62d7be293234
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D5.8F.09095.82EB7D26; Wed, 20
	Jul 2022 09:34:48 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220720083448eusmtip1781661d6798f6ddca816f4ab4f77b33a~DfJoM98sh2347123471eusmtip1O;
	Wed, 20 Jul 2022 08:34:48 +0000 (GMT)
Received: from localhost (106.210.248.172) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 20 Jul 2022 09:34:43 +0100
Date: Wed, 20 Jul 2022 10:11:54 +0200
From: Joel Granados <j.granados@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Kanchan Joshi <joshi.k@samsung.com>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<gost.dev@samsung.com>, <k.jensen@samsung.com>, Javier
	=?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH 3/5] nvme: refactor namespace probing
Message-ID: <20220720081154.h24utc2fodremtgk@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="laltfok2saapw5ae"
Content-Disposition: inline
In-Reply-To: <20220719143703.GA21148@lst.de>
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87qa+64nGXStlbZYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRXDYpqTmZZalF+nYJXBm3LjWw
	FLxQrthyLaqB8Z50FyMnh4SAicSqZ7/YQGwhgRWMEu0rvboYuYDsL4wSL28/YIJwPjNKLDz+
	kBmm4/iqG1CJ5YwS+zZsYISr+jN1OTuEsxWof1UfC0gLi4CqxKKfc5hAbDYBHYnzb+6AjRIR
	UJJ4+uosWDezwGNGidm3t4EVCQtYSjT8+wZWxCtgLnF05g0WCFtQ4uTMJ2A2s0CFxK+9zUD1
	HEC2tMTyfxwgYU6g+R19KxghTlWWmPN6B9TZtRJrj50BO05C4D+HxJTrp6ASLhIrPx9hg7CF
	JV4d38IOYctI/N85nwnCzpbYOWUXVH2BxKyTU9lA9koIWEv0ncmBMB0lDvQqQZh8EjfeCkIc
	yScxadt0Zogwr0RHmxDEDDWJHU1bGScwKs9C8tYsJG/NQngLIqwjsWD3JzYMYW2JZQtfM0PY
	thLr1r1nWcDIvopRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwOZ3+d/zLDsblrz7qHWJk
	4mA8xKgC1Pxow+oLjFIsefl5qUoivE8LrycJ8aYkVlalFuXHF5XmpBYfYpTmYFES503O3JAo
	JJCeWJKanZpakFoEk2Xi4JRqYJIpXXF4eQ+bVdKdtrqgZsMW2eWdnQItmQ7M76RXytcuKXq5
	6N56Vg0p1pCZn2YWqm+Yyl7snWBklbT4YLrexQ6ejdM6Zki3t2RGcn597BMrGe+WZlMQ+juY
	JfKkVsunUHVfyXvnPFma4tmfVxr2iM5U7txxp4/zUaLkrGMTPlWf29fpuvy/x5WJWUvW5NzX
	5Vr8Kv4K75QTTxXlPUvVvWYdvKIzz1JZdNbknrTGBYc5Wl/y9oa+adaxfvZ/kR2LToS5h6Zj
	dUV7Yax5vQTHgYDdFcquXI8P/sg5b9t64GQ+sySbnMjNZL8m58mP7vT8FlO/9Pretu59D/xv
	ZwsxWEx7x5oSuH6+R9G3S0eUWIozEg21mIuKEwFJ0t6byQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7oa+64nGcz8YmWxcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAlii9GyK8ktLUhUy8otLbJWiDS2M
	9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLmTVjJUvBMuWLF9jcsDYx3pLsYOTkk
	BEwkjq+6wdTFyMUhJLCUUeLs/rcsEAkZiU9XPrJD2MISf651sUEUfWSU+LLnBDOEs5VRYsv0
	BawgVSwCqhKLfs5hArHZBHQkzr+5wwxiiwgoSTx9dZYRpIFZ4DGjxPk7G8ESwgKWEg3/voHZ
	vALmEkdn3gBbLSQwn0niQyMXRFxQ4uTMJ2BxZoEyiXkveoFsDiBbWmL5Pw6QMCfQro6+FYwQ
	lypLzHm9gxnCrpV4dX834wRG4VlIJs1CMmkWwiSIsJbEjX8vmTCEtSWWLXzNDGHbSqxb955l
	ASP7KkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMBY3Xbs5+YdjPNefdQ7xMjEwXiIUQWo89GG
	1RcYpVjy8vNSlUR4nxZeTxLiTUmsrEotyo8vKs1JLT7EaAoMxYnMUqLJ+cAkklcSb2hmYGpo
	YmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwBTFmfGj4JD1t/tR/A/7em1uZxSt
	eV+68Map28nMKXdPL8oXvtL0fmP1etXZwl37P5Wu17mRf/pNd2u762G2U3aMou2Hd2suTdgW
	ZvQz43FMnrTx7CWMTvIfTu38vFQx/pXsB2XpBD4ONzaXbqPjF1Z2cc06Epq1QnPdwVOzj1zx
	U2r7FXNtdp2Rzn2Le0daHJKMWvmnndC+W3fN1tOD6bhbjffOgzXMHtHeqdPdf+w7tqXETN9R
	zLbu68WrD990HEjlkU0wnHHy2IU7Lsbr4tvWVHWvMFwh961pzaXvbUJCpW9UxStn7etd4pn7
	u060a8MSyT9qibm+K7gXxu5Y7b37uoRs+Gnl9atnl5frliuxFGckGmoxFxUnAgAoXiCPagMA
	AA==
X-CMS-MailID: 20220720083449eucas1p1b80794cfa420bd4132b1426cd478db62
X-Msg-Generator: CA
X-RootMTR: 20220718052850epcas5p24450d4c756d1eb0db6f4cc9c24bb184d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220718052850epcas5p24450d4c756d1eb0db6f4cc9c24bb184d
References: <20220718052503.235270-1-hch@lst.de>
	<CGME20220718052850epcas5p24450d4c756d1eb0db6f4cc9c24bb184d@epcas5p2.samsung.com>
	<20220718052503.235270-4-hch@lst.de> <20220719070845.GB22571@test-zns>
	<20220719130048.gkvgei44m3ssqklv@localhost> <20220719143703.GA21148@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_013458_676691_10374FC0 
X-CRM114-Status: GOOD (  28.52  )
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

--laltfok2saapw5ae
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2022 at 04:37:03PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 19, 2022 at 03:00:48PM +0200, Joel Granados wrote:
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -2011,8 +2011,10 @@ static int nvme_update_ns_info_block(struct nv=
me_ns *ns,
> > >=20
> > >        if (blk_queue_is_zoned(ns->queue)) {
> > >                ret =3D nvme_revalidate_zones(ns);
> > > -               if (ret && !nvme_first_scan(ns->disk))
> > > +               if (ret && !nvme_first_scan(ns->disk)) {
> > > +                       kfree(id);
> > >                        return ret;
> > > +               }
> > >        }
> > > =09
> >=20
> > Should we also take care to hide the device?
> > As I read it the call to nvme_revalidate_zones can return a -ENODEV
> > (through blk_revalidate_disk_zones) which is the original condition to
> > hide the block device.
>=20
> Yes, I think we need something like the patch below folded in.  This
> unfreezes before setting the hidden flag and setting the ns ready,
> but I can't see why we'd need it frozen for that.
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index bbdf0f95331f3..e6025f80744f6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2012,7 +2012,7 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
>  	if (blk_queue_is_zoned(ns->queue)) {
>  		ret =3D nvme_revalidate_zones(ns);
>  		if (ret && !nvme_first_scan(ns->disk))
> -			return ret;
> +			goto out_free_id;
>  	}
> =20
>  	if (nvme_ns_head_multipath(ns->head)) {
> @@ -2029,6 +2029,8 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
>  	return 0;
> =20
>  out_unfreeze:
> +	blk_mq_unfreeze_queue(ns->disk->queue);
> +out_free_id:
>  	/*
>  	 * If probing fails due an unsupported feature, hide the block device,
>  	 * but still allow other access.
> @@ -2038,7 +2040,6 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
>  		set_bit(NVME_NS_READY, &ns->flags);
>  		ret =3D 0;
>  	}
> -	blk_mq_unfreeze_queue(ns->disk->queue);
>  	kfree(id);
>  	return ret;
>  }

Yes. And with unfreeze in its own goto, we can return with the
out_free_id on success. In this way we do not duplicate the 'kfree' line
and future uses of 'ret' will just work.
Something like this:

diff --git i/drivers/nvme/host/core.c w/drivers/nvme/host/core.c
index bbdf0f95331f..8359efbb1d29 100644
--- i/drivers/nvme/host/core.c
+++ w/drivers/nvme/host/core.c
@@ -2012,7 +2012,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *=
ns,
        if (blk_queue_is_zoned(ns->queue)) {
                ret =3D nvme_revalidate_zones(ns);
                if (ret && !nvme_first_scan(ns->disk))
-                       return ret;
+                       goto out_free_id;
        }
=20
        if (nvme_ns_head_multipath(ns->head)) {
@@ -2025,10 +2025,11 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
                disk_update_readahead(ns->head->disk);
                blk_mq_unfreeze_queue(ns->head->disk->queue);
        }
-       kfree(id);
-       return 0;
+       goto out_free_id;
=20
 out_unfreeze:
+       blk_mq_unfreeze_queue(ns->disk->queue);
+out_free_id:
        /*
         * If probing fails due an unsupported feature, hide the block devi=
ce,
         * but still allow other access.
@@ -2038,7 +2039,6 @@ static int nvme_update_ns_info_block(struct nvme_ns *=
ns,
                set_bit(NVME_NS_READY, &ns->flags);
                ret =3D 0;
        }
-       blk_mq_unfreeze_queue(ns->disk->queue);
        kfree(id);
        return ret;
 }


--laltfok2saapw5ae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmLXuLcACgkQupfNUreW
QU8TSwv9Hl5I0CaqsBbohnaK4MtJ6gjBg6YYU1gZ6rKtS/V4O1Yhx/Lru+WkAFCF
ZwTtqOd80kONJZJmM4aGmxRAuyrrp8qz5v1JJQ8Rf5xypLiydGhKOGQKJmXis5rx
0au288EK16URwCXNRJiPRysOOi/ANOWqFPpWW84qYYNWtkrNmxkKQgm8hQcpMPW+
W1VDP4Th4Hs2OR1uWyvg3MCHCMRUojXNzTI9GaPztEv6uGQJCpcgwAowTN9L9uil
9ceJVOIwiKgMGZFRBJ/QVogV9h/wZWQuPSMmsJ6OiZrW4QRd5+uoJYLUo2LDYc1N
xuG+SgK6D4YawzNSgubt+tcS4+jAiMYzKjCQ/djD5qz7Gszmhs+gwd7KkPIv6C49
ONtd4aYVwR+eQyj+9YnecZkoWGNgkb5zer/JzqDEpxTjdxjPWgQtc6ZxY819+x4n
O1zIKcIGGQd/QloTf7Z+RaozhspImmnzzMDcRUNTuiJGPtzvi8XHlJhPJNeS7BIX
btfpaQR6
=PiYP
-----END PGP SIGNATURE-----

--laltfok2saapw5ae--

