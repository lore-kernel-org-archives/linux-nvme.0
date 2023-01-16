Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000A9C3DA78
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jan 2023 00:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PI1Wr5txXyjNwre3pgqi8ldXWCwqCBCuefIwLZL+EL8=; b=ERTcjbIxkgYxZwmvxtKPuwenTO
	cGtSY4TbBaJfSsJqWjzslSODMsdz/+Jo6XHZMLvKnUHCDOz+ln4k76l+MIDKFRYn4tUl+OZ1N/UTX
	8iA+Cp/P0e0Sut0NOYPzMAmUf35JXEsHf7SYdsw0Xgppv2AquszqmJHDjJD+c/jqpYHADLnXG+j2s
	kjZ2CioRKShTmlk4k6HxLOUcpPQZPxj7P+hnKtvbSD/Z4eCqOl8AOJ3ZRTKUwb1CeQ+hs+TnMe48K
	30LwV4SSF2F6LpX5oLISJTSOMQn5UmKhkHAGDJWNgNX0OJFGTcFZyg1gx+LNeNNi3aMFIIVCBIluW
	5rny0Q8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHDMs-008D4D-GG; Mon, 16 Jan 2023 00:28:54 +0000
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHDMo-008D2n-O9
	for linux-nvme@lists.infradead.org; Mon, 16 Jan 2023 00:28:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkEQv6oF4vaHSWkOTkKA+S8K2FkTuQSzX7eY7ACy2eMjk3zDIx02a4Q8webF2rRaIqxi5whq+h/apn/0rWAoIWx+hdZxjsM0G5B6s+llrg5Gmmdx08VAiQ/4dcsTEalB7VeGdhVXtjGxlNFn9PmfrOSu4meSJeV42WpR5j8LxRIn4f2axcFQSu8D3DsQGcr1Ior9Z6reID7nJSO5hsvkGoGSLwOUWX+5UyTJlUc0VG8B37qJSDwOZjT5Jty/Qzc4q0SWWAYFNvLQKnVgeU0c5iV7WPPDQmYpuFjQn3ICk8VBxRGhw5cDdRz8mGZ/pfROW9ZQRoqUlZncwwnckV0MKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI1Wr5txXyjNwre3pgqi8ldXWCwqCBCuefIwLZL+EL8=;
 b=lyBAdr5fLIPuDGZlavbw4pVuLOcTWGPgA5sQcyABpRDwpRgPqT89H8oXrLpLj5Ub58tb6SwcQ9VhTcAdDynk1WFi3W4uG9FEaaS6lrI1hvfh75JgCtzXElVxEPykzJagwUKcUEqaNrgD2XxmhC+Ug2rQ5iRcohWd0X11MFhddFBQbZ5Z8CzYlRSWne8B+Wy5JqoF03Xt16xAIRxOZu0BdIJxoBLSMP4+U9OtdHwqf5W2R20dfrLtOFaL9vYkRVWyosQfW9DBUdzzkbALMMCRc6zVzHIgpOcSOLK8+KfWe714T42XZ/aVfzqKErYe+Tmx3MC3ltXdeR+oiuf5HWHBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI1Wr5txXyjNwre3pgqi8ldXWCwqCBCuefIwLZL+EL8=;
 b=VmKZ/LtFxjvh1Rqv3fmIEgJH+N0pX+IgsA22cpCbHZUOmeci4lpyrmxXlvydiutS+IBzUnMBp6P1RmJa1KDiRkrSGJZRZdJdTmJdaMy+SS0JKSL6w/ShoK1dIaqmL3ilCD2xTSqxl+Y5fvIdfmKdCOLJRtm6rKfehiO3l6QnPqKEFfSKYs5sSyEi89EzMLzOiz2SAIyg+R+x9xJSNmuBnA0lU2/xfYr4ZBE3aVQ5skCIdWyoua7Tt0i9LQFuc7KeGHZyjRNW/hb3mY6mnAwnV2xMoM+0oM5UabJGCXKluuqRvbu+eeVsVd9aMiYtpppdfKYu/+Bgw4DF+F5lGjaY/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 00:28:45 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9444:21e0:2a65:da95]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9444:21e0:2a65:da95%8]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 00:28:45 +0000
