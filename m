Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756D7C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 09:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Z8iFRfoKmJOydGYoSsFMebfgQmCmRC9PAOD8LuIVw4=; b=UNqr55BbrKtBNvbplwcxqW7gFZ
	683zXB7o5du85sQeeFWF5NCibCgTmKVBXwvya1Bqlqvh0KVlFaebgUoKER73sjIteaNkMSsZ7O+po
	co8m4e8SB3V8rSuDYsZvCG+d5l9/+2ZHKHI9Y+R2Z1poOpolKU0C3pdLY/bYC7yKckVfUN0vgGFVr
	FlhjGj/IQ7tRTr8tCBGdz7kJBDxT+In3hoTl+scadfnpNGt5hGHaR7s7EgzpS+Et6Zx0aW2peJBpE
	bKkxyX+mdbihUOJg+BjyghkB5OFbtw/NagSwihR5dSHzSXyNLIpQ/dXHgGYWAsKhITp9j+axDa9n7
	FLLwyQxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEStC-003XfP-On; Thu, 21 Jul 2022 09:54:38 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oESt9-003XZ5-DB
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 09:54:37 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220721095427euoutp021ddf8f11a1d1dd36e49cbb0f927e0681~Dz4dXB_2z0975709757euoutp02H;
	Thu, 21 Jul 2022 09:54:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220721095427euoutp021ddf8f11a1d1dd36e49cbb0f927e0681~Dz4dXB_2z0975709757euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1658397268;
	bh=0Z8iFRfoKmJOydGYoSsFMebfgQmCmRC9PAOD8LuIVw4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=X6MrNQJLIHSEZg2PQHPH+4cL2QoY9VEeiUglLmrJ8bKI09BDhz2iEqOy+faaI1jny
	 Ez+P5EEwHcAPzfsHNz+pMej0fTG9+3kSpJyK3fdL9DMAL840GbispljSyz3hBxlYPc
	 as8/pcSTDAYyx1nLouYlQRXjHD95oqiiZew+YMTw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220721095427eucas1p16bd45b32629e5489012230dd45d7f1fa~Dz4dCxrb91956419564eucas1p1Z;
	Thu, 21 Jul 2022 09:54:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 92.E1.10067.35229D26; Thu, 21
	Jul 2022 10:54:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220721095427eucas1p200a14a1ccaea91bb48844ce6686a3e92~Dz4cnSglq1866318663eucas1p2W;
	Thu, 21 Jul 2022 09:54:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220721095427eusmtrp203c377154130b5127ffd38da616d23e5~Dz4cmg1XP2100621006eusmtrp20;
	Thu, 21 Jul 2022 09:54:27 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-9f-62d922538c21
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.56.09038.35229D26; Thu, 21
	Jul 2022 10:54:27 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220721095427eusmtip1940d31db995096511803d8316a7b9dbf~Dz4ceFKD32045220452eusmtip1W;
	Thu, 21 Jul 2022 09:54:27 +0000 (GMT)
Received: from localhost (106.210.248.172) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 21 Jul 2022 10:54:21 +0100
Date: Thu, 21 Jul 2022 11:54:20 +0200
From: Joel Granados <j.granados@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: <kbusch@kernel.org>, <sagi@grimberg.me>, <joshi.k@samsung.com>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<k.jensen@samsung.com>, Javier =?utf-8?B?R29uesOhbGV6?=
	<javier.gonz@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 3/6] nvme: generalize the nvme_multi_css check in
 nvme_scan_ns
