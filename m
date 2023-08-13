Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865CCEB64DD
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 13:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=laC9Heu+PxM1xbW39+7mo/8Y5DzPUSwDc3BGUaOBbmw=; b=RzVD9lbskIX6xHQgX423f+puLH
	rITNd1zLAGx1IXFpGUAozSJBuurXWcHWt/rG9nV9Vb8h22Do5BQBWL3RCWAXKuiTrSVLLgbZhb2qt
	2GPV7rO7XInnF5znPKvhEhgoeXABg6rGueBW2UM75wlSetSPK8j6Ra6jwatm/I76104QLwTfnoLRU
	SkpVj+qRPBjxUzUOQrSrjZnFiqzSG6H0dm0oOqLDP/ZmGdivw9xN6yogF7naCsSIgnynFDsR2LXfu
	87HLM90kDs2QJa8YWUenFAkc2tBD6K5B4/nnS9JpyoMCEbr2HHjEua0/DVAXaeWtMNlCaGRqjzaV2
	LJTNKBUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVBTC-00FBCq-0v;
	Sun, 13 Aug 2023 13:49:26 +0000
Received: from mail-ej1-f54.google.com ([209.85.218.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVBT9-00FBCV-08
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 13:49:24 +0000
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-98273ae42d0so108017666b.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 06:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691934562; x=1692539362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laC9Heu+PxM1xbW39+7mo/8Y5DzPUSwDc3BGUaOBbmw=;
        b=X9whPe15wUS8xvIsbuH6z/++QYzyIwbf8BlNvNdvDXGyt8xgZqKdictOH8/xGpMH7S
         i9EOAhZb81mCEc1k8e2kawg2gMtfgO0BteP6hszEjgSD3QBGaEw4ud6fZ7YDn0hruqr5
         cjgrBa33Ys5nmUx7jPeJ/uv/iGkiV7LQWOcsznk3oqi+egY7nK+tyLSOIjfdkT6k3NKi
         nCa8MxFe70AbYXZQ3nHtpKTcJkBNv2OsnHQBK14Za316EpnDor6LrzNmZwVZiUuMW0Lq
         CpmWW4x6D2vBSEwjWDy7ymvc7Bk5Y5sqrO6q862cSNvwYR8Xw0ayrO0Dhosq4GSRAJxM
         JtDA==
X-Gm-Message-State: AOJu0YyB3idRMYWXanxa1Uc1Gotko+cO0UAUJ6zyz4YXTNtSexfDyC6g
	pq4yq9nQ/8RyhqEM4TPdYO8CNgW+XZI=
X-Google-Smtp-Source: AGHT+IF7YUIGxUwudcL7olJnfZ7dnFAbfY3wg3aeVc52XCo2hdrzB3VZvXXBiijHMtnvpjFFtlF2Yw==
X-Received: by 2002:a17:906:c1:b0:99b:c845:7917 with SMTP id 1-20020a17090600c100b0099bc8457917mr5731425eji.4.1691934561592;
        Sun, 13 Aug 2023 06:49:21 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906379300b00992b8d56f3asm4563706ejc.105.2023.08.13.06.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 06:49:20 -0700 (PDT)
Message-ID: <6711898d-915b-b799-e9dd-2b1c1ee3ec34@grimberg.me>
Date: Sun, 13 Aug 2023 16:49:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 09/26] nvme-tcp: RX DDGST offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-10-aaptel@nvidia.com>
 <2a75b296-edff-3151-7c6e-22209f09a100@grimberg.me>
 <253msyzvtph.fsf@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253msyzvtph.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_064923_085384_AC56F15A 
X-CRM114-Status: GOOD (  16.19  )
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



On 8/10/23 17:48, Aurelien Aptel wrote:
> Sagi Grimberg <sagi@grimberg.me> writes:
>> grr.. wondering if this is something we want to support (crc without
>> ddp).
> 
> We agree, we don't want to support it. We will remove it and check it
> doesn't happen in is_netdev_offload_active().
> 
>>> +     req->ddp.sg_table.sgl = req->ddp.first_sgl;
>> Why is this assignment needed? why not pass req->ddp.first_sgl ?
> 
> Correct, this assignment is not needed we will remove it.
> 
>>>    static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>>> @@ -1047,7 +1126,8 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>>>        size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>>>        int ret;
>>>
>>> -     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
>>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) ||
>>> +         test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
>>
>> This now becomes two atomic bitops to check for each capability, where
>> its more likely that neighther are on...
>>
>> Is this really racing with anything? maybe just check with bitwise AND?
>> or a local variable (or struct member)
>> I don't think that we should add any more overhead for the normal path
>> than we already have.
> 
> Are you sure test_bit() is atomic? The underlying definitions seems
> non-atomic (constant_test_bit or const_test_bit), are we missing
> anything?

Hmm, no you're right.

This makes me wonder if we have some places to convert test_bit to
test_bit_acquire where we must not make forward progress.

This particular condition is fine I think...

