Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8161CD1CA17
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ucjfv6hh6GDE6G/azWilN7SLwoltZBpY85y+MnRdi/Y=; b=0jIEiVUlKRiZfKMMg4i1QKi41H
	nuTbbsTuFzVCoUZ7X42/6bRebTKcHMGXcMihqrWMUedGuki2vvYJT3tLtHXv5T7nWnbJsgY3U/3NC
	xj7j1mDmyyUSAXGu9AIBjXC0AY1MnvCBEZHxFmvKibk1PmzhvgrIgPOXVgmwhM4jy2ykKYKKmjIwn
	dIqWgyL+ZLUK9Yk0HTTSlUrypSYEbSt94h7tlLASYdovo7PhwS2Nfck31f09gy2g5P0grF2XL5CzU
	QwS5/nXqLCF/dEux7DIvGRktITQKap50Wuiq7zFiN7aDJkKHFUbH5vGsrAkzvJiT61ERFaASwAQ0F
	Umo+QbpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YEX-00000001p25-0gKH;
	Wed, 06 Nov 2024 05:05:33 +0000
Received: from mail-bn8nam11on20622.outbound.protection.outlook.com ([2a01:111:f403:2414::622] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YEU-00000001p1f-0Oy6
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:05:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpx9PyqKHMqsJr9Znmr4qpDr4PnUTYVJ2708uM2MToZKRgZLK8Icw/dv3UHbznczxLzcM6sej6tLXNCPIP2SUgDyF1jis87Ko8Pcsc1thXP5rQsjFgoay0KBMBt7ODTyAQ6QhMoSW77Ad95bJddn1hvGXUZ7HNvO5j/uOqj7Va9rukEgT8gbR/+k91+uZ9uXG/Mf0q6fvs4POsrs2A0uB7SWGqlI6yeVl2oSehT/pWww2N0IXgbmzVnvpO+DX3XJVfSmof1+Gk6d+oicGemusH/hhUbYHRmXfQqLP0bBArdOEY/k0M74v7D1GOmyJ129JUyAGM0uQDbHIeCLu3w4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucjfv6hh6GDE6G/azWilN7SLwoltZBpY85y+MnRdi/Y=;
 b=Uy+lCSQHodWXFuuWF5+EBWvuq6QolBTJqNJHDTfYx1fcXTTWVVV1MmUkNZTqp+Vhps+Btf0dor+1ajxUjOiDnrA4sYfwryriErs32h+rlot0ae5gjzArt3tJ7NghcDA6kFivklFeCy7RSbzNAjOmmJZaKMM49X56WW1jpcL0sSLlFfJWGE+/yicqKXbfQ99u/NTCq4A4qGT95WXlBWCWQKXmHaBj0ZDYnVaI5k4iFOE68nql3rG8yS3jqfl7sTlcQ/xCj2m0oa+8Lf5qZlpoAQIQwPzOG1soMlEOzi+EHbxtU2cglwlQ6+TRdNfdEaPB8ypKlHrya2z+EZZBp9l6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucjfv6hh6GDE6G/azWilN7SLwoltZBpY85y+MnRdi/Y=;
 b=uhFsSbaQ5vaxSKgI8NK6fD6Xyln2AhYp3cX60f7D3kjDakcxJljPnQmJDtv4uF26fYDdbxSpAVmk+u6Qj6p/Gp4Eun4qmwcx8p/8ujRwgLjNZbK1LBLPu20BunGdI5I2z6coUjLKC4jG9kOYjE+8YtF0222cL4WeKZtEiG2y2ifM7ISkNJnmiK/WKBjwx4tpvkZNwH8vvNEL7NNpCioVvACz4s/FQcucckkG0l4B4zniA/WGid/yvb+ubtxM8cGOAC5g9abjMOk6Ml0ezz8kIZ68yElVxA+MuWYwFoZHfDbaMU1Y+a7SF4uNinuKj5eZNa0AAvyZ4nc0Ok+BK7DU/w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 05:05:17 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 05:05:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "m@bjorling.me" <m@bjorling.me>,
	"matias.bjorling@wdc.com" <matias.bjorling@wdc.com>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCHv3 01/11] nvmet: implement id ns for nvm command set
Thread-Topic: [PATCHv3 01/11] nvmet: implement id ns for nvm command set
Thread-Index: AQHbL6seEGzQtV6dyUeiHbcu7mSINbKps5kA
Date: Wed, 6 Nov 2024 05:05:17 +0000
Message-ID: <2925efa3-4d1d-4fae-acd1-523774babcac@nvidia.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
 <20241105174904.3612888-2-kbusch@meta.com>
