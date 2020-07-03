Return-Path: <SRS0=BHMv=AO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB05C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 13:41:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25B420826
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 13:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tr8ZdFfF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Wv0CsLHr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bBK3mbty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25B420826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ZJkO619IAOwl3qhT8WkNk5FY2tLz+YMenKcttJCfFAw=; b=tr8ZdFfFA6j1bOta+g+5b87gZ
	FWiJii44f/GM/ToPIBji1yreBG7IgfbYXIwrNdqv1yHK5x6E8Yg5ITbae0CULJL4I/ZzUVabtWFms
	8tDDCwCQWmR8IIwTST+N+Xha7WbmX595zZHNrt/mTMUqFryfH06RpaSzcZ4svSlk0Saz6jtNY/MWf
	P4XrLsiu+4V7b4mga9FZ9tI/a9AtwonYTclDYH/qO5gwI2XZQJxADDLa8S6k5q6eXdjcEuhEuCr+J
	X6b464cgyOKyrg/WhajxTXIZ2DFrOoKmigjssJyQ0qeIzcN6/GOuft0G2Odn1r/7I5DhSaK0gDAAO
	CROT41u1w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrLwR-0004ID-3i; Fri, 03 Jul 2020 13:41:23 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrLwM-0004He-36
 for linux-nvme@lists.infradead.org; Fri, 03 Jul 2020 13:41:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593783678; x=1625319678;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=aIUEzT+4BEUQWe/t6TZ7cUr+IAWqd1ZFu06AvzUJ/yM=;
 b=Wv0CsLHrobXyhiPjDnkMvqQ2Q1h3QgEtWYRyyij80NmWLCKCGTLreRtf
 3d3WI84AqfJ9mMOy/NmB0fJ7RKAfqEn/c+JMupO/zOLMpXDc9q5moXRcY
 zU/GH1JbQKfl6AN0HUwrfqSw9qNFaCfb2ddV9n3Pz5GYQWu1fqAehItJx
 J9s+MIKelS1z473cw3ypUUn0GOEf3fK3wnjDAeXIIvm+umPAK+XRqWIpc
 dInKPy/e9Uy1AqhMeHgcQom0yaVhbzud6ul9Qo0hpI+O7CYOf+y+p1u3n
 NFhDXPoySCoErtAwoF96fNSAPUC0z6BaQe7tp2sn6H6ms4NwLsdWJppMJ g==;
IronPort-SDR: d6V3jlkX4NKqImZVIfMSeNlT1SrCxnX9JgSytMLjxh+Psbi1zABocr/o6J5Gzb6hmftlFgEzMU
 yjwR6rjuwd/XBoy7EORXVLkiyKEZmeC5TYXSCl9mvJhHYmcpBbzEoVmKZh3rOH4WpALPPA/Jt1
 gaSqP5/wMjGQ87Ds73JxovEX29V8QWF6GObvSsZKV+z9wgpu6GzfN8ndEfs0NhQw8k4v8WG5O3
 gewQ8zCwDbb5rYeMlYgIYk2XU9T3+0L5XpJ5nIocBxIjgLSPsSAEeSrt/EEKaBB+gDfkHh/4x1
 lfs=
