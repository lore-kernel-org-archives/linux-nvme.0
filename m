Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9A3C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jul 2022 08:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D3eigwgAAuysPrJ5sjfAfPask7TIUjcQrrAROJaW+gg=; b=I4e+A1p9IE47rfV4alh0qTnjks
	0X5yFg5pHW+sLBdFJGUzWImCMVivuvBzkQiRVeNh6BfO1YSOCuHXo6O5vZMdvbH6AgFoZ+++lpoq3
	2oynNW9NprPs2jeu750AKW6ztLUzvuV56amlJC4uYNXtKqkrq5IJIBlj2B6ZDnw63prznceeithoJ
	JCmZIPDvYsfh80MXAogRYhm34PucfU6jTEOV2UQFQq+ngisyDreBJh9VwEnq/fynR8T5dv7d+fMWy
	nLduG4ltiIrwr+NJT6V1E5A3sJlMRGJOBJneJ98ifJ3GAfXDXguAnOkljyJ2OSd29QyE5uJtYK5c/
	nVvvEf0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE5Al-002e3Q-AP; Wed, 20 Jul 2022 08:35:11 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE5Ag-002dzy-RI
	for linux-nvme@lists.infradead.org; Wed, 20 Jul 2022 08:35:10 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220720083505euoutp01230e0148a628fa359f17a999f73535d2~DfJ3t22nI1589415894euoutp01k;
	Wed, 20 Jul 2022 08:35:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220720083505euoutp01230e0148a628fa359f17a999f73535d2~DfJ3t22nI1589415894euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1658306105;
	bh=D3eigwgAAuysPrJ5sjfAfPask7TIUjcQrrAROJaW+gg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=W59JgeEBeWcmRq0iYtqiA0SO9jVnbyrLH4MNsJTgN7im4Mibwl0aVvdjfl8Vf1rEP
	 rpz0x88yDwnE3OMsiB1vK2ldq8Nv2kIXdsOOsoNuoQ7UEJPAtoqo/iVc7oNMGEuZlb
	 FfSwuZmZH4IXwdOzttvvRHYRrXCM8xPu/zd0Zigo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220720083505eucas1p130e40b0c5f3fd404fe9e40404425a58c~DfJ3YP7Ey1541515415eucas1p1Q;
	Wed, 20 Jul 2022 08:35:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id B0.70.10067.93EB7D26; Wed, 20
	Jul 2022 09:35:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220720083504eucas1p2dd8c2a42393c08f5a82b5b032ec91305~DfJ2mHPoG2140521405eucas1p2l;
	Wed, 20 Jul 2022 08:35:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220720083504eusmtrp1c77bab8d17de5c9aa264ac3002a354f3~DfJ2la0Sc1057010570eusmtrp1Q;
	Wed, 20 Jul 2022 08:35:04 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-46-62d7be398383
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 22.9F.09095.83EB7D26; Wed, 20
	Jul 2022 09:35:04 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220720083504eusmtip2dcbd6ea3f83b5c13baa84f6a60b2e6dd~DfJ2aeyc02000020000eusmtip2R;
	Wed, 20 Jul 2022 08:35:04 +0000 (GMT)
Received: from localhost (106.210.248.172) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 20 Jul 2022 09:35:00 +0100
Date: Wed, 20 Jul 2022 10:19:12 +0200
From: Joel Granados <j.granados@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: <kbusch@kernel.org>, <sagi@grimberg.me>, <joshi.k@samsung.com>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<k.jensen@samsung.com>, Javier =?utf-8?B?R29uesOhbGV6?=
	<javier.gonz@samsung.com>
