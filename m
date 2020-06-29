Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74097C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 01:00:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3777020672
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 01:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WlpMFtjz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AiqbJ90c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bvk5J1h7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3777020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=tgE8YsZgftrCq5mwDtDpf2GndRmMDpwgIq3KATYjQc4=; b=WlpMFtjz/KMqKbCKqgDOsoWqc
	H5yn19t9Kuz+JZE3qrHP0OW1COGM2haoD648KxheAP/JpTJPnmFV0sOZTYejFpu2jbJk8Sr/nGJKi
	4461oRnmxOGxlkuxZUSZ+CQJefJAWZWDWXI0bjthqyOMAu1imSs9lllyZGKP+l46xIL5fRAfIe7Hv
	6udtYtZ7v8dYAdSK8102SRpyJczZzIF3pnxxehF1e/vMW7CkyUkA0C48dem7Jm9DL6K11+698mIO5
	vnRf75/qIUWBiJ1jTb2bBMP6qjy16UxprWhCA3jUifJVNAAFwR3zADtJWPMTjooeAoY0SPChWdkQw
	nwJgkLCig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpi9h-00084F-8Z; Mon, 29 Jun 2020 01:00:17 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpi9d-00083g-U7
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 01:00:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593392419; x=1624928419;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=JTCrS8CjlptUiymm+4AUF8QbZQI4Ws++ALILMjufE94=;
 b=AiqbJ90cylBJSeVDPj8x45Li/Y1g46MSb+8zgs23J2bdu1EyeV3R9Yrh
 LcjoW56BdUASxyMBikpEsNprVDvt9m9iG2auRCg/ZoCrdDrD1m5cKNDl/
 NbQ6cWbUzQ2DDRHQeW85XlHNKBanVKVYu1PA8FKcGmmAc8/tW4RHVzqYs
 +sQSCvLl4P6FdN3H0m5BzkyA9lKS7VD7cKCQ25CH8r1ZqA7A6Ul2nBu7B
 03UUCsdxn+F3byC2OyZC5I5MD3DUetw3Wb5qc8HFFfRgksJ0XGgH/OVSC
 yWF3xZS6LguHQk4AEFRBgZon+7HdX52xIx+RgEQXBpENmZDNK3lhN1hsE A==;
IronPort-SDR: 1qZJpHUlEjxcriXvOY+DSqB6Az+d0uG0AQU1GIOX84pNrJTwSRmcYGG7wODFFaHsExORRYWbaR
 e6U2RTLRk+UHW6AWsS+7Q+WCCLgucwzXbr0gNfEI7fdaTiVW5UUNhWPu1n7nPffW/1RUkQWeGM
 x3w3S7GHb7DCtlu+cEEf+TOnvVvdcJTGiZijWV2+8+TniroEQSkUcf9EJpiJR8G0crApVv8U20
 QVocY7lpbsQhsmM0q0LiB6Pp8Rug1jwx1ZnsLhs0dUWX3XnlHFiQCOx/CIa7fg1c0OzDRapFk0
 3uM=
X-IronPort-AV: E=Sophos;i="5.75,293,1589212800"; d="scan'208";a="244157395"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
 by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 09:00:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hc01Bl338ZyN344WuIf6Py8f+3CpYJbGI044+P0B3Yk17QB+CbMbG159vxDAvZ90AX+vS1xrbWNytsAQ91banAJXYKf0jC+LFIVPHAESvWjuWY6xK8MHMOcOxxJ+Sd765qM5uur/nibtQPg+meTFW5sWMVSzfXZBJEqXQDVeuGqzYiH+jOqXIFUhP7zsOerLx3euFG7NCez4hcF4MFSXbpKn0mwEJLnmFmAPQtuMoUfnw2Ud4MJM1Ss4ylG+MZG7RVCmPSQVCKaz3M4RQGe1tZtv2ZQ7ri48YbopR1WWsllG3vuoDqQ+wD4D69bU9LpDkhK3Ac+dKd5cAWibVhArYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/4qOEEcze1gvpUQp6NdbGgP0HT2EspkzrJ4MPYV7gY=;
 b=MtqhMyR5Gv0igqhzUq6ijRzq3mTphjwBu+oGQ5mmp8gzJ5b9luqnWSRAt7PtI4dmIlQG3XR5iCOEiTu+aykq/huNHaUrMjwohV8m+Kwns0Dr5oYcwe7yMH/rv2XooPnX1ZpIuvJqZbXKeYT5pFWXkePx53lrL/+1O2eb/iQDdrFRa4h4o8t/NGEd291uClJ8YoHZtyW25/co+Se05PlGyybLMQrHlnW3YuoA/+9k/ykDigwXIffntLzOzctS4pAMq7nSrA9zU9g4iyi8zvzjQ3Ro+OwWuy1NdSAcReKnxZ4HLHQbwxU84D9wvmswpgCxq0lsut6QtEH+BLsidlX/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/4qOEEcze1gvpUQp6NdbGgP0HT2EspkzrJ4MPYV7gY=;
 b=bvk5J1h7a1KAp7wneAd/efjAj7zP27pLDeP9fkyob1wpgcD0oczDtO2uULFahpuL4RfIgi+BbXLZQgObA5gwrpdsmSRtd4QMxRG8UcCMkxQvQ5RkTX89m7ut6k2LPO7qCnYInn0fRcfDm17ngrW7GPViQ2N/fw/unDTwCQtRKaM=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0374.namprd04.prod.outlook.com (2603:10b6:903:bb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Mon, 29 Jun
 2020 01:00:06 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Mon, 29 Jun 2020
 01:00:05 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Matias Bjorling <Matias.Bjorling@wdc.com>, "axboe@kernel.dk"
 <axboe@kernel.dk>, "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de"
 <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>, Niklas Cassel
 <Niklas.Cassel@wdc.com>, Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCH 2/2] block: add BLKSETDESCZONE ioctl for Zoned Block
 Devices
