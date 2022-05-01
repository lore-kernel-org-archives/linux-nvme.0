Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CA8C433EF
	for <linux-nvme@archiver.kernel.org>; Sun,  1 May 2022 08:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g4xX8Y5blf1ygFPpU5vOkYFrD1k8mcooq53VNVDIVBk=; b=ZFYm+W3ECgv0tBgS4ruvhuzu3e
	ekXjhInulklOEdvxuhw7Q38tlTAIvD4SnDWZWXoxXMTeowDMzKBkSBB83brrU+WFzqFKoRKMOXnPz
	L7V27UNXOr/i7ayTExFZC3wNuJz64hS4SVmejThLwd0XwbNR9/9o0RSpbPbEhv84HpoIIC3V++YIL
	xPyH4/5kp9v1gB6h92CehIMKpMq40BQOQxDevYiT+xpMtVV4OO2Mud86DP60V2GgSpwNSevnpFInW
	qUFwBr6vIm4CuG8fie3VFlvx0v321BZ+USpfxNfcFZoWRKQlUBrWw6WpyNHj/MaFsH59z2g2+3PH+
	2kkoOXwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nl4sQ-00Ftg5-OG; Sun, 01 May 2022 08:24:22 +0000
Received: from mail-bn8nam12on20628.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::628]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nl4sK-00Ftfb-Sn
 for linux-nvme@lists.infradead.org; Sun, 01 May 2022 08:24:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl+UULAV50Po4DuCgK2HIGqYfWLE1yDT5h7D1UOscxb/8bdpdj654FBiUHcfdmKPcn6FgALGcgv+5xxxMJvtSFlwANy7Q82xgC5PrWJc7t2M3uTdBEeOU0shtyjdSGCkjwaicjp+2BpqH1payuuwzkI5dHxh/gSJqXzbeqJ9yApnVCeyVNnYJsuC426X/cm92uckWyMpgT6kDdrVirywx9imC3opzl/SqBjUIN6g9+eiWo5Lp39+nAVB/VcytQ47QEQktc6J+wbTrcDNNui3Gqg4pWr+xw2AT6bgrT28rnG7cjuoFqJKq0GdSyc+poOllzdw5LYtuV+y/FQku4x8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4xX8Y5blf1ygFPpU5vOkYFrD1k8mcooq53VNVDIVBk=;
 b=kqlCgQvTSy7RUti2/r7qcdWTHhwa117YA6vPTU1ovKIOOjjbuXQp+tOneFTWgLwpWVS0CWZqug6UimXVkoeaofGCWMF7ctGMY6OQGtjngxVz6cAPENa+pU19PAIRdfL0VhF/TCKMxEshNzH/BLWZvKsnyvxlaKPLvC6dLaCEan2v40aWSZdTghncOFNEqJp9qVNMsqzxTSvFbaENyGnlOESHSDsCMuBP1qcrWJOYaVPISxbxozgOB4geuqcQuQ3AXXgReZQU5+IA9eUSwJ9xn6q34DF8TJGcvmqpIJQz9Oy7Y/efRthf2XRRXy+SBBMro4qoNWY2MDt8oUPGy0d1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4xX8Y5blf1ygFPpU5vOkYFrD1k8mcooq53VNVDIVBk=;
 b=ddWMcbFiBK6XBkJZnPZD5soC/kZAW/Op2eFqkugjvFaPda8hHahVrb/DcYk03owC+jasKdCAzT7eXkMk8MBd1pofZ4cRPWXW/5qNnGWT+KSJhot9qEziOmVHP2fgfRFYlUiIqr+MJVYKhb11+evU+XcEfqHgnNkrN0IopoaUIAjLLOamfdbHWG6sDRAEe2qVZxiNT1a/HLqhBYqWaufg/JR6Cyb54AbGCQuECOLcwmRsU7ojB9lJmh8NFuCJo8hQcV661yaogh7ibdUPghUMgeY2afFsb98IlsajJoNtggXDTuaQEelcNQ8OZ/EBwZIAqsP9pzolIo/yNG63z9WvjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN2PR12MB4029.namprd12.prod.outlook.com (2603:10b6:208:167::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Sun, 1 May
 2022 08:24:11 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f0b1:ab59:e038:4682]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f0b1:ab59:e038:4682%6]) with mapi id 15.20.5206.013; Sun, 1 May 2022
 08:24:11 +0000
