Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28120C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:13:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED7121924
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V96EjZi8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="afzK4zqU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Y60hndL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED7121924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ki2PCJ1yRJLggg4PAoGvowkWR9DX2kcuFhYn73XRWyI=; b=V96EjZi8CMGmCMLAj1cbt574k
	S5vNk7Z9r67KHPmIp8wLVexn3qyw5F6mV6VQmnuJKJnfYGP2SMIP7n1cHUsf7eVPF5FV9l6a2L6Qg
	lhTGwaUYm1YuWRBljBREtquzF085S1bLuJtJq6lZBPMA17WPC+QVtVDJ6cYqTAIJ5+eQmXarBjZKf
	zViV4MsxQaOWmbzF2Du8uX8FJt0JO9zoeO+HTdlM+o2FCM1KZfVxdp8egzrSQebkpelNqZO6v6JBD
	VmlJPuJzKgcepS+/41CX8ypp0k2VpqZF6ZlWZvC/oprE/Y0rY81so2WFuBWByOdRYy5xXa7d6dY7v
	aMZWs9kiw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMtuY-0000ct-QM; Mon, 28 Sep 2020 14:13:50 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMtuW-0000cM-1e
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:13:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601302428; x=1632838428;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=+wqkTuxp0UbovhS4dAWup3FmfOVRRWCDwH/j+eeaCvw=;
 b=afzK4zqURviU4gnb3onWXBDA7cROpjkStT24v3gXY9Iytu39PuzLwKrl
 Qc4kXmbHEm3EmFgy8kV+PnS1YVL7RcdQtZhppOEOMQjQh3uQS9v8dccQM
 XqUncBOYxYKhMvA7/L/rmn3XJzi4lEU6R0Hb1kDsLr9iQ9GW30JHV40J+
 rT1rSQmRnDdqbrIIWQ0N2MerkTuY4sZqjXrgo28SB/baTLRZnvyy7NdS9
 /bg68F8KIzQ0pby/LCXdVUw46uLF6vt2d24dR6A89dU8lzVWRoCo6vjca
 zIXOmh5tu3IXNqJw/Nk7k7QLW2+011qKhT4XLGAoZb3Xp/MUNekGARe8C g==;
IronPort-SDR: uuo79xlarvk/v7Ko7NuNhI/5IWuJ0GqZfygw5KfT3vsIaujJcnZNq08rqUY+veF/VK86skCb3f
 hUkDiolC0azSkerk+OQvj9icIVr/EbHbXzcWuvN/0vhR26HfcE4ZVwGe33sTm0SpDuXV+qcK4P
 tn9fUFN4sKSZ7duYtAAUC+lh87VxejClCMoD2iYUWA+HPqzQwufxzQDOkZqDT2LcP/qY4PfPg/
 jAWDyfnhhW2QAPPzFmWqU7HJaiOPMfGMQg8NlQHNLDx/MSRm5IoIS4Kt41xgXmE8WHaQzO4XqG
 yDU=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="148468781"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 22:13:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbmdRkk0R4pf8i44RnM4/iVVOzjIMD0SZ+hyZH3x6yTTYlWQLw2LgUjVZz5e5QV//tXPk2j1hI+RjXEDYsCg8Xkyuf4VSqQDM60rkGoA5cyqKvLONxzcuMRqF3fhUlPkrXC8gXpESuYFDp4yjGM3Z+hmFMD1RchG+ehzLkvOfZaG4eo1dMwoKNdxttQqPqjdREbEy+Hgs+moMV8fAcniSU3v4Jj82FY4Kf3p0f0Ed9N0/BSAgujAXv1yhV7hnPboNVusnq12R0seCK6T2+OyMUrjtgg8reb3GOKVtoZPkCQhUPBklo+hKCPHL5gZIocqxV1LsKsW2wrWDPp8IL1DpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXgXXFBgg66pOztLIn35DRTVweMk9GbrUjyq08LfLUU=;
 b=DTdsu9k6AmfjBnSFBBpt5mYuG/jmc1+FMc9AHbOvSuP46pF61ZOwn7riXy2ybR6l8x/Ewxg6w29ITJo/Xrd//QVvsF0P3dzIUKHoPqwCes7NvaZ7LqIyXoaOz+QphQwzJXHL+xOfZe3jsI1Rlx51s9L1T0Ra6snrAPu/7JyTPK5jkMm+i3ha9Jy26mq0jHPWayFFQphk3aB0zY2BDh6KR2I+RIe0X+duuIafhg8x8A0c+x3lA8f2ZSmwnAFS+dYO3zhohQeUkLmn2UqnvU6NlgpDVYMqyRzqtnQMd8hnMnovY3aB/9IXdUMMTnX5cTKOi/zxXSvOAaj+T21/g5KgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXgXXFBgg66pOztLIn35DRTVweMk9GbrUjyq08LfLUU=;
 b=Y60hndL9CuLaUourZglnTUaGRnk4ow1mntCaIYQTezhcmhog+9fCZfOOV+g0MiP9/P8bzMkwHuN4wMwMtMExxh+31ltEHnsxn4N8yJvOkWGjogSomO8fQmVP0Ng4dWNRRB+VflhSPx05ixvmcLPc00mUxIMEc08dOLCw9YKgPHw=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3588.namprd04.prod.outlook.com (2603:10b6:910:90::35)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.24; Mon, 28 Sep
 2020 14:13:42 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:13:42 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 02/20] nvme: fix initialization of the zone bitmaps
