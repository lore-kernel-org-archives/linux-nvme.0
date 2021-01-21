Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A35BC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 01:35:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8127F23884
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 01:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8127F23884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Kp9m92worOUvJGALLhKRGlVm4eaGRRVAL9iumdQ8jgo=; b=Hfi48LilRNzdncblTmP+LzAXR
	+aeuXqDn/yMjaMCMaFpTsHJEyfFAVBme2eUxL1eJiqMHnBRecpC7PEDiUcTyuJADY/SCCOvD7NTyQ
	4zXHvEs3nMena7pXAaobBeHy3iIxEp4KHgEUFIxhwxlkf9UnwVBF/8m28H+1cFaaaTWBJmPTKlDbK
	3rmgKWVbLKsx65R+A9+2gZPczKxb51Rh3tYenIOAgxFTNgvwJjfYGq6ncmB0cBI0RubrWUiHGuh1j
	20/OzCG6CwJBlvv+Hmisa0TN1DFGYu19Cw9xheu3onjnay2FxV5XOHcyzJvMsu0JrAsmxlM8MN2AS
	4+BlS9aKA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2Os2-00040N-9u; Thu, 21 Jan 2021 01:34:46 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2Ory-0003z4-BM
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 01:34:43 +0000
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DLlJ952nyzW39r;
 Thu, 21 Jan 2021 09:32:41 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 21 Jan 2021 09:34:31 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Thu, 21
 Jan 2021 09:34:30 +0800
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-5-lengchao@huawei.com>
 <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
 <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com>
 <a3404c7d-ccc8-0d55-d4a8-fc15107c90e6@grimberg.me>
 <695b6839-5333-c342-2189-d7aaeba797a7@huawei.com>
 <4ff22d33-12fa-1f70-3606-54821f314c45@grimberg.me>
 <0b5c8e31-8dc2-994a-1710-1b1be07549c9@huawei.com>
 <2ed5391c-fe43-f512-adf0-214effd5d599@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <6bfca033-8fda-4ace-c05f-285fccb070fd@huawei.com>
Date: Thu, 21 Jan 2021 09:34:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2ed5391c-fe43-f512-adf0-214effd5d599@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_203442_894837_92C9341A 
X-CRM114-Status: GOOD (  26.74  )
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
Cc: kbusch@kernel.org, axboe@fb.com, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/1/21 5:35, Sagi Grimberg wrote:
> 
> is not something we should be handling in nvme. block drivers
>>>>> should be able to fail queue_rq, and this all should live in the
>>>>> block layer.
>>>> Of course, it is also an idea to repair the block drivers directly.
>>>> However, block layer is unaware of nvme native multipathing,
>>>
>>> Nor it should be
>>>
>>>> will cause the request return error which should be avoided.
>>>
>>> Not sure I understand..
>>> requests should failover for path related errors,
>>> what queue_rq errors are expected to be failed over from your
>>> perspective?
>> Although fail over for only path related errors is the best choice, it's
>> almost impossible to achieve.
>> The probability of non-path-related errors is very low. Although these
>> errors do not require fail over retry, the cost of fail over retry
>> is complete the request with error delay a bit long time(retry several
>> times). It's not the best choice, but I think it's acceptable, because
>> HBA driver does not have path-related error codes but only general error
>> codes. It is difficult to identify whether the general error codes are
>> path-related.
> 
> If we have a SW bug or breakage that can happen occasionally, this can
> result in a constant failover rather than a simple failure. This is just
> not a good approach IMO.
> 
>>>> The scenario: use two HBAs for nvme native multipath, and then one HBA
>>>> fault,
>>>
>>> What is the specific error the driver sees?
>> The path related error code is closely related to HBA driver
>> implementation. In general it is EIO. I don't think it's a good idea to
>> assume what general error code the driver returns in the event of a path
>> error.
> 
> But assuming every error is a path error a good idea?
Of course not, according to the old code logic, assuming !ENOMEM && !EAGIAN
for HBA drivers is a path error. I think it might be reasonable.
> 
>>>> the blk_status_t of queue_rq is BLK_STS_IOERR, blk-mq will call
>>>> blk_mq_end_request to complete the request which bypass name native
>>>> multipath. We expect the request fail over to normal HBA, but the request
>>>> is directly completed with BLK_STS_IOERR.
>>>> The two scenarios can be fixed by directly completing the request in queue_rq.
>>> Well, certainly this one-shot always return 0 and complete the command
>>> with HOST_PATH error is not a good approach IMO
>> So what's the better option? Just complete the request with host path
>> error for non-ENOMEM and EAGAIN returned by the HBA driver?
> 
> Well, the correct thing to do here would be to clone the bio and
> failover if the end_io error status is BLK_STS_IOERR. That sucks
> because it adds overhead, but this proposal doesn't sit well. it
> looks wrong to me.
> 
> Alternatively, a more creative idea would be to encode the error
> status somehow in the cookie returned from submit_bio, but that
> also feels like a small(er) hack.
If HBA drivers return !ENOMEM && !EAGIAN, queue_rq Directly call
nvme_complete_rq with NVME_SC_HOST_PATH_ERROR like
nvmf_fail_nonready_command. nvme_complete_rq will decide to retry,
fail over or end the request. This may not be the best, but there seems
to be no better choice.
I will try to send the patch v2.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
