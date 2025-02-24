Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6153FC021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 22:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OJf9UzoBPgpt1aQGdQ+UX+tjf3o9sKYGvjqAbStvqaQ=; b=U26pH2rC5NdKqZoEJnT9u4pWxE
	zM3TfKgD4UXrgdm62irhVy2wMSm+cl2eXx76PAznsZd7pqKCTKZrhAUSljS3+wNRPDimAZHvjuTdC
	wbyT7UYkNCfc4+StPbvWjUJ9c2UgaleC56NcVHgQA0sp/6ST7iZwxQXSCmg2GJ8sLhZkquKoFap7o
	4x6D6oYrxHNXFQqzhLCQZ4yOOlmGAnsr1Zsvp3Aqj9GofNrCkaQdtsPU6rOIQxqB3+PRcz5a7gLqX
	ShTKaVKIGKXAY8PU4FEpb3yjhuJtE+Ty+IxO0150fsmfsxIInwdNpQQTajpp2j2fZL1vA0ygb+Jfi
	+zzRc9CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgqc-0000000FLt8-28UF;
	Mon, 24 Feb 2025 22:22:46 +0000
Received: from mail-dm6nam10on2060e.outbound.protection.outlook.com ([2a01:111:f403:2413::60e] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgpd-0000000FLmP-43Ex
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 22:21:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXsyDGoO1vdI2+UeoahBfz4TFOtgLMDjWCXo3FjE9+rcWBQZhhQ/M3Zn1npNsMRBT/oanH255HilL07JKavQxR9jei9DD4JYAV3ePE+gkYA/8kD5NjG3qRfeJa6+IttLjLdu1JtsuagyevJ+55jBRw2904gaOKVpYHgkS1yL4dWvRN+8dDntaSQ2N83gDg9m+zAY4MkbEcc5obyfb+4NJxjqrGzB6ZZ4Goj6mP01IHDxuxSSXtfObDyP69vHLIOZP1PV1WufDx9DXFv2rOYV4jg5P4q7AP/V0C98uzcQMjrnngwZ0SJPI6B3kGLlGBrTcM/tsmQsrAEZRwrABXWQNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJf9UzoBPgpt1aQGdQ+UX+tjf3o9sKYGvjqAbStvqaQ=;
 b=Udvp1Q15qvzmkSMyUIEXzH/sJm3pR8tgbUqLqCzG2Ip9aegUZ+/fUOUv28g2WDJqiQb0TldgfhL/nqALvsJslYg3f8pSM0hDYddz87dG8PoshvvuS2oR8iv4xpcCJJ6HubjjnDwtqxgALzYWooQA2couik1rWAzOg1LAZIqzcRjtCW+wi9T1ySsfzksGJlYXPptucU4vx568fIpUrg01W8rtzwHq4+EQ2DoVPOJbjjNR6kx9SlEK5XZZvDu/YAb+K2vaVs2qVbYPhMEYcOf+K21fChTUr+An4EfLrtX4sdz1Pg/GRUvM5l71PXXV41+tUQBRLnLJSQx1AjkfwvDckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJf9UzoBPgpt1aQGdQ+UX+tjf3o9sKYGvjqAbStvqaQ=;
 b=SSMB6rT2rX4AmvjX8nb1b8ltTjVJ2HXRI7v/LaI9hRlI1svwtGLQWozCulp5SCmeDLjfE7JGkVmAJs6T+4sp+nBXa49JxoE7qpj6kMWi/K0zzEPwDGcqcy1p1HuqXrTheU2zIIHutP9p2AAz9N/rDEX6PH0acO/moYMIjqwtZFyAW2q4RK7h8+seD9r2zrX7QULDsngnvI1Oe+iElXOOY1oHnXefJq1GoU3dKttHovMGs8DJY8dKpdThfdCkX21SYJiwcl6Sz1bFrIZh+sjRG4J5gj/ONgTjtx52MM35I99NFsk4Kv1TzY/8ZTR/rZ9MLj0YTtzXizCye65CaEhKcQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 22:21:39 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 22:21:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/6] nvme-ioctl: fold open_for_write into flags
Thread-Topic: [PATCH 1/6] nvme-ioctl: fold open_for_write into flags
Thread-Index: AQHbhuqCeImX0Sn1dUiGKE3BQAtIkbNXBx2A
Date: Mon, 24 Feb 2025 22:21:39 +0000
Message-ID: <499b5847-b07c-4fe6-be21-ebf4d574405b@nvidia.com>
References: <20250224182128.2042061-1-kbusch@meta.com>
 <20250224182128.2042061-2-kbusch@meta.com>
