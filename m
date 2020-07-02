Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6525C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:11:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81EE72067D
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sHQDbWIx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VtaAeR+l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="z29Zx9lI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EE72067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=mdMcCQkhNqcVv5TCNlnyDO/PB6Chiz7dWLwgSFtV10w=; b=sHQDbWIx3ynjExm/nsCKpre3T
	7+OjlaTF07NI5m1gGiHkE05wUlnTgFSlwLxuJJ6RFkfxNjJctJ3BJzGVoYbvTikzPeylMHeneZ+6K
	owa0rV2K3jhac4rjNkpz0ET5bWLnF3RA0oYBF/53wR58pu7DV8+srQiQ8m/NMj5Ncbn6MZBATJN9V
	7EPlZKbHfCnfXc8L1M9FI4XJKKnrTxLgfAJhdKfJ+/h/b/NTAcbCksgTW2GFsmTrL/vJ5xVHiL/Ip
	c5+KL7AjTUPc27JAWP4JOdJH8rzZkF+Vae6XAKBiHI0Ahwr9cKjnhmNh+xnUGGg2Sk9mUvDb2Qwsk
	sYE9I56qw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jquJA-0004d6-V6; Thu, 02 Jul 2020 08:11:01 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jquJ8-0004cW-Fv
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 08:10:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593677496; x=1625213496;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=XMYfNeicJWMtlNUA5SOPlyTsUxLqtdlA/UMCJpN6WNA=;
 b=VtaAeR+lMywC32UlbkAfSWApTJNGCXFueRLmDYuILkSyPlvIISFSpYXA
 SHLUW5+PeQPepEAa2mF7t2WXVfcl9ewQjJKLB3dPkEX0YcQmarsP5Mx0H
 lLAbfy10XD5Pz2BN4uNukOLjjKtnUAXu73yLvMT4MvxL6Yn+VejNKi5OR
 1Jtn/LCJexWDA0PJBehL6o+z0tspkeqA1Ciw99H4yqquoENlqQ+yjL2k7
 AttYVYQ4SqPu1U1umVBdkaNCrxGwPXthzfo+JTdOBBN52lIorEAUyP9OU
 mzqO1kV2LshKe24dXa+UqOEU1EjHeXNmtn7WebKTmQSc3qxnpS/k4L5Sz g==;
IronPort-SDR: GTPBCw7ddcRPhc67bh7oSe9xSbwZJDeg6856bBupzibl6TpO3VM2nlFArDhu5gSp/D6A1DsbF0
 zl4tB+DT4JT0OXJ+uAdmnI6MrEzO7eXiPjgmHqL+Rg8BzzN9ueXBwI1NNr3ofwKXk71ZCdKu6m
 kR76v5Xmb5eSvM2aDe7BZrmoVZnpcckKwkw+m/csgqooc5QH8yv+JtBhvU52kve7ciB9Roth44
 KqELcbvCsd2vqTDtaLJ5jGg91QklKXe5KnIGL6ayNiXxitJDfo1lb5Djnek10GB1EH5Xnh1yeg
 um0=
