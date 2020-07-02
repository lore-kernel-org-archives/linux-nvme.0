Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65075C433E1
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:41:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F7220884
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aUV67UQ3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K7TTcdD8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RJ9MTxzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F7220884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Nx73JdLBt2SplE++ShAb4hvHk89aPGaWUU/lLKAICOk=; b=aUV67UQ3DjN/5s3MYcYLX7MB7
	QLBUQwEUU2+Q50wBYUzJVOYtPKK6dSzuFBQuAMExRWoJcSpugqQeJPjtj1tKWMOUMiAUGsWHyExSA
	FHaeFvtTOYO8PIdyXTPSc5+6FyZahXosY3pEOzkliP9A+RtG5wnS79WQc3iLcYd2BxNM91GhsvvqL
	2A2AAGfffUIQD28bAicS6bFBILz+XzVfpWNYoNqu3YtGCdQ2Yl0J1iLptrpT7snZor/XEd8Xz7tuT
	OojGwSkEDA7aJfU5bPO3NM4XH5IxKdRKU284IvqLwUrpy7ICWuxC0xJzZx77yRrpglpNPYfXEs+h7
	M4iGEWN8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqumO-00038j-Dh; Thu, 02 Jul 2020 08:41:12 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqumM-00037l-0q
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 08:41:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593679270; x=1625215270;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+dDiG4qpRmfshEeRv6xwYI70Yj4gH0uPhch+7f9kfPU=;
 b=K7TTcdD8Mf2zo+msVuKlC0HHnCewOwYkWzKflpb1KSw46C+ToWTJLpKB
 +CUN1ine52GIxh3/FBMkp795sVcxXTURQM8Lw9Ev+DI9ezGO1GyEE9RpL
 c1DkmMWkrTBzVmLs429EILUqaSFy9iJo2SjTwRR6KJ6E8muYYQgaj+mc2
 ntuswf1jdHxMNibO8PJEQGQZmZMdFu/jAijU3LzvPlBneL8BobHA5Shry
 XjUHKvacMi1VOp53qUUqBRDIou91UgzyOMtpvFMyIhkAkmeX+rbEuvkAl
 EukkrV/b4W7aI+Rj5JRZUUNpz28CYPkCVXk7ZRkeDS4Ftq8WzK1Ogpw9I g==;
IronPort-SDR: WFbOym90J41xoZqo8+KXSRuzbo8DKsd2DQuSFeuySOG3/6XmqlxwWAB16+3Qz1Mi6hPZ5hjzbW
 nbJ4RHNsCGAmgBLE07EW1BtTURRs1SUk33pFlJajWobb0j0tf/3w5jSOmJq39bGnNObtBt5fNf
 Gp1Rd7V0IdaiN9SgnXu8+HYG2X4QepwoWO+AloTF68hceoRYo73OzMnNhB9oz0xqY1ZUdKrrAS
 vtiuiI6KqDwiunMgrKIvHF3bEccWMedfhTn42SYClYXMWWTohMy7En3AsEQI8XsbftvBEJpinV
 CWo=
