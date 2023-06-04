Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9853EC77B7A
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Jun 2023 00:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6pirHfdKoI1c6x49pVARGCLEi86P5q9muZdbhbXqpns=; b=f+kJyXwv8al60JGHrON5ASxlvf
	OjjNcFPjufurKDmENOATuhUvULukNXNxwYadobOBOnGc3mPK2Nr8DpoafaASc8zom7bnriP1fbJkC
	ssFV4/FcEBhmsSc3o3ZrpOGUFCRQnlx52kXEGuVYS1ekXV3i+a0IJYfMIK2WWuFvwYMpCx7rzJSjA
	AVQk4X2pvJyERlz/0shOXQOwHEqDftpeXsht9oNoU2WZ5pm12TRn5/dyIfd5sZ1gc1cEjZ/JKPL8W
	2h4x4X4f4STD9c171l0NjqbnRVFgI1/YmXoiq137tvahSkrN0QCQ1dcHIojOMi5rUh3Ees+LXKb4F
	DFOZpffA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q5bis-00AvHT-2l;
	Sun, 04 Jun 2023 00:35:54 +0000
Received: from mail-dm6nam04on2060f.outbound.protection.outlook.com ([2a01:111:f400:7e8b::60f] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q5bim-00AvG4-0L
	for linux-nvme@lists.infradead.org;
	Sun, 04 Jun 2023 00:35:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8vBRDQAOYyBiFmTvtmPAfqdQdFbRO4YoEYuJegxux6yqJHIbrDFVFxuGa2QLe/GwjZ6BkOSbxL3vovk5+GB8nYzq0q2xi/Hhqh+hgWtdx/MIV1ff2yDBDkpYv1s6O6vTsLi2oysYigeQKvV2IQjtGu+YsT+A73Iz25GTl926MCzeaz1LL2xQQCRWEKWPJFu5MTifwEtpJ2B1AlpmIZTwoW2yWcE6/Vj3T9nmozm6h/A5p8W/C5dI9FbOaEEHpI0+cCOxo6bHVNMXDpDCHvRAg07Rei9egKn08Wlku7Ldwir8+M58TvZawxbfdvjVtbsTpoNOXNAJr6SjTSwWjgWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pirHfdKoI1c6x49pVARGCLEi86P5q9muZdbhbXqpns=;
 b=clTs/RZpmmGDDCVEymadGkJA2+qAztzmMuJ9teefjm2AAXe2uT7Wt+8fL8B6apMJMTHyX43YDsMunOhy9qcllq2N3O98q2cKYO8txE9LAtTBWRAKooNUBEBkC/o7ze2UuWy5JxqmqQ4WJM9uLsVQu8CV1Q4HEeAGWYMB31T80+dVa7c6aM7i4RMzYXumOWSgORhwUBFFBzPU5/mCL3CIuY729o4x0pj4TY5E8f7CwXpivgGdYvaftLe0eHkWdHdV1derDzwpvw/W2XiBhSAO6VQD2ASvdto3eyQnivYFQ1iATPtYxjqW+X6lhPtHaEf3Ufky0ENggTJLpBbHGnGgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pirHfdKoI1c6x49pVARGCLEi86P5q9muZdbhbXqpns=;
 b=eQ4FhXqfbnH2NUfWbotHbs5TarbpzuyH3qZSPtmGQO2MSmg4SqLgAmvfh9sDgjbrSHtVJvJz9jbxuB3Ji5WbXUF9CuEOVOhUk3RFB/ueR1DTenXhMhCt4HJdPnWSTXLtpBuusZnYPSEckGm3bOm/9tGP1gCRaUeXvXBegJdq4ygV908ok9G8gsnORpyZ3SLSa6W6dDlqYeVaQjnlJNEir45JYRN4/NHO3Yofl7YvAqdiFgaW7jxs3KIrMTKmBv/tAyONr74630UKHuteucSnHaB9anaafkQbqK8QmYSJlJWXJK41XHgMeAxPFz9fe/ZOJbGbgc1cBkyxvz0sB4+FPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Sun, 4 Jun
 2023 00:35:30 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::cb7e:86d1:886b:3d0c]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::cb7e:86d1:886b:3d0c%6]) with mapi id 15.20.6455.028; Sun, 4 Jun 2023
 00:35:30 +0000
