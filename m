Return-Path: <SRS0=BHMv=AO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728EFC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 05:03:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30B8F20771
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 05:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rE7e6G2x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YHBHjqKC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oR4ZPZlz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B8F20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=x2umgj/RtgbcXF0XC20l+cihduexUbIbCnWmZ5zY0lk=; b=rE7e6G2xnZLprLXZwXqjeRl9u
	nDUXlLa8ERkAtDDC1hhEqpKEk0qZ6fPuDvNUUKoruTFUxhorhyXB4aJhNppjujFzygkpYMPHjTXrW
	PYy0YwP0tXgYeABV+3DLWy6koBH5zzdrpvflbUZvC/kfyVG5UmzQB5pva/opzlyUV5kpxXOLhOiLK
	w3FuaPnmZtgaed/PSYJebCzHFlNxk2veDwsdc3Yqdw2FvlOuuoPA0g86DUrrv2HnFL1KcaT9kHFYi
	fP27Ne5oBcEvSsLoCC7iHxALUf/YU34xVVlTeHG8tz82aS2wfezrOeCx1J/9qb2HI3BLVsa1LTnkk
	gTjFtKcYw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrDrE-0007BZ-RB; Fri, 03 Jul 2020 05:03:28 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrDrB-0007B1-NZ
 for linux-nvme@lists.infradead.org; Fri, 03 Jul 2020 05:03:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593752605; x=1625288605;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=N2UqwvJ9kfNsiNAmmtPTrLUptgCeWN9ZSiPEs5zOhco=;
 b=YHBHjqKC01idnPQlhlgE67V5/MCXmv2n1vLoJDb3MxyDLzOEoiEjaIjf
 /6Jb2bTVrGLHBE+osT+WIJ1SH0wbwpi3ijO5ZC4/Up7SrNEjkF3icU9Wg
 RtLN5ETpvT8U2L8UgbbiDPMcjFtH5j0i2LLI1xrtvACFNabQ6fAPyBotI
 HP4UxnGEv95KNkfWQ7DTIKDX/kQDNdCFUlahrMLyYZwN9CzisBbBMnzTh
 uovqZltMXIC9ZwnNAVgplXPXCAosYRxrQp3uK+fsZGLpzL0SQLpuTLTzq
 Ei9t2OuOCdWlgvX935mfabAB1HPh1NVFYqqN0y5KBVDU7g+qvhqxHPrw2 Q==;
IronPort-SDR: yqAvVeHv+oS31yR6vLmfZn2K2UDm/yn4mUCp4L59rPTLw4lZLs0jzbJRc0AXl+tfCadfDCnFzY
 QNTf3VMT7VJDFj4ZwBtjW5F69BtLFW1a8wwUy0zZFc0g6qKpn8wk1FHXBljI1PfsiQvdO0DwN7
 NZolq84tuE/P0amgByxtVeS6u+MK/WLB0VgllAwkNC93vx0ceQihR1YRGKNagLgOBJ7kS2nbeB
 DT+JiqxRyhBwd7rKrdwxldT7vMncxz+/YUJmVovD+sGw0CljL5mIS4BH6cjCe5vOpOS3yE7aEL
 R5U=
