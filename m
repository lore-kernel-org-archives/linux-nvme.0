Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E003CC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:45:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8912A206B7
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lDfPCnEA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DVnLIy5V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V6sIzCgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8912A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=XoaXzFGuEr4igWDwjs6/pszXEuhzQDvNt+KFM7+/KVo=; b=lDfPCnEAzMXhTSUFhnl9QSuFM
	2jPgL8WJMfRQFZbIybXilk6FCSCBeOwyt1L9lBCh1sKQypbmFSK+0QRgWY3Db5HYL8dSjpEaQ0han
	O7brP+suxdb4sQPS0/AcJ6KeXNX6hBaGIioovLlVQi63BXhuac17SgnoyNcwnQvjQ5u6Csz9PREuY
	2IHnDY4NzI8sEbyPnweOVANvl9J02HUoaeO50TziRsFtbXJENtY7IL8mUbNrViVAY9gW6RNXeonQv
	KVwKMvbhe2XctqJYJduf63mCxsx5M7YmFLE2SkZ6DiDZzTcbngrC0Q0JSTImov5at17xeYoEXP6Cg
	4Azhz1nzw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jolr5-0003aj-1v; Fri, 26 Jun 2020 10:45:11 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolqm-0003SL-2N
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:44:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593168292; x=1624704292;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=VNEMBL64Nrrgorsa6euS7Ll8zBO3+Ywn5BMhE93AZY4=;
 b=DVnLIy5Vr3QwqBJYA0QK+ZJ8baCjAHSBODqrkn02knDJOhkWMNszjz9B
 XJuucZF2BDuUCz655MdsgY8WelMPEdVu7eFEn/2sCb0YcjN8LqEfExN4G
 Xdxut8BG8Qutw/G+CYq3SW2EgfbZh3zfXQEsB2bwWpbrNRkPgyWv++IOU
 2r2FBw0ZH2Ri1P1gag5tGPew/NoGfjlUqeTUDfa8h4sCRXzrff7N5lFM2
 3ufg3SdOmLaUYYzt7BgYEVK1SCPC055AX3zrVknFVkqpzoK155koFrN6O
 sk5ImLZ60epkqlGLS7jlfXviDVxy6+NqCXxIOa2IueKnhL1I8ZD4y1bAd w==;
IronPort-SDR: J6kbdRdMjWTHGcjUBoRXjdeWbF8HMQ8v6Jx0GDSQajRUP8uEPoFYK5Itejh4b9KyN6PAF4pEP5
 lT9I98wl0MbHDyTNboljsLolVtcEELkFkVCtAhBbNr8QSISMcXndWxqAFNHKqmTOOjabF9m1uW
 xdJ5afp24bS3LHSsgIpDqUYrjefZdKsUi8xFqJMNi+bQhUKKZ9uRtUqv+wD5E2INqmc2bxXz4N
 s2OsneFcJY8gl3KbfQABxngJvRQeZBF6cyIltHGXzE6iTAtkUCUI2mV/DyXUlcBvsAT2vMOL5J
 UM8=