Subject: Re: [PATCH 3/5] nvme: refactor namespace probing
Message-ID: <20220720081912.uspwuwnsxna2pgos@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="ocqffkm5eepwfqxc"
Content-Disposition: inline
In-Reply-To: <20220718052503.235270-4-hch@lst.de>
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87qW+64nGWyZxW6xcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAliiuGxSUnMyy1KL9O0SuDKeblvD
	XNDdw1jx+s08pgbGz/ldjJwcEgImErM+3GTrYuTiEBJYwSixbssnFgjnC6PExpm7GSGcz4wS
	N/98YoJpeX/nGjtEYjmjxN2HB5jgqiZN+w/VspVRoutBO3MXIwcHi4CqxJbrdiDdbAI6Euff
	3GEGsUUElCSevjrLCGIzC1xllDi4SgjEFhawlGj49w2slVfAXOL29CKQMK+AoMTJmU9YQMLM
	AhUS/1akQZjSEsv/cYBUcAoYSmw78ZkZ4kxliTmvd0DZtRJrj50BO1lC4D+HxPXLa1ggEi4S
	Zy68YIewhSVeHd8CZctInJ7cA1WTLbFzyi6oQQUSs05OZQPZKyFgLdF3Jgci7CixvLmbESLM
	J3HjrSDET3wSk7ZNZ4YI80p0tAlBVKtJ7GjayjiBUXkWkrdmIbw1C+GtWWBz9CRuTJ3ChiGs
	LbFs4WtmCNtWYt269ywLGNlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKam0/+Of9nB
	uPzVR71DjEwcjIcYVYCaH21YfYFRiiUvPy9VSYT3aeH1JCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8yZkbEoUE0hNLUrNTUwtSi2CyTBycUg1MUVU14dP6Wh6snN9RIBtXmnSnZkt7TeTGxKYi
	p5LvrT+Cao5krcv7xZmrueTqtitdO1K25POdeNy0VlpmuRb/f+2ABY4rQ0WFly8/lDvN6IVd
	pIra1Volea8ny0vMkw63JIT9sbnrp3YqTWGeRW5iY+6s+xbz9j2Veb5N3Gv6lYyWpuPRVmai
	lz8+90i3Mze++i8/b8+KnPe5qmwLJ990NswKaI3N2f/sX6TKs8s5gbyLppen/DqbYuYbVcfj
	FPEw5aFiw8MOltXpQhp+DMeeXprKo66+++Whrb+l5SbdXL/k6VTJ0P2iCh+PW9Um+T5Uurk0
	OfLT4vM8BxK/CLe+6Qn2/TZhYWuV9QmGH2pKLMUZiYZazEXFiQCZFGJoyAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7oW+64nGXTP4LNYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRejZF+aUlqQoZ+cUltkrRhhZG
	eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkvjj5jLujsYaz4NPk1UwPjx/wuRk4O
	CQETifd3rrGD2EICSxklXhxkh4jLSHy68hHKFpb4c62LrYuRC6jmI6PEmskv2CGcrYwS3dsn
	M3YxcnCwCKhKbLluB9LAJqAjcf7NHWYQW0RASeLpq7OMIDazwFVGiYOrhEBsYQFLiYZ/35hB
	WnkFzCVuTy+CGLmaUeLU/S9g9bwCghInZz5hgegtk3h/YzXYKmYBaYnl/zhAwpwChhLbTnxm
	hrhTWWLO6x1Qdq3Eq/u7GScwCs9CMmkWkkmzECZBhHUkdm69w4YhrC2xbOFrZgjbVmLduvcs
	CxjZVzGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTG6bZjPzfvYJz36qPeIUYmDsZDjCpAnY82
	rL7AKMWSl5+XqiTC+7TwepIQb0piZVVqUX58UWlOavEhRlNgGE5klhJNzgcmkLySeEMzA1ND
	EzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBialiL+RFxQ2zm063v50z5Yy/bMP
	o6/XujP/9l18QnnG+Y+OPq/ezdqXqhXImlXmGeTl9s8nJv/Z/cNpbrxv3gpl9X/4fmcJ76aT
	3dNiN1ef/RDzuoJNdMMNiz9pi5LV/3pKrc88vmLC2XeFYW5KLjtlNINNbpgtWndTyn7Zi9A7
	T77NntQZdHsZ24PvP1MqdOMSj/jtT7bdxi8m/u1ZTpqDVMg/tzZ73lkMcppbJKs4Zr41ObF5
	stfBO/LNcw2v3otVTdnLcJ2pKdNsx3vXPWJHFBI9w2WVjYNKMxQaWyW+2kc1nWhXzsk87T0z
	9O/WytdPNjvdnnxt6jehlXVqApa6Cp8Lay5u45NTuiizl0eJpTgj0VCLuag4EQCsDZquaAMA
	AA==
