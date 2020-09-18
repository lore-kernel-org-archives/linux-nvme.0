Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9675C43463
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 13:32:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D9A206DB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 13:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d0oPAE/k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IHXgux0L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BVNBjgW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D9A206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=RnZ9td6N4cdnqOj0HlvKJzImCWy64MQnkP+1a73Fiv0=; b=d0oPAE/k4Hrpi61JcaiHeCzbL
	NgV3HFARPfdTyPxc0SKY5dJIL27uJpOgILoeefZYoUecdPkjGGULBCqkVSSDtBNYULN4PaN2mnj8B
	4qPa818HRI5dvzDkRJBKs1cQD38hgeKjPk66wSAoYR9kb455UjEnWN7QrJYd6GI8mzWudjMBLGkB9
	LB1rmOiuqxWefuJuBBgGPJ9tqRylbKbRec3mcsKp0NPKL1csa3bhzs+jmMe03u6ezj87ic62pMXHc
	OzgFTI6/ivoxR1xtgVN5R0vYxarZj2qRDziKzVTmh58ZPGa2oqBwiwKakjhjLg2uxFZ0pzukPgH8K
	oapXNJScA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJGUf-0002SA-Uh; Fri, 18 Sep 2020 13:32:06 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJGUP-0002KJ-8a
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 13:32:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600435909; x=1631971909;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=zX3b7iCZ8eISx1t3rMPplzVA7DEuIwyrXJ9cQ90GCIE=;
 b=IHXgux0Ld6x0eFCchrZRP5sRVTqrsrZxrOxFP7/TIuxoGXf+9LqT5f3o
 aOnxDWdPeF39vYPcTF5V1HFTvQtbVgZFVa1MelvMd5m/T+vNVOUSMkwmJ
 8mC2xyypTF1oPtdCrHIawlBCHx0cSZbAzFYMNsUJUMADvYAcuOk1arUOS
 xM8IYsJ1E0L4+LECdtOuYctKGObcXumDYPks0WlK89AlG495cOqsTUljQ
 zb5ovxg+AtR01dwtVnZ0PsoExwg/m85i0IhJwy9J1Y+sbNzB3bYLWdkMC
 xxbPNOdAE80sshuyM+XeW4HKLZuhE/ZhhInZseK3HKl9yIFih9xJuy5jL Q==;
IronPort-SDR: hQCg8ydzN9Ns/MTLRLRusEYMWWvyOsAgHiZ63qWrgINW/cm8kS73L7q+0IcYu2lIwLNCWx/uIS
 9k+Ke88RK3rKg4t7DtPhO40HR6aX75cgm1QCuO76MC8Xagypvl8Bph7k8iJKemfvszVGAMujxj
 Toa0n3uc9a6W0BGrAvMW5z/yLGcEVcgOXBKiSsr3aWilgRBE0hsZVtL8Nq0kdoHP1dyKvOMDbA
 1EdJxIFxYK1bzd8VaMf3FUIP5g4htjZKqW6DR6k9z3kOd6KdUF+UQYbRSm7uMuePHxj7cnSI3e
 WO8=
