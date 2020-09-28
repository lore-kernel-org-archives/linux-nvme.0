Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAC7C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:17:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF402075A
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K22lXIkC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JYib9Caa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qgz2qEZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF402075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=2I9HWEm8PiaQMkJhGRjSBi4xF1NUMYBx/E1FQ3wrLv4=; b=K22lXIkCMLXeoENKqPJK+40Nj
	PiKxE1Elk3xcjKLjoiUnyW5zoB0orUT612nJG3dRzfUo5wtDlsCVba3YR9AyTcSewInhAWxAZJ/mz
	KdNWTTApjAZNQq5UaVN6GET+My7N5pTNSavOJb0fs8A1KVYLdjXgB2imPdXp97TASmPxsj1xWi8OG
	2MNsnsSd6UuzUyhqlZWcsec0xrA54q1bj8ocTXva66qBIO2Lo2u8EVaJkPH6l7yMemN9fg4Ib77x7
	wiK4TIfkJ3vLNT3cvk8IJhq2L4HldhEHkJmxvMnM9d2R+5fZ6mxCDhX4oF89L68/Fk0K7qTr0/NU8
	NxxfpFEHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMtyQ-0001Hz-2C; Mon, 28 Sep 2020 14:17:50 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMtyM-0001H6-Rp
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:17:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601302667; x=1632838667;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=4upuOpDLWQ5Glud6f7ZGirpQR8WTpKWGXqUKHi4FFew=;
 b=JYib9Caa6jqbU4elomFziXrzQtn8p4vUnpIcRm5kLFLjXeJBZyCQPQ7g
 uriE/rd2lFcgXIbbyCyW6d2Ti79XUTvb8KxBSrjHl4umM99kzdr3M9Xix
 gHai1boBpC0LiJL7u5KtWd0larebrxR7MRB5gU2oYgkoEQ/W1lDL5otsp
 yNjRWNye3HtSfzYlYwAf8D2LARwmVQ3yXipAT90FkyAfdNl1loDZ0Bt73
 T8DZ68iU7GvPoZOI23ERdwTocm/xUOloHEjOo+mJWGDIOgXltCcgiRH4r
 rYc2JKt7eOfGU8yPY4NwusUTK9+GuBz80a74XFi4dmmOts9apTqs79CFc Q==;
IronPort-SDR: N6ITh/IGwd3wdvvVVtOfC87ZD4lRIvV1cCeObN/c68MFYxWw7DCz119owe5Kz6SLrtw4dp80WQ
 oW4S7e7y7kgypaWdz6GrvRZIrUHakVeM11fIyNRC+wbjXkKg+21TbRCO0QYhaTPVcWTK/1DLgt
 AtjBDSVjAjaHzOlH2BQF71iEfXWYrjVMBhBuI6JnOSrlzH+8tqgbK2c45XQiPTiSDPlRC+Xw5F
 7Bri20yZ20alXrKB6+Lcv89kSxwoN8XOezdBBCnVzYdRC2ADophLkGIQsA7yRhlcZMV/QodPFI
 IUo=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="148469100"
