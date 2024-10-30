Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAB6D7497D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 07:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MUkFDt3gaC4i5dHJi2zI2n/Wmcb9txzd83g4J7l1wxM=; b=v3GQRtaOI4yb24KA0ZTh+IxQBN
	5GQKfqr8/hjtxjRBEQa62HpP4GEAXP1EnZ8rFr5rzc638xapa+n27rldR1KuQtPsfQhe1pWFf8gOj
	cLHRC1gv5epFi9C4VAAF96jl5XpL+enc5ysyZYdGySNT+dzPWjyakqQ/7aWLjqL2iFqawRd+8VNOS
	gk0GzNaNH0Qt5hr7F9Ttigngn/+/wq+I4A8HvN0gdEtLW42HKGio7+0myOiEfhf3Is2W3RDy9OyW1
	Z1/MM/W6flJRM/Dcg/1jdRQbk05a3B7HdvOL2F+fOerC7ij0llej1KvdpT4MBvalMr5J0YGHXhv3H
	L1wofAXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t63Wb-0000000HCvw-0kfM;
	Wed, 30 Oct 2024 07:53:53 +0000
Received: from mail-mw2nam12on20630.outbound.protection.outlook.com ([2a01:111:f403:200a::630] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t63VL-0000000HCqN-03v7
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 07:52:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxDoC0Sclot6W6VLdScVyzOn9m7JI1uFbpJf0S8LMdbNBy9UGMRswTZxTysGfPkVRpDlq8dZ3ZhJ0ZYnfDDez6jO3ral4kxDSyoAfaJFic+s/9uRhK+u6RosdCZ+IBDCnjw4VJSv6k+PwyiVpxRJbnRErlPR5zH6X9oe2Siy6jHrOFmNpWH3ooHLbffJebCaLT5J+CD7cPebFdE4v+7GhllsDPf0+qQGtyPnR8OWeiGF2N0K5Ue8JyZES8s4GBNK0AJwtsVNIKE/le7zuLVmrEpXdBBGgaivtgivD7SjA1gPKFQp0ZDDjeKX1dADSlCxIpFmQefs/dEzA3j/WaNW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUkFDt3gaC4i5dHJi2zI2n/Wmcb9txzd83g4J7l1wxM=;
 b=s32e8tWyqdTQ+Y/abxJFrB0jVLA13vYArxxuYj+CUktRcWwDUNelcF1YMtOX2lb3p26sCzw9WoJ4r6di4fbojRUY79kdtqwlt3VGFygIOHQTBTN3pHk3GyXIHpkAspEszMW/QjqxeavPexxEOgJMecSWdtCLmXsRF1qh7pvt65jD+Y5DgGyQdEy1wwrubamcEaQQX2hhoRfK+D3XlRDUDmKEIshgVcW5+s+F0XpOi1C4w28NzAOJQ4TdMm9oBp3JseBiNsjbEcE3qaRvaelqR6jn5xW7sE9VDVHLrkhDmGR55aZQGp06nGMUd9Pu/HoVgTe+QFb35dPiXrEVRVnung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUkFDt3gaC4i5dHJi2zI2n/Wmcb9txzd83g4J7l1wxM=;
 b=QIysPTHKGoJ39CtWi/0F9WBBDQDOIwrnnmND/u0/M8xOuT/O5n/kLSowN/fVvr0xZWJB13eEuaAC98nEghA3GlKoyy9aWScA7MUaaFLN+v9XbDnLVEwyxah4QQnyFEyMXb2iYyYtf9ypT9ELexH2LLHtXZJKVN3OlShw3QEUFDfRXM/YEzMJtTC1ZGZJP40Enezz6rSiTNympEun5Ecj2mB3UxEDdU742GNXavLC5YFrdKsQ90Gm1m7c/VvLg8I0ICExRfncv66YBduwf0vzwVtt7CKAVcwDHYcCmaTk8YXQgh5O/ecXAK2pUMULuJcvLESuePa1o4klL/XXW/d/2w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 07:52:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 07:52:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v2 01/13] nvme/038: use nvme_trtype instead of
 hardcoding
Thread-Topic: [PATCH blktests v2 01/13] nvme/038: use nvme_trtype instead of
 hardcoding
Thread-Index: AQHbKphCqy7sTaw51kWQLvYbAeAj47Ke7B8A
Date: Wed, 30 Oct 2024 07:52:25 +0000
Message-ID: <ae7c1fa4-eaec-4651-b9d5-5ed5d209bfe5@nvidia.com>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
 <20241030065149.2297405-2-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241030065149.2297405-2-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN6PR12MB8591:EE_