X-IronPort-AV: E=Sophos;i="5.77,274,1596470400"; d="scan'208";a="148958725"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
 by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2020 21:31:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBxHN1vu1usB8tWvW5HSMpN/ZVm54LQEEgv7UDaXlumXBxpfy4coTvkB+ZLmONCaifk0AX9HunsvfjfJXVHq9xO1AoZtnAUdYj7PHlWJ1/cgxQ9kLsjwNxOBks0GCxjTiXi3U/NO8cSkMl7eXZjk/rF9Lvj7txZC0BHB15mBLLc9+zCJJ3lgnNAa3knVpqYcJ3xMyCLA2y49hl300Bhd1q9KOJrGO0nQkRB2fXGTFEXzq2bzclo7gie8jJnMaoqE9q6KGDOkli077978rM2/MpIYGQ9jKPtqy0arXu2OYMNe4wIc0d7vdiykHOt6lczRsjy7ebPVnxaaOqmZZw4i6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdFH/5ixCZAsVOSbY5leC//retFE+u+8sFYZiHn65Os=;
 b=Xoo6M6HhOzFgn0UjSonIpCZjJRYx3Fz/trNTHE8pDlvuK/PJHwe/fA2a1Zs9V4jIqbjqPnjxCtR/qZDVk5Sj/IAIFsTUVJvqZEhxq+nQfh9spbZRoqPQzB8i8VJ4tLjh1qn+IttktrFuvDsVv64VC0+KeVsQL0ngaJiNmLzUko3F+drTM34Tec6ZOcKj2sAWKFIWD2ynt0n6I4mpLyQvG1jM9geqLpwj+47GACmb/VNLoBe+2l/XHoGOkxTRtCJvPYEfIuBWZv2y3hz/wJJrB+LhFkZjlteSYNg1WMRkwiQWw6PVKQlw6J5r1gBqV+cgss54J6j8lb/RlAas6NHe3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdFH/5ixCZAsVOSbY5leC//retFE+u+8sFYZiHn65Os=;
 b=BVNBjgW2m0hsRUaxEaSKRRpz6lreFqG3swBJcEgPblLqH0i+RuDjxrAwDucFYrYOHQUSpHH25u7b/U3qhD5gXIZfqdekqZioZ7+NbrRfpNRjQgK12Z7sx3qOEnMXGzM25ecyY2nivUv+QJ2NAk+iKyVp0m2I4WpQZvzQ8o9+nYw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3805.namprd04.prod.outlook.com
 (2603:10b6:805:4d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 13:31:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 13:31:44 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>
Subject: Re: [PATCHv3 1/4] block: add zone specific block statuses
Thread-Topic: [PATCHv3 1/4] block: add zone specific block statuses
Thread-Index: AQHWjUjpcQ/OOMMUgU+KxaV/geAZWA==
Date: Fri, 18 Sep 2020 13:31:44 +0000
Message-ID: <SN4PR0401MB35983DBC8B0B97A4083CDF8B9B3F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200917231841.4029747-1-kbusch@kernel.org>
 <20200917231841.4029747-2-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:8d9e:cb93:a2df:3de3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ae99d93-7f2e-4c2b-10d5-08d85bd72f77
x-ms-traffictypediagnostic: SN6PR04MB3805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB38055D1BB6821D70403B5D9D9B3F0@SN6PR04MB3805.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sl28JKC1AsRS6fDnDRf+MiYopHoLd5QVojKA3UCiBOVAgK3+sozexbUB40mbH7oBio17tO02/Uq71f+IdgpRNL/I3mtZW7M5781nDSB+BSzdQKQDvF9JRKQWrukAjJcI3c75rq5JTPORk5wXsmMKPn1dUvIIkrMEIbFGlHWnloxmypB4MYuaS0ZpLMVJNAL8vK4IPSbf6gE3J9LSsdXRnUsRnHWLHCgLGonAzRqTA73n3AZ908Kjjx8UMS1BbwJRnWRLpY4IM4XbVMbOumHVYnsQXqtlaKuTrUhtqBExuNycvPdb2twBU8gg9l9rpmy83NbDqSXqHI40ocDqij6dVA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(83380400001)(8676002)(91956017)(52536014)(2906002)(53546011)(86362001)(7696005)(55016002)(6506007)(9686003)(54906003)(110136005)(5660300002)(4326008)(478600001)(76116006)(66476007)(316002)(8936002)(66556008)(186003)(66446008)(71200400001)(66946007)(64756008)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 7pC2mL2S3nZqbxSf+dIHfwTJan9CGG3m7JnAfwT7bVZVdA67/OP852kOc7Vb5Xttdjy7WrBvJzc+gwPPWAaxQKfv/UdbmciKgqfyhR3cBjAmqN6AI7InzmlxQ9+JNLRuT498WVrHVh8GHU6h66Twdh66pfUrusw7DWKteQEsslzn6E/FImNFNybNYHQTHFrlMZ5npneLQLx+vmard6mF6VYxZmHFLNIuK5oeJe/NeR90yveaQVCYpVVVIW8fyEjkZjMez85Ys8lVpAp4ExJsA/zkcM+sjOmb7+HjrXxW4LsvIsZTz92Pr/sd3XeVtWoOta9oqoThvfDDbOCtxZiKT2bwvth9UFeIPHTl/jqLgzskOas1hqjQ6appHAkMIOOtwc26DSoLmeyqM4XD8yP6ocn0yMnZEYFx9It0HM10P5Ec79eFyXdwPHh6IYQTj7zA88wM4IWmZYFVMhfVROvQBwr8sOcaoYYCYS8zRRCkNcKPCKrJIrvY4Ly7D42w1BT0tAnpHbqRjcIsFMddYOdJi/o6IPUqHAYbYXosvAwJxdTc47PWrNTJxesHLSxWJQm4IzKU6hysPa31/3VhV0qE4RpWu6WFDfifKtQawXNKHFN32KSL2IH0g3zbb/BTq0bzYD3N3vHSp95U/E5SaaMH/jvpXBv/p0ShuiK6ct4MwnhuPGWg00ygzHCJXVKkKtbViIl0TSIVGPK203AKZu3bYQ==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae99d93-7f2e-4c2b-10d5-08d85bd72f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 13:31:44.3994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bP9YKWMndfrhoMn0k/oyS5iOB2JveLhCT2ZQ9HkpNrw/SD08xXAF0bC8/VYhgEaEUJVvhVmdfrLTzIjlQsy9o+L2BtPpZEL4ME7O+gSKK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3805
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200918_093149_444604_BBD6FDFA 
X-CRM114-Status: GOOD (  16.19  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 18/09/2020 01:18, Keith Busch wrote:
> diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
> index f261a5c84170..2638d3446b79 100644
> --- a/Documentation/block/queue-sysfs.rst
> +++ b/Documentation/block/queue-sysfs.rst
> @@ -124,6 +124,10 @@ For zoned block devices (zoned attribute indicating "host-managed" or
>  EXPLICIT OPEN, IMPLICIT OPEN or CLOSED, is limited by this value.
>  If this value is 0, there is no limit.
>  
> +If the host attempts to exceed this limit, the driver should report this error
> +with BLK_STS_ZONE_ACTIVE_RESOURCE, which user space may see as the EOVERFLOW
> +errno.
> +
>  max_open_zones (RO)
>  -------------------
>  For zoned block devices (zoned attribute indicating "host-managed" or
> @@ -131,6 +135,10 @@ For zoned block devices (zoned attribute indicating "host-managed" or
>  EXPLICIT OPEN or IMPLICIT OPEN, is limited by this value.
>  If this value is 0, there is no limit.
>  
> +If the host attempts to exceed this limit, the driver should report this error
> +with BLK_STS_ZONE_OPEN_RESOURCE, which user space may see as the ETOOMANYREFS
> +errno.

Don't we also need to update some man pages in section 2?

Code wise,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
