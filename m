Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87E8C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 09:51:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854DB21531
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 09:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gBWKAkke";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F4pj54dN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VLS54hFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854DB21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=cg2sZcgn+G25Kf6Fkk22Bl+ZCANW3IQ6FHfC5zWj2OQ=; b=gBWKAkke0HPLl1BuVgWVQ+eue
	3srjWGKaB/SMowvg2PiJIVy1glH8RbGB2sPci6RSwYvdeFfQoykH8yrBYO/3hL21Ayu9mWhzGl7AK
	o0fB/FngULbWk9P5JwN1HyLyEofNwbRyfF47jViw1KjK1xmW4Rr9gBpUEAAVla+2IrMIsKhGrUHh6
	DZ/9O3MbhVaLOIvN1mKQcOrJW+l6mimFd6sIRniIUW5gDfco55gY3iiqrXkHRrOZcsoDWTCz6aHe2
	KDv44K8Qq1GnD8+nA1hUryFgpxq5MZjy4o/RtlCNynxn62EbY4HsUafqLxu0hkBjpS6gVe2yXvZVp
	sf9jEDCSA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jol12-00035k-5b; Fri, 26 Jun 2020 09:51:24 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jokQ6-00024O-Qx
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 09:13:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593162795; x=1624698795;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=NHpBSsJbEkotRKvhqvpfdJDLD9wPiSMMT+xhWyFy+tY=;
 b=F4pj54dNaS0y9XAmG8ipMWzCoqcFwFhlAkssU2bSZijr4kMlRLjGvGIS
 1SIBXjbGrzuL0Q0+W15iMcQ5HXY5rv/46Ge3+h3qVCwWaPiZYPIGzG0mZ
 KpT9aCc2P391CaCkPFMgquHkhbYr6gewYpTqIOMIvWlg3Hz+MqK4zm168
 vr2nHvgGE68e3DWuADRZ3VZOp+naCPtr4dAQ/qlKTnI8gNL4ld9gO51mj
 Y/gV3FRBaHwurZJ0J7zzFs3rfjo9+5ECziKCtrcAbhVdhaaeIpYje+I24
 STOEvhTS7d3zSo3OU8kXtFFyHVtB9PtzOcYHSr3I+5Yx9Acv7gYBYGElJ g==;
