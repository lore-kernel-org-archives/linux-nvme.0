Return-Path: <SRS0=c/Ka=3J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851F4C32771
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jan 2020 05:13:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3604C2070C
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jan 2020 05:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LbntgCns";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HC8/kn9+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="evdnpV7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3604C2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=N55zUyGkHbnFlfskV8eFt5CjlXWgGI30mNUwsyoqpKU=; b=LbntgCnsmO3XEh
	bFHV9VLv6tIc78Sjv8f/+oEwg+nIMSrujHREhod9riB6M1BmHyP7FfQo9mLLmu+AzOOYO8Da50PO1
	O2kbDfanGT9HEAM2dsIstAQ7uvQyweIYlEkDivga5p9T0acOTAhEIZk1ot8K9pC0QuI9pfFVr0cer
	Wv6o6iCRlQ5Q/htdhKiFipFG5v3eA6FdppmX5BC3tWZlfHkh/izMROTqtuGxym9VmPp6sMsGOj7H5
	4xpcc1igUxIP5AntTOm7pRft9Cc8lWBHRj5FubJUfAARHTywkEDyZH4BSWvSxsvOC9IPlq0FPfL2n
	MEwWtZpntklSqDh9c34w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1itPNs-0001EU-4t; Mon, 20 Jan 2020 05:13:56 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1itPNn-0001Dw-NG
 for linux-nvme@lists.infradead.org; Mon, 20 Jan 2020 05:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1579497232; x=1611033232;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5oztdCSaY7yYSxEPm3Zo8lKxF/XK48NhYo0Xa06SBI8=;
 b=HC8/kn9+Pk+xpn4BekqrE0B6xdU3RYN0B0blRGrL93/5J7RVbQX0RwQY
 RljfFLAcnsfsshwbl8DghFZK2Jnhn/orZ12Gu+bx/5+W3BrFZ5iir9NhL
 pNXXwZkVblPaEM5eMr4tcPi3HbCNbsFPnTvHefDnYYXDdvsaFT4A5NAQK
 7HqV69Jw99JIoqL5iGGibsY1J6A/tll6hFRr5IYTWWxXGkVkbsq9o3qzh
 lf5vdJJK+oYDXWFTjRjaGVB5ejCsFLWrVQVftv582SDmW2FYLWJC+XAy0
 7eCu5POSRLFTVaiYfuuCqJCy0Pj9K5UVJgRiBdg+qU0442+iEP28XYkK9 w==;
IronPort-SDR: NPKyfK82GSc3YE41zhVGSTM8FO143Hw9lgy8/br9WFeCICsJ6sbsc4CoIhe73lcKzPfg/fH5SN
 ZBZMbWQ/uJy7ApWhvxx0se3Vku4ZE7r8Z1p30Sz90J0VB4DjnmUffSyQ+yYA5yiRbLMUfgtVXm
 p5y9zjXyXX19biQInvolD1iPQQ0+AKPc/NmfnJiKmJeJlZdC9dnXwvAYDV2x0cnSm0qBNuZGjo
 mo6sVPlwWzVMoihq3ii5DeXqh//2LQqoVMO1Wnp61xKd1xSX2yR0cedUYjo9DCg5yU7E6cNMwd
 J4o=
X-IronPort-AV: E=Sophos;i="5.70,340,1574092800"; d="scan'208";a="129461495"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2020 13:13:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnQZ/bv6xVRUNGkCoEcYJWqggiqhr1pugQYT0CluKymxey4dWWChHtL+9agW1GLE6TH4HUVocLuNNdGuSKGcBmnJj8kpHYYtt6buUQ3g7Mdc2uoGV5kIbssUxA4yryRuX+qYemvou0CiAHXcoHiUR+x6MAOsdkh2e7kcyYDKI1HYSrWHeaUc4k9qSFQfFEYIIkrXUygSZDlNJr5jFR7yDDJdz5X85uiX3VdpOseBdn/dnNB8aEuoBl6VYC9tgPBNcmIwSB0Fq/KZQUD8IQUQP+tJ2qC60q1O25WpLg63xLRUkpcQWm+qLEOfDSeGSwQWxWDuK2cxeTyN9SMjOBd0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B1tTedf9yvw3GZbeYRQ3Q2IecahguQDvTDK/B2fF0s=;
 b=DQ4RzLdDf0kwhnFGpvXTpiSJDMs+96JevxtKpqeNFlLR4Z2JEhP/9GN5yVoQ/dchBrqVOQmdZbsfBHuVeujFEkmeUSXPxDj3l1xqkDnKwL45Y14u+VFdon17ailu0KaBGajaNLm1jKk7FeCPvYQw03aEQxI6tb/kjA/EC1L1MpzUe9+YRoyx4d3cdWTEwWEkmum7QwYEt1zst2+HzIQZiq45XNCqGfb5vwqw525v1CNeCdNFCaZLEKRCh3XGcyvb9xhI/83X/s6JofJ9gwp+w3PJBQeFReWbFUVOsXX/H3S3nKXFt9+hLGLf+E+y7szzCjBBQJ9MGjtiZXvNU5C95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B1tTedf9yvw3GZbeYRQ3Q2IecahguQDvTDK/B2fF0s=;
 b=evdnpV7sYBC2RTWj41lSGTlqnNEE1y92fNdDKJg/jG5PsFrcUSmgvDIsRepgJy5UehCpDfgM8a116iytD6eeGLtgUSej8WVnw043fUGthUyHS9bBSpF8uqvqi4w+xVX7aNm48vWEZQuuRtBInxkXG3GLgyBgmjJmVu53SYkPhxU=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5080.namprd04.prod.outlook.com (52.135.234.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:13:46 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 05:13:46 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH 0/2] nvmet: add polling support
