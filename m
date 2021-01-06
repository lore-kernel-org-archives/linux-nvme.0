Return-Path: <SRS0=xG/4=GJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7E0C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 02:30:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3B622CF8
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 02:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3B622CF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BlJa1FC6jbHYUzhXKGwaSKKYmQHELcTzN3/jVMXpZWY=; b=nA7bOvu0d2UgliXwfPHk2DYWI
	FT9vEdPj+UkHzh8HVNYmVK3skFuMN96CF7RMUe5BnjzzVWMcNplM94uDu9TGWtShzd65uvpzomV1j
	yp0CRQSu0w7652lnzZPkfK5EY6JR9jpMXnjko6BcLrPQTbuYz+UwEQL4dtPocEU/eNFskExWY9prl
	diAdEo/YRe6/q2qW4nm4kzX31dagTJs3VeluIooj1e7FYJKWOtGC681IeI9GLijdrapCJmp9eKleA
	yHtcC5gC3ixhX6R6BMNzsHVEwEPlwyA1JpTAnNRLIkAaK2EcK1pyMyyyqHX9+SPhUEwyUfg/txcv9
	JjaiMEdrQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwyaj-0007QQ-60; Wed, 06 Jan 2021 02:30:29 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwyaf-0007Pt-Ae
 for linux-nvme@lists.infradead.org; Wed, 06 Jan 2021 02:30:26 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4D9YGV0wm6z5Drq;
 Wed,  6 Jan 2021 10:29:22 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 6 Jan 2021 10:30:16 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 6 Jan
 2021 10:30:16 +0800
Subject: Re: [PATCH 1/6] blk-mq: introduce blk_mq_set_request_complete
To: Minwoo Im <minwoo.im.dev@gmail.com>
References: <20210105071936.25097-1-lengchao@huawei.com>
 <20210105071936.25097-2-lengchao@huawei.com>
 <20210105191638.GB4426@localhost.localdomain>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <e4308bf9-ac47-d765-fe9a-6852a67da5c5@huawei.com>
Date: Wed, 6 Jan 2021 10:29:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210105191638.GB4426@localhost.localdomain>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_213025_657756_B5E5924D 
X-CRM114-Status: GOOD (  13.97  )
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



On 2021/1/6 3:16, Minwoo Im wrote:
> Hello,
> 
> On 21-01-05 15:19:31, Chao Leng wrote:
>> In some scenarios, nvme need setting the state of request to
>> MQ_RQ_COMPLETE. So add an inline function blk_mq_set_request_complete.
>> For details, see the subsequent patches.
>>
>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>> ---
>>   include/linux/blk-mq.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>> index e7482e6ad3ec..cee72d31054d 100644
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -493,6 +493,11 @@ static inline int blk_mq_request_completed(struct request *rq)
>>   	return blk_mq_rq_state(rq) == MQ_RQ_COMPLETE;
>>   }
>>   
>> +static inline void blk_mq_set_request_complete(struct request *rq)
>> +{
>> +	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
>> +}
>> +
> 
> Maybe we can have this newly added helper with updating caller
> in blk_mq_complete_request_remote() also ?
There are similar optimizations for blk_mq_request_started and
blk_mq_request_completed. It may be better to optimize it by using
independent patches.
> 
> Thanks,
> .
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
