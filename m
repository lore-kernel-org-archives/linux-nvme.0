Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3820FC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 09:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I0u5D//xsu5tOZktc/xMxrccz86CBJ3Ku1mM1q+NyFg=; b=KnI1XQev1fdGCo87q8PehfISqE
	JyGTdhHSfOl70gOVP4QvZhBparXhbUWMC+UZPI+JiNiVIJE03f9FIM3cRjnCCTPR1zluCbQ5nMItb
	0rmQ4fvpSGKTHtIPa40ZFYhncxq//K2iPsZoDGpRi+Y4HbxwNcgiO2E9atoqMPPU5Iun3tdzhWTVq
	nNJ8rSfpj8Pqcd3+aRzv/0EBpIyLbWW/418BngG7X2rF09Gm2hxUzAbg2DJ4B5EGtREugJoq6F1LT
	2XDAiXllITP4zyFLAnCtWhlff4C+hHIXLdrRFmdCLmGPTBoohoOexxKSuvJMOLc7QwYG0SmjK0rcH
	fsiCaTVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oESsZ-003XHL-BH; Thu, 21 Jul 2022 09:53:59 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oESsV-003XDD-6G
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 09:53:57 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220721095352euoutp014fcb270ce962a79564e70636ed872786~Dz38aeWBU2082620826euoutp01j;
	Thu, 21 Jul 2022 09:53:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220721095352euoutp014fcb270ce962a79564e70636ed872786~Dz38aeWBU2082620826euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1658397232;
	bh=I0u5D//xsu5tOZktc/xMxrccz86CBJ3Ku1mM1q+NyFg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=rRd2zjnUON//Dxq2oED7PaDdremfqCZE4AhYop+MbZLl8Ip4JEe3GFt4iVE6dfHlk
	 6GypVcDl4BWn+wIM7YBiTYWCDax5U4YHU2KGP3rUuy9kt0dciNSNI23KZ+tbieW4aB
	 68XnQ4gJmEo3hG48uN7rKcjKfg+IY1l4EGg1POfA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220721095352eucas1p10e7c6e827d5a1311b774d10b01a1fe7b~Dz38PBPj70111301113eucas1p1G;
	Thu, 21 Jul 2022 09:53:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 06.31.09580.03229D26; Thu, 21
	Jul 2022 10:53:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220721095352eucas1p1fc63ab1f2e1f0ab14d10601d78e4fafb~Dz378eMFN1826018260eucas1p1e;
	Thu, 21 Jul 2022 09:53:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220721095352eusmtrp1105743f9500cfed6741a3ef96609b109~Dz3770ksk2452024520eusmtrp1d;
	Thu, 21 Jul 2022 09:53:52 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-d8-62d92230f4e7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 98.46.09038.F2229D26; Thu, 21
	Jul 2022 10:53:51 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220721095351eusmtip164d229cd2d390665175d5e2bc6debfda~Dz37xjkwH2312623126eusmtip1I;
	Thu, 21 Jul 2022 09:53:51 +0000 (GMT)
Received: from localhost (106.210.248.172) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 21 Jul 2022 10:53:51 +0100
Date: Thu, 21 Jul 2022 11:53:49 +0200
From: Joel Granados <j.granados@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: <kbusch@kernel.org>, <sagi@grimberg.me>, <joshi.k@samsung.com>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<k.jensen@samsung.com>
Subject: Re: [PATCH 1/6] nvme: catch -ENODEV from nvme_revalidate_zones
 again
