Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B826C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 12:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4zoq/XFM4r5loYPcX0FVwy1mGC50VxMGIvUGmIfyvI4=; b=NvJMzpZDWwDum2zdS0J4+6z4QI
	Ape/73S4UE/zBybBa7wHZsgC2qZwVsiUOXWfReXweH1w1FALdZxDl48Uqo0M8BFO/DMAbj8W1Vg0L
	psDRrPX8LnkOerRcY9TX0t+WzvEq5GiuSJ4ICfTGQ+WXWtxgC85rMJHtZNZAycCRADB6GpFM7/4TM
	1G324Im1HS6Y5qhDI/7k+gnjmHX8m1zvqon/spNARSFM0RmRq2c6sK53mBAyNVn3f05abzNnsdaZQ
	Va7ARPgVM84NUCYSuha+8etrqhhWXsCHeY4v5e2TG1SbLOXc45KwvPLjGmlgM1n9BdQsrC8PoAlRK
	C5WdOqCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHkC8-00Ar0Y-13;
	Mon, 25 Dec 2023 12:36:32 +0000
Received: from mail-mw2nam12on20603.outbound.protection.outlook.com ([2a01:111:f400:fe5a::603] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHkC5-00Aqzj-08
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 12:36:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkiGw9J5b91umAQN91RrSMAFqNxiz06k78bXIzH7ZxwJxXvkzIdvOArLAu6vEXVuXEtmpOfNbgs4vjN0U0XZ2KCt2IVQKBwtKQOlB8jDKLSfX5zGctQxHQM00PxorZzLYRz9xd8v03Hf6t6t7tXilYNeX21tLAqqooE25EMn45NwSCxnLjwik920aZ+ar7PYrqE6rMkbAXl6rIL25XO4trsbyJw2Cl74rzL2EMMhEalgRcjFub0C0ziHq19Ad2fBhf5HbvjIvsnxzss+14l5of1kXM8zWbXHks9KMYfPhizj3Aq4AJOCgpmzXzxXHwES7GiJRnKQPh83vAyVgjtvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zoq/XFM4r5loYPcX0FVwy1mGC50VxMGIvUGmIfyvI4=;
 b=Vw/RYsbmnHIvpCWdAYahmjRjBI48N3iJOx0lJwlL0KHg2LgcJUnslTTPnebKQ5pNd7+pzbesCnK5uslJAsA5XF64GyaUFpHI3B9r2CGngrH82N1J6B2ERcMKYxaRhuUgobmiXXABqPel1sOAonaW9cAJUIiz+9pT4WEF7VmGBKHIwWDfMb8IRxhFLKniA9oTXkIIlErWBheRlPxoLaysmmpwUDgWeyhMOWOWRw5wQV3wy2Hgn5OevXo9aEusL1l1fXsbOED1+4pKvPcqkfByCT94NRLJxuOG5e+H47vjEDmbLVHqREQoFOnWjVkzucCWWHWSrcJfU3ec2f4W400nhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zoq/XFM4r5loYPcX0FVwy1mGC50VxMGIvUGmIfyvI4=;
 b=YdGgIy63JNWmg9bENOUruZPaCKW8FMYznVn6MJZEL8R/6S0JpGr9cMU8Vff9lOXV50Zs09+2QmFk1YpMpqoNHS1ragAe7vMC+QuqsEfi5A5YHnT9HpQrEibv6k0gc3OAqzAJURpJu5zTdpMpcMlgBWziHmLNis/fFbxk8DeTEYFlCGz33su9VLRmZBiuUHuP1SZbB/NWN9fi915kirYYKuNl55WwXwNttgI0+5nzM8HUvxCfmLMMyrvogAXcT38Bkc8OlRuLWdBD1R9731a/n19uPw5kBgxYJqNjIGxOjYTdXCRXvZzM1Hr2JJc6eVFhl51MEqvU7JAKfx7vxvcj6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 12:36:22 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 12:36:22 +0000
Message-ID: <f4f4d62b-8f2e-460c-a393-ff2966c9ebd4@nvidia.com>
Date: Mon, 25 Dec 2023 14:36:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 2/2] nvme: rdma: use ib_device's max_qp_wr to limit
 sqsize
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Guixin Liu <kanie@linux.alibaba.com>,
 hch@lst.de, kbusch@kernel.org, kch@nvidia.com, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
