Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C35C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 09:54:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F1B72084C
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 09:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FF8HiVGF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="culxwO0p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V1FhPzM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1B72084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=HptGg9WBNHp/91z//mho89uMLMGqN9Je4eCMf7GmTzE=; b=FF8HiVGFNeo0F2b2i40B/P93Z
	3yJva60JlUZxUIYyWqMfQd8rAXb//d1WWAAX4pALrg7xsE2qud8L5J+UNpzTx+wNLGTqxjJYGaOt7
	CJr/N2Oov12Y3hGI3tGHoIR6kv69AkMYD1uEwUkU8woYA1I0jz7zovVwDaZU/0XHrd3BJntR8t8c2
	j4dPAFekIrpF3QflQnIrTPxYuG79kF6r+mYuHAowyyJA69hPr35ouQS4gI7Pv4lBn+7LoUzz2Gbzo
	N9nBuCpTlD8dOsGj0Vlw5X9Mz1bBgAVZ4MrlRmd5PLtJJ/jQwJbp3nWSEAKt4LqEyHGiwA0Kn1+LM
	7pzmOmO8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqvv9-0005Kn-Pu; Thu, 02 Jul 2020 09:54:19 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqvv7-0005KB-Q4
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 09:54:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593683657; x=1625219657;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=X+7H1S1fyH3TDdnS2FtBrDLV0kMG9NYYBm8ZjeJLBFQ=;
 b=culxwO0p4CMWEzjuOVSKws7zFnq28Gs7BIVS1nIjGLki4U9pbQQM1pBl
 3NZGxIzaXxE4MamKw0XVKO9e2DXX/DDhN++gGgSs9SpuFlpviOAo9AP0l
 uENufj0dT9gZ5v3Lcah1gZ10wlcDPGkGXrGlKox9/ghrE53ITJVDLrZgo
 0yAKWRbgsObeXzX8kAriDTdov3HGXWe0BEKjXV2G/c5WJibO5w9PxZLLI
 H4VjX9+MQZLfIttq0dPhe+NFRLQb3WHB7S/1+VD5eGAETMAeJ4aJSdXfp
 awIsSMZ9s/jLW4A+xeddcVaYxmEQNX5sGc6qOd5wqLJE6EckAfCCKJ43x w==;
IronPort-SDR: YkZr1Q7dBVSnxmDUDHsXQZQVVCTGoGDL+dSGL+FqRUQDdu4mSL0OgThNLwM8ymTSRSljlRUjvn
 6looD56etMgV9HC4XZoQFgcqZn7XUGSPQeaUyc9R5RGjtKNVWZBVBPohCbf+67EOULER038QHy
 yqWJrAS4iIKYBlctTLW0959eukKTw4yBGu7MH4UecPvY5SryVcAAbB3r9Sxv6jQSfZYXaTdV6f
 EEdSknVRDUO2b0yZNhFDhkeAGal9pl/rmP0+qxMjueMF1bE8Z1gliOr64QN4OJfxde4zsqulkZ
 Qps=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="250704462"
Received: from mail-bn3nam04lp2052.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.52])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 17:54:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOHvX+0GsYU9WBPex6fuClgDHvSsMHOVlr2YyXc6Hvxrn11f9KTPj7STMJb+h0ww0Zhf4xsXgRgU8jsVIF0meRNUtZMDJyhXQ50JxgtcAsSuObeWRXY6lTmuzmN13X4zIKNMeNmGuZxFJa13FKZHYu/kcvOVuYZ7mi1XoOV7XKhRTFCEg1TBBYGpnsTzUhlB7PsqVuArAKPOgk4hawPlWQ+gCwGoXm+H/2M23PoZP9f/4D1zsZiSXh27iTotptWOaxszyLPwhWaLHAKOhb9Qt1RG9zACVmBGitqDIhutU7kmIUN+tcc07qurzhbi1tL+2rq157HHvgAGVnZiqWCk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWrtpcoeh0luRt+Se4/Nj87QwIcHli/+eHO14SRDIss=;
 b=Hh/ViF6wWq84olEOrV4pa/spBqole/AIg2r7sUqaAk/1LWDz1PTvR87TxHERj/KRTtO8CEJl1v6UF8JKrznMrSawlC4GC1dR6HfXCHnlsN+VogDjq7H8WQNSCEFf2D1E8v+3w63uS8fmJQNLnAnGxpKnQPJT3RjisdvY3Jgyjvx7rQaDkVG3KMsBCqucy8STNNB9mLt9hcgty5naN0IHnB1sKFmmBB+Ok36UoXs885Kwb0194AZbNQYTfDmLGQzeT6O7j7RuCbsk8hu1rHIIX/ugQQWJE69j02vvea1rT/q6RA6RaVBRfwNrSEm4qastYOQi/BhfHn2GvTWsufgOEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWrtpcoeh0luRt+Se4/Nj87QwIcHli/+eHO14SRDIss=;
 b=V1FhPzM8WZ7szQ7fKWzZJCWy7DmKbWM93PgASi8l3fgjVxOpezwppnFKjiFUCWbmX70u4QAAumQf3flEYxelD+eZsb9njhktsrEaNDoDjmf7iub9kFafyvJWTrXn3FZy2/kYLHuZJFMOiBWO0FcZYkX5x2v+lifDl3CWO/nBbIs=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0246.namprd04.prod.outlook.com (2603:10b6:903:38::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 09:54:12 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 09:54:12 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v3 4/4] block: add attributes to zone report
