Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD12BC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 10:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=va+Xr5qhjfPwUwwsN1zSPhnOWq2c/lmTdvUTeyyFTag=; b=1Kh8DQnQ6KCLz1Xs4+SMdGjXGW
	6WLcVl8cCe8JFTei2x8hlyHfR2P5Gw3a6UwYA6mz/14pwSBjCeR0Sg0nH4/KbyY3f9lqzgD1ykBoz
	BJXhjnIkfRyyCMmBc/A1YAaJNmmGk5K3VNbu06FTufLUEfVqa8yzva3KnhFwy7JERg3ej2dhJfMRL
	J9xkYcnhod9bea6mhhEltfG224fx0qNCUOPKxQ0m8hNbet8UCIDZv0gM5Unn+BBFcYm0MiTMY6+Ug
	7f4Hz6m++9ZZ3qkJJPj00L7gXR5/tuqsU9gvfFdDsZmpKHpPHDwU06NCDk5t2rTaCijPM7M9r71Pe
	yUk0hpLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofIVJ-005H5i-QG; Mon, 03 Oct 2022 10:16:53 +0000
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofIVH-005H39-9f
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 10:16:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPBmrzpfir585gdcPoq+dgcvgIS4t2ZikR0EwMhAKcCBcIln+Sdj7Q0o19XrwFLTAms5EzS/ZxHKDITpEFsJuBTet/is2ky1Z2v8kPJ1fO2/7ewaIa1IMHmqtZUdrV+0MA6Tdy/XYY9jEWbFEBQPvQ8VvuKWY4paHoT9lRV31agQnV5M8Z7eFucDxdWSfpFEvla/A56fIk1Cx0BB4K168xM+bYFIr1g1pluBrHKniy2Dfqt44clDChFsM/A9rACzUwOQUulXzgSfqUrfAE6SWvGvyB2hddKMjUL5zWTZUM2Ocr1rFLf0ssX1J/XWzxoC+upOSObCF4i8UwokQFylEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=va+Xr5qhjfPwUwwsN1zSPhnOWq2c/lmTdvUTeyyFTag=;
 b=W4VGcXytI/+ItwHaEzhO5zw4vJI0xKx7FtEC4G16d0EI8bkY0A8ijpBJucHhAN4dsjLUoU2vCWwUJwZlefHBbb7guMDg9HbfhwvERptZ1qBqnxn0XjnYwoTDd/k9911rKDtJpY1sPXpPJHYhwqQ33m/gUZ+77CUvZHbVStyXt5DGJuJG8WsffxnScsOst9Vjty/e6Jm0MV4gVvJm42e+wLKHGnoCSBaB3CVfU8kBLVOZbFJTVWfSbeNAMYaw2Y//Ke4hgGJG7FHxh8TWKU0tfxXbpDsNdl0hr76sd1oKSxjHrl6jOtrwXd6nNY7ptm8cQ5M2KwIpBNLjeXSuMgK5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=va+Xr5qhjfPwUwwsN1zSPhnOWq2c/lmTdvUTeyyFTag=;
 b=gr5QdLykOFCPn84ALmbUCeLym8XqWwtL1H44TZ+mPey+XCRaeQWr2eZXycrgwkNLoIBi838Y+BdFQpCo0hfjQuWSQLoaSYyO9a3GKpMQ2iSXNWk8b6rQR/yrkaqaD3VDrj0qlfLnjSnjoRH4wgTLaGiUctlNmmJvkqnFX0pJHygYTWrzQfkTZHTrZxCGhbJMkcDyCAIU1YZTCIPOylGUOTbQNfsMQnmnGGIF6zLxir/idRiHycGzs0RCdeCxP+jLkhiLdV8UPIxxEOixT/FNFzln2xQrtGCDli1EjRv4t13gJPDztC2VoF1PVoBl2II/FKzJxKhRoFfYfxNAw5j8nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Mon, 3 Oct
 2022 10:16:43 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb%4]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 10:16:43 +0000