References: <1702971145-111009-1-git-send-email-kanie@linux.alibaba.com>
 <1702971145-111009-3-git-send-email-kanie@linux.alibaba.com>
 <82d16c8c-efef-41d2-b2ff-8ce8f5ac9b28@grimberg.me>
 <92b53d3b-8ee6-42b1-a078-9b51886c6003@nvidia.com>
 <77df6829-3a14-49a1-82e5-f3389ba47d86@grimberg.me>
 <436efebd-ab7e-4b23-9be0-a316884552ca@linux.alibaba.com>
 <d5c0a0d8-f67b-49de-bb25-a64c53be5345@nvidia.com>
 <91dd2cb9-29ec-4727-818e-822cea788401@linux.alibaba.com>
 <51a09c6d-d4b5-4edf-814c-08bc95640a2b@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <51a09c6d-d4b5-4edf-814c-08bc95640a2b@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0104.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::20) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|BN9PR12MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: d6dc0331-ec9b-433c-e6b0-08dc05461a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h3k1gFLRUM6SxjImGk1C6C73dYhhzk+ItQ2slWi2jjrvEYLKbk1XAMm0XBhUTnBJKrncxEZuuM+XFjDOH6WJQsoVMi1v7Rin6vSMTsiX/dj5TH4O3IXbOFp5NDx18gUBmVNnVrebV+HUtVl5uff5kCcoqatJJTpItbzz2yAU57Ld6Z/+XmqQkKcew0+wrLRYcs7dlWblKo3RgvGajW/HKeGuBdQQL+cAw0SDcblvj4sIxAI9cZULAyrp3RJ4q+GuqmO1GwGZECrtH6JadQpdWNDtd8MckxOAoLo/vwq1Dnmq4J8ak7bEVObOpuRWa04ulmQF+xFCrlMiaS721MFX+NuaFKbcbErBgnb5LOyGiVghpHTM+jaltdu9TUKqAPV01v1rr63LKBihv3Kq7LZy3tR29PEEn/KbkIRy1iht50YLZEXpMQ9rC45S8z5nPv6xA3fYjNFWBadh81QRmTC5HzjsuA5IePgH8ILb+G0T+whAVT8WwmnKvLhNmmt4Yc+HEOLcXbA0yQvt49lc/gHRTK6OyBay7ucY5UQahMoGo7orC9YXBS3bjGMhUq5PKW8l/ebwx1fRYekxNj8MNYLbAAYPCWXQ47mjJIHAcQU8GSG3QssyagcYWtCk4pBbi5rPLndAQ3UQVXdGWLMAkaqB9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8676002)(8936002)(5660300002)(2906002)(4326008)(478600001)(53546011)(66556008)(66946007)(6512007)(6506007)(6666004)(66476007)(110136005)(316002)(6486002)(41300700001)(38100700002)(31696002)(26005)(2616005)(36756003)(86362001)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUIyWDJsenJhcSs3MWV0WXZsUnY5LzRDUzlEWWhYbWQyWnlXV2p1YTN2OXZy?=
 =?utf-8?B?SVUwYTdBRkUvajA2QUdIM2ZDREk2NzFqQXFCTnplSGRsRXBJOWg0K3F2dTZO?=
 =?utf-8?B?bC9TU0hiNk5YOEVwWE5sYnpNMnJSSjBSYnlKdFNia2J4dlg3eEdKd3ROUXpk?=
 =?utf-8?B?cElxd2d3VVdVNU1mRzhieE5QMmRoT29Cc0hadUplUDMyZHdSZG9pY0JrK21W?=
 =?utf-8?B?b2RXMGtYYWlNN2JEYUFJazhCbmkyWElXSzVSU254UHdBWlA5dWJCZGIrSmpY?=
 =?utf-8?B?ZkgzZFJ0eXl0aGU5MkttelYxYS8yZXdUak1oSGVrWWRxcUk2QUE2eTA0M08r?=
 =?utf-8?B?Q1JHTjJaUFFXWDczYnQ4NDJHbitzT2xQQzVEWSs1NnNVUnFRM2lZY3dQMXVz?=
 =?utf-8?B?Z0tac09zMXk1T3UvOHh5UFV1bktUYkpmRnNtZUEvc050Tnc1Yzdid091dW5I?=
 =?utf-8?B?RFcrd2VVSWJNdDBpaWxuUUJBbnlyOU5uRnJDaXQ1d1N6RERYQVZERVJocXRI?=
 =?utf-8?B?dldKWU9JVWdmSjl6Tmx3KzY5QmJ3WE8vOWpTSUxqTUsxTWpVekExbzN2Y21o?=
 =?utf-8?B?aklsQVVaZytMUi8xdWJ2Yzl4SnBsdEcrSUNWYWFpb0xjT05yK2xXd3dUWWVo?=
 =?utf-8?B?VUFxOXRzNmNSR24wZzBaNFlsa1JxWXZsVTZxTEFSZDI2Z3V3OU43bVFNd0xI?=
 =?utf-8?B?dEFLTTNibUl4RmFtY0FSZ0VIMlBaa0VQSmdDaGJLV2NZazNYVnVCOGNXRVhB?=
 =?utf-8?B?eWkvMFMxZDk1SFFzS2NSbUpVQUg2ek1KNFhyWnNMVmpPR0s1dG5BcDl4d0hE?=
 =?utf-8?B?Um9ONDdzamprZ0syZ0lrdDltMzZhNzk3Smk1ZDMwenUyM1FpRnlQcit6WWd3?=
 =?utf-8?B?WVN6U3orODczd2RscDJjOUJEbmYweGViWEdQNjVNVlE2dDM4dmg3Tmd2QVgr?=
 =?utf-8?B?Rkh0Y1I4dXROSHd3WDBqUlBPSkhSRG84UXpLL2ZEdzE4MlBONlZOdzZhWkNi?=
 =?utf-8?B?cTNSVk9rMGdHNTlHZWNmUHNaamVoVEtHZUxNSWVmQzl2K1A2U08ybjc3MGV3?=
 =?utf-8?B?eWdtMFgxRUI2VGtERmcrZFRBdjZtZnVwWG1xdlNzcjh4ejhIQTRaRGFMdEhO?=
 =?utf-8?B?cm5KUUFvaU1wVEk5TjRUaURFck1zV2RGb3dmNDZqVmlTR04yakFmNTZaeHl4?=
 =?utf-8?B?dUNJSVpwU3RRenN4MGROMFU1RERPTnFabFduOHpDVHNjTG92cW9SNXdsWjh5?=
 =?utf-8?B?d0tWemxYUE55REdaRlV0Y3JJZ3RZaVpZd0N3eXhmZE92R1A0Nk5MQVY1cWUv?=
 =?utf-8?B?MFFkVFkvUWhTQUJxK2U1Q1kxeElhQ1k4clovYkMyV1AyMVlYcTY1TFBSNkFG?=
 =?utf-8?B?RnA4M3lIZkxqaHFFTDNzdFkwNFVWSkhrOFk3MmxkeHEwcHJrdGZ1LzR5SjBr?=
 =?utf-8?B?YmIvYzZlZXhDRm83WjhZNzNPMEplQnpvVngzdEJoQVhxWmIrWU5pbDhJWVJE?=
 =?utf-8?B?QkVuUUxnNnhJU0tPVlBTTExsMGxKVkJVWk5kUGdGZHRTaDNHbDRRT1h2cmJi?=
 =?utf-8?B?NDVpc3RrVFBEdU80V2ovTmR3VlU3alpacDZzVVh2QUhXTXBGNzJOZXIzMlYy?=
 =?utf-8?B?cXhUbWgvWnZLc29tWFNtekhsZkpxWldPeklWN2tjZm1XQi9XbzdmcDlaUkRN?=
 =?utf-8?B?eXNmRWxaOXl5N3FhQmx2NDZBbjdjbWV6b0ZHa0Q5VGRmRnVEUFdwQkQyMzR6?=
 =?utf-8?B?VnRVeHpJZDM5TjZjQ3BHdjVJdzBXQXZDdU5aTkxhNVlYaHhHaW5zVEhLOE5i?=
 =?utf-8?B?TlhzR3FVREQ2UXBiQVdPUTJ2LzNWYkk4R0dhK2dqc09FSXk4QkNVVTdlM2pQ?=
 =?utf-8?B?OHhZOEgvbnBVbnRHM3VYS2pNbHoxWGNRSXVGSzdESTZ2ZWtPeWgyOGZMenZU?=
 =?utf-8?B?Y1IrbWdKNzVaSGcvTk5Vck5NbndZMnFTK3FqT2hpYVVKWkZzeG9tcmZxNTM3?=
 =?utf-8?B?QTQwVlpTSjhOM1BEQk9uZk5xMHhXNFp4QnJEdW4yWUlTZkNJRHY2YStzTTJV?=
 =?utf-8?B?WlBJVDFLN20rbjVJUzJmS3FzMzZBQTJDUGFZMWhOMGRJOEFIMm5ZRTZ2RW1l?=
 =?utf-8?Q?1cDNSmTO3qMrKSId3aUVnRQtr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dc0331-ec9b-433c-e6b0-08dc05461a03
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 12:36:22.4638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyGd4wnxFvTOFHgveLSGuxnTbpprX9FRYmBWqzGv9mtmjgi4+jj5LjfR5b+xufFOc7NsPlMbt0jbqDgP/Pd0tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_043629_110467_2FCB85CD 
X-CRM114-Status: GOOD (  23.45  )
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



