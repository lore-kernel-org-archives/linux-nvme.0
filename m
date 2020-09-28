Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DBDC2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:16:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1296E2075A
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c4DLDBY6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XARpXf7X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MjDr3iHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1296E2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Z5QUqbis/un7mq8O4Muvn8HZ43bt/tUgL0M5gb86zYs=; b=c4DLDBY6ncPMJIvNutpgB8AaP
	4kNupi7CnXmnHhkyX5JXDfRwyIxabEFGPEixeCaV2HWzuvy5GVWSv1zBYwBjWxoYTJoMJbKKPG1II
	0WpKkTQgEtUToC8bbYyKcxWEhfO51kr4xYrKIcsdPp5kMeZigCM/5PqWM4jNp6mRwbEerxOuk6gIb
	mHU6NQou7wwpVBqVTigQKQCdGHKqBAbe7B78I359tkxcPjDTCUjB2b2emypCgGstn7CfF1p7etLjv
	2ml1cceZVKaaQOWEeSzbecmDZbY02C46wMnjUUzO6sUfFtc25RDOwDiMFQFf0gn/Lk0gdjGVSE8o0
	w2qR2e9sg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMtxO-0000zt-VD; Mon, 28 Sep 2020 14:16:46 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMtxN-0000z9-BP
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:16:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601302605; x=1632838605;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=e+1xP7GAC3S56ZfGTy9hCbrtUvoS0UTjvpQD29Tamk8=;
 b=XARpXf7XHZ0FNgqsviglKuXmg3xIhDrLY0xakeN2IjCa8xjuFE6tejv0
 jG6QdfgNOuXVDjhD5TiUhWl1eW1e8zEjob0AgrkH895KyUE+WZK0CzINR
 xDOszuM8AoUd2QXi7wQvlV3j9FH1xJ4NzfH3JwHU7ln4tTQvZTyw8YtD1
 38GCSZmMcAsbPwtzf+7+ke4XUiXYaQC7KC1YLxvZRwyAlZJ7zi9HO9dLy
 9Y5xYitxU7tUr5NXoEiFOQAa5kbxzk4XIPz2MpzFVn7dIxxhWEve3c0oe
 FSbOVoJol7gZn9wtNeblsPmxjEQpq+D0XEs3PJ+Wus78o5WHjQhpOz1pL w==;
IronPort-SDR: n4to4sczPhFDNpmW56h+Zn4WU8xw744h1WPu7KI4zUVeZcGOV4FIBgru1v8sfG0lRw0kN9whKY
 wiVIDdRX8nwqqDnb8/p8Ea34QRw2OqpNGG1fG4wccf65OWkldSxOakl7Hv4DAHKanx7q3BD1P/
 1FBz9ooOWrT7RdpZwX1ErTBVC3BO5WfggTCt6O9t0e9tDl/+LmWzp1Kzpvs+Ee3NBeP12wTDp+
 csOqho9FF6s8zdKeo1avjTDL08aUtHcEip68WewE2/+f9dNa9Po7zY3BcxpUw5UIHPl2uFhKR1
 NHQ=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="148364630"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 22:16:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBhOGcjslPwmTGnYJp9dyj4UEd1tPs3cnsMpEIeznWCUWnVdhhvXhy+rMHKc6QIGGYRx/4guvOZXy7NNQQx5wIpXhE3uGD+LuKg9kZjX1vsKPNNcWxUCj7VxQaeYNh1RMInxn5UXvyOLEsJol5R3VMQXfPRVSYVbqSXLv+H8DxgRGaEqDSgp+zJn27q+oKwkwRF1jOSVP8r8/W7zEolDl2B+sOKR22lfl4asDkm4LQJZ+sThMOiPHthsTYixDyAneOuZocRbgQduT1k6HNsaJHcdkHeAq+KBW6pDkJTH3dAyCDHwn1PkByagLd6CC5PYruow6JrNIYDFEZ1p+P5CKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZdJdDIQVLGV32pQe9z5mPrHblHizs46j5OI6HV1jbI=;
 b=D3oREOPpESyx/VBJ4TGg1O2b1uJPJwvTiAt20p2AvNFT70nZwKX6tQDkyCkKPvf+JJQtio+7zaM9+FfLHFI+gk/H8lvR24XxXtPJLeqXsQdAVRShYhIbTjrgScWVdFQSBX+y5i7QSzhCiCP6RyC8pC/zfk4U6J09Ka1++0rHWrfZQIJIgxL0gWNJiA1cC7RTEEXq6NBy6uhxnct0Ybno7E/cgrTS5F5tnpo0qQhQJ0Un+0jTFa8Tm+2SixIGREqKjzBRTz3AzrqkurIppWE4TIV/fs+Lf64qafHCDFrorKQJMY5uUWKhK7Pi+0gtgD120MacB7Pj6JmSWf2jyD1y4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZdJdDIQVLGV32pQe9z5mPrHblHizs46j5OI6HV1jbI=;
 b=MjDr3iHo/PnhcxoIw1M4Bs31jh9LA5df30lL/PAZsiQy3UJ3JFCubIRmPgV9UKjZ6etCR9PuGegLfMJT2Lw4qDWQ81FSAhxrzQ5B5wWG3m5whn3qpiONxdBxrd8he5pIR8XxZmMWgC+z+ShlJNsNSbdESFu+q1FJiqnvx5DXeLg=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3588.namprd04.prod.outlook.com (2603:10b6:910:90::35)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.24; Mon, 28 Sep
 2020 14:16:34 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:16:34 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 02/20] nvme: fix initialization of the zone bitmaps