X-IronPort-AV: E=Sophos;i="5.75,303,1589212800"; d="scan'208";a="145792956"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 16:41:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCBCwljt5/O7uhqxBGByze7R/09Mo3DYq2GLK6iYk9o8R1V/6fE57VC6qe1f017Xv7SXJnnqFbci4WO3Rqs9AiniBVaXr3Lzgl2puwd7ArD+KoMY+zRprr5/8dBv+paDwfRYhTc/xXWCLjA2Lye4R5AbxrnoTCvajwGBu/Vgbv3YJrq+s4m+pWN+1ylPKAu1P1m6pwx/0OzQc/f2/G8qh7PogZz3kGVCH03HUbeuXQDJPJvz4qYhi30KAmCE/W/L9qcWV7sDnXGNJfbijS5Srl9irdhRZnO+4TfufthdfbSEnkOvE3YOpUOp5q6SD39qTtnewgIPSp3IOZN9io8/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dDiG4qpRmfshEeRv6xwYI70Yj4gH0uPhch+7f9kfPU=;
 b=oD9Ta234vkwpIxZ0oxNmaaCdCzCPM3ULPRb0nKRMGPk0ijG5OjUdiYZS0HDKiKypXVJNHPRr6BbvJBAx0v2r6ifygZ9QzxD4vweXhJ6k8MZUoORlfR+eqwrFoyGVF+2yflzYYWsdVVX1pqY9Zvumd7j/AhKKygfhC2g8tVv4/iVptxdLqj2AF96HYu7efPmKUm2Tz/vCroKHi9Mc9GF5e9WVxLVPfuWEgxcvMZFDvtLlTUMlD2/ULyzJoPfl6Bq05+Nig1h3jlnba9YCcRdI8at3Yp5BTTU14Fzdy0XsMVF5BMaZPaziB5frVbmAfGhsi9RUyvaooi7P/l+QVOj6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dDiG4qpRmfshEeRv6xwYI70Yj4gH0uPhch+7f9kfPU=;
 b=RJ9MTxzd5ZJDiq0FQwVQkTYs7oLfElaS30ZNhL0GRHsERiCCfonGFpAmjOzXmH/hiFtUFttkSIx6Qp0xlxrfi9D6iLtA0GxbqJ0lrpJNuiwKC/uiFi8pzNpPEWWT+7f2hHNL7FTizm/V0UhDX5N5sGLLbcKYspdPiyRUXOBmI9Y=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB4934.namprd04.prod.outlook.com (2603:10b6:a03:4f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Thu, 2 Jul
 2020 08:41:05 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 08:41:05 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 2/2] block: add max_active_zones to blk-sysfs
Thread-Topic: [PATCH 2/2] block: add max_active_zones to blk-sysfs
Thread-Index: AQHWQ8iQJj1cyFXZ4EOOAcdNj7JGfqjyqqwAgAFmzQA=
Date: Thu, 2 Jul 2020 08:41:05 +0000
Message-ID: <20200702084104.GA607715@localhost.localdomain>
References: <20200616102546.491961-1-niklas.cassel@wdc.com>
 <20200616102546.491961-3-niklas.cassel@wdc.com>
 <20200701111330.3vpivrovh3i46maa@mpHalley.local>
