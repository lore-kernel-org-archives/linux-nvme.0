Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1F2CCA47C
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 09:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bjZdwwCze9AxRt7y5L26FzACboJEcVTz3t/HFYXwrDQ=; b=bMJnKoo00rpNAPx2qne6smj02h
	gx5VVXH3VyrR8RrnxoxM5FOQXM1XxCbIp9ACtbjvDzJXjJ7WudeGzSQC0AWw9RNRtH5ZuOC/ErBQ/
	jBklbuQcxbyhBNRb6QAjCzsBD8ut6FechfscTdmzDsW7a9U3a/l8DVrA8sfS3kEQ1tDOXDdKY/NSj
	fFZAyOCPxF/OdD4sVrGbr0hL8ZmkvA2+yEi+SF1iD9I3ylLDLHcachQ2BWXHiy/QPyeQoGy8/DUdv
	3ytnv2huZkRqKjHBXxmwzRVfPPNe1ZnAKTjCizNjKcoHvtLwb3Lr882RubGkkOx44n2058gKsGHJs
	fN7OxMdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6TtK-00AdeB-SI; Wed, 29 Jun 2022 09:21:46 +0000
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6TtH-00AdcD-Md
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 09:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dp7LOLpiVx8347PZ8JxnTeMqufjDNBvmWhZDoqchAoeO3tdY21kzRWgv9TRcG6CQ8hEc9dqmWBtJJEyIvmxRCvpn0ul0DJJguWOguDewS4xDVCpF6s1GVJ9vGqyvsHtir4gnU/bfpzterybDPRe3bJ5kPyAx4k7RVcg2Y4Evol2UvVv+ExIf73n8aXdag+GktMFTxZIjlliB6IC/S+I8AGv+27vE5wGxuBOFfKZuQU1DJwYdTQC/sgY8OMzrEjpD5+UZ03eqMTB7Y3KIFbnHmZdqLZKm1+HkdU+HCqCgUAd5LRxb5M3VC8ZOCcYn7Z9HBNE1onyjFVqxleHa1sJfLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjZdwwCze9AxRt7y5L26FzACboJEcVTz3t/HFYXwrDQ=;
 b=AxZko9+IWbQMhZ5GtI1YWtnKpUfCY8AQ/fi7lxO487kALM2rQbjLQ5hpcmCvwXKBDvpEqWFlwbNZRlu7LtwT9vz1B8b3w3D/qKprJ1O42EcfIkPin1g5a4eawu3sPhHU/5KE7KhULsrS5V0bjhtrGg1uUy47tSUDdlj2xNed7BxojTbCdnsQ/ka91Mp4yp58Dh70/gPcmYkviTf9GDe1ScT/vC1eJsF30wZtGugtzHUBck7co/9rEZ3psJs11xqRV0/068VafSnry6V1chJTCU7CAxLmAYaBes7VLqSI0NIFMi6Ra6neS+yFkIRIwH1iZEBp7C7/GoC0FIhRNYnz3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjZdwwCze9AxRt7y5L26FzACboJEcVTz3t/HFYXwrDQ=;
 b=NGmmDIsQNntA0yjz+Kq+k1nm2jYJVcSe60iUgHMqTmEaXhzoZdJNsoPzrPO/OOFSDKj0L1TmzPQmz79SVZ5SCnJ2B4scl+Bbf+y4Ti7hMlQALNcQQfqtVP11tdWpOMe9uYSLhBRcX72g4+p34T8kBhIIxe5oCwVwWJwCVrGkyT4Bvhsqy3AUFRBgoXPPK8HlhKIF1dB9j7YmLibG8ZFPyjwDlu24bj7GOELhOJmLcchwP92lUwwMHQo6pSWmm6YhRZfKIK/UsjWRWQFNrGvD3iFNjvLYsuyrbTfIlXpumBy3e7q3ECWE4Vz+NOZNjq+++pnvxkhxh/gJgv63Yh0zuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SJ0PR12MB5470.namprd12.prod.outlook.com (2603:10b6:a03:3bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 09:21:36 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cb:bf2d:4598:bdfa]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cb:bf2d:4598:bdfa%8]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 09:21:36 +0000
