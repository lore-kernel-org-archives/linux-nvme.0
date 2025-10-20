Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3E0CCD1A2
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 23:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rJ6lp0OQa5wQ9USTb7l3Owyyi7sZzQ8VRspedzkZSpc=; b=4g7SlBZlSV6s6G+CJjsmGmg1H8
	M0NGnsIIftJoZgCwiu/MsVCmq0lnQ79tJSnwus6SdoKwnxeOyCvckoO+N7TaiDvsXmwGVQVxfhWj2
	I+Ls1ikkIy1QPehTJEzj/Ifa9MWeuklBL7eyliSxg/X1sqAoBAbbNwCQgaYV4SIFH4et5bHHUIyZt
	qJDZL7VgvUKv2UpRf4+TPsmvWkMlRxresdt4JBRxBA/Op1uum6AytvY2mMTvUiBijK3xoqERyfUZb
	Sc2y3HIhzyy8fhCI7aAf4Fk4SYqQvDj5wmtg4sxD+Fz6T3e8iCHUPWulAFV75AndWt+iBrwLsPHOL
	Q0Q0e9ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAzPe-0000000FGiE-0Wxs;
	Mon, 20 Oct 2025 23:35:38 +0000
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAzPc-0000000FGhf-0uSY
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 23:35:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qS9EYRCODzEHq7TmKfYHRubTHBaw5Pfl2Gy/q+ePY9nhQOCbiHLxz5KmFWrfzEGAb690UAgRQ4/PxirvRICNQo57TNwopWLagQPzA2V6PyaqFeY4AL1EwXJ54rXjZDKs15LshVFpyPhyPEPLPCmEHUuXATtGHFwQiLaU/rRE6DcmuQgI5RqZcnVRrddbi3MSP0sBZ+g8MP/ehaltTRzkm0Qgo5Nntr2dKb8GNO6JaHxKXS+u1yKB00+nWE5QlmcyKZwMNSlvXt2VDn1T7UQbC3eFpDfdOjOjQ9PGErx6pu9m9MODrLN9pZ5yX5awr/BFmmNmt0/D8qandlAAe9ITGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJ6lp0OQa5wQ9USTb7l3Owyyi7sZzQ8VRspedzkZSpc=;
 b=coyWBO0iEG85qljYwRRxmtdqfi0Ts1W7xaRYT1AygpgaR279hlGUD63QAa8sqOeMxl/CnbN0PpbXx4hqAj/QcaNICUjbNYBp7KMlP9q3xth98mskALjAUj8rmyeWq0Y2rN6rfYlGp20LXud+dSVr8PVw2WA541J+nQzm8xSqjOUAmgnvdvJFwCtvpLSp/r5hdGBJce2Ow6mD2e0xEtI3vVYhqXaKGdDMeJdeVoCtD0mm3uiTuq3mrX/6m613jA9zW1mWSdH0rbBI0k3zqQjMrzs4ewxGSndMh64K+eXnVDklLaMravCGXAhccmW1OvqWMXjoKX0JR0XXDW4ejr+nWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ6lp0OQa5wQ9USTb7l3Owyyi7sZzQ8VRspedzkZSpc=;
 b=BJeD66Dbo73EW7iq1H3fOb6UqEZvzrwC7PCcjoQuDrbIKoKV63mQrMpm0M2wfKBTszpQf2KfIV6/8FXxXGrX8MOKXJ6A5M5lFWfLCfz+LL7KDQ0sXaT2G63JpivYIJ3rTRHat+wuvQ9QMlpsDz3NaHaY3Ynneu7x+ahc8eiTM5n6z5ppOb0K3qzvVtFoaFU+gd8FkmWhd2TK3FnHrsWouA5G91loroXSPj69deHtrxR6JwJdLrSSAkFZ18rZOl9Hp/Bpk9ETb6HCl7gFRNFyC/bWY+YTdwJ8m5yl0+4dvuvcL+fz8hsbhoziXz7oqJaBmXELfIQ4L3SHYpu4TiDQsw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 23:35:32 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 23:35:32 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/2] nvme-pci: Print error message on failure in
 nvme_probe
