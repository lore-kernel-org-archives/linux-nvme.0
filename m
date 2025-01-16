Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77ECC02180
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2025 01:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8UAaKNKomYYdL4pKg7EtgYSS4agfGPFPOcoKEjbxFs8=; b=D4yq6Ij5rctVyvEJ4AO0hq+vo3
	9oNQnqgEq2YFy063K4qrotFQnDjfGH+oMnIAAXtQQVfLXs/HK7SSExXu+P/kVBh6FAWICHHz68lwP
	I/3pZAyVfkPfgX0Sq4KpWGajtTcxhQ0cV7ZWrFH3X/mgWuTtvqLnA7ZcJJ9alYIx6jmULV0cwS8QG
	iu80oMwlW003zjFMZlILMYoGe2BrOVpYyTjO2qMKM1/5ik2uf19MvsD9tRWgAlJsKS8wJ2sIHX4J7
	tJ3SRlwrUbEizDF3pzRLQMF5cRp9sVQxo/1uxC4Un+RNjbaBQIC7181LAFpp8JCawXRFfw8dz/Xsj
	CoyyZDgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYETp-0000000DW6X-3hb4;
	Thu, 16 Jan 2025 01:15:29 +0000
Received: from mail-bn8nam11on20631.outbound.protection.outlook.com ([2a01:111:f403:2414::631] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYETn-0000000DW69-2OGk
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jan 2025 01:15:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smbC/XzQwyr0KxMJd4Ki2Oh8b6kaDfvAdpu4ycbeSl9hGyhxQdn/SxRWfYg3i+keRLv4E/yTWd9YC48XSH8sBqXNFbYeKuVb3AB0lqLAntTaeZArxGKZ/L/vFEKYrETb3r2RBXe4A2MCTv8KSb8dxDMMdRrkpRwfRpW3mc8xCF0sI8FNC9dMGiEb7SHyVo1PKNmzkWyGrRDTJNzT5YmR4RzfPbCMzJOkcrOxC2lEc7NlxrpUnmzgQMZ4INLQELsk9NP41iS88EKwbgCEL/WbyKN92iQE+4E8fF0cPw9WUE0jbaKz3wRSXLImnovV4U8so0F5BM/VkdzuBb3bdnwRVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UAaKNKomYYdL4pKg7EtgYSS4agfGPFPOcoKEjbxFs8=;
 b=WY0YyQ6h7hD87gcvkcxe/UZrfO0xeaHEUQqyYl5Wi+sx6P2SrMo7APdLOwe7C4h2H931m3AwaSoDmQehi7I1L1QC4zJyvdFVp+RMqu2Dg0uPni0vr96YYey5rwcwvzy88ZrhroNIPUUwSpy3gIhk0jSxQXn6kpuyJVjV2JwDoVbJzlfzPk2i8J5iqWL+r+VpvbodZC+eHZyxeyAIDUtMihamcsSHztQF6ttmvvv8lfXEJ1x6e8EBJB4CIM32eLqvZx8brpuUJ+jkyEmEcLihKWX5eE33HH2XwyJVZ5aQB7vCumO0/n93bDu1IfoI6plVnBSO1HNLtZ6FqIsoox1Krw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UAaKNKomYYdL4pKg7EtgYSS4agfGPFPOcoKEjbxFs8=;
 b=oiRK55/d1CasYufwVNQI4YLNXY+82wNbfsc+Zs4ydKfTwX5uE5rg3KmsV5Y6THEMlqDydJygr0cBUad+8g8sYAdvX/GpF+uFp38EJUQphU3vO+vIGYKNI92yxTpRS+ljApsk34IaoRNCiTXR0U67RywjS6P2BlPyIVqx/O2WqYOohp5/hzsN8bnR1ZLW1Gb+6w95Ze1POrhYejs8ltZtyygbeT4E4N7nKZriOSIuMaSkwdVm2T/FU2Pbbr6TR5LBM0zM8TOEd/bjiUOyKpuGhcwuREBnmBLI2RUoRUfbGzrf+8Dsc91uyV+gccDsnGsymQka/YVHA7hixo/XVXFtIg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 01:15:21 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 01:15:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH V2] nvmet: fix compilation errors
