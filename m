Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CCCC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 11:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WYwAFeqLYBKSSkklslUc0pZkYbBAAiL2WVEM/FMS73I=; b=mo7z69HUB1VHNz5yTlkvhUqZKH
	TZt6lfj+NCcNa2pcLAheRJVurGkGk+wl1uvco9JuRzOyuhr+EZpNrXmTZISix0vNP9xwKJgUkDyLj
	P4+B5t2zd0Fl4OorSVirAWRN5gIBeVXe2bIYQ/ddSBtTBjhtgO0w3xBEM8W8/cb3OctqcYqI5bzWA
	Hj3VSFAw/RQGA9AC7i9DTNoqB0dqRYNyFsGiXCBkz6VQ3mUSPR+5gOAonTxjSDejeMZbhyMeeGCWS
	vDuh/5d7O5tP/+y45mzN9SB/VWFhf9DIgLtqRQb8hUShBifkHwseAsQ0iTOuZ/9bR4156eTN0x9oZ
	Mp5xUjqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiZg4-007oC9-5o; Wed, 12 Oct 2022 11:13:32 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiZfx-007o69-VI
	for linux-nvme@lists.infradead.org; Wed, 12 Oct 2022 11:13:27 +0000
Received: by mail-wr1-f49.google.com with SMTP id r13so25704642wrj.11
        for <linux-nvme@lists.infradead.org>; Wed, 12 Oct 2022 04:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYwAFeqLYBKSSkklslUc0pZkYbBAAiL2WVEM/FMS73I=;
        b=Sah07pTIorl4RFXjn450RbJCVAWj7bJJ6es72WLQECqqZeGqg89G2QyPPE4LNWs0n7
         x5E3L8duqjnJxmRIvllp5ME/emo523/vL4CMg+P/3DrUjDF+5GkHEVIow36cmnjq20OE
         8quBAhEvFzT/9e4RFQDJoolgmPzVl8nB1Su7SdCwK52AITvkXW55A2b30bVQNmzoBX6w
         6t4D3JmTevCupFjtXDhh9XgWqlzuAiQSLsd5b4NYM5sBwHL70WpCxRO/okmnjY9mD4SL
         UKtKnkdbSARgzSe2V0tWhShn+1i16If3OVd+WjR6DLYDXP8ltj9PAOy83OTGV4gJC665
         rM4Q==
X-Gm-Message-State: ACrzQf3OZxKZH0bh717EBmNNInfPOFJ+OL04UD5xTFbK4JiSBE69goRM
	0letNHu6hJ0ct+ixxvPvRh8=
X-Google-Smtp-Source: AMsMyM6gYolkmlmkcNvJqQug5jnk8hs+QgSR5b9WwZPW3HSqCwyqP+BcFHysKcfqRfn9jnG6mHi0UA==
X-Received: by 2002:a05:6000:1244:b0:22e:4d39:a0e3 with SMTP id j4-20020a056000124400b0022e4d39a0e3mr17093808wrx.509.1665573189292;
        Wed, 12 Oct 2022 04:13:09 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b003c6b874a0dfsm1877110wms.14.2022.10.12.04.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 04:13:08 -0700 (PDT)
Message-ID: <a44292df-ce46-828a-91a6-aa7377aa23f7@grimberg.me>
Date: Wed, 12 Oct 2022 14:13:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk
References: <20220729073948.32696-1-lengchao@huawei.com>
 <20220729142605.GA395@lst.de>
 <1b3d753a-6ff5-bdf1-8c91-4b4760ea1736@huawei.com>
 <fc7a303f-0921-f784-a559-f03511f2e4be@grimberg.me>
 <20220802133815.GA380@lst.de>
 <537c24ba-e984-811e-9e51-ecbc2af9895d@huawei.com>
 <5fc61f6c-3d3e-ce0e-a090-aa5bcdb7721c@grimberg.me>
 <f9fce880-4714-3cdb-dfd1-f1d77d033d7a@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f9fce880-4714-3cdb-dfd1-f1d77d033d7a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_041326_034917_A487993A 
