Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0FDC47073
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 12:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s2+0AMKAznXYS/+sUW1IdemkslcU132B/azaLkcdIhM=; b=rWue8fP9ujROWAcnfDlGSOqRJ3
	pzS9rrgKAplgtE7eAfDD54ygFi7PU+NM0oyW7CgRN8fqn09IFUA5yoh4OI9iH6yUrkbtd1EE7j6eh
	m8iqkaUIAT0V10skENYUmpMT6NCoW5pEhuMyYEvCBVAeQTBouaaeiYfghfmwmkk2BcTRhgx3Nz5j9
	y4vKu1VgUq4gNb9ygXwxWRAfMqGdgAQTbElylCs76QXxV38mULNUf915P6Nzu4cFIX90TrMxHjfW3
	/WPHqR6Mp53de+HNBUx1qku/OBrTpr1rvURYOncWBOCHVxEXvm4aN4ePoGHAYVzY+JIfwCEGvJAel
	3Yef5mFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKHVf-0068Y3-1I;
	Mon, 01 Jan 2024 12:35:11 +0000
Received: from mail-bn8nam12on2061b.outbound.protection.outlook.com ([2a01:111:f400:fe5b::61b] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKHVc-0068X3-0L
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 12:35:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3ZpcuS9PLedY5E0B+3F0XIdYV1VlSFiCTxGCofkeJiOpYZ3PPh2WyRg9eCOKnQ0Ye6MHFJ2ubNV4n5wRuHvCVONEx1aFuImtZWoJGsqWjgigdebJu/6+BocwYjMbRpxc9tTzG2feAMx+5ob6twAF7qTAOpCEy0KiQkAn0cv4Ds6mmtOXBYATefNJ9JM88aFG34IQ6acXbmIYpdTgvG2+gT92fajlbVf0Hx/MKpEF+2wSlmuKkeyzcLLdsChcIesIzhq/Hjlhfc1+byQNIpkeRTbrvYcbV/kdheIry940kPBAF0aTxrSJsdj65Mvnf79YQC7XFHj9Eg9u8kRdqF4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2+0AMKAznXYS/+sUW1IdemkslcU132B/azaLkcdIhM=;
 b=ChzCAU9T8IwrOT/6PFiWYJ8GLfLeWmXl/X7wJDrJtXiJAiTYvHkGRrfiWukZ9G6ats9/KGUkvIx/4N0Rxcmnw6smyJSKO7KWHM+0DbucuMJChK076Mg5DkuiVQuveAMav/EgI3havjdnir1ACphxb/Jm2ZZd3Xn1yzg9ypCmOtvleBkh/fmPX9wZGWGz10BfpHTudqHUURXwJjtXB04w2iY8XeBclf0w0vuKlo8P3+DMFsoNAOUz8WQ8u1yMjgLReceL/PJCXpmj7/ljl11sdC0QAR/4Apqbf+raeBf1TmT5a+yhYgt3F11LSZNnLGQekGyT55EIx8LGyp8i3v7+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2+0AMKAznXYS/+sUW1IdemkslcU132B/azaLkcdIhM=;
 b=H3HNmPJaFqOvUGDOWcPrIF39PqZDJ+Q7KbUoWUsWCmjqH+zV3yySS3AJPyhyd6sioQNVJltw0u5yS7fOIpP2c7EopNJn4s63FC60Lk01FJA8KascR6AEmbE42beQoKSIo6sDLRO2SBQ51mVFkX/YYDx6/mJj/petrMTl6yPObMIASE/93+sZtWiZXez8Xbej8Iql3fhNYVkG6pn8b/czfbWtW6vYsyMgW6g/y/jBVgKsav474g27/DRNX0G7niy5NLWc99eWpl4YGEeGGCFQvC5q60AJxqsct/NlP1JxqPv6tbRYnR3dbtnkbvdKX7BB4nSs13ft39TSaCE68bbAiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Mon, 1 Jan
 2024 12:34:53 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7135.023; Mon, 1 Jan 2024
 12:34:52 +0000
Message-ID: <250e588a-6f53-4c1c-8876-55a7779606aa@nvidia.com>
Date: Mon, 1 Jan 2024 14:34:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] nvme-fabrics: move queue size definitions to common
 header
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-4-mgurtovoy@nvidia.com>
 <41e49eb9-24e5-47c8-96a9-12d47cfe3367@grimberg.me>
 <24453b86-800e-4a92-b78b-5fe7d92a9c8f@nvidia.com>
 <8dca8961-ead8-44d2-bc58-2be9edbe5d81@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <8dca8961-ead8-44d2-bc58-2be9edbe5d81@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0372.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::17) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 8646b50c-4462-4c56-b6a3-08dc0ac60cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sUysTaIspOH6fu8DL5xQIkyhhthJBwGhI3yNzMSlLTuB1TsHjAVva4uLLGimiIZ6XZNl8g8L7Qjco1nP0vefQoe3V10C7Equ4Nbi75ZASxX0wENM1oF571T2p6dm/QD9gIEPYIgmFfk504+6715hlqF7v3Atov6xrtqBHtPv2IJmiop4XhRNeQryZWNeyUKXzx1SL1h3Ifuu6yDMcUnNQcUV0MHwEPbPL4rBVgZjp0tSouEQBYlHAi3pkLSS+roPgUJE6r5fnMROL/xg1GhHfqAfbF99jiGwx80yPwOGMrsQYnphinoxvWU+eUAKEgRjPel0OaT33th+C7tfDfW4krjoqCLDOsuUXZ08ySaD1VWOqXvidleVjlA/MIQPX5ufLnwef/7OqK7LOtfaXbPkyo9reMVJUtzvkYbiX6UL4rcT8OBFpRRf52vjmancH07qiQefy5bIjbWzFKeQu/i8qJ99EXnRMtZo1n2FuGL4qRQH2qIA3Gr+MPHFRV4EiG1vue8GNQYmeUG1cPJ25XwDDVh45Fq7qcGLrMFN7vmkU6rwlYQB9VNmXqYNR6y6g7NtaRW2FFaHcW850qy0DdgCuflkje5+0rVx82c0NngAxyTThz7RiNmDyADpWVnkpR4v5VbkYgIeguCcrBkdcB5LZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(86362001)(316002)(66476007)(8936002)(8676002)(31686004)(31696002)(36756003)(66946007)(66556008)(6666004)(5660300002)(38100700002)(478600001)(6512007)(53546011)(2616005)(107886003)(26005)(41300700001)(6506007)(2906002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGt2VWZBNHg1T1JBMW9ESjFIWlRMZldWWCtMbjhpdGY2cU5qUlJhcFovUTha?=
 =?utf-8?B?aC82MWx0UFlSRU5YaXZPL1BGQ2tsckJ2NGozL25KaDgrbm5MT0JKM25HWUcr?=
 =?utf-8?B?MDNXTitNV2FkcHRGaG5PWllJNmk0Ym40aTFzd1FPOEhIbTF0UEFFb2dpeWdR?=
 =?utf-8?B?bWY3TFRvWkFzemc2b2ltZXo5TmxZZmY0MHY4MjUrMXdxT3FWci82NGJPYTZh?=
 =?utf-8?B?c1JoeDRUaEtmZC92dFVhcVdRZUwzN0EzdEI0djlpOWpuUjMvYkp0Rm54MjFw?=
 =?utf-8?B?cjJjSFVqSDVtSW9rZEZLL01HTjd6S1g5angrNTV0MFVWeE9QRm1Dd21ITmxI?=
 =?utf-8?B?ejNUNlhDNitVcFNqMjFJd3k2NWRhNHNXTmUwVGgveWhxN2NEck8xcTVxRzE5?=
 =?utf-8?B?SW5nS0FnR0FHY2JWeFptazJWSzY4WUJDTVBIc1N4dTl4V1VpWDdaUm1mVnlw?=
 =?utf-8?B?SnV6dExTdjFyNEk0b2NsNHJ6N1ZKSlR3dnJmbTJLdm5jcW5WVnQzUG1LRmoy?=
 =?utf-8?B?SEI0UkZwZkZ3OTlwUkRsbEgzRjRpcUxEVHlqQVhFaXkwbHhMOC9wNEdMRlM2?=
 =?utf-8?B?cUxFa3k4WFpWbXFtVGg2WG1FdmJ1UUlvSGFnRUxYQ3dkejhLNG1uZjc5M29S?=
 =?utf-8?B?S0p4YjRMcXcxOERRcEZJaEhsVmNaNWw5NDN5alRXQjR2VE9MWlFjd1Zld2kv?=
 =?utf-8?B?L2pudlNtRGhnN1N1WWprTDArVEtuZXJTQmpId3FTaDVGWHBOWDRSdUJoWVZZ?=
 =?utf-8?B?NkRWNEltSGEzUkhVcDI4dmZwLzdsOURxQVBMbUswZC8xUVJnR2phdmlWNTkr?=
 =?utf-8?B?TDlaaEZIT1FUeUpRVTUzNEZXTDVZS0U5d211Ukc4RkdnU0pNZ1ZoWU5tTmwv?=
 =?utf-8?B?UVZnY254cVVXNVpoYjVrQ0pyUklPcVB2L2V4a00waUd4b0hlRENwUTk3VjBa?=
 =?utf-8?B?cGRKWTArWGFWVnV3dkJyNjFTdWJ1ZkNMNW1lbWVCaU9FbUNoMVA3eWtsbFNV?=
 =?utf-8?B?UlBzVGxGUXB3bS9VQjd5dEZHdWlhUVdGMXhLOWd4cmpyc3VJVklQektFQ2hX?=
 =?utf-8?B?ejRtNDcwSkNrMGtwQzFGeGRrQzAreCtNS1ZtRlRXMmpvSGd5SXBKK0VqSDNh?=
 =?utf-8?B?NTZVN01mSzlkd0RMTXRYUjZHSlF4dXdoMnZzTGRYbzhzVmN0VkNvTzNWU24z?=
 =?utf-8?B?b2N1bTNqYitjU3JLTmNGTzdqMm4remVqOFZtaEFuQVRvcGZsWDhMUTJScTlB?=
 =?utf-8?B?dllJekhaSm5CeTRvL0crM3lYRDVmSTVyZGF6UFpBaU5YWjgrc0dON0ZxckdZ?=
 =?utf-8?B?SnV3d09xRGdiMC9GT1FHd3hCMjNseUQzR2RaMis4bEFSZlVKWm5YVDYwR0Rr?=
 =?utf-8?B?S0tPcFEvYU1wc2tqTjh6NExLOGJ3Zjh2c0FnSytzL3VTdWJaejA4UU9oRm4y?=
 =?utf-8?B?WHlvbStzZGtDOXhvZ00yczJERDVFRVl0ZnUzYlI0Vno1MEU3NHhvNkpGbEU0?=
 =?utf-8?B?aEozcEdrRkFkSmdxSEhBVVM5WWtDVVJhdzN5eWNQTkhQRytZSVVRdExzSmpM?=
 =?utf-8?B?TUZaMkVEV3MxbTg3VDdVVXBxY2ZNQ2R0bVdWd2tRMk1LTE40YXlEQ0wzckUz?=
 =?utf-8?B?UENlNGx5NzlvQTRyTG0xM0Nma1ZXWjFVUzZ5YjdMeEp5aVhtNDhyelM4Y1Yy?=
 =?utf-8?B?ZmFlTE5UenFySTdXZjVsTkJBaGpqamM2S2s1cnlVOXBVYnp5WnFPUzJqMXpH?=
 =?utf-8?B?QTBaR1BDalZVdjB5WU9RRXp4N2NrQyt2OExjVWkraks1cGIrR2lpT25FMktk?=
 =?utf-8?B?NXQ2N1NiMHZybFBHcUNzdFlycm5nbTU0V0FvVjQxMzUvdlFGTUR3bThWSkRW?=
 =?utf-8?B?WDZvMmpsZ3hlb1JIU2M4cnJzZm9kZUpXWjVuYmdrMXNLNFJDUk10ZVFKdHBN?=
 =?utf-8?B?eHREemh0dldlbUN4a0svUHl6U3Yvb3Nqd1VmTmtyMUovMkw5R1RwQmtoVHRs?=
 =?utf-8?B?V2NYLzVCWStJQXdxSmZIRzJxZDllR0orcC92eW12MDMzV1BoaE8xTDVlMll2?=
 =?utf-8?B?MXVQcXVIUENDcFRPc29GSi95T3ZjTHM3TnAyN2lVN1VXeGwrUjUxZDNEN1Jq?=
 =?utf-8?Q?exARt8jSaBITlMcxV3gACrfds?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8646b50c-4462-4c56-b6a3-08dc0ac60cf6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2024 12:34:51.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kOKFfNSi1dy0CeEv9/3Z39GEidIBPaBzWjHgjurUtIcve3+k2YNbJVKADmnyzE2PmrK9RlsZqe8xFdh7fImRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_043508_250544_DFB974B7 
X-CRM114-Status: GOOD (  14.24  )
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



On 01/01/2024 13:20, Sagi Grimberg wrote:
> 
>>>> These definitions will be used by host and target fabrics drivers. Move
>>>> them to a common place.
>>>
>>> Don't see why these should in any way be common.
>>
>> why not ?
>> why should we define these values separately for hosts and targets ?
> 
> Because the host and the target are separate systems. Don't know why
> they should share the same defines for something like this.

It is the same Linux kernel framework so why should we have different 
values ?
We have an option today to set queue_depth in nvme connect, and now 
we'll have an interface to set queue_depth in the target side as well.

do you prefer having duplication for min/max/default queue sizes for 
fabric host/target ?

> 
>>
>>>
>>>>
>>>> In the future we can introduce a common nvme-fabrics header to ease on
>>>> the maintenance of the global nvme.h header.
>>>
>>> nvme.h is the wrong place IMO.
>>
>> I've mentioned that it will be better to create 
>> include/linux/nvme-fabrics.h file for common definitions for fabrics 
>> drivers.
>> But we can do it incrementally.
> 
> I still think that nvme.h is the wrong place for this. But if others
> don't mind then fine.

nvme.h is already overloaded and splitting it to nvme-fabrics.h is 
recommended anyway, but I feel that we can do it incrementally.

