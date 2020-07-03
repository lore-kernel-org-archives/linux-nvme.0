Return-Path: <SRS0=BHMv=AO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA693C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 12:09:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C61B207D4
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 12:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mptdwB4V";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CLJTgIjS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rQh1beat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C61B207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=cVCV8vkl+PArRP6HJi6z5U6RRx4kP8ec0CbMRNE3IO4=; b=mptdwB4VhtByn7jyYdpwkk3QW
	CXuVNPcyUYJ6qhvnilTBWdspoG5T8LV3+J1G+gHbrJRetID9v6QdYBidqqFVkm85JpobkhZSgL3Ce
	mWmH+TWKTmif5oaQBWJ8xu54SlqZBggCDQ3Wn4dRjXkg02/Oga4YdgnsCwne41mN6ZOUDNDvDbqCd
	Gn/KzbEJNRT1Hgv4zJ5gxA5RaUjOd+GTaxIPLhKL3IeIgVPkvMKa9UJAJB6TzuZxtVLMB4vfMYPAg
	jhbjil+ij1Iazc0b0HaYiQUgzHOHjmoyoAIM7nGwmikyDy6JUDOHmjpG7SfjgkoDiaNwc85L2JRa+
	YsoU2qzDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrKVf-0001vg-7u; Fri, 03 Jul 2020 12:09:39 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrKVa-0001u5-LD
 for linux-nvme@lists.infradead.org; Fri, 03 Jul 2020 12:09:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593778174; x=1625314174;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=SfS+K5MTPTZIhplI+MGYFH12O6KVup+8QR4l4HmL+eI=;
 b=CLJTgIjSPNo0NV0zt8IFcUDwuHo/hBHfSfVSoDEaFDpS9kP/mOxf/OI3
 jgfQfdfPnNSxzhnxY8jLpGSMzXwsu0L4qxQoJ6kdHfODfUxNJUG05Ytvg
 B7GVD8HScmO/EAPjcM1QmZFZk2bIMGk5sQtf3120KBkclMgP6PGu3Nlyn
 med8p7YBJQhygJCohL8VJ8sbw0evDUxNZwbIwmusQNkpQa2JvSed15ME3
 ujjJbG4KYiNuKL1pnapWp1yzfbgtjew8z365wz7c2N5AhvAqfFWcCRKBN
 FBT5DZYqVai/YY4UbNcX/A/Poqur6bfuPHb29iWYTcTjx+FwTAKpVGPes Q==;
IronPort-SDR: lmmBmfUOval16CTT4O4qyuLEKa1/vpnl/lrdqaG6i7j6xRningeLYDu9OqSQgh2sqToylvfk5U
 Atjc9SoaHpSgGxSGkDf1D3k/EEjVjMpqKQMr11yROSdboyD0+AcCJzgMimlnRrb8DUR/8pbWRr
 zGMFwuSpksL1YVzyPM9WsIF+XasOjYRyAa2bMvelsAY6BdLl2uhynf8UNjGzHsdiuAtJjEA46l
 W01F4wv1CeGy5hM2UHZSMnFK9p/j+YEBUVmMStVpWAzIbmVGhzW4hjUDWW2rCYa/RXW9sEW7gA
 Bio=