X-CMS-MailID: 20220720083504eucas1p2dd8c2a42393c08f5a82b5b032ec91305
X-Msg-Generator: CA
X-RootMTR: 20220718052519eucas1p23ea18838828398065cf55f6c9ccb245a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220718052519eucas1p23ea18838828398065cf55f6c9ccb245a
References: <20220718052503.235270-1-hch@lst.de>
	<CGME20220718052519eucas1p23ea18838828398065cf55f6c9ccb245a@eucas1p2.samsung.com>
	<20220718052503.235270-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_013507_198285_05C67AC2 
X-CRM114-Status: GOOD (  31.27  )
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

--ocqffkm5eepwfqxc
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2022 at 07:25:01AM +0200, Christoph Hellwig wrote:
> Change nvme_ns_scan to gather all information needed for generic
> namespace setup into a nvme_ns_info structure.  This structure is filled
> from the Command Set Idependent Identify Namespace data structure if
> it is available or else the legacy Identify namespace structure.
>=20
> With that everything related to the NVM command set (and the ZNS command
> set derived from it) can be encapsulated in the nvme_update_ns_info_block
> function while keeping the rest of the namespace probing generic.
>=20
> The downside is that we now always issue two Identify Namespace calls for
> each probed namespace instead of usually just a single one previously.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> ---
>  drivers/nvme/host/core.c | 231 +++++++++++++++++++++------------------
>  1 file changed, 126 insertions(+), 105 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4769c49141913..659068f90165c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -31,6 +31,14 @@
> =20
>  #define NVME_MINORS		(1U << MINORBITS)
> =20
> +struct nvme_ns_info {
> +	struct nvme_ns_ids ids;
> +	u32 nsid;
> +	__le32 anagrpid;
> +	bool is_shared;
> +	bool is_ready;
> +};
Nitpick after looking at this for the second time:
Should we use tabs instead of spaces to increase readability here?