IronPort-SDR: gkg+3nSxL4R8NBP5GX7nZVvUz0rClA35Uf/MpaKnc9tda8zU8shr9cqJlYjs/W6FeMjHl+C6xk
 Sdt6XGb8UjEeWRfNwAWGoJsHbMCPgStjagV835BvP2HlufKkc8IdsPy2/qt3OSu2CrynlAhmzI
 XGjG3EImStU+iB2f1RvWVsxXn4rzS/s1W3eA0m/4oEXrxnKffJ1sOqLACdo5ndiLERheihwyLe
 MbNF0tB+/lBpSA7qyISI8yhMOZ7AxPcHiQ0pshQQaO3OhBjPTo49NEmFnCYo4mWDvfBhpAPSzh
 /cs=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; d="scan'208";a="141211955"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 14:42:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhX2UmJoK83rDbuRv+EbHnJFbMbb7dszgMNdJM5DatB+IgsU8VhLjFimKks/hpL2lct5jDPph9u77hklDZ6FSnoptPD4/ytxPuaqGBZ+7kdsUP+iuCZn467cARr3lfiiQ+yV/0bflqyF4sexKhV+3z876YTM/TiCZ1WEDo0/opM+GeUtFPVv8sx1FRaI3lhQDapVTEM+/FDC9ujSHnwM8OSREUcBPo6ID4MKmTqHP/5xQOmFmDUB7/uY/xq9ibwkNdKZMvavN4Unbu9W0w847jIWu8LV/DzYHHbo3YAeszI6TpcRmYWH2UJBrd3Ye3OmGE8sx8S+8fuEK5XeNB17Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKcv8vLdqn4SdoWiZ45ao1EwbFjIOk1IxpJ9zNuBrp0=;
 b=Y+wEkbq00t9pMR6eJIDGQfVMpLoWDyZq8IAgbMjTBIrSIZw+oaihJuyZVr7LURiLtUWezbS5mI+rJ5sObBjyiCNR0wwFNHa7vGn+HtNZtZYQLxeQRDCC0bV44JPzsCJ0E3Y8h1/8uK5vtTuP88WWerIDj34ICSkT0eh+vs7+KHSP9zxb3nzcS3TmR2Om0UvlvTiLuXpogQPObB8+ThZf5l2kLu9su4FA5iCHn19AgnaOr1OHre4lzZgumjYe7TuCoVpf/HAwVF+e4XjeByFVczDR168viIQc9USZDzdM1q+OWF/OWtyHnCE6hNOaqA7OmsY0XlbTlAVaYHE5ll0W9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKcv8vLdqn4SdoWiZ45ao1EwbFjIOk1IxpJ9zNuBrp0=;
 b=VLS54hFI+DjRfjelhEkrjEb8R6+PONxewTS5kFWcQUAl8MdGwgMiAxF01htD5jXfMjDmt1kLUxoOW/ad/6zV3PLdgy3zCRmoxrH8UzCGxTWAZzZwwfeO7fg/9dEwXDmfWWyCryOBbmtY+Tg7a70dE3O9w/oUkGjIgyhwCsxmxko=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3586.namprd04.prod.outlook.com (2603:10b6:910:8e::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 26 Jun
 2020 06:42:26 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 06:42:24 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Thread-Topic: [PATCH 3/6] block: add support for zone offline transition
Thread-Index: AQHWSutT3xCQHGem9k+D54mKrpOEQg==
Date: Fri, 26 Jun 2020 06:42:24 +0000
Message-ID: <CY4PR04MB37515EAB61CDB458DE5AFCA3E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <CY4PR04MB375111445246B570FAF4EE58E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626060858.uo56xe57l4tzepnc@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78cf473b-5148-4dbb-c7cf-08d8199c1601
x-ms-traffictypediagnostic: CY4PR0401MB3586:
x-microsoft-antispam-prvs: <CY4PR0401MB3586D5A409E2FD32DF7C9ED5E7930@CY4PR0401MB3586.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CDJS652uPVOsRrN8koZwkaXVZYKoXpwf+xU2S99A94NEVWiJLX5342J5V9+uKql1TvYHT9snOz01sBySvxNXdZ82+rrr0uJLco4O+/0gIRxL0Ppsc0HKQPlyixd6i5PyVrwU4BiRMhlwz2o9w6dVAduzBV3/Oqw3OugZ4pgs6h/IY9D4uHiYi03605NRTEmgbMqa4nQwsf+CeVWaMbbQzwc3jLz8njknXOwyaBb9g4AhAjbn+rQKeF1cUA2G/UTvWIvnuHbNRgwPffJCQVtXuCWTmt1qkp8K/5Y7nAVip5jTRbVMEsn4AkOD6S2Irdcg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(86362001)(5660300002)(8936002)(6916009)(52536014)(8676002)(66446008)(66476007)(33656002)(64756008)(66556008)(66946007)(76116006)(71200400001)(83380400001)(91956017)(4326008)(26005)(186003)(53546011)(55016002)(9686003)(2906002)(6506007)(7416002)(66574015)(316002)(478600001)(54906003)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: WT2c8lS1oZGk6Rskq9z73cDJ/YdyCHtuJ0e8h35slk12CLZin1nMTzoQdoHs0ywtppeawjVzTh9+vqCZ4wyIX5+lwT97A8Jhxk6cIG0NVRTzUFwhvBv+Q7Iwk9iM/Uii9smFX70Li5EZPyXX6TfaWXFCnaZ7Y+VCdjQlACb2BHG89TAFLeo0UdrbHzTDK7Cx80zbD51mqzSJYWw455lih+FX7Tim0NurnA0mye2cKVEmZ4XkiJsrK+EGnkCceov9l1451Kma7dZpaMWyttL/Cbtt/InaKHWo+ejjs1yv4hkip1b7G9ERl/brGbjxZqbEDzVRLjG+v5bvPx1nNPcylLQb5mK3iPW10faKHQ2AGhSzFA1o2zCKvPUyWu/hx1PEECJL+tG2ONORH6lrKejlS3oDWch6ZaPaMogpNVKBe6Z1gxGmYpP5ZvapFEzJXe5YwM4GkrSKKGmdsS7w2D86swBYLT/C4I+tLm01bb93PRLdXa01aJ7Prju/W3AcgA8+
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cf473b-5148-4dbb-c7cf-08d8199c1601
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 06:42:24.5914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OaSbbo2dLcMUX9y/Is0IY0AlpaiVk0DjuZYAqkPjnHlrHMRsI8oVChhWUjwe5Ml29QlGO3AHDeSgYvl9e0iLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3586
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/26 15:09, Javier Gonz=E1lez wrote:
> On 26.06.2020 01:34, Damien Le Moal wrote:
>> On 2020/06/25 21:22, Javier Gonz=E1lez wrote:
>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>
>>> Add support for offline transition on the zoned block device using the
>>> new zone management IOCTL
>>>
>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>> ---
>>>  block/blk-core.c              | 2 ++
>>>  block/blk-zoned.c             | 3 +++
>>>  drivers/nvme/host/core.c      | 3 +++
>>>  include/linux/blk_types.h     | 3 +++
>>>  include/linux/blkdev.h        | 1 -
>>>  include/uapi/linux/blkzoned.h | 1 +
>>>  6 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index 03252af8c82c..589cbdacc5ec 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -140,6 +140,7 @@ static const char *const blk_op_name[] =3D {
>>>  	REQ_OP_NAME(ZONE_CLOSE),
>>>  	REQ_OP_NAME(ZONE_FINISH),
>>>  	REQ_OP_NAME(ZONE_APPEND),
>>> +	REQ_OP_NAME(ZONE_OFFLINE),
>>>  	REQ_OP_NAME(WRITE_SAME),
>>>  	REQ_OP_NAME(WRITE_ZEROES),
>>>  	REQ_OP_NAME(SCSI_IN),
>>> @@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)
>>>  	case REQ_OP_ZONE_OPEN:
>>>  	case REQ_OP_ZONE_CLOSE:
>>>  	case REQ_OP_ZONE_FINISH:
>>> +	case REQ_OP_ZONE_OFFLINE:
>>>  		if (!blk_queue_is_zoned(q))
>>>  			goto not_supported;
>>>  		break;
>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>> index 29194388a1bb..704fc15813d1 100644
>>> --- a/block/blk-zoned.c
>>> +++ b/block/blk-zoned.c
>>> @@ -416,6 +416,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bde=
v, fmode_t mode,
>>>  	case BLK_ZONE_MGMT_RESET:
>>>  		op =3D REQ_OP_ZONE_RESET;
>>>  		break;
>>> +	case BLK_ZONE_MGMT_OFFLINE:
>>> +		op =3D REQ_OP_ZONE_OFFLINE;
>>> +		break;
>>>  	default:
>>>  		return -ENOTTY;
>>>  	}
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index f1215523792b..5b95c81d2a2d 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, str=
uct request *req,
>>>  	case REQ_OP_ZONE_FINISH:
>>>  		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
>>>  		break;
>>> +	case REQ_OP_ZONE_OFFLINE:
>>> +		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);
>>> +		break;
>>>  	case REQ_OP_WRITE_ZEROES:
>>>  		ret =3D nvme_setup_write_zeroes(ns, req, cmd);
>>>  		break;
>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>> index 16b57fb2b99c..b3921263c3dd 100644
>>> --- a/include/linux/blk_types.h
>>> +++ b/include/linux/blk_types.h
>>> @@ -316,6 +316,8 @@ enum req_opf {
>>>  	REQ_OP_ZONE_FINISH	=3D 12,
>>>  	/* write data at the current zone write pointer */
>>>  	REQ_OP_ZONE_APPEND	=3D 13,
>>> +	/* Transition a zone to offline */
>>> +	REQ_OP_ZONE_OFFLINE	=3D 14,
>>>
>>>  	/* SCSI passthrough using struct scsi_request */
>>>  	REQ_OP_SCSI_IN		=3D 32,
>>> @@ -456,6 +458,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)
>>>  	case REQ_OP_ZONE_OPEN:
>>>  	case REQ_OP_ZONE_CLOSE:
>>>  	case REQ_OP_ZONE_FINISH:
>>> +	case REQ_OP_ZONE_OFFLINE:
>>>  		return true;
>>>  	default:
>>>  		return false;
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index bd8521f94dc4..8308d8a3720b 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -372,7 +372,6 @@ extern int blkdev_zone_ops_ioctl(struct block_devic=
e *bdev, fmode_t mode,
>>>  				  unsigned int cmd, unsigned long arg);
>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t m=
ode,
>>>  				  unsigned int cmd, unsigned long arg);
>>> -
>>>  #else /* CONFIG_BLK_DEV_ZONED */
>>>
>>>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzone=
d.h
>>> index a8c89fe58f97..d0978ee10fc7 100644
>>> --- a/include/uapi/linux/blkzoned.h
>>> +++ b/include/uapi/linux/blkzoned.h
>>> @@ -155,6 +155,7 @@ enum blk_zone_action {
>>>  	BLK_ZONE_MGMT_FINISH	=3D 0x2,
>>>  	BLK_ZONE_MGMT_OPEN	=3D 0x3,
>>>  	BLK_ZONE_MGMT_RESET	=3D 0x4,
>>> +	BLK_ZONE_MGMT_OFFLINE	=3D 0x5,
>>>  };
>>>
>>>  /**
>>>
>>
>> As mentioned in previous email, the usefulness of this is dubious. Please
>> elaborate in the commit message. Sure NVMe ZNS defines this and we can s=
upport
>> it. But without a good use case, what is the point ?
> =

> Use case is to transition zones in read-only state to offline when we
> are done moving valid data. It is easier to explicitly managing zones
> that are not usable by having all under the offline state.

Then adding a simple BLKZONEOFFLINE ioctl, similar to open, close, finish a=
nd
reset, would be enough. No need for all the new zone management ioctl with =
flags
plumbing.

> =

>>
>> scsi SD driver will return BLK_STS_NOTSUPP if this offlining is sent to a
>> ZBC/ZAC drive. Not nice. Having a sysfs attribute "max_offline_zone_sect=
ors" or
>> the like to indicate support by the device or not would be nicer.
> =

> We can do that.
> =

>>
>> Does offling ALL zones make any sense ? Because this patch does not prev=
ent the
>> use of the REQ_ZONE_ALL flags introduced in patch 2. Probably not a good=
 idea to
>> allow offlining all zones, no ?
> =

> AFAIK the transition to offline is only valid when coming from a
> read-only state. I did think of adding a check, but I can see that other
> transitions go directly to the driver and then the device, so I decided
> to follow the same model. If you think it is better, we can add the
> check.

My point was that the REQ_ZONE_ALL flag would make no sense for offlining z=
ones
but this patch does not have anything checking that. There is no point in
sending a command that is known to be incorrect to the drive...

> =

> Javier
> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
