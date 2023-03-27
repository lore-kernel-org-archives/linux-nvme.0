Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23142C7619A
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 07:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SEmozipYyP91Rl8mYwVsCQj5B95SizODpktAdYyKgtc=; b=1x3XOslI3TcmgJRzdJh37Howk5
	1e5zVutDpqFLd+vvZPmkhn916ieyg5+v5JwoodSSudVQZOO5Ys6faKjsvMbwR4fDVMXZZ6vIgDnhy
	A4tAm+Kpvu8q/cSbK4KYZQNpX41sMGg81D/pApkY79TyvVsm1K+ZGsTIS2r22HujGz1vCt0tzAJFm
	HBnoiBhPJMrMT0zeD74h4RF3jEQL5Kq7cP06Yj9oJOGHsy8iVERTmsuwOZUleKOHUl73tMiLmY/sO
	e9qdceujFZ17t+NGNy9JC1z/gle52ZBsdJvFNykQYAKWHwcUdYR4um16M1vR4xK0uE07Wd0iXuN23
	XQYQGTtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pghT9-00A5lB-13;
	Mon, 27 Mar 2023 07:40:43 +0000
Received: from mail-mw2nam12on2062a.outbound.protection.outlook.com ([2a01:111:f400:fe5a::62a] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pghT3-00A5kc-0I
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 07:40:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCloohaZrxB38nNl61iFFFd2ZGQhB/r1yP/lAY6TjJWTTrQYe9206N4w2jtOG6yT55FaRJoTLKvsmm8WHrAi5lBIkwR84bHULuaTkX3DlEvtvHnCFZIV6gGnLx7QkbXn1ntOppAlx6ZA1mgYdlKQrSyaD30ME4LIzywT8dF21krIaUtSdG2b1+X2Ep7J6JFL3D+IFTH9JdYIiiOiT/dw/WOuudSjvOPh3DAiTkDl9IP5aNzGZKMqN5+kEqSYODKsczXoVMOFD6WWFzpvMJWRH8LRw8NrSiXQ2KzlA+WoVKy6jWUqLxS7cLOCaWXUwpMD5aq8shDS268JDuo26g4QhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEmozipYyP91Rl8mYwVsCQj5B95SizODpktAdYyKgtc=;
 b=F8bsmhN5Uh7TIp4YqWkEIerxibuSCWNzl96As0tqmqa/Gycz7CefG5amALYxkkT/NOkXncapyOMxoGbBrVTC0aHSRc2YPfh0lwb1RLtR52zrrhfZEETnAPD1XuELtf+EKxtXFnm9IkFAruRG3PtZCMdYd/phz1QschiHBwIDWQixg0a/0BWtUeLJlRjTymXv61JjoJM6hcu1PdOAu8Fwj2Z42xxXmakjWMEMsciIuhBBmvjOqjTBQDjJ3DRXFpy2Uew39lnC68jReqGrTN3pWJUHqSsmVQ6SQTiZE3nJcWH11+JOTH7PN0Qqb5EQ8OOpmWh0BWHhx+ecZjGH5rZQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEmozipYyP91Rl8mYwVsCQj5B95SizODpktAdYyKgtc=;
 b=ex5qoirT8INglhZZHzLcdJ+dT+Nqq5AX6VYojbS42K9oBrrDiayWPYfWqLzPJxPsVsRBpwcu3Kl3kfZe8v9WhK1RLyZ+Cw6S7aSim5TJlcdZ1sMQjFJjo5jzJiZ9u4n1XYZVBMoFnFZKdoMlW2VHMODnq6ij34CHWopf28YhpBY7nYhcjqtte4Szj0K2FzeTAB10pFHTkpTJHCdv8IPQuPeyJ4iuj34ip9DM36KIytnBsinLh0C87k7mk97vrkC3Rxs3sPji9HDVGQTM41rra3Lf3jHht7YH2HyZ13B7uhxhX/6+x1RA/hQsdkaNy0WaZ2lI+Q54fULmbjn9KnRoAg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 07:40:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.030; Mon, 27 Mar 2023
 07:40:32 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: cleanup nvme_should_reset
Thread-Topic: [PATCH] nvme-pci: cleanup nvme_should_reset
Thread-Index: AQHZWBECOtrndzqyCUmwcS6pcJjlr68OTq6A
Date: Mon, 27 Mar 2023 07:40:32 +0000
Message-ID: <96b25961-572d-241a-05f9-5c93ed9e93f3@nvidia.com>
References: <20230316140857.873370-1-hch@lst.de>
In-Reply-To: <20230316140857.873370-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB8070:EE_
x-ms-office365-filtering-correlation-id: 8dca9965-e3fc-4a02-6411-08db2e968b6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  KVnSw06ZEx7D6JCeYDAcMsr55ZJlSZ3OQBCfEGKIJlnly3w8Aybt7Y7kJOSL/KKmC7lXRlzduudHIpF9FJxLjtH09OYw+/oRucffuCtrER06FfOHUoZhmZy4NzxiW+WhL93d+/vKxYnx4f6OUiHgDM3hy+/WXdJwoHL7ygN8eIqNWGl1oRjZibPSpu7nGCywqDBVFHeo5znS2CniSRrmtkZ7XxEHeBz/8TKxr7Kt5E9gILyYU4naLnNa2meC4uizNycjYBPWN/koy1qMaXQL2hjdMmrSqkM3JTKrZZ9/jSufe9WyS7kGQir0C9kg2wwKwum7GvEgOR6GUbgGLIoyfOi1TmJdHugEn0l8yB2Ui82RhkUqdIuR2q+Av4zuj/FyDNudqIVGGiHk3IEtLEl/VGDOYh2pMz/t2vbzVXX23xiB5Tk7MLB6V0ef4KyeLpjIJi9L5no6TiJkOpbXSIOnY/HmIlHi7f/i9/XcH9AxYHtmA8MySKH0KzuG7fTSDQTQNARboDMCLt3RmFcQrK4Sla1P0Mp2K9UjXtJNsq9o3ldTQHh94O1zJDA8QYYVvbcBRFa4UJfOiHogwBaeDJzY+oefX8/lRcGc1zJulPpa7pVT0qONYHvkapT3c3bHRdRj4lphtEXPM+FWF54d0BClm3dgND10OBXiaURvuNZPs8xGgAoD+Tu7Izw28QHPRUy5
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(110136005)(316002)(478600001)(5660300002)(122000001)(8936002)(36756003)(38070700005)(31696002)(86362001)(38100700002)(4744005)(2906002)(4326008)(91956017)(66556008)(66476007)(66446008)(64756008)(8676002)(76116006)(66946007)(41300700001)(186003)(6512007)(6506007)(53546011)(2616005)(83380400001)(31686004)(71200400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RFQ2dEhsSWp6YUVZKzE5MmFFcEFPZFF1UnFDM1hPRXNmRVZBZ1RLcm9URUhz?=
 =?utf-8?B?dHZWa3FWVDFIclh4TFFSWEJNVnVPOWhZMVVEOUc1TGdKa0NaVGFtRVNkOXgz?=
 =?utf-8?B?WVo4b21EUHhwVERPVjFEOUpsdFQyNzJPSVZ4RHlVeFQrdzZ6dzVkVGx5emln?=
 =?utf-8?B?bko5REhWcUkzNmh6U2kyck5Xa1NrMGpnTm9GUkZqQWI0SkJlQVpCQldUY3dq?=
 =?utf-8?B?Nm5rUzFCcVVNNnpWZFVoOTlWdFF6NmJwMjNkMGIzZUFsLy82cVZVYkZCeEVJ?=
 =?utf-8?B?NUxscGVWK2p5TGF1cnpSK2dHRG9oWTNCNnVSQi9MU0NLbUYvaTMvSEorM0di?=
 =?utf-8?B?Vnc5U0F2WnFUZGo5Ty9icjR1bm5sS0tzMVJpMThTc0taQzJiNUdLdTFScFd4?=
 =?utf-8?B?eDNlS2x6cVNaT1hodFFHVU55WmlIajFnakNMVWRHcWtHZVoweXVlVjRRWE5U?=
 =?utf-8?B?SnFvSlpxOWE2UmVQMWo4YkVYQzFkS3RSUlBmT2VVNFI1RGpaQ25ZbzhCcnJt?=
 =?utf-8?B?MXh5R3JtN2pxa0pDODQyQWNDQkNnY0ZkWG80T1Q1akJOcXJBeFJMazFocERk?=
 =?utf-8?B?LzdnTzJNQ00xbWx6TzQzSEMvUXg3dlhYc21NU2FkeTI0NGNXejBNOFNJOWpW?=
 =?utf-8?B?QnIxbHQwRVlyNUx0OWl5NXYzdlROREgwYjY2VUJMUkpqYkNiVy9EbWJ3RlFJ?=
 =?utf-8?B?UjhMdjJ3NGVJSFZFZTBta0dHYW43enkxd3h2N2NkajZpYnA4RVBaYkYwUFM2?=
 =?utf-8?B?TWc2dXlVRWplZ25YUTJyWDNvWHZPUkt1dGo4TVZaZXVuY2tJeFEzOHJHdDdF?=
 =?utf-8?B?TmNzb2JncTAzYXFXNUZxckRpR0ZwNTlRQzJQc1p1OW0rS2lvdyswWVh4WHY0?=
 =?utf-8?B?eXNYcDRVVytzb2NJcHdmU0dZYklVUUVDeSsrYmhLdDRMSXNPbFczQlhOK2dH?=
 =?utf-8?B?NE9pTzNNVDVNWHpjQW1DRlNTdWp2d0VzYXFFNDlCMGJSR1hMaHVUdlZJQ01z?=
 =?utf-8?B?eUlwNjVIaWdOcUYwdkFKQjcraEtaNzk0RDZaM2tyVnVYNDRtSEYvaENGaUhR?=
 =?utf-8?B?dFRSUklwTWtDc2ZWV2ZmMHkya3k2UmZUNnpmZEFtUFR2ZDNFVzdzTTdnamp0?=
 =?utf-8?B?NEFGSHd0ajZqS1M0K0hWeU9Ha2x0VnhIMUo0czEzaTdYd2xyOUhpUUF1Rmxo?=
 =?utf-8?B?WjhEbzZCTVgyUTFNMXRnUU9mcTJIbHdtQTQrMWRxM3puY1F2dGFoemRManhD?=
 =?utf-8?B?M3N0ZmFvVGhObHpkUHVSNzVrY2hGaGhDVlMwcGJpb1NLeFF0Y2VOc0JEZWNK?=
 =?utf-8?B?M0hRQWFWM0EyTGozSmJGdzB0RWhyNVdPQkwwZEVydmp1bHFEM2xoS1VXT2kv?=
 =?utf-8?B?cHZKNU1odjNwcjBiR3BWR3RBbW90SEsyMnorSm9sQjhhUGZYNGtHNjhsdUlZ?=
 =?utf-8?B?TXFsR2dxT3NlcnI1THJjbUs0dXZ3UGYvb1FORE5jZ3UvS25MSExZWkRlUVdm?=
 =?utf-8?B?cWxKTURHQjl6Q1lTTk9kcnpCVENTMktkMkdZTUp6ZTJGaU8rWSs0clFFV2NI?=
 =?utf-8?B?a1ZPVkxmd3hOT1orODRuN3Z2NjJBVWIxSDF0aytRVlhCbkZISk1RWlluaFlX?=
 =?utf-8?B?SzhtQ0NmUlV5bHpZWW4rd2xzRDhWRElvN2FYckRuREd4cmNzWUcvM3VUbVkr?=
 =?utf-8?B?UHdDbk5oQUVTTnFXYUQxWmhlSHhUdEhqcVBsVlpuVnFFUTZnUlIxb3JGRm9j?=
 =?utf-8?B?MjN6Z2lhT2VaSTJaSUFJOWpNdDZOZmxpQlV6dFc0U285anhzQ0N3WVJCNVU4?=
 =?utf-8?B?cldBVU5zK1ZlUDlQTUhIMlc0ZE9MNitQeitNcWlOYy9MejZFL2JHY2JoUzNp?=
 =?utf-8?B?QzVUQUJwdlU5Uld3STNHaXQ5Z01LRi9uOVJzQW9XUjYxWVhvLytmc28zeWZt?=
 =?utf-8?B?L1VLbUpKcThUWmU5Q2hMRVE4S0M0RmhBcnFHa1JxYXdqMW5CRzJDQTNUd3FL?=
 =?utf-8?B?YjZ2R0J5RnoxSGVqOTBhQ1lvcEpSUlhPNXJCRXJ4ZFJuYkd3QTRqSEdHa0pX?=
 =?utf-8?B?RTBWZUZlNm5XTjhGcjNVTFM5a3kzNTQyQzB1S3JTaVlYMjZZTDAyUkxlU3Ew?=
 =?utf-8?B?ZFRxTldWeEh5MVVZdklZTWI3RWVyYThJVzdSSnlrakRUVzRRYmlGczR4aFdn?=
 =?utf-8?Q?TLl0d6qM9PrTFLahc6fI201oKUTfnRbtkC3l6A5y86Gj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB1F2FACB5EBFB43A7E32C294B59D703@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dca9965-e3fc-4a02-6411-08db2e968b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 07:40:32.1964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5s1DenFKoXKqgF7vlk+0fun/2NnqT4Cbq0NvKuP4HoHX4foEx1M9pDxja5YhpvydvMKVVLhHXDnwmyd8kCkNYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_004037_135535_51D9B310 
X-CRM114-Status: GOOD (  11.51  )
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

T24gMy8xNi8yMyAwNzowOCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEJvdGggdGhlIGNv
bW1lbnRzIGFuZCB0aGUgY29kZSBmbG93IGluIHRoaXMgZnVuY3Rpb24gYXJlIHJhdGhlcg0KPiBj
b25mdXNpbmcuICBEaXJlY3RseSByZXR1cm4gdGhlIGV4cHJlc3Npb24gdGhhdCB0aGUgcmVzZXQg
aXMga2V5ZWQNCj4gb2ZmLCBhbmQgdXBkYXRlIGEgY29tbWVudCB0byBtYXRjaCBpdC4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpM
b29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlh
LmNvbT4NCg0KLWNrDQoNCg0K