X-IronPort-AV: E=Sophos;i="5.75,307,1589212800"; d="scan'208";a="250783527"
Received: from mail-cys01nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.56])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 13:03:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5DEFWwIeDyqr+03LXZiXf1ootWg8x5Ph8s2x4BT7CzDKVICyTIQnSDG3sn60L9lJ5UNKO6ghAo7kEZ7MDcNRWnN8Ge21Mof9KYR6AwBc3vm01HJMUpADJLdsPvhIZu7dwiNjU6Kz/Gs0JdSAzbC3UD31SZZEXmZo7qVp8yS83Ja6wWlClVHQCv9KxK09jAEqHyiiTEeXk35419nPywuiSa2K01fzwBCLzPYtVswZyaf94o8RG53OCweM+aZnUjmhQOttxl/8xte0m/mMHtSS2I/thzwiiUWu49WM41P78AcRRmvTfXOYnypTutgSp3c0fgiYRnexNZXCPOe3W+/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ7j8yYIJeJ4Xa2J+3zZ+VoD+MCIz+nCmypaFJMT+wI=;
 b=ZxvDp7zjlmtkKMurs2Vx8u7wQSf/HUC3ZzzUzI7oQ7iKxbqSqRl361Z298x5ulm3k3vvWvtykYc8FVOhZMwbzBMjgANNpiQ0XYnwUFVAajH4VWYp8CnlDJZdYZeNCi8j8WWV+3GW2Vd6Fsmul15fuBZ/fEwE9WKRfb84wJVR0iEXG8qrdM+cmFNqSO3LDxsGVHnoja1sid+nXmXhq1SeOJVYOyZhVvXD6bXFVMRBA6mDPTyF8Y6bIMUFu1qTBAexUWn1LOY0KhTNnQbiGSi/tGxBK4cbv1M3X/CbIVEMLV9amuPDi/4wd3Ak3jqjtU2akWL1CMkj4jKN3jmnPbSaZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ7j8yYIJeJ4Xa2J+3zZ+VoD+MCIz+nCmypaFJMT+wI=;
 b=oR4ZPZlzwZyQqWTtQlzb6j4boCL6EHK7ezNfO41SxOd9xsFdmSnfaun7ODC6S1iazJs5EqXlTHf9bP2WeDjWG6GWQN2TasQWh/Qq0bMWhN4PgKumINYUZRGvRTrrzNOWvO9vXNIsAqeVAFQdey6zMBTPXyvdDcd2M2mOQ5GOR+M=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1256.namprd04.prod.outlook.com (2603:10b6:910:52::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 05:03:21 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Fri, 3 Jul 2020
 05:03:21 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>, Jonathan Corbet <corbet@lwn.net>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, "James E.J.
 Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 1/2] block: add max_open_zones to blk-sysfs
Thread-Topic: [PATCH v2 1/2] block: add max_open_zones to blk-sysfs
Thread-Index: AQHWUJ1lxUIFGXZs1EKrt/jHY/9h1g==
Date: Fri, 3 Jul 2020 05:03:21 +0000
Message-ID: <CY4PR04MB375175BB7359179C8256FA38E76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702181922.24190-1-niklas.cassel@wdc.com>
 <20200702181922.24190-2-niklas.cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab69b13f-3ea6-4f5b-0c40-08d81f0e687f
