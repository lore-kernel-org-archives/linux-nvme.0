Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD89C76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 14:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gvxEE2aNnA3XbOaHfc+5ocmk6LqQv7k+kw2RrxxjdfU=; b=V+QJLnXgToaxj+I1OaVFE7dQZE
	o/XkuAEYQgDHDwXMdMwWFDYJKk+mpFDBq17TdvSyCWL/3rHRmSkBA/wnmESA816BqV7hdGH9M+kYG
	ey0y0FxQTI5hDo7gQib0cpXcKqTgwezLSh6L9cXjQtbcTRZvoWBz1DN+8/GwL7vylSjmoqddBGrpc
	7cFiwRzcqrlVvINmGpHPRsPGlCH6bqz9lh95JLwyP4QWtoN7ZIxT7vWWwpiDlzvQDUxZATZTB54V+
	fgPZyjikUDMWUfmuGV9y/FNoGfyaS4TGhpFSek/YWyLclMIEiPJ3GJBkQNE+Bwwhe0MS6SF9Cn+vh
	jS3WwPpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjKoV-00FZXp-1Q;
	Mon, 03 Apr 2023 14:05:39 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjKoP-00FZUJ-2x
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 14:05:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77AFF21DB1;
	Mon,  3 Apr 2023 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680530728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvxEE2aNnA3XbOaHfc+5ocmk6LqQv7k+kw2RrxxjdfU=;
	b=cxJ3yQVb6AoJso8/VE6/ioa8vvIugiCippmeaz6MHQmM/hUuborMk7dTjXsmiKAvhPcpYZ
	3uj0hiw8zxE1nqOWhU9+NX5WpZ1u0eMefzLNxsKTvVAjEJ5hayL6ii4H2Y694Kctm8ET/o
	6o8zP6GVaEaQT8SfHO64+L0vjKDYFtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680530728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvxEE2aNnA3XbOaHfc+5ocmk6LqQv7k+kw2RrxxjdfU=;
	b=kFvSoGl61Es6hXLBCP4DCCqS4e06hcjwcIP3sUS7vNGIpptKvfWU9gq1DYBf4tTXtmU1m6
	/2+g0oZg/PV2OcBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C41E13416;
	Mon,  3 Apr 2023 14:05:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id fcuHFSjdKmS0CgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Apr 2023 14:05:28 +0000
Message-ID: <b9fdafa4-b811-7242-e0b9-ea04bb7a5ca8@suse.de>
Date: Mon, 3 Apr 2023 16:05:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-16-hare@suse.de>
 <e1cf08ad-de6e-c41b-9fd3-de78b3a7d362@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
In-Reply-To: <e1cf08ad-de6e-c41b-9fd3-de78b3a7d362@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_070535_931058_340DA449 
X-CRM114-Status: GOOD (  39.24  )
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

On 4/3/23 14:51, Sagi Grimberg wrote:
> 
>> Add functions to start the TLS handshake upcall when
>> the TCP RSAS sectype is set to 'tls1.3'.
> 
> TSAS
> 
Ok.

>>
>> Signed-off-by: Hannes Reincke <hare@suse.de>
>> ---
>>   drivers/nvme/target/configfs.c |  32 +++++++-
>>   drivers/nvme/target/tcp.c      | 135 ++++++++++++++++++++++++++++++++-
>>   2 files changed, 163 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/target/configfs.c 
>> b/drivers/nvme/target/configfs.c
>> index ca66ee6dc153..36fbf6a22d09 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -159,10 +159,12 @@ static const struct nvmet_type_name_map 
>> nvmet_addr_treq[] = {
>>       { NVMF_TREQ_NOT_REQUIRED,    "not required" },
>>   };
>> +#define NVMET_PORT_TREQ(port) ((port)->disc_addr.treq & 
>> NVME_TREQ_SECURE_CHANNEL_MASK)
> 
> Can you make it a static inline?
> 
Sure.