Message-ID: <20220721095420.gzvrf7o3ndsszxd2@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="d4zqgzf55tp2pfzr"
Content-Disposition: inline
In-Reply-To: <20220721060320.1704646-4-hch@lst.de>
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djP87rBSjeTDNYeVLZYufook8WkQ9cY
	LZ5encVkMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGsVlk5Kak1mW
	WqRvl8CV0dlyg7Hgi0jFw46LbA2M1wW7GDk5JARMJCb+/MrcxcjFISSwglHi191GNgjnC6PE
	3A2roJzPjBLL5n9kgWmZ+W4SO4gtJLCcUeLxC3+4oj3zVrNCOFsZJRrbVjGCVLEIqEr8PniD
	FcRmE9CROP/mDjOILSKgJPH01VlGkAZmgV+MEq3XljKBJIQFQiROb74Pto5XwFyi+/97dghb
	UOLkzCdgcWaBConlC/4ADeUAsqUllv/jAAlzChhJbD2xgxniUmWJOa9h7FqJtcfOsIPskhBo
	55R4/OQQO0ivhICLxI/jfBA1whKvjm9hh7BlJP7vnM8EYWdL7JyyC2pOgcSsk1PZIFqtJfrO
	5ECEHSVeHu1ngQjzSdx4KwhxJJ/EpG3TmSHCvBIdbUIQ1WoSO5q2Mk5gVJ6F5K1ZSN6ahfAW
	RFhP4sbUKWwYwtoSyxa+ZoawbSXWrXvPsoCRfRWjeGppcW56arFRXmq5XnFibnFpXrpecn7u
	JkZgyjr97/iXHYzLX33UO8TIxMF4iFEFqPnRhtUXGKVY8vLzUpVEeJ8WXk8S4k1JrKxKLcqP
	LyrNSS0+xCjNwaIkzpucuSFRSCA9sSQ1OzW1ILUIJsvEwSnVwKTH/n/ptrtcksr9JVm8lgcz
	LALKl1042X2p6Ojtn1Hb3326PLMz5NZaTZPt1/w3TbM0e5xv9OT7NN/I9paNYcyq3IHLlGpO
	bjm/pu3IxSDfh+4r93zekFEfE2b57ki60/8PSxpWzzxQMOmQqIieptSNh2+PW57bfHfTKdvC
	2Ta8s9zOsSbNCusKnRG3Jb3fZX3QfodLsw7e2Dzjm0Ps6adWdfIdSkqVvSfvBDq4L3vc6cZo
	sOt0vmyzdl7t9VV/+OY2GbJGbfwv8uL795cFGWd3aRoHzp/3OsXfS+jhqx3KOdu2yXueeSLJ
	zNy5XN17kiqfm57HOvHC/iuib64faF2k2X3sPDv3sae8BjMY6ySUWIozEg21mIuKEwGUKokG
	1AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xu7rBSjeTDFY8ZLdYufook8WkQ9cY
	LZ5encVkMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGqVnU5RfWpKq
	kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXMePCL9aCTyIVczbu
	ZG9gvCrYxcjJISFgIjHz3ST2LkYuDiGBpYwSjZdPsUMkZCQ+XfkIZQtL/LnWxQZR9JFR4sve
	u1AdWxkl2jcfZQOpYhFQlfh98AYriM0moCNx/s0dZhBbREBJ4umrs4wgDcwCvxglWq8tZQJJ
	CAuESJzefJ8FxOYVMJfo/v8eaupaRoll096yQiQEJU7OfAJWxCxQJrHz9jygbRxAtrTE8n8c
	IGFOASOJrSd2MEOcqiwx5zWMXSvx6v5uxgmMwrOQTJqFZNIshEkQYR2JnVvvYAprSyxb+JoZ
	wraVWLfuPcsCRvZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgRG87djPLTsYV776qHeIkYmD
	8RCjClDnow2rLzBKseTl56UqifA+LbyeJMSbklhZlVqUH19UmpNafIjRFBiME5mlRJPzgakl
	ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBaVWx2RTG81c3abpc
	MOYRN/9petz3krlsjPvmtALdTi01t7jSmW/nc4tvMzZ9eq3hyI4kDgvm3yZGeWuuLS1VsF+b
	UpRbra3AxtMiuKzl34cjrAFsJ3+cCelcldRfpPxWctHdgidR+gEiG/rm2r/n+ubaqeW+7LHf
	6bdRN6bnnQnjZHgxyf6eWcqfxfIL92w8zLJH/9nNsw2pMXqZCz+eMn/4wZQ1okp41jXpxNvh
	s4sPOkdMNhW7t28GX8pKK99FVrGF/92jP997yPAiceGRBLHw3d6x7k939wpvPVS3XmCNoASv
	9p3jbbeWTs1t6kubekXRNYtB9+GOnun/z8aVLQ1YfMrf6Noqnjk6z+09lViKMxINtZiLihMB
	A0bUYHUDAAA=