X-IronPort-AV: E=Sophos;i="5.75,281,1589212800"; d="scan'208";a="142330076"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 09:38:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO2OOg4G/qXXGY8zZ9tNKPOWS7ejzNp0HxzxsUzfJomgaTXoC7qIYkHxh9NHpXWkPb5JtMtkHv/KWEYZqIGsExoU/z+lztBS28H14WQc2T0v9569MwYQDWjMFSA2LoF3jo9f5V/5mQPrqtN4ZrFNHhXOZr0LjkSqIQae1cPW3lqUzl9j0pgaxjJMoTPAnyK7jiJ55U/xCdl/vJBpU4BVE+x1DpWfBAjDI3vwofsqOelsHCbiYlvmvDSEWLvMB8fCMx/9AyUeFuKEvL5nM6PZYx0pFR8ewNscBXA09MjRywBdsKlGJ1hRe7lj8K6wKZPFcS596WkyJxSBlSM/L+B7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF1wiQPZqW0R3xp+/BYfIeRC4HaS/cdipp7x2Hb2Eus=;
 b=kk0WFs4KEegUw69d4Q+bEathZOw19S0nQoKJfdvglkHSSppiVmSRSq4ezHF/ygLBQUO+T106VNUgddkLhc04g2IDgWuQCC3/qds3yTwNJi5suIRm4KJZVHvEUdn808vz2fe1PffRmE6Sg7NXSHiNEbVmxC9AQvaa31bSi168as/scYtWjELO7debA7p4LIt03I/rOOdn3hkh66rhfE23vu0yXwMphfLLyKO0phZ75j5nIXKgvxW8P9moYVApwGP7rywpE7tbWjMdx244/ksmaGXOqsxiwf2GRrZTcSdrTeWPXwXyplzZXDKS4MONtlj8D5mTJWg0NRWejr5IV6SIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF1wiQPZqW0R3xp+/BYfIeRC4HaS/cdipp7x2Hb2Eus=;
 b=V6sIzCgpnpA5cS+d0DMaiZrgQf0jldLwagbpXXUqBl8GRO43kPJ9wfWRLl0FVo085FMRlw7NiRKQmSU4G3XB8xojHqUyTMjc0Z9kQyS8Xslq4nPKeE1CILVxrbwHDl415jUZjMzxNewh+Nkjst4ni+sYeoGmLF2j0vJJj/M/lkE=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1032.namprd04.prod.outlook.com (2603:10b6:910:50::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 01:38:08 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 01:38:08 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/6] block: introduce IOCTL to report dev properties
Thread-Topic: [PATCH 4/6] block: introduce IOCTL to report dev properties
Thread-Index: AQHWSutNlrk/U7ZovU6aHVaoqZz0nw==
Date: Fri, 26 Jun 2020 01:38:07 +0000
Message-ID: <CY4PR04MB3751A4DAA69F56A10F3D9196E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-5-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92c2e757-96cf-4237-c4ed-08d819719439
x-ms-traffictypediagnostic: CY4PR04MB1032:
x-microsoft-antispam-prvs: <CY4PR04MB1032CC2F8B15D3E9BF246F9EE7930@CY4PR04MB1032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZZfGOeqp6hCBxCnZSwjhD9A5VGnOaJAbQZ0d6KQtRYwADAtYY6D2Eh8T2xx1XO5YWhRJfhjUNZP7PunSljcn5FQ0/bioeI7p6jFoo9sWWz4GMK5DEShKk7O/XzkiWHuwpseD0GLEwCXshR4bRO6eDa7y/ojSQ5xZMbkdGsyroZw17iMIFvm7ipxgS2aIhINCRtIzbMTKqGf25C1ippmjHG1MtwifuxM+qIJYsT0+OcT8hefAMw/xASP2P1uOl5AmVY4NhRisZdnKh8/daTmI3t7V44cjNolboVDy/XEujVUfLujY1iR7FHvog1Rf7mSRPl2focajZJa/Y6gbT64rw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(91956017)(7416002)(86362001)(55016002)(66446008)(2906002)(83380400001)(66946007)(71200400001)(66476007)(64756008)(478600001)(66556008)(5660300002)(186003)(76116006)(9686003)(26005)(8936002)(33656002)(53546011)(316002)(6506007)(66574015)(4326008)(8676002)(54906003)(52536014)(110136005)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: uZZwbHSLXYa2LABKJl2J4tuUkITX2ZHKtKuuoUzHEs5zKMvvYKf6gZH1N4YNrcHQ/q8Y0wmZoWSkQQO8Xs3nkw7haV+bi1rDyAj0QEoqlTtr5U0VgjAJBSSpBFTJ+5L9pYEWd2owxMW20QUtX75pOVfacdroi0ojaLP+zGbCZJDuZEyGYa88Bvdq1L5A31JvDYe6DWTZndKHbn/YBROahx7WNc+3LyTouM1DOG84Yvc635wB74Uc4Tm6Q9zwVKOE88IeGBwSBjM1R+1MkZuowKMqnENVkMReetaSxpwYV30Wi1DgnkF+HdBfNBjKDtUVfqEZqCRpr5M8QqE09RY6d0iqWlWhgmAbilBXZJTQePB/CdrIpXVssbpiCxx9UwP5/uEyRclHAWb4NKwaNzUtAOARF35DSaJcBJthF6igIPPHVkWX+gxHzX7GECca6ChpRwBzHSQWi35XafBpGBKmJXaK1YtaChL8HhZlP/dUYwY9Ql2QIrY2otmBbL894lne
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c2e757-96cf-4237-c4ed-08d819719439
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 01:38:07.9908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJC9tfaPbYDLNetwjoTsNXqAi+0LRIvxiSW+fzBed6Bzb8RcKCMSme9OihnE45VMU9x/yt1bE3JWkXytSuyQWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1032
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
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/25 21:22, Javier Gonz=E1lez wrote:
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
> =