Message-ID: <f03639ad-18b7-a051-c83c-7bca5ef1ec0b@nvidia.com>
Date: Sun, 4 Jun 2023 03:35:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] nvme-fabrics: open code __nvmf_host_find()
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
References: <20230602064742.56298-1-kch@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230602064742.56298-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: d808c82b-564c-412c-fbe7-08db64939916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAOyUfjysCCttPih3KnMU6dx2D63+FfmiYsZgOHtbkktfBbkdwfnRl6ZbVGHxOH9MLT2REPG6+SWP8vUjtn5pRDNxKgyt7Qak96NNHSUZsPG3Dz/JbLXLU744N8dz+IathBGYfT6EXk9UzI2lZfqsuqdadkel24wFP8BtYvRWcmJaswxvDaLOnQRSOmbCQ0IIuJN3HD45QWGa+QLEG6QfXP3GIljphvYaaQn8MYqq7hhO44GXJ/0IoA4Uqgt+LTQWnWYhJm0N6vP/8aV5bYxeE6YwKW96bE3zKl1xEXeg/qZ0JvQNTa5Ub5y+mZ3yMOAhJ84kwkmenihOWZ1atTOMJyXEg8BOKNd7C8HpTb617/oguIAO69E2QCjZCiqeff0hfgHwdOyqSkP0KQdZThJ+6HaHFIDktuFs7AwPq+znPFCvoov2jdrmdQimxj5LD2U1pt/n00i5n9rYX6YjtZa0mWxUswcKqVaOqAk3JvPNrmrMY07YSXGInsrehSjuiidFuxTjRt4R0fZc7IlVKwXD12eqL2Lk0q1eZYCOSS7y1ia9l1ZBGGaukMKCVELRKDT8gnuQBbS2J9XdF7/wt1Bhw/0BPOktL900aaUTapZ7XLUaCuvBNdElx1TsveidB8bC01epovT0mtTeHKST2UBnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(41300700001)(36756003)(478600001)(31696002)(6666004)(2616005)(2906002)(86362001)(6486002)(83380400001)(5660300002)(53546011)(8676002)(38100700002)(186003)(8936002)(6506007)(6512007)(316002)(26005)(4326008)(66946007)(66556008)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHE1TDI3U29BWUl3R2VBK3gwa3NJMmNOM0lidzlMNzNaaGNJSXFwZzJhS045?=
 =?utf-8?B?L2VsbDRYRmw2TXFGcTJxUmgyK1lONWVqUldEcTZWcXpTNEZTdXFvYit2WEts?=
 =?utf-8?B?aTJjMUhXZURabkR0VExrbXVGU21Ld1RzYlEwb0t2RkRkVTg5L3U1RmhhSkdG?=
 =?utf-8?B?R29pblBMRXhxcnFrNzU3Z0J3ZDlqWGo2d0ZmQ0MrWHJralpQVVUyYlJ6b3hT?=
 =?utf-8?B?MitPUm9KZXdYSDc2SlRZQWQraDVEM0ZRS3BjUkZPRzNubGUzWlF5Z1l3dUw3?=
 =?utf-8?B?cHhPb2NVUFBGVHlOaFBZZ0ZxTy9YTXFmMWNzT0k1ajRsZUt6d0orUkRudG5t?=
 =?utf-8?B?WEswTndRUTdBUGZVbVl0cGxreXRCbmo5WkQzRFJWWVJwWGQrZG00S1dTUzVW?=
 =?utf-8?B?V2dUN1BtNFRWa0h4K0xNV25qR3pXZisrZjVVNG5vL3ZQNE5Qd0Y2czBkdWN1?=
 =?utf-8?B?QzVmUHRkMWJRWDk4R1F0YzNrUGw5OUhSdWg4R1dSVS9uaVd1Qms2b2ovRzJs?=
 =?utf-8?B?UHdCOE5wYnRyY0tEN3c3V2l6VGRMOVNxMmRha2dVVXhrSkhwTS9YU2xNOW1Y?=
 =?utf-8?B?Q1ZWWldUajV2bjkzbEI4cm1laTZmNlA1WXFET1FZbmdJV3JONXltdEt3STU2?=
 =?utf-8?B?QWdoK0tXYkZDR3RhRElnZ0xUS0VuNFR2ZkR5SWYyZmVZeC9CT3pocUtlYnA5?=
 =?utf-8?B?b1JVS01FYWdySlArSU55aytWd3FZZkdHR0N0RW15RE82Nk85ZW5HYnB3dTd0?=
 =?utf-8?B?VGhXaU1nSTlxZEpyUzltbm1EWEFJbndyQytjU2NIMXdveFJNRS9FODVhbzEy?=
 =?utf-8?B?cFl1c09qZ0E4QVRFSlltU1Z2NXcvUDdGdmI1cE9oVTNQOEQ5YTUrT2VKcERX?=
 =?utf-8?B?UG1LMEJhYUVqRTFydjVSM0hwc2ZmZWVzQlhTd0wrT1NMb2ZpN2R6L2lJU0tr?=
 =?utf-8?B?RVJIaFhRaE00akFNQTJHMnEvcURHcmFFdjllKzVHOUNLSnRUa3d5bVpld0t5?=
 =?utf-8?B?a0FZVDFhWjZiMjBxWVluMW5GellGMHJXUEJlNmo0Nm5mUjJ6UmFMU0N2ckhS?=
 =?utf-8?B?ZUtnMktuMHhlU1JsWjJaQjZMODRWeUxKQXNtcTM3MDZXRHl5UXlTc0YwTEVU?=
 =?utf-8?B?RzI0RkNYcnhlekVmYzBDdnF1bTByWjgwUTRTbnRpczBOTFdoMjhxVU9VQVZ6?=
 =?utf-8?B?QzNKZmsxeklERE5RQ2tHOTdWU1lRdDdXcEN6QWVSa3pqUnlxc0I4MmNSaXE2?=
 =?utf-8?B?T3FwN282ZFJVYzArcm5xNVZWRm1MallOeXlOR2xZYzNBellSWmJZZzhLLytv?=
 =?utf-8?B?VFA4b09WeDRtdUYza3hUZlR4dzJtQzd0UVNTaWtKV3JxdldweHhkRExWSkV4?=
 =?utf-8?B?ai9ySFdMU2xUN041SE5SNlVpQVBVSmJLZzJTck8zOEt2dnVSejlFeDhkeld5?=
 =?utf-8?B?L2lKMjN5a21mMmEzTnJLVkZyN0RUV3NYcnBseldNM3dCWkpQUmlyQmNXTFVU?=
 =?utf-8?B?SXE3WFZ5M2xnRXJiOWtkUnkwK3JoNHlsRFdCV0llSjk0WVE5ZER3aU1FU0d4?=
 =?utf-8?B?dmNVd0xlTEhIYjMrYjFuTms4SjlKNEdxNVRIU0JTMERiTllERjJLZWFPZEsx?=
 =?utf-8?B?M3JoQ0duOGZHVHpIMDYzRGQwOWxkNE9EbGNXVEU1eXEwOWJqcmpad1pWbFN2?=
 =?utf-8?B?ZTdkNUNJSE11Yk45ek9DdlorU1dOUTdYVTd0VXZldm5UbGdJUnNLNk83RVFG?=
 =?utf-8?B?TzM5UG1QY0tncUdNQkF3WTVLS2tKb3R1Z2ZDaUVvZDA4UDU1MFBhK2d3YitQ?=
 =?utf-8?B?RG1xL1g4KytSNVlPRnh6K252MmpyeFFLSkU2RnZNaXBwQnc5UFhJeHNFNGZ3?=
 =?utf-8?B?S3c4Sk5CY2NKUDQxaU5ScU53ZUIyc0NFM2lhNlpmY3NYZFkxUWYremFNZi9n?=
 =?utf-8?B?Y1E2dlhDL24wd0JUbE92enlVbVY0UWY1R0szTVl3cU5ZbWNVNEVCWlR6TGwv?=
 =?utf-8?B?M0pKcG16cVVHajlSb2JiT2x2aGF5NWRFUnhncTc0SWNiN2F2ZGluRWQ2S21C?=
 =?utf-8?B?ZGllbVZyQzJHUFRXR1ViWDlkbUpMeGNsYlY3Y2RhTkJERFM4UWk4cnJBaW43?=
 =?utf-8?Q?BGvPqj4HZnzM8A/8zVmzm16aF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d808c82b-564c-412c-fbe7-08db64939916
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 00:35:29.8294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hZ5eEtRK84dXODGylF2S2PS1/bn8CVRY6nsUdRZLqGxkNcpKwlwe/bmaBpcs34/d54fYYhsklYZp+VRWP03zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230603_173548_172448_BCDE5199 
X-CRM114-Status: GOOD (  27.71  )
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

