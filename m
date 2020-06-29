Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6E6C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 00:53:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDF32076C
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 00:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nxQugdtg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="auN41T1Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IUrSYzk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDF32076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=mVvVjao1uY/mFYZX9iFONtE5FCYhjF83tr+aG5FWbmg=; b=nxQugdtgYbzrqO/4hwuxGVEFt
	lPagSkuet6HZ2V39Z4ImWiKDNrswTwuhXQhW1eXne0OX13CzeZi1TqALAzXqTyIwKIAO1wXLF4MEf
	ZUJkVhk1/0eRlpQiSDum1NhMrXNzDPIVTUCIf04Ewrs/MK1a1QVfuyCNCZhIvoTkT93az2b1wwuzX
	yueB0GNxD/ZP1YvW/+nHeOiRV2plDppf83+DzgJK1eQhKE7SVQpUgeohFqcbZeXuX8r9XkApld5sn
	GMYYvZOBWTF1y1zjKFa6W4BaozLGeCqocm6q07mi+AhcjZijXIu6NVx57Uh+PXNz6MuZU8c10ttZc
	+RoTTqJkw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpi2d-0007j1-FN; Mon, 29 Jun 2020 00:52:59 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpi2a-0007iU-Ao
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 00:52:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593391976; x=1624927976;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=8p/AWzdBhDohe13OXG6nCYcpDtv0GFKiA2RyAFw536U=;
 b=auN41T1YcPF+QsxXmBNPVGHM2bWwhwCOiR98jxLs9FHVbcLHHR9BDEVU
 YdiDaGWKkUbbM6aWYvvAISlD1FtnkgWhbE75M6J3+2d8udOgDmgsI6Z+6
 fl9Ew9lwfnN8gJ1Kjq+B4zD2ERkPq/C1qvVh8I6qU9CTUXwyiYA5Vg0u5
 C8qialEwlDHJybQR7vYEHjBO5/tsjcPyU1XII9Juatu3kE0a1gRnxV4BR
 u9U0mo6p/q93vBhKpBkK9xBjhR/4p6ODovHdXyFct/ArsdE7FGg7j99X+
 whXkerKPxr5QGdEOqnPyzBu1tcy+RWYiC+7tHd2yfgDDS0HEElFktHzL6 g==;
IronPort-SDR: bpz0PmIxdBRfOYpYf6hPYUr1XFXrguGqOeTojtFwNDp2TdfIREBSUAWiHqRTW+UG7mCwr2UgME
 sBwYwHFdZNOpOjfdlG9l2Tt0xQ/3UH27sn+nyS6FgoJjSvZz6+NN3esP9BrSV/i4XPRUIod9P+
 ajQ61IAqr/PSVPBaxH2V1e7fxdbyA4gvyjL92hSFNHVNF1QD5VsvWruYkJUwZbHuk0RuqecUUf
 CJSX59kb1ZBPhMN44dBwp4uYS1orOd1rX3zMDCCoPRmEgp4gAmWNOw9FnD2ZKidhlkqcaGhslD
 UXo=
