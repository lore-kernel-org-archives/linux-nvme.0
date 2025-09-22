Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2490ECAC592
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 21:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZZpBW1Fn+DBlm3kbXNtFiTe0UTviGcoamU5m/JZofy8=; b=PlX9tdH/05sePWRjVvOF+jPDj1
	utJqS6BolZega66u6CZwkR/f2HWMOfBQc5pgYKnh8in7aAGDe3LAdvHsY8ZDD/jvF+bO4xankOjp9
	MtXB8BEAeJ7R+IHuSQJT4+i0gPvgt5ignMZsKVIGBf05fGrUe4+GGMFAxRw/XtLNw/WCialEZpdNQ
	fHPXsYiuzKvG+UYhwl07U9vNeC5kjvodGvXvn6odbYCTfraAECOBTfNQ/JT+YDD4ZPowQ1/e6cZLr
	iY+qIt9JYnPv+8yWhtPw9ZTvc2I1nM26Jww9/W9711etEJ5zg7ACNYEV5IUxqHDDCnXwfnmfmsfWO
	vYazM3Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0nxL-0000000BYHB-3Dh4;
	Mon, 22 Sep 2025 21:20:19 +0000
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0nxJ-0000000BYGo-2Ck7
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 21:20:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYnmyji2rQxC7Dpxfb8feuIPAksU6TtnIEm4av6ZTXmYxUcnMcDUXEz4i+zonEFL3tKyqiUwvLRb1Nt3GHJnjdf3dzudtyRNcFVBCERW7l5cXWirMMqg30Ecnv3flNKxXGJBDSSlzPO/gH0+NPdU4HEczJ0zSlzLTspKKaSuNI8Jm61b65iN6XE4TlUts8mOQNGCLfXrxoYVY6xta+z4W7jPk+C2q6643fMi7RHrSKjBPxhSOITrJFpLlZw9uP3X/aASTYfMbRzubDZUWgp/hjg/houiRNC70dgSboaUe5H/kCqzHfpLP95LHsvNnlb8E7b8/IUc93VM2Bw8/wcAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZpBW1Fn+DBlm3kbXNtFiTe0UTviGcoamU5m/JZofy8=;
 b=esjNIAiytCykDBXLnD03Mq+OIIphWcO5nGe8I/3p2T0hX3z3EZwA+jZLPTZdgzuK+ou0Lmx9/tbR8utAgWPcp8fquFnZ2n0+i7DFUvW4fmpLdByM1p93FfSgSuK2yjHMemUQGEHWEEr9iY0BGJJpPmInuaz20L/ZJnAhtTfdupEJDtJAqr0nODAK/QbnbI/NXoufy/VVN8tAD2GZhIOed7ym+jNBaMquM74rbUOCaTr1a9Le2p8X2HRviii2MBCdhZzXwxlld7hSPeUDdw0RVtQVUTbugUJ/pH6EEA1K6dqeNUfgvFgQeNLqPetvYW6lfr3CakJPEXIgOKG1YfGHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZpBW1Fn+DBlm3kbXNtFiTe0UTviGcoamU5m/JZofy8=;
 b=Y+tJInfJ/D7M3eBdp/M+RQD7n0UvwhPs32mGlk8f/ASVixxc9CuFsjyAX1d76qtvR8E13lbmC5tBspnhUo+0Qud1TV+C67TiBwzxesgo4j8MmDOkXBzrRLQp3JruAtqaPAb8STJF/YqQy/qugm38xuCevPR94Fpob8Ii8VKqGuoCTVD33kql8BhJiyhPPI/k+LzTpxEJk6O1u9hd8RI6w2UoG2gTjKxVzwaCf9++1Bfx7/Lq/E+qjYuTX+42i/cQmbMrG/osUwVa+cSF+dsa4E9bgHX8jCYsZAb/MXmDhOXc3yrDf14gDp6zSNiXmkSMs3lPE/9yL7PzRlVSrS9wbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 21:20:04 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 21:20:04 +0000
Message-ID: <cfe873eb-5e39-48b5-9d9d-1e2874bc1e30@nvidia.com>
Date: Tue, 23 Sep 2025 00:19:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvmet: replace transports array with a linked list
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
 kch@nvidia.com, israelr@nvidia.com
