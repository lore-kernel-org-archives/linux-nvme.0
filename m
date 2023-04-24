Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CFCC77B61
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ia2ka/OnFg0K9ff3BOHdpgDCguA85vtOl7akcGWJOsY=; b=NVhAddPoN8QfFdNJpq47PzB2g7
	mJq4KoO0jOyiQ44sziFnNlFhImiGtzwGWpUtr3q2AOBoH9I/d/I4ssnIGLzaXG8vVBua1T+jDx7SP
	kLFgSNyNFWShkdp2h3cVjuXajpFm7VtGVeIe8o+3ZSrVMztLB+cjocAKfcVsC/J6WrQfwP25GqbMX
	j9lLM77zff0DjBYztMXIyj6Nl4AIfL5sVCwVY8YfjeEaKfNK/eyVHR7svXx78HQP+OVUe6cf9Z9h7
	+gZU04PV0l3t2JQmzRugS4gqHvLg9hQvG6/pJ5/fwiTr0tVN3QxTxWqcGk6ddvvQ+yZEljvT8a1Rw
	2yMfd1qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqwlO-00GWAj-15;
	Mon, 24 Apr 2023 14:01:54 +0000
Received: from mail-co1nam11on20607.outbound.protection.outlook.com ([2a01:111:f400:7eab::607] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqwlK-00GW9m-2r
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 14:01:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8Z0DOaPxZxaYZ9JonmOVrcq7NBLPvBISLRBWWarSE7iSKkFeATFd4yiGzReoV5bFOPbK4xAwPJdrc4sAuGyWXGkioPTjGAIvkMK3et3LnWdCxtocnuQV9fpSlqjbC90hi2GgozfH1g9NrF3/euNil2R7Vv6a1bHASyamagrucnXAzw9VfQfr5f3dPMKJOQBEh70yFguFQ4x0S1eM6aCzZp33jUnuLM420fSn5MY7Y6+jRjxVSKq0TgSG/QZd7LDE0PRdv3E7e/HvpHBiVV7/rvuO3wnFb8ADQGogtBJZzTy0DaQnUMiQXLC/szCMPjEQxGWEt66v5fWhkhb3C2lJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia2ka/OnFg0K9ff3BOHdpgDCguA85vtOl7akcGWJOsY=;
 b=Ej3lYDx1yTdNmjakUy0DDxzDr2ons3v/tGFKxfcf/VLww+2M6DAvOp7m/EHVTAY8YYvqFT4iAC3s1GczyHIm9w3OEOgxlbjfMxKTz3WlbSz/yFK45TRYb+iYKPF0rrrVTJlRsCxUTGmY+aJlZoTBIwJsuV+z7qp/fFvOKIuNXFUzAj4+phb5yoTM191AkWxCvB4FpXXScbVMbkMO+HQANXALFp92aOypWLp/rFN/Fy6cWxzWdEWXVmuvwHZmad4i+l5X5WwyFXf+kwDX17VeJLcRC7WsbWX8YGqvE0c2o7xWr2/UhQwpv0OA3/2uoHpEwnYMJecWhZX/pSHSbDUPbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ia2ka/OnFg0K9ff3BOHdpgDCguA85vtOl7akcGWJOsY=;
 b=ivL96R0q9UzHBKT8AOgPHzddNmszjvapen/WhuqNvyut0eNZhUbfSDRnF0NyUSm08LAYePQii0T92GFo2meDHmc0zX9AygactxPjaQYnQ6aQcwm5fmwjYWKvQoEuqY07N2wK4sxRlSuhsMfKWOqBPRYhPgbtNsMXPZxfOX7YIDfoqwj6XcUmlO0D0iHBmmyc0Ti9vJxNK+kd6y3UJjGC1X6nSbKvOVynQXqST/qG5zgQli+/6Au2Oa99XNlQiFJmMCNHZdyPPvaIVR2cKv2dYF7wAwt5Nesj9/CxTj+NQoizeSC2f7lOPk567mL2d1Uj0iv231QwiuABAroKTASSUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 14:01:45 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%3]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 14:01:45 +0000
