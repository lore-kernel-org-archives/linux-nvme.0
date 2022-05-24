Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45B3C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 09:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f1BGtL4r/WboPXoq5Ib46It9E4Oc6cvyut9QEjlYpHM=; b=mjKCkQK/WAy4yNhb+BeUbQRNV/
	GDWDtBiLNRKCwOS7iV90qIrTSpzc292Gm6fRGq3PHH8ci45dBkqlJG613aidcKgsuBDm54PN8KPim
	c85V7uHUDK2ha9+J9qdn0CDxx4EtmM5edtlp1goZdxnj8Ge2Km5RLg+trmHGk8Mkd92xdXSA4SE/V
	14A6OJdpLQqHQjnrcyD9evWkZP9sLpMiuH4S6uH/pO4nHEHrru7OlCqilj3H1i2x12u0mzuUup/kb
	HYiZIc4gPuMTxoGNSfMA+fAONQKgjPcf+beZBWJc+ybSKLnq24yISbTJrz3V7eSn5BrzoqWRGCk33
	0/Qd81pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntRJY-007Y76-7d; Tue, 24 May 2022 09:58:56 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntRJU-007Y5Q-O2
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 09:58:54 +0000
Received: by mail-wr1-f53.google.com with SMTP id t13so5759818wrg.9
 for <linux-nvme@lists.infradead.org>; Tue, 24 May 2022 02:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=f1BGtL4r/WboPXoq5Ib46It9E4Oc6cvyut9QEjlYpHM=;
 b=7plZt0T66DvLAbx3AJWTa8Kbxi3S3o/HODQp0H4Lz8m8nJk1EncPMPDKT88duitGS+
 y8DwR7KNpK/jDPDlWBnYguXUaRvPsgv1KZr1BAvAzEoL4SEnpXfBJyUSNe/Uao9z4M9e
 rgj5DUT/yKg+0KiE0w2J+QFMBA+/tEl1UXRx7WKuM3t6FF0Jkxr1NemRk572XX/yaGcO
 Y49FEECEv0jfvyr89brNMxddXj2wBArsMjCuAxIGriv5i0mHfzwXRdSbU9IzHLkEdiEa
 kC3QBCu3PePEidwreBPAQX9UYot6/+Q8YbWcADEO1YbB/ZR1GtE7s5SqmGkvuS7zAuU6
 oycw==
X-Gm-Message-State: AOAM533XhAAenQvBnWvSOxyXkUTz3/sy1QpF1IF2XtW1S3Q+uNt4M1U4
 zvSPDQSXGFswkxXx1mL2QvyLc+xu6ts=
X-Google-Smtp-Source: ABdhPJx7d16Wa5iJsUx3+ReD79cOUMK4Ju1ywgHkdFKj/ms56g/Ou0vo7xi+okF/MeF40uRoF3x72w==
X-Received: by 2002:a5d:48c1:0:b0:20c:52e9:6c5b with SMTP id
 p1-20020a5d48c1000000b0020c52e96c5bmr21456496wrs.233.1653386330840; 
 Tue, 24 May 2022 02:58:50 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 f13-20020a7bc8cd000000b003974df805c7sm1771999wml.8.2022.05.24.02.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 May 2022 02:58:50 -0700 (PDT)
Message-ID: <500df090-0c3f-79cf-a2b4-f04871b0a528@grimberg.me>
Date: Tue, 24 May 2022 12:58:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] nvme-tcp: spurious I/O timeout under high load
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220519062617.39715-1-hare@suse.de>
 <20220519062617.39715-2-hare@suse.de>
 <7827d599-7714-3947-ee24-e343e90eee6e@grimberg.me>
 <96a3315f-43a4-efe6-1f37-0552d66dbd85@suse.de>
 <96722b37-f943-c3e4-ee6a-440f65e8afca@grimberg.me>
 <e749bb3e-2ff7-23f5-9f5f-974c986845b6@suse.de>
 <7ec792e3-5110-2272-b6fe-1a976c8c054f@grimberg.me>
 <919bfaa2-a35d-052a-1d35-9fdd8faa0d3f@suse.de>
 <02805f44-6f2d-b12e-c224-d44616332d5a@grimberg.me>
 <76475e4f-13c7-2e0c-8584-f46918f5cefa@suse.de>
 <ec08bc32-3ad3-fade-0acd-ae5d5ca3812f@grimberg.me>
 <582f08b6-ac55-b857-6a38-675b0b5810c8@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <582f08b6-ac55-b857-6a38-675b0b5810c8@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_025852_814422_8F4C7A07 
