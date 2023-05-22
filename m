Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D7AC77B73
	for <linux-nvme@archiver.kernel.org>; Mon, 22 May 2023 07:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=egjJp/o6G57TBaqZEvbhz1jQEfbtnQOSpdHmtN/bE4A=; b=BlVmPmoaMinOYnI+1ZyfyVRjcn
	KTL0/EdJUioU2jBEQYmN/hKr8Uwl20rHozb8lo/cEbCsztSCatbDjDQ+VSouCsbZHUpsj2sH0Qee7
	I6FynTPqqnHk89GrRAADsTHpESggT8RGu95bttNvQ4IboMP2GmVnmzf13cckLvXgOQboqdg7yc+zr
	FmMy2NrrQaYkL+IMEkX6lvIyWpwPfrCo9DhHzpIeU0PTYpBmcpzHDYyiPAWfvN5pOPuFjXxSpLRJA
	2wlgZ805IycHrP1hRa/40QeREvge08bpNdmuvxnC5SrcPI/Kg6L3eiGHij8I3UzByF8GVwItH9lzv
	xYKWDHPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0zeL-005auS-1T;
	Mon, 22 May 2023 07:08:09 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0zeI-005asB-1N
	for linux-nvme@lists.infradead.org;
	Mon, 22 May 2023 07:08:07 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3093aa2f2a5so314547f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 22 May 2023 00:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684739275; x=1687331275;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egjJp/o6G57TBaqZEvbhz1jQEfbtnQOSpdHmtN/bE4A=;
        b=HkfPUOf6TC7TCuK1Zyldpn4eTgZ0Wot/yeNyZD3dclT60FKCO+AwCJb4HCqW7Xh8Wq
         Mm/tVwK+4i5lX63wrA2nSY1uZwqTQVOF1dJKley0Q/8O05nqedyV/mNgTV7PdbFkdOxC
         vQVA/fYp3gWbwDl6fH3RigGWIpT2VGWn+90VHsU8p9MamXeaR5KMzU+AdJ7YaeqPl2Eg
         Uefbx0bd4W/D2Lgy78h+r2AmUJwcprreE69foxp01z/rndK7EpREcjAshN1aeV1hpUdK
         O+dP+oRLO6lwvrpDwNCXzL2tP8lGvvzapZhPbRWihBZL+DIioi92jE8Iqk8HUEygcoCt
         8o4w==
X-Gm-Message-State: AC+VfDwj6JfNFZn6jLjJcWlGdeYeqJWTc6BVTq84mh0ROvMZR934NEaD
	u7ye+ALRgRrG41CN1t/84vOE3MBczks=
X-Google-Smtp-Source: ACHHUZ4MxxQYw99goW2wcOPSSfWM5Bqg2dbv5+rqB0UMTJlfr1NE/v1bJhwt+eqeZa+nMBJ6nWUZTw==
X-Received: by 2002:a5d:4283:0:b0:306:3688:e5e5 with SMTP id k3-20020a5d4283000000b003063688e5e5mr5509796wrq.3.1684739274940;
        Mon, 22 May 2023 00:07:54 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdcc2000000b003077f3dfcc8sm6598959wrm.32.2023.05.22.00.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 00:07:54 -0700 (PDT)
Message-ID: <9abb3c36-9b1c-75c6-b071-1364c30dc84b@grimberg.me>
Date: Mon, 22 May 2023 10:07:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvmet-rdma: Release connections synchronously
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230511150321.103172-1-bvanassche@acm.org>
 <f2909fb6-26e4-f99f-c55b-1dcec577bb44@grimberg.me>
 <82c223c5-d6ba-d862-2d6e-31fbd3daa77d@acm.org>
 <11382811-caa7-c64c-5fe5-659fc5722c44@grimberg.me>
In-Reply-To: <11382811-caa7-c64c-5fe5-659fc5722c44@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_000806_467251_11C77CB6 
X-CRM114-Status: GOOD (  14.40  )
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


>>>> @@ -1582,11 +1566,6 @@ static int nvmet_rdma_queue_connect(struct 
>>>> rdma_cm_id *cm_id,
>>>>           goto put_device;
>>>>       }
>>>> -    if (queue->host_qid == 0) {
>>>> -        /* Let inflight controller teardown complete */
>>>> -        flush_workqueue(nvmet_wq);
>>>> -    }
>>>> -
>>>>       ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
>>>>       if (ret) {
>>>>           /*
>>>
>>> You could have simply removed this hunk alone to make lockdep quiet on
>>> this, without the need to rework the async queue removal.
>>>
>>> The flush here was added to prevent a reset/connect/disconnect storm
>>> causing the target to run out of resources (which we have seen reports
>>> about in the distant past). What prevents it now?
>>>
>>> And you both reworked the teardown, and still removed the flush, I don't
>>> get why both are needed.
>>
>> Hi Sagi,
>>
>> My understanding is that the above flush_workqueue() call waits for 
>> prior release_work to complete. If the release_work instance is 
>> removed, I don't think that the above flush_workqueue() call is still 
>> necessary.
> 
> I'm wandering if making delete_ctrl synchronous may be a problem
> in some cases, nvmet_fatal_error can be triggered from the
> rdma completion path (rdma core workqueue context). Wondering if there
> may be some inter-dependency there...

For example, nvmet_rdma_comp_error -> nvmet_fatal_error -> delete_ctrl
-> __nvmet_rdma_queue_disconnect -> nvmet_rdma_free_queue ->
nvmet_rdma_destroy_queue_ib -> ib_drain_qp

ib_drain_qp cannot complete because the completion handler is
synchronously deleting the queue, hence cannot reap the drain
completion...