Message-ID: <97b1df55-33c7-d31c-d99a-6c6f5fe4f361@nvidia.com>
Date: Mon, 24 Apr 2023 17:01:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 1/1] nvme: add a dedicated .c file for sysfs interface
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org
Cc: oren@nvidia.com, israelr@nvidia.com
References: <20230424130316.25805-1-mgurtovoy@nvidia.com>
 <ff1eb7b3-890a-7f12-94ad-6951bb1533ab@grimberg.me>
 <980a8241-407f-a3eb-a1b9-d5eb1ae0ecf5@kernel.dk>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <980a8241-407f-a3eb-a1b9-d5eb1ae0ecf5@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0165.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::13) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 778ca35a-de66-4021-4c4e-08db44cc7090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	U6zAqquFse0yQ+dtSJCgUXeD0HEE/THwWlemGlsy7QGKR2vsU+uUBPXVx4TDk4KyBRB+idGemaxHBQlgRiUsrmadjisvoFxjoOLj5WEEJSQSTzPNclgCljvVonJ9GVIIsA4+ZyHCi5h2iq6E3ugn1z67R1OS9OYSshiIjrL2IqqNw0dITBJRgFPO7vrG+qb4hlWNjsphP7ZOLV8XQ9w54mbM0l3oEK5UqyMLmFqx8hUAK0Y5ywB+bjyabHiycwAEod3/mWcQ4JgconseGfVQmB/95UAgDuo1JVXX7+s5r2YJNBO9ILk7/1wLMdt+ZEHB8+KNXICg4kLfZMni3ddbfd2s/DTluYD6OpvgGGvw3CRCEPO0UmzF/BDn9+nE/hlSbMTPgaUarkHCKNvvTrtzjAH084bBBvmYnHnkXAt09DfQF065XAKJ/kmxFv4dbqxtUdcxyPqkY8b6oa+Tm2X2Ztx5nrcdLD94dY0Qva5a09IGa0NiusC9/bvIwMXLSppTzTCUYULc4+U5qC6bz7ArQ0xykN2vdResBES8pKLo6hEbxX5O8FwHS1Mim5lGGWKu7pvM5kFmSoG/HRCOh+Xo/dZGa3yOuOnXKVzrdnsKOvSXahmJSxYLiwnDEPPapeaEzv5E9r9vcPLZ9BuMQ6SiewH2/fEysgYwh1JglJiHJiU=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(36756003)(8676002)(8936002)(110136005)(478600001)(66476007)(66556008)(4326008)(66946007)(316002)(41300700001)(4744005)(2906002)(38100700002)(5660300002)(2616005)(86362001)(186003)(6506007)(6512007)(31686004)(53546011)(107886003)(31696002)(6486002)(6666004)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?bjNzVWIrMHQ3eEZhbU9PNTlyNndubGphNFVaTi94OGRieHpUNndwZm9jQ2Q2?=
 =?utf-8?B?ZDFrNzNUcEN3U1RQbkdaK291ckdhK0VtY2F6Q2ZTcnBNNXhwVzcvMzZEbjNZ?=
 =?utf-8?B?VjNLV0Q4a25HaDFkWC9EQ3VQU2RJTno4Q1JWWmI1cWpKTDl6dXlkdFhvc2l3?=
 =?utf-8?B?OFhaQ0JFSHpoNm5jRCt4U0k3d0xTSzB2c25Mb2V4YjhDUGN3ZEc5MzhJMmZS?=
 =?utf-8?B?L0tsMkovUTR2MmJhRFEvNGRKd1JtNWRsUC83L3VNaWdzeDkwMDY0b3BWV3B0?=
 =?utf-8?B?RnBTalBKbHZIY1BMazMwMUpuSnl1WTR5Z1NBYXdsZnZpWko5b0Q2dFA1NHJq?=
 =?utf-8?B?UkErOGRLN1B0RjlMUEd1SEwrRm5DakRvaG1Ic2dtZm1RWXVnYnBXUWZLMytV?=
 =?utf-8?B?UlVHRU5BaFFSaWZMa2FQOHBYUy9MWG95ci80ZWNrakhwS1lsaEhScGlySmxk?=
 =?utf-8?B?bUEvWFh5NGl0ZE9ETnRKbjUxQkx3TG9oNFVGNllXNlUvZ0tvNVFIbkVCd1RS?=
 =?utf-8?B?UGwzcnFiWldpa3lnNmVZd3pSaVhLMUJ0cWcvSXpXREZBZTdLbVllMXpOZCtE?=
 =?utf-8?B?UUVtR0cydWZqWUZ6N2xzYXZiLzdNdnZaSGlQOWxZNUc4U2VJc0dPU2xuNTZB?=
 =?utf-8?B?eER5VXdRN0NqY2l2alZmSjFkRWljV0ljZEg3OXNuOEp1WExqVGJUMit1WEgr?=
 =?utf-8?B?ZEc0OTdtallDdHNHR1RiQ3Jsd2dDMUdCb3VlRGQyTVRNcGFLTityUEkzUDZD?=
 =?utf-8?B?cFZzVG42R3UyczJSclV5N1YrUTlCK2c1bEdKNHZ3MjVmdlA1dGQrVnFUVC9F?=
 =?utf-8?B?blF4Nmg4RWxLUjVKSHVMU2VPVUU3NWY3ZGU1UUdBK1d6blBiTEtQcU1UZGR3?=
 =?utf-8?B?RWhuTXJPd3MxQmRseCs4cVFzT1Y2azhwMUdzcXQ0b0ExdXZYWmVuZVhPcjlr?=
 =?utf-8?B?RGg3UDRDY1hxc3UzNGczWXJkWVNLaUxneGF2UmRqLzFhWXpOOCtsUnBLTDda?=
 =?utf-8?B?STlrQ1RLZ3pjZWM1Yjg5OWRqaWVwb3F5dy9UdGFiR3RSMXgxWENJcXJlejJt?=
 =?utf-8?B?SWprK21iRTVhTXJjN1ArdnRSYXUyR3Fjc3g1YXhvYWhTSlRSRkJkK1ROMlVC?=
 =?utf-8?B?Y2RxQ1BkekRGazQvclkySDZreTlZMXNsUTdUa01HaTFMNmFvKzlDeFpWSnJU?=
 =?utf-8?B?MlVISWxJS1QvRzJjZ1ZmZ1pQeDg3dTAzazFVQ2I0ZFhna2dyMFBUOGZYNzM1?=
 =?utf-8?B?V3FQWTZRdXBRUDlrMDhzSUd1WVBqTTk5aEtJSmlQZ3BHM2VkRTNHdUMvZmh1?=
 =?utf-8?B?R1dwTWV4UG5sVXVoc0h5NlhrRHZ5L3VvR0Z1eDVlV3RmeGxqTE5kbTZoSzZH?=
 =?utf-8?B?OGsrQXlTN3I0OGJOd2RVU3RNb3ZWSmFzNklBeHdpQVBHVFNyQ3YzWFRCbEZq?=
 =?utf-8?B?c0FGUC9PUStwckszcDFHY0F6eTdxL3oxRFRtWHI1Mm9aVDlCMEM3TkRRSVZ3?=
 =?utf-8?B?ZDdHSUN0a0pJeUlBaFpKZFF3R0xMNk9WN29GUEgwMHhBRENxQkdZajdiUGVs?=
 =?utf-8?B?NzlGaXRqZHI2TUNrWmdROUUrUWtja3pzQzRVdURDREdqdDVodGIzU2twRjhS?=
 =?utf-8?B?TlBxS0hla0oxQjVmZDJmRE9pM1Vndm9BZ0lFVTF0ejJ6TGx5QnczZkJBbGZF?=
 =?utf-8?B?VjNqK3l5L3NaVWRIVmVDNkhLSTJibjlrUGlIYWYrSHZYZGVOeE5EOUJCWDNt?=
 =?utf-8?B?YWVRYk43VkhXUFhZL3BVRzVBT095ZGN4NEoxZ1RSNXFkb0dpYVhkNElwcVJL?=
 =?utf-8?B?dVJTdW01ZGRQVm45ckNzczFjV1dKdmZUMTNRb2REd1NFb04wMkZzQWIvbWZK?=
 =?utf-8?B?RkZjcWhGek1WZEthbkJWcXU3cUI3TnkwdXN2TDY3UUZLNGF4amdhYnVsLytv?=
 =?utf-8?B?aUI1V2RSUm42by95aHh4Ly9DemFmTGw1S3B4QWZORTIrbzdOV1RPN2JRN2pW?=
 =?utf-8?B?Mno0Z1hoWU5qWXREQmVnT0tXUlBRMGo0SC92ZFZ4RndJbHE2WHFpOGg1dGtw?=
 =?utf-8?B?M214UE1wakJsYlU3cjNkVERxRFdUVldIeHVDMDIxczFkVFpEVG9XVmdUaXd4?=
 =?utf-8?B?UFRadE1saVBHSnJqY2hST1pTSThqRm9OUHoydk9zVzdDdkNaTEFZYVdwdkxL?=
 =?utf-8?B?MjMwUFg1WHVSVEtPZ0drTXd2K0VwMHZkaVVBZDllVWZpMzc0TXNjanR2dnRL?=
 =?utf-8?B?S3pNNXZFRmpRZ3lieGlVRWlMWUlnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778ca35a-de66-4021-4c4e-08db44cc7090
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 14:01:45.7930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXyNDIQ+LlWk038UJiqcxUgg5rU5IMD3RpI1qUiGIRDcDiuadmPnlEfUsN0H3QlsT7gtCGzTWf5Y/tQbf7/isw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_070150_950129_119EB574 
X-CRM114-Status: GOOD (  12.16  )
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



On 24/04/2023 16:56, Jens Axboe wrote:
> On 4/24/23 7:38?AM, Sagi Grimberg wrote:
>>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>>> new file mode 100644
>>> index 000000000000..8d2aabe2d290
>>> --- /dev/null
>>> +++ b/drivers/nvme/host/sysfs.c
>>> @@ -0,0 +1,657 @@
>>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>
>> Linux-OpenIB ?
>>
>>> +/*
>>> + * Sysfs interface for the NVMe core driver.
>>> + *
>>> + * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>>
>> Not an expert in this matter, but does copy-pasting full hunk of code
>> from one file to a new one qualify for copyrights claims?
> 
> IANAL, but that seems bogus for sure. Adding a copyright claim for just
> moving code is nonsense.
> 

My bad, as I mentioned to Sagi I will remove it.
I wanted to get feedback on the concept.

If the only comments I get is for copyright then we're good I guess ?

