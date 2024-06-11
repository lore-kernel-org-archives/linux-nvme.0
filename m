Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2998C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 11:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xM2KCq5EvMs3QrajVors58+0a4G7RXd/HxTWHlBo4Tg=; b=VMWWryVMlHj9Z3+HmzmXenu+gf
	GAkda0Ul/dNOpBHaLz5Hy2PwlC64MRo1O4p8VEFZuR7ws5eivOB+8LVv8lpZUj5pqNRJFmVVTyAzI
	r8ZMERp7IGKzrvg3/SP9Oyp2B98DedjZjQuh4uu+O4SSvYOAvYY592WJUkaspapt6k54RSL9YIn3C
	Fsf+zNEXiNdjjY3t5OESFKLO4jStla/K2yW0zYl8NJvQj1bn2eKOxzea0tOBsJ3HI4DFpmF4X2h/G
	v8y06O44hNLeTtj4HWqJWgIh57VVzdRbQyc6lMb1eJxSw/Y7EHUYF+NUbupSkybafToafIXfeQnGB
	488Ud0vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGzyX-00000008j7x-329Z;
	Tue, 11 Jun 2024 11:47:41 +0000
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2415::600] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGzyS-00000008j5m-2KrL
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 11:47:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWcANBfecrKd+Bf9qJ3Pon/paPQ35ML29plvgJQdh4pPgh57ooOapqX76aNnxvQUzRIdWTueGfS/1xV2B+ua6BjLzpPFhi1N/2wQuOSoaKTa2hDM2vEd2/bGvhWRthZD0Ng/GAKnvZcWY+IoDTrJUDCHcgniQukPkhp+RCiuVLGzxOpiD+sDricuCpRLHRJYC3HA4LAJQTRb76c0PhaKEp0iJb6CQlEVfIcBMnfWAjPC7Hkj8qvpiCxU5Qb6KFThY1BMSuGX8x+Pd1LJc/fkin2xzbglsFm0xizLISmbL9PyOyw26XqqFVw7CBAOrRx9NRsDsTQ1Z2lYj22GEPRpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xM2KCq5EvMs3QrajVors58+0a4G7RXd/HxTWHlBo4Tg=;
 b=Wiv46T19VoDZVmcp1YKpmS+Qt2FB+iIKP3yBpj5/0+i1uymEE7mHtRbz46byAaM3ui0n0x9VWYGEyViyfEmGdH7zRobm+fOc/MNtk/pGhEKCcA2UfnVumPja8X7OKidvhcZ3JCNbK5FXT7+wLYvnk29zMYyuNyxdm2M/pxJuGaWlB4EN0qoissS7XMU4oji2dta+qG9qRT59H5jzD4T8+vaEnuxtcngi/CYwrlEX1d6oRCZB6f8tnP3g+si5SrmK0WB2HAz6DPSHpfzCv16nDT6oxlyF3dlpvI5apDiWRLuqCrlQsI/kFs4nNO0LXCBai/vZEsWQUebubiq7biBycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM2KCq5EvMs3QrajVors58+0a4G7RXd/HxTWHlBo4Tg=;
 b=ta6QcLz0AiM6DClEGa1bLBw3crYZ+RlKyWIK5SlV7hdXJLULPlfoPQdS/SWXGpSJlX+EnRn4Xg0b7kGX88Yt47k4IP4GpRf6p7uFX/uZSwvbuzzU83BygT/lHhSFC+mkStTFhm7s3w1SGT9lNXK4POsfFt/fiJr0gqY+1eYj4AMG2praFC4dF2ZBA3Gqcl8clNs32ji/dT7r+bl9T0LTs0rcoy00IXVlWNTkIrbgzRyR2uV4ox4zexP7rMK5gizo8H0gdkY1nLTXEgVYmojC+TrA/IFL4heC4xYKZiqzjGJYcEY3YLWzpjeHGhSryrGIoG32QZZ9f7NX5KWjDzgVuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 11:47:30 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 11:47:30 +0000