Thread-Topic: [PATCH 02/20] nvme: fix initialization of the zone bitmaps
Thread-Index: AQHWlZPU7ec0MCLzLEKUFp3GJ4oXUQ==
Date: Mon, 28 Sep 2020 14:16:34 +0000
Message-ID: <CY4PR04MB3751BD67B00FA6F6D3442E96E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9caac49d-d805-4f6f-a865-08d863b91b2d
x-ms-traffictypediagnostic: CY4PR0401MB3588:
x-microsoft-antispam-prvs: <CY4PR0401MB3588F9DA79751BDD7A23F1F4E7350@CY4PR0401MB3588.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XRb2bpmiKXEpCQkqvOCXhRwhyAoVW+5NonDeE/9eb472rHPWB0gBFK6trVFYaxd3lKcwF/KspSBPSB5nangHJUjgqKXae0TWCHQX3N9jdSC+vRzSb/wfIqoqmY4yLw+V8mpT+V5x2xdz1EmXCmXR8MOcvLEd0D1UwAQCeg89mlMvJSYBityhGn146JaJBuhY+gxhiW3TB7FDe6fx0+0V/KrVray27xbXxP00lvv5KXVicv0/wsDe/SZ+VSGDrH7ATPiRQnUlNE5uTp1vJihvSWcN905d5aNrkiLj2iOI9b2zfJ23KbqWdVyEzLPSFPYyXnP+g2Mqx4wWA+NPgVhhGis5vudO+UOKKjaG+IUOSKnL5zr2DnHzZ0t+BehGpc9H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(76116006)(186003)(52536014)(2906002)(86362001)(6506007)(7696005)(53546011)(71200400001)(83380400001)(316002)(8676002)(33656002)(110136005)(91956017)(5660300002)(64756008)(66476007)(478600001)(55016002)(8936002)(66446008)(66946007)(66556008)(4326008)(9686003)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: lY5zeLrrFkZVFaERygsqD8TbY1hdLBDwT1a9hWLSPo+MWJOOrrjsKr3YbSlk4cGzN3tgHstEKdhzIG+Ot0A8mNFEdbnoJ7jKy9+M9M4HFS5Y+hCw4Tzu81QAVLNOHteJdy+EUT18ZeqWEi7rADe6R77zePb9R6TzvLBXHWsOhd7XcwB2OOARj9PjIrDYlAmLsktAkC/aTQt6yXIx0aPMWZe8YqwjgeWqRau0J+mBiYFQuPnM3HeUg6uIXqyQQEa6etWW6wUrY3QYFaq7H3sXq6yX+AEF890ckxPiKTzqMGzTRRpcYlfrgknqHkHEYJdLGCp3JgQZitJ9YVZdT/a+o3Y6VwSnL3iadmpkIgBe2Nvw+xS5YNzKNHck+3BDUzri3ttqV+4ZiueelRX/GZ1PfSdH4MkgU9ME1cRpgUGe0gHSWX/ecQ41BRTWcXulcBbSCjlzervtTONMpFnBaXN5lcuLmq41Jnv3IFVR8Oti6cTFRtbmXJTUj2Ors/y61krRfnyXwlUkEkGxKJUF73WlN6Oy4xEaJX4TcFLEvbDuFancwtXwZbt31L5nw9n3/SXHxBrJ0vTw0P4tef7ILRaULKQ/J+f9x+jMP59YF1p5kELKv8SeG2fzeoTzazwG6EXpljXCHiZah85mGv7Y3Eb0loC6Cy596G+yS3tziMyATN3voWlPFg9tMMb/Y/6AoLv8jNJWnTxCXCRrIJW3uB6wPQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9caac49d-d805-4f6f-a865-08d863b91b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:16:34.7682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qNTJrdMeSiRsr20C341xeX5AaXBoPtwpo9OPb53da0XVlFE5B9sbvNZcmgHjfsPY8ZhjGT33bcECVl2jR8TPvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3588
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_101645_509725_7E28290B 
X-CRM114-Status: GOOD (  21.85  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/28 21:35, Christoph Hellwig wrote:
> The removal of the ->revalidate_disk method broke the initialization of
> the zone bitmaps, as nvme_revalidate_disk now never gets called during
> initialization.
> 
> Move the zone related code from nvme_revalidate_disk into a new helper in
> zns.c, and call it from nvme_alloc_ns in addition to nvme_validate_ns to
> ensure the zone bitmaps are initialized during probe.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 28 +++++-----------------------
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/zns.c  | 11 +++++++++++
>  3 files changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0a985c601c62c3..400d995f95fe2d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2202,28 +2202,6 @@ static int _nvme_revalidate_disk(struct gendisk *disk)
>  	return ret;
>  }
>  
> -static int nvme_revalidate_disk(struct gendisk *disk)
> -{
> -	int ret;
> -
> -	ret = _nvme_revalidate_disk(disk);
> -	if (ret)
> -		return ret;
> -
> -#ifdef CONFIG_BLK_DEV_ZONED
> -	if (blk_queue_is_zoned(disk->queue)) {
> -		struct nvme_ns *ns = disk->private_data;
> -		struct nvme_ctrl *ctrl = ns->ctrl;
> -
> -		ret = blk_revalidate_disk_zones(disk, NULL);
> -		if (!ret)
> -			blk_queue_max_zone_append_sectors(disk->queue,
> -							  ctrl->max_zone_append);
> -	}
> -#endif
> -	return ret;
> -}
> -
>  static char nvme_pr_type(enum pr_type type)
>  {
>  	switch (type) {
> @@ -3958,6 +3936,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  
>  	if (__nvme_revalidate_disk(disk, id))
>  		goto out_put_disk;
> +	if (blk_queue_is_zoned(ns->queue) && nvme_revalidate_zones(ns))
> +		goto out_put_disk;
>  
>  	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
>  		ret = nvme_nvm_register(ns, disk_name, node);
> @@ -4052,7 +4032,9 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  		return;
>  	}
>  
> -	ret = nvme_revalidate_disk(ns->disk);
> +	ret = _nvme_revalidate_disk(ns->disk);
> +	if (!ret && blk_queue_is_zoned(ns->queue))
> +		ret = nvme_revalidate_zones(ns);
>  	revalidate_disk_size(ns->disk, ret == 0);
>  	if (ret)
>  		nvme_ns_remove(ns);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1096ef1f6aa2b0..6cbbd1597ae6d7 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -758,6 +758,7 @@ static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
>  }
>  #endif /* CONFIG_NVME_MULTIPATH */
>  
> +int nvme_revalidate_zones(struct nvme_ns *ns);
>  #ifdef CONFIG_BLK_DEV_ZONED
>  int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
>  			  unsigned lbaf);
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 53efecb6789838..672a18fcf3bfe2 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -7,6 +7,17 @@
>  #include <linux/vmalloc.h>
>  #include "nvme.h"
>  
> +int nvme_revalidate_zones(struct nvme_ns *ns)
> +{
> +	struct request_queue *q = ns->disk->queue;

struct request_queue *q = ns->queue;

may be ?

> +	int ret;
> +
> +	ret = blk_revalidate_disk_zones(ns->disk, NULL);
> +	if (!ret)
> +		blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
> +	return ret;
> +}
> +
>  static int nvme_set_max_append(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_command c = { };
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