Thread-Topic: [PATCH 2/2] block: add BLKSETDESCZONE ioctl for Zoned Block
 Devices
Thread-Index: AQHWTaAf9fLinKVA0kyZGzXPFf2RKQ==
Date: Mon, 29 Jun 2020 01:00:05 +0000
Message-ID: <CY4PR04MB37518908765B458987C57702E76E0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200628230102.26990-1-matias.bjorling@wdc.com>
 <20200628230102.26990-3-matias.bjorling@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d2d17e8-87f6-4e8a-e26d-08d81bc7c301
x-ms-traffictypediagnostic: CY4PR04MB0374:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0374C274B0B5E3652ECAD167E76E0@CY4PR04MB0374.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jl3dPh7wiMTPd6yCtTzvbxBVMnJ+izPr5I/g+2/VEkC9GDSPeXLJZOA9R99zxUEw+I2dPDnxMNDilpWhxcU6tqJ5X51pddiFDAVbBKGo0RTmP9kj1BglTTo7GslCatlDjCDFivcd0aXdxkU7zUWhv5lBxSmul3n4csnJC8RFS7mvo2rvqVip2svv2ii1EsE+H28s2vpNKcMPsglGhiI0sIpoWoOI30TloT3+mlqcaT+TtcuOs4fnojLo7+DnjdJaYxgITKVWfOZCZeYojbkydlvkuvj6SfirzWzqTL7eWVeY7fAPkql3z8UyFobKxeR83MWb15PNjAcuAfVr40kpKQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(30864003)(86362001)(5660300002)(7696005)(6636002)(8936002)(186003)(498600001)(54906003)(110136005)(4326008)(26005)(71200400001)(33656002)(52536014)(83380400001)(9686003)(91956017)(55016002)(6506007)(2906002)(66476007)(64756008)(53546011)(66446008)(76116006)(66946007)(66556008)(8676002)(66574015);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: arY97rY0Yi4veUSXTAaXprSn36Gc+DQD1p/2Zct7zwR7svKowQ1MQg3tIc1u4W92z/SgXNycIfQTgtwlfSKathgs56h8xqaZkNRSvTWBw9wWrE39R/lR60KpAcG0ScR7YthRiL4aSUEOY+gZwtP0M9HcHoDspDr0vnUhFKlv8Mmrt3GMOPInqGYv6mqBeoI4k2UnT8JUTcIXWaZeigPYCNz+AbjwxBPzd7d5e2tGmS2rDKNv8D4S8622MbY01PtTJ3aO/mpahJej7PqjfZ0O5aVAqeg+trmWtsgDyJslvxd1wHciW9D67D801hMN1qmz50ZZreO1EY26O+ENdg4RTZMo7aybgZ8574jUK9qFqiXyZHRkUdFI8vvtS38Pk0C7J3OSQU+cwAtBpTr1u69GEImgGJWJqqt8PcFBcuHnV7VId8tHwgVPJsrWm2ib9cwbSwIdmlAnwrAwX6oQSoEOSPpk13qLKiJXsfTKfn+zHYo=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2d17e8-87f6-4e8a-e26d-08d81bc7c301
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 01:00:05.5498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/ZkRp6fqsh/7F33iuVdovIyU7+FJMbt7OPDQ7LVb5yEAMo8VB5dffWlYKk46XinVCCQTxYSNnyEGY/vmX7Vkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0374
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

