Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E672C38145
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 20:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2YO2uMYztmbvBwhP0vR+QAAEt9yWNB/qPLSTqRXekd8=; b=gF9XyNlxwSt29hikbvCjvtDpj1
	lFoHX3kzPdQ/ZVgkerMTk/UG+SUR6tEihcX6fZAkOxSaThxCA6wsM1sSWkgP1AjIyf45K9w4ECvaU
	DCIiBqQSNwAdzXtHO9NUivJETgoMn4StMTorYG75Qe8gmLKpUXn37FNP3F+RSWgq3GMooEV9aDH3M
	kufvYkQo3FjsI+gGnRAmEEozHq72R2DHMGS+aAAKhm9I+VziJewbXDFn/+9eLSJoDSj+u9WylGsxi
	gZSRr9R0pmPden0nF+nNMD3VtFqHVG8R24BDdaCegzxvsF56MqP2vVs7sErfAZPcynlsi3RK3t3Jn
	Xg8Da1zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVewR-00H224-8s; Tue, 06 Sep 2022 20:13:03 +0000
Received: from mail-bn7nam10on2060.outbound.protection.outlook.com ([40.107.92.60] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVewJ-00H1yX-Sg
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 20:13:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZyLHoNs7XiLNeNxEPXfxnqERSdLvcZMEGgP9cOo+a69voBLn89zecd9ukpKPC6FaskeWO5t6wSB0miz2Dy9a31PZlmHXClfcJFDdGgE6nASmCV7eEowljZDgp+CSocSZi8mJT5aIN4OlbQl/5RFpkYNYlLiyyfEMlnwI/mVsxefz3XYaAzGXPFQwqmifaxVym9acFfmTzWLDmeDXLvby+TjnIj4Ome2u1Nqw5EoQ/Q2ZmWvyWh+Ga052xWfkZy6KJZ7JI+Sh6y6p1lx3jjJ+JakKXe1kk5N3ZCzpVv5gATMwoz6cQXcUVV8nNF3m4gbBN+oSswZwrLmL0WZ7Zn8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YO2uMYztmbvBwhP0vR+QAAEt9yWNB/qPLSTqRXekd8=;
 b=XsBJkdUx9g3oUt71/ewikZ9sTOJBIvpSXEASoEOY9MNY3G9msNuY6cGs/ooTOnxsKYYlZOXQZHgEKkQ7UQrNgLXnTxaeHxrmsPR59mZt02jLF2sQdZUyWEy5L9pMYH+newhJHshuPGeQx0d1bTKgGUGAV2GijcVS0C++kHLkbGtcONEmhoEOrp9LUcsx1X3KybkZVQtRWNi3ZY6Uxah2QAj4oWC6gtsx4iTfVFu238mkKzORP4wNR8fnGNXxhmVqbqqJoe9r1tvge7ecdtYLzhUArvt7Y7rIPt7a97KJmt5P2xso846HHAu/0TqGD2bswYRSHFU2BqXS+K3QsGw5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YO2uMYztmbvBwhP0vR+QAAEt9yWNB/qPLSTqRXekd8=;
 b=AEi/dGZLR1xHh70hCzMcG/7H+9fRw0UVZPWvt5qum0bdWfjCWMWNaChChgtjbmUOuJOYRvdwwdGCI6XkTXezLyAtC3nXNEJLY7ZmVgPmNURUm0lQOQGrchTDOvyjIiMJOVzA84LSwyWGtQ2rqZ48X06QZFwBjlbIeFNzD0YQbNI+reUdrU1K01jh/GKNBSZZ2mYMUh2rTTmFEOwIwxs51WOQhet4KYkdlT933ckXrKNRk7mfzCcpMQWLGT/lqFL1FX9BuIeRc1bpccipFVJgefBlYW0+CFT7NE6gxzeKmGEx8CfGZLih74lgJoxNUjIpJ8oLLwkCWJAoLnPrVzAY+Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Tue, 6 Sep
 2022 20:12:48 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 20:12:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Martin Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
	"axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, Martin Belanger <martin.belanger@dell.com>
Subject: Re: [PATCH v3] nvme-tcp: Print actual source IP address through sysfs
 "address" attr
Thread-Topic: [PATCH v3] nvme-tcp: Print actual source IP address through
 sysfs "address" attr
Thread-Index: AQHYvtfAbuGNkxjAmUG3/1NDIxCSwa3S3GCA
Date: Tue, 6 Sep 2022 20:12:48 +0000
Message-ID: <6f029a9e-cc12-e049-8e61-fa70c491324a@nvidia.com>
References:  <BL0PR13MB42919EA6B50B34A1A60455969C7A9@BL0PR13MB4291.namprd13.prod.outlook.com>
In-Reply-To:  <BL0PR13MB42919EA6B50B34A1A60455969C7A9@BL0PR13MB4291.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6c8ef1c-92a4-4fa9-69da-08da90442b1e
x-ms-traffictypediagnostic: CY5PR12MB6105:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  wEI0C6yHEAsS+uVWwNKQH0cL1zzueH3LObMp2Gr3jBp4yY/OqBF6QxwBql10WsFQgl1QhC/URPcS2WHV+BKx7EuGfGcsohEnrXQeiLsTw3XJBi5ZFX+6ny5ARif6Wei1u5Fyo2RDrLd4CK8Piy0SzMo1CiBGy8PkACEH2Z6aUAZALMaP3sYGPKFGbvh29JmkDFvTgg9s+SYFIbiKJielNz8/RpSCFgQ1VbhYtFMZCLk+Zt8jARZvOHktT6RRMjVg4gVL+CMbkOc0jKHd7ouDQRVH6K9t1SodkqMi93fPfv57EhMAOd8VW0dK6y0kRKjcuiAKhewqvhZpke5tQMkiclFGx4CFl+wIqyQFLmzUIaMXqdttkTISOg6Wxx3m2r2ipxXG0T8iff06eSyrn2Ubg92joMpqrN9ESZhorz2X7VoGXlACbLoEqn7B78Qh2OfNZ8ZK9KkDQ0Sj3anxXHqp8SILrNcKJh4lBJFtnq+kBc93ifUA2tlIvs6mLeEmuxu4JKDiHeai1w3gi+iVqR0s0LqiJTABEsDQZ9GQ+/YyG9SfHdZIWSMAposX9Tt4Y3iz9dW6GhQC422gHSOPi8l/3t2Wcj2nqlnni0HskcBRu/jkEi3qsrX7HZj3HCxiID9cT5ixnL991lqBPRtatwWJeyjj9ADmdo5wq7vvldRA8evWLmf1WDhoB1XokPPZYwPMxZ3BQU7abPts1Fxet9e0I4t/l/p8Rdd6XhCfOIM6trSPF0nnDqMJbM2U0YaUvLQIzeNfL0keVR18VVWYGLtfnGzfHaHK9Qs0EM7Bk+/23Dbt3IvR9x1n/PJu23U1S6D3ecT4ofL4CXWv815InCCXQA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(71200400001)(5660300002)(6506007)(6512007)(2616005)(8936002)(4744005)(186003)(31686004)(6486002)(36756003)(41300700001)(478600001)(86362001)(38070700005)(83380400001)(54906003)(110136005)(122000001)(31696002)(38100700002)(91956017)(316002)(2906002)(8676002)(64756008)(66446008)(66946007)(76116006)(66476007)(66556008)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?NHJrY3NQam1ldnJSZnJkd3BhUnVmVnFWeGNxbThpRU8wWW9pOGVyelJrWVF3?=
 =?utf-8?B?S1dxK2hzNnZTT3pWU1BGbm5zOEJMaXhVKzUyWW9hMzhESTc4NjZZdXNMNWxo?=
 =?utf-8?B?V2J6ZGRualJRRmdLWi9IQmVSQnB1RWo2a3lNeTZYMW8wWkVNN2QxQ29HSlNN?=
 =?utf-8?B?L0RKcFh4TjdndkNETVRGNjUrbjRYTHJNMVoxc0hzT3AxM0VOWitHRFFKdHlD?=
 =?utf-8?B?RnFYL0lLaFI5MnAyVVNOYmk2MXVuOUhrd1VWQ054L1k3VFA0Z0x3akd2MU5T?=
 =?utf-8?B?RlcrMDhrUXJRcHcvQitKS1F6VkRxMXBvdDZaWml5N2FzWWJGcUI2S2R0WEZx?=
 =?utf-8?B?UERNUmpzVzkxQUNYa1NEV1JxUUdLelFqMW9qV1dOMlZOUld3Vml5aHVHU2Jw?=
 =?utf-8?B?OGk0alczY0ZTaG9vSDVURklGbENFM1RINVRJM3RBZjZMOWM0dXhvZUVnVjBK?=
 =?utf-8?B?RWoxS1d5Q21GRXBHZkg2RDBLUmZ4WVRFK3U0MnpoQ2RWR282eDI2WXZCWDQ4?=
 =?utf-8?B?YlpyeUJDZFFPYnpMRWYwZ3B2NjJTY1JZeTY0RytGWElTMmh4QldqRFRwakNs?=
 =?utf-8?B?YTd4OEFkcmFWbUhraGIyaXFJVytaTi9mMFVTeFJUL0l3NXdQTzBaa2QxQWZF?=
 =?utf-8?B?Tm9FWUNmVnZJRW5GekJLTmxWTFBxb2h3RWlXaGhTbWxPZHNwTkZ6eSt5MmIr?=
 =?utf-8?B?ZDNkck5UbU5VYVl2QkpUOHZNcHQzTnAzTUtRcGUwYWNnbU1jZUNXU0trdXdC?=
 =?utf-8?B?UE1jQWNJZ0pFTlNhVUdTVDBIaXdhSHlkWlVNQ3Y1dFlHSXVGMjFWQWlYQjFB?=
 =?utf-8?B?Ulp0VnZnWFM0RnlJV1NvWFMxVUx0Z0lkd0pPSVVuY2RqTWVSQTJBOUsveExD?=
 =?utf-8?B?Y25PeXhFNS9rOGdaNlhGNkd5VUNZYkpDZ2JoLzNkUDNHdUhkd1FIV3hSbmFP?=
 =?utf-8?B?OWZxM25wOEh5MWpzUWg1d1F1ZmZ3TStRUWpLZ1hGaDZsN0l4R0NVQmdkRU1n?=
 =?utf-8?B?TTFjV3R6dXd1dlFLMTVKYWc0d3Q4NTZ0a2xJVzhIdXY0ZGM2eWdvcWgwU2pH?=
 =?utf-8?B?YVdhSW9NZW5kT3lmcElCaDMzRUVCTHdIRk1Lc2JLMzI1Yis1cDVVT0g5cFQ5?=
 =?utf-8?B?cW9ybE5JVzVhWDhKMTJuUjh1VDhaYUtmUUZqNWhldENzZHdyOEJOQVRZcTJw?=
 =?utf-8?B?MHdPZHdCZHRjOU9qd0JhTFd5SjlnRlZZM0FXb0Y1YzRhdFRVbU1tb3dqVllU?=
 =?utf-8?B?Q255UjUvM21Qb0ZhREFxQzA1RnRBa0x0dStkQXk3ei8zQ2drZUJhTURvTm1C?=
 =?utf-8?B?ZVVwTzNnMHlyTW1mWDlCMEM0bmlrQWlEeFRrWXQ2SnRNUTVYNW01aVFUZTlO?=
 =?utf-8?B?R1JZSU5QYXRwVTM0aFZ2UW5qaDR4VzlBK3lTR2dQS2FheHQ3TTNDb1dCenZ2?=
 =?utf-8?B?K2R0MTFicThFeDJYYkZsTHBrVVZrTzhzVHFnSGx2TW1aOFdHOWxZTW1ZV0Vr?=
 =?utf-8?B?VmN3aVZ3R2lyVS9qY0FMYXM3TlpLR3V2Ym9SbXRzU014eEh5c2lMcVdJRkVC?=
 =?utf-8?B?NzJJeTVaay9jSTlXMEpqNDRuUXJTVUYrSEU2WTQzdE1MM21MYTBudi9nYW5K?=
 =?utf-8?B?WEZLQjdDOXBjUFUwSERoUlhlWDM1bmxtMDIrRTl1dkxGUVhkQXgraXRVcXhx?=
 =?utf-8?B?QmdUcjFody95Vk1BZktLQ1JicCthajM1V0tPRGpFSDBIcG5haU1WNjlqd25s?=
 =?utf-8?B?K0lyenhjVmR6aHpBVEluMFoxUm9BWnpDRmdxM2ttd2E2ZDRNb2prZ0hvQnJ6?=
 =?utf-8?B?L3cvUDU5ZDYyeEhYUDNSTDNWSHRCZHE1bG9RWTRNZkNZRnJkYU1RZmJvZTNW?=
 =?utf-8?B?Nk5LZ1docUJXRnlUQ0JoNnM0bzlvYXZ3Z2V3UUJWYUw5akdOK1Vrdk9CVlNB?=
 =?utf-8?B?UENBNWhsK3JpajJYZzNlelFWaGtUUlBzOW9jbnFoSFBEaWU1T0lucStQWnd3?=
 =?utf-8?B?NmtpU3U5Ym5QUnJuYjl0WnNHWmsrMy90c1Z6WHBOY3RaN2hNN3ZZejhMU1ph?=
 =?utf-8?B?cWhNeFdzcmp0YVFzcGNJUTdwY0txYmRkWFRiRzNoelErZDRlQTNnclhSaGFT?=
 =?utf-8?B?NVpVeFd4NFB4UTI0ckRjZk4zMFpBaURWTnBQUUdzWmxlVy9BdGljZEVaL1lI?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2F74D4DD512DF43990C6EB7D63668B8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c8ef1c-92a4-4fa9-69da-08da90442b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 20:12:48.1467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgtenQm6gcennxO7b5+YFihqosGXgA+oK5dlioDMRQP5S/ips1xzStLYwXT0RI9X/jXuA8Yuk5sKZLFYQ6NDeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_131300_051041_CE0495CF 
X-CRM114-Status: GOOD (  12.80  )
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

DQo+ICAgDQo+ICtzdGF0aWMgaW50IG52bWVfdGNwX2dldF9hZGRyZXNzKHN0cnVjdCBudm1lX2N0
cmwgKmN0cmwsIGNoYXIgKmJ1ZiwgaW50IHNpemUpDQo+ICt7DQo+ICsJaW50IHJldCwgbGVuOw0K
PiArCXN0cnVjdCBzb2NrYWRkcl9zdG9yYWdlIHNyY19hZGRyOw0KPiArCXN0cnVjdCBudm1lX3Rj
cF9xdWV1ZSAqcXVldWUgPSAmdG9fdGNwX2N0cmwoY3RybCktPnF1ZXVlc1swXTsNCj4gKw0KDQpu
aXQ6LSBjb25zaWRlciB0aGlzIDoNCg0KCXN0cnVjdCBudm1lX3RjcF9xdWV1ZSAqcXVldWUgPSAm
dG9fdGNwX2N0cmwoY3RybCktPnF1ZXVlc1swXTsNCglzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSBz
cmNfYWRkcjsNCglpbnQgcmV0LCBsZW47DQoNCj4gKwlsZW4gPSBudm1mX2dldF9hZGRyZXNzKGN0
cmwsIGJ1Ziwgc2l6ZSk7DQo+ICsNCg0KZG8gd2UgaGF2ZSBhZGQgY2hlY2sgYWJvdmUgaWYgbGVu
ID09IDAgY2FzZSA/DQpJIGJlbGlldmUgeW91IGhhdmUgYWxyZWFkeSBjaGVja2VkIGl0LCBpZiBu
b3QgaXQgaXMgd29ydGggYSBsb29rLg0KDQo+ICsJLyogUmV0cmlldmUgdGhlIGFjdHVhbCBzb3Vy
Y2UgYWRkcmVzcyBmcm9tIHRoZSBzb2NrZXQgKi8NCg0KYXBhcnQgZnJvbSB0aGUgb25nb2luZyBk
aXNjdXNzaW9uLCBhYm92ZSBjb21tZW50IGlzIHJlZHVuZGFudA0Kc2luY2Uga2VybmVsX2dldHNv
Y2tuYW1lKCkgY2FsbCBpcyBwcmV0dHkgY2xlYXIuDQoNCj4gKwlyZXQgPSBrZXJuZWxfZ2V0c29j
a25hbWUocXVldWUtPnNvY2ssIChzdHJ1Y3Qgc29ja2FkZHIgKikmc3JjX2FkZHIpOw0KPiArCWlm
IChyZXQgPiAwKSB7DQo+ICsJCWxlbi0tOyAvKiBzdHJpcCB0cmFpbGluZyBuZXdsaW5lICovDQo+
ICsJCWxlbiArPSBzY25wcmludGYoYnVmICsgbGVuLCBzaXplIC0gbGVuLCAiJXNzcmNfYWRkcj0l
cElTY1xuIiwNCj4gKwkJCQkobGVuKSA/ICIsIiA6ICIiLCAmc3JjX2FkZHIpOw0KPiArCX0NCg0K
LWNrDQoNCg==

