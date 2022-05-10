Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE08DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 18:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zc3zBKJim9jyifG51aYUjzMq1sQ9JfN0/emRQMlcn0E=; b=Rfn+tn1XvDvhPR6+v6u3zQLAY4
	g8+807f7AzpW66CGbHKaBQmhn4xjd4aBXVD5ySTwDyqUFtZ2c9zuMOE8qbr1B3uXsGTXZTonbSm//
	RlwLqTDGbgwzedfz5fEiVIjmZOEeim5+W5CWeUjAcSsw8XpxWv5wb9poGYMz7HljfNYBjEbrU3R6c
	QMJIoZlpSUQ6PZt6FCngEnhpE9Ielizo0qoJBCiS+TLKX96+CdetumXOa0n2yz6AYvVubCZ3sfCxP
	d75aN0NWs4k192ZQnZUAFwR5DhQjfYnT41I5b69lrFn0LlD/1C2BK9I/vaRVq6rXw5UwRks//yfP5
	6c76j7wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noUau-003dAR-AF; Tue, 10 May 2022 18:28:24 +0000
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noUar-003d9P-GJ
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 18:28:23 +0000
Received: by mail-pl1-f172.google.com with SMTP id n8so17505820plh.1
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 11:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Zc3zBKJim9jyifG51aYUjzMq1sQ9JfN0/emRQMlcn0E=;
 b=gzBM7z6P6WT9Ngk+ix+u8icRFGcOsUtSRzC7IDHcUlVXgGlv9h0PPk3YXDX/b74Vfn
 NBAs4yrRSUJKD69Ao0ifkQtQT/7o5oW4OqbKI65HDWwZbMq8BxhRY50htHvjkNDfQqDj
 nUsUpzLF/SZMFLU636OnXFccC6AgIqcQSr48br4xGJDnq2VwliROcPxL6WckpQCsnDyx
 n5WEVsxNRo6/tu1xl6/argLs4e2xjxnJlQfpq+AxmC6pebkUPxB/KexQ047pbwwMSryz
 pu+Uk9axWtgjPRd7DycKWB9SzqmwYgNOerK6Qoq6qk5jhhcuyR4pdIVMAA6Pk27TLzNW
 RKEA==
X-Gm-Message-State: AOAM533JI2jRB9RLp/uGlYHJnkCgqX0tHDy9CQe/EFfSTGsHY0TO/hO4
 cArbG2goLRhemXf2haHer8Q=
X-Google-Smtp-Source: ABdhPJyxZ2rlmodhN0YPimrbBD7qoTZvrnQM6nR57Xuk6BmadlhbLyx/6Nxq61NlxyGu4v++j9E/0Q==
X-Received: by 2002:a17:90b:30c3:b0:1dc:b6d7:58d3 with SMTP id
 hi3-20020a17090b30c300b001dcb6d758d3mr1191339pjb.172.1652207298348; 
 Tue, 10 May 2022 11:28:18 -0700 (PDT)
Received: from [172.16.228.60] ([65.122.177.243])
 by smtp.gmail.com with ESMTPSA id
 z29-20020aa79f9d000000b0050dc7628170sm11059433pfr.74.2022.05.10.11.28.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 May 2022 11:28:17 -0700 (PDT)
Message-ID: <3670e27a-a5df-1078-d999-bf094f0c0b42@grimberg.me>
Date: Tue, 10 May 2022 11:28:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme-host: tcp: do not read from the socket if we are
 performing a reset
Content-Language: en-US
To: John Meneghini <jmeneghi@redhat.com>,
 Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, cleech@redhat.com
References: <20220415101437.292254-1-mlombard@redhat.com>
 <31923ed3-3d6e-b25c-6971-9d5cdfd4e057@grimberg.me>
 <14f3b14b-b228-7758-a556-213cd07f6593@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <14f3b14b-b228-7758-a556-213cd07f6593@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_112821_584486_A4D0721F 