Thread-Topic: [PATCH 1/2] nvme-pci: Print error message on failure in
 nvme_probe
Thread-Index: AQHcQdZojM8Xy587o0W5Hanwn0DDsbTLsMWA
Date: Mon, 20 Oct 2025 23:35:32 +0000
Message-ID: <ac6a2d21-2070-49e7-8254-5fe7d5b70bb0@nvidia.com>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
 <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
In-Reply-To: <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY5PR12MB6429:EE_
x-ms-office365-filtering-correlation-id: f9dec72a-8e98-45c5-0d5c-08de10315c51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?M3B4VEtZd0s1U1VQeFY3WkxuTHRVbVB0REFHZEpwaGNNdC9JK1pjVHh1RU0z?=
 =?utf-8?B?djhtWS9NaXF0cEZzdGp5aGRsSGZ4cDN3c3UvTXRjTGk3bWdYOXhoRnpUUVUy?=
 =?utf-8?B?c1NPbHBWbSsrMVVYNHlrMEtESS8wU1pWYUJQNU4zU00yNUtSOGlvSU5tMXA4?=
 =?utf-8?B?TFkvaUIrcnpYUjNoM1o1SjBxUFRlWWFqWkZpZHhjS2J0MXZIVWQxbHQ1VkYw?=
 =?utf-8?B?U0Ixd1VRSXdadEdXV2pUS2VacjFrSGZOQUtsblNpbHYyMzNJbHBBT1A3OXFG?=
 =?utf-8?B?TzBMY2U2RlVuNVF2eUtMZmhqcnNEVk5jTWR1RUdqbE9SOER0Z1NWWjB4SEZG?=
 =?utf-8?B?WXBnR1hUekZVNEVNbkVOOXdQaW1FdXRiZmlGeGRPN3VtZ3JwY2NYVmszSFd1?=
 =?utf-8?B?T3lHSFI2cEJ3T2YvdW1jdVJvZTArLzVWdUhMVlRmTlZpdUIvUldZQ1ZaMFV4?=
 =?utf-8?B?SWFJL25jajNIMmhDbWRnSjY1TjVSUmRJbHg0VjVWTWxjV0hsQXg3YTljWm9j?=
 =?utf-8?B?aWM0TkMrWm5zWTl6Nm1OOHpGMDc2UG5tRElGd2xKUDdibS9wei9qYUN0TXhU?=
 =?utf-8?B?OU5UVmNGQ3FlMnpac3EybUhJekRpeG1OTWw1blJsOE0wZnBvWVlacmwvMGpi?=
 =?utf-8?B?WENVOWxQWUNkOEorUXBYVTNnaUQ5dmx6cHM3cWNIaGFoQ0VzK0xSdysrWDd4?=
 =?utf-8?B?Wng4RjZveXNNT0lvS0FHQ25zOS8veENOaTI3OEM3ZGRLVmZrMStPVVpFbU5W?=
 =?utf-8?B?c0ZnL2hOcDcyUzdaTEtXZkF5SUV5WDRnNndMenYzSk9LQk5GdkxmSk1ucW9N?=
 =?utf-8?B?blBweWN4VjFpSmh3VndycjJuOTc4bGNqdTlrcHhUYkFGZUErRVZZWXVCUFN1?=
 =?utf-8?B?YTRHcWNaM0hjdnFId01HOGJKVGN2Rmp2RjYwSUZwb09EMkJvazE0TmpVbUtw?=
 =?utf-8?B?Zi8vUUpqYVRKSTAwVG9KWndRMGsvYmhLRUpid1lIbTVPY1NZcFZCVzdlZVRU?=
 =?utf-8?B?NnRxSDlsZmFuWTQ4bFloUm1VME1yamlBRlY4UmN3SFBJYUFLYnloUTFkd0U2?=
 =?utf-8?B?SDdGcWgyazdTMk1SV1o4VnF5WmtsVEsrQytOVjRHeFk2ME9SS2hCdWp0OXpY?=
 =?utf-8?B?bTlYVFZrSDZSREx1elZySEcwN0pPR0JURmM5WTQ4Y0ZoOWp6ZjROb3hiK29u?=
 =?utf-8?B?Tm5RZy8wT0g1T0phcWpxLzI3NDdjSUFRTHRPVkFMVHVjZlpEYnRKR002Y3Vv?=
 =?utf-8?B?YjR2TTl4T2tTbGRCeXBnZW9lcGx3K0E3NmhaWTNMOGlHWDZ5NTdPUHloQWNH?=
 =?utf-8?B?TGx1ZkRwL2s1U3BKSGYxcExKZlpHcnUvazkraWp3TVorRGFENWNTcGl6NEhh?=
 =?utf-8?B?a2J3aVhhWk9UeksvNGxzS1V2L0VuZ0NPbTJIa216QkFnclBFSnZYaENZcmIy?=
 =?utf-8?B?aXdaYitpcHF1ZzUzZ0YwL3lNNUIxWVhrZm9QcXV6RitCUEdEcFdYQVFBc1BW?=
 =?utf-8?B?NWNnckZUSzlpbGhnY2FNUFFHSXRRU3J4OUg3S2VLZkdmWElEVzI0eVk4Sndw?=
 =?utf-8?B?bWwrQ3doS2FhRFhFWVliWUJmVlJiUWQxT1hhdUZvL090ZG00WHNFWVpqSm5O?=
 =?utf-8?B?bW5RUjIwV2d6eGZvSkNULzVHSlJmWHIwSWhFNGpnMUI4OThmMUNITnRycjVy?=
 =?utf-8?B?a1B5eVZKOCtGSEFQMHROTU03Y3pPRW5JQVBiSjA0U09Kcmp3bkFkcGhOUW5V?=
 =?utf-8?B?d0VJUUxVeS94Z0pCWjFvaiszRnJJYXdiNWxQanJ1TEJYUUtjbFlsWS93RnZx?=
 =?utf-8?B?elJVY04vc2ZhNERUa2VmZW5hSE5GcGNabFlBTTN2YmJYRE5HRDhYdncvR0RC?=
 =?utf-8?B?dndZY2djZ1FMRDI0ZTI4MGw0M20rWGJXWHE4R3d1T3pHZTRKV256L1dVVndE?=
 =?utf-8?B?b0hIekhrZDFpQnFmM2UrVVRmODJVcy9PUi9xU2EvRDZGT2VERWhKWE9Uc0RL?=
 =?utf-8?B?K0d6L05nUjJqN3pqbTFMZmpyNWlrc3NHYUdCTjJLWFNTODA5VUc1SDhUSzlD?=
 =?utf-8?Q?PFnYXu?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGFBRmpaK3dTSmZ5cnFsajBGYm5HbkFGcmxBTWtla2RraElwRXM1WFBpYWFQ?=
 =?utf-8?B?WDFFVTcvRGgvdS8zUjM1cUxXblRwaW5Wd2kydEx2NmIzSGREa3ZneXhvbDNi?=
 =?utf-8?B?SmM0N0hvQ3VWN1VVYWhzS3dsT0tVSjlXMDdPT0FENGM1d0hWSGtNVWJ6UlFt?=
 =?utf-8?B?eHk2RzNTaytLaFJ1bllsZUlqRVF2MnFtdE1JdFI2ODIrWWJCejNXdytVUzF6?=
 =?utf-8?B?azJRMlpHSjdWOW9YUHZBYkp3UGE3czd1RXJmQlRkSzVqNUxmS0xUSmRkTHdp?=
 =?utf-8?B?VXF5VkUxU0RmQmp3dlFuSkl3eEd1elcxU3IyazlDZ0daWVoxNnJsTVM5ZTZq?=
 =?utf-8?B?RWp1SXpEYk5NbW53M0tBa2xOTE1mVElrSEFrc0tRVGZQTUxTMjVWdXRnWXRm?=
 =?utf-8?B?MlJrUnNycmtHVWJsNWpXRUJDS0REN1lQZ1RFVmJNTm9pR21MTEpheXVGV2cy?=
 =?utf-8?B?T0xIQ2FwcU9NelRiOWV3VWdnNE1uSzNoR3djZ0Q3MHd2WkVLMXdBdzk3Vmh2?=
 =?utf-8?B?b3NKTTdmWW1JT25JbHh4ckVCMVF3TjdxMUJWVWZIWHF2V1o1UHZMN2RGUkx1?=
 =?utf-8?B?SWtKT05xNEwzZGFQZVdUbWxRQU1pYWwxMTVyTXQ1Zm9Ib3BaSDZTdi8vQzlC?=
 =?utf-8?B?Tnh1eXkzTVJDOXVSZ2hqa0c5ekc0SS9EUlhtSHVmT09TejhBY096djcxS1hP?=
 =?utf-8?B?cW9nY2xVdm11TkNSTmlrUmM0MUUwb0xxc3cwbVc2Zml5RzhuMjFCbTZQUDBx?=
 =?utf-8?B?UmtmSEdWaFF4bC9ZQkVJRi9GQm1tYkJ2SS8ybkZVZGVZUm5XcjJtT0RGcENT?=
 =?utf-8?B?a1VzeEdHRVo0QlBHVVN4dTRGT1NGWjJnaVlyd1U3Q0U1eVh0ZkhKaVdLbzRX?=
 =?utf-8?B?RzNFeHNweGl0MHB5UTlEQkx5alJuNlE1cWhDNUFkSFNoZXNCQkgyOUl5TDdZ?=
 =?utf-8?B?QkNpU214UytvaVZJL2M0SkdLQm80dmhCVU5hUFRNbXRLOWdvYUo0WHhFZ3Z5?=
 =?utf-8?B?N0FKMlZOREpWeWhpcWI3R2ZuZXVuanN5bEhvZDA4cTdtRWZaZHNwREVkeFZk?=
 =?utf-8?B?bjkwNmFXZUlCeDZiQmkwODM1YnRCRWRJZ3FPa05SSlNrcHlmY05Zd0ZxVy9R?=
 =?utf-8?B?TDFFcUtETUsyMFNRaTk4bDdMWFdpM3d2ek5URzFlS3RUZnJZU1BkejVNNWpR?=
 =?utf-8?B?TTNKYi9xNTNwdGtieDBzelptUTVESnp1VEJsclppYmlUWjIwZ3BaN3pRWEVQ?=
 =?utf-8?B?dStTc0RiVkpic2FRQ0pJc2hFclBGVEptKyt6TFJ5dlZzeHQrOE9oUHl0Zmcv?=
 =?utf-8?B?MnBEUUJDS2sreVR4N2NXdzNYSnVEU2ZrWDlYVnViWU1YUGs0ZURqRlZTTzBV?=
 =?utf-8?B?VkNyMEt2T1daRS9Yc3VEQzFnR3ZyNXIybWVTT1p5SzVhTDlkWkVUUHBROWVz?=
 =?utf-8?B?Z21DMTlEQW5MQ1Y5eUZoaEs1UDB0VjFkTVZjeVkwKzdDd2pLYUFtV1YyVkh2?=
 =?utf-8?B?d2FLTHBhR0w3RFJqamdoMEJrNVhuTjZrU3J5NGRUcWJvaTdFS20vSFhpSmYw?=
 =?utf-8?B?SjZld3pWS2FNZlFhSzNNdTZVNkFpMkJ3QkdVNW1mSkdsc3hPenBtckFoekFF?=
 =?utf-8?B?L1VwVm1jbWJtNXRqcG9vT09XWUFvdURLcmV3T1pxbjdZYi81T0xVMnNZVDNw?=
 =?utf-8?B?M3pHTFBIL2l2eS9wejk2bmdwZ1ZUT3FxbDNGNEZndHZmNEdQdVlvYkZ4Ri9D?=
 =?utf-8?B?azlreVJ0MFJ0aHBxVy93cWczSWNpdCtvaWNQaVJRd3Z4eGljak5aNDJXUU5h?=
 =?utf-8?B?ODVzOFd3Zzl4Vi9QbTU1Z0RzMFZTWnNlLytlQjBPMkhUSDhoK0VrUHRWV2pV?=
 =?utf-8?B?VE9mSVFCWEN6eGhBZzZ6KzFOZWpPYmU1OUdKYzNTV09HVkovS2dzR3U2VlA2?=
 =?utf-8?B?TmFzaWFoR2N1TjhrUjMzMEhUWmJHRUJVcXowWmRRa3Q0K3puVE9wMUg4RzNs?=
 =?utf-8?B?WnRGcUtsRzg1WW5vYk1QbGdweTh5azR2Z0pWbi9oN3RxaVU1TXlBalhUSmFP?=
 =?utf-8?B?NzhTUFZvUk1qTm04STZ2NjN3WFJ3cHk4R1JuVk01MnQxK3FqRVBRYkdUejlr?=
 =?utf-8?B?UXd4UjNoeTBJZWl3enhJb1NKQXk3ZU9pU2Jhb09BUHJBNWExc1pmWmxhMS9O?=
 =?utf-8?Q?gEd7Ws7zfdvFZweA/7dKKChQuQzksisQBHPvB0l5nFli?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5E4FE02B99AE74B9F2BBB6A63AC97C8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dec72a-8e98-45c5-0d5c-08de10315c51
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 23:35:32.0861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYpQySLqBHkDrw3wiccXuhQwkVWH1zzF5yqRlHhOWH9h6bIjmCwS6GFvn+ybu3ZAGMkze6xUgYjMYdsmyMWO+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_163536_256790_E2792E36 
X-CRM114-Status: GOOD (  14.50  )
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

