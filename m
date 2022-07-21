Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B136C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 09:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WRNfP+3V4s8JXYymI1VuH6v0UwGeVIdjq/EY0PbcI1k=; b=YFFADFNmbzoOQz8GfGxWCfaAEv
	XTPYcmiXEsjOEDU4+8m3qjTyhyyNBxMNX4csQyoK7ajvVfA1qBeiuH8UcIQVcz0CLVg/40eIRRe7m
	3zbIEQy35S+XyO61BDBRpq/WdwhjoeQlDcttZpma9MLTq4Wzsj/EdJjxsAknucOX/yFe6su0p7hp/
	ncc2pt8d2VitFxC0m5/XE7UB9dckzXCsahzdkgx2ob2NBHyPSJWODMvN+BZ5h4aDrqUF2CDoRPRlI
	qU4wKSPO54PqNi6pOYfeHlzAlL/oFw1chORyliDCrNAMtHVTDOPidxDqwOF0hgR0fXdy8JlfqdfV8
	7AOpOUKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEStV-003XuL-OV; Thu, 21 Jul 2022 09:54:57 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEStS-003Xrd-Jx
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 09:54:56 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220721095453euoutp02b0c0d9993d22edf7a54a3c37fef276e8~Dz40767kS0876408764euoutp02v;
	Thu, 21 Jul 2022 09:54:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220721095453euoutp02b0c0d9993d22edf7a54a3c37fef276e8~Dz40767kS0876408764euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1658397293;
	bh=WRNfP+3V4s8JXYymI1VuH6v0UwGeVIdjq/EY0PbcI1k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FcKC11YVTFNPMeJ5nDCDITFiNmly3ggOpObG7T38pHDlKMmtbyczty0go5e2AEYMu
	 ShTpHab4taZatGNn4DVVi3mnLZEN892fFH6EWaWlbOGVpVGBZ4tB1VG5hwcEX352bc
	 xX4A9F954qcl/jk1qlvoyi+B/8eU45VptsscdkuM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220721095453eucas1p2f351f0fad08538f68ea2e7e18b233429~Dz40wnlX22692926929eucas1p2G;
	Thu, 21 Jul 2022 09:54:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E3.0A.09664.C6229D26; Thu, 21
	Jul 2022 10:54:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220721095452eucas1p286f8382cee1213f7a7d144a5e2a888e2~Dz40XPtuF1866518665eucas1p2x;
	Thu, 21 Jul 2022 09:54:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220721095452eusmtrp18bc832ad7f83c0e5ed1adc18c711adf1~Dz40VtTBF2529125291eusmtrp1x;
	Thu, 21 Jul 2022 09:54:52 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-91-62d9226cf1e4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 82.A5.09095.C6229D26; Thu, 21
	Jul 2022 10:54:52 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220721095452eusmtip2d7e55d4b590ddd3c1bb389ed9c6418ea~Dz40NKA471764917649eusmtip2B;
	Thu, 21 Jul 2022 09:54:52 +0000 (GMT)
Received: from localhost (106.210.248.172) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 21 Jul 2022 10:54:49 +0100
Date: Thu, 21 Jul 2022 11:54:47 +0200
From: Joel Granados <j.granados@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: <kbusch@kernel.org>, <sagi@grimberg.me>, <joshi.k@samsung.com>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<k.jensen@samsung.com>, Javier =?utf-8?B?R29uesOhbGV6?=
	<javier.gonz@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 5/6] nvme: factor out a nvme_ns_is_readonly helper
