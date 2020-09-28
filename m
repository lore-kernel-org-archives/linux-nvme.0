Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3BFC2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:20:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184C921941
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gNeBMTG1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MSzKaoBS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AAU4TU3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184C921941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=tWebVZ/uchAEM6+NMxHdT0MNXIX+R4kYRxWQzzZlWu4=; b=gNeBMTG1rUl/rLaAjFun/zv1e
	vLDfGemPDsjXzSe5rx28xgM+hOkFJKfVi42zt6rvvIlHWEUj+vtSqfvi7SRjpanMftTUjGl/b4yO0
	VnrO5xEQBUJcZwskBa8xiF8fgQCEnSNIU1SXlCiZDeEny9HzLPe3yuFDE9fLm7UbEtrFupPgrcg96
	ofbzGUSXXVK2IpsPbfL2yZCswV4gwsawSJHV3qy9K6j8hExGqyG4h2+iWWV8I9oOUiKwU5l8PTI7t
	+cf4Egd0jb+Np7or6cpwVpyXls/7p7LdIh0MqxxcuKU6UWds0PlVZF/KJ8XvT/jlEo7aanT/2wI1J
	+EWrDOk0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMu0i-0001oC-09; Mon, 28 Sep 2020 14:20:12 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMu0d-0001mn-NS
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:20:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601302852; x=1632838852;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=tugAYpaIPhAl/Jgt/k8SjaSx/fU/ADjLQLldEpoE0kI=;
 b=MSzKaoBSG9jMYHcm/3bwHySwJUjCz++Tp5Dw5im5MQUq1ZE5LVgK5irG
 IPo2k7PC9rmptTQWVhD5vOZKd73D8kEogD6irGLEtaNQo6zkTHSzW1QEN
 7Cx/4OwKfHq9PevxRmA82yl9fk7EyhI8t5pJpQbPVup1KI2Z7Xfj0sFsQ
 rppnATjKoanc0mMN/pp6mGVPBck65F6b/aSEOvnu1CH6CunZycwOEBa4g
 +ipEtniDaKKGaPSpv+NokfyUCMBD7kDxOSYQ4Zc3wwbqeJ0JaDuLECyDw
 5OKA5Rs639lj0y1SXXQI4CY74BtHV+cxedCImJwj1Ts/2OJ+hS5KeYejx w==;
IronPort-SDR: rElXFG8B2fS/Iy6nEl8zZkTT3Cz/NscjTA7YImSJztpizU8lHJ1peuAR2pHqZwBhxy86RPuCw4
 QJ4X5gOTXlxRlq2huuONdLyrilpuYPyZiLWNobRcJaObAs9qOsgz5HY1SAu/XIfyyjrvZRzN5h
 9bkzonuF5t6/4v+ZT6LpGPbLnh10LoYmpngo4D1JLdw327BKfeu5Ai6dAl6ELa5ulpVmvHIHd6
 2s3ayrik0sSkBiOiIY2N+nXwRq0y5NC48OQtPsTd7Eaxe5bIq7X2qhrfLSTFGD//B3TqA9pZEE
 IZ0=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="251842811"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 22:20:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9YEltObobhs381rNx1u7I3hJUjpuD+Z00dD/kWhokaNZquEiIPHGP6GvepUVuBBG47q6EV3s/94lrpbMVVei8kBW+wBXwIDn3sWe7PWbg/V7xBiCpXICA9/wX4rbHxFlDiOh9brexqf4vtq+38IHvmTX4UV5V8xs1Zkn/D5hr2ORXbKnamfrpkt7ng2iIZTObv0ezTIStZlzu97QHFmg7TEeo96DvBT2SMv3Yxz+PNrv4+4auflZmN3b5q6A+gI0CMT7mTy8i3K8n9j/M1a3/JgMB5NgKrmN3mq2nFRK98W83x15o3jRTt5h7NLA6mX9g0vao3xJIl5xMSNkFCeag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yubf6IJCyQw9rXMUD/bL/rvlCZQl+5YNkcvvakHFIuw=;
 b=bjcDBLy6nqRdiovQibQpiiBHsP+iWJovyqgWUEq8HmRxWRX0Dfrx8j+DUJAe8o6F3msYSDLF6yb+pWLB/9XzhyjDhnYQS/ApurWSGoeesEditCArWVKh6Jawvx6tt1pJ4S2Yj0zOJ+tXf/TBIlip/O2we9HpD9Dkb+JvYLPtDMrqjWL85ZQyiAtdGlD+8wD5sd+2eiMmLFA6NmLydgPL17jgXrydgBwcUvmbu8nV9qEiAJAIQiciQBmNKb9FBrYNfb01ewXWQCFTSwH5/oezrFsO2uB3L6AhogRsqSZIOIuJNBedBwiIbaxhPDQ2ul5cnPxwMWJpYYWV9YYHHzGr8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yubf6IJCyQw9rXMUD/bL/rvlCZQl+5YNkcvvakHFIuw=;
 b=AAU4TU3y+6/DFQhNyddb/Vwv8HijA0cse95H41Gc9AOLxhTxeOpP/NogC06tQJ3JtXBPkSTJ+370o9veCt5aEjCn/QBu6SqQbKQQcPOm5vu1iTINvUYrmIqqxw3ZvrafZ1sTCqJuMvnZwz6/HjI3NN5TCGdFvabOLCUNl4J52Lw=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3636.namprd04.prod.outlook.com (2603:10b6:910:91::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Mon, 28 Sep
 2020 14:20:05 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:20:05 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 05/20] nvme: rename _nvme_revalidate_disk
