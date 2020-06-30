Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86A8C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 01:49:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660092076C
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 01:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="njTQemaW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rk6czQo6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XjJQ3pDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660092076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=2j8FQVgbjgRprADnvrtbG1Y5bwPoMeAM54M3aWGISV8=; b=njTQemaWkIyNuR7BuSf18/TPG
	eGQDC1ekM1QyZORmxhddK0a7gMMI6aIC2XKKl+mQ/kWwq7bWxwe1SwzjGFji6EeVdeFjoNI5qT4eM
	+pSLQB0tn1JIibtI1o4FA0RHU08Nfpe3FeYfdhf0xF3XrgJkrHh24lVc/G0vWhI3DOz5Xq0geLv7F
	FcOLpSM2a1gi5ewNmdvLKOO7I83h/F5x+59SCDUf6VMvwqImx3Byz28gsN2Uie4Ffrp6jbj7FA4z/
	GavSCNDHF2/884EC5Q2tTwiig+I8qjQ9U5Adl7uacjw4mrS5+EvFs2bX0o+0WeueygNw+uW4eGWc1
	69IcDqPAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jq5PD-0005un-5E; Tue, 30 Jun 2020 01:49:51 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jq5P9-0005uW-Vw
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 01:49:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593481788; x=1625017788;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=uE5YdxXmVu/h414GPvQBfGDaWvp9WdIVHsEs+mleto8=;
 b=rk6czQo6J0FX/cVXBVdo24I6gO+ElV73y9NfrgA+vaI7P4o4Dh/5wkP0
 tF5CiQ3fg6zvdhi1Q+aN2VvU09pygXqEAPbqq+MToM2dxNXBE5PVhQ6qV
 WHaUNyX0EUdD8GdsWJvVBbnaPhj+Riw8Vs/BUY6VRty3IaML2KPd4eyPq
 GNt/do3WLIWLHocx59QvYsKmRWB0QcMvFYAocFf0eo21tewyu5wdtX3tr
 kY62PVfNxx7EvgSwPbD9dQVs4f6nr05j1AX5I07LV0/4DlVrZ25ughWvo
 KJsNawLy4IwBR2K8aFCnQJ49271cdctOYmTae830R66fHidwP9X2j/7Wj A==;
IronPort-SDR: o7ljCzyP6xVoUMb2jdfev5wlbOexYyRtiK+jD4Y7iRfwfT0b4mXJnEj1kJfpcTwd/RCDyMKJ2s
 77k7oZ9qkPwVCBNu4EKMO9X6VcG2tz85B5SQdPD3Wp/PsNRGfV/vO9zZrV/pxxcOaRnJs4+alA
 mx+xfSQ64hDi+m37u7UtGxtwahICUR925Tr4x15fumCAHzaVOa1dgWQedGo8LPbdU01P3H3pSN
 qy38F+B54zH24Zximth8WGaCd0O1YGXXG18UO2rrPOMnDfEH4z9f9gj7QwBXNvklQhQ7ievUjQ
 PNQ=
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; d="scan'208";a="142588538"
Received: from mail-cys01nam02lp2058.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.58])
 by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 09:49:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGL+lL64tG5UR393vdMOUB85KjdsdNgn2oVZa1ivgleZJQ1u2IRVu6PDNaeevWccvpZVPtqXf6T0nzsCBYfYkSYSXdE1QOLAWPukoaW/BjitNjdk4iGGNyAj6VONEgg9YR9t7UktRDfn2n6AFsjYAeEZeiGLgDuAY2aAMrnfaiAOwRA+JLsKTIWNuXg23s2dnOqGgQVpRMRwCq+U6LlUUDDIWpYCPa5Be0h0nkLd92P67HNgSJeMYAE0tMHF/kScEngcxHKBM0EAncubusqVpylNsvhMMR/V2X08Wp6ziKntWMxnG5GKYROE9ZPpest8/LQQcnVi2YkHdtu7s/HaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI/9WSzNIoj8q80Hg/Zi9Tg1oU8/R4r+rp5oMbuCmRY=;
 b=WF1fuvITR8qly8m7Lb4cmsv9wJdBKEbouTKqXhHqC31900JxplokRbzsob8vI0GqfzYVNuVPfc1p/vJ5pSgqZ82/zY5FvBpDU/jgUu+ZOHXBLT49tN7WoFQAGxsQk6iDsSPtpOKELyhjHwN9Ei8iCckyPdUoXP/YpJCaHFDD9EcmdSXK8QRSQ6xNZyz6Mw0+lzG5iX7yq8YSPQaWuelRu2gByJua1TRw+2Ms4VJ9UaKRH17Oz6zWUCrJjZa/gnMCUbCED1FYfX5IxTY/XMujq5m2VJLQMUHaFp2MIueMdIwk9mkt1Fe5GQvZJbtTBar+KjSfk9nH8EpA7VveMdG4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI/9WSzNIoj8q80Hg/Zi9Tg1oU8/R4r+rp5oMbuCmRY=;
 b=XjJQ3pDMV38pmW/M6/ylYsffQkCgaG5lU46zqWzAO9WaItW36c8RSdJiQTB00OWp0xB/V2q8MQvxZD5UzHXd0xa31g4ITFohNiNnxxz6VEYwFlFUBoaDEovfeDusZMBeAZDxpQ6/DsVSfiQxOjNJUGrBEQ7wiitqLYOT7ppXFWc=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1048.namprd04.prod.outlook.com (2603:10b6:910:54::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Tue, 30 Jun
 2020 01:49:42 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Tue, 30 Jun 2020
 01:49:41 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>, Jonathan Corbet <corbet@lwn.net>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, "James E.J.
 Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/2] block: add max_open_zones to blk-sysfs
