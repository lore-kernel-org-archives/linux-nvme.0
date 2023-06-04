Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94066C77B7A
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Jun 2023 00:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Aa2Esj6wi45ietmO348miznP/577bebhwY+dCYMYvoM=; b=NGibkBSbH3d4Kqst1V9hlCgkrs
	45ETZ8VjYZIw1XmFF3gCXIfKlHw4AbfMECWo4iA2XZQIyjM3sjsKqgrxllxVhZwo2fpLkdGc4uXC5
	D94hBTyinJQ4pgkd5Kk931etqnfD5jn2/slhCnSvUsDeynSEVGKmA/xXR4CLtKTr9iGXEcfk+PDn0
	iu0Gke9mw1Z4JLEC1G/h4d1GY4eZJpAVO5ZfzMFRqd2UjFrhFOEIU4rjCSkglNa5S4RlYKVjV+w+P
	dqcVYlGjHuKhL5rNExBDbji3khc1p6GpR9XbPsADfa82355C8/F2O8KRj4xXDaQupvoIxX/126Qqv
	1H2LNKoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q5ble-00AvXu-07;
	Sun, 04 Jun 2023 00:38:46 +0000
Received: from mail-dm6nam10on20613.outbound.protection.outlook.com ([2a01:111:f400:7e88::613] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q5blb-00AvXL-1o
	for linux-nvme@lists.infradead.org;
	Sun, 04 Jun 2023 00:38:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+6QpYan/oc/w8JgejI+2UhvBlc9hHa2fti5g4lwh7RLX2XKh5sYcSUQSgdc3w39EbzRvQY9rn7qx6KwpB7Wla3Iw8CUVuEqsLZrwvt1XqegXe9/e5tWFqAO9PK482ovXOz2FlEwbELLFQwcAJf8Z/pRTN2zFmAKGppAZZBYiBgz2gQv8rEXFakg7xzgW2bb2Q1SWHr4GSDsHDVY6VEdcSXmiCI0GDjg6aGCIbdefs7JF5wMNCPyP4t0JflSgAG6y9boMn5dekf9S61wyApRedg3VYPyKd+l3MF5evSirnlBuQ5layCkQitJ6bBYXCrfNEJ7F9ZdXb8jx87HkdnT/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aa2Esj6wi45ietmO348miznP/577bebhwY+dCYMYvoM=;
 b=lDhTEUJSrIXWPueJEQWoi2Ttd4T/J3gebFUZPD33gBwbcJ82SUAG7fpaav1BEYYwBY2XiDuJflAk8yXZ41rWpo4/ElGN83SxaAN1sZzNzOGJHynNcAdJJJthYZXcg6buUMW79RQpqKnMS3zELsXF9nx74E5AhWzkdkxQ667qY1puyjbaN69gu31PeMtdiVDSoQ4JRzPBZeZqhx5gyNKqibHDNqe6smUYQCsIvFS6Lk23rKBzFTKWhPJbmcKplNLnnXtXDiJrGrEwWV665k4lgGWdMIATlghmhTp5fF9jusqB3YO1rogs1q0Qn2jd6F+o3cKS70gbLnpIGVmYBM48SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aa2Esj6wi45ietmO348miznP/577bebhwY+dCYMYvoM=;
 b=bWmlCoI0+2GI43BqDwWiJaQRwrYXtzUsAQhOt1CJ55AMKLF6cOGzfI4vzI2eHkLHIpw4y20wXpZmgZADPozHmg6mwI1njtvR7JyWMm7K8paP/f3uErY4sLEYtUmjCMJVdyk+xQADu27Ji863i8FXmocNfWZP6qIh0hTXmQzFOPPmMjoHNH4QvgK7fBaj29IlF3J9xrQK61fXWxi9fO/dMxqhl5hMIuT6gUrG8CEjV+LOOATLYZjk/dUwJYMV7AeR7zMtm7D8znw2hJbMma+D1rdLd4fhGj1jTPGkNCOXhXeVO/ur75C7uCP08GyV0mkezpY26dIWpUW+5NTXpHXEGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sun, 4 Jun
 2023 00:38:36 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::cb7e:86d1:886b:3d0c]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::cb7e:86d1:886b:3d0c%6]) with mapi id 15.20.6455.028; Sun, 4 Jun 2023
 00:38:36 +0000