Thread-Topic: [PATCH 05/20] nvme: rename _nvme_revalidate_disk
Thread-Index: AQHWlZPUT+h02EHg9kmJfUlEuep/ew==
Date: Mon, 28 Sep 2020 14:20:05 +0000
Message-ID: <CY4PR04MB37518032CACD4755588F7005E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65b3fb69-e945-43ff-6888-08d863b998ab
x-ms-traffictypediagnostic: CY4PR0401MB3636:
x-microsoft-antispam-prvs: <CY4PR0401MB36366F7671578AAC2BF7E64AE7350@CY4PR0401MB3636.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ea88JsGjvGprB+70VAeYw6S35vOs7mhV3YORVjMaX7VLdr+qdrP0vxeDUaxsoBoR6RyH97Dw7nm6++izGWqK3jl3VrmIUjQO+EKieUyPrk+BEeTQcttGmshKA/1HGzYrweX2KCREfYEPTCkMtvqQo3QlTRgz0KRyp543LHVHHw8e5crSMjN3yWVl4Ctk0pWvYqW2PNEoyVX0BLlynOWsgqcZc5MuvEu4lMsQwdPv7Eq1CRWjmZzEzv4FGBXgYs0C0bU7zOgOhG4kKV+0EgVZ64fu1l1XrwR9/397gK3UZN1y4KnkP6cTNeYIjq6kevUXrP8r+BPORASupZVpnod4Cu5vSur6u+AHnirBmYPPJDs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(5660300002)(83380400001)(54906003)(478600001)(186003)(110136005)(316002)(6506007)(53546011)(7696005)(91956017)(66946007)(71200400001)(86362001)(66446008)(76116006)(66476007)(66556008)(64756008)(52536014)(2906002)(33656002)(8936002)(4326008)(8676002)(9686003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: zj+rIp2tlzpINE5BUUSn48l766NajsiCUe/MpWA2TvIAcY8FeghOfLictZpLo+glyh4r3Q6J74yIIhDK+hK7pQiHJTub+Zo/ooFwei0TZgD4jDJ4gQN5HJgMACdwAve6ZY1sYojwOMeirOP4W0tT+KtHQVXWLiEefER2z9HbPKVM7CXgSF6VLbXuW0Jvsvt9YyXjNTA8NQsBD+/6GDNx/FuayDlj1a0ou8OOJwrRMybP3PoiS+RMCocIcUlx6okkZdqst/ICYUdBAKdw6B1N+FvD9DjLOO3DqQw4wtC9WGhRq+GGKgElsEcHaoluPn8M2YIuFeWkkLFsTJ7Uf9DiH2fIilKl73q8O7Jcky5qsFwFdqMy9F7NXqYk9SN4GdvKNyyyF7iQ0i2OjGoBwqC3p1oDAO350v/b+M3SwEVWcCI0EdzCNK5xqSEc2b8KriibvhiPyN01pGAGF++0wuwuT+shYm7h7XxU/3+0vsb3qsNdIXtMYdg+HO+Lns3sV9fi40WIOnmTkq6oxX6INij+umpQIwi1MgETirHzMSdmB4UTeP0hmFaesypHO5sbhY0PNUjM67e4UWbZKxkpldY1MVdfgvRtLyx24Km02muBoGUvw56Tg79PKZTHmKzi/NF9EZt6dXq+m0jv1hwFvqA/O+1Wboyed4oumT/iNi0rWpX69uL76Vz64qZHUhPrT+XTMCU4um9kywiq1DuA9RYG3w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b3fb69-e945-43ff-6888-08d863b998ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:20:05.3075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mAqgWlB+xJ90sqbDDUZ2kgz/WSnMlhEh6R3qHZijvZMkMhsww9EOnf7cvKv5i/X7WglGyHEM7lUQD7sywphknQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3636
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_102007_907657_C3099861 
X-CRM114-Status: GOOD (  18.65  )
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
> Rename _nvme_revalidate_disk to nvme_validate_ns to better describe
> what the function does, and pass the struct nvme_ns instead of the
> gendisk to better match the call chain.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c5f2615bf58374..c04043a94e6496 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -89,7 +89,7 @@ static dev_t nvme_chr_devt;
>  static struct class *nvme_class;
>  static struct class *nvme_subsys_class;
>  
> -static int _nvme_revalidate_disk(struct gendisk *disk);
> +static int nvme_validate_ns(struct nvme_ns *ns);
>  static void nvme_put_subsystem(struct nvme_subsystem *subsys);
>  static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>  					   unsigned nsid);
> @@ -1026,7 +1026,7 @@ static void nvme_update_formats(struct nvme_ctrl *ctrl, u32 *effects)
>  
>  	down_read(&ctrl->namespaces_rwsem);
>  	list_for_each_entry(ns, &ctrl->namespaces, list)
> -		if (_nvme_revalidate_disk(ns->disk))
> +		if (nvme_validate_ns(ns))
>  			nvme_set_queue_dying(ns);
>  		else if (blk_queue_is_zoned(ns->disk->queue)) {
>  			/*
> @@ -2154,16 +2154,15 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  	return 0;
>  }
>  
> -static int _nvme_revalidate_disk(struct gendisk *disk)
> +static int nvme_validate_ns(struct nvme_ns *ns)
>  {
> -	struct nvme_ns *ns = disk->private_data;
>  	struct nvme_ctrl *ctrl = ns->ctrl;
>  	struct nvme_id_ns *id;
>  	struct nvme_ns_ids ids;
>  	int ret = 0;
>  
>  	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
> -		set_capacity(disk, 0);
> +		set_capacity(ns->disk, 0);
>  		return -ENODEV;
>  	}
>  
> @@ -2187,7 +2186,7 @@ static int _nvme_revalidate_disk(struct gendisk *disk)
>  		goto free_id;
>  	}
>  
> -	ret = __nvme_revalidate_disk(disk, id);
> +	ret = __nvme_revalidate_disk(ns->disk, id);
>  free_id:
>  	kfree(id);
>  out:
> @@ -4032,7 +4031,7 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  		return;
>  	}
>  
> -	ret = _nvme_revalidate_disk(ns->disk);
> +	ret = nvme_validate_ns(ns);
>  	if (!ret && blk_queue_is_zoned(ns->queue))
>  		ret = nvme_revalidate_zones(ns);
>  	revalidate_disk_size(ns->disk, ret == 0);
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
