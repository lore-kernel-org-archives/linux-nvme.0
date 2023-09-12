Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225D6CA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5eLcYV8rbHxk1H60tjU9sJwN9rwm6vzjm2SPVACrauk=; b=iqZ1CK5texTca+iEoL3ujZOavC
	IdO2MlZ8JeKwMX9lslmP2LUYjPXzJ7Q5s8tauXb8Y71vBoOJVaOxJfzMhjxdDfUgPBVkrtVY7I1TG
	KE8WY4JPkerLOHKNnz7PmHqUtaeI+pNgRhYlPDPvF1JJQOSeOe1Z2NGSMLt333z21ILY3y4nuU+Qx
	sV3R3XWRNwGge3fXpEbLLD/UxdVI+0/04cRjGxJVTFy8Qw4gfbZBPzj+Gh6PBhy5fnN+yQkMUCguK
	utDkDcOUZD5omdFeNWCqQRzL8CzFyym37wtd7hU8mqRUXZD2XRdFfb/TD2mScrtmzKN/dH+AnqnTa
	uk7bvo7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg2vg-003Mta-0h;
	Tue, 12 Sep 2023 12:55:44 +0000
Received: from mail-lf1-f52.google.com ([209.85.167.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg2vd-003Mso-1f
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 12:55:42 +0000
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4ffd3c9330dso1264769e87.0
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 05:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694523338; x=1695128138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5eLcYV8rbHxk1H60tjU9sJwN9rwm6vzjm2SPVACrauk=;
        b=KLGXjJn/xcF19zFzzvnoddY5kfKZvMpvvVzOUzFqxX+gnizC0Er4SrWtcqy+cHCYL9
         8/RzYIyCNBQZvfFrojCUs0EsV3JKCi2Z5ySjJxg5c2Ek6uTQegbs6e50uzMG+K+bSavs
         /T7yIhJFEA3axSXqN5shFFwE7rl26uodaf/FkE5Ph+j2hsXCkWTGwCxCCdL9lYt3FkmO
         NE81bMU9eMA2v1GVELbakysRMLYfOoF9D0k5YwHUJJdtniFOt69reOU4TPhIg8CRUGKV
         Z6rJbEOVMnPYnjhL3731C5EzScg6xNO4shuyqOqcU4xewnW+r/U7aBaALdT1RgaQMFrX
         BOSw==
X-Gm-Message-State: AOJu0YxFRHBg1e4Tg8eT9maP6p2A8oq2vfduaqwUmGFutVJwl7Gk9jQp
	JUA9FtPo21qPUeeEBBVkXeY=
X-Google-Smtp-Source: AGHT+IF1oLNiuiDhNNtGZRPjDkM260FMUKo10QVdrgve8RPwzLSUdCavJEkBP2F6dGMJWbSqdNMsdg==
X-Received: by 2002:a05:6512:e93:b0:502:d345:e473 with SMTP id bi19-20020a0565120e9300b00502d345e473mr1250555lfb.4.1694523338223;
        Tue, 12 Sep 2023 05:55:38 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m27-20020a1709060d9b00b009a5f7fb51d1sm6789046eji.40.2023.09.12.05.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 05:55:36 -0700 (PDT)
Message-ID: <e743f924-7421-3f06-c916-075d79975b26@grimberg.me>
Date: Tue, 12 Sep 2023 15:55:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 18/18] nvmet-tcp: peek icreq before starting TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230824143925.9098-1-hare@suse.de>
 <20230824143925.9098-19-hare@suse.de>
 <b545b658-0771-6c53-fc9d-a69e452909c1@grimberg.me>
 <94fc9502-c743-4f6c-a082-40e326085426@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <94fc9502-c743-4f6c-a082-40e326085426@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_055541_553904_11ECA276 
X-CRM114-Status: GOOD (  18.78  )
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



On 9/12/23 14:48, Hannes Reinecke wrote:
> On 9/12/23 13:32, Sagi Grimberg wrote:
>>
>>
>> On 8/24/23 17:39, Hannes Reinecke wrote:
>>> Incoming connection might be either 'normal' NVMe-TCP connections
>>> starting with icreq or TLS handshakes. To ensure that 'normal'
>>> connections can still be handled we need to peek the first packet
>>> and only start TLS handshake if it's not an icreq.
>>> With that we can lift the restriction to always set TREQ to
>>> 'required' when TLS1.3 is enabled.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/target/configfs.c | 25 +++++++++++---
>>>   drivers/nvme/target/nvmet.h    |  5 +++
>>>   drivers/nvme/target/tcp.c      | 61 +++++++++++++++++++++++++++++++---
>>>   3 files changed, 82 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/nvme/target/configfs.c 
>>> b/drivers/nvme/target/configfs.c
>>> index b780ce049163..9eed6e6765ea 100644
>>> --- a/drivers/nvme/target/configfs.c
>>> +++ b/drivers/nvme/target/configfs.c
>>> @@ -198,6 +198,20 @@ static ssize_t nvmet_addr_treq_store(struct 
>>> config_item *item,
>>>       return -EINVAL;
>>>   found:
>>> +    if (port->disc_addr.trtype == NVMF_TRTYPE_TCP &&
>>> +        port->disc_addr.tsas.tcp.sectype == NVMF_TCP_SECTYPE_TLS13) {
>>> +        switch (nvmet_addr_treq[i].type) {
>>> +        case NVMF_TREQ_NOT_SPECIFIED:
>>> +            pr_debug("treq '%s' not allowed for TLS1.3\n",
>>> +                 nvmet_addr_treq[i].name);
>>> +            return -EINVAL;
>>> +        case NVMF_TREQ_NOT_REQUIRED:
>>> +            pr_warn("Allow non-TLS connections while TLS1.3 is 
>>> enabled\n");
>>> +            break;
>>> +        default:
>>> +            break;
>>> +        }
>>> +    }
>>>       treq |= nvmet_addr_treq[i].type;
>>>       port->disc_addr.treq = treq;
>>>       return count;
>>> @@ -410,12 +424,15 @@ static ssize_t nvmet_addr_tsas_store(struct 
>>> config_item *item,
>>>       nvmet_port_init_tsas_tcp(port, sectype);
>>>       /*
>>> -     * The TLS implementation currently does not support
>>> -     * secure concatenation, so TREQ is always set to 'required'
>>> -     * if TLS is enabled.
>>> +     * If TLS is enabled TREQ should be set to 'required' per default
>>>        */
>>>       if (sectype == NVMF_TCP_SECTYPE_TLS13) {
>>> -        treq |= NVMF_TREQ_REQUIRED;
>>> +        u8 sc = nvmet_port_disc_addr_treq_secure_channel(port);
>>> +
>>> +        if (sc == NVMF_TREQ_NOT_SPECIFIED)
>>> +            treq |= NVMF_TREQ_REQUIRED;
>>> +        else
>>> +            treq |= sc;
>>>       } else {
>>>           treq |= NVMF_TREQ_NOT_SPECIFIED;
>>>       }
>>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>>> index e35a03260f45..3e179019ca7c 100644
>>> --- a/drivers/nvme/target/nvmet.h
>>> +++ b/drivers/nvme/target/nvmet.h
>>> @@ -184,6 +184,11 @@ static inline u8 
>>> nvmet_port_disc_addr_treq_secure_channel(struct nvmet_port *por
>>>       return (port->disc_addr.treq & NVME_TREQ_SECURE_CHANNEL_MASK);
>>>   }
>>> +static inline bool nvmet_port_secure_channel_required(struct 
>>> nvmet_port *port)
>>> +{
>>> +    return nvmet_port_disc_addr_treq_secure_channel(port) == 
>>> NVMF_TREQ_REQUIRED;
>>> +}
>>> +
>>>   struct nvmet_ctrl {
>>>       struct nvmet_subsys    *subsys;
>>>       struct nvmet_sq        **sqs;
>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>> index 67fffa2e1e4a..5c1518a8bded 100644
>>> --- a/drivers/nvme/target/tcp.c
>>> +++ b/drivers/nvme/target/tcp.c
>>> @@ -1730,6 +1730,54 @@ static int nvmet_tcp_set_queue_sock(struct 
>>> nvmet_tcp_queue *queue)
>>>   }
>>>   #ifdef CONFIG_NVME_TARGET_TCP_TLS
>>
>> You need a stub for the other side of the ifdef?
> 
> No. The new function is completely encapsulated by 
> CONFIG_NVME_TARGET_TCP_TLS, so no need to add a stub.

Ok.

