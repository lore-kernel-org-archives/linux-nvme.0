Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D44D6B6BB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 18:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0GwxfX4xhsfov/4tgIUmZ+MOByNEyN2eSOBlhW28ii0=; b=XBOmAAWcLRQKodsTrmHIUx+FKa
	hsEP1bCPwFc1xpAAu7uzTkDwL6ZdqVsE0DHx483U0ZnUF2VQoOWD5toK38NZSCyUna5WvkoZOzm3d
	GN1bFpqnxBoP6q7THrb4mvzCAiMsp5+bWWyvuVMYutYByr2sBvACqwLlUOTHxnPqegFQgctWIpO3V
	vhlH3ZibVREbHge7NIOKxiML1Yyw7kACtuzob+ZHMbHvqHu5waibsHxgVXUg5BaPg7Ra3S3lhoVgr
	tKCCXVWQIrn0u9bq01yM9h9tpk/eDQJ4sKPmREpqlknvdrb0t1OaOHTx1aiSSzQqeF+DRsveIm14C
	AQ7iF/Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6DWq-00000001RXE-3DG6;
	Wed, 30 Oct 2024 18:34:48 +0000
Received: from mail-dm6nam10on20630.outbound.protection.outlook.com ([2a01:111:f403:2413::630] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6DWa-00000001RSn-04BL
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 18:34:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qsjweu3u3H7glZ/HLAto/+rJwdNUrkolepojQTpPBGKRmJFOKi9Jjh+qeQQJMmC/uwcUXH8R/KoPZDARTjrLSGMzjY3HjdmJ0UQQhnBB5Ydowan4OVTN4V6dzgJLu4IuW19aPpq3IgnjvnCqI8VQH5HfVHaWDzCaxc8Ng2grZzrL2a8CH3AL5kn72Yhblw5aiXNSc99c6+vCid9Lv8ZggTtnlPaQhrOhUSsSI+L/0uuBznook+5GBm/3m0H4/C2JMGrjxN3BlOxqI2b3hX3XWrS9hzQpnK4NekiKqj1ztp7VOpVWJOA8T3X5GpjwPxknzsj7njUzm6AXEFNFE4WE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GwxfX4xhsfov/4tgIUmZ+MOByNEyN2eSOBlhW28ii0=;
 b=yauODbxVsDzo8aoqIVk9JAoNCCevTieqH9E5QN2tP4v18M0e2c4JXduUB3B4m1RMEe1Wa2SnmPYANwxhY9NJI8PuYvoXJHB3aBMD89H6HeYSwKCtS1YpWeKUTSsdgv2hTBvYZNz9ORvuKLAG5ezVYHBLcjRrI/zVjx+jRxaW5PK9TIF9cF1IV/J3xy7cXaUlgSV8Q96tGZfuSB76g3fH27iRZO848cDMR2+3/KI+p83dXpWvw7pBNdEeOxQa3m21Xi4kxAukoqp9zNsOnqiw2Ofu+CUAprsr9ZHyB1MiQMcTPai1rs0qG3x3rwEpWXz9i/MNXRsXrvyCfS6u+Qpt3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GwxfX4xhsfov/4tgIUmZ+MOByNEyN2eSOBlhW28ii0=;
 b=YSNC+3LkBBtJ8RvwFLwfAkeyWMJaRijPwTYnI4SrAmqc2zZ1VmrDrUz46BE0c7dYtv0Q0K8oRIOB4g52mXXoXqgwfjK5pud7fQGUlDBT+U07syWVFEXroBLK2QsxzBuOS93BxnYA1uVouZvbYZmrMgOGRWtZb9DPNFCefL2aNFmDNYOuRw6CM0ZeJAzBU48CbsdmzSiImWUsBlvpAVpkmpMrd0sPSnvPQDMC2j1ecFI+Fvs9m+o1fBB2dBluMhBQmWMGJqtwsbdJIZpTVUYmCAYoUMgJ07wVFvGvyQtRLKUX1lX0pyUrAnsLuNmtNIzJkZqd+42+jyC8neicwwMwjQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 18:34:26 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 18:34:26 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-core: remove repeated wq flags
Thread-Topic: [PATCH] nvme-core: remove repeated wq flags
Thread-Index: AQHbKpevYxOHQYsA90qOLutxzj4F5rKfUN4AgABOo4A=
Date: Wed, 30 Oct 2024 18:34:26 +0000
Message-ID: <908a8ed0-75e8-41c9-81ac-53140eda8aee@nvidia.com>
References: <20241030064737.95291-1-kch@nvidia.com>
 <20241030135258.GA28325@lst.de>
In-Reply-To: <20241030135258.GA28325@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA0PR12MB8907:EE_
x-ms-office365-filtering-correlation-id: 172a3af9-a047-49db-da61-08dcf9117b8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q2k5aUlweW1XUnNFbHRhK1NkM1h5Qk1TTFZsREVFMnFSMHJQdHAwKzVjemhk?=
 =?utf-8?B?WnMzN2xEOXZPbnNCa1JKSFg3UGgwOVF6VEl1REtHcmcvZ0xXYUl6NVRFZlRp?=
 =?utf-8?B?MFE3Z1U0MXQ5S2FMM3JzSGFrMzZBMjN6MVNIMW91RjJWcEVjd0c0ck0rRGV1?=
 =?utf-8?B?bnlaZlNRODVIaWdzRW8wREs5dTl6d1FZNjlmVzZscmhLVTBNdWZKWi9sRGd6?=
 =?utf-8?B?L3d0SlBubjBEYW02OHpIczcwWUt0MS9oUjdabGt2R0E4aDQvRllwRmNXak82?=
 =?utf-8?B?bk5vNU96Yjl2OXVxSm8veVBZY2JJWkg2ckcrdDJBSjhiZm1VZjQxS2IyQXJX?=
 =?utf-8?B?c0FIQm4rTW1TeldJOTZFUzNjQ1ZEeitIMzk1aHozNjVPZzllMEtVMld1dW5W?=
 =?utf-8?B?cnBWMWVzU05nc2JXODRxUDZ2aTFBRkJpcndMQVZIOEs4clRvM1o0ZC9oNk83?=
 =?utf-8?B?d3pjOWh0VTFHSTBYZ2RCWTZFRFZvSzNmY1ZWUXJkOTBIZnh3Ui93VC9WcXBC?=
 =?utf-8?B?Q2kzdms2WS9Ddk5rclZjSFZSdGpyZzFmeFdqbnViNGd1YmpRZ1MweDd4dk1p?=
 =?utf-8?B?RjFnWHFCUGpTVTlnRTdxRmNlK2NVZnJYVDBKZmxKQldjSy9xTERXT3hLbTF1?=
 =?utf-8?B?blZMZ3NjUlZzc1NUaS9oSjR1Wm9wVGRKZGoxT00wZzZQMHF1a0s0K0hCSjgw?=
 =?utf-8?B?bDR1MEhEOUtIRjdEcXZaZCtoVzhRODN3UW5CWXl4bVJxbjgxK1ZGQkFTYm1u?=
 =?utf-8?B?R0NiaFN2VWVtRE1HUXpFc0p5NzdhZmhJYmlzcGc0Y1c0ZllBOS8xdmZXLzhE?=
 =?utf-8?B?T2JqMFQyMEo3M0c1MCtjeTVSQVF6NUQvd3JWdk50KzBsRlZRUDNZUDlmdVlV?=
 =?utf-8?B?K1pFbXN2cHh1OGo4SXBBREdFZzhpSlIzZ3RtTWhCOW9pa1pKS1JRdkRIVnRE?=
 =?utf-8?B?MWlrUXRvcjM5Mk8vdEtmU3M0bjAyUkNzemRYMGRYZGMxSEdhWTIrc1l0YjVK?=
 =?utf-8?B?aTNiZFdYQXZPSGxUV3B3VEFscktJTG41V3hiYnR1Rk5pWnJWQ1dFSWowVTdF?=
 =?utf-8?B?Q0FxWXBNZHRsb1QxL2FzSFg1NUhJSUtxVnpHV0dORU1YclNMbWJ6amIycXFs?=
 =?utf-8?B?R3MwUHE2cm9KZE1BVmg1UUFKUnhTMDhESzBLRG8vdXhjOXRITGpsMTFSZStZ?=
 =?utf-8?B?Uk5PNjkremRMU3RGbmNqbTRtSlpFNzN4cUp6YnQvUTV5WmdhbDJvU0hjamVk?=
 =?utf-8?B?OWNrVVhZbTJrTlVhK3FDMVFwczZZTHNSL3BKVGVES1JrV0FZNXlZTGpNRm5W?=
 =?utf-8?B?NEE0RXh5SVBHTmJwQVprK1UraDFPUmd4NlV1dWd4ekNIK2x6Ym9LN2Y3bzVM?=
 =?utf-8?B?YnBsenBDMlMrUHRLK1dYMDg2enBqbmIrNjdKOVdhdkZhL254ZUNENUdUQkNl?=
 =?utf-8?B?aU9lTWw3ckpWTWYxU3F3RUhRWnhoV1g4L3R2Q3ZZRXBzUXhBbk44bEpUUDF0?=
 =?utf-8?B?N2ZMZkFFRUF1T0ZyYldNbnN5OXRKNkdtOUZxL2UxSXRlN3JlTDBrVkxuNU9Z?=
 =?utf-8?B?UUN3dW92NE5VdFVVLzljY1NVZ1ZLTi9BVnFqNjZRQVc1WEVWVVdXSnc5dXY5?=
 =?utf-8?B?UlF4UnNWZEQ5UHc0WFM2ZWpnUlUrdm9ZOUR3cWNzcEJUWkpzUG5CemxLYTVG?=
 =?utf-8?B?bmJLd1JuSmtkbWs0MnZCcDZLUGlsRktRSzB0RTMwY3dnaVo2L0JhU255aXpt?=
 =?utf-8?B?am40OFFvenNkcEI2YkVERTAwZHZEdHU4YlA2T1o0VFZBZGhSSlN3a2dwbW5s?=
 =?utf-8?Q?CQh4j35gY+dgptb/FVVVVq0YKwo1zmYqlMAAA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDFKS1oxa3RoSlV1eVp3ZzlxeU1qaEd0RzJGd0owQ0xLNGlLMHMvekt5V2JL?=
 =?utf-8?B?ZHZzVHZBeVJ5dFloOWI2MnFoN29RMFZObHlvVmNwbFVQS2pZV05oVTB2V3hh?=
 =?utf-8?B?eEpZeVpCditZekZGcG00YVo5L0wzMzBrK29ROUtYbG44K2lCVkVZbEttcmUr?=
 =?utf-8?B?WHZEdnFNOFRTaFpML1ZkL2FkUUxvZWZsYzNSY3lNL09rK1g0STNVcEkzaHM5?=
 =?utf-8?B?czd6VzVzWURjaDVlbmRVL0ltRTRCODlrWEU4ME9kTTRCa1dWSS8xTU5taHN1?=
 =?utf-8?B?SkFJeDYxTVJNbXBZenJCWjZjVGpjaDkzbVVNZDZPNnlJaTB3V2xPbGtvQmhj?=
 =?utf-8?B?bFNhaFFFQkJJWEU2amd6UitWc21hQm5kb25qcnl1VStWYkt3TkJ4VFllYWRt?=
 =?utf-8?B?VDZHcjIvMnBWcllKeU5PWHVScXdrMWxzS09hOGs2YW5Zc0x3TElINjBPV2lP?=
 =?utf-8?B?N0Q4TlBjTVV5VHl0SW1MQ3N5VjBwYmh6dUJnSWU1UUVyRnllbHdpMTIwQU5l?=
 =?utf-8?B?WUZpZEJIc0Q4WnZUV0pOTnlpaWUyUk45VldORkR6WUZEQS8vWlpTUG14Q0R3?=
 =?utf-8?B?SUNFSzBsL0xhWnFCMzQ2OVR1OGFNWC9FRUxoai90UlFEcHc2bW9QbnhsS1gx?=
 =?utf-8?B?NkFpTk93cXZaTW45RDdSR2pXVHNydXh4TEZKVWdzN3ArdXh1MktUcHhWcnlX?=
 =?utf-8?B?djFIUm9wYTQwR3hXYzltdkFENEQ1WVNvYUt3MGFqOUZxUnJOWnZLSzl1akJX?=
 =?utf-8?B?QjZUZWJHWTNGcWd1L3VobXcrUmVTamVaa2k1TkF1Q1RSekdyazVJc3BIMGo3?=
 =?utf-8?B?UUNlSFFnUHFiYzJNVkZnWmRCR1ZHSy9JTzgxQUc0cTBIOGx3TkdXZ3F0SkJY?=
 =?utf-8?B?K2pMVWdlY2RZZU04U0hmTXNuQzV2bWlmUDAvOHJycTdIUlp4QXoxZWFuMW1j?=
 =?utf-8?B?S3pWY2s5UDVqa2dTRE9XQzZZbGlZdkxUKzdoSjFtTjU4QnovUHRUQkJ1bzVk?=
 =?utf-8?B?QnRBSXdqQkxlTktTWnd5dVRMZnJJeHNVMWtJTHJaWnkzZ1BFQzZsZXRKVTVL?=
 =?utf-8?B?Q1ByM2NuL1ZMNFlJQjkyNnBOTkV6aUliVStSaEQrWTRTL0JzdmFUREE5Q3pa?=
 =?utf-8?B?aHF1K0luKzhNK2dONFRDSFoxTXlNbVVMZERRcENKcHBDZDViWnlhWjd6TTIw?=
 =?utf-8?B?UmVxbFZKQUZVVDVBR05pT3NZbm1EV1loVTBXR1ZJRVU0akJSVU1ORllmOVhL?=
 =?utf-8?B?UERTeHJmVlFTS0gzS3lnNWFySW1FQkZNcVJwNGd4K25hY1laenN2akdwajcr?=
 =?utf-8?B?elB2VDJ1UkprRS8wRW42bnVpaURtYjZPTE4ydUltM1V4N3ozY3RrOUhNK0gw?=
 =?utf-8?B?Sjh5NmVROWtwaWN2bW44UnhzQ0RNNDNoc3FBN0crMTAwNUhvb0lLS2orb29S?=
 =?utf-8?B?cWo0L0QyQUxHWUNKNkV1RFJ3Yjl0N2JIYisrSzg1aEFPVGNVWGtiY0NTUzc3?=
 =?utf-8?B?NWZvaXh1Y2k0eDFacnV2K0RLNDdlNVZ3azQzZnhSN3JPMmVxOHE4UHgyUkM1?=
 =?utf-8?B?LzRsaGpIakg0MVJObjhwVXhoSmI2S0xlR1dteVZWaWVwcWd2QmNFbFBPWjBU?=
 =?utf-8?B?QmNLSXdYQVZDbmszTnFWU1FaYTJOUXFOQkdSVkxiSUJyV1MvcnpPL2FSeUZJ?=
 =?utf-8?B?dkcxQkZZMnlhR0pmV05nNzBxWUt1a2FrSkdRRUliejEvQzJiR2c3Ky9vd3Vo?=
 =?utf-8?B?NkJmdTBYcStyRDVPbHVJandjcWxlelhwQUZJTTF1K29hMUtMWFBJekY4N0xE?=
 =?utf-8?B?NWVmWFFQNldaWDBKWk5VSlpLQi9TYkcrUlJUeDBHNmp0RC83SEhHVitva1Ro?=
 =?utf-8?B?bm9TZ0VKOUVMMWszUzFJRy92ckg5dW92UDVCS0FGTHg2cnRWQ0F3Y2NkQlow?=
 =?utf-8?B?a0l3UC96M2VubEhMWVJabUx3aFhJVEZSRmNwdFNtK1E3ZzdNVGZ6WnpteDg1?=
 =?utf-8?B?L2grNlZjYWxQSkVaZ2FoVXZQMU1hSWtmeGdNVHFFVkszdjloSGh5WW1lM0lw?=
 =?utf-8?B?NGVaMHJKSmlyc05IMmtXU0VUcWtMT3paZmIra3JncnpVMk10UGJQZWFiamRn?=
 =?utf-8?Q?yW3yqel175uDpThDryLzfBi6+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BB14283C4F9684D94B6AE7838CC273F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172a3af9-a047-49db-da61-08dcf9117b8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 18:34:26.2091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50jWyINhrg6iZE9behq12dObNiEaEGMbmaVp9xO6icZMn68xdVSkLGSrGysZGRp9vFbmJUHJSJVU6VMDFK6qlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_113432_076629_35A5A842 
X-CRM114-Status: UNSURE (   8.28  )
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

T24gMTAvMzAvMjQgMDY6NTIsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBMb29rcyBmaW5l
LCBsZXQncyBob3BlIHRoZSBmbGFncyBhY3R1YWxseSBzdGF5IHRoZSBzYW1lIGluIHRoZSBsb25n
IHJ1biA6KQ0KPg0KDQpZZWFoLCBpdCB3aWxsIGJlIG5pY2UgdG8gZ2V0IHJiIHRhZyAuLi4NCg0K
LWNrDQoNCg0K

