Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33252C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 07:54:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CCA20B1F
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 07:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e3d9xomY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aoK9SgHE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Yg/tY2Nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CCA20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=v5JP2+yuskbPOjjZ6sgP+cEG4bMP/YdFl13Vix95sAI=; b=e3d9xomYssLV61MXWlk2jkW3a
	CmWVrdftffNh5yT8WK679INVHCMfYICVUvAX+mRxYn1Uv/0bJ0JMeHZEUgYi0N24jLNqw/2C6UKRf
	Lcut7Mmd0OZsrmfcMZ1D2eHBVOF4WQvRQ8SglnAizvE8Bv8WrI9p1HZutbz+ghfOSrdJQA7WqIFX3
	djZ9RtDtbGb702Zv3K7fhPv2AM+s+4a74hVqg1+LrmhI9nBMAAGdIkoUiBR6XVtXXOuGa/j5j98MP
	EKB0iXvepCcMnx5R1vpX0Sl/qbRjh8ezJiJCRcIY5g1VSHdSTZ8xqkvW/RAzdHrCS/2+UH4Gixbd8
	OPGvjFZ9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqu3T-0003UZ-Ol; Thu, 02 Jul 2020 07:54:47 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqu3R-0003To-Fd
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 07:54:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593676485; x=1625212485;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=aaeZSnOXqrP62lECJelRQQcCZZ1aERfA73WJ7VSQEto=;
 b=aoK9SgHESa+IGATVy/VzBsXGwRg4Db7XOkAhpJ3glTr/cI5mAgpWhkjh
 2NmSo+TREvzmEh1w6J9kU4tKQ4OZajpGs2fgjHTVl98SW2PqeyWhmrXYy
 DZ92Rixik5RWLNuOlBItte4DuEo5u4NCjg/6RtwoJRXDlHdmT9imJIuQP
 9coVm2UcoLkTVZOZUFbUxb1uI2xopbna1wWnfjuB1OXKmi+56gQhCVc4x
 F0a84tPJ1VAdouIVgqFcaHA4bclMgok2dr/SY6w4yFe3TDWAOzQvTn/ay
 /AD2XYno3WALdPrRdP2aGc8pxHSM4thY7fKiChHO3QBXs4t6ap0BOEN45 w==;
IronPort-SDR: 3Ne0I36hJzabjKLXTX9ldrNQ3+jLqjhlqLm3hEIOqva9IWh0tqIh0u7Bg8vCrJcMlPz15AJoVC
 qoGXyDLYexFnM33vF5dfkAZLC32nFx2rrLXE4QJtP20eNslnQmjSz8QSH3DaZANNwItXruwEki
 TUVAqKPR4XhZNFZn5uFRiM0nWt1wLxFgr+LPjsK8M3cSsmZ6JjLRerpZJXu7wuFhp6Y93hDkhu
 lhsFSl1+VoJxZMTBb3tJkllgl1qIf8nb8W32TzfitRBXTYp29wm3HmwlijQBYWnWPYfxqigaQB
 Wd4=
X-IronPort-AV: E=Sophos;i="5.75,303,1589212800"; d="scan'208";a="141662213"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 15:54:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRAE4rKg9W6AlM98OkONe7gUprXow32NttF67f5OwGNQCZnVwlrMFwwrrZ7KMhgpP//4Hiu2TkUWQerTnBXWPbrKSH3RYwkV57wzTKI1yG3oRJoxWEysNh1pj+6gDR6yz3CCqGFo1Xksm74uUHS9q0mZEzTFWbKUzKgxd6GsHxd+GRgXappw6mCmMVcnhzqH5H+agLLnKFMHs820P6nPYimojcwVcDc1gZZHD7VKg/Cfg4LqDzz1ponO/t0j9ZP1mUtkyQKTi5OPu8mTDLH1+RTfDEVODi/7XRIrGBCCjYIRcrfetxLhBfTN9HX5OPfuebZIp27+ksAcFZozttRVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqUHW6epqHx+bxCEx28DMxnMoF6uHUqRCM37Nmw++Xw=;
 b=FYnA+UVAJKCdQnP8XHYuZzQ6ZJ1Fw4MLS58miyfXrjENCmgpaWJBP1XpuKWyEHcMFGGvlprIyLSVgqjq3B9NT8BHHZwHr2ESlN6CwcR0jc9aTFcl0Jp45XzddHZOWBKDinqoCQP1vLCuOTUnY2b7WWtwvMmpMHDyIHXE8JHDnd1odEgO08bxKaJP2rEBkvV9ESMQXMh0ylL5sbD1pf3RJCDAhC91LgBOqV/RoNHfxrB49mowMLtAd0/R71treBbjCwlRNDAtodpn9mLhWW+7pdyePxfcqY3ppINzq8h2sGTaTIVoFolxCHDieWRqWHuPvTuNiSPGk2iLZpouXfpdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqUHW6epqHx+bxCEx28DMxnMoF6uHUqRCM37Nmw++Xw=;
 b=Yg/tY2Nq+SKoqfTxNHYZL6PBjqOrdjyDa1N0XQ5U0Ploa17BFoit6e/tK8WdfHYbRcKcdxe6ZGlSCUCFkXd9+RDDIC+Ysis+naY/t1+jXm9law2f9LRMUVKXQb18K2YaqVD0h4XxPZhEPQjff3jX2+ehxqlZlCZ76h1aBmVtjlw=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3588.namprd04.prod.outlook.com (2603:10b6:910:90::35)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Thu, 2 Jul
 2020 07:54:40 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 07:54:40 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/4] block: Add zone flags to queue zone prop.
