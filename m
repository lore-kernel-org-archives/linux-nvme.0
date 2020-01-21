Return-Path: <SRS0=JmHd=3K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B51C2D0CE
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jan 2020 19:22:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0986520678
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jan 2020 19:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SzxfQh9e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jy6sbtKv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eSSzZDSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0986520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=kqRIVYCc68qg/fOqnKNMcJWHy4rlO8iGEdwnGt/OLXc=; b=SzxfQh9eq8aBuS
	rg9V/nctd/5RSciq0bLsbAAhrRBL51X3vd4+AUylL140npsCWv9mspyZi0YCXPdg/Ij6JsfI0A5ii
	K1rCyAi/gtKqscdpvgW6ZIDMM4jb6+9Dd80t7Zz6Znb55mOxybw0vMlWUCcoCMDrDZLzr0E//B2mN
	Rj3Lm6x6oEmJDX3oFkl9hhLScXuRvH74DiAQRnGQCwCtjifkXlTnl3tDgtB3Ps46PDk8R2d86Hk8n
	LKstrE4artOp8u1b3qdnbkUKaUCxHPSV7SbWhmqRPwgbg9GzTTZwovTxdAN8JsF30zwpOO6HamG+q
	OWhrd4OYOyg/lb1/G6gQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1itz6K-00043R-0f; Tue, 21 Jan 2020 19:22:12 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1itz6E-00042b-1m
 for linux-nvme@lists.infradead.org; Tue, 21 Jan 2020 19:22:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1579634526; x=1611170526;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=GPAdexq+9gaNiQ1ztNcCfpvRzVoXXWL8+OKWkJqoJw0=;
 b=jy6sbtKvzas6A6rVzBxIGgS8Z3iR1E2Jq6bSeq3H0mQWuDhpRk/NgGqP
 f7Q5pCBK7bCBhBfOLc8XUQ3eTBEePIqI9VEZYNe3gzYmab0ooxFqwoFGt
 E+0sxFDtzidkJWg3KFwp/oqxb9GKum0W4AZzWqale54p05f9qEazl6BsJ
 rNOBO//7m+bfMaH7wlwEtr0OGNNXNeJnJqTZeNOp7zuZmawm04+musuUY
 XdUkDSeWn1+rYvxN5B0RVq60tig46Rf8xPk3cC2u30AkLkbs/k58sRuFB
 z/XM2sj/rVAt9YnGR/6nb10QjyM7CPMkjGvYLSBXAWZpXTUkpI0nx7xq8 Q==;
IronPort-SDR: kwDugDFjeB4ajSnd5ga6vqT9tOvvmuZtmPOtpInoh+Tn9ha7t+fGndvCdtcaDfgSsy146NTqmH
 uzkbnB7uksTxFSDIm6Q7/fsx5rOBAhngX1bnFEveeue0R2Be0hunVAqxppkYNNne4984N//dva
 R4/vElZhJN9/GgFE1Wr7J3P2A1mpailVI1Jp7dkgwQuKNYS0OhJenJOu2QM7k2yqhw5GNCzNav
 JZAHD6wuA9WFWmD04iUQuvryp4KcWnvzH1gCh1rDRPf3sRO0xH64Z+o5YUBdG70EeYV/ZoYsUH
 DCQ=
