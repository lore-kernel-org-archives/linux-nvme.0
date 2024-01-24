Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EE0C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 14:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2VBKEtGNwFJan9w1w8ML4Kr5mWJbZXJiBFkc1jzZ5wM=; b=oIhkI4w7jQjthus9jBXAqacfEb
	7dVCAgqqSesbCxCybPsCxWXil4bhbiDc69IsKS7scfk9JoLOc8KVxjG44DZkclmeIxLbeCBP09ASa
	rpfO0Y+3sOPRO006txLYFVjRYAfH3BIafeq3po6UvrelBIJP+/aXEK4PEBrG+/SpbgmmSEGpfzdHC
	mRnUTt0zfdoFgvV4sX5B62LU7OCYYy2mWfnnHzKzFt2HfuVpMxNSYvGRa2uBqY3PZDOg14bM6UbXr
	emoacq99f+Dw4eRpnm8ZzAefmu50JkGn/e40YYNrToo6iAE7ziy3chjpmMeQrRUILTcbQjjiiuxMj
	BO6asW7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSe2m-003bok-34;
	Wed, 24 Jan 2024 14:15:56 +0000
Received: from mail-dm6nam10on20626.outbound.protection.outlook.com ([2a01:111:f400:7e88::626] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSe2j-003bnF-2q
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 14:15:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dp5YAURc6g/hnrd38xejhfL7mQnArLiR6B4fasfZy7BuMO7uvzsZEQoWpHOf91UnrE9RqgCbNkBexO4MuTj+Cl/k98jwH/9rkeRLK0h+ujgwKRQYHE9WJQAY3+G42FwaBAC5faM6vzSFYLPdxTMv7tostaFyBXy3k5hme5uZpMZmpwk7KhmWN/XR0XuwR2TYWtVucloqxuDxz6AfHVXUWJ5X+TTKs6lJC+4OdtxMbJCBTgBqP/SUBbmNHnxv2zk+oJRsDcV1Hv2dmFYm/rgKFvFJDoRZzYZwfdb51IqGWlA8mzQKyDU7pemSCYYk1/qOKNrW8m8T5zsukUxQq4/J6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VBKEtGNwFJan9w1w8ML4Kr5mWJbZXJiBFkc1jzZ5wM=;
 b=QiS91MsF9SqTsPLFOUVk75k7xcrRV2NEPpOBaaYySSeYIMWyVmeygelJaTFDVX9SFBoU7Jz9n+d3haiES5IFjA4s0YzSoechYddkN2ZU06s+PhhLk6cq80fMqmi74ssgMgf4dzgYEGCxfz882rula7DKcwX/EYId2+Ymg0ZeduHtZIzU+SA6Rnuw5szr/DkbregEnL0zsJ0XeZS8ZSaAePDrAjha6AVVjNvU2gEcWxfGjCHinvE7mIyfKgZD2roP+oei1DubMzLAQYOSZnFYYiVfQxaS1THMh3QFNUU//qBQMkmF1GZKb2eW39dxWYgbqOrHCnDcdEzmdVhRnOrcJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VBKEtGNwFJan9w1w8ML4Kr5mWJbZXJiBFkc1jzZ5wM=;
 b=JzBH6AY30/Eip0txetoalMRoJqZupElO7HRxYEmtTwrOtNHmF0++mzMPpAaVXFGYPSxFgipwbffkQEQIRefWHOGyS6rA6wtOuRwuNETewlN1m1uk0y5kxXHe3CDce+gUoRGhJiYMnlfwygDw6yMZarssjKBYIQbaM5X3cVBJpIUKg4VX/ZlAio61P3jYHBtmp/MIdA+A51lNgVXVFK1YmC74Da5bLQxGlC/byvnViE5QkHG3/9XCvDimqPvrmksaEmM8brD8vkuIGxjc3X5rW1TJk1fPHDa0+1VYNYy5YPSiJLH2bK8nEorVNEVYbvwscMahbRqFeIQsIakEedAzPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 14:15:42 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3%2]) with mapi id 15.20.7228.023; Wed, 24 Jan 2024
 14:15:42 +0000