X-IronPort-AV: E=Sophos;i="5.75,293,1589212800"; d="scan'208";a="141138083"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
 by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 08:52:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhsjuCMmcdknd3J7MW+V14p3RyjbMLknb3CtwpWqRBDzqBY4TVqLjqAzJr1NmjlCi+az9KjPAN+M52+ArfgD/+HYVQz4KlaGstHxb3vQId/LPuUTd2oV2/pIjwzeJbz7+7T9HP0tU5bRj08ugkMHLf9oKS2srn/tnRGEX0GVFotKO0R3pBt2QuSElnCAkHozNeb6dMrbMMjYiJ/8BUPzn6Qn2algCtzpsxPLQt+Z7zoeAN9T4oTFAeloon74IveEm0xLHPD6nWrbkm54zVfEDYNt7rIPPUR4MSjOGfiB1MoXjAPPb3dfKi3PnkcrW4XuJ7cWohDhtAgO93A0f1WRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eP4LRVkC7Ky36RmxTuw1XIN7TOZoqaS/uf+ppiLPrzk=;
 b=kiVbshqgwEU1gd3uV0MeNBWZtQ9e8TYV+iVZnwnUe1R9Kxf+0M95KgbM79PDBgeoIoo6PWI9qn3qag620Nw53oR+2C/Q8URp1aj7adiZI0bsnQRXYuSYJWO+LN+isUWiokKbo2cWkbQ9otuP98/0Fq8IR4DcR8D7XCuJusviGU9UIHuupTKtX51d020CJgT2tiYCjR6+FzcvtfeY1n2Au37ijFEUKyxEs/Eo4kYZmkY0heloexfslzrWf3a2v5xDD3cBqnjoLeBFI2YaN5YWlESbO4ZuFuszN5S8Mqsux1fGMbQwYhnXk8ODltG79f6I2eeOJmLK2M7iJtqPctV9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eP4LRVkC7Ky36RmxTuw1XIN7TOZoqaS/uf+ppiLPrzk=;
 b=IUrSYzk0M/Qgf+D/R9P3Yzo+3FmQGLBvFwR5nUC0hJw0H+pCEpx9Pa+5VMD/imC+iYweePCVWJP/rBWyvQq+x1k8S7Xsb/lm6petISTtDntt+VHtTX71ERBBlDfqO6Qdwq6p8Nvr9UJmi1SC9exj9BwlEJcPbnXJEEPWwpx8iqs=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1048.namprd04.prod.outlook.com (2603:10b6:910:54::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 00:52:46 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Mon, 29 Jun 2020
 00:52:46 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Matias Bjorling <Matias.Bjorling@wdc.com>, "axboe@kernel.dk"
 <axboe@kernel.dk>, "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de"
 <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>, Niklas Cassel
 <Niklas.Cassel@wdc.com>, Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCH 1/2] block: add zone_desc_ext_bytes to sysfs
Thread-Topic: [PATCH 1/2] block: add zone_desc_ext_bytes to sysfs
Thread-Index: AQHWTaAexT5EBQ0B+0awwAwr0pDYRw==
Date: Mon, 29 Jun 2020 00:52:46 +0000
Message-ID: <CY4PR04MB375197387D94CE4E60E836F4E76E0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200628230102.26990-1-matias.bjorling@wdc.com>
 <20200628230102.26990-2-matias.bjorling@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3037fa4-1b95-4f0d-eae4-08d81bc6bd20
x-ms-traffictypediagnostic: CY4PR04MB1048:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB104869B527FF299CA1C5E076E76E0@CY4PR04MB1048.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MLirVJeHxGCkk1ia/RwPoFvifukjV98e9WdHdLD5dhTG0Z+WEL920GTO+W9IlpxtNq1hCqe0oYFp3FYLWI0HP2jF2pujvJjWuE/CP+n/eQ/QruuICkUpjoLmbQCxiZC08D9JcslYPeIzuEUtYqM8dPcEVtUAmYQ27h50+Ito66XzV9UDYuSj8Fg3wQnIUSKl56azfshPHqVuOsTR81VVsV+BsRyRoLZHvajEMfU82kmKHzGJiqGJNBpoPMPldSIJYy8h4tEdB6neP6JtF2SjWF2iCbbjuHAI+fgfpqT5SBM7eyGfv0k+lrBwMYHt4FSencrCKiu3f+cd8LRXC46pbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(6636002)(4326008)(83380400001)(52536014)(478600001)(71200400001)(66574015)(64756008)(66446008)(316002)(8676002)(66476007)(76116006)(5660300002)(91956017)(66556008)(66946007)(55016002)(86362001)(33656002)(110136005)(54906003)(9686003)(26005)(2906002)(6506007)(53546011)(186003)(7696005)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ZPW8TQoi7MLaxAPuAfYYPr0ybRpM6qLXaD80wxVg7jot6zeVjGTGB+LAAqCsGmLSa0xGelKaI0uFoFEW3EFN2H2XWMQPdilra/46XtYIrM9vdDM7fytk/g2YtxYD+Au7R8zS6ExDEqprGYcV00UZ58yjsIpwuwwyRl0G16hSWzJ1OIk/dktCRFWD85dCFcKHALAOqzrogGfuSpmk/zA69YsG45TBiGOafq9prB7dvxP++4oBDQDwnkwH+2zKeOxiIQPWQG+chWpnt9+kW6RjcF5iOHJ1UJXvDaOTMlFkOFkp3P39S7a0pd2TO69SZYoiQ76SNxrhhHkpM97atGa5+ESseVCDUtUyPWi8pEXOR4ChKeAOWx3wR1Rb3FX8h/mBA531jIJQOBmXwpQBirF4jUwqg4QmS/u37FcDZwWWCMSYcX58fgK2NXcBChRQ8Uyd2+Ggzg1MQHKJeLK4lVgsr/u/GxIPL/axfk1K+DrLCqo=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3037fa4-1b95-4f0d-eae4-08d81bc6bd20
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 00:52:46.1821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1lsXYaJ2NWr62aPBv/0AG+UdE5ekLlbvlG8Wr7XZxE+2TYBhvvtofP97MeWQbQGKaag7U5fkSHXFDCDBiyZsAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1048
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/29 8:01, Matias Bjorling wrote:
> The NVMe Zoned Namespace Command Set adds support for associating
> data to a zone through the Zone Descriptor Extension feature.
> =