X-IronPort-AV: E=Sophos;i="5.75,308,1589212800"; d="scan'208";a="145911029"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 21:41:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW/epK6xGkv0hVTwMmr5L2MsuOd4b2mwspk3iR6ggO9tnm/LLsSGU8jfLKd1/oZJCYbDcBbH3CmRe1jW3xTgcsT9ctkH/M2AKJTwZA9VNKdoWAJalHTwh8a8lbNraDyHuU3732WDBuAKYgPPNGW53g9j3GLcBCgT/mt6wWEw8yZxSwGtshzDBU0p1ZaG1Y+egVhTaFZTJNQOLXG5EoleLsNzjSOBo01e5C15c2H/WdU1qwvSjSOF097K57WMxJHyZqSL2eZQRo9tHaUtWNjKHUNUjeis3RWDLvR3z1DIWXVHewrGPLfloC6aODv5NvIDwg4o3QkTs5jKmXBCPaf1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIe3d8i/Lj48zTZFVmS96ZJW6z3w9L9Z7WLXZULwSls=;
 b=AFYM/VeKSOkLXfesMtrGvALaOHSk5qJDyOp2EDI5+bQ00PEovKffDjfRio5IVvBnW65rUyqenivSCC5UTnugg3YW/PtcBcIQ/xIyGeoApZ/pYiqXPycK7w5w6MVYawP200svrVuTv4I3uK/MRCj99k5GqAzFYZNFh6/lI5mmGiBZ9cdEZom6Z80g7CDX0ONKuWez1qp7esbgYSTyeJxSddy9X7rQtq5XExJ8n+CsDHQqyh6VvA/4vVTbnFT07EJoHk7Gs2gqOOSgh+DJRhOs3NCCToPVjNokysMR4tnzy1XAs1hkmv7wuHPrEKTuKV8F/ZhLZzMHbHMU+Cuj4gxaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIe3d8i/Lj48zTZFVmS96ZJW6z3w9L9Z7WLXZULwSls=;
 b=bBK3mbty1FsSYK53UmSwGcqbmqWbNgJUqmYP74v5MxpqpatF9B1j42coMSg2PrKj7rp4RC5CWyYgiyLyeFZm/7gZbtBor4106+H2zVV7nLOjCTIiPTlQTUl/ZosAnmg9iP8nvxnwm7fdkatmV4aGWVUXOl7BmApYBRuCYuonkjE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3519.namprd04.prod.outlook.com
 (2603:10b6:803:46::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 3 Jul
 2020 13:41:13 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 13:41:13 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH v2 1/2] block: add max_open_zones to blk-sysfs
Thread-Topic: [PATCH v2 1/2] block: add max_open_zones to blk-sysfs
Thread-Index: AQHWUJ1laLSAJw11LUObxsrvIlcW1g==
Date: Fri, 3 Jul 2020 13:41:13 +0000
Message-ID: <SN4PR0401MB35983A6201A6E2AF2611FECD9B6A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702181922.24190-1-niklas.cassel@wdc.com>
 <20200702181922.24190-2-niklas.cassel@wdc.com>
 <SN4PR0401MB359886C77E3711DAF16D9B9F9B6A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200703092353.GA33841@localhost.localdomain>
 <SN4PR0401MB359801D165A0B9882B43B3719B6A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 528c3708-eb81-49c4-7f47-08d81f56c0c5