Message-ID: <20220721095447.a5y4ds7k7iw77xm6@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="hxpfhli2b7yvb5tz"
Content-Disposition: inline
In-Reply-To: <20220721060320.1704646-6-hch@lst.de>
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djPc7q5SjeTDI4eZ7RYufook8WkQ9cY
	LZ5encVkMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGsVlk5Kak1mW
	WqRvl8CVcXuDSMFu+Yonn3axNDDekOpi5OSQEDCReH7lEEsXIxeHkMAKRomvr5+xQjhfGCVe
	PN3JBuF8ZpQ4c/ILC0zL0hn97BCJ5YwS67saGeGqNq35BdWylVHi//QPzF2MHBwsAqoSGw6X
	gHSzCehInH9zhxnEFhFQknj66ixYM7PAL0aJ1mtLmUASwgJuElMfnASzeQXMJX7dvsUMYQtK
	nJz5BOwMZoEKiVdHelhB5jMLSEss/8cBEuYUMJLY92w1E8SlyhJzXu9ghrBrJdYeOwN2tYRA
	P6fEmpkL2CASLhKfrj2FsoUlXh3fwg5hy0icntwD9XK2xM4pu6AGFUjMOjmVDWSvhIC1RN+Z
	HIiwo8TKmd+gwnwSN94KQlzJJzFp23RmiDCvREebEES1msSOpq2MExiVZyH5axaSv2Yh/AUR
	1pO4MXUKG4awtsSyha+ZIWxbiXXr3rMsYGRfxSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJ
	EZiyTv87/mkH49xXH/UOMTJxMB5iVAFqfrRh9QVGKZa8/LxUJRHep4XXk4R4UxIrq1KL8uOL
	SnNSiw8xSnOwKInzJmduSBQSSE8sSc1OTS1ILYLJMnFwSjUwKTGX2fbM3RR3uN2yckPIwrDu
	zcezOUzfLpmh8dvpTp/jrLPR9owBHx4+NmcOmPm/8O7Jo+FfXPqv3X2tPyfp744E26TYfaJC
	ZaoH55rfNZ6RulbiTch39t8r2oVUAzu/nHYLeSe5etubm83LXq25urfd9rrMXB7fYMsm5tev
	vTMLLeIrTjWrBd6MVFrms+Pl0dKkQzkbctbPeLdDSXifdvCB2RJlRvIqsi/+cjrn9YVZvn65
	fGL1Fpc/jX+MTyuVTviotjf0YP3fPTduKcU2up/LC1XdUS07ySI2aWKY/WTHmVLCcRxzCtiW
	OfSdlQs8XJxiobyl6rUN/+++k2LqXE2BUkqxmxUZ9s9mTL+vxFKckWioxVxUnAgAMki1KtQD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsVy+t/xe7o5SjeTDA7NV7VYufook8WkQ9cY
	LZ5encVkMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGqVnU5RfWpKq
	kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8XjGTpaCnfIVHw6/
	Z2xgvCbVxcjJISFgIrF0Rj97FyMXh5DAUkaJ5i0LWSESMhKfrnxkh7CFJf5c62KDKPrIKHH/
	wj6ojq2MEm92T2bqYuTgYBFQldhwuASkgU1AR+L8mzvMILaIgJLE01dnGUHqmQV+MUq0XlvK
	BJIQFnCTmPrgJJjNK2Au8ev2LbAGIYG1jBLLZsdDxAUlTs58wgJiMwuUSTRe/MwMsotZQFpi
	+T8OkDCngJHEvmermSAOVZaY83oHM4RdK/Hq/m7GCYzCs5BMmoVk0iyESRBhHYmdW++wYQhr
	Syxb+JoZwraVWLfuPcsCRvZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgdG77djPzTsY5736
	qHeIkYmD8RCjClDnow2rLzBKseTl56UqifA+LbyeJMSbklhZlVqUH19UmpNafIjRFBiIE5ml
	RJPzgWklryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBSZuxxHKL
	zRc331g9p012j/0/vF/eevLKNMG8wgUHXh9VFlzM5al/6XjBwWmGpxJu/ru4VOnsufDA+225
	v6fzPOcNnqqwnj1hrc+SSP6aKqaspNjft07tLsnv6M0xO7h64vvGpf0qzKUNZjJdrku4lHZO
	z10j91byk76BjOMznS3x9oauDr/fbHqlODcu22jmZ7eJ274kSexjmpSjf/JsIn97bYvl3bY1
	/lxdz1jvvYnk3Jm++KFL8KrFPZw8N5iUM1YHP1A/vJ3va9fxK6Iz9cX2iGnvryuU8+XliUxb
	zyzvYjJbSeX/pPiekrZjWZZ/Aq6Kl261M/i5/MlfxesL7ghlaM4vYP+loP+zaOkdJZbijERD
	Leai4kQA07NciXMDAAA=
X-CMS-MailID: 20220721095452eucas1p286f8382cee1213f7a7d144a5e2a888e2
X-Msg-Generator: CA
X-RootMTR: 20220721060344eucas1p100631c8fdd6ebde05eb1e48c3fdddf8d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220721060344eucas1p100631c8fdd6ebde05eb1e48c3fdddf8d
References: <20220721060320.1704646-1-hch@lst.de>
	<CGME20220721060344eucas1p100631c8fdd6ebde05eb1e48c3fdddf8d@eucas1p1.samsung.com>
	<20220721060320.1704646-6-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_025454_959916_8F3C3646 
X-CRM114-Status: GOOD (  22.50  )
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