X-CMS-MailID: 20220721095427eucas1p200a14a1ccaea91bb48844ce6686a3e92
X-Msg-Generator: CA
X-RootMTR: 20220721060340eucas1p29d43917dc5c524603e443dac9353711f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220721060340eucas1p29d43917dc5c524603e443dac9353711f
References: <20220721060320.1704646-1-hch@lst.de>
	<CGME20220721060340eucas1p29d43917dc5c524603e443dac9353711f@eucas1p2.samsung.com>
	<20220721060320.1704646-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_025435_756413_FF5766B2 
X-CRM114-Status: GOOD (  23.04  )
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

--d4zqgzf55tp2pfzr
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 08:03:17AM +0200, Christoph Hellwig wrote:
> Check for multiple command set support early on an error out if is
> not supported when a !NVM command set namespace is found.  This
> prepares for adding command set independent passthrough support.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/nvme/host/core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index af3b90ca9131d..5ba09d010daba 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4295,6 +4295,12 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, u=
nsigned nsid)
>  	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
>  		return;
> =20
> +	if (ids.csi !=3D NVME_CSI_NVM && !nvme_multi_css(ctrl)) {
> +		dev_warn(ctrl->device,
> +			"command set not reported for nsid: %d\n", nsid);
> +		return;
> +	}
> +
>  	/*
>  	 * Check if the namespace is ready.  If not ignore it, we will get an
>  	 * AEN once it becomes ready and restart the scan.
> @@ -4326,12 +4332,6 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, u=
nsigned nsid)
>  				nsid);
>  			break;
>  		}
> -		if (!nvme_multi_css(ctrl)) {
> -			dev_warn(ctrl->device,
> -				"command set not reported for nsid: %d\n",
> -				nsid);
> -			break;
> -		}
>  		nvme_alloc_ns(ctrl, nsid, &ids);
>  		break;
>  	default:
> --=20
> 2.30.2
>=20
LGTM
Reviewed-by: Joel Granados <j.granados@samsung.com>


--d4zqgzf55tp2pfzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmLZIkwACgkQupfNUreW
QU9k4Av4wbnt8JlZqccffI4+G88F18Hh9ZtsPx81GG53ABLL0x68y6WL9zB0sTcJ
lSKKzoiYFuHNeLgcIkNnsW6Qx2HFOIG3x5T9HrDRJn9xwIu7QeoVV8avdCHuimsi
8E6mgNkpCG6fBLPMT1BnENXvY4/audcNuFzlUFuKyjSN9hQWnhq5EplEjOUHYRxn
41sJYpUQK14pNt8ryEcmCc2zeyh34Znqqzn1o2jqE66SHIMXJiPCtepqZtJtphV4
Qisj7MRQCfJfxG0C7ybWY8qT+OMeL2+hYGwJuiaiAOH8QQcpltetNDyVSK8cX265
8iT2uU9dyTkX4c76KBG9+28XTkVTp4GDsB0j/9+0EDvfN1esQkedlx0nuGq2Bieg
kUbl0o7Baj38n3tByOLteItdJtD6gqD5zwj852Y3zsYGuaIEQGFDwbizGrbRXn5O
7CvPBJhUHRuShCZvMK6zLD77MHsjVpfbCHtBn096oTzr9nthq7pdpJrT6i/1l8Fb
MmBEJks=
=SgiN
-----END PGP SIGNATURE-----

--d4zqgzf55tp2pfzr--