Message-ID: <89c28502-7602-4be4-973c-becc8b8864b3@nvidia.com>
Date: Wed, 24 Jan 2024 16:15:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: oren@nvidia.com, israelr@nvidia.com, dwagner@suse.de, oevron@nvidia.com
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-6-mgurtovoy@nvidia.com>
 <d964c7a4-9754-4f31-977e-68d5c08c6e6f@grimberg.me>
 <60f3e0d6-1fce-4f88-84f1-154a5cde4f7f@nvidia.com>
 <42fcd973-223a-4753-8b53-b4aa0b97f414@grimberg.me>
 <b5910af5-2978-47d7-a312-830398c1402f@nvidia.com>
 <cac6959f-00e2-4b8a-b642-16dfe1a24383@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <cac6959f-00e2-4b8a-b642-16dfe1a24383@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::33) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MW3PR12MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: a1159212-b7d2-4962-8ebf-08dc1ce6f297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sSRg2Ildme1yhqyDBdNKwtlZA5BBkDQT6G4LHxJiTYOkQIjdXlTnEdLlEpOy2eAFQnc4K3r/4GaYPtpQt2j2Bwlcc0JZhWth8JXhz3ZdwSWp5BKVa4xqxFerJLAWZ8DWYpM1K+0AylxnDsppfIkufkm9oh3GQgxOdd1po8VVUmJInX5aPO81UmtknFe1FajLK1C9Gz1JYe86/sNM3+gjhnPiKaPGY2njyg/U+ZCxuxxR0YGIJh7lfXzpqOcfJzVklTQQtQ6U9PQFHPWpbum2Y++PINx4jHUP1PZnlToYiQEnX4SfokF3YEyyN0y2VWhW3P6lBOz/CSksB/3PVNfjua+IseMyZmFoRvkPmDUVjT62BsCzE6iUGYB3SRDT0eUlv+YLoeKu/rXOWyiUD6THZAWhJJXB+fNLzUQ94zLPEzj5n+gxOEj/ONU4vjEYEQThU1cXiFM11XjSQ2soqEyL6wzsb0lYJocKacLLvUccn1LuV5UTKiou3K7620G9ATtbkdN/Gdlnykm5APHkHybEh/tyyw9LOtJGbaN8CN9KmXGB89ygVhwl5smDvO9WHFaxWLlyI0VyvLO1FRY58lauFqK5ONiV2Ko2vVzRlrah6Gony1ONJmEts+sYBnbTiF31stmGESRfarVX9nE5JO+GsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(31686004)(26005)(107886003)(36756003)(6512007)(6666004)(2616005)(53546011)(478600001)(83380400001)(6506007)(38100700002)(6486002)(31696002)(2906002)(86362001)(5660300002)(66946007)(66476007)(66556008)(316002)(8676002)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnFQQVJZcTd1dzduTENCWTZ4d3V2TytoS0FTK3FxZ2NROElZcS8rK0sxSEE3?=
 =?utf-8?B?MHJrcGFSTWRjQ2FNTUlJZlZJbnZORUplRXVna1NmV3hUSHpTY2c5NFJOblQ4?=
 =?utf-8?B?eHI2bWRuVzVsSzV2SWlFRVRuVFlWdWFwWlE1dzhyeVNTOVFvWmlVTWdkWHhD?=
 =?utf-8?B?bjhYNU02NkZuMERNSVhRa3k3UzE0djJOT0hiSlp1V2RtKzlnOTNvSXVmcGZM?=
 =?utf-8?B?L1B2azRPd3lpRWozTDhycWdRNUhzakZrbDdLZTdUb0VjT24xeW5lWmNuK1Ni?=
 =?utf-8?B?cVVGSFZDN2sydk8zY1dSYXRMc0dwNEgxNmg1MjBRbFY5aUhYV0tTZnhXeGR3?=
 =?utf-8?B?L0V2TWJ2L1BjYzBhTCt5L1lCVGZqSk5hbnJKeFFLQTR3RmtocUlPK0phMlBz?=
 =?utf-8?B?empLS3hNblN2ek41KzFTM1FIY3dZME9QaVNYb3pQcCtrQTVWZnhGQW1QY3F1?=
 =?utf-8?B?M1Q4Sy9qV3NqY3VSaW9DL0RSU3BmUWxEN3RFMWxVOEgxai90b2NHeGlFQnlp?=
 =?utf-8?B?VjNmbEYrNnlHeDdtNmpXVmtEbmowenF4dCt4V1M2NSt6Q01xY09Jc1UwVUc5?=
 =?utf-8?B?OXNCajhQRlhBaklRNzBpbGx5S1Zqdkp0MVBSZUpjd3d0ejhKalU0Y1NSQnVD?=
 =?utf-8?B?QVRSSHZGVHY2WXZXWHlrZ0pqc0FBSUEvK3Bmdno3ZVptTGUrM3pGNU5RRE9M?=
 =?utf-8?B?K3FHdW9rU2JzTUMzNUdJbEpZY3ZWTmlrSzM1YTg2WVpHM05LM2lrQ05Lbktx?=
 =?utf-8?B?ZWc2SUhaTzI5NWlDMU1LWTh3c0dHZDZueEpiN044UmxCVHZ3QXZDSDQ1Lzgz?=
 =?utf-8?B?eC9BUFg2MFE4K1pBQWlVUVNQWDJOQXhJTUlTTERmQkladkZTUlBheXVmTzJa?=
 =?utf-8?B?WGZ4VGZDOGtsZlFwS29GUGVXUEhNTnVjV2s4WC93T1ZrQjBubEVLQ2tNTzFs?=
 =?utf-8?B?ZndkeDJkeG1mRnZKd2FIejN3V3lOZVlJeGRYMExjT2lOWmZWbTZ1MmhGdTVO?=
 =?utf-8?B?RDEzb1VvNWtCQnlUdUtONmFsRXNDSUxyM0pXcHlPMTkyU0V2TWdodmE2cGpq?=
 =?utf-8?B?M0lpQXR6a3AzZCtNWVpQNWMwdVVsY2l4b1hrSDV4clFnSkI5bVQ0cUNnSk9m?=
 =?utf-8?B?WUZOcEgrYnF1bzJWMVBsM2lRR0ErYzBUN2pXbDBFbzZVaGFiZ1I3SkJoM0E2?=
 =?utf-8?B?anpzcUlvZ0NtZVYyQ0x4c2hHZk1jZ0hKN2dRcmoyUTNWWUJXWklCWlNmcDJB?=
 =?utf-8?B?R01YcnpZN3NBV1l3MHg1ODN5QVhnbyt6L2ZDaG12NktVcTg0SXlEc3FQbE9k?=
 =?utf-8?B?dko4bDYwSy82TVZ0UWZOZmM3NlF2Unp3bmxKbzR4d016OWtZNUF3RkhmMGVX?=
 =?utf-8?B?V0VTV2NoQ1RQeEE1YnJJSDVSYkdRQ1Q1dmZtRkNHdUhFTmZtN2FnQlY3bkd5?=
 =?utf-8?B?ZGFMaVRrNW5QeEVaRHpBSGZvM1ExcTl0UEZNMW1yTEFzODRQcEd6Zkt0LzRO?=
 =?utf-8?B?Vm1NOVlYMStwQUJLTC9JcUc2NFMzTWtmb2JkWXpxcTdtZmhuK3BPMzl0TGdW?=
 =?utf-8?B?VVphT1hKeC9FQTN5Ky9qYXhCblpSK21DeTZKK3BkOVFHK3dvWXlBLzduMU9O?=
 =?utf-8?B?VHQ0S3JiZTNDeEw0YUl1ajRFUG9VWXNNcURNMXJVUUpYRFpzWFdoVlkxdnA0?=
 =?utf-8?B?NTVtMWVUcmpxeGRxV2h3U05QL2s0Z3JpRU9wVWpkSG1lK2RIQ0lLTjMvTDcr?=
 =?utf-8?B?eXVISVR3LzZyNzNOVC9UU3BYNVdNcUNhYUZnTkRUOVlZdHlmNEhXMUMxdnBn?=
 =?utf-8?B?MFBxUUd6aHhJNG1PQXYwejFQT2FzcWJnZ2JCcjFYYnhjN3NlUXpaS3YvSGNl?=
 =?utf-8?B?UmkvdmRLbjhybitTTG9hWWxYdVRnYWs3YlZ6d21qL3kxTTQ0MC8xQURsbDht?=
 =?utf-8?B?QmI5bDNsM3M3c3Y4ekNXdGI0NmJGaTdvTmxSUUo1ck1IZnBIRkZiNEhkamhw?=
 =?utf-8?B?NmN0R0FQcTlxaUFwTHJVVWoyenhPa054OWNoWDNlakI5b2xtZXNoRHNiMDhU?=
 =?utf-8?B?SGRPd09yQmNjZm9ZcWlWM1ZyakQ5RWRyN3FyZndOcFNHc3g2VGd1NHg1eVNO?=
 =?utf-8?B?dTV2bTkvaWUrZk5mc2ZwT1BFSXlyWFNMSUJ0dXRPcXVFWFlQaU9IVE9NVkV2?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1159212-b7d2-4962-8ebf-08dc1ce6f297
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 14:15:41.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZAjhuqdS0re5NLrkWqXmnPtDkI7PAFlMAQVYlWKyWIs5GzDB2SzS8aiQ8LdwNU3BFQ1+Ge5eO0JRvHa3jWqKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_061553_936239_A7C7BEBA 
X-CRM114-Status: GOOD (  17.44  )
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