x-ms-traffictypediagnostic: CY4PR04MB1256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB12564E9149BC7917D3D5CD24E76A0@CY4PR04MB1256.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UpQG/twH4QY3BLHZB6sGARV/wSTHnx69RH6hkaa7bAvKyR88JY9h1Wvq1s6w62Pb4gNsZhqnr2C2Tn96IADdZJUqQfy580osYC6rSoaqnmXlLUAjk3WUc8wLQ3hcS8h7LZ9x6UN5MhFb+gw4A/XMjuBDzaPJVCCIp+ra+LEIvcpXqWbUoEg9MoUX63WUgN84kRQnDw1tbtySNmBF9ENv9Um5s3znoz4f0jIC9DA35L7QnDWqrDto43Xc+qsBXdUNsWTKYvvZRxh1WkNs2io8nUw9IBLskZYoxVLY3sFNX2FXi5rWwlIm7LCjEBIEO+whCpptn92pJEV31xvXpN/lmQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(66574015)(83380400001)(5660300002)(86362001)(2906002)(66946007)(8936002)(8676002)(66476007)(66556008)(64756008)(66446008)(76116006)(91956017)(478600001)(7696005)(186003)(26005)(6506007)(53546011)(54906003)(71200400001)(4326008)(110136005)(55016002)(52536014)(9686003)(33656002)(316002)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: dmd5riCP2ZxaPSXh5pzu07K2QUwayYN1wqZacimjIUmTp1RljbjYPlM+ybCHfOeiUyIvKKtWaLAvpHaRfRf5m0wcWHz3g6mElNIlNS/PRlH0CpEI0xRpHv1JzJfawHIGMQtNknh8dpE0HhcAw4Woatc2pwuXuvLb/HksdEBJwOfUYQtJCnwt23OnF/VH/bh2yYz5dMWqoGzcMeoXF7Igh1TpBfyYm/UltBA8/BKqZroJXCQNZwNrgCD6pnQCxVRNAbXUwht83oniLHMZBFaUxVfPAdRB0CDPwMi1qBV6KumqcxHLJ0c7vwdyl+L8EEbLtybGolKXobgMR/7peip7ZBLVVmMCn2S2ZX8nbgRm/WOZAy1n4vugZCHBr0m46ieYUw/JiQAvd3684Ib/1cRtmhU5Bt9vMFRxuzt3tlh6C9iPdJ7UcCrYGMdXe5HpU0erYVP8/G3pXLWhzo18RupgQw3wPNKh8NMSoq94OIM9YPRSCUNzru5SXRa745ReJ0y0
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab69b13f-3ea6-4f5b-0c40-08d81f0e687f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 05:03:21.4355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqW20NCoFTIFSiqZ6d+Fw1pbbzlzMmC5myenDtsJ+OTqOrHZ6PwBa1lO1qb8Te6pugafNrZAedpkUFoHlqpUqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1256
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200703_010325_979573_13ED392E 
X-CRM114-Status: GOOD (  22.91  )
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
Cc: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/07/03 3:20, Niklas Cassel wrote:
> Add a new max_open_zones definition in the sysfs documentation.
> This definition will be common for all devices utilizing the zoned block
> device support in the kernel.
> =

> Export max open zones according to this new definition for NVMe Zoned
> Namespace devices, ZAC ATA devices (which are treated as SCSI devices by
> the kernel), and ZBC SCSI devices.
> =

> Add the new max_open_zones member to struct request_queue, rather
> than as a queue limit, since this property cannot be split across stacking
> drivers.
> =

> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Reviewed-by: Javier Gonz=E1lez <javier@javigon.com>
> ---
>  Documentation/block/queue-sysfs.rst |  7 +++++++
>  block/blk-sysfs.c                   | 15 +++++++++++++++
>  drivers/nvme/host/zns.c             |  1 +
>  drivers/scsi/sd_zbc.c               |  4 ++++
>  include/linux/blkdev.h              | 16 ++++++++++++++++
>  5 files changed, 43 insertions(+)
> =

> diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/qu=
eue-sysfs.rst
> index 6a8513af9201..f01cf8530ae4 100644
> --- a/Documentation/block/queue-sysfs.rst
> +++ b/Documentation/block/queue-sysfs.rst
> @@ -117,6 +117,13 @@ Maximum number of elements in a DMA scatter/gather l=
ist with integrity
>  data that will be submitted by the block layer core to the associated
>  block driver.
>  =

> +max_open_zones (RO)
> +-------------------
> +For zoned block devices (zoned attribute indicating "host-managed" or
> +"host-aware"), the sum of zones belonging to any of the zone states:
> +EXPLICIT OPEN or IMPLICIT OPEN, is limited by this value.
> +If this value is 0, there is no limit.
> +
>  max_sectors_kb (RW)
>  -------------------
>  This is the maximum number of kilobytes that the block layer will allow
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 02643e149d5e..fa42961e9678 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -305,6 +305,11 @@ static ssize_t queue_nr_zones_show(struct request_qu=
eue *q, char *page)
>  	return queue_var_show(blk_queue_nr_zones(q), page);
>  }
>  =

