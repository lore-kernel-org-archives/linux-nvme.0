Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B266C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 08:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uwkrVUVST4c/y9ZIdet7GZ+SQrAR1VKrFPoR5bnNGXs=; b=AdWuf4F3lz+ole87E+Vg1ewgnp
	NeX2UPv1QRk9dJLEsmeBceFe/NhqzpxRrMF8rw3vVMbt7ey0wWypW6l5ep1KbkSFy06xksw8QtiP6
	OFBJYRRt0x7XuCpHJwewrsPPVE+MT/2tybVrI55POlni2DwDeT9rUxdojPWs3O63z220hhu+EtFSv
	XWOtswhIdCTeni5SL1wzBQYYAbKCuXmyMROPD0Nt87mFHBcSIYho+ogpPDjnjE7IN282oBi5rWavV
	lp9gzmthZhbiPnjo7yc6dcYVf+Qsg2GsR8J9RUD0pXmlj/KFvSBPslcIZyyRHf2/q6/71UnHakMm/
	t6NNosqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHgo7-00AQkz-2a;
	Mon, 25 Dec 2023 08:59:31 +0000
Received: from mail-lj1-f177.google.com ([209.85.208.177])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHgo5-00AQkf-0z
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 08:59:30 +0000
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ccc1a757e5so1900001fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 25 Dec 2023 00:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703494767; x=1704099567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwkrVUVST4c/y9ZIdet7GZ+SQrAR1VKrFPoR5bnNGXs=;
        b=K04z0kZUnWUCuGzk6i9vhkykxbRbAgruRFHJx4f+6/DAn0XsJH2c/malQMiEwqEEOM
         jbTuUMw0+tTq+8/xRRRgtGA+03Lw8oD7IYvIRWZUn/WrzrM5nevOK9y20GqMe2dykxx4
         Sdlz0h4R9syuF63/mB4H96SAaeEkvGdAhOj2J3EJnFxf86FzJq1i2cRxcplpBeKbeqnn
         SmujmsPdB62YHTKVarTfZIOLI4l4xwaQdVGdHCsEFZVwvpl0+YnFaZ46LzuWTNfMkdfj
         dvbMR+2xiEweqCbbdGHzdj9X5CZTJdVFrErEBa7XcXFVG3yoOfycbaINK2hABB5AnxCA
         3dIA==
X-Gm-Message-State: AOJu0YzxAdusPka9svIgqp0OrH0bYUPgO90rjD1Cgmi7UDv/t9Lg5YqK
	ykmczkMYrK82aVOCF6DceKI=
X-Google-Smtp-Source: AGHT+IEFzMY4+OkJHWZFqCcmIwRGOWDGTPh73iCkRQQcHSBZXzzizi5kDdRadT9+nOCo/T59OU6Wew==
X-Received: by 2002:a05:6512:3c98:b0:50e:76a4:f593 with SMTP id h24-20020a0565123c9800b0050e76a4f593mr2067795lfv.5.1703494766659;
        Mon, 25 Dec 2023 00:59:26 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u4-20020a05600c138400b0040c03c3289bsm16680191wmf.37.2023.12.25.00.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 00:59:26 -0800 (PST)
Message-ID: <51a09c6d-d4b5-4edf-814c-08bc95640a2b@grimberg.me>
Date: Mon, 25 Dec 2023 10:59:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 2/2] nvme: rdma: use ib_device's max_qp_wr to limit
 sqsize
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, Max Gurtovoy
 <mgurtovoy@nvidia.com>, hch@lst.de, kbusch@kernel.org, kch@nvidia.com,
 axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