> +
>  unsigned int admin_timeout =3D 60;
>  module_param(admin_timeout, uint, 0644);
>  MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
> @@ -1342,8 +1350,8 @@ static int nvme_process_ns_desc(struct nvme_ctrl *c=
trl, struct nvme_ns_ids *ids,
>  	}
>  }
> =20
> -static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
> -		struct nvme_ns_ids *ids)
> +static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
> +		struct nvme_ns_info *info)
>  {
>  	struct nvme_command c =3D { };
>  	bool csi_seen =3D false;
> @@ -1356,7 +1364,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl =
*ctrl, unsigned nsid,
>  		return 0;
> =20
>  	c.identify.opcode =3D nvme_admin_identify;
> -	c.identify.nsid =3D cpu_to_le32(nsid);
> +	c.identify.nsid =3D cpu_to_le32(info->nsid);
>  	c.identify.cns =3D NVME_ID_CNS_NS_DESC_LIST;
> =20
>  	data =3D kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
> @@ -1368,7 +1376,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl =
*ctrl, unsigned nsid,
>  	if (status) {
>  		dev_warn(ctrl->device,
>  			"Identify Descriptors failed (nsid=3D%u, status=3D0x%x)\n",
> -			nsid, status);
> +			info->nsid, status);
>  		goto free_data;
>  	}
> =20
> @@ -1378,7 +1386,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl =
*ctrl, unsigned nsid,
>  		if (cur->nidl =3D=3D 0)
>  			break;
> =20
> -		len =3D nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
> +		len =3D nvme_process_ns_desc(ctrl, &info->ids, cur, &csi_seen);
>  		if (len < 0)
>  			break;
> =20
> @@ -1387,7 +1395,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl =
*ctrl, unsigned nsid,
> =20
>  	if (nvme_multi_css(ctrl) && !csi_seen) {
>  		dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
> -			 nsid);
> +			 info->nsid);
>  		status =3D -EINVAL;
>  	}
> =20
> @@ -1397,7 +1405,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl =
*ctrl, unsigned nsid,
>  }
> =20
>  static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
> -			struct nvme_ns_ids *ids, struct nvme_id_ns **id)
> +			struct nvme_id_ns **id)
>  {
>  	struct nvme_command c =3D { };
>  	int error;
> @@ -1420,51 +1428,64 @@ static int nvme_identify_ns(struct nvme_ctrl *ctr=
l, unsigned nsid,
>  	error =3D NVME_SC_INVALID_NS | NVME_SC_DNR;
>  	if ((*id)->ncap =3D=3D 0) /* namespace not allocated or attached */
>  		goto out_free_id;
> +	return 0;
> =20
> +out_free_id:
> +	kfree(*id);
> +	return error;
> +}
> =20
> +static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
> +		struct nvme_ns_info *info)
> +{
> +	struct nvme_ns_ids *ids =3D &info->ids;
> +	struct nvme_id_ns *id;
> +	int ret;
> +
> +	ret =3D nvme_identify_ns(ctrl, info->nsid, &id);
> +	if (ret)
> +		return ret;
> +	info->anagrpid =3D id->anagrpid;
> +	info->is_shared =3D id->nmic & NVME_NS_NMIC_SHARED;
> +	info->is_ready =3D true;
>  	if (ctrl->quirks & NVME_QUIRK_BOGUS_NID) {
>  		dev_info(ctrl->device,
>  			 "Ignoring bogus Namespace Identifiers\n");
>  	} else {
>  		if (ctrl->vs >=3D NVME_VS(1, 1, 0) &&
>  		    !memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
> -			memcpy(ids->eui64, (*id)->eui64, sizeof(ids->eui64));
> +			memcpy(ids->eui64, id->eui64, sizeof(ids->eui64));
>  		if (ctrl->vs >=3D NVME_VS(1, 2, 0) &&
>  		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
> -			memcpy(ids->nguid, (*id)->nguid, sizeof(ids->nguid));
> +			memcpy(ids->nguid, id->nguid, sizeof(ids->nguid));
>  	}
> -
> +	kfree(id);
>  	return 0;
> -
> -out_free_id:
> -	kfree(*id);
> -	return error;
>  }
> =20
> -static int nvme_identify_ns_cs_indep(struct nvme_ctrl *ctrl, unsigned ns=
id,
> -			struct nvme_id_ns_cs_indep **id)
> +static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
> +		struct nvme_ns_info *info)
>  {
> +	struct nvme_id_ns_cs_indep *id;
>  	struct nvme_command c =3D {
>  		.identify.opcode	=3D nvme_admin_identify,
> -		.identify.nsid		=3D cpu_to_le32(nsid),
> +		.identify.nsid		=3D cpu_to_le32(info->nsid),
>  		.identify.cns		=3D NVME_ID_CNS_NS_CS_INDEP,
>  	};
>  	int ret;
> =20
> -	*id =3D kmalloc(sizeof(**id), GFP_KERNEL);
> -	if (!*id)
> +	id =3D kmalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id)
>  		return -ENOMEM;
> =20
> -	ret =3D nvme_submit_sync_cmd(ctrl->admin_q, &c, *id, sizeof(**id));
> -	if (ret) {
> -		dev_warn(ctrl->device,
> -			 "Identify namespace (CS independent) failed (%d)\n",
> -			 ret);
> -		kfree(*id);
> -		return ret;
> +	ret =3D nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
> +	if (!ret) {
> +		info->anagrpid =3D id->anagrpid;
> +		info->is_shared =3D id->nmic & NVME_NS_NMIC_SHARED;
> +		info->is_ready =3D id->nstat & NVME_NSTAT_NRDY;
>  	}
> -
> -	return 0;
> +	kfree(id);
> +	return ret;
>  }
> =20
>  static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
> @@ -1925,12 +1946,19 @@ static void nvme_set_chunk_sectors(struct nvme_ns=
 *ns, struct nvme_id_ns *id)
>  	blk_queue_chunk_sectors(ns->queue, iob);
>  }
> =20
> -static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
> +static int nvme_update_ns_info_block(struct nvme_ns *ns,
> +		struct nvme_ns_info *info)
>  {
> -	unsigned lbaf =3D nvme_lbaf_index(id->flbas);
> +	struct nvme_id_ns *id;
> +	unsigned lbaf;
Checkpatch.pl has a warning here for use of 'unsigned int' instead of
just 'unsigned'

>  	int ret;
> =20
> +	ret =3D nvme_identify_ns(ns->ctrl, info->nsid, &id);
> +	if (ret)
> +		return ret;
> +
>  	blk_mq_freeze_queue(ns->disk->queue);
> +	lbaf =3D nvme_lbaf_index(id->flbas);
>  	ns->lba_shift =3D id->lbaf[lbaf].ds;
>  	nvme_set_queue_limits(ns->ctrl, ns->queue);
> =20
> @@ -1967,6 +1995,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, =
struct nvme_id_ns *id)
>  		disk_update_readahead(ns->head->disk);
>  		blk_mq_unfreeze_queue(ns->head->disk->queue);
>  	}
> +	kfree(id);
>  	return 0;
> =20
>  out_unfreeze:
> @@ -1980,9 +2009,30 @@ static int nvme_update_ns_info(struct nvme_ns *ns,=
 struct nvme_id_ns *id)