In-Reply-To: <20200701111330.3vpivrovh3i46maa@mpHalley.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be7026da-0a5e-4620-f32f-08d81e63a8da
x-ms-traffictypediagnostic: BYAPR04MB4934:
x-microsoft-antispam-prvs: <BYAPR04MB4934C8167CBE6B4E0180D95BF26D0@BYAPR04MB4934.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QoQbkdbu4cgiKlj3AtgXXJZF/l+5sq4fiuG31alrdsk8SKT1KM1l1YQbqGlYQK8rvlvrdCBATgsRMOmJ3ewdk0QJNZJj4S4yQEmJcVCpg4Xd/ERfBuWS5wkzJkdHJVvtAqUWyQyu70r4QsETy+y6S4T78fmTCJ8NmJn47iZGGm5DpwAcoh+u3BbaJqL+r2BDlh7bvbyzkyMtqmnXFRH5z00Hcm3e6IVbHI9CbycTL5c55zyPB/uikci8szsQbvpOsCUNMow97Fxy1kSGl1H3B4KZfsDlFvin7+8sTvNzg4OZAj3xhSNz3G/da6yqHDeTxs542sCJ3tz93F2kzfGpEw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5112.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(6486002)(9686003)(54906003)(6512007)(71200400001)(478600001)(4326008)(8676002)(66946007)(6916009)(66446008)(53546011)(66476007)(66556008)(316002)(76116006)(66574015)(26005)(186003)(64756008)(6506007)(91956017)(86362001)(83380400001)(2906002)(33656002)(7416002)(5660300002)(8936002)(1076003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: NBt/luJiIEMUJ7q3E814qU4pjb9Zp7UFgE+4KV8yUiSmHT6aRwLeppTht61T8Uy7OFkXymgKJiCHy+Cb4ndJZSYLhyYKe0mZs+Y9Co3pky/dfCyj+o4KPttScD/2N2P1AOvXWZqgsYbPoWIbxFdNcra7tmyze3Tu4gufFjILtfOj1D4vXeHcO0FFqf0zg51/EFJBmgAXgd1fE8JgTztQL5RsTTejLpcWVqdkAqsXfmRqAdtA/EybqEC9bTf53wd6FHIVWI6aYfoHAeywrW5j++QOlqRNGuhGCpfGdIirbmBZtMHPHbUaSsbqqtuQ6RPr1C663rjyG6diUjuSF3ueQyJ0o8sL39uPacbUSQGwEJTOV36E/9WAznFyFU/Bj9UUD/lvblf3G3seMNUN2DDJ8Odwpen/Sfjxc+DHsKrPrFKOB2smZzxwUbzG7rU0IEtAptODDXAnPNSdFRiddTjbNlnttssnSBeLdi/HA1Jd7KsezBzXzpZ4oWm7ZYaPXEXC
x-ms-exchange-transport-forked: True
Content-ID: <19353BAB97C4E8439B6A6481F7A385D2@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5112.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7026da-0a5e-4620-f32f-08d81e63a8da
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 08:41:05.5452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMCEhO+Zr+42GZcycNkXw9hVi9Nv8tyPZxdgm0x59ln7GJ14gDCKmpo8m9Zdj2ZBETDia65oBGkg/wSnZMg9tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4934
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_044110_201285_812A5676 
X-CRM114-Status: GOOD (  20.40  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, "Martin K.
 Petersen" <martin.petersen@oracle.com>, Jonathan Corbet <corbet@lwn.net>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 01, 2020 at 01:16:52PM +0200, Javier Gonz=E1lez wrote:
> On 16.06.2020 12:25, Niklas Cassel wrote:
> > Add a new max_active zones definition in the sysfs documentation.
> > This definition will be common for all devices utilizing the zoned block
> > device support in the kernel.
> > =

> > Export max_active_zones according to this new definition for NVMe Zoned
> > Namespace devices, ZAC ATA devices (which are treated as SCSI devices by
> > the kernel), and ZBC SCSI devices.
> > =

> > Add the new max_active_zones struct member to the request_queue, rather
> > than as a queue limit, since this property cannot be split across stack=
ing
> > drivers.
> > =

> > For SCSI devices, even though max active zones is not part of the ZBC/Z=
AC
> > spec, export max_active_zones as 0, signifying "no limit".
> > =

> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---

(snip)
 =

> Looking a second time at these patches, wouldn't it make sense to move
> this to queue_limits?

Hello Javier,

The problem with having MAR/MOR as queue_limits, is that they
then would be split across stacking drivers/device-mapper targets.
However, MAR/MOR are not splittable, at least not the way the
block layer works today.

If the block layer and drivers ever change so that they do
accounting of zone conditions, then we could divide the MAR/MOR to
be split over stacking drivers, but because of performance reasons,
this will probably never happen.
In the unlikely event that it did happen, we would still use the
same sysfs-path for these properties, the only thing that would
change would be that these would be moved into queue_limits.


So the way the code looks right now, these properties cannot
be split, therefore I chose to put them inside request_queue
(just like nr_zones), rather than request_queue->limits
(which is of type struct queue_limits).

nr_zones is also exposed as a sysfs property, even though it
is part of request_queue, so I don't see why MAR/MOR can't do
the same. Also see Damien's replies to PATCH 1/2 of this series,
which reaches the same conclusion.


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