References: <1702971145-111009-1-git-send-email-kanie@linux.alibaba.com>
 <1702971145-111009-3-git-send-email-kanie@linux.alibaba.com>
 <82d16c8c-efef-41d2-b2ff-8ce8f5ac9b28@grimberg.me>
 <92b53d3b-8ee6-42b1-a078-9b51886c6003@nvidia.com>
 <77df6829-3a14-49a1-82e5-f3389ba47d86@grimberg.me>
 <436efebd-ab7e-4b23-9be0-a316884552ca@linux.alibaba.com>
 <d5c0a0d8-f67b-49de-bb25-a64c53be5345@nvidia.com>
 <91dd2cb9-29ec-4727-818e-822cea788401@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <91dd2cb9-29ec-4727-818e-822cea788401@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_005929_349881_E81D00C7 
X-CRM114-Status: GOOD (  21.65  )
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


>>>>>>> @@ -1030,11 +1030,13 @@ static int nvme_rdma_setup_ctrl(struct 
>>>>>>> nvme_rdma_ctrl *ctrl, bool new)
>>>>>>>               ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
>>>>>>>       }
>>>>>>> -    if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
>>>>>>> +    ib_max_qsize = ctrl->device->dev->attrs.max_qp_wr /
>>>>>>> +            (NVME_RDMA_SEND_WR_FACTOR + 1);
>>>>>>
>>>>>> rdma_dev_max_qsize is a better name.
>>>>>>
>>>>>> Also, you can drop the RFC for the next submission.
>>>>>>
>>>>>
>>>>> Sagi,
>>>>> I don't feel comfortable with these patches.
>>>>
>>>> Well, good that you're speaking up then ;)
>>>>
>>>>> First I would like to understand the need for it.
>>>>
>>>> I assumed that he stumbled on a device that did not support the
>>>> existing max of 128 nvme commands (which is 384 rdma wrs for the qp).
>>>>
>>> The situation is that I need a queue depth greater than 128.
>>>>> Second, the QP WR can be constructed from one or more WQEs and the 
>>>>> WQEs can be constructed from one or more WQEBBs. The max_qp_wr 
>>>>> doesn't take it into account.
>>>>
>>>> Well, it is not taken into account now either with the existing magic
>>>> limit in nvmet. The rdma limits reporting mechanism was and still is
>>>> unusable.
>>>>
>>>> I would expect a device that has different size for different work
>>>> items to report max_qp_wr accounting for the largest work element that
>>>> the device supports, so it is universally correct.
>>>>
>>>> The fact that max_qp_wr means the maximum number of slots is a qp and
>>>> at the same time different work requests can arbitrarily use any number
>>>> of slots without anyone ever knowing, makes it pretty much 
>>>> impossible to
>>>> use reliably.
>>>>
>>>> Maybe rdma device attributes need a new attribute called
>>>> universal_max_qp_wr that is going to actually be reliable and not
>>>> guess-work?
>>>
>>> I see, the max_qp_wr is not as reliable as I imagined. Is there any 
>>> another way to get a queue depth grater than 128
>>>
>>> instead of changing NVME_RDMA_MAX_QUEUE_SIZE?
>>>
>>
>> When I added this limit to RDMA transports it was to avoid a situation 
>> that a QP will fail to be created if one will ask a large queue.
>>
>> I choose 128 since it was supported for all the RDMA adapters I've 
>> tested in my lab (mostly Mellanox adapters).
>> For this queue depth we found that the performance is good enough and 
>> it will not be improved if we will increase the depth.
>>
>> Are you saying that you have a device that can provide better 
>> performance with qdepth > 128 ?
>> What is the tested qdepth and what are the numbers you see with this 
>> qdepth ?
> 
> Yeah, you are right, the improvement is small(about %1~2%), I do this 
> only for better benchmark,

Well, it doesn't come for free, you are essentially doubling the queue
depth. I'm also assuming that you tested a single initiator and a
single queue?

> I still consist that using the capabilities of RDMA device to determine 
> the size of queue is a better choice, but now I change the
> 
> NVME_RDMA_MAX_QUEUE_SIZE to 256 for bidding.

Still doesn't change the fact that its a pure guess-work if it is
supported by the device or not.

Are you even able to create that queue depth with DIF workloads?

Max, what is the maximum effective depth with DIF enabled?