Hi,

On 02/06/2023 9:47, Chaitanya Kulkarni wrote:
> There is no point in maintaining a separate funciton __nvmf_host_find()

typo *function

> that has only one caller nvmf_host_add() especially when caller and
> callee both are small enough to merge.
> 
> Due to this we are actually repeating the error handling code in both
> callee and caller for no reason that can be avoided, but instead we have
> to read both function to establish the correctness along with additional
> lockdep warning check due to involved locking.
> 
> Just open code __nvmf_host_find() in nvme_host_alloc() with appropriate
> comment that removes repeated error checks in the callee/caller and
> lockdep check that is needed for the nvmf_hosts_mutex involvement,
> diffstats :-

The above 2 sentences are redundant IMO.
There is no error handling in the callee so it can't be repeated. We 
just return error in the callee.
The first sentence is good enough to justify this patch.

Lets have instead:

"Merge its code with the only caller nvmf_host_add() since both are 
small enough.
The lockdep check in __nvmf_host_find() after the merge becomes 
redundant so we can remove it too."


> 
>   drivers/nvme/host/fabrics.c | 75 +++++++++++++------------------------
>   1 file changed, 27 insertions(+), 48 deletions(-)
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> Hi,
> 
> This is generated on the top of posted fix :
> [PATCH] nvme-fabrics: error out to unlock the mutex
> 
> -ck
> 
>   drivers/nvme/host/fabrics.c | 75 +++++++++++++------------------------
>   1 file changed, 27 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index c4345d1d98aa..8175d49f2909 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -21,48 +21,6 @@ static DEFINE_MUTEX(nvmf_hosts_mutex);
>   
>   static struct nvmf_host *nvmf_default_host;
>   
> -/**
> - * __nvmf_host_find() - Find a matching to a previously created host
> - * @hostnqn: Host NQN to match
> - * @id: Host ID to match
> - *
> - * We have defined a host as how it is perceived by the target.
> - * Therefore, we don't allow different Host NQNs with the same Host ID.
> - * Similarly, we do not allow the usage of the same Host NQN with different
> - * Host IDs. This will maintain unambiguous host identification.
> - *
> - * Return: Returns host pointer on success, NULL in case of no match or
> - *         ERR_PTR(-EINVAL) in case of error match.
> - */
> -static struct nvmf_host *__nvmf_host_find(const char *hostnqn, uuid_t *id)
> -{
> -	struct nvmf_host *host;
> -
> -	lockdep_assert_held(&nvmf_hosts_mutex);
> -
> -	list_for_each_entry(host, &nvmf_hosts, list) {
> -		bool same_hostnqn = !strcmp(host->nqn, hostnqn);
> -		bool same_hostid = uuid_equal(&host->id, id);
> -
> -		if (same_hostnqn && same_hostid)
> -			return host;
> -
> -		if (same_hostnqn) {
> -			pr_err("found same hostnqn %s but different hostid %pUb\n",
> -			       hostnqn, id);
> -			return ERR_PTR(-EINVAL);
> -		}
> -		if (same_hostid) {
> -			pr_err("found same hostid %pUb but different hostnqn %s\n",
> -			       id, hostnqn);
> -			return ERR_PTR(-EINVAL);
> -
> -		}
> -	}
> -
> -	return NULL;
> -}
> -
>   static struct nvmf_host *nvmf_host_alloc(const char *hostnqn, uuid_t *id)
>   {
>   	struct nvmf_host *host;
> @@ -83,12 +41,33 @@ static struct nvmf_host *nvmf_host_add(const char *hostnqn, uuid_t *id)
>   	struct nvmf_host *host;
>   
>   	mutex_lock(&nvmf_hosts_mutex);
> -	host = __nvmf_host_find(hostnqn, id);
> -	if (IS_ERR(host)) {
> -		goto out_unlock;
> -	} else if (host) {
> -		kref_get(&host->ref);
> -		goto out_unlock;
> +
> +	/*
> +	 * We have defined a host as how it is perceived by the target.
> +	 * Therefore, we don't allow different Host NQNs with the same Host ID.
> +	 * Similarly, we do not allow the usage of the same Host NQN with
> +	 * different Host IDs. This'll maintain unambiguous host identification.
> +	 */
> +	list_for_each_entry(host, &nvmf_hosts, list) {
> +		bool same_hostnqn = !strcmp(host->nqn, hostnqn);
> +		bool same_hostid = uuid_equal(&host->id, id);
> +
> +		if (same_hostnqn && same_hostid) {
> +			kref_get(&host->ref);
> +			goto out_unlock;
> +		}
> +		if (same_hostnqn) {
> +			pr_err("found same hostnqn %s but different hostid %pUb\n",
> +			       hostnqn, id);
> +			host = ERR_PTR(-EINVAL);
> +			goto out_unlock;
> +		}
> +		if (same_hostid) {
> +			pr_err("found same hostid %pUb but different hostnqn %s\n",
> +			       id, hostnqn);
> +			host = ERR_PTR(-EINVAL);
> +			goto out_unlock;
> +		}
>   	}
>   
>   	host = nvmf_host_alloc(hostnqn, id);

With the updated commit message,

The code looks good to me,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