X-IronPort-AV: E=Sophos;i="5.75,303,1589212800"; d="scan'208";a="244482264"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 16:11:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giWqwp1rVKTMUDaPagL/77d3ev0kOM1BWTI9j/Er6JvszxmcHJCN1bhwHDuSkYs1hTIoK8HukpFe3cAQBB3MYFFwhpUWmXuE8DDvZG+EtFaKIg2lalvOOMvQBSr7qJLavJQYXeqm73fAq9xQ6jLqliBBkL4OxWAT4S9lWZXNwXuEdCkzCXJlrFXmVpIqXws6UPHl9j8TVX0O/R4QaotskqtZoz//ptxT8SXl0F1KD4Qi9DVvpqrClDS8ZCU2bix30yXLW7vW7nUyOoSM0bGpOo07qulKHBDi1cyzTJWJVkVzljqddLXJWFgpmdWk8hKov5BYgu8CkVXVvYK8viSBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=embGmwR3j6tc2qPypZniddQ9JmRQ577nIussOnG53BQ=;
 b=bVQLCN2QmJMrocpY3N0x0RilF1ym3NZziIycmfMCJ54Y3DNFUQ0rfINgJd594aD1OSsVt898NUxkLhCmm0q/uzvgTZRjOdtCz8+Y7upyjCIMMMLsDeCAPj86IPWZm9hVRuCYJ4Vj9Ey+7kyGwXc3+anNgwj/KBgw8DWpHwHqeZ7Wz3Iu0tXjCiQfgXLGozcfaul1l83Tbu9N3FueVXtYrH0ooDLmmEwJcFKOdkN3etdLRA25xj2A2AsA218//HEUqs4ZHVLgfk27tcuIhHQbz++S10ph41TDioNVzAJxaC9Q3C8gHXevnh29jVsBaWIsW3wPPphTgUbOpYU3L4gBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=embGmwR3j6tc2qPypZniddQ9JmRQ577nIussOnG53BQ=;
 b=z29Zx9lIM21nI40GtBMbbO/2HJXKAUvzETOCIavHTs0Ej3SrN2109t+QifLbPHeON8JxJlRJs0fzg52+bedrgIJVSsVtRINgXpr6IDpmZHN3GbDj9X48NnJWZS7dwSrQQ59dMv1Xp/klhrHQX1TvAsr/ZgqQnvLb6OZ6BTnBAls=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0759.namprd04.prod.outlook.com (2603:10b6:903:e3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 08:10:54 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 08:10:54 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/4] block: add support for zone offline transition
