Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E5DC25B08
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 10:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GS3uETP2QCuIf1x+SmwTzncgxqElF+XQyJdEpNKzueU=; b=ZqBPYoYhaQF9MVsxK44BejQ84K
	tfsgrZpIM6ZnAgVKosrN3JUi5aFS7w1yKfBiA3a4YnVmY2ofIxBG/CWe2Hch9DSEXcv9wYS0m0iIn
	HSfPdYPjywsHDY3hpXwkQAjopSwQTVw0M/6QRfY8hd2xL8sq+a3sVrCL6q29nlkgPG8VRsw23FDR9
	/3P2KuxqJc/gZvo+b3ZV8wGX35dW3CvTKyf5nwjrdeqsRvfNPQ/60Q/cD9+JBOacKH0Evx1BBzszm
	R7q+yA7IWJ1ad26uWz3DUylA2hGraT1fHRVqPWX9bsfeC25QTHilu3VUi4ONiC+PRPLn9QNHmyea8
	EBsQApqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOG6v-000XKG-WC; Wed, 17 Aug 2022 10:17:18 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOG6s-000XHk-W9
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 10:17:16 +0000
Received: by mail-wm1-f52.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so1549084wmk.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Aug 2022 03:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=GS3uETP2QCuIf1x+SmwTzncgxqElF+XQyJdEpNKzueU=;
        b=tiuZk8vh6v0erwktZZc1F9WbATZ7p6BWWn/x/pTR91ZajimbfhgoB7eenSItw3bOtU
         lxPy2rXj3OuOaxQEHYNikaK1F65E3VxXj8RmwxSl0J/zv0ihPR6iRJwM8pSqvokcZzmS
         oWJ9C7DKp9wD7HSsJ1Fos6fyF2jdbf/rf0f89Oxrfc1ydD+wZtW4Px8g9jTUXQkQaiFw
         MwQmHHBseHUZQgeU+peeXbdKbPMQochR4X9DUma/hA6tLBNbfv8h91f6goxD8tkebSij
         gAwFVG/dHdDnMSS8bRUpCrB7AgptL4Rn7hrcdaTnNHSr+B3vJR1gKqvU4XpPwq2U0/zh
         uCKQ==
X-Gm-Message-State: ACgBeo1eCxL1U6j/PvLPOXjKeQusRKMesval5Sm0Zmqgr0YkguFrpeBW
	bQslDIyYzsUr+6/+OxxfQVU=
X-Google-Smtp-Source: AA6agR4r/8L7E5SJBKbsOGDmzoR51jCKFtjjiCg+olxay5OS41P9zHGxy7p4gj0Lbqg+GMNEEbw7Rw==
X-Received: by 2002:a05:600c:4e94:b0:3a5:b7e5:9e64 with SMTP id f20-20020a05600c4e9400b003a5b7e59e64mr1668507wmq.26.1660731431711;
        Wed, 17 Aug 2022 03:17:11 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t185-20020a1c46c2000000b003a5f812635asm1623636wma.39.2022.08.17.03.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 03:17:09 -0700 (PDT)
Message-ID: <97436a8d-e7ce-0118-1b88-739539adf302@grimberg.me>
Date: Wed, 17 Aug 2022 13:17:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmet: Fix a use-after-free
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 stable@vger.kernel.org
References: <20220812210317.2252051-1-bvanassche@acm.org>
 <cd2189da-59b3-c01e-9bd3-5f838258c7bc@grimberg.me>
 <9ec2e292-1e75-8ee2-a9fc-d5adfab92fbd@acm.org>
 <3b12abd3-ba64-7811-8f1f-66dbb368cf66@grimberg.me>
In-Reply-To: <3b12abd3-ba64-7811-8f1f-66dbb368cf66@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_031715_073458_27AD7E64 
X-CRM114-Status: GOOD (  17.36  )
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


>>>> nvmet_req *req, u16 status)
>>>>       trace_nvmet_req_complete(req);
>>>> -    if (req->ns)
>>>> -        nvmet_put_namespace(req->ns);
>>>>       req->ops->queue_response(req);
>>>> +    if (ns)
>>>> +        nvmet_put_namespace(ns);
>>>
>>> Why did the put change position?
>>> I'm not exactly clear what was used-after-free here..
>>
>> Hi Sagi,
>>
>> Is my understanding correct that the NVMe target namespace owns the 
>> block device `req` is associated with and hence that the namespace 
>> reference count must only be dropped after dereferencing the `req` 
>> pointer has finished?
>>
>> This is what I found in the NVMe target code:
>> * nvmet_put_namespace() decreases ns->ref.
>> * Dropping the last ns->ref causes nvmet_destroy_namespace() to be
>>    called. That function completes ns->disable_done.
>> * nvmet_ns_disable() waits on that completion and calls
>>    nvmet_ns_dev_disable().
>> * For a block device, nvmet_ns_dev_disable() calls blkdev_put().
>> * The last blkdev_put() call calls disk_release().
>> * disk_release() calls blk_put_queue().
>> * The last blk_put_queue() call calls blk_release_queue().
>> * blk_release_queue() frees struct request_queue.
>> * blk_mq_complete_request_remote() dereferences req->q.
> 
> The analysis is correct, specifically for loop transport, but it is not
> the same request_queue...
> 
> blk_mq_complete_request_remote references the initiator block device
> created from the namespace, but nvmet_ns_dev_disable puts the backend
> blockdev, which is a separate blockdev...
> 
> Maybe I'm misunderstanding your point?

And specifically your stack trace references nvmet_execute_io_connect
which is not addressed to a namespace... This I think that the
request_queue is actually the ctrl->connect_q, which is used for
io_connect commands.

It is unclear to me how this one ended up with a use-after-free...
Maybe we have a stray io_connect command lingering after we teardown
the controller?

