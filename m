Return-Path: <SRS0=c2UW=74=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FAFC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 23:46:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14942206DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 23:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J/WjLJwl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JeC2YUOv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LJqPSAC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14942206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ceJSwPBVyI1p4ci5068tC6+8lw4GvhxHcxKcE3gm7Jw=; b=J/WjLJwlAzEf6A
	upgInTe4HOu7V41Gyjw6ZLe7YjDyZfZ5qb1w+ZVK56ZrxMaVn4Cvq5KnTY7Tb1rQNHw1wR+P9TJ2S
	qE7ViUm5/qDpQj87aw0Gk7pxmfLmEEoVp/ZUz3ydTB0nicxcTsFz5AnDHQHC3nxsCfdtsaRleAvr8
	dNBvRhf8EYkxla76caNb/rNz5DAQ0mZw9bklZUHg2TbI03Mbki3oIWTXP29W66yM3jMRVo1kancT5
	FhHHIoCGbjsk+tmzcw0lRAzh8GzKcjsgjuCIfOlxxaKPXhCmyBxiwscL2fMhNmbG2phu4Ay/9zL/b
	LUtcQk1B/T3cw8bmj4uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jkyoC-0004XD-OE; Mon, 15 Jun 2020 23:46:32 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkyo9-0004Wt-Vs
 for linux-nvme@lists.infradead.org; Mon, 15 Jun 2020 23:46:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592264790; x=1623800790;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=tVUVNc9sbl9/bbpBzV9CmLSd206pRdXabr+3vVCtXYg=;
 b=JeC2YUOvjFvB5FmDWeAqFMGWnXs7psPS6LfZW5/AuhB9IyrCaElN/Jh6
 EnNOK/yGAijD2plm5eC9iZWi0fq107SbGn4chJFkq5K/osDtki0tFPbwx
 QrCASk/F29PzJ/UB4mIkoE0Fc3DRZ8R3ssQ3kK4ISqWZnPLvbnSiShUTX
 wsj7cC+Ihr99/Rxr3kFKl1or1r7IY22hyJntSujFxldMvWrWzhL2aYWEl
 lfcozkLgimdV0hSSR6JC/Bx/9J/I3H7D8ltfp0pnsdI8IEQiUiiIm65V4
 TgVX8LpfzJXCNmVEBNKiahuOr2KgULKGRPIWb9bVebktFD9cg9RnhvKOI w==;
IronPort-SDR: hYZ0t5WTLB2vvTNMgVttOJgAMJeIAtJB5s8ns/zeH0M16cmLsmVZtyCfz+fdyKADPlU0ubBf84
 0hw5+COF2CFQGEqdxd0TfutHxEPDp78DuucCkZFQlPBCiFPZs7byyjnl9ZTG3P+NHEQKV013m0
 6ieoPwTDjB/UThtA+1J7uCWxqLEuBN+vEyDXioCl/xgTyHuqpXKSCHYwPmAO0j7LTtUSHTfVLp
 g4CNP8hBjvn5UZDAxxP4HDAT3cw/Fpza2Kqyg2rdkB1iAc2aAKlWU/ABlGiKw6KKXPtfsdIaQc
 6KQ=
X-IronPort-AV: E=Sophos;i="5.73,516,1583164800"; d="scan'208";a="144394932"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 07:46:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dzxs47TSxCPgr5oyhJltH+/zvvdPVuRUfJEOrG75BKientRFp5zQhSzwsaPl9qIefPQBtfOKVPkQaET5SCc44JHqw7FT/bXln6Y6icesEampZgS+rDN/j6SoEjtfhFp7Q+FtBw02GIydLfzLUTpUiTs6puONv8LyVjuY1uLIldY/pLSDLOQPvYRhTTbbIaLGs4Dg4JGNJuo/fUZKdGCnOliGrNr/EXObQkRx6nD463JWlBQBpt0ope82dxJ07tEmxFHtLlMHiNDO2UNCSqxWNSeE6mYke1vhAjdxCdc+XU44xkTYCG5cbE2UU3+ndVO0LWezh+o5RiyS+euHaHyQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLEwv9b8J6eGd+cjaUn1MZ7nzn9XhBMJKVYLPvKh8Zc=;
 b=GFwXoKegIpYLmedw9A5QuTuEd2LRnBWm91NZNynP4hn22V826Jjun0lh8AY7fBQre7HGA3GtRW/1//lUvDwTpDB3Of90tB0+D8tdaSFSWFiFNYO+oNfwvUZSoA5skc9vedn+ONgzirXZelOfz/uvAa/7W/zoJqB2/Tf68HR1WeOj5wnQO+LcLFAqVzLovt+iozJM8YCpSeNXWpibqg0Smdi/rJrgHDu/ZIH3ravPIrsyRhQxk4kfp8Nd08M7fORpqL1ahw+ZJbdT7F87upN8T24fC7JctJ3xBj0SaUKNrLGPfzsEbPs13lbRmhE+p9Mdbojyeh+z+bpIgLpWKBxYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLEwv9b8J6eGd+cjaUn1MZ7nzn9XhBMJKVYLPvKh8Zc=;
 b=LJqPSAC5Mn1aFlp4xmR1XSvCqTT/VMMiewq9LwJAOYQvNmpzw2OhgnRzpT1k+FhBBZ7XHcBP+CExp8Zy5ujCSNG8ft4QQpymJzZj6HZFykq8Aly6cR2HnSSqqewk26C6UkZ1ArC1801rQz5UrSpRHYrjnD2Zfh7dL59zk0CVUNM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5334.namprd04.prod.outlook.com (2603:10b6:a03:c8::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Mon, 15 Jun
 2020 23:46:26 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 23:46:26 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <Keith.Busch@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/5] null_blk: introduce zone capacity for zoned device