Thread-Topic: [PATCH 2/4] block: add support for zone offline transition
Thread-Index: AQHWUD25AuPO9FUJKEmO2iwqT0FCbg==
Date: Thu, 2 Jul 2020 08:10:53 +0000
Message-ID: <CY4PR04MB3751F9F6BBBAD8CAC7E15431E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-3-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c6addb5-e58e-4693-2826-08d81e5f710e
x-ms-traffictypediagnostic: CY4PR04MB0759:
x-microsoft-antispam-prvs: <CY4PR04MB075954E198FF5349D4AF9F6FE76D0@CY4PR04MB0759.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tfBpG2YujfEXSWOLxU+rfV6dcEUPIdqktndowMifq/hl5lJPdw1BPqzxvN8XJe5UlNhn8XlrZ+FU3IUW5lJkeC2zgi6dpbJDfAMoX+lnDlUZjWdFPITbYjF2gtMK0KXVBREDxVj7D6rEydxxSOBgVbOslqJbbbNooYVT75GNlO5dJw8T8ZLX++kfjgexWz8RmGZibYAKsg0yoKlw5gCwfN5HtrXwrhjiIsv+11R3ShoKZTbAfCI+yh1U9a5N9Niq6pwKRaTA7WZ1h5F8wlAadeHXklS/bhuozZid9Bb92IyfjmGV0M3wZoqH6sd7UR4UYMAZIqGoSuCUFRnwmO2LjA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(66446008)(5660300002)(55016002)(52536014)(186003)(7696005)(26005)(6506007)(9686003)(4326008)(53546011)(86362001)(2906002)(33656002)(8676002)(66476007)(66556008)(64756008)(66946007)(316002)(110136005)(76116006)(54906003)(91956017)(8936002)(66574015)(71200400001)(7416002)(83380400001)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: HcbJbwII1ZtosbSisFAc5H5doA0oHFDyk0psdExNm/dOpMLyzHmOqhaFDvQnQUsTtUNSzJt6ZCWUSAbvYNnwT7iHYSNrJdn9NdZtoZ4sqYgMurKXFqY+FmtbZaGSXr5t9LW2YM6hgVV9MUQI0tzJfWH3Dz4+Fh00HKgLUa5mv6VpB2ztsJMb+OTubSfiayBXqj3r9pFup/DktlmNVpxn59/7qtMWU5OU+uH3r9LBTuZVzPt25vnNQkUH93K14qCgIZFXE5Wntpr+/UqtROTFbQX/7b0LpOTMthbQ27HZDrmZnS9bFv7d968mFcwqpXnu6WZLBdVLc41NfzGySFak1tOQhpuIimjSzXpujej3LVa1RKwwKK6j+6rVevOk5fOIDfvH94Isc10s0nsWhlYiny3AFduWXVaLMlsnBGK2I6CmFhhQ9ipSxnEcJsSmzbn+MvTbgV8eeyiFKaEOSi4Kdes6fD9NkovjhLgM8LnJJ/T/o1Eivcc5tRKu+Ol8xstL
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6addb5-e58e-4693-2826-08d81e5f710e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 08:10:53.9315 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtfSebe1BSoCdLFDw3WIBNXmkKIoI1EzFcEg2QeCFnXm+FXOAjDqW11TlCEej2/kckA9AaM0y0YR0uNGe4ZzDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0759
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_041058_716486_D3A26D02 
X-CRM114-Status: GOOD (  23.97  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
 "mb@lightnvm.io" <mb@lightnvm.io>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/07/02 15:55, Javier Gonz=E1lez wrote:
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
> =

> Add support for offline transition on the zoned block device. Use the
> existing feature flags for the underlying driver to report support for
> the feature, as currently this transition is only supported in ZNS and
> not in ZAC/ZBC
> =

> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  block/blk-core.c              | 2 ++
>  block/blk-zoned.c             | 8 +++++++-
>  drivers/nvme/host/core.c      | 3 +++
>  drivers/nvme/host/zns.c       | 2 +-
>  include/linux/blk_types.h     | 3 +++
>  include/linux/blkdev.h        | 1 -
>  include/uapi/linux/blkzoned.h | 3 +++
>  7 files changed, 19 insertions(+), 3 deletions(-)
> =

> diff --git a/block/blk-core.c b/block/blk-core.c
> index 03252af8c82c..589cbdacc5ec 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -140,6 +140,7 @@ static const char *const blk_op_name[] =3D {
>  	REQ_OP_NAME(ZONE_CLOSE),
>  	REQ_OP_NAME(ZONE_FINISH),
>  	REQ_OP_NAME(ZONE_APPEND),
> +	REQ_OP_NAME(ZONE_OFFLINE),
>  	REQ_OP_NAME(WRITE_SAME),
>  	REQ_OP_NAME(WRITE_ZEROES),
>  	REQ_OP_NAME(SCSI_IN),
> @@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)
>  	case REQ_OP_ZONE_OPEN:
>  	case REQ_OP_ZONE_CLOSE:
>  	case REQ_OP_ZONE_FINISH:
> +	case REQ_OP_ZONE_OFFLINE:
>  		if (!blk_queue_is_zoned(q))
>  			goto not_supported;
>  		break;
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 0f156e96e48f..b97f67f462b4 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -320,7 +320,8 @@ int blkdev_report_zones_ioctl(struct block_device *bd=
ev, fmode_t mode,
>  }
>  =

>  /*
> - * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl proce=
ssing.
> + * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE, BLKFINISHZONE and BLKOFFLINE=
ZONE
> + * ioctl processing.
>   * Called from blkdev_ioctl.
>   */
>  int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
> @@ -363,6 +364,11 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev=
, fmode_t mode,
>  	case BLKFINISHZONE:
>  		op =3D REQ_OP_ZONE_FINISH;
>  		break;
> +	case BLKOFFLINEZONE:
> +		if (!(q->zone_flags & BLK_ZONE_REP_OFFLINE))
> +			return -EINVAL;

return -ENOTTY here.

That is the error returned for regular block devices when a zone ioctl is
received, indicating the lack of support for these ioctls. Since this is al=
so a
lack  of support by the device here too, we may as well keep the same error
code. Returning -EINVAL should be reserved for cases where the device can a=
ccept
the ioctl but start sector or number of sectors is invalid.


> +		op =3D REQ_OP_ZONE_OFFLINE;
> +		break;
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e5f754889234..1f5c7fc3d2c9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struc=
t request *req,
>  	case REQ_OP_ZONE_FINISH:
>  		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
>  		break;
> +	case REQ_OP_ZONE_OFFLINE:
> +		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);
> +		break;
>  	case REQ_OP_WRITE_ZEROES:
>  		ret =3D nvme_setup_write_zeroes(ns, req, cmd);
>  		break;
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 888264261ba3..b34d2ed13825 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -81,7 +81,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct =
nvme_ns *ns,
>  	}
>  =

