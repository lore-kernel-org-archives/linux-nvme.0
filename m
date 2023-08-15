Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495FAC001DE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Aug 2023 07:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YR8sY2DL7x3iXcGtF+g4jILN9Q6tfLKYzMR7RwaTmq4=; b=ym/VoePDB0do/Ujm4nkTUuca4J
	m/mA8mJVcos5n+BbY35vao65JlMGuccohFR4kKcrRt1eVAS9q46LwZsy5JsYxj/eZW8lV+lwu3jP+
	7MxXKJOiF5E2qJ+PqhYzJ5wO5D3lqNhx0aluJngjerhedGnowKCBiqW8t522+oE1MIARtMjDfZ8vC
	pQqTEwh55+7TLKwfxXOUGeBnoY1I1ANoK4j7j+uek1/hduz2aB/cmE6Op6BoQsq1AVXcMaMFx247K
	YMF8Il6bT46dZ+fx6+vT4A9ovhw7bf+RdOMZB8/RpD7t3zhtgESMgtugS06BeWqaBb3LOxty6GRKD
	+GmoRHGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVoLh-0013iH-2m;
	Tue, 15 Aug 2023 07:20:17 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVoLe-0013hq-1r
	for linux-nvme@lists.infradead.org;
	Tue, 15 Aug 2023 07:20:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C4DD1F8C1;
	Tue, 15 Aug 2023 07:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692084013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YR8sY2DL7x3iXcGtF+g4jILN9Q6tfLKYzMR7RwaTmq4=;
	b=tzZ/YFRfO60yHPlKJPsdCuYqBGvBHQCZxjqWS3GfWeoEqevRZlDgOlVyIruB+10I3u1gz/
	IwxG8PHBAcqnMYaMn8cz3eXSerEpFkWbmfPMt1xSwA1HBjXzxwU2HG/IF5fmHgW4HQjqoA
	ILLvRjuimdA36Wh34XXrF9Rw5i3NE0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692084013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YR8sY2DL7x3iXcGtF+g4jILN9Q6tfLKYzMR7RwaTmq4=;
	b=+39e51Sp84mArCNbm0IlTkNSFJcrE3N8vCTk6sbpTfO38wce5xEaduHruE9OGll9di5Mqi
	XZRB30Y3J+7ldMBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1939013909;
	Tue, 15 Aug 2023 07:20:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id nFGwBC0n22Q+BAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 15 Aug 2023 07:20:13 +0000
Message-ID: <1eca42a4-ee8e-dff3-adb0-0f4799e4f96f@suse.de>
Date: Tue, 15 Aug 2023 09:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 15/17] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-16-hare@suse.de>
 <cf21000c-177e-c882-ac30-fe3190748bae@grimberg.me>
 <bebf00fb-be2d-d6da-bd7f-4e610095decc@suse.de>
 <a7e01b78-52ba-9576-6d71-6d1f81aecd44@grimberg.me>
 <fdb8caf7-78cc-c39b-3dda-2d9db4128a34@suse.de>
 <ce3453f8-807b-301c-f18a-3d7a7bc0bca7@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ce3453f8-807b-301c-f18a-3d7a7bc0bca7@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230815_002014_791219_420D5A6E 
X-CRM114-Status: GOOD (  19.99  )
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

