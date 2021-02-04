Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B5BC433E6
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 08:48:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8409764F4D
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 08:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8409764F4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gyIstFOCOtH7yH1O6q143ypWEaYfEULuVDGHDVpaoVg=; b=GPdvRxhXGRPpAAVqNgGFTFCGx
	o4WiGFohDAeeE2fv9RVOz+15tXu6suM7bRPk2lovj/VZ7jlC3IIt6olpLQ5WBywGG8JUEUpooPYGK
	w7IOOQoIy5CTRP+Z44hqNgZ4uNReoVDtS9Qdi6stFNabyvbUh9OJ6HOJd+4qmk78d/sbnGTMn7zn9
	j7nVv+jSkEU4zMMzrBvCyXIZcM/oR+R78o0oPwAW9fSPSP0Qd3+ssgAYp0kNnroYihu1mow3lfUxu
	HPuxcK6Jyb9P4SCkUCA8q6ljHgNbRwsi/moF03JN+Z/wTqntW+pJ4N6QT+T63VXtOK11dOG3gRe9g
	Czn7jbWCA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7aIx-00055x-ME; Thu, 04 Feb 2021 08:47:59 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7aIu-00055U-Ao
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 08:47:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612428476; x=1643964476;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=GLNFOvBvurWz3clG/6kugpYUDqIj4coVXGW89HvCqaI=;
 b=MK6Wbv3oBo5JX1QQs7iEngj3GmtcLDbRTqsJIH21cM5AAO5oMT1rpeZP
 aZhVo2amw/kC8PJ/LrhlYrxRgic4tySAn+5X3K7b54NWPqUNdZo2sJz1z
 yyHg1rbvHykELjzfFv/5CLUpoWGjWRujSOWY1jIGeEWZxg0cZXPPPbKED
 bOf46fwumsdH1wYoZ7wJ35D86oTeJRmSvi439H1nPa61hLQgkMy2hrpku
 zQc2z39M5lhZJsdG53WoEunXfWEsDXNCS2+va40IQ0Oe5JtORVhicZN7F
 Hh1VLBbjQDdAHIVmQS1xV4jbPGv0fP6flHyyinygfy0Zok+hYWHaVCJu4 Q==;
IronPort-SDR: tPou8lo8/34MR27+Gn94z4Vc2CEmO+eFE4BeNXWqm2Ma1Cok5uo0SJHgta2jMhSzdg5kSNEhyf
 Hhp7x9aOUhEkDF6uKeE4GqNHj5kM75+WafQhCd32sBWGzaglyeY3oW9Tk0a581U4PfGjEXZEIc
 1Ekiq8sWQf73CvQyf2/yTOpjnKijQRL2VTnJnTpZ8rlbsIi7/DBRTTtw83ch87xmCu9UJlMZ1z
 qnwtaApI8e02d9JkCU49HQBqDqrRbUN1B59UGE8yvvU9u5CAb39vHScpreBN3A/YKc8ybio4w7
 NHU=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; d="scan'208";a="159100734"
