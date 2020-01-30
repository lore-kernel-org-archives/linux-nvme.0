Return-Path: <SRS0=3CeD=3T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13986C2D0DB
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 18:20:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0F32082E
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 18:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qKOHmk+6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R9Nf39wU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LRg/uY9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0F32082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=X974FEOTcBQ/5xm0PyMw1H9A5JaeMnLCuXoj4+oG3VY=; b=qKOHmk+6Mr6Fmt
	8VZlC2YO6eVGiEvijd2glMQXhLk0+crW3fSS9q9j3OgLIt2mfa+iGmKMfwQINPFtuKBCBbWFj6L7X
	pLIReibdnbyOKW4ayQLE218CFKqXDTFKYp6T3eFk1orBFyCs9YXGN4GGTDe1IsEAXDQGDAhui69r4
	uxsD8iI7rF/bEqNCq2YDk8JhESMouiNeN6GDsn9kx6JJXkmdY3DP7Oin9MtZwPpcqJy63OJlAGPqp
	sMWIjcYo/VIHbJcXmhfnnjNNlP/knhJtoyC4U6RhGa09ZXw1DnMi+bcbjiyEyK8DdmqdtjCICz1Fw
	LZzP+hvq/g1k3sp1YOHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ixEQ6-0007Zt-3z; Thu, 30 Jan 2020 18:20:02 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ixEQ2-0007S8-Dg
 for linux-nvme@lists.infradead.org; Thu, 30 Jan 2020 18:20:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580408398; x=1611944398;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=1v4XPb1bksDZaFzOVQfhzIhugjNpqqzoKJN/z5mA7tA=;
 b=R9Nf39wUTAQvx+IPUPF8od4ac1N0Pa6f4g69S3vkgKbe7yfFo1ELUnyd
 /ZJD3FN61V+i7Wv7GAfajXGEEzEOB2+lnKSKkgX1sZ1YrhNoOvo0thOft
 HhzqmbSHgbFSsHNE3qOhF2CaC7RGI4C4fmBIdd+8KipP0Q8lPYmApVdOa
 CdM5lWUPEPVk7bnR3GPjabMpUz2sqLzmRgTtRKxbNFukrg9QJkRxKSJ+r
 vK+zWlvRAJ1jN9N8yO5KipxZMxO/GOj5xLcjlRmp2XfQ7YDq0qGmt1fbw
 t2cAu0DBZxVvSlCcoD3NoEcEaoGrJFQA0EjoHfXKD6MJtVI4dgzuB8ruJ A==;
IronPort-SDR: zeo+4KOG0ierSmWW0BL7qVA/GYY/LI/e5fHhuERPnkPV3J4CuNH/Y7Qo2Z0bwTav0dIlqEJk9w
 BD7mob1XBPwnAcocLxjrgXHQe9+iqsEApPSAM02yAwpPZd9WFaMWlp04MfABCj0rDmbz+2jXLa
 c7UUNC2jsQzDgYnZBrHi+IJofPK683AelC085oImQ+rkP1TO5Bm3/kAgi5OSERNOFWsxea5sHK
 G31q1T+fqqBHFrEZXPtbLF7x2RhRgDI0oPwwxw9UtANEp6R9BpzSTxzDiwVNrAcO94HPWHX5vb
 k4k=
X-IronPort-AV: E=Sophos;i="5.70,382,1574092800"; d="scan'208";a="128763111"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
 by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2020 02:19:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gn5qI/MnGkJ8FWCkUrfm9+PhiU2mqSDML5iWcHqkkuQj+lKbXbUhGAigydovD4kmBDSjJHFuFUgDRg88DVo0T92THMubAFzsyu0wWDESXFg9+xHX8dZApLM7yazU8+x6y1lMx3wpq7s1KIwVe8dANvBm7BmgyfChM8WOjft58LCYbMcso3qS7qiuziEL+hsLYOxH9UK/ew89U5ryYfOQxOlcsZ1UdAB14n8NsUtF3NYl/V5ol4UE4+N3Ihxx/SCGrs0gcN5ZXaRoo3Pf60QCrL68PQwNJUUm1Te20KhxQ+qSrVhN9Amdsc3bNfnRGb8d7n3WuuhonNDo9wAaKYOz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v4XPb1bksDZaFzOVQfhzIhugjNpqqzoKJN/z5mA7tA=;
 b=P590tMzcyhN0VvbPSKaYKw08TybjIZyL7aUvWOluDArg5mMOFRWT10nyZgPtjbtG/eqd0wm6FiGvFgNSsyXydfkuSOYqXFlll+xO5GuNHXxOIA+KJ03IAziiyYfSGZ0QRGH0Q5AW1PJdTJfLrxA1pR8syOLdijLNQeIHZnh447gWaohnuMK//R9hzatXoF73PseAboFXVmLnoOfAnDZbobx5DHnNDeFFxcBZqBgcvHLT5fFxCHRv3FmTOkQaKnnXgB6uqG0IsQ6e59O0ZKP09tpa99D110z+7Hj829tJOHAcnHp7a8h/Qnay2W8srXUqMEyvagtIZvL1tv/VB4RGjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v4XPb1bksDZaFzOVQfhzIhugjNpqqzoKJN/z5mA7tA=;
 b=LRg/uY9PPnmp3vVGVg5ZA3uIHnoyPfH2NbP5B4StWeVySrOP3ZQ+ktyMrLG1Ul7fW5Sc0vTDEjk9yHXKulGWMd8qvUcWAyz18ce36dkfWpZglS3GZ6o4GZkn5WhxMSH6QXy4Q+5qaCdz86S/q8QeNqsMVlYNsO59nmaFCXUSwlY=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5000.namprd04.prod.outlook.com (52.135.232.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Thu, 30 Jan 2020 18:19:43 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 18:19:43 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <maxg@mellanox.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH 1/2] nvmet: add bdev-ns polling support