On 8/15/23 09:01, Sagi Grimberg wrote:
> 
>>>>>> @@ -1864,6 +1877,14 @@ static struct config_group 
>>>>>> *nvmet_ports_make(struct config_group *group,
>>>>>>           return ERR_PTR(-ENOMEM);
>>>>>>       }
>>>>>> +    if (nvme_keyring_id()) {
>>>>>> +        port->keyring = key_lookup(nvme_keyring_id());
>>>>>> +        if (IS_ERR(port->keyring)) {
>>>>>> +            pr_warn("NVMe keyring not available, disabling TLS\n");
>>>>>> +            port->keyring = NULL;
>>>>>
>>>>> why setting this to NULL?
>>>>>
>>>> It's check when changing TSAS; we can only enable TLS if the nvme 
>>>> keyring is available.
>>>
>>> ok
>>>
>>>>
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>>       for (i = 1; i <= NVMET_MAX_ANAGRPS; i++) {
>>>>>>           if (i == NVMET_DEFAULT_ANA_GRPID)
>>>>>>               port->ana_state[1] = NVME_ANA_OPTIMIZED;
>>>>>> diff --git a/drivers/nvme/target/nvmet.h 
>>>>>> b/drivers/nvme/target/nvmet.h
>>>>>> index 8cfd60f3b564..7f9ae53c1df5 100644
>>>>>> --- a/drivers/nvme/target/nvmet.h
>>>>>> +++ b/drivers/nvme/target/nvmet.h
>>>>>> @@ -158,6 +158,7 @@ struct nvmet_port {
>>>>>>       struct config_group        ana_groups_group;
>>>>>>       struct nvmet_ana_group        ana_default_group;
>>>>>>       enum nvme_ana_state        *ana_state;
>>>>>> +    struct key            *keyring;
>>>>>>       void                *priv;
>>>>>>       bool                enabled;
>>>>>>       int                inline_data_size;
>>>>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>>>>> index f19ea9d923fd..77fa339008e1 100644
>>>>>> --- a/drivers/nvme/target/tcp.c
>>>>>> +++ b/drivers/nvme/target/tcp.c
>>>>>> @@ -8,9 +8,13 @@
>>>>>>   #include <linux/init.h>
>>>>>>   #include <linux/slab.h>
>>>>>>   #include <linux/err.h>
>>>>>> +#include <linux/key.h>
>>>>>>   #include <linux/nvme-tcp.h>
>>>>>> +#include <linux/nvme-keyring.h>
>>>>>>   #include <net/sock.h>
>>>>>>   #include <net/tcp.h>
>>>>>> +#include <net/tls.h>
>>>>>> +#include <net/handshake.h>
>>>>>>   #include <linux/inet.h>
>>>>>>   #include <linux/llist.h>
>>>>>>   #include <crypto/hash.h>
>>>>>> @@ -66,6 +70,16 @@ device_param_cb(idle_poll_period_usecs, 
>>>>>> &set_param_ops,
>>>>>>   MODULE_PARM_DESC(idle_poll_period_usecs,
>>>>>>           "nvmet tcp io_work poll till idle time period in usecs: 
>>>>>> Default 0");
>>>>>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>>>>>> +/*
>>>>>> + * TLS handshake timeout
>>>>>> + */
>>>>>> +static int tls_handshake_timeout = 10;
>>>>>> +module_param(tls_handshake_timeout, int, 0644);
>>>>>> +MODULE_PARM_DESC(tls_handshake_timeout,
>>>>>> +         "nvme TLS handshake timeout in seconds (default 10)");
>>>>>> +#endif
>>>>>> +
>>>>>>   #define NVMET_TCP_RECV_BUDGET        8
>>>>>>   #define NVMET_TCP_SEND_BUDGET        8
>>>>>>   #define NVMET_TCP_IO_WORK_BUDGET    64
>>>>>> @@ -122,11 +136,13 @@ struct nvmet_tcp_cmd {
>>>>>>   enum nvmet_tcp_queue_state {
>>>>>>       NVMET_TCP_Q_CONNECTING,
>>>>>> +    NVMET_TCP_Q_TLS_HANDSHAKE,
>>>>>>       NVMET_TCP_Q_LIVE,
>>>>>>       NVMET_TCP_Q_DISCONNECTING,
>>>>>>   };
>>>>>>   struct nvmet_tcp_queue {
>>>>>> +    struct kref        kref;
>>>>>
>>>>> Why is kref the first member of the struct?
>>>>>
>>>> Habit.
>>>> I don't mind where it'll end up.
>>>
>>> Move it to the back together with the tls section.
>>>
>>>>
>>>>>>       struct socket        *sock;
>>>>>>       struct nvmet_tcp_port    *port;
>>>>>>       struct work_struct    io_work;
>>>>>> @@ -155,6 +171,10 @@ struct nvmet_tcp_queue {
>>>>>>       struct ahash_request    *snd_hash;
>>>>>>       struct ahash_request    *rcv_hash;
>>>>>> +    /* TLS state */
>>>>>> +    key_serial_t        tls_pskid;
>>>>>> +    struct delayed_work    tls_handshake_work;
>>>>>> +
>>>>>>       unsigned long           poll_end;
>>>>>>       spinlock_t        state_lock;
>>>>>> @@ -1283,12 +1303,21 @@ static int nvmet_tcp_try_recv(struct 
>>>>>> nvmet_tcp_queue *queue,
>>>>>>       return ret;
>>>>>>   }
>>>>>> +static void nvmet_tcp_release_queue(struct kref *kref)
>>>>>> +{
>>>>>> +    struct nvmet_tcp_queue *queue =
>>>>>> +        container_of(kref, struct nvmet_tcp_queue, kref);
>>>>>> +
>>>>>> +    WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
>>>>>> +    queue_work(nvmet_wq, &queue->release_work);
>>>>>> +}
>>>>>> +
>>>>>>   static void nvmet_tcp_schedule_release_queue(struct 
>>>>>> nvmet_tcp_queue *queue)
>>>>>>   {
>>>>>>       spin_lock_bh(&queue->state_lock);
>>>>>>       if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
>>>>>>           queue->state = NVMET_TCP_Q_DISCONNECTING;
>>>>>> -        queue_work(nvmet_wq, &queue->release_work);
>>>>>> +        kref_put(&queue->kref, nvmet_tcp_release_queue);
>>>>>>       }
>>>>>>       spin_unlock_bh(&queue->state_lock);
>>>>>>   }
>>>>>> @@ -1485,6 +1514,8 @@ static void 
>>>>>> nvmet_tcp_release_queue_work(struct work_struct *w)
>>>>>>       mutex_unlock(&nvmet_tcp_queue_mutex);
>>>>>>       nvmet_tcp_restore_socket_callbacks(queue);
>>>>>> +    tls_handshake_cancel(queue->sock->sk);
>>>>>> +    cancel_delayed_work_sync(&queue->tls_handshake_work);
>>>>>
>>>>> We should call it tls_handshake_tmo_work or something to make it
>>>>> clear it is a timeout work.
>>>>>
>>>> Okay.
>>>>
>>>>>>       cancel_work_sync(&queue->io_work);
>>>>>>       /* stop accepting incoming data */
>>>>>>       queue->rcv_state = NVMET_TCP_RECV_ERR;
>>>>>> @@ -1512,8 +1543,13 @@ static void nvmet_tcp_data_ready(struct 
>>>>>> sock *sk)
>>>>>>       read_lock_bh(&sk->sk_callback_lock);
>>>>>>       queue = sk->sk_user_data;
>>>>>> -    if (likely(queue))
>>>>>> -        queue_work_on(queue_cpu(queue), nvmet_tcp_wq, 
>>>>>> &queue->io_work);
>>>>>> +    if (likely(queue)) {
>>>>>> +        if (queue->data_ready)
>>>>>> +            queue->data_ready(sk);
>>>>>> +        if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
>>>>>> +            queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
>>>>>> +                      &queue->io_work);
>>>>>> +    }
>>>>>>       read_unlock_bh(&sk->sk_callback_lock);
>>>>>>   }
>>>>>> @@ -1621,6 +1657,83 @@ static int nvmet_tcp_set_queue_sock(struct 
>>>>>> nvmet_tcp_queue *queue)
>>>>>>       return ret;
>>>>>>   }
>>>>>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>>>>>> +static void nvmet_tcp_tls_handshake_done(void *data, int status,
>>>>>> +                     key_serial_t peerid)
>>>>>> +{
>>>>>> +    struct nvmet_tcp_queue *queue = data;
>>>>>> +
>>>>>> +    pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
>>>>>> +         queue->idx, peerid, status);
>>>>>> +    spin_lock_bh(&queue->state_lock);
>>>>>> +    if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
>>>>>
>>>>> Is this even possible?
>>>>>
>>>> I guess it can happen when the socket closes during handshake; the 
>>>> daemon might still be sending a 'done' event but 
>>>> nvmet_tcp_schedule_release_queue() has been called.
>>>
>>> Umm, if the socket closes during the handshake then the state
>>> is NVMET_TCP_Q_TLS_HANDSHAKE.
>>>
>> But there's a race window between setting it to 
>> NVMET_TCP_Q_DISCONNECTING and calling tls_handshake_cancel().
>>
>>> p.s. you call handshake cancel in the release flow so you should be
>>> fenced properly no?
>> Not really. But I'll check if I can fix it up.
> 
> The teardown handling feels complicated to me.
> 
You tell me. TLS timeout handling always gets in the way.
But I've reworked it now to look slightly better.

> How are you testing it btw?

As outlined in the patchset description.
I've a target configuration running over the loopback interface.

Will expand to have two VMs talking to each other; however, that
needs more fiddling with the PSK deployment.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