Thread-Topic: [RFC PATCH 0/2] nvmet: add polling support
Thread-Index: AQHVryK85gJ3GKafwE2Wl4D0J6eouQ==
Date: Mon, 20 Jan 2020 05:13:46 +0000
Message-ID: <BYAPR04MB57493E67C9E76DE203F8982886320@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191210062557.5171-1-chaitanya.kulkarni@wdc.com>
 <fe370161-13d7-a005-2666-968107be13bd@grimberg.me>
 <BYAPR04MB57495A09DE5E7652E2B38AAF86550@BYAPR04MB5749.namprd04.prod.outlook.com>
 <ed3638c6-7506-4ac6-a2ab-df432b2111b6@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d820df8-f9d6-4b10-dbf1-08d79d6786c9
x-ms-traffictypediagnostic: BYAPR04MB5080:
x-microsoft-antispam-prvs: <BYAPR04MB5080E60DD6858E78DD7BA05286320@BYAPR04MB5080.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(478600001)(316002)(2906002)(71200400001)(26005)(186003)(9686003)(55016002)(81166006)(81156014)(76116006)(66476007)(64756008)(66446008)(66556008)(110136005)(66946007)(4326008)(8676002)(8936002)(52536014)(5660300002)(86362001)(7696005)(30864003)(33656002)(53546011)(6506007)(579004)(559001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5080;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZW0w2xXEv7GE36vvQhGYBOs5bFSRPr599p4TgB8SOiHqWuo2lqQOYAuNDmxKMv390nMeLzMJ56zzybJ02d68V9TFrjVP9xb9jkQtx2K2bFJ2yrtw9Eegs3OtBPWmdk3T581vN9QKREmruuumPSrNePT/jW86QTHk5iOl6n9ulRjnE9N4sO+Yx1UKxoGFzvbR1NrYTffCagcJvvk6Ot9EWQDCVvDfOtPNIHKxW+0rcpVTjYsPHsQm3sitYZdIQuMtxmN3ZlLYw6n9vkPhte8UGNhKqze8nKTfUvIFJAsEsNJPU75pvtE2cobkv7PTAIlL/ybjUDf0DiedXqQ3o82yp2whIcLyRAlu1tu64Tyjghp9u2wiz0D/Su93L8ejEOPJzw04YQNbtQZJZflO3OMv9QnVX4pifp5gQEe0U4JcWgSXHsHI92ezDgOZwfwr4yjC
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d820df8-f9d6-4b10-dbf1-08d79d6786c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:13:46.2324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0K/DTvOTOm+Xn7uGm+xx7/Au9bZMmUxUyiFsZwAZU5inppqG7y0u/65QgkZDO+dWPCOyAXk0VS4xWgm+vpizQrb6pRwelS81s7IxJDDnE/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200119_211351_844500_6743FBDA 
X-CRM114-Status: GOOD (  17.03  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/12/2019 12:32 PM, Sagi Grimberg wrote:
>>> >>percpu threads per namespace? Sounds like the wrong approach. These
>>> >>threads will compete for cpu time with the main nvmet contexts.
>>> >>
>> >That make sense, how about a global threadpool for target which can be
>> >shared between all the subsystem and their name-spaces just like we
>> >have buffered_io_wq?
>>> >>Have you considered having the main nvmet contexts incorporate polling
>>> >>activity between I/Os? Don't have a great dea on how to do it from first
>>> >>thought...
>>> >>
>> >
>> >I am not able to understand nvmet context, can you please elaborate ?
>> >Are you referring to the pattern we one have in the
>> >nvme_execute_rq_polled() ?
> No, we would want non-selective polling. Right now we have nvmet context
> starting from the transport going to submit I/O to the backend, or
> starting from the backend going to submit to the transport.
>
> Ideally, we'd have these contexts to do the polling instead of a
> different thread that will poll for as much as it can taking away
> cpu time?
>
> One way to do it is to place a intermediate thread that will sit between
> the transport and the backend but that would yield an additional context
> switch in the I/O path (not ideal).
>
Yes not ideal.

I took numbers on the following patch and I can see
performance improved when enabled polling in QEMU with
nvme-loop.

#nvme list | tr -s ' ' ' '
/dev/nvme0n1 foo QEMU NVMe Ctrl 1 2.10 MB / 2.10 MB 1 B + 9 B 1.0
/dev/nvme1n1 6e79351962f851ad Linux 1 2.10 MB / 2.10 MB 1 B + 9 B 5.5.0-rc

We can see that CPU percentage has gone up to the saturation point
and increase in BW and IOPS.

IOPS/BW:-

Default:-
read: IOPS=52.8k, BW=206MiB/s (216MB/s)(6188MiB/30001msec)
read: IOPS=54.3k, BW=212MiB/s (223MB/s)(6369MiB/30001msec)
read: IOPS=53.5k, BW=209MiB/s (219MB/s)(6274MiB/30001msec)
Poll:-
read: IOPS=68.4k, BW=267MiB/s (280MB/s)(8011MiB/30001msec)
read: IOPS=69.3k, BW=271MiB/s (284MB/s)(8124MiB/30001msec)
read: IOPS=69.4k, BW=271MiB/s (284MB/s)(8132MiB/30001msec)

mpstat:-
Default:-
CPU %usr %nice |%sys| %iowait %irq %soft %steal %guest %gnice %idle
---------------------------------------------------------
all 1.18 0.00 |60.14| 0.00 0.00 0.00 0.08 0.00 0.00 38.60
---------------------------------------------------------
0 0.00 0.00 | 32.00 |0.00 0.00 0.00 0.00 0.00 0.00 68.00
1 1.01 0.00 | 42.42 |0.00 0.00 0.00 0.00 0.00 0.00 56.57
2 1.01 0.00 | 57.58 |0.00 0.00 0.00 0.00 0.00 0.00 41.41
3 2.02 0.00 | 79.80 |0.00 0.00 0.00 0.00 0.00 0.00 18.18
4 1.01 0.00 | 63.64 |0.00 0.00 0.00 0.00 0.00 0.00 35.35
5 3.09 0.00 | 63.92 |0.00 0.00 0.00 0.00 0.00 0.00 32.99
6 2.02 0.00 | 75.76 |0.00 0.00 0.00 0.00 0.00 0.00 22.22
7 1.02 0.00 | 57.14 |0.00 0.00 0.00 0.00 0.00 0.00 41.84
8 0.00 0.00 | 67.01 |0.00 0.00 0.00 0.00 0.00 0.00 32.99
9 1.01 0.00 | 59.60 |0.00 0.00 0.00 0.00 0.00 0.00 39.39
10 1.02 0.00| 62.24 |0.00 0.00 0.00 0.00 0.00 0.00 36.73
11 1.02 0.00| 62.24 |0.00 0.00 0.00 0.00 0.00 0.00 36.73

Poll:-
CPU %usr %nice |%sys| %iowait %irq %soft %steal %guest %gnice %idle
---------------------------------------------------------
all 1.08 0.00 98.08 0.00 0.00 0.00 0.08 0.00 0.00 0.75
---------------------------------------------------------
0 2.00 0.00 | 97.00 |0.00 0.00 0.00 0.00 0.00 0.00 1.00
1 0.00 0.00 | 97.00 |0.00 0.00 0.00 0.00 0.00 0.00 3.00
2 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
3 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
4 1.01 0.00 | 98.99 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
5 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
6 0.99 0.00 | 99.01 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
7 1.00 0.00 | 97.00 |0.00 0.00 0.00 0.00 0.00 0.00 2.00
8 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
9 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
10 1.98 0.00| 94.06 |0.00 0.00 0.00 0.00 0.00 0.00 3.96
11 1.00 0.00| 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00

Any thoughts ?


Patch :-
diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index 2b33836f3d3e..8877ba16305c 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -10,7 +10,8 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
  obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o

  nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
-			discovery.o io-cmd-file.o io-cmd-bdev.o
+			discovery.o io-cmd-file.o io-cmd-bdev.o \
+			io-poll.o
  nvme-loop-y	+= loop.o
  nvmet-rdma-y	+= rdma.o
  nvmet-fc-y	+= fc.o
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..0e6e8b0dbf79 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -545,6 +545,34 @@ static ssize_t nvmet_ns_buffered_io_store(struct 
config_item *item,

  CONFIGFS_ATTR(nvmet_ns_, buffered_io);

+static ssize_t nvmet_ns_use_poll_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_nvmet_ns(item)->use_poll);
+}
+
+static ssize_t nvmet_ns_use_poll_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	bool val;
+
+	if (strtobool(page, &val))
+		return -EINVAL;
+
+	mutex_lock(&ns->subsys->lock);
+	if (ns->enabled) {
+		pr_err("disable ns before setting use_poll value.\n");
+		mutex_unlock(&ns->subsys->lock);
+		return -EINVAL;
+	}
+
+	ns->use_poll = val;
+	mutex_unlock(&ns->subsys->lock);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, use_poll);
+
  static struct configfs_attribute *nvmet_ns_attrs[] = {
  	&nvmet_ns_attr_device_path,
  	&nvmet_ns_attr_device_nguid,
@@ -552,6 +580,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
  	&nvmet_ns_attr_ana_grpid,
  	&nvmet_ns_attr_enable,
  	&nvmet_ns_attr_buffered_io,
+	&nvmet_ns_attr_use_poll,
  #ifdef CONFIG_PCI_P2PDMA
  	&nvmet_ns_attr_p2pmem,
  #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..af91240b1a1f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -510,6 +510,18 @@ static void nvmet_p2pmem_ns_add_p2p(struct 
nvmet_ctrl *ctrl,
  		ns->nsid);
  }

