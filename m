Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3551BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bATTgMhMwxw9houHJlTChTK97i3o0ZAnQSid9Z2ANFQ=; b=ifeXGn3XJpbQ9wHoFiQhPWAXo+
	dRKh/20jYhA/upj9jWAnITDm1yqKcKlQW23YMZz++Ai5Qcm646YplKgWp2dBUfaR5y8QDNgbQFfhi
	8AZKl27ReBmJxl1mjWynwqe0pxPMDalBbCCERA2eezv8lu0egoq9QStiXimydEidBPSzRx215YEcu
	7XigbWn2M+KZftlxSRq0XfUUn2eiQjsewBm8DGUjb9e4nm7/PGENCDJCG1iQVD3Iz60wXH+yvJVor
	7NNPDAR5/a+qP7oIMmnwCrAnGqyY3YhOaVdfvKoha+kHWD1KXK6pjhlPdTVoRH9IEaR7OZtKaQ/Aw
	fq4qVl8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKLbE-007NFm-4O; Wed, 16 Feb 2022 14:48:08 +0000
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKLb7-007NEX-Kl
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 14:48:06 +0000
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20220216144757usoutp0295f2e669e00a80ec0b2cad9eddff0db7~US5dwtRvE0454204542usoutp02q;
 Wed, 16 Feb 2022 14:47:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20220216144757usoutp0295f2e669e00a80ec0b2cad9eddff0db7~US5dwtRvE0454204542usoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1645022877;
 bh=bATTgMhMwxw9houHJlTChTK97i3o0ZAnQSid9Z2ANFQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=YyCgvffSOT+JdPQLaWOGc0lvY/HAF4o0o4R/ycYTARpjupzCNUenzmnFaI7pKyzCY
 KMeWSNYriBSB3kJagCVRhKAflVxNUjvRQiTWyFn1U9m7D1hBQA1bT29aBpJJJFSZ2I
 I8jmPJyXZlA/wvFLvyOeixkUmYw6MDqLM20os/PQ=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
 [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220216144757uscas1p193088983d2fecbba941e13719676713f~US5djYzLq2110921109uscas1p1p;
 Wed, 16 Feb 2022 14:47:57 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges1new.samsung.com (USCPEMTA) with SMTP id CE.B2.09744.D9E0D026; Wed,
 16 Feb 2022 09:47:57 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
 [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220216144757uscas1p28813487cfc37b977fbd23e985714c998~US5dOYAfZ0896008960uscas1p21;
 Wed, 16 Feb 2022 14:47:57 +0000 (GMT)
X-AuditID: cbfec36d-879ff70000002610-21-620d0e9d644a
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 1E.58.09671.C9E0D026; Wed,
 16 Feb 2022 09:47:57 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
 SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2242.4; Wed, 16 Feb 2022 06:47:31 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
 SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
 15.01.2242.008; Wed, 16 Feb 2022 06:47:31 -0800
From: Adam Manzanares <a.manzanares@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Daniel Wagner <dwagner@suse.de>, Kanchan Joshi <joshiiitr@gmail.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 "Hannes Reinecke" <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-multipath: fix multipath path scan
Thread-Topic: [PATCH] nvme-multipath: fix multipath path scan
Thread-Index: AQHYIv1e+YHYC3yXN0Kz3tMNc+dQ4KyWWdEAgABNMwCAAAKhgIAABosAgAAYSgA=
Date: Wed, 16 Feb 2022 14:47:31 +0000
Message-ID: <20220216144742.GA2231@bgt-140510-bm01>
In-Reply-To: <20220216132056.GA15649@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
x-exchange-save: DSA
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7C01369AE3F0F54E962AA9380BD003B1@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djXc7pz+XiTDNZNkbQ4/HgSu8WeRZOY
 LFauPspkcf7tYSaLSYeuMVrMX/aU3WLd6/csDuweO2fdZfc4f28ji8emVZ1sHpuX1HvsvtkA
 ZJyuDmCL4rJJSc3JLEst0rdL4Mp4uX8ue8EvmYonG5qYGxinincxcnJICJhIdHZuZ+pi5OIQ
 EljJKHHs2nI2CKeVSWL65/8sMFU7bzcxQiTWMkps3jkPquUjo8S6L1+hnAOMEtc23mcHaWET
 MJD4fXwjM4gtIqAk8fTVWbB2ZoHZTBIPdx4AKxIWsJE4tHseG0SRrcTa3XdYIGw/icPP/zGB
 2CwCqhJnvm9kBbF5BYwl/s7oBBvKKaAjce9SJ1gvo4CYxPdTa8DqmQXEJW49mc8EcbegxKLZ
 e5ghbDGJf7seskHYihL3v79kh7BFJNZ9f8sG0asjsWD3JyjbTuLL2vlQM7Ulli18zQxxg6DE
 yZlPoOEiKXFwxQ0WkMckBJ5wSDz59oMVIuEicejDKqjF0hJXr09lhihaxSgx5VsbO4SzmVFi
 xq8LTBMYVWchuXwWkktmIblkFpJLZiG5ZAEj6ypG8dLi4tz01GLDvNRyveLE3OLSvHS95Pzc
 TYzAhHX63+HcHYw7bn3UO8TIxMF4iFGCg1lJhDfuLGeSEG9KYmVValF+fFFpTmrxIUZpDhYl
 cd5lmRsShQTSE0tSs1NTC1KLYLJMHJxSDUy28499nbTT7rB93NtJIpwHVwTK7VRROCRU8m0T
 R2mj/KJlDCwzjgQzTHNg3fnHUZTLZt8il4lljq8X9Kk9/H7pt/rNz8JzonfMVkmcnt7Bl8U6
 ZfmPrL6+1RO4L6WzlsgUbO/99N118ftJu2pCl254c/qd/XeHMr97h0JOTrt0df6NJOUVL9hs
 Q7ReyfMy/La4Urlg+TuLI4Ue/mdEtxg3tO+YrLPES3Bepcxitw1Vz/N2Tn/SbR6sKvhQTkKR
 V3I615Gz4fIrptj8PZP/+zmf5IvpES91Lhuu2OW5Vzltp+0hxnttr/+WLnl40eOruugWkf9M
 vTuUbwilbJ2w96VDufR+h0ldE6w2uXczHu5/qMRSnJFoqMVcVJwIAJ+QwfjHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWS2cA0SXcuH2+SQUe9xeHHk9gt9iyaxGSx
 cvVRJovzbw8zWUw6dI3RYv6yp+wW616/Z3Fg99g56y67x/l7G1k8Nq3qZPPYvKTeY/fNBiDj
 dHUAWxSXTUpqTmZZapG+XQJXxsv9c9kLfslUPNnQxNzAOFW8i5GTQ0LARGLn7SbGLkYuDiGB
 1YwS63+fhXI+Mkrc6/zDDFIlJHCAUeLwBnsQm03AQOL38Y1gcREBJYmnryAamAVmM0ncP/WX
 DSQhLGAjcWj3PDaIIluJtbvvsEDYfhKHn/9jArFZBFQlznzfyApi8woYS/yd0ckMsfkQk8S7
 kwfAEpwCOhL3LnWCDWIUEJP4fmoNWDOzgLjErSfzmSB+EJBYsuc8M4QtKvHy8T9WCFtR4v73
 l+wQtojEuu9v2SB6dSQW7P4EZdtJfFk7H2qmtsSyha+ZIQ4SlDg58wkLRK+kxMEVN1gmMErO
 QrJ6FpJRs5CMmoVk1CwkoxYwsq5iFC8tLs5Nryg2zEst1ytOzC0uzUvXS87P3cQIjP7T/w5H
 7mA8euuj3iFGJg7GQ4wSHMxKIrxxZzmThHhTEiurUovy44tKc1KLDzFKc7AoifMKuU6MFxJI
 TyxJzU5NLUgtgskycXBKNTCJOGkeLfzjfVh5rtThw+daMx9U+Mlry+4/Zfhz+URhfQ+bi1sV
 DBlEnu86laidqvDxiLqx9BbWJ51iMxmf1/3+UZP3ctLr92dmXXZptd19wsGvo1ObNfTnq4fp
 J8MU2KdfPc3Y3zjTJJw/Y2lYjtYOn0pro5sHOo/6OB5hnvFnP/t2RuHT+5m1Mi9YnH3///iZ
 avssnw0vP3npXj236/8639uRVruYFeOevgtrWF4uNX9Nzo4rzx96rrmy2tdAdE9LLA/7l2yb
 l6GNr/cv0gj/yzv3wx/rgMYjacqnXzXdmnLd9fRvy23/+Kp37L5eK3t2Rt46pzcrZ/5suFtk
 e9pN5IuSY3vhm/bXmflcKd+llViKMxINtZiLihMBXW4CSW0DAAA=
X-CMS-MailID: 20220216144757uscas1p28813487cfc37b977fbd23e985714c998
CMS-TYPE: 301P
X-CMS-RootMailID: 20220216061807epcas5p1a349815c50db8f3539c30e2dd569232f
References: <CGME20220216061807epcas5p1a349815c50db8f3539c30e2dd569232f@epcas5p1.samsung.com>
 <20220216061305.45360-1-joshi.k@samsung.com> <20220216081148.GA10851@lst.de>
 <CA+1E3r+3ra2sr3hHx4b2QEq-tsQ6sfLp+hVvPz0a+Q_8G84QKg@mail.gmail.com>
 <20220216125731.6juezl4kshv7ovbp@carbon.lan> <20220216132056.GA15649@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_064801_905297_404E27E7 
X-CRM114-Status: GOOD (  26.41  )
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

On Wed, Feb 16, 2022 at 02:20:56PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 16, 2022 at 01:57:31PM +0100, Daniel Wagner wrote:
> > > In nvme_update_zone_info, but nvme_configure_metadata is also possibl=
e.
> > > Moved setting the flag before both these.
> >=20
> > But the NS is not ready at this point. nvme_update_disk_info() needs ru=
n
> > before the NS can be marked as ready. Commit message e7d65803e2bb
> > ("nvme-multipath: revalidate paths during rescan") explains why.
>=20
> Yeah.  So the only error return from nvme_configure_metadata is a can not
> happen case which doesn't really need the error return.  So we only
> need to check nvme_update_zone_info and can set the ns life for the
> -ENODEV case there.  Something like the patch below:
>=20
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 79005ea1a33e3..7814df10b5199 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1723,7 +1723,7 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *=
ctrl, struct nvme_ns *ns,
>  	return 0;
>  }
> =20
> -static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns=
 *id)