> +static ssize_t queue_max_open_zones_show(struct request_queue *q, char *=
page)
> +{
> +	return queue_var_show(queue_max_open_zones(q), page);
> +}
> +
>  static ssize_t queue_nomerges_show(struct request_queue *q, char *page)
>  {
>  	return queue_var_show((blk_queue_nomerges(q) << 1) |
> @@ -667,6 +672,11 @@ static struct queue_sysfs_entry queue_nr_zones_entry=
 =3D {
>  	.show =3D queue_nr_zones_show,
>  };
>  =

> +static struct queue_sysfs_entry queue_max_open_zones_entry =3D {
> +	.attr =3D {.name =3D "max_open_zones", .mode =3D 0444 },
> +	.show =3D queue_max_open_zones_show,
> +};
> +
>  static struct queue_sysfs_entry queue_nomerges_entry =3D {
>  	.attr =3D {.name =3D "nomerges", .mode =3D 0644 },
>  	.show =3D queue_nomerges_show,
> @@ -765,6 +775,7 @@ static struct attribute *queue_attrs[] =3D {
>  	&queue_nonrot_entry.attr,
>  	&queue_zoned_entry.attr,
>  	&queue_nr_zones_entry.attr,
> +	&queue_max_open_zones_entry.attr,
>  	&queue_nomerges_entry.attr,
>  	&queue_rq_affinity_entry.attr,
>  	&queue_iostats_entry.attr,
> @@ -792,6 +803,10 @@ static umode_t queue_attr_visible(struct kobject *ko=
bj, struct attribute *attr,
>  		(!q->mq_ops || !q->mq_ops->timeout))
>  			return 0;
>  =

> +	if (attr =3D=3D &queue_max_open_zones_entry.attr &&
> +	    !blk_queue_is_zoned(q))
> +		return 0;
> +
>  	return attr->mode;
>  }
>  =

> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 04e5b991c00c..3d80b9cf6bfc 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -96,6 +96,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct =
nvme_ns *ns,
>  =

>  	q->limits.zoned =3D BLK_ZONED_HM;
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> +	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
>  free_data:
>  	kfree(id);
>  	return status;
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> index 183a20720da9..aa3564139b40 100644
> --- a/drivers/scsi/sd_zbc.c
> +++ b/drivers/scsi/sd_zbc.c
> @@ -717,6 +717,10 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsign=
ed char *buf)
>  	/* The drive satisfies the kernel restrictions: set it up */
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
> +	if (sdkp->zones_max_open =3D=3D U32_MAX)
> +		blk_queue_max_open_zones(q, 0);
> +	else
> +		blk_queue_max_open_zones(q, sdkp->zones_max_open);
>  	nr_zones =3D round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks=
);
>  =

>  	/* READ16/WRITE16 is mandatory for ZBC disks */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 8fd900998b4e..fe168abcfdda 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -520,6 +520,7 @@ struct request_queue {
>  	unsigned int		nr_zones;
>  	unsigned long		*conv_zones_bitmap;
>  	unsigned long		*seq_zones_wlock;
> +	unsigned int		max_open_zones;
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  =

>  	/*
> @@ -729,6 +730,17 @@ static inline bool blk_queue_zone_is_seq(struct requ=
est_queue *q,
>  		return true;
>  	return !test_bit(blk_queue_zone_no(q, sector), q->conv_zones_bitmap);
>  }
> +
> +static inline void blk_queue_max_open_zones(struct request_queue *q,
> +		unsigned int max_open_zones)
> +{
> +	q->max_open_zones =3D max_open_zones;
> +}
> +
> +static inline unsigned int queue_max_open_zones(const struct request_que=
ue *q)
> +{
> +	return q->max_open_zones;
> +}
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>  {
> @@ -744,6 +756,10 @@ static inline unsigned int blk_queue_zone_no(struct =
request_queue *q,
>  {
>  	return 0;
>  }
> +static inline unsigned int queue_max_open_zones(const struct request_que=
ue *q)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  =

>  static inline bool rq_is_sync(struct request *rq)
> =


Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
