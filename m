Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2CDC7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ujPntV1tKQbQ8UoeOD1vNGiJ5DHWU151ZD0/bwwDtnc=; b=eS8tKM/Q/ApOJ1DZH4r+iNjf8w
	ln5JRw8Im600XdJMdjQ84Any8R3qCS87XrCw5MI10zs+axZPNW6inWlmUUk6NK85fBJVlVkEOt3Pq
	rn95TByx17xSmmGOKkkrzVV0oevRcDGs7iTaZP49GOC+19PDHw2z2vZd+A/cAje1QVmTZkbVYO4Ls
	SvKQh32xzikG0VMZDUZfqIFrMy7Sr8RlyoXfo/TOebKkHQ+MRUzd7mazDUutbC3fP7oiiRopYeKYv
	qr+m8JhTodFnLPYX/hUb3ltmcJjRELvBcWTDykU5dg8+ggxZbDKnEBuWTKT2bdWzaH5UyHs7+loeW
	SKgQkpQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px6Kk-008roA-13;
	Thu, 11 May 2023 13:27:50 +0000
Received: from mail-dm6nam10on20609.outbound.protection.outlook.com ([2a01:111:f400:7e88::609] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px6Kh-008rnN-13
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 13:27:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcbN+wEseBvf92J2Gsn+alJ3xE1v3hb6pifupmcajZT68eS4HR3mASMTooMPziaNS4ZL7WeFT7xCgIuf7UMB+i26MtCVkAfqSg23Jgya6JUwkG5lRuXbodt/xO+1Khq6Nl0rNEXlvqGKvfpfogSZYRuWHUEYlYaKxZCXQQ/30itqC4JylkZsNfsWUtWukC2Jjyh3genIeQbtDgkcj17pGzWdo0vfTkQaLYaR7ighWBWE/uNffMrTN/FMLN2JW4moIt7cUip65exKYgVcKZLgMO2HliOGRxGJ0U7UdE9vQmqesRbMAZYduV3Kf3RLUXU30AsoTUIHFn8kgBBAUSGeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujPntV1tKQbQ8UoeOD1vNGiJ5DHWU151ZD0/bwwDtnc=;
 b=Or7HFTe2rzluFuoW3xQTblZWE7PT4qHvYQ/w1f9qd+PaBl3lFW2B1xcuuF/myuDanl4ha4y6UXZB7kAUwLHCkDAFIxefhiDG9WWqTlZKOdc8CCwzYbFMgy1SR4uibJPviFhIQaiYU13V4q1XOL0MnB0jZnYaXhLmnRPqVJOiUoqY4nsbUOAgJnJSGZJn24oXXN/vAoYJYXCgdlejzraQHTv6pn0WBtszbew7x+adCBjfMu3lLW8i3A/cirt/7wU8cqaRVPzq3HTJN0gT4crBPU+v/cPY6ZfGF7+YdInFD1BAtGqteAB3KBqpK6eXPuVlJKsPckSMGMDBWu/6iJp+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujPntV1tKQbQ8UoeOD1vNGiJ5DHWU151ZD0/bwwDtnc=;
 b=alI1c7ZRAu5d5i5hxrOT5QFMQYh3E/IAuAL4qmVOjLlm3r0aSFAF/1ihC6KDYXJIyOmZnMnabU9PEDp9vUDosaDJTRDn6q3l8VXjCQtVouUaqiLKHja7TsPTdWK2ub0s0q4FoHt97n1DEYelgEg5iWqWAcBBH2dwNl9lFo56r7CNPjSG0kCBKhfyPVTGlfJTjAbsbZ/xEcB/f7NxV+DPar9TtwJ/z1jx1Ldph6Y1rXBYCY8tM3bR8hUBWG5c3emDqgpVMRwk6oHKz8I9sfIrbmB8Mu+4lgZIrmPE3AO/iS1RgrfRUDiCjIKE9QjT9aBhj0yYwiv1XK7x9mU0QjD9vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.36; Thu, 11 May
 2023 13:27:44 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 13:27:44 +0000
Message-ID: <526d1327-b108-fe81-faab-b248d3a003b7@nvidia.com>
Date: Thu, 11 May 2023 16:27:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/3] nvme-fabrics: check hostid using uuid_equal
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kbusch@kernel.org, linux-nvme@lists.infradead.org,
 hare@suse.de, axboe@kernel.dk, oren@nvidia.com, ngottlieb@nvidia.com,
 israelr@nvidia.com