Received: from mail-cys01nam02lp2058.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.58])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 22:17:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmjXTyizAxwyXgjZYf/+MC4dqXwHFv5I6KhljtMIl783dCQSPZYU0CPT1TTeiHk8gj0hTLhbcAtQ2L3mhAI8GvsqSXEX5F3QQfy4Rt/wIQWUllIDEj5y8cqNjOOHAdVihubZPkq5iHwj6Ze2a4e19VDT7WqoCetJxQdon9cZFHWHecy02apXLsJB4iZLSVEcX6sPvMx7ZdK9IvQLZo2K7zIpr70AuEsZFLfeHySK3Gtpzo5kARgQQlUBFLwNkwCksyYjbteBouBl8vHrHyUtkQ+Capmgocm0CchdIxhXoPrB92HJT3LHpDRav2yWIv9gtf3jG45E5UImC75bIbF8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BqdnE9RELXeU0ZoucVZkBWgCd/xZUUmylQO57ZtMOs=;
 b=Hgr7YvVKkJeZnXc8i49e3CGXoKtcvtlJAWMujjSBjqG7BWZtjPJGLW261aC03v3VGiTa6QDSQqrTObfFYgTNVnlwFz88M4S4/Z1MWA1y/qsk7TLDFz4FIA+dGhbN6nRo7WR4/yqfCJmNZFPLSIwsKN6Do8tHalwFWo3gsm23fGI+oymDnH1QoJ79cLgKXZkCXCfFAI0T9JzIyInXqTJhpVAhg0Kbt7jrKCRt1z+45bseDBddlCy+5hv7E77AKu2KIds9dQC6/AEwSR0m3mM9umhhCWk1VHFX4l6/oJdFPGzhNeCpeRmZVG76GQDngtaIM25TBO7+NwtYfUNRhFUScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BqdnE9RELXeU0ZoucVZkBWgCd/xZUUmylQO57ZtMOs=;
 b=qgz2qEZYquK+Vx7qM/KJjNl8KY+3Tj+cuHhjgqTkyFP6gGf/aClkBt3mx+H24LrPuo2yaPQBSjetstJ7VFypcUmfB3Jf24EN8lexyEBFhT1ZY5cKR5Y5uYRBTpMuptl3iDWVVt3fCuUcqnKeYJO7g/lObDFZ0svYWM24e3GGerw=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3636.namprd04.prod.outlook.com (2603:10b6:910:91::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Mon, 28 Sep
 2020 14:17:45 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:17:45 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 03/20] nvme: remove the disk argument to
 nvme_update_zone_info
Thread-Topic: [PATCH 03/20] nvme: remove the disk argument to
 nvme_update_zone_info