> To allow user-space to associate data to a zone, add support through
> the BLKSETDESCZONE ioctl. The ioctl requires that it is issued to
> a zoned block device, and that it supports the Zone Descriptor
> Extension feature. Support is detected through the
> the zone_desc_ext_bytes sysfs queue entry for the specific block
> device. A value larger than zero communicates that the device supports
> the feature.
> =

> The ioctl associates data to a zone by issuing a Zone Management Send
> command with the Zone Send Action set as the Set Zone Descriptor
> Extension.
> =

> For the command to complete successfully, the specified zone must be
> in the Empty state, and active resources must be available. On
> success, the specified zone is transioned to Closed state by the
> device. If less data is supplied by user-space then reported by the
> the Zone Descriptor Extension size, the rest is zero-filled. If more
> data or no data is supplied by user-space, the ioctl fails.
> =

> To issue the ioctl, a new blk_zone_set_desc data structure is defined.
> It has following parameters:
> =

>  * the sector of the specific zone.
>  * the length of the data to be associated to the zone.
>  * any flags be used by the ioctl. None is defined.
>  * data associated to the zone.
> =

> The data is laid out after the flags parameter, and it is the caller's
> responsibility to allocate memory for the data that is specified in the
> length parameter.
> =

> Signed-off-by: Matias Bj=F8rling <matias.bjorling@wdc.com>
> ---
>  block/blk-zoned.c             | 108 ++++++++++++++++++++++++++++++++++
>  block/ioctl.c                 |   2 +
>  drivers/nvme/host/core.c      |   3 +
>  drivers/nvme/host/nvme.h      |   9 +++
>  drivers/nvme/host/zns.c       |  11 ++++
>  include/linux/blk_types.h     |   2 +
>  include/linux/blkdev.h        |   9 ++-
>  include/uapi/linux/blkzoned.h |  20 ++++++-
>  8 files changed, 162 insertions(+), 2 deletions(-)
> =

> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 81152a260354..4dc40ec006a2 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -259,6 +259,50 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum=
 req_opf op,
>  }
>  EXPORT_SYMBOL_GPL(blkdev_zone_mgmt);
>  =

> +/**
> + * blkdev_zone_set_desc - Execute a zone management set zone descriptor
> + *                        extension operation on a zone
> + * @bdev:	Target block device
> + * @sector:	Start sector of the zone to operate on
> + * @data:	Pointer to the data that is to be associated to the zone
> + * @gfp_mask:	Memory allocation flags (for bio_alloc)
> + *
> + * Description:
> + *    Associate zone descriptor extension data to a specified zone.
> + *    The block device must support zone descriptor extensions.
> + *    i.e., by exposing a positive zone descriptor extension size.
> + */
> +int blkdev_zone_set_desc(struct block_device *bdev, sector_t sector,
> +			 struct page *data, gfp_t gfp_mask)

struct page for the data ? Why not just a "void *" to allow for kmalloc/vma=
lloc
data ? And no length for the data ? This is a bit odd.

> +{
> +	struct request_queue *q =3D bdev_get_queue(bdev);
> +	sector_t zone_sectors =3D blk_queue_zone_sectors(q);
> +	struct bio_vec bio_vec;
> +	struct bio bio;
> +
> +	if (!blk_queue_is_zoned(q))
> +		return -EOPNOTSUPP;
> +
> +	if (bdev_read_only(bdev))
> +		return -EPERM;

You are not checking the zone_desc_ext_bytes limit here. You should.
> +
> +	/* Check alignment (handle eventual smaller last zone) */
> +	if (sector & (zone_sectors - 1))
> +		return -EINVAL;

The comment is incorrect. There is nothing special for handling the last zo=
ne in
this test.

> +
> +	bio_init(&bio, &bio_vec, 1);
> +	bio.bi_opf =3D REQ_OP_ZONE_SET_DESC | REQ_SYNC;
> +	bio.bi_iter.bi_sector =3D sector;
> +	bio_set_dev(&bio, bdev);
> +	bio_add_page(&bio, data, queue_zone_desc_ext_bytes(q), 0);
> +
> +	/* This may take a while, so be nice to others */
> +	cond_resched();

This is not a loop, so you do not need this.

> +
> +	return submit_bio_wait(&bio);
> +}
> +EXPORT_SYMBOL_GPL(blkdev_zone_set_desc);
> +
>  struct zone_report_args {
>  	struct blk_zone __user *zones;
>  };
> @@ -370,6 +414,70 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev=
, fmode_t mode,
>  				GFP_KERNEL);
>  }
>  =

