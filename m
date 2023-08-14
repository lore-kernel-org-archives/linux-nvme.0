Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7D6EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 19:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZYZDzpDhPpUu+V/D6Iom0HMlkeGtrJCPzmM64j8kbtE=; b=0iGcI/vUnRzX7GRKErrUcUYged
	DzqO01J4UyXl+9vNFUGn6TW4jeGYZpkabM4/4YV4tSQPBtRZhXKNv5RksiCxrLVCRjcBlezOsh/gI
	oAvq32phBOoD7oBfwdrUwX2/OdBqbbmDLJ6TY/BFFX9j9QPdGSGiI27U4Usckz6xXEeH2xxbvHrKJ
	6ZAdhwD9BtzGvzF0NAXFXthDIyibCUYZ/OLVYdPDvrKI5zYd1VB4fowo4Z+KyIY33+8h/GyofzqPV
	flYw9vkWLoS7Ll3G9J/8KDqrl0SiDonCU5B00DPrb/0NlEGRnj9/ifNsW6Q30OjaCPOaU5Ba7FQOj
	0tDYpCiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVczL-000CEO-1I;
	Mon, 14 Aug 2023 19:12:27 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVczH-000CDp-36
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 19:12:25 +0000
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-52349d93c8aso1423943a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 14 Aug 2023 12:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692040340; x=1692645140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYZDzpDhPpUu+V/D6Iom0HMlkeGtrJCPzmM64j8kbtE=;
        b=bOX+3Shhr2AWnzVKEuogiXU0luUIzmDjzyhr27URxe2k9PrqRNiQJ6dSu7IOrsoUOE
         m9KN6gsfDXgHVw9PFynh4fA1EQ4jb2Z9VuOw+tA7C2zG07bPRrMocIo4FRTgiFRgD/CJ
         Eqs8v1R8kO+eBNIFFB/yKJlFyl8LtO5hdqJtFIveOBAknTiT+vms1SId/3nrYe3QaZAN
         rdXGXnBXBkq9cZdkBGAOjSaCx7d3VnulFKZnarmJ9Ran9fwZ2zTZEaU0qylzhM+/7/3+
         dWKkQW6BWtdO5653OIrD5w2XwjuBHXVDQm7q5Av49N9KfAZffs37qD4jyNRgaCzCwy3W
         8Njw==
X-Gm-Message-State: AOJu0YyDj0jytAJXc6YgpOCWe01yobcYYuexeqlSJRIM5caYEaHgUmUr
	sMhCeNuAtbSuY98Bbf+N8Is=
X-Google-Smtp-Source: AGHT+IErgcbz/hR+TLPLKyCV4srVgY9c5gHs09OFSnnnRxqYVHGz7HwbbnM6fh5lgPuKvo+wNJVGVg==
X-Received: by 2002:a17:906:21c:b0:99c:c178:cef9 with SMTP id 28-20020a170906021c00b0099cc178cef9mr8072805ejd.2.1692040339460;
        Mon, 14 Aug 2023 12:12:19 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id ke10-20020a17090798ea00b00982a352f078sm5951999ejc.124.2023.08.14.12.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:12:18 -0700 (PDT)
Message-ID: <a7e01b78-52ba-9576-6d71-6d1f81aecd44@grimberg.me>
Date: Mon, 14 Aug 2023 22:12:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/17] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-16-hare@suse.de>
 <cf21000c-177e-c882-ac30-fe3190748bae@grimberg.me>
 <bebf00fb-be2d-d6da-bd7f-4e610095decc@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bebf00fb-be2d-d6da-bd7f-4e610095decc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_121224_021259_3E731438 
X-CRM114-Status: GOOD (  21.22  )
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


