Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716E3C0015E
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 12:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7F+F1tUJsjsJM6NZFh8MEiVHQzYJfrRsCdA2uLourpI=; b=DT9EE60ZMCLjeECtR/LEiUjEXQ
	9GiX//JNuUbB/Zb6fCDLtf1UaGcXMBin0FVsxMitUaxvQEwwMezwiMofc3fhcl/CwuiKRSKHiTeyt
	nLp2FgD+HiDQGOS/YszlxZMkqHTpaTjv2AHAwTll2WtWM9pYSmRfpMLPgDKcGeedRfzKlvAIN+0KF
	FPy/hiZKIJrjGeoFKtuus/NbWiueJbqr82HStY6GkjGw3ShDjeMdM/ITTY9gbs6B8jeXhxyJSUhVw
	F7/C51n3jwuGaPpDc6v20lGrAnNMsrtEWh1H0S8+/Khn150g7JrYLB1VPTubbKQQc0LJhXk4dATcU
	sXAOmNSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTihX-004vwB-1O;
	Wed, 09 Aug 2023 12:54:11 +0000
Received: from mail-ej1-f41.google.com ([209.85.218.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTihU-004vtu-1a
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 12:54:09 +0000
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99c3ca08c09so206022966b.1
        for <linux-nvme@lists.infradead.org>; Wed, 09 Aug 2023 05:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691585645; x=1692190445;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7F+F1tUJsjsJM6NZFh8MEiVHQzYJfrRsCdA2uLourpI=;
        b=H27/rpywcwjXmcNTNiA6Qr63f4EwctkPyh5KXhO7Po08iw/gqd/x2MkaqNMRwPG2aI
         dPBEo8lMMaXdtV+XsZziC63qvJSjx0cFpDQ08gQDdbZTPxRM9frf95NnKp7paG9Qxkp4
         vm1HXZStZLsSpHhmm107v2XiyvsVm2XKuU1CGEJIuChrccx9/pD4WRAonw4wXibkinf4
         1h6feLT58OPWzypb6xIiL+ywdL/RIqhbVjgAbfnpAyA7vTSwcCBghp26BI60fFj7EDUF
         oA8ep47e4Oqrr5nHdtv9W7GToe0Heek/zJfPbGcokQQEZO4E8s7sFbly2wRbliGEMT2/
         gcuQ==
X-Gm-Message-State: AOJu0YztiJO96/nWtsKiIeolT991KebkReSh9yPRag/e+icA9Dw9IsFL
	Gsfr3YCa5fyjRh88arqVhVc=
X-Google-Smtp-Source: AGHT+IFIhlGug8ENvlBnvzgJ2oYc7BwFPZYCfE6uIVZRjlvRw34JNoAZSCKJTIJgmymAaoAUyxpJiw==
X-Received: by 2002:a05:6402:3492:b0:523:37cf:6f37 with SMTP id v18-20020a056402349200b0052337cf6f37mr2261480edc.4.1691585645087;
        Wed, 09 Aug 2023 05:54:05 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e14-20020a50fb8e000000b0051df67eaf62sm8095206edq.42.2023.08.09.05.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:54:04 -0700 (PDT)
Message-ID: <8afb1865-ae77-5fc1-a63b-cc3fda9ffdf8@grimberg.me>
Date: Wed, 9 Aug 2023 15:54:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/16] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-16-hare@suse.de>
 <e28dffb6-66bd-2724-6c9d-f06e5da75aeb@grimberg.me>
 <9a331c99-a2e3-6c4e-5d4c-a41bfeb8e741@suse.de>
 <7c484503-dc86-e5d2-96c8-e90ec7a1c3bb@grimberg.me>
In-Reply-To: <7c484503-dc86-e5d2-96c8-e90ec7a1c3bb@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_055408_527919_6333CC1F 
X-CRM114-Status: GOOD (  12.70  )
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



On 8/9/23 15:51, Sagi Grimberg wrote:
> 
>>>> @@ -1621,6 +1642,75 @@ static int nvmet_tcp_set_queue_sock(struct 
>>>> nvmet_tcp_queue *queue)
>>>>       return ret;
>>>>   }
>>>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>>>> +static void nvmet_tcp_tls_handshake_done(void *data, int status,
>>>> +                     key_serial_t peerid)
>>>> +{
>>>> +    struct nvmet_tcp_queue *queue = data;
>>>> +
>>>> +    pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
>>>> +         queue->idx, peerid, status);
>>>> +    spin_lock_irq(&queue->state_lock);
>>>> +    if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
>>>> +        pr_warn("queue %d: TLS handshake already completed\n",
>>>> +            queue->idx);
>>>> +        spin_unlock_irq(&queue->state_lock);
>>>> +        return;
>>>> +    }
>>>> +    if (!status)
>>>> +        queue->tls_pskid = peerid;
>>>> +    queue->state = NVMET_TCP_Q_CONNECTING;
>>>> +    spin_unlock_irq(&queue->state_lock);
>>>> +
>>>> +    cancel_delayed_work_sync(&queue->tls_handshake_work);
>>>> +    if (status) {
>>>
>>> I think that after this call, you cannot reference anything
>>> in queue as it may have been released. Or I'm missing something?
>>>
>> I guess I can, as this code is gated by the state change above.
>> Once we are here the state has been updated, so the timeout work will
>> short circuit and not delete the queue.
> 
> But who guarantees that queue->state_lock is a valid dereference?

The lock acquired in the first line of the function...

I think we need a reference count here...