Thread-Topic: [PATCH v3 4/4] block: add attributes to zone report
Thread-Index: AQHWUFK3RxUfGqWvLEyZ9ArAbfPr+Q==
Date: Thu, 2 Jul 2020 09:54:12 +0000
Message-ID: <CY4PR04MB3751CAC724F706063EA0D87EE76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702092438.63717-1-javier@javigon.com>
 <20200702092438.63717-5-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9696c36c-4ec3-4a42-2cf3-08d81e6ddfe1
x-ms-traffictypediagnostic: CY4PR04MB0246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0246E687CE3AE98284D293CBE76D0@CY4PR04MB0246.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v5DplzHkY1WMUpPfhS3K/Hofpj6/ZLZzXJKBL8JzWaYQ8nbgXDdWeM4MY5RBRSUTNMHMpB1y9C6DqIv8Tsww9ohGvHTJ22douYldRBLVHaHnz/2WrC/epSCXVbZrWwJUtFxaJ1l/V+syjZlAnQq/k/Fyf0a7YnZ/56AJko82D2uj3AGVwPSPWXQc7dvPdppoZaROUM6khJgKV2gfjy59/J3SISprLBc7By84Eh0lwAu/RjxpRB5rWphnc6FzUTy6BCBD0liS/bQO1ogYVih7ld98NxPbZJR9/qxl7K//BkZBlivN18RUT+BKh7RnOHmz7LPS0lbpY2xwjRzq+/eJtw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(52536014)(54906003)(33656002)(8936002)(2906002)(83380400001)(53546011)(7696005)(66574015)(8676002)(4326008)(6506007)(110136005)(7416002)(86362001)(71200400001)(316002)(66556008)(5660300002)(186003)(64756008)(478600001)(9686003)(55016002)(66446008)(26005)(76116006)(91956017)(66476007)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: eljEybN7DZjPZteDahXRdUo6U4oUOhM3nrKKPScnftRxUMijEz/2jFAyJd95zzCB2FwNojTR09tofyb8Lmd+m1J5HZx3sBp7qxrYN5+YibN7y+POPXdB0aVvC7nOhMCKKDnpUGviulKNYUUWFprtmYbnqYQ0PWhpq9GjTC+gfo0unCpIOAR471A2AmenshLK24V34N5zQLyeJQl212u1dLJ06C40CO+ThYfV3ZZgRAPtDIeLuIPnIcckAuMbHp3tBessA2HwB7yAVRc8xG+LWL+qL4ivyTjMqFsm+acDlH+GE9VH0kdpm4FMkvkBKIXTHsil7PlgD2QVFozYz7WYopMtzXCu0KYa69gfdhItAeuH/+E55zGHmIkQ4E0mK26cDegg1kIyk0Xn+avFkLeBtdtZFvQtS4zKYw3z7Dsar9WWCsDm0KDflU8HNvJ2mEz6UvQye39jrExlBwn23vSsreOoewXdbPO2cUgM05PmACkEd6k8ii4TVqe1+vkjN3PH
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9696c36c-4ec3-4a42-2cf3-08d81e6ddfe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 09:54:12.8100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfyX/3rlX9AvsLcZVftJAgYszoGW2zVDeHPDHxdF2B0q1P0A9QpO+9XPrA7vpPTEaWme1TzaOBfAhNrnI9xMSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0246
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_055418_045321_741C6EFA 
X-CRM114-Status: GOOD (  18.78  )
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

> Add zone attributes field to the blk_zone structure. Use ZNS attributes
> as base for zoned block devices and add the current atributes in
> ZAC/ZBC.
> =

> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  drivers/nvme/host/zns.c       |  3 ++-
>  drivers/scsi/sd.c             |  2 +-
>  drivers/scsi/sd_zbc.c         |  8 ++++++--
>  include/uapi/linux/blkzoned.h | 26 +++++++++++++++++++++++++-
>  4 files changed, 34 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index daf0d91bcdf6..926904d1827b 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -118,7 +118,7 @@ int nvme_update_zone_info(struct gendisk *disk, struc=
t nvme_ns *ns,
>  	}
>  =

>  	q->limits.zoned =3D BLK_ZONED_HM;
> -	q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_SUP_OFFLINE;
> +	q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_CAPACITY | BLK_Z=
ONE_SUP_OFFLINE;

Wrong flag added, as already signaled.

>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  free_data:
>  	kfree(id);
> @@ -197,6 +197,7 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
>  	zone.capacity =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
>  	zone.start =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
>  	zone.wp =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
> +	zone.attr =3D entry->za;

Mask on defined attributes ?

>  =