X-IronPort-AV: E=Sophos;i="5.70,347,1574092800"; d="scan'208";a="129581358"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2020 03:22:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHrKJFYWRTSuyP1nzhTXDgcnZaylz6JnMEhUrTq4iPy5kwqWJXhlVOcefKnG9ucoJ7C7jIhkJK39eah5dpildlKYqbIP6xvuvl3xrv9Ba5zogRtzfxYDGbfdImf+8K3kyJfwK27L0xy8fTYypsd4Xcf02JnkUEtTCPXcZrPIt4uR4mCNZV+qzORoJQINqvAZAMTrPBkEYZnhL4IJGeIlWUCU1hAD+X0MpyoXwEE4k1XCmn+vwRTyxTyJwweOoseSWHYSMh6oUe8iiF5OM+Zi6jDJmtJAQD0STe3JSHoqkOYdnx1K3JgBXpWAhNaLUY3Nrsi/n1yw6YVcOjpQ1NC+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=340AHyStwTb39h79KGffQgWpTxAVU/t+Frkjrzd3w2o=;
 b=S38mieRHWCfP6DFE383WKeVQVaV+KB8owI5Equx6DrifxEfb6UkYkDQl40f2wm6XB7+ai4n8TyqdrrdI8juJIQ8BsO9KZvEoltMa+GNIU8mBTk9ey6UBlLKFtV7sZjFD1iL0dVGkEWYmatEYRriIrGQDKpZEbDY+L0QPNI4scv37U/tqjXybDlOvlwLlRVwAILI+AISA9Vsy9X2egYO9tj6Mv7+mBz+CSYRUbtfq2Ut+nYUK5Bm2UBgLB8YBnLIW7hle/lohpshylRpdTJAJyc/BSWfCK2FKsav/vl1kTujj5y9EQYAv9ete3Dwvi5lIWL8I0zhf01Yclm6j1GeJyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=340AHyStwTb39h79KGffQgWpTxAVU/t+Frkjrzd3w2o=;
 b=eSSzZDSntcKQ6GVK2auFsHKfPGEHrK9F4RPBTRAjAz9kCM/DHNoWg2jUBIt/5aLLQf6UCX24l8S2Nc35mWHRTNNJFHQcC6LNFXAdnDtk/UKJ0S8VJ6Zz0o8VNU2IISKkp4lAyPRmDsmVYLR41YwK3T0ns2s79WFBqlYQlwKgfpY=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.51.24) by
 DM6PR04MB5561.namprd04.prod.outlook.com (20.178.227.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 21 Jan 2020 19:22:01 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::f123:d623:d0e3:daab]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::f123:d623:d0e3:daab%5]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 19:22:01 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <maxg@mellanox.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH 1/2] nvmet: add bdev-ns polling support
Thread-Topic: [RFC PATCH 1/2] nvmet: add bdev-ns polling support
Thread-Index: AQHVryK7P6rMrL35gUKBVCzwh+BN/A==
Date: Tue, 21 Jan 2020 19:22:01 +0000
Message-ID: <DM6PR04MB575431D7764F7D4BB98AFA5B860D0@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <20191210062557.5171-1-chaitanya.kulkarni@wdc.com>
 <20191210062557.5171-2-chaitanya.kulkarni@wdc.com>
 <2c5f45ab-7ac1-b904-bc7b-1f272484b845@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3f891b4-314f-40d2-ad81-08d79ea73112