Received: from mail-sn1nam04lp2057.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.57])
 by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 16:47:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkqVmBsmd5I7MVukLt7PA9BeOGVwFqt1MRDQTCIPFMiRZmWOivJj1tPrtP2vSKVmHwgZBLf/qu+xaMjzhNKm/Px64FKV9g8G46OLuzPgXzXk8AvMgcEx+JDR1j1c79wPhdNC1tSbRWaga53wTd9M+fX87/qFvOT46+uQW6XG72aDFHQeOAWsLGkbRPYQO7OiGzCBRA/QZCh1Q2ba34TbCFLK7J+ggHb0y9LfqW3dHk9ms6weQX9LVUPhOZMXNxW9CM7g/W/m8MR9dNpmq/rqOW2hM2d7o3+dnNF/8nao20M5yK1Z//1BAGdLfjd2wFFNksSAWvrDqD0P49AGjMEE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU1ap/2Xjoqi9mxjiMaIZCj5QnKurDuIrScvs7VafhI=;
 b=WnD7O6pkTDbUCOcaTUhYlN2Yl6hCQUYjyjPd6D4bABi+ZsjG4uhCPUU3V9oryVCK6XVNk4XjGz95p4uDyC8KjIyPcaQyt0A69JK/J+coWV3OvUgQNBN6x0zjgq5U7//HJGwoZDurliwX3VBHj4uLYt2zPDXNWdfsavS989qCA2s9DgFfdFKUl13NFO0bl3BoDqmqhLY0w5RQKFNY3bteZaleGLCE7ltAf7iybZrNoPxfeVwh4g2OCfp+O7Jbt/Nw9/QdP5j8L6J+0u19K0A9xmIE5Ejm7/U+WB5xoFZal41uglphKltOmmTJNNM7pUP9Xj9a242cOdOHhQJg0O51Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU1ap/2Xjoqi9mxjiMaIZCj5QnKurDuIrScvs7VafhI=;
 b=egjYuRzpW95hQ9RRTeBrq8AC/ktlir+c36SmXGn6qknnZIu9UF0lmuGJiLf99DIEJIfjHbNE6VCjoNDF/yfzsO3ymmlk1t51rRZgnV6Cq/8nTQBqfDgd8bcNwChMAq8X3qVeRsCRZU4H+zlGGV8R3aMtLrETxohAGZaXpcU2RR4=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4740.namprd04.prod.outlook.com (2603:10b6:208:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Thu, 4 Feb
 2021 08:47:51 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 08:47:51 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
 <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/8] block: add zone write granularity limit
