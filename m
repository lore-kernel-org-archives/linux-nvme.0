Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437B4C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 09:46:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0372720760
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 09:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lku5/K0c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oIHXoj45";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tRucrq2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0372720760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=O8qXBYTqlRGwtyeQ7M6MJWzvx/kVGUbFEjBWl23L9Jw=; b=lku5/K0cywuwx2i2FK3JarxNW
	LlfV8uimnrAOcjOnAYfT4/zxBhg/Svq0cxQA3cNmFnBpqY6lUw327kzZyFYDF0T2cMWNvaY1Du7Z2
	IyEcRZhP7z6b94GE+74/rSEqrcTR9hpNuplPONrl6D2YBCSJU0aaWMBTHthWXQ624EnQ1rmFFUYP2
	JU+z87jEP0jgPbNMCL+lVsLUujY6onw6ALi4FFXrBT5zG3qysIVXhim4n7UOREfOxYT7SyrgQ5arJ
	axTMLxRgrR/FRCKkRlF0/26i6Tt7XtvMxnA0nOM70AExPYjkt0IGDaLDI2wn3PKI2MRFZc6SVcq4c
	mj+yrp5NQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqvnP-00043E-Qe; Thu, 02 Jul 2020 09:46:19 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqvnM-00042l-N0
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 09:46:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593683189; x=1625219189;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=rj1QU67BtrE2Hi7TTgLbeXtScxL1gYwIAB9qnY2HA6M=;
 b=oIHXoj45mDFO5kmND/w1SbhpQb4wxh7cqVp3L/Hxgjkv5UuNZn7rjvj8
 on1jYPv9BbzoBDp4eHkSWb6VD6M7YuhHG+QgMKh27O6A00VjYF23dDger
 os/GT/ScCuS3PkW4PpNYPTXnrgmCtYyubLilcAE+puVozB1+eLAwWVAbw
 R7TG6bItkuC0nydpuFfuCj3MQ4vfPMb2i+p7slHCmG8N3Icl7I4gY5QxK
 w1Wd2O35yVtJ0lE04pUsOfSw/cllSBIAA4a9OO7ofSYFiWzdCI5UB6yfM
 11PA4n79y8RebFuWWRbmFzxqIv0eArVchxWgQCzba/gBJU+Ikl7wP585r w==;
IronPort-SDR: 6xqbtMD5pOYnNvse4T6qXwsxOE6RpX9F/UwU6XK6T+8Y+l9cpBbXvbZG+yfvqogQX1aDyX6F9d
 0wJRI+UBjWcb6KYn5V4tYJVPtGctltpL0DfzM6wz1+1iT4X4zzOO20UEB/soHdfoy0cXGRcNGf
 Fn1skYdkeZ0mcWgBqZcdonssad43LMqwuaCMQbTLWoxOSUMASo7PBTiynN92FmEhHNBgEaYRNG
 yh3i+F4xV29NxxGSpC7AlB8rVzeXgIqmWiPzvCccbZd9EWnfvmYfaSqDxTgHS/bygQc6bH62vX
 Jns=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="244488336"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 17:46:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBhmdOqlvlxA6DaiX9yFj30EoN/T0ELAXScQSXqwVeRMP3WxmM6hAg4xhKiVdXTlWOz8rC2kSLIWGcvK3M9lcyniFV28DTzuK4sqQesF+/0uuBgAttfG8XBJ2HbE6y/Dij29aHzzKoa+IQi0yIt5oKsHdfa3Teiw/NAPhSgSmn0kKa2kwcE4i36FzZMpSrYiQAKGWcw/FV8ObX6DFXrTnkQP9wLVHlPqeoRqS0MmWCvbocei6reOhS05Spibo5bliqB08iQYDRdbx/b3gq7ZG42/9Cnq6/hbuE7lRJyEeE89eQ6CpqTAOncU9vqZfrpVKfJrA7Atk+bFHTXVkbRqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5QQJSRITWo5I9LEP4IVjqdXpos30a73owGQElcxIdE=;
 b=NYvmnZ+cQBb6Nl3xDASp37XebcHY4UAZkrWQ0ZVHKOA5zEyosgjUe8CDylSlJW5VWNiQUgabYUAjgC9tnD6KoesV4NjvFvmYaC13bZudrb1FgzEyM5H8VEprIDiV3wsWO99vneIrNrR+Ws5CNKKIqxXRJ7QX5wgPtiS9HOAy0Z9xo6KFgqCrWOriCxiYrkSU8uHyTUoGkto2Frw8B6PMaN+QtyUIuNXxNWL/mQIxyNXu6DLzV4O7xiQyTeH7NWC+87T2eaaUYG5jvwxbZAYtIA3tX7AzIUL1VfkZwnOrw7fa7OzKMtb/kPJZC65eQFHBY0CFa3WfxIibpX9qxJC7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5QQJSRITWo5I9LEP4IVjqdXpos30a73owGQElcxIdE=;
 b=tRucrq2MHqV8sq4PnTqoZuhGumpLQjZYZPFRTxg0kjvcq/LH1uxucy7k7b/lxO8FCcPVYqorbkNYB/Zo1k/wYaG03GzUmh4tVoA1ujx8MybaXjXIdqTc88dX3z/XBurddS8O/etpWdex6czWspoiZVg6ZLB/QcN/X8PTjkathlU=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0246.namprd04.prod.outlook.com (2603:10b6:903:38::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 09:46:12 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 09:46:12 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v3 1/4] block: Add zone flags to queue zone prop.