Message-ID: <82bbd37f-5175-68b6-0ca7-5d03d11d9f21@nvidia.com>
Date: Sun, 1 May 2022 11:24:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] nvme: add missing status values to verbose logging
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org,
 kch@nvidia.com
References: <20220428091935.35651-1-mgurtovoy@nvidia.com>
 <20220428091935.35651-2-mgurtovoy@nvidia.com>
 <e8ea0448-bdb5-3232-d209-35106f9db30e@suse.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <e8ea0448-bdb5-3232-d209-35106f9db30e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::15) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e7bb566-a3cf-4942-88cd-08da2b4bf820
X-MS-TrafficTypeDiagnostic: MN2PR12MB4029:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4029A2DC136BC851F66C657BDEFE9@MN2PR12MB4029.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ca8qJ7DMFLo8pTxu9Dfes+er+/TepZfSIvWH/eK5uxyVNdzj8SOBzHkY0WlmM/r+ZsZO9toebh6qZqpmoGYJQ4vu+TJ+3QkE0f6iQpFfXXLepBNnKUsSWxQBqgTR+iGeGJN/i4QaemjPiT1csd2xqJdVl13JkgU/P4He5BRTV7yNPNIo9Wn5YoyKNW+6sEKwMmz6s9EtJEy0AoKSXbwLsa40SbiCrb459dOOpuuaeNfDwcj0oGzDgqdr4CxLpR8YIeGvgfYOfYn1bWCPVd74u23yFogGNOz1BDIj3KC03C63E6cNu1wCJgQW4+31oFD61NLznxxMnI3fpA20K0a/03/awe2h6XXsnsasHSPc/bGztM2KMSpKOuu7Z19Ro3b74SvigHkTz78Oc0/mvbVOkil8ovovADNL0EDUad+uEDOPVgoa0AML24eonLtWpIoJwDE5caUhhBySV8/y9mdIwaKsICzUJ2H+Xry1mAgN+6PtoMVkKt6dbs/0dcbc8hnTNUDb3CFcIcdYvUoVqVk0LObgqXh/Grxy+4J/GqQyxHjKJGNDs9jJvwj2ur2Jd5k8jWWQcZS008PYEbf3wmYJLFD0fhy7y5lUpeCLyldtE2Aeh3sK813jKpkhB7byz1myL7XGVS0ehQfqozc8tEZ8YswXnAaC1mtUrJ8tCSneTLBDeCGqe108sEPvHaAJsAYOvpI/6rmpfmzgoSTMXGrsKNMS/KQxmeuSdAvz5mqCzJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(6506007)(6512007)(2906002)(53546011)(2616005)(186003)(38100700002)(86362001)(31696002)(83380400001)(508600001)(6486002)(36756003)(31686004)(5660300002)(8936002)(316002)(6636002)(66946007)(8676002)(66476007)(66556008)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEpramlDOEhYcVFzNWQ3R21RdVhJMGQyTGhYSzVIajNLMWk5ZUJJbHdjd2d5?=
 =?utf-8?B?Vk5vei9vU0J4Qm50dUxkNDF3cGNzekd1RzFqQnFZaGMwMlhrbUtRaE80ZmVu?=
 =?utf-8?B?SVpkZ3h2c3pXNi9vdG9PREMyb1ViZDMxRHFSZmxJZU9zZGR1K0o4bHlPZWc4?=
 =?utf-8?B?T0hUc3h4UmhmSUh3S0dmaUtLRFJHNTBRWkJaNW9YeUlxMDZ0N3pxRGhNOXE0?=
 =?utf-8?B?eFJUK09KdjhUU2NjTFJ4VDRSVTNaTmJzY3RwTXNCMnpNRHd6aktXZ2hIRVpW?=
 =?utf-8?B?aDlIL25rcWx2R25RZkRsYkNmYThBMEdEc0F3SDVIM0RLQlhqNzVjbWhoQXkv?=
 =?utf-8?B?MlhReUd2THJsUkVjamduOW5nRklwN1hMMGk2QnQ5SnNIdGRRT0l4UHgwVmhK?=
 =?utf-8?B?SlN1bjJGSmlycSs2aHlyUG1mbDlrUWZLRUkrWmJkcU9oK2dOQXRsQW5xVjdR?=
 =?utf-8?B?TGZpNlU0UDNaSitpRUdGRWxTVkVRWUJCZTJTR2JZaDJ3MEpzMjJ0aElLUEpM?=
 =?utf-8?B?QkRzWFlIaVVrWGFHZnpyaENpV3ZaUzBKUTVIMG93QzNaUEQ0OVJPNlFKMFhQ?=
 =?utf-8?B?c20xbjM5MEpCQVVtdUZnT0hOSWdBZnVteHFGNEZ0b3hPRVdCL21hb0pQNy9t?=
 =?utf-8?B?Ykd1M2dIVWhHbHltcUxyVlc4TXlnRk9TSVZxcDlxRlZkT2tlL0M4UVpBMHZU?=
 =?utf-8?B?Rkdnc2JPd3BWanlEMU9IRDNtbVNmdHlRdGhaZWd1WkhtL2pxWlNzeWM2dm0x?=
 =?utf-8?B?M2tMMDZGYVZsalNjZDFYYWRFRjN1Umxhb0FEUG5haER5dXU4N0lnQ2pOcmVH?=
 =?utf-8?B?clNnenMzUkwxOXpwNXJGd0FsemhoRmdGbUR6QWFSeGt5WnB4TmxFQ0h0bGxH?=
 =?utf-8?B?TUc3ZGc1ZFMwOEhLbUZEYlN3eXN2TW9VWFRLWVpEUmFYN0xDNGJQRmtKaktn?=
 =?utf-8?B?eUd5b3MramFJTWxKTEUxaTFYaEhRTHhmWnRlZFFLRUxPZXE1YW5pUEZBNXU4?=
 =?utf-8?B?Wm9XUHJkLzJDc09VZWxURFI1SzhlNXhCRzZxNHczMTFzTFU0UkxpRlcya2FV?=
 =?utf-8?B?WGNXUFNGWnRxT0R2Qy9ENE9TYUdndFJVNDZXR1k0ZkdZOFJUVll2OHdWN1h6?=
 =?utf-8?B?TjU5NnRjNWM1dTExdms4TkpHd2wzTExuY0dBNzJHY1dLQWlFR21nQUg0bHE5?=
 =?utf-8?B?WVFjdi9ZaCs1a0lybWFPdTFKS1VJZVRGLzljM2pJSnRLSVl1WWxMZnFWOUs0?=
 =?utf-8?B?M2Ixa2NkSjhpeG9KTVNabllVTzlQQlF0dFZzYW9TK21CcHk5YThkamhQWTBR?=
 =?utf-8?B?eVZIbUJVeDdrc1Fub3YvdC85YkpISWVCa0JNQ2toS1Q1MDVDWGR3UXB6cVk1?=
 =?utf-8?B?YmtPTVdpZVgyMHIyOG9LQWJqUHY3OFZ6di9abnUwV0g3RHZDWFNLcFRUVVZk?=
 =?utf-8?B?QW9mYW5yM0VLZWpndDc0RmtVdFpSL2hoUHNZSkY0ZVJ0RmJjek9WMzBCTGVt?=
 =?utf-8?B?bk1IS0hja2h6bG84eFZuQmJsdFpwMWNqVWVabGFQZjVJdmpJMHluN0pEVTdq?=
 =?utf-8?B?Z2k2aXYzNmV2WThLVzRSeHpwYVRUb0VqMG5sd09qaVN4Tm9DdUpiWC9RMFRW?=
 =?utf-8?B?T0JidkVEdlN6KzNwVUUxRlk3YXBFQW91UmFTUUJEV3N2NVduQ0YrNGM2TkQ0?=
 =?utf-8?B?QXFIWWtjWUl3RUhtUklKeUowOThZZXpGNkdQRUdRSE1uci85VUFScmRqZDdD?=
 =?utf-8?B?UlBkUC93UnYwT0tUSUpOYllwQzBsVzduZytIUnJSWnQ0VW9pbVpFQ3N2MUxl?=
 =?utf-8?B?ZlpEWmF2cTdoNEtYSjVzNnRPcHVYb20rMmhpSFNkeGNZRVlNNjVKWkF6SlIx?=
 =?utf-8?B?NDQ2RVRoUWM1R0FhZ2VNeUEyME9aV0plcVM4eFZ0Qk9tSG5ZVVY2VWJJTGhr?=
 =?utf-8?B?V3NMeWN6RVltVzBvM3ZYL0dBT2ZhSFZWZU5EOVNlRVhwRTVHMEFCZXZTWFRH?=
 =?utf-8?B?VjdEVUF3Y2dtZzJOZHgzNHB3UnZNNEc0SEFINU5EK1NGMDNIZk13R3VEOEhq?=
 =?utf-8?B?SUoyVm1MNFlXbHdWVHk1MFJ5T0JTa0xpek84VGQwd2NrclNNR25DTy8ySDhm?=
 =?utf-8?B?a0JUR0hhK3VFV0lEU1JBV0dtQm5seG1LTm9UTkZPcTEwY3p4eFVOemgydHRG?=
 =?utf-8?B?QzlmWk1Ua0M5YlVGVk1VYkM1VHNTRG80NktQOWM5SVYySzVFSWkvMEtVOWIw?=
 =?utf-8?B?MWZYOVRtbzFmK2ZWRitTMUIxY2pqMUxoUHNjKzJUV05KSlZhQlpMTUt4L0x3?=
 =?utf-8?B?TEtkaWU3SnM3SDhYN3NPMFZyd0Y3Ylg4d3Q0bGkxdVU4R2lDcXpJQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7bb566-a3cf-4942-88cd-08da2b4bf820
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 08:24:11.4426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/asfLDU0hPfHzNYSQ7L3KJauXBDPuK7GQM2rb+eK1xex8jWME6ViaUCGTT4bOAk1ml36AeoCXrY/Z1jwSUZbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220501_012417_160500_374E7296 
X-CRM114-Status: GOOD (  11.65  )
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