Thread-Topic: [PATCH V2] nvmet: fix compilation errors
Thread-Index: AQHbZ5tFZCK5jI2oYU2r9rFiPViU5LMYaJmAgAAwaYA=
Date: Thu, 16 Jan 2025 01:15:21 +0000
Message-ID: <a4299529-15ca-4187-8a7c-d1c43fee92db@nvidia.com>
References: <20250115221703.62861-1-kch@nvidia.com>
 <6ca7f59b-f232-4bf0-984e-a4439e22b9ba@kernel.dk>
In-Reply-To: <6ca7f59b-f232-4bf0-984e-a4439e22b9ba@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN2PR12MB4174:EE_
x-ms-office365-filtering-correlation-id: 13ddd7c4-f8b6-4974-c819-08dd35cb3f84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cElzSFl1NERKbTVTZ0dicG1UNmx2YlNFUzVpdmhyS3l3MzZ4TG9tN1dSbXVQ?=
 =?utf-8?B?Z3dnczYrODZyeDVEWUlUN0dPMklieFlwZENBaFd0MFBQNkpUM1p1VzN4SkxU?=
 =?utf-8?B?RkFIa2pkUE9DTTRvbkU3eVBJRGRBVGpDUy92ZGVZSStGZ08zcFNhT1FPNHlz?=
 =?utf-8?B?Y1lOTmgycDJUWmhOeXh5UFU5SFFWNzAySzJEdUpKMjgzZXdQWWczYUhuTFcx?=
 =?utf-8?B?WitoeTdMSGhseW5nUXhlL0hYZ3pJMzUxY3JuTkVlc3ZmbXliOXhZdVNiMGt5?=
 =?utf-8?B?dnIyaUFNMENJdXNxcElqdjBnWWFTelBoZCs2TEFJZkVDeGJzU0l3S0NSZVk1?=
 =?utf-8?B?RjYzRVY4dFVrL3k1ckhFN1R2dEEza0FXSXVuYXNwcm5NTnZUbTFCaXgwL3JX?=
 =?utf-8?B?YWNmdXdpUldQV3liLzJvbFRqUVNhTjhmMjE2eDdQTTRrWmJ1VHR4c1pMRnpQ?=
 =?utf-8?B?cXVlQ0xDRjZWOGNSYWVlOG5MaEJxc015d2pCVTVnSEJ4NzNTNU93Nlhndk9D?=
 =?utf-8?B?bHpzTmowcHRjOTA4WDg3a2w1VGh4bFNwaElHdTYyQjFPVFYxcU5UajlCYTBW?=
 =?utf-8?B?SDcrbmVHZWtDMzAwZTR6alAvaTdURHJiV2RabEZiVURuekwrNTZUUDlQenVI?=
 =?utf-8?B?cTRkTnNad0o0R0JZVmJ4UElFTHVDZHljTElvVEdqdlp0SUVDQ3NwWlE0ME5N?=
 =?utf-8?B?MDFFWVdZVGcvc0RFVzRVMlpGbjVCN3VSdUZKL1B4RVFSemFOVU5GVGoxWXVt?=
 =?utf-8?B?RjlQOVNtQXd6WXJKSytBSjhlQjN3eWdMZjVYTGZ1Qno4ak9Rb3M3ZjFJTWUy?=
 =?utf-8?B?a09LeTc0dURsNW0vZ2Qxc1IzTUhjVnQ3U1VieldoMGtSbmJIN29OYkhQbFZy?=
 =?utf-8?B?STA0Z0FkQ3M3RnZsNjdTTVRGazI0MmZ3OFFkbzZZRVNaYjRweXQrWFVGajFu?=
 =?utf-8?B?TGV3Uk5Dczl2cUJTVmxpU0JwQ3FhR3ZoMnBXT2lIeGhkUU81dmxZQnBjTlJY?=
 =?utf-8?B?a1hQd24vTVk3MVVuMi9rV0tMdDBraUFpWlZ4VWVidDAyQW0wVklBcHdQNXQv?=
 =?utf-8?B?d0dpNnVveTdkRUQxWjlqMWRRYitYdkdOT0tsRzJaditRRG9wTkhRcEhvMWpz?=
 =?utf-8?B?V0owMzNuZUl3VVAvMzcvNlp4MVdKdTFEcnBkS0dXSjZIWTJwQ0h1enA4U0Uv?=
 =?utf-8?B?RVZCQnZBSWVHRmdnb3ZlaXBvUEsxNUNTOFZ1NCtSTDQ3SThJV2RMMWpqamJz?=
 =?utf-8?B?U0Y5VXNBN3M2NjRjbmd2WUl1K043UzVWdWVUNGkwK0FsQlpoeDNDaGMrSUFM?=
 =?utf-8?B?VTR2RUhpUHRjNEhoeWkxZHhNQXlMZ2prQWlnNWRvM2Ezc05qREVpd3hvY09w?=
 =?utf-8?B?eEtOaFBtNkVnOGVkamg4d0wyUk5xOEFqUTlkdUQ3bWkyb3pSMUM4L2N1NlVF?=
 =?utf-8?B?NHdWWVRBdzNQandIaFNWY0F6MXdCa01FWGNVTC9xajdvOXRZak95d1ZaTkRa?=
 =?utf-8?B?bWdrWStVNFFvU0EyeWc3aE8xbUdLQlJ2WDFpcTF0MjRlT3lSTDltcXp2WUNp?=
 =?utf-8?B?dUJaaEZqb0t2RE9WcVUvTFJ0WlliNTdMdFZqSHNXQ0Q0dVViQWdQZGt5VHVu?=
 =?utf-8?B?OFVXQVZ5dWRuQnVoQ3ZBT1ExVVJXbzNFUTRuNU1NSXBCV2VHTjBNQUV0TnZk?=
 =?utf-8?B?aERJeEVjdi9JdFZiMWR3czF2QXczc2VUNytBbVUyL2ZNNXlGazY0cWlETTN4?=
 =?utf-8?B?U3FacmNPNWNCd1VnaUlJZVVDV2FzZTBBNzhHK01qTjR3SFY3U2VUK0NYR29Q?=
 =?utf-8?B?aHNpRlo3eng0RE4wbG01bVpESTVNVWZwY3hRa3NqbGhjN3ppSHNpeTdibVNE?=
 =?utf-8?B?cUEwckZ1WHVkM0kvSnVXZ2FJUUh6OThmNEowL1I5YTd4Ym1RN09oZjVoQThW?=
 =?utf-8?Q?miqihbbO4f4qtvclIEImVMssiZyLARh0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REhIM295c0I1YW4rbmhhK2VsOFJEWXkveDdxMVdHK2s3Ri9pa3hiTm5NQlF2?=
 =?utf-8?B?ODJQMzlURWw2dGdOMVd5cGFOUTJ2bVdneDI4L3RKYVpXR0RFWEErZ0MwSVJZ?=
 =?utf-8?B?TDJvUGE2T1pqdGlsajluZHR3YzFsbDg4VElSUjJEbUcvRGd6WUluQ2dqeFpv?=
 =?utf-8?B?VmZRM3lzWVozQjhVT3Q1MkluS20yWkY4cWVnWk1jL1lVSlkzdjNhQkkzck51?=
 =?utf-8?B?ck1uaXFKcmR4c1VtWExBa3JsK25SY3RoWk8rWDFqdHEyeTUrdGhyMTdJNzlH?=
 =?utf-8?B?WW9aMjU3MUx0Z1lHcVZ0QnR5NTg1S0Y3dXdnV0krYWZzNGR1b0lvZ095bkor?=
 =?utf-8?B?UlR4RURST2hsNGtnOU0wd2N5a2lHNzczZ2lvQ1BsVGNneVBNZjBoMXFySHEx?=
 =?utf-8?B?TURBL09HRlE5WmZITWlHdUFmNXJuZ3ZscmJ4VVVkSlBiWll0MnN1Qm1vR3Iv?=
 =?utf-8?B?U3NRSzNOZnZrT09YU2xHNXc2eUVPRmc0U3BkVmJCdGh0eXY0NWZWcXR2My9v?=
 =?utf-8?B?VnhicG14dWF4VHl1a1dJbVRyZzZ5ZlZpRXg1ZnpDS0dWTWE4amVSRXhZU1du?=
 =?utf-8?B?RE8yOWRVSU9VRUpLeEdhdk5GU21ZWnYwT3VROTJLN3Bldzl6RmpaWFg1UHZM?=
 =?utf-8?B?MFAvQmRjOFdnVVZzTDB0RElLVFAvOEYwNHhvdFJDb21JVit4UTVlbFhkWDd1?=
 =?utf-8?B?R2ZRSlYrdHY3NGUxUEdXMjM0RFU5YjJyVUVVU2tGRkREV2JRaWpTOUFiUnc2?=
 =?utf-8?B?aUUyY3NIeEdPbjUvY2h4VXNWV1ZKMDYvV2t5MWJuNFArYXEyS2ZybjYyV0Zp?=
 =?utf-8?B?c0dJeTJtRkdpQTJzWGFPOGVBK0lDcFh4Qm9wUE4wSzZjc2U0SGtFZ29SZWo3?=
 =?utf-8?B?UjlBWWtLY0VXNnlveGFwRkVLeFpLTW0xTkk1QXgycEFHajZIdlRVM3p5clpj?=
 =?utf-8?B?cCtjWFUzTHkxMzNLcXhCMy90L01SejBNNzNNSVgxVldDaXVGTkF0NjBrdFov?=
 =?utf-8?B?Tml6NmMvMmNIRjExaWwzdlh1YkpKSjF0UDBSUGNwTGM4U09CRHhRNEo0dzdH?=
 =?utf-8?B?ZWZEUktObXBXc2dLNFd3RWhkUkFWbE9YN3BFbkM5a0pMa0VqMG5kTFozRWRp?=
 =?utf-8?B?R3Rxd2NZaERtc05GOXpKWWdVV0RiRzd5WEY2aEprL2VjMDR1a096dmoxd2F5?=
 =?utf-8?B?cU5qdXBQS1dldXZHaWpvcHBnY1NLZFZWWkNJU0t3bStNQVhpOWxaZStoRG10?=
 =?utf-8?B?RTJlQk1GQ0FNOGo1c3VBc3NhSXBwUUJ3WFRhWDIwMDkzcW5uYW5oZ281U3Yy?=
 =?utf-8?B?ejFzVFFVRVhNcDR1RE5HZDB3UVpqWHhwT0dUNVNrN3dwaVExUTU2T3ozL29H?=
 =?utf-8?B?aDJSQWZPRGdwL3hjd3drRmxYMThGR1RraUlxdjJlOGNLb1RhWDY3Z0Fhemkz?=
 =?utf-8?B?WWQzRHVCMHYyZ0JTYytzZ3phRVJhN3BBTTd1aUo1ZytBTHZOOTd3SjlaUHB3?=
 =?utf-8?B?SjNJbVhtVXhpWUwwV2JNWlFWY29iTFJDUVAzQ2lSQk9uZ1FIK3F4QzhWVk5w?=
 =?utf-8?B?OVR0QTVmU2lBd2IxdkcvRDAwcmhkcktxTXVqZlZCNDdIaDNWVEtwMG15TE9s?=
 =?utf-8?B?SjdTSkJZWHhlUXo5anhDVDBxVXdhUjNBWU93NGdYaUltb3Z3UjNqNEpLNWZX?=
 =?utf-8?B?Tm5NTzVuYjlvOS9UQXgwSVhYbHRybHMyd3YydFBQak5ZSGtGdVJZamNtT0FH?=
 =?utf-8?B?WkJ1eHBMUkhLQTdMbk5tMVlRc3pacU5IbHFScGN1T3pQR2hnMWxZMXd0UGVs?=
 =?utf-8?B?c1gwcjJldGF4WklldWZXV3BOdkZuenJYckMvT0J5d0JwM2Z4WUdWTGIxaXV1?=
 =?utf-8?B?c1MwWkIrb0lPK0krNVBCSXIrUitpSUFBZm9NTUV6ZVI1MFNjbDA1dXBWN09u?=
 =?utf-8?B?bGV5MThlcjE1UFNKalpnNnVwYm5Kd0pHTWY0dWllNVloOVJTTTBKdkhtL1Jt?=
 =?utf-8?B?cVF0Tk9MSkRWTmtxMG5GbldYNWlCM0RLcG0rNkZDOHMyOVFyZTc1d2V4SE5z?=
 =?utf-8?B?OEE4Z0R5cUlNZmpVRWNvV1RHSmh3bm44aUkreFFDUFF3Si9BVDl4MFJhRCtW?=
 =?utf-8?B?dDVEVmZmS1BWR3EvOURoNmRQUXpUWTBIZjNBL1BlWmlqZ0xMclhEaDB1eEZN?=
 =?utf-8?Q?6kUbGDjFiB60/rHxMt2BzGKDhePbxwC7EL+BTnvr36RA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C18B2AEA378A3B42AF65562E9478171F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ddd7c4-f8b6-4974-c819-08dd35cb3f84
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 01:15:21.6514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DPLO7PTROvc2cXFLVttWBIcov2B7Hg1efYDIVyIhuwmlW7LQL7KUJombtViADerlz4HsIRgJtAlxA88CibKdrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_171527_621440_9188BFFA 
X-CRM114-Status: UNSURE (   8.95  )
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