Thread-Topic: [PATCH 1/4] block: Add zone flags to queue zone prop.
Thread-Index: AQHWUD25/vKGWWSejEep48tajSAGnw==
Date: Thu, 2 Jul 2020 07:54:40 +0000
Message-ID: <CY4PR04MB37511008EEBF1A77DB4F423BE76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-2-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78b3d35f-ac87-4612-e7ee-08d81e5d2cc8
x-ms-traffictypediagnostic: CY4PR0401MB3588:
x-microsoft-antispam-prvs: <CY4PR0401MB358804AD4B0171E30A404294E76D0@CY4PR0401MB3588.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gwrROOTVrm+JsxSd+d9LaNqvWFdHN0/ELwsXKlfrnqYiXGV3HVE4rowXMiXalQh7UTHh0eA6cQbORpBdLpl38UgqwzrlHgyqqM3DML6zhfUNE4jXaOZHV0t9zpHXReycogKZx6aXxWoQ/vzeMew9cSuR48KHr9D5Lt8p99sLhvHv+mUNHMG6y/2mnJI1pBbXsUlW+/KfpjU8QF1vNI4iYuaNAJlCEY5w5b1lBkKaVmVS5XrBIbGBmf1AlHChdE2QgjSdVgWNB77zonxfdnCdFVPSi2TFMjbK/F9jdhsjgTuNFvjNWEc8h7s/3eRI/joMLbNKNGPLOTiD9yGFwyQ8mQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(478600001)(33656002)(2906002)(7416002)(55016002)(9686003)(64756008)(8676002)(8936002)(86362001)(91956017)(76116006)(66446008)(186003)(66946007)(66476007)(66556008)(71200400001)(26005)(53546011)(6506007)(7696005)(4326008)(52536014)(5660300002)(54906003)(110136005)(316002)(66574015)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 2usdrQDweCzUk0xOTRPISE/y/8j6aNygUY5tu9/gDf32m4R85QOtUk7IaW3Q+nyDOtcN2SAaP7FMXz3+EiHZPEoH5h3esdnH6AZpygQugmcBHhTxFUiPxGqTGlUiP4vNbHxmrm99MsnYKGrDUJVTTGyqEPveZBuUed0F14rZeB22opTGwlUeshoShjPrSNEmetlFU4PDtk1AVWB+B8GdqKSJI4oOS7WrfuP6NNJiSdLb1l0ePzBdHmu7xiT54ptMLi6Lnqz5HA960vErBbhdF+vSdaD7saxRL21D15LUid5x1YxvLF8rEDDZoMcwUxFibHJxaWUHvviPFCvUBrS/HCZyccndjP3WONJ/V78BN+2L/FUXD7tOIYE33mFnGW1xqdpTjh5kHxix77302kvCxLJh/yEFrlRI/7Gt04Ur/qdqI9Q4zql5f29fEODDHyVOOCDw1er0cNppAz49ttAiaiXUYQtjuzYK23BwObupKOKsUYRoxZEc/WcPydMgMQqc
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b3d35f-ac87-4612-e7ee-08d81e5d2cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 07:54:40.4351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGr2haujLoZEDayQdBzOS/ZMN3xS+uVB7OsFVXEMCo6gzHDo6ZT9J8qU0lBCq2qKu8cZE1/lhm/ULgtuEnm/zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3588
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_035445_656923_D0C9B185 
X-CRM114-Status: GOOD (  21.35  )
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

zone_flags seem to be a fairly generic flags field while rep.flags is only =
about
the reported descriptors structure. So you may want to define a
BLK_ZONE_REP_FLAGS_MASK and have:

	rep.flags =3D q->zone_flags & BLK_ZONE_REP_FLAGS_MASK;

to avoid flags meaningless for the user being set.

In any case, since *all* zoned block devices now report capacity, I do not
really see the point to add BLK_ZONE_REP_FLAGS_MASK to q->zone_flags, espec=
ially
considering that you set the flag for all zoned device types, including scsi
which does not have zone capacity. This makes q->zone_flags rather confusing
instead of clearly defining the device features as you mentioned in the com=
mit
message.

I think it may be better to just drop this patch, and if needed, introduce =
the
zone_flags field where it may be needed (e.g. OFFLINE zone ioctl support).

> +
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
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
>  =

> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 0642d3c54e8f..888264261ba3 100644
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


And you are missing device-mapper support. DM target devices have a request
queue that would need to set the zone_flags too.


-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