T24gMTAvMjAvMjUgMDg6MjksIEdlcmQgQmF5ZXIgd3JvdGU6DQo+IEFkZCBhIG5ldyBlcnJvciBt
ZXNzYWdlIGxpa2UNCj4gbnZtZSBudm1lMDogcHJvYmUgZmFpbGVkIG9uIDIwMDQ6MDA6MDAuMCAo
cmVzdWx0OiAtMTkpDQo+IHRoYXQgbWFrZXMgZmFpbHVyZXMgdG8gcHJvYmUgdmlzaWJsZSBpbiB0
aGUga2VybmVsIGxvZy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogR2VyZCBCYXllciA8Z2JheWVyQGxp
bnV4LmlibS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIHwgMiArKw0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMNCj4gaW5kZXgg
YzkxNjE3NmJkOWYwNThiNDllNmU2NzY4Njc1NzExZGY1MmIxNTc2NS4uNzU0NGM0YmFjMmM0YTIz
MGQzMmNmNzI5YWJiOWU5NGJmOTNhOTIxZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hv
c3QvcGNpLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMNCj4gQEAgLTM1MTksNiAr
MzUxOSw4IEBAIHN0YXRpYyBpbnQgbnZtZV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29u
c3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKQ0KPiAgIG91dF9kZXZfdW5tYXA6DQo+ICAgCW52
bWVfZGV2X3VubWFwKGRldik7DQo+ICAgb3V0X3VuaW5pdF9jdHJsOg0KPiArCWRldl9lcnIoZGV2
LT5jdHJsLmRldmljZSwgInByb2JlIGZhaWxlZCBvbiAlcyAocmVzdWx0OiAlZClcbiIsDQo+ICsJ
CWRldl9uYW1lKCZwZGV2LT5kZXYpLCByZXN1bHQpOw0KDQppcyBpdCByZWFsbHkgaGF2ZSB0byBi
ZSBkZXZfZXJyID8gb3IgZGV2X2RiZyB3b3VsZCB3b3JrID8NCg0KDQo+ICAgCW52bWVfdW5pbml0
X2N0cmwoJmRldi0+Y3RybCk7DQo+ICAgb3V0X3B1dF9jdHJsOg0KPiAgIAludm1lX3B1dF9jdHJs
KCZkZXYtPmN0cmwpOw0KPg0KDQotY2sNCg0KDQo=

