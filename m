Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE51CAC5A5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 08:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RZuf3P6SLIchLvTcoDpYfD6JRTx4raj5p5gKxWXSR9c=; b=jh8b/oVG2b5OuOar1iZdzoIErX
	eJbsvYyUCSFfW4l5p7BakIxApXYD4i7k1fjHJXlzQmpr6Yo56yJWpSMd0VDmpQv1D+ypC3mzsWNmQ
	V3ySi2PADGu0E3uI6xJK31OIGgPvKdi9DShyaT2jDxLlIlmy4dOJKYB2oXe2mOranXyiJ78sTPXI9
	qtoCeOkksG5MkjBzSp9zjvO2DVMooB+azIrTRIpDzvZYrSVR6+LDG3d+CwWtp4oTZGns+8qo3hhT0
	QUr4Wy51qo0XS4a1Zu5koUrQBWiA/lIeCGBSs9XagSQLxwsNp0vT8hkJa4m20tVHBmxZoUqJPjuHB
	b+3cnzlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1hKu-000000078Hx-2oFt;
	Thu, 25 Sep 2025 08:28:20 +0000
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1hKs-000000078G8-3hDs
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 08:28:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHkv2FIUhlkILsEVhh+UNvrineMefMjE3wkSWGS/JXGvy5VE4LMgQEnv605DOfoTVVaOy0VMfJ1Sn0J9DJ3o1i/qc3rycIz3JPA1bO8oh4dEpuYhS0UhNgcIXE14Tls5d920BT208ORI5aOm7QIjEus4Go5cLkFaZ6uwLfyGhbuWjLUnFygKaOh0X4D6OhI3dlU/JIRLYdoD+djRJECSnHLiVHWwpnxUoKHG+942KFmwAl/J2SsuwsX0o0qbmA5wfd7uMH48Xw5AVqbfcxBIaw4nt83zZiw6KjgV5iXTZjBNVqs6lvfVjor2t+tFwzy7mCCViKzVWq08jGXbWTrKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZuf3P6SLIchLvTcoDpYfD6JRTx4raj5p5gKxWXSR9c=;
 b=VJOAczh1hYq+s/OZdBA6jByaMW1zaSqfp/n8Gd3j3WpxaRjInipvgy16I5fmWzgwXNsImJNEHs2V22ILcWjwBzkvR0zq/NKEAo+qynXSdHQ89qUZpWqbEdh/1CIS1fGE8sRQAX5nVyq9cbuscFfrt+Jxn9LwEsBgHPsnP7p/vhBcWMwMj1AXf6k6zQoKq/GgutpWBNRMD3drvcDsR3ElohcAuA2vSXvFucHCfWrWtnSs5T5ZFnw+0A3m+6APkEGfXzv/QyOoC9zWHqk05LT7somiKzVqzs+wWZlB9DH943jlz/PtNXELIo889eMUG79DwVpwsbTdumMgcabYN7gOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZuf3P6SLIchLvTcoDpYfD6JRTx4raj5p5gKxWXSR9c=;
 b=Nz4xT0aFlEcnmSJIOj9S4zry1+SOi63FZUIrEjckCIqe3fuBbexgmwH16DSkMmJtS/1zvlI1+B0jwZsDn+jcgQNQqwUUpb5zHbAYeUu6mcCOg0y3XhFZGVVtD/jck1AWxYSBwYeNwpWLKoZYIfIy1GexUa/unmkzij1jopY6D7AfUfXu9gPU8HgxwCSD9CHWSvsnW1wISsNRMC2f34SoYxEGDH8n6Ufhtq3PA3hpfxWWbotLKyMoRBa5qynmSfr9wJmA4G8vz6Ptigi9rea6iRksVs0z4JRH/fL1YtozJiOa7cjeerrMBTeevDGfstfiuxNrxgIkkI1VC/zhteClmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 08:28:09 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 08:28:09 +0000