Thread-Topic: [RFC PATCH 1/2] nvmet: add bdev-ns polling support
Thread-Index: AQHVryK7P6rMrL35gUKBVCzwh+BN/A==
Date: Thu, 30 Jan 2020 18:19:43 +0000
Message-ID: <BYAPR04MB57492FCA245C3F19079CDD5186040@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191210062557.5171-1-chaitanya.kulkarni@wdc.com>
 <20191210062557.5171-2-chaitanya.kulkarni@wdc.com>
 <2c5f45ab-7ac1-b904-bc7b-1f272484b845@mellanox.com>
 <DM6PR04MB575431D7764F7D4BB98AFA5B860D0@DM6PR04MB5754.namprd04.prod.outlook.com>
 <03494a32-b31a-432b-870d-7347f5cc9596@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fbc272f-fe7d-4835-e6d2-08d7a5b0fad6
x-ms-traffictypediagnostic: BYAPR04MB5000:
x-microsoft-antispam-prvs: <BYAPR04MB5000FE2EC49204617E515ABB86040@BYAPR04MB5000.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(189003)(199004)(478600001)(8936002)(45080400002)(5660300002)(8676002)(81156014)(81166006)(26005)(66446008)(33656002)(66476007)(55016002)(76116006)(64756008)(66556008)(7696005)(66946007)(4326008)(9686003)(71200400001)(53546011)(86362001)(6506007)(2906002)(52536014)(316002)(110136005)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5000;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 54jD9TkVlYtjXyLtAsVSaMGmlFE+HgQJNXEZezrTv24o5/1ElKcDdQrVA0axpKZwWENI5sxuycBkYTQMNwDHYXgQRD23aqV/bI03Re4iMVj5tdunqmD3R8n2SiuS+66B1CXqFtpzb/oXGs6VERd6oy/SzJjPnIx1lXDOD3FREZuVxPJcCVEiQF4sOecTsH/dS2G1us3pSaLF2Pri5thzZSMvEB9pc8XT9C75emglpsu2JC/O7d7R18H+ORalz4J6wjfxP6yBTlqDPiX1+RJuU16e7EsxxSMrqnYuZqW4M93hDL8aD0/rl8Bslo2dNG36yWWqrrZCKtK/DU57fcbfgck6Mq1FG9G8/bnOfzQUvekkc5b1ln+Fu3lkGZBzHqIYs0LtBQqF40OEZ2+ui62ZBi6v24cC4rvd/iNS1mvmZskNJDG5F3FHsA0l7q4qaJPx9E5U+8+OH26S2qlhqr8ZBdpR0IVs4B6ffX79Kqx/lK6LlRmQFE0mL4UVgid+mgfvIc5Nj6xFQ2GYlv/b7MsM2g==
x-ms-exchange-antispam-messagedata: f/kSozqQhULstnuRscgc4FczHUKXJRS6L21uDGmHExeqowEVANWyfwmJW5zS5lmA2b19hIXHt0DLdgLnXa0NHDhsXSGKrMI9+5wRQWsnzjy4kAAIN3gdQc1d1FAFkvasMUyWsOQb2Me6+WFcSA0oKg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbc272f-fe7d-4835-e6d2-08d7a5b0fad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 18:19:43.6120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kd5nFaRK0MBqOiAFAzdwahP2MyrmEhFDxxTkjN2+k4CU1Znermih106voyfJ86Qot9zTbvhPIsGpvTqURusZDp9jO4NboWY8GbBxlfYz0oM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200130_101958_594174_B0CE727E 
X-CRM114-Status: GOOD (  11.69  )
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

