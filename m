Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F58BC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 09:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ZNr5/ibdubXMKKeROFNvDU8A6+Z42vnJ39GcNA3vMg=; b=R7wWl3eav7vIiMvRp9RdfdJv4J
	WdQ5w0AuAUKzd89debJ9HXBw9TvaclbWJ+ThQUg73coNCth94H8oyviyckKDK4uOwUZzkJsmrDVaE
	GZw/bw2Jy1CfXkJKHYl4afUgTS+mlBD5+8z6zapn2racMAHlgem190Zzqw3G73AWiDUmWK2t8uXU3
	wY4ejR0wnzsNuSN9RJJp/880vWchfn6LtnbecLJyux6kHSfa2Ztj2ms6lKvahuwaM1zsuwwnzMyoS
	s3X/t10SDd/UFOIj7np58VkoJKDy/ch+Q/psdDEsDxBOTpAMS7I/m19dOpWZK+OecFKKi6vx9MW6z
	fmRbb5sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oESbo-003PPy-K9; Thu, 21 Jul 2022 09:36:40 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oESbi-003PK4-SJ
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 09:36:38 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220721093625euoutp01636c035c2722382d018990b4f39b03d1~DzotfYreZ0110001100euoutp01S;
	Thu, 21 Jul 2022 09:36:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220721093625euoutp01636c035c2722382d018990b4f39b03d1~DzotfYreZ0110001100euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1658396185;
	bh=5ZNr5/ibdubXMKKeROFNvDU8A6+Z42vnJ39GcNA3vMg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=MBdQ0oMPZnr3NOkPKgC/MXiJZN/SoQ2OLtwjOmMcbwQvX6WoV4v44VlVC2bEeyKrF
	 O2U/7mOVd/txzAzP9gA3XnGLrNYWu+BTzhsCkzZ72MD+Di2bDIlJ5xubqv6obBjDpJ
	 TdLeLX+B9lyc0A58+GhXnYqrafWwRbfcDvp6IRtQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220721093625eucas1p2395215b690433910b15377a6b1801278~DzotGXGtC1894218942eucas1p22;
	Thu, 21 Jul 2022 09:36:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 36.6E.10067.91E19D26; Thu, 21
	Jul 2022 10:36:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220721093624eucas1p2255b2456878503f3a10051c1c4ecb88c~DzosuRYQm1892218922eucas1p2p;
	Thu, 21 Jul 2022 09:36:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220721093624eusmtrp156d287525475ca297e68d384a0c2bff8~DzostkWLd1429914299eusmtrp1-;
	Thu, 21 Jul 2022 09:36:24 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-f8-62d91e19c381
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 79.B2.09095.81E19D26; Thu, 21
	Jul 2022 10:36:24 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220721093624eusmtip170a1f9f012a4afb5965132ccaa4e0761~DzosjvMdT1323913239eusmtip1V;
	Thu, 21 Jul 2022 09:36:24 +0000 (GMT)
Received: from localhost (106.210.248.172) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 21 Jul 2022 10:36:19 +0100
Date: Thu, 21 Jul 2022 11:36:18 +0200
From: Joel Granados <j.granados@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: <kbusch@kernel.org>, <sagi@grimberg.me>, <joshi.k@samsung.com>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<k.jensen@samsung.com>, Javier =?utf-8?B?R29uesOhbGV6?=
	<javier.gonz@samsung.com>