>  		ret =3D 0;
>  	}
>  	blk_mq_unfreeze_queue(ns->disk->queue);
> +	kfree(id);
>  	return ret;
>  }
> =20
> +static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *=
info)
> +{
> +	switch (info->ids.csi) {
> +	case NVME_CSI_ZNS:
> +		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +			dev_warn(ns->ctrl->device,
> +	"nsid %u not supported without CONFIG_BLK_DEV_ZONED\n",
> +				info->nsid);
> +			return -ENODEV;
> +		}
> +		return nvme_update_ns_info_block(ns, info);
> +	case NVME_CSI_NVM:
> +		return nvme_update_ns_info_block(ns, info);
> +	default:
> +		dev_warn(ns->ctrl->device, "unknown csi %u for nsid %u\n",
> +			info->ids.csi, info->nsid);
> +		return -ENODEV;
> +	}
> +}
> +
>  static char nvme_pr_type(enum pr_type type)
>  {
>  	switch (type) {
> @@ -3911,7 +3961,7 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
>  }
> =20
>  static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
> -		unsigned nsid, struct nvme_ns_ids *ids)
> +		struct nvme_ns_info *info)
>  {
>  	struct nvme_ns_head *head;
>  	size_t size =3D sizeof(*head);
> @@ -3933,8 +3983,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(stru=
ct nvme_ctrl *ctrl,
>  	if (ret)
>  		goto out_ida_remove;
>  	head->subsys =3D ctrl->subsys;
> -	head->ns_id =3D nsid;
> -	head->ids =3D *ids;
> +	head->ns_id =3D info->nsid;
> +	head->ids =3D info->ids;
> +	head->shared =3D info->is_shared;
>  	kref_init(&head->ref);
> =20
>  	if (head->ids.csi) {
> @@ -3991,55 +4042,54 @@ static int nvme_global_check_duplicate_ids(struct=
 nvme_subsystem *this,
>  	return ret;
>  }
> =20
> -static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
> -		struct nvme_ns_ids *ids, bool is_shared)
> +static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *in=
fo)
>  {
>  	struct nvme_ctrl *ctrl =3D ns->ctrl;
>  	struct nvme_ns_head *head =3D NULL;
>  	int ret;
> =20
> -	ret =3D nvme_global_check_duplicate_ids(ctrl->subsys, ids);
> +	ret =3D nvme_global_check_duplicate_ids(ctrl->subsys, &info->ids);
>  	if (ret) {
>  		dev_err(ctrl->device,
> -			"globally duplicate IDs for nsid %d\n", nsid);
> +			"globally duplicate IDs for nsid %d\n", info->nsid);
>  		nvme_print_device_info(ctrl);
>  		return ret;
>  	}
> =20
>  	mutex_lock(&ctrl->subsys->lock);
> -	head =3D nvme_find_ns_head(ctrl, nsid);
> +	head =3D nvme_find_ns_head(ctrl, info->nsid);
>  	if (!head) {
> -		ret =3D nvme_subsys_check_duplicate_ids(ctrl->subsys, ids);
> +		ret =3D nvme_subsys_check_duplicate_ids(ctrl->subsys, &info->ids);
>  		if (ret) {
>  			dev_err(ctrl->device,
>  				"duplicate IDs in subsystem for nsid %d\n",
> -				nsid);
> +				info->nsid);
>  			goto out_unlock;
>  		}
> -		head =3D nvme_alloc_ns_head(ctrl, nsid, ids);
> +		head =3D nvme_alloc_ns_head(ctrl, info);
>  		if (IS_ERR(head)) {
>  			ret =3D PTR_ERR(head);
>  			goto out_unlock;
>  		}
> -		head->shared =3D is_shared;
>  	} else {
>  		ret =3D -EINVAL;
> -		if (!is_shared || !head->shared) {
> +		if (!info->is_shared || !head->shared) {
>  			dev_err(ctrl->device,
> -				"Duplicate unshared namespace %d\n", nsid);
> +				"Duplicate unshared namespace %d\n",
> +				info->nsid);
>  			goto out_put_ns_head;
>  		}
> -		if (!nvme_ns_ids_equal(&head->ids, ids)) {
> +		if (!nvme_ns_ids_equal(&head->ids, &info->ids)) {
>  			dev_err(ctrl->device,
>  				"IDs don't match for shared namespace %d\n",
> -					nsid);
> +					info->nsid);
>  			goto out_put_ns_head;
>  		}
> =20
>  		if (!multipath && !list_empty(&head->list)) {
>  			dev_warn(ctrl->device,
>  				"Found shared namespace %d, but multipathing not supported.\n",
> -				nsid);
> +				info->nsid);
>  			dev_warn_once(ctrl->device,
>  				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is depr=
ecated and will be removed in Linux 6.0\n.");
>  		}
> @@ -4093,20 +4143,15 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_=
ns *ns)
>  	list_add(&ns->list, &ns->ctrl->namespaces);
>  }
> =20
> -static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
> -		struct nvme_ns_ids *ids)
> +static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *i=
nfo)
>  {
>  	struct nvme_ns *ns;
>  	struct gendisk *disk;
> -	struct nvme_id_ns *id;
>  	int node =3D ctrl->numa_node;
> =20
> -	if (nvme_identify_ns(ctrl, nsid, ids, &id))
> -		return;
> -
>  	ns =3D kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
>  	if (!ns)
> -		goto out_free_id;
> +		return;
> =20
>  	disk =3D blk_mq_alloc_disk(ctrl->tagset, ns);
>  	if (IS_ERR(disk))
> @@ -4127,7 +4172,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, u=
nsigned nsid,
>  	ns->ctrl =3D ctrl;
>  	kref_init(&ns->kref);
> =20
> -	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
> +	if (nvme_init_ns_head(ns, info))
>  		goto out_cleanup_disk;
> =20
>  	/*
> @@ -4153,7 +4198,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, u=
nsigned nsid,
>  			ns->head->instance);
>  	}
> =20
> -	if (nvme_update_ns_info(ns, id))
> +	if (nvme_update_ns_info(ns, info))
>  		goto out_unlink_ns;
> =20
>  	down_write(&ctrl->namespaces_rwsem);
> @@ -4167,9 +4212,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, u=
nsigned nsid,
>  	if (!nvme_ns_head_multipath(ns->head))
>  		nvme_add_ns_cdev(ns);
> =20
> -	nvme_mpath_add_disk(ns, id->anagrpid);
> +	nvme_mpath_add_disk(ns, info->anagrpid);
>  	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
> -	kfree(id);
> =20
>  	return;
> =20
> @@ -4189,8 +4233,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, u=
nsigned nsid,
>  	blk_cleanup_disk(disk);
>   out_free_ns:
>  	kfree(ns);
> - out_free_id:
> -	kfree(id);
>  }
> =20
>  static void nvme_ns_remove(struct nvme_ns *ns)
> @@ -4249,29 +4291,21 @@ static void nvme_ns_remove_by_nsid(struct nvme_ct=
rl *ctrl, u32 nsid)
>  	}
>  }
> =20
> -static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
> +static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *in=
fo)
>  {
> -	struct nvme_id_ns *id;
>  	int ret =3D NVME_SC_INVALID_NS | NVME_SC_DNR;
> =20
>  	if (test_bit(NVME_NS_DEAD, &ns->flags))
>  		goto out;
> =20
> -	ret =3D nvme_identify_ns(ns->ctrl, ns->head->ns_id, ids, &id);
> -	if (ret)
> -		goto out;
> -
>  	ret =3D NVME_SC_INVALID_NS | NVME_SC_DNR;
> -	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
> +	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
>  		dev_err(ns->ctrl->device,
>  			"identifiers changed for nsid %d\n", ns->head->ns_id);
> -		goto out_free_id;
> +		goto out;
>  	}
> =20
> -	ret =3D nvme_update_ns_info(ns, id);
> -
> -out_free_id:
> -	kfree(id);
> +	ret =3D nvme_update_ns_info(ns, info);
>  out:
>  	/*
>  	 * Only remove the namespace if we got a fatal error back from the
> @@ -4285,57 +4319,44 @@ static void nvme_validate_ns(struct nvme_ns *ns, =
struct nvme_ns_ids *ids)
> =20
>  static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  {
> -	struct nvme_ns_ids ids =3D { };
> -	struct nvme_id_ns_cs_indep *id;
> +	struct nvme_ns_info info =3D { .nsid =3D nsid };
>  	struct nvme_ns *ns;
> -	bool ready =3D true;
> =20
> -	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
> +	if (nvme_identify_ns_descs(ctrl, &info))
>  		return;
> =20
> -	if (ids.csi !=3D NVME_CSI_NVM && !nvme_multi_css(ctrl)) {
> +	if (info.ids.csi !=3D NVME_CSI_NVM && !nvme_multi_css(ctrl)) {
>  		dev_warn(ctrl->device,
>  			"command set not reported for nsid: %d\n", nsid);
>  		return;
>  	}
> =20
>  	/*
> -	 * Check if the namespace is ready.  If not ignore it, we will get an
> -	 * AEN once it becomes ready and restart the scan.
> +	 * If available try to use the Command Set Idependent Identify Namespace
> +	 * data structure to find all the generic information that is needed to
> +	 * set up a namespace.  If not fall back to the legacy version.
>  	 */
> -	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) &&
> -	    !nvme_identify_ns_cs_indep(ctrl, nsid, &id)) {
> -		ready =3D id->nstat & NVME_NSTAT_NRDY;
> -		kfree(id);
> +	if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
> +		if (nvme_ns_info_from_id_cs_indep(ctrl, &info))
> +			return;
> +	} else {
> +		if (nvme_ns_info_from_identify(ctrl, &info))
> +			return;
>  	}
> =20
> -	if (!ready)
> +	/*
> +	 * Ignore the namespace if it is not ready. We will get an AEN once it
> +	 * becomes ready and restart the scan.
> +	 */
> +	if (!info.is_ready)
>  		return;
> =20
>  	ns =3D nvme_find_get_ns(ctrl, nsid);
>  	if (ns) {
> -		nvme_validate_ns(ns, &ids);
> +		nvme_validate_ns(ns, &info);
>  		nvme_put_ns(ns);
> -		return;
> -	}
> -
> -	switch (ids.csi) {
> -	case NVME_CSI_NVM:
> -		nvme_alloc_ns(ctrl, nsid, &ids);
> -		break;
> -	case NVME_CSI_ZNS:
> -		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> -			dev_warn(ctrl->device,
> -				"nsid %u not supported without CONFIG_BLK_DEV_ZONED\n",
> -				nsid);
> -			break;
> -		}
> -		nvme_alloc_ns(ctrl, nsid, &ids);
> -		break;
> -	default:
> -		dev_warn(ctrl->device, "unknown csi %u for nsid %u\n",
> -			ids.csi, nsid);
> -		break;
> +	} else {
> +		nvme_alloc_ns(ctrl, &info);
>  	}
>  }
> =20
> --=20
> 2.30.2
>=20