> With the addition of ZNS, a new set of properties have been added to the
> zoned block device. This patch introduces a new IOCTL to expose these
> rroperties to user space.
> =

> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  block/blk-zoned.c             | 46 ++++++++++++++++++++++++++
>  block/ioctl.c                 |  2 ++
>  drivers/nvme/host/core.c      |  2 ++
>  drivers/nvme/host/nvme.h      | 11 +++++++
>  drivers/nvme/host/zns.c       | 61 +++++++++++++++++++++++++++++++++++
>  include/linux/blkdev.h        |  9 ++++++
>  include/uapi/linux/blkzoned.h | 13 ++++++++
>  7 files changed, 144 insertions(+)
> =

> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 704fc15813d1..39ec72af9537 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -169,6 +169,17 @@ int blkdev_report_zones(struct block_device *bdev, s=
ector_t sector,
>  }
>  EXPORT_SYMBOL_GPL(blkdev_report_zones);
>  =

> +static int blkdev_report_zonedev_prop(struct block_device *bdev,
> +				      struct blk_zone_dev *zprop)
> +{
> +	struct gendisk *disk =3D bdev->bd_disk;
> +
> +	if (WARN_ON_ONCE(!bdev->bd_disk->fops->report_zone_p))
> +		return -EOPNOTSUPP;
> +
> +	return disk->fops->report_zone_p(disk, zprop);
> +}
> +
>  static inline bool blkdev_allow_reset_all_zones(struct block_device *bde=
v,
>  						sector_t sector,
>  						sector_t nr_sectors)
> @@ -430,6 +441,41 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev=
, fmode_t mode,
>  				GFP_KERNEL);
>  }
>  =