X-CRM114-Status: GOOD (  29.28  )
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



On 10/12/22 11:43, Chao Leng wrote:
> Add Ming Lei.
> 
> On 2022/10/12 14:37, Sagi Grimberg wrote:
>>
>>>> On Sun, Jul 31, 2022 at 01:23:36PM +0300, Sagi Grimberg wrote:
>>>>> But maybe we can avoid that, and because we allocate
>>>>> the connect_q ourselves, and fully know that it should
>>>>> not be apart of the tagset quiesce, perhaps we can introduce
>>>>> a new interface like:
>>>>> -- 
>>>>> static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
>>>>> {
>>>>>     ctrl->connect_q = blk_mq_init_queue_self_quiesce(ctrl->tagset);
>>>>>     if (IS_ERR(ctrl->connect_q))
>>>>>         return PTR_ERR(ctrl->connect_q);
>>>>>     return 0;
>>>>> }
>>>>> -- 
>>>>>
>>>>> And then blk_mq_quiesce_tagset can simply look into a per 
>>>>> request-queue
>>>>> self_quiesce flag and skip as needed.
>>>>
>>>> I'd just make that a queue flag set after allocation to keep the
>>>> interface simple, but otherwise this seems like the right thing
>>>> to do.
>>> Now the code used NVME_NS_STOPPED to avoid unpaired stop/start.
>>> If we use blk_mq_quiesce_tagset, It will cause the above mechanism to 
>>> fail.
>>> I review the code, only pci can not ensure secure stop/start pairing.
>>> So there is a choice, We only use blk_mq_quiesce_tagset on fabrics, 
>>> not PCI.
>>> Do you think that's acceptable?
>>> If that's acceptable, I will try to send a patch set.
>>
>> I don't think that this is acceptable. But I don't understand how
>> NVME_NS_STOPPED would change anything in the behavior of tagset-wide
>> quiesce?
> If use blk_mq_quiesce_tagset, it will quiesce all queues of all ns,
> but can not set NVME_NS_STOPPED of all ns. The mechanism of NVME_NS_STOPPED
> will be invalidated.
> NVMe-pci has very complicated quiesce/unquiesce use pattern, 
> quiesce/unquiesce
> may be called unpaired.
> It will cause some backward. There may be some bugs in this scenario:
> A thread: quiesce the queue
> B thread: quiesce the queue
> A thread end, and does not unquiesce the queue.
> B thread: unquiesce the queue, and do something which need the queue 
> must be unquiesed.
> 
> Of course, I don't think it is a good choice to guarantee paired access 
> through NVME_NS_STOPPED,
> there exist unexpected unquiesce and start queue too early.
> But now that the code has done so, the backward should be unacceptable.
> such as this scenario:
> A thread: quiesce the queue
> B thread: want to quiesce the queue but do nothing because 
> NVME_NS_STOPPED is already set.
> A thread: unquiesce the queue
> Now the queue is unquiesced too early for B thread.
> B thread: do something which need the queue must be quiesced.
> 
> Introduce NVME_NS_STOPPED link:
> https://lore.kernel.org/all/20211014081710.1871747-5-ming.lei@redhat.com/

I think we can just change a ns flag to a controller flag ala:
NVME_CTRL_STOPPED, and then do:

void nvme_stop_queues(struct nvme_ctrl *ctrl)
{
	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ns->flags))
		blk_mq_quiesce_tagset(ctrl->tagset);
}
EXPORT_SYMBOL_GPL(nvme_stop_queues);

void nvme_start_queues(struct nvme_ctrl *ctrl)
{
	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ns->flags))
		blk_mq_unquiesce_tagset(ctrl->tagset);
}
EXPORT_SYMBOL_GPL(nvme_start_queues);

Won't that achieve the same result?