x-ms-traffictypediagnostic: DM6PR04MB5561:
x-microsoft-antispam-prvs: <DM6PR04MB556164642A441E5D9D0AB6C0860D0@DM6PR04MB5561.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(189003)(199004)(6506007)(53546011)(9686003)(30864003)(66476007)(64756008)(66556008)(478600001)(966005)(52536014)(55016002)(26005)(91956017)(86362001)(5660300002)(71200400001)(66946007)(76116006)(81156014)(8676002)(81166006)(8936002)(7696005)(186003)(4326008)(33656002)(66446008)(2906002)(316002)(110136005)(21314003)(579004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB5561;
 H:DM6PR04MB5754.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: khg6t0sLcZ4Pd7629G8qJ9qrGqkrkAmb1/7visqKQkm2UHxkbHflaoP0+l3T5wj9SjJqwvKLBt7AZjvvTtDb5fJkOLO3zAPL15t5BXLZ5dzOoBnQGhvvczYtOIWe2ztgwc5OOrFnNmm0TYPt7kZU9lLeJ0HFNuGzbo4xwNszAre0Uc07CqrB/iw3w85AXMfVM4SIM1U0PPogB9N1DNg/dC4us3p5X+JGw+prPXby6tqJwzdmaYMQnXRkWtSTILUUcdxX7/jdeGeiDpPd8KKHtFEGMfwxcnPDFX0U8Hk76AAMLOn7WZKRPgmNllk50cmK1Kvg4wLD6bPLX7K+WOgJpJvn6XV3fD6DDIakqsIB3Bqdxt7tggrjSWXGxR/Z8IU0eKV44cd7X1LqQ6ereOyVLAhjwwniDe0XUaQblyFCn2kojTqBcrn6uCHl8tCXo/LfqgyGCH6kKiz7EjSxbJEFmdPyNpJBh3frLyawzpdX62Pw+GIwBkBveSX4DjsMQBDLKWXEowSujXyU2l8lXncN8Ziy9v7Fq5z95krDpK2enRU/RYBBdJ1c1Gk78m0v7ZwK
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f891b4-314f-40d2-ad81-08d79ea73112
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 19:22:01.4969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/Sv64nH9armZEpNP0qg71JsWs9inlC3OsTjeBcYO0TR4Xfb19OfEuf+ri/whD9p+C8vpGG1bBJ6RFPmBMVqoUv67vB+bOSj7aTmM0aukTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5561
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200121_112206_250707_81F020C2 
X-CRM114-Status: GOOD (  18.64  )
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

Please see my in-line comments.
On 01/20/2020 04:52 AM, Max Gurtovoy wrote:
>
> On 12/10/2019 8:25 AM, Chaitanya Kulkarni wrote:
>> This patch adds support for the bdev-ns polling. We also add a new
>> file to keep polling code separate (io-poll.c). The newly added
>> configfs attribute allows user to enable/disable polling.
>>
>> We only enable polling for the READ/WRITE operation based on support
>> from bdev and and use_poll configfs attr.
>>
>> We configure polling per namespace. For each namespace we create
>> polling threads. For general approach please have a look at the
>> cover-letter of this patch-series.
>
> It would be great to get some numbers here to learn about the trade-off
> for this approach.
>
>

Already posted these numbers with QEMU nvme-loop here :-
http://lists.infradead.org/pipermail/linux-nvme/2020-January/028692.html

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

>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> ---
>>    drivers/nvme/target/Makefile      |   3 +-
>>    drivers/nvme/target/configfs.c    |  29 ++++++
>>    drivers/nvme/target/core.c        |  13 +++
>>    drivers/nvme/target/io-cmd-bdev.c |  61 +++++++++--
>>    drivers/nvme/target/io-poll.c     | 165 ++++++++++++++++++++++++++++++
>>    drivers/nvme/target/nvmet.h       |  31 +++++-
>>    6 files changed, 291 insertions(+), 11 deletions(-)
>>    create mode 100644 drivers/nvme/target/io-poll.c
>>
>> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
>> index 2b33836f3d3e..8877ba16305c 100644
>> --- a/drivers/nvme/target/Makefile
>> +++ b/drivers/nvme/target/Makefile
>> @@ -10,7 +10,8 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
>>    obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
>>
>>    nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
>> -			discovery.o io-cmd-file.o io-cmd-bdev.o
>> +			discovery.o io-cmd-file.o io-cmd-bdev.o \
>> +			io-poll.o
>>    nvme-loop-y	+= loop.o
>>    nvmet-rdma-y	+= rdma.o
>>    nvmet-fc-y	+= fc.o
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index 98613a45bd3b..0e6e8b0dbf79 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -545,6 +545,34 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
>>
>>    CONFIGFS_ATTR(nvmet_ns_, buffered_io);
>>
>> +static ssize_t nvmet_ns_use_poll_show(struct config_item *item, char *page)
>> +{
>> +	return sprintf(page, "%d\n", to_nvmet_ns(item)->use_poll);
>> +}
>> +
>> +static ssize_t nvmet_ns_use_poll_store(struct config_item *item,
>> +		const char *page, size_t count)
>> +{
>> +	struct nvmet_ns *ns = to_nvmet_ns(item);
>> +	bool val;
>> +
>> +	if (strtobool(page, &val))
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&ns->subsys->lock);
>> +	if (ns->enabled) {
>> +		pr_err("disable ns before setting use_poll value.\n");
>> +		mutex_unlock(&ns->subsys->lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ns->use_poll = val;
>> +	mutex_unlock(&ns->subsys->lock);
>> +	return count;
>> +}
>> +
>> +CONFIGFS_ATTR(nvmet_ns_, use_poll);
>> +
>>    static struct configfs_attribute *nvmet_ns_attrs[] = {
>>    	&nvmet_ns_attr_device_path,
>>    	&nvmet_ns_attr_device_nguid,
>> @@ -552,6 +580,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
>>    	&nvmet_ns_attr_ana_grpid,
>>    	&nvmet_ns_attr_enable,
>>    	&nvmet_ns_attr_buffered_io,
>> +	&nvmet_ns_attr_use_poll,
>>    #ifdef CONFIG_PCI_P2PDMA
>>    	&nvmet_ns_attr_p2pmem,
>>    #endif
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 28438b833c1b..d8f9130d1cd1 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -510,6 +510,18 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
>>    		ns->nsid);
>>    }
>>
>> +inline void nvmet_req_done(struct nvmet_req *req)
>> +{
>> +	if (req->ns->bdev)
>> +		nvmet_bdev_req_complete(req);
>> +}
>> +
>> +inline void nvmet_req_poll_complete(struct nvmet_req *req)
>> +{
>> +	if (req->ns->bdev)
>> +		nvmet_bdev_poll_complete(req);
>> +}
>> +
>>    int nvmet_ns_enable(struct nvmet_ns *ns)
>>    {
>>    	struct nvmet_subsys *subsys = ns->subsys;
>> @@ -653,6 +665,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
>>
>>    	uuid_gen(&ns->uuid);
>>    	ns->buffered_io = false;
>> +	ns->use_poll = false;
>>
>>    	return ns;
>>    }
>> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
>> index b6fca0e421ef..13507e0cbc1d 100644
>> --- a/drivers/nvme/target/io-cmd-bdev.c
>> +++ b/drivers/nvme/target/io-cmd-bdev.c
>> @@ -49,10 +49,11 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
>>
>>    int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>>    {
>> +	int fmode = FMODE_READ | FMODE_WRITE;
>> +	struct request_queue *q;
>>    	int ret;
>>
>> -	ns->bdev = blkdev_get_by_path(ns->device_path,
>> -			FMODE_READ | FMODE_WRITE, NULL);
>> +	ns->bdev = blkdev_get_by_path(ns->device_path, fmode, NULL);
>>    	if (IS_ERR(ns->bdev)) {
>>    		ret = PTR_ERR(ns->bdev);
>>    		if (ret != -ENOTBLK) {
>> @@ -60,16 +61,21 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>>    					ns->device_path, PTR_ERR(ns->bdev));
>>    		}
>>    		ns->bdev = NULL;
>> -		return ret;
>> +		goto out;
>>    	}
>>    	ns->size = i_size_read(ns->bdev->bd_inode);
>>    	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
>> -	return 0;
>> +	q = bdev_get_queue(ns->bdev);
>> +	ns->poll = ns->use_poll && test_bit(QUEUE_FLAG_POLL, &q->queue_flags);
>> +	ret = ns->poll ? nvmet_ns_start_poll(ns) : 0;
>> +out:
>> +	return ret;
>>    }
>>
>>    void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
>>    {
>>    	if (ns->bdev) {
>> +		ns->poll ? nvmet_ns_stop_poll(ns) : 0;
>
> can you please use an "if" statement instead of the above convention ?
>

This is just as RFC, will send out formal patch series with all the
coding style fixes.

>
>>    		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
>>    		ns->bdev = NULL;
>>    	}
>> @@ -133,15 +139,39 @@ static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
>>    	return status;
>>    }
>>
>> -static void nvmet_bio_done(struct bio *bio)
>> +void nvmet_bdev_req_complete(struct nvmet_req *req)
>>    {
>> -	struct nvmet_req *req = bio->bi_private;
>> +	struct bio *bio = req->b.last_bio;
>>
>>    	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
>>    	if (bio != &req->b.inline_bio)
>>    		bio_put(bio);
>>    }
>>
>> +static void nvmet_bio_done(struct bio *bio)
>> +{
>> +	struct nvmet_req *req = bio->bi_private;
>> +
>> +	req->b.last_bio = bio;
>> +
>> +	req->poll ? complete(&req->wait) : nvmet_bdev_req_complete(req);
>
> Same here for the "if". Lets keep the code as readable as we can
>
Same as above.
>
>> +}
>> +
>> +void nvmet_bdev_poll_complete(struct nvmet_req *req)
>> +{
>> +	struct request_queue *q = bdev_get_queue(req->ns->bdev);
>> +
>> +	while (!completion_done(&req->wait)) {
>> +		int ret = blk_poll(q, req->b.cookie, true);
>> +
>> +		if (ret < 0) {
>> +			pr_err("tid %d poll error %d", req->t->id, ret);
>> +			break;
>> +		}
>> +	}
>> +	nvmet_bdev_req_complete(req);
>> +}
>> +IOPS/BW:-

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