On 01/23/2020 06:23 AM, Max Gurtovoy wrote:
> On 1/21/2020 9:22 PM, Chaitanya Kulkarni wrote:
>> >Please see my in-line comments.
>> >On 01/20/2020 04:52 AM, Max Gurtovoy wrote:
>>> >>On 12/10/2019 8:25 AM, Chaitanya Kulkarni wrote:
>>>> >>>This patch adds support for the bdev-ns polling. We also add a new
>>>> >>>file to keep polling code separate (io-poll.c). The newly added
>>>> >>>configfs attribute allows user to enable/disable polling.
>>>> >>>
>>>> >>>We only enable polling for the READ/WRITE operation based on support
>>>> >>>from bdev and and use_poll configfs attr.
>>>> >>>
>>>> >>>We configure polling per namespace. For each namespace we create
>>>> >>>polling threads. For general approach please have a look at the
>>>> >>>cover-letter of this patch-series.
>>> >>It would be great to get some numbers here to learn about the trade-off
>>> >>for this approach.
>>> >>
>>> >>
>> >Already posted these numbers with QEMU nvme-loop here :-
>> >https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fpipermail%2Flinux-nvme%2F2020-January%2F028692.html&amp;data=02%7C01%7Cmaxg%40mellanox.com%7C9308e8badf9f41ec4faf08d79ea733ae%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C637152313279111655&amp;sdata=RM3%2FcVeRcp8hgyAUFIM%2B7wbZ0cw2xvhdsfcVp9FuPm4%3D&amp;reserved=0
>> >
>> >IOPS/BW:-
>> >
>> >Default:-
>> >read: IOPS=52.8k, BW=206MiB/s (216MB/s)(6188MiB/30001msec)
>> >read: IOPS=54.3k, BW=212MiB/s (223MB/s)(6369MiB/30001msec)
>> >read: IOPS=53.5k, BW=209MiB/s (219MB/s)(6274MiB/30001msec)
>> >Poll:-
>> >read: IOPS=68.4k, BW=267MiB/s (280MB/s)(8011MiB/30001msec)
>> >read: IOPS=69.3k, BW=271MiB/s (284MB/s)(8124MiB/30001msec)
>> >read: IOPS=69.4k, BW=271MiB/s (284MB/s)(8132MiB/30001msec)
>> >
>> >mpstat:-
>> >Default:-
>> >CPU %usr %nice |%sys| %iowait %irq %soft %steal %guest %gnice %idle
>> >---------------------------------------------------------
>> >all 1.18 0.00 |60.14| 0.00 0.00 0.00 0.08 0.00 0.00 38.60
>> >---------------------------------------------------------
>> >0 0.00 0.00 | 32.00 |0.00 0.00 0.00 0.00 0.00 0.00 68.00
>> >1 1.01 0.00 | 42.42 |0.00 0.00 0.00 0.00 0.00 0.00 56.57
>> >2 1.01 0.00 | 57.58 |0.00 0.00 0.00 0.00 0.00 0.00 41.41
>> >3 2.02 0.00 | 79.80 |0.00 0.00 0.00 0.00 0.00 0.00 18.18
>> >4 1.01 0.00 | 63.64 |0.00 0.00 0.00 0.00 0.00 0.00 35.35
>> >5 3.09 0.00 | 63.92 |0.00 0.00 0.00 0.00 0.00 0.00 32.99
>> >6 2.02 0.00 | 75.76 |0.00 0.00 0.00 0.00 0.00 0.00 22.22
>> >7 1.02 0.00 | 57.14 |0.00 0.00 0.00 0.00 0.00 0.00 41.84
>> >8 0.00 0.00 | 67.01 |0.00 0.00 0.00 0.00 0.00 0.00 32.99
>> >9 1.01 0.00 | 59.60 |0.00 0.00 0.00 0.00 0.00 0.00 39.39
>> >10 1.02 0.00| 62.24 |0.00 0.00 0.00 0.00 0.00 0.00 36.73
>> >11 1.02 0.00| 62.24 |0.00 0.00 0.00 0.00 0.00 0.00 36.73
>> >
>> >Poll:-
>> >CPU %usr %nice |%sys| %iowait %irq %soft %steal %guest %gnice %idle
>> >---------------------------------------------------------
>> >all 1.08 0.00 98.08 0.00 0.00 0.00 0.08 0.00 0.00 0.75
>> >---------------------------------------------------------
>> >0 2.00 0.00 | 97.00 |0.00 0.00 0.00 0.00 0.00 0.00 1.00
>> >1 0.00 0.00 | 97.00 |0.00 0.00 0.00 0.00 0.00 0.00 3.00
>> >2 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
>> >3 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
>> >4 1.01 0.00 | 98.99 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
>> >5 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
>> >6 0.99 0.00 | 99.01 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
>> >7 1.00 0.00 | 97.00 |0.00 0.00 0.00 0.00 0.00 0.00 2.00
>> >8 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
>> >9 1.00 0.00 | 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
>> >10 1.98 0.00| 94.06 |0.00 0.00 0.00 0.00 0.00 0.00 3.96
>> >11 1.00 0.00| 99.00 |0.00 0.00 0.00 0.00 0.00 0.00 0.00
> with all the respect to nvmet-loop, it isn't a real use case, right ?
>
> Can you re-run it using RDMA and TCP ?
>
> what is the backing device for these tests ? NVMe/NULL_BLK ?
>
>
I don't think null_blk supports polling. This is NVMe QEMU Device.

Don't have the RDMA setup, I'll create one and report numbers.






_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