> +int blkdev_zonedev_prop(struct block_device *bdev, fmode_t mode,
> +			unsigned int cmd, unsigned long arg)
> +{
> +	void __user *argp =3D (void __user *)arg;
> +	struct request_queue *q;
> +	struct blk_zone_dev zprop;
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
> +	ret =3D blkdev_report_zonedev_prop(bdev, &zprop);
> +	if (ret)
> +		goto out;
> +
> +	if (copy_to_user(argp, &zprop, sizeof(struct blk_zone_dev)))
> +		return -EFAULT;
> +
> +out:
> +	return ret;
> +}
> +
>  static inline unsigned long *blk_alloc_zone_bitmap(int node,
>  						   unsigned int nr_zones)
>  {
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 0ea29754e7dd..f7b4e0f2dd4c 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -517,6 +517,8 @@ static int blkdev_common_ioctl(struct block_device *b=
dev, fmode_t mode,
>  		return blkdev_zone_ops_ioctl(bdev, mode, cmd, arg);
>  	case BLKMGMTZONE:
>  		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);
> +	case BLKZONEDEVPROP:
> +		return blkdev_zonedev_prop(bdev, mode, cmd, arg);
>  	case BLKGETZONESZ:
>  		return put_uint(argp, bdev_zone_sectors(bdev));
>  	case BLKGETNRZONES:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 5b95c81d2a2d..a32c909a915f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2254,6 +2254,7 @@ static const struct block_device_operations nvme_fo=
ps =3D {
>  	.getgeo		=3D nvme_getgeo,
>  	.revalidate_disk=3D nvme_revalidate_disk,
>  	.report_zones	=3D nvme_report_zones,
> +	.report_zone_p	=3D nvme_report_zone_prop,
>  	.pr_ops		=3D &nvme_pr_ops,
>  };
>  =

> @@ -2280,6 +2281,7 @@ const struct block_device_operations nvme_ns_head_o=
ps =3D {
>  	.compat_ioctl	=3D nvme_compat_ioctl,
>  	.getgeo		=3D nvme_getgeo,
>  	.report_zones	=3D nvme_report_zones,
> +	.report_zone_p	=3D nvme_report_zone_prop,
>  	.pr_ops		=3D &nvme_pr_ops,
>  };
>  #endif /* CONFIG_NVME_MULTIPATH */
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index ecf443efdf91..172e0531f37f 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -407,6 +407,14 @@ struct nvme_ns {
>  	u8 pi_type;
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	u64 zsze;
> +
> +	u32 nr_zones;
> +	u32 mar;
> +	u32 mor;
> +	u32 rrl;
> +	u32 frl;
> +	u16 zoc;
> +	u16 ozcs;
>  #endif
>  	unsigned long features;
>  	unsigned long flags;
> @@ -704,11 +712,14 @@ int nvme_update_zone_info(struct gendisk *disk, str=
uct nvme_ns *ns,
>  int nvme_report_zones(struct gendisk *disk, sector_t sector,
>  		      unsigned int nr_zones, report_zones_cb cb, void *data);
>  =

> +int nvme_report_zone_prop(struct gendisk *disk, struct blk_zone_dev *zpr=
op);
> +
>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct reques=
t *req,
>  				       struct nvme_command *cmnd,
>  				       enum nvme_zone_mgmt_action action);
>  #else
>  #define nvme_report_zones NULL
> +#define nvme_report_zone_prop NULL
>  =

>  static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,
>  		struct request *req, struct nvme_command *cmnd,
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 2e6512ac6f01..258d03610cc0 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -32,6 +32,28 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
>  	return 0;
>  }
>  =

> +static u64 nvme_zns_nr_zones(struct nvme_ns *ns)
> +{
> +	struct nvme_command c =3D { };
> +	struct nvme_zone_report report;
> +	int buflen =3D sizeof(struct nvme_zone_report);
> +	int ret;
> +
> +	c.zmr.opcode =3D nvme_cmd_zone_mgmt_recv;
> +	c.zmr.nsid =3D cpu_to_le32(ns->head->ns_id);
> +	c.zmr.slba =3D cpu_to_le64(0);
> +	c.zmr.numd =3D cpu_to_le32(nvme_bytes_to_numd(buflen));
> +	c.zmr.zra =3D NVME_ZRA_ZONE_REPORT;
> +	c.zmr.zrasf =3D NVME_ZRASF_ZONE_REPORT_ALL;
> +	c.zmr.pr =3D 0;
> +
> +	ret =3D nvme_submit_sync_cmd(ns->queue, &c, &report, buflen);
> +	if (ret)
> +		return ret;
> +
> +	return le64_to_cpu(report.nr_zones);
> +}
> +
>  int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
>  			  unsigned lbaf)
>  {
> @@ -87,6 +109,13 @@ int nvme_update_zone_info(struct gendisk *disk, struc=
t nvme_ns *ns,
>  		goto free_data;
>  	}
>  =

> +	ns->nr_zones =3D nvme_zns_nr_zones(ns);
> +	ns->mar =3D le32_to_cpu(id->mar);
> +	ns->mor =3D le32_to_cpu(id->mor);
> +	ns->rrl =3D le32_to_cpu(id->rrl);
> +	ns->frl =3D le32_to_cpu(id->frl);
> +	ns->zoc =3D le16_to_cpu(id->zoc);
> +
>  	q->limits.zoned =3D BLK_ZONED_HM;
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  free_data:
> @@ -230,6 +259,38 @@ int nvme_report_zones(struct gendisk *disk, sector_t=
 sector,
>  	return ret;
>  }
>  =

> +static int nvme_ns_report_zone_prop(struct nvme_ns *ns, struct blk_zone_=
dev *zprop)
> +{
> +	zprop->nr_zones =3D ns->nr_zones;
> +	zprop->zoc =3D ns->zoc;
> +	zprop->ozcs =3D ns->ozcs;
> +	zprop->mar =3D ns->mar;
> +	zprop->mor =3D ns->mor;
> +	zprop->rrl =3D ns->rrl;
> +	zprop->frl =3D ns->frl;
> +
> +	return 0;
> +}
> +
> +int nvme_report_zone_prop(struct gendisk *disk, struct blk_zone_dev *zpr=
op)
> +{
> +	struct nvme_ns_head *head =3D NULL;
> +	struct nvme_ns *ns;
> +	int srcu_idx, ret;
> +
> +	ns =3D nvme_get_ns_from_disk(disk, &head, &srcu_idx);
> +	if (unlikely(!ns))
> +		return -EWOULDBLOCK;
> +
> +	if (ns->head->ids.csi =3D=3D NVME_CSI_ZNS)
> +		ret =3D nvme_ns_report_zone_prop(ns, zprop);
> +	else
> +		ret =3D -EINVAL;
> +	nvme_put_ns_from_disk(head, srcu_idx);
> +
> +	return ret;
> +}
> +
>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct reques=
t *req,
>  		struct nvme_command *c, enum nvme_zone_mgmt_action action)
>  {
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 8308d8a3720b..0c0faa58b7f4 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -372,6 +372,8 @@ extern int blkdev_zone_ops_ioctl(struct block_device =
*bdev, fmode_t mode,
>  				  unsigned int cmd, unsigned long arg);
>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mod=
e,
>  				  unsigned int cmd, unsigned long arg);
> +extern int blkdev_zonedev_prop(struct block_device *bdev, fmode_t mode,
> +			unsigned int cmd, unsigned long arg);
>  #else /* CONFIG_BLK_DEV_ZONED */
>  =