+inline void nvmet_req_poll(struct nvmet_req *req)
+{
+	if (req->ns->bdev)
+		nvmet_req_bdev_poll(req);
+}
+
+inline void nvmet_req_poll_complete(struct nvmet_req *req)
+{
+	if (req->ns->bdev)
+		nvmet_bdev_req_complete(req);
+}
+
  int nvmet_ns_enable(struct nvmet_ns *ns)
  {
  	struct nvmet_subsys *subsys = ns->subsys;
@@ -653,6 +665,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys 
*subsys, u32 nsid)

  	uuid_gen(&ns->uuid);
  	ns->buffered_io = false;
+	ns->use_poll = false;

  	return ns;diff --git a/drivers/nvme/target/Makefile 
b/drivers/nvme/target/Makefile
index 2b33836f3d3e..8877ba16305c 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -10,7 +10,8 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
  obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o

  nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
-			discovery.o io-cmd-file.o io-cmd-bdev.o
+			discovery.o io-cmd-file.o io-cmd-bdev.o \
+			io-poll.o
  nvme-loop-y	+= loop.o
  nvmet-rdma-y	+= rdma.o
  nvmet-fc-y	+= fc.o
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..0e6e8b0dbf79 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -545,6 +545,34 @@ static ssize_t nvmet_ns_buffered_io_store(struct 
config_item *item,

  CONFIGFS_ATTR(nvmet_ns_, buffered_io);

+static ssize_t nvmet_ns_use_poll_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_nvmet_ns(item)->use_poll);
+}
+
+static ssize_t nvmet_ns_use_poll_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	bool val;
+
+	if (strtobool(page, &val))
+		return -EINVAL;
+
+	mutex_lock(&ns->subsys->lock);
+	if (ns->enabled) {
+		pr_err("disable ns before setting use_poll value.\n");
+		mutex_unlock(&ns->subsys->lock);
+		return -EINVAL;
+	}
+
+	ns->use_poll = val;
+	mutex_unlock(&ns->subsys->lock);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, use_poll);
+
  static struct configfs_attribute *nvmet_ns_attrs[] = {
  	&nvmet_ns_attr_device_path,
  	&nvmet_ns_attr_device_nguid,
@@ -552,6 +580,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
  	&nvmet_ns_attr_ana_grpid,
  	&nvmet_ns_attr_enable,
  	&nvmet_ns_attr_buffered_io,
+	&nvmet_ns_attr_use_poll,
  #ifdef CONFIG_PCI_P2PDMA
  	&nvmet_ns_attr_p2pmem,
  #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..af91240b1a1f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -510,6 +510,18 @@ static void nvmet_p2pmem_ns_add_p2p(struct 
nvmet_ctrl *ctrl,
  		ns->nsid);
  }