> +/*
> + * BLKSETDESCZONE ioctl processing.
> + * Called from blkdev_ioctl.
> + */
> +int blkdev_zone_set_desc_ioctl(struct block_device *bdev, fmode_t mode,
> +			       unsigned int cmd, unsigned long arg)
> +{
> +	void __user *argp =3D (void __user *)arg;
> +	struct request_queue *q;
> +	struct blk_zone_set_desc zsd;
> +	void *zsd_data;
> +	int ret;
> +
> +	if (!argp)
> +		return -EINVAL;
> +
> +	q =3D bdev_get_queue(bdev);
> +	if (!q)
> +		return -ENXIO;
> +
> +	if (!blk_queue_is_zoned(q))
> +		return -ENOTTY;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EACCES;
> +
> +	if (!(mode & FMODE_WRITE))
> +		return -EBADF;
> +
> +	if (!queue_zone_desc_ext_bytes(q))
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&zsd, argp, sizeof(struct blk_zone_set_desc)))
> +		return -EFAULT;
> +
> +	/* no flags is currently supported */
> +	if (zsd.flags)
> +		return -ENOTTY;
> +
> +	if (!zsd.len || zsd.len > queue_zone_desc_ext_bytes(q))
> +		return -ENOTTY;

This should go into blkdev_zone_set_desc() as well so that in-kernel users =
are
checked. So there may be no need to check this here.