Subject: Re: [PATCH 4/6] nvme: refactor namespace probing
Message-ID: <20220721093618.jwkj5biwo6lsnuqj@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="bbvougbtfpaoajds"
Content-Disposition: inline
In-Reply-To: <20220721060320.1704646-5-hch@lst.de>
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djP87qScjeTDN48FbZYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRXDYpqTmZZalF+nYJXBkPlh9k
	K3jdwVix/up/5gbGJbldjJwcEgImEmu+nWftYuTiEBJYwSjR+reNDcL5wiixef8sZgjnM6PE
	1pavrDAtm1+vY4RILGeU2LKnjR2u6t3ekywQzlZGiRP/joG1sAioSsy/vIANxGYT0JE4/+YO
	M4gtIqAk8fTVWUYQm1ngKqPEwVVCILawgKXEs45/YDW8AuYSW2ddh7IFJU7OfMICUV8hcfx7
	A9B8DiBbWmL5Pw6QMKeAkcTy9V1sEJcqS8x5vYMZwq6VWHvsDNihEgI/OCSmXbgI9Y6LRM+f
	u1BFwhKvjm9hh7BlJE5P7mGBsLMldk7ZBVVTIDHr5FQ2kL0SAtYSfWdyIMKOEt+mn2OECPNJ
	3HgrCHEln8SkbdOZIcK8Eh1tQhDVahI7mrYyTmBUnoXkr1lI/pqF8BdEWE/ixtQpbBjC2hLL
	Fr5mhrBtJdate8+ygJF9FaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmCKOv3v+JcdjMtf
	fdQ7xMjEwXiIUQWo+dGG1RcYpVjy8vNSlUR4nxZeTxLiTUmsrEotyo8vKs1JLT7EKM3BoiTO
	m5y5IVFIID2xJDU7NbUgtQgmy8TBKdXAtOJMb/VZM817ql7TlBMbDi4V38ESlFXabf1tyW3t
	L9uepdk8kWQIOXf3neZfR97Fh01f6vS///fMMI/pxefnp4UYvTI2vWK8c0W4kldezp7PX+P9
	Ve3+YwXfJ25oTZ3JLXPu0xfxq3XzdikGbZjwo14911zzg6ClkOe6dUH8N/QDGi5ynOm4YjPP
	3/f837RDfM5LDq2eF6p4P2A7X/cqdRE/zvppU/fPrVFw8GatvSkcq5L1b11SXllm1WPfLx5V
	7f7pjsaTNqxfFKD98ubqfXpbv2gFJ+9S+nvO5HiR3cmaHI8Nt7JCvY5J3YyKeWa2ROfd9aup
	UZp8ZZzyi/Q6nnEopSTIKq1Y8H+LwKF3SizFGYmGWsxFxYkAj/ekGcwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7oScjeTDGbsM7NYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRejZF+aUlqQoZ+cUltkrRhhZG
	eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkv7x1nKnjZwVixb28XawPjotwuRk4O
	CQETic2v1zF2MXJxCAksZZSY3nGBDSIhI/Hpykd2CFtY4s+1LjaIoo+MEl/OX2QGSQgJbAXq
	aC0HsVkEVCXmX14A1swmoCNx/s0dsBoRASWJp6/OMoLYzAJXGSUOrhICsYUFLCWedfwDq+EV
	MJfYOus6M8SCtYwSrVP3sEAkBCVOznzCAtFcJjHv6hSgiziAbGmJ5f84QMKcAkYSy9d3QR2t
	LDHn9Q5mCLtW4tX93YwTGIVnIZk0C8mkWQiTIMI6Eju33mHDENaWWLbwNTOEbSuxbt17lgWM
	7KsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECY3XbsZ+bdzDOe/VR7xAjEwfjIUYVoM5HG1Zf
	YJRiycvPS1US4X1aeD1JiDclsbIqtSg/vqg0J7X4EKMpMBQnMkuJJucDk0heSbyhmYGpoYmZ
	pYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAPTFg+dh4ETfkRkrPixVX9D3eaGiDfB
	K7bOm1jw22CjD1NKfc3DR/WLprPxMG+rqW3pD5PwXDexVd7+h2ND1sW0Q113vmgu32qVdihp
	a6abqvLk+h2vGnxvqBpPPuzAtYrHKqKA70h/y/0P/RnC89Sf8Uh3P17tKFO/tGn3u5/WoSpM
	br/WLf1ret1jq7CJ35EwXdUppyrYHn6q9+k9rPDgW2NpQGd24VnjS4USYlO3z2DPujlb58Fd
	syy9JUf1FL5OiL0l839VXIdCkRhLheyERKFgO6GMD8nbPFc7lvXdy7y1cEFuwJEvQjsvTFs5
	PV5sZWy/9+zXS9TMup4wrDdscOoyuac4S/ZDeE+/6SMlluKMREMt5qLiRAAJ/20oagMAAA==