> The Zone Descriptor Extension size is fixed to a multiple of 64
> bytes. A value of zero communicates the feature is not available.
> A value larger than zero communites the feature is available, and
> the specified Zone Descriptor Extension size in bytes.
> =

> The Zone Descriptor Extension feature is only available in the
> NVMe Zoned Namespaces Command Set. Devices that supports ZAC/ZBC
> therefore reports this value as zero, where as the NVMe device
> driver reports the Zone Descriptor Extension size from the
> specific device.
> =

> Signed-off-by: Matias Bj=F8rling <matias.bjorling@wdc.com>
> ---
>  Documentation/block/queue-sysfs.rst |  6 ++++++
>  block/blk-sysfs.c                   | 15 ++++++++++++++-
>  drivers/nvme/host/zns.c             |  1 +
>  drivers/scsi/sd_zbc.c               |  1 +
>  include/linux/blkdev.h              | 22 ++++++++++++++++++++++
>  5 files changed, 44 insertions(+), 1 deletion(-)
> =

> diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/qu=
eue-sysfs.rst
> index f261a5c84170..c4fa195c87b4 100644
> --- a/Documentation/block/queue-sysfs.rst
> +++ b/Documentation/block/queue-sysfs.rst
> @@ -265,4 +265,10 @@ devices are described in the ZBC (Zoned Block Comman=
ds) and ZAC
>  do not support zone commands, they will be treated as regular block devi=
ces
>  and zoned will report "none".
>  =

> +zone_desc_ext_bytes (RO)
> +-------------------------
> +This indicates the zone description extension (ZDE) size, in bytes, of a=
 zoned
> +block device. A value of '0' means that zone description extension is not
> +supported.
> +
>  Jens Axboe <jens.axboe@oracle.com>, February 2009
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 624bb4d85fc7..0c99454823b7 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -315,6 +315,12 @@ static ssize_t queue_max_active_zones_show(struct re=
quest_queue *q, char *page)
>  	return queue_var_show(queue_max_active_zones(q), page);
>  }
>  =

