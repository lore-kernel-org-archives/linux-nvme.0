Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328B3C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 10:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QZyfTINu+A1SkJAd/1a7oJyPMPovqnMyvPFXbX0QRu0=; b=JmM9gj3AknwazGhtr1b1+XSXB1
	RCIyNPq5ZT428YZ3Xolp5TOxt3Os7CrpJazQ4LipxOIKQ6Rj/KFWuGC5qwO6nhmqzmv4pI3GgPBBN
	yuhsfML6h4BMW2YGe+tddM0++05cwfcUl9KGvDbafxpDqgBTdihg2xlOy/ZasJ9aZ+kQAS4d30w1D
	oJcd4aj71nLR4+yLOp6JzRwimw0etQRkhP9QhQyYwIn/3Zd+h2QLQR4QsAMGED527IXZ8iRPvuF7s
	8ytWBS3gCFP5ZXMBxoD7XKOlO+b5lhDA2bMuWPx08n8GHqW1/hdzkNL3K30MSsW3gR1Nz4HciXFpX
	QCs4dsuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaxFP-00AwIh-Qu; Wed, 21 Sep 2022 10:46:31 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oauxB-009t9B-VG
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 08:19:38 +0000
Received: by mail-wr1-f43.google.com with SMTP id bq9so8576542wrb.4
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 01:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QZyfTINu+A1SkJAd/1a7oJyPMPovqnMyvPFXbX0QRu0=;
        b=NBXrvtCprKOIGl9uvavumnhFsjlE4i4//4WCrd/LMZNdjBlwIc356hIvJ/h+D9GTdY
         UrRwFK4iqiA+o8Hfa5Zbf5oShUoTVyrJ1StthZgROc6iaZ3Dd22KepqOKV+rC5OYWVP4
         pnafPh+xrDmaj805EiCR8Y/ZhBvHRhoPgD+U9n1JQgIx0GEfSZAoqA7GAjN8YAv+luh4
         Qz+fhUT7IXvr4lGLZKufX0JB4FWqoYJkebZBwJVBibJzxMQdKNLFK31Hn+soV6qHbsDW
         f2hrUQvOHsXvLl4sUShpmF5CH1OT+yJSWafu2+WCx83CL+U7lwjfbRrXNFhO+paNiCxF
         J9nQ==
X-Gm-Message-State: ACrzQf04NpYyMtbuEx2yM/+m20gFLUeqpHf6h3+MNAU3jxikONVWnrzz
	wVXwyYoGC8BmRJ9u7saH/sc=
X-Google-Smtp-Source: AMsMyM5qZg9LnqGfef+lphJKJgzMVsEj93EacElYzujPPEukFU9ToCTKOxboj9CbrtHe5AIpJcXSmg==
X-Received: by 2002:a5d:457b:0:b0:22b:24d6:1a9f with SMTP id a27-20020a5d457b000000b0022b24d61a9fmr940547wrc.201.1663748363377;
        Wed, 21 Sep 2022 01:19:23 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003a5f3f5883dsm2064715wmo.17.2022.09.21.01.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 01:19:22 -0700 (PDT)
Message-ID: <8aed1d8f-3bd7-e86a-837a-b2fc6d316d8b@grimberg.me>
Date: Wed, 21 Sep 2022 11:19:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme: don't wait freeze during resetting
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Yi Zhang <yi.zhang@redhat.com>, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>
References: <20220920015719.1840164-1-ming.lei@redhat.com>
 <c04a263f-31cb-0cb8-c2f0-a3d318093b6c@grimberg.me> <YypoGKWiZBFAx6xX@T590>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YypoGKWiZBFAx6xX@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_011934_063989_D005E54E 
X-CRM114-Status: GOOD (  26.86  )
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