X-IronPort-AV: E=Sophos;i="5.75,308,1589212800"; d="scan'208";a="141580301"
Received: from mail-bn3nam04lp2052.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.52])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 20:09:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n66OSmkv2kEsfM/Ln1ppXocQYO1K0cP/lQJg5oet9ZuhkjZUjECgFQRvM/BM6uoPai+QCzZPM5TDiBjdpJL6DBzICUdcL+Rv8cmi/jWuHCPsVHPzBX9X3aPxUJRkUG9Er5pUZ/TZiyz0WPyzbaClIj4zxwMGThr+RDRHVLUzT5x5idPemeO7l5CG+UkBNSilA7RALsp5sUr4HFKGFaOvA4AmBHjQmO+qq21y3hQ6vBUxyUCi+Azr6R1hO1StSWIE3uR2CQtkiSTYtiGabQyWqdVz8GhhcvqRc+uhneBkNQe3D7uITIuBbChjzXoaxH46onFAI5saazKcPUU4esWw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w10F6oAfULdcNMEWTN0Mi6P5uD958F92baLMWdJeN9c=;
 b=SGg3CPuNvAEPWyZJIoUnQCS/QJe3uefCp6N8cU4j9Xm1WQ1irlpM9EwxwKKMEqO4HvMB8jR4SZAsU4PpReY9MSiu7p9SjGjgHaUUVWATjDWLMdP72wTBX4Tgk+jV6KRkapXgwiyrr+4UNdeZXSVOm96D11YKr1Y/6KObhTTvbWKgQRa6I99gpsXwOChXwH+KI/SNXEr0ZlNjdJ+uye2w5sNP7qiGfT/22pDEgLi0/llGxk5AmJknl+r/4hMiJStosUwinHWi9L0GkvT0inyqB/Al6zlOHbfnkNMLOMxVKR589H7kEr7VbNU8f2pxt4oj5YHrenZuuG83tZnS52mT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w10F6oAfULdcNMEWTN0Mi6P5uD958F92baLMWdJeN9c=;
 b=rQh1beatMIyGPTumsXODKRT5jr6QFYDbZsEuwyKiHdLZffWbTvf4NdiaDzQIeRUKuUXylDstECKL7Q6b18xmrEUVj2NUPL1MU1aX9MX0lTmwX5Ztg9uKZ++RiWUBAtpNpx8qhfux/UpeDlMh2KQoa2HOuqlnhpi9r/8DIf4eh38=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4461.namprd04.prod.outlook.com
 (2603:10b6:805:ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 12:09:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 12:09:29 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH v2 1/2] block: add max_open_zones to blk-sysfs
Thread-Topic: [PATCH v2 1/2] block: add max_open_zones to blk-sysfs
Thread-Index: AQHWUJ1laLSAJw11LUObxsrvIlcW1g==
Date: Fri, 3 Jul 2020 12:09:29 +0000
Message-ID: <SN4PR0401MB359801D165A0B9882B43B3719B6A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702181922.24190-1-niklas.cassel@wdc.com>
 <20200702181922.24190-2-niklas.cassel@wdc.com>
 <SN4PR0401MB359886C77E3711DAF16D9B9F9B6A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200703092353.GA33841@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3dfaa944-a9a9-4990-bf38-08d81f49f070
