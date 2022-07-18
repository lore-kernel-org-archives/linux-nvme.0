Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AC0C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 21:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=azP6awPUzfM59EBpF3hyNYEZNssw24avi/fm5Mv1gVQ=; b=k8+rG3SrUhV7GuH77ElqRlcADh
	nmXKEBk0682UJnONZpX9/FCwoOcw0YJtRI7MjoNldqeXP26KtSzzXw05N2DflEzqu6aMs9IilGFfL
	DAYzo54/DJHpaWV8584t4QgK+Y/QhsgEbYVXY9dIr2NoFpgH8PbJ8gZ3hHzaRPsnO/8A9dK6GEIzS
	juJn6PhryI+F+FViSxtUzzNqQTs1PZkovv32KGHYIy8jYnapnEVeA7q4oASWm1/h9e98LBH+vqZFB
	ZQM77dPOW2OG/AYxVnumqv7cRcyus9t38nQfAeOlunPxhpCUEGr5JE6gn81L77VkLhJdhSs/I4g2X
	AvEOJ1Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDYR8-001bpi-W4; Mon, 18 Jul 2022 21:37:55 +0000
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDYR6-001bop-N7; Mon, 18 Jul 2022 21:37:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCr/8U2EL8eLtQMk1G5fR+5i0azycMRBmmjXw78AuBdj6+pZzpCgUvsxYiGvalm792T7u7XWmReF3/xu8LX3Rwv+CYVoQzjms5B7LsDUW+3GqXbTsJUza/jZ8z9WMEPQYjCcGuG+wohkn7U3KC/kGC39UZTLiJl4dEmfq2FtVovRCOr1jREjJ6CTeA4CEyEsevl5Fj+YpVUQZCA9EGb2cGmGEQ28KUdkvVD+/oIKAdYDqbZCIqquTSkh3ZHdpPi2flnR5XP+K5fHHbVQGgl5+jHNAHoe1PYbMz2joeq5W3Rpsh0zmf4Ehivi3EL5ixtsTOstNYlzIfKrjyu0RrVxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azP6awPUzfM59EBpF3hyNYEZNssw24avi/fm5Mv1gVQ=;
 b=DF1lq9fTK1Dv+Q9SZRMRukRPwtqoybO404DSJGSbyLylvdTG44J5AtWuQXRyPm9JIvgfz2eLEZATip4672SyaN1C+DP0xVzkvbfodF/01wW1oySePf3t/nwY0kaXZ6n2bxVd5/u86LcId9tVQuIiUKwaUokJgTdauj9yrhCcl5dyba/+NUoiC5f+8xogWvBaBtP1MnWbEW+vawXg+iBr2EGNzvRdRdnFkCkAPHMcAVts9fCaM+3XcJMk5naNJR9xCOnikD+lQbtTRy0rYP0GyC9cCkfd50xeNeNkdqAPwLWMY78OqZbZqLTZVVZopmlgthXaiJSplNKaUNKonGQD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azP6awPUzfM59EBpF3hyNYEZNssw24avi/fm5Mv1gVQ=;
 b=G5hKGqb536nGwZWzb3JjsHRrlIhPiP8LqgkQ0tgkrNnzaoY37ZOlZNfbdV1kJbfj3vtP4WkkYP1KDw4YM8JhHndJHOPb2RF7TnEGaU6CdQQTpIqj9lzEDTJZd/V9MMo4xufrEkAxGCri5S7P3TsmLsgBSONydqqsDVinnUXQTU3pNKyPzz4O3hum9qm0Qu9yFCedr+idgwBeFHmPpiS2Fz0lDWOkm3od2U6yQelSBGv9SZnm2Btxwrt1b+WoHfRE0LS7nI8ji5FPjUS7DWRNR0ZzCouAgxmdukAHZwZDcE5PTGZ4docbBgJUfRGFpH5C1+xZvFR/D7gVUnb4Eyn9Pw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Mon, 18 Jul
 2022 21:37:49 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 21:37:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>, "marcan@marcan.st"
	<marcan@marcan.st>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "sven@svenpeter.dev"
	<sven@svenpeter.dev>
