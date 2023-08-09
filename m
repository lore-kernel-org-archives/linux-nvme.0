Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A07EB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 12:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AZqLi7+oeVXxXysa2KJhcBSx74kBFosVtbjbdkzk3FM=; b=OSAXFi1ArnyfmvSK0J627wO6tj
	2lptgd7+YwMourSMu1mtoy1DgyyKzSq4M4NjsE4NvqxPmr1sN10Gkcj5CFNw1O0/UnUvb2xgRhDnA
	qZ5l3gAaWdtx8SzDqze6bJev1cDLhZnOyFGcRNYMUJlVdEOdFhStYXP3qNZtwy82K9yQG6YYyo3s+
	XMJRAHE5hpTAWLXBVq8nRzBxC/+2sZLeZ+ASh2SGahiO0BsrgAB/AKrGptFq3aWnJMmIRsqiOhlkD
	SqgUOW8vEdpZCYcRnpV4Hc2rVuio6Rpj8oDsjmC9ZfetptmgCFBGyunift2iKK+rHLvUuBXxdHqq5
	PZSMQZ+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTifd-004vXE-00;
	Wed, 09 Aug 2023 12:52:13 +0000
Received: from mail-lf1-f50.google.com ([209.85.167.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTifZ-004vWe-1D
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 12:52:11 +0000
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fe0a3377bfso2873422e87.0
        for <linux-nvme@lists.infradead.org>; Wed, 09 Aug 2023 05:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691585520; x=1692190320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZqLi7+oeVXxXysa2KJhcBSx74kBFosVtbjbdkzk3FM=;
        b=lG1HLdQY59zWwb8AvuO9vWpRnCQkady0pcZMV1FB3ErtcEkCvM7RIc0gKvB8TWUkbj
         flnaWSor07JnzI2MqoTtJzC9W8WweDD4G+nGH73bFfOng2R3JdKjFeayJTCqU19/OztW
         gpcez477DHcRqhpetO9tCf9GONE6OlUSfUWLMdkiCgmItFjC0+rc4oMdGqAnzDuY6ar0
         +loSsuJDj/HzVEt2/0tUtsKCKXKBHxihEmyTPvWl5zko4rXpCOrGwNvz5HIThZNR5pZw
         6MMPOITt7GizJYdIBDUR61S77GBUDsgWur25GzwnCLoFZHqU3pAlYoNoZLJs/E+sHQ2C
         VOqg==
X-Gm-Message-State: AOJu0YwPhh1vxl6F7TTMGJ8K2imLGQC8tSDSQm+a1q77IiylddDGnjSZ
	afEPVewoDOaqcKkMMGRtYBcz5lR+UGw=
X-Google-Smtp-Source: AGHT+IG+h5PuKSIOPzM4d/A/qCIbq8XrskSrM0f0OqCmwV+/Dcw6VhyXwh/qcrdgSANwVKoa/bGm3w==
X-Received: by 2002:a05:6512:251:b0:4fd:d186:6603 with SMTP id b17-20020a056512025100b004fdd1866603mr1638749lfo.0.1691585519938;
        Wed, 09 Aug 2023 05:51:59 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w9-20020a170906384900b0099cf91fe297sm2053887ejc.13.2023.08.09.05.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:51:59 -0700 (PDT)
Message-ID: <7c484503-dc86-e5d2-96c8-e90ec7a1c3bb@grimberg.me>
Date: Wed, 9 Aug 2023 15:51:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/16] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-16-hare@suse.de>
 <e28dffb6-66bd-2724-6c9d-f06e5da75aeb@grimberg.me>
 <9a331c99-a2e3-6c4e-5d4c-a41bfeb8e741@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9a331c99-a2e3-6c4e-5d4c-a41bfeb8e741@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_055209_436809_C0CA909D 
X-CRM114-Status: GOOD (  11.30  )
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


>>> @@ -1621,6 +1642,75 @@ static int nvmet_tcp_set_queue_sock(struct 
>>> nvmet_tcp_queue *queue)
>>>       return ret;
>>>   }
>>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>>> +static void nvmet_tcp_tls_handshake_done(void *data, int status,
>>> +                     key_serial_t peerid)
>>> +{
>>> +    struct nvmet_tcp_queue *queue = data;
>>> +
>>> +    pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
>>> +         queue->idx, peerid, status);
>>> +    spin_lock_irq(&queue->state_lock);
>>> +    if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
>>> +        pr_warn("queue %d: TLS handshake already completed\n",
>>> +            queue->idx);
>>> +        spin_unlock_irq(&queue->state_lock);
>>> +        return;
>>> +    }
>>> +    if (!status)
>>> +        queue->tls_pskid = peerid;
>>> +    queue->state = NVMET_TCP_Q_CONNECTING;
>>> +    spin_unlock_irq(&queue->state_lock);
>>> +
>>> +    cancel_delayed_work_sync(&queue->tls_handshake_work);
>>> +    if (status) {
>>
>> I think that after this call, you cannot reference anything
>> in queue as it may have been released. Or I'm missing something?
>>
> I guess I can, as this code is gated by the state change above.
> Once we are here the state has been updated, so the timeout work will
> short circuit and not delete the queue.

But who guarantees that queue->state_lock is a valid dereference?