+inline void nvmet_req_poll(struct nvmet_req *req)
+{
+	if (req->ns->bdev)
+		nvmet_req_bdev_poll(req);
+}
+
+inline void nvmet_req_poll_complete(struct nvmet_req *req)
+{
+	if (req->ns->bdev)
+		nvmet_bdev_req_complete(req);
+}
+
  int nvmet_ns_enable(struct nvmet_ns *ns)
  {
  	struct nvmet_subsys *subsys = ns->subsys;
@@ -653,6 +665,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys 
*subsys, u32 nsid)

  	uuid_gen(&ns->uuid);
  	ns->buffered_io = false;
+	ns->use_poll = false;

  	return ns;
  }
diff --git a/drivers/nvme/target/io-cmd-bdev.c 
b/drivers/nvme/target/io-cmd-bdev.c
index b6fca0e421ef..317c9b427b71 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -49,10 +49,11 @@ void nvmet_bdev_set_limits(struct block_device 
*bdev, struct nvme_id_ns *id)

  int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
  {
+	int fmode = FMODE_READ | FMODE_WRITE;
+	struct request_queue *q;
  	int ret;

-	ns->bdev = blkdev_get_by_path(ns->device_path,
-			FMODE_READ | FMODE_WRITE, NULL);
+	ns->bdev = blkdev_get_by_path(ns->device_path, fmode, NULL);
  	if (IS_ERR(ns->bdev)) {
  		ret = PTR_ERR(ns->bdev);
  		if (ret != -ENOTBLK) {
@@ -60,16 +61,21 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
  					ns->device_path, PTR_ERR(ns->bdev));
  		}
  		ns->bdev = NULL;
-		return ret;
+		goto out;
  	}
  	ns->size = i_size_read(ns->bdev->bd_inode);
  	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
-	return 0;
+	q = bdev_get_queue(ns->bdev);
+	ns->poll = ns->use_poll && test_bit(QUEUE_FLAG_POLL, &q->queue_flags);
+	ret = ns->poll ? nvmet_ns_start_poll(ns) : 0;
+out:
+	return ret;
  }

  void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
  {
  	if (ns->bdev) {
+		ns->poll ? nvmet_ns_stop_poll(ns) : 0;
  		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
  		ns->bdev = NULL;
  	}
@@ -133,15 +139,34 @@ static u16 blk_to_nvme_status(struct nvmet_req 
*req, blk_status_t blk_sts)
  	return status;
  }

-static void nvmet_bio_done(struct bio *bio)
+void nvmet_bdev_req_complete(struct nvmet_req *req)
  {
-	struct nvmet_req *req = bio->bi_private;
+	struct bio *bio = req->b.last_bio;

  	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
  	if (bio != &req->b.inline_bio)
  		bio_put(bio);
  }

