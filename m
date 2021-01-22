Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32ABC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 01:47:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9C522B43
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 01:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9C522B43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EqXhLcBpOrV95FVkm2VBx/rlAk5PsZ8rAMdis9FVcIc=; b=r6P5n1p+//TX5ygUx/sDpnt10
	tiC/JE4O1N0vWWWUZVQwK3/SYe6j4tJ8Yx5l9BPZpqrCKRh/NKQQ9757PG0kuaX6jQZJW4bWjHJXi
	qMGlxbR/+R4K+przq/B2DHNlYZK5Q05fvMojOjscwHWBNxhHiyeNcYKWqrsP9LnBkfvxZUmbC37ZY
	5MjKpBA9YdM32tUR5n8Ed2Zh6rTGsOWnlDoB/KjApYcgROVQJywiou1YU6WnjwGKR8vvPyQvHTX+m
	I2ZHnWOxdHw9SReaYLbJyncC/FI3QMsecCWlpVV45LXM3FsoRxd4VwfCpElO9+wVMPOXBSGOZLIRc
	UyAPxUOvQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2lXE-0002tn-KJ; Fri, 22 Jan 2021 01:46:48 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2lXC-0002t2-EP
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 01:46:47 +0000
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DMMXj2DXmzY1f8;
 Fri, 22 Jan 2021 09:45:41 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 22 Jan 2021 09:46:42 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 22
 Jan 2021 09:46:42 +0800
Subject: Re: [PATCH v3 2/5] nvme-core: introduce complete failed request
To: Christoph Hellwig <hch@lst.de>
References: <20210121070330.19701-1-lengchao@huawei.com>
 <20210121070330.19701-3-lengchao@huawei.com> <20210121084150.GB25963@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <c833e26b-623e-47f5-2493-13cb83014905@huawei.com>
Date: Fri, 22 Jan 2021 09:46:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210121084150.GB25963@lst.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_204646_727293_CAF93155 
X-CRM114-Status: GOOD (  11.65  )
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
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/1/21 16:41, Christoph Hellwig wrote:
>> +static inline void nvme_complete_failed_req(struct request *req)
> 
> I think the name is too generic, and the function also needs a little
> comment, especially as it forces a specific error code.
Ok, thank you for your suggestion. Use error status as a parameter may
be a better choice.
> 
>> +{
>> +	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
>> +	blk_mq_set_request_complete(req);
>> +	nvme_complete_rq(req);
>> +}
> 
> Also no need to mark this as an inline function.
Yes, export the function is ok.
> .
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