In-Reply-To: <20241105174904.3612888-2-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH8PR12MB7304:EE_
x-ms-office365-filtering-correlation-id: 8237d79f-faf8-4886-6c76-08dcfe209b26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RkF3OVZWV292Y2sxQlJZZFllVTdHNHk3SXZBYS9vQ2c0N3lsSHVtNTBBYlFM?=
 =?utf-8?B?OFFxY1VjaGJhT3FzYkNlK1l0Nk9scDdZM2d4eGxMTFAyNFRhc2I2NFk5NlBN?=
 =?utf-8?B?NUlZbnRuR2xJeW0xU0NDSTUvZlllQVRFeElqenhyOEJwYTNvZDdvYzRPejAr?=
 =?utf-8?B?cXR4ckI1azNIdEtMZ1VCN0dkRWhCVllYMko5VnhXamtuTXRZNXVMYUtpMmJG?=
 =?utf-8?B?LzBnSGZ0ZGpOZFZnM2lDekptSFJxcEtqMDA5ckoyMVVCaUF4a3JMMTRiVmNV?=
 =?utf-8?B?M3N0dG5QQjVUSnN4Y0M0NUpxSTIzSVk5MFhtZTYyY3NZYU1RT1IyM1JsUUJa?=
 =?utf-8?B?YWpZR0ExWUE4VlRtS0xwOWVFRzc0SDVIQW9kUjlJcktOczEvL1RCVmRGRUI5?=
 =?utf-8?B?S2dMLzIwVysxSzZmaGcyWFZweUVFYmlFR3ZsbkRjdXAyM3ZHcVBwOXk1aldn?=
 =?utf-8?B?NVd4cVQyTmFPOThRK1p1RTg4dW5LMk9ubldPNHp3eFVJSEtwT0RZbUdWamlL?=
 =?utf-8?B?anpkUzFROWtxdTlIaVg2ZDJXTkI1UGhtcWlQWm9yeE1TY1lUYTdPZjFPL1Jt?=
 =?utf-8?B?RDlPbWtpeUdMcTloWXRleDc1MU1BTVJTam5SRHQ4WjRVWWs5cU1pNW1tcFl1?=
 =?utf-8?B?MGwrN0hpcUhVY1E3bHNHbjNNWEE5U2xtaCtYWTBPdTZsNVQ4cURQb3pBYXFn?=
 =?utf-8?B?ZVBQaHZaVXZ6L0ZJUkJiV3JyS044M3g0V0NLMy9vS09qVjJhNFRid3R3L2ky?=
 =?utf-8?B?cGowUnQ0TGJTV3RJakJiS1k5YWlxT1o3Z2R0RXZhKzYwMU1maHh0anVpOXZD?=
 =?utf-8?B?WDBUa1VFMWQ1WWxVRi9xbFp5NktPSnV5eU9HNGhxSjQ5QW0remR3dEZ1UUNL?=
 =?utf-8?B?RXV1VlRkVnJzK09TNDNRTnc3dGdCaDd0UDRlRXpkbDJYQ2wrMWlOcUtSY2hY?=
 =?utf-8?B?ZDQ0NDhISEROTy9JbmNFMGMrb0xxMm1VV2ozRXRpMVNaWm1qRGpWMk1OcnpN?=
 =?utf-8?B?N0hnYmVjd2xkS0lZT3JnSlZXT0hPOEIzQnhkQjQ5S1RSeFNTaXBtdlhNTm56?=
 =?utf-8?B?bXFEQmwxRGJWYkNnNlVwa1NUREJsNzczOTdTL29FTTRpZXNtcTY4aitrLzZR?=
 =?utf-8?B?OXJYY094TU1JZkRkWVV0WGxZSUFqK2hnMGgvUytua05GRlorTnFhNVVCVUlV?=
 =?utf-8?B?STFSQ1lNOWwzNlYzbXRQRk1QUTlzM1licUl2VTBMSXRWZHpveGJWeG9ZYi8r?=
 =?utf-8?B?UFBjMWxDMUkzSHorcmhld3VocmJiZGFJaUdNMGptYUhsQmRmT0ZvRkx5Sk8x?=
 =?utf-8?B?eERvdHdxL2Riak1oUHVKS0FpRVkzYjRsLzdXSDc3STRWb1ZmVlNGSWVDK3pZ?=
 =?utf-8?B?MkxGOHJMUkY4NmRDWi9SZS9mTWZUajdYVGhwQnByaHYwNkxObC9vd3JSRDlQ?=
 =?utf-8?B?TmRhalI5QjM3TXVWdW9OaFM5WmF3WkpnQ001VjlWa1EzQ05PTXpLRjBYY2Vs?=
 =?utf-8?B?djlMT3NFS3g0OU1ybFVJUFE1cmYzU3Y2eSt4cjhseWJVeHRoaEQwZnNHTlRp?=
 =?utf-8?B?b2RNWkFabFB2dVZ5bjU3cDIxZDBweUE3aHl5eFVxNlZCajBkODJra3dPbFRh?=
 =?utf-8?B?OXY3MExGRXB6dmc3QzVZYWowYVlvYnlyTkw4ay9lL215MzFnbndVS0duN1o5?=
 =?utf-8?B?SVNyWDRJaHV4TEVQTW11NVV4UFk2YzlnN2Fkb2owM3ZsRnprekh3RkRTUkJZ?=
 =?utf-8?B?SkdULzZLMmhQblpKUy9aZ0xpa2g1Qm91dGZXZVIyM0h4UkhZRFJhZ0thRW0z?=
 =?utf-8?Q?mVIxHTHfjyQLDknJxfQDZ1rK2HBDUoIR7Tj3Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RExXMDlsQnBxdmI0clBTenp0a2RkQmZVQzNvL1lnc3N3Q052azh0eWFQK0Rl?=
 =?utf-8?B?S05YWlZ0NXAzaWVEYnBsQkcwRXNvb3FMWjVOSVBPU1E0RVpyUEZyRUJRMEFu?=
 =?utf-8?B?NnhwNFEwZW8xWlRwMTVNeXBvN1FwVWlwbkU1RVpzaWVOWTFZOTVOZ2llUXY0?=
 =?utf-8?B?bzJFaVJYM2xWMTZ6SnZMM00vUUhMNkhRS0liYllDMW5WYzdpQ0huYnZJT0pV?=
 =?utf-8?B?SGk0L2xBVWFReDZTaGIxbTkwYWtjRUtnRUM4RXprcXMvTkpXTk9LVDQ0cStZ?=
 =?utf-8?B?RXpqbzNtald0amZXOGtMMzYyeHJsRFJpb0VjM0VGUWd3RjZJSWs1MG1HcUlQ?=
 =?utf-8?B?dk5lTGFSNVpXckRGUVpscCtZWW5Jb1J3TTNMY05UQTNXL09NV1dDdTdhYmdJ?=
 =?utf-8?B?RzRvZHZLWnh1b1N0dHhXcHR5bmwyaFpxVXdiOVR4RERSWEpkQmF0eXFjZTNt?=
 =?utf-8?B?UGRhZk90R0VQS0UwY3hoS2pRejh3TVg4dW9OeURPOFQrWmNyZWFxcjJmZFNQ?=
 =?utf-8?B?TS9aemV4ckNhSGY5akNvQTdCbEF5TGhNQ09zYVpVRUtvYnMzWERhd0s0OWF3?=
 =?utf-8?B?Lzlna1hRWGo1YzV4Y3hXK1daMlZ0TnR5QWZFa2lQRW1pcjVhckFOMzhmNHJY?=
 =?utf-8?B?czhVeXQxTHZwRGNrTGx6SnZjTDJWd0VQcTBNd3JLSHFQbVF6ZkZmLzJDS0pj?=
 =?utf-8?B?cTZJaEQ1cThXdjk2TkFSckFOYjY1SGNLSk5STk5kTW4yTzdzYTZQVEpybXE4?=
 =?utf-8?B?STZ5eDd1M3R1aXlESUdEaG5FWThreUVRYk5Ja2wydFlLYmJVL0xxc3E4QWlv?=
 =?utf-8?B?YjhFNzFxYitWaHpJK2c4djRJdVlLUXU3MDBkd0I0eERzYUdqcWprZDJHV0Np?=
 =?utf-8?B?d2pzaTVmMWQzQnl5MHdLUHJOMDVZOTFzVFZ5N2d0OGpNQkdFSEc4bFZXWHA1?=
 =?utf-8?B?MTdFeE1EQ1cyV0JncVdvN3c0bnE1R2lKd21MSmpGck92OHUxUEsxcGY5eHoz?=
 =?utf-8?B?UTFNbVFhUVQyQW5IenJRUVViNlEvVTUxcDFCT21JQUhlZjJDVElpaHZpRmtR?=
 =?utf-8?B?ZklyUmw2Yk5XNDZXMytjWkpIKy90djBBNE9WYzAxQUtjR2hRb0ExRThQT1hv?=
 =?utf-8?B?bk1TVHlHSHdEU3Y1dTBnK1JON0RiVXd5MkpYSTJKdDZFejEwZGpxSStEODdL?=
 =?utf-8?B?Qzl5ayszaFZtU2JSaVZqdDNwTU9aSjJzaFZKTVR1djZtQkRnRkh6MG9yTysx?=
 =?utf-8?B?WlZlb1gxSmZPRlZ4UzN2bnVTV2ZMQTBHaVZ1RXI5L0dxQnFJcXVSRS9XZmho?=
 =?utf-8?B?V0tYd1Q5elVBbWtkajdVUlFDUjVXalF1RG1ncXp1Z015TjU0TGJDRFFFV2ND?=
 =?utf-8?B?aTdXdEE5ZVZHSi9yVStlVlVXbFhUQVg1NzZQLzdPd3o3eTdZR0k2ZTdwekJN?=
 =?utf-8?B?WUlPbW9meDgyOHpTcFBVeGlsaFJTR2wvdE81UUZmczBZTXBlRkExOENlT1Zr?=
 =?utf-8?B?VWJFNWtFMjNTcEMrNUZCY3pYM2g2bjl4ZGxkR2xsMmliL1RHemdQZDk4ZVJJ?=
 =?utf-8?B?TU42cmlaaGpBUW8xcU5tcE5OVFlmYXAxYUtVOTlJeHoxbG85OXVaTlpSOUNa?=
 =?utf-8?B?TGx5TnA0RTV1dGk2Y2lrZlFKVFFLSXFCc1BKUU5yVVplRXp3UWt3YnRkWFpa?=
 =?utf-8?B?WnBJOGFURzBJTGorQTE5LzFSZ2EzNkJ2bHA2VnB3RlZseWJMV2xacFJ4NGlr?=
 =?utf-8?B?UG04WFJoQktkNXZxd0xJWVlNS1BPS2tHRW9EUEpkMUpERDlpRjlaajdhc0FE?=
 =?utf-8?B?MkE4NW04ODhFeGVlQVNVN3kxdVZCVi9IVit3UndwT0FOSkxML2xnL1BYelRJ?=
 =?utf-8?B?VEIrdTJ4SnhDQWoyazFQZVp4ZWlrMmRBNVVXOVB5Zk5KTmkvTjAvQnc5eTFC?=
 =?utf-8?B?RkkvcFo1ZDcrdW5KaStRTEZIUUllTDllb1FTMmozMlJSQzd4b3M5d0s3d1Bu?=
 =?utf-8?B?TVQrNVpQZ2gwK291Yk54Z2NtYkFPNzJqNXRQZnB6YTRqL2x1UHpGc1RDS1B1?=
 =?utf-8?B?T1lWaExRbDgvV0NLQ01nSzR3QzJCM25sdlNTbm1HS2dxS1BMNENUVjB3ZTl3?=
 =?utf-8?B?SnBRMGxpekpET283VVBHdGtUZjNGd0hOcnBWeE5ZejdBU1VpWmZoVDFXTzll?=
 =?utf-8?Q?Z5/Q5SHBos4VBoxruU2O0yq0TrCnHad9nguCpkBo2+dF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <123E936E3EFB3F4193CF092183AC3F8D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8237d79f-faf8-4886-6c76-08dcfe209b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 05:05:17.4895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9aIxGMQ6UcVLnSt54qWMVYgv2pKKVKHwNxGjyDcIEuxzviAhW71lqnyJbMTztXJO264z+rCF6swdGX9JSxu5Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_210530_198218_946F0A1E 
X-CRM114-Status: UNSURE (   8.02  )
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

T24gMTEvNS8yNCAwOTo0OCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPiANCj4gTm90aGluZyB0byByZXBvcnQgaGVyZSwgYnV0IGl0
J3MgYSBtYW5kYXRvcnkgaWRlbnRpZmljYXRpb24gZm9yIG52bWUNCj4gMi4xLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogS2VpdGggQnVzY2g8a2J1c2NoQGtlcm5lbC5vcmc+DQoNCkxvb2tzIGdvb2Qu
DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQot
Y2sNCg0KDQo=