--hxpfhli2b7yvb5tz
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 08:03:19AM +0200, Christoph Hellwig wrote:
> Add a little helper to check if a namespace should be marked read-only
> that uses a new is_readonly flag in the nvme_ns_info structure.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/nvme/host/core.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6169737c233b2..271c0de483a9b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -36,6 +36,7 @@ struct nvme_ns_info {
>  	u32 nsid;
>  	__le32 anagrpid;
>  	bool is_shared;
> +	bool is_readonly;
>  	bool is_ready;
>  };
> =20
> @@ -1447,6 +1448,7 @@ static int nvme_ns_info_from_identify(struct nvme_c=
trl *ctrl,
>  		return ret;
>  	info->anagrpid =3D id->anagrpid;
>  	info->is_shared =3D id->nmic & NVME_NS_NMIC_SHARED;
> +	info->is_readonly =3D id->nsattr & NVME_NS_ATTR_RO;
>  	info->is_ready =3D true;
>  	if (ctrl->quirks & NVME_QUIRK_BOGUS_NID) {
>  		dev_info(ctrl->device,
> @@ -1482,6 +1484,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvm=
e_ctrl *ctrl,
>  	if (!ret) {
>  		info->anagrpid =3D id->anagrpid;
>  		info->is_shared =3D id->nmic & NVME_NS_NMIC_SHARED;
> +		info->is_readonly =3D id->nsattr & NVME_NS_ATTR_RO;
>  		info->is_ready =3D id->nstat & NVME_NSTAT_NRDY;
>  	}
>  	kfree(id);
> @@ -1909,6 +1912,11 @@ static void nvme_update_disk_info(struct gendisk *=
disk,
>  					   ns->ctrl->max_zeroes_sectors);
>  }
> =20
> +static bool nvme_ns_is_readonly(struct nvme_ns *ns, struct nvme_ns_info =
*info)
> +{
> +	return info->is_readonly || test_bit(NVME_NS_FORCE_RO, &ns->flags);
> +}
> +
>  static inline bool nvme_first_scan(struct gendisk *disk)
>  {
>  	/* nvme_alloc_ns() scans the disk prior to adding it */
> @@ -1974,8 +1982,7 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
>  		}
>  	}
> =20
> -	set_disk_ro(ns->disk, (id->nsattr & NVME_NS_ATTR_RO) ||
> -		test_bit(NVME_NS_FORCE_RO, &ns->flags));
> +	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
>  	set_bit(NVME_NS_READY, &ns->flags);
>  	blk_mq_unfreeze_queue(ns->disk->queue);
> =20
> @@ -1988,9 +1995,7 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
>  	if (nvme_ns_head_multipath(ns->head)) {
>  		blk_mq_freeze_queue(ns->head->disk->queue);
>  		nvme_update_disk_info(ns->head->disk, ns, id);
> -		set_disk_ro(ns->head->disk,
> -			    (id->nsattr & NVME_NS_ATTR_RO) ||
> -				    test_bit(NVME_NS_FORCE_RO, &ns->flags));
> +		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
>  		nvme_mpath_revalidate_paths(ns);
>  		blk_stack_limits(&ns->head->disk->queue->limits,
>  				 &ns->queue->limits, 0);
> --=20
> 2.30.2
>=20

LGTM
Reviewed-by: Joel Granados <j.granados@samsung.com>


--hxpfhli2b7yvb5tz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmLZImcACgkQupfNUreW
QU+Zwgv/aRkNBMZ/nm795llv+xLStzY02z87drFu9FAP/x8pIFF4lAmLBfNSnK58
7fW8hQoVSNx5Xz6rWEBq6Pf9LdKydGuxn2OmVURm4yEGkdSXOHCyuB0LFZeWhYtL
/cZKy2SHaF/Z9fEYFHx/gkcL0Ro0IzpeHaa2Gpy4AfjtSMzS4VknsX07S/URCsJw
w+sIDNnVBkpZQnAEFYCuVrVkiLgpxf3dorl4xnxr/0z8NK1qBLxEpc0C5/Lr7lQX
UGoOtoJRaDt6DpLD495PeyNmYght++WHbiTTIzVjqUzi9B0aCNU3VnYezTW3KbnD
GTP8OHOF0YeJrYza+DSVj0J3F7dSnbMuyFT2d7Mnnp7VRMA+vtOHv55dHX5nOELk
McsSChUsBHTEEgxMZz8hYmX+J/chtJL2gkWDlfYpuP5u5WO6lKodYiCyQPSs20QB
d3mTk55BepAnDEIcihZoJiOPLXOgLyrIi7pVBtjUvH74qdIu6l+VrYBvhGoY+IZf
KgzTH9tx
=W2DC
-----END PGP SIGNATURE-----

--hxpfhli2b7yvb5tz--

