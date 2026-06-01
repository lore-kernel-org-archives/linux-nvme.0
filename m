Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9C3CD5BD1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 02:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kKcsQNIvsUmCKrwEDlf41HwjhOHW81k2rEDuzKViFmQ=; b=0yGteBeoNfpCy+Ag1rMWDvdGAI
	B8tNEvrGcRjldvyhfTbS5eK8HIolRgTniL4R+PZTCp1Wp6wcSO6j4VozIfZpXX5pnySpG1vn6+Rxe
	EOVXz6Ge8BkbkAHma2ktvF4OJHBDlR6OtDS2idHFsX0R3omaHLEpclJirFJ60WshReyLV333+4+XU
	BWu+hYZQ4T+7sSncmczd+OqupBxZl+BJwqt5GGAjUPp0X2F6NtvRq7pmVOf0CUJk12GIna+OWkL+F
	UP/RDOMuBZSDp4KzTMnsrbFfMlBENrM1TmuQLiD2CvetuNygk9VqCWo9R8/QNVZ0PGzs2o/M9xfeh
	tyNXKhNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTsEa-0000000A348-17mV;
	Mon, 01 Jun 2026 02:18:32 +0000
Received: from mail-centralusazon11010033.outbound.protection.outlook.com ([52.101.61.33] helo=DM1PR04CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTsEX-0000000A33i-0kuc
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 02:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B93K+gywjsEptiYEZn6xFNZsFyELJncCkeBe2p41Fw/IaZq14LRIjYx6uNDmxHJFqFdxLQzNrhgNe1xmXOx3JGofF0+e9bdA9gn90X3z+yL8W75UuA49KEVNYg2Y9I/YE7H4v3iDGJZVNfgNxhBuUGg/JHyUs+ilLICmAkOm0FwFSgDmoAuQzySlrnO3OYQ3hlxX5uPbZmfCo8vYIh7Vp7Sm+dFK6g58zy74mV1Bjgt1jp3YZOfGKK/WY4UEsOxY6zpAw4LZ2VHppalaVp328NElrz7ML3z9GrOyogPoBsgQdu2feay4Hlvb4WQGkx1dqKQcN0A7p3FR/xkdPY/yjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKcsQNIvsUmCKrwEDlf41HwjhOHW81k2rEDuzKViFmQ=;
 b=m1vtOPJACxoJC2+MtHl5EM7PkyxFyR+BR0SJY9pJg4crS1zPNGWwsid5xxnlwZ5DDe5/qA+2TkPPCd1txRKRecDbFyiGPrDuodLRGivrsBCqxcB9iOBmVqXDnQ6ZWD6pUxntgiwcvvZoefIa/YsQe6d7Rd/7C8qOanVLCwBLtLO9oVWsDulaA6sWGNz72DAwmTk5W8hVfeXUTmNg2eZMOrrX/AkNIL2AMflNG2vDWgKQreD9Ycu2VYHpUIWX71a65nouRpBFCbKi3mvar8l5L/BbjqM+7fAb0dJYScNzWQudcyGn5PmSp5SBuU5Z/4ZbYIPCOw73zcZKGzhFupJ+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKcsQNIvsUmCKrwEDlf41HwjhOHW81k2rEDuzKViFmQ=;
 b=Br7PaiLetKFbOyKGTkWGKznfcFUUmCUvARiN0s4JIHnCQKgaIOnXNUtyeHGETozh3618VqkO8FHWT03uDecW9pP3flx1CCpLK351nwTjmbeQ0QFIeWWUvK0u8cZPbKdh8YPqK5qpe1wHwfwDbtRhUXNSNDdfBMycen4O3sUXDNE+7LLir2Fje/VZC7vuXPnuI2tfY8OpJjn6oazA2VAZgyz62NLSiEwPUsExqUDtiDTHINTKIjZTo8MYNeVEtCzPJtr3j1CxqusQOIFv/nzX2eEv7+JTUciIMKEdI8aPKc30DFt+GguNS9An4kUY2NyIS+Z/XqsgM6QhYWVaI76bMA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:18:22 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 02:18:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
CC: Marco Crivellari <marco.crivellari@suse.com>, Tejun Heo <tj@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
	"syzbot+d078cba4418e65f61984@syzkaller.appspotmail.com"
	<syzbot+d078cba4418e65f61984@syzkaller.appspotmail.com>
Subject: Re: [PATCH] nvme-tcp: Use WQ_PERCPU explicitly if wq_unbound is
 false.
Thread-Topic: [PATCH] nvme-tcp: Use WQ_PERCPU explicitly if wq_unbound is
 false.
Thread-Index: AQHc8BeFPiuxO6SxIkyQJ/VEVMLYeLYo+aaA
Date: Mon, 1 Jun 2026 02:18:22 +0000
Message-ID: <1c9a0261-f8b1-4bff-9e21-5a773c953bd8@nvidia.com>
References: <20260530081059.428303-1-kuniyu@google.com>
In-Reply-To: <20260530081059.428303-1-kuniyu@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB9514:EE_
x-ms-office365-filtering-correlation-id: 8e7f9ec4-af42-4ad5-770e-08debf840e1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|10070799003|1800799024|18002099003|22082099003|38070700021|11063799006|6133799003|56012099006;
x-microsoft-antispam-message-info: BVlGqN7g+JBPIQtoraxU0PPIZxsj2h8LpXT0zTzk8HesmaVx+unRdoUI9ze+zljAh4eJrb3Q3TlM5X1+CSmItarTtw73If//g8nm9HhnqL9HaV/koj2JNkV1GKmPJklWOSlbYo7gUFGmlUa6trROWMWGibeXlWQJZEL7iB5sOTi/n7rvmUDT2ONOSGOdj1cOMZ6bEsBMv2Es15amGqKG0lZDPQSYcXTRVCm4k0tcLvHLNHJn7HFo3mQEyVGH3CYy3mVEhGjRweRd6QP19+BhDRlgVPSXgWwgo+55sdu8JtqBqj36GtmVPz8lsf69BdbzKMb64QYxepBw5nB/W8hXHVgJTLa3WSTMEgl5DI78o6Nwihr/dZX0wSQMSKM7ZJ+BFwP/sDsfcKNvdfY8Abcrlcc/RjI8iuVcWXQZPiWjpS4a6BdRg0Sq5h+A1nlVVYz/o8kQwjngwFSF7fDqd5pSl2K3bUy4B5ILjGt5tUFwT7TuxwN5y/iipgF5xIpKVTB+S7evYzZirTlsJiwv8GYXE6DSInKl+ZWliki5reTHIumiLuFwhoVjl9mGzGT3BRllQeu6Gf5SeCe9SowLl6GGomsb/IMPmikgNhp5UPkxHWfPKcYdqh8xJqwv+0HXw81baXzb6o6cmfd/L5Gnhwqy4XG1foacXH6cZmLfY1vZ6F1iIll2vHxstDdVA4smEo/Q5SWn53HSM9oY2c4elGCNKmCbMgZedaeElw2o6f6Gn+7j7CwySTaHV4dfk2bKs+h3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(10070799003)(1800799024)(18002099003)(22082099003)(38070700021)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEczOG1TcVJtTHM0QXYwaXFKZWkzVG9WeDJKd2c4R3J0dFVPQlljMzM2Vy9k?=
 =?utf-8?B?UnNxQmlWaDVESXdOS0x5ZzlxeXBCbkxjYnM1V01TV2owWTFlOVNYb2htRGFt?=
 =?utf-8?B?clBaV3lGYVVBT3AyaVVMSjBxQnNQcS9RNlhSOFdSbWE4Y1pCZDR4WGF5Qnph?=
 =?utf-8?B?WUxrejRPa2lGemJaRGZwRm03U1E4R0hBQ2ZmeXV6eEE1cnVrakg1dzA5V3hH?=
 =?utf-8?B?a1hmbUtSS29NL0o3bjVEaXV0MXFOOVI4bjZjMC9qYzM5bWRERjZMbXRkYVAx?=
 =?utf-8?B?ZmQ4alN1MCs0dXg0UnBxY0RySmpObFdjd2kxaEhodFExUERYeDBGZVgwamVu?=
 =?utf-8?B?cGVrL3VFeEhoQmI4VW94ZVVCRUxXK2d3cmZBMG1Ub2dGV3JUSk8rQXMzNllO?=
 =?utf-8?B?TDhaSUlVc21LZE9RcXRjK29DRUF2TjJ0TTVxUWpuZ2ZLeDlRUU5ReURack5p?=
 =?utf-8?B?OWtHWE80RFZjbTJoS2ZBVWlpcWNBS054VWcvR0MrRVBsR0FZUzZwWVFmMXIz?=
 =?utf-8?B?N0tQOUxJZkdQNXVXZlZaZCtQbFlTYzQ4WE9sWDM0RlVueEV3STF4aEk0UkF4?=
 =?utf-8?B?V1hLUm5KVHNHNFh2RVVrRWhsZ0NyVEJKSk5qUk8rWTVIbFRORmNWYmwxb3ZP?=
 =?utf-8?B?S0FqWHlkeExVak1mb2sxTURtQkx5Qk1BSzk1dzJBbXQvbFN3TW9IZnFjN1RZ?=
 =?utf-8?B?NkNENU5zZVQyenMxOW1mOTN0Z3Y1SEs5MDhHMDQ0TnhMU20rU0FZV0d1SXlW?=
 =?utf-8?B?bVM3aEVPUHh1dGVDT2lrMmova2ozeTRaYnd1WDI3UTFlbEJheTdNbnBKQlRI?=
 =?utf-8?B?K2tIQWUwVmVKZDJ4UCtEdmpqcnJtS2dLWEZzYWs2ZXRkbU9lMDNSY2E1c3RS?=
 =?utf-8?B?Vjg1blhOYzhUTUx5UXQxbWlGb3ljbjhUakMzalBKeDZYOVowZmxrU2JiS3c4?=
 =?utf-8?B?eVlCaEI0ZmY4UGNQZDZEL2pTdnl2Q0NDTzJwbkY2UXBpTHd0eWlKUlFaQm80?=
 =?utf-8?B?c3NCazBUbU5aL2sxMG9icW9JWjdLU2wySUhwOXdldDdtWlBtNXBldXM3Y01p?=
 =?utf-8?B?UWthRFV0aDZhUUFLVGlaVEl5NDBRK3hoYlJoUEZHd0tYUithYisyQzRRYlhD?=
 =?utf-8?B?eGd1QjM2VUpRWElBakxlVzhlTExGSmJTVWpPYVhZdlREamdUSS9WeHdyaWsz?=
 =?utf-8?B?dDNLRmR3MlZqcWx1b1dGdUtsZlBrdThIWFlwZmVrNnpsTFN6bEhDUTgwOXN0?=
 =?utf-8?B?U0ErRlhRYnlDVHZ0S2dxRk0zMnRFTUJIN25rcGtrZWVySllXTWJ6SUp1Znpr?=
 =?utf-8?B?azlOSFplVE9oR3JzMnl0T0ZOemxvUGxsREZkM0ZHS2gySTZHSW0rRVgwcXpL?=
 =?utf-8?B?Tk1WdldiSjU4UndXNXJTMk9jNndWMWp5OFFTYllJQmFwZnpabU56MEhBV1hD?=
 =?utf-8?B?blZWYldtZkV1elZNQzdPbkhoSFozd3ZIckUvZWxqdWsxS0UxbjI3Slg3Q2ha?=
 =?utf-8?B?R3R0aWsrdW8wdmtscElpOS9XeHlMOHBsYmY0R1lyQ1crd1RVR2Y2a2k5d0U4?=
 =?utf-8?B?bEc2cEhkUHlJaUxhT0luOGRJT3VrWTVZNWZHbUFjOWtsYUFSYW92cTBQQlJY?=
 =?utf-8?B?NkZ2YUhPWHZHaytHdHFEdStSK1lKSi9jcHNpK2VRK1V1ZGNvN0RsNWhpMEJB?=
 =?utf-8?B?K3dKU29YVG5PMUJKRmNRMWdndUtZQXRGVHowK01jNHdkejZzejZnR1hEdDVw?=
 =?utf-8?B?VWljZ3RRQnM3bUpPai9BQXJMbkxnNGxwbzJXSk42MmxIc0VJUElpRkgvOVU4?=
 =?utf-8?B?MlE4eFgvWkZGbXo0b1A2UlNtcldCSkJYWDVrazhqSFhCZGxDMTA4Zm96eFo3?=
 =?utf-8?B?alN5TEY5NWNlMVh4Rm1ERkFXcDhUWkJJSjI3S3cwNkExUU93QmxhYXlqRVVC?=
 =?utf-8?B?Q0ZJUXE2dXNMc05ENVJHRFdjaFJ3MHJGNG9GTzhLWFNiQkVyZmdpdGNaSlJM?=
 =?utf-8?B?VEYvb3BkbnB1R1RlMHdhNHRaZHN4ODc5amdVSUFNNjVBOHpOUzQ4aG1ibmtI?=
 =?utf-8?B?dHlxS0M1djc3SGVuSmdKa3J1K3BQaU1odUlOUHpNUk93K25SczlmNmR0NnQ3?=
 =?utf-8?B?cUFVR1RBQU5CV3ZMMmJXNnNpa0Z0OWdQZkpUVGxjZUV5VWllSVdkYTk4czgr?=
 =?utf-8?B?Z2czN0lwQnpiWEFYQk5hVDUrbDZJWjhXTmM0am9tbUNMUVFsaWtYUjR1WDRh?=
 =?utf-8?B?Q3RCd0pnSHArZ0xLSnJNTTgwT09zMll4eHc2Wnc4Nm5RazdmTEEweHNWbWZY?=
 =?utf-8?B?ZUlONSszZUpMK3ZyMDlnTzFLdjd2OG81VmludlZzTGdFakx3azhKbnB4VEd6?=
 =?utf-8?Q?NcpnbPKvQpg1Tfj8uJAP7Wi+SIHjEbiB02hpA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <682DA56BA490E7419D0616FA59CC4EB5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7f9ec4-af42-4ad5-770e-08debf840e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:18:22.6087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaCUGUwQuZaosbOvjgakyJm//o/v8JmXQZfKcM+Cs8K2bjey54axXe/iTsmwBwJRqUcHnwFkNHfn6TPmJEaaog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260531_191829_241027_0199073A 
X-CRM114-Status: GOOD (  16.77  )
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

T24gNS8zMC8yNiAxOjEwIEFNLCBLdW5peXVraSBJd2FzaGltYSB3cm90ZToNCj4gU2luY2UgY29t
bWl0IDIxYzA1Y2E4OGE1NCAoIndvcmtxdWV1ZTogQWRkIHdhcm5pbmdzIGFuZCBlbnN1cmUNCj4g
b25lIGFtb25nIFdRX1BFUkNQVSBvciBXUV9VTkJPVU5EIGlzIHByZXNlbnQiKSwgd2UgbXVzdCBl
eHBsaWNpdGx5DQo+IHNldCBXUV9QRVJDUFUgb3IgV1FfVU5CT1VORCB3aGVuIGNyZWF0aW5nIHdv
cmtxdWV1ZS4NCj4NCj4gbnZtZV90Y3BfaW5pdF9tb2R1bGUoKSBzZXRzIFdRX1VOQk9VTkQgd2hl
biB0aGUgbW9kdWxlIHBhcmFtDQo+IHdxX3VuYm91bmQgaXMgc2V0LCBidXQgb3RoZXJ3aXNlLCBX
UV9QRVJDUFUgaXMgbWlzc2luZywgdHJpZ2dlcmluZw0KPiB0aGUgd2FybmluZyBiZWxvdzoNCj4N
Cj4gICAgd29ya3F1ZXVlOiBudm1lX3RjcF93cSBpcyB1c2luZyBuZWl0aGVyIFdRX1BFUkNQVSBv
ciBXUV9VTkJPVU5ELiBTZXR0aW5nIFdRX1BFUkNQVS4NCj4gICAgV0FSTklORzoga2VybmVsL3dv
cmtxdWV1ZS5jOjU4NTYgYXQgX19hbGxvY193b3JrcXVldWUrMHgxZDAyLzB4MjA3MCBrZXJuZWwv
d29ya3F1ZXVlLmM6NTg1NSwgQ1BVIzA6IHN3YXBwZXIvMC8xDQo+DQo+IExldCdzIHNldCBXUV9Q
RVJDUFUgaWYgd3FfdW5ib3VuZCBpcyBmYWxzZS4NCj4NCj4gUmVwb3J0ZWQtYnk6IHN5emJvdCtk
MDc4Y2JhNDQxOGU2NWY2MTk4NEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tDQo+IENsb3Nlczog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzZhMWE5YTg2LjMyM2U4MzUyLjE0MWIwOS4wMDAx
LkdBRUBnb29nbGUuY29tLw0KPiBTaWduZWQtb2ZmLWJ5OiBLdW5peXVraSBJd2FzaGltYSA8a3Vu
aXl1QGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIHwgMiAr
Kw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMNCj4gaW5k
ZXggMjJiZTBlMGVlZTA3Li5mY2Y1NGNjMzhjM2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZt
ZS9ob3N0L3RjcC5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jDQo+IEBAIC0zMDQ2
LDYgKzMwNDYsOCBAQCBzdGF0aWMgaW50IF9faW5pdCBudm1lX3RjcF9pbml0X21vZHVsZSh2b2lk
KQ0KPiAgIA0KPiAgIAlpZiAod3FfdW5ib3VuZCkNCj4gICAJCXdxX2ZsYWdzIHw9IFdRX1VOQk9V
TkQ7DQo+ICsJZWxzZQ0KPiArCQl3cV9mbGFncyB8PSBXUV9QRVJDUFU7DQo+ICAgDQo+ICAgCW52
bWVfdGNwX3dxID0gYWxsb2Nfd29ya3F1ZXVlKCJudm1lX3RjcF93cSIsIHdxX2ZsYWdzLCAwKTsN
Cj4gICAJaWYgKCFudm1lX3RjcF93cSkNCg0KDQpXb3J0aCBsb29raW5nIGF0IGJsa3Rlc3RzIHJl
c3VsdHMgd2l0aCB0aGlzLg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