Message-ID: <da056c53-cbed-40c7-afa4-e8b57c48e0b4@nvidia.com>
Date: Tue, 11 Jun 2024 14:47:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: avoid double free special payload
To: Sagi Grimberg <sagi@grimberg.me>, "brookxu.cn" <brookxu.cn@gmail.com>,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, maxg@mellanox.com
Cc: linux-nvme@lists.infradead.org
References: <20240611100208.115211-1-brookxu.cn@gmail.com>
 <c6b15807-dc35-453e-b162-982fca77443f@grimberg.me>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <c6b15807-dc35-453e-b162-982fca77443f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0092.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe0e8be-7d16-4af6-49e3-08dc8a0c4638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXBFeTRrUFp5L0xZZFd4cmcvOW1nbE9DcE9XZWUvRDZiTW1Wcjc5ZFZ3dXJu?=
 =?utf-8?B?UWRNOWRJSnJhU1BlVjZ6MjFQN1pBUzhRMjloVGZKVDRJQXFINmNJN3UzMGFB?=
 =?utf-8?B?VEx3UW56K1kreWRRUzY4TkVMUGFmQW5WQnFwVDZGcWg2ZmdYTmRsZzhKb0tP?=
 =?utf-8?B?Wi94RlRpa3ljVDQ4MFo4VWpJeGpIa2lNUWNrS2JQTXltS0tqNGE3Wm8reXgr?=
 =?utf-8?B?R1R2YklscDBUWGNVelp5c1prTnJvcnpURjJ1L3Q0WTh2NHlFa09aNjVIUkUv?=
 =?utf-8?B?Q2FMQ2hEVS9yTS9hclRHR0tqSG5kWXJBYWdVcVpnRDlINTYyTlN5WXR5RHNK?=
 =?utf-8?B?M0paT0s5YmN6OWY4UVdBaWIvNDdPNnQ4VlJGcWM2ZVBZbmJDb2RvNUI5SnB0?=
 =?utf-8?B?dE9LYzNjeWhzcXVVK3pvcFQ0LzdyMFVQR1ZKRmdmcUpiUi95RHI5OUxUSG9z?=
 =?utf-8?B?VVY1ME52L0ZiUzk3RThSTHNORjh2ZU1HQVJNMldkODJIanBlRmdLbGNkZCs5?=
 =?utf-8?B?eDNrZkY1NkJIbFRmVEZTTDQvcVZUVmNlOUxBQlJMTUJHRWc2ZzhJQlZJUUQ1?=
 =?utf-8?B?a2hBekEzN25HWVZrcXZqeGVGK0ZiZmZYc2hCZTgveVB3bHRCMjFzN0tDZEMz?=
 =?utf-8?B?MVR1K29EZVIrSGxRYTJWSTR6ck1ZanF1cnVTaDFZTGNKTE1QQ0h3U2UzMUZS?=
 =?utf-8?B?V01GeDhFNzZGVW5OSXcvWFpzMjFPQVZqRWRMcTN4TEdjNDZQaWR6UUJHMEtz?=
 =?utf-8?B?eUUzd1hwVE9wNGRhWHRiT2JuMnBjVldqcFI2Z3Y4dXd0NG9aV2lOWHByc0pC?=
 =?utf-8?B?dFB3RWpLMC9ZTTVsSGdnOHBDTjlmbk5EbUZwUDBHVjhSZzcvK091d0xwaWJP?=
 =?utf-8?B?cjVKTGNvOHU3Q0JVcmFTSGk3elZWTldPOGR3V1lNd3JhMDZwVkZGREkzUEov?=
 =?utf-8?B?UTRoMGVlbE8yS082ajdEeW1pczZkN1FJVVdwUVpqS3cxbVliN0h5amRBTkVm?=
 =?utf-8?B?SXI4K0FOSVVlNllGQXMwd0VnNmlBNHYwUVljN2N2VUZWaWhYU3MyTUt4eTRQ?=
 =?utf-8?B?NzRqQi82Q3R0WUdSUXVjcGswNUs5djBOQU5UdENFVDhwNFpWaUZWWU9tTE5k?=
 =?utf-8?B?dGdBNlpBOW55ZWErNlU0QXN5ZStmdE1XVWtiaTNVbWFSMHNQR0U1L2pmbnpT?=
 =?utf-8?B?bjdCQU5KMUdVVENIUFQ5T21SaldNeDBRV3B4WVlkSGs3amw1dDBCd0VURkVp?=
 =?utf-8?B?VGdvajdOTDZRZThhR2h6TnoxV3FmMmRrM1RpTG16djVlanQ5bUlNQUdZbW9X?=
 =?utf-8?B?M3ZtdWtCaWFyVy9QdzRKV3ZSNytrQnBPRmxDQ0J6S2oyUThyU0wxdkE0OUxZ?=
 =?utf-8?B?enlYcmlFSm5Fd1pGSFZNTVdYWVRIb2dZcWRMMEhSZXREWWVRRXI2ZGxCVTBu?=
 =?utf-8?B?aWNHMWFqejBiOEYyaXcyZUN6b2M5Q0dYMUtIVjdETHJ1WG9iVkV5YWdYMjBH?=
 =?utf-8?B?Qm5yRXd3VmpSMTcybVM3Ty9nRjRXTitNTTFCTWJxekoyeWZMWW1wMXhWSDhi?=
 =?utf-8?B?dVp3cEJQY1hTeEl1ZkpWOTlVb1F3OWdKRVdnQ0w1Y0llY1pRZmR1c3NRbm1u?=
 =?utf-8?B?bzlBeHl2WmdCMk14ek5HNWhFeVpNMDBSdVJIdVo2UjFnMVVRNlVSNkUzWkly?=
 =?utf-8?B?UTdDd2s2ZjlKN0ppcjNoMFFGSTNFWm45ekd6UzAvOVJTcm1GNHVyaU5aSFl5?=
 =?utf-8?Q?eU4kbAsSyvDdB5LMw7D9WS6e1/B2DfEv0PXa80w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk9OTTJBaEhRWW9iM2pPZ0J5Nkc2MGxMbUV4UFFkVjJncGxuWGVKTzJzRjl6?=
 =?utf-8?B?MDBsYWxTU0tHa3JoSnh2akdWRDllV0V6UFJqbUJUSjRaVnhhL3hLVWEyTUt4?=
 =?utf-8?B?NnF3ck1Ga0VBSkpOalVXK0tmZ3hoTzBJcHczZ0d2TmgwMStBQ3g3dFlzRGxG?=
 =?utf-8?B?SFdRRUw3K3VCeXJyZm9yRzgzbGRKMERVSWFhcWdMejk2eklEL0M0ODN0b0dS?=
 =?utf-8?B?b2hEN081YU05cUFSWjBHZTY0NFJIRk1RemFPMUN6MnY2VzRmc0poMkNGcjhO?=
 =?utf-8?B?akhIWloxNE5KL1VnRDg5QWR1b0tJWkNiS1ZuUkpCZkVGVWcxVE4xV0gwU3FD?=
 =?utf-8?B?VGQ5eXY2ZEk1a3JLcXFpMkhCNWxSOVBSaStTRndRTDhZNzJ4blhFNXBPOU9s?=
 =?utf-8?B?ZDA1aTZVaVVZRVhtV1pJKy9JZURMOGkxempkNDlFa1JEZWpZL04zcEJKUTRJ?=
 =?utf-8?B?azV1TnF6WHF1ODZUT0ttdGpvTGl6b0JTQWVaTTVqTXdFN0RranY1WG5jdFFT?=
 =?utf-8?B?aTFKV3dPckNYNFNnU2ExaXlUQ0dKa1U3M0tqaXpmVVJuRC94Q0NmM241aXhp?=
 =?utf-8?B?ckxId1MzREkxWVBkM3JwZFM5eEhiT29lMGo0dVIrTXFrMHRLWDZHS1EyeXFQ?=
 =?utf-8?B?R3RTYWlWbjg1Q1Q2aUpTS243SFEzS3lQMTZIelpzcER2ZnVPdXdOT1RHQjZt?=
 =?utf-8?B?UzdNUnRRTnRMV2VtUkxYWkpzVkRvbEE0eUhMNkhDNDBTWVhwUDdxdXNkZS9S?=
 =?utf-8?B?S0c0WXd5TGFYZ3hPYzRXNWFveGNsNlJ4c2xUeGFhbUZnY1pQbjhuYWJLbWZk?=
 =?utf-8?B?SEU4N2I1ZVFpbSsvMFBIcGF2dXlCalI2aUdtQjgzWkdGdHFQZnlIeko2N2RO?=
 =?utf-8?B?UkpFWjhQUWxzeGVmVUJIS0F6dzZDbWVMS3VrK3VnS3VONk9MT1FJWUxic0R1?=
 =?utf-8?B?dGNIK3pFRlIzMFdLTDdzVy9aMHp4SE5DZ096aXVEczdGMEJ5am56cEJ5dzdu?=
 =?utf-8?B?Y0dsKzVHbzFVQmVFNGN1V2hOb1pMamRuQmlLUXlKNXVmOFNUa2Q4a3VnN0tk?=
 =?utf-8?B?NXE0WTNyVzBVamVSbUlDYk5xRUdnSjM5aFN2cE11c3krbVVZbmZvWEh2RW9N?=
 =?utf-8?B?TEdjeGJxS2JNK3J1MGUyWTJ5RDQ0TFBYRVFUK2xRL0VGcjRtcGJTQmRrMTVF?=
 =?utf-8?B?TlZjVGNON3R2Yk9VYWI0NXdONDNjZGRWOXFYcE1VeW1XWTdobWhzTVdPQzBn?=
 =?utf-8?B?OTNuODIveSsxVElwRjIrNkVqVmgwNXRIejBvL0x3dExzSm5IV254cnpYWGlo?=
 =?utf-8?B?QzNQR0dYeXRJejQwYjFETDBvU3FpbHpMWXhsUHNDUmtaaUVKb1NlU09OUml3?=
 =?utf-8?B?VVp4S2ZlekREa3EzVmlLMDJhWmtWOTUrRkgwSDNpamk3bTlHdkxCR2NNaWhF?=
 =?utf-8?B?Q0FaZUY3VVBWYTFiRzdBc09kWFU4VHVEbHkyMFVkWW43U1cwaTI2Y0xrVGY4?=
 =?utf-8?B?OWJVR0p2WVYxL0lyMTl6WlFvZTI3S3pia1AzTUpuTytCdmpWZlFPTlhBb2Ri?=
 =?utf-8?B?UDkyRTBTOUZUZy96RGgxNUljSVIwa283c0Z4K3ZnMERNY0ZqVzcxZGFBUFdS?=
 =?utf-8?B?WlhqUjBKTHRHYmdrY0crQmkyV3ovYm00eGFOMkROeGVUU1Vya1hudHhER0tk?=
 =?utf-8?B?NXdYdGFpWEd5K2g2MHZlanFmcVhRdFhFMitjMG14RTlqK2psV3FvV2JqNStI?=
 =?utf-8?B?cXZzZmQzbVkwMDVCWHc2S1luZm0zQ2UvR082U0gyd1VRazBRYTFrelFweTJn?=
 =?utf-8?B?VkFsanBFeFE4YzNPOUhqdHFad0tmL1lQWG5JQU1TT1hZM2gvcGdKWnZsZCs5?=
 =?utf-8?B?UmlHSDhXOWtoNUxsVnNmdlpTV0x4NHJyRzhPZjJDT2VhTXJOUU1WL0d2bjJa?=
 =?utf-8?B?aW96akJDNW1ZZTJYaGdYditETmFHUVBKMmNyQmo1UEtjYWNlRnNHYStxb1lB?=
 =?utf-8?B?NDJrZEJTMkdRRVNIYlpDbG5qclZmcUJKSThCYmtYL0RUN2dzZjFMMDVxN0NX?=
 =?utf-8?B?OVI4Tldza1M4aDB0WFJnSFpncHRZZnVpOWtMdURUeGovdWF0RHplT2hUQW81?=
 =?utf-8?Q?52guyJzzHmitA/+knhXPhxcT6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe0e8be-7d16-4af6-49e3-08dc8a0c4638
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 11:47:30.4553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KaPIu0oLpk+VhdlZiM7P/bLf6zR9uKqfMyQ07CGYJejcp18nMdUw0QkaLYh8hCr6jSstia/PcWUdlDfhZC4Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_044736_679185_E5B5CB43 
X-CRM114-Status: GOOD (  12.10  )
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

