Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB517C77B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 19:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QgvL+i8a2CUsVerAu7vE9dy3JfAq3YDmvTKKn5oB7KI=; b=0JgiU98ixzZ6xK4xFr2vmdz6yJ
	G18E1LE2yoWg+KENiDhQT02i4f/yaaVObrReaQiwIX0RmDz/Qg6mxhC+sU74W10EBOX1dSp+Q0uaZ
	+xO73wN4w9wiVVklvnG+5QbwpglKOXahBf2ysKblmpLRvxgDZ4vzGM7iN7a0SDOQjRbDs2IJBqiUk
	AvoewfbjXzEYT/bJDjdYYJLd6KuT/oWk/C23fuJAPnabbT4SWSo2GnC271WL061zp+PDVv+6QbjTA
	lOun8TaNe0XNKLfpowMnNi8grr4NreADZLsRqBYzgTqMYpTqPMqENJovtmVbiS5fq7wHbwRmfPw+S
	9rkjj2Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxC4p-009pkQ-2Z;
	Thu, 11 May 2023 19:35:47 +0000
Received: from mail-co1nam11on2061b.outbound.protection.outlook.com ([2a01:111:f400:7eab::61b] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxC4m-009pjR-2b
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 19:35:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyJ/66wUkJhJkfFbf7CoOehFKMtZ1IC6Gr3VRIuXqL0GddyPsg4b7/AnTdoeVbuJnosLP5CAB7H68oaaRwiRCZO0/Fmq/QipRXUUk90E8ecaY3alhQOi2YUBUymdnc4cn/UQ33b0hliEN7C0DNt0XK220DTVxAUJN6hiKNPc60ox/cyBngtYcWAeSCn2i6iUaIU/7Df8SQXri/kqv+neN4SZgB43wbS4b/AwvNoi1obCkv1BdGgyHZVmCZpAItmOJWNi5exqRF5NWrhCOn8kyK7R3mp8F3VzbjvLpIX8lzX2mLLZqbp45pqPmH7Ohho9QtQn41ijf2VgVkP+MQQKcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgvL+i8a2CUsVerAu7vE9dy3JfAq3YDmvTKKn5oB7KI=;
 b=EpUpdXg3CVDGT+xtQ6/lZ66vgX3doMK/0Ja+NZgeFpmZHm9jBtFkP0Jkkp9u7F9S6UzRddLZSQYPNU3tNagMcZgsQvzMcKEJDqkK1eSA/ZnHyqW1Fpe+Xt68YeNIqmCtHMGCgUiHjQa2o/PLWTeDhCrGHG0Ga6R/vUhTN1TvEogj9xTDkfKWH4rq5zRP9FBWHw9e+tvChuWS0GexIOWE96GgfHtYDPwT0w0Xj/CinyD9noAOIIBbUvNjI4CpQZT5L0PQmqU3Lp4O0A0zXdeJk9FmZLd6Eal3gULrOPObm0RPTMduKGmpfFtEYG3aP69hEotpJvDEXuQiVSP9i8KVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgvL+i8a2CUsVerAu7vE9dy3JfAq3YDmvTKKn5oB7KI=;
 b=p4pAoxcPjWPVIopebyEx0xnvL8qI6YbKgvWOA7eSaqSf8tDUYPZ4DC2WXa9ie2nkhA0TnGoX2JIJ6MgFgSt4TLefGWTKBX2bPVHwzKk5hu1UmPl16uGYoITYhSsyxmpe9q5fhJnxhsrOPloxlRUmqr6b7z1x9UivgeRH+KHe6ogtkd17TYbTzE0rj5Rzqx5RhxLFioj5LF1Z312Qr1BtvSSG2xXUpbNEi5RB8vjll6igYor3RKSA3+vBRJH9pFyQk8zgoOcp0rIxFneg3S5VAQ566ohrOTaZgthao6fq+/YITt1EJQijBajceIThmya/BvldQqEP0rs/KJqGvb/gqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.36; Thu, 11 May
 2023 19:35:38 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 19:35:38 +0000
Message-ID: <025ae696-38cd-edc1-edf4-3cc05b4e9a9f@nvidia.com>
Date: Thu, 11 May 2023 22:35:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/3] nvme-fabrics: prevent overriding of existing host
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, hch@lst.de, sagi@grimberg.me,
 kbusch@kernel.org, linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, oren@nvidia.com, ngottlieb@nvidia.com, israelr@nvidia.com