>  	q->limits.zoned =3D BLK_ZONED_HM;
> -	q->zone_flags =3D BLK_ZONE_REP_CAPACITY;
> +	q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_OFFLINE;

The name BLK_ZONE_REP_OFFLINE is not ideal.  This flag is not about if offl=
ine
condition will be reported or not. It is about the drive supporting an expl=
icit
offlining zone operation.

>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  free_data:
>  	kfree(id);
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index ccb895f911b1..c0123c643e2f 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -316,6 +316,8 @@ enum req_opf {
>  	REQ_OP_ZONE_FINISH	=3D 12,
>  	/* write data at the current zone write pointer */
>  	REQ_OP_ZONE_APPEND	=3D 13,
> +	/* Transition a zone to offline */
> +	REQ_OP_ZONE_OFFLINE	=3D 14,
>  =

>  	/* SCSI passthrough using struct scsi_request */
>  	REQ_OP_SCSI_IN		=3D 32,
> @@ -455,6 +457,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)
>  	case REQ_OP_ZONE_OPEN:
>  	case REQ_OP_ZONE_CLOSE:
>  	case REQ_OP_ZONE_FINISH:
> +	case REQ_OP_ZONE_OFFLINE:
>  		return true;
>  	default:
>  		return false;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 3f2e3425fa53..e489b646486d 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -370,7 +370,6 @@ extern int blkdev_report_zones_ioctl(struct block_dev=
ice *bdev, fmode_t mode,
>  				     unsigned int cmd, unsigned long arg);
>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mod=
e,
>  				  unsigned int cmd, unsigned long arg);
> -
>  #else /* CONFIG_BLK_DEV_ZONED */
>  =

>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
> index 42c3366cc25f..e5adf4a9f4b0 100644
> --- a/include/uapi/linux/blkzoned.h
> +++ b/include/uapi/linux/blkzoned.h
> @@ -77,9 +77,11 @@ enum blk_zone_cond {
>   * enum blk_zone_report_flags - Feature flags of reported zone descripto=
rs.
>   *
>   * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
> + * @BLK_ZONE_REP_OFFLINE : Zone device supports offline transition.

The device supports explicit zone offline transition

Since the implicit transition by the device may happen, even on SMR disks.

But I am not sure this flags is very useful. Or rather, isn't it out of pla=
ce
here ? Device features are normally reported through sysfs (e.g. discard, e=
tc).
It is certainly confusing and not matching the user doc for rep.flag which
states that the flags are about the zone descriptors, not what the device c=
an
do. So at the very least, the comments need to change.

The other thing is that the implementation does not consider device mapper =
case
again: if a DM target is built on one or more ZNS drives all supporting zone
offline, then the target should be allowed to report zone offline support t=
oo,
no ? dm-linear and dm-flakey certainly should be allowed to do that. Export=
ing a
"zone_offline" (or something like named that) sysfs limit would allow that =
to be
supported easily through limit stacking and avoid the need for the report f=
lag.

Happy to here others opinion about this one though.

>   */
>  enum blk_zone_report_flags {
>  	BLK_ZONE_REP_CAPACITY	=3D (1 << 0),
> +	BLK_ZONE_REP_OFFLINE	=3D (1 << 1),
>  };
>  =

>  /**
> @@ -166,5 +168,6 @@ struct blk_zone_range {
>  #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
> +#define BLKOFFLINEZONE	_IOW(0x12, 137, struct blk_zone_range)
>  =

>  #endif /* _UAPI_BLKZONED_H */
> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