Message-ID: <0c96d03b-b98c-4996-8739-e8cd0d6af96a@nvidia.com>
Date: Thu, 25 Sep 2025 11:28:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvmet: prevent max_qid changes for discovered
 subsystems
To: Daniel Wagner <dwagner@suse.de>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
 <20250924202604.7201-4-mgurtovoy@nvidia.com>
 <97291788-f831-469c-b0cd-7fd79678366e@flourine.local>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <97291788-f831-469c-b0cd-7fd79678366e@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: e6074063-1bc0-4844-6154-08ddfc0d7550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTJWNUErU0ptZE9ybEpUMDVmMnpFL29PbHpsVi9KV0NPTEN2WExaUENQSVBa?=
 =?utf-8?B?U3MxVENLMXorUFl5T2VyclZDSFRmcE5RZmcrMGN1WVRQeGx5S1pRTERnNG9T?=
 =?utf-8?B?QnYxakxFQytxYmc1ZWsyVElBd3ovZ0pVN2RqZ3ZsVEhYNHUwYW11KzF5MVVF?=
 =?utf-8?B?OGRNTXMrMGJzbzd2cnpNR21UeENNdCtINTJvUFo4UUZpeFQ2a21FYU5ONXlx?=
 =?utf-8?B?Y2FOSDh4MFM3WVRNejQvNEx5ZDJhOE5IZzRXbUdkcGhscUxuUUc5QWVteHF3?=
 =?utf-8?B?ZWNJOE1HL0dqZnBWNjZYRTduY2tLSE5hQ05kYlFrbXFVSlJiNHRZbmVObEhn?=
 =?utf-8?B?dFcvUW5Gdmx4cThISHRxVy80ejBhSG12TTE0OG1KZVJpdFFaOTRobUNtcVhV?=
 =?utf-8?B?SHpOY05LSTdyY3BRNjZSVVhsTzZ5dGR0Vnd2TTlKQVo4SkZhT1pyRnNpeDZ6?=
 =?utf-8?B?TkhieEhiNGFYbm05amRuZGhYSmY4TTgzdkgxY0ZDY051dnRyVFNVdlhqSjJW?=
 =?utf-8?B?RWo4cm1XQ21KMnpUNnNxaldqV2N1RE5iTUdKZzhPZjZjOUo5WU5DZlVPMUpL?=
 =?utf-8?B?eUYyYWhsR2NobjMyTzU5K1g3eHI1eHJBZEFFd2lqb1NuODdzZlc1V2tHYlA2?=
 =?utf-8?B?NzNsWWpXK3JTVzN0OElvRlBML2tibTdXdkRTNmRSR0E5ZWtMLzY4YlllaHBG?=
 =?utf-8?B?NkYwN0NRZk14YTJzMm9FZlV1UFQwbWl5aHc0d2lqbE1aRmdaOCs2SW9LZHZh?=
 =?utf-8?B?L0RMSGc0dWx1cENVWkJ1Z1NwVjRLMnV3S1JMMTQ0eXJxZklJTWRPekZrWi9G?=
 =?utf-8?B?Yk1hWjd5SU80eWplNmJ5NS9mbjIzOHhMWVQ4bUFQcjlqaVFqTlVacHU1Q2ND?=
 =?utf-8?B?Qkxzcy9oUk03YkhtVDk4STMyNWNTaGlHYkJSNkdYbVp2QjRwdG5sT3RTSXBP?=
 =?utf-8?B?eGd1YXJqek1OMm85TnVTa3hRWkY4ZjF3OUpoNTdCNGxNV1dVNHk1U3d6Ty9t?=
 =?utf-8?B?b1lrd2RXQ2JuZ3V4Qk5IcVdxN2NvUFZrN3pudHFGK0JlUktaREptUmcxdHps?=
 =?utf-8?B?RE1NYkdlMHV2cUhHclBla20zZjVMcFRoaGhLdG05MzhrSkhYS1A0UkE5bUVV?=
 =?utf-8?B?MWcwR0FBNEpEWmovN0hLVjRXQzJFM1UxSGQ5MkxpREg3cDN6dEZpYjFwV1d6?=
 =?utf-8?B?aGxyZFhaek4rY1c2eGJxYk9HY3hJR2JtaXdjalhIWWdGR3laQndnRTJRU0FS?=
 =?utf-8?B?RVFhcnZsaVVOemZvZHMyeHNqL05vTU9OS0V1MWIzaTR5cXhUTjU2dlNKZFNT?=
 =?utf-8?B?QkJ0bnByUzJMNS9XWVJnMjRBU2dxbnlqZnNidlEwemVVUSt2VmJldmcvYVhF?=
 =?utf-8?B?eVgrcVZ3N2lDa3ZiMUNzeUhMbWdwLzRpek1tQ2VYM25tUXlBdmNZZlZDeFpa?=
 =?utf-8?B?Zmwvd0dJREs4K1h6aHpwZXRyOGlsM2J4TFlvUDZMNHkwcVcyVGpvaHBWaTht?=
 =?utf-8?B?NStFK1JEbTZtSis4dEI2M2dvdnB1bCthU2xzUTM1M1hFeStSV1lxYSttZjlB?=
 =?utf-8?B?ZnlYWjB1REh6MWhOa2RLZnJ5WVhlSmZMd3NwVEpSRHhkamtQM2pEbHlmWWZz?=
 =?utf-8?B?dXlUdkRBNlk3cUUyUnhYYmM0Ky80TnBzNkdvVkZzcjZ3bnNRTHNuQzJlcmZT?=
 =?utf-8?B?RE5xTXhDWWRJRks1ZEZWSFZJMVVncm1YZ3RMYnB4bjhmMVFGVExIbEVCQTh3?=
 =?utf-8?B?QTQra0xwcFRsZzIxNW5jWms2aDRQNmtJbzNaVGFUaXQ3bEw3WmgxMUg0U05x?=
 =?utf-8?B?S2xZTW1mMHdvdGtMcEFDUTJBVmpXMVNLbzlzQ05hQk10c0IyYVZGQ2VMazhS?=
 =?utf-8?B?OXlmSmhSb2FDd2ZUSm1vTWdWUkNSZVBQb0tDUTBmNCtLM2YzN0N0YkplRWZ4?=
 =?utf-8?Q?OczcuhyMCnI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S203aDhhS1pMWWV5aURzaDBZMDFsNWd4dFlzRnpISVZ0YStpcG1PeUw0M2dl?=
 =?utf-8?B?NUNGa3RVeTlqSlpmTzRsWmtCR3RzaHc5Z1Q4TDZob1FWUEkyb1VXZGVoNzVM?=
 =?utf-8?B?UmZ3RFpwVVpvQkpucFFFMUVtelpGOTdGM084RSt2VDd6aXp0ckthamhSK0Ni?=
 =?utf-8?B?cVJoUjJ0VkNCYlZDVnF3aFZhMFdYdk1jenE4RHI2NEprZnVZOVlnRGhYUTZa?=
 =?utf-8?B?TEJEd1hnWll1Um1EcjBSTUhpNzhRVTdYT3Aza25OUWZWd0dSQk8xUmFzeXp0?=
 =?utf-8?B?RCs0Ni9YVEFHR3Nuckk3SVVwR2tvUXgxVWM1TjZ2NlltYUc0ejV4MWl0Qkts?=
 =?utf-8?B?b0NtK0lCbDFpcE5VT2VLQ0h4dlBqSWRYS0VBZER5bTFTUlIxN3FXZEV0U1Zw?=
 =?utf-8?B?dUx5am5pWjlwb2xoV2x5MDdyOEI3RnExTUpOaGwvV05ncHoraFFXNWdUbVdX?=
 =?utf-8?B?QlRhNGxYeGovc1dHbjVGOTlWVDZ2WUxvUzhpTWwraVprckJjMHVJZWxtWWxI?=
 =?utf-8?B?TkI4VkVkdWNhSm50MS80Rm5nSndlNG10eFdOUGIxVXVHVTNDZEVDTmNPaGJV?=
 =?utf-8?B?aVc1SnhTTmNFd001UlYxamNBcmcvQ01GNGgzblZrNSsvZ3phVjhmUkFEdGxX?=
 =?utf-8?B?anVsR2d0REs2U0VLcVZPZ1Bwc3RORWN0dDlYUllJanpKOFZsWVF5VCs2UFlS?=
 =?utf-8?B?T2RkSktLdlJQa2hHVXV1Y1VLVjRic1BjR05QeGV3V2F1d3NVdU1HTE5RYVBN?=
 =?utf-8?B?SW1MVGxQWFh5WXBCZjRUcUtERlFwRGVLM0R3dnZ4VnljQ2V1WUVQWkhtUnpW?=
 =?utf-8?B?cDQxQkVvcnVueWVXUzgrSnJ1L0E3d2FSbEUyT2s3TDZ2UStTQTQxOXVDaHha?=
 =?utf-8?B?OE9PRFNTTTNMUjlQSFVCOEVCOTRpUFdmY1BUQXVSZTlsaUNFOXNYbWJzSEtX?=
 =?utf-8?B?Zmd0eVM2Q1g4NnpFTU9vNGhKaitMd0lvd3dXRWtsdUx1UWNSTnJGWlpaVnB2?=
 =?utf-8?B?SGFKTytjdFdQWlZEdHNRSmswVzNXUDVmRStGR0k0UkFTTXlHVi9NUUkxVTdm?=
 =?utf-8?B?L2NzYSsvTCt1SGs0ZWtIdlh6T3E3amdxT0hIemUwc2RBRGJMVkpQWldiWVNT?=
 =?utf-8?B?RVBXZkZ1WWZqOGpJenhHNEpMRWJ0MFR6TDJFbXFzV1dMdEMwNDY3SWFOeDF6?=
 =?utf-8?B?RWlrb3ZPVGtXeE13c2JSUXlhcUV1UVN2UVozcytQWGlYT2x5YzNEQWppZWln?=
 =?utf-8?B?VWxJaFZOSjNnS2wzdTBwcitobU0zVXR1eDB6czllcGgrK2lzWFJacHNKWXZS?=
 =?utf-8?B?ZU03REVxdlpwcDNsR21nSU5OdVJUWEtsbDN3U0lod0NnWkd1b083aVgweUFN?=
 =?utf-8?B?K1VKVXMxY3RKUjdKeXl2MUpneG1XRmNCSTczc1c3OUw0UHpzN0lMdWJTdk5j?=
 =?utf-8?B?SXU0SU1UZ0x2K2lBT2JocmxwRW1JR3IzTzliUVhPNHhkdUdiaGMxVnc3UER4?=
 =?utf-8?B?ZDU1c2dkeGVRdWU0WXRFaE1jZldGOGNkdFk4L1hHWEEwOTBGZTlISkx2cVk5?=
 =?utf-8?B?S0ZiREVzZkZZTW1USWp1MUlhaGJ0c1VZaHZ4ZVZFblc5MGRuWEc0RjNhcjZV?=
 =?utf-8?B?Wml0S2FLM1Nsb1BLT1g5VkNDdU94cEhPTVJYWVZ1bTM4STdXeWJYRWFpY2hk?=
 =?utf-8?B?TE00VUtyaEhpYXRPRGVUOE5VVHU1aDNBRDBZeU5uTWFTTEg1UFI3VzhWeFNJ?=
 =?utf-8?B?bFExVzc3YUZoYW5XT0VweDFVcVo1UVM3TDBlYXc0cFIyamU0MVJDUEhEbDN1?=
 =?utf-8?B?bmpkZk5lNXB0WVczU2FLcGFYRVErQnhNcVUyUzNVTnJsektWNDFVeGpSN2wy?=
 =?utf-8?B?amV6M0ExV3FMNTA0anRpZUx5ZUs3U2hoc2dDbXVJaWxDT1RYa0M1dEFCQXZE?=
 =?utf-8?B?UVJFZFVndS9IZENqYStOeWRrend0ckJuNi9POFJ3ZWJiOUJpZlR2NExoaWRu?=
 =?utf-8?B?TmNQb3NiL1dlYTJPR0hLbEUya2dZYVFnalV3SmxHRXNhYzMrWDlNWkZhZWND?=
 =?utf-8?B?QmpzVTdtTkY0bzU2V2ZYdUk1Z2xXQ2c4TiswS1FPbDdNYk9jeXhyZnlDTEE1?=
 =?utf-8?Q?kxz4xY/U4NTfunVebXWMvVEI9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6074063-1bc0-4844-6154-08ddfc0d7550
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 08:28:09.2497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOGOnp8UcmFAlV5YN97ukSkEU2Mn8kkIKGjpzb9LdXAhFaM6VW2JrVcq95ybHTOrWo7fKXNMOCGRN4wK2BA+sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_012818_932892_D845E861 
X-CRM114-Status: GOOD (  22.73  )
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