--ocqffkm5eepwfqxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmLXun8ACgkQupfNUreW
QU+YkAwAgnoSXE1R5JEBzchTFjCmI9H8Vz4WcliOzj1zYRRpdePzoz4exZNy+5t5
TEeDyl3AP+h0WbPM6KXxWGpinwvipmn3Wj5bXhHTFTEsG54V3sbj1eQy97DUFqCB
Nf5MLhaali8B7rEZ3ilckpXtceZWVH9xGSyFl0mOCAUaabKnjw4VmLWUbv1ZGyDC
AkBXvAtUuAq3aRIFHN6cdSy9/Yl8npBZs5c6F8WDegg921B2YFdKT5fin03bRMtZ
4iMlnZ9cIWcJmLm4ERsuvoyY0T9O5x/fZJZf3NbrGerEH7bUWmF8efmF1S6aBsqc
yu71gld6uD3+qRHenP8Q6XhGINLfN+1oH2sTZQOnALbfQm3pQIZpmwV0bCKIMRn1
hxP1CYQlg0JFXFxp0h2Tm6JFeyveLo7vVwfNSjKZHYU1baKU81x0sL6Tu87GmXsp
7OMUjTqeyxnq+8heQXhpEh3DSRsH49Gd0XR/uTH7p1JXTC/y3bcidnZKaMY65HlZ
sBlJK0Tq
=f0fC
-----END PGP SIGNATURE-----

--ocqffkm5eepwfqxc--

