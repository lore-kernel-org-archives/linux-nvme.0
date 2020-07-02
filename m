Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE41EC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 09:47:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647A420760
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 09:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I0pGyxro";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PL/NKDwE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="isIdDfJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647A420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=CxI98wOitbcDS51TNwVp3Xtat4onJGISPzT9FviRW2w=; b=I0pGyxrowsC9mMFtZO8Kxd0ft
	uXE91GB35FPowP+pdrmWRBC318Hwjw1O0wyE1FUz43noX1h8LL47UMKX+Xcpl3Jzig4MuVl/4ir3I
	ZvAdLClHKPJe5iShbJucehZKyiVsFq16wjes6MYmBCZx3q8BGNbBpWAyONcDkOYOzHutVCVUSnNFw
	z1cGsg8k0180iA7yT2zF32q3YCGfZc2Wb4p/l13uY3PluMsH/dos96psmHZufzHOob5rXZoSp7VmL
	f1WkJwe5KLdh3VFTL1QUhlLfyQLP+AKevlFQ4XCNJpYVQhCFqjni2SXpT2qQbRpAg+sWXSWUk9fYa
	Jh8sjdR0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqvoE-00049P-LG; Thu, 02 Jul 2020 09:47:10 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqvoB-00048s-WE
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 09:47:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593683228; x=1625219228;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=08aY6dUSUTm/Nz6E38xGucnuF/VYZD8Y1NNp4C+Du14=;
 b=PL/NKDwERwWLnUm3pPxDEofA10Y2rs6WDDQir4JsYi6mmrqydCzbDiC0
 bTJblY4/Bz5oVZH2/ftELTvhQB/ik9ztpQegRSeUPw0HZxP7ZMvUQZsW1
 SMOiyjDi71TKegCFgi0fgVoSnQrsZkrYOaFP0obWLmHxGcp1PNeHg6NEB
 f6CYdphmp4hl31TC1wN+yvRP7HQEg5AGDhTD/RkvzxS0vDcxWu1Rm/E/Z
 EDd+lPVYd/AEjDmOq400CQpkAVq+ztTjTU5wy2xruCiDUIyPWHayegZch
 QgBgKos7eC6yYU5f5qwRDIUndA2iNlwbEGIaOc6XjFs7z5jyPNf1/xkcF Q==;
IronPort-SDR: QciJvMNdFhfCeI0Csz7blUhS2vFKZV19fWWwS0ngNJSClIBTwrbc2KqaVdZyjUaCCPSdh5IcZ0
 Cds41e6cSo5jgxhiCfjEwWRWfOl8ZfFQr4fB55xeYXOlAi3/Ch9oAMambSAcMoFe6zu8sc4Mk+
 uR3MEcH2BHMrmgWDzsDodyNekWVYnv2P4Nv+OKfFX86BQ5EJKs+0Kx0NPkLypU1lImByLP893j
 OWHnsqPgp7FcM8/sjp98ykE/22IvI5fsMxEwHPDslFOAYhu7AFD01xEP773j/D6vRVQAo0sjmw
 SDk=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="145797103"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 17:47:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRJEA74Lc99f3Lz7hX9Zirthu2irfBGpf1t+oFrgJwP0H4U9IIj+Q3Baw9lRaozd57SD+KcCITZlGRXE9lwwyNx+c1nIc+Gj8ZXcc+KGCBu8TGJ4WLXLflezkTdl/b8KcWdqAUicG+RjouuK1jiAbq4p/2GIrTf0UNZKQFI8lkKrnlcZupDPxsljVOl6yzS6WaG4U8Qxa+4+VwM+9wVgvEV86OYpwU8kszGH3pVbMPK1a8ufVoQYhazQ1G0DLipUZ7aWVv1QBRm4QwzkbelTZxlQENQ2T2e+huK8uFaKAHKbLBhPlxqidVVNo73NtJwF5h3dDuRLv/Bc817AvnbKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYTdEcD/fd+dLpkzeVFFX6KKfTU1HwMGrB+Hh43zJ4A=;
 b=C16kkHK44aheCtZevUeclW4+Fa8s1ZRY1Loxbvjzik6HoQLj6d31/uohirPrh+09jLJnN+ezFuMXIsowBUfaAQPbpbpvDrBdDe+4/3LODrc8uuiTymJPBaITsNGjMv2GGxb9RW6Ogco/RUTfvZbn/nTVcKVp5tk8VwpqQ3TR8/xQlJGZFwVqrWHEVcT0MvQTkPUSOMzHI4DceysdvKGV64NvEyw5pMXpjPxG8ygzoj2iUAAx0dXoeG8E4tTiBBbZAUnQxXM2gQU63iGavSRh1drGo5emIoDKM3Jllf8a37LCQ0xbFStdrqizLhrJqYP6hQzkD9mQCLdVCKcS4+ghHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYTdEcD/fd+dLpkzeVFFX6KKfTU1HwMGrB+Hh43zJ4A=;
 b=isIdDfJfHpMtjbjOTd4w9sHLodAiBUN4zw4IlvPKLg+n8dX5Y5JQjIY7Pbws8AcYbPztBA8T6R1o+/sfe71Ys7z60VUvwS+q9nqpzQb7GCj5JBdUGqszgUnoWqKEKvNwskEBXMr9YlouWBFWJwg9kVhBJD9B8q0qx1ZdjqJg8uY=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0246.namprd04.prod.outlook.com (2603:10b6:903:38::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 09:47:03 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 09:47:03 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v3 2/4] block: add support for zone offline transition