Thread-Topic: [PATCH 1/2] block: add max_open_zones to blk-sysfs
Thread-Index: AQHWQ8jtlLWiiEumE0+QMSt8tXUnYw==
Date: Tue, 30 Jun 2020 01:49:41 +0000
Message-ID: <CY4PR04MB3751C2C03ACCA263541DA348E76F0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200616102546.491961-1-niklas.cassel@wdc.com>
 <20200616102546.491961-2-niklas.cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d29a0415-47c3-4431-177b-08d81c97db6b
x-ms-traffictypediagnostic: CY4PR04MB1048:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1048D483E83E21C12C890CAEE76F0@CY4PR04MB1048.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xuu+bN/3I+dwDuVB8wvNubH+6aOgOLh2EkMzWjutZuFPgH3bkMQrqBVP88TaMMuKe2hbeyGhto3RBGc2IXQFwOzluWIoo1f6t9s/M8PjM9O1jgjNAwGkdBMyjrMPHdIK95ZTAAYWhiadZe8SBQ95JL47maNP5+tFZ4QyU46VpfgUpLtFuzJiR3zIhNwK+ge/9DeLYWd6d6D/yq6GT+7YwkgINwkLMRAA14TljIQT74L8tkQKhuHZwD8Jo84RdGBiA47tqt5EAuQJf/luCwWRqswS4zyWZhM5i5kAbH1IvXehrFMyghLp00UbFc1yAkQr9wk2pXZC2x/p/DwPIdu93Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(52536014)(54906003)(86362001)(9686003)(8676002)(33656002)(55016002)(7416002)(8936002)(71200400001)(5660300002)(7696005)(4326008)(110136005)(66556008)(64756008)(66446008)(66476007)(186003)(66946007)(26005)(91956017)(498600001)(2906002)(6506007)(53546011)(83380400001)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Ys0ErRnaLlc9rjB+txW0PD8N5jpXstxphhZOe+x6+2G/3RstLG+g8iB+SYSutC0byIb8j/GpyuAh86zohPNdREl8nCxrUDE8CDCSPDmx78Soo+JxyTAV1exxxoqTrre3bRyvGZ6hIw8VZqThsg0yhgaF1RpHKC3vMMr//EJVK8CnnrMb0PvSRhzLHuzZN9toAB6Igi2sfejCXDpZz8mJkhorC1VPvoxiljh4iuk2+VLjeZMiMEepRMb18JuDqhyFdryPJP+iYJdGC+83cQcFq3b14mTDUbvTw3vGdvbgPcMkdltrcXoc6GmzDesOvLjJqAUmRVtLv3DY8Ya68KIkcpufZsrFhzeijZzJ2s6mjC2wX7BhycxUbd2PKTImsYTcnPihY+U3pT82hRX4IFawOp3fIbi3PaOEyQfK7n28B8aqRtr1Qpo13rqyBZmJo34uFqHt4YghVOLl+3MqrzfFscYnpP3d/c8bgLUGfksZ9WQ=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29a0415-47c3-4431-177b-08d81c97db6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 01:49:41.8413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RVwJH6JEMcY3ZozY6C8oevQ73FzHw4/vmfkgAYJL+M7IzfcO+Izz168RvUw8MMxOAGszP6AKq0E3hp/DDjVvmw==
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
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/16 19:28, Niklas Cassel wrote:
> Add a new max_open_zones definition in the sysfs documentation.
> This definition will be common for all devices utilizing the zoned block
> device support in the kernel.
> 
> Export max open zones according to this new definition for NVMe Zoned
> Namespace devices, ZAC ATA devices (which are treated as SCSI devices by
> the kernel), and ZBC SCSI devices.
> 
> Add the new max_open_zones struct member to the request_queue, rather

Add the new max_open_zones member to struct request_queue...

> than as a queue limit, since this property cannot be split across stacking
> drivers.

But device-mapper target device have a request queue too and it looks like your
patch is not setting any value, using the default 0 for dm-linear and dm-flakey.
Attaching the new attribute directly to the request queue rather than adding it
as part of the queue limits seems odd. Even if DM case is left unsupported
(using the default 0 = no limit), it may be cleaner to add the field as part of
the limit struct.

Adding the field as a device attribute rather than a queue limit, similarly to
the device maximum queue depth would be another option. In such case, including
the field directly as part of the request queue makes more sense.

> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  Documentation/block/queue-sysfs.rst |  7 +++++++
>  block/blk-sysfs.c                   | 15 +++++++++++++++
>  drivers/nvme/host/zns.c             |  1 +
>  drivers/scsi/sd_zbc.c               |  4 ++++
>  include/linux/blkdev.h              | 20 ++++++++++++++++++++
>  5 files changed, 47 insertions(+)
> 
> diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
> index 6a8513af9201..f01cf8530ae4 100644
> --- a/Documentation/block/queue-sysfs.rst
> +++ b/Documentation/block/queue-sysfs.rst
> @@ -117,6 +117,13 @@ Maximum number of elements in a DMA scatter/gather list with integrity
>  data that will be submitted by the block layer core to the associated
>  block driver.
>  
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
> @@ -305,6 +305,11 @@ static ssize_t queue_nr_zones_show(struct request_queue *q, char *page)
>  	return queue_var_show(blk_queue_nr_zones(q), page);
>  }
>  
> +static ssize_t queue_max_open_zones_show(struct request_queue *q, char *page)
> +{
> +	return queue_var_show(queue_max_open_zones(q), page);
> +}
> +
>  static ssize_t queue_nomerges_show(struct request_queue *q, char *page)
>  {
>  	return queue_var_show((blk_queue_nomerges(q) << 1) |
> @@ -667,6 +672,11 @@ static struct queue_sysfs_entry queue_nr_zones_entry = {
>  	.show = queue_nr_zones_show,
>  };
>  
> +static struct queue_sysfs_entry queue_max_open_zones_entry = {
> +	.attr = {.name = "max_open_zones", .mode = 0444 },
> +	.show = queue_max_open_zones_show,
> +};
> +
>  static struct queue_sysfs_entry queue_nomerges_entry = {
>  	.attr = {.name = "nomerges", .mode = 0644 },
>  	.show = queue_nomerges_show,
> @@ -765,6 +775,7 @@ static struct attribute *queue_attrs[] = {
>  	&queue_nonrot_entry.attr,
>  	&queue_zoned_entry.attr,
>  	&queue_nr_zones_entry.attr,
> +	&queue_max_open_zones_entry.attr,
>  	&queue_nomerges_entry.attr,
>  	&queue_rq_affinity_entry.attr,
>  	&queue_iostats_entry.attr,
> @@ -792,6 +803,10 @@ static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
>  		(!q->mq_ops || !q->mq_ops->timeout))
>  			return 0;
>  
> +	if (attr == &queue_max_open_zones_entry.attr &&
> +	    !blk_queue_is_zoned(q))
> +		return 0;
> +
>  	return attr->mode;
>  }
>  
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index c08f6281b614..af156529f3b6 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -82,6 +82,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
>  
>  	q->limits.zoned = BLK_ZONED_HM;
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> +	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
>  free_data:
>  	kfree(id);
>  	return status;
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> index 183a20720da9..aa3564139b40 100644
> --- a/drivers/scsi/sd_zbc.c
> +++ b/drivers/scsi/sd_zbc.c
> @@ -717,6 +717,10 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
>  	/* The drive satisfies the kernel restrictions: set it up */
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
> +	if (sdkp->zones_max_open == U32_MAX)
> +		blk_queue_max_open_zones(q, 0);
> +	else
> +		blk_queue_max_open_zones(q, sdkp->zones_max_open);

This is correct only for host-managed drives. Host-aware models define the
"OPTIMAL NUMBER OF OPEN SEQUENTIAL WRITE PREFERRED ZONES" instead of a maximum
number of open sequential write required zones.

Since the standard does not actually explicitly define what the value of the
maximum number of open sequential write required zones should be for a
host-aware drive, I would suggest to always have the max_open_zones value set to
0 for host-aware disks.

>  	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
>  
>  	/* READ16/WRITE16 is mandatory for ZBC disks */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 8fd900998b4e..2f332f00501d 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -520,6 +520,7 @@ struct request_queue {
>  	unsigned int		nr_zones;
>  	unsigned long		*conv_zones_bitmap;
>  	unsigned long		*seq_zones_wlock;
> +	unsigned int		max_open_zones;
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  
>  	/*
> @@ -729,6 +730,17 @@ static inline bool blk_queue_zone_is_seq(struct request_queue *q,
>  		return true;
>  	return !test_bit(blk_queue_zone_no(q, sector), q->conv_zones_bitmap);
>  }
> +
> +static inline void blk_queue_max_open_zones(struct request_queue *q,
> +		unsigned int max_open_zones)
> +{
> +	q->max_open_zones = max_open_zones;
> +}
> +
> +static inline unsigned int queue_max_open_zones(const struct request_queue *q)
> +{
> +	return q->max_open_zones;
> +}
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>  {
> @@ -744,6 +756,14 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>  {
>  	return 0;
>  }
> +static inline void blk_queue_max_open_zones(struct request_queue *q,
> +		unsigned int max_open_zones)
> +{
> +}

Why is this one necessary ? For the !CONFIG_BLK_DEV_ZONED case, no driver should
ever call this function.

> +static inline unsigned int queue_max_open_zones(const struct request_queue *q)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  
>  static inline bool rq_is_sync(struct request *rq)
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