Message-ID: <0936a1a5-c798-ad90-6be8-3f22fc12460e@nvidia.com>
Date: Mon, 16 Jan 2023 02:28:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] nvme-fabrics: introduce existing_ctrl operation
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org,
 hch@infradead.org, kbusch@kernel.org, sagi@grimberg.me
Cc: israelr@nvidia.com, chaitanyak@nvidia.com, mgurtovoy@nvidia.com
References: <20230115100341.40347-1-mgurtovoy@nvidia.com>
 <9fbdb00d-4d79-04eb-c986-814a5e1f9212@gmail.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <9fbdb00d-4d79-04eb-c986-814a5e1f9212@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::15) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|BL1PR12MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d10454e-e7b0-4215-f7d3-08daf758a096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	a5vipbcAn1S+bDwqZpQmef12CvgqYrqpYHR12pk6MBb5JKnAtSP1azz7a17G5DwNayNQdr6pil/EFRtHHyM01gITrVNE/QwIaUtWoP5cPgzABa/uWvddSCETj/KdEFIOU5m1dx2usN8FZ10k6nemQlFRSpRa31H2LYlH6oMuEZZ1ot+Rrd0aNAyVxQwYJoWMqepb3ZmnyRM2D/Le/hCEdBBINSn15rKQ2ighSlwlBwWVZkxNL7TKLYBIw4lDLo31IFN39AC1g+r/kOxZi9KE8b6konZUtTI2Fyh9PwtTq/L+9H23Zf6t4KFdRGojJNm8hXsiuHmOBGOZvxI7iiY424fiHbsZu3JDZZOSds0OuqkDCZzNUCT5/k/bEAyuiNmmKt7btrZ/k3Ernm9PPfKUgJZgbFCCwfhqnlLONlJp0AfFTmVSymIa9dVzNwgneaDfyPUpfgSRCbMT7tVz3IVSDaLySHSZJ/+779VbNcqGLtXuj4rPLuPNna+2kZz9oyoi/dDV7BGhzPl2BhHGMe4OHYP3ZDG2UWGCpFVJWmuBYPR1GUZxNyUVO503zKEPUz75RAF6MuJsdgZJVKOjyky8eaK0PgMWuSCVh+6I0umKNv9GYXNnjuj6UkYVfUpAyZFljYI2JNojj/ffoH/4Crzj4EXfC7zSwXULVYhiNOh8fDn9oWM31RlbYG8fAJc9uGCL0wjdoY1O6rkvRuY9gokkUeYC3fI9btkY1O+m1K6qfcw=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(2906002)(8936002)(5660300002)(31686004)(83380400001)(86362001)(66946007)(66556008)(8676002)(66476007)(4326008)(36756003)(316002)(41300700001)(31696002)(6486002)(2616005)(26005)(186003)(53546011)(6512007)(6506007)(38100700002)(6666004)(478600001)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?cU9WSngyd1pMU3pVc0ErWFNYVXU0c1VqZjI3UDMwc0VnN2IzUUJNaDFHakJC?=
 =?utf-8?B?dU5GYzZoYTV6MVdtREdzWG1TQW01MGRCYTFCZmthVTNrYmxQTFp5ZWI4YXFa?=
 =?utf-8?B?a2RXTFowb1pWekMzcHhiZStFUTEvVGk5UlNNaHJUNzRXTzNCQ1JzWU9rekJu?=
 =?utf-8?B?dWg2T3F5ZXlvQktMNXlPQ3N3U1NJMGhMeXo5OUZTR2dWdWlNRldKZW56Zldh?=
 =?utf-8?B?d0toNkx0RTM2YUduczZUb2gzVXBsbmJlQkxvS2gxaXlVTFNFeHN4ZUNwRElv?=
 =?utf-8?B?bU1hN1FkVWJucjBaSGlNQWhvUUhwd3ZEOWpISnhLT2NDVkZvTVhIN2hHdDBo?=
 =?utf-8?B?aXl6Tmt2QXhGYUhSQVhsRSswZTA5ckhMK1k5RlhEN3phbk5HSC9SOWVSVHY3?=
 =?utf-8?B?WTdUenVmTDVOZXJEQ2pvazVZVXdBOTVJUHZDVnFvWG1wYmJwOWVlazlOd28x?=
 =?utf-8?B?bXhERStsWnV2czFEL25mcnNTQWRUbTUwcm9xTG4xZkxmZmJrbU9wRlI5U3R4?=
 =?utf-8?B?M2N2Z0ZZajY3djMrbWhMYlhlRUdsTjk5cW5RSFBrcmlEY3REd2ZjcVovendC?=
 =?utf-8?B?ZEpLbTE3OG4zVzJzcTFPVEhDZnE0SWIra3psOVRSTFBZY2QvUTdHVVV2dERG?=
 =?utf-8?B?U1pjSHNXSitDVnNWQnBnU1F6ODBITGpzTVkzVGYwSy8rbmp4UFpqZkFORVVs?=
 =?utf-8?B?SU9TLzhTeXhVTTVnV1ZKaHg0enVUS05JVFFGZ29YVVh0NmVVU1ZzMElDNHNw?=
 =?utf-8?B?MTZWUGpzdklSTGNhN1laS01iMTNBZElmOFdTNUtXckNkN0xVQU9IYXdkV2E5?=
 =?utf-8?B?YUhWOHhFdEZiODhXOVFDbTk4ejRVTThjNGswcHV6SlMrSjZDWWtQeVdQMng2?=
 =?utf-8?B?QzMvRTdkcmxUODhXRkRCbEVHMC9wSDIvaXlLQk41WWFzZmJPbWtYY0pVUThC?=
 =?utf-8?B?SFR3MEExSXA1Yk5JTVdsNVA3RGt6RHFIclc2VEhnOGgweHVxZzlWZzVZWTRz?=
 =?utf-8?B?Mm85d1FtejBaUENuOFl6ZmZkMkxGOUZ6Nmtrc0hFdGN3dmRTdXFHcDdUR0dG?=
 =?utf-8?B?aHQxbWJTL0dtU0VLK1l2UUQ1NElZSThHNklRTE5SUGdsR2EwQThGY2Yvak03?=
 =?utf-8?B?NEJFaEZyenllenFtTWZFbUJaR0g5eExpcUZxOW5DVjBGVmNiU3FOQ0Q4VXFB?=
 =?utf-8?B?WmhiWkNoU3UwTU5WSDZrVHVyWllENWpwT0RUK2wyK2FMYUdFN01TYUdQbmtU?=
 =?utf-8?B?SHIwOEcrQmZyV2VTRFFNUnc3clkzd2JKUDNhZ0xCbnVxSW1ydUtzd1hzbWZB?=
 =?utf-8?B?QllXRDNkRUlPdjlTUFJhSlpUL3NXWmZRWWdNV3A3YkJ6MUlZaDBVWnJ1NGE3?=
 =?utf-8?B?bWdjbVdqekNTdmtvcUpWSU9majMxZU54R1lqYzhSMnNTclV1MjBNKzhEbmFW?=
 =?utf-8?B?MmRUTlhyaUVXMk5xT2dETHUvL3lJVDJkS3ZRMjFoVXN1TEVhNjU1R0RGQ3BK?=
 =?utf-8?B?RjZudXp2b0NLNWVjOGdIVE82ZUdhakZoY1F1SnN6TVJPMUExN0tVVHFpVHRU?=
 =?utf-8?B?SkVDSDZpek4ycEd1NnAzMHlVeDJQeDFKTmtFbG5DdzdHdXNxK2dnOHJlRTR2?=
 =?utf-8?B?N29PNWNXZE9wV3V6V1VtRE4vVms2L3dWOGtTY0gxQmk4eWQ5NnYzQzJXNTZT?=
 =?utf-8?B?a24wajQ3aFUyWlg0aFZnZlFtczVZbllkWSt0d3JDTWNvenBpeDZ3a1hPS2d5?=
 =?utf-8?B?MDdUc3F5V3Z4dmVLeUFkeXUraldnNkZUOU1Lb25QNGh5cWtucXZjNktVZTRR?=
 =?utf-8?B?UExKMmh5VTN1ZzR5VHJFRW14WjhPQ3ZxVFZNWGZpaVpzVjRMdTNJcjR3WTIr?=
 =?utf-8?B?SjA5cVRqYjRGNmlGMmsvUWI4R01teGprRkFEQkVobmoveDBQSmhEQXFVNFV6?=
 =?utf-8?B?MjdSMnV5UE5SQmhwS2EyMHRRM1BIVjNFTDNUU2pQV0U3MFBrZE5nQ1NCaGQ3?=
 =?utf-8?B?VlFlM1lQenMybFZ6Ylp5QjhjSFZHUi9kb3dKTll3NVU1bzlSVnJSQmdINVJ3?=
 =?utf-8?B?cStnYThjV3FFZ0RQcTIxaXk4OWRLbGlwUW5ySnZHY0FLeVdRcGRocTNCRVVp?=
 =?utf-8?B?WVVyWGR0cXZpcXVrT01OR1pCcldsVGJnd0gwVlZ0czZZNStmaC9WTWx5ZGRW?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d10454e-e7b0-4215-f7d3-08daf758a096
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 00:28:45.2745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdy8EZrVuhckhjW/Mxh5fb/O9dWll27C4U3fjWa1ocORlsCABmn8PKwCmxYxpIYEkcQqTL4P0pEFMK2l7cmDVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230115_162850_870888_F20C56F0 
X-CRM114-Status: GOOD (  26.13  )
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


