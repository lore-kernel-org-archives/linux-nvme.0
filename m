Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D7ACCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 23:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4BCUmQwCsUu27d4yu3rdstpe0qxt4uqAfyuTliU/ksY=; b=KsIqxzL8YPQv0U9xRpAWc1FYT2
	enqEhcBy9dxc+H2JN1LuetUQUCleRfIUeJfbHXMk2GVBYYqSbt2sAjsqw2JYVAEMASiclh/wyBSCa
	hPSJ1W9fcpvNa6zsVqUisazPQsXK0p2e1eEOaO6MRImEn7I80pWXwiCB+XqsW5gMoozFU0gdkivBK
	AgLxsq5ioxazOMi4sACIx2/4ALoi5W53UrIOU/L1JlOGQU+ar7hu2f6mWG+Dm2rIUbrSJ6xpma56s
	iZb/Ad9CpVkL73WvbY2LLJP2b6hd/Amj+tBjgQtn7KSV3FeGjfcbVilPv6UzmJCHN3poOTPe4ndlO
	WoWk2S6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGQ8c-0000000CjWJ-1z2C;
	Tue, 04 Nov 2025 23:08:30 +0000
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGQ8Y-0000000CjVA-3bBA
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 23:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5ySf15pSnkBeSoRSuVWeaWt4Hfjh4Myk3yu59keNu1d7ngV45ND2fiMIvbp+BnYuTvLlomauyipTNtuc5CIbjzHT9iU+Ck4/Du/5dk7H4ZXXLpN1GaP4lWxwBlwIYUlg7PgfcLtMpRUZPSFGtTGDIOmYYykMjjqmWeplIlXURa/yCo0xQHu0emcNBZ6sJGTfqUI5VH/ceqLq0LzjBVD5kNz0sdjyeqRuGCCrMaqOnqWpIlpFHVddYJ0rUzn79gq8sjt4RHfAqbHR3WrUEvb/UWZCvrMMZriBGFXYQa73msIuU1Jpii5Yx9xp41SjdHaMBB4Kk2/t9JqdkSV2d7lRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BCUmQwCsUu27d4yu3rdstpe0qxt4uqAfyuTliU/ksY=;
 b=El4JQAbTIchZNQb6GhwhEz6L7stM10oAuKDbaA76mIAxULqUPhchjKq21wtcRmC50CLHVgmBlVXaPwpK+PgdKpJp4UcitWqf4UMu7iBWMZfNlf1V6YnD8/p7vhrb3+Ftl09ngBq2PbmRhKQJooziFWaYocQ0QzHK+l16aMnYFmvjvLYqqJr6ainiIT4hMXIU0XzzTNf4tw8mftp6+N0ZmZML5dOut3L1uUZ/e8P+ZehhsZliRj7u7md2+MlkGXKAlTI/L0iiiHLqTRpTpqO0MUNJ8tK3HZtfQb82U4biR50QY8wlMuwPNtJK6pA3ZAjDvzSRuGDVRPmN94p8vHbFCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BCUmQwCsUu27d4yu3rdstpe0qxt4uqAfyuTliU/ksY=;
 b=pWkonKpSlkUuVcXzYZz7t2EF9A7/ovuk9l5sI38cs66mu9wZFzVlmjguUNN9fHihDiys/iOEToDkP0gIoCYWYGWGviwDPPjg8mzWQBrHE/yw8WEYbbk7gd+l2RhrSSTQhY7cNhCzPJiuniRFgswcyVV2USVV/Pyl5LpahZdYHiok+XN9OQKnNp+jXSZvTjcFgtfe/2O2Yn+OsARiLVJljnYapFOhFVr+qomJW72CTMvSyWZl/wGjm0nEo7lMpqrrWwwrqwUbMh0QoA1/WVNGLGQVwWkaEQV9+DBx9Fqs0k3JVmjgTX+JIuvq39MtaNvfPdPD4li6xdhfgBAWFUgTvw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 23:08:21 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 23:08:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCH] nvme: fix admin request_queue lifetime
