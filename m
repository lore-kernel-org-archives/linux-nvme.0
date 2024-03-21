Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AD2C6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5aj3aVN5F6HQSq9ha+aOhPp9c34S5/UZ22tI5CMHyxM=; b=2GQYE00fyKx/8PFW8QEE2Zv0i7
	A15aIZnwBDaChDohR23LuYIp3hQadWiHgAYHFrOgoURFoBjIXEi3g4JU1u+onrixS7/yn/piu5R0m
	LIOzmwYdWWX/JnPV5Do0IJcksAVYIH1lSF7WfClftKwF5C8C0fri+hzUn6jiftfuWkTt6m1BG0kIQ
	KjiMljRoiyCmx2nAxhtQ1Y6TMuSGg3KKLTCEQdkJH2LEZQq9NgHQ7+xf4s702pANk8RQ3VLoxFE8M
	bl7rmtiJPuLIIlHaerC5OiPKLekrdMiw4lTxY0yrpqov+c3oCe+azUFhV8qQPmVe/yerstsoxibLS
	W6lTkq3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnMEr-000000045Jx-09y8;
	Thu, 21 Mar 2024 17:30:01 +0000
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:2418::600] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnMEo-000000045Hy-1FR1
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 17:29:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVYolIo9iEnl0w0EuUXaXnvhKVFfoQcQijkoIGvLH06JlOhDn72volqtEVnCWhl5ckVmvwRfymdLOnPGjgoN38rMjlzoDHWTdrODBCOUpsZTAsU1amJW0X27+Ww9ynfdcBIiaKczbvi8KmrdCe3RqQ+mvIAshkAVBOjD3/jjtpAuF2FBGpZf/WMjDG6gcmCPOgyLV+U8m1htSCjRnsgn1DBgn5MGZ7Gbvsa+c0TobKMrgL1iLmSR21Vs7omZlmxNI2VaVAJhhF3RG/YlgqHlO4B48Bi9BsBPybfKkmq6g0J0IFNtpxsu7JkmHbqhwwSO5+9z2vYKo/eI6VSMCsnl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aj3aVN5F6HQSq9ha+aOhPp9c34S5/UZ22tI5CMHyxM=;
 b=PMMq2jQu/g5nYhxQRXej30eSZ3tOnerkA8LprBawW3j30jcrgrXoncmgO6VbldQvfQHk3MyOrB864XctvSz6/wqXpHE8RX5s6jIR4A+RuRTEWzu89qCnnt5iUGIabyEJPVVfuLPj6i/IuEqoUvSDG/XFRcSbE0zXVuCrjaVsHWckIBEwlP0+XZAAEdX0DoakhfYfMm0MSUM19MxhGCbxTThu8dCjLBo0uk36PldNpD9ApFRNrItuyvIx8S+h8+r3pMmZ0res2U72bZTVe5TUDW0pv2cEbuv+8E/yVTfSFA6cEA2mRMsfUzIuUheiQVbPaTPXq/kkIN7D050RVc4Djw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aj3aVN5F6HQSq9ha+aOhPp9c34S5/UZ22tI5CMHyxM=;
 b=QemcuPs4wOkSCYK7g4FMI9V5mnr0s0dUiGXcvRNaYXH1Gs6Nf2WV0/6RP2Gf3RBFnUIp2kTE54Ms56CBRd+LLkOSBSQJiruavPPGZ1CCrwXl0vBuyTSD6aDSYsDVWzLseAdhl07NecAD/Zbrn8cYK30WhndltbtFzLmb2lrxyaA9yzOrpaHItgbPQUGeYRPSFsH9+hZQ02mhbr8PjZAu524mFU8T/ETfZqalEm26eTCnmvlsIjZN97hemLUqNTisJRWTmUk3G9evwBtfMnKwNv6NZ9PL2kucJRWDUrrFC11oqBGTZaXsj9HN+UAAFWYyW/Hq9Jamvz4M02q7STs0aQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 17:29:50 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 17:29:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de"
	<hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: remove redundant BUILD_BUG_ON check