x-ms-traffictypediagnostic: SN4PR0401MB3519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3519CBABBB6FACD27274725A9B6A0@SN4PR0401MB3519.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B8is28mIbLp2LlKFEJthuAFIT/sX3CuK74xVpaqAOlUSBvf3jGx5yQnYR0IOjgYfv0cs9tjxY7fc46n1tfVGZ1G2wADxdEPQvs+Hcx5n9QZpcgVqVz6aEar0ExjVgEqy/+e+wwWWt2YpEBC3xQeNEd6nfV571c4RvhWPlvgdgowjQrDV6zmWs8d9O5kS1XgKhnB8vLnsU4v1s2rmq0zmDEU4u74MsqHi7DMaTbC97mAHPbyAufvbB2obM146KcXsa+G5y2NT9p2xaolxHmGHkGb/4v5b1eyQFOaTl2m9+Ir7aWT2AJ1qrItz8UEQdazN7AgFXhibHxrZhHFBTJ+u5g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(71200400001)(2906002)(4326008)(54906003)(316002)(83380400001)(6862004)(33656002)(186003)(7416002)(66446008)(66476007)(52536014)(91956017)(76116006)(86362001)(66946007)(9686003)(53546011)(26005)(6506007)(8936002)(6636002)(7696005)(55016002)(66556008)(64756008)(478600001)(8676002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: tCMYlUnzuNkSfhBFDmAguheqohMTL78IsVUYk2I6lCt2/wvq9NMhu0bf8lbIsm4fT59zX9mBviZP2TIYAtOAReRtz5MGn7nBKF2h0Nj8++Wm9w811ieFa/CZnt+TbyKxdjC2Le4/EHFMWc06v9bI7JFcnLSrdetbFEnssoYmnFXjOUG2OUYZuwubJsrhrKiLfJyiq+21wCS/ecY/Te8at91nTJ/m2Ssm/36DpqnRjvV59upsrOSaOfWDTE+fOyDnjXhW9/Xx0ekd9k8DVfkVqG5XA1dPojWlq4xA+fXCpH/cl0rAZnrPWlN1lQL1twSozBbUqlAhSTctpJqgj8iJfSGiL08Xt1trti4+p132JMZmcfU2f4ZuRWz0dexm7V48xmugbo3nVGa9L/hivqeERaErwzpX/UwvXz1OQwJA55NLap7X20IyR6SjHQiUK9v4MDzBYfVsJyiB71hBaBx2zElnwpdIy2LaRpt4NSVg7kD50VM0pVKYHWlTZCW+d6Fj
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528c3708-eb81-49c4-7f47-08d81f56c0c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 13:41:13.3250 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KUl4QosvNFeXGnoZuJn+nEUKuAs7xzWWfLYXQGelvdX0lJi9UFogxfv5vK0MPAsEhm+BbKPU2PdUSwIAAqfYcS9OW7YGrc7MVfN+NYEdcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3519
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200703_094118_450477_87639103 
X-CRM114-Status: GOOD (  26.06  )
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
Cc: Jens Axboe <axboe@kernel.dk>,
 =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 Sagi Grimberg <sagi@grimberg.me>, "Martin K.
 Petersen" <martin.petersen@oracle.com>, Jonathan Corbet <corbet@lwn.net>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 03/07/2020 14:09, Johannes Thumshirn wrote:
> On 03/07/2020 11:23, Niklas Cassel wrote:
>> On Fri, Jul 03, 2020 at 08:22:45AM +0000, Johannes Thumshirn wrote:
>>> On 02/07/2020 20:20, Niklas Cassel wrote:
>>>> Documentation/block/queue-sysfs.rst |  7 +++++++
>>>>  block/blk-sysfs.c                   | 15 +++++++++++++++
>>>>  drivers/nvme/host/zns.c             |  1 +
>>>>  drivers/scsi/sd_zbc.c               |  4 ++++
>>>>  include/linux/blkdev.h              | 16 ++++++++++++++++
>>>>  5 files changed, 43 insertions(+)
>>>
>>> Sorry I haven't noticed before, but you forgot null_blk.
>>
>> Hello Johannes,
>>
>> Actually, I haven't forgotten about null_blk :)
>>
>> The problem with null_blk is that, compared to these simple patches that
>> simply exposes the Max Open Zones/Max Active Zones, null_blk additionally
>> has to keep track of all the zone accounting, and give an error if any
>> of these limits are exceeded.
>>
>> null_blk right now follows neither the ZBC nor the ZNS specification
>> (even though it is almost compliant with ZBC). However, since null_blk
>> is really great to test with, we want it to support Max Active Zones,
>> even if that concept does not exist in the ZBC standard.
>>
>> To add to the problem, open() does not work exactly the same in ZBC and
>> ZNS. In ZBC, the device always tries to close an implicit zone to make
>> room for an explicit zone. In ZNS, a controller that doesn't do this is
>> fully compliant with the spec.
>>
>> So now for null_blk, you have things like zones being implicit closed when
>> a new zone is opened. And now we will have an additional limit (Max Active
>> Zones), that we need to consider before we can even try to close a zone.
>>
>>
>> I've spent a couple of days trying to implement this already, and I think
>> that I have a way forward. However, considering that vacations are coming
>> up, and that I have a bunch of other stuff that I need to do before then,
>> I'm not 100% sure that I will be able to finish it in time for the coming
>> merge window.
>>
>> Therefore, I was hoping that we could merge this series as is, and I will
>> send out the null_blk changes when they are ready, which might or might
>> not make it for this merge window.
> 
> No problem, I'm just working on MOR support for zonefs and though about how
> I'm going to test it. This is where I've noticed null_blk doesn't really 
> expose a config knob for MOR. I can do some temporary hacks to test my changes
> and wait for your's to materialize. 
> 
> 
>> In the meantime, MAR/MOR properties for null_blk will be exposed as 0,
>> which means "no limit". (Which is the case when a zoned block device driver
>> doesn't do an explicit call to blk_queue_max_{open,active}_zones()).
> 
> 

Another thing I've noticed, can you please introduce the bdev_max_open_zones() 
and bdev_max_open_reagions() functions as well?
Like this (untested):

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bb9e6eb6a7e6..612f4e36828d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1522,6 +1522,15 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
        return 0;
 }
 
+static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
+{
+       struct request_queue *q = bdev_get_queue(bdev);
+
+       if (q)
+               return queue_max_open_zones(q);
+       return 0;
+}
+
 static inline int queue_dma_alignment(const struct request_queue *q)
 {
        return q ? q->dma_alignment : 511;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