Thread-Topic: [PATCH v4 0/8] block: add zone write granularity limit
Thread-Index: AQHW9TEj5Ey4b7FkN0Gz3QH5CcuabQ==
Date: Thu, 4 Feb 2021 08:47:51 +0000
Message-ID: <BL0PR04MB65147501739ABF4F27B72290E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:61dd:3796:e34d:42c6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92ec8639-a4c8-42fe-74bb-08d8c8e98e74
x-ms-traffictypediagnostic: BL0PR04MB4740:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4740E17989F145A7C471425CE7B39@BL0PR04MB4740.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: olf0hj8r6ny7H4WEIZkNXogHSZvFhS/BqmE4Pa2B9gpiKY9BaLUEHrCVPqin//X2JdaTy0zn0MoLOhY/lUiYddgmLdwi4GafBrtgFYurb+3WZIc8QTcVh3SieptuJYRGgi6PMd64+/rqrxbgL5ukPlsGxNC5a7V/xPZ22lczXAJRCotWmmb55pZx2rcuooNwnFQ6qHkqMyOUY9I6yfmfck1wsgAtNvlnnLAq3qKoX2I51W8T6uf4I7tJ/VBO2/oJOgRR1oy4fr5l6+h/i9m0F0lIXD6xLfvLT7ka0Lh85CTq9/0o96aBnIQ3daKQZjJKXZ/nWyspIGMd0OBngc9qx4ULMx59U9Zu2l2JeH9EIj6A5YR3Yl/6WwDI3TWxM1df0h6Wfx9LsHpl2TQq+FbjZ+A471qDe+fZGfeLvkKy1hnROikEn1DTc+bWgcu0jTa524DiVj5BO/T6n/xHcdle6e5YEC4wWVaEINWWkyUo9EGvospj4LeRKn8iZAttJy2nM5gy7ww2LVoyJ/82wPzADw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(9686003)(91956017)(71200400001)(110136005)(478600001)(8676002)(54906003)(55016002)(66556008)(2906002)(316002)(66446008)(64756008)(66946007)(66476007)(76116006)(53546011)(52536014)(83380400001)(4326008)(33656002)(5660300002)(7696005)(86362001)(186003)(6506007)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tE6/3O+wNvKxuvg1IUR96b4Nm65akWtnnJgshcDikCD5BiO+vjzMM9quUln4?=
 =?us-ascii?Q?Va0ISZ/oxPdHQO7hCMIiv20+ArACTKA7PWfWMA5j+h/z1njpW10KH8x3fy0O?=
 =?us-ascii?Q?x7Ye8KMH04/I7DhFzw3lQGq4Dd0zMfFoWueyQa1Unc4C+Te2aiO7aAy2ahwJ?=
 =?us-ascii?Q?f/r6BZI7cVTBGD+PL9lfifCK2CX/+sOD63WqIg3lYX8/4zWlK7y2OHp1Fco2?=
 =?us-ascii?Q?/kKbyQyDZRUxifDrk0PZYUsDW27vmMLA7ojKpYx/BEjo45C/YiFYGjcHxS92?=
 =?us-ascii?Q?1sQZZdW9Yv4gc6flNL163VPiQ2sc8bfLJh+pcr8ibVrNNuhL/cP0gczDI3lX?=
 =?us-ascii?Q?JFgfJpLjjTbHGxorCE3lpK5Kk7UH+pjAdFpR1+hX3Vr4rp3mIrq04kLVloDg?=
 =?us-ascii?Q?e3kRQS7/Qk6opK8FAV/HpuLDQBC8A6h3245Jpua4qI7o8o6n5MPSAfJrKTrE?=
 =?us-ascii?Q?BqaFHS/XdRQcPS2/gasEi0Nu1U2UHeZO5ZIuBbTqKmOBqx+532kIZ+nbdWAh?=
 =?us-ascii?Q?ZYZTsaitHejTnt+UJi8UXURMiOZBTOThUS1lobQABYr+ERwuxxytG5OgGFDT?=
 =?us-ascii?Q?iKcppON3HIC76QXC9Qub1yHSGks+J5enwdnHGsa984Gw48W35p8As6yKEkgo?=
 =?us-ascii?Q?vsiqGFqLZlJhyjjl93f7lyQjN3TJtnJ1soxDlYzO66EY3Cz8G3uZ06x9o5C9?=
 =?us-ascii?Q?3kvCotDlvgPrLysXkJg5idtcjNGvFHbOUhz9VpRQ/Vn/7SFcHo0t5CNjfEE+?=
 =?us-ascii?Q?FENWzdeW/Aiik9Gfbxzs21VdOHDfHwIOSrhAkTJoC4Pz9gznzbUuPXBLUCEg?=
 =?us-ascii?Q?9uNCrIBJB/Bjyb3de3EBwjwnuUGYI2K4klKXeWzldpG2O4CqvqBeJSzKL8Pt?=
 =?us-ascii?Q?n9UZVFfnlriR/d+E92IoXWFADuga+1JQOJ6sIfnYswYkbOkY8pN/+XPptCS/?=
 =?us-ascii?Q?f2KRsz0JoSzPby1J7cjVFbn/ClJjo8O73k6/lwNKnv8xOSlc4NEqvPgpdD3U?=
 =?us-ascii?Q?eFXf0VoaPTqmkiR8qmbRzmywyMGeksdK/rAQSuUOEmbJeHFcoiwPjH3zSZ0R?=
 =?us-ascii?Q?VA5QhBnmZtBubKiZbgGkuyNJURRHwH9tcMfNEPT2StIiy3GrW9SoFbTbFPxo?=
 =?us-ascii?Q?hfyCSv46juqAljYlU28d+7Y8Je0sMcnpRXRc9tS7SbB+XSw5Vrt2Rcw2vbXL?=
 =?us-ascii?Q?MAdEUbRn6ejdTU0Eb31hycSzA8Bmc4cR1AlJWSZaLbI+dVF6xkO763KKg15d?=
 =?us-ascii?Q?wH3o9P5yxf+WPnt0PepIVF/29WXlEoTmFCRODxPONtpwsPSFArlQya8GqkXs?=
 =?us-ascii?Q?kb9VnjgEXyRrsiZHmqJWRAaGQZOYtXvCgbPVWq21viseFCnVHa+VkEuE+18l?=
 =?us-ascii?Q?nrq3Ho9ngEHbXG+8c55gkoGMOlgIERvIDzLKmTKxef4rVBNF3A=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ec8639-a4c8-42fe-74bb-08d8c8e98e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 08:47:51.4931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRNZNk5mnG6CVIDAA2i4KUE55hcYqFejXo84fdX/xpXPEruxBquKf3RcqJJreIZYZGJn0PFWgBa+cg211dlypQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4740
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_034756_606575_6E2E4B42 
X-CRM114-Status: GOOD (  20.70  )
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
Cc: Keith Busch <Keith.Busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/01/28 13:50, Damien Le Moal wrote:
> The first patch of this series adds missing documentation of the
> zone_append_max_bytes sysfs attribute.
> 
> The following 3 patches are cleanup and preparatory patches for the
> introduction of the zone write granularity limit. The goal of these
> patches is to have all code setting a device queue zoned model to use
> the helper function blk_queue_set_zoned(). The nvme driver, null_blk
> driver and the partition code are modified to do so.
> 
> The fourth patch in this series introduces the zone write granularity
> queue limit to indicate the alignment constraint for write operations
> into sequential zones of zoned block devices. This limit is always set
> by default to the device logical block size. The following patch
> documents this new limit.
> 
> The last 2 patches introduce the blk_queue_clear_zone_settings()
> function and modify the SCSI sd driver to clear the zone related queue
> limits and resources of a host-aware zoned disk that is changed to a
> regular disk due to the presence of partitions.