Message-ID: <20220721095349.w4rurdlk5paxngzr@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="6nfb2s5xbfpsnwjk"
Content-Disposition: inline
In-Reply-To: <20220721060320.1704646-2-hch@lst.de>
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSf0yMcRzHfe95eu652pOn6/BRN+MpGpFKmyNRG9YfjC0Mf+CqZ9W6rvtR
	KmMdqYkURXLol1zUSqFf16bt0Gll52cK+RGZLgmpIUXXNz82/70+78/P9/ahCXGdnQsdpYzj
	NUq5gqPsydrmb5ZF3lxnqHd5qkR2qfyWQJZtakeyAkOPUFbZN0AGksGW59Vk8JWydCr4akly
	cGOnjtpIbrdfEc4ronbzmsUrd9lH5ld8sFM9h0RzxyOhDlklh5GIBtYPervOUYeRPS1mLyIw
	ZtcQOPiCoPi8SYiDQQTmM6N2v1sGHqYhnChF0N2YIfhT1XG5yQ4HNQjyjFlCWwvJzoVrhnvI
	xhS7ECzvnxE2lrAc9FjvTOgEm4eg/bi7jZ3ZDZD74CdpY4ZdCsZjZxBmJ2g5/YbE9YnQYn44
	voweZ1coHaNtsoj1hRsVRgG+1A3O9tUTmPdBRXPbhB1gv9Dwtu3+pJ3VkNKgIzE7g9V8TYhZ
	Cq05GZN6NDScME4OUoG+5SRl2wusP2S2KTAGwQGdD0ZH6Oh3wkc6QnbtKQLLDBxKE+MZ86D+
	QA06htz0/9jS/2NL/9cWlhdCYeNn6j/ZEwxFfQTmAKisHCALkbAMzeDjtTERvHaJkk/w0spj
	tPHKCK+w2JgraPyfWsfMQ/XoovWTlwkJaGRC7uPN3VXld5ELqYxV8pyE6VE/DhUz4fKkPbwm
	dqcmXsFrTciVJrkZTFhUlVzMRsjj+GieV/Ga31kBLXLRCeZe0IQZ1u9oOpsvFU31feUQsr8/
	J+/mopEB89PopaqkEIfV1t6PQarqZE+u951/aw4TuH64LGd0+LT7EdV+9VXuyMmOhJU+wswp
	Dp1BN3s83il2hMgk0bmVGTMZv1Xb5EtKmfnZ7UPW3VTA4N7pB/vb9+lvFHg+Odrg36W8Kzqa
	WLhpjov3G2Ud5xmXNf824otpHynxNX+VyDnXbZbFoD8Uw0wLUH8/cXyd5fpaR79C+LEstqT5
	uq+UTkoPXH7fMPNJXbWa9ghfU741q6F+1ufI1y9kKa5rRnR1qWGtjFMk2/IsRapK5vy9tsTV
	Tt9clNCtrmpKn/0ytNNRRWVqutQcqY2U+ywgNFr5L2tUX9/KAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7oGSjeTDCbaWqxcfZTJYtKha4wW
	85c9ZbdY9/o9iwOLx/l7G1k8Nq3qZPPYvKTeY/fNBrYAlig9m6L80pJUhYz84hJbpWhDCyM9
	Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jONd15gL7khUbDuxmrWB8YVIFyMnh4SA
	icT7K22MXYxcHEICSxklTq7Ywg6RkJH4dOUjlC0s8edaFxtE0UdGidOvrzODJIQEtjJKbJzM
	CWKzCKhKbFl2kRHEZhPQkTj/5g5YjYiAksTTV2fB4swCMxglrk1UAbGFBXwlmrf+ZQWxeQXM
	JXZNmA11xVpGieZXE9ggEoISJ2c+YYFoLpM48aIFyOYAsqUllv/jAAlzChhJHF67iwniUGWJ
	Oa93MEPYtRKv7u9mnMAoPAvJpFlIJs1CmAQR1pK48e8lE4awtsSyha+ZIWxbiXXr3rMsYGRf
	xSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERin24793LKDceWrj3qHGJk4GA8xqgB1Ptqw+gKj
	FEtefl6qkgjv08LrSUK8KYmVValF+fFFpTmpxYcYTYGhOJFZSjQ5H5hA8kriDc0MTA1NzCwN
	TC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamGaIlUk4MG/fzv9nlqadk1PxUreCi+Y6
	tdVv/H/tjd38Pav0zMJt4v8uOPLV7BbbGD7RdIvknPBdmlp9xdfO/X20O8xQc47J3jlqkgfe
	lWt6l2p6apfX65/X3jDhyq6fTlXOKUsSwo546r6YeHoa8wLhg8LMDmf3sLcfE+o9155c1hH2
	1zjoflvp6rhn/O49i9dcXqDmW1pyT1JSo6TASSh4wftl5l11YcJHXDpPrvNn76g8M3G9Q/4u
	ziq+qSkM8T92Zl8TnpaXc+vgD8moDxfu+vfuzC/9qLrOZOXWirNMSyyW1eQlO0gtOup6adXK
	AxO6as4cNLnT0d3xl639wZoYNavSlruSydWHzc83KbEUZyQaajEXFScCAEeWivRoAwAA