On 9/21/22 04:25, Ming Lei wrote:
> On Tue, Sep 20, 2022 at 11:18:33AM +0300, Sagi Grimberg wrote:
>>
>>> First it isn't necessary to call nvme_wait_freeze during reset.
>>> For nvme-pci, if tagset isn't allocated, there can't be any inflight
>>> IOs; otherwise blk_mq_update_nr_hw_queues can freeze & wait queues.
>>>
>>> Second, since commit bdd6316094e0 ("block: Allow unfreezing of a queue
>>> while requests are in progress"), it is fine to unfreeze queue without
>>> draining inflight IOs.
>>>
>>> Also both nvme-rdma and nvme-tcp's timeout handler provides forward
>>> progress if the controller state isn't LIVE, so it is fine to drop
>>> the timeout function of nvme_wait_freeze_timeout().
>>
>> The rdma/tcp should probably be split to separate patches.
>>
>>>
>>> Cc: Sagi Grimberg <sagi@grimberg.me>
>>> Cc: Chao Leng <lengchao@huawei.com>
>>> Cc: Keith Busch <kbusch@kernel.org>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    drivers/nvme/host/apple.c |  1 -
>>>    drivers/nvme/host/pci.c   |  1 -
>>>    drivers/nvme/host/rdma.c  | 13 -------------
>>>    drivers/nvme/host/tcp.c   | 13 -------------
>>>    4 files changed, 28 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
>>> index 5fc5ea196b40..9cd02b57fc85 100644
>>> --- a/drivers/nvme/host/apple.c
>>> +++ b/drivers/nvme/host/apple.c
>>> @@ -1126,7 +1126,6 @@ static void apple_nvme_reset_work(struct work_struct *work)
>>>    	anv->ctrl.queue_count = nr_io_queues + 1;
>>>    	nvme_start_queues(&anv->ctrl);
>>> -	nvme_wait_freeze(&anv->ctrl);
>>>    	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
>>>    	nvme_unfreeze(&anv->ctrl);
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index 98864b853eef..985b216907fc 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -2910,7 +2910,6 @@ static void nvme_reset_work(struct work_struct *work)
>>>    		nvme_free_tagset(dev);
>>>    	} else {
>>>    		nvme_start_queues(&dev->ctrl);
>>> -		nvme_wait_freeze(&dev->ctrl);
>>>    		if (!dev->ctrl.tagset)
>>>    			nvme_pci_alloc_tag_set(dev);
>>>    		else
>>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>>> index 3100643be299..beb0d1a6a84d 100644
>>> --- a/drivers/nvme/host/rdma.c
>>> +++ b/drivers/nvme/host/rdma.c
>>> @@ -986,15 +986,6 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>>>    	if (!new) {
>>>    		nvme_start_queues(&ctrl->ctrl);
>>> -		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
>>> -			/*
>>> -			 * If we timed out waiting for freeze we are likely to
>>> -			 * be stuck.  Fail the controller initialization just
>>> -			 * to be safe.
>>> -			 */
>>> -			ret = -ENODEV;
>>> -			goto out_wait_freeze_timed_out;
>>> -		}
>>
>> So here is the description from the patch that introduced this:
>> --
>> nvme-rdma: fix reset hang if controller died in the middle of a reset
>>
>> If the controller becomes unresponsive in the middle of a reset, we
>> will hang because we are waiting for the freeze to complete, but that
>> cannot happen since we have commands that are inflight holding the
>> q_usage_counter, and we can't blindly fail requests that times out.
>>
>> So give a timeout and if we cannot wait for queue freeze before
>> unfreezing, fail and have the error handling take care how to
>> proceed (either schedule a reconnect of remove the controller).
>> --
>>
>> So if between nvme_start_queues() and the freeze (with a full wait)
>> that is done in blk_mq_update_nr_hw_queues() the controller becomes
>> non responsive, in this case we may hang blocking on I/O that was
>> pending and requeued after nvme_start_queues().
>>
>> The problem is, that we cannot do any error recovery because the
>> controller is in the middle of a reset/reconnect...
>> So the code that you deleted was designed to detect this state, and
>> reschedule another reconnect if the controller became non responsive.
>>
>> What is preventing this from happening now?
> 
> Please see nvme_rdma_timeout() & nvme_tcp_timeout(), if controller state
> isn't live, request will be aborted.

I agree with you. However non-mpath devices will most likely retry the
command and not fail it like in the multipath case (see 
nvme_decide_disposition) and will cause the I/O to block.

While it is arguable if non-mpath fabrics devices are important in any
capacity, the design was that IO is not completed until the controller
either successfully reconnects (and retried), or it disconnects
(failed), or fast_io_fail_tmo expires.

Hence for non-mpath controllers, the request(s) will timeout, and
aborted, but nvme will opt to retry them instead of completing them
with a failure (at least until fast_io_fail_tmo expires, but that can
be arbitrarily long).