>>    static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>    {
>>    	int sg_cnt = req->sg_cnt;
>> @@ -185,7 +215,8 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>    	bio->bi_end_io = nvmet_bio_done;
>>    	bio->bi_opf = op;
>>
>> -	blk_start_plug(&plug);
>> +	if (!req->poll)
>> +		blk_start_plug(&plug);
>>    	for_each_sg(req->sg, sg, req->sg_cnt, i) {
>>    		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
>>    				!= sg->length) {
>> @@ -204,8 +235,16 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>    		sg_cnt--;
>>    	}
>>
>> -	submit_bio(bio);
>> -	blk_finish_plug(&plug);
>> +	req->b.last_bio = bio;
>> +	if (req->poll)
>> +		req->b.last_bio->bi_opf |= REQ_HIPRI;
>> +
>> +	req->b.cookie = submit_bio(bio);
>> +
>> +	nvmet_req_prep_poll(req);
>> +	nvmet_req_issue_poll(req);
>> +	if (!req->poll)
>> +		blk_finish_plug(&plug);
>>    }
>>
>>    static void nvmet_bdev_execute_flush(struct nvmet_req *req)
>> @@ -330,15 +369,19 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
>>    	switch (cmd->common.opcode) {
>>    	case nvme_cmd_read:
>>    	case nvme_cmd_write:
>> +		req->poll = req->ns->poll;
>>    		req->execute = nvmet_bdev_execute_rw;
>>    		return 0;
>>    	case nvme_cmd_flush:
>> +		req->poll = false;
>
> should be done in some general place for req initialization.
>
>

This needs to be done here for better redability, since it
depends on the 2 factors with backend support and user setting.

>>    		req->execute = nvmet_bdev_execute_flush;
>>    		return 0;
>>    	case nvme_cmd_dsm:
>> +		req->poll = false;
>>    		req->execute = nvmet_bdev_execute_dsm;
>>    		return 0;
>>    	case nvme_cmd_write_zeroes:
>> +		req->poll = false;
>>    		req->execute = nvmet_bdev_execute_write_zeroes;
>>    		return 0;
>>    	default:
>> diff --git a/drivers/nvme/target/io-poll.c b/drivers/nvme/target/io-poll.c
>> new file mode 100644
>> index 000000000000..175c939c22ff
>> --- /dev/null
>> +++ b/drivers/nvme/target/io-poll.c
>> @@ -0,0 +1,165 @@
>> +#include <linux/blkdev.h>
>> +#include <linux/module.h>
>> +#include <linux/sched/signal.h>
>> +#include <linux/kthread.h>
>> +#include <uapi/linux/sched/types.h>
>> +
>> +#include "nvmet.h"
>> +#define THREAD_PER_CPU	(num_online_cpus() * 2)
>> +
>> +static int nvmet_poll_thread(void *data);
>> +
>> +int nvmet_ns_start_poll(struct nvmet_ns *ns)
>> +{
>> +	struct nvmet_poll_data *t;
>> +	int ret = 0;
>> +	int i;
>> +
>> +	t = kzalloc(sizeof(*t) * THREAD_PER_CPU, GFP_KERNEL);
>> +	if (!t) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	for (i = 0; i < THREAD_PER_CPU; i++) {
>> +		init_completion(&t[i].thread_complete);
>> +		init_waitqueue_head(&t[i].poll_waitq);
>> +		INIT_LIST_HEAD(&t[i].list);
>> +		INIT_LIST_HEAD(&t[i].done);
>> +		mutex_init(&t[i].list_lock);
>> +		t[i].id = i;
>> +
>> +		t[i].thread = kthread_create(nvmet_poll_thread, &t[i],
>> +					     "nvmet_poll_thread%s/%d",
>> +					     ns->device_path, i);
>> +
>> +		if (IS_ERR(t[i].thread)) {
>> +			ret = PTR_ERR(t[i].thread);
>> +			goto err;
>> +		}
>> +
>> +		kthread_bind(t[i].thread, i % num_online_cpus());
>> +		wake_up_process(t[i].thread);
>> +		wait_for_completion(&t[i].thread_complete);
>> +	}
>> +
>> +	ns->t = t;
>> +out:
>> +	return ret;
>> +err:
>> +	nvmet_ns_stop_poll(ns);
>> +	goto out;
>> +}
>> +
>> +void nvmet_ns_stop_poll(struct nvmet_ns *ns)
>> +{
>> +	struct nvmet_poll_data *t = ns->t;
>> +	int i;
>> +
>> +	for (i = 0; i < THREAD_PER_CPU; i++) {
>> +		if (!t[i].thread)
>> +			continue;
>> +
>> +		if (wq_has_sleeper(&t[i].poll_waitq))
>> +			wake_up(&t[i].poll_waitq);
>> +		kthread_park(t[i].thread);
>> +		kthread_stop(t[i].thread);
>> +	}
>> +}
>> +
>> +static void nvmet_poll(struct nvmet_poll_data *t)
>> +{
>> +	struct nvmet_req *req, *tmp;
>> +
>> +	lockdep_assert_held(&t->list_lock);
>> +
>> +	list_for_each_entry_safe(req, tmp, &t->list, poll_entry) {
>> +
>> +		if (completion_done(&req->wait)) {
>> +			list_move_tail(&req->poll_entry, &t->done);
>> +			continue;
>> +		}
>> +
>> +		if (!list_empty(&t->done))
>> +			break;
>> +
>> +		list_del(&req->poll_entry);
>> +		mutex_unlock(&t->list_lock);
>> +		nvmet_req_poll_complete(req);
>> +		mutex_lock(&t->list_lock);
>> +	}
>> +	mutex_unlock(&t->list_lock);
>> +	/*
>> +	 * In future we can also add batch timeout or nr request to complete.
>> +	 */
>> +	while (!list_empty(&t->done)) {
>> +		/*
>> +		 * We lock and unlock for t->list which gurantee progress of
>> +		 * nvmet_xxx_rw_execute() when under pressure while we complete
>> +		 * the request.
>> +		 */
>> +		req = list_first_entry(&t->done, struct nvmet_req, poll_entry);
>> +		list_del(&req->poll_entry);
>> +		nvmet_req_done(req);
>> +	}
>> +
>> +	mutex_lock(&t->list_lock);
>> +}
>> +
>> +static int nvmet_poll_thread(void *data)
>> +{
>> +	struct nvmet_poll_data *t = (struct nvmet_poll_data *) data;
>> +	DEFINE_WAIT(wait);
>> +
>> +	complete(&t->thread_complete);
>> +
>> +	while (!kthread_should_park()) {
>> +
>> +		mutex_lock(&t->list_lock);
>> +		while (!list_empty(&t->list) && !need_resched())
>> +			nvmet_poll(t);
>> +		mutex_unlock(&t->list_lock);
>> +
>> +		prepare_to_wait(&t->poll_waitq, &wait, TASK_INTERRUPTIBLE);
>> +		if (signal_pending(current))
>> +			flush_signals(current);
>> +		smp_mb();
>> +		schedule();
>> +
>> +		finish_wait(&t->poll_waitq, &wait);
>> +	}
>> +
>> +	kthread_parkme();
>> +	return 0;
>> +}
>> +
>> +inline void nvmet_req_prep_poll(struct nvmet_req *req)
>> +{
>> +	if (!req->poll)
>> +		return;
>> +
>> +	init_completion(&req->wait);
>> +	req->t = &req->ns->t[smp_processor_id()];
>> +}
>> +
>> +inline void nvmet_req_issue_poll(struct nvmet_req *req)
>> +{
>> +	if (!req->poll)
>> +		return;
>> +
>> +	while (!mutex_trylock(&req->t->list_lock)) {
>> +		if (req->t->id < num_online_cpus())
>> +			req->t = &req->ns->t[req->t->id + num_online_cpus()];
>> +		else
>> +			req->t = &req->ns->t[req->t->id - num_online_cpus()];
>> +	}
>> +
>> +	if (completion_done(&req->wait))
>> +		list_add(&req->poll_entry, &req->t->list);
>> +	else
>> +		list_add_tail(&req->poll_entry, &req->t->list);
>> +	mutex_unlock(&req->t->list_lock);
>> +
>> +	if (wq_has_sleeper(&req->t->poll_waitq))
>> +		wake_up(&req->t->poll_waitq);
>> +}
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 46df45e837c9..ef2919e23e0b 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -49,11 +49,22 @@
>>    #define IPO_IATTR_CONNECT_SQE(x)	\
>>    	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
>>
>> +struct nvmet_poll_data {
>> +	struct completion		thread_complete;
>> +	wait_queue_head_t		poll_waitq;
>> +	struct mutex			list_lock;
>> +	struct task_struct		*thread;
>> +	struct list_head		list;
>> +	struct list_head		done;
>> +	unsigned int			id;
>> +};
>> +
>>    struct nvmet_ns {
>>    	struct list_head	dev_link;
>>    	struct percpu_ref	ref;
>>    	struct block_device	*bdev;
>>    	struct file		*file;
>> +	struct nvmet_poll_data	*t;
>>    	bool			readonly;
>>    	u32			nsid;
>>    	u32			blksize_shift;
>> @@ -63,6 +74,8 @@ struct nvmet_ns {
>>    	u32			anagrpid;
>>
>>    	bool			buffered_io;
>> +	bool			use_poll;
>> +	bool			poll;
>>    	bool			enabled;
>>    	struct nvmet_subsys	*subsys;
>>    	const char		*device_path;
>> @@ -292,9 +305,15 @@ struct nvmet_req {
>>    	struct nvmet_ns		*ns;
>>    	struct scatterlist	*sg;
>>    	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
>> +	struct completion	wait;
>> +	bool			poll;
>> +	struct nvmet_poll_data  *t;
>> +	struct list_head	poll_entry;
>>    	union {
>>    		struct {
>> -			struct bio      inline_bio;
>> +			struct bio		inline_bio;
>> +			blk_qc_t		cookie;
>> +			struct bio		*last_bio;
>>    		} b;
>>    		struct {
>>    			bool			mpool_alloc;
>> @@ -442,6 +461,16 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
>>    void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>>    		u8 event_info, u8 log_page);
>>
>> +int nvmet_ns_start_poll(struct nvmet_ns *ns);
>> +void nvmet_ns_stop_poll(struct nvmet_ns *ns);
>> +void nvmet_req_prep_poll(struct nvmet_req *req);
>> +void nvmet_req_issue_poll(struct nvmet_req *req);
>> +
>> +void nvmet_req_poll_complete(struct nvmet_req *req);
>> +void nvmet_bdev_poll_complete(struct nvmet_req *req);
>> +void nvmet_bdev_req_complete(struct nvmet_req *req);
>> +void nvmet_req_done(struct nvmet_req *req);
>> +
>>    #define NVMET_QUEUE_SIZE	1024
>>    #define NVMET_NR_QUEUES		128
>>    #define NVMET_MAX_CMD		NVMET_QUEUE_SIZE
>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
