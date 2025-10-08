Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A599CAC5BB
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Oct 2025 22:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vMVxNuEvNpClpvMpWRqJEiYwHzIr2tlcLzplCli03P0=; b=KHkio7yHmkeQsd4iow67AC9XR5
	ObEM0sBxAA/MyOUTdCPp7dvZkUoSR5V9qEyk4udWsionWqTp+qV8rXLhWXDeRr9V2mabwL7JmT0/V
	2A1mnArlhuWgbTt0gF/J/AEZB7beHqGrf33MGBSF4b7Z8Wb5k4iicM6HTFLv7Abs/hntEbLojgi9+
	bDflt5dgZUuJSLm7UAmJvI1h0GCoVLXDzDX9U45/WIOXexMvAamdQBZDtkwieMNzKLOHq4EzOlfc5
	W4fcFliM5CVvw7rf4aZLlewLNcgnWF06biYCRMhpIHVK/ED3dBC7wHTqOFsOCSEenQ8cbDAAjG0Ju
	GV+335Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6d5I-00000004mOl-0VCg;
	Wed, 08 Oct 2025 22:56:36 +0000
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6d5A-00000004mOO-1pEA
	for linux-nvme@lists.infradead.org;
	Wed, 08 Oct 2025 22:56:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KI4pI6uVA52ZsOj5Xtl80ccX2p6JXBqkzJVolefjIbcT0d6qH7c4QX9EOt8XzYXYxqaGLTzhFU2wRLHFJVGW9JeeZaFccztVapqzPVHXl//d6qkPgLlHax9SDNViHhD3e/nQLa3yyaWMbAQiXN2l/VZRAVxeR6U5XkAGr8okLzeHh5WO4/tSdbSPpWnn0oQMcPDxp6LoU7GEONtFXk1z6sL1DnwkRAKstpsjngfnWn/AT0g0QTHH+k3v3v45CQOOIP/XRFYtf/x8xZ+J6EWYtWG503CzfIbxZ6p1tr6cSq+evFv8v0vr+frrvhpyH3S5Dyhv2clXtDeoC6IIWelpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMVxNuEvNpClpvMpWRqJEiYwHzIr2tlcLzplCli03P0=;
 b=Unp8TNbu6oBaxz1cHsQni7gd+DSJBTOP3sZGnsneDrbpFmSabTA1Fgr420Sk+HOePbCmQ97z1m+6kR3GFyrlJG8S71niEBjwEUUEuThhpOWlcuCLSq7UJXxwZlfL6wqdh2+poohAB+GZPRdafdYm26ki3Zk3OGaY7vkRKD5ZWpY+i1VimqSSfYsVpJGkuZZ2q9AUc08ISx7ER5OWZd341psAzsrOWrFKdNGBSMswJFGoBaz6BuM5aaPFG2/trAw35rADMNVR17W5w87bAvbu1CefBmwYB6J6YxuWycvAqj2WndF5I7CUIU7mZqgBy6ZbKzZ/PYVOyzD4I/uHUP7l0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMVxNuEvNpClpvMpWRqJEiYwHzIr2tlcLzplCli03P0=;
 b=JG0x6mZdZmM/YcUJzqz172EMic8wvtEhEDUR2k6PXSxGVFmzynbYcdo9O9mIjaq0q7TBP2BcMFFWuCOVSE42EG3tEas69W2v47PGIO6A4djaCletZWX0FRMiZkgGav4r/BPyYHUtCWNwzZOcn00JG3a6yioMx7xwRWlE0FipouKAnmg2hm01lmjWNuc6SoVjn6iUS2XvXtl+UdARgBvfyEZVpsUHTU8/IaJFec5SEytP97l1tNrTWRsVdARF3IU26sFrAub5cxh4s2x0d2ANOKiR/jM0NJzZN+mgXyOwh0FyjZuQrLCxfUjhcCc4cSDEzj5v4OVN0t7gkjp7vsPqiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 22:56:08 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 22:56:08 +0000