Thread-Topic: [PATCH] nvme: remove redundant BUILD_BUG_ON check
Thread-Index: AQHaeqfYniCyZNiVDEKje8kjxhj/drFCdXCA
Date: Thu, 21 Mar 2024 17:29:50 +0000
Message-ID: <0064e09b-0edc-4153-9ebc-2aab3ff4f77f@nvidia.com>
References: <20240320091949.20791-1-kanie@linux.alibaba.com>
In-Reply-To: <20240320091949.20791-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB8210:EE_
x-ms-office365-filtering-correlation-id: 542d27b5-7b06-47e6-3115-08dc49cc830e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dFPADcVOxuORJZuKlpZF7vitHTYPaj7HA8gLQNkcedmdnBLp1N3jyUibvou29Y/lf+8YmH6/KdOoRtiCsXzJkspPxi7IlAesEfPi5TkofPimCnZT2caQChYi2csfolWQUh9oK8UMwWJ5f04qzyrVy/5E4YChcYGZrt20znyXpIuuNBomwtueIR1z9vPoY21wuEwzTJ1zgyyvxz/mzc07oTOokpM8Ob+uaC+wZukEIiLGwwMpspyNqcXsQtCdEYR0qkjWtW4OYusvtRUDRNB1Vx8enx5ljsgfXrfXQsNtZFZuLF/NBBsysQm4AZiBQ4Q+1HQKuZfmZiheeaBqzuBe0P1roS3JhXRQQRlCWcTl3rfjDbsGUxN0r+Fvc0sMTagTNokrD52+6F1Mp7QHbvMam9Zc3IHIgtq+MkbJEEGPFjM6pLFGLxHwAHJIBFHKuv1k1fAowtiWLCmT9z00XkdsMt1ps+cGH3xGxHJRiH3VLOBPZEjO1Ruf6UQMiFqXWe718ACccezYymE8gABNAvaZc5BpEs0GYXl55jQGnxHQKFXTjOUXMiNz4SAR8XucKL9OvN5ged7c1zbNxqa6QbhegRhRrIgThrlN8kY8tfZaHf3T8WQHBBIeFMgiZiETT8rquUrYLU3Ng6tSnzE/BAfbYe0Ll+iOEIPB/cnGOU5Sfna4Co2LiMl41CpSToCa1se2bvthbA9omTaB8SNbDAdq4pT+mWGyq26GgLu81C4X3DM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXhYYTNTYjd6S0JJVjYxeldnZEEvaXc1eHFNRzFBYXgrck1BZzNLSmthVkZR?=
 =?utf-8?B?SkQ3Q2F1bmZxUTIvT0xHdDl0ZlBkb2dVb09QMEd3QUFxVVJsV2FxYXR6Mmw0?=
 =?utf-8?B?UzY3OVF2dWNhTDFheldhQlVQQWszYVlxcklWNWUxajhNeU1mUzBWN0c4Y2NX?=
 =?utf-8?B?cThkVWNlNkdqenhVeExmV1pvUncwRTdpaGdpV3cwVEhYQlkyTklKcHBPTDhM?=
 =?utf-8?B?VEdGdzZXS0NwcWpJWWgyTEhpZVFNTko2ZWVacnpBQ3E4ZFQ2Q3kyMWdreDJq?=
 =?utf-8?B?NFRhQnk2eDMvQ0FVRGdJUGVjVnhNd1JQZlZ6TlQ2M25EcUlxTjQ3UGttbXl0?=
 =?utf-8?B?RTNRbUJJTUZlWXkzMkFuY204NEswbjIrRS8wMjJ6NWpPSnMyODA0OVZTWU9H?=
 =?utf-8?B?YU5QcHRHNDRXRW55Rk5SSjNtaUI2OXZmTmNka254OXNLV2tOUUlydXFjQ3pq?=
 =?utf-8?B?SU9FWU1EYzZOSnBwcUFNaURlNjZ0LzR0Rnc2bEtRMjdXWHViOUZvb280NDBD?=
 =?utf-8?B?UG9yT1hjclBzSkltanE4V0svVXh5cE05S3pTR2VYc0dOVm9NYmdEejN3SlYx?=
 =?utf-8?B?bjIzaGtVV0xnUEtaRHZEdFpXYU1hS1cvZThrNUNOcTNPZzRvNDRmSXlXQUNM?=
 =?utf-8?B?N3dDdlVDa1I3RlZodlpKYWVJL1pwdGtlSmZRUDlERWJ2SGtVQjdRVDJpUlgx?=
 =?utf-8?B?VVd5Y2hHQWNsWVh4WU40b1F5NGhtd0xwNUFvMy9uOWwrSkozNnNZMWJZRkdM?=
 =?utf-8?B?RWM2em42bnF0RmFWSXl1OUVaY2tvQm9kZzZJQUUxc05OL0d2Mjg2ZmIwZlIw?=
 =?utf-8?B?RUUrTTJHTnJrYW8wQXVVVnkzS1JrN0FiWTBmNWhqSTRQelhMdXZFNDhGNTJt?=
 =?utf-8?B?OVlBL3dFYlFPdjd6c0d2SGhNNGoxZndSNVBGWkRjNC9BaWxhNmovaGRUYmtr?=
 =?utf-8?B?Und0TmpkWDh4ZlFCR0ltbk9uaDRNb2NkdExJNDRxc2RLbEdpVTVRYzFKNldS?=
 =?utf-8?B?Y1ZhT0hBNWtFRFRWTDZOcHlIOGpNUWxOMkFseUxlU3lReGg4R0UxbktwbGQ0?=
 =?utf-8?B?VmVaR3lteVhsaWQ2KzM2Z3VDeSt0eDVZUExUc29aUXo1WmRyUys0eUFTMHZz?=
 =?utf-8?B?YlFhRHlucVNsVTlBYWRSL3RxUTJkL29QVys0bTM0MXRsRW1qRk1mVEJlcmRQ?=
 =?utf-8?B?OVdmeXVIV2hiNCtjcXBtVks0T2Z1Q29mdEd2Z2xzQnRjbnA2V0JHK3IyUVBt?=
 =?utf-8?B?Qjl4cGVmWnc1MCtKSkVpdHBrTUFKbm9RTTdMZ0dKWnJob0JneVM1emhxN0kw?=
 =?utf-8?B?Q2Q0ZFVuMklZZXFpam5lNW5QdXplRHl3TE1sbUNKcFZWdjBWcUFjSElYckFN?=
 =?utf-8?B?M0svOVppcDJWUUdtM3FiMVd1OVpzOGFRN0s4T0w4V2dCNDVlSmdiT2daT1lW?=
 =?utf-8?B?MGxPbE5QWkxhWnp4OXZEc2g4NHl1OFJQWE40WEk0Y3MzekpVN2dZSGtheXRE?=
 =?utf-8?B?bVN4Z3ZxYVBUUUxIWnhZd2RnREFKZVBmYjc5M09RdHZCRDhETTdrb3dWdHVa?=
 =?utf-8?B?LzViQ3pzRUFLZnN4S3hoaVYxYVBFSUdFeW5MMnZLR1hHeHhoa2RhcWgwa2xC?=
 =?utf-8?B?ZWM2c0FHWXhPMk1PMmwxVDZXaVMvOTZqMVNZMElzZUVXaFZpSTFwUGo5T3FC?=
 =?utf-8?B?SFZUWVdJOTVJa2ZiemE5N1hpa2VZUnl3RDdCUW1UYmhTL1FEclBqWUhvNDV5?=
 =?utf-8?B?ZkZvZ3FsSnh0MDh4ck8rMjNtSDl2ZTJUb3BENGxSWEwxbGZLRmZqWk9VNWFp?=
 =?utf-8?B?YVVxRHVsbndHVmh3Y1BEbmhnUWdXZkozd0lTODlqczhid2ZTcmpwSC9vTm5Q?=
 =?utf-8?B?Wmt2QjFaeWIwOEUzU2toRmlFeHpIVVlnc3pwUzdHRUFTY2R4TW0wNCttQ2ZC?=
 =?utf-8?B?ZGs3Z0R2MlNpam1PcTdRS1VaSVYwMndPVVpkeTFHNzFsMkFkcnRvNEwzaXU4?=
 =?utf-8?B?L1NKWDZhbTdTZ05GSFNqVENpSkdqbTh3MDhpZS93OE1tTGlkQjFwZVJrSXh2?=
 =?utf-8?B?U3h2M1BnaHVMSldOdFB0S2lKUkFPUHNYekVBenFUaVVYcmR0aERqWGFPYmQ2?=
 =?utf-8?B?LzViUithb1IrVkNNSDNlU1RkaDMyZENLd0N3L2hyUmN0UTJMMWQ4bS9pMDB5?=
 =?utf-8?Q?2jQrkEMoMj+8UjMQtl9pS//dGYbf8lU962WCwLFxLhQO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4D8BE19DD34B9468F22F51A68A1ED3F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542d27b5-7b06-47e6-3115-08dc49cc830e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 17:29:50.0511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/7IEMj8BOj2yYuP3Q6i/LxSxzteI63VAahvxCIkFaA1WgU0gHqsPVnNPAtFWPN+GIucdkxFG3XS7AO0L9Bxow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_102958_381430_1039AD26 
X-CRM114-Status: UNSURE (   7.80  )
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

T24gMy8yMC8yNCAwMjoxOSwgR3VpeGluIExpdSB3cm90ZToNCj4gUmVtb3ZlIHJlZHVuZGFudCBC
VUlMRF9CVUdfT04gY2hlY2sgb2Ygc3RydWN0IG52bWVfZHNtX3JhbmdlLCBpdCdzDQo+IGFscmVh
ZHkgY2hlY2tlZCBpbiBudm1lX2luaXRfY3RybCgpLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBHdWl4
aW4gTGl1IDxrYW5pZUBsaW51eC5hbGliYWJhLmNvbT4NCj4gLS0tDQo+ICAgDQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=