> +
> +	/* allocate the size of the zone descriptor extension and fill
> +	 * with the data in the user data buffer. If the data size is less
> +	 * than the zone descriptor extension size, then the rest of the
> +	 * zone description extension data buffer is zero-filled.
> +	 */
> +	zsd_data =3D (void *) get_zeroed_page(GFP_KERNEL);
> +	if (!zsd_data)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(zsd_data, argp + sizeof(struct blk_zone_set_desc),
> +			   zsd.len)) {
> +		ret =3D -EFAULT;
> +		goto free;
> +	}
> +
> +	ret =3D blkdev_zone_set_desc(bdev, zsd.sector, virt_to_page(zsd_data),
> +	      GFP_KERNEL);
> +free:
> +	free_page((unsigned long) zsd_data);
> +	return ret;
> +}
> +
>  static inline unsigned long *blk_alloc_zone_bitmap(int node,
>  						   unsigned int nr_zones)
>  {
> diff --git a/block/ioctl.c b/block/ioctl.c
> index bdb3bbb253d9..b9744705835b 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -515,6 +515,8 @@ static int blkdev_common_ioctl(struct block_device *b=
dev, fmode_t mode,
>  	case BLKCLOSEZONE:
>  	case BLKFINISHZONE:
>  		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);
> +	case BLKSETDESCZONE:
> +		return blkdev_zone_set_desc_ioctl(bdev, mode, cmd, arg);
>  	case BLKGETZONESZ:
>  		return put_uint(argp, bdev_zone_sectors(bdev));
>  	case BLKGETNRZONES:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e961910da4ac..b8f25b0d00ad 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struc=
t request *req,
>  	case REQ_OP_ZONE_FINISH:
>  		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
>  		break;
> +	case REQ_OP_ZONE_SET_DESC:
> +		ret =3D nvme_setup_zone_set_desc(ns, req, cmd);
> +		break;
>  	case REQ_OP_WRITE_ZEROES:
>  		ret =3D nvme_setup_write_zeroes(ns, req, cmd);
>  		break;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 662f95fbd909..5bd5a437b038 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -708,6 +708,9 @@ int nvme_report_zones(struct gendisk *disk, sector_t =
sector,
>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct reques=
t *req,
>  				       struct nvme_command *cmnd,
>  				       enum nvme_zone_mgmt_action action);
> +
> +blk_status_t nvme_setup_zone_set_desc(struct nvme_ns *ns, struct request=
 *req,
> +				       struct nvme_command *cmnd);
>  #else
>  #define nvme_report_zones NULL
>  =

> @@ -718,6 +721,12 @@ static inline blk_status_t nvme_setup_zone_mgmt_send=
(struct nvme_ns *ns,
>  	return BLK_STS_NOTSUPP;
>  }
>  =

> +static inline blk_status_t nvme_setup_zone_set_desc(struct nvme_ns *ns,
> +		struct request *req, struct nvme_command *cmnd)
> +{
> +	return BLK_STS_NOTSUPP;
> +}
> +
>  static inline int nvme_update_zone_info(struct gendisk *disk,
>  					struct nvme_ns *ns,
>  					unsigned lbaf)
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 5792d953a8f3..bfa64cc685d3 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -239,3 +239,14 @@ blk_status_t nvme_setup_zone_mgmt_send(struct nvme_n=
s *ns, struct request *req,
>  =

>  	return BLK_STS_OK;
>  }
> +
> +blk_status_t nvme_setup_zone_set_desc(struct nvme_ns *ns, struct request=
 *req,
> +		struct nvme_command *c)
> +{
> +	c->zms.opcode =3D nvme_cmd_zone_mgmt_send;
> +	c->zms.nsid =3D cpu_to_le32(ns->head->ns_id);
> +	c->zms.slba =3D cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
> +	c->zms.action =3D NVME_ZONE_SET_DESC_EXT;
> +
> +	return BLK_STS_OK;
> +}
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index ccb895f911b1..53b7b05b0004 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -316,6 +316,8 @@ enum req_opf {
>  	REQ_OP_ZONE_FINISH	=3D 12,
>  	/* write data at the current zone write pointer */
>  	REQ_OP_ZONE_APPEND	=3D 13,
> +	/* associate zone desc extension data to a zone */
> +	REQ_OP_ZONE_SET_DESC	=3D 14,
>  =

>  	/* SCSI passthrough using struct scsi_request */
>  	REQ_OP_SCSI_IN		=3D 32,
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 2ed55055f68d..c5f092dd5aa3 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -370,7 +370,8 @@ extern int blkdev_report_zones_ioctl(struct block_dev=
ice *bdev, fmode_t mode,
>  				     unsigned int cmd, unsigned long arg);
>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mod=
e,
>  				  unsigned int cmd, unsigned long arg);
> -
> +extern int blkdev_zone_set_desc_ioctl(struct block_device *bdev, fmode_t=
 mode,
> +				      unsigned int cmd, unsigned long arg);
>  #else /* CONFIG_BLK_DEV_ZONED */
>  =

>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
> @@ -392,6 +393,12 @@ static inline int blkdev_zone_mgmt_ioctl(struct bloc=
k_device *bdev,
>  	return -ENOTTY;
>  }
>  =

> +static inline int blkdev_zone_set_desc_ioctl(struct block_device *bdev,
> +					     fmode_t mode, unsigned int cmd,
> +					     unsigned long arg)
> +{
> +	return -ENOTTY;
> +}
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  =

>  struct request_queue {
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
> index 42c3366cc25f..68abda9abf33 100644
> --- a/include/uapi/linux/blkzoned.h
> +++ b/include/uapi/linux/blkzoned.h
> @@ -142,6 +142,20 @@ struct blk_zone_range {
>  	__u64		nr_sectors;
>  };
>  =

> +/**
> + * struct blk_zone_set_desc - BLKSETDESCZONE ioctl requests
> + * @sector: Starting sector of the zone to operate on.
> + * @flags: Feature flags.
> + * @len: size, in bytes, of the data to be associated to the zone.
> + * @data: data to be associated.
> + */
> +struct blk_zone_set_desc {
> +	__u64		sector;
> +	__u32		flags;
> +	__u32		len;
> +	__u8		data[0];
> +};
> +
>  /**
>   * Zoned block device ioctl's:
>   *
> @@ -158,6 +172,10 @@ struct blk_zone_range {
>   *                The 512 B sector range must be zone aligned.
>   * @BLKFINISHZONE: Mark the zones as full in the specified sector range.
>   *                 The 512 B sector range must be zone aligned.
> + * @BLKSETDESCZONE: Set zone description extension data for the zone
> + *                  in the specified sector. On success, the zone
> + *                  will transition to the closed zone state.
> + *                  The 512B sector must be zone aligned.
>   */
>  #define BLKREPORTZONE	_IOWR(0x12, 130, struct blk_zone_report)
>  #define BLKRESETZONE	_IOW(0x12, 131, struct blk_zone_range)
> @@ -166,5 +184,5 @@ struct blk_zone_range {
>  #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
> -
> +#define BLKSETDESCZONE	_IOW(0x12, 137, struct blk_zone_set_desc)
>  #endif /* _UAPI_BLKZONED_H */
> =


How to you retreive an extended descriptor that was set ? I do not see any =
code
doing that. Report zones is not changed, but I would leave that one as is a=
nd
implement a BLKGETDESCZONE ioctl & in-kernel API.

-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
