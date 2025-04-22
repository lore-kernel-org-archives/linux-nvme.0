Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED95C369D8
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 07:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YJSPwHYb/4HYKWj/xbiHculOpG9fUfpFU4XIHMQc6OI=; b=jFVTqZi2iIF2I4dKAKihbwGnt2
	XIGQvCGDhwJhptnlwnhY2ID9pxjucvwCePXAuJFCM7X56RHtfs1fLUsRoqcjna4E9ennq5jAaXmwn
	uCw/HX+4hZrzGXCvR3ms6nCK9zQ+HEBQPUeBBlOxsiq1EDXitoBQv7iOSA3RK7hZctDQ3FkIg4TqY
	O2L11aVkxIec0Z3NGjtF4sECPDCPeum+kPyLFm4pYkkMtMYMMLSR7Miqd1YbIS7xYyWZA0wtOweE9
	/mSq/Pk/562zP19/6Zih83nzXDNNArkN5mBSp6Xqun/x/7tsDgno3an/NbNbZOOZvzlzz1yr0+dQW
	zXZTiV+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u783s-000000067Ko-2E0e;
	Tue, 22 Apr 2025 07:28:56 +0000
Received: from mail-bn8nam04on2062e.outbound.protection.outlook.com ([2a01:111:f403:2408::62e] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u77Px-000000061jC-0GrT
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 06:47:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRi8YxQZbhXAdxwmqLGRNntedmEnuz0sqJNwrUWRvmh2KD4jnwLkE4lX0RgZ2RAH6fw3M5DWWxY7MuazadtKf1EM0A8GsJpv4cdZwXfOlPIMWahGuuAfNslrVloc6Cii8JnQ8mMr1XNv6/qDbTL/r/pQOWzFVUYTnPV+6x0LZvccxaH7ppuy9MEIjMpiz7j1IvT/m46wlrxOYOwBh66/mxbTJ6A+A8j5Qza+HZg5Q0RT76xksUPSP9tp7cJ+94A98z5uOewVw5GVnC1M/BemBmbJMHm7JHy8hwECPr8qyopBMGhty1iIAAWo5L2PuOfoDKGBHnCjmmtMlucOMcYfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJSPwHYb/4HYKWj/xbiHculOpG9fUfpFU4XIHMQc6OI=;
 b=vzlRvfSrM6lF6lcf/ihXMIsTq1z/ujtLEf7I11k7fmEyZFky6Ht+/VAAf59fwjlH3pXWdlTYWhHOASUTi4xRfk8XRVcdj54RvC4mqvQjuNFLW7y5Yb1LFQYz+I3hX4aQgs/tJfQ3+nbkOnf5PQuTh3KsDsH9PHA4PKY4I3ZsAqi3PkuCpw7ZCk1GNeFChWrvda3XrptGyJs6lfaSujsM62AzAc5niJ4jRkJH07IkLj4yOzTSJlUfFdHuFq2aYB5tYVk30lEgV/8LgQgRZBRiVvOmP8VwUJD2ntohuXe7RyO3VhONXIcfG/PE8QWk/pElCdeX7L9ktQi+sqTFfqlgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJSPwHYb/4HYKWj/xbiHculOpG9fUfpFU4XIHMQc6OI=;
 b=Ukshewax8TojlNGajMtqIeF4BmYA4aJhJQIx17/JUfkgywk2VuJft0iH030i+VfZBxk94vauWEIDIYtfGasUuc0RP0xxknZGGbsQ8Dx5AJLtBSoRele2xUTNP+RbbyXP2XcXUmcirkIF1Mlu1UzyW9wodGNv+/cpGy4T06cojmt1e3KqcH+gYf9QZW6Q7QLU1NL/PgNx58Z69LdsRa2KmfpmgqUHdV40FT1r2zl4IIHpahNCEWoFYQ1nW0QMe8WVighVDdIcSm+BLzj/odEdNuwcEk4OZBpJqQUdyXMJjjmj6E4EU1GDd6+NAjTsfPOvYhii21MizoLmYrysOqhrrg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Tue, 22 Apr
 2025 06:47:37 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8632.025; Tue, 22 Apr 2025
 06:47:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Richard Weinberger <richard@nod.at>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"hch@lst.de" <hch@lst.de>, "upstream+nvme@sigma-star.at"
	<upstream+nvme@sigma-star.at>
Subject: Re: [RFC PATCH] nvmet: Make blksize_shift configurable
Thread-Topic: [RFC PATCH] nvmet: Make blksize_shift configurable
Thread-Index: AQHbsEF+rFpCwd/m/0iFJLj8GwLz5LOvRFkA
Date: Tue, 22 Apr 2025 06:47:36 +0000
Message-ID: <bdf2b8c4-366d-4f04-915b-c2f374eddcba@nvidia.com>
References: <20250418090834.2755289-1-richard@nod.at>
In-Reply-To: <20250418090834.2755289-1-richard@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY3PR12MB9680:EE_
x-ms-office365-filtering-correlation-id: 46033af1-cced-4828-4bf7-08dd8169915f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q3NTK3FoZ3I4eVBveHlEWEVwdEMvanVINDR2VDU0bDREN1FOK0UzcGVWc0pH?=
 =?utf-8?B?TjBFcFA2aGVDL2NwSUhiRUdYOWJkVktCR1Y4NjVhU255amhTZzNoOEI4clhE?=
 =?utf-8?B?UDJXbXhCOFFVMlBDQnRtZEdBWXFtTEhhbmJVVWROdTQvd0JsY0l1Ri93OGFB?=
 =?utf-8?B?TU5oa2ZFWlJoMmV0YXZjaWpVUFVIaTlDZUozTGY2TUx2L1hhN1BJQW54Nzl4?=
 =?utf-8?B?UnplZVp0a0F0OW91RWF6SE9kYTVJNlFtdGk1cS8vallKdmttNmhOUUphTWtr?=
 =?utf-8?B?S3NjNGQ3aHF5NTBDc3A4dmovdk5QeWFBamZRbTVrdHZySlFBUXhyMEhCNTNi?=
 =?utf-8?B?dGlRanliUUwyTTdaZy8rWkczZkQrdm1ZSi9UOG1NbTM2N2l1U3VDMXk0OU1u?=
 =?utf-8?B?NUg5MXNVdUNqRXpnaTdTZHpJdVBRa0NJVTZMb1NwM0tjbjJORjBSb0RnYmRT?=
 =?utf-8?B?UEg3dUlEMHg3cHptc2hZYVBwT2dpaXlmMHhsZlZsMmZNYXpwZFpTUjBnSW5r?=
 =?utf-8?B?dHFFQ2hRcytSSmlLL1JoakZjdEU3ZWdsNlZwNDI5czhlU09kb0d5RHJ3Qkh1?=
 =?utf-8?B?OU5PZGl0aVNMNUJxbU9UbDhlbzBuZndzUTdOcUlSNXNPRjZkdXpwV3pvdGxw?=
 =?utf-8?B?NFBHVFpRWlJvNVQ3ZXo4NWl4U2diaFJ2akxMUzJ6d2tvTUkyOHZFcmRoVzFI?=
 =?utf-8?B?STFNMy9FdUxHRUlFam9TSWdQd2dwQzhndERaOXRmcFJsL1hVTlJNOUJwM3BU?=
 =?utf-8?B?MDhxMVJ0cGZGY1MyOUtGRVFoRzZBdlNkSStBU2N0YnY4NjFFN3NabHh1VGRU?=
 =?utf-8?B?a2d0YkpUNVV4RUdYREQrZndPd1F3YUh6OUZ2Q0JvZzJrOVpyaklLc2pBbXdu?=
 =?utf-8?B?bmFqcTdSVkJjUWc0am9iTVh1OVhDRDRYekZCVXh0OU5pQlZTbm5pVUR1cU9F?=
 =?utf-8?B?YmtmRzdDSHloWjhLbmV4QWEzdy92V1hITlpOeTkwQk9lK0ZkUVBpZ0R3UDBH?=
 =?utf-8?B?bnhQSVBrVDI2dFJnbTRxQldLOEhUY1k3WHZEd25FQ2ZDanlwc2ovUFlla3Mv?=
 =?utf-8?B?eDVDTjZWUjVnTldMOVVORHRmdFNwU1FQZ0p1Z0ZvaXFhaXhCQ1VkemlBZnlv?=
 =?utf-8?B?dWFieXRYVDNiRTJvZGlsOTZmOHlyaUhPMWNySDNwNS9zeDlGcWhTY3QxT29h?=
 =?utf-8?B?ZHVTaDhPNUtiUzlueEpRVGtRa2FMV25kdDBpdmlZUnRocXBYV1RIQzFnQlpq?=
 =?utf-8?B?amlGMDZUTXpIUC9pRyt2eGxxY1BSL2l2QXphajBLMGRERitOWHVBZDJmK2VB?=
 =?utf-8?B?UXpZK3NRdGZiZDFESW9RZldMWnNzdmhtYktFaWp0dGdxb1A3MlhUeFNZczF0?=
 =?utf-8?B?UXpITVpuWlE0czdVODArSksvcGRDNXcyOFM1a2h1bFlzTDRkK0FMZUVNa2R3?=
 =?utf-8?B?UkV6OWY0bFN3bHZJMTBtQzFiNDF2MWNrV1R4RU9qRmVCU2tvVEFQQUJNTlFw?=
 =?utf-8?B?V2pFOWhGcXgvdTJCOUxKaEphRUh4L3k5QndUbWkvdlU2bWZSenZuYUt2NnNC?=
 =?utf-8?B?OG45RUd4UXY2QmV2UG9TRnRFSUtUcmF5VU5saG1XbE01THF0cXQ5SS9jcW1O?=
 =?utf-8?B?eWQzUERyVHM5elE1bnpNaXhEREEyTjJPdVFaa3VnQlpiR0l3akdMSm94R2Nl?=
 =?utf-8?B?UzlSZFlDdk1mMy9GVStBd2hUcDNoTWN2Z0NtMkcvNkVLNVRxV0V3UWozQlhW?=
 =?utf-8?B?SU1zaTVhb1pQbGswUEk2cVR6ZXZ4aXNaaUErVnovUmUwQUZwbEoxeEh0ZWMw?=
 =?utf-8?B?VENPUzZkc243UjU2c3VCMlA2UjVkNkRndmVaU1BBZkdTVVhIQXNIQmt6NWJS?=
 =?utf-8?B?bXpYZWZlekh4elhNa1FZZzJ4RnF5ejdMdVJYYnI3dStCMnE2N1VtZnZwZ1hH?=
 =?utf-8?B?UDQ0MGIyT0RIdVFLditpOGI0a1IyN0U4dzJtK01mUzFQb0ZzVTlzQjhYOVN6?=
 =?utf-8?B?U0lKR0FSckZBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGZjaVRsVzdNM0RRVUllS044VDROdHViTDBiakhDTi92d2Fnd1NYYkUxSGls?=
 =?utf-8?B?MENHa1RZWm5vdXUybFptQ284RjUzZjZoKzNWK2tlRE8wbElEUkRwWHdibHg5?=
 =?utf-8?B?dWViRkR0VGx0TXZ4N3JHSUsyc0VTa0pFYVQ5YUtiWjA3M1dzRTZlSzFkeVNO?=
 =?utf-8?B?dzB1TFUxd3VpaU45Y05MYzBLS0FsbGVWaGQzcXVxbm40dUxwZkZYRm9IQnNy?=
 =?utf-8?B?T2IyVjNwQVlBMmMzKzJnc3c1NWg0U1BoY1RFL1JXL1plckxFNXIzSkJCV0FM?=
 =?utf-8?B?Q1lPNzg4eDRaSndVY0NtTWRMcUlzaXRPa2NaYjdoNFhUUlB6MGhOWGlNa01F?=
 =?utf-8?B?QzVmRTYrMkpCL0ZaS3h2S2xRQlU5MVR4K2FkbEdBQWVXbm14WmcvOXVjckFM?=
 =?utf-8?B?QlBZZ1E5Y0VrQ3dTYmhhdUc5OUhtd3c0ZmttaCs1KzU2ZG4rSmk1ckxtWWhy?=
 =?utf-8?B?cS9mSXNaUHFoVTd3UmpOUkxEQ3J2d3RuNFpQQ1FwVkNTcmhtL3pXcytJazRN?=
 =?utf-8?B?SHVZSUpUbVNXZUwwSG5ZM05yYnlKWVd1cHR0Y0RWdk5pNUE5MVBlSm04MjhW?=
 =?utf-8?B?ME16Y1lzK3F6V0JtV1ZxV0g3b3FUaE9UNlVtbzFwc0ViZytBeTJzeW9hbWJi?=
 =?utf-8?B?RHV4dDlWSXloamtEM0RtTnJRQ3hKNGtHaWMzVC9FVjdOVk5FalFzZzg4WGU4?=
 =?utf-8?B?UlBpN2dsKzYwMUxxMWJyYVA2amV5MTNQUG1QNmFpb3RvRjFXQ1pEUFpqUWY0?=
 =?utf-8?B?ZHd6WEs5SG42VWhsOEo2UHE3dG1MNW1LQlVSSmdZWHZiS3hvQ0hIUXNHMERH?=
 =?utf-8?B?TnNZQ3puRXNodVlhQ2JPd1ptZGhBQk1IK3NUWHZxTlBLYmFjNEJCZXpqcmhK?=
 =?utf-8?B?cnloMGxqU0xnN2JVUCs1ckxkYWI3V2tNTGxMdkp2ZG9md1JYc09ab3NzTHdo?=
 =?utf-8?B?T2lMSnJYOTRDeUtvVGRHVjFRcVJHVk8xN01JK3N3NlZPdTlSTWxic3REZEdw?=
 =?utf-8?B?b2U3QWI2N0ZrWWxWUk9zMm5vbHNaVTVObi9ScmVYWk9GU0EwUk1Sc1M5bFE1?=
 =?utf-8?B?WFJtTHBYN1JzcWtMTjVpVlFLR3RRZFFZdjVTRFFZL1dwbGdMcjRSTU0vSkt2?=
 =?utf-8?B?Mml2MWszTyszdVZjYld0SGlCQzZ1R1dVUWFFUW03cElPelVnMnpTb253Z2x5?=
 =?utf-8?B?RTJtWElTQ3NPbzZOdm5TSitLbFZvb3VOR0NIM090OVdDRGEyK0lzcGRKSDB2?=
 =?utf-8?B?U3NQaS9VTVhJa1pOWFFIK1dpTHhWcUhIemt4WVltR3BvTmxyRm9qNnVnS3R5?=
 =?utf-8?B?eVoxUDNCZWV3SGtSS2ZDS0o2bk5rZE1jR2d2alp1RmFVOHVISEZ3K1o2M2hL?=
 =?utf-8?B?bWVmYjkyZkxoeTBJR0daNlJEMlB3b0ROa2JBQ2VQTE93aUtTeXY2SkVJOXo1?=
 =?utf-8?B?Mk41b1oreWpqWlhZSWhQLzA5UkYxQmxmT2l0eXEyOUw3eW9pQTdZcFVCYjUz?=
 =?utf-8?B?c1g3ZXFUeGY2R3A4VGQ2OG1tVnBhTENQYVFHeldNYkpHVEFYMEh4SEx3YVlJ?=
 =?utf-8?B?ZnYrenZRa0M4OE5PdEZLSUZiN2RNZHBJUDh3b3JmTU83aTBjbmg5VzN2Q3Jw?=
 =?utf-8?B?ak9vSm9VeEFIRGZoOGVCS2gwMFdJY3lydkZOc2I4bGY3cVFKZm5hTVRXWW44?=
 =?utf-8?B?U0hoRklId0E3RHBFVlhuSzltZVR6Zkw3bHF5VVkvZzJmVHZlbnFHMU53MG8z?=
 =?utf-8?B?RVBQTGVlcERVbzNJNk5TaTRQRUEvclFBemNPT25oZVRnTmgwcVNiR09vWGtF?=
 =?utf-8?B?bWxKbzRvRUFHdzlwbC9ZeWJvdXdZUUpFTUI4bmtiR3VKNlE1NXM3QU91M3Br?=
 =?utf-8?B?bWZCbXQ3UjM3Mlk5Z2Y2OTZPQnllMkpXMW5uQXRVRlVJMVl5dVVnWXU5bStz?=
 =?utf-8?B?Yjd6WG5zMThFczhRYTZ3Z0tjRXhDYkltcnhIWDhwZEE2ZGhZR0EvVm5MZ3Vj?=
 =?utf-8?B?M3FnazNiRzNDQ1FDaGdkOHRKeTZ0b3VBa3pOTlFac3dnc1kyRlNya2htc3Vx?=
 =?utf-8?B?NjUvUlgyMHIwWUhxNGFhanRMSDlBUUNXclNzV0R2WTQraEZXVmJqUnlYUWRR?=
 =?utf-8?B?eGtZYXBHQmhJWXRIeGRPalNxRDdLaU8yWDZKa1BMMTFCVjA4VzE5aHFUNTYw?=
 =?utf-8?Q?AuwUpy5drj0oClvCPtdix8HNA1KJgSJkdHviAxgtS7EZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C804A2DC720ED5499C63A49FF82D890C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46033af1-cced-4828-4bf7-08dd8169915f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 06:47:36.6356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUF5VIdsedMqjOf7UQAdNsL3UOx/Ym2rhQnZ33LGpscq8lyFKE/EBJlCvB7XaoDGQHN2xwUzyLkbmMN63WRaGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9680
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_234741_105355_B5506771 
X-CRM114-Status: GOOD (  12.57  )
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

T24gNC8xOC8yNSAwMjowOCwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOg0KPiArc3RhdGljIHNz
aXplX3QgbnZtZXRfbnNfYmxrc2l6ZV9zaGlmdF9zdG9yZShzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0
ZW0sDQo+ICsJCWNvbnN0IGNoYXIgKnBhZ2UsIHNpemVfdCBjb3VudCkNCj4gK3sNCj4gKwlzdHJ1
Y3QgbnZtZXRfbnMgKm5zID0gdG9fbnZtZXRfbnMoaXRlbSk7DQo+ICsJdTMyIHNoaWZ0Ow0KPiAr
CWludCByZXQ7DQo+ICsNCj4gKwlyZXQgPSBrc3RydG91MzIocGFnZSwgMCwgJnNoaWZ0KTsNCj4g
KwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJbXV0ZXhfbG9jaygmbnMtPnN1
YnN5cy0+bG9jayk7DQo+ICsJaWYgKG5zLT5lbmFibGVkKSB7DQo+ICsJCXByX2VycigidGhlIG5z
OiVkIGlzIGFscmVhZHkgZW5hYmxlZC5cbiIsIG5zLT5uc2lkKTsNCj4gKwkJbXV0ZXhfdW5sb2Nr
KCZucy0+c3Vic3lzLT5sb2NrKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiArCW5z
LT5ibGtzaXplX3NoaWZ0ID0gc2hpZnQ7DQo+ICsJbXV0ZXhfdW5sb2NrKCZucy0+c3Vic3lzLT5s
b2NrKTsNCj4gKw0KPiArCXJldHVybiBjb3VudDsNCj4gK30NCg0KYmVmb3JlIHdlIG92ZXJ3cml0
ZSB0aGUgb2xkIHZhbHVlIGluIG5zLT5ibGtzaXplX3NoaWZ0IGRvbid0IHdlIG5lZWQNCnRvIG1h
a2Ugc3VyZSBuZXcgdmFsdWUgc2hpZnQgaXMgaW4gdGhlIGFjY2VwdGFibGUgcmFuZ2UgPyBpbiBj
YXNlIHZhbHVlDQppcyBub3Qgd2l0aGluIHRoZSBhY2NlcHRhYmxlIHJhbmdlIHRoZW4gd2UgbmVl
ZCB0byByZXR1cm4gLUVJTlZBTCA/DQoNCkFsc28sIGRvIHdlIG5lZWQgdG8gI2RlZmluZSBtaW4g
YW5kIG1heCB2YWx1ZXMgZm9yIHRoZSBhY2NlcHRhYmxlDQpyYW5nZT8NCg0KLWNrDQoNCg0K