>>> @@ -1864,6 +1877,14 @@ static struct config_group 
>>> *nvmet_ports_make(struct config_group *group,
>>>           return ERR_PTR(-ENOMEM);
>>>       }
>>> +    if (nvme_keyring_id()) {
>>> +        port->keyring = key_lookup(nvme_keyring_id());
>>> +        if (IS_ERR(port->keyring)) {
>>> +            pr_warn("NVMe keyring not available, disabling TLS\n");
>>> +            port->keyring = NULL;
>>
>> why setting this to NULL?
>>
> It's check when changing TSAS; we can only enable TLS if the nvme 
> keyring is available.

ok

> 
>>> +        }
>>> +    }
>>> +
>>>       for (i = 1; i <= NVMET_MAX_ANAGRPS; i++) {
>>>           if (i == NVMET_DEFAULT_ANA_GRPID)
>>>               port->ana_state[1] = NVME_ANA_OPTIMIZED;
>>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>>> index 8cfd60f3b564..7f9ae53c1df5 100644
>>> --- a/drivers/nvme/target/nvmet.h
>>> +++ b/drivers/nvme/target/nvmet.h
>>> @@ -158,6 +158,7 @@ struct nvmet_port {
>>>       struct config_group        ana_groups_group;
>>>       struct nvmet_ana_group        ana_default_group;
>>>       enum nvme_ana_state        *ana_state;
>>> +    struct key            *keyring;
>>>       void                *priv;
>>>       bool                enabled;
>>>       int                inline_data_size;
>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>> index f19ea9d923fd..77fa339008e1 100644
>>> --- a/drivers/nvme/target/tcp.c
>>> +++ b/drivers/nvme/target/tcp.c
>>> @@ -8,9 +8,13 @@
>>>   #include <linux/init.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/err.h>
>>> +#include <linux/key.h>
>>>   #include <linux/nvme-tcp.h>
>>> +#include <linux/nvme-keyring.h>
>>>   #include <net/sock.h>
>>>   #include <net/tcp.h>
>>> +#include <net/tls.h>
>>> +#include <net/handshake.h>
>>>   #include <linux/inet.h>
>>>   #include <linux/llist.h>
>>>   #include <crypto/hash.h>
>>> @@ -66,6 +70,16 @@ device_param_cb(idle_poll_period_usecs, 
>>> &set_param_ops,
>>>   MODULE_PARM_DESC(idle_poll_period_usecs,
>>>           "nvmet tcp io_work poll till idle time period in usecs: 
>>> Default 0");
>>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>>> +/*
>>> + * TLS handshake timeout
>>> + */
>>> +static int tls_handshake_timeout = 10;
>>> +module_param(tls_handshake_timeout, int, 0644);
>>> +MODULE_PARM_DESC(tls_handshake_timeout,
>>> +         "nvme TLS handshake timeout in seconds (default 10)");
>>> +#endif
>>> +
>>>   #define NVMET_TCP_RECV_BUDGET        8
>>>   #define NVMET_TCP_SEND_BUDGET        8
>>>   #define NVMET_TCP_IO_WORK_BUDGET    64
>>> @@ -122,11 +136,13 @@ struct nvmet_tcp_cmd {
>>>   enum nvmet_tcp_queue_state {
>>>       NVMET_TCP_Q_CONNECTING,
>>> +    NVMET_TCP_Q_TLS_HANDSHAKE,
>>>       NVMET_TCP_Q_LIVE,
>>>       NVMET_TCP_Q_DISCONNECTING,
>>>   };
>>>   struct nvmet_tcp_queue {
>>> +    struct kref        kref;
>>
>> Why is kref the first member of the struct?
>>
> Habit.
> I don't mind where it'll end up.

Move it to the back together with the tls section.

> 
>>>       struct socket        *sock;
>>>       struct nvmet_tcp_port    *port;
>>>       struct work_struct    io_work;
>>> @@ -155,6 +171,10 @@ struct nvmet_tcp_queue {
>>>       struct ahash_request    *snd_hash;
>>>       struct ahash_request    *rcv_hash;
>>> +    /* TLS state */
>>> +    key_serial_t        tls_pskid;
>>> +    struct delayed_work    tls_handshake_work;
>>> +
>>>       unsigned long           poll_end;
>>>       spinlock_t        state_lock;
>>> @@ -1283,12 +1303,21 @@ static int nvmet_tcp_try_recv(struct 
>>> nvmet_tcp_queue *queue,
>>>       return ret;
>>>   }
>>> +static void nvmet_tcp_release_queue(struct kref *kref)
>>> +{
>>> +    struct nvmet_tcp_queue *queue =
>>> +        container_of(kref, struct nvmet_tcp_queue, kref);
>>> +
>>> +    WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
>>> +    queue_work(nvmet_wq, &queue->release_work);
>>> +}
>>> +
>>>   static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue 
>>> *queue)
>>>   {
>>>       spin_lock_bh(&queue->state_lock);
>>>       if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
>>>           queue->state = NVMET_TCP_Q_DISCONNECTING;
>>> -        queue_work(nvmet_wq, &queue->release_work);
>>> +        kref_put(&queue->kref, nvmet_tcp_release_queue);
>>>       }
>>>       spin_unlock_bh(&queue->state_lock);
>>>   }
>>> @@ -1485,6 +1514,8 @@ static void nvmet_tcp_release_queue_work(struct 
>>> work_struct *w)
>>>       mutex_unlock(&nvmet_tcp_queue_mutex);
>>>       nvmet_tcp_restore_socket_callbacks(queue);
>>> +    tls_handshake_cancel(queue->sock->sk);
>>> +    cancel_delayed_work_sync(&queue->tls_handshake_work);
>>
>> We should call it tls_handshake_tmo_work or something to make it
>> clear it is a timeout work.
>>
> Okay.
> 
>>>       cancel_work_sync(&queue->io_work);
>>>       /* stop accepting incoming data */
>>>       queue->rcv_state = NVMET_TCP_RECV_ERR;
>>> @@ -1512,8 +1543,13 @@ static void nvmet_tcp_data_ready(struct sock *sk)
>>>       read_lock_bh(&sk->sk_callback_lock);
>>>       queue = sk->sk_user_data;
>>> -    if (likely(queue))
>>> -        queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
>>> +    if (likely(queue)) {
>>> +        if (queue->data_ready)
>>> +            queue->data_ready(sk);
>>> +        if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
>>> +            queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
>>> +                      &queue->io_work);
>>> +    }
>>>       read_unlock_bh(&sk->sk_callback_lock);
>>>   }
>>> @@ -1621,6 +1657,83 @@ static int nvmet_tcp_set_queue_sock(struct 
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
>>> +    spin_lock_bh(&queue->state_lock);
>>> +    if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
>>
>> Is this even possible?
>>
> I guess it can happen when the socket closes during handshake; the 
> daemon might still be sending a 'done' event but 
> nvmet_tcp_schedule_release_queue() has been called.

Umm, if the socket closes during the handshake then the state
is NVMET_TCP_Q_TLS_HANDSHAKE.

p.s. you call handshake cancel in the release flow so you should be
fenced properly no?