X-CRM114-Status: GOOD (  27.53  )
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

Hey John, Sorry for the late response.

> 
> This bug has been reproduced on a partner's testbed.  We don't
> have direct access to the tests they are running but it appears
> they are running error insertion tests which aggressively
> bring the TCP link up and down, reset the NVMe/TCP controller,
> and randomly add/remove NVMe namespaces from the controller
> while IO is in progress. With these tests they have been able
> to reproduce this bug with our v5.16 based kernel.
> 
> I do see a number of patches from v5.17 and v5.18 which
> look like they might affect this problem.  Specifically:
> 
> 63573807b27e0faf8065a28b1bbe1cbfb23c0130 nvme-tcp: fix bogus request 
> completion when failing to send AER
> d6d6742772d712ed2238f5071b96baf4924f5fad nvme: fix RCU hole that allowed 
> for endless looping in multipath round robin
> a4a6f3c8f61c3cfbda4998ad94596059ad7e4332 nvme-multipath: fix hang when 
> disk goes live over reconnect
> 
> This is the testbed that reproduced the RCU hole fixed in 
> d6d6742772d712ed2238f5071b96baf4924f5fad.
> We should definitely make sure they are running with that fix before we 
> go any further.
> 
> If you agree the above patches are needed we can give them a new 
> v5.18-rc6 based kernel
> and ask them to run their test again.

These are all useful and needed fixes, but please see the fix I've
referenced below as this issue looks very similar to what this patch
fixes.

> 
> /John
> 
>>>
>>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
>>> ---
>>>   drivers/nvme/host/tcp.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index ad3a2bf2f1e9..e3ef014bbc0b 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -103,6 +103,7 @@ enum nvme_tcp_queue_flags {
>>>       NVME_TCP_Q_ALLOCATED    = 0,
>>>       NVME_TCP_Q_LIVE        = 1,
>>>       NVME_TCP_Q_POLLING    = 2,
>>> +    NVME_TCP_Q_CONNECTING    = 3,
>>>   };
>>>   enum nvme_tcp_recv_state {
>>> @@ -1213,6 +1214,10 @@ static void nvme_tcp_io_work(struct 
>>> work_struct *w)
>>>           bool pending = false;
>>>           int result;
>>> +        if (unlikely(!test_bit(NVME_TCP_Q_LIVE, &queue->flags) &&
>>> +                !test_bit(NVME_TCP_Q_CONNECTING, &queue->flags)))
>>> +            return;
>>
>> How is this protecting anything? If the queue is torn down we may access
>> other freed memory, not just from accessing the sockets.
>>
>>> +
>>>           if (mutex_trylock(&queue->send_mutex)) {
>>>               result = nvme_tcp_try_send(queue);
>>>               mutex_unlock(&queue->send_mutex);
>>> @@ -1670,6 +1675,8 @@ static int nvme_tcp_start_queue(struct 
>>> nvme_ctrl *nctrl, int idx)
>>>       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>>>       int ret;
>>> +    set_bit(NVME_TCP_Q_CONNECTING, &ctrl->queues[idx].flags);
>>> +
>>>       if (idx)
>>>           ret = nvmf_connect_io_queue(nctrl, idx);
>>>       else
>>> @@ -1683,6 +1690,7 @@ static int nvme_tcp_start_queue(struct 
>>> nvme_ctrl *nctrl, int idx)
>>>           dev_err(nctrl->device,
>>>               "failed to connect queue: %d ret=%d\n", idx, ret);
>>>       }
>>> +    clear_bit(NVME_TCP_Q_CONNECTING, &ctrl->queues[idx].flags);
>>>       return ret;
>>>   }
>>
>> Question, can you tell from your stack dump if this queue is the admin
>> queue or I/O queue?
>>
>> If this is indeed the admin queue, please check if you have a related
>> fix applied:

This is the possible fix patch:

>> 0fa0f99fc84e ("nvme: fix a possible use-after-free in controller reset 
>> during load")