> +static ssize_t queue_zone_desc_ext_bytes_show(struct request_queue *q,
> +		char *page)
> +{
> +	return queue_var_show(queue_zone_desc_ext_bytes(q), page);
> +}
> +
>  static ssize_t queue_nomerges_show(struct request_queue *q, char *page)
>  {
>  	return queue_var_show((blk_queue_nomerges(q) << 1) |
> @@ -687,6 +693,11 @@ static struct queue_sysfs_entry queue_max_active_zon=
es_entry =3D {
>  	.show =3D queue_max_active_zones_show,
>  };
>  =

> +static struct queue_sysfs_entry queue_zone_desc_ext_bytes_entry =3D {
> +	.attr =3D {.name =3D "zone_desc_ext_bytes", .mode =3D 0444 },
> +	.show =3D queue_zone_desc_ext_bytes_show,
> +};
> +
>  static struct queue_sysfs_entry queue_nomerges_entry =3D {
>  	.attr =3D {.name =3D "nomerges", .mode =3D 0644 },
>  	.show =3D queue_nomerges_show,
> @@ -787,6 +798,7 @@ static struct attribute *queue_attrs[] =3D {
>  	&queue_nr_zones_entry.attr,
>  	&queue_max_open_zones_entry.attr,
>  	&queue_max_active_zones_entry.attr,

Which tree is this patch based on ? Not I have seen any patch introducing m=
ax
active zones.

> +	&queue_zone_desc_ext_bytes_entry.attr,
>  	&queue_nomerges_entry.attr,
>  	&queue_rq_affinity_entry.attr,
>  	&queue_iostats_entry.attr,
> @@ -815,7 +827,8 @@ static umode_t queue_attr_visible(struct kobject *kob=
j, struct attribute *attr,
>  			return 0;
>  =

>  	if ((attr =3D=3D &queue_max_open_zones_entry.attr ||
> -	     attr =3D=3D &queue_max_active_zones_entry.attr) &&
> +	     attr =3D=3D &queue_max_active_zones_entry.attr ||
> +	     attr =3D=3D &queue_zone_desc_ext_bytes_entry.attr) &&
>  	    !blk_queue_is_zoned(q))
>  		return 0;
>  =

> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 502070763266..5792d953a8f3 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -84,6 +84,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct =
nvme_ns *ns,
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
>  	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
> +	blk_queue_zone_desc_ext_bytes(q, id->lbafe[lbaf].zdes << 6);
>  free_data:
>  	kfree(id);
>  	return status;
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> index d8b2c49d645b..a4b6d6cf5457 100644
> --- a/drivers/scsi/sd_zbc.c
> +++ b/drivers/scsi/sd_zbc.c
> @@ -722,6 +722,7 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigne=
d char *buf)
>  	else
>  		blk_queue_max_open_zones(q, sdkp->zones_max_open);
>  	blk_queue_max_active_zones(q, 0);
> +	blk_queue_zone_desc_ext_bytes(q, 0);
>  	nr_zones =3D round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks=
);
>  =

>  	/* READ16/WRITE16 is mandatory for ZBC disks */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 3776140f8f20..2ed55055f68d 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -522,6 +522,7 @@ struct request_queue {
>  	unsigned long		*seq_zones_wlock;
>  	unsigned int		max_open_zones;
>  	unsigned int		max_active_zones;
> +	unsigned int		zone_desc_ext_bytes;

Why is this not a queue limit ? This may need to be to be gracefully handle=
d by
device mapper for a target device using multiple zoned drives.

>  #endif /* CONFIG_BLK_DEV_ZONED */
>  =

>  	/*
> @@ -753,6 +754,18 @@ static inline unsigned int queue_max_active_zones(co=
nst struct request_queue *q)
>  {
>  	return q->max_active_zones;
>  }
> +
> +static inline void blk_queue_zone_desc_ext_bytes(struct request_queue *q,
> +		unsigned int zone_desc_ext_bytes)
> +{
> +	q->zone_desc_ext_bytes =3D zone_desc_ext_bytes;
> +}
> +
> +static inline unsigned int queue_zone_desc_ext_bytes(
> +		const struct request_queue *q)
> +{
> +	return q->zone_desc_ext_bytes;
> +}
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>  {
> @@ -784,6 +797,15 @@ static inline unsigned int queue_max_active_zones(co=
nst struct request_queue *q)
>  {
>  	return 0;
>  }
> +static inline void blk_queue_zone_desc_ext_bytes(struct request_queue *q,
> +		unsigned int zone_desc_ext_bytes)
> +{
> +}
> +static inline unsigned int queue_zone_desc_ext_bytes(
> +		const struct request_queue *q)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  =

>  static inline bool rq_is_sync(struct request *rq)
> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