>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
> @@ -400,6 +402,12 @@ static inline int blkdev_zone_mgmt_ioctl(struct bloc=
k_device *bdev,
>  	return -ENOTTY;
>  }
>  =

> +static inline int blkdev_zonedev_prop(struct block_device *bdev, fmode_t=
 mode,
> +				      unsigned int cmd, unsigned long arg)
> +{
> +	return -ENOTTY;
> +}
> +
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  =

>  struct request_queue {
> @@ -1770,6 +1778,7 @@ struct block_device_operations {
>  	int (*report_zones)(struct gendisk *, sector_t sector,
>  			unsigned int nr_zones, report_zones_cb cb, void *data);
>  	char *(*devnode)(struct gendisk *disk, umode_t *mode);
> +	int (*report_zone_p)(struct gendisk *disk, struct blk_zone_dev *zprop);
>  	struct module *owner;
>  	const struct pr_ops *pr_ops;
>  };
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
> index d0978ee10fc7..0c49a4b2ce5d 100644
> --- a/include/uapi/linux/blkzoned.h
> +++ b/include/uapi/linux/blkzoned.h
> @@ -142,6 +142,18 @@ struct blk_zone_range {
>  	__u64		nr_sectors;
>  };
>  =

> +struct blk_zone_dev {
> +	__u32	nr_zones;
> +	__u32	mar;
> +	__u32	mor;
> +	__u32	rrl;
> +	__u32	frl;
> +	__u16	zoc;
> +	__u16	ozcs;
> +	__u32	rsv31[2];
> +	__u64	rsv63[4];
> +};
> +
>  /**
>   * enum blk_zone_action - Zone state transitions managed from user-space
>   *
> @@ -209,5 +221,6 @@ struct blk_zone_mgmt {
>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
>  #define BLKMGMTZONE	_IOR(0x12, 137, struct blk_zone_mgmt)
> +#define BLKZONEDEVPROP	_IOR(0x12, 138, struct blk_zone_dev)
>  =

>  #endif /* _UAPI_BLKZONED_H */
> =


As commented already, NVMe passthrough or sysfs device attributes would be =
much
better. See scsi: there is no IOCTL defined to obtain every single log page=
 or
mode page defined. Passthrough is the interface to do that. For frequently =
used
log pages giving device information, sysfs is used as a cache. See all the
"vpd_pgXX" entries under /sys/block/sdX/device. All of this is done by the
driver. Not the block layer.

-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