References: <20230511165441.30005-1-mgurtovoy@nvidia.com>
 <20230511165441.30005-4-mgurtovoy@nvidia.com>
 <583bbc61-58d8-d950-a179-16c6807f38bd@suse.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <583bbc61-58d8-d950-a179-16c6807f38bd@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0538.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::8) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3e0bc3-4f2c-4a7d-4337-08db5256e5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	0psgE96+3983wNYw5CcxGauA0YfqjzCDpNzAp3nNdchHsmCfMl/MjIUUQfWnF9WYQfZhJAwitG12irhSfUJMJzoYWIgdGwaKFNg8qp/DzGuo1YNiJNThgrmajeLTKcIx3p6eRC9A696I55FgEwM+NGTTimEDk3/2GIPjHTTFTppUhKv3BQUKWnGLjRye6tOwWZO1Tqd4D28pqeZJMJy63ONDT89vX7PZWX7Ko+dvLxe9yWlVKQHFbq2zXlithqaOB4AaB7TsdKPr7A1piVb57ViBBlswS0F1wQx02M9IyC0Jzx+1aSJLySnMzmlzm345H2C745CALkAxROeu7l0F+71cHiQkTWbVnjWkEC3FOsyZ9dBHOAspYhKNiLmx/9uNbFqnf/ksdpn/DP78NK1dJvmIHjAqcd+3Zr2qL4djqYSBGP8pVXQ7uf2pONdtuMkyptnJhaNqnbRRV+MsNLiArVJ2DNUZ6krlb3mYETnvQkwLFd0yuf+n3Q4+oV/VBhIPPmhi9Q7m1SLX0PJj7M2vx/dhdoUMyBWcIBA2iE21Z2FmeUwtNVP2H0Zpacb8WomOrckViNJY9IIXwTNx7mc4crQe1HmZi220pKuyBs/iZOf9qFhc2E0cIMh/zxV3GNzvly79hSNu5aa+hz/35wKEFQ==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(31686004)(41300700001)(107886003)(38100700002)(2616005)(6486002)(53546011)(83380400001)(6506007)(26005)(6512007)(6666004)(186003)(478600001)(66556008)(66476007)(4326008)(66946007)(316002)(5660300002)(86362001)(2906002)(36756003)(31696002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?RUJKK2tWVUlIRjJQa3JpSWVrSnoyMy9yRlhBUmYxNTNpYkZRTWszc0JsZnVm?=
 =?utf-8?B?TXhsbExEUjUxRm5va2FpSmhoSzBFbkpFZHMvd1hhM21zNm1IUk9KNGFSeDFL?=
 =?utf-8?B?L2llQldYVlR4amFybFAvQ3FNMVgwOHgrVVlRbCtpU0NHNjlPb3ZlVStNaXF6?=
 =?utf-8?B?ZTVGajVRRi9ZTmJ3dEc0bmpSTzBMakF6L3Y3MitCaGdXM051ME5DWWpKSFpN?=
 =?utf-8?B?R080dktaTVNHSXd2c0dpYUhxRThzN1JxZjQ2K2V6dy9EV0dhdXpDVGFpT2dr?=
 =?utf-8?B?bFM5UU9zeFlYY2V3OGJLd29WL3dreGFTSjV3aGRlZ3lYdkljWkRoK0FmQmg0?=
 =?utf-8?B?L1dnYWlCckpNZ2xjano2QzJrdTUxbDZyOHpLRUh5d3QwSVJjbktSbkdwNTZj?=
 =?utf-8?B?VHFjZ3FPcnFWWGYyOGF1Sm9YS25vYmFVZnhXdWFWVG1IOVdhdVJzY1UyMzdP?=
 =?utf-8?B?N2hpNEhtR1FUKzZyaCtBRXFUOFBmcERYUmZFbnVlaFl0c0ZoOVcxdktaM0RS?=
 =?utf-8?B?Um4zRFdCMzE3UGJCT3oreGdxOXExVUc5cmVjbFlPZlI1OU43bXhmRFYwRG44?=
 =?utf-8?B?a3dXS0dCVFJKZEU5dDEyOS9CVzNaUjBwZ3ZnanVWSHcxWHJEVms3Kzg4RWZR?=
 =?utf-8?B?SDVTTllPQ1dqT1VkVTlIMDBqRFcxSVJITnJnWmY4MVZNZmw1ODNOa1VWQ0w3?=
 =?utf-8?B?QXAxcFhqUDRRWXVpajcrR3BhcHYrVE45eVZpazZSd0JYTzFxdDBtMVBjc0sx?=
 =?utf-8?B?Nkw2MjlHMVdqb0pPdzE1VlphU254dmtHU3BBQmpDbFovaUdEMDhQdmdRWjYz?=
 =?utf-8?B?MWNqYzFGR1JPNUxIQmFVZmxocGNtaS9MKy9TRTdoaGVJYkIrbTNiZkdJODBZ?=
 =?utf-8?B?Y0g0V1NJQjZuNS9NSFloMmJYV2hHcXBQVm1lYjA2TkR3TWhaNXRIUXNVNE95?=
 =?utf-8?B?ai9wVnNEQStBVDVyWVhXY2Nza2tvMWtlWk5SWWFuOW5xOEpuS2pKdUhyYUtv?=
 =?utf-8?B?UGE0eWN4MnFBK0t3RjNpYkoyeWJjeW15T0oyb1pCeFNtQ1NEbWpPU1JTbFNB?=
 =?utf-8?B?TXk1VEZPcjJ2bEpoVTQxV2xXMjJpMEYyUllGeW0rbTFnUjl6NWJ2cEtUWExp?=
 =?utf-8?B?bmRlZFdwR0FrVXdvR1J4czU0Q21IY1pEWHNGekZ5YkNQY0FSL00vS0lHckRS?=
 =?utf-8?B?c1NNZmxxeTJkRWd6Qzh4ajgySmpueXZKdkNWZ0lFZGF0TUJpSUlhdU9YS3VZ?=
 =?utf-8?B?cmdua0krbEowLzRGUXlNN0gwVit2L1JLQ0xhdzZwQXpXQ0RDcmRxUDNUR0pO?=
 =?utf-8?B?dFRzQ05kTDJCeXhoY25id3UxTHVLZHU4ZFpYcmNkaEFqTnpHSnJMZTJ1N1ll?=
 =?utf-8?B?b3hWeDZHcklLNFliZmhGY0NSd0dnZ2V0b0lXTVdkSlJ1dEtSVGtwSXJ6cno5?=
 =?utf-8?B?N2RUbUlrK2RuZ0xERE83Q2Y0RVMxWVVSK3VITTNmbWJpVDFTc1lmcDZOSEcr?=
 =?utf-8?B?L1l2UVV0S091SEVrdFdzTTUrbDh6TlpNTk1HbXczWnNDU2tSbWY4WTJobG9I?=
 =?utf-8?B?N1RvNGlwdkJuR3ZTSnVhTytrYzlqWHFmcGRQSDJaMVd1ay9oQm9FRlNxWW41?=
 =?utf-8?B?WTZ4dTdnNWNrQmliVWVpdjlPY1BEQS9CM0NXcW9DSUN2cWJicWxrZUEyUEt5?=
 =?utf-8?B?NGVzc1NGcHBoT1B6ZEQwZktjZStSc3dHdmFXOER6SG94RERYRFIvQjhYdEtq?=
 =?utf-8?B?QkxRRVg3ZTIvK01Ra3VHZWpxUUdob1NhNjg3WWlzbFA3UXZlTlo0TFZkcXJC?=
 =?utf-8?B?eGRJRWZ0cGpXUEt5cDZQYU4rZUxYTnliSFRsMmhVOW90SHI0Q1RkYmhzblE5?=
 =?utf-8?B?cHBCc2loSXFwK3dRK2lhb3kxb2h3RVpZaHpPUEFvQUk5eDUzdWhTV1EvSHJ2?=
 =?utf-8?B?Q2VoaGFZVm82ck15Mk53cmV0aXd0U2ZMMmZqb1pMQUZKMlJmemxsc2FNM0Z4?=
 =?utf-8?B?QlhBWjhZbjVkaEtBTFVtL0wzQ0pLelZWdXVMY2ZpSGN2Mjg4UWdMcklwNVlT?=
 =?utf-8?B?RE5jY09kU292TmZKYnpiNTRGdnJQdmp6UmY5M3NFbGhVdXhOWjg5Z1YvMmNo?=
 =?utf-8?Q?2rEyW0f6KJE0BxrQrA10yOxyk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3e0bc3-4f2c-4a7d-4337-08db5256e5fd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 19:35:38.4825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHLm7nfleTCUU0pgWc40EE1I89HxgAlh9CCE+8YEA2q7AEjfMqr36miEUQUNCmyDw6RF3Fwcf3DxJfONZY0Kwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_123544_891001_AAFBB25D 
X-CRM114-Status: GOOD (  21.97  )
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



On 11/05/2023 21:50, Hannes Reinecke wrote:
> On 5/11/23 18:54, Max Gurtovoy wrote:
>> When first connecting a target using the "default" host parameters,
>> setting the hostid from the command line during a subsequent connection
>> establishment would override the "default" hostid parameter. This would
>> cause an existing connection that is already using the host definitions
>> to lose its hostid.
>>
>> To address this issue, the code has been modified to allow only 1:1
>> mapping between hostnqn and hostid. This will maintain unambiguous host
>> identification. Any non 1:1 mapping will be rejected during connection
>> establishment.
>>
>> Tested-by: Noam Gottlieb <ngottlieb@nvidia.com>
>> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>
>> changes from v1:
>> - address comments from Christoph
>> - allow only 1:1 mapping between hostnqn and hostid
>> - add error prints in case we fail a connection for user to understand
>>    the reason of the failure
>>
>> ---
>>   drivers/nvme/host/fabrics.c | 98 ++++++++++++++++++++++++++-----------
>>   1 file changed, 70 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 0c0172bdc4dc..f8e47c7d6188 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -21,35 +21,77 @@ static DEFINE_MUTEX(nvmf_hosts_mutex);
>>   static struct nvmf_host *nvmf_default_host;
>> -static struct nvmf_host *__nvmf_host_find(const char *hostnqn)
>> +/**
>> + * __nvmf_host_find() - Find a matching to a previously created host
>> + * @hostnqn: Host NQN to match
>> + * @id: Host ID to match
>> + *
>> + * We have defined a host as how it is perceived by the target.
>> + * Therefore, we don't allow different Host NQNs with the same Host ID.
>> + * Similarly, we do not allow the usage of the same Host NQN with 
>> different
>> + * Host IDs. This will maintain unambiguous host identification.
>> + *
>> + * Return: Returns host pointer on success, NULL in case of no match or
>> + *         ERR_PTR(-EINVAL) in case of error match.
>> + */
>> +static struct nvmf_host *__nvmf_host_find(const char *hostnqn, uuid_t 
>> *id)
>>   {
>>       struct nvmf_host *host;
>> +    lockdep_assert_held(&nvmf_hosts_mutex);
>> +
>>       list_for_each_entry(host, &nvmf_hosts, list) {
>> -        if (!strcmp(host->nqn, hostnqn))
>> -            return host;
>> +        if (!strcmp(host->nqn, hostnqn)) {
>> +            if (uuid_equal(&host->id, id)) {
>> +                // same hostnqn and hostid
>> +                return host;
>> +            } else {
>> +                pr_err("found same hostnqn %s but different hostid 
>> %pUb\n",
>> +                       hostnqn, id);
>> +                return ERR_PTR(-EINVAL);
>> +            }
>> +        } else if (uuid_equal(&host->id, id)) {
>> +            // same hostid but different hostnqn
>> +            pr_err("found same hostid %pUb but different hostnqn %s\n",
>> +                    id, hostnqn);
>> +            return ERR_PTR(-EINVAL);
>> +        }
>>       }
>>       return NULL;
>>   }
>> -static struct nvmf_host *nvmf_host_add(const char *hostnqn)
>> +static struct nvmf_host *nvmf_host_alloc(const char *hostnqn, uuid_t 
>> *id)
>> +{
>> +    struct nvmf_host *host;
>> +
>> +    host = kmalloc(sizeof(*host), GFP_KERNEL);
>> +    if (!host)
>> +        return NULL;
>> +
>> +    kref_init(&host->ref);
>> +    uuid_copy(&host->id, id);
>> +    strscpy(host->nqn, hostnqn, NVMF_NQN_SIZE);
>> +
>> +    return host;
>> +}
>> +
>> +static struct nvmf_host *nvmf_host_add(const char *hostnqn, uuid_t *id)
>>   {
>>       struct nvmf_host *host;
>>       mutex_lock(&nvmf_hosts_mutex);
>> -    host = __nvmf_host_find(hostnqn);
>> -    if (host) {
>> +    host = __nvmf_host_find(hostnqn, id);
>> +    if (IS_ERR(host)) {
>> +        goto out_unlock;
>> +    } else if (host) {
>>           kref_get(&host->ref);
>>           goto out_unlock;
>>       }
>> -    host = kmalloc(sizeof(*host), GFP_KERNEL);
>> +    host = nvmf_host_alloc(hostnqn, id);
>>       if (!host)
>> -        goto out_unlock;
>> -
>> -    kref_init(&host->ref);
>> -    strscpy(host->nqn, hostnqn, NVMF_NQN_SIZE);
>> +        return ERR_PTR(-ENOMEM);
>>       list_add_tail(&host->list, &nvmf_hosts);
>>   out_unlock:
>> @@ -60,16 +102,17 @@ static struct nvmf_host *nvmf_host_add(const char 
>> *hostnqn)
>>   static struct nvmf_host *nvmf_host_default(void)
>>   {
>>       struct nvmf_host *host;
>> +    char nqn[NVMF_NQN_SIZE];
>> +    uuid_t id;
>> -    host = kmalloc(sizeof(*host), GFP_KERNEL);
>> +    uuid_gen(&id);
>> +    snprintf(nqn, NVMF_NQN_SIZE,
>> +        "nqn.2014-08.org.nvmexpress:uuid:%pUb", &id);
>> +
>> +    host = nvmf_host_alloc(nqn, &id);
>>       if (!host)
>>           return NULL;
>> -    kref_init(&host->ref);
>> -    uuid_gen(&host->id);
>> -    snprintf(host->nqn, NVMF_NQN_SIZE,
>> -        "nqn.2014-08.org.nvmexpress:uuid:%pUb", &host->id);
>> -
>>       mutex_lock(&nvmf_hosts_mutex);
>>       list_add_tail(&host->list, &nvmf_hosts);
>>       mutex_unlock(&nvmf_hosts_mutex);
>> @@ -633,6 +676,7 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>       size_t nqnlen  = 0;
>>       int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
>>       uuid_t hostid;
>> +    char hostnqn[NVMF_NQN_SIZE];
>>       /* Set defaults */
>>       opts->queue_size = NVMF_DEF_QUEUE_SIZE;
>> @@ -649,7 +693,9 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>       if (!options)
>>           return -ENOMEM;
>> -    uuid_gen(&hostid);
>> +    /* use default host if not given by user space */
>> +    uuid_copy(&hostid, &nvmf_default_host->id);
>> +    strscpy(hostnqn, nvmf_default_host->nqn, NVMF_NQN_SIZE);
>>       while ((p = strsep(&o, ",\n")) != NULL) {
>>           if (!*p)
>> @@ -795,12 +841,8 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>                   ret = -EINVAL;
>>                   goto out;
>>               }
>> -            opts->host = nvmf_host_add(p);
>> +            strscpy(hostnqn, p, NVMF_NQN_SIZE);
>>               kfree(p);
>> -            if (!opts->host) {
>> -                ret = -ENOMEM;
>> -                goto out;
>> -            }
>>               break;
>>           case NVMF_OPT_RECONNECT_DELAY:
>>               if (match_int(args, &token)) {
>> @@ -957,13 +999,13 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>                   opts->fast_io_fail_tmo, ctrl_loss_tmo);
>>       }
>> -    if (!opts->host) {
>> -        kref_get(&nvmf_default_host->ref);
>> -        opts->host = nvmf_default_host;
>> +    opts->host = nvmf_host_add(hostnqn, &hostid);
>> +    if (IS_ERR(opts->host)) {
>> +        ret = PTR_ERR(opts->host);
>> +        opts->host = NULL;
>> +        goto out;
>>       }
>> -    uuid_copy(&opts->host->id, &hostid);
>> -
>>   out:
>>       kfree(options);
>>       return ret;
> 
> Hmm. Remind me again: what's the supposed behaviour if I do _not_ set 
> the hostid from userspace and try another connection with the same hostnqn?
> If I read the code correctly I will be getting a new 'host' structure 
> (as the hostid is not identical).
> Is this the behaviour we're aiming at?
> I would have thought that I would be getting the same host structure ..

Unfortunately, the nvme-cli is not handling the hostnqn and hostid well IMO.
It should have enforce getting these 2 together or non of them. The 
current code in cli allows the user to provide one of them in cmdline.

We also might have hostid and hostnqn files under /etc/nvme.

So what we have is:
1. if files under /etc/nvme exist:
  - use values from files if the user didn't set explicitly from command 
line during the connect command (for each missing argument).
2. if files under /etc/nvme don't exist:
  - use in kernel default hostnqn/hostid (that is created during module 
loading) values as it uses for the /etc/nvme files.

The code today will override the hostid for the host that it matches 
hostnqn. In case we'll have a reconnection, we'll reconnect with hostid 
that was mistakenly overridden.

In v1, I've fixed that and allowed having hostNQN with multiple ids but 
Christoph suggested blocking it in linux and maintain unambiguous host 
identification (1:1 mapping between hostnqn and hostid).

In v2, I've enforced the 1:1 mapping and fail connection establishment 
in any other case.

I've added error prints to dmesg to help the users to understand the 
reason of the connection failure.
It is better to fail the connection establishment than overriding the 
hostid under the hood.


> 
> Cheers,
> 
> Hannes