hi,

On 11/06/2024 13:53, Sagi Grimberg wrote:
> Looks reasonable.
>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>
>
> On 11/06/2024 13:02, brookxu.cn wrote:
>> From: Chunguang Xu <chunguang.xu@shopee.com>
>>
>> Now we may double free spacial payload for some requests, such as
>> discard. This will corrupt the memory and lead to kernel crash. Now we
>> will free special payload before retry it. If we disconnect device
>> before reconnect success, then we will fail request by
>> nvme_fail_nonready_command(), as a result we will double free
>> special payload. Here try to fix it, we may can clear RQF_SPECIAL_LOAD
>> bit after we cleanup command. This will not broken following clean
>> logic of blkmq, as nvme request will not be partial complete.
>>
>> Fixes: 16686f3a6c3c ("nvme: move common call to nvme_cleanup_cmd to 
>> core layer")
I'm not sure that this commit caused the bug. The nvme_cleanup_cmd() was 
called in this path also before this commit.
>> Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>

The fix looks fine to me, but the commit message can be improved a bit 
to be more clear about the scenario.

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

>> ---
>>   drivers/nvme/host/core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index f5d150c62955..c40930d10bd3 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -998,6 +998,7 @@ void nvme_cleanup_cmd(struct request *req)
>>               clear_bit_unlock(0, &ctrl->discard_page_busy);
>>           else
>>               kfree(bvec_virt(&req->special_vec));
>> +        req->rq_flags &= ~RQF_SPECIAL_PAYLOAD;
>>       }
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
>