Thread-Topic: [PATCH] nvme: fix admin request_queue lifetime
Thread-Index: AQHcTd6+cRUvwt/Ro0Wz9pKeeHCGorTjJBQA
Date: Tue, 4 Nov 2025 23:08:21 +0000
Message-ID: <9d9a56a3-87fa-4d51-ba78-d3af220d5fd5@nvidia.com>
References: <20251104225939.3641605-1-kbusch@meta.com>
In-Reply-To: <20251104225939.3641605-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY8PR12MB7609:EE_
x-ms-office365-filtering-correlation-id: 5cd81bb7-48c1-4077-3b52-08de1bf70c5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bVhmVUNjOVczd0dQVm5PSkk1alQ5Ymh6Rld4S1lOakNjdFJlWWdUalRJQkpq?=
 =?utf-8?B?UU44Y2pVN2EzR1pLR2Rra09iS3JMRm90UWRzZElseEh0WnBvNW80NUpiaDhs?=
 =?utf-8?B?M0hOSzlMNDF6ZW4vWVFXc1o1aUNhSHZxc20rZXBIbzZCOUhjdVVFVXZrRHZJ?=
 =?utf-8?B?Ui9lZUV0akFFbTM4MHR5TEhXeEdtYWRjOWZibmdORE8zVlJIeU9DT0hybVp1?=
 =?utf-8?B?WWszNnY3dU9zWGVsZ2JpQ2lJZzIrVnZ0dklGMXY1bVpLTTA5MHNtZ1hOTFgv?=
 =?utf-8?B?R1VKam5Eb0pwQ21pUE5BT1h0dk1vM0pITjVrQkNSTUthZmxnRW9TYmw3d1RO?=
 =?utf-8?B?Q2pjQkdraVJyZG81dkxQdmxKeldwVmJUTWw0cElLU0JPdmFTYU9NdzJNUHE5?=
 =?utf-8?B?Q3pWUFJidUljendkU3lkTVdKRHFXNGw2NkcvS0wxUE9vUFcrTTJZT082cmo3?=
 =?utf-8?B?MVFTeTQ1SW90VmJQWktsK2d5dU85TWlEMlB3enVBQmw2ZDJ3MVJ1eUZqYTlv?=
 =?utf-8?B?dWROVitudnB1dmFKbHRpZmhQOUwzK2JRajBqVTlTLzVUZnB1cjBzZEFqOGtq?=
 =?utf-8?B?c2RyQXR3aVZ4RGpRYlh1bzZabTVVM2RIVHpWQmlISDZNRW9NQWVsUFhCZFhl?=
 =?utf-8?B?dS9ET0dpZ0JGVDNqNkRXcksvVzNldFVYU1JhTDQ3QlhuTmpDbWtuREhEa0Ex?=
 =?utf-8?B?NUp3WVVMbFh1VVdFbnZCRWtmOFdmMGxvemZFUXl4a04vcFdheWl0NVJ1eHZY?=
 =?utf-8?B?UTA3UXNrT0hnZE9GeEpCbzJKN2dXNHJieDhoZGNubXh4bGh3TmxCN1QzOE1v?=
 =?utf-8?B?Z0ExQml3UDJEb2dBU1RXL1lZVzhHWTN5ODFkRlppVHRvWFFxVENta1F1Y2NB?=
 =?utf-8?B?ck8veU8weElvZE5BclRhUXdvREV3ODNFRjNpM3hwSmpaanZHcXRaTCs5bC9y?=
 =?utf-8?B?OUh6cVVnN3J4WWJHTFdYWkRMNGVQSm1iZ0trdklPTGVXMG9iQ1RRbFZyNmVZ?=
 =?utf-8?B?a1VnVHJnU2RmbnJWK2Faclplc1JKMkpxZXpicVU0dW1aRUV0Y3lmdjk4NXM2?=
 =?utf-8?B?dU9wNzFURW5Cc2lIakk3YnpLSzBRckUzcXRnenJvQUV4VTVzR21HN0dSVldJ?=
 =?utf-8?B?ajlIbnlHeUtkTVZDMlNVS0hmMlYyN0svTUhNQXNIQjlYZEZoQWFNaEhGemox?=
 =?utf-8?B?aGpvZ3hDc1ZHc3UxU051c3BhemlRSnl4bHR6Y2RCanN1QzIzWXl0T0tSdXRj?=
 =?utf-8?B?V25sbFpPU3RRSXBhbVdDWXNpVytHbVRudWtFOTZMNi8wMlFrQUl2c2JmNTVi?=
 =?utf-8?B?Y0JDamZ1KzcxdkJPSit0VVJCc21DM3kwZ0FnSHhEKzJnWU9LK2QwOGFqdk1j?=
 =?utf-8?B?cEtRUWdKTi9nb0FsSFdNOCtVVWRHZGF6ei9GQmI1ZEFWRzhERDMvV2ZadkVu?=
 =?utf-8?B?ZjhXcGNkRHJadktQTmpZWEdsRXMwNjBzMFBYaEY4Wldxc1djUHRFdkdGcWh1?=
 =?utf-8?B?TU90U1ZNeE9tMko5dFBxUEs2Z1FGaUExMEZXdjFNL3lFQ09ZMjJyeFNhTHU5?=
 =?utf-8?B?bmU5WUM4L2hXNWpiVXZXNVpOSFBQUkFpMHJ0WmhIMkU2V2xWZ08yOG5aR2lQ?=
 =?utf-8?B?U1UvQ1RudEMrYUlHTDY2VkY2OGFCajN5YytLWVhvNDc3ZlozTXd0VGNCdWZL?=
 =?utf-8?B?TThxbDVKMEpPNG8zZ1NTSG5qemRDaTNMT2pURk5hRUNzeVN5VEtiTWVpZ2Zx?=
 =?utf-8?B?WnhjWDhyMkpSdWN0bXpwcnNReWhzaEM3azhoQjQ5MU5mMGxPZGl0VHZhT3ZP?=
 =?utf-8?B?TWRnZ0VYc2tlMThhSk03SE1oRk9zdnJIUDNsdDVJQmlrQ3lKR1dMNURSWU5R?=
 =?utf-8?B?WC9mbEtRNlZucjFGb1VtY1REZTRUTUhLUWUrNEVETHd0cVFwcUxHOVYzYjNM?=
 =?utf-8?B?UzZVMHgwQSs1VVdqWWhvb2xjTm03TU1tbTJTTW1SSm1NQmFOSzR4cFZDVko1?=
 =?utf-8?B?b3U4VE5xK3RsTHNVNktTV1RXdFpZSXFxb3hHd3R1MUdIdGZ3NG1saUZxQmdy?=
 =?utf-8?Q?J6t2g8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk1hTWJ0a1lGNkNJQjFveE5FS3p6UkhGbHk3UTF1eEZyWmR3dDBmUnNJOHIv?=
 =?utf-8?B?cHZkTkQ0d01DNmpzcG0yTUFlQW84VjJWYmY2Szk1dGora3Fsckw5MkNvMnpx?=
 =?utf-8?B?TUJMdWx2Y0h6Rk5NUTJud2RWeUliT0k0QjJIKzF2NTZKZkhuUHNTLzd4WFZh?=
 =?utf-8?B?RmZJRHZGejhWTXJZZnZWZ2d2SWJsZDQ2eHoyZk55OVFzZ20yOUZBMk53T3dP?=
 =?utf-8?B?NWJieVJEVS9xc1BUNEVhK0tzcS9hektzTHR1Wk9ScGJkWlMvWkFNRnBvMUN5?=
 =?utf-8?B?Qmt4TjRWcXBRekFPeXNuempHdFM0cXRnZGM5OEpoRHJRaURWbkwrREhGVE9v?=
 =?utf-8?B?RTBVNWZnU3ZXbUw4Tlh0TXh1OGZsMXVlcVZqUkRLK09MK3h6ZHN0VmRDN2JF?=
 =?utf-8?B?V1B2MG1lbWx6SlJLWk9zSi83b0lNMFVPaDlLRnJjbURYTmZIVXJ1WHBuWFI1?=
 =?utf-8?B?QmorRUFkYmw0SUFDbGJKNmRoZVcrTHMvZGY4ZzBXYll5aDYvd2R2NnlQbzND?=
 =?utf-8?B?MXlVNzNIRisxNm5VQjRiVVhMdHd6V2VNVVc0Qk5ibTZDbERzU3o2NU01ZUd4?=
 =?utf-8?B?cXhvN1pVRmRiZVZFY2ZlTTFvd2V6YlpIbVBSd0FPeTh3eUJlUk5EZzBveEp4?=
 =?utf-8?B?c0FYU1pRcmR0cVBRb2lYNkhxYnJMbWR1TThsYmFURjNnc2JXbzQxcDUzRnF0?=
 =?utf-8?B?MUorQTlIbG9GbmhGaktMOWJSOEd4SzhLT0h3cmtkZTIzUU1abzU4S1NWODl0?=
 =?utf-8?B?cVZHRlpHTWtZZnR0WEhUQ1U0bmlHbVVUc3Z4TFV6aGJxR0F5Mmpzdmx6NTNt?=
 =?utf-8?B?MG9TajVWcisvdW0zU3N1dDFSZzJ1Z3N5VXEzRnZOc0pqMUxXRzhHSEVRQ1dG?=
 =?utf-8?B?SUJUMVdxeTdheWZkaGJOcm15N2VuVDA4LzZYZVlGN0dTQVJad3ZlNzRKZWFj?=
 =?utf-8?B?bEdqRjNiTStUUWJwM21UM1U0S1ZTTm1uQUdyeWlWMTlMMmNrRXUyNEF6akh2?=
 =?utf-8?B?N2hYNW5NS0J4VzNQVHF5b0pJTDBQNG1EV1dnR01ZOE01dXRxaitsaG5wVE9V?=
 =?utf-8?B?M1BvdktWeDg0MHNKb01NeDVRN3BtdWZJa3NhcWdLaVl2ZXArMy9HZUJtcDdy?=
 =?utf-8?B?MEprcktJUWlycHpPQzEraW83RHVsajFCMVdMY3lObENmZXhLS0hQTWUvQncx?=
 =?utf-8?B?RERHL1RNWTdJcWZqbGFLSTE3TEFBWU1TVWZtWGJjWmdNbW1QN05RVWRpbzBO?=
 =?utf-8?B?c1EwSlpkazJOTWxlaG0rOE50bkdDanZqdURBMFd6UU5HaTA0elVyOVNqVlhZ?=
 =?utf-8?B?OFdmdldSQkFQRkRndlE3MXJtRWwxZnEzdmc2Y1JoODBWSHB4VlNZU3JjUWJG?=
 =?utf-8?B?MXM4Vk4wakhsYUhUQkJDaWVsUVlaNTl4d3V2V05mcWRsQ3JneUs0TFQ4NFFZ?=
 =?utf-8?B?alhidDM4dmU1OU9SVHkxaTh2TE9IajBpZEd1ZDJNNlVOOGJiV0JBNVNPMi9L?=
 =?utf-8?B?dlpscFFLQ1pHRUFDWHV3YzRGUkU2clZPa1czbkM0VmNYNUxhQk5lSUxXakx4?=
 =?utf-8?B?eDVHdU9pdmYzckc2OE9QbW8ySDRteHZNdDFyQlBUeStXYUkyYTl6L00vaUJF?=
 =?utf-8?B?blFYeitqUVpJV0EwSS9ucWR3OW1WbjI1NDBxVm9wdUdZRmxYWFpPNDFiT0pl?=
 =?utf-8?B?cUI4UVVFSHF2M1JCc3hYdGVxbnBvYkEzbS9rUEUybGcrS1JqL2VYVUcxc0FE?=
 =?utf-8?B?cnU1WDlub2J2MEtzc0RjVXlhK0dBWWJqMklpd3J4cEMwdTlSSm8xK1Jma2F3?=
 =?utf-8?B?TGtCcitZWGxKWEI0c1pEQ2Jtb1MvUW5aaThlUEFSQ2xCQmg2VWpXSWNudmF0?=
 =?utf-8?B?OHZtZk5sRXJWeXE4dzFQbDdqSFZURFJxSk1LdUFkRzRvUkdSOVl0TTJEZlIy?=
 =?utf-8?B?YkxhdW9jNFNuWGpObm5IRkVmRTR0cHNCUjhBdHdFVXdkVVhsWTQreW9JVldW?=
 =?utf-8?B?NklKNXhGM2ZjU2hkWU5welZPQTJKYnhSUzJPdk1UUjdGSVh1Q0tiQzRDN2RD?=
 =?utf-8?B?UWNnZ1ZKS29hZWFnVy9GKzVBK3FhQllZNlNPNGx5Um80K0RrWFVlelcybC81?=
 =?utf-8?B?cjJqckRKSDJHUlE2UllNMjdENnlCdEJaRmg5U25mYm9jbmxDLy85YXZMYURZ?=
 =?utf-8?Q?IGBIk4YAmBX7D3/Nke1e1gjfw4XVT97TL4clEcXmV7/l?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECF2766E6C79704183568B8FD19392A9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd81bb7-48c1-4077-3b52-08de1bf70c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 23:08:21.1319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttkK1r6C33Wqc3ialwaDjAo3tuZ0YbMBK+UsmdqTe6xOJKVVHEhYLyMuARgHZd6kL+U6glNyBa6VEMz6CZzQyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_150826_928856_7771A340 