In-Reply-To: <20250224182128.2042061-2-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7607:EE_
x-ms-office365-filtering-correlation-id: d3e3d233-2dc7-42ec-a5ca-08dd55219bf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R1h5K1JiaVJyajRHY2p0T1p5aWZqeEIxb3R4UDZ2UzJVL05xWUdtaVQzejVE?=
 =?utf-8?B?ZXpTQlVTcnRwQXMvUjBtYWZlcEF4Nkl2eWdVTHBvZnlodWwyYS9aZmVqSkJY?=
 =?utf-8?B?SjV2ZTFTa21xeTNiUHdsbmEwK09lVm5Ua2dLa2Exd054UGtqM09ib0VOSEhM?=
 =?utf-8?B?LzkxbkVGMUVpeHR4ak9QSnpNN1lPb3o2OWFhQlU1RUlPYnhSOUhWMFc5Skgv?=
 =?utf-8?B?ZDJkSlA2RVJHZTY5MFUvVEtkbnYrNXVtclhSVFNMYUZYVlNqbUlwbVV0RVZu?=
 =?utf-8?B?STlPTEI1Q3dNcENYcmJYSURRYkNuTnV0WTBxZmo3dzJhQzI5elkwOVM5MU51?=
 =?utf-8?B?QmNHeEVmQ0FSUXZMei9CU2V2Uk9VRENPZDh3c3p6K1VVSG9ibEcxck1UaGFz?=
 =?utf-8?B?NjFnb0N5YXBNVWV6V05vOUxnWG5lS0RzOG9SVE5NRUJMcVJIcDlONjVJM2lV?=
 =?utf-8?B?ZlliZHlGc3Z2VlJUcmx2TXIrZlpNNytWZHd5bE9lOC83bDgrd09SUFQ4bEdh?=
 =?utf-8?B?K2hqWUN2cG96TjJmL0p6WWo0anhHUlRVZ1VGUFJtL0FLRUFPUjlZZnhvZlpX?=
 =?utf-8?B?WGJySWNkOEVyL0dBZVUxYzc2bEZ5QXhyVURWam9KSUs5YldTcmEzOWZJL211?=
 =?utf-8?B?Z2k3djZTeHFZb0d0SzVOckFjNml2WmtCaTFVSUw1QnhDM2Rhcmo5UWdzaitm?=
 =?utf-8?B?R3MrZVNQQ09JeDhzMEVGejdhbXlMckZGb0tqd0hYeTNHSHZYQ0dsS3ZxOWx5?=
 =?utf-8?B?dlQ0eTBoVnlZc3Z6Q3FoQ2ZkTnd2OUpiUWIwTFRLS0g2Z2dUTjFEUlpyeGVi?=
 =?utf-8?B?U3liVWJlQXJkamhQOVE4Uk9xcUJGS2Z2dUtLaWppUWFWbXhIbGdaYU43TUdV?=
 =?utf-8?B?enpxUTR5dHRERVlEUmowQTBDQklVeUdKd3VvQW5tbGlsVzdUMFVSMHBjdGd1?=
 =?utf-8?B?SEk1dzc4VVJGWjdUYnkzditWa1Y2ZGhHZHV3MEhOKzFlR05GRXpyeUlnam1P?=
 =?utf-8?B?Tm1xdUpOU2trTDJ5aU1zTGw3VjdOU0Q4bzZWN1REZ1NQNHBvdy9zT3ExUWw2?=
 =?utf-8?B?aWlqTW1iOTkxUHROTnFNellzY0VodGN0UlVIb1JLYXpsZkZQeXo3NktQbTR3?=
 =?utf-8?B?NFlDbUcra2ZneWV2TUxoUzdaeEV2MFhseTllSEgrVVdINDk5TXhjVExCNkw2?=
 =?utf-8?B?aG9VRVJ2S1JEQlM4SU1kYmxUOUc1M1V4d01RYUZUbHNjOEZNbjFxaEJiUVZ1?=
 =?utf-8?B?dzkySDhZRnQ1ZE1tWFpnWnRjR01wQUdLa2dxMnZlWTV2SEhCaWVCN3FuYUYw?=
 =?utf-8?B?NjdBQjZMaDR2cGhRQ2RWaVMxQ045V1dXRjB3aENwSHAyU2I3djJ6d3ViS0FB?=
 =?utf-8?B?cy8vSkd1N0ZMNHArQ3orZmNxNEs0N0Q3akYxdDVpL2VNeSs3OERZL1VtQlJ3?=
 =?utf-8?B?SXNqQzFnbERtRkFCQjZ0elVndVFWam5kM0NFQmpOM1JQYmNDVnBrUWhUY2gy?=
 =?utf-8?B?R0tkYmljSDBKcTFaVDYrTnNDWW5KZm9pYVNnR0xVSlQ2YzR1c3BZYXl5NkJz?=
 =?utf-8?B?bGN4VFpraDBuNjJ3YW90YkRwbDJWa2NlRm8xNzhZVEJ4RVRmVmROUWRzNU0v?=
 =?utf-8?B?UDY3cWlDMzdqbjhFR1lPSmx3V2QvbjhTRnlUQW9aZXluL2JhNngrbzRtajRx?=
 =?utf-8?B?d1UyTG1MOW5yQ1pTZVo3OGFHZEszOURKVUo3SzZHajZLRG95L1NCR25pZlFL?=
 =?utf-8?B?UEVYaXJPbUJvRUx3WG9yVEk2Q0hVdEhGUmNFRFg3Zk9DSDQ3TU1lOW5SOFJ1?=
 =?utf-8?B?MmFEdm9xQWUzcGs3cGFSYXBiWDdtUjlnMU95cUdzREhxR3FRbUxxRE9MNy9u?=
 =?utf-8?B?NXNWcFFweUQrY1ZubnltVGtudWZwZzFoaWZRU3NGN3JXTU0vSyt0N1hFMGhK?=
 =?utf-8?Q?C3aDA/fbKLaEk1a7guoTpR6hB/HlPESP?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnVEdjUwSllMUC93WEtObklIWHNMUHpuZENoN0hCNjFKbzd0MVBLUVR2aXVP?=
 =?utf-8?B?Y3NJaEtjWk5JaC90WW14YkdQd3VHSGZOWnNIQm12NHpVaXM3YzdMVG9mUU1h?=
 =?utf-8?B?MFRrYVRET2Q0TjJacGxBOW5BcU5FWHhDc002UVBpQmZ5Z3JGQzd2QmdCS0F0?=
 =?utf-8?B?eGdLSHZIVHhYQ0dENmJSMVA3ZExZNjMrZlJLUjB4T0YrT3VmR1JUdzllMnNl?=
 =?utf-8?B?UzF6QXlUVG1tRFQxWk43Q3BxNmtUNDdZbTY5TmgwZkdoSkp5SHBCa1JXeTFU?=
 =?utf-8?B?YmwzcnpnNDNabnF1WmlvcVVMK0laVDAwcVRhaUxQRVpvWHI3amd6cWtXamtU?=
 =?utf-8?B?UXpidittOVZCbzFRTWt2U0Q1Qyt0OG1acFFNTEZTb0VSQ1RiTmx1U3loZmJO?=
 =?utf-8?B?TVJ2T2NxSk9tL2pkc3dES2trZEMrMFN1N1dGVjd3ZGFKbG5yMmJUb2YxbmZJ?=
 =?utf-8?B?cDZJbG05c3B3TW5reVA0QTJwUzMzY3JKK0FwTGZEeVV6OU8zdXQ1WjBrMURv?=
 =?utf-8?B?RDBKWVEycjVNbzJJSnY2aVRCOWMzY05SNXp3VTEyOGpGYzFpa01iVHorWHF5?=
 =?utf-8?B?aDRiMW5HSnQvUlk4MnMvRkk1OU9PSkFwd2xxU01UOTY1dmoxbUV6cVVtVDh2?=
 =?utf-8?B?TGEvUmZUdFVzKzJnQ1hrcTVFUnlwN1Rqc1RsbTVaOFFYSEFYeW9Ha3RDVWY0?=
 =?utf-8?B?OFVVczJzbzUrTUpWTHBiTitQbDU0Z1RxaElMcEpJaHpid0wreWgwbEh2UDRV?=
 =?utf-8?B?cnlMdVVyK2l1a2NMTk1GNVM2dGNpU3dOTWFjMzhpQ0kwNXo2b1pQWmJOZXJL?=
 =?utf-8?B?T0NVSVRtSDlwM2Zxb2l3Q0ZJK1kwd0hzV3kxVGQxZFJBWVEzM0wwNGlRY0Iy?=
 =?utf-8?B?WlB0em42eXQzb0xDa041SlJqQi9iMUg2Ym5KaGR2MFpvM3Z5MENhNHdRWXZT?=
 =?utf-8?B?eEhGQ3hVQXFna1ZlNkN2Ly9NMFVYYnJqS0pSeEN5SG1qUnBVQkRmUUZzdXl1?=
 =?utf-8?B?K3pneXMyeHBJOTlrSllJRkJyc0NqUml2L0szQjZVZXMySGYwcE5vR0hCM3Q4?=
 =?utf-8?B?WUozeUdxelRJd0xidzQxTmRqcm5wUXI5Y2lyRVJoYzh4TXJDVk1UYTlobFNK?=
 =?utf-8?B?SGh3QnBNVUlmK0xYR29QYXo4aU44TGRSRFlvUXFYNEZxQUdhNXZDOTVXNFBZ?=
 =?utf-8?B?bWQzYkN1eHZkT2daS0NrQnZzRDRheTYxaUIrL0tPNFRtVHp2UkhLOTdzVGpx?=
 =?utf-8?B?T3E4THQwOCtTNW5jSitPb3lRb2NpWlQwL0ZGeEI1VFAybWJSeUdpNTZIaW9C?=
 =?utf-8?B?RkRMSVF1T3hQakZaTnYzR2NRZXdhVFE1V3VzaEtrREpqWGxYc2JITVhTVUZz?=
 =?utf-8?B?TCtSNVlqMEl2TVN2QWo1eU9jemg3S2RDUnBNYXpvTWtHUno4Z3E1a0wrRDhR?=
 =?utf-8?B?emw1OVBTazhSMEFldE9VR1J4a2tLZStqUjZJUFYvS1BQOEg4ODlrYWVXRStw?=
 =?utf-8?B?VzUxcUdXMThUeFFTMmhVS2htTEpyaHk5ZGdMZTdOclZacjQ1U1ErRXYvT3pG?=
 =?utf-8?B?RVlrSUFuekRaSEkvaER0RDlDM3VoVjhYYmVWNjMvMUhBeC93MkI3Vk9CRnBp?=
 =?utf-8?B?UFlyV1JJc0FGNzhub2k1M2FoY05uWHZrZkpDa0dmTWZ0amJmdzN3aEM3ckF2?=
 =?utf-8?B?RGdPMytNTWhQbk9uUzVVQUVUdjZna0FoOGw5bzdhZi9qVE51VTJ2OXk5d1Rn?=
 =?utf-8?B?VXA4dERXVDRBbE5yemVUWDcrY25DMjJ2cHlvYzg1MWhHTG5ZYnZZRUdkSjhB?=
 =?utf-8?B?ck5mZ1haSEZMOWdha0FGNUxPVnBVWHZOUkh3Qmk4bWgvZGVWUy9rcm5OZU02?=
 =?utf-8?B?R0JlZEtYVlNqbitDME5aVVpjVHZCVjR3ZXpMMFFDa2wxZDdLSHFXVXUzN2FS?=
 =?utf-8?B?VU5QekxxQ2F2eUFvdW1hNnBuc2NuM1VlRFZ0TVdlTktQN0NyMlV3dXZVb3lC?=
 =?utf-8?B?dVV2QSthc2wxUThVQWozMnJhSi9uR2VZU2pzRUhJbGRaS2tGYW4rUlF2dVhu?=
 =?utf-8?B?RFU5Yzc1QncxVStUOWRkc1YrVTAza25ROVdQL2ppTTRhQlZGSklBdktwRndD?=
 =?utf-8?Q?W4SMBhpOjLuBSzcdkyoCIz0QA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FF648FAAAEC07428FA4441E384EF88F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e3d233-2dc7-42ec-a5ca-08dd55219bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 22:21:39.5206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Xbb0Z02Mq3wS2CtHg+Icrp40P9iktBeWh06kjRTQBMvL3M2cWcFXLNCOeTlA9THmWcVSLosfUF+LCKk3Z1peA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_142146_008628_0C574623 
X-CRM114-Status: UNSURE (   7.39  )
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

T24gMi8yNC8yNSAxMDoyMSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBIZWxwcyB0byByZWR1Y2UgdGhlIG51bWJlciBvZiBw
YXJhbWV0ZXJzIHBhc3NlZCBhcm91bmQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFp
dGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