X-CMS-MailID: 20220721095352eucas1p1fc63ab1f2e1f0ab14d10601d78e4fafb
X-Msg-Generator: CA
X-RootMTR: 20220721060334eucas1p127a57fcd3408afc8af6746a1b3bea99e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220721060334eucas1p127a57fcd3408afc8af6746a1b3bea99e
References: <20220721060320.1704646-1-hch@lst.de>
	<CGME20220721060334eucas1p127a57fcd3408afc8af6746a1b3bea99e@eucas1p1.samsung.com>
	<20220721060320.1704646-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_025355_676095_DE9A3CAD 
X-CRM114-Status: GOOD (  23.44  )
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

--6nfb2s5xbfpsnwjk
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 08:03:15AM +0200, Christoph Hellwig wrote:
> nvme_revalidate_zones can also return -ENODEV if e.g. zone sizes aren't
> constant or not a power of two.  In that case we should jump to marking
> the gendisk hidden and only support pass through.
>=20
> Fixes: 602e57c9799c ("nvme: also mark passthrough-only namespaces ready i=
n nvme_update_ns_info")
> Reported-by: Joel Granados <j.granados@samsung.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 698e71680e6f3..2e1af9b5c8a91 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1940,8 +1940,10 @@ static int nvme_update_ns_info(struct nvme_ns *ns,=
 struct nvme_id_ns *id)
> =20
>  	if (ns->head->ids.csi =3D=3D NVME_CSI_ZNS) {
>  		ret =3D nvme_update_zone_info(ns, lbaf);
> -		if (ret)
> -			goto out_unfreeze;
> +		if (ret) {
> +			blk_mq_unfreeze_queue(ns->disk->queue);
> +			goto out;
> +		}
>  	}
> =20
>  	set_disk_ro(ns->disk, (id->nsattr & NVME_NS_ATTR_RO) ||
> @@ -1952,7 +1954,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, =
struct nvme_id_ns *id)
>  	if (blk_queue_is_zoned(ns->queue)) {
>  		ret =3D nvme_revalidate_zones(ns);
>  		if (ret && !nvme_first_scan(ns->disk))
> -			return ret;
> +			goto out;
>  	}
> =20
>  	if (nvme_ns_head_multipath(ns->head)) {
> @@ -1967,9 +1969,9 @@ static int nvme_update_ns_info(struct nvme_ns *ns, =
struct nvme_id_ns *id)
>  		disk_update_readahead(ns->head->disk);
>  		blk_mq_unfreeze_queue(ns->head->disk->queue);
>  	}
> -	return 0;
> =20
> -out_unfreeze:
> +	ret =3D 0;
> +out:
>  	/*
>  	 * If probing fails due an unsupported feature, hide the block device,
>  	 * but still allow other access.
> @@ -1979,7 +1981,6 @@ static int nvme_update_ns_info(struct nvme_ns *ns, =
struct nvme_id_ns *id)
>  		set_bit(NVME_NS_READY, &ns->flags);
>  		ret =3D 0;
>  	}
> -	blk_mq_unfreeze_queue(ns->disk->queue);
>  	return ret;
>  }
> =20
> --=20
> 2.30.2
>=20

LGTM.
Reviewed-by: Joel Granados <j.granados@samsung.com>


--6nfb2s5xbfpsnwjk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmLZIicACgkQupfNUreW
QU90vwwAj65dHkn/Ib5ADUkiqgup/H3q8r6CaGnlDxUk+qMDOhlfWA5UCBHIo0Wc
iFofCVonvaBQs3BIGaUeiCcC9Hp9KY6ztIkeE8zqksCpt7V31pljXkTiMH2Kxjq9
n13e34JWNKbGv+G1iJA8VUAGqDXmHy5qAlMbnoZKtDQ4AXgP1FotuNnvRun55mRm
OVnw2jzWmCZaUvlTYtR0D1rsfrH1nhVLKAZGaEAQp81ujxEybxp7uk2lAWzodhc1
WAbBo9lxWqPq/5GeuaoZYLtHlDe6o8qNUpZKFx9AWh/xJlf8FvNQp2EMjGnPFRX5
kUI+fPwYurG7zExiDKXuMCvwSDoZuub5qg5Y2n4OYDXdO3AoE120BNq0VCpgBq3p
op09FEs3ZjINggXoWdyLxilBT3vqYmKK2zEKQDmeF5hdLW2hrtR0ZXdIu0hF2N8b
MAnuk3AFjbNP7Y1wxkbyIVJ8DsJWPGpZBlkO6MRlVxbDynZjWeVhyppfeBv/Bl1p
v7ogZKee
=vxrr
-----END PGP SIGNATURE-----

--6nfb2s5xbfpsnwjk--