Message-ID: <3354c32d-34b3-0997-3a59-8fc199e6640a@nvidia.com>
Date: Mon, 3 Oct 2022 13:16:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/1] nvme: use macro definitions for setting
 reservation values
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org
Cc: oren@nvidia.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org
References: <20221002082851.13222-1-mgurtovoy@nvidia.com>
 <cfd01d2e-1f87-2295-13bb-c8705b3335f9@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <cfd01d2e-1f87-2295-13bb-c8705b3335f9@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5P194CA0003.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::13) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CO6PR12MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc624ee-eef3-43ef-b3a1-08daa5285efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	4+LNJV39BWWvUI6Oq+ZHSXWvL6/hzsw/UGp5WP6Job33w2kUicDLP+bTS2SxiuY1yXIUJq0jQCsuv7eLEmkmYkIi5EUMfQL2+zk7uhopwGZ+JeapphT9qctUD+mokTd48t61q6RoVWbjiSVaeQV/HIRvqkmLL7T0wVtz5DqLTve271EJ3HlK0WvsuGxabf+38hpi2csNombk4HLWnPW3GbxcIVUN+d27SRolTjj5CyMtavoma/wmGgWHOzF2lc460urHtaHfGZNSLQBmU/NOus8pgp3T37h2yLWtgttWmCKxKgXQ3mAiMw7RqAxJqy0nncqN4swrmWW78gskJyfWd38WxEnZiDD+JDLWm3OD0MFtgSwzP/ErX7qiGXKALuBeQDghpGcI3a7AGdnE7GZ84D/7oElp98i2VxV3+3qv4KrEnHdv3mkKYW8JhLjbRRwe4yWDRcyFtlT6vjMUWJ/UVp/E4MdZ45CJ2qECscBdV+VXIR61ejGkDmliuaeTyGeAso/Fj5Af/AEBlC2GmJqsk6esh4t3XcdIyGR5s4eiF4NtqdbRO2RSHqOnLfl0vVU4dR9Bpr3ntW+EU3//CxEnwB7xfJ5ZbJx6ppDE0EVR7X3Em2nOMIx6P/duWXL6Fi1mmyWdSt+ykStVlvjSHupsiDi069+M/6Hu8CaqOk2zIUIJ62HIAmv1qEItJRhznxL9SPivzzlcuKBOIM/Bqub9usf2y1SsqFfSJkxqw3M128OnZ6YQB2XRa/25LTWrJ0vBiHMLm8wwnjHyvsqhyXNkFiHaS5J1A8EACYpmlsf0AEU=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199015)(4326008)(8676002)(38100700002)(41300700001)(6666004)(66476007)(66556008)(66946007)(186003)(2616005)(2906002)(83380400001)(53546011)(6506007)(31696002)(6512007)(86362001)(8936002)(36756003)(26005)(5660300002)(31686004)(316002)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?T3BVVVJkaS8vSzFwOWZRcE1kUXh2UWlMYzJnKy9UeGJSOGlvUjJ1VDl5NFFn?=
 =?utf-8?B?bTI4a01QbzVMZENHSlUvN2RrQjdvUTdnWWZ3ZDNtelJSa1lGYkpGaUErR05D?=
 =?utf-8?B?WExoZTN2RnhDMGlwYUdJN1V1Nk9XcVNPRCtSUFIwUHlELy9wd1YrUGFMUmZ2?=
 =?utf-8?B?bmJPUWlBVm8yeUpwNWVOaVBkNUhtTWlCbkpCQ3lUUlhnb3ZPSFphMCsyT0hm?=
 =?utf-8?B?S1JpWExWaXEwa0MzK1pjL3VWL2xwWWVwTklXdEwvSC9oc09kSE1ZSEVrOSti?=
 =?utf-8?B?NDRUNU9xbzBwblUvOUR0UEkxaGs2MWxVOC81dWdhcG5iYVllUHVZM3Q2emM4?=
 =?utf-8?B?d0VDWGtSaDhTNHdqaEhCMkMxY3JKUTI5eGpsK0R2SWtLYlhEVzJ0cUZ3Rk4x?=
 =?utf-8?B?Mlh3cGFyRUZvckwwWFk1UEF6dVNIK0RRUitjdzZ1NjRPTTZha0NEU05tcXR4?=
 =?utf-8?B?U1FiaGhKUHZocms3V2RpWHJNTHhQQzhEMlZDN3ZOajQ2VGpOS2VqOWY3QWxr?=
 =?utf-8?B?dGtkTWZmcmlYZDBTeHNnejJyK3JTMEo0SGlGRHZJeG1KenUyMWdmMkUzQ0ls?=
 =?utf-8?B?ZXVYbGpHdjNITFJ2V3ZsejRjRVFNamRIK1dNQnYrd3oyYSttYUp6Sjg1ZWti?=
 =?utf-8?B?ZjRmb3ROWDRNZ0VnaDB2a0RFV1FLd0I1NjEzemZFNnF3STdaanZ1R0x4dmFJ?=
 =?utf-8?B?TXJEbC9aa2xUZVpyb1BIa0JkcGtnOWZJUFlBSGwyc0RKd0wrS3VnQ3h1VlZx?=
 =?utf-8?B?WS90N1RWbGJlZjRlK3VpbXRMOUo2QndvTHkxZ0lINktMOXVIMGxKVTI3TXp0?=
 =?utf-8?B?YXkwZ0tUT1dBMEtnRHdhQjJWY2h6MUJEZlpvSDFPYW1WU3ZUUG4wMFlPZVVo?=
 =?utf-8?B?R1FzTlAydXdFU0s5RHpiTWg2aFJraDhDZFBCT3VFTkRHUnJROWx5VWxWbFg0?=
 =?utf-8?B?MERxRlU3aEZlUDVpZHdwVFlUcG5qMmNHZFc5dU9OZWRGczBScnp0bG1qdlcz?=
 =?utf-8?B?RDFlRnMwdFg1dVowNStmYURBcmpFYWpONy8zNmoySjR0TGJFbDk0dkRpTlJz?=
 =?utf-8?B?ZkRZa0ovSFZ0bWJpQ2JMbVRUdTROQlB2S0dpVzFxQXZmZjI4QW1hR29CcTEr?=
 =?utf-8?B?S3k5TVlZcEJLYXRLb2w2cGppRTJ5TU5LMmZ0ZVJmQ0NxREtNVWVHdWREdzFQ?=
 =?utf-8?B?SGwzZ2MvOFRuMU5nSXd2SE5QZW1oWDUvaG0zOURGeUJJcmQzYnZWUzA3YTNs?=
 =?utf-8?B?VERCZXptNlc0N1NsVnhQNXhFdnhjUVJmM1FGNlBsQmdlbU00S0t1Zzh1MXM1?=
 =?utf-8?B?aTRvelIyWWFybjI2Zy9NYnEwUGdhZVFJMm5WajluY2VVb05LTXl3OXFHQ3pt?=
 =?utf-8?B?QlIwbmpWRGdRb21hbUtQa2VQdGRMeHhJdi9yS282dXdXNlcwWHYrd3ZFYnhU?=
 =?utf-8?B?ZGsvdmp1U1R3RDcwYjBJWTBQTXBxK0dkUjN3OUhxcTlXRVpyNys4TEI0VVpa?=
 =?utf-8?B?eklBNnZUOGsyZHgxVlZpYXBNb2tIdnAyTStsREswY2M1OFFjd25RMGRxS0JF?=
 =?utf-8?B?SkJMYm9WUmVZSnlPRlUzVVBhOE95QWo0RG84V2VEUEZ4V3JtOHZOYlZXRTVm?=
 =?utf-8?B?alFnZWVZdE1Ud0krcjBrajU0NThrcER2c2JZblBlTlM2aWVLbHN2aXpjUEZn?=
 =?utf-8?B?RjZxZW1TS0diQS9VcFh3Ujd0NEIvSU9qSi9jMXJmQlBuU29LeUZxamNpTENV?=
 =?utf-8?B?NDE5STB1S0UzWFVxT3B6dTZML1BZc2I2MEg1cVVWMlhjeU8rMGdvRTBXc1lv?=
 =?utf-8?B?WUtCYzA1WU5MZlhWVW1lWitDcmtUdGVZZzU4MTMzZUpDQW5lRllzaFJlYzdv?=
 =?utf-8?B?bDhrMmF6V1piYk9SQU80VXMwMkk4amRmeGJEbnpjTERxU0lHWCt4ZDVWRVlP?=
 =?utf-8?B?dmdua3FyZFJyZHF2TjdLcHFmbXIyQWxKclBTajBxNVlBWmJNZ1kxSldyZldy?=
 =?utf-8?B?UmxvYXdxR1RwVWY0MHV5dFZkamNxZC9NeXVjZndIZnI0Rm54NzFIWWlCV3hO?=
 =?utf-8?B?dFFBWmZwUmlOYk9OWlJEekxmUTN5VmhWbHg1NkRnTmJxOXl1dms2L293cGRQ?=
 =?utf-8?B?OHRPdGQ0MDdkZ0ZRWmtBMUlLV1Y0MVZYZkNJUWZoWFJRL3pZWXB1eXNKUUMw?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc624ee-eef3-43ef-b3a1-08daa5285efc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 10:16:43.8959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th+jhKgflLp2/TmssMrYjnAKq7r3tPOiSpKtkjAuTAx6XJ1MK2tVng9OcnQtq6gMAL2oxwY6trbJHNS5rZGcCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_031651_378059_921EE039 