+static void nvmet_bio_done(struct bio *bio)
+{
+	struct nvmet_req *req = bio->bi_private;
+
+	req->b.last_bio = bio;
+
+	req->poll ? complete(&req->wait) : nvmet_bdev_req_complete(req);
+}
+
+void nvmet_req_bdev_poll(struct nvmet_req *req)
+{
+	struct request_queue *q = bdev_get_queue(req->ns->bdev);
+	int ret = blk_poll(q, req->b.cookie, true);
+
+	if (ret < 0) {
+		pr_err("tid %d poll error %d", req->t->id, ret);
+	}
+}
+
  static void nvmet_bdev_execute_rw(struct nvmet_req *req)
  {
  	int sg_cnt = req->sg_cnt;
@@ -185,7 +210,8 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
  	bio->bi_end_io = nvmet_bio_done;
  	bio->bi_opf = op;

-	blk_start_plug(&plug);
+	if (!req->poll)
+		blk_start_plug(&plug);
  	for_each_sg(req->sg, sg, req->sg_cnt, i) {
  		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
  				!= sg->length) {
@@ -204,8 +230,16 @@ static void nvmet_bdev_execute_rw(struct nvmet_req 
*req)
  		sg_cnt--;
  	}

-	submit_bio(bio);
-	blk_finish_plug(&plug);
+	req->b.last_bio = bio;
+	if (req->poll)
+		req->b.last_bio->bi_opf |= REQ_HIPRI;
+
+	req->b.cookie = submit_bio(bio);
+
+	nvmet_req_prep_poll(req);
+	nvmet_req_issue_poll(req);
+	if (!req->poll)
+		blk_finish_plug(&plug);
  }

  static void nvmet_bdev_execute_flush(struct nvmet_req *req)
@@ -330,15 +364,19 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
  	switch (cmd->common.opcode) {
  	case nvme_cmd_read:
  	case nvme_cmd_write:
+		req->poll = req->ns->poll;
  		req->execute = nvmet_bdev_execute_rw;
  		return 0;
  	case nvme_cmd_flush:
+		req->poll = false;
  		req->execute = nvmet_bdev_execute_flush;
  		return 0;
  	case nvme_cmd_dsm:
+		req->poll = false;
  		req->execute = nvmet_bdev_execute_dsm;
  		return 0;
  	case nvme_cmd_write_zeroes:
+		req->poll = false;
  		req->execute = nvmet_bdev_execute_write_zeroes;
  		return 0;
  	default:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e837c9..e5991e36ed6f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -49,11 +49,22 @@
  #define IPO_IATTR_CONNECT_SQE(x)	\
  	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))

+struct nvmet_poll_data {
+	struct completion		thread_complete;
+	wait_queue_head_t		poll_waitq;
+	struct mutex			list_lock;
+	struct task_struct		*thread;
+	struct list_head		list;
+	struct list_head		done;
+	unsigned int			id;
+};
+diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index 2b33836f3d3e..8877ba16305c 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -10,7 +10,8 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
  obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o

  nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
-			discovery.o io-cmd-file.o io-cmd-bdev.o
+			discovery.o io-cmd-file.o io-cmd-bdev.o \
+			io-poll.o
  nvme-loop-y	+= loop.o
  nvmet-rdma-y	+= rdma.o
  nvmet-fc-y	+= fc.o
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..0e6e8b0dbf79 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -545,6 +545,34 @@ static ssize_t nvmet_ns_buffered_io_store(struct 
config_item *item,

  CONFIGFS_ATTR(nvmet_ns_, buffered_io);

+static ssize_t nvmet_ns_use_poll_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_nvmet_ns(item)->use_poll);
+}
+
+static ssize_t nvmet_ns_use_poll_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	bool val;
+
+	if (strtobool(page, &val))
+		return -EINVAL;
+
+	mutex_lock(&ns->subsys->lock);
+	if (ns->enabled) {
+		pr_err("disable ns before setting use_poll value.\n");
+		mutex_unlock(&ns->subsys->lock);
+		return -EINVAL;
+	}
+
+	ns->use_poll = val;
+	mutex_unlock(&ns->subsys->lock);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, use_poll);
+
  static struct configfs_attribute *nvmet_ns_attrs[] = {
  	&nvmet_ns_attr_device_path,
  	&nvmet_ns_attr_device_nguid,
@@ -552,6 +580,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
  	&nvmet_ns_attr_ana_grpid,
  	&nvmet_ns_attr_enable,
  	&nvmet_ns_attr_buffered_io,
+	&nvmet_ns_attr_use_poll,
  #ifdef CONFIG_PCI_P2PDMA
  	&nvmet_ns_attr_p2pmem,
  #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..af91240b1a1f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -510,6 +510,18 @@ static void nvmet_p2pmem_ns_add_p2p(struct 
nvmet_ctrl *ctrl,
  		ns->nsid);
  }

+inline void nvmet_req_poll(struct nvmet_req *req)
+{
+	if (req->ns->bdev)
+		nvmet_req_bdev_poll(req);
+}
+
+inline void nvmet_req_poll_complete(struct nvmet_req *req)
+{
+	if (req->ns->bdev)
+		nvmet_bdev_req_complete(req);
+}
+
  int nvmet_ns_enable(struct nvmet_ns *ns)
  {
  	struct nvmet_subsys *subsys = ns->subsys;
@@ -653,6 +665,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys 
*subsys, u32 nsid)

  	uuid_gen(&ns->uuid);
  	ns->buffered_io = false;
+	ns->use_poll = false;

  	return ns;
  }