Thread-Index: AQHWlZPTni/KrHfTa0G+gt4hNHz5KQ==
Date: Mon, 28 Sep 2020 14:17:44 +0000
Message-ID: <CY4PR04MB375120010EB2515A85A0E0ECE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e09d5815-a838-4eeb-bd41-08d863b944f9
x-ms-traffictypediagnostic: CY4PR0401MB3636:
x-microsoft-antispam-prvs: <CY4PR0401MB363623BB2A8BBE79A4ED4792E7350@CY4PR0401MB3636.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W93rQulUYL1iJ3K8mj+WouGaZR0jNfvXGKileYm8QniA3DwBAwmMCwalUW5l0rkW0SIYs/n9e6e+cGm36t0gyV8nQXIYQVO6mCn9+CgGlk8LAdILklBVDI97J4OWHkbREDYSdAj//MoC6hCOvxG68n6IU4bGELaBJrcKv6ZDS3FswOYJEsJqDAhuUuZo8Ymv90MB30+njEfrxDfb7BUzsagFZBGOI0Br0Q/438m/pqee7Y2sCjDFCgCPQcrOitD1vnqfB0MU9zYwguLSHzsGwAIFnDLUivUQOob0o6sY+1OZHZwGuoIQ5CbkGbaMwuvzDcAL107EWbMmgx5/B3EFKZay6EdNvQ6ESUcEPykKBZWJqHACrc5KgWtX4g93WEYj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(5660300002)(83380400001)(54906003)(478600001)(186003)(110136005)(316002)(6506007)(53546011)(7696005)(91956017)(66946007)(71200400001)(86362001)(66446008)(76116006)(66476007)(66556008)(64756008)(52536014)(2906002)(33656002)(8936002)(4326008)(8676002)(9686003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ZKJGkne/RJoP+05d9C3XcwWFuxhot84TQA6bMG3/QtofVyiO4zaprZ0jmljyVZV5ZQcLwbaoC5YsHb5FsUG/WOsAJuBU375f/g7Jrk/9SAYKdYrfSGchZFJm26IT8FMxz0x5K3htW8h6VGkUenS2KiX4WvrJOmYmRevlVEbbKFHt59oxi8MEYMImAsbuXlVYSlc0nYk/hD8Dg39XOR5Bn+h0g9nR8WEglVCP1LhUbrqe9IvMCf6dpH/Nsp57E2JwyDLH9pCnvhWdEk8Vg6d7zBnC1lHPsaex7IV9CYAXqgH0fN6vzPCU7qAj+ocBfA6FjQ7ICLiARxQ6KGcPfiyWrl/1w7ypevgUkpwiqre79F7Hlm2eLcuqSgbrSPU4bujWCYzWSeOXIhENfkl9E58NKL8/iky82BMkIN5CaN8sVhi1Kva6ANgXNh3ZM5YVZUz1jd1NGiNA/4XSTpqHHjle4pU+s4gB0yNV5wHSjFAnv+DEyT3CTDhuVFfyhs8AtLr5QwFfxcqXD6dzKWeZAFz/1eqxkB/fSMldTiuATtVPeNUaVXtpEfNF6Q7+cKFKNFFTol1YhjWvsYQamHN9Gf7GdMFzhl7leePx1/w55BB/ysIueMs3nK2ZE52IXOB5xi0Kf2zHMA95v9sT9rTRrQDqHOyYNMjTzGmpWyv9hOFo1C4hw9/Clk9mx7Ssl8RdEvQKL8m3iMWgAgnr2GyIKsSQ8w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09d5815-a838-4eeb-bd41-08d863b944f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:17:44.9432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3+0qxSamvh/JwBtA97AVG7NOCIpdeVlXpEeAdBXD82TrxIoGjAcLBkvYHFw0VYYE6ef4BPd03O/43xvHhr0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3636
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_101747_052996_A93F80A9 
X-CRM114-Status: GOOD (  18.15  )
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
> The queue can trivially be derived from the nvme_ns structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  drivers/nvme/host/nvme.h | 8 ++------
>  drivers/nvme/host/zns.c  | 5 ++---
>  3 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 400d995f95fe2d..d4b5032084972a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2095,7 +2095,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  	case NVME_CSI_NVM:
>  		break;
>  	case NVME_CSI_ZNS:
> -		ret = nvme_update_zone_info(disk, ns, lbaf);
> +		ret = nvme_update_zone_info(ns, lbaf);
>  		if (ret) {
>  			dev_warn(ctrl->device,
>  				"failed to add zoned namespace:%u ret:%d\n",
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 6cbbd1597ae6d7..5667761001267d 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -760,9 +760,7 @@ static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
>  
>  int nvme_revalidate_zones(struct nvme_ns *ns);
>  #ifdef CONFIG_BLK_DEV_ZONED
> -int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
> -			  unsigned lbaf);
> -
> +int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf);
>  int nvme_report_zones(struct gendisk *disk, sector_t sector,
>  		      unsigned int nr_zones, report_zones_cb cb, void *data);
>  
> @@ -779,9 +777,7 @@ static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,
>  	return BLK_STS_NOTSUPP;
>  }
>  
> -static inline int nvme_update_zone_info(struct gendisk *disk,
> -					struct nvme_ns *ns,
> -					unsigned lbaf)
> +static inline int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  {
>  	dev_warn(ns->ctrl->device,
>  		 "Please enable CONFIG_BLK_DEV_ZONED to support ZNS devices\n");
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 672a18fcf3bfe2..cdabc3eb192bad 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -46,11 +46,10 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
>  	return 0;
>  }
>  
> -int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
> -			  unsigned lbaf)
> +int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  {
>  	struct nvme_effects_log *log = ns->head->effects;
> -	struct request_queue *q = disk->queue;
> +	struct request_queue *q = ns->queue;
>  	struct nvme_command c = { };
>  	struct nvme_id_ns_zns *id;
>  	int status;
> 

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