x-ms-traffictypediagnostic: SN6PR04MB4461:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB44615F2758B78935B11E2E629B6A0@SN6PR04MB4461.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O+k/nqfHhf/fHqc0BERP1I/oYmJ5MBxRwkmR/7tBf81qxhYeP786eenYs5EP40kQ5Rcla5+ocqJStMhJg5k8D2/snNtbwB96sA7XGVJPRv2N5kToB+Mz3p1Dl8F0hfyHHbBg0ybDfYaYLlOJ9Xb05xaqjicnv+6h1OIBESTGU+TJtnGppCuCii/AfdYJNLB5OJzrAQnNIZn7/9nwPaK0cv5cFzbL81cFhr15y6nf6ZH1tixpwINtc5G8+obGLwInqVjtC7uvvlG6Bs9zQ+NVUWZEd2l7YhI3HwWP0tmktg4IQNQGWfpk04i5OLfhGoLYju9kgISqoJ9h4VIYf7dsGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(8676002)(8936002)(478600001)(5660300002)(2906002)(52536014)(7416002)(6862004)(71200400001)(76116006)(64756008)(91956017)(66946007)(66476007)(66556008)(66446008)(54906003)(55016002)(9686003)(6636002)(26005)(186003)(86362001)(4326008)(7696005)(316002)(6506007)(53546011)(83380400001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 2mHiQPS5zKMFY6rBZbxLRI429dulqXhIy1G5jRfJ357ZYe6JBvEnWpoR3QYa1AvsODIuIjwGuRr4FgBtO9Hg6lLGgaImENexCfuBDaQCYmtwpI+UPV5Loq1Zc/QN58/6w+SbdhV6ZVdrI25WZSo31Q0hotCXsfKQD/i+MCdG6V6Mb5M9yh0sdQeLHT14pPXwJL3v8gJIc50EVokh0aXsp+W0v5UA2ye4hudYJZ9spQXQAU96x2jDZZk2lExX1NlR6t2J3tIhZ1TdMG/6nFU1GDmRKnp57WdDM8ryzZ1XoFCjn81jnWx+Wg3XkKidvUNPJmIDOwGykpyBFdRYafZTuhInjkFE4gZvt0b4bu+Dh/7xqChdZ9SiRRwzYbzrF+pHKpD6McvezHCMhk5SUiliUoZgsr95IUf3vjDCBgsSfnKmjzmAC892n60mitmAGIlCD/34ybFGLHfXEgKX0abVLrc2KyhgoTdmwcEutE7Q9IaE9hHTjvUojggx6Ci+BFeW
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfaa944-a9a9-4990-bf38-08d81f49f070
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 12:09:29.9051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62akM7fmIZD5H6031culOFUlMnyLDYsMJXvB+doiJDaU5oSRad7m83vHtkqWbe/o1wkKUOhzDj+HKuifAJRY7ZKM2EgTB+aN35VU+UZGHOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4461
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200703_080934_982953_F8F41DD7 
X-CRM114-Status: GOOD (  26.84  )
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

On 03/07/2020 11:23, Niklas Cassel wrote:
> On Fri, Jul 03, 2020 at 08:22:45AM +0000, Johannes Thumshirn wrote:
>> On 02/07/2020 20:20, Niklas Cassel wrote:
>>> Documentation/block/queue-sysfs.rst |  7 +++++++
>>>  block/blk-sysfs.c                   | 15 +++++++++++++++
>>>  drivers/nvme/host/zns.c             |  1 +
>>>  drivers/scsi/sd_zbc.c               |  4 ++++
>>>  include/linux/blkdev.h              | 16 ++++++++++++++++
>>>  5 files changed, 43 insertions(+)
>>
>> Sorry I haven't noticed before, but you forgot null_blk.
> 
> Hello Johannes,
> 
> Actually, I haven't forgotten about null_blk :)
> 
> The problem with null_blk is that, compared to these simple patches that
> simply exposes the Max Open Zones/Max Active Zones, null_blk additionally
> has to keep track of all the zone accounting, and give an error if any
> of these limits are exceeded.
> 
> null_blk right now follows neither the ZBC nor the ZNS specification
> (even though it is almost compliant with ZBC). However, since null_blk
> is really great to test with, we want it to support Max Active Zones,
> even if that concept does not exist in the ZBC standard.
> 
> To add to the problem, open() does not work exactly the same in ZBC and
> ZNS. In ZBC, the device always tries to close an implicit zone to make
> room for an explicit zone. In ZNS, a controller that doesn't do this is
> fully compliant with the spec.
> 
> So now for null_blk, you have things like zones being implicit closed when
> a new zone is opened. And now we will have an additional limit (Max Active
> Zones), that we need to consider before we can even try to close a zone.
> 
> 
> I've spent a couple of days trying to implement this already, and I think
> that I have a way forward. However, considering that vacations are coming
> up, and that I have a bunch of other stuff that I need to do before then,
> I'm not 100% sure that I will be able to finish it in time for the coming
> merge window.
> 
> Therefore, I was hoping that we could merge this series as is, and I will
> send out the null_blk changes when they are ready, which might or might
> not make it for this merge window.

No problem, I'm just working on MOR support for zonefs and though about how
I'm going to test it. This is where I've noticed null_blk doesn't really 
expose a config knob for MOR. I can do some temporary hacks to test my changes
and wait for your's to materialize. 


> In the meantime, MAR/MOR properties for null_blk will be exposed as 0,
> which means "no limit". (Which is the case when a zoned block device driver
> doesn't do an explicit call to blk_queue_max_{open,active}_zones()).


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