Thread-Topic: [PATCH v3 2/4] block: add support for zone offline transition
Thread-Index: AQHWUFK2qjJ6xwlwRUGOria0OYOyow==
Date: Thu, 2 Jul 2020 09:47:03 +0000
Message-ID: <CY4PR04MB375148CB23D342EE8DCFED65E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702092438.63717-1-javier@javigon.com>
 <20200702092438.63717-3-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58e765e7-67e7-4e6b-7c95-08d81e6cdfe7
x-ms-traffictypediagnostic: CY4PR04MB0246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB02460254A3DB6BC474026C7DE76D0@CY4PR04MB0246.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z8lW3SHmMsEOSwCkEF58Bo9Lx6WK4R2Z6H5TWiLh2C+fg7VC0zhKuVIuNGWyhNlUM7iI85pbnCgDh2MykUwg9kO/b9g5qB/3I6v3/9b2sPnxF8HVBzbfYjiWyMGIi2JWPvpsl9G+RKfY47sX8IbgWu1G4NYbzNBom+kLdpLpkorkvuZUCEcgoF2qvSgDQRBGQNtIcEVD8prPXx5YDdlB6z6e8LPG4DQDyahCPPLxGzs7421Ipq5kRtv5n03ZIx6ugjCmwMHHbEKwW9Jc4ipdyu2w9LN2/y4wum+ii3IA+Dhlq8sYwAkCz/hLomBq2ke0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(52536014)(54906003)(33656002)(8936002)(2906002)(83380400001)(53546011)(7696005)(66574015)(8676002)(4326008)(6506007)(110136005)(7416002)(86362001)(71200400001)(316002)(66556008)(5660300002)(186003)(64756008)(478600001)(9686003)(55016002)(66446008)(26005)(76116006)(91956017)(66476007)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: M84QA1fygTLL1GULf/RN8UoqRjm9fHTd0LaxQh8E8wMBeAFnR+3EwMt+Ze1dYQHUuwz2k6weekMzCoqVHW0JkcZMvSzhqthSAX90f4ipPRLgsYF+VXkdh2P4v147+mVjffG5yJmMTnzRUf0hwzuwkIepuFS8Rwr55HJDGPVbIjcEm5tVZo3i57y97hPZ+Eth4Ru/1G2PpgOwpSXzaKUq/JvIu2ceCUflzThwT6hFfdoEt56NGE82AyOTnV0dJ4WKMMR0Vq9XRMkQxoVwv0fU/Db/RK7jbGYvGea5lnjGbBo9cVWbv1YmJ109XTPbnOysAADEPAnIUma3k5Q5OX0QDVrlEnsok0xcV/h31TYS2Hlnk9nNp/I82GxAvJauQKMWcnV8AK5zwzwtkRS0LGUS7KuXtHadKwFgzb/ar1r3uF3SopFayv57x2Lo0Dw+zjooJ1RnpABhC0tig5QRMx3r4XAas+PlwIjGItHcwaf2m3lStB3Ixo/FC2OOH4CvOAAa
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e765e7-67e7-4e6b-7c95-08d81e6cdfe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 09:47:03.3097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vroub2HJukGYMLYcm1wA6fanBfGRKhr5gPdwDo7E3/v+0qd4CWWlXNEhQ+p6k+5g8kkUVc62ATpVl0MP9cZlCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0246
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_054708_729511_14D36CD3 
X-CRM114-Status: GOOD (  18.58  )
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
 Kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
 "mb@lightnvm.io" <mb@lightnvm.io>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/07/02 18:25, Javier Gonz=E1lez wrote:
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
>  include/uapi/linux/blkzoned.h | 6 ++++++
>  7 files changed, 22 insertions(+), 3 deletions(-)
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
> index 0f156e96e48f..def43ef2b021 100644
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
> +		if (!(q->zone_flags & BLK_ZONE_SUP_OFFLINE))
> +			return -ENOTTY;
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
> index afe62dc27ff7..bb6a33f52d53 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -81,7 +81,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct =
nvme_ns *ns,
>  	}
>  =

>  	q->limits.zoned =3D BLK_ZONED_HM;
> -	q->zone_flags =3D BLK_ZONE_REP_CAPACITY;
> +	q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_SUP_OFFLINE;
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
> index 42c3366cc25f..8b7c4705cef7 100644
> --- a/include/uapi/linux/blkzoned.h
> +++ b/include/uapi/linux/blkzoned.h
> @@ -77,9 +77,14 @@ enum blk_zone_cond {
>   * enum blk_zone_report_flags - Feature flags of reported zone descripto=
rs.
>   *
>   * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
> + * @BLK_ZONE_SUP_OFFLINE : Zone device supports explicit offline transit=
ion.
>   */
>  enum blk_zone_report_flags {
> +	/* Report feature flags */
>  	BLK_ZONE_REP_CAPACITY	=3D (1 << 0),
> +
> +	/* Supported capabilities */
> +	BLK_ZONE_SUP_OFFLINE	=3D (1 << 1),
>  };
>  =

>  /**
> @@ -166,5 +171,6 @@ struct blk_zone_range {
>  #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
> +#define BLKOFFLINEZONE	_IOW(0x12, 137, struct blk_zone_range)
>  =

>  #endif /* _UAPI_BLKZONED_H */
> =


Device mapper support ?

-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
