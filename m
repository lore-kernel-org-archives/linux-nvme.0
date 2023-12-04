Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1EBC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GzdbCPs9LqOic+UW/lGUmWE5CfNLkYDb6qWC8rbSdTs=; b=0j23C9jgtuY7/mKCszxRMd28U7
	aOag6nDPtpxa1TV4PfzEEV32Wof/Xe3yHfLwAUmq57g0gKTTH7q2UxM04EoISZsLUCD2J9IC1Ag40
	YFJlpL1rwH41oQy3+qa5bX74JzRpcLpo6JyyjyVS3qTTemiQGfPMr/UKUQMaVgJBXjuV042U7g4CC
	91gaPVoeQsZJn0cUrjR8dGsobv7p8bsn7tsbsMiU75RFPgBvINBPS8N7NXoshNK4LmG66rPjZcY+6
	aQTG/I6IVo1Exu0KjQLMxlGg63nagoTrn2zAF3gEFM12dFbY5RQDenW4bm2g7zvz5hLp1s+4gpLOv
	UCDTA3Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA8Lt-004CKz-0x;
	Mon, 04 Dec 2023 12:47:09 +0000
Received: from mail-lf1-f51.google.com ([209.85.167.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA8Lp-004CD4-2Y
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 12:47:07 +0000
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50bcbfe20e8so1202765e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 04:46:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694016; x=1702298816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzdbCPs9LqOic+UW/lGUmWE5CfNLkYDb6qWC8rbSdTs=;
        b=Qx6gNt9ejAXhOKibhGh/HSDWpd/lNob2r8GPseV7OcP+eoefFpluMKXMs9Nru9Kk+6
         U2BwJ18xClGU5OmKXOSC+5P/8i515Wfmz8ZSz0k4FtXrpMpFWIEzKSmqz3htQ+YAJQSi
         ZcXrb+4YIEjYPrNZUY9zNHrtkIax6CEEG9w6qiohTMvCLRdfEGOPKLNDHSdhJgisEE8l
         LJnJBbgp1mcrsc73DzZzqdBx1lFj/YlYzPbASjFoCJwk1RqWyE+ZLTfnH8bK16uvTq6z
         WdHHSQG1y4APJpbLa83E8P0bcUYDQWb0Qcq7sAadL7UclZmUcQc4P8S1m5MZoqtiZf12
         P6rw==
X-Gm-Message-State: AOJu0Yzm+tMC8WDSfYjcgKm+SfMkw2AZs0HTvTx8v495z6/waEHZOQ44
	vBU//fmsxfPL5OImkVlRw+M=
X-Google-Smtp-Source: AGHT+IFnYbpcSPjJTg3mNn4wfu2zCR6UpDq9lRtzyQZFamiW22ENIxkZH21w6EMfSoi9/T8M7quz8w==
X-Received: by 2002:a05:6512:3ca4:b0:50b:fd29:7ed8 with SMTP id h36-20020a0565123ca400b0050bfd297ed8mr989272lfv.3.1701694015859;
        Mon, 04 Dec 2023 04:46:55 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id fa23-20020a05600c519700b003fee6e170f9sm14880713wmb.45.2023.12.04.04.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 04:46:55 -0800 (PST)
Message-ID: <8cb5e071-385a-4332-af97-cef4ddfb4720@grimberg.me>
Date: Mon, 4 Dec 2023 14:46:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20231102141903.66515-1-hare@suse.de>
 <20231102141903.66515-2-hare@suse.de> <20231103082305.GA17096@lst.de>
 <69b6f873-f8a1-482b-a739-b47da6e98cec@suse.de>
 <20231103091952.GA18200@lst.de>
 <e09869f2-193b-4f03-a12f-2a7f6c24d537@suse.de> <20231103140514.GA2395@lst.de>
 <d5ef550d-91da-4135-959d-e10f153514a0@grimberg.me>
 <52bd0ef3-b91e-492e-8117-41a290b6cfe6@grimberg.me>
 <c261fe62-e8e6-4470-b9e2-3047fd4c3d99@suse.de>
 <9ca33803-e2ca-4550-8d6e-1e64219fb3d9@grimberg.me>
 <e3fa3584-47e3-4712-a2ce-7fc59e603898@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <e3fa3584-47e3-4712-a2ce-7fc59e603898@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_044705_829887_1BD36586 
X-CRM114-Status: GOOD (  21.96  )
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



On 12/4/23 14:31, Hannes Reinecke wrote:
> On 12/4/23 12:57, Sagi Grimberg wrote:
>>
>>
>> On 12/4/23 13:49, Hannes Reinecke wrote:
>>> On 12/4/23 11:19, Sagi Grimberg wrote:
>>>>
>>>>
>>>> On 11/20/23 15:48, Sagi Grimberg wrote:
>>>>>
>>>>>>> According to 777dc82395de ("nvmet-rdma: occasionally flush ongoing
>>>>>>> controller teardown") this is just for reducing the memory 
>>>>>>> footprint.
>>>>>>> Wonder if we need to bother, and whether it won't be better to 
>>>>>>> remove
>>>>>>> the whole thing entirely.
>>>>>>
>>>>>> Well, Sagi added it, so I'll let him chime in on the usefulness.
>>>>>
>>>>> While I don't like having nvmet arbitrarily replying busy and instead
>>>>> have lockdep simply just accept that its not a deadlock here, but 
>>>>> we can
>>>>> simply just sidetrack it as proposed I guess.
>>>>>
>>>>> But Hannes, this is on the other extreme.. Now every connect that 
>>>>> nvmet
>>>>> gets, if there is even a single queue that is disconnecting (global
>>>>> scope), then the host is denied. Lets give it a sane backlog.
>>>>> We use rdma_listen backlog of 128, so maybe stick with this magic
>>>>> number... This way we are busy only if more than 128 queues are 
>>>>> tearing
>>>>> down to prevent the memory footprint from exploding, and hopefully 
>>>>> it is
>>>>> rare enough that the normal host does not see an arbitrary busy
>>>>> rejection.
>>>>>
>>>>> Same comment for nvmet-tcp.
>>>>
>>>> Hey Hannes, anything happened with this one?
>>>>
>>>> Overall I think that the approach is fine, but I do think
>>>> that we need a backlog for it.
>>>
>>> Hmm. The main issue here is the call to 'flush_workqueue()', which 
>>> triggers the circular lock warning. So a ratelimit would only help
>>> us so much; the real issue is to get rid of the flush_workqueue()
>>> thingie.
>>>
>>> What I can to is to add this:
>>>
>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>> index 4cc27856aa8f..72bcc54701a0 100644
>>> --- a/drivers/nvme/target/tcp.c
>>> +++ b/drivers/nvme/target/tcp.c
>>> @@ -2119,8 +2119,20 @@ static u16 nvmet_tcp_install_queue(struct 
>>> nvmet_sq *sq)
>>>                  container_of(sq, struct nvmet_tcp_queue, nvme_sq);
>>>
>>>          if (sq->qid == 0) {
>>> +               struct nvmet_tcp_queue *q;
>>> +               int pending = 0;
>>> +
>>>                  /* Let inflight controller teardown complete */
>>> -               flush_workqueue(nvmet_wq);
>>> +               mutex_lock(&nvmet_tcp_queue_mutex);
>>> +               list_for_each_entry(q, &nvmet_tcp_queue_list, 
>>> queue_list) {
>>> +                       if (q->nvme_sq.ctrl == sq->ctrl &&
>>> +                           q->state == NVMET_TCP_Q_DISCONNECTING)
>>> +                               pending++;
>>> +               }
>>> +               mutex_unlock(&nvmet_tcp_queue_mutex);
>>> +               /* Retry for pending controller teardown */
>>> +               if (pending)
>>> +                       return NVME_SC_CONNECT_CTRL_BUSY;
>>>          }
>>>
>>> which then would only affect the controller we're connecting to.
>>> Hmm?
>>
>> Still I think we should give a reasonable backlog, no reason to limit
>> this as we may hit this more often than we'd like and the sole purpose
>> here is to avoid memory overrun.
> 
> So would 'if (pending > tcp_backlog)' (with eg tcp_backlog = 20) fit the 
> bill here?

Yes I think so, we already place a listen backlog, so maybe we can reuse
that as NVME_TCP_BACKLOG or something. The same should apply to nvme-rdma.