References: <20230510180231.18865-1-mgurtovoy@nvidia.com>
 <20230510180231.18865-3-mgurtovoy@nvidia.com> <20230511131335.GB29790@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230511131335.GB29790@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::20) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 7735b115-768e-4960-8988-08db522380c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	la7vjW8xEJ6liJnDRN7U0DJBJ7Mo0umqaAPoWW0AQ/7JS0A90a1UAMq1Z4wnJSB2NVHSA4sggA45pb754mTl5v6PKcmMiwHwpnZCu6G3jlZpx78QgRTomXuPSZDnqk9uho2Vih43PoIODEpB89Oh8fShaf2kup+bHrEvKC48Oy0B3wUUAFwIyCrNnAGhQjOQabLdFwcJ9We5SJ+A5+I/SM7bhCh96luacmvJ9Z4mKi+HODztTJ8HXNcd2K5U9CMi51Hk1j+imIKdioG1L8T3Z2i+rfg2pybZ4mTuG2J4DjReCBU9UiA46ovgr5VaoLf5Npb0WA/DOTN4BnnkB50A94m6VR7PEcbgdy2R3K3HCV3dUKIYxdvRdLu6kygcLStzXymobrf/Ai3xEmp+zZmn2uNzavpYpu9mvb+b7owd+JsrudnVfYEKBYH9FbguYmYhLaZLjOg0Ixg9rcJJzy2aOshsq8aVCn/aVHwmijTAmLEQUm5h32qZiDlt0bAvqEUYyclH4FdvPPbPVW0r/KoqcOa0O+CAGQy68wHxw/cIGa8KI0pkUG9fj0V4Il30g+4lmSRXz/mSeXZ3pILpJWLiXueVF49L/u1jtwiiDmkZU8vnnIW581U4DNhSrNZYSr4GgdEf7x/hE0rOYwaZNi/6dw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(31696002)(86362001)(36756003)(316002)(66556008)(66476007)(6916009)(4326008)(66946007)(478600001)(6486002)(41300700001)(8936002)(8676002)(5660300002)(6666004)(2906002)(4744005)(38100700002)(2616005)(186003)(26005)(107886003)(53546011)(6506007)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?NnpzakVqbXFoVUFJa1JNTDhaK1U2QXhzTXhnOUxxd01YV1lobjc5bUdLSWlK?=
 =?utf-8?B?YTFMaVRNV0c5VHByUVhYSVozK0xOS2NRa05Oc0VoeE9Rbm9YQXJ4Q0krblp0?=
 =?utf-8?B?ajdkdlNFS1MxVTU0ZnYxZkk2UFRpcXB4SGtVR0hUM3RudElSM2JYT0dyTXNH?=
 =?utf-8?B?N1R5QTA0ZHMwVzhDbjZtUGo1cjRKOTVQYjNqZjBFM0M1NU1XUTNQWVdVSXFa?=
 =?utf-8?B?b05yWjZvYUhhUDhvOVVCWkgraVNiOUJZcW9Ma2NxVFBUSXpPNFZkQ09nRndW?=
 =?utf-8?B?N3I2emhpSnBHNFdIekN2eUpiWFNqTmJ4cGgzZEZuQUxYU29McXhqSUg3MDZp?=
 =?utf-8?B?dVo2SFdUUUtBeFFaY2s5RUhoS0k1Um5ocXJDQzFodkdJYWc2NDd1TXFKcytt?=
 =?utf-8?B?aWFndFcvenVtTW92dHFUUzFyaWFVUHdHS2h4YVBWaFpDUG04YThseXdXQi9C?=
 =?utf-8?B?Z2tpRmo4cmVwN0FHQnE5YU1YTFRGcFJ1Ukt6S2xRd25YeFppN3hMa0tPY3Jj?=
 =?utf-8?B?RWUwbHZEdlpmejhDQ3ZVQ0IvSzRCNFZWL1Ryd0s5aWx2YUdvaE45OFRtamQv?=
 =?utf-8?B?RTNvVTU0OWI4YVFqd2NnMEpTYUdRakZqM1lNNDhsVlZsTEkwMFozcmY2NDl3?=
 =?utf-8?B?QmpZMXo4NWtNOWtwL2VhZlBSUnorTlQweHAvc0JkdkwyYTVLSUhRRUpSNUZh?=
 =?utf-8?B?eHFSdlZPL3dSaVFyZTZwNE5Fd1E1MFUyMEZjaE5heTh2aTZMUExoOHJOY1ZY?=
 =?utf-8?B?ZjdyMkZQamJoQ05selFGdE82Y3VJc3VkV0ZZcjFBd0dYUUxkblhDNzhMMDZE?=
 =?utf-8?B?a2FCb29BaXhweFhKTnFJL1BPK1FxUFR2RjYrTzZZVHY3MEhOT1ZXdlBEN2tX?=
 =?utf-8?B?ZmNwY0xWV3l1MUo4a3FvMDkwNkJRd2dhdW4vM3ZjQ3R2Y3ZSMVY5VW4xOFly?=
 =?utf-8?B?clVXd2R1R3RPb1ovMHlmVWdhUDZ5cFVzTE5pUjExTUZ1NmFYbG5NbmtZcTdG?=
 =?utf-8?B?eVM4MTdZaFcxclRZcm1XRXBQaXpZR0I4MXMzaXdrTG9tdlR3UlEvQWh0MGVP?=
 =?utf-8?B?WVhzZzF1R0ZjZUFnQWJqNnRVVDNkUzVMd1dkMzVwQWNabksremxBSnRRYnNN?=
 =?utf-8?B?bUp5M3p3Ylh2OTk0K2w4clpmTE83MmQ0Q3crTnc2WFlzT0YzTU1HNGZHeWtk?=
 =?utf-8?B?VjVMUG4zZ0phU0dDa1p5S1NOL1VvbWJHNUdQdnM5VWdXTEpYV3VPbzFzOHl1?=
 =?utf-8?B?bXNlODNPT1FmMzh6OG1vQUZmd0lCWFpnQ21JL1hDcURUS21HRHFJNjcwRGNS?=
 =?utf-8?B?ak5ZbW1zSjFsTEhhbW93Y2xyNkI4SXpkMWtzdGdwTVRoV1ZQeGFUM0U5TWQ4?=
 =?utf-8?B?YmQ0eUx1UWQ5MGRZdGROSjZleE9oOGpsWVhHK2JlQmtodC9BTkMxcXViMitW?=
 =?utf-8?B?RjJjbEx1dWovQzdnSmZ0eFl1NGJtMHRKRm5FbWNzcWRDdy9BK1lZcFFIOWVN?=
 =?utf-8?B?VThUWmxDT3FudzRXcUxVWXRPMDNlWTRCa3pwL2dLU3NueFE3OFY1ekZPWXRh?=
 =?utf-8?B?YTZ5WGkzVXc0VDRpbWpGcnM2WFhpMFZFaXdPTmZ0ajZNUVEvczlQZ3FsYStE?=
 =?utf-8?B?c3FFbmh3emxVNGZsSmNjcWdLWEFmWTBvc0N6ZjJqM1o5cWJsZEgrMHNlQ3M2?=
 =?utf-8?B?emhrOGF5ZTluNnV5N0lHTC9XNndEazN3amM1Y0VncmlWOGFuVGxKbDEwbU9E?=
 =?utf-8?B?WWhvM3FSK2hqcjFSNm5pUTR5bFpnVmQrckszYTlWVk1XY1dZWWN1MHBGUVU4?=
 =?utf-8?B?NVV6SDNNVy9CZ2FrMWtDbjU4RENiVGZwQVJkYytuajE3S1pIR0hPWXRRNTlW?=
 =?utf-8?B?ZWdoTEFJVU1pMkFyR0VJdEdka1ErQUVFc3lGL2s3S0NZb2VKdVBNcCt5Q2pq?=
 =?utf-8?B?SlJZVXozSCs1dG1nYmNJS2k2RjlIRGF4ZjJmZ0VsdWJjU2NBQWY5Zjk3SEhs?=
 =?utf-8?B?M2MrdEt5RWU5YWZ5MWI1anBTVkhQY2VPQ3hrNHUvN2o4Z1dHdEVGaDRscSt5?=
 =?utf-8?B?YktYT0M4MEtyMkg3OWQ2L0ZmUExieXM0VFZpYkdwZUR0WXlFZDIrc1B3OUdL?=
 =?utf-8?Q?Qw1G4KN8ATUx2c8LsFHORcGyo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7735b115-768e-4960-8988-08db522380c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 13:27:44.3265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rGXgUYwIDUnzLhM1mw2WfIHS07x1E7c+x7i3xgGV38R5NimJyaP53JkDeHlnLVhLlEgaqTAkqhP8KtMM1Ym5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_062747_368504_F5E2A481 
X-CRM114-Status: UNSURE (   9.46  )
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



On 11/05/2023 16:13, Christoph Hellwig wrote:
> On Wed, May 10, 2023 at 09:02:30PM +0300, Max Gurtovoy wrote:
>> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>> index dcac3df8a5f7..0f3763283222 100644
>> --- a/drivers/nvme/host/fabrics.h
>> +++ b/drivers/nvme/host/fabrics.h
>> @@ -181,8 +181,9 @@ nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
>>   	    ctrl->state == NVME_CTRL_DEAD ||
>>   	    strcmp(opts->subsysnqn, ctrl->opts->subsysnqn) ||
>>   	    strcmp(opts->host->nqn, ctrl->opts->host->nqn) ||
>> -	    memcmp(&opts->host->id, &ctrl->opts->host->id, sizeof(uuid_t)))
>> +	    !uuid_equal(&opts->host->id, &ctrl->opts->host->id)) {
>>   		return false;
>> +	}
> 
> Please don't add the pointless braces.  The actual change looks fine to
> me, though.

sorry. probably I forgot to remove after finished debugging..