On 25/09/2025 10:36, Daniel Wagner wrote:
> On Wed, Sep 24, 2025 at 11:26:03PM +0300, Max Gurtovoy wrote:
>> Disallow updates to the max_qid attribute via configfs after a
>> subsystem has been discovered. This prevents invalid configuration
>> and avoids races during controller setup. The maximal queue
>> identifier can now only be set on non-discovered subsystems,
>> ensuring consistent configuration state.
> IIUC, this change will break an existing blktests where it tests if
> the max queue changes on reconnect. This took a while to fix in the host
> and the very reason the disconnect call is buried in the max queue
> update. blktests nvme/048
>
> The scenario where this happens if you have a multi node target and one
> node after the other gets a new firmware. For some reason the number of
> max queue changes in the new firmware. When the host fails over to an
> updated node the host can't blindly reuse the old queue max:
>
> 555f66d0f8a3 ("nvme-fc: update hardware queues before using them")
>
> So if we find a way to keep this tests scenario alive I don't mind. But
> as I said I think this will break it.

The above mentioned commit 555f66d0f8a3 ("nvme-fc: update hardware 
queues before using them") was added to Linux-v5.15.

The qid_max support was added to Linux-v6.1 commit 3e980f5995e0 ("nvmet: 
expose max queues to configfs").

IMO the real objective of adding qid_max support is to make the 
subsystem more configurable and not for testing reconnect attempts of 
the host, as was mentioned in the commit message.

This re-connect scenario can be easily tested in a different manner, and 
the target driver code is not there for testing the host driver unique 
scenarios. At least it is not its main goal.

If we allow changing the qid_max attribute at any time during the 
lifecycle of the subsystem it may lead to a bad configuration and 
unexpected behavior.

For example the following race:

1. user set max_qid attr to 10

2. during "nvmet_alloc_ctrl" - ctrl->sqs = kcalloc(subsys->max_qid + 1, 
sizeof(struct nvmet_sq *), GFP_KERNEL);//max_qid = 10

3. user set max_qid to attr 20

4. during "nvmet_alloc_ctrl" - ctrl->cqs = kcalloc(subsys->max_qid + 1, 
sizeof(struct nvmet_cq *), GFP_KERNEL);//max_qid = 20

The above happens before we call "list_add_tail(&ctrl->subsys_entry, 
&subsys->ctrls);" and it will lead to sqs[11] and cqs[21] and max_qid == 
20 without any reconnect attempts.

I don't know how the driver will handle it but for sure this is a 
situation we would like to avoid.

I guess we can try fixing this problem in other ways, but why should we 
complicate the code so much ? let's try to avoid this scenario to happen 
and simplify the code where we can...