X-CRM114-Status: GOOD (  13.93  )
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


On 10/3/2022 1:03 PM, Sagi Grimberg wrote:
>
>> This makes the code more readable.
>>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>> Changes from v1:
>>   - remove comments (Sagi/Keith)
>>   - use tabs for constants alignment, similar to 'enum pr_type' (Keith)
>> ---
>>   drivers/nvme/host/core.c | 12 ++++++------
>>   include/linux/nvme.h     |  9 +++++++++
>>   2 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 3f1a7dc2a2a3..50668e1bd9f1 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2068,17 +2068,17 @@ static char nvme_pr_type(enum pr_type type)
>>   {
>>       switch (type) {
>>       case PR_WRITE_EXCLUSIVE:
>> -        return 1;
>> +        return NVME_PR_WRITE_EXCLUSIVE;
>>       case PR_EXCLUSIVE_ACCESS:
>> -        return 2;
>> +        return NVME_PR_EXCLUSIVE_ACCESS;
>>       case PR_WRITE_EXCLUSIVE_REG_ONLY:
>> -        return 3;
>> +        return NVME_PR_WRITE_EXCLUSIVE_REG_ONLY;
>>       case PR_EXCLUSIVE_ACCESS_REG_ONLY:
>> -        return 4;
>> +        return NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY;
>>       case PR_WRITE_EXCLUSIVE_ALL_REGS:
>> -        return 5;
>> +        return NVME_PR_WRITE_EXCLUSIVE_ALL_REGS;
>>       case PR_EXCLUSIVE_ACCESS_ALL_REGS:
>> -        return 6;
>> +        return NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS;
>>       default:
>>           return 0;
>>       }
>> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
>> index ae53d74f3696..4f777d8621a7 100644
>> --- a/include/linux/nvme.h
>> +++ b/include/linux/nvme.h
>> @@ -238,6 +238,15 @@ enum {
>>       NVME_CAP_CRMS_CRIMS    = 1ULL << 60,
>>   };
>>   +enum {
>
> I'd make this named nvme_pr_type

Most of the enums of this header are not named.

I don't understand what is the convention here.

Usually, if it's not a new header file I'm trying to keep the file 
convention and this is what I did.

If all agree on named, I'll send another version.