Subject: Re: [PATCH] nvme-apple: stop casting function pointer signatures
Thread-Topic: [PATCH] nvme-apple: stop casting function pointer signatures
Thread-Index: AQHYmmQNp+If9CQYykyZDr0VS2Kzca2EqHQA
Date: Mon, 18 Jul 2022 21:37:46 +0000
Message-ID: <99c63c57-2260-7c4f-08b1-95e2190611e0@nvidia.com>
References: <20220718050500.227804-1-hch@lst.de>
In-Reply-To: <20220718050500.227804-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b25095b5-488e-4460-e65b-08da6905c132
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  i0DzRBolbdd8Pok0Y/8sjnk99IbBC0CO7eNnYIqrUEg4dbSGMcC32NNwK4vlJo5qx7JSunmMNRZXk6vvKHqgl5hV57dqlghd+rUcRQSyjrtaHlFBLOFMLvADirn5S6y/PW8w9hnubDo3Kq8QMZyWaQf9/yrlq7Mz3/x0pBSBvWrhthpSFWOeerCA7hUCTTLL+cFV+LW6nrXfEIvNYLpMpApekto3jkMpIoWnyhzMpXdILNF4wCMcCTEdnge0LIIw9DTyDPB9JZirdZCEu+gIMvXlg8DtuzjbzStznXsBvqha3KnW07PiDpDSxUqus6CF9/PbvgKamXM+nKFNryJs+6bcEgQSDg6cEMKiH+uWMStqWzEN8bAqnF1aZZqv2G77wwbumP7Jju2F1Gmw4i9+LzK97G7eUJxSEnZc7t1aDlYiGSSVVrx+smlpZbBlX4sg6iJKHNEx1K1n+FshhZWDOa7bDdXS4AhVkx8OG+ysasqLKJbFBSoJwwyGEbQkUixQX6eLSinCSrAxQUnf5BGzzGm+cP0iqPXeqN7sFBxFW9FfAnXUrALBRwlZlAhpu/t1Q47TLCaoTP4dG1GmNxVfFluhsLeRrykKpGVor6ZJq9jR8Pj4vdY+HJCNxc3f2k+Sy85dsBEgHerQHJoC4iXTfL+pGM9YIoDVQ1KDqxMLFp089O9aW7aBcYxjfvnsmfxXpgcQ9giqCUdQNUw5iWCiV/EqB7TYXpE+HkjF+tdbKtDt/g0QIIEcPDsvaVcFwGesQStPJoT1uV21orL704r0GF6DDKooc0a2gIElsg5V8BNhDFvnmyIY55IYG0xWKED5/+uo2i0jaI0EizgS/OEKRv0EfXIyzXF4sJrUDPNw9tjXn/aYOZoonjXBBUryo1SCqHNrQB5jAbDI8NutBLz2+g==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(47660400002)(8936002)(86362001)(66556008)(38070700005)(64756008)(31696002)(66446008)(66946007)(8676002)(66476007)(4326008)(76116006)(91956017)(36756003)(54906003)(6506007)(6916009)(38100700002)(53546011)(316002)(31686004)(4744005)(41300700001)(186003)(2616005)(478600001)(71200400001)(5660300002)(6486002)(2906002)(6512007)(122000001)(46800400005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dnZRMXVxN3NyS0RsRFl1S29rWkNvNlZXQkg5bmwwNlcxNnFGeEFFY3QwcTRa?=
 =?utf-8?B?eVI3cDRLZVF0V0lwaWY4cUtOaHVPbEFFbE1NL3VBK0NKaXV4QS9pSVZyY3k4?=
 =?utf-8?B?cGFhWVhhTUFEbnRId0plRnAzNGVjSUNhd0ZzVkt4WkZNQ3p0TUNBajZoQ3ox?=
 =?utf-8?B?QnhLRVUvcDc0MW4zOTc2Y3phaTFJZjFsb2ROdExEY3RGd0c0ZkVodkJSZi9M?=
 =?utf-8?B?YlRVTjBGUTE1em9rTE9CSXBRZ1NYSHN2UmtnWFpGRkx1RUc2YTJaRmtuckZi?=
 =?utf-8?B?NHhTMkZrUTVVellKQWh0KzdVUXdtNVZXUkxiYWYydU1mVDhFdEROZFJWdlFN?=
 =?utf-8?B?a3JaZUxxZjE5QWFVcnpmTVgyU2JTRVRWRlpNa1ViNmNvakoyaS9FWlpKaXF4?=
 =?utf-8?B?Y2QzczNMNm16WG83YnlYOFN6UGkrZ2RZSWdscWViSm5YSXROWHdoWnJRVFYv?=
 =?utf-8?B?dTdFUnZEVjVBTTBCT1FlYWNyRG0vMXFhTU5FMXUydEtGYVdqWk80YTdkWlhy?=
 =?utf-8?B?YjFxYnlMUTI2ZjdGcHg4MnNxV2FYSE5pa0luVFh5ci8xL1lEUk12UEVtdkRt?=
 =?utf-8?B?MFJOTXJMeEVRb3J4VlhNbkY2M01udllPNVRJN0JxbVlVR3hoSVdJaFhDaENw?=
 =?utf-8?B?dDh1VVBOaDBmZHh5a3ozM25naEl1Z2dxVWdxYVNOeWNrdWc2YjBEVlhIZ2tq?=
 =?utf-8?B?U21CMVBmZ2Y4UGZ2blhjTXpoUjhKZW5SZ25FOHhSRnRCZ0xqOTZIMkl3Ykkx?=
 =?utf-8?B?Rm9rZ3o2akpOa3Q2RU13YWZuM0xYRVZrRmJyd2h4aUpTdHovUGJYZ09nZnlo?=
 =?utf-8?B?VXBJVExtTnBRMzVxRVdqZFBKMWhRZE1oZURJUWR5OUZIT1IyWFgvWEVXSXFH?=
 =?utf-8?B?dW85RWgweHpYcFozKzBUODlJNFNuRTJFVzAvbjVnNzZjN1VtNVZEdDNZMnJ1?=
 =?utf-8?B?eGNwdFZHZ2JKWnBJOW9tUjhCaThLbEowa2F2VGZXb1Q3TVUvNU9zZ3NOdXVi?=
 =?utf-8?B?c3U2RUNlYkpqcFVsOUZuK3F0QW5OMTYxRXVqUEo2aXR0N3MrZ0xqNW9hQzZt?=
 =?utf-8?B?dmk3U0hOWTRXWll0YTFZV1pEd3pBZG12QnM5bkJNa3lsQzRzSml0T2xUbEYy?=
 =?utf-8?B?M1VXa1QxczNraGpHUDhqL0plcGRzaldhNk1hVUxkVExwbVBlMWppa09OYkpm?=
 =?utf-8?B?SmZmWWZ6Z09uK1BqcmJQcDkvUTMxZ3g4djkxUnJNc2o2Q0FHOGZZU3ZmWEhl?=
 =?utf-8?B?aThNRWhvc09peHJwRHJrdmNoU3hKd0hGdkNjTDFIZ3U4NkJaOFpGNmQzSThS?=
 =?utf-8?B?TktnSlhlK0ZCZGdLMllCYWRGUWlna1JkY0JuVmE2YU1UMFBwT01Pbi9nR0V2?=
 =?utf-8?B?V1MzODg3Y0JxajBpVWxKS2g5VUhBWVJaUWhpVlJjZ1hjRS8rTkNCeGpkUTZj?=
 =?utf-8?B?ZzhYelUxRVIrVzBXR3BPazBFYXorZTZZZWhiUzVZQmpCK3dxYk5lVkRNUUdk?=
 =?utf-8?B?elI5YStwSGN3b1dCRVE1Sk53bUhnc1MyOWJYeGlVWEtiWVZKc3phb3FDTnpR?=
 =?utf-8?B?dzZybk9QMEdEb25CWHRGaThoRVpUcTMrbGNnOUl6cGh6K3E3dXg3ZVpUQ0VW?=
 =?utf-8?B?OEpvSHdDNjFibHN0d0V2NnBoaFpZdFE1MzZ1WnFJdDliUWFpS2RCVHloZ0JX?=
 =?utf-8?B?U0pWTjJBS1dyRlFpZFdSTXd2bWY2Ynp0NUdtZ3lLaFlJRXV6N05SSmwyWG5m?=
 =?utf-8?B?R1lVWHhZUGFVZzlSYXR3Uk85WlA5VC85VTZlUjM5WFdSQWFBaTZ1VTJNNGNV?=
 =?utf-8?B?Y1dSWUdJR3d6VGNSQWE2OHk0eHNVVFlhMFFhRTVmdVJ3T1Q5QVJZaExTR0U2?=
 =?utf-8?B?SE4xcEppSWM4R3JHc293RlBLMmtqekQxb3JWbXJJUUhEcUFHcEk5UnhyRlJZ?=
 =?utf-8?B?aGRFWTk5SFdKVW05Wk52cjA1YU9xVTNwYWNPZ0p4U0w3ZC96Uk5hcXFiSjM0?=
 =?utf-8?B?NnN2UWE0QzBiYWkxOUZtUjA1ZmsyZnp4SmYxbWMzdS9Fb3hzUUltZHNhV1JD?=
 =?utf-8?B?MHkzOHFYZEJMalo5dmxKL1dDOHJ4MEhnVHNqN1ZGL3g2Sk9rUG00bFZGYWVO?=
 =?utf-8?B?azJXcDhGem84cDRMRXh3RFNKWC9seHpLa2UrUHdHTUZYenZBOWhiRHlBRndQ?=
 =?utf-8?Q?Fc+c9VHcYtrsB8HCh4H4NmhRUCKEo/td7sp/cMjxRk1C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B6FE7BC65CA3C4194E4E5112630A278@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25095b5-488e-4460-e65b-08da6905c132
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 21:37:46.2812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nw0m+lxIwuCYUc3vsJdA/ntM7x2aVXQEAzd3NqZ9pfv+4RjFYs6SpCHF/vNztO5dfOWioL2GzKxJa4kdyIy1yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_143752_773377_AE379893 
X-CRM114-Status: UNSURE (   9.22  )
X-CRM114-Notice: Please train this message.
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

T24gNy8xNy8yMiAyMjowNSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IENhc3RpbmcgZnVu
Y3Rpb24gcG9pbnRlcnMgYnJlYWtzIGNvbnRyb2wgZmxvdyBlbmZvcmNlbWVudCBhbmQgaXMNCj4g
Z2VuZXJhbGx5IGEgaG9ycmlibGUgY29kaW5nIHN0eWxlLg0KPiANCj4gQWRkIHR3byB3cmFwcGVy
IHRvIGdldCByaWQgb2YgdGhlc2UgY2FzdHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3Rv
cGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCg0KdG90YWxseSwgdGhpcyBzaG91bGQgYmUgYXZvaWRl
ZC4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