On 24/01/2024 15:54, Sagi Grimberg wrote:
> 
>>>>>> @@ -4537,9 +4536,10 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>>>>>>           nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
>>>>>>       if (ctrl->queue_count > 1) {
>>>>>> -        nvme_queue_scan(ctrl);
>>>>>> +        nvme_queue_scan_sync(ctrl);
>>>>>>           nvme_unquiesce_io_queues(ctrl);
>>>>>>           nvme_mpath_update(ctrl);
>>>>>> +        nvme_kick_requeue_lists(ctrl);
>>>>>>       }
>>>>>
>>>>> I really don't think its a good idea to block ctrl start
>>>>> like that.
>>>>
>>>> like how ? scan_sync ?
>>>
>>> Yes
>>
>> why not ? this is control path..
> 
> Because in the real world, namespaces (or HCAs) will not change their
> attributes in 99.999999% of the cases, and when they do, in 99.999999%
> of the cases the inflight IO has already failed over to a different
> path.
> 
> So no, I don't think that preventing the ctrl start from making forward
> progress until a full namespaces scan completes makes any sense.
> 

The correctness is important. Namespaces in NVMe can change dynamically.
Issue a request to non identified namespace doesn't sounds right to me.
For real world use case, that has 1-5 namespaces for a controller this 
sync will not cause any harm.
Also there is some patch sent recently to perform parallel scanning of 
namespaces so it will even not be stalled a lot for the 1k namespaces case.

>> we have to make sure we issue commands to a validated namespace.
> 
> I think we should simply refuse to create the ns when it differs between
> paths, or remove it in the highly unlikely case where it suddenly
> changes its attributes when reconnecting.

how will you refuse creating a namespace if you didn't finish scanning it ?
This is exactly the logic we did, but we need to get the new identifiers 
and understand whether we need to remove old ns and create a new one.