diff --git a/drivers/nvme/target/io-cmd-bdev.c 
b/drivers/nvme/target/io-cmd-bdev.c
index b6fca0e421ef..317c9b427b71 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -49,10 +49,11 @@ void nvmet_bdev_set_limits(struct block_device 
*bdev, struct nvme_id_ns *id)

  int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
  {
+	int fmode = FMODE_READ | FMODE_WRITE;
+	struct request_queue *q;
  	int ret;

-	ns->bdev = blkdev_get_by_path(ns->device_path,
-			FMODE_READ | FMODE_WRITE, NULL);
+	ns->bdev = blkdev_get_by_path(ns->device_path, fmode, NULL);
  	if (IS_ERR(ns->bdev)) {
  		ret = PTR_ERR(ns->bdev);
  		if (ret != -ENOTBLK) {
@@ -60,16 +61,21 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
  					ns->device_path, PTR_ERR(ns->bdev));
  		}
  		ns->bdev = NULL;
-		return ret;
+		goto out;
  	}
  	ns->size = i_size_read(ns->bdev->bd_inode);
  	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
-	return 0;
+	q = bdev_get_queue(ns->bdev);
+	ns->poll = ns->use_poll && test_bit(QUEUE_FLAG_POLL, &q->queue_flags);
+	ret = ns->poll ? nvmet_ns_start_poll(ns) : 0;
+out:
+	return ret;
  }

  void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
  {
  	if (ns->bdev) {
+		ns->poll ? nvmet_ns_stop_poll(ns) : 0;
  		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
  		ns->bdev = NULL;
  	}
@@ -133,15 +139,34 @@ static u16 blk_to_nvme_status(struct nvmet_req 
*req, blk_status_t blk_sts)
  	return status;
  }

-static void nvmet_bio_done(struct bio *bio)
+void nvmet_bdev_req_complete(struct nvmet_req *req)
  {
-	struct nvmet_req *req = bio->bi_private;
+	struct bio *bio = req->b.last_bio;

  	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
  	if (bio != &req->b.inline_bio)
  		bio_put(bio);
  }

+static void nvmet_bio_done(struct bio *bio)
+{
+	struct nvmet_req *req = bio->bi_private;
+
+	req->b.last_bio = bio;
+
+	req->poll ? complete(&req->wait) : nvmet_bdev_req_complete(req);
+}
+
+void nvmet_req_bdev_poll(struct nvmet_req *req)
+{
+	struct request_queue *q = bdev_get_queue(req->ns->bdev);
+	int ret = blk_poll(q, req->b.cookie, true);
+
+	if (ret < 0) {
+		pr_err("tid %d poll error %d", req->t->id, ret);
+	}
+}
+
  static void nvmet_bdev_execute_rw(struct nvmet_req *req)
  {
  	int sg_cnt = req->sg_cnt;
@@ -185,7 +210,8 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
  	bio->bi_end_io = nvmet_bio_done;
  	bio->bi_opf = op;

-	blk_start_plug(&plug);
+	if (!req->poll)
+		blk_start_plug(&plug);
  	for_each_sg(req->sg, sg, req->sg_cnt, i) {
  		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
  				!= sg->length) {
@@ -204,8 +230,16 @@ static void nvmet_bdev_execute_rw(struct nvmet_req 
*req)
  		sg_cnt--;
  	}

-	submit_bio(bio);
-	blk_finish_plug(&plug);
+	req->b.last_bio = bio;
+	if (req->poll)
+		req->b.last_bio->bi_opf |= REQ_HIPRI;
+
+	req->b.cookie = submit_bio(bio);
+
+	nvmet_req_prep_poll(req);
+	nvmet_req_issue_poll(req);
+	if (!req->poll)
+		blk_finish_plug(&plug);
  }

  static void nvmet_bdev_execute_flush(struct nvmet_req *req)
@@ -330,15 +364,19 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
  	switch (cmd->common.opcode) {
  	case nvme_cmd_read:
  	case nvme_cmd_write:
+		req->poll = req->ns->poll;
  		req->execute = nvmet_bdev_execute_rw;
  		return 0;
  	case nvme_cmd_flush:
+		req->poll = false;
  		req->execute = nvmet_bdev_execute_flush;
  		return 0;
  	case nvme_cmd_dsm:
+		req->poll = false;
  		req->execute = nvmet_bdev_execute_dsm;
  		return 0;
  	case nvme_cmd_write_zeroes:
+		req->poll = false;
  		req->execute = nvmet_bdev_execute_write_zeroes;
  		return 0;
  	default:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e837c9..e5991e36ed6f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -49,11 +49,22 @@
  #define IPO_IATTR_CONNECT_SQE(x)	\
  	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))

