Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE97C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Apr 2022 21:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8uErECG2JugWCdqjDqpqHuu/CwaOXoxif8GKXYPtCbE=; b=e6RCiOL64oOt2Mkc1bdp9TSXeT
	E43j9/gaecw4XPTNQvYrx5xo+xQjwNYiQi5iqJbRP5tcrjfqxAEyvsF1LJZYTxW4sMtEqRYU3WvPK
	CaZEUkOyHUL2PJML+1PvixevIO010K4ZjPKm9nFq9DtF6E1xrnPaCshiXimYhqszobCAZTcJXaaqf
	encpbe0dDYFJVyhoz8v93pE2EDsgddjqa2wnoO/w3qjgthPQm3YSCT3rHucvnVuQTKZMmY2QJKRgi
	lg8XYZVBrZqB7x81FHSY7L0cveinYUn+wLsOiyuvw8VjYYmORFIxYBTxpMfwa4OqeDPPRZlc48R/I
	Y7/IYfgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nheoz-00F88r-Cc; Thu, 21 Apr 2022 21:58:41 +0000
Received: from mail-mw2nam12on20603.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::603]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nheox-00F87f-5N
 for linux-nvme@lists.infradead.org; Thu, 21 Apr 2022 21:58:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBgxMlzSwcASkCGDFfPBkMHw6txP1Nv0xS5IG18k+Rz+RDPqnAST2ZES0q6ttskuwooZnNSz0F4ZbNJ5sSTR2ROSsARBYQ0qiAE2GJTcPWSFbfb5NP3PkXcQ0Q2IJiPDH0aFtWNTlNJPlpuAENX8S3XqdohrJmhs28jIIjkdz+4nsc21Y/Cqs6qzgrPweVuuSmLHaJqD9bMGKoVpNNduYHycw1ooQfJrUr3CUKyx8cmUZ+08+T8lIo03YFNqmfhOSZSNjnLyMEQxo+QyZJCUI+gC8D7wvkCQ9wF/QUx8NCarTO7hxcaYPZvk268Ai5w1FrvDgI9nv0CHqQdvZci0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uErECG2JugWCdqjDqpqHuu/CwaOXoxif8GKXYPtCbE=;
 b=agYhuhpUxdHlHpsc5sD/jFjHbhxrYbBn5Z50GDReT92Ly8EcOiktfkragIcas4iZqizlkZwGI4w76y4jB6lMyUlKkKH6mGi3iWqkpKq61cPtXh2oN0GLfKilFjmbZhL6SHP96z/BmcmvOG6wipNZxHcsDuE8E2SbDaSB2JrbExLU4HaWBg0GJ6cg1qwcbJTZqv7VUAq3yfwNHq0tuIxhazSSrdYXgTNLE1gT8DQgCouvVDkmW8ryAc3tMmBAuGnc6m7ZMVT9kAEAJ+rvrNF0jpsqQgO2mq5WEL6TEz+RM2H3aAlK8SQR2FPg7FM4iPJMaVtEqBAMni+AK3AYCqIZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uErECG2JugWCdqjDqpqHuu/CwaOXoxif8GKXYPtCbE=;
 b=nOq6ZU5stODM3AgrNDl77L6UqxoGVWgRGrLNvSDgxEr3zfDLgeBWehOoNZRowGDAZ/5iVipLli5rtXEIEM31cIcycHHbSEHPZh2dU7y149PiFP/OpGIi+hdmV/dK04nndORUCz9nZi6SXjZ81eYpYFSgINQ6bpO31uQvggdMv960j69RGGejJ5CiOnJwvSJOU4r2x64MbvSO8XkqAqU+NOgjvfBfQazmD/9sUV6uFRlmgUJT8BaKmY11jBMxvOrbybGorsIxp6FMCYhF3PuUfRW+l1TbRyZNWSDQV4YIYCJpgmSFneH54UMXuGbCUneN5mb3IvDUkDyAR6NWf0KV4g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1280.namprd12.prod.outlook.com (2603:10b6:300:12::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 21:58:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.026; Thu, 21 Apr 2022
 21:58:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Thread-Topic: [PATCH] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Thread-Index: AdhVqlZ3h7upkXT4TAG9KVUkeJ9NKgAB8dUAAAPEAGAAAnDpgA==
Date: Thu, 21 Apr 2022 21:58:33 +0000
Message-ID: <8c0eeea7-1d9d-4464-53ef-143331e1faf7@nvidia.com>
References: <DM4PR84MB1590F030A9AF89C6E0E62A38A0F49@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
 <YmGp4g/V9zkyMWzz@kbusch-mbp.dhcp.thefacebook.com>
 <DM4PR84MB1590C311ABDB0895A1B4D16EA0F49@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DM4PR84MB1590C311ABDB0895A1B4D16EA0F49@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: babfb3ba-954c-4d0d-9ee7-08da23e21480
x-ms-traffictypediagnostic: MWHPR12MB1280:EE_
x-microsoft-antispam-prvs: <MWHPR12MB12809E4B59289451D11D79B6A3F49@MWHPR12MB1280.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VBRPpceNT8Ydv06yQ2Lv0JlJyx+oezfgf4UiXzX6R9H6PcJGnwKYJ3RQ4cw8hWylJG1lR6LCEMtMUsSCjhKbMKekxk9UXgExYT2+umJZdBjJTbl5GUBbLMZX7XhQnZLC4sUbWYPhs+ewbjf8vLWpl8ddjsuz93wYcRMNXpuxK1snGG98s43KQcEhYhRL1j3RttnpccpsP7PF2KQYP8tlKGF1SV56kSk2wARFeSSkrwMGtxLC9NrXX/BbxNIzF5Dk4U0G81cPuKqkx8E8Ct/MXRdZRSx0qSMXTMZ7sB5rOWqXC6YIFaR66YvcedSFsrWS8aMIYv1zySv2s+65cYLm21frkKjtrvd2I8gaWKh3Tu+Z16dMR92/mBY3wRHeF/+LSG4GtiQZLgBGw7qCkx2LgWNPItKsIwLndSxvFWfRL/g8er0q7QvInJYku+ZO9lyZWrkZ7IRZU8MW3SAXziO1YIetyyK3BjnULelG6fdsekpXj3XlKg1DrS6PVsB5kHnzK5PIKtQFmg+7xEo9iF/TyOrruQpeeB73rtYhs2kflSYyBfFQz6sSSUIPpIktRQKTADzai+Y2QG8Dl7cLZ4HhVe8/D1zwiHIvEuElVQLW1fbGnfYyXsSmxvYlAtnycsp/1B6Svz6noXExAn573KW5bUf8SstsHDVst7U6Jg/0k3ZKSetnOo3jyBlTpTDyrG3hue/txeFfhYNp8lhxKUtRcdFWWXHsziKEjFM8ma0dVhcUa54g6iQJVMf5R8xRyvWblb/H2iLVmg4sm07ryfSz1A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(2616005)(508600001)(6512007)(6486002)(71200400001)(26005)(53546011)(2906002)(6506007)(83380400001)(122000001)(38070700005)(38100700002)(76116006)(66556008)(64756008)(66476007)(31686004)(66946007)(66446008)(8676002)(91956017)(86362001)(5660300002)(31696002)(316002)(36756003)(8936002)(6916009)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wm01cTVWRVVOQkhaYlJiZVZDdGhtbWlrVjlhbHBaNWlkL1lNV296eG5VRmpx?=
 =?utf-8?B?RDVxamZnZXVPMVNWOGh6bmJ2ZGNteTlNeld6N2FvbXJwUnlydGJDWkIxQStT?=
 =?utf-8?B?Rk42ZlhITlFET2V4VUUxcnZESVBzTE1ocXlxVEhkajFoeXZ0MXh6UTdqdkZO?=
 =?utf-8?B?NnFabG5qTmZCbnN3aHRtcUdEMTBlUUZ0bmVnb0hSNk40aWRZTVE5WitNMnlk?=
 =?utf-8?B?RDJhUUQzUUFMTUhwbHRQMTdvTWIwc2JMRzJCamdFTEk2SVhsVmhnSndvV2o3?=
 =?utf-8?B?WElWS0pjMCs5OTU1cEtvamNGNWFMUnhVcVg3clFld0pUZnJaOGN3elVMMTda?=
 =?utf-8?B?WnBVbHdrdm9XWGJkU1QwT3dEdWhjMjlTTmtCSGxaMlIwZEhrS2syeElrdnZx?=
 =?utf-8?B?UGtHUFJxNk5VMkdWWTF3bUlVbUdEZ3hjQWhrYmwyS0ROQkVKMnR1NHJaVXMr?=
 =?utf-8?B?S2xKL0FMT3RDZ3RmWCt6eFFEOTM3ajB2bVRWdnhvVEpKSFBzc3lDREY3MWsx?=
 =?utf-8?B?NXhmYTBybEovclJreGNUd1B5NGdCelpQNVpTWDhqeXZsM0Z5Qk9Mbk1leGNl?=
 =?utf-8?B?Vy8ySGpqVEgzOUVQNWVxSTJNV2d2Z28xa1g2ZWxBQWpZZVFrcFI5VDR2ZWp0?=
 =?utf-8?B?ZEtQdHhrS1k5ZFgxVGhzN3JPaHF2aE8wakdGcURZTUpSUXFjMUFueTZCN053?=
 =?utf-8?B?bXNEVmQxYXBRMENkOWxGdTlWb2h0QlE4RWlQWlpzU09qNERLRkdLaUY0alBU?=
 =?utf-8?B?KzNNSE1rak5iOEU1bEtmaXZnYy9uZFR1UENOL2hhMi81YjRyUlR6UUplZm9v?=
 =?utf-8?B?QUZaODlEcWxMQ3NubXRma3orb1RKd3lOQ2kvenBVWkxFd2hmcVNHME51clhn?=
 =?utf-8?B?SzB5SDhJclpLQkFQK3A2bFJaM1cxL2JCOG5VdThSeDkxeERJVytSYnl5SFU2?=
 =?utf-8?B?NVJ1Zzl0bWlNc3dvYzIwSVRVbkRXVS9oTWVvRWYrTzl0cFpYRHZMcSswOEVC?=
 =?utf-8?B?VEUwdzduclN6cHpPeXkxUndUbkZGbE9KbmJOenN2b0ZOaWhXRXhOb1Z1MHBV?=
 =?utf-8?B?akpYYmhBVW9SNjE1Wk9nL1BsZnVvSzZnNWVtczM0QUJydmVGS1pTQkpLMmRC?=
 =?utf-8?B?ZkFuRDhpK2krWDlvZXlZckFjRCtiUk94Vm5pY2NQL01EanNBUXB1Sll0YTlu?=
 =?utf-8?B?d25GUWpJRi96Y2VnOWlrc0xqY1hQb1UrdG9kOG9kKzVsQWJ0LzE4ZjBHUnJr?=
 =?utf-8?B?RVEwMS9Md2pWcE5idTFPL2QyUGIyaW5KZU81U2ZMUHI5Mlc2NE5IVzlPRUFp?=
 =?utf-8?B?SUZUT0xQdDlGK1NCd2tJcnh6YWVjZENITk8vZ01KbUE1WU5kN0IvRHluY0Fm?=
 =?utf-8?B?cnNUaTFFTVJUU051UmNQNjZBZjduamhNa1drNUJreWFJUjVyeDNVOCtZaGN5?=
 =?utf-8?B?WTJ6WmlCNnplQUdxYVRJSWJzQnN4bDdtL29OdFplS2daRXV1QVllZWFMalIw?=
 =?utf-8?B?ZmtMTnJqZEhlbGp2QkpKNng0ZytrS0k1OHZHdHBTZVFmRHVYZ2p3S0JGMk9y?=
 =?utf-8?B?WHN5N3dXL3RaWEUyL0dKZkJSVDJQNHpzOVI1R3pUVzlUb1htN2g0OWQ2RXNM?=
 =?utf-8?B?RmNlZ25YQUR0dndhaksvRTNVWXFBeTc1TkgzNG1ZNW9VMWd2andHdXpBckpj?=
 =?utf-8?B?Sk9CVHBDNTBOOWJFaytMZTE3UisrOEdJWE16cWZrRC9ndmYveEhJd3MrOWFq?=
 =?utf-8?B?Qk5HWnlCYURCUWY1WU0veUt3dzU3Nk1ZRHYrZmFKNWgzMnJvRDh2WlVzVDdw?=
 =?utf-8?B?OFhDVTRrZWhsZlZSbXRCQlVqM0huUURSd0s5c0JIQ3VlWWFtU1M2VnU3QVEr?=
 =?utf-8?B?MzJLdmkrdWlld1M1T1Z4VlZ4dE5NbjdnUnp5NUNnRTliY2VoNERKbmxIVEE0?=
 =?utf-8?B?MG5xenIrME9LOFN3QXN6cmJIcEM0UHpyZUdkY29oRXFzNEJ4WHdsajQvTzdL?=
 =?utf-8?B?T01mZ29mWnhhdWNFZEhVL0pPS29FeHBndEN5MUk2dzdXeU9WRUF4MllHQmtn?=
 =?utf-8?B?Zm1HZndqRmk4RTJnYzBtU1FGM2Z4SG5Rd2FreTZPTE8yNGo1M21rRm8yZmJ3?=
 =?utf-8?B?bmR1V0xZdldEbStITStXbzhkZ1dpMW1IMTJRb0F1bUYycmVqUE9ZMGJ4aXI1?=
 =?utf-8?B?VE1kVjdTT2VXbE5DTDY3RFl4NStoNUlWOFdMTlUvY0JIK0F1aFV3V0xBS0ZG?=
 =?utf-8?B?Q2ZVMmluY3p6N25mTkFVNEViT3pKeEU3QkJxOWphMC91NnV0OERKZER5aVdx?=
 =?utf-8?B?eHZDQm96NXdHNlVNZ2NSdHNLTWQvSGlRenVBOWlpTmtwQkxDMzlZdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AD70B399A3B3B43B9A2B9BD570C3452@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babfb3ba-954c-4d0d-9ee7-08da23e21480
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 21:58:33.8963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzrek3Iy4kMCnSwvTef5xwC8kO4bDRGHst98o6EaeSuS45MiQ2t98zAv3BVrjBDhaAinxOAN2kAh3sxK3NUypA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1280
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220421_145839_249496_9FBD6DA9 
X-CRM114-Status: GOOD (  21.47  )
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

T24gNC8yMS8yMiAxMzo1NSwgU21pdGgsIEt5bGUgTWlsbGVyIChOaW1ibGUgS2VybmVsKSB3cm90
ZToNCj4gSW4gbnZtZV9hbGxvY19hZG1pbl90YWdzLCB0aGUgYWRtaW5fcSBjYW4gYmUgc2V0IHRv
IGFuIGVycm9yICh0eXBpY2FsbHkNCj4gLUVOT01FTSkgaWYgdGhlIGJsa19tcV9pbml0X3F1ZXVl
IGNhbGwgZmFpbHMgdG8gc2V0IHVwIHRoZSBxdWV1ZSwgd2hpY2ggaXMNCj4gY2hlY2tlZCBmb3Ig
aW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIGNhbGwuIEhvd2V2ZXIsIHdoZW4gd2UgcmV0dXJuIHRoZSBl
cnJvcg0KPiB1cCB0aGUgc3RhY2sgdG8gbnZtZV9yZXNldF93b3JrIHRoZSBlcnJvciB0YWtlcyB1
cyB0bw0KPiBudm1lX3JlbW92ZV9kZWFkX2N0cmwgLT4gbnZtZV9kZXZfZGlzYWJsZSAtPg0KPiBu
dm1lX3N1c3BlbmRfcXVldWUoJmRldi0+cXVldWVzWzBdKS4gSGVyZSwgd2Ugb25seSBjaGVjayB0
aGF0IHRoZSBhZG1pbl9xDQo+IGlzIG5vbi1OVUxMLCByYXRoZXIgdGhhbiBub3QgYW4gZXJyb3Ig
b3IgTlVMTCwgYW5kIGJlZ2luIHF1aWVzY2luZyBhIHF1ZXVlDQo+IHRoYXQgbmV2ZXIgZXhpc3Rl
ZCwgbGVhZGluZyB0byBiYWQgLyBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLeWxlIFNtaXRoIDxreWxlc0BocGUuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJz
L252bWUvaG9zdC9wY2kuYyB8IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJpdmVycy9u
dm1lL2hvc3QvcGNpLmMNCj4gaW5kZXggNmE5OWVkNjgwOTE1Li4yZjc1MTA5MzhiMTggMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9o
b3N0L3BjaS5jDQo+IEBAIC0xNzcyLDYgKzE3NzIsNyBAQCBzdGF0aWMgaW50IG52bWVfYWxsb2Nf
YWRtaW5fdGFncyhzdHJ1Y3QgbnZtZV9kZXYgKmRldikNCj4gICAJCWRldi0+Y3RybC5hZG1pbl9x
ID0gYmxrX21xX2luaXRfcXVldWUoJmRldi0+YWRtaW5fdGFnc2V0KTsNCj4gICAJCWlmIChJU19F
UlIoZGV2LT5jdHJsLmFkbWluX3EpKSB7DQo+ICAgCQkJYmxrX21xX2ZyZWVfdGFnX3NldCgmZGV2
LT5hZG1pbl90YWdzZXQpOw0KPiArCQkJZGV2LT5jdHJsLmFkbWluX3EgPSBOVUxMOw0KPiAgIAkJ
CXJldHVybiAtRU5PTUVNOw0KPiAgIAkJfQ0KPiAgIAkJaWYgKCFibGtfZ2V0X3F1ZXVlKGRldi0+
Y3RybC5hZG1pbl9xKSkgew0KPiAgIA0KPiANCg0KUGxlYXNlIHNlbmRvdXQgYSBzZXBhcmF0ZSBw
YXRjaCBhbmQgbm90IHRoZSByZXBseSB0byB5b3VyIG9yaWdpbmFsDQpwYXRjaCB3aXRoIC4uDQoN
Ci1jaw0KDQoNCg==

