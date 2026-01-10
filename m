Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C971D25026
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Jan 2026 22:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pyESP346nncFFwnnf+rL1k6rZXfknn+BJgHNcqcB42o=; b=F3+5+Dysv3l1CtqSkm/UgOJWQX
	j6Jm3O73Fp0XnYPjZzivkfr9ensHtameiAi+KvjYkqonkgSY850MAoH68X+MHDIqHS7rmnM8KUvvR
	5mUVZHWA5XRNy/y9c0+dH9/CRR8CSkQ3nkq7k/T/zqRHQUq2s209FEqfn3h2UTl1/PcIgi3ngTykX
	u1rVZc7aRJHgwC+JG7eDv/ZMKsIoYBhxR6W35fkVcis7SSjY09RHYo8N2+BVFRhNq8PT8RdqsG00Y
	pQbgETSuZ2M/4sk0q0o+ZuCt35NbD60WUqqJydIxka2UQ25P0n+p5MX8SaFPJZNmvox51CQpq5Llm
	F+qJob8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vehEg-00000003ivo-1hAK;
	Sat, 10 Jan 2026 22:15:06 +0000
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vehEZ-00000003iv6-02Qo
	for linux-nvme@lists.infradead.org;
	Sat, 10 Jan 2026 22:15:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVDNKgVqaiUaX5IrSgu3N/exE7Zz56gw4WrUlwMI7fGteHf8VvzfFH4Zw0aUXTUt54VZXnziZSFwaoqXA6Dx6nYPysD6uyzDSGIfx+0Ep8O4GWCkYI7Q6CI9bUJ/4y4IAFGHPRmR+rSFymMXXYVFUwPDcU+xlIAwvUaBcpw8bmMT2uC4/gZZIZQaoVeBWx4PvY0amqEk5r7sZieT+Q3y8hM12oqVbFer5f80/NyAZn1k7FBJAs50C2BxotpJkSFu3NfWzi1/l1hI8yeyArI7iGZrx1OsmqRJR37K+at7LT5YU9sm/4DQ5AWDUfQFyhDBDtpdiLjxg//U8S1l6o3JaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyESP346nncFFwnnf+rL1k6rZXfknn+BJgHNcqcB42o=;
 b=xLSlYHesE22fwL+0nBOvp1ngP8e5mZwhX10IlWHAHvPS1ztyUcuVlRvWdz9t8dDWs6k30uCSuXlgYyMk6V6X+p5rqmWvWG1Zuizu06Q/SmqEUmVZmFiTfluGhAuN4h4I6ntyCgFFgHgh5kX/VmYVBX/2qIFCPe7s5J7cGQeC3NCcPI2ZiaA21pXqyA9AwXNSPJO8+5xjlbnL2i1+khxWfE9RlMS0LTiMFGxm/L/p1p1ZTW0uG+SeJyiNmNEbjXqbwHuEzjtc+Up9wnHwdAywCzWxfWkUZQ8BodL8EVwdkPJjIfd1Wl071mnEk2MBaACIKbCRwuuyK090qGYCEiP0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyESP346nncFFwnnf+rL1k6rZXfknn+BJgHNcqcB42o=;
 b=HBeOHx86zZeHglTq7bmHNlXnOALdujKGzxO2cRzY8G4x2lWQJbXhELgw+ewJhrPwUiImxgxJd9+U8LvmHZ/+M+2GEYbXUYGT3ht/L+S8Kr5AS4CivWH7VLZjQtJkoST86T+XrJ6vnBmXr7S04jzVzYfKBRkKWqClQeVbUM2wWanpu3R/SmeCxB59J8789aI2WPB6JJHkqByawOrpFyxLw0IPVOxNwaLfHZRKGKWb0D5/oICOTUWLVNlXl+DSPPELIEcfIHRmPLP0skwlV2YY7AbBwbRiaq8Z++UFXsqm5b8s1XvH6kiFxRnuxgZb/sGJVaV/Xc3KoBIVfgyeGMXzQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 22:14:52 +0000
Received: from IA1PR12MB6257.namprd12.prod.outlook.com
 ([fe80::19e6:8541:a93c:de4c]) by IA1PR12MB6257.namprd12.prod.outlook.com
 ([fe80::19e6:8541:a93c:de4c%6]) with mapi id 15.20.9499.005; Sat, 10 Jan 2026
 22:14:52 +0000