X-CRM114-Status: GOOD (  32.42  )
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



On 5/24/22 12:34, Hannes Reinecke wrote:
> On 5/24/22 10:53, Sagi Grimberg wrote:
>>
>>>>>>>>> I'm open to discussion what we should be doing when the request 
>>>>>>>>> is in the process of being sent. But when it didn't have a 
>>>>>>>>> chance to be sent and we just overloaded our internal queuing 
>>>>>>>>> we shouldn't be sending timeouts.
>>>>>>>>
>>>>>>>> As mentioned above, what happens if that same reporter opens 
>>>>>>>> another bug
>>>>>>>> that the same phenomenon happens with soft-iwarp? What would you 
>>>>>>>> tell
>>>>>>>> him/her?
>>>>>>>
>>>>>>> Nope. It's a HW appliance. Not a chance to change that.
>>>>>>
>>>>>> It was just a theoretical question.
>>>>>>
>>>>>> Do note that I'm not against solving a problem for anyone, I'm just
>>>>>> questioning if increasing the io_timeout to be unbound in case the
>>>>>> network is congested, is the right solution for everyone instead of
>>>>>> a particular case that can easily be solved with udev to make the
>>>>>> io_timeout to be as high as needed.
>>>>>>
>>>>>> One can argue that this patchset is making nvme-tcp to basically
>>>>>> ignore the device io_timeout in certain cases.
>>>>>
>>>>> Oh, yes, sure, that will happen.
>>>>> What I'm actually arguing is the imprecise difference between 
>>>>> BLK_STS_AGAIN / BLK_STS_RESOURCE as a return value from ->queue_rq()
>>>>> and command timeouts in case of resource constraints on the driver 
>>>>> implementing ->queue_rq().
>>>>>
>>>>> If there is a resource constrain driver is free to return 
>>>>> BLK_STS_RESOURCE (in which case you wouldn't see a timeout) or 
>>>>> accept the request (in which case there will be a timeout).
>>>>
>>>> There is no resource constraint. The driver sizes up the resources
>>>> to be able to queue all the requests it is getting.
>>>>
>>>>> I could live with a timeout if that would just result in the 
>>>>> command being retried. But in the case of nvme it results in a 
>>>>> connection reset to boot, making customers really nervous that 
>>>>> their system is broken.
>>>>
>>>> But how does the driver know that it is running in this environment 
>>>> that
>>>> is completely congested? What I'm saying is that this is a specific use
>>>> case that the solution can have negative side-effects for other common
>>>> use-cases, because it is beyond the scope of the driver to handle.
>>>>
>>>> We can also trigger this condition with nvme-rdma.
>>>>
>>>> We could stay with this patch, but I'd argue that this might be the
>>>> wrong thing to do in certain use-cases.
>>>>
>>> Right, okay.
>>>
>>> Arguably this is a workload corner case, and we might not want to fix 
>>> this in the driver.
>>>
>>> _However_: do we need to do a controller reset in this case?
>>> Shouldn't it be sufficient to just complete the command w/ timeout 
>>> error and be done with it?
>>
>> The question is what is special about this timeout vs. any other
>> timeout?
>>
>> pci attempts to abort the command before triggering a controller
>> reset, Maybe we should also? although abort is not really reliable
>> going on the admin queue...
> 
> I am not talking about NVMe abort.
> I'm talking about this:
> 
> @@ -2335,6 +2340,11 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
>                  "queue %d: timeout request %#x type %d\n",
>                  nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);
> 
> +       if (!list_empty(&req->entry)) {
> +               nvme_tcp_complete_timed_out(rq);
> +               return BLK_EH_DONE;
> +       }
> +
>          if (ctrl->state != NVME_CTRL_LIVE) {
>                  /*
>                   * If we are resetting, connecting or deleting we should
> 
> 
> as the command is still in the queue and NVMe abort don't enter the 
> picture at all.

That for sure will not help because nvme_tcp_complete_timed_out stops
the queue. What you can do is maybe just remove it from the pending list
and complete it.