Thread-Topic: [PATCH v3 1/4] block: Add zone flags to queue zone prop.
Thread-Index: AQHWUFK1aUt5RXCV0Eaj2nicmpl1Cw==
Date: Thu, 2 Jul 2020 09:46:12 +0000
Message-ID: <CY4PR04MB37519E324412FC96FDE6BFC1E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702092438.63717-1-javier@javigon.com>
 <20200702092438.63717-2-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1d6c221-0a4d-4718-929c-08d81e6cc15f
x-ms-traffictypediagnostic: CY4PR04MB0246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0246A3A0DA544B9CBA79D535E76D0@CY4PR04MB0246.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2vFXqXQjKARB7t6MwrfQ1Vx4yI6uBfq+5JjXEVsdmZ+d3x/0hdAwxFrztkMdMLGpAPbGT13bUEHrJlhDV+josJQRm+c9r1blqYBXlet/+w2+zWrpek+NcFyxn95iYViFQ2pmT2DfYuyNTjJ+wf0tVEdOQmPTmLOObWJMGoXT8UQpxHck6JeKrUp2pWvlZJGHfi3fHOCjbP8d4BT0tZPaZJRqqfiKXlyPhUaf3QG3vK6Zzk/boGGift+eFi668hds5OKVgbyikTCPbHSV0o5zt24VhdQlh5dHXm0vdrsBQIIgN+hKfg7mmni7unt1lrUafXu58b6aF8IoNSp2hKFCBg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(186003)(316002)(5660300002)(66556008)(91956017)(66946007)(66476007)(55016002)(66446008)(64756008)(478600001)(9686003)(26005)(76116006)(2906002)(83380400001)(53546011)(8676002)(7696005)(66574015)(52536014)(54906003)(33656002)(8936002)(7416002)(86362001)(71200400001)(4326008)(110136005)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: lZTv3gfbsEK8MSSE9BWHGwkFuIcTbHdZaM5zb7KeVbK9s9YNLqFrodZrBZXBiqS4u06Wv4iCONDbkhoiIpx7j6TVJkqFC5zbxY6A+YTawL4ciT1J1NWIlNf4HtM9pChGnMO1J3NgSxGFjYFQ4RsIp/ganRPBl8BZhvRxFTcUPtIqvXD5KxRFeMrkVRezRFoSF+RIpEKEaNOgtV/x9UpAV85npc2dPlU+wED78oi6/tAmi4NGVewrNwp15Ms3z4xtidjS2Ticrk3uSz2ooZLYSPHQemNbdZrxPWdSXvdJya1gAXPI1VnK78PSLLIcTgef+i5eNlhfJny6+zlT91bOLaEpJPmjJ6lonF/lDSrBB8bYw9e7YIlhVnp8RFNZzPvYCcIswJVlReAKGXDhNhwLXe189vMc59JdkpTioUn+X7Yz8Mx4l8f/pJSjlT+JA3jtMLjkTH72TlKwtyIzHmhUPun67akC939cYcE8LfPr2o06unoRInrpolO9Orh8/wQ0
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d6c221-0a4d-4718-929c-08d81e6cc15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 09:46:12.1323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8oyTfFsiT5LECy/BKRcwKR+onunrq60bY4eDp4TfJE/iCncYOVENG66sAAv4qrhMZVc8xtQgXtBAr0qQGRKmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0246
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_054617_136713_7F9029D9 
X-CRM114-Status: GOOD (  19.26  )
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