On 25/12/2023 10:59, Sagi Grimberg wrote:
> 
>>>>>>>> @@ -1030,11 +1030,13 @@ static int nvme_rdma_setup_ctrl(struct 
>>>>>>>> nvme_rdma_ctrl *ctrl, bool new)
>>>>>>>>               ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
>>>>>>>>       }
>>>>>>>> -    if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
>>>>>>>> +    ib_max_qsize = ctrl->device->dev->attrs.max_qp_wr /
>>>>>>>> +            (NVME_RDMA_SEND_WR_FACTOR + 1);
>>>>>>>
>>>>>>> rdma_dev_max_qsize is a better name.
>>>>>>>
>>>>>>> Also, you can drop the RFC for the next submission.
>>>>>>>
>>>>>>
>>>>>> Sagi,
>>>>>> I don't feel comfortable with these patches.
>>>>>
>>>>> Well, good that you're speaking up then ;)
>>>>>
>>>>>> First I would like to understand the need for it.
>>>>>
>>>>> I assumed that he stumbled on a device that did not support the
>>>>> existing max of 128 nvme commands (which is 384 rdma wrs for the qp).
>>>>>
>>>> The situation is that I need a queue depth greater than 128.
>>>>>> Second, the QP WR can be constructed from one or more WQEs and the 
>>>>>> WQEs can be constructed from one or more WQEBBs. The max_qp_wr 
>>>>>> doesn't take it into account.
>>>>>
>>>>> Well, it is not taken into account now either with the existing magic
>>>>> limit in nvmet. The rdma limits reporting mechanism was and still is
>>>>> unusable.
>>>>>
>>>>> I would expect a device that has different size for different work
>>>>> items to report max_qp_wr accounting for the largest work element that
>>>>> the device supports, so it is universally correct.
>>>>>
>>>>> The fact that max_qp_wr means the maximum number of slots is a qp and
>>>>> at the same time different work requests can arbitrarily use any 
>>>>> number
>>>>> of slots without anyone ever knowing, makes it pretty much 
>>>>> impossible to
>>>>> use reliably.
>>>>>
>>>>> Maybe rdma device attributes need a new attribute called
>>>>> universal_max_qp_wr that is going to actually be reliable and not
>>>>> guess-work?
>>>>
>>>> I see, the max_qp_wr is not as reliable as I imagined. Is there any 
>>>> another way to get a queue depth grater than 128
>>>>
>>>> instead of changing NVME_RDMA_MAX_QUEUE_SIZE?
>>>>
>>>
>>> When I added this limit to RDMA transports it was to avoid a 
>>> situation that a QP will fail to be created if one will ask a large 
>>> queue.
>>>
>>> I choose 128 since it was supported for all the RDMA adapters I've 
>>> tested in my lab (mostly Mellanox adapters).
>>> For this queue depth we found that the performance is good enough and 
>>> it will not be improved if we will increase the depth.
>>>
>>> Are you saying that you have a device that can provide better 
>>> performance with qdepth > 128 ?
>>> What is the tested qdepth and what are the numbers you see with this 
>>> qdepth ?
>>
>> Yeah, you are right, the improvement is small(about %1~2%), I do this 
>> only for better benchmark,
> 
> Well, it doesn't come for free, you are essentially doubling the queue
> depth. I'm also assuming that you tested a single initiator and a
> single queue?
> 
>> I still consist that using the capabilities of RDMA device to 
>> determine the size of queue is a better choice, but now I change the
>>
>> NVME_RDMA_MAX_QUEUE_SIZE to 256 for bidding.
> 
> Still doesn't change the fact that its a pure guess-work if it is
> supported by the device or not.
> 
> Are you even able to create that queue depth with DIF workloads?
> 
> Max, what is the maximum effective depth with DIF enabled?

I'll need to check it.

I'll prepare some patches to allow RDMA queue_size to be 256 for non-pi 
controllers anyway.
I also would like to add another configfs entry to determine the max 
queue size of a target port.
hope to merge it for upcoming merge window.