Message-ID: <7fbcf3e6-693a-49b3-884b-155c90275b6c@nvidia.com>
Date: Sun, 11 Jan 2026 00:14:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet: do not copy beyond sybsysnqn string length
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20260110110647.197130-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20260110110647.197130-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To IA1PR12MB6257.namprd12.prod.outlook.com
 (2603:10b6:208:3e7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6257:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a301e0e-04bb-44c8-33f5-08de5095ad79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVg5ald1WENvWlVkYkh2aFdXQW1oUGtxeDNrZVE4MlM2aGNpNXQ3dEh5YVZR?=
 =?utf-8?B?OVJndnp5U3hSTHBYVWUvVlFzbVNmZ0lKMC95NDdTRXBUZWVOZExsTmt3cTV3?=
 =?utf-8?B?c2dZdjNtOUpBSDNUMUtFNE81VDRIelBUTUI5N1puVm9NU1lmYUZEZ3dJNUV1?=
 =?utf-8?B?UDBkcWhlVUV6bTVXKy8wbEl5T1VxSlVXOUNSMGV6ZlpnNEVpNEF4RUJkSHJP?=
 =?utf-8?B?WjQzaSttelE3ck9JeVhBa1BUdHNiVHZEejBPS0pNazRYMHJqeHBhN3pUeWp1?=
 =?utf-8?B?MlJQZ3lMZ0NKdG9UYTl5TTFmL29KbU5zdHhtRnVJQ1JlbE4rOTU0Y05ZMFZ0?=
 =?utf-8?B?TDNUSTNjbDNiRTRuOWJlTTY2UE9SWThudG8xcWJPOVV1L01MbFhWeTJRSXh5?=
 =?utf-8?B?STVNS3lSVE9kbDdkVUV2Umh4RjJWSHQrZEFhVncxTXFmR1JBem9YVVlpMUJ6?=
 =?utf-8?B?RFFGYWxVak5kSnNqdlBxcjV6bUQxeW9PcnZYYmdnKzZtQWxhcTRLcW13VEli?=
 =?utf-8?B?eVhOR204UVBZN3VtT0t0cnJodWZIZi82RXEzTWdMSDlrbllXc1pEa0owenJT?=
 =?utf-8?B?UHpRbllJS2hmOEJUQUVwZnRaSHFVRDJucG4xRnVKMW1aT1VEY3VPM3U5SUJH?=
 =?utf-8?B?UHpFbUNYRUkvSDd6dUEvQ1B2cWpUamdCM2lFcm1hSDhIRjd0OEdLNFlwb0xM?=
 =?utf-8?B?MlA1Unl1bDRLRFZQbThwZDZJaSsrSE5IeVBMNmc3VHRDckhEa0F5ZGtSd09H?=
 =?utf-8?B?L1NKZTYzSnhhMDlEa3BaN1did0NGSFh1aWdQMmZqTTlhdDY0UUpiNXl5dDVq?=
 =?utf-8?B?VEZ1MkttMzE4L2U5a0liQVo2MXFKNjhPTkpJQUdrVnB4cUxBOVJaYWNYOTA1?=
 =?utf-8?B?SndJMkMvUjVZUHZZbm8rRDFIcnFJNGVaTUdjTklCM0RPQTVEUUl0dk5tVVFr?=
 =?utf-8?B?MUVMWWU2WGZ2c0RUOVlUYmo0UjY1SlFvRjBkZ1hGNUZxUkxPMTQ3NWt6aGRH?=
 =?utf-8?B?Y2YyVXRMYU9kR2tHMUhHME1UbzFUWFF3dDdwWWo2OUl6QktkaHg2RkEwTjhD?=
 =?utf-8?B?R1A2U29TamFxY3hFQnJzRUpmcTJCT0FGUU5qM0R4RXo4WGZpdko2YUZoczBs?=
 =?utf-8?B?TnpSVEo1eVUzamJIU2h6eVBzcDZkRUNHdk82RDhTRmlkTmp5SjVVL293a0NY?=
 =?utf-8?B?NTEzRjJpZmlPWkhXSHpXdlRGLzdoWXNiUWFUYWIyNm9tYjh2OUdsSlY3NnBY?=
 =?utf-8?B?WDBWdW9vL2hMVmwzRmlTV0FMMncwMWkvS2tuSUpHdkpXNWR2RHpRUk9QTmVl?=
 =?utf-8?B?SXJXM2tMOFlpMnVVSVo5eEg1M3ZGeThtWGNKRUw2SVFPVnlxVmFLWUIwODFE?=
 =?utf-8?B?RkhwVVdXUlYxUHh5V2ZCQXhQcHJqL3NheVZMUXVLMGkrbm1adFhPT2V4RnhV?=
 =?utf-8?B?QXNST0tYdWpIKy9tMjg5MzlCYkc3MTVBVTJuM3BKTERRWWlVQy82OGJCcGlN?=
 =?utf-8?B?bHRvT1JNaUkrNCt5Z3Y5MWNiZ3UxanVHZ0lTM2FwcTFKZjdVYlAyREk1aURj?=
 =?utf-8?B?dTVlSUF4eGE0cnJQMlRLMlZZQWYzMndNNmRDS01MNUY0di9OS1FTaWdPVEpO?=
 =?utf-8?B?ZTJYUXJhbXJCQkpYaHNmTmd3ODd5Wmd6YjZvMUFLbmo2ZjdHc2R1NDE4OWYr?=
 =?utf-8?B?eUwvQXk0WnllZUxsNXg1cDdKazk1RnZtbjhMWS84TGc1VmJIQ3o4cHVFeHBV?=
 =?utf-8?B?dm42R1V5NUsyUXlPb1pUNTdPRGtieVhhdnpMU0pIbE0zTFExS3RodE1ZMkE4?=
 =?utf-8?B?WGsxNXhQUjA3V2FuMWJpUENkcUd2cUtEU2lkdnNYSy9vSmQ4bm5kZmszYStz?=
 =?utf-8?B?NlB0amppMEx4c3hqZVJYeFpxUGJ2RjlqblVyVlRocDNwNWloQ2tPeStUQW41?=
 =?utf-8?Q?dVqOz9awjD5Jcy64Qx4zbOoSB+D2/9Hr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6257.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0tHcnBSazVzYlkwOHVSUldoZUQwYmM4VE5HalFNemdzSjcwT0FvcFAzaG8z?=
 =?utf-8?B?dWNWMWlnK25UcUhEL1hjK1dsbTlROWhmTFRndlh0U0l5ODB5K1I3b0RIUU01?=
 =?utf-8?B?KzBlK0s0RUVmcnBCamNnVnJlY1RZTDBOdUlzM3lMcm1pbnJ5U0xWZys5Y2ZI?=
 =?utf-8?B?TUd4MmFPbDJPVFNsd1BHbDFnYzhMVVRQZmlSYmttVUtmS0tiOHQyekk1Ym81?=
 =?utf-8?B?RU4yR0hnSXU0dGF4ZkhNWENUQUtIR0VvRnVTdGtSMjJXS1g1aVE5VEcvQ3BU?=
 =?utf-8?B?aGxQQUFINU5GaEl5WStXVzNPU1JyV0swUVdjU3VOQ3lKKzNheUlOQ01oK3JS?=
 =?utf-8?B?NEJ4NnVPRXNuQnozWTA3ZTYyeVRibEM1cWVVSGQ4cUVLTERIQ2g1MEJtK0xi?=
 =?utf-8?B?WXhEcjZnWjgrK2NIQ0ZSa1FPcURtaE1zdUZ3a092dVVXRFJZUzVydXdmK1VS?=
 =?utf-8?B?NGVVaHNPaDBNRHFGNUNwdW9wVDhSd2dRL0RLYXN2bzZDakdocXcvR2dEbkgv?=
 =?utf-8?B?NEJlY1ZtZjdRMk5KWkd3S3pWcDUwUWdpc0JJa0ZIaDlMYTlyY21vYloxUWEv?=
 =?utf-8?B?MExtRGJkNXpwSnVEbllRdzVSNUw0WmFUYi9jQkpNZzhub3RuVzNkYjU3bzl5?=
 =?utf-8?B?QjJlZjZ4Qmh1OWdqQXY3VGlmN05icncvRnNLZ3NLMG9veFh5Y3VqeU1qd2Qy?=
 =?utf-8?B?aERFc3FHdDdNOHVHVG5mcEtRbG9rRzYrdHB5RnR3YzUveUpKNWoybytOSlly?=
 =?utf-8?B?RzZDV1IxZjZLSDE0b3loKzdpNzNScHkwWjgyZW1nNit2UmhTUXdEVjdlZFVX?=
 =?utf-8?B?RXhoK2hwVVRHZzR2WlI4K096QkJ2ZUQ3TEg2REJIcithVkF1MUN2U1hPdGdm?=
 =?utf-8?B?VWhIR1dOdkJMV2xnTHZENEtKc1RJWEw5RllEUkNIa1lhWGRCOUZjbm94KzB2?=
 =?utf-8?B?Tmhpc3ZOYm9hWklOTU1Wdnd1TktoVUxReldTOWJoa1dNV25XOEQwUHdvQXQy?=
 =?utf-8?B?VXRGNVJzR3hsTFVkYTk4OEUzWXpaUXhrYi95alJYY0E5TG9IQ041a2t3RnU4?=
 =?utf-8?B?OXMzdUUzZTIvaUJrRHFLQVpjbTl6YWZWRS9HNDNya2NzTlViMEo4N3lOSWpL?=
 =?utf-8?B?b0JGM1ZRWEFEVWVoY0ZMWTVTODNhVkdrK2l0Qkx4T05WQkFLRGJJUG5INnBr?=
 =?utf-8?B?Rm1zT0xBY3lzbklZSk0ybDJRMVZJZm5ZOXQrOGpPQ3NoM21SWWo2NEZkai9n?=
 =?utf-8?B?ZGFtdGhhS00rOUtOaEtsV1lLSkFZWUJ5N1g0akhsbURhaEZ0WUxhbExQNnRI?=
 =?utf-8?B?d293VHhCcW1VVmpHT0pWcSszOVhzVjdHeTd3V2kwSG1RSzNlR2x0RWYxakVM?=
 =?utf-8?B?SmdlbVZzYThDODRGUUppVDZ4UDFpcVQ4Y1RDbHRPQ1VJWndiNm9BQUxhdWNO?=
 =?utf-8?B?VGpYV2czOExNNFc1SjdVNjY4bDJtVDdFWUNLYmNQU2ptR2hCOEpqa3JFeXdU?=
 =?utf-8?B?aWdISnVCcEM4YWd6NURFMnJQMGxLU1ZFa3Vra3FRU1BoRE9yeDk5cFJZL1Rr?=
 =?utf-8?B?eFpuQnVBUllXdHZiaENlMkwzTHh4ZzJPUGNxOEdmRVJVSFMzRXFyazBlWlA3?=
 =?utf-8?B?ZlB6eVIwK3oxRHlCamh5Vkt1WVM1N01NRklLOGJpOEYzVXdJOVJtRnh5dzNi?=
 =?utf-8?B?bi9ud3NJMDBLK1J4d1dabUJhZzgweHd1RUt5RFZGTkQ3UXBoRDIwNWZod0s4?=
 =?utf-8?B?Qk1uKzFSN3hMdExHM3dWY2JYTWJ2NU9ZY2R6WmJiYmpEM1N3eW1sSGtVb0lt?=
 =?utf-8?B?c0xpek9xdzhaY1ZTcm9UQjJNNUhmWEJ6L1lPN3dlMXo3OFhPNVlMblpneWMw?=
 =?utf-8?B?Tld3ZHk2QW5nbmQyRXBmTG9QUTJ3R0F5VUNKeGlGZktyeldjMUNzTm05bENj?=
 =?utf-8?B?QUF5WlYrWEhOSmtVc2dmRTlNN1dEUWV0RHZreERrdlRsaTRGRjFwV3laLyt5?=
 =?utf-8?B?cjFvNXZ0bHpDUlRmV3JCK0UxNlhVQnBFVnJhSE5hVkYxYjRESHF2b25JU0J4?=
 =?utf-8?B?UU0vcE4wZjdYNkZoeEJuSmI1aGdjdHplRXNsWWR5UE9UMS9aYzVTK1pucXh5?=
 =?utf-8?B?TjZtb0xPVXAvQWcwd3BQUi85L21MS0RSdU1talIwcDRVUVc1dzBUK2cxUE5F?=
 =?utf-8?B?a1J1dkFqdldOWkJjUGtqTk9RZFNnbEdVRWt6bUpjR0JQd0wyT0dqMUJ6dnQ5?=
 =?utf-8?B?Qk5aZzhGVzhxZVJRV3ZUeEhlNjI1bE95MW9LL09oaHVIaGFzUHg2V205OFlR?=
 =?utf-8?B?NGdSSkhXYS8yeFJGS0dTM21tVUIvUkhlOG9WMHhaRm81MUF3TE4xZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a301e0e-04bb-44c8-33f5-08de5095ad79
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 22:14:52.6454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxXUXDB7fU2sIUIb7lbOlv9olk2hUjnXzlskzLrDdQHnA1zrZZeP/DnVK8wRV9EREwB+FsENXqPx/h9k8ZX/cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260110_141459_080276_D02BAF1D 
X-CRM114-Status: GOOD (  12.03  )
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

>   drivers/nvme/target/passthru.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 96648ec2fadb..67c423a8b052 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -150,7 +150,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
>   	 * code path with duplicate ctrl subsysnqn. In order to prevent that we
>   	 * mask the passthru-ctrl subsysnqn with the target ctrl subsysnqn.
>   	 */
> -	memcpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));
> +	strscpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));
>   
>   	/* use fabric id-ctrl values */
>   	id->ioccsz = cpu_to_le32((sizeof(struct nvme_command) +

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>