x-ms-office365-filtering-correlation-id: 0467a0f0-9df9-4568-1752-08dcf8b7cb49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Tk8wZUpjZ1ErZ3NDR25LQXRxY2ZFVHlxMDFmNEpuV214aEJjN3AyWGdGaW96?=
 =?utf-8?B?V09LdXAxZm15VDhmbXg1cXUycU8ydkRSVlhrL2FjV1VZcG9ZZThMcE5GYnoz?=
 =?utf-8?B?UkpLckx3WlVBWTNiOXlId01IV1Z5ajBYdVY2SXFIZ3VTUjhiSEhNejBSajBP?=
 =?utf-8?B?enF5ZG1MWGNQVy9uT3VZN2FhbFZsTTlYclZnV21jR256MzR2QVd6QTREYTJJ?=
 =?utf-8?B?a3pkMS9ZVHF3REkvTFI0WDNKdGhRcC8vTEV3a3JyRUJYc3NqVW0wa3JxZmsw?=
 =?utf-8?B?Umx0OXpQYzFQNEpXdFFmcnJXZUFpUTUrSGZTY0JYckl3NVoxb2lIa05pbC9E?=
 =?utf-8?B?am83MTJueGZDUkE0QUUzckdEWU1JdzZmMlNTVWxUN0tVSFFUaGptTWJxdGZv?=
 =?utf-8?B?VmNINlZqTjAxT09ueExvSTA2a1QySlBVYWZMV2tWaGRvSzJiNGVwRXFqL2NM?=
 =?utf-8?B?NHdrUllkbG53Z0F1ZHo4REF5TEk5dXhrbEJNdHJ3eWFHdm5MaU1RMW9acEc3?=
 =?utf-8?B?NW5CeUZXc2Z4Y0YxSjQwdXIrVGFLSUlnMEUxN3pqMDVwbTVuSlVKRXMxRkpW?=
 =?utf-8?B?Qkw5dWwrVFVrT0VGajlvOXd1azgzdFFhaEY0Wm16bmlNbUw1cnVkcFF3Zysy?=
 =?utf-8?B?bU05Y1B0N3kxVVNQbkpJU1V6aUs3SHh4V29MbU1iR1hCTnBxVGV2RWgyZVkv?=
 =?utf-8?B?TlhUWjZ1KzhvYkFQOENiVWdoUDFleTVUaE5EbmpCdW05cng5QnNvQ2RZVjEw?=
 =?utf-8?B?Tm95NndlZzJnK2ZiVm1SMUI4aGNvOGEvQnZFS09ydkxJYUwzL1hhaDZoYS9F?=
 =?utf-8?B?UGN4SktaQTNMTEp6S29XZEt5ZUN4a0hhS3VLTUxGNlEvbEFQbnB6QzU1b3p3?=
 =?utf-8?B?ZlhiMEZ5WGtNSk9vTTNKVFJ0MEpmeHI4OUhvREo3cm80Q3poSEtDS2QyMkpm?=
 =?utf-8?B?c1JkZm9vWm95SXpXVnJBR3VES2xGS1ZTcDRjSlIwYWFXNks5SDFmUHpJSzBi?=
 =?utf-8?B?UWpTTmNIQ1M2Q29ONm5SNnl0VXFOZCswUTVpTUlFT0t5WEJrRDB1MUdmbSsr?=
 =?utf-8?B?V1BGL0ZnVXdnZnI2WWY5TmhMNStPVURNbGx4c1J2MXVhZ2JUUVpEdWdnN3lI?=
 =?utf-8?B?c3paRW1aakxHRTFUcjhaQkUxMHJJOGx5MkpCQ0o4eWlMMXFBZFRFOU5maXNC?=
 =?utf-8?B?bWhOTnJDMFJBOEhuMDlzQ0FNdGNUU09JQ0JLZFJBR2JJVlhVeXBtMXpwUmF5?=
 =?utf-8?B?T0xKMzNKN09oSDkzQ2NrY3ZkNEc1V3hHcERQRDh5UWdmRklxU3h6MUxMNjZq?=
 =?utf-8?B?RDQzaHJUSWI4TlVVelVwMFUxaVM4OTNYQTNFa0lQOG1lanpNSWdFREdkY1o5?=
 =?utf-8?B?Z1RZcXV5UUlxeDVVZzA5eWgwMi9DS25DVHh5YUM2SHNFbDV5aUxvclMvbStD?=
 =?utf-8?B?bUhCMDlWSzBlUFZtOHRmcE43TzVTdk5qVXY4ZGVFR09RNVltNEJHQXpMY2M0?=
 =?utf-8?B?Yy9VTzN6SFRtM2hZL0RpanZ5akdxS3JFRjZtSjF1SjNLaUFUYmRsa29MRDdl?=
 =?utf-8?B?VVFXUFBGMzljRDB6TCszM1pPLzh0YzhnUXFJM1JjNmpONndvc2h0Ry84WUV4?=
 =?utf-8?B?ZXBQRTVVVUQweHd6dDRqakxzYldCZ2tudHhYRGhkZXhhOUhnOTg3U29oT2RM?=
 =?utf-8?B?ZmxGQnlGUEFGOEpqaTBCR2l5dVlCdTBZRGZ3Q2tuMk5wajdTSm01by9uSmVk?=
 =?utf-8?B?Z2p4S0t5T2VZdThiTm1obzZIZm4zMXgrazJPYjFqV3oyclZrZUo0VXR3V1Iv?=
 =?utf-8?Q?RMtozhfP7Fh+tF/ZplAmajQZxwMyhdcD2CfkA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1Z4b3c5bXcwMkdkc1ErYXpZM3p4SFB6WHM5eGRKQWtTTFVqZHNlaTJ6VDBa?=
 =?utf-8?B?VEZzMUVrY00xR0poVVMrdmVvckRKV0FjcEZGdkRDWk9tcG94Q3hlaTN3dGM1?=
 =?utf-8?B?VjJTQlhiOUFaQStYVjFzQUtWcGFHMW8xY0NBUkJGSkxLSnhDb0Myd09jSUx5?=
 =?utf-8?B?ZDdDaGNEN1d5Y01rL0dUZVNtc0lsSjd1STBrMU5ZTS9td3ZDeGFraGNQVWNZ?=
 =?utf-8?B?RnlMV0ZaSTdHOUlscnFleHhGZ1ExQnJBWExaL05BTWJZVzIwaHQxajdJalBH?=
 =?utf-8?B?YVo2dE1CekpwWm02cENOR05Kb1F2MDMrOGpCV0RuVmFDRWRRUGJ5bFdCcVJ6?=
 =?utf-8?B?UERMbmhGM2RMc1BlUWl1K3N3VEZ6UWZJSitvcHY4eEhzZVZGa2FFaWY3cXp3?=
 =?utf-8?B?V3o4b05vWGZ1OVoxcGlvcEpJU2tyMTlRdEdleWRZR0VVWGRabFA2QUU0elM1?=
 =?utf-8?B?Vi9RYzNpTkE5UThmRjVndG9KbEZ0dytQMVI2ci9VUEdzaW43OTdjOERtQ0h2?=
 =?utf-8?B?cXljaVhQL3ljdjIwSHlVZWk1U1A3NmFJWEk2b0tNR3lTWlJrdURqMURhN1dN?=
 =?utf-8?B?VDBiOGRJYit0ZTF1T0VJMFlCS1FaN2RTUVVJOHhrVC9sMEpIYWdPdGRnNlpl?=
 =?utf-8?B?WGpReThsVmVCSDU5QzVJWDJETkN4UlJKMWZ3QUludXExTjFxbWZUMkIyT0RY?=
 =?utf-8?B?dG9wVnFUbGVGanN4bHZFZ0JOaVdObTdKNmF3SUIrQUZMejJMUUFkUEVEbHpF?=
 =?utf-8?B?L0hRUnpkVEdXTFRGVENmbmQxNkhPWTB2RVQzOENaZXNMSWtXTFJaQ25XVTlF?=
 =?utf-8?B?eEYzMEduR2dMR21EcG1BbkxjTjFNR25uUDNQelRZSit0QzVMM3MyZlhPOEQv?=
 =?utf-8?B?aGtXalpXTnpudWI3ZTQxL0ZVbzZoZjA0OWRGVTROSERhUVlFSjJFSCtQenFv?=
 =?utf-8?B?azV3cDVuM1FlV203SnlURGJXSUxiM3puY1pqOEEzbTZVQ2UwcWZNeUxYVk9w?=
 =?utf-8?B?blJsWDZBUXVldWxjTEd5QlMwVHRINnRuc3hrdis2YXQrNzZlNS9PSGR0amVR?=
 =?utf-8?B?SlF6Z2JEYUdGWVpjZnlvMFk3d1NJTWlWUHpYRWV4U25XRHRTOURsNFNxOERl?=
 =?utf-8?B?d0FuamlxclV6L1B1Z0w1MjJtSEovR0pRK3pCR3V3WWppeFptR3dQeFVTdEZv?=
 =?utf-8?B?WmRIUktHUFZ2eFFPUjFqUkxJNjhldktSY2lDV2VwMDF2ek5kODRUcGFocFUx?=
 =?utf-8?B?N0I0M1FrWGgxVm1Tc3p2U0QxK3ZiRXRCWWhPNzJWdktNMjl4eEdpU01vbHEy?=
 =?utf-8?B?TlBMYW9ZaEV5d1EvWUQwV2NvK3VZeXZVOEpubUVDM05ueURjNVpNQVdCYk5C?=
 =?utf-8?B?MUt3Tk5HMzRDM1JTdHRkdG1lMGp0T25ydGs1OHVZanVMdjA5bHdidUhLMkRR?=
 =?utf-8?B?ZElESkV5akxOVnpCVGduUDFoL1o5TW94a0NmZ1V4TjM2UnRiSktCYVdBV3Bh?=
 =?utf-8?B?Zmo5ci9ORGJoUXc1WTVPVjVpNldacjk3aHVsZkMrcmIrRVVrby9vUWorMDhC?=
 =?utf-8?B?Zmh0OWNlZGJaSmFmNlFjaGt1Q1laclkrb0hnK1hvdWRaS1J5V0w2bmhHeGlJ?=
 =?utf-8?B?NGFzUDFOVzRYYWVGdFhyZnpvQitveGZxS3BGZkllNzQ5WEVGYlQrNHJQUmcr?=
 =?utf-8?B?RVcvQzY2emNDZ0w4SmRUZHpKS0hPK0VFMTBkVlRTK0t1MkRpc3RBalExRm92?=
 =?utf-8?B?TGVvMitMb2lvQThsa1lFL1NHTGwvQmZKNWZ3cjFJWXpmc1J2S0NjTk4xSHY5?=
 =?utf-8?B?eXZRTmc4b29DaFRwM3RZbm4wb0pkKy94eW5aMjRxcGJ3YXIzTGpueHJtQ2Nw?=
 =?utf-8?B?RDFwZVovQWlFZW1MNlo4OC9iYkEwRHhNc3E4OEQvOGx0ckxFS09DR3JJOHFq?=
 =?utf-8?B?WWw1d3Y4cDBMUi9LT1dhcjE4TnVUOUJudnpIYnhtWStsa2RQdTk1aEtWTjNr?=
 =?utf-8?B?dmU0Ym5ZajNlRWk0cVdXSkkraktpVGtDNTVTSGQxSkF1WkVDUllxWUY4RGkw?=
 =?utf-8?B?YXhNMTMxeDBUdjRLemtUL2dTWWtWQVo4ODlhckxtaGpuODRVWUNRQXhNeFFr?=
 =?utf-8?Q?RCr+rOmfq+EgvWpIFqmN9pCw5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <076A58934B260C41B75944233D95A125@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0467a0f0-9df9-4568-1752-08dcf8b7cb49
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 07:52:25.2414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9HM7/CfhtzjeF7P9381Eq6eK54bastYFkxZNu3qu0lFvwlaZpadOHT5yjWVPMal5i0XBW8Ysv1FMEnvxm+SdYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_005235_081142_0909DF9C 
X-CRM114-Status: UNSURE (   8.77  )
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

T24gMTAvMjkvMjQgMjM6NTEsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBGcm9tOiBI
YW5uZXMgUmVpbmVja2U8aGFyZUBzdXNlLmRlPg0KPg0KPiBUaGVyZSBpcyBubyByZWFzb24gd2h5
IGxvb3AgaXMgcmVxdWlyZWQsIHNvIHN3aXRjaCB0byB0aGUgZGVmYXVsdA0KPiB0cmFuc3BvcnQg
dHlwZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSGFubmVzIFJlaW5lY2tlPGhhcmVAc3VzZS5kZT4N
Cj4gUmV2aWV3ZWQtYnk6IERhbmllbCBXYWduZXI8ZHdhZ25lckBzdXNlLmRlPg0KPiBTaWduZWQt
b2ZmLWJ5OiBTaGluJ2ljaGlybyBLYXdhc2FraTxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+
DQo+IC0tLQ0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