Message-ID: <ada5966d-5a6b-84d7-f69e-ffab96dadf97@nvidia.com>
Date: Wed, 29 Jun 2022 12:21:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 04/11] nvme: add definitions for NVMe In-Band
 authentication
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20220627095207.105201-1-hare@suse.de>
 <20220627095207.105201-5-hare@suse.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220627095207.105201-5-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0435.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::8) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dc63ab7-3e60-46a4-0b0f-08da59b0c412
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5470:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	gH6+uh0Le7YiOQ2k9WyNDzpSsh+SABZ1hcl1BmXXFAmsRsZRcxDDpYdMyYmQSv0P5sW8pFMk3jnPzTwLhmjz+iAs2uestXUY9ex9sUy1Y2DDzHgFbg2KMUIKFvIDO7q3G3QAouufjpdXRRSFNpTM/TU65km4RAuSic8hlIeHH8/4tyZCzUZl2y3OVQtrOsIaFQszLDc5m0KJs8wgQ2Zw9u+13BPOCWu0BlGcTJt0Mmm0lMdfMSTzrkvb3OBB58oQTefOPPiuk1/JYlKFkoyTLZxnJfLGLhOyBs0vS3NqTLlrYObxTpU4lsLWJqNteCJsAB8ZpGMCLvvi9sinD1WSt61+0Z4jq65IRfHyu6vYRzASsbVlxLQwuXazeWeiZf71zcvw4ocyXZ2/wOigcF1YYtxRuuvT4owkzPHqhfW5ULSdb1/ckR4kucP/DhOQ4uzqlJvpQP2TIWBDAziIyH1OlTEZGpqo0uKvC8JRkVuYe+0AoOorCQes3W3UH1IQvKosikoRswEHcWPUO3Ofsd79fC09RokVBqhOQj0Fy3HjpDpxtsM6O6a7E6hh39rbdkbKkIey3lVEzO5SMuxr493hPZHJSvz1bE109fdgs4v0lTjS6lvAJaj4JMsfrSOjXoZJXh6dwV1iN1vUww1z5P+aDtKFAukVFe8qYSm8B5QmxsZUFym6L4bZEg9wsRMDMyMh43ydgvxfBgAC/wiolYEVV5Twchpm1j+fmniuYB3Fff0V23rnGfnTpyiyI3/qFYW6jBXp1JxHMEe6ro2BpEq9YuqJ+jJbackZqcU/H4nodSYwS6vYql7yTrKERyZfmit3vg8YnjQ8sfPRsfrIqbxI5A==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(31686004)(5660300002)(316002)(8936002)(38100700002)(86362001)(6666004)(83380400001)(2906002)(36756003)(4744005)(31696002)(41300700001)(8676002)(2616005)(107886003)(66946007)(6486002)(6506007)(53546011)(478600001)(4326008)(6512007)(26005)(54906003)(186003)(66476007)(66556008)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?YS9TS0xSYU9IL2JJVkVtaTZzaVg5R1Q1WE40eEZ4K2xwK0lJQnJJaU1HQWx3?=
 =?utf-8?B?K0tYajJQTzJUOXJRSnpxTDZ2VStncWNndmZWRVRHWU9CcU9VUWxuNitDR1Ry?=
 =?utf-8?B?T1d1NExoWGhiTE5PY1B0clFjT0kxakFETG5Xb2NxYWpkdGdlZVQxQTRNR1lZ?=
 =?utf-8?B?WmlvM2NiemRoUXkrMnVFTFROeStodU52ZFAyRnZ0STNHZExRbWRRb1hrWVRF?=
 =?utf-8?B?V0xkaElIRjZFTHBzaXFwZXZ0VEJCdFpJNmxDdHlZWjExNVJRRzJNYlhXbUcr?=
 =?utf-8?B?VmxRUkQzQWxyRmNpakR0YU1VODFVUHdNWVVYWUpFWUZJVTRrM3I5N1d6SkVR?=
 =?utf-8?B?dVhQd0w0bXhZdHhoUldHRmFIK1BvWnJZdXhjOTlOKzlQcXBJZnppNjBQQnRh?=
 =?utf-8?B?d2NGL2E0U3pWK3lxWncxZlVONnFwaHpyOFp6Y1IzSi9zZGJ2RzNEV0x4OXly?=
 =?utf-8?B?Mk9oeFhPckkvUGR3ZnhvUkgvdFZOcVZ5WUFlenNvZDRLTVJBTVc4ZGNsSjJW?=
 =?utf-8?B?VnJYTjdCR1NlN2paNGRUL2RweVRhbys5bUpYbUNUK2xpOS9JNUdRZ1V5a3o2?=
 =?utf-8?B?QkxkSU5oSDlPVXBsZTRCS0QzL0pON1pGaUdSNzFqMzB5WHhLMEExSGk5NUJS?=
 =?utf-8?B?Z3dVdkRWNnY0R0xnNHpwTktUdU9kazJvR3IzWTZTaWhRaW1BOGx4Q2d0YXJa?=
 =?utf-8?B?NmcyTUdIaWlQQnQzeGpSb240SEg4b25vb1U3WXhVc1BjSU8waGg5TmpYTWpF?=
 =?utf-8?B?R3FaYXFEc0hwU2ZDU29TM3k2Wk9hZUhmZ2pZVEZ2WlYybVY3RUhjZkQ0SWxK?=
 =?utf-8?B?a0h3Q2I4TktmWU9sNnhkN2tLMDN5L1RXQ2pZM0UrKzJFSzRjZUdSUFEyNU0r?=
 =?utf-8?B?QmYzTnI0dUFpN3JWY0g5akUxWjdnQ1V3Yms5NUxEbVh0L0p6VHE1K2lnbXlD?=
 =?utf-8?B?aE1PKy9aSDF2QkZDQnAzQ2VGR05ZZ2pma1dwMDhVODk5d2kzb0F0NlNWelVo?=
 =?utf-8?B?OXgxSkNmTEFqYWdRNWdXRHoyaXpMNHlDOVFXMXJiTHpHTTVVYnl0VnFjY1Jr?=
 =?utf-8?B?YjBxWnhDMVBVbUhhTXdlUVdrQTliOTZ3MEM5U3o2WUQzemRaT3J3K21HVnJr?=
 =?utf-8?B?T3RtZFkrRVdkUHYxWDQzaEJsdEhSSkdwc3JoMHlwK29GU0JoSmRWNUpESUFB?=
 =?utf-8?B?aEI3bFFLcE5WWW42UGhveDRDbjVHWWN2QzBaNFo5NUorUCsvTFVGUDNvZGFG?=
 =?utf-8?B?bUY3RWpxMFU0NDlCZGx3emMrQnBHclNWV3hTK2pPYXVWTnhZM2Fta3pEaDdy?=
 =?utf-8?B?Y0NmT1pFSDI5V3dLSEc5dVZtV0NhTFlaUktIL1JtZFlnMUJ5bHBNUjk5aTB3?=
 =?utf-8?B?cnVZNk1ldHk0WWM3Tkx1KzBKZ1R1VmtmZndWU05FSVpkSitEbGgybGlyaVkr?=
 =?utf-8?B?L0tjSnhzbnVhQXVMOWF5L3llOFFGZy9qL1BHRFFZZ2M3T2FWR0lwdEgwNnlM?=
 =?utf-8?B?OHJLbm0vOFdEb05WVVEzb1BWQlNTejlmU09tOGJwVlRYWElWVFAyeXVhOGxZ?=
 =?utf-8?B?YVB2YnQvYTdJdlcwOHM3VVdaMVhnYUo4aGZ5alpnMVJJUnZmNVMrYzltWVpK?=
 =?utf-8?B?Z20vWjduOHdPa2FmM3BYNm90MmNDbm1TRTNlOWJRK3F0VGVBWGRoT2N2WHpj?=
 =?utf-8?B?OGM1UnRPdTZJRFgwZ1VucXhhREpxcHBac0hBNmZKb0l4UGUzQ3RMS2ZQb2Nk?=
 =?utf-8?B?cmxsbVowRzdJdUk1aWVieUx1amIvYnp6K2Q0Y1diKzd6aU1iT3IrMkRPdHNm?=
 =?utf-8?B?cDYzRzZ3Rk8vWjJMbC9SM3IrRWpUQy92VFpmRmRoOVNkOXFIcjlzMmx1K1JE?=
 =?utf-8?B?RzBVQlBEalAxTjdnN0xVbWNYVHpLNGUzOXk0d2dOOCtVRW5HT0tsWnpKZ3FD?=
 =?utf-8?B?bUl6V25UamZKNjRKaUM4RnV4ZSs2MWpDVUxLRktCRit1RXZTYzQwRS9ONUV6?=
 =?utf-8?B?UnBVV2hrZzQ5ZTVKWll2Wk5zRytOejBBME4rWVprSGNteW41dTFwS2NsVEEx?=
 =?utf-8?B?Q1NncFFmbkY5NVlCT3ladjNvUjMxS2lPcmtPdHJndmxETlRETXRQaEN3SUJX?=
 =?utf-8?B?SDVsLzE4QTdOK21OT1pqc2VtVmJkdE9uRk1CMHBKSFFucm5zUFFoYzN0SXdB?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc63ab7-3e60-46a4-0b0f-08da59b0c412
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 09:21:36.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccPuKczS+kXWVNn4PPDVj334S+GZV8T73du2Gdn2UR1VaSQ4voxB+80pPNG/kPGp6WquZU36X67yWPskSX10rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5470
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_022143_797668_77066EBC 
X-CRM114-Status: UNSURE (   9.36  )
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

hi Hannes,

On 6/27/2022 12:52 PM, Hannes Reinecke wrote:
> Add new definitions for NVMe In-band authentication as defined in
> the NVMe Base Specification v2.0.

Thanks for adding this feature.

if we're going to send another version, please add more info in the 
commit message.

Such as:

What is the benefit for doing In-band auth ?

what problem is it trying to solve ?

Which transports can use it ?

Is it only effects the control path or the data path also 
effected/encrypted ?


>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---