> As the zoned block device will have to deal with features that are
> optional for the backend device, add a flag field to inform the block
> layer about supported features. This builds on top of
> blk_zone_report_flags and extendes to the zone report code.
> =

> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  block/blk-zoned.c              | 3 ++-
>  drivers/block/null_blk_zoned.c | 2 ++
>  drivers/nvme/host/zns.c        | 1 +
>  drivers/scsi/sd.c              | 2 ++
>  include/linux/blkdev.h         | 3 +++
>  5 files changed, 10 insertions(+), 1 deletion(-)
> =

> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 81152a260354..0f156e96e48f 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -312,7 +312,8 @@ int blkdev_report_zones_ioctl(struct block_device *bd=
ev, fmode_t mode,
>  		return ret;
>  =

>  	rep.nr_zones =3D ret;
> -	rep.flags =3D BLK_ZONE_REP_CAPACITY;
> +	rep.flags =3D q->zone_flags;

*all* zoned devices support capacity. So why changing this ?
You are only forcing adding setting the queue flags for all device drivers.=
 That
is more code.

> +

White line change

>  	if (copy_to_user(argp, &rep, sizeof(struct blk_zone_report)))
>  		return -EFAULT;
>  	return 0;
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zone=
d.c
> index b05832eb21b2..957c2103f240 100644
> --- a/drivers/block/null_blk_zoned.c
> +++ b/drivers/block/null_blk_zoned.c
> @@ -78,6 +78,8 @@ int null_init_zoned_dev(struct nullb_device *dev, struc=
t request_queue *q)
>  	}
>  =

>  	q->limits.zoned =3D BLK_ZONED_HM;
> +	q->zone_flags =3D BLK_ZONE_REP_CAPACITY;
> +

White line change

>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
>  =

> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index c08f6281b614..afe62dc27ff7 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -81,6 +81,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct =
nvme_ns *ns,
>  	}
>  =

>  	q->limits.zoned =3D BLK_ZONED_HM;
> +	q->zone_flags =3D BLK_ZONE_REP_CAPACITY;
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  free_data:
>  	kfree(id);
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index d90fefffe31b..b9c920bace28 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -2967,6 +2967,7 @@ static void sd_read_block_characteristics(struct sc=
si_disk *sdkp)
>  	if (sdkp->device->type =3D=3D TYPE_ZBC) {
>  		/* Host-managed */
>  		q->limits.zoned =3D BLK_ZONED_HM;
> +		q->zone_flags =3D BLK_ZONE_REP_CAPACITY;
>  	} else {
>  		sdkp->zoned =3D (buffer[8] >> 4) & 3;
>  		if (sdkp->zoned =3D=3D 1 && !disk_has_partitions(sdkp->disk)) {
> @@ -2983,6 +2984,7 @@ static void sd_read_block_characteristics(struct sc=
si_disk *sdkp)
>  					  "Drive-managed SMR disk\n");
>  		}
>  	}
> +

White line change

>  	if (blk_queue_is_zoned(q) && sdkp->first_scan)
>  		sd_printk(KERN_NOTICE, sdkp, "Host-%s zoned block device\n",
>  		      q->limits.zoned =3D=3D BLK_ZONED_HM ? "managed" : "aware");
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 8fd900998b4e..3f2e3425fa53 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -512,12 +512,15 @@ struct request_queue {
>  	 * Stacking drivers (device mappers) may or may not initialize
>  	 * these fields.
>  	 *
> +	 * Flags represent features as described by blk_zone_report_flags in bl=
kzoned.h
> +	 *
>  	 * Reads of this information must be protected with blk_queue_enter() /
>  	 * blk_queue_exit(). Modifying this information is only allowed while
>  	 * no requests are being processed. See also blk_mq_freeze_queue() and
>  	 * blk_mq_unfreeze_queue().
>  	 */
>  	unsigned int		nr_zones;
> +	unsigned int		zone_flags;
>  	unsigned long		*conv_zones_bitmap;
>  	unsigned long		*seq_zones_wlock;
>  #endif /* CONFIG_BLK_DEV_ZONED */
> =


And you are still breaking device mapper targets report zones with this pat=
ch.


-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
