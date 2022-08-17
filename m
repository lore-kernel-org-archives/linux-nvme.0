Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BFCC25B08
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 10:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=flCOnruedLv/caOc0xS1W4+CLvteqbYSWbjqjDLk1pw=; b=AzcBdImrYq0jfu7ChcJ8x3SgP6
	ZPLPVHt6mSbvnGcoS+hqKlMhYutsJOkD16tvTEqRaV1WAoK2skHFOF2GM+DP/uNcpQyWrVLYtnBVt
	XD9qtTNC2pGmm1T3hUBU3Tu2gK5Altc8nFFTCtZ62C2Z7VbiDeuQsmCCVMKVgyLJIBFduPBc2kJrM
	NzUhmwSBtnbL9ABVxCB+vnb44ngF8gje2MsCvF906t0TlE25F8ervBnACIwh2KXV8uA8KAEf2WSvS
	o5DSRDNLaOexn2/NeQsIV19aagaPCtyaaNHdJOlX4JayvfsXDIL/S7PluRyCUYLT+5gRFjS0g1T20
	aUBRqTCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOFzX-000QDS-P1; Wed, 17 Aug 2022 10:09:39 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOFzU-000Q7c-T5
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 10:09:38 +0000
Received: by mail-wr1-f41.google.com with SMTP id n7so4428599wrv.4
        for <linux-nvme@lists.infradead.org>; Wed, 17 Aug 2022 03:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=flCOnruedLv/caOc0xS1W4+CLvteqbYSWbjqjDLk1pw=;
        b=eI8Z0E5o1aJwDtEV1HPqN/otvYLq8AoGeO3NRLGItzoEfD7lbGnYvk7x+7jHL2+quS
         ClDmvc7CLPKJwy3ctylgH8ILTfg0AHWu+gOEJulE+C6z2yY1rkoIJ6+ycVRBA4EKXNpO
         RX/+UNcD0I2knE4JRxHpyh4+Sr/M9ggTajZqW87KOHlCIYKOJzTPe++XOx4IEGqqpww/
         TsgQSio3J/KunvsvPlGd/MGo1yGdxuV+U9G1XPTfjPxoUbb6ZiBY8xskBUvs90e+y/7W
         5rEm9i4AHf9WX7JfKMm+d1WsA/L2jYD6lHS7eQ4t6ZdFJbzph6W6jCkBj9rWY6HrfvxH
         b+aQ==
X-Gm-Message-State: ACgBeo17/uNWiwtUtzb8F3lBByFQossmExBDBg0hphr9UF/YtEHLz26e
	48l6iyByboPWtWRpeXCyQGY=
X-Google-Smtp-Source: AA6agR5v7tQeU6EUN3CIVkxj/oIkGbYDtgmcYWMPYvXVZRSVD+BKHKjDLX4ksJ0jRB15bSLY34yrFg==
X-Received: by 2002:a5d:6501:0:b0:220:5f19:de73 with SMTP id x1-20020a5d6501000000b002205f19de73mr14033363wru.713.1660730975113;
        Wed, 17 Aug 2022 03:09:35 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s3-20020a5d69c3000000b00225232154d7sm1766323wrw.110.2022.08.17.03.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 03:09:33 -0700 (PDT)
Message-ID: <3b12abd3-ba64-7811-8f1f-66dbb368cf66@grimberg.me>
Date: Wed, 17 Aug 2022 13:09:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmet: Fix a use-after-free
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 stable@vger.kernel.org
References: <20220812210317.2252051-1-bvanassche@acm.org>
 <cd2189da-59b3-c01e-9bd3-5f838258c7bc@grimberg.me>
 <9ec2e292-1e75-8ee2-a9fc-d5adfab92fbd@acm.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9ec2e292-1e75-8ee2-a9fc-d5adfab92fbd@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_030937_001282_C82448C5 
X-CRM114-Status: GOOD (  16.94  )
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


>>> @@ -745,9 +747,9 @@ static void __nvmet_req_complete(struct nvmet_req 
>>> *req, u16 status)
>>>       trace_nvmet_req_complete(req);
>>> -    if (req->ns)
>>> -        nvmet_put_namespace(req->ns);
>>>       req->ops->queue_response(req);
>>> +    if (ns)
>>> +        nvmet_put_namespace(ns);
>>
>> Why did the put change position?
>> I'm not exactly clear what was used-after-free here..
> 
> Hi Sagi,
> 
> Is my understanding correct that the NVMe target namespace owns the 
> block device `req` is associated with and hence that the namespace 
> reference count must only be dropped after dereferencing the `req` 
> pointer has finished?
> 
> This is what I found in the NVMe target code:
> * nvmet_put_namespace() decreases ns->ref.
> * Dropping the last ns->ref causes nvmet_destroy_namespace() to be
>    called. That function completes ns->disable_done.
> * nvmet_ns_disable() waits on that completion and calls
>    nvmet_ns_dev_disable().
> * For a block device, nvmet_ns_dev_disable() calls blkdev_put().
> * The last blkdev_put() call calls disk_release().
> * disk_release() calls blk_put_queue().
> * The last blk_put_queue() call calls blk_release_queue().
> * blk_release_queue() frees struct request_queue.
> * blk_mq_complete_request_remote() dereferences req->q.

The analysis is correct, specifically for loop transport, but it is not
the same request_queue...

blk_mq_complete_request_remote references the initiator block device
created from the namespace, but nvmet_ns_dev_disable puts the backend
blockdev, which is a separate blockdev...

Maybe I'm misunderstanding your point?