> +static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_n=
s *id)
>  {
>  	struct nvme_ctrl *ctrl =3D ns->ctrl;
> =20
> @@ -1739,7 +1739,8 @@ static int nvme_configure_metadata(struct nvme_ns *=
ns, struct nvme_id_ns *id)
> =20
>  	ns->features &=3D ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
>  	if (!ns->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
> -		return 0;
> +		return;
> +
>  	if (ctrl->ops->flags & NVME_F_FABRICS) {
>  		/*
>  		 * The NVMe over Fabrics specification only supports metadata as
> @@ -1747,7 +1748,7 @@ static int nvme_configure_metadata(struct nvme_ns *=
ns, struct nvme_id_ns *id)
>  		 * remap the separate metadata buffer from the block layer.
>  		 */
>  		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
> -			return -EINVAL;
> +			return;
> =20
>  		ns->features |=3D NVME_NS_EXT_LBAS;
> =20
> @@ -1774,8 +1775,6 @@ static int nvme_configure_metadata(struct nvme_ns *=
ns, struct nvme_id_ns *id)
>  		else
>  			ns->features |=3D NVME_NS_METADATA_SUPPORTED;
>  	}
> -
> -	return 0;
>  }
> =20
>  static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
> @@ -1916,9 +1915,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, =
struct nvme_id_ns *id)
>  	ns->lba_shift =3D id->lbaf[lbaf].ds;
>  	nvme_set_queue_limits(ns->ctrl, ns->queue);
> =20
> -	ret =3D nvme_configure_metadata(ns, id);
> -	if (ret)
> -		goto out_unfreeze;
> +	nvme_configure_metadata(ns, id);
>  	nvme_set_chunk_sectors(ns, id);
>  	nvme_update_disk_info(ns->disk, ns, id);
> =20
> @@ -1934,7 +1931,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, =
struct nvme_id_ns *id)
>  	if (blk_queue_is_zoned(ns->queue)) {
>  		ret =3D nvme_revalidate_zones(ns);
>  		if (ret && !nvme_first_scan(ns->disk))
> -			goto out;
> +			return ret;
>  	}
> =20
>  	if (nvme_ns_head_multipath(ns->head)) {
> @@ -1949,16 +1946,16 @@ static int nvme_update_ns_info(struct nvme_ns *ns=
, struct nvme_id_ns *id)
>  	return 0;
> =20
>  out_unfreeze:
> -	blk_mq_unfreeze_queue(ns->disk->queue);
> -out:
>  	/*
>  	 * If probing fails due an unsupported feature, hide the block device,
>  	 * but still allow other access.
>  	 */
>  	if (ret =3D=3D -ENODEV) {
>  		ns->disk->flags |=3D GENHD_FL_HIDDEN;
> +		set_bit(NVME_NS_READY, &ns->flags);
>  		ret =3D 0;
>  	}
> +	blk_mq_unfreeze_queue(ns->disk->queue);
>  	return ret;
>  }

LGTM

Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>

>  =

