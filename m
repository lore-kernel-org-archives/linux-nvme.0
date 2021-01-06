Return-Path: <SRS0=xG/4=GJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9AFC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 02:32:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B55722CF8
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 02:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B55722CF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GqagMcblJbdNQ+EYecKOoYGtzIjR+w6zYqRfoYvenqU=; b=lNUmctuD7Zs7n+t+/hW5FfmTi
	IMk8ubyBGUs5t/5fMzFtWVfGDBr+5M9D4sR4/opZID4qhIu7ZROuwnFl8fLV/DC5n8I30YDgaG6wd
	JM4kYqIDC7HRnlPuGj1EBWRdo3KwIdgSTC+TtQYXjE2X8KKSxidMwlMMP5QpIly3kqzC+zj8ewYIb
	gN4pQwMcEPlDp76dt/E3voVz2F8wRbie5dwuuS8bIDUpCwgCYAC1Cg5CmtPMZjXsy0NyFBrkiZzJH
	nAPwe4L4B1Bu1LFVIGTJYxjEzScIHpyZznzfjzOagpHaM9LSmGeV6vZ8ruJLq3tfMCgD5jQLFGQtO
	7Aj6ZC4PA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwycN-0007bn-Eb; Wed, 06 Jan 2021 02:32:11 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwycL-0007b6-49
 for linux-nvme@lists.infradead.org; Wed, 06 Jan 2021 02:32:10 +0000
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4D9YJf3vzWzXpks;
 Wed,  6 Jan 2021 10:31:14 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 6 Jan 2021 10:32:03 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 6 Jan
 2021 10:32:02 +0800
Subject: Re: [PATCH 2/6] nvme-core: introduce complete failed request
To: Minwoo Im <minwoo.im.dev@gmail.com>
References: <20210105071936.25097-1-lengchao@huawei.com>
 <20210105071936.25097-3-lengchao@huawei.com>
 <20210105191154.GA4426@localhost.localdomain>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <9f760de9-fc05-a831-9258-cdf15d9ecf90@huawei.com>
Date: Wed, 6 Jan 2021 10:31:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210105191154.GA4426@localhost.localdomain>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_213209_430686_4DF17A37 
X-CRM114-Status: GOOD (  19.97  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/1/6 3:11, Minwoo Im wrote:
> Hello,
> 
> On 21-01-05 15:19:32, Chao Leng wrote:
>> When a request is queued failed, if the fail status is not
>> BLK_STS_RESOURCE, BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE,
>> the request is need to complete with nvme_complete_rq in queue_rq.
>> So introduce nvme_try_complete_failed_req.
>> The request is needed to complete with NVME_SC_HOST_PATH_ERROR in
>> nvmf_fail_nonready_command and queue_rq.
>> So introduce nvme_complete_failed_req.
>> For details, see the subsequent patches.
>>
>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>> ---
>>   drivers/nvme/host/nvme.h | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index bfcedfa4b057..1a0bddb9158f 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -649,6 +649,24 @@ void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
>>   extern const struct attribute_group *nvme_ns_id_attr_groups[];
>>   extern const struct block_device_operations nvme_ns_head_ops;
>>   
>> +static inline void nvme_complete_failed_req(struct request *req)
>> +{
>> +	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
>> +	blk_mq_set_request_complete(req);
>> +	nvme_complete_rq(req);
>> +}
>> +
>> +static inline blk_status_t nvme_try_complete_failed_req(struct request *req,
>> +							blk_status_t ret)
>> +{
>> +	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE ||
>> +	    ret == BLK_STS_ZONE_RESOURCE)
>> +		return ret;
> 
> If it has nothing to do with various conditions, can we have this if
> to switch just like the other function in the same file does:
ok.
> 
> 	switch (ret) {
> 	case BLK_STS_RESOURCE:
> 	case BLK_STS_DEV_RESOURCE:
> 	case BLK_STS_ZONE_RESOURCE:
> 		return ret;
> 	default:
> 		nvme_complete_failed_req(req);
> 		return BLK_STS_OK;
> 	}
> 
>> +
>> +	nvme_complete_failed_req(req);
>> +	return BLK_STS_OK;
>> +}
>> +
> 
> Can we have these two functions along side with nvme_try_complete_req()
> by moving declaration of nvme_coplete_rq() a little bit up ?
This may cause the function declaration disordered.
> 
>>   #ifdef CONFIG_NVME_MULTIPATH
>>   static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
>>   {
>> -- 
>> 2.16.4
>>
> 
> Thanks,
> .
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