Hi Jens,

Any comment on this series ?

Martin,

The scsi bits (patch 5 and 8) may need your ack.

Thanks !

> 
> Changes from v3:
> * Added pathces 2, 3, 4, 7 and 8
> * Addressed Christoph's comments on patch 5
> 
> Changes from v2:
> * Added patch 3 for zonefs
> * Addressed Christoph's comments on patch 1 and added the limit
>   initialization for zoned nullblk
> 
> Changes from v1:
> * Fixed typo in patch 2
> 
> Damien Le Moal (8):
>   block: document zone_append_max_bytes attribute
>   nvme: cleanup zone information initialization
>   nullb: use blk_queue_set_zoned() to setup zoned devices
>   block: use blk_queue_set_zoned in add_partition()
>   block: introduce zone_write_granularity limit
>   zonefs: use zone write granularity as block size
>   block: introduce blk_queue_clear_zone_settings()
>   sd_zbc: clear zone resources for non-zoned case
> 
> Damien Le Moal (8):
>   block: document zone_append_max_bytes attribute
>   nvme: cleanup zone information initialization
>   nullb: use blk_queue_set_zoned() to setup zoned devices
>   block: use blk_queue_set_zoned in add_partition()
>   block: introduce zone_write_granularity limit
>   zonefs: use zone write granularity as block size
>   block: introduce blk_queue_clear_zone_settings()
>   sd_zbc: clear zone resources for non-zoned case
> 
>  Documentation/block/queue-sysfs.rst | 13 +++++++++
>  block/blk-settings.c                | 39 +++++++++++++++++++++++++-
>  block/blk-sysfs.c                   |  8 ++++++
>  block/blk-zoned.c                   | 17 ++++++++++++
>  block/blk.h                         |  2 ++
>  block/partitions/core.c             |  2 +-
>  drivers/block/null_blk/zoned.c      |  8 +++---
>  drivers/nvme/host/core.c            | 11 ++++----
>  drivers/nvme/host/zns.c             | 11 ++------
>  drivers/scsi/sd_zbc.c               | 43 ++++++++++++++++++++++++++---
>  fs/zonefs/super.c                   |  9 +++---
>  include/linux/blkdev.h              | 15 ++++++++++
>  12 files changed, 150 insertions(+), 28 deletions(-)
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