Message-ID: <881b0c54-818e-473c-a44c-1cf6ecbdb962@nvidia.com>
Date: Thu, 9 Oct 2025 01:56:02 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] nvmet: fix configfs attr update handling for
 discovered subsystems
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 kch@nvidia.com, dwagner@suse.de, israelr@nvidia.com
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
 <aNRtJZL7uxRaHifz@kbusch-mbp>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <aNRtJZL7uxRaHifz@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbca3f7-7310-4439-2956-08de06bdde30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SU9WdzBMV0I1eERudmhtSEp4RDYyRFpEOWttOFVVci9ITXdISWJZZ3lSNVp0?=
 =?utf-8?B?T2cwNzhJMXplc2ZlZDMzQ3NhVWwwVkhhcFpnaVlCUzhWRGJ4TGF5ZHlXY01h?=
 =?utf-8?B?R3l4R0NoUUJWV3FZc3c1Nk85V2FLYVZjSXB0bXBoWi9IaDJDT1dYYzh2ZlpS?=
 =?utf-8?B?Nmt1SDQrWCtTc2k5VGJUNXFScGZqQVFYL2dDZDRaWVpDVVlpc25yR3VUdFly?=
 =?utf-8?B?blBRZkNyZThMb0VsenU0V1lXdUg2WE5TQU9EcE9ZZEhISGx5SHFoZkZWSzhu?=
 =?utf-8?B?N0ZnZENxdmZlaUtwUGM5c3lYeGhFTlE0V3ZFc0MvY0J3Z3BzY0J1Yjc1Qjdy?=
 =?utf-8?B?bkYvWWVkMzZZMWhyTzAzNThDUytYUkhoYjY2eXpNSmhyQ2RXdjF1QU9YRzAr?=
 =?utf-8?B?bXRWUG9jNExrRHFhNGFrZk9RWnhkcWVRMDZNK1BnZS85bU80Z0tuUWMyUTln?=
 =?utf-8?B?Vlp1OXBBSTJTcEt5OE5YT2dEYmhYMEE5OGJQaTJPY0NLcm1RM0ZTZ1Bsd3F2?=
 =?utf-8?B?TnF5R29hRGJIL3pONFJRUVRFQXlmekVBZTVCQ2JFNDVyMlVZalpPUVd3Vngw?=
 =?utf-8?B?WW1zRWJ3UFVncTNSaHRXRWU2bjdzUnduYnZxSnRkSkxXQmlEbzNCVStPNjMv?=
 =?utf-8?B?aUt2Qy8yL1BlV05haHlqZnRnUzhIRE0rNlVvRGwyZVc2RStycnI2eXVQSDlZ?=
 =?utf-8?B?MEFRK21ZV3VRV2xuaks1T3QvMTNtaDZ6ZW9ZbDcxM2dTdzJDT3BET0VUTTJs?=
 =?utf-8?B?ak10OVE0YllaZXNZQVZzemhyRFNVMVZpUk8vUks3dGNWczhGQzdNVXBuTVl6?=
 =?utf-8?B?SFJtckpyNlpMd3lmR2pxTnZKbFRxQXkrbzQrRjBFc3JFOTQ5QXNoSFZBVjVR?=
 =?utf-8?B?VHl6cUpwZUZoSVZBaUVackFza0lSNUpWVTh2RWcwYVBkVnVNSmR0MkQrbVpW?=
 =?utf-8?B?TjViSm5LaVVRbjBLNXByUHhOdGxiWXRydTl6bmUzNVYvdVE2T01GMVBvbjYv?=
 =?utf-8?B?TG55SUlPeWpGUC91RzkxY3hCamZIb2hqM29jR1d6SGRDU1lreEpUSE55clQ0?=
 =?utf-8?B?Qjc2eXh0cTA1STg0bVozTmpZY3lMNTRCemFIQWlSbjdtdURSZUNrbm42dkR6?=
 =?utf-8?B?S3JqRnBxeWJ3ZWw5UHFXN2hqY2pRbWJDVkJSNmZjb2xrcHJwUWhqYnVqQzhn?=
 =?utf-8?B?Q1hjdlB4V2RuWkZoOTdvZ0wrVlBvMy9sYUM2ZWt0M0lsclRrNms5RXVPZEFp?=
 =?utf-8?B?VHo5YkNZa3duUkdYM3IvWjNsZFpjVStlTDYveFZ3NWJ5Z1R0Q3ByVDhMckQ4?=
 =?utf-8?B?M3pKMzIySGgvem95OGhIejRJL0xMQ0YrWUZITC91U0ZLQUY3cVZzNERxQmYx?=
 =?utf-8?B?RzRrbmVMVm4rdWx3b0ZHcGFJSllNODIvS3VCS2xBMFRZeElqUWFNdVJ2Q2tC?=
 =?utf-8?B?Uis2VGdmalVIN0pPWGlXN21vd0NiYnZOeXNSdVFoRTdDdzR4OVV6eGZZVkxM?=
 =?utf-8?B?UmR0RmtUQnAzcHo4MUd2M0NXTWFkaVhhNHpDSlgxTXh2alNFNEhpV1NFazEr?=
 =?utf-8?B?bTlqMXVkTURTbFQ4dlpsTnFVa1VLZi80OUQzYllFcUNReEdVTjBKMy9OQk1H?=
 =?utf-8?B?cEQ3N1dYWUNUcUQ4bzNzc3JuQUpVSXhBb0wxcVliMTExSlgrM0lhclFqa0Za?=
 =?utf-8?B?YVV3czAvMlJybXZrSXgxaW1qc1RCMzZjZmhuWGZ6bDFpeUNDRHNSMlc5Y2h2?=
 =?utf-8?B?OGJHMnZScXoyYk1SWVJvODZacDhJMUVIMTBwS05CYUR2eXdSYUpmSjhnMmRB?=
 =?utf-8?B?Z0lHSnRMSEp6ejh4Nk5TSXRFSVJBU2VKQUFZZ3NjWlNNQWxxeHI4LzdmMlR4?=
 =?utf-8?B?VE5hOTNkZUVvdWp6NllYNXVSS0NRNVF1UmY4THVnN2c2cjBVZVoxSVRMQnN2?=
 =?utf-8?Q?WTC2Nw93FCrE3JEzAjYkn90O1chV1p3j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzE4WGhGK3k1dmZhT2FkWURPTXBGR0lCcWF0aHlVNHlHckdoUzJ5SzlQc09k?=
 =?utf-8?B?bmU3RlZoRjQ0U0hFYVdISWR0S25zM1l6WTZFSDcyZDNiUU9wamRZR05ta2Vp?=
 =?utf-8?B?QzYrNW5KMWJrZDFEUGtSU1cxckh2ZGJNYkVIcXZwUkF5UVZ1aThpcE9FQ0Z0?=
 =?utf-8?B?RTJDcnFFaXNzcS8vVkZXTVo2aHRWNXdzMnFQbjR5WlppcVY1TzFSc1Q0T3Fa?=
 =?utf-8?B?dWt4V0NkSEI3U3VhOEpLbUVqL2lWNWU2R09kYTdZajBiWDJocHpmclRYSGJh?=
 =?utf-8?B?bUdwUjNGc0NnZkNFQnAra1ladTZWUE1LNXRDYVc4RmVpYmJRZ2txOFNRU3E2?=
 =?utf-8?B?RG01Vlk5dlRvNmIwbmZqV0YxRDJtamxNZmpIdFllMXQxelpQYVczVEdQbzNy?=
 =?utf-8?B?b3J5VlN6bkJXcnQzcVdaUHZaOXQ5WXp6cEVIZzZzb0IrcWkzVVBCOXhBYVlD?=
 =?utf-8?B?MnE1eW15MXZoY0phWFphRkRSZklHU3NFZG1ramI0WGg2dTBZQ0N3L2diQzZq?=
 =?utf-8?B?LzR1UHdHRjkxL0NKL1ZROEpXc0ZVRFY3WDZHL2cxZytoL0hXWXVIcEtYUkxh?=
 =?utf-8?B?Sm82S2FUTURTb0xRR2d0Yk1EeWtPdk5HRldUbUJwaUtITjVsRU9sWSt6OXM1?=
 =?utf-8?B?N0tOMGdMSGNvU09DeUhYYTd3S0ljZy9zQjlkNDBRWjlSZDVJM2hXZ0lpRk5Y?=
 =?utf-8?B?YURsbHFnZjFJWWg2QnVGaEg5UWkxZTQ0TXZheWVNb1kvZllUYkZVQVQ1ZmQr?=
 =?utf-8?B?RFhlTm43Q3VDbDNvZlVXeWI1QVNYV0Z3aC9UTlhHcUJpT0pRRnkxYTE3aGVL?=
 =?utf-8?B?cmpyK2dnQUtmVzRTZ0JGY2xCdHVVMENaQ3Y2Y1c3M1VTUDhBTmF0Y3hxRzVM?=
 =?utf-8?B?Q3g5Ukl1VkhQczdBYUhhNjdLM2ZuQkxSNFZQVnpkdTRUSmI3SzF5L1R6VWg3?=
 =?utf-8?B?Q3hyWHRhbzQ3WU1TRHV6U0dxNGxKamVncVJQUWV0NGUwUUlQUnBqSmZCZVZP?=
 =?utf-8?B?TlN1NVpFTHVUaFBYdEhmaGJsa094TEE0NGxSYytRQ3NqSVpGUUR4ODc2dFc3?=
 =?utf-8?B?Vm56RHMzSnNMaEFEcVdGdi90R2wwUVJ4WUpPZlRQdmFpY0U3L2VtNzl1K2Rr?=
 =?utf-8?B?TDByaVpldXlENnA4dS81L1RUQlg0UkFDUlZ3dk1mbjkwMkVnOXpZK1UvYk15?=
 =?utf-8?B?L2hzTS93bUJ0ZFgvTVpML2VsSnZvN1F6YmFBNW52cGlGUGhrYmdqSFk3dkcz?=
 =?utf-8?B?ZnZ2dmxkRldBN3pPYXo5cEhabUplbG1wTm85MDFSNmdvb2cwdi9Nc3puMU9Z?=
 =?utf-8?B?L01DWFFOd1pkYVk3MTA3N05DZWo5YkFNR1hkbGQ2WHM5VlhOWXQ0MjRQUWRC?=
 =?utf-8?B?bDdVNGVpMzAyZjl0anF6bEZmNThCSFpRdFVMTEJUYXZrMld6cHB5N2pKRzhB?=
 =?utf-8?B?UDNCaWdCeDVNZy9iN3A2amdCcUtNTG9nKzcyUTV3ZWtKc1VRRWJ2QUhaNkxD?=
 =?utf-8?B?WGt3L1M2R245RTJvLzhFUjlPVUZmZ1FiUUJyQnFjQUpvWk1lL3Z3TFVQbDd1?=
 =?utf-8?B?K1UxZjZlZWtTbHRsUG1Pd1FMblFPNFErOFRDWXF2T0FrVDVJUURqd1E2WXlD?=
 =?utf-8?B?NzFXcFMwQ0lyZGpZaWNRaWJ1SERlNWtxZ3RUNmZNcDE3Y2E0WnVtdmlGejJ4?=
 =?utf-8?B?SW1iTndoSnFBdFV4TWxnNDRLOUNMZDRReTl4SDdScUlSYTNxMEpwVG9Pa0xC?=
 =?utf-8?B?bjZtYmErclN0V0xjbERiRm5VZmI0dGN2RWlPaDh2SkdWTEJsc0paeHV2MmNH?=
 =?utf-8?B?ZWdvZ3FBM1QwelhPMzBqbm16bzdYL3Fsd0NLOUQxT1F4SW8rQTcyWnQ3L3ln?=
 =?utf-8?B?aUdVSU85SnRGQzBNZlFnOWxuOGVTNUlCcHY3cGV4UDBvbEJxdXpJWWtzSzN3?=
 =?utf-8?B?eUgrMEU0NDlvUk1uTEh1NkE5ZHFSaGJQM0I0S0FIZ2xNaGovWWV3RW1JaUp4?=
 =?utf-8?B?VGlzRHlCYWhTYVJPeXZmVzdLNXhPQXl5T2RZYzhjRE53S2ZNVjdYeXJiOTl6?=
 =?utf-8?B?NXIwR1FqV3pvMmJjeE9oZU1mcmhndHpkdDV2QVdlcTlkM0xXY2xEVWV6VXJY?=
 =?utf-8?Q?SHz6bJ3aDBSJU/ehns7sLV44G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbca3f7-7310-4439-2956-08de06bdde30
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 22:56:08.3046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yl0+IMM8Pf5JfgQCN/Izi1EbPiDBo4DhMj4Lr0/aV3kO/20XlgCTx/IYhO21rM2Vcls2pYSasL+zFNPdNkVPsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251008_155628_501568_8140147E 
X-CRM114-Status: UNSURE (   7.91  )
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


On 25/09/2025 1:13, Keith Busch wrote:
> On Wed, Sep 24, 2025 at 11:26:00PM +0300, Max Gurtovoy wrote:
>> 1. Forbid changes to controller ID min/max attributes values on already
>>     discovered subsystems.
>> 2. Switch cntlid ida allocation from global to per-subsystem scope,
>>     matching the granularity of controller ID ranges.
>> 3. Forbid changes to vendor ID and subsystem vendor ID attributes values
>>     on already discovered subsystems.
>> 4. Forbid changes to max_qid attribute values on already discovered
>>     subsystems.
> Is there a reason these should be changeable after they're initialized
> even prior to being discovered?

I think we can make the subsystem not-changeable during the first 
successful call of nvmet_port_subsys_allow_link() related to the 
specific subsystem.

Then make all the _store() functions to fail after first linkage to some 
nvmet_port.

any thoughts ?