>  	return cb(&zone, idx, data);
>  }
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index b9c920bace28..63270598aa76 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -2967,7 +2967,7 @@ static void sd_read_block_characteristics(struct sc=
si_disk *sdkp)
>  	if (sdkp->device->type =3D=3D TYPE_ZBC) {
>  		/* Host-managed */
>  		q->limits.zoned =3D BLK_ZONED_HM;
> -		q->zone_flags =3D BLK_ZONE_REP_CAPACITY;
> +		q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_ATTR;
>  	} else {
>  		sdkp->zoned =3D (buffer[8] >> 4) & 3;
>  		if (sdkp->zoned =3D=3D 1 && !disk_has_partitions(sdkp->disk)) {
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> index 183a20720da9..51c7f82b59c5 100644
> --- a/drivers/scsi/sd_zbc.c
> +++ b/drivers/scsi/sd_zbc.c
> @@ -53,10 +53,14 @@ static int sd_zbc_parse_report(struct scsi_disk *sdkp=
, u8 *buf,
>  =

>  	zone.type =3D buf[0] & 0x0f;
>  	zone.cond =3D (buf[1] >> 4) & 0xf;
> -	if (buf[1] & 0x01)
> +	if (buf[1] & 0x01) {
> +		zone.attr |=3D BLK_ZONE_ATTR_NRW;
>  		zone.reset =3D 1;
> -	if (buf[1] & 0x02)
> +	}
> +	if (buf[1] & 0x02) {
> +		zone.attr |=3D BLK_ZONE_ATTR_NSQ;
>  		zone.non_seq =3D 1;
> +	}
>  =

>  	zone.len =3D logical_to_sectors(sdp, get_unaligned_be64(&buf[8]));
>  	zone.capacity =3D zone.len;
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
> index 8b7c4705cef7..b48b8cb129a2 100644
> --- a/include/uapi/linux/blkzoned.h
> +++ b/include/uapi/linux/blkzoned.h
> @@ -77,16 +77,39 @@ enum blk_zone_cond {
>   * enum blk_zone_report_flags - Feature flags of reported zone descripto=
rs.
>   *
>   * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
> + * @BLK_ZONE_REP_ATTR: Zone attributes reported.
>   * @BLK_ZONE_SUP_OFFLINE : Zone device supports explicit offline transit=
ion.
>   */
>  enum blk_zone_report_flags {
>  	/* Report feature flags */
>  	BLK_ZONE_REP_CAPACITY	=3D (1 << 0),
> +	BLK_ZONE_REP_ATTR	=3D (1 << 2),
>  =

>  	/* Supported capabilities */
>  	BLK_ZONE_SUP_OFFLINE	=3D (1 << 1),
>  };
>  =

> +/**
> + * enum blk_zone_attr - Zone Attributes
> + *
> + * Attributes of the zone. Reported in struct blk_zone -> attr
> + *
> + * @BLK_ZONE_ATTR_ZFC: Zone Finished by Controller due to a zone active =
excursion
> + * @BLK_ZONE_ATTR_FZR: Finish Zone Recommended required by controller
> + * @BLK_ZONE_ATTR_RZR: Reset Zone Recommended required by controller
> + * @BLK_ZONE_ATTR_NSQ: Non Sequential zone
> + * @BLK_ZONE_ATTR_NRW: Need Reset Write Pointer required by controller
> + * @BLK_ZONE_ATTR_ZDEV: Zone Descriptor Extension Valid in zone report
> + */
> +enum blk_zone_attr {
> +	BLK_ZONE_ATTR_ZFC	=3D 1 << 0,
> +	BLK_ZONE_ATTR_FZR	=3D 1 << 1,
> +	BLK_ZONE_ATTR_RZR	=3D 1 << 2,
> +	BLK_ZONE_ATTR_NSQ	=3D 1 << 3,
> +	BLK_ZONE_ATTR_NRW	=3D 1 << 4,
> +	BLK_ZONE_ATTR_ZDEV	=3D 1 << 7,
> +};
> +
>  /**
>   * struct blk_zone - Zone descriptor for BLKREPORTZONE ioctl.
>   *
> @@ -113,7 +136,8 @@ struct blk_zone {
>  	__u8	cond;		/* Zone condition */
>  	__u8	non_seq;	/* Non-sequential write resources active */
>  	__u8	reset;		/* Reset write pointer recommended */
> -	__u8	resv[4];
> +	__u8	attr;		/* Zone attributes */
> +	__u8	resv[3];
>  	__u64	capacity;	/* Zone capacity in number of sectors */
>  	__u8	reserved[24];
>  };
> =


Similarly to BLK_ZONE_REP_CAPACITY, I do not see the point of having
BLK_ZONE_REP_ATTR added to q->zone_flags. Rename that one q->zone_features =
and
have report zones do:

	re.flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_ATTR | q->zone_features;

Devices such as nullblk can simply have zone->attr at 0, always. That is st=
ill
correct. BLK_ZONE_REP_ATTR means "have attr field", not "attributes are set=
".
seems a lot cleaner and simpler to me. For zone_features, it would be zone
offline only, but as already discussed, I do not think that a feature flag =
is
the best approach as that complicates support for device mapper.


-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