Thread-Topic: [PATCH 02/20] nvme: fix initialization of the zone bitmaps
Thread-Index: AQHWlZPU7ec0MCLzLEKUFp3GJ4oXUQ==
Date: Mon, 28 Sep 2020 14:13:42 +0000
Message-ID: <CY4PR04MB3751DF6C5A70102EB2E4F1E1E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: a12418d7-32e4-4947-c9ee-08d863b8b4a6
x-ms-traffictypediagnostic: CY4PR0401MB3588:
x-microsoft-antispam-prvs: <CY4PR0401MB358865CFB11749612268A648E7350@CY4PR0401MB3588.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0T/gXOAWZ+LZHCfhx50EqAIiuPcTZU+Ho3Cr6o3qmRc+jq3fHk3BDSlZsOY4u/mR+ZfznKXFaW6ZseaimXg2bWSd+MEM9AoWyBxxrGyYSO+Br3IZ2IrygUkKUXdt2V/Ra+wdqXZ3sq6x03BfZbj/Z9CoOU9tI4OhY8f0NYT4V+EcuIETf2JYBetaxOyQGz169+Xg/EzjBY0nXwaUpfCpMT/rBGy3YrfRQXiyH0H8ZIKLp3rhh7AMBWVMDYMWMfbiaK911Mh0Tl4RQ9+s7DOvquyc7HJenxME+8t55Bwkogyb0cFb/xOYdBV7p1OYiZYlds1CqjgrOgeH1PdpGTK7V3cQXf7eueL3Rh5iV0l8uiVdfqvNY305awgCLfcJtSSD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(76116006)(186003)(52536014)(2906002)(86362001)(6506007)(7696005)(53546011)(71200400001)(83380400001)(316002)(8676002)(33656002)(110136005)(91956017)(5660300002)(64756008)(66476007)(478600001)(55016002)(8936002)(66446008)(66946007)(66556008)(4326008)(9686003)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: byllnB1hHgClkhZuMKOJvuh2HPn19EwZsjPs63XhX621P8xdJWvlch3dXZnTBbEMFIOozYjTltLhaV84pMzIVqeRNgjuLOR0FzArrlQWuQlRQoQChJMeTaWHI5bMOsxAPJQ0E3iMzm71EpR6bMsr6uGQyfwSrJWrFoPBBOQb0fOdSEFUEuqrUVFBIZLWaz1GCHMtZr6lhofGfKDlGNbow4Q9uagsCnQwOYVfCjTB9gdVS1+Ym/s9LgwBVaZls3S8E6kvy8eR6ULCSYb3QoL1xh85ulbzY7YR8fyH+SUVNLigOazU8hvUm1P6rayucefeE8Ou99GvZBoW3eU4/uQ5pVHTESlxnEanM8TZQXR8lsbGWEhIneh/mYlvrE9cYTmShRC4UzU+R3b4fmrvm4k1ryydb/wvGQ1MW0/+R49FBAU/cpp6XtmpfRmKtHnp+JgVq2zADoFYKZVQ3SenE5YxdA0Z+abJKI0uqIWn65CVebth7K/2pyqXgYBFPSdrZC5TTbuvYudeGojYakqoSMpTuAtNyiDVAmRxwFhFNn7KWfbc53KtYYX6UQYPPpFNErVjetkskDWkbi+tERzaCe9HrtMhoYafFaUyzgUzF42hO3fgpSw78jsNS0D6USxxPQZadJk67ufdgoZXEQ8x/fHDZM34s+ooqGojJPjgYmxyScfdyK/H5HDqyvxLIozYmN3KVG/LrOHLPcixloByElOSAg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12418d7-32e4-4947-c9ee-08d863b8b4a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:13:42.8137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PH7V8RhlH3cp3iuYzTRPf639qxDeuayZkS6JIIg4SeZvl8g0/3gN+R1yArSqdWfV7JlIf2EHCF7R5jY64TGrpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3588
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_101348_321004_E19A9E81 
X-CRM114-Status: GOOD (  21.54  )
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

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