Message-ID: <b20ba4f5-f4f7-2283-38f1-382ce2447290@nvidia.com>
Date: Sun, 4 Jun 2023 03:38:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] nvme-fabrics: error out to unlock the mutex
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kernel test robot <lkp@intel.com>, Julia Lawall <julia.lawall@inria.fr>
References: <20230602053713.43006-1-kch@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230602053713.43006-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0041.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::10) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6a486e-900c-4083-baa5-08db64940842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1xxH/9ik0pv/iXYc9HnzL5QX5g4yGSuf8X2PQgsr/PVba8nbTdKkiwwkZJxl3qgfeTiIgLZU9n7y/3ejbaqRKdp82bdA9y7MS7cTTmLKYAZes3W5+v7JOk7mZWHRm6MucMyqcXepnV2/R1IE96MLDsF/6LTCO6vvP3JhdTkPn8EbtTm+SM+f7kfL6LTjT5khLwjoSDWNeYkFtRrdvaLEBNn4z9z1HQFJc/J4czZxMScLxQeMv0fgvI5nS8J/lz03v9fijQWOYL8QF4xlIhmuNWdQeL4CKWgvgZRi8QppqLVwmhu0yUrPLKEVr1I/Pd/aq9m6pnXOwqBSayjB8zU1TV0Y1VVtvmIIC4tLUw91y92L3caFVqg39CsdE6lJd0q+ID4kFQ197OZjAMgJNorOQcBUcxw/PXlAgLvW7WULIuAfionjWoQVm2UpXTgO+gfZqtzNF3o2Hg1jH4+IGEWvumlNfMgBFbu3wVb4/F9PIkcg8wPvde2QDs3NPKFLkIEk0cJQ3kdruQmsIVUgfE8rLwuI9jS5maWQKytZbi7VXnZvCToI+4UYPS85giEzatRzxM8STiX2t1CVBJ/USCv/DWN0Ch0vgeqsdFZ7FMB3xExsnqoGJczq8YcokHdjZ428tHGX9Qi96lWzYXX7XYPA+Z7N81uM1Fg0dCgq5YtLvSM9paZRiZlhaZPGSVA6JvQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(8936002)(5660300002)(8676002)(316002)(41300700001)(2906002)(4326008)(66476007)(66946007)(66556008)(966005)(6486002)(54906003)(6506007)(53546011)(31686004)(26005)(186003)(36756003)(6512007)(2616005)(83380400001)(6666004)(478600001)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVB1WkF6Q09RbkRRNGtvdnR3azIvclNWYWFnNEYyUThBNFFpRitkN2NUbUZM?=
 =?utf-8?B?NXN3M3gvVmRMblFNaUoyQTQybng4Y1NiRzNwbDZvNVFQVE9GSmhtUXNpYlFI?=
 =?utf-8?B?VWg4aWZoZWY0TU5ydmN3YTdIRXJNcy9XVS8vcEZSaUZCYXMxSXZ0QzlPY3lE?=
 =?utf-8?B?ejFUdFlKWDdhQVREQ1VyY1E4clNObkVUdTQ1TlVGQ3VJcXNHeEdOeGN6VnV6?=
 =?utf-8?B?QzRhY1QvY00xZ3R3NWJWTi9Ga2dKL2tib3NDTFFPVUU2UTNBNUR2T1JiZ0xD?=
 =?utf-8?B?d3RTV2pkbDAydUNCN0NCMzV4MUp2YUxJU200Z3Z0L2gyZVRVNTZhLzRya0NU?=
 =?utf-8?B?ZlZhc3lTSWUvQkdiQzdEbzlFK0N5eE5GOUYxc2tjdklOcklZbm0wajBDRldt?=
 =?utf-8?B?NThMWGNKa3g2WXhxdU1hYUxtWEI1Y0xtaUdyNlYxRFIzMVpOTjJGOFBPdTFU?=
 =?utf-8?B?eDFnclNpSlpQaC94cnZ3QjVveWl0d1pYZ2MvME15L1pMNExOSG1neHZpRkJo?=
 =?utf-8?B?czdxb3p3eFZuNGFRSHZtWkhMeGNYeVJLRWxVQ3lMTEFxMmdjUzdsZE8xbnRk?=
 =?utf-8?B?V2xhVEZrekVFMTc5VWRqWlNBUERXNTFXdTcyL3FLbXRMSk1qcHAwYkxoYVBM?=
 =?utf-8?B?ZHNLUTdMMG1BdFhsRzJHQnFYTjVXdWZZeWtSamg0cU9ncnlBU1B6c3NQZG82?=
 =?utf-8?B?UmJ1OVU3Z1pZbTFyTzZ5YjIzeXhoNnJrUzFuZ3lObGh0WEpweklXTHRVak05?=
 =?utf-8?B?VkdCZ2tveW9LSW9NWmw4Uk8rcEEyclhCWFFmSGM1TkRhdTlxQk9PYkxuc2xw?=
 =?utf-8?B?ektEYkdMWlYrQnIvYWNpa3V1SDVDYllYaGZzSTB1MStNdWZuK1p0eW1nUFYr?=
 =?utf-8?B?enVKK2V4OXk1S0dIZ2FSa3p2K2xldi9Da05iTGVhY215QzVFSytXOXJwWDNq?=
 =?utf-8?B?Yk9lSGhEZnZjWGszcVhabXo3dysyVVRaL29Ja2JPcTJyQzRMYVZmY0ZWWll3?=
 =?utf-8?B?dmhYUWg4MUp4ZlJtNW5PaGQxQXROMkJZbXdyM2FMS0RYaGFRUjZUU3RXQk05?=
 =?utf-8?B?OHJFS2hiMnM4VUpld09rZ3BlMndsQ2Q5djRQemd3aE9ZZkRxdlUzUkFhaWEz?=
 =?utf-8?B?WkZlcElEMFJXSWlpbzllNlc5cVhQbG1FUjNyVFdjUnpISHpIYUxXdTh4eHA1?=
 =?utf-8?B?WEcvSUtSOGhMWjJLdHFNL2tUUFM3MUlncjJqNDZOcG5LQ3doSHkvQ0F4OExz?=
 =?utf-8?B?d2ZJK09wVm4zam9KMGhUb1hDTkNoOWpwTlVSMjY0MWNxRFZOQi8rU1ZkcTVD?=
 =?utf-8?B?MURkTXdwdEY4bldzdlZzK0l3eUsyY1lPcnhCc0k5WHN5dWdIbTJwSlluaFM0?=
 =?utf-8?B?VCtuMlRtY09wemYxU240QmlPNVdNKzFOcWRtV0M4azAzUVNuelorQjV5d2pV?=
 =?utf-8?B?djFWRSsvRlRBTHdtS1VXQmZVc3VZeFlTcXduTkNEb0FLaWtsQ01wWTF0cURs?=
 =?utf-8?B?N0NxcXIrNi9XcXlIYyttYjkxL2R3T3I3RW4zejFGTjUvRDkrSkFRT3RTbHVI?=
 =?utf-8?B?ZUFIQUR0bDJ3QnJCTTJrU2Z0T1M4cUxrcTIvUmFYVWdRQWxrODE1bHdJRnB6?=
 =?utf-8?B?bDJvMHVaOVgzTVFxMWVSRHZOYVlEQ01CNUM3L2x6RSt5SHpnVFhmYmFJK0Iw?=
 =?utf-8?B?RFU1ME1DcU9wa0NpK1B6R0JPNHlqUTVTVis1cnBPb29qdVlwZHp3c1Y4TWFr?=
 =?utf-8?B?TVAvSGRWMXgvOFJDKzF2bm9TQnhkaEdrYkkxUFhPZGJMUXdOYWhkL1F2RVRH?=
 =?utf-8?B?OEh4ZWRMUGRaMjAvQUk5eWcvdnVLVUhTYngzdVdOWGhYOTg2REp4cmNyVWxx?=
 =?utf-8?B?SG1ZSEpjTGZ0RmxNVXVtT1U1YjAvL2cxSWw4aUZodExmQVQyS2FFd0pXVE42?=
 =?utf-8?B?Q2tkYk1vYjBXeFFJK1VQWEhEQXdJakZKWm9tVmx3SFc5TU42ZHkxMytTYUFJ?=
 =?utf-8?B?eWYzRzJaVHM1ZlFQaVo2UWRXNXJ0cldTZm5mZlBpVnNCL2xxaHozVGxqSStE?=
 =?utf-8?B?c2dGSkpHTnd1aCtVZlJ1K1BwNURQRHBhTU83N09lMkc5WjV4dHBEZUs5UU5p?=
 =?utf-8?Q?Pz4jBRiztMwiywj2Fu9eRROYO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6a486e-900c-4083-baa5-08db64940842
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 00:38:36.2359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1KbmehQ/tz0xv+x5rW1M/ZzCFHfN7ZKRwCF7m15bhJiU5mAL5EfZZ6q9/2rGuCyDNICxI3qNO7FCk/RPugpiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230603_173843_600336_9EC3A3A4 
X-CRM114-Status: GOOD (  16.53  )
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



On 02/06/2023 8:37, Chaitanya Kulkarni wrote:
> Currently, in the nvmf_host_add() function, if the nvmf_host_alloc()
> call failed to allocate memory for the host, the code would directly
> return -ENOMEM without unlocking the nvmf_hosts_mutex. This could
> lead to potential issues with mutex synchronization.
> 
> Fix that error handling mechanism by jumping to the out_unlock label
> when nvmf_host_alloc() fails. This ensures that the mutex is unlocked
> before returning the error code. The updated code enhances avoids
> possible deadlocks.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Closes: https://lore.kernel.org/r/202306020909.MTUEBeIa-lkp@intel.com/
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index b1fa27b60917..c4345d1d98aa 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -92,8 +92,10 @@ static struct nvmf_host *nvmf_host_add(const char *hostnqn, uuid_t *id)
>   	}
>   
>   	host = nvmf_host_alloc(hostnqn, id);
> -	if (!host)
> -		return ERR_PTR(-ENOMEM);
> +	if (!host) {
> +		host = ERR_PTR(-ENOMEM);
> +		goto out_unlock;
> +	}
>   
>   	list_add_tail(&host->list, &nvmf_hosts);
>   out_unlock:

Looks good,
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

