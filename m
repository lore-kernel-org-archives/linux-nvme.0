Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2327AC54E49
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 05:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tjDoU2ImgtEijmNcQuf1Ye1HBl36Ph5PU/OYAjclqJY=; b=4xyHiKPldr5yf80rrY6x9R7y8l
	9Yl6l4zuXIVIfn6gp+mlw6eGXmuLKt6bij6nY51VWU8tMdIL5qBnXTbQfj229uSlpYfR+6a3YMSE1
	wanOmK0Y4RgBeG4HUmAmaOiqHOuFsnhqNcUtf6KNIHfbFkh3oaDCCMFlsHF7Kbwc3AB2vp/gnGm8x
	ho9TgHIKxMWEnFVwFteWKfjY7EH8GlhZOWP4xpWMQGbxDYT5bhKtcz4ho/o4qQn5jIcvIsHexC0e4
	/gtQmGPmpL/M96DvDjc9mELdw4RuDjgNi8m7ZjkGPWbz04diY+o4SpWxhE1d0sY7zDJfndgXRwyXl
	YNHQHHLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhjiX-0000000GMwn-1jo1;
	Wed, 06 Mar 2024 05:21:25 +0000
Received: from mail-bn8nam04on20600.outbound.protection.outlook.com ([2a01:111:f403:2408::600] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhjiU-0000000GMvb-2i9J
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 05:21:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG/LodgxLZJ0wmrUypro3XuX1f7CfwRqd3WLAGMYq7uPyucXvnJGCg1rTcgAF74MMEKdy04YcRK6HAq/hN4XqBkojuvNe5D3uWQT9OcEy4gg6ECFl3mdVta8j3XpTTIFKEQKSZdMeK/tywLsWNGi1ycGwsXExbGQ55gPhzhYfUM65SnBYI64tY7cBBfdEVB4Qqd9fnNK6/ZuaANPFPElp6x2x2hremQDTpjq91W1zuEYBJj7owSCa6WdVj3SUW9f+ZYCvVljiUPbijD/knTnH3S39EAhK1jLaxRIaAjG9NvhivuDUeH2HMu14m8kTZ+mcXDDU5I65MElfubdGJ2Zcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjDoU2ImgtEijmNcQuf1Ye1HBl36Ph5PU/OYAjclqJY=;
 b=e3lyi+WYOG9eHjzs/M0MiNtrLO6twx872zs+2eeVINVUCKVjl8COUUjG2nGfAm8SadO5pBkoTrTmt/mmkSrk469MtOmY0mw7Y4klPfKEEdUzwcE5S/XRBoSinPYYhzFCY0NTW3avSIga44YUXda9HQ+KH7wwL0moz2MDmVDE7mWQC9fh1YvwH2JbhDikyPMFADJtvyxheCnl3PWdrV9IdAtxBVhLOhQTlRQo1W40TkO7SfL3NiLO7/KRgOmFuXXsrpyN+Q1mnCLQxtTYgIqK7OIsij4Iiu3bwu+pNM02iVxTCbxp+VrBMt+IsC4yARiemQDwth7yCLiXvcfr8h/YiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjDoU2ImgtEijmNcQuf1Ye1HBl36Ph5PU/OYAjclqJY=;
 b=E58iMtwU3VgWejgGplCCrRjzdYGsr6gw7kIPhk6hY/2lEG91EiMO5p1DGl3sml/lzo50Qa/JcmFrJjajCLaLXqoKnCwjLJD+zG1rmJ9L/3VRO4QZumhXYz8ma446IGmR2bPaLHiqnBXv7m3+gi8coLiJ49goUWpWU1zgpe+SN7qi2CjTygr4hpIvmACWKKXQd+Evj8B0cC5QnCXX+zFF3fMP+W7eBYUbI7UtRoUf+1QeviATrAn5Vd05BMHS8/dWwl+tYkt8/V2yzazw3OIYz5d/sGwKjVtPwizgdxRngWsdG4dZFTsvq9/4plttaE+315Gf78ppTnYAFqSZPapNkw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 05:21:11 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 05:21:11 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme-core: add ctrl state transition debug helper
Thread-Topic: [PATCH 1/2] nvme-core: add ctrl state transition debug helper
Thread-Index: AQHaXWu3LWYv38OYtk+GmIdaKDPvLrEpewIAgADWWoA=
Date: Wed, 6 Mar 2024 05:21:11 +0000
Message-ID: <db18830a-ec4a-411e-b9b3-1951965abbb5@nvidia.com>
References: <20240212042641.227821-1-kch@nvidia.com>
 <ZedJeFUpuogtBSd5@kbusch-mbp.mynextlight.net>
In-Reply-To: <ZedJeFUpuogtBSd5@kbusch-mbp.mynextlight.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB4431:EE_
x-ms-office365-filtering-correlation-id: 0ec65b8f-9f38-4f83-b67e-08dc3d9d3ca2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +VDQVS+yQ1EfiO5afY8CKT2Uy3ZORa11f+1ZJeHZit5pKMKRVdS8BFXzTLnh+g66XVCn3XLQo0nk3loeCzEs2G//c1jwNGbR/97JjrjTzuxzVPm0D1IL75xSeTpLMW8Qjs19cd/sgqtMtV1YKAJsjp05LatN5rWw9G01AaBr+bCKui1VRiaS8FN/22YbZvfPKzND4TKC+HS6N7vDygtrtVikTnwB1GVoV5eht3Z21ijHoUWS9xKTMP8Dmz99WeJeumqgCmFVs4vJ10vGpfv/8YwESxw/14cndUO12hKgad9crfa108Z0+G9TqfFzvAkiItVS6p0pg0IfWTWmjGHYnm1+dPkzpQZuADV1kwgC3/4dkGygL9iMof0vIark0BcwWTkgduE9HQ+v251/L+MIqFCq/4bsngn4PAVt+18bnt9YsGJvtUFByOq/5efxwkXLOZ5yOXFwJRauOLEq2f9gHNs2iOBuFxJEMi4PLFqnibzaqe2SzeeV35T3sJp6OZqrtTulXNmln7narhdwnGBEIsRVetNi+g+W4U9hVpawak5PCrp5b0M6lhIw+Y8OYfiZ57lQ6u4FxI4D77mJsQqd6un7kXsW/381cUPBh1pLPU2ChcnmnkjvAIaKp0n8GLIBIzN6v3SUGR49LH4eoZuVTcYqW3pvpr5BGnRstl4WBfGu+fnxfJfbsWMORuyF3Oajba5KaJ3UBOzTmZUURjGryqFzMjfwNmXGAfAyKT5pFxc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHdWY2VHV0pVZTJoQ1pzenF1OHFjazdLbTNyWVBkdU0vV3VkT3RMNWMxUXdF?=
 =?utf-8?B?WFJIeTF1TnVLOXZIRVFpWWdWcjZnd0tUbkJCZVB0TzZ2dVhnREg3cGMzVWRN?=
 =?utf-8?B?TWNRekpBKzlKdW1OSFhkUWFUaFV3STBHNUtqNDhGZGlHV3gxbkFHZkhvR0Zz?=
 =?utf-8?B?a1lhWVdXSDFUVHM2L1FxSUZKcmo1bjRrVlRGVnA1QTJiUS9IdW5CYXJRUkx4?=
 =?utf-8?B?NlhiempaWHZmeFpLbGxDaHdBMW55YVFvYWJ0TlpPbTJ3Q3NiOXZPWWFmYW0w?=
 =?utf-8?B?d0dRVXk3ZkxLMGdSTHF5bHFydzc3ZDJTTWNWTmx1UGdqTURyc05ZRnp0b2tQ?=
 =?utf-8?B?SVVuU2JRN05TeEhiTVh6UjNYOVphMWlRditlY0tWdWFvUDRFRFI1czZQU2xH?=
 =?utf-8?B?L1BOdGkvUjY0eWtKR2ZoNWhkZFYyNUJHd0hRTWRJNWptVGNYMVlRbUlNZVI0?=
 =?utf-8?B?RVM3eVJzQnY4d3FJSVp2NlRKaUd3Z2VidWlhazJuL1B5NUdIVkxEU1A4ZFZa?=
 =?utf-8?B?V0FjdERjRWx5ZFRBM25IWTVkOUhkVHNZSDNQdnp5dUF4ei94Y3RZY21XRUw0?=
 =?utf-8?B?ekVQR1NwWWI4Z1p4bVo3SVBBVGtKQytRSHhyUHNVTDdlQ09UcE14dmI5MVBl?=
 =?utf-8?B?Rng5TFZ6UlVFNjBncUVIUEovOUk0K0JTNnVmTktFbFdtQ0pSeDFyeVhUZmNW?=
 =?utf-8?B?WGVzUzI2dExsMjRIWFhnVThtQzhGS0c3VndjNFFGbGFnRzZpaERzUXBuS3hu?=
 =?utf-8?B?bkp3WVR1cGZGVEJqd1JCTk9URW5XalNIWWZIYkQ3aVBmOUVRSklBOG1Qbkdp?=
 =?utf-8?B?UnYwMGhPbWNJdWd4Q2R1a09OQVFRMjFIRitGTkh5empqdG8xelpJU0VPQXRV?=
 =?utf-8?B?VTdEczFYeFBWZkZoZUtabVZpb3JVdG1yaGRCVE5wNzhlanNTdFB5dGIzaHpw?=
 =?utf-8?B?NnJUY1lHT1B2ZjJ2SzNFQkZIY1YwWWhlLzNvb0EwSzZhK3UzK2FvUC94MnFn?=
 =?utf-8?B?cGMrQm9ZS1E1OEp5OTVna0tqZVpuRGhwYmQxSmZ6ZFhzVUVSVzJIL3pYL3dF?=
 =?utf-8?B?NEY5TWdjWi9CU1RuRkNGQStadnFIaGtLeUMxK1NDQnpSVUNJd2JzZXFGenpZ?=
 =?utf-8?B?UjRyK09vSzFxVnFUQldPQTRFM3kzYzB1VU1NbFA4NklNeFhNeVlCMStIQjBh?=
 =?utf-8?B?SHFyQktkMUNoYmlXZHR0aWszbHFzTUJXNWdISlF6Sm51MVZ1VVZsT3EwODc0?=
 =?utf-8?B?cXNZbjByREtmalViMC9SNWlNSDFXZjhqZ3pIaU1ZbVdRNDJJRVBIVDBSOG9R?=
 =?utf-8?B?SjN1c2hremxsblhCdHhvZk9QUCtlQjNGdXlEM1JWV2lacFZFYXpBeG9GVjZG?=
 =?utf-8?B?NXg3dWpUUVliSWZEbnJ4eFJVWWxoeXVROGNsMXpiYlVUZlVkeC9UZExaZHk3?=
 =?utf-8?B?S1haZHZCVDRteHhNTUh1T2VvaUZUamNabVhWckZCOWdLMXJrRGY1bWNGR01a?=
 =?utf-8?B?Z3E5blVEREZDK0JVUkI4WktadEcybGNHWkp1dSs3YjJMNGtubCtmRFNlL1Zt?=
 =?utf-8?B?WGljVGlrWktIaTVWZnZkaTlSMmxSMkQvWkl0RVpEYnRsMXhDTVhJZ1lNUFJq?=
 =?utf-8?B?c3BscG5WaTdBS1FVUzhYamlRUnVZeVAwQXEzQ21xYUh6SVhKWnN1djlZOGxq?=
 =?utf-8?B?VnRTaGwwODFSZ1B2YVhDN2dnV0lCbm5sRTFtMUMzSW1tc2cxMnpVSEwvQ0dw?=
 =?utf-8?B?aWEzV05BSFVmNXhDMnZVMmxKVzdHdGYrM1NZVjJjWllrM0lBRVA0Q3d0MTN5?=
 =?utf-8?B?dm5XVTNOUXI1bG9ub3NNaElDRGljVHV1bjl4TGlGRXdkblhNRW9SQTRCd2Y0?=
 =?utf-8?B?NVlTdUk1czREaVp3ZUYzdUxCSGloYUkxWlkxUFZkYmJBNmVXOW9yQUJDVm1y?=
 =?utf-8?B?alZGbFBxUmpzWHVUNE95bHVISUVXTE5CQVl4R1pRbUJ3amFLMGxuNDZXY211?=
 =?utf-8?B?VnR2c3l3NWtFeWhSQ1lQUXh3VmZKM3VzdGdhdWRqcEl5UTJjNkVJQS9uNDhG?=
 =?utf-8?B?YUhBTEVBOVF2bXZRWHJ5MGVVQ3ROdDNoM29RTGtKMnoxQm5KOVpoQTByazdE?=
 =?utf-8?B?NDFKM2VhcERqOVBKRGdkRkhzMGJQRXRhWE1BMHZLcHRRMm1CL1RCMHh3UHR1?=
 =?utf-8?Q?mRkZt9B50tTRjxGBjTG2wnNq8xbD2bJChi/c5RE7rNFC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12512C650A1C4D409D32B146A0E906CC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec65b8f-9f38-4f83-b67e-08dc3d9d3ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 05:21:11.6180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rl/5P6PN60uzGZrKkkVSfagunveEhuvyEXtDSAsGyHf5NYoz22jYce/5K6XE+917pxTKnZ394RxbZRt9mf6Odg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_212122_710745_F029E8FF 
X-CRM114-Status: GOOD (  10.55  )
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

T24gMy81LzI0IDA4OjM0LCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gT24gU3VuLCBGZWIgMTEsIDIw
MjQgYXQgMDg6MjY6NDBQTSAtMDgwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gQEAg
LTYyMSw2ICs2MzYsOSBAQCBib29sIG52bWVfY2hhbmdlX2N0cmxfc3RhdGUoc3RydWN0IG52bWVf
Y3RybCAqY3RybCwNCj4+ICAgCX0NCj4+ICAgDQo+PiAgIAlpZiAoY2hhbmdlZCkgew0KPj4gKwkJ
ZGV2X2RiZyhjdHJsLT5kZXZpY2UsICIlcyAlcyAtPiAlc1xuIiwgX19mdW5jX18sDQo+PiArCQkJ
bnZtZV9jdHJsX3N0YXRlX3N0cihvbGRfc3RhdGUpLA0KPj4gKwkJCW52bWVfY3RybF9zdGF0ZV9z
dHIobmV3X3N0YXRlKSk7DQo+PiAgIAkJV1JJVEVfT05DRShjdHJsLT5zdGF0ZSwgbmV3X3N0YXRl
KTsNCj4+ICAgCQl3YWtlX3VwX2FsbCgmY3RybC0+c3RhdGVfd3EpOw0KPj4gICAJfQ0KPiBUdXJp
bmcgdGhlIHN5c3RlbSBsb2dzIHVwIHRvIGRlYnVnIGxldmVsIG1pZ2h0IGdldCB5b3UgYSB3aG9s
ZSBsb3Qgb2YNCj4gdW5yZWxhdGVkIHN0dWZmLiBDb3VsZCBhIG5ldyB0cmFjZV9ldmVudCBnZXQg
eW91IHdoYXQgeW91IG5lZWQgaW5zdGVhZD8NCj4gVGhlcmUncyBtb3JlIGZpbmUgZ3JhaW4gY29u
dHJvbCBvbiB0aG9zZS4NCg0KdG90YWxseSBhZ3JlZSB3aXRoIHlvdSwgSSBoYXZlIHBhdGNoZXMg
dG8gYWRkIGZldyBtb3JlIHRyYWNlcG9pbnRzDQpJJ2xsIGFkZCB2MiB0byB0aGF0IHNlcmllcyBh
bmQgcG9zdCBzb29uLCB0aGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uIC4uLg0KDQotY2sNCg0KDQo=