References: <20250920234943.4959-1-mgurtovoy@nvidia.com>
 <20250920234943.4959-3-mgurtovoy@nvidia.com> <20250922173540.GC14393@lst.de>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20250922173540.GC14393@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: f38fabd5-5fdc-4f99-7ac7-08ddfa1dcc43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2ZmZmNlZkR5MkVpbWRubnZ5OHlUemduRCt4ZWhJRExvQ0duUEt1ZVhjL1hR?=
 =?utf-8?B?d280WHhncHpVNWRkNlRXNnZvdkgxU0hzMUlVR0JQRi9OYmg2TlUyTTNrVDNW?=
 =?utf-8?B?aXB0KzB2TFlpZkhiSWlscUQ2NUNVZnpuaXFuZDF2NG5ybitIeER5TWkyeHdX?=
 =?utf-8?B?L3pIeStkNmZCV2NPR2ltT3d4OWtKZzcycmhwbmdSalZjU1lkKzRDbHBueEpy?=
 =?utf-8?B?TVIvRDZScng2dHlMRzV1YlNmVmltbFlOcnljaFlTMFp0NWtMdFRGVy9EcDhW?=
 =?utf-8?B?TE5OZzlRcHlwekZkZG9mQWdieDVDcVFsbjh3SXN6N0lpOXBvNHY1YkpxVjJj?=
 =?utf-8?B?dG44N3YvMHFoalN4NkFWeXJ2UHl5M1R3NS91Z2NJbWN5SHhhVG0xMjVsTGFz?=
 =?utf-8?B?bVI5YkN2aGtGUFlDRjFNZTZIYmlFZzF0a0lRTWpwY1pGMnVjQnEzWWdjTU8y?=
 =?utf-8?B?d2M5UXdTcHByeHdrU2RuaUZFVE1sN1ViQmMxckNHUXFRUUlPMk9abjNyOFc2?=
 =?utf-8?B?dWdKKzcrcy9aVlBxbC9pN1ZCRGZwM0M0ZWlKcGxIMVN2Z1o0dVpac09XNGxO?=
 =?utf-8?B?a1dUUnRGaXFVZ24yVXQ1YTJ2QndLRjFRbWlxaWFxYWRBTVROOEdGcTdPQ0dS?=
 =?utf-8?B?VndzQ1NFY2xGRDVucFk4R0NVK0FndzhPTW5pRmU2QW5qdFc2SHBQTDlNRDRh?=
 =?utf-8?B?UHZDcytpdEJWR3ZoTzJCN0hadjkxMFhaS0oxSTRlWU81TkZXUzU3YmJ4Qm1Z?=
 =?utf-8?B?UEhxU3ArU3JrSDhaN1FpSDd5cE5PeFlmK21qRlc5NTNEbVhJQjlGem9oNmdq?=
 =?utf-8?B?MkR1ajBvbHpwMjFnN05ZaXJ3dStCdEZBcGU0N2NCRnpiSEZnTnhIcjZ2SE9p?=
 =?utf-8?B?dzlrT3JtOEdIREIxN3lyUU5jczZGaHhBNVV1VE5QbnM4eE5VZlVFN1p0UGFT?=
 =?utf-8?B?T2lscXE0VFR2T1ExeWxid1hENjNtTEJvZ2IrZG1Rc2dVbG5SVzVtME1DUU9J?=
 =?utf-8?B?akJ4c2o3am5tM3Ezd2xOekpMRE5kdzlZMFIwRW5naVZpOHFodWZxbmwybnZr?=
 =?utf-8?B?OVM2em1FQTVRR2JUdXIxUlNDekFZNGlnU3ZaSHRoUXVHeUhmZlFIcDVDdkE3?=
 =?utf-8?B?RlY3WlJhc0dUR2VJMTIvRStlR0NvRmRKdmd0ci81QXRaaU1DRjZiY3g2UFFC?=
 =?utf-8?B?MytqVDNRZjhqVVlUVTRtc1ptYWJuWkMydmN1YkJpQmswYTlScDY2ZlVmR0JB?=
 =?utf-8?B?S3lDU25iVU02YVdMYjExU0R4a3RQN1RwUDlya2VsLzZveU9FT1htT01GT1Mw?=
 =?utf-8?B?YUErcnFIKzVvMGRlQUV5NXpxNWNmUzJzdVQ2Q0VwQ29wMlAvYk0wWThROTlk?=
 =?utf-8?B?NTZSaXVWd3Ewcy9DR0NkcG9YMTRNUStiQVQxcEg0MytzZW11WkZGNTZ6TmtT?=
 =?utf-8?B?OElqSkdJMTdzMmpsTzRDMDNuY1ptRVZaLzdDRGpQay9VOVVqcWRuaWtVcENI?=
 =?utf-8?B?dTR4cVlQL1FkdDd1dHVnWFlSNDdVbXZtbEtGdWhxVldJSFJ6ckVyU0c3dFBE?=
 =?utf-8?B?VFZOaXk5Yzlhbk5wTm1uSWFUZTd3REozRm8xNFhHVVJsTW5WZ2VLZGorUnV2?=
 =?utf-8?B?aytWdk01bm0vRFNaTCt2SG1UcmF1Z0s2KzBGNHVhS0JNbkZ5SWgzOGxZRGpa?=
 =?utf-8?B?NFRLUW5XQUpKbE5Tc1pRaUhUWG93VlhJcW5taWlMV2wwVTIxT2FsRWVyQ3Ew?=
 =?utf-8?B?d0dwWkYxT1l4ZUY4aDNRRndTZzdQd3RFSitVVXNCblR1My9lSmpTb1ArdGdo?=
 =?utf-8?B?NlRySHZxcTAvUFBQSzR2QUJ3RzRQT3prMW02dTNNeUJyL3IvV1hiaFppWWFm?=
 =?utf-8?B?NUloWHFxbEFaemMwb1hQWVVpWjFZNjZRZ2pFWGpvSHppMFRWb0FLbG9ocmFC?=
 =?utf-8?Q?s2EemEyWBjw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkgzVk4vMER0Z2tKNStKRkhoczFSTEwvUHFKM1BXcWJBejRsaHYvNG5nRkZE?=
 =?utf-8?B?NXBpdVFiSVgzQVVOZkVvZU05NTQ3d280N290SVBxWDZCM3NJc3ExUXBXdHVO?=
 =?utf-8?B?K3VZK3dtcGdSeFlNY1hLMjN3SGk2U21kdHVCeUNmRnYzRzRzd3RtWG9RelYw?=
 =?utf-8?B?ci9ucGhoRS9DSlBLSWhjSEhQMjBBYXpRemIyWGFnSTVENHFSUmdUOGtsUjhr?=
 =?utf-8?B?Y290NDJsRVp1anp4T2VQZDZpTXRtbVhibURHZkVycmRER2wxWWpwQ0EzTW1D?=
 =?utf-8?B?Y2xMSnJmeWt2RFVzRHVDRUhoM2Zxc0FQZHQ5TC9waFJmeWUzbk03ZFJEdWJp?=
 =?utf-8?B?VkZFLzZjcFJXMTVtYVZFS3ppME9sbmJrb0p4M2NZMU0xRVNFSFVVRk1malZ1?=
 =?utf-8?B?UDRJajJlQTlRV01JNnFkall0WDU3UE1yK1UxQ2QzNzNPRGhSaitiaU1pZkZP?=
 =?utf-8?B?ZVNESzhVcnMyZldIOGpWLzFoZkdVd3hmQ2Y0Q0RqamdSdE9QcTJkeVFCcUJ3?=
 =?utf-8?B?cHUvZTZHMjVLWm5MS0JmemFObUZMMG5kUzFMUk8yZjRmR3VkaWphY3FYbmR2?=
 =?utf-8?B?TzJObEI4UkMyVEFuWjg0Q3FnVUQ3VVJXUHZpMjVhdTlhcUdHL1d1dTB5N3Zt?=
 =?utf-8?B?eXdJd1FwOW56MGNaQUg4QnIxNHRidE92aUh0bGV4WkFFcmtwMXdVblpwUUxM?=
 =?utf-8?B?Z21lT3RaU1BPendwNUZUa0NUR3FRQmJQZmpsMHBjWmpvVm42MmFJWEExN2xW?=
 =?utf-8?B?dW8xZEwyaVhQKzE3LzVWdHp4Skh3aEhPTzNhY2ZKNytFUXRzdm40QXN5VjFh?=
 =?utf-8?B?eDVhN1dUaW5SZzVQL3g3MCs4bThjTkRDeElJQW84azdaUk53bXo1ME5WQTdN?=
 =?utf-8?B?dHNiUThUUUZSUnV2Z2ZudzFVdS9mY05Kbk1XWWhaU25QTUMrSUxPQVBNK0Nx?=
 =?utf-8?B?NFBBV1FXTFR1eDJqeThnWVUvTVQrQkoxNEIrUUFFbFhTSXRBdktuOU1vSFBk?=
 =?utf-8?B?V2E0dXgzc09yUzQ3N1Z2WFRxTFVkcUUrSlZ1TFJPdDZjWWNMQi92aXFIaHl4?=
 =?utf-8?B?b3BvYnFOdXY3dFl1NUZUR0lEN3BRNjVyazJmbENyL0NOaEdMZXJDL3M3RVl4?=
 =?utf-8?B?bHBGeUVGUWFuYm9WWERCbEVvMlUzbXNoVnVjc0NWZzZEek4zRlJWVUpvcjB4?=
 =?utf-8?B?RHN2WENudkd6VC8wczA3SW13dktGS0Rwc0Z3UFlzTkhNY3YyYmJWcE93ZWdC?=
 =?utf-8?B?a2ZVNHFiM0VsT0xBdmZJdmNjNDFMVEpnTVJKU0hXKzVmNzFyR0tCaTRmd0Mv?=
 =?utf-8?B?dDlaYU4rMnE4ZURrNTVJSFhPTjZHWnl1V2RodXpQZnJ1aFM4MkcwbUpkNmZJ?=
 =?utf-8?B?MzUvaFVlSkQvczBCWURDQlJiaUZGZm1zaWJyZzVCTFhGclNGNE1tYmZ1RElD?=
 =?utf-8?B?TStBamNEc0p2bC83dXZRWTlVU2V5aWh2aStEVHdUMFEwRU1rMHhPWFBma3Bi?=
 =?utf-8?B?eVIyNkc4ZWh1WFk2NXRRWGlKQjVnaXRUVXl1TlpzN0ZEekNlS2Z4WUNmTCtz?=
 =?utf-8?B?bHUvS1c1TWdkWHU3dFdPeUh3MHFOMmV5Skp0NDhTM0VuWUY4MzFLZk5FV1ZQ?=
 =?utf-8?B?T0VzYW1SU0VVREhvbXJwQmcyYkhkMG9HQllocWRoMjlIakFqbXZoUStpTm5M?=
 =?utf-8?B?OHp6RFRDd2dWbitmcEhSWi9CdlBzWlMxMEJpSVE4eUpJS1NPK3liV0tUVFZW?=
 =?utf-8?B?aUgwNnFqb21vVlRTZXhQY0Y1Y25OaE5CZjgwc1RCbEY4U1pOZStXUEkrUlVW?=
 =?utf-8?B?T3d5Q2o4WlZvQjVTL0dkbEswakRBNkg3WFI1UlBrRFI3eW1iUHhRc0dESWhX?=
 =?utf-8?B?YVZyRW1KbXcyTkpnbTJ5N1E5a3pjL1B6MlY0dWJhdzhKN0xJZ1JweUpZM2hG?=
 =?utf-8?B?ODNIYXpFd2xWbmN1OWVVd1BwRlpZTEVhaVppOXZ3L0RLSk5mU0l2ZG83Mmgv?=
 =?utf-8?B?bWpPQ0xkWXUrS3lJbUFtNFJ3UDJIZ1JScnVRUTIxZzY0Mno2NGpjVlBzRUx0?=
 =?utf-8?B?VE9LNDM1QWxQY05aUERoeUEzWk9RVDNSRWtsUXZNNmFXL3hPT2tyQXFTY1hK?=
 =?utf-8?Q?Sn9ykpv4eUDxbNUwowTI6Miz3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38fabd5-5fdc-4f99-7ac7-08ddfa1dcc43
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:20:04.6675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adIpS8LH17SvEhPzRO1PM7o3RbqPzMXDDRlzi+gNb9gjoG8+/FxF8B1+/a90PHZ0zYVLGZ/TQcMr98IOBHXcPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_142017_569678_C0DA72DC 
X-CRM114-Status: GOOD (  14.47  )
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


On 22/09/2025 20:35, Christoph Hellwig wrote:
> On Sun, Sep 21, 2025 at 02:49:43AM +0300, Max Gurtovoy wrote:
>> The nvmet_transports array was sized to 255 (NVMF_TRTYPE_MAX), although
>> only up to 5 transport types can ever be registered, resulting in
>> some unused memory. This change replaces the array with a linked list to
>> store registered transport ops, substantially improving memory
>> efficiency by allocating space only for active transports.
> This adds extra code and makes previously const data structures mutable
> to save a little bit of space, which feels like the wrong tradeoff.
>
> What is your motivation here?

The main goal is to save the wasted memory (even though it is no huge).

maybe we can do something like this instead:

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 655d194f8e72..8e076960875c 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -68,7 +68,7 @@ enum {
         NVMF_TRTYPE_RDMA        = 1,    /* RDMA */
         NVMF_TRTYPE_FC          = 2,    /* Fibre Channel */
         NVMF_TRTYPE_TCP         = 3,    /* TCP/IP */
-       NVMF_TRTYPE_LOOP        = 254,  /* Reserved for host usage */
+       NVMF_TRTYPE_LOOP        = 15,   /* Reserved for host usage */
         NVMF_TRTYPE_MAX,
  };



