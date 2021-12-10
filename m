Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93A3C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Dec 2021 11:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R0p0+dUSwO4TEnWwMvhrIMrPJ9w8NKT+pGUwbQ840SA=; b=Shq6KDIi9v/fi6nAxopFcI00LG
	cxXt1O3YG8K7HEnPMXwXivJL1NIwX3hyEvC/LWSb2zLKx5w9ejhWIQ7Xs64wBe2aMHhoo4CdveBeM
	oxlAepuchgMuGDuM4buZk4J4yfn0uzDs7Di3WwIqvfIW8zFtAwl4zWmOVn/HdcUXscLokXnRQnsym
	2tLNJpPN6pkkOdhwgbHCUGzXw5ntKgF4/ofB/Z8YQ6wEOPx5pPYnU+qTD4n1aT9/iOevOycToIHMh
	aKYw7IZ6bNd/xaUNEhYknYDKwjkUJpbSU5hhdHEMOEDScHpFC9IZBHBoGndQpA+nk4616XcPC5Al5
	d6njeohA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mveCu-001hSg-1m; Fri, 10 Dec 2021 11:36:56 +0000
Received: from mail-bn8nam12on2045.outbound.protection.outlook.com
 ([40.107.237.45] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mveCh-001hOn-AU
 for linux-nvme@lists.infradead.org; Fri, 10 Dec 2021 11:36:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqOYAQT9dbNAPqd6M1FI6lBDThlADYFXs+rxHuTnBa2WvNak7jjzgJ2uzcTnutvAhGQu2a88wsXmUw183A3+4BADIOJELAXoJtKejnW3p9ueRfMZTgFzH5465zias2Z+VUyJn61eavfHM6SwgSfRhMyhwodocjsXWKeUakEryaxuIXMqKjIyN5KgDY/XsKaiTqMZ0cQ/UVw3+tCjyu/Mf7A6uzsYunHUpThzOTChIn668WuQ8XohVnieVw5m/BRlL0DjRULUOSSiUGj2w5aHR/2kMxoJTBFnGg/Ew9KhmUBStWv5WdtA91FSXmdyy43vHps7SyrIZ6VCjK4g3irDyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0p0+dUSwO4TEnWwMvhrIMrPJ9w8NKT+pGUwbQ840SA=;
 b=mAhGwpIkCXJfUcHT6/6kKkj52YVkY/abv6Gm2wJ31x/29UHl8e2WSDM29KxaI0UhYY4CWCWPE9GKLmR2wiDBHspCkXGS9n888rUcQt0jajoMu0iDKujqalnsTO6KOgFZMxqureeTWjdOjBAIjJjg8+iPq8epLJnumidZZcRJL+TStIEkUFY2kKDuzJWHspkLYRyVVcejHq0faP3yd+5iQ6M+MtZXnLIw35K3hWwWjLOmrM/bD7uDFEwW3uo5gao9mXWprFJy6nbe5IAyzvfgqATbCr+Hu+SJ333EyaaNDZInyLt+Y44L3b46/3edLnPe3VoAWm3Qb+Su5XUYv5yJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0p0+dUSwO4TEnWwMvhrIMrPJ9w8NKT+pGUwbQ840SA=;
 b=BK6TcpofyqkgCiH6ORtBLxuwIhMNt96HZORep5yBYMLe1scTOr9PKToeLndxW1OBypXdOZe+hRadlz2H4UHug9FwX+0qr/e5o05xq8SqQJgoJXJtHXsXtyAUr39BnBhQuPU5y6NvM+op/5MnJHPya3KPWtqwrSxw8Pg3KbhT4MQoJme6eebASObG2kaJwHyg3gmF1AiixGdMjhINdRmDzwi6m+Z9NrqQAR4Fq2fBf9duhbPST/qzURGtcHmf7RjvxZXJ6i5NAqJh6HmxwGZeId3i0AKp7ZjlscQb0AlEPp91OPJ3Tf6JFNGAJN3CVNs0U1MseKEQr4Dt8CB1/CsyBg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1581.namprd12.prod.outlook.com (2603:10b6:301:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 11:36:39 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 11:36:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvme: Add verbose error logging
Thread-Topic: [PATCH 1/1] nvme: Add verbose error logging
Thread-Index: AQHX7SNElKpKCM+2R0+aIivULZFZVKwrmhwA
Date: Fri, 10 Dec 2021 11:36:38 +0000
Message-ID: <fc8f5858-3bea-675b-003f-b59059bd5e5a@nvidia.com>
References: <20211209173213.14249-1-alan.adamson@oracle.com>
 <20211209173213.14249-2-alan.adamson@oracle.com>
In-Reply-To: <20211209173213.14249-2-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b3df387-0510-484b-581b-08d9bbd15492
x-ms-traffictypediagnostic: MWHPR12MB1581:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1581247E6A0FF52C072BE515A3719@MWHPR12MB1581.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 45U6n7hFG+LYb7LOfgIUQj4Z76qup/SYKvszjo7R7BPYjtbZ2+XJlep8JEXmpmJbvaUSS4m1qgj8xM5aYEdIzZJ4UvmMwUINsgnkl5H/vJzeWlwoIqxrDLQqsALALmqAf/w+XVTQ1Cq53j/scZTnrOXvOYjhgZAP4DNmZd0LBpkuuzwbVhWCnq/e2if7tmRubqb8WcSDsqQoCdpUUqHLCJbjsaqFCeUthC/45VJCmzG0i4TtrtkYZwsS4hV1J2eTz52zeb+uA22OkfEYR6Z7MvIezfNiE7wF0AI85f8zLsCAZisMG912dvvJaSPgMVtfqVBgyA58SO1U8AKGMXCF/OGZppgJGQzpMaVFK0OCKtJjVQxzJUnW95pwLrV8aevrwlOWWC2ESYBhKhWp5OvrPRsfVDipPn4OFPuDdp9ee/dWFSK+jgVamf74wt8elzjCREovIprjtL+qrXTxxiZEpa7ZtsIPnY9PULPhp/e/xBbgLUVJHRPqgz61rsUsbpXQOqjlisAvkd5XUK8rt7C0/du9T8FPIdsHzeUBjlaY0RErelEXDNB/lRW3HIlhNZj5eiObjZjqvBDY/FEB+ZKlOrO99kVvLly5YqzbH6sxiMOj3e0L0nMaMXZaiAHf9IEd4l2og5eIMHP0BQnBNgmt1Y07ONTnPA2cSwOf7cKmup4Ei1+AQqkDpgkbYn6VzeGg6ujc48aEbeB7g/lSiCw4P2QZlzQ7+xXhfmB6B9Sn8jxcZ9QsIml9nzznRZ43VWERpWzKeSrjM4kRiErmLBUdhQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4744005)(8676002)(38070700005)(6916009)(66946007)(53546011)(8936002)(6486002)(66476007)(64756008)(316002)(66446008)(83380400001)(31696002)(2906002)(71200400001)(66556008)(26005)(6512007)(508600001)(54906003)(76116006)(31686004)(86362001)(5660300002)(122000001)(38100700002)(36756003)(186003)(91956017)(2616005)(4326008)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2o2ZndSV2ZiU3ZxMU9DMTliOURhR21WOC9aNXhjRjJuYTZXcWlCU1dLbzZK?=
 =?utf-8?B?RE16QW1YTDFDdm5OK2liT3FrQjNtaUloQ2tSTC9KWjEzYWV0cFVJZk4wMU1X?=
 =?utf-8?B?bTcxR1VJWk1QaHFJTW1jNU5RQURheERBSGJwLzlsb3VoZzRISCtTVGVRYW43?=
 =?utf-8?B?R0lQUUgrQ25JbHVpekhhK0FHd1FPSzQ1R3F3ZnV0Z0FsZjhta0NVY2lHNzRs?=
 =?utf-8?B?QlFjMGZ1QWMyY1JYNHFYdHUwdk41TjdQcWR5RTIrZGFNd3RuMmo4RlExV0FJ?=
 =?utf-8?B?Vy8yV3BmSkxKR2JkSjB2L3h1eThxczgycGZGRXRJT0hBZVpDcVZheEFmSVVY?=
 =?utf-8?B?Mlh6VjhyeFZhSE5HbUphZGJYa25IM2FWZzZVZFV1NWhpU0xJVFpFRWcvdzRa?=
 =?utf-8?B?UlFqZWJLa05EK3BYYjROeCtrUkRVRUdRT3V6T1lEWkJlL0F3cURXcUdBK3FE?=
 =?utf-8?B?MmlnZUJ1U0JYN2E5Rlo2c3Ivd3ZSa2VoSS9acVgwZm5wVlU5R1diak0rRWlj?=
 =?utf-8?B?VW04V1VBTldZdE5ZNXdQMitobENWRmxhSVkwWFNqTk51dGVOQVBGT08yUnZk?=
 =?utf-8?B?bHZ5TURCSzNaSlBIMmZxVUhnRWdPTlBwM3dsalRUNlNwZW5wVTNUOXR0VFR1?=
 =?utf-8?B?SjdldkNkVXZXTlJhU2o3bXB6ZkxHQU1BSXE1M1BSdGtBQm9GaGhzZnFmelNw?=
 =?utf-8?B?c0tYNE5TcW9WRDFxMVNaRzVwNGhKRElKUzRLaEthTG5odVdQcklQTlZ6ZTFx?=
 =?utf-8?B?Zlh0aEdsaUFPcHRSeTNuUi9Sc0d2RllQYWtTMW9ZRStzcUVLbVkxa2kvZHdC?=
 =?utf-8?B?UFlIOHdTUE1JOGVIYllrTXIyMnJFYTVNdjhRMTBQNVZhWFZIc3BOSmo3a1VH?=
 =?utf-8?B?NnZ6SWQxRVZaa3kvVTd1bXozR0lIbHV5T3RuYm5tc2RTaFdrL2ZwT3NOQjVF?=
 =?utf-8?B?aW1NWDQwdExxTzEzdXo3STJ4UzFRdFg2WW1sQmxxSWJqNnBpSE1HWXl2cldO?=
 =?utf-8?B?ZW0wNDFNYW5NYmVBOGQ3cjBRR3FmMWZYVWZhd2xDeUVXejFYdUZYOEJwY2JC?=
 =?utf-8?B?QkFuMUdYMXNaRk1JbmdSS1VudWFvNzlVeXF0Z3BYa2ZlWnZhdGZiVWR5Q0JL?=
 =?utf-8?B?NElsYTYrSmtjT0lhN29LaVZ1WHpBRFJRUXFKZ2FXclJ0Tk1lZVdZeGpoZzhO?=
 =?utf-8?B?cjl6REIzQ2w2ZVpVeVBFTmZLeXJhZW5RMlQzYkVGdnowcS9MUmh1U05CajFI?=
 =?utf-8?B?YnptZmJadGdTOVJHdFFzMGhLb0RlYWQ2RmtlRW0wNFVVWFowNzB4SlNBY2xz?=
 =?utf-8?B?MXZoa0NHUkZlUU0yOUNFblVYREpqRmFDY3RpUnc0YlB1aml5Y3kybVV5UGdJ?=
 =?utf-8?B?ZURLbGNYaVlTaWF4MkxoNXVRTjZ1MmhsNzRwbndOTCswaTdhMVBYRm5kSFZo?=
 =?utf-8?B?MjhuYTZWeHU0OHlZRElmWmtKWHRMS3VNdno5Mk9vY0YzNWFlcnBENzVBR2xN?=
 =?utf-8?B?VklnalNtYUlDNG9NNzdERU4wcy9RdnQwT3R1RStaV0w4V0pJUnB6eGEvY0tN?=
 =?utf-8?B?RTlJL2pPcnc3Z0FBUkowSXJ0NnFYMmEwZnVaK1RqWG50SUZ6SWtjSkoxTUt1?=
 =?utf-8?B?UFh4d1BITlNNMGFBUFJqM3cxMnV4TmNuMEpPZGZWVForbVZlQms4Sk9JY2Ir?=
 =?utf-8?B?blBDeXdvOVdzYVhzRjJ1U0hCbkF1UGlzMGZpUndsVmZ6enZ0ZmUvemQyNmdL?=
 =?utf-8?B?Zkc4cVBHVDZ4YkU1OHk5M1VXaTk1OU5EVFdmQTZZRG9iS3pQbWRZWnl3WGk4?=
 =?utf-8?B?bWtoNVgvOXBkbXZjOERHbXJNM21ab3NHYWlaVmFUSFA1UzBNbk5jV0tWVyt5?=
 =?utf-8?B?ay9EcXMwOGJTMmtVWXFYZGlLVHdyZkZtU2NMTThvU09aQlo0SmJRNGQ4YkIz?=
 =?utf-8?B?UUVIZkFML0Y4SC9HSURocXpOanB5cWxUUndDK2NJRnRId2JVMXFsNjE1bXZR?=
 =?utf-8?B?eDE1MU4rSmhiQ0FDMlZiazhoZkhmcFZPcEJJM0d4R29OTEhsTWhtYVpCWjBT?=
 =?utf-8?B?L1g1bCtIQjRsOUZ0eGs5OWpKUHVqZnlCRW90WUpnZFlhUTJkRWRrSjVXcjZv?=
 =?utf-8?B?ZUxQNG5vdElRZ2s5aEZOSitVRkFFODB0WVFKZHBuZGdvN0t1eDFSbGtZeDlo?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <221359196C931648AAF97DDC9BE5BDEC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3df387-0510-484b-581b-08d9bbd15492
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 11:36:38.9642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0d0aSGdd3m2p/0g67lWkYHx8c1nBqArRZVkRfD5VpJyel5rH7WMJ4GbvvMGnJs/rn8c8kDJzOVjAfhe4aM3s8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1581
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211210_033643_425541_5272D090 
X-CRM114-Status: GOOD (  14.53  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

QWxhbiwNCg0KT24gMTIvOS8yMSA5OjMyIEFNLCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+IEVuYWJs
ZSBtb3JlIHZlcmJvc2UgcmVwb3J0aW5nIG9mIE5WTWUgZXJyb3JzLiBUaGUga2VybmVsIG5lZWRz
IHRvIGJlIGNvbXBpbGVkDQo+IHdpdGggdGhlIE5WTUVfVkVSQk9TRV9FUlJPUlMga2VybmVsIGNv
bmZpZyBvcHRpb24gZW5hYmxlZC4NCj4gDQo+IExvZ2dlZCBlcnJvciBleGFtcGxlOg0KPiANCj4g
bnZtZTBuMTogUmVhZCBAIExCQSAyMzA0LCAxIGJsb2NrcywgVW5yZWNvdmVyZWQgUmVhZCBFcnJv
ciAoc2N0IDB4MiAvIHNjIDB4ODEpIEROUg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxhbiBBZGFt
c29uIDxhbGFuLmFkYW1zb25Ab3JhY2xlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWFydGluIEsu
IFBldGVyc2VuIDxtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEhp
bWFuc2h1IE1hZGhhbmkgPGhpbWFuc2h1Lm1hZGhhbmlAb3JhY2xlLmNvbT4NCj4gLS0tDQoNCkFs
dGhvdWdoIEkgYWx3YXlzIHByZWZlciBkZXNjcmlwdGl2ZSBlcnJvciBtZXNzYWdlcywgSSd2ZSBu
b3Qgc2VlbiBldmVuDQpoYWxmIG9mIHRoZXNlIGVycm9ycyBpbiB0aGUgZmllbGQuIFRoaXMgd2ls
bCA6LQ0KDQoxLiBJbmNyZWFzZSB0aGUgc2l6ZSBvZiB0aGUgZHJpdmVyIGNvZGUuDQoyLiBSZXF1
aXJlIGNvbnN0YW50IHBhdGNoaW5nIG9mIHRoZSBkcml2ZXIgY29kZSB3aGVuIHNwZWMgaXMgdXBk
YXRlZCwNCiAgICBJJ20gYWZyYWlkIHRoaXMgd2lsbCB0dXJuIGludG8gY2h1cm4uDQoNCkFsc28s
IHdlIGNhbiBlYXNpbHkgdHJhY2sgZG93biB0aGUgZXJyb3IgaW4gdGhlIE5WTWUgc3BlYyBmcm9t
IHRoZSBlcnJvcg0KY29kZSB0aGF0IGRyaXZlciBpcyBwcmludGluZyBjdXJyZW50bHksIGlzIHRo
YXQgbm90IHN1ZmZpY2llbnQgPw0KaWYgbm90IHBsZWFzZSBwcm92aWRlIGEgc2NlbmFyaW8sIHdl
IGNhbiBhbHdheXMgaW1wcm92ZSBiYXJlIG1pbmltdW0NCmVycm9yIGxvZ2dpbmcuDQoNCi1jaw0K

