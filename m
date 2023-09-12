Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA98CA0EC3
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 12:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5F2/s4ApN+VZBlMAP/QUKrNS3bdLo80b1VJ4xVpaQ1U=; b=wIzcn+8o8ICFrl99whZmMU0B8K
	8KehJrV/LoOiqyhv6//2tgvKshxV+7kRiaIQ0B/0Af5WhmQ8/YAHA1UftXgCymVpGUIr+3WIb3xdA
	BU0grGZ4pgGOQD7FmkX8igRWTs/Mc0hkTLYdn0NutzrKB47qaStMthaKCeJf/D77nJ26ZJHVmqwaZ
	yP9BNUwEBDYEHQR+EqFvIn0CIseTtPMRynhx3Wcbnr4sTjMEjbkuQ1jvI0ezkSSo+mFRJu5xEOMb7
	xlHI5LiL6VbvXy7uymZvmpSC4emUM+WFxeuGLBLb+qYlytUAL6CDIeowIq7zycAIZR7eGgb5O+MNW
	GEUBLw5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg2Ji-003JJl-1u;
	Tue, 12 Sep 2023 12:16:30 +0000
Received: from mail-ej1-f51.google.com ([209.85.218.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg2Jf-003JIM-2v
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 12:16:29 +0000
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-98273ae42d0so161379766b.0
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 05:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694520985; x=1695125785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5F2/s4ApN+VZBlMAP/QUKrNS3bdLo80b1VJ4xVpaQ1U=;
        b=rHIrBz6h2SEuDY4l9XRDOTb2nxn4A+Ah1/O6Ce6NddX0mFPIScSGw2DMY4UtkfCHjx
         JNazyy/AhdRslGdNLNise0VR790tmGfb7r62LzLgMHhnzzrTq1giWHY4m8TQXTMgNMqv
         7VMG+Hhqq3jHLVyKKT1scKyP0xpyF5ROd4CNOhFJAJC241HCsVl703Y2zq5pzwI7BBBl
         c2GXxa53VD4y/hIg4xGm5bXGOhDAktDUzyIz8tTP0C1U8RsBdRN1ABKjGQiOw53NRp45
         v99I35FMfuFX5b2QJeDHBd1qOIj8QZ8buyEGQcwvD46A5MlL3uQ1j6j2MCAcq9qHb97+
         pjRg==
X-Gm-Message-State: AOJu0YzgHZPsifrnBqreq7PLw5BmnHiLMcc+4xudm/StkfVp/xG1Lghb
	vFHcs6X0OcnwM7qrRFeePPM=
X-Google-Smtp-Source: AGHT+IHWb5edEyZI68sbUyfgadyFFNjmWK2aaAWsrT5eBP++lc8/OO4HWIRjadVsEbB1zNzCBZaTSw==
X-Received: by 2002:a17:906:1d9:b0:9a6:5453:2013 with SMTP id 25-20020a17090601d900b009a654532013mr9441039ejj.3.1694520984610;
        Tue, 12 Sep 2023 05:16:24 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id ho15-20020a1709070e8f00b009ad8ba6976bsm732070ejc.9.2023.09.12.05.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 05:16:17 -0700 (PDT)
Message-ID: <9f5afd8d-b1b5-53de-9229-8b48d87f4106@grimberg.me>
Date: Tue, 12 Sep 2023 15:15:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] nvme-tcp: Do not terminate commands when in RESETTING
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908100049.80809-1-hare@suse.de>
 <20230908100049.80809-2-hare@suse.de>
 <b21a2472-2afb-5a38-1029-1db153102a0c@grimberg.me>
 <25a59314-ff11-4217-b1d8-d06f684312f5@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <25a59314-ff11-4217-b1d8-d06f684312f5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_051627_941269_C3E10141 
X-CRM114-Status: GOOD (  20.08  )
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


>>> When the error recovery started it will terminate all commands
>>> anyway, so we should just return BLK_EH_RESET_TIMER for a
>>> command timeout.
>>
>> Does this fix a real issue? the timeout handler and the error
>> recovery should be mutually exclusive.
>>
> They are not. When several timeouts are triggering at the same time,
> only the first will start error recovery; the remaining ones will
> still hit the timeout function until cancel_tagset() is called.

Yes, but they do not access any resources unsynchronized. Meaning
is this a use-after-free issue?

> 
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/host/tcp.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 5b332d9f87fc..1faef1cf5c94 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -2274,6 +2274,14 @@ static enum blk_eh_timer_return 
>>> nvme_tcp_timeout(struct request *rq)
>>>           nvme_tcp_queue_id(req->queue), nvme_cid(rq), pdu->hdr.type,
>>>           opc, nvme_opcode_str(qid, opc, fctype));
>>> +    /*
>>> +     * If the error recovery is started all commands will be
>>> +     * aborted anyway, and nothing is to be done here.
>>> +     */
>>> +    if (ctrl->state == NVME_CTRL_RESETTING &&
>>> +        work_pending(&to_tcp_ctrl(ctrl)->err_work))
>>> +        return BLK_EH_RESET_TIMER;
>>
>> What does the work_pending() check give you here?
>>
> 'RESETTING' is also entered for firmware download, so we need to check
> for work_pending() to find out if the error recovery engaged.

firmware download? what happens if err_work is yet to run when
this request times out?

Not sure what this is protecting against.