X-CMS-MailID: 20220721093624eucas1p2255b2456878503f3a10051c1c4ecb88c
X-Msg-Generator: CA
X-RootMTR: 20220721060344eucas1p1e65827c0216e70f05407ded24d88cce0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220721060344eucas1p1e65827c0216e70f05407ded24d88cce0
References: <20220721060320.1704646-1-hch@lst.de>
	<CGME20220721060344eucas1p1e65827c0216e70f05407ded24d88cce0@eucas1p1.samsung.com>
	<20220721060320.1704646-5-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_023636_174017_EA2A1BB9 
X-CRM114-Status: GOOD (  30.23  )
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

--bbvougbtfpaoajds
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 08:03:18AM +0200, Christoph Hellwig wrote:
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
>  drivers/nvme/host/core.c | 230 +++++++++++++++++++++------------------
>  1 file changed, 125 insertions(+), 105 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 5ba09d010daba..6169737c233b2 100644
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
> @@ -1981,9 +2009,30 @@ static int nvme_update_ns_info(struct nvme_ns *ns,=
 struct nvme_id_ns *id)
>  		set_bit(NVME_NS_READY, &ns->flags);
>  		ret =3D 0;
>  	}
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
> @@ -3913,7 +3962,7 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
>  }
> =20
>  static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
> -		unsigned nsid, struct nvme_ns_ids *ids)
> +		struct nvme_ns_info *info)
>  {
>  	struct nvme_ns_head *head;
>  	size_t size =3D sizeof(*head);
> @@ -3935,8 +3984,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(stru=
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
> @@ -3993,55 +4043,54 @@ static int nvme_global_check_duplicate_ids(struct=
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
> @@ -4095,20 +4144,15 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_=
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
> @@ -4129,7 +4173,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, u=
nsigned nsid,
>  	ns->ctrl =3D ctrl;
>  	kref_init(&ns->kref);
> =20
> -	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
> +	if (nvme_init_ns_head(ns, info))
>  		goto out_cleanup_disk;
> =20
>  	/*
> @@ -4155,7 +4199,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, u=
nsigned nsid,
>  			ns->head->instance);
>  	}
> =20
> -	if (nvme_update_ns_info(ns, id))
> +	if (nvme_update_ns_info(ns, info))
>  		goto out_unlink_ns;
> =20
>  	down_write(&ctrl->namespaces_rwsem);
> @@ -4169,9 +4213,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, u=
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
> @@ -4191,8 +4234,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, u=
nsigned nsid,
>  	blk_cleanup_disk(disk);
>   out_free_ns:
>  	kfree(ns);
> - out_free_id:
> -	kfree(id);
>  }
> =20
>  static void nvme_ns_remove(struct nvme_ns *ns)
> @@ -4251,29 +4292,21 @@ static void nvme_ns_remove_by_nsid(struct nvme_ct=
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
> @@ -4287,57 +4320,44 @@ static void nvme_validate_ns(struct nvme_ns *ns, =
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

LGTM
Reviewed-by: Joel Granados <j.granados@samsung.com>

--bbvougbtfpaoajds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmLZHgkACgkQupfNUreW
QU+DtAv+I1lppyDKkzd/xW/HgjqnqzDuBlOVyVgaeIq3hwikRhoz7YoCDDVhIKxD
863PgQAPobanENJOx1fIggmUVf9yDWZ2q0vFZ2TEerG8kuivObsFMiCYUxrHYbmp
Wbdp67hrpqmfVEK+jg0bFxX//O4nUcRcY6TYcu7uJACrdsDdEr/GuxInkfUl/NMx
HnPkpVRXaMMaYroR1FXm/9hvt6bOYANstsutui9PLf+K9gMEinAQoxgOoRf9uOaQ
jq0z5C1rT35vVcOg9pLXcN0oSN+mQC43Z3f51Y4IaSN+jn5YHsvjbkcLAnQAf/y0
GVi4uw4NHFJWoF37H20nGSenOoq2Dn43n5cOlQYlTQODnXzrQzUIhrKXJK06FDJp
5ELmCQy2mlTPHMcMi73XMcOoutlbKWxzd8JsxJnEBtzOSRCPYGORCHqQIbmo5zga
gFx1JPilWb6RDm0cYfmeGNxiX3QlYYgRyi1p1COYyT+BYDVq/dLh42jgq9/Irqak
11YkNpjr
=3Dv6
-----END PGP SIGNATURE-----

--bbvougbtfpaoajds--

