Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAFEC77B75
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 23:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8l0ff5zP5O70g7/G1/NPKtT/63NU94X+7kXdCbbtfQE=; b=RKxgZnGIApH7pZjxx2Qq7cByJn
	CMdttNhKCV8nEMSI/LEYmQKSfaysx1Z81O0tK819Fjd97aUPUNhp5zONpal2E+E09Oxr8q8FHWqRA
	cYGrd4YPCn+LUVWaVAsUy+9lieq2Zai57VvV8ncYL8YptzVoxTl2bE5Oen5lash24ddfIMthYnXi1
	PW0FdZLvkLGFrlyIA82rZolv/cUgFm4aq3HSY4tMJMx8PUy2HPmmXk1rCQxQXCVWp3R9o4EknctZ3
	sw6YSd/loDooowkcV647HmMSGch/zgqvby851dyeqDPe21NV3Nubu9RYv2x1nmvBJ7C7o5YnFyWwB
	BoO6WDWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWZr-004U6C-2B;
	Tue, 09 May 2023 23:17:03 +0000
Received: from mail-dm6nam12on2060e.outbound.protection.outlook.com ([2a01:111:f400:fe59::60e] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWZn-004U5V-0Y
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 23:17:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2YPBmq4CJukdPO1yoEYlZHegCttD4LPdmYdaNoMHZLWEZ79Wk+eeDtIiLXI+avY9rvQMxqfMWnVjkJ6WUcKZm9NK/Wo+wdYbVXm3SBcneOII/+jFPt9j6AV9g7VnTMHuCmr/1Ys9PnA89KytSarqBg1CG5sbN/iqkli+vRch0IWsxTAwJsR1oxfmH9B8vZVRmoRa9fT+DwvAOrJNLjCWEWWCq6OrL5zmbXTzFdsdhY/bgkYP904CZ1DdTDb2MakVmfIEQbXrZ9Iu+BHniDusSKetkMa4TdcFze/DJv70PSVJC2J07eKYKULTNrYtRcAwlPxg9+YjcoYDKr9nmpYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l0ff5zP5O70g7/G1/NPKtT/63NU94X+7kXdCbbtfQE=;
 b=hYHfKhaBoSFoLq/mzhhX3l1e5FadzpEYCvenpGy4it9hkIrwhIWE34EJb0w8Ppstyod4ucrup6WmqxgXFwjwnlfT0GkWpk4S9ixewrkUT6+uza9aA3lkhIX1TujoI6ZaSo7nIBbV6lkmuVXR0mILTy+9q3OscU3N/j1gpd5sZcgJ7BoAwBQQGpu5mHxbIGFYtbb+dAhqS9vkTDyKZE6TVxNFeC0P4d0evwMggmwUOPy3R4v8ALZYMaSYxTXLvw/S+iWBHKvDs6YW1Xn8bTCN4CJwjyK8t5q6OJk4UBW6t07N/Pq1s/inhF+Wi8+AB/vA27/BDt3wS2UBmtxs8acddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l0ff5zP5O70g7/G1/NPKtT/63NU94X+7kXdCbbtfQE=;
 b=Df6BQJzSpD7hJpaQwZ98KJSEej07gaRzR5h/NJfZqGowL2uXJzA1KFDXdsSWogiQrgKxYAQpmW6DBJPi5Nmwfu/AEtZ3hYlrndH7+wCsEVE10xqPZ+ac7RHOd3HzVC4mdF5YNO2IulVvvaZTaZbDGQAqS51s3gnAfUn7ECKD91Vm3D/YSUTdaQ19nJ9q+8tSX0ViFB9o4CeU8H0C7B1Ttif6mYQKLgwsloQGFR56XFGoeYrzYCEHohihlX+duuh/knT/8Rb3tXBY9oh1Mpa/6GYSiA+QTe2SPKcmT+OAPzNSEkSyC/LmScmnciT6xT8IYnSdEefs6NIBh/lheRRbyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 23:16:54 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 23:16:53 +0000
Message-ID: <09624f1c-a1e9-ad8b-bccf-c7696c398b4f@nvidia.com>
Date: Wed, 10 May 2023 02:16:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 11/17] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-12-hare@suse.de>
 <31551564-2fcb-50d2-99c3-3d09473fce06@nvidia.com>
 <55ffd26c-9776-a2c7-99b2-fc45de60c0bd@suse.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <55ffd26c-9776-a2c7-99b2-fc45de60c0bd@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0437.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::17) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b07b624-32f8-450c-5e20-08db50e379e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	bYfwOFFmSALFtmGWZjzK17sxbrNLHOATuDeq4u/FO6RUj6WfPUSE5D8z2f1PKkGzhpVG6cBguUdGflxa6jAznGyiYPHJefslcI61CzYQw1IrlxlDkD4z28bxGtIy3jdzGAbL8rshujP3AH/2ZcgN4imqRaSwHffncLeVHtPZ7cbgS9HXJYKE3QrzhWZ+MmGsWmTASVTksNlhmre4rd9hTdncN7iy2noy3uTfRaDJaOL9/zyEpoMM0Z4gnov4UhtTY9FKpc1bCVUEAxetBYeDrggEvCbV1ApdMFnXuxqzyN1nly63jUXg1n7CoVvv7ZwVkwOWZtCDNxul54uYBGPjxWvLYsOGUJazSeolqlNTuHul3uBLQ0tOFjdauaYWDoCReQEyYbRZP87QHbuP7IYyeVngzgzVJinYPHhGWgEAep5T9tC6IrJVsmHNYCpU+smxmG4d0/n+KAtojVh0z0uebj7jla7v63y9d4LiSw1Xhu4V+eiOsJ7EnsvEq7JdWPHREChwGr773WvSbxVP/45wy1g9BTdOCljln7NOdPNiDtQyPha8bprlNkWBbueUoEV6ygcUvZwSl3D1S9ZVlkKMOjpP0n+ssncwKN1eW8xSZ1oR/jNOp32IdGWEVDy/xtlPovSUlls76jd/F9gI6pvfNmrd+5+ZYmE+JOupw4sxv9QbrqYYol7JwnmT843Psaqi
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(966005)(6666004)(6486002)(54906003)(110136005)(38100700002)(4326008)(478600001)(86362001)(26005)(6506007)(41300700001)(66476007)(316002)(31696002)(66556008)(66946007)(31686004)(2616005)(83380400001)(186003)(6512007)(53546011)(30864003)(5660300002)(2906002)(8936002)(8676002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?TndybmhsZVc3S3F2YTB4QWpHYkZyc0NQOFYzNGdMMlpUR20xOTU1bEJqcDNR?=
 =?utf-8?B?SytPa1NRYTI1SkI2R1pqc3F2dmJwYXhBYitYYTNYK3lsNmpPeVJuano3L1lO?=
 =?utf-8?B?bXhEWVdzdDhhZ2NlaTR1Q0w1SU4wL1BYVG1DMlJ5UWt2dGRMeS84Y1BFOGUr?=
 =?utf-8?B?SDdjWCthbG92U285cndDSlY2M3RzTUo0TDhXWmZVV0VweVpJTGZQQ3FUN1FS?=
 =?utf-8?B?RXZobkVpL1ZsMVhSZW1NQkVTWWl3dFlqZVJndHhYdEtidk4zaGxzNW1mSUtC?=
 =?utf-8?B?RXYvNXFkeWdQZnhmVGV5OXB2Q2VQUERCNFR2aytLYkU1aEpzSmxwT043bS9j?=
 =?utf-8?B?bzNqSjNqait3Rll5TldHUmJrWFl4SUlNbFJ5cy9HaWVXSmk1L2Y3VEMyejRx?=
 =?utf-8?B?UjNBY1lIMVM4WHFFUVo1TklSSzc3Zk00RlhudGFMUklQL2dBS3JFSlZLaExY?=
 =?utf-8?B?TTNFRWE3WWxUdU8yRlU3aUUzdGtwUmxSYW5jNXAra3lWSmJzYU80SDVuR1FO?=
 =?utf-8?B?UitLMWZvTXRJQm9OdXhkSUxlUjZlSDdEVVZSZzRKOFdyYnVhSmN4aU1CRFMr?=
 =?utf-8?B?cmo3Q1duUWNVVzQrbkNHSWZWVHdtUVpnTGZpR0hrUUtaOGRYSjA0SUk1NGh2?=
 =?utf-8?B?bEpINy9ZZFRydTNjM25XT3Z6UVpTRmQ2MmRzdjZBRjkrMDlTODA1ZEhkRUlC?=
 =?utf-8?B?NXRMalVHUFE0bXRyc1NnbjFWNld1bWNUTE5VUnFtQjF5SVdNek0rR3BwQ1Bu?=
 =?utf-8?B?cEx6R2FraVVIRTA1VU54NDN5RHJNV1hhdC9CRW1RNFRhem5uZ0lITEpjcmh1?=
 =?utf-8?B?aTEwQUsvZVU5Unk4R2Z3bGxKanREQlM4MnlnYXVzV0E0L0NXYjU5ODBQNWhH?=
 =?utf-8?B?eDk0RmZNT1RnK2poYnFoTWNDMTNWVC9zTXR6QmVQcHU2K1MwaTBJTHB3SWN5?=
 =?utf-8?B?aWJYL2VidlZ1NHFpZVoreXQzdFdJRy9lQmlxaFFsVTFnblNzY1loVE1sZmxa?=
 =?utf-8?B?bFRVcmQzYnpmcVJmRXdhMVozRkg3OE10cUxPeE5ZMFJteUZJK1c2ZmlSSVJG?=
 =?utf-8?B?VEdQU0Vaa0FPMm1vOEhZVmRxTFBLWHVhRldibVVFTEd4a05rYnJYajhEREt2?=
 =?utf-8?B?WnBRTlYrSVBBNno4dk5LLzIvUCtKU1dYSGtGQjRiU0RNaHpRZHpxTmhiZElr?=
 =?utf-8?B?bVgvMkFUVXRMQzVrbEswR1ozYmo1elplSVpad3lPNElEdkMrcVdROWlJMVF0?=
 =?utf-8?B?ekpQeVdGdkJ5N2ZIclVyOTZESE5qbHBJWmt0QjFnZElzOURHMmNDWXk0M25r?=
 =?utf-8?B?MGdqVVI4aUNQa3NNaDhKK1JPU0xyZE8yYWtIdjhidWxOa3R3SWxMeDVPQjhJ?=
 =?utf-8?B?OUd6ZkZtZmlyUE03cWRpQ05KZTQwU3lyVExENXVYd0piSi9iODdJeEpJczdj?=
 =?utf-8?B?WFZaNWU4ZE1kajBXbEppYWhhbit1Z28rZnpqanUyeGRrelk1aVdhKzFZM1A4?=
 =?utf-8?B?ZmZsRi9IY3M5L1BMVzFuQVlCeGUrNENCM1RzcjBlSHRIa29jeCtWM2ZYY3ZT?=
 =?utf-8?B?VU9OUDBWcktWNWtvbHRxVmJ2enV1aU9lZW5lR0ZuM1dMV0xqY1lqYWxXdXkv?=
 =?utf-8?B?TlN6cjZOcXRrc3Nrc2UwMTIyYmVMQkRKNnRub0FpdHBCQUVSOHNLdmtnNEw5?=
 =?utf-8?B?a1MySU5Mc0VKSWUyOTNQQnlUUTY5YmZTNi82alEyK2d4d1VZTk5GY2xSa2c2?=
 =?utf-8?B?QnN1MDMwRXl3MXNsMFVGc3RkNUtaVFV3NElhMnhlMXdWdVdEMS81aXFNWUIv?=
 =?utf-8?B?U3hSWVdYVlR1MVBOMGJ3SE9EZ1RzK09XUHUvZkIySlV2NzUxNEFrWS9GS2RN?=
 =?utf-8?B?bHUvMjEzd0lPRm14Uncwdllma3N4djFrZ3lxbHFmN2xYcEFNTWFuNFR3cUFN?=
 =?utf-8?B?RzRsaFVldGpvN0M1VTRzellobWIyb2pRL0s5MW96R2RKeFNUWFF1UERwaita?=
 =?utf-8?B?THF0Y1puaFFGVnVEeC8wbXI5cG42TzRxWUkzREFCbGFTcWMrUDA1L3RRbjZR?=
 =?utf-8?B?MEVqQmlrTUg3ZW8ra2dZWFVxNDFuQlJkUkNFZXBpUzBsYnFzKzd3cWh3bWww?=
 =?utf-8?B?MUVxNGRESGo4MXdDTGVzVXU4RWFsOGdhaFhab1FQNGJBTStlWEtoTmUvUGRr?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b07b624-32f8-450c-5e20-08db50e379e7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 23:16:53.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgHW5i1Gr3GZJMZ4QHmOl3hubuw7T65CALtq6OMG/Mtc0hmKL780m/0tjIFKYtZmWo0h4xojsN0LSwSi2mTkNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_161659_258644_463F29F1 
X-CRM114-Status: GOOD (  22.63  )
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



On 09/05/2023 17:22, Hannes Reinecke wrote:
> On 5/9/23 11:48, Max Gurtovoy wrote:
>>
>>
>> On 19/04/2023 9:57, Hannes Reinecke wrote:
>>> Add a fabrics option 'tls' and start the TLS handshake upcall
>>> with the default PSK. When TLS is started the PSK key serial
>>> number is displayed in the sysfs attribute 'tls_key'
>>
>> Can you please explain the flow for the TLS handshake in the cover 
>> letter ?
> 
> Sure. Will do so in the next round.
> 
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/host/Kconfig   |  14 ++++
>>>   drivers/nvme/host/core.c    |  23 ++++++-
>>>   drivers/nvme/host/fabrics.c |  12 ++++
>>>   drivers/nvme/host/fabrics.h |   3 +
>>>   drivers/nvme/host/nvme.h    |   1 +
>>>   drivers/nvme/host/tcp.c     | 129 ++++++++++++++++++++++++++++++++++--
>>>   6 files changed, 174 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
>>> index 2f6a7f8c94e8..96a74041bb0a 100644
>>> --- a/drivers/nvme/host/Kconfig
>>> +++ b/drivers/nvme/host/Kconfig
>>> @@ -92,6 +92,20 @@ config NVME_TCP
>>>         If unsure, say N.
>>> +config NVME_TCP_TLS
>>> +    bool "NVMe over Fabrics TCP TLS encryption support"
>>> +    depends on NVME_TCP
>>> +    select NVME_COMMON
>>> +    select NVME_KEYRING
>>> +    select NET_HANDSHAKE
>>> +    help
>>> +      Enables TLS encryption for NVMe TCP using the netlink 
>>> handshake API.
>>> +
>>> +      The TLS handshake daemon is availble at
>>> +      https://github.com/oracle/ktls-utils.
>>> +
>>> +      If unsure, say N.
>>> +
>>>   config NVME_AUTH
>>>       bool "NVM Express over Fabrics In-Band Authentication"
>>>       depends on NVME_CORE
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 79aa215aec76..937013127c91 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3889,6 +3889,19 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO 
>>> | S_IWUSR,
>>>       nvme_ctrl_dhchap_ctrl_secret_show, 
>>> nvme_ctrl_dhchap_ctrl_secret_store);
>>>   #endif
>>> +#ifdef CONFIG_NVME_TCP_TLS
>>> +static ssize_t tls_key_show(struct device *dev,
>>> +                struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>> +
>>> +    if (!ctrl->tls_key)
>>> +        return 0;
>>> +    return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
>>> +}
>>> +static DEVICE_ATTR_RO(tls_key);
>>> +#endif
>>> +
>>>   static struct attribute *nvme_dev_attrs[] = {
>>>       &dev_attr_reset_controller.attr,
>>>       &dev_attr_rescan_controller.attr,
>>> @@ -3915,6 +3928,9 @@ static struct attribute *nvme_dev_attrs[] = {
>>>   #ifdef CONFIG_NVME_AUTH
>>>       &dev_attr_dhchap_secret.attr,
>>>       &dev_attr_dhchap_ctrl_secret.attr,
>>> +#endif
>>> +#ifdef CONFIG_NVME_TCP_TLS
>>> +    &dev_attr_tls_key.attr,
>>>   #endif
>>>       NULL
>>>   };
>>> @@ -3945,7 +3961,10 @@ static umode_t 
>>> nvme_dev_attrs_are_visible(struct kobject *kobj,
>>>       if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
>>>           return 0;
>>>   #endif
>>> -
>>> +#ifdef CONFIG_NVME_TCP_TLS
>>> +    if (a == &dev_attr_tls_key.attr && !ctrl->opts)
>>> +        return 0;
>>> +#endif
>>>       return a->mode;
>>>   }
>>> @@ -5080,7 +5099,7 @@ static void nvme_free_ctrl(struct device *dev)
>>>       if (!subsys || ctrl->instance != subsys->instance)
>>>           ida_free(&nvme_instance_ida, ctrl->instance);
>>> -
>>> +    key_put(ctrl->tls_key);
>>>       nvme_free_cels(ctrl);
>>>       nvme_mpath_uninit(ctrl);
>>>       nvme_auth_stop(ctrl);
>>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>>> index bbaa04a0c502..2aa8fb991455 100644
>>> --- a/drivers/nvme/host/fabrics.c
>>> +++ b/drivers/nvme/host/fabrics.c
>>> @@ -609,6 +609,9 @@ static const match_table_t opt_tokens = {
>>>       { NVMF_OPT_DISCOVERY,        "discovery"        },
>>>       { NVMF_OPT_DHCHAP_SECRET,    "dhchap_secret=%s"    },
>>>       { NVMF_OPT_DHCHAP_CTRL_SECRET,    "dhchap_ctrl_secret=%s"    },
>>> +#ifdef CONFIG_NVME_TCP_TLS
>>
>> This ifdef is redundant IMO.
>> We have to many of those already in the code and we should reduce to 
>> be able to keep the code maintainable.
>>
> We have been going back and forth on this, and the consensus was to 
> _have_ a compilation flag here. This allows the userland utility 
> nvme-cli to determine whether tls support is available on any given kernel.

nvme-cli will determine tls support using check for "static const 
match_table_t opt_tokens" ?

> 
>>> +    { NVMF_OPT_TLS,            "tls"            },
>>> +#endif
>>>       { NVMF_OPT_ERR,            NULL            }
>>>   };
>>> @@ -632,6 +635,7 @@ static int nvmf_parse_options(struct 
>>> nvmf_ctrl_options *opts,
>>>       opts->hdr_digest = false;
>>>       opts->data_digest = false;
>>>       opts->tos = -1; /* < 0 == use transport default */
>>> +    opts->tls = false;
>>>       options = o = kstrdup(buf, GFP_KERNEL);
>>>       if (!options)
>>> @@ -918,6 +922,14 @@ static int nvmf_parse_options(struct 
>>> nvmf_ctrl_options *opts,
>>>               kfree(opts->dhchap_ctrl_secret);
>>>               opts->dhchap_ctrl_secret = p;
>>>               break;
>>> +        case NVMF_OPT_TLS:
>>> +            if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
>>> +                pr_err("TLS is not supported\n");
>>> +                ret = -EINVAL;
>>> +                goto out;
>>> +            }
>>> +            opts->tls = true;
>>> +            break;
>>>           default:
>>>               pr_warn("unknown parameter or missing value '%s' in 
>>> ctrl creation request\n",
>>>                   p);
>>> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>>> index dcac3df8a5f7..5db36e250e7a 100644
>>> --- a/drivers/nvme/host/fabrics.h
>>> +++ b/drivers/nvme/host/fabrics.h
>>> @@ -70,6 +70,7 @@ enum {
>>>       NVMF_OPT_DISCOVERY    = 1 << 22,
>>>       NVMF_OPT_DHCHAP_SECRET    = 1 << 23,
>>>       NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
>>> +    NVMF_OPT_TLS        = 1 << 25,
>>>   };
>>>   /**
>>> @@ -102,6 +103,7 @@ enum {
>>>    * @dhchap_secret: DH-HMAC-CHAP secret
>>>    * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for 
>>> bi-directional
>>>    *              authentication
>>> + * @tls:        Start TLS encrypted connections (TCP)
>>>    * @disable_sqflow: disable controller sq flow control
>>>    * @hdr_digest: generate/verify header digest (TCP)
>>>    * @data_digest: generate/verify data digest (TCP)
>>> @@ -128,6 +130,7 @@ struct nvmf_ctrl_options {
>>>       int            max_reconnects;
>>>       char            *dhchap_secret;
>>>       char            *dhchap_ctrl_secret;
>>> +    bool            tls;
>>>       bool            disable_sqflow;
>>>       bool            hdr_digest;
>>>       bool            data_digest;
>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>> index bf46f122e9e1..fbcc0ccf2ef2 100644
>>> --- a/drivers/nvme/host/nvme.h
>>> +++ b/drivers/nvme/host/nvme.h
>>> @@ -347,6 +347,7 @@ struct nvme_ctrl {
>>>       struct nvme_dhchap_key *ctrl_key;
>>>       u16 transaction;
>>>   #endif
>>> +    struct key *tls_key;
>>>       /* Power saving configuration */
>>>       u64 ps_max_latency_us;
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 9deba481ae6a..d25695cf4e03 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -8,9 +8,13 @@
>>>   #include <linux/init.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/err.h>
>>> +#include <linux/key.h>
>>>   #include <linux/nvme-tcp.h>
>>> +#include <linux/nvme-keyring.h>
>>>   #include <net/sock.h>
>>>   #include <net/tcp.h>
>>> +#include <net/tls.h>
>>> +#include <net/handshake.h>
>>>   #include <linux/blk-mq.h>
>>>   #include <crypto/hash.h>
>>>   #include <net/busy_poll.h>
>>> @@ -31,6 +35,16 @@ static int so_priority;
>>>   module_param(so_priority, int, 0644);
>>>   MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>>> +#ifdef CONFIG_NVME_TCP_TLS
>>> +/*
>>> + * TLS handshake timeout
>>> + */
>>> +static int tls_handshake_timeout = 10;
>>> +module_param(tls_handshake_timeout, int, 0644);
>>> +MODULE_PARM_DESC(tls_handshake_timeout,
>>> +         "nvme TLS handshake timeout in seconds (default 10)");
>>> +#endif
>>
>> Module param under ifdef also sounds redundant.
>>> +
>>>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>>   /* lockdep can detect a circular dependency of the form
>>>    *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
>>> @@ -146,7 +160,10 @@ struct nvme_tcp_queue {
>>>       struct ahash_request    *snd_hash;
>>>       __le32            exp_ddgst;
>>>       __le32            recv_ddgst;
>>> -
>>> +#ifdef CONFIG_NVME_TCP_TLS
>>> +    struct completion       tls_complete;
>>> +    int                     tls_err;
>>> +#endif
>>>       struct page_frag_cache    pf_cache;
>>>       void (*state_change)(struct sock *);
>>> @@ -1502,7 +1519,79 @@ static void nvme_tcp_set_queue_io_cpu(struct 
>>> nvme_tcp_queue *queue)
>>>       queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, 
>>> false);
>>>   }
>>> -static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>>> +#ifdef CONFIG_NVME_TCP_TLS
>>> +static void nvme_tcp_tls_done(void *data, int status, key_serial_t 
>>> pskid)
>>> +{
>>> +    struct nvme_tcp_queue *queue = data;
>>> +    struct nvme_tcp_ctrl *ctrl = queue->ctrl;
>>> +    int qid = nvme_tcp_queue_id(queue);
>>> +    struct key *tls_key;
>>> +
>>> +    dev_dbg(ctrl->ctrl.device, "queue %d: TLS handshake done, key 
>>> %x, status %d\n",
>>> +        qid, pskid, status);
>>> +
>>> +    if (status) {
>>> +        queue->tls_err = -status;
>>> +        goto out_complete;
>>> +    }
>>> +
>>> +    tls_key = key_lookup(pskid);
>>> +    if (IS_ERR(tls_key)) {
>>> +        dev_warn(ctrl->ctrl.device, "queue %d: Invalid key %x\n",
>>> +             qid, pskid);
>>> +        queue->tls_err = -ENOKEY;
>>> +    } else {
>>> +        ctrl->ctrl.tls_key = tls_key;
>>> +        queue->tls_err = 0;
>>> +    }
>>> +
>>> +out_complete:
>>> +    complete(&queue->tls_complete);
>>> +}
>>> +
>>> +static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>>> +                  struct nvme_tcp_queue *queue,
>>> +                  key_serial_t pskid)
>>> +{
>>> +    int qid = nvme_tcp_queue_id(queue);
>>> +    int ret;
>>> +    struct tls_handshake_args args;
>>> +    unsigned long tmo = tls_handshake_timeout * HZ;
>>> +    key_serial_t keyring = nvme_keyring_id();
>>> +
>>> +    dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>>> +        qid, pskid);
>>> +    args.ta_sock = queue->sock;
>>> +    args.ta_done = nvme_tcp_tls_done;
>>> +    args.ta_data = queue;
>>> +    args.ta_my_peerids[0] = pskid;
>>> +    args.ta_num_peerids = 1;
>>> +    args.ta_keyring = keyring;
>>> +    args.ta_timeout_ms = tls_handshake_timeout * 1000;
>>> +    queue->tls_err = -EOPNOTSUPP;
>>> +    init_completion(&queue->tls_complete);
>>> +    ret = tls_client_hello_psk(&args, GFP_KERNEL);
>>> +    if (ret) {
>>> +        dev_err(nctrl->device, "queue %d: failed to start TLS: %d\n",
>>> +            qid, ret);
>>> +        return ret;
>>> +    }
>>> +    if (wait_for_completion_timeout(&queue->tls_complete, tmo) == 0) {
>>> +        dev_err(nctrl->device,
>>> +            "queue %d: TLS handshake timeout\n", qid);
>>> +        ret = -ETIMEDOUT;
>>> +    } else {
>>> +        dev_dbg(nctrl->device,
>>> +            "queue %d: TLS handshake complete, error %d\n",
>>> +            qid, queue->tls_err);
>>> +        ret = queue->tls_err;
>>> +    }
>>> +    return ret;
>>> +}
>>> +#endif
>>> +
>>> +static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>>> +                key_serial_t pskid)
>>>   {
>>>       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>>>       struct nvme_tcp_queue *queue = &ctrl->queues[qid];
>>> @@ -1626,6 +1715,14 @@ static int nvme_tcp_alloc_queue(struct 
>>> nvme_ctrl *nctrl, int qid)
>>>           goto err_rcv_pdu;
>>>       }
>>> +#ifdef CONFIG_NVME_TCP_TLS
>>> +    /* If PSKs are configured try to start TLS */
>>> +    if (pskid) {
>>> +        ret = nvme_tcp_start_tls(nctrl, queue, pskid);
>>> +        if (ret)
>>> +            goto err_init_connect;
>>> +    }
>>> +#endif
>>
>> Maybe reduce ifdef here and use IS_ENABLED ? (might be done in 
>> nvme_tcp_start_tls too)
>>
> Then I would need to have a dummy definition for 'nvme_tcp_start_tls';
> but yeah, could do.
> 
>>>       ret = nvme_tcp_init_connection(queue);
>>>       if (ret)
>>>           goto err_init_connect;
>>> @@ -1769,10 +1866,22 @@ static int nvme_tcp_start_io_queues(struct 
>>> nvme_ctrl *ctrl,
>>>   static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>>>   {
>>>       int ret;
>>> +    key_serial_t psk_id = 0;
>>> +
>>> +    if (ctrl->opts->tls) {
>>> +        psk_id = nvme_tls_psk_default(NULL,
>>> +                          ctrl->opts->host->nqn,
>>> +                          ctrl->opts->subsysnqn);

After the patch squash you will not need this defaulk psk and also the 
opts->tls.
Why not ask the user provide it explicitly always ? why do we need a 
default ?
I'm not TLS expert, but seem redundant..


>>> +        if (!psk_id) {
>>> +            dev_err(ctrl->device, "no valid PSK found\n");
>>> +            ret = -ENOKEY;
>>> +            goto out_free_queue;
>>> +        }
>>> +    }
>>> -    ret = nvme_tcp_alloc_queue(ctrl, 0);
>>> +    ret = nvme_tcp_alloc_queue(ctrl, 0, psk_id);
>>>       if (ret)
>>> -        return ret;
>>> +        goto out_free_queue;
>>>       ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
>>>       if (ret)
>>> @@ -1788,9 +1897,17 @@ static int nvme_tcp_alloc_admin_queue(struct 
>>> nvme_ctrl *ctrl)
>>>   static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>>>   {
>>>       int i, ret;
>>> +    key_serial_t psk_id = 0;
>>> +    if (ctrl->opts->tls) {
>>> +        if (!ctrl->tls_key) {
>>> +            dev_err(ctrl->device, "no PSK negotiated\n");
>>> +            return -ENOKEY;
>>> +        }
>>> +        psk_id = key_serial(ctrl->tls_key);
>>> +    }
>>>       for (i = 1; i < ctrl->queue_count; i++) {
>>> -        ret = nvme_tcp_alloc_queue(ctrl, i);
>>> +        ret = nvme_tcp_alloc_queue(ctrl, i, psk_id);
>>>           if (ret)
>>>               goto out_free_queues;
>>>       }
>>> @@ -2699,7 +2816,7 @@ static struct nvmf_transport_ops 
>>> nvme_tcp_transport = {
>>>                 NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
>>>                 NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
>>>                 NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
>>> -              NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
>>> +              NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS,
>>>       .create_ctrl    = nvme_tcp_create_ctrl,
>>>   };
> 
> Cheers,
> 
> Hannes