T24gMS8xNS8yNSAxNDoyMiwgSmVucyBBeGJvZSB3cm90ZToNCj4gV2hhdCBpcyB0aGlzIGFnYWlu
c3Q/IFRoZXJlJ3MgYmVlbiBubyBjaGFuZ2VzIGluIHRoZSBudm1lIHRyZWUgc2luY2UgSQ0KPiBw
dWxsZWQgaXQsIGFuZCBpdCBkb2Vzbid0IGFwcGx5IGhlcmUgYXQgYWxsIHRvIG15IGZvci02LjE0
L2Jsb2NrIGJyYW5jaC4NCj4NCg0KaXQgaXMgYWdhaW5zdCBudm1lIHRyZWUgYnJhbmNoIG52bWUt
Ni4xNCBIRUFEIDotDQoNCmNvbW1pdCA0YTMyNDk3MGZhYmFkNTAzMjYwOTczY2Q1ODg2MDlmM2Ey
NmJhYWI5ICh0YWc6IA0KbnZtZS02LjE0LTIwMjUtMDEtMTIsIG9yaWdpbi9udm1lLTYuMTQpDQpB
dXRob3I6IEZyYW5jaXMgUHJhdmluIDxmcmFuY2lzLnBAc2Ftc3VuZy5jb20+DQpEYXRlOsKgwqAg
RnJpIEphbiAxMCAwNToyMTozNyAyMDI1ICswNTMwDQoNCiDCoMKgwqAgbnZtZS1wY2k6IHVzZSBj
b3JyZWN0IHNpemUgdG8gZnJlZSB0aGUgaG1iIGJ1ZmZlcg0KDQotY2sNCg0KDQo=