On 4/29/2022 9:08 AM, Hannes Reinecke wrote:
> On 4/28/22 11:19, Max Gurtovoy wrote:
>> The following status values were added: NVME_SC_INTERNAL_PATH_ERROR,
>> NVME_SC_CTRL_PATH_ERROR and NVME_SC_HOST_ABORTED_CMD.
>>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/nvme/host/constants.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/nvme/host/constants.c 
>> b/drivers/nvme/host/constants.c
>> index 6c2aa8eefb55..1dd1d78de295 100644
>> --- a/drivers/nvme/host/constants.c
>> +++ b/drivers/nvme/host/constants.c
>> @@ -154,10 +154,13 @@ static const char * const nvme_statuses[] = {
>>       [NVME_SC_COMPARE_FAILED] = "Compare Failure",
>>       [NVME_SC_ACCESS_DENIED] = "Access Denied",
>>       [NVME_SC_UNWRITTEN_BLOCK] = "Deallocated or Unwritten Logical 
>> Block",
>> +    [NVME_SC_INTERNAL_PATH_ERROR] = "Internal Pathing Error",
>>       [NVME_SC_ANA_PERSISTENT_LOSS] = "Asymmetric Access Persistent 
>> Loss",
>>       [NVME_SC_ANA_INACCESSIBLE] = "Asymmetric Access Inaccessible",
>>       [NVME_SC_ANA_TRANSITION] = "Asymmetric Access Transition",
>> +    [NVME_SC_CTRL_PATH_ERROR] = "Controller Pathing Error",
>>       [NVME_SC_HOST_PATH_ERROR] = "Host Pathing Error",
>> +    [NVME_SC_HOST_ABORTED_CMD] = "Host Aborted Command",
>>   };
>>     const unsigned char *nvme_get_error_status_str(u16 status)
>
> As mentioned, maybe merge with the first patch.
> But that's merely cosmetical.
Thanks.

I'm fine with squashing it to 1 commit if needed.

Or it can be done during the merge to nvme tree.

Christoph, please comment what is preferred ?

>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
>
> Cheers,
>
> Hannes

