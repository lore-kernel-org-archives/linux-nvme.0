Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD767C41535
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Dec 2023 06:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wrD8OrsBMi0LOhXvYssrLbXmBorDvwPVluqXHrWUcSY=; b=b2qvpi1AOKe4ZC9qWRqKEBmpS+
	5eyfCfKX+h+bqXl78wn/AJVuMJA242YIg6F4DEyLOsCLmzX+QsygHCs4vdEk1UOLJnHMQDxzXDOBQ
	kwW7iG5Ily4VynKsO8QmDuWHDCFm3gFGy1V+KFVt5XjXGq6qJQJ/6Rnhx/zap7CBEd5PifLL56seA
	qHKt/3ZCtwE/yIGtVqRr0r7fsEN6DWdVM07pQGsF/iTmvgqtByUgQW8HJ3FhbKtFYb3F0SDtamUgB
	G7VyeiYqx5eaGdBPk5k4W+89Xu9S9yi2Oe4bJdhyt+Rv2lkOcMrK26SCTnIm+K0qEewNxQ0iqXRWN
	iOfgXurQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGZV0-0057DJ-1h;
	Fri, 22 Dec 2023 06:59:10 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGZUv-0057D0-0B
	for linux-nvme@lists.infradead.org;
	Fri, 22 Dec 2023 06:59:06 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vz-22J6_1703228339;
Received: from 30.178.84.159(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0Vz-22J6_1703228339)
          by smtp.aliyun-inc.com;
          Fri, 22 Dec 2023 14:59:01 +0800
Message-ID: <436efebd-ab7e-4b23-9be0-a316884552ca@linux.alibaba.com>
Date: Fri, 22 Dec 2023 14:58:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 2/2] nvme: rdma: use ib_device's max_qp_wr to limit
 sqsize
Content-Language: en-GB
To: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 hch@lst.de, kbusch@kernel.org, kch@nvidia.com, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
References: <1702971145-111009-1-git-send-email-kanie@linux.alibaba.com>
 <1702971145-111009-3-git-send-email-kanie@linux.alibaba.com>
 <82d16c8c-efef-41d2-b2ff-8ce8f5ac9b28@grimberg.me>
 <92b53d3b-8ee6-42b1-a078-9b51886c6003@nvidia.com>
 <77df6829-3a14-49a1-82e5-f3389ba47d86@grimberg.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <77df6829-3a14-49a1-82e5-f3389ba47d86@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_225905_255804_5DC1FDA4 
X-CRM114-Status: GOOD (  18.02  )
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


在 2023/12/21 03:27, Sagi Grimberg 写道:
>
>>>> @@ -1030,11 +1030,13 @@ static int nvme_rdma_setup_ctrl(struct 
>>>> nvme_rdma_ctrl *ctrl, bool new)
>>>>               ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
>>>>       }
>>>> -    if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
>>>> +    ib_max_qsize = ctrl->device->dev->attrs.max_qp_wr /
>>>> +            (NVME_RDMA_SEND_WR_FACTOR + 1);
>>>
>>> rdma_dev_max_qsize is a better name.
>>>
>>> Also, you can drop the RFC for the next submission.
>>>
>>
>> Sagi,
>> I don't feel comfortable with these patches.
>
> Well, good that you're speaking up then ;)
>
>> First I would like to understand the need for it.
>
> I assumed that he stumbled on a device that did not support the
> existing max of 128 nvme commands (which is 384 rdma wrs for the qp).
>
The situation is that I need a queue depth greater than 128.
>> Second, the QP WR can be constructed from one or more WQEs and the 
>> WQEs can be constructed from one or more WQEBBs. The max_qp_wr 
>> doesn't take it into account.
>
> Well, it is not taken into account now either with the existing magic
> limit in nvmet. The rdma limits reporting mechanism was and still is
> unusable.
>
> I would expect a device that has different size for different work
> items to report max_qp_wr accounting for the largest work element that
> the device supports, so it is universally correct.
>
> The fact that max_qp_wr means the maximum number of slots is a qp and
> at the same time different work requests can arbitrarily use any number
> of slots without anyone ever knowing, makes it pretty much impossible to
> use reliably.
>
> Maybe rdma device attributes need a new attribute called
> universal_max_qp_wr that is going to actually be reliable and not
> guess-work?

I see, the max_qp_wr is not as reliable as I imagined. Is there any 
another way to get a queue depth grater than 128

instead of changing NVME_RDMA_MAX_QUEUE_SIZE?


