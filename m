Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FC3C7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 23:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VM72QUkPwFXOtTEjK7UbL3TqcES37TrBWCQXy/5IUsU=; b=VVxRw7QJVjOcMZh8YUZX/x9trf
	J++KLW0nXdjwglyIbkCGr0vYFFo941AQ5TkWu2kakZHvX2zFjzXLjX1c87GMZJRQ2+c5N8ax4qxdY
	OJQgc52yPunHe6PUvmEk/HD87pE7TJAABlvHzsUMjYtg+qNFTCcRc2MipdeopHtatElsnRECLhBxm
	gJ8Y9ekEagjfaXkpJ+brpkbmtspF+TnPZqF6jiAOTMKq6rTfvvhwG5c06CJHZDwdCWxldMu5eRogt
	E/p4LSQmq+I0EBbwO9FjRKQRcrYQid2OQvtWw6LJoKXbFrsCB5cgRZPg3c0aCvN4KGFMAlHSZe/yj
	mJuhMPZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxFaU-00AKdX-2i;
	Thu, 11 May 2023 23:20:42 +0000
Received: from mail-bn1nam02on2061f.outbound.protection.outlook.com ([2a01:111:f400:7eb2::61f] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxFaR-00AKcb-1q
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 23:20:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVfZpFRkQzVpQC47vGKnDQ4lzbwtbMTYgMiQb+66BRrC/G3HsQnINtSWNLAGt4T8PI9i0fnH8KedW0Lh6QwTeqj67gRjUeJvBD39S9eTwxx/GE5mbLsIevFId93cZD/N7imbrYD4m4/lKXzZ+DNVlJq8brnADMLeRxsTg8yx7dulPeMtCv+bChP1iTpr30D1fDjVJNn29GajyF4OJ9ZxDvkdt2SSGhHvmthP/Se/ZZfvj71zueZXk8f+YX/alyTAfZwH+u+JIhIUyd815aL1evbEhUPQ/EUElgbaC9OGwfe019YdTWgmMjlvk0hrRuA5op8whJm6HaJ0IMomyu4nPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VM72QUkPwFXOtTEjK7UbL3TqcES37TrBWCQXy/5IUsU=;
 b=DBnLKsNP2ZQ9ULJbKhUW7Chir5p9gYV9xTmexyzMEOPryjpDIiYDuEWPI2aSQF0ptrqJ+sqtnk5hnKeMTgWrr8YuHdNqseRGfjKwAZgVtTS8BA3ewOk/DQ2yVApMuK1zTEaQmEbYxOJwLhekN96cX17Eqy5ha354x1A0JkrfzEEVmnq6izEfVlYTrk0wVJPvwkh6eEjJPaEQv4mJVzu2Benw5LhUA/VsXjcQ9RmKLs2G5FlyGm8ogOHjY4p8evI+s9zJt6HP6lQDd0rCAq1123XnO0ywEb51nKYKEMbKqIgKokPO3K/vnEcx6A1uHSwiPCaeYQM3qm80RhKGzkuwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VM72QUkPwFXOtTEjK7UbL3TqcES37TrBWCQXy/5IUsU=;
 b=iVdoga1NkGhL/d8HZnYJIqV8liWdNj79Aw5/y9JgGPn+9K+GxSvQC9MSHjYTQiPU6a7dp3SNaupG0L7XR4FSL0bPH1IO2WTLTCDzjUIzXwJ2zCFyNSQ7c97bX/gDsD2YDmeOqMvMBoaH2Uvr6t+EcRhzd7nSnk4YhHvRKB19zT+JrNiuU4Gm4zEMokVtEJWKHenJ3BouN3gZuCtXDJwHD5KlV/c4oN1olHv8A2vjwk7muaA7q+ONc59qEpduP6s/1QFU8Z4aknQY/VD6XR/kBmzssYym0ptyPoHCJbng0SWO36ysLEof/YhkQuLf8W5z1e7SmiqqsIufAs9YCwMwAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 23:20:33 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 23:20:33 +0000
Message-ID: <acde645a-78e9-c0a7-3b19-fca16f7735b0@nvidia.com>
Date: Fri, 12 May 2023 02:20:24 +0300
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
 <025ae696-38cd-edc1-edf4-3cc05b4e9a9f@nvidia.com>
 <95e9f93b-4545-871e-bf69-8c1a2f8ffe5c@suse.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <95e9f93b-4545-871e-bf69-8c1a2f8ffe5c@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0137.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::16) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MW4PR12MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6abfd6-7157-4590-38ed-08db52765191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	8yGcrczzt71gNYHgExXhVKElOEKA6/KSyuxdFyk8ujG6sRmrDZHEbPpCfz5mCtuhIxsh442MIDlRf5DQTgowM4AEo0z1d/EAfzsR76/pWOq1yOexrn5dDXDJaEj/ctY3V/iFQ9ylpW/m9u+pCTHM368C5abOtFIo63wF3sUpuOk4WxDmzMr4iPo1nCRlEiN/uYk+XBFeKR7RE3oX6JhlE2a1Inr+vioNPMBqwVykkjRP3VXao6vrduNHnkRpgwkMOhj27WrbS9egOZkkT09rZcn0KiFngrCalr9jEHqgewVeqOYsIjrcDH+jMfmRL9+8KY0CSh5bt9wmzroMCuU1bRhVAtuPL2O3NuUs7thM6LHrxQgRqFOiRtUptCzEhSZWT/YDMxgXFZdLpojfJxxu5F8gmvV59h9SBB163hBfXZSBmipjMvE8fu4DeCyJuEzYLIXZhIQWyA8EB4KwZzK6wUU2s4Ozn9K1O84WzvYco4Ujhgm5jQ3ux9xHxQ6X0/xZpaVfuQ7L+17MasDPO32r0ytWx4x4m2WG4kCmZXVMeoHC2RZYBjxbb13100GuE1xLUffAdUG6TpkCobxSXA/WLFamA6YlhmrMl/tVjbg4osfFhs37jUKaMxruR22bHq7BmF97URIrgSfKeck1S4OrcA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(2906002)(5660300002)(6506007)(31686004)(83380400001)(26005)(53546011)(6512007)(2616005)(38100700002)(8936002)(8676002)(41300700001)(66556008)(66476007)(4326008)(66946007)(316002)(36756003)(186003)(86362001)(6666004)(478600001)(31696002)(107886003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?UHBwbWU4ajJLT2t0Ym4wVnVLM2JDQVVkY1JJWEFBbzQ1bEpoeWxsWnJzaG1w?=
 =?utf-8?B?UGkyUVVSS0ROWklUVTBmSlFnb2phWEhmSmhkaGdMR0JueXl6Q2N4SkhtZ000?=
 =?utf-8?B?WWs5VFBYOVVHcHhmNERObkdkTGpqMW91czA0eHJ5ZXk1a0VJbm1VWExBU2tD?=
 =?utf-8?B?eFZBeUh5SWo2WXJKVXB3aVMyZnZyMGdQZ3padGp3RDRtdjVkejFTRjdQV2hT?=
 =?utf-8?B?OHNDczJwNXFZUEhPTVd3MkhaTkl1VngxWFpqTGE3dVhDOE5zQ0VKQnBMek1R?=
 =?utf-8?B?OEF6L1pSc3lvdWhrVzVHR05oOUhncWJtMTNWcDBTS2RCdGhjdXlzN1lTZXZx?=
 =?utf-8?B?eTRtdy9wMUdldVFIWnlaR2tpSzc4NWdrL09La3dtTm5XOGluUnQyN0lMcTd2?=
 =?utf-8?B?MmZ5M2d1N3dnS3VEdDM0MHFTQ0t3dHBtNmRmNzc3MEJpdkdKWjRkZnlYQlVX?=
 =?utf-8?B?M1Q3TmJvQU4wVUJ2c0tJTEwxdkVqaWNlbWQ2VFNXaEpPMzZFWk4vbGp6RDBD?=
 =?utf-8?B?cDY2Mll0OWoyYi9mQUJjNkluazgwNVZaUnNJTzkzTk93RVJIamtkMUtWc2xi?=
 =?utf-8?B?dE5acE1ldk93ay8rSWNuYTYzV2ZlRTZ6UWpwc1doOFNFa09pWGFXR2t5ZjFW?=
 =?utf-8?B?TlFrQkNsc1VVS0tqRDlqNXFiaFhuYmdrZ1FpVHhnajNJclRQSTJtM2JtY0hV?=
 =?utf-8?B?T2VpV2NUbEgrdEJTY2JpMXhPK2pTSG1YaGdHK2hyaFp6VkNpR0Z2MytncWhY?=
 =?utf-8?B?aisvbURPS20wSFZxNXBGUm1YSHpaUWVCSkZCUU15T2haUzh3TEhGN2ZRVENm?=
 =?utf-8?B?VGNoQzBsYkhEQ1NCNFM2OHZna21HNWkyZkR2NnR0aXYzdTB6SFg2VUFvVzVj?=
 =?utf-8?B?MGJzNEV2Q2x1S2dEZEVqWHJMSnZXU1JUeDFzcU9maW9EQi8rcUFDUTBUZlk0?=
 =?utf-8?B?SUFsNk85YWpZV05KMlNGMGJSaTBDUUVsenMrT3Fzcmt4Z1dMSHc2QVNUbHp6?=
 =?utf-8?B?bEIyVlQybVcyY0trdHh3SDN3RHJyNUowcWVBam1icDFpYUhSam81Qll6TWxp?=
 =?utf-8?B?LzFSVGt1M1NNUldYUC9iTEgrUENHc0kxRGFOUlVBRkNTMkpJbmxkV2xlR3VT?=
 =?utf-8?B?azFPMjAzOE9OczNUaFo5TmFkVmUvMWo3ZmJ2RVVTOFdiYjRhczNWMG9peWpu?=
 =?utf-8?B?K2Uxd3JmUUY4b2F2RnVackwxOUpZd3k3blNMVnlNSFBhK1dCQnZPVDg2TWV3?=
 =?utf-8?B?UDRaV2tlNkY2WlZUYUNrcGlKUkswVjBXS1B1U0VqdmM3M29zLzhjeGVNRTJl?=
 =?utf-8?B?eUpsd0pIanBNRFZhZ3ZpK2FVaHNMSHNvd2VYREFlSVFJWHgwZWFEVEcvcVZq?=
 =?utf-8?B?dmtNS0Y5dis2K1ZGWmkwaGNoTDVTc3MxWnBoNHlmbVoxcTVGU01GTG9lRWJ1?=
 =?utf-8?B?ZVMvQnd2TGo3Ym5wdXFTZmxRMkFMRXBvN0dta3NPbWdzbWpITmRSaVhMYktt?=
 =?utf-8?B?ME00cEZETFByRXFaRmpXQ2R3RnZjcHNYQ3lhOTVGSjlydFlHMGgyRGExaUs2?=
 =?utf-8?B?ckRIUGdOSFgrang3M0ZiWkZlNHNGZHgxTU02cXVmdHRmNU9TWXR5czhGY0tq?=
 =?utf-8?B?cTFkVi9ZemVZMURGWG00N25yUmlFZnN5S2xmUlliaFFncVNCVm1vZENVakE3?=
 =?utf-8?B?NkhFaWNwc2ZaTVpVZTNlU0lHblg0bWVrbFZ2RGJSb1ZWdWhyU0FXVFJwL2ZU?=
 =?utf-8?B?QmRVeWNKSVhDQ0ptTlVQTWhOV1ZaS1lOdWkvM0ExUFQ2TnBJamROQUNuMW5i?=
 =?utf-8?B?Q1pGcmU3alVLQzF4b1RiV3B4ck81NjY0R242eXFTcFBrY1Q3cXFwWDlkTDd4?=
 =?utf-8?B?WTRkR0RqaThndFlRMWg1OTRCMVIwMXpWZlNPbUcrbkVmeXhGdUtHVmQ3amFZ?=
 =?utf-8?B?ZWxtcURVcHl0R2VlT2NFNWllcWVyMzFZZWgxdGpkSHdyOCtjV0RSaTB1Y1lG?=
 =?utf-8?B?bFV2Q1JTUnZqTnNBaXYwUUEvdmpVaWV2RzlJcGg1UGZSWm9NSlhjUHVkRnRU?=
 =?utf-8?B?NFVjMjVpaEE1MnBCV3FSQkFIMXNWekpUQXNiZS9kTmVTenJyaWV6dDZ3TG1F?=
 =?utf-8?B?RHpqcWdOelR1VkJqcEd2d3pqYlJxelltU3ljNUlZNk1UUi9GdC9tUlJOeGgr?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6abfd6-7157-4590-38ed-08db52765191
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 23:20:33.3552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pS8Eoa0bQ7czDZ7J8bSFdzBXaEDYZ3Ts/Qz6F8NFVpQBJyrryv9MXoO6ZxC6tkUd9QSRllWE36eAKJdemsO5Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_162039_741964_166431C2 
X-CRM114-Status: GOOD (  18.73  )
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



On 12/05/2023 2:13, Hannes Reinecke wrote:
> On 5/11/23 21:35, Max Gurtovoy wrote:
>>
>>
>> On 11/05/2023 21:50, Hannes Reinecke wrote:
>>> On 5/11/23 18:54, Max Gurtovoy wrote:
>>>> When first connecting a target using the "default" host parameters,
>>>> setting the hostid from the command line during a subsequent connection
>>>> establishment would override the "default" hostid parameter. This would
>>>> cause an existing connection that is already using the host definitions
>>>> to lose its hostid.
>>>>
>>>> To address this issue, the code has been modified to allow only 1:1
>>>> mapping between hostnqn and hostid. This will maintain unambiguous host
>>>> identification. Any non 1:1 mapping will be rejected during connection
>>>> establishment.
>>>>
>>>> Tested-by: Noam Gottlieb <ngottlieb@nvidia.com>
>>>> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
>>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>> ---
>>>>
>>>> changes from v1:
>>>> - address comments from Christoph
>>>> - allow only 1:1 mapping between hostnqn and hostid
>>>> - add error prints in case we fail a connection for user to understand
>>>>    the reason of the failure
>>>>
>>>> ---
>>>>   drivers/nvme/host/fabrics.c | 98 
>>>> ++++++++++++++++++++++++++-----------
>>>>   1 file changed, 70 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>>>> index 0c0172bdc4dc..f8e47c7d6188 100644
>>>> --- a/drivers/nvme/host/fabrics.c
>>>> +++ b/drivers/nvme/host/fabrics.c
>>>> @@ -21,35 +21,77 @@ static DEFINE_MUTEX(nvmf_hosts_mutex);
>>>>   static struct nvmf_host *nvmf_default_host;
>>>> -static struct nvmf_host *__nvmf_host_find(const char *hostnqn)
>>>> +/**
>>>> + * __nvmf_host_find() - Find a matching to a previously created host
>>>> + * @hostnqn: Host NQN to match
>>>> + * @id: Host ID to match
>>>> + *
>>>> + * We have defined a host as how it is perceived by the target.
>>>> + * Therefore, we don't allow different Host NQNs with the same Host 
>>>> ID.
>>>> + * Similarly, we do not allow the usage of the same Host NQN with 
>>>> different
>>>> + * Host IDs. This will maintain unambiguous host identification.
>>>> + *
>>>> + * Return: Returns host pointer on success, NULL in case of no 
>>>> match or
>>>> + *         ERR_PTR(-EINVAL) in case of error match.
>>>> + */
>>>> +static struct nvmf_host *__nvmf_host_find(const char *hostnqn, 
>>>> uuid_t *id)
>>>>   {
>>>>       struct nvmf_host *host;
>>>> +    lockdep_assert_held(&nvmf_hosts_mutex);
>>>> +
>>>>       list_for_each_entry(host, &nvmf_hosts, list) {
>>>> -        if (!strcmp(host->nqn, hostnqn))
>>>> -            return host;
>>>> +        if (!strcmp(host->nqn, hostnqn)) {
>>>> +            if (uuid_equal(&host->id, id)) {
>>>> +                // same hostnqn and hostid
>>>> +                return host;
>>>> +            } else {
>>>> +                pr_err("found same hostnqn %s but different hostid 
>>>> %pUb\n",
>>>> +                       hostnqn, id);
>>>> +                return ERR_PTR(-EINVAL);
>>>> +            }
>>>> +        } else if (uuid_equal(&host->id, id)) {
>>>> +            // same hostid but different hostnqn
>>>> +            pr_err("found same hostid %pUb but different hostnqn 
>>>> %s\n",
>>>> +                    id, hostnqn);
>>>> +            return ERR_PTR(-EINVAL);
>>>> +        }
>>>>       }
>>>>       return NULL;
>>>>   }
>>>> -static struct nvmf_host *nvmf_host_add(const char *hostnqn)
>>>> +static struct nvmf_host *nvmf_host_alloc(const char *hostnqn, 
>>>> uuid_t *id)
>>>> +{
>>>> +    struct nvmf_host *host;
>>>> +
>>>> +    host = kmalloc(sizeof(*host), GFP_KERNEL);
>>>> +    if (!host)
>>>> +        return NULL;
>>>> +
>>>> +    kref_init(&host->ref);
>>>> +    uuid_copy(&host->id, id);
>>>> +    strscpy(host->nqn, hostnqn, NVMF_NQN_SIZE);
>>>> +
>>>> +    return host;
>>>> +}
>>>> +
>>>> +static struct nvmf_host *nvmf_host_add(const char *hostnqn, uuid_t 
>>>> *id)
>>>>   {
>>>>       struct nvmf_host *host;
>>>>       mutex_lock(&nvmf_hosts_mutex);
>>>> -    host = __nvmf_host_find(hostnqn);
>>>> -    if (host) {
>>>> +    host = __nvmf_host_find(hostnqn, id);
>>>> +    if (IS_ERR(host)) {
>>>> +        goto out_unlock;
>>>> +    } else if (host) {
>>>>           kref_get(&host->ref);
>>>>           goto out_unlock;
>>>>       }
>>>> -    host = kmalloc(sizeof(*host), GFP_KERNEL);
>>>> +    host = nvmf_host_alloc(hostnqn, id);
>>>>       if (!host)
>>>> -        goto out_unlock;
>>>> -
>>>> -    kref_init(&host->ref);
>>>> -    strscpy(host->nqn, hostnqn, NVMF_NQN_SIZE);
>>>> +        return ERR_PTR(-ENOMEM);
>>>>       list_add_tail(&host->list, &nvmf_hosts);
>>>>   out_unlock:
>>>> @@ -60,16 +102,17 @@ static struct nvmf_host *nvmf_host_add(const 
>>>> char *hostnqn)
>>>>   static struct nvmf_host *nvmf_host_default(void)
>>>>   {
>>>>       struct nvmf_host *host;
>>>> +    char nqn[NVMF_NQN_SIZE];
>>>> +    uuid_t id;
>>>> -    host = kmalloc(sizeof(*host), GFP_KERNEL);
>>>> +    uuid_gen(&id);
>>>> +    snprintf(nqn, NVMF_NQN_SIZE,
>>>> +        "nqn.2014-08.org.nvmexpress:uuid:%pUb", &id);
>>>> +
>>>> +    host = nvmf_host_alloc(nqn, &id);
>>>>       if (!host)
>>>>           return NULL;
>>>> -    kref_init(&host->ref);
>>>> -    uuid_gen(&host->id);
>>>> -    snprintf(host->nqn, NVMF_NQN_SIZE,
>>>> -        "nqn.2014-08.org.nvmexpress:uuid:%pUb", &host->id);
>>>> -
>>>>       mutex_lock(&nvmf_hosts_mutex);
>>>>       list_add_tail(&host->list, &nvmf_hosts);
>>>>       mutex_unlock(&nvmf_hosts_mutex);
>>>> @@ -633,6 +676,7 @@ static int nvmf_parse_options(struct 
>>>> nvmf_ctrl_options *opts,
>>>>       size_t nqnlen  = 0;
>>>>       int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
>>>>       uuid_t hostid;
>>>> +    char hostnqn[NVMF_NQN_SIZE];
>>>>       /* Set defaults */
>>>>       opts->queue_size = NVMF_DEF_QUEUE_SIZE;
>>>> @@ -649,7 +693,9 @@ static int nvmf_parse_options(struct 
>>>> nvmf_ctrl_options *opts,
>>>>       if (!options)
>>>>           return -ENOMEM;
>>>> -    uuid_gen(&hostid);
>>>> +    /* use default host if not given by user space */
>>>> +    uuid_copy(&hostid, &nvmf_default_host->id);
>>>> +    strscpy(hostnqn, nvmf_default_host->nqn, NVMF_NQN_SIZE);
>>>>       while ((p = strsep(&o, ",\n")) != NULL) {
>>>>           if (!*p)
>>>> @@ -795,12 +841,8 @@ static int nvmf_parse_options(struct 
>>>> nvmf_ctrl_options *opts,
>>>>                   ret = -EINVAL;
>>>>                   goto out;
>>>>               }
>>>> -            opts->host = nvmf_host_add(p);
>>>> +            strscpy(hostnqn, p, NVMF_NQN_SIZE);
>>>>               kfree(p);
>>>> -            if (!opts->host) {
>>>> -                ret = -ENOMEM;
>>>> -                goto out;
>>>> -            }
>>>>               break;
>>>>           case NVMF_OPT_RECONNECT_DELAY:
>>>>               if (match_int(args, &token)) {
>>>> @@ -957,13 +999,13 @@ static int nvmf_parse_options(struct 
>>>> nvmf_ctrl_options *opts,
>>>>                   opts->fast_io_fail_tmo, ctrl_loss_tmo);
>>>>       }
>>>> -    if (!opts->host) {
>>>> -        kref_get(&nvmf_default_host->ref);
>>>> -        opts->host = nvmf_default_host;
>>>> +    opts->host = nvmf_host_add(hostnqn, &hostid);
>>>> +    if (IS_ERR(opts->host)) {
>>>> +        ret = PTR_ERR(opts->host);
>>>> +        opts->host = NULL;
>>>> +        goto out;
>>>>       }
>>>> -    uuid_copy(&opts->host->id, &hostid);
>>>> -
>>>>   out:
>>>>       kfree(options);
>>>>       return ret;
>>>
>>> Hmm. Remind me again: what's the supposed behaviour if I do _not_ set 
>>> the hostid from userspace and try another connection with the same 
>>> hostnqn?
>>> If I read the code correctly I will be getting a new 'host' structure 
>>> (as the hostid is not identical).
>>> Is this the behaviour we're aiming at?
>>> I would have thought that I would be getting the same host structure ..
>>
>> Unfortunately, the nvme-cli is not handling the hostnqn and hostid 
>> well IMO.
>> It should have enforce getting these 2 together or non of them. The 
>> current code in cli allows the user to provide one of them in cmdline.
>>
>> We also might have hostid and hostnqn files under /etc/nvme.
>>
>> So what we have is:
>> 1. if files under /etc/nvme exist:
>>   - use values from files if the user didn't set explicitly from 
>> command line during the connect command (for each missing argument).
>> 2. if files under /etc/nvme don't exist:
>>   - use in kernel default hostnqn/hostid (that is created during 
>> module loading) values as it uses for the /etc/nvme files.
>>
>> The code today will override the hostid for the host that it matches 
>> hostnqn. In case we'll have a reconnection, we'll reconnect with 
>> hostid that was mistakenly overridden.
>>
>> In v1, I've fixed that and allowed having hostNQN with multiple ids 
>> but Christoph suggested blocking it in linux and maintain unambiguous 
>> host identification (1:1 mapping between hostnqn and hostid).
>>
>> In v2, I've enforced the 1:1 mapping and fail connection establishment 
>> in any other case.
>>
>> I've added error prints to dmesg to help the users to understand the 
>> reason of the connection failure.
>> It is better to fail the connection establishment than overriding the 
>> hostid under the hood.
>>
>>
> Oh, I fully get that an I'm on board with that.
> Issue is that you are generating a random ID if none is specified on the 
> commandline, so the second call (with the same parameters) will fail as 
> we're just checking if the hostid is identical.
> Guess we'll need to skip the check of hostid if none is specified.

I'm not generating random IDs.

if none is specified on cmdline then:
if /etc/nvme/hostid exist take it from there;
else use the default_host->hostid


> 
> Cheers,
> 
> Hannes