>> +
>>   static ssize_t nvmet_addr_treq_show(struct config_item *item, char 
>> *page)
>>   {
>> -    u8 treq = to_nvmet_port(item)->disc_addr.treq &
>> -        NVME_TREQ_SECURE_CHANNEL_MASK;
>> +    struct nvmet_port *port = to_nvmet_port(item);
>> +    u8 treq = NVMET_PORT_TREQ(port);
>>       int i;
>>       for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
>> @@ -193,6 +195,17 @@ static ssize_t nvmet_addr_treq_store(struct 
>> config_item *item,
>>       return -EINVAL;
>>   found:
>> +#ifdef CONFIG_NVME_TLS
>> +    if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
>> +        if (port->disc_addr.tsas.tcp.sectype != 
>> NVMF_TCP_SECTYPE_TLS13) {
>> +            pr_warn("cannot change TREQ when TLS is not enabled\n");
>> +            return -EINVAL;
>> +        } else if (nvmet_addr_treq[i].type == NVMF_TREQ_NOT_SPECIFIED) {
>> +            pr_warn("cannot set TREQ to 'not specified' when TLS is 
>> enabled\n");
>> +            return -EINVAL;
>> +        }
>> +    }
> 
> Is this code wrong if CONFIG_NVME_TLS is not enabled?
> 
Strictly speaking, no; it just won't do anything except from having a 
different value in the discovery log page.

>> +#endif
>>       treq |= nvmet_addr_treq[i].type;
>>       port->disc_addr.treq = treq;
>>       return count;
>> @@ -373,6 +386,7 @@ static ssize_t nvmet_addr_tsas_store(struct 
>> config_item *item,
>>           const char *page, size_t count)
>>   {
>>       struct nvmet_port *port = to_nvmet_port(item);
>> +    u8 treq = port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK;
>>       int i;
>>       if (nvmet_is_port_enabled(port, __func__))
>> @@ -391,6 +405,20 @@ static ssize_t nvmet_addr_tsas_store(struct 
>> config_item *item,
>>   found:
>>       nvmet_port_init_tsas_tcp(port, nvmet_addr_tsas_tcp[i].type);
>> +    if (nvmet_addr_tsas_tcp[i].type == NVMF_TCP_SECTYPE_TLS13) {
>> +#ifdef CONFIG_NVME_TLS
> 
> Maybe in the start of the function just do:
> 
>      if (!IS_ENABLED(CONFIG_NVME_TLS)) {
>          pr_err("TLS not supported\n");
>          return -EINVAL;
>      }
> 
> Instead of incorporating it here.
> 
Ok.

>> +        if (NVMET_PORT_TREQ(port) == NVMF_TREQ_NOT_SPECIFIED)
>> +            treq |= NVMF_TREQ_REQUIRED;
>> +        else
>> +            treq |= NVMET_PORT_TREQ(port);
>> +#else
>> +        pr_err("TLS not supported\n");
>> +        return -EINVAL;
>> +#endif
>> +    } else {
>> +        /* Set to 'not specified' if TLS is not enabled */
>> +        treq |= NVMF_TREQ_NOT_SPECIFIED;
>> +    }
>>       return count;
>>   }
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 5931971d715f..ebec882120fd 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -11,6 +11,10 @@
>>   #include <linux/nvme-tcp.h>
>>   #include <net/sock.h>
>>   #include <net/tcp.h>
>> +#ifdef CONFIG_NVME_TLS
>> +#include <net/handshake.h>
> 
> Is net/handshake.h under an ifdef? If so, CONFIG_NVME_TLS should
> select it.
> 
>> +#include <linux/nvme-keyring.h>
> 
> will this include not work if CONFIG_NVME_TLS not work?
> <linux/nvme-auth.h> is not under CONFIG_NVME_AUTH for example.
> 
Hmm. Should. I can remove the ifdefs

>> +#endif
>>   #include <linux/inet.h>
>>   #include <linux/llist.h>
>>   #include <crypto/hash.h>
>> @@ -40,6 +44,16 @@ module_param(idle_poll_period_usecs, int, 0644);
>>   MODULE_PARM_DESC(idle_poll_period_usecs,
>>           "nvmet tcp io_work poll till idle time period in usecs");
>> +#ifdef CONFIG_NVME_TLS
>> +/*
>> + * TLS handshake timeout
>> + */
>> +static int tls_handshake_timeout = 30;
>> +module_param(tls_handshake_timeout, int, 0644);
>> +MODULE_PARM_DESC(tls_handshake_timeout,
>> +         "nvme TLS handshake timeout in seconds (default 30)");
>> +#endif
>> +
>>   #define NVMET_TCP_RECV_BUDGET        8
>>   #define NVMET_TCP_SEND_BUDGET        8
>>   #define NVMET_TCP_IO_WORK_BUDGET    64
>> @@ -130,6 +144,10 @@ struct nvmet_tcp_queue {
>>       bool            data_digest;
>>       struct ahash_request    *snd_hash;
>>       struct ahash_request    *rcv_hash;
>> +#ifdef CONFIG_NVME_TLS
>> +    struct key        *tls_psk;
>> +    struct delayed_work    tls_handshake_work;
>> +#endif
> 
> If these won't be under CONFIG_NVME_TLS will it save a lot of the other
> ifdefs in the code?
> 
Wasn't sure if we always want to have it.
But if we do, sure, things will be easier.

>>       unsigned long           poll_end;
>> @@ -1474,6 +1492,10 @@ static void nvmet_tcp_release_queue_work(struct 
>> work_struct *w)
>>       nvmet_tcp_free_cmds(queue);
>>       if (queue->hdr_digest || queue->data_digest)
>>           nvmet_tcp_free_crypto(queue);
>> +#ifdef CONFIG_NVME_TLS
>> +    if (queue->tls_psk)
>> +        key_put(queue->tls_psk);
> 
> key_put is NULL safe.
> 
>> +#endif
>>       ida_free(&nvmet_tcp_queue_ida, queue->idx);
>>       page = virt_to_head_page(queue->pf_cache.va);
>>       __page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
>> @@ -1488,8 +1510,12 @@ static void nvmet_tcp_data_ready(struct sock *sk)
>>       read_lock_bh(&sk->sk_callback_lock);
>>       queue = sk->sk_user_data;
>> -    if (likely(queue))
>> -        queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
>> +    if (queue->data_ready)
>> +        queue->data_ready(sk);
>> +    if (likely(queue) &&
>> +        queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
>> +        queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
>> +                  &queue->io_work);
>>       read_unlock_bh(&sk->sk_callback_lock);
>>   }
>> @@ -1597,6 +1623,89 @@ static int nvmet_tcp_set_queue_sock(struct 
>> nvmet_tcp_queue *queue)
>>       return ret;
>>   }
>> +#ifdef CONFIG_NVME_TLS
>> +static void nvmet_tcp_tls_queue_restart(struct nvmet_tcp_queue *queue)
>> +{
>> +    spin_lock(&queue->state_lock);
>> +    if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
>> +        pr_warn("queue %d: TLS handshake already completed\n",
>> +            queue->idx);
>> +        spin_unlock(&queue->state_lock);
>> +        return;
>> +    }
>> +    queue->state = NVMET_TCP_Q_CONNECTING;
>> +    spin_unlock(&queue->state_lock);
>> +
>> +    pr_debug("queue %d: restarting queue after TLS handshake\n",
>> +         queue->idx);
>> +    /*
>> +     * Set callbacks after handshake; TLS implementation
>> +     * might have changed the socket callbacks.
>> +     */
>> +    nvmet_tcp_set_queue_sock(queue);
> 
> Maybe fold it into the caller? The name is confusing anyways.
> The queue is not restarted, it is post-configured for lack of
> a better term.
> 
I see what I can do.

>> +}
>> +
>> +static void nvmet_tcp_tls_handshake_done(void *data, int status,
>> +                     key_serial_t peerid)
> 
>                      pskid.
> 
>> +{
>> +    struct nvmet_tcp_queue *queue = data;
>> +
>> +    pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
>> +         queue->idx, peerid, status);
>> +    if (!status) {
>> +        spin_lock(&queue->state_lock);
>> +        queue->tls_psk = key_lookup(peerid);
>> +        if (IS_ERR(queue->tls_psk)) {
>> +            pr_warn("queue %d: TLS key %x not found\n",
>> +                queue->idx, peerid);
>> +            queue->tls_psk = NULL;
> 
> Here you let the timeout take care of it later?

Well, this is a slightly odd case; we get a '0' status but failed
to lookup the key.
_Technically_ we should be able to continue, but wasn't sure if I should.

But in the light of the key rotation discussion I probably should; new 
keys (and keyrings) might be provided at any time, so I might hit that 
case here.

Will be updating the code.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


