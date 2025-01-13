Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E58C02180
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 20:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UJT+rTYj6g2MknPO0ZzuHRFaaAWsC3Iy/VR+kzM/nko=; b=YRIz/Hi48P49gcufiKaXrF6LHQ
	wKbX8xDL0np/uF+lPZWSzwZgofO4bETcCp+aQO6SHYVP5earud54bDnccVLbLSlaS8+TgxEZDRnmS
	6icE3MSpr642zeZ3uG4YoBjtRhNqTMx0GGtbl06E592prdFP0uBCOV5q0LlNk8D9r+HZ8AzfT1b2w
	WXSo7mcZnQ4i4tYtch04JfV1C6Qmt95VOZjZm+YP8uVFelkSWSMI8TC5etg9TPuClVboiXnkFABlp
	fGMeFoearrNDnZsHVR0qMeL7tIHvGRpunxRGF06MjLKCnwjUcFpZpnoNUSsiuRMtYYwkqzivRmi2a
	ocFGZjtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXQoI-00000006Wiq-0zSP;
	Mon, 13 Jan 2025 20:13:18 +0000
Received: from mail-dm3nam02on2062a.outbound.protection.outlook.com ([2a01:111:f403:2405::62a] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXQdO-00000006UkT-3WxZ
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 20:02:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCc1eiEeGf4sFw9M9WF4HzRDEmVFHUJ0+vTM5WNi5KjQxZZg7tDp/fcX35VmzIu/t81rbaFeTGSwtVE/0p3VVU2ybcfJTwFYjpkENbeBh2b2bVLcQWWh4ogEy3vthWYlIM/xXGfX1ICZ/y/Rd8B9FsbOfvCe8x4tajP8pFRRp6wdmJh5ySrN7VJfB4BXiYaYLc2l6tleLPIm2etRewMgCFegFrUS55M2HbBOEmw4dGlA9LyzUlvKnuxqr8kXCGQkEMGmk+6LGPHpz/HUvNYgLuK/pmkX969mtn5uvtNOXVqg0wnbJ/6O+BPEo7r0rFc53vcimEl88AVu8cahJ8VVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJT+rTYj6g2MknPO0ZzuHRFaaAWsC3Iy/VR+kzM/nko=;
 b=Ez/KCxyAsQ0B7GPJTromncPs2Dr0mQnHtentVJkusnYPGnaD1FLaJWdV9h/P7y+Etr8pXVDk6S9FlAcaMALtCya+8wb8xMIp9jWI038E5LcsULCPP1XbYaV0nAcnH0sd9a4NCFXxzDUldHKBnQxLLz7ywIoPi0cVhTRsaoHL41Ifw6XWFwteTrE1Hrf+EANm1Fu+ry+khZVYXI+MK0UGtsVhMst7nAYD51QrXzJnYKjG+R/rtTJC2Mw7kwnWH0Zh+9WaVTs3m+SdhBkeRPmSXYyS4zOOxnpdKCDHxFQxJp+2CJhH1sq1r3B1ksmriWCbukjiGpsuLkX8JlEmBOs8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJT+rTYj6g2MknPO0ZzuHRFaaAWsC3Iy/VR+kzM/nko=;
 b=tGF5MrtH9iaenRErLH/3UxEoQbwxI5Z3xVquzgotWCc9H81KQIolJhobl4XvEGjUW5dKIRI7bT5m8/6JUzJc/W8j+idnvkfJwlcjPJsLBuvXj+l54EhEh8veCS/o7QcDw1NVs8Q0H5qlX5kvZtd4fyYZIBhMlyBrL5MgjfNuEzNg9YJ7/S4DAn8V99BRoFjGwvhMH69TRux9S9MGBz2XiEsuTSdtdbMyBXhA2QoPOBypgm4PlU4JGT8GShkIBvDnHm30gcIZ6MljKcqEh9ZFUHGAZTDNADD1yfsHJb8HV3/hZrY+g0Vn82+sBC9eveUHpzjRgmSo/bQOtJCxjQsv6w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 20:01:56 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 20:01:56 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, "keisuke.nishimura@inria.fr"
	<keisuke.nishimura@inria.fr>
Subject: Re: [PATCH] nvme: fix bogus kzalloc() return check in
 nvme_init_effects_log()
Thread-Topic: [PATCH] nvme: fix bogus kzalloc() return check in
 nvme_init_effects_log()
Thread-Index: AQHbZeDeVPJ9PdtisEqzh1oBsUZJfbMVIDwA
Date: Mon, 13 Jan 2025 20:01:56 +0000
Message-ID: <02a7e9a7-230f-4645-9a4b-86f34c5a42d5@nvidia.com>
References: <9516d209-712a-4a48-9dda-b270e80e3abb@kernel.dk>
In-Reply-To: <9516d209-712a-4a48-9dda-b270e80e3abb@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7129:EE_
x-ms-office365-filtering-correlation-id: 3fe71d1d-b2f2-4037-95df-08dd340d2227
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WldOMHFzbEhCNVFtemkvcjhCT2hUeEJQdkVOZ29udy83V0dBbENTZ2NrUkVv?=
 =?utf-8?B?Y1ltMUx0ODYyVG9ETnFnMzlSOWVrbWltWjNQUUU5aE5OSWZxei9UNkgrU0pm?=
 =?utf-8?B?ME5KcVppR2Fja0FBMStwWTk4TWFBNjVQTkNFZnFsa2ZpczRvQ1JzdTRKOWdn?=
 =?utf-8?B?SGRLQndSaXpZdjlGeHRCZlhOSG04VVJ0TDlhckJ2cmVkMDYvRTR6NGVVYWF4?=
 =?utf-8?B?U05mQUpId1g4S0VPSVNEVGdvSGtOVVJnVFl5K09DUzdab0NacmhkKzZQdW5i?=
 =?utf-8?B?SldCTGtHWU4yNFBiNDZPK3hxMGV4QUwzSXdEZ3dwQkRvaFdmVlFYSDZYbE5J?=
 =?utf-8?B?a2k2TDlndDBuWlVCNFlDMlRQdXlLOGEzVHE5eDh1NVRUcTVjVk9SWVNkM3lz?=
 =?utf-8?B?Nm84UG9vS2cvYThsMjhuQnplcjFWWVlETGtQTXR4T3FZOXpCS2lUcmg1ajMx?=
 =?utf-8?B?Z202NWpBUHFXelhjclR4TE9zOG1iZWZzOW8rME1iYkQwc1JvU2Y2SVppRE1S?=
 =?utf-8?B?K2c2VTZjamRpWWc2ZEZRZUxxcDRkKzBTbUFQbUNNSDVLVWw3K0xHdXgxYXdZ?=
 =?utf-8?B?dExJZUVHSUJHdHdIdy9abzRBblQ3RGNld0FqdnlpMEhUbUE2dlcrMUR6QzFx?=
 =?utf-8?B?M084Mm9JcW5SWW82TzZTVkgvb1FHSTY4RFZEM2g0RlpIZkhyTThWUW84bFpH?=
 =?utf-8?B?eW55b0xXRWZzOS9kL2Q2Y2pJd3hDd01XVDd2djhBM3RVMUZyQWxNRUpHK04x?=
 =?utf-8?B?UUpodmdNcTZFQU9oVWpFRkhNU2xrcjJFdnNhSUZpUU04ZHN4cmM5S1Q2ZHR0?=
 =?utf-8?B?dlBLSXlYaDlabkl0aVQydUc4TlpVWEFuN1MxYUNSbWMyL0M3dTNUM3lFRDVz?=
 =?utf-8?B?b0cwRWhYZkYvVlVpMTdWRUNyMWwrTmZEUG5Jb3UwUW9UTVRvYjNScTM4TVNT?=
 =?utf-8?B?UDF5R01YMG9IOFJDVU1kMStnczFKRVpyaklPdEJUcWpnNXJsT0ZMRFZhN1Rk?=
 =?utf-8?B?T1oxdmFJdVRTZ1dXUExWSTRTSFBGY0tLWllWc0JIeHNwa1lHQXoyL0RMbGR4?=
 =?utf-8?B?bzlmSDdaaXdWQWljTTBuUU9FaEwyTVV1T1ZWckZsaUFkeWkvT1NJeWIwTXl0?=
 =?utf-8?B?SHhvb1BPczJyT3lvVFR4R3B5dkxuWTNiMS9XSTZSaEdZOWIyNStpZGFJTjgr?=
 =?utf-8?B?bUN2RkRabldDUWw1SW4wRmt0b2FXVmRiVis1ajhBTmVRWVI2OXN5Z0tLQ0Iy?=
 =?utf-8?B?Z2M0WlBJTWtCbWhaV1NEQ25jdGxoVGZXY1p6cEpObG5TR3pWZG9zUWFzR01s?=
 =?utf-8?B?a0MwQ2dpU1pGM2hid2k3VXcvMDRoT2g1TkllZFU2dkQvQmUrZHdSaitKaTRk?=
 =?utf-8?B?SlNrNVplZHpyS1A3YVZ5dVZtYjA1eGorTENPSzR3aDZ0M3BuL0JzUkttY0tP?=
 =?utf-8?B?M0JBOFh3R3BmdnlBam9hSXlwMXhSMjB1a09mRkZtZHdiZEJ1WWkrVEpRSXFL?=
 =?utf-8?B?OHZkSHpGRUM4YjVmTmErYkdteDhpcDk0d1l6SkJwc0dTbGxMWnNObDZjb1g2?=
 =?utf-8?B?RmErRnFuNU8wSi91aE1GTFQvbE85RFBwZTRBcmsyV25leElmQXFGMDRZR2Zl?=
 =?utf-8?B?RURWcnJNUTNSemljM3M0TmdRbTdEK0doV21JR1E5Uk1tNzhKakVMdXJoTGpP?=
 =?utf-8?B?V2RIenA2cWJnZVVaRGd0S28rYXdlbnVjbE9Sa0MzMHg0V1NKSGlpS2o4ZTR1?=
 =?utf-8?B?OWtHdDRsUytPMVdiRXZBb2JqcXRweGNXVEhSNXRzaW9EOUVMa0lNa05ENXFR?=
 =?utf-8?B?RVBrdVBOcTc4Y2s2SURhRzYrdldvdFg3MkZwK2RtR3F0TlUzcUtOOGx5MUxa?=
 =?utf-8?B?RUZYLzhHMTZPa2NBbjYveDFZWWcrcVZFQk9kKzVHY2FLZFNidHduMmpxakg2?=
 =?utf-8?Q?8KUxMvlWm0AjVAAd+YuNdR0UXAoXbAIi?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K21hVW9jQ29ZaGdKeTJmK1lJSFY3K0JiOHNKOXV2YnBwemNqR294QTIraG13?=
 =?utf-8?B?WVR0clhLcWQxTkltbEFoWFpjbHlqQmRqTFFGdnVJbmFEK0NZOFJCN3prL0xH?=
 =?utf-8?B?OHE4ZGZBeW9ndkpJNlRWMVNjUE8xKzhQc2VlM0JGTVZOYkQ2bGQzTVIvaVkz?=
 =?utf-8?B?RkVHMTd5Z0FteHcrQnRVemdFNk5QbXJyMFE2YXN0OTNzZjZ3OU03M0R5UnV2?=
 =?utf-8?B?RUNzK1VCZURVQ0dSQm1lalBQVWRhRko3L0JzVnFFdGRiRlhaZ0ZHQ0tnTHgx?=
 =?utf-8?B?M3lCMGtJOG1LQUxzdloyZHU0WFc5NjBGOGgyU2l3WnloL0Zua1pua1ptaGNv?=
 =?utf-8?B?TFVodXN5UXhOMWFtMTRoc29jZ1k2Y3NPd1N4dzFZM3NHbDRndFlsYzh3ZVNk?=
 =?utf-8?B?Q1dOc1ZoMnQxbnRvekh0eE9sUXZMWU55eG9vUDFoMnZhU2xiMFh6RFE0VERH?=
 =?utf-8?B?RUhQTldDcDVqOE9nWll3OFlFUXVJSFFMTVRadXd4QW8rREgranR1YS9EbTlw?=
 =?utf-8?B?YTlhN1hHOWIyNEtrK1pFeU12ditrMGZoODB5RmtRNGVmdXR2T0tBTHNBN01W?=
 =?utf-8?B?ZTNxeTNNeVBnMTdEVGxuSDBXbGxhdVR2NEpCYXUwR1VyYU13cFZHRTd1Szg2?=
 =?utf-8?B?TUR5OXozcGgvcGx2MmdocnYrT3RUWEh0RklOM2diLzZQVlZSMFA5RFN4U0RT?=
 =?utf-8?B?NzZSODdsUEpTQTR1bkRIK2RvYS9KZFVTWngzYWtUYnFzdHNMZjd5eVUwa0Er?=
 =?utf-8?B?cWlLdlNIakxWRitqRExablNBQ0srSW1zODJsaFQyQWVsdGpSdGc3VlZNSEky?=
 =?utf-8?B?K1BvMEFSbExXc1Y0T1pOUFZYWEJzNmRtSmU1RUF5QXJHc3EzNVE5UWJPUTg5?=
 =?utf-8?B?N2RUT1hhZlVWVlp1clE1YXNSYU5kQ2FscFZOa0loMVZZTEV0OTZ0VUxkeTJp?=
 =?utf-8?B?NHUwTU0ycHliRlFDaGVMWGl2WnAza3Y4SEVHRUpTdGVOaSs5enBBZFdSZkRN?=
 =?utf-8?B?SnJkQlphUklaRXZYZjh0dDBoT21VSDkwNHdvRlBIelltaWw5YzRxTXAxOTNN?=
 =?utf-8?B?TVdNa3hvYzA0TXhUUTZVQ1Jpd2l6enM5dmNWTDBpeHZCTXZDakJuUXZHMVF3?=
 =?utf-8?B?UW9zeDk2bFc3V252YW1ESUJ0WW5PV3FSSkQ0Zk91NytjVjdka2ZjRVpoeVhJ?=
 =?utf-8?B?Sm9OSk5LTFpBT2ZxTHBsSlp3eFZmb3AybHA5TUpiSFd5RHg0ejVsM1d3cnNI?=
 =?utf-8?B?OHdZZ2wxZjZrdzZQcjJuS1BxeUlHUUQ5Rk9jTHR6OTRJSmd0YzdERDVkVHIx?=
 =?utf-8?B?M0Y1UTg0RG5mZzZqanl5UUVIOGl4MVhSWDBrSjAyNTRuYWx2ODNHU3JRQi8x?=
 =?utf-8?B?bFI1RnFVZFBpZ3FpbTNFdjk3TWFjNlpZY3k3SFZVSFdlcGlPM3VDbGxremNv?=
 =?utf-8?B?SWhGVHF5eVpCcitja0ZWZERYeWZ0VFhFMlc5Qkwwd2JWdlUxSnRUWkJiOS82?=
 =?utf-8?B?U3FieEE3aSttSSszZUpUelNpNkhhcWE3ZVFYODF0L0xlajJRdVRYNnhMQ0VS?=
 =?utf-8?B?YlJKd2pabmJiTnVkeFc2QVMvNjhyc254R21heEtLSjdWVEpqYUlnMnRsVmJZ?=
 =?utf-8?B?RFU3WHRVQVp3dUpzVzgvZUxkaTFCMkFUTmgxelhGZi9BdGU4RUFXRFpuMFJl?=
 =?utf-8?B?cndyR3lUeS9MaUxaV0hUbytqL3l3UWdSdmd2S0tWUlNtSkQyek9jZ3pPKzUw?=
 =?utf-8?B?SW82YndkWmo4V2w4dThwMHU4ZkJwNTlXYkdhek8weGs1dUx0bld4SkZjMU5N?=
 =?utf-8?B?TUh1RE40OWpQNVJISHAweUVEN3kvTHBqdllWd3M1NXMyMlB4emtjTjBQbmVJ?=
 =?utf-8?B?bVhwZi95L2p0aHpkcEhUY2Vqb0w2aG9WSzJhS20vOUUwNWVFaXZUL05qdDdO?=
 =?utf-8?B?ekw2ZExWWXZoM2M5dzhXQlFTMHBodmo1M1Y0LzJ5TG1JQzFWU2J6NTVaYWJV?=
 =?utf-8?B?NHlyc0lhZnpaaTJBWWZ0Q2ZZUi9hY3NzV0tqajdiYXhlRUxZci9pZitXZzI4?=
 =?utf-8?B?SytadTlSMUc3V25JMWI3ZU9sT2NmdzBzNEJYeHA4WkFJVkRLNVNyMFlBaFdj?=
 =?utf-8?B?c0N4MGM5aU1FVkdZRlVBa2locUpsVmhZRE9XNnBya1B5UkJIM045aEl0YWlr?=
 =?utf-8?Q?scPF9y/GthWrEx2yxPYCridYyeduz9OVxrtcmaMkRTai?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D573CE8FB90CD4FB9C2368C7E0E9607@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe71d1d-b2f2-4037-95df-08dd340d2227
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 20:01:56.8089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XoVZsYwrARvMHCi1Acl6f1yOcY9zCBXtHG+bu/VsBTOnRao3Ff2X3KK5ywPneMLV6x0GGM4pIsxiOfMfLW6AYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_120202_891742_58CAB6B7 
X-CRM114-Status: UNSURE (   8.63  )
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

T24gMS8xMy8yNSAwOTozMCwgSmVucyBBeGJvZSB3cm90ZToNCj4gbnZtZV9pbml0X2VmZmVjdHNf
bG9nKCkgcmV0dXJucyBmYWlsdXJlIHdoZW4ga3phbGxvYygpIGlzIHN1Y2Nlc3NmdWwsDQo+IHdo
aWNoIGlzIG9idmlvdXNseSB3cm9uZyBhbmQgY2F1c2VzIGZhaWx1cmVzIHRvIGJvb3QuIENvcnJl
Y3QgdGhlDQo+IGNoZWNrLg0KPg0KPiBGaXhlczogZDRhOTVhZGVhYmM2ICgibnZtZTogQWRkIGVy
cm9yIHBhdGggZm9yIHhhX3N0b3JlIGluIG52bWVfaW5pdF9lZmZlY3RzIikNCj4gU2lnbmVkLW9m
Zi1ieTogSmVucyBBeGJvZTxheGJvZUBrZXJuZWwuZGs+DQoNCkxvb2tzIGdvb2QuDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