+struct nvmet_poll_data {
+	struct completion		thread_complete;
+	wait_queue_head_t		poll_waitq;
+	struct mutex			list_lock;
+	struct task_struct		*thread;
+	struct list_head		list;
+	struct list_head		done;
+	unsigned int			id;
+};
+
  struct nvmet_ns {
  	struct list_head	dev_link;
  	struct percpu_ref	ref;
  	struct block_device	*bdev;
  	struct file		*file;
+	struct nvmet_poll_data	*t;
  	bool			readonly;
  	u32			nsid;
  	u32			blksize_shift;
@@ -63,6 +74,8 @@ struct nvmet_ns {
  	u32			anagrpid;

  	bool			buffered_io;
+	bool			use_poll;
+	bool			poll;
  	bool			enabled;
  	struct nvmet_subsys	*subsys;
  	const char		*device_path;
@@ -292,9 +305,15 @@ struct nvmet_req {
  	struct nvmet_ns		*ns;
  	struct scatterlist	*sg;
  	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
+	struct completion	wait;
+	bool			poll;
+	struct nvmet_poll_data  *t;
+	struct list_head	poll_entry;
  	union {
  		struct {
-			struct bio      inline_bio;
+			struct bio		inline_bio;
+			blk_qc_t		cookie;
+			struct bio		*last_bio;
  		} b;
  		struct {
  			bool			mpool_alloc;
@@ -442,6 +461,17 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys 
*subsys,
  void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
  		u8 event_info, u8 log_page);

+int nvmet_ns_start_poll(struct nvmet_ns *ns);
+void nvmet_ns_stop_poll(struct nvmet_ns *ns);
+void nvmet_req_prep_poll(struct nvmet_req *req);
+void nvmet_req_issue_poll(struct nvmet_req *req);
+
+void nvmet_req_bdev_poll(struct nvmet_req *req);
+void nvmet_req_poll(struct nvmet_req *req);
+void nvmet_req_poll_complete(struct nvmet_req *req);
+void nvmet_bdev_req_complete(struct nvmet_req *req);
+void nvmet_req_done(struct nvmet_req *req);
+
  #define NVMET_QUEUE_SIZE	1024
  #define NVMET_NR_QUEUES		128
  #define NVMET_MAX_CMD		NVMET_QUEUE_SIZE
-- 
2.22.1


  struct nvmet_ns {
  	struct list_head	dev_link;
  	struct percpu_ref	ref;
  	struct block_device	*bdev;
  	struct file		*file;
+	struct nvmet_poll_data	*t;
  	bool			readonly;
  	u32			nsid;
  	u32			blksize_shift;
@@ -63,6 +74,8 @@ struct nvmet_ns {
  	u32			anagrpid;

  	bool			buffered_io;
+	bool			use_poll;
+	bool			poll;
  	bool			enabled;
  	struct nvmet_subsys	*subsys;
  	const char		*device_path;
@@ -292,9 +305,15 @@ struct nvmet_req {
  	struct nvmet_ns		*ns;
  	struct scatterlist	*sg;
  	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
+	struct completion	wait;
+	bool			poll;
+	struct nvmet_poll_data  *t;
+	struct list_head	poll_entry;
  	union {
  		struct {
-			struct bio      inline_bio;
+			struct bio		inline_bio;
+			blk_qc_t		cookie;
+			struct bio		*last_bio;
  		} b;
  		struct {
  			bool			mpool_alloc;
@@ -442,6 +461,17 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys 
*subsys,
  void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
  		u8 event_info, u8 log_page);

+int nvmet_ns_start_poll(struct nvmet_ns *ns);
+void nvmet_ns_stop_poll(struct nvmet_ns *ns);
+void nvmet_req_prep_poll(struct nvmet_req *req);
+void nvmet_req_issue_poll(struct nvmet_req *req);
+
+void nvmet_req_bdev_poll(struct nvmet_req *req);
+void nvmet_req_poll(struct nvmet_req *req);
+void nvmet_req_poll_complete(struct nvmet_req *req);
+void nvmet_bdev_req_complete(struct nvmet_req *req);
+void nvmet_req_done(struct nvmet_req *req);
+
  #define NVMET_QUEUE_SIZE	1024
  #define NVMET_NR_QUEUES		128
  #define NVMET_MAX_CMD		NVMET_QUEUE_SIZE
-- 
2.22.1


  }
diff --git a/drivers/nvme/target/io-cmd-bdev.c 
b/drivers/nvme/target/io-cmd-bdev.c
index b6fca0e421ef..317c9b427b71 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -49,10 +49,11 @@ void nvmet_bdev_set_limits(struct block_device 
*bdev, struct nvme_id_ns *id)

  int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
  {
+	int fmode = FMODE_READ | FMODE_WRITE;
+	struct request_queue *q;
  	int ret;

-	ns->bdev = blkdev_get_by_path(ns->device_path,
-			FMODE_READ | FMODE_WRITE, NULL);
+	ns->bdev = blkdev_get_by_path(ns->device_path, fmode, NULL);
  	if (IS_ERR(ns->bdev)) {
  		ret = PTR_ERR(ns->bdev);
  		if (ret != -ENOTBLK) {
@@ -60,16 +61,21 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
  					ns->device_path, PTR_ERR(ns->bdev));
  		}
  		ns->bdev = NULL;
-		return ret;
+		goto out;
  	}
  	ns->size = i_size_read(ns->bdev->bd_inode);
  	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
-	return 0;
+	q = bdev_get_queue(ns->bdev);
+	ns->poll = ns->use_poll && test_bit(QUEUE_FLAG_POLL, &q->queue_flags);
+	ret = ns->poll ? nvmet_ns_start_poll(ns) : 0;
+out:
+	return ret;
  }

  void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
  {
  	if (ns->bdev) {
+		ns->poll ? nvmet_ns_stop_poll(ns) : 0;
  		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
  		ns->bdev = NULL;
  	}
@@ -133,15 +139,34 @@ static u16 blk_to_nvme_status(struct nvmet_req 
*req, blk_status_t blk_sts)
  	return status;
  }

-static void nvmet_bio_done(struct bio *bio)
+void nvmet_bdev_req_complete(struct nvmet_req *req)
  {
-	struct nvmet_req *req = bio->bi_private;
+	struct bio *bio = req->b.last_bio;

  	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
  	if (bio != &req->b.inline_bio)
  		bio_put(bio);
  }

+static void nvmet_bio_done(struct bio *bio)
+{
+	struct nvmet_req *req = bio->bi_private;
+
+	req->b.last_bio = bio;
+
+	req->poll ? complete(&req->wait) : nvmet_bdev_req_complete(req);
+}
+
+void nvmet_req_bdev_poll(struct nvmet_req *req)
+{
+	struct request_queue *q = bdev_get_queue(req->ns->bdev);
+	int ret = blk_poll(q, req->b.cookie, true);
+
+	if (ret < 0) {
+		pr_err("tid %d poll error %d", req->t->id, ret);
+	}
+}
+
  static void nvmet_bdev_execute_rw(struct nvmet_req *req)
  {
  	int sg_cnt = req->sg_cnt;
@@ -185,7 +210,8 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
  	bio->bi_end_io = nvmet_bio_done;
  	bio->bi_opf = op;

-	blk_start_plug(&plug);
+	if (!req->poll)
+		blk_start_plug(&plug);
  	for_each_sg(req->sg, sg, req->sg_cnt, i) {
  		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
  				!= sg->length) {
@@ -204,8 +230,16 @@ static void nvmet_bdev_execute_rw(struct nvmet_req 
*req)
  		sg_cnt--;
  	}

-	submit_bio(bio);
-	blk_finish_plug(&plug);
+	req->b.last_bio = bio;
+	if (req->poll)
+		req->b.last_bio->bi_opf |= REQ_HIPRI;
+
+	req->b.cookie = submit_bio(bio);
+
+	nvmet_req_prep_poll(req);
+	nvmet_req_issue_poll(req);
+	if (!req->poll)
+		blk_finish_plug(&plug);
  }

  static void nvmet_bdev_execute_flush(struct nvmet_req *req)
@@ -330,15 +364,19 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
  	switch (cmd->common.opcode) {
  	case nvme_cmd_read:
  	case nvme_cmd_write:
+		req->poll = req->ns->poll;
  		req->execute = nvmet_bdev_execute_rw;
  		return 0;
  	case nvme_cmd_flush:
+		req->poll = false;
  		req->execute = nvmet_bdev_execute_flush;
  		return 0;
  	case nvme_cmd_dsm:
+		req->poll = false;
  		req->execute = nvmet_bdev_execute_dsm;
  		return 0;
  	case nvme_cmd_write_zeroes:
+		req->poll = false;
  		req->execute = nvmet_bdev_execute_write_zeroes;
  		return 0;
  	default:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e837c9..e5991e36ed6f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -49,11 +49,22 @@
  #define IPO_IATTR_CONNECT_SQE(x)	\
  	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))

+struct nvmet_poll_data {
+	struct completion		thread_complete;
+	wait_queue_head_t		poll_waitq;
+	struct mutex			list_lock;
+	struct task_struct		*thread;
+	struct list_head		list;
+	struct list_head		done;
+	unsigned int			id;
+};
+
  struct nvmet_ns {
  	struct list_head	dev_link;
  	struct percpu_ref	ref;
  	struct block_device	*bdev;
  	struct file		*file;
+	struct nvmet_poll_data	*t;
  	bool			readonly;
  	u32			nsid;
  	u32			blksize_shift;
@@ -63,6 +74,8 @@ struct nvmet_ns {
  	u32			anagrpid;

  	bool			buffered_io;
+	bool			use_poll;
+	bool			poll;
  	bool			enabled;
  	struct nvmet_subsys	*subsys;
  	const char		*device_path;
@@ -292,9 +305,15 @@ struct nvmet_req {
  	struct nvmet_ns		*ns;
  	struct scatterlist	*sg;
  	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
+	struct completion	wait;
+	bool			poll;
+	struct nvmet_poll_data  *t;
+	struct list_head	poll_entry;
  	union {
  		struct {
-			struct bio      inline_bio;
+			struct bio		inline_bio;
+			blk_qc_t		cookie;
+			struct bio		*last_bio;
  		} b;
  		struct {
  			bool			mpool_alloc;
@@ -442,6 +461,17 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys 
*subsys,
  void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
  		u8 event_info, u8 log_page);

+int nvmet_ns_start_poll(struct nvmet_ns *ns);
+void nvmet_ns_stop_poll(struct nvmet_ns *ns);
+void nvmet_req_prep_poll(struct nvmet_req *req);
+void nvmet_req_issue_poll(struct nvmet_req *req);
+
+void nvmet_req_bdev_poll(struct nvmet_req *req);
+void nvmet_req_poll(struct nvmet_req *req);
+void nvmet_req_poll_complete(struct nvmet_req *req);
+void nvmet_bdev_req_complete(struct nvmet_req *req);
+void nvmet_req_done(struct nvmet_req *req);
+
  #define NVMET_QUEUE_SIZE	1024
  #define NVMET_NR_QUEUES		128
  #define NVMET_MAX_CMD		NVMET_QUEUE_SIZE
-- 
2.22.1










_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