On 15/01/2023 21:51, James Smart wrote:
> On 1/15/2023 2:03 AM, Max Gurtovoy wrote:
>> The check if the connection request matches an existing controller is
>> duplicated in several transports (such as RDMA and TCP). Move it to
>> common code as optional operation.
>>
>> Also, this check can be done before creating the controller to simplify
>> the flow.
>>
>> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/nvme/host/fabrics.c | 7 +++++++
>>   drivers/nvme/host/fabrics.h | 3 +++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index ce27276f552d..3d5035331b9f 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -1100,6 +1100,13 @@ nvmf_create_ctrl(struct device *dev, const 
>> char *buf)
>>       if (ret)
>>           goto out_module_put;
>>   +    if (ops->existing_ctrl) {
>> +        if (!opts->duplicate_connect && ops->existing_ctrl(opts)) {
>> +            ret = -EALREADY;
>> +            goto out_module_put;
>> +        }
>> +    }
>> +
>>       ctrl = ops->create_ctrl(dev, opts);
>>       if (IS_ERR(ctrl)) {
>>           ret = PTR_ERR(ctrl); > diff --git 
>> a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>> index a6e22116e139..587b92575a9b 100644
>> --- a/drivers/nvme/host/fabrics.h
>> +++ b/drivers/nvme/host/fabrics.h
>> @@ -153,6 +153,8 @@ struct nvmf_ctrl_options {
>>    *            that would go into starting up that fabric
>>    *            for the purpose of conneciton to an NVMe controller
>>    *            using that fabric technology.
>> + * @existing_ctrl():    optional function pointer that checks if a 
>> connection
>> + *             request matches an existing controller.
>>    *
>>    * Notes:
>>    *    1. At minimum, 'required_opts' and 'allowed_opts' should
>> @@ -170,6 +172,7 @@ struct nvmf_transport_ops {
>>       int            allowed_opts;
>>       struct nvme_ctrl    *(*create_ctrl)(struct device *dev,
>>                       struct nvmf_ctrl_options *opts);
>> +    bool            (*existing_ctrl)(struct nvmf_ctrl_options *opts);
>>   };
>>     static inline bool
>
> Reviewed-by: James Smart <jsmart2021@gmail.com>
>
> A bit disheartening we're "commonizing" in manner that FC can't 
> participate.   I looked at FC supporting this, and although it could, 
> it's a bunch of code duplication, more code than leaving rdma/tcp code 
> in w/o optimization, and FC still has to repeat what it does in 
> controller create as there are other checks to be made. It's more 
> optimal to leave things as is on FC.

I tried to make this change to be applicable to FC as well but I wasn't 
able to figure it out so I didn't add changes there.

As you mentioned, it's better to leave things there as is for now.

I don't see any reason not to add the FC as an incremental patch to this 
series.

>
> Max: mind pinging me ahead of time when creating these common items so 
> we can get the 3rd transport participating if possible ?

Sure.

I think that a lot of logic can be moved from the transports to the core 
and I did an attempt in the past to do so.

But we need to make some preparations in the FC code so it will be able 
to enjoy it as well.

>
> -- james
>