X-CRM114-Status: GOOD (  12.95  )
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

T24gMTEvNC8yNSAxNDo1OSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBUaGUgbmFtZXNwYWNlcyBjYW4gYWNjZXNzIHRoZSBj
b250cm9sbGVyJ3MgYWRtaW4gcmVxdWVzdF9xdWV1ZSwgYW5kDQo+IHN0YWxlIHJlZmVyZW5jZXMg
b24gdGhlIG5hbWVzcGFjZXMgbWF5IGV4aXN0LiBFbnN1cmUgdGhlIHJlcXVlc3RfcXVldWUNCj4g
aXMgYWN0aXZlIGJ5IG1vdmluZyB0aGUgY29udHJvbGxlcidzICdwdXQnIGFmdGVyIGFsbCByZWZl
cmVuY2VzIG9uIHRoZQ0KPiBjb250cm9sbGVyIGhhdmUgYmVlbiByZWxlYXNlZCB0byBlbnN1cmUg
bm8gb25lIGlzIHRyeWluZyB0byBhY2Nlc3MgdGhlDQo+IHJlcXVlc3RfcXVldWUuIFRoaXMgZml4
ZXMgYSByZXBvcnRlZCB1c2UtYWZ0ZXItZnJlZSBidWc6DQo+DQo+ICAgIEJVRzogS0FTQU46IHNs
YWItdXNlLWFmdGVyLWZyZWUgaW4gYmxrX3F1ZXVlX2VudGVyKzB4NDFjLzB4NGEwDQo+ICAgIFJl
YWQgb2Ygc2l6ZSA4IGF0IGFkZHIgZmZmZjg4YzBhNTM4MTlmOCBieSB0YXNrIG52bWUvMzI4Nw0K
PiAgICBDUFU6IDY3IFVJRDogMCBQSUQ6IDMyODcgQ29tbTogbnZtZSBUYWludGVkOiBHICAgICAg
ICAgICAgRSAgICAgICA2LjEzLjItZ2ExNTgyZjFhMDMxZSAjMTUNCj4gICAgVGFpbnRlZDogW0Vd
PVVOU0lHTkVEX01PRFVMRQ0KPiAgICBIYXJkd2FyZSBuYW1lOiBKYWJpbCAvRUdTIDJTIE1CMSwg
QklPUyAxLjAwIDA2LzE4LzIwMjUNCj4gICAgQ2FsbCBUcmFjZToNCj4gICAgIDxUQVNLPg0KPiAg
ICAgZHVtcF9zdGFja19sdmwrMHg0Zi8weDYwDQo+ICAgICBwcmludF9yZXBvcnQrMHhjNC8weDYy
MA0KPiAgICAgPyBfcmF3X3NwaW5fbG9ja19pcnFzYXZlKzB4NzAvMHhiMA0KPiAgICAgPyBfcmF3
X3JlYWRfdW5sb2NrX2lycXJlc3RvcmUrMHgzMC8weDMwDQo+ICAgICA/IGJsa19xdWV1ZV9lbnRl
cisweDQxYy8weDRhMA0KPiAgICAga2FzYW5fcmVwb3J0KzB4YWIvMHhlMA0KPiAgICAgPyBibGtf
cXVldWVfZW50ZXIrMHg0MWMvMHg0YTANCj4gICAgIGJsa19xdWV1ZV9lbnRlcisweDQxYy8weDRh
MA0KPiAgICAgPyBfX2lycV93b3JrX3F1ZXVlX2xvY2FsKzB4NzUvMHgxZDANCj4gICAgID8gYmxr
X3F1ZXVlX3N0YXJ0X2RyYWluKzB4NzAvMHg3MA0KPiAgICAgPyBpcnFfd29ya19xdWV1ZSsweDE4
LzB4MjANCj4gICAgID8gdnByaW50a19lbWl0LnBhcnQuMCsweDFjYy8weDM1MA0KPiAgICAgPyB3
YWtlX3VwX2tsb2dkX3dvcmtfZnVuYysweDYwLzB4NjANCj4gICAgIGJsa19tcV9hbGxvY19yZXF1
ZXN0KzB4MmI3LzB4NmIwDQo+ICAgICA/IF9fYmxrX21xX2FsbG9jX3JlcXVlc3RzKzB4MTA2MC8w
eDEwNjANCj4gICAgID8gX19zd2l0Y2hfdG8rMHg1YjcvMHgxMDYwDQo+ICAgICBudm1lX3N1Ym1p
dF91c2VyX2NtZCsweGE5LzB4MzMwDQo+ICAgICBudm1lX3VzZXJfY21kLmlzcmEuMCsweDI0MC8w
eDNmMA0KPiAgICAgPyBmb3JjZV9zaWdzZWd2KzB4ZTAvMHhlMA0KPiAgICAgPyBudm1lX3VzZXJf
Y21kNjQrMHg0MDAvMHg0MDANCj4gICAgID8gdmZzX2ZpbGVhdHRyX3NldCsweDliMC8weDliMA0K
PiAgICAgPyBjZ3JvdXBfdXBkYXRlX2Zyb3plbl9mbGFnKzB4MjQvMHgxYzANCj4gICAgID8gY2dy
b3VwX2xlYXZlX2Zyb3plbisweDIwNC8weDMzMA0KPiAgICAgPyBudm1lX2lvY3RsKzB4N2MvMHgy
YzANCj4gICAgIGJsa2Rldl9pb2N0bCsweDFhOC8weDRkMA0KPiAgICAgPyBibGtkZXZfY29tbW9u
X2lvY3RsKzB4MTkzMC8weDE5MzANCj4gICAgID8gZmRnZXQrMHg1NC8weDM4MA0KPiAgICAgX194
NjRfc3lzX2lvY3RsKzB4MTI5LzB4MTkwDQo+ICAgICBkb19zeXNjYWxsXzY0KzB4NWIvMHgxNjAN
Cj4gICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDRiLzB4NTMNCj4gICAgUklQ
OiAwMDMzOjB4N2Y3NjVmNzAzYjBiDQo+ICAgIENvZGU6IGZmIGZmIGZmIDg1IGMwIDc5IDliIDQ5
IGM3IGM0IGZmIGZmIGZmIGZmIDViIDVkIDRjIDg5IGUwIDQxIDVjIGMzIDY2IDBmIDFmIDg0IDAw
IDAwIDAwIDAwIDAwIGYzIDBmIDFlIGZhIGI4IDEwIDAwIDAwIDAwIDBmIDA1IDw0OD4gM2QgMDEg
ZjAgZmYgZmYgNzMgMDEgYzMgNDggOGIgMGQgZGQgNTIgMGYgMDAgZjcgZDggNjQgODkgMDEgNDgN
Cj4gICAgUlNQOiAwMDJiOjAwMDA3ZmZlMmNlZmU4MDggRUZMQUdTOiAwMDAwMDIwMiBPUklHX1JB
WDogMDAwMDAwMDAwMDAwMDAxMA0KPiAgICBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAw
N2ZmZTJjZWZlODYwIFJDWDogMDAwMDdmNzY1ZjcwM2IwYg0KPiAgICBSRFg6IDAwMDA3ZmZlMmNl
ZmU4NjAgUlNJOiAwMDAwMDAwMGMwNDg0ZTQxIFJESTogMDAwMDAwMDAwMDAwMDAwMw0KPiAgICBS
QlA6IDAwMDAwMDAwMDAwMDAwMDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAzIFIwOTogMDAwMDAwMDAw
MDAwMDAwMA0KPiAgICBSMTA6IDAwMDA3Zjc2NWY2MTFkNTAgUjExOiAwMDAwMDAwMDAwMDAwMjAy
IFIxMjogMDAwMDAwMDAwMDAwMDAwMw0KPiAgICBSMTM6IDAwMDAwMDAwYzA0ODRlNDEgUjE0OiAw
MDAwMDAwMDAwMDAwMDAxIFIxNTogMDAwMDdmZmUyY2VmZWE2MA0KPiAgICAgPC9UQVNLPg0KPg0K
PiBSZXBvcnRlZC1ieTogQ2FzZXkgQ2hlbjxjYWNoZW5AcHVyZXN0b3JhZ2UuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gLS0tDQoNCg0KTG9v
a3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQoNCi1jaw0KDQoNCg==

