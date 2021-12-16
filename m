Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B210DC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dba4ER9Iz3q4FpOIWKRG/reKhlXSVW+3EI6wzSuW4/w=; b=xVV2dCpYwo3vcCtdVpCWAtu9OG
	2ppkuv9CkQ9xUxd7qdIahOJZFlwT4UAya1rrHCWC53sqy84B2eBqA2tVB4yCb0CbM+mT9aI9lvlQk
	dh10qkEgroPk366qV+tyc0D87Vaz/aDEuzAQ1LCiQj5KQ1VdUoEJEDgdn8ZGwTMDXSanHDoMy0FmK
	wbk/Lm7yUWglYlXet2ZA0590HVTCAgJ+ZAr75/VGNYSMV7uZCqXY6IeymMiKR5lACX64v/2pDKJ9Y
	ZhDB8hwz8VIAL/s3MxV4BPhL5DhTantJmVzJAsCdHKqv05i1/VCLkBjwAWNVM4/NSk9EqfArQsEeu
	ph2BAy9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxtM3-006VzC-Gu; Thu, 16 Dec 2021 16:11:39 +0000
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com
 ([40.107.223.54] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtGu-006ThA-GN
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaDkknjzELcJWQ3LNz4DcfIS/X4sZKGfYwzO0huJ44S4dBG349baVJXAUC5do+XokoP8ym4nkEaZQslME6CsbTaGZtTPBYd+/TpxmRKKomhifwLYJ0qjFKs2IZTzX8XQ3PPDMDrSJdxwUTb0739VsN3GoDoxINR0ZzmDYnUuY0Lr+uUDKPGa3Uomu9HXSBZrYIXX7CMyJaFlRMijCgjBWeAAshVTrNkWfmdKCP5ocmpRIZIWxKHfUg8zMRhFw3V+uGUs60/xlT3kxfniye2zMD/joRGREH+nqdHMlDU1aQ/woCF6TUAB+1PPPSgrVhU/Ld+tvX0PREPdvBc/VfKt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dba4ER9Iz3q4FpOIWKRG/reKhlXSVW+3EI6wzSuW4/w=;
 b=YyQ4Sy8qpBRz/TGzjtjZ2pfcnAkH6fqY2WnDdc/lgF+COaXqPquuwnAuPKQJFIxX4I6SnK2O79j2Ze51qsHq56UG1DTwSlDmDvK8IcTqVry7fYpmHjhRUY44FjB5P7IneXPgMFMLaxzeuizk3ajzsbuCk/8jC3BS5BzSQdP3pgLNBF3cyOZvwBsnVNvWIq2aQNmyLdqRSOXG1rzjQq97Lq+tuQSXl4exUOJZlE20+CXwgpLBALriy3mZ1/36zcW5Y1Z2eDB09efppPkxDHTewc0LZg6xAbIlEA5UB3QjKBRejEWv1SVlmGVXi6wvW3qLjAafDZITWqO2/+ETD9WPYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dba4ER9Iz3q4FpOIWKRG/reKhlXSVW+3EI6wzSuW4/w=;
 b=I9ntCUl+Qk7QYFjDtlbXlNTDvjjTiII2aXAK9xeumBtenFAiXj8c6kZ7uR4YVYB/kUsAdGvUqjp+G5ShLe+iGbLowipCB2CUDwqyv10hGd7f9twqrCgNd6kex4ksYj1E0Ml5dO/q7QPLcKe0K8EXRI1AlbC1a5PMSQTEiFlFHl/0JIswK0t7wq2YDxYAMs4G7B/Oc6xV7/TaUdyaTm/s5grrh/Hg7S3masUs3Zyd73ODQCER6T6HSueaMMUEqI26G8Gby2Zy9ZSO47A2MzbbxlZR41HMlZAzEhO6KE9T+Zu3x8IbM5GgClhBsyEepgQc3nNSDG94Lw1Tmo4touLoCA==
Received: from BN0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:e6::24)
 by BN9PR12MB5307.namprd12.prod.outlook.com (2603:10b6:408:104::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Thu, 16 Dec
 2021 16:06:17 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::ea) by BN0PR03CA0019.outlook.office365.com
 (2603:10b6:408:e6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Thu, 16 Dec 2021 16:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 16:06:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 16 Dec 2021 16:06:12 +0000
Received: from [172.27.15.177] (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 16 Dec 2021
 08:06:10 -0800
Message-ID: <adc77577-5c94-fb06-a4e4-afbddd2a7b57@nvidia.com>
Date: Thu, 16 Dec 2021 18:06:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, <io-uring@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-5-axboe@kernel.dk>
 <0c131172-54cf-29f9-8fc6-53582ad50402@nvidia.com>
 <e2828b33-65c8-e881-e802-b5431aabc6ac@kernel.dk>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <e2828b33-65c8-e881-e802-b5431aabc6ac@kernel.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: feb7e2b2-d150-409b-e9ad-08d9c0adfdd7
X-MS-TrafficTypeDiagnostic: BN9PR12MB5307:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5307070F60CB9E502E7E871CDE779@BN9PR12MB5307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6vEd3/R4JyQ6X/nWRjX6OSjEvCDpFKpDMK+HAYcK1ewYKD+TAK8qR6RfHCtve+3b5WweT885BJTpfXRw8ncJquNWba0VhYnFHikAHiMPlCc4tJhJd08lBzFBcTd/FmDAUuOex1HtuHer+LoxTLOteO59YJXlsjovAln6nii5FS/zbodAmPcSXM7amdpbX5oeWQOe5qSWuQelhNJRywfpRG+yd3RIEhv63PTok6WaYoRaYWYsYrQVFjhbHtrYA5YSxF0W842nvlGzvsWw3PhFFJPUgUic7ac9UlAVwuX0B4XPOdIrf687NnnoeoOCvnc8UZvb5+E3LiJpZee0do0+U+2QJ2RCQHYUyFwVWo8RgJ7KmVkNThfHtbnmejGp4db+w8KB+C7kzza9Lpch9s47iXWv+qjX9OOWw8RKBQYrSWocSzUaz0WnC4LMHAfPtAHTrG87+xI6objwDfZj4DCmz2GdUrjqv3dI0APp2M44fyk9+yjUnl9HTxQjb08Ii2UQVLk7GTWdbU4o+2+WRGj6JmPwCvYljpVti+UTjNCcZdXY392mA96Omq77uYV9aHXuhR9SQ5EMPMxyD6kqwLyhAb6AZjVgA7gFoDBZZIfH+wCkofrHnbqx+lVXqFSkfH5e4/WK8MUfXWe2qAe41V2b5Z1W0HLTFN5daoT/exV+t83n4aJUz7nzZxJJtoXLkGhZ7YaqWjJXTv4reW9/3xwPJm0xnHcarQpBRr5mh69ijsnUA+GTucsW9fsc/hwKsmhFE8trMFVdJrj6hTgnsubbUvEcJTdBpUh6F25U+2xQRe6fFGofXnHn3ZDA47+VSeGB0yGEy6G4FwaQJkpxR7zKNfZO4fNdX4cMZmbpiHeWnpt+cx8B5MNu/zHoLEyjSue1WB8hZ/sAdki4iYFR7OypA==
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(2906002)(336012)(4326008)(8936002)(110136005)(26005)(36756003)(16576012)(70586007)(47076005)(508600001)(316002)(6666004)(8676002)(2616005)(426003)(31686004)(53546011)(82310400004)(40460700001)(70206006)(356005)(81166007)(36860700001)(5660300002)(34020700004)(31696002)(16526019)(83380400001)(186003)(86362001)(219204002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 16:06:16.8649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feb7e2b2-d150-409b-e9ad-08d9c0adfdd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5307
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_080620_611011_3EE61777 
X-CRM114-Status: GOOD (  16.63  )
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


On 12/16/2021 5:59 PM, Jens Axboe wrote:
> On 12/16/21 6:02 AM, Max Gurtovoy wrote:
>> On 12/15/2021 6:24 PM, Jens Axboe wrote:
>>> This enables the block layer to send us a full plug list of requests
>>> that need submitting. The block layer guarantees that they all belong
>>> to the same queue, but we do have to check the hardware queue mapping
>>> for each request.
>>>
>>> If errors are encountered, leave them in the passed in list. Then the
>>> block layer will handle them individually.
>>>
>>> This is good for about a 4% improvement in peak performance, taking us
>>> from 9.6M to 10M IOPS/core.
>>>
>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> ---
>>>    drivers/nvme/host/pci.c | 61 +++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 61 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index 6be6b1ab4285..197aa45ef7ef 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -981,6 +981,66 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>    	return BLK_STS_OK;
>>>    }
>>>    
>>> +static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct request **rqlist)
>>> +{
>>> +	spin_lock(&nvmeq->sq_lock);
>>> +	while (!rq_list_empty(*rqlist)) {
>>> +		struct request *req = rq_list_pop(rqlist);
>>> +		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>>> +
>>> +		memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
>>> +				absolute_pointer(&iod->cmd), sizeof(iod->cmd));
>>> +		if (++nvmeq->sq_tail == nvmeq->q_depth)
>>> +			nvmeq->sq_tail = 0;
>>> +	}
>>> +	nvme_write_sq_db(nvmeq, true);
>>> +	spin_unlock(&nvmeq->sq_lock);
>>> +}
>>> +
>>> +static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
>>> +{
>>> +	/*
>>> +	 * We should not need to do this, but we're still using this to
>>> +	 * ensure we can drain requests on a dying queue.
>>> +	 */
>>> +	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
>>> +		return false;
>>> +	if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
>>> +		return false;
>>> +
>>> +	req->mq_hctx->tags->rqs[req->tag] = req;
>>> +	return nvme_prep_rq(nvmeq->dev, req) == BLK_STS_OK;
>>> +}
>>> +
>>> +static void nvme_queue_rqs(struct request **rqlist)
>>> +{
>>> +	struct request *req = rq_list_peek(rqlist), *prev = NULL;
>>> +	struct request *requeue_list = NULL;
>>> +
>>> +	do {
>>> +		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
>>> +
>>> +		if (!nvme_prep_rq_batch(nvmeq, req)) {
>>> +			/* detach 'req' and add to remainder list */
>>> +			if (prev)
>>> +				prev->rq_next = req->rq_next;
>>> +			rq_list_add(&requeue_list, req);
>>> +		} else {
>>> +			prev = req;
>>> +		}
>>> +
>>> +		req = rq_list_next(req);
>>> +		if (!req || (prev && req->mq_hctx != prev->mq_hctx)) {
>>> +			/* detach rest of list, and submit */
>>> +			prev->rq_next = NULL;
>> if req == NULL and prev == NULL we'll get a NULL deref here.
>>
>> I think this can happen in the first iteration.
>>
>> Correct me if I'm wrong..
> First iteration we know the list isn't empty, so req can't be NULL
> there.

but you set "req = rq_list_next(req);"

So can't req be NULL ? after the above line ?

>