Thread-Topic: [PATCH 2/5] null_blk: introduce zone capacity for zoned device
Thread-Index: AQHWQ22kUu9c0Grr/EKhSnAaI+KUeQ==
Date: Mon, 15 Jun 2020 23:46:25 +0000
Message-ID: <BYAPR04MB4965573D0109F13F1E6BA8D1869C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-3-keith.busch@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af1c9bca-82d7-4aa2-3190-08d81186519e
x-ms-traffictypediagnostic: BYAPR04MB5334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5334DA949AFA00F1221F7F13869C0@BYAPR04MB5334.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qgcq9idPYki2pfNLM4LgeOzyUL2PQHCnQiJAUt8RdhUpdvDfGP5AwRl/jE75RPkEmhSA3CcPxq2tw8WuiL3kpfcPHwD7RTret6TaDudCZrOn2utteD7GhviNzL2D/Knz02LoW1eOUPD6LoIDtPP4w0R5Bn1bUse2eROMpGc3ECSRzxILxstmYpPXSFkqpA7jVTJ/8rhUragEFlYbAZsKlREQetio35am3rGwpYGjf+P3Mij4gASZ8dwZ/drX2DTrqyXihpRaK6YPBRuMg8sBsTZw79x0Xq2P9ETkXBmPgJrIKT72dui2P657AYK4OI9m7O0AZyU5alSgKK9ZV9GmTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(7696005)(52536014)(478600001)(9686003)(54906003)(26005)(76116006)(66446008)(66556008)(2906002)(71200400001)(64756008)(66946007)(66476007)(8936002)(86362001)(316002)(110136005)(33656002)(8676002)(186003)(55016002)(83380400001)(5660300002)(4326008)(6506007)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: grL7mWqVW1uhZfYcUKZOJzqe2TJIoWnd6ZLAZVeQogZP2Sp+utlM83YdQcj8FN5Ber0zs8WmMQQBuH0Lo9EPZf1wQJTEuzswlCiId6AGvZWl3S0TDpat9STQLzM8yuovgTYGVgofdoPiDIHfTOKbbRHEqTRrcV5se4dYNlZtYAwPE5EWJv9hm4CjxQG7/sxPtXnVvpUUEBVQtXldT799tIXULEdRrNve5vJHXvR0X5vvtiwA8m8gSKbzbL/Art3ZbTnw3rQJOO63b/sn2LCD+S9p8emFPobHs3aly9mchjhH9gOKQbO1tH2K4QtogrnWkEbQzFds/e+WlRUIlUYAWiM98UiWdc0/8+fJ9C5dE90CCwtBLtO35iLE1WAJAqL0tyVDfX0/3xgHI35/9Yq3BOhVm1enNTBnTX8WaV16Au8CscfAns7fDe+5jqqgxY0cDHHyzCUTxYddoKIUDY50X63ZHM/uIMfiqWLGfVJszsI=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1c9bca-82d7-4aa2-3190-08d81186519e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 23:46:25.9930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1ctAq3obG6G6Vv18gXm7Hl+Jt4eLV29FZLCj0+C4kJYzA7Yi0LD+ojxbJo0+3EoWbkTmUtow+2y1qt1f5zYdsoivmsMPTRvq7NTFyeHojw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5334
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200615_164630_036927_C4C6055F 
X-CRM114-Status: GOOD (  19.02  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Apart from couple of nits this looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 6/15/20 4:35 PM, Keith Busch wrote:

> From: Aravind Ramesh <aravind.ramesh@wdc.com>
> 
> Allow emulation of a zoned device with a per zone capacity smaller than
> the zone size as as defined in the Zoned Namespace (ZNS) Command Set
> specification. The zone capacity defaults to the zone size if not
> specified and must be smaller than the zone size otherwise.
> 
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> ---
>   drivers/block/null_blk.h       |  2 ++
>   drivers/block/null_blk_main.c  |  9 ++++++++-
>   drivers/block/null_blk_zoned.c | 17 +++++++++++++++--
>   3 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
> index 81b311c9d781..7eadf190528c 100644
> --- a/drivers/block/null_blk.h
> +++ b/drivers/block/null_blk.h
> @@ -44,11 +44,13 @@ struct nullb_device {
>   	unsigned int nr_zones;
>   	struct blk_zone *zones;
>   	sector_t zone_size_sects;
> +	sector_t zone_capacity_sects;
>   
>   	unsigned long size; /* device size in MB */
>   	unsigned long completion_nsec; /* time in ns to complete a request */
>   	unsigned long cache_size; /* disk cache size in MB */
>   	unsigned long zone_size; /* zone size in MB if device is zoned */
> +	unsigned long zone_capacity; /* zone cap in MB if device is zoned */
>   	unsigned int zone_nr_conv; /* number of conventional zones */
>   	unsigned int submit_queues; /* number of submission queues */
>   	unsigned int home_node; /* home node for the device */
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
> index 87b31f9ca362..54c5b5df399d 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -200,6 +200,10 @@ static unsigned long g_zone_size = 256;
>   module_param_named(zone_size, g_zone_size, ulong, S_IRUGO);
>   MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned. Must be power-of-two: Default: 256");
>   
> +static unsigned long g_zone_capacity;
> +module_param_named(zone_capacity, g_zone_capacity, ulong, 0444);
> +MODULE_PARM_DESC(zone_capacity, "Zone capacity in MB when block device is zoned. Can be less than or equal to zone size. Default: Zone size");
> +
>   static unsigned int g_zone_nr_conv;
>   module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);
>   MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones when block device is zoned. Default: 0");
> @@ -341,6 +345,7 @@ NULLB_DEVICE_ATTR(mbps, uint, NULL);
>   NULLB_DEVICE_ATTR(cache_size, ulong, NULL);
>   NULLB_DEVICE_ATTR(zoned, bool, NULL);
>   NULLB_DEVICE_ATTR(zone_size, ulong, NULL);
> +NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
>   NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
>   
>   static ssize_t nullb_device_power_show(struct config_item *item, char *page)
> @@ -457,6 +462,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
>   	&nullb_device_attr_badblocks,
>   	&nullb_device_attr_zoned,
>   	&nullb_device_attr_zone_size,
> +	&nullb_device_attr_zone_capacity,
>   	&nullb_device_attr_zone_nr_conv,
>   	NULL,
>   };
> @@ -510,7 +516,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
>   
>   static ssize_t memb_group_features_show(struct config_item *item, char *page)
>   {
> -	return snprintf(page, PAGE_SIZE, "memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_nr_conv\n");
> +	return snprintf(page, PAGE_SIZE, "memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv\n");
This line is becoming ridiculously long even for new 100 char limit. 
Maybe we should do a cleanup patch for feature to string conversion.
>   }
>   
>   CONFIGFS_ATTR_RO(memb_group_, features);
> @@ -571,6 +577,7 @@ static struct nullb_device *null_alloc_dev(void)
>   	dev->use_per_node_hctx = g_use_per_node_hctx;
>   	dev->zoned = g_zoned;
>   	dev->zone_size = g_zone_size;
> +	dev->zone_capacity = g_zone_capacity;
>   	dev->zone_nr_conv = g_zone_nr_conv;
>   	return dev;
>   }
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
> index 624aac09b005..b05832eb21b2 100644
> --- a/drivers/block/null_blk_zoned.c
> +++ b/drivers/block/null_blk_zoned.c
> @@ -28,7 +28,17 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>   		return -EINVAL;
>   	}
>   
> +	if (!dev->zone_capacity)
> +		dev->zone_capacity = dev->zone_size;
> +
> +	if (dev->zone_capacity > dev->zone_size) {
> +		pr_err("null_blk: zone capacity %lu more than its size %lu\n",
> +					dev->zone_capacity, dev->zone_size);
> +		return -EINVAL;
> +	}
> +
>   	dev->zone_size_sects = dev->zone_size << ZONE_SIZE_SHIFT;
> +	dev->zone_capacity_sects = dev->zone_capacity << ZONE_SIZE_SHIFT;
Do we really need zone_capacity_sects ? As far as I can see its is not 
used into fast path, correct me if I'm wrong.
>   	dev->nr_zones = dev_size >>
>   				(SECTOR_SHIFT + ilog2(dev->zone_size_sects));
>   	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct blk_zone),
> @@ -60,7 +70,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>   
>   		zone->start = zone->wp = sector;
>   		zone->len = dev->zone_size_sects;
> -		zone->capacity = zone->len;
> +		zone->capacity = dev->zone_capacity_sects;
We can just dev->zone_capacity << ZONE_SIZE_SHIFT here.
>   		zone->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
>   		zone->cond = BLK_ZONE_COND_EMPTY;
>   
> @@ -187,6 +197,9 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>   			return BLK_STS_IOERR;
>   		}
>   
> +		if (zone->wp + nr_sectors > zone->start + zone->capacity)
> +			return BLK_STS_IOERR;
> +
>   		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
>   			zone->cond = BLK_ZONE_COND_IMP_OPEN;
>   
> @@ -195,7 +208,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>   			return ret;
>   
>   		zone->wp += nr_sectors;
> -		if (zone->wp == zone->start + zone->len)
> +		if (zone->wp == zone->start + zone->capacity)
>   			zone->cond = BLK_ZONE_COND_FULL;
>   		return BLK_STS_OK;
>   	default:
> 


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
