Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3B6C001B0
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 11:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rZoqHM/oiyrMzIYtIHAU1pVjQ1jlmn9wZO+jl+JMa5Q=; b=18ltNZsqWAntSPY+UaFQ3lzBtK
	K4n4C8C+kZ02VCmRL473n9SPdnVvKFwQ/MmOUU8zkyhhj77tYz33UDUL1agOQ6752jS3bhbEr3qZE
	usPlwzMysKDE4gjHGCJqraUCrFwi1rU2PNkd3XBOoh+FqBmtjtwoD2wLannlP0MIpMWxm0P55Kj7F
	46yMkQNUDxb212a+y5l4mjbaYtdFbgLH1bZ8s7uXwoEk28nakHyO+OmIZRtjzs5pOV2E5HgmmSWed
	hnCTj1Bhc/aiXL6IeSRabXCMwtGwPwp1jq2WIYfW9Wupz47VDsecEy2mSfzdkBVKhG2aRQ8WWx56F
	Eqp4+TOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qThRV-004mWO-1v;
	Wed, 09 Aug 2023 11:33:33 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qThRR-004mVy-2I
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 11:33:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 462C41F38C;
	Wed,  9 Aug 2023 11:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691580808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZoqHM/oiyrMzIYtIHAU1pVjQ1jlmn9wZO+jl+JMa5Q=;
	b=S+LYAzcoall6oBU0iI1ETVC9bRLvFGpp/yJisXkJhbCQTGAIVgDojTP9SYhFlFUMudm9TY
	7UyUT2tVkyQRPhMMesf8eFp7DgMRKaVUqNLo0mVBFJsurPZ+sgxqnL4uYUqottzJGPZDGz
	Hyg3OIAV6pnSEnWmEoHqKTI1a47N7ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691580808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZoqHM/oiyrMzIYtIHAU1pVjQ1jlmn9wZO+jl+JMa5Q=;
	b=PHDtjqQl6rYmJOX7TcGjaOuldnwuouqyCoPbOsdALWYymJoawsg3+myhH3M2LhmfYYhMxY
	0wIyQj+SOqVF87Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36BBD133B5;
	Wed,  9 Aug 2023 11:33:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id z/b4DIh502TnUQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Aug 2023 11:33:28 +0000
Message-ID: <9a331c99-a2e3-6c4e-5d4c-a41bfeb8e741@suse.de>
Date: Wed, 9 Aug 2023 13:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-16-hare@suse.de>
 <e28dffb6-66bd-2724-6c9d-f06e5da75aeb@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e28dffb6-66bd-2724-6c9d-f06e5da75aeb@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_043329_892648_142B7F4D 
X-CRM114-Status: GOOD (  26.22  )
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

On 8/9/23 12:51, Sagi Grimberg wrote:
> 
> 
> On 8/8/23 19:53, Hannes Reinecke wrote:
>> Add functions to start the TLS handshake upcall when
>> the TCP TSAS sectype is set to 'tls1.3' and add a config
>> option NVME_TARGET_TCP_TLS.
>> And move the 'state' lock to an irq-safe lock as the 'done'
>> callback from the TLS handshake will be running in interrupt
>> context.
> 
> Really.. that is surprising. Can you describe how exactly?
> 
Let me cross-check.

>>
>> Signed-off-by: Hannes Reincke <hare@suse.de>
>> ---
>>   drivers/nvme/target/Kconfig    |  15 ++++
>>   drivers/nvme/target/configfs.c |  27 ++++++++
>>   drivers/nvme/target/nvmet.h    |   1 +
>>   drivers/nvme/target/tcp.c      | 123 +++++++++++++++++++++++++++++++--
>>   4 files changed, 161 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
>> index 79fc64035ee3..8a6c9cae804c 100644
>> --- a/drivers/nvme/target/Kconfig
>> +++ b/drivers/nvme/target/Kconfig
>> @@ -84,6 +84,21 @@ config NVME_TARGET_TCP
>>         If unsure, say N.
>> +config NVME_TARGET_TCP_TLS
>> +    bool "NVMe over Fabrics TCP target TLS encryption support"
>> +    depends on NVME_TARGET_TCP
>> +    select NVME_COMMON
>> +    select NVME_KEYRING
>> +    select NET_HANDSHAKE
>> +    select KEYS
>> +    help
>> +      Enables TLS encryption for the NVMe TCP target using the 
>> netlink handshake API.
>> +
>> +      The TLS handshake daemon is availble at
>> +      https://github.com/oracle/ktls-utils.
>> +
>> +      If unsure, say N.
>> +
>>   config NVME_TARGET_AUTH
>>       bool "NVMe over Fabrics In-band Authentication support"
>>       depends on NVME_TARGET
>> diff --git a/drivers/nvme/target/configfs.c 
>> b/drivers/nvme/target/configfs.c
>> index 3c2aeb763e22..49b407702ad5 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -15,6 +15,7 @@
>>   #ifdef CONFIG_NVME_TARGET_AUTH
>>   #include <linux/nvme-auth.h>
>>   #endif
>> +#include <linux/nvme-keyring.h>
>>   #include <crypto/hash.h>
>>   #include <crypto/kpp.h>
>> @@ -204,6 +205,14 @@ static ssize_t nvmet_addr_treq_store(struct 
>> config_item *item,
>>   found:
>>       if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
>> +        if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
>> +            pr_err("TLS is not supported\n");
>> +            return -EINVAL;
>> +        }
>> +        if (!port->keyring) {
>> +            pr_err("TLS keyring not configured\n");
>> +            return -EINVAL;
>> +        }
>>           if (port->disc_addr.tsas.tcp.sectype != 
>> NVMF_TCP_SECTYPE_TLS13) {
>>               pr_warn("cannot change TREQ when TLS is not enabled\n");
>>               return -EINVAL;
>> @@ -399,6 +408,15 @@ static ssize_t nvmet_addr_tsas_store(struct 
>> config_item *item,
>>       if (port->disc_addr.trtype != NVMF_TRTYPE_TCP)
>>           return -EINVAL;
>> +    if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
>> +        pr_err("TLS is not supported\n");
>> +        return -EINVAL;
>> +    }
>> +    if (!port->keyring) {
>> +        pr_err("TLS keyring not configured\n");
>> +        return -EINVAL;
>> +    }
>> +
>>       for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
>>           if (sysfs_streq(page, nvmet_addr_tsas_tcp[i].name))
>>               goto found;
>> @@ -1825,6 +1843,7 @@ static void nvmet_port_release(struct 
>> config_item *item)
>>       flush_workqueue(nvmet_wq);
>>       list_del(&port->global_entry);
>> +    key_put(port->keyring);
>>       kfree(port->ana_state);
>>       kfree(port);
>>   }
>> @@ -1874,6 +1893,14 @@ static struct config_group 
>> *nvmet_ports_make(struct config_group *group,
>>           return ERR_PTR(-ENOMEM);
>>       }
>> +    if (nvme_keyring_id()) {
>> +        port->keyring = key_lookup(nvme_keyring_id());
>> +        if (IS_ERR(port->keyring)) {
>> +            pr_warn("NVMe keyring not available, disabling TLS\n");
>> +            port->keyring = NULL;
>> +        }
>> +    }
>> +
>>       for (i = 1; i <= NVMET_MAX_ANAGRPS; i++) {
>>           if (i == NVMET_DEFAULT_ANA_GRPID)
>>               port->ana_state[1] = NVME_ANA_OPTIMIZED;
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 8cfd60f3b564..7f9ae53c1df5 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -158,6 +158,7 @@ struct nvmet_port {
>>       struct config_group        ana_groups_group;
>>       struct nvmet_ana_group        ana_default_group;
>>       enum nvme_ana_state        *ana_state;
>> +    struct key            *keyring;
>>       void                *priv;
>>       bool                enabled;
>>       int                inline_data_size;
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index a8ceef6e5a7b..75e4cb4c2f29 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -8,9 +8,13 @@
>>   #include <linux/init.h>
>>   #include <linux/slab.h>
>>   #include <linux/err.h>
>> +#include <linux/key.h>
>>   #include <linux/nvme-tcp.h>
>> +#include <linux/nvme-keyring.h>
>>   #include <net/sock.h>
>>   #include <net/tcp.h>
>> +#include <net/tls.h>
>> +#include <net/handshake.h>
>>   #include <linux/inet.h>
>>   #include <linux/llist.h>
>>   #include <crypto/hash.h>
>> @@ -66,6 +70,16 @@ device_param_cb(idle_poll_period_usecs, 
>> &set_param_ops,
>>   MODULE_PARM_DESC(idle_poll_period_usecs,
>>           "nvmet tcp io_work poll till idle time period in usecs: 
>> Default 0");
>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>> +/*
>> + * TLS handshake timeout
>> + */
>> +static int tls_handshake_timeout = 10;
>> +module_param(tls_handshake_timeout, int, 0644);
>> +MODULE_PARM_DESC(tls_handshake_timeout,
>> +         "nvme TLS handshake timeout in seconds (default 30)");
> 
> modparam description is lying...
> 
Yeah, don't trust it :-)

>> +#endif
>> +
>>   #define NVMET_TCP_RECV_BUDGET        8
>>   #define NVMET_TCP_SEND_BUDGET        8
>>   #define NVMET_TCP_IO_WORK_BUDGET    64
>> @@ -122,6 +136,7 @@ struct nvmet_tcp_cmd {
>>   enum nvmet_tcp_queue_state {
>>       NVMET_TCP_Q_CONNECTING,
>> +    NVMET_TCP_Q_TLS_HANDSHAKE,
>>       NVMET_TCP_Q_LIVE,
>>       NVMET_TCP_Q_DISCONNECTING,
>>   };
>> @@ -154,6 +169,8 @@ struct nvmet_tcp_queue {
>>       bool            data_digest;
>>       struct ahash_request    *snd_hash;
>>       struct ahash_request    *rcv_hash;
>> +    key_serial_t        tls_pskid;
>> +    struct delayed_work    tls_handshake_work;
>>       unsigned long           poll_end;
>> @@ -1285,12 +1302,12 @@ static int nvmet_tcp_try_recv(struct 
>> nvmet_tcp_queue *queue,
>>   static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue 
>> *queue)
>>   {
>> -    spin_lock(&queue->state_lock);
>> +    spin_lock_irq(&queue->state_lock);
>>       if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
>>           queue->state = NVMET_TCP_Q_DISCONNECTING;
>>           queue_work(nvmet_wq, &queue->release_work);
>>       }
>> -    spin_unlock(&queue->state_lock);
>> +    spin_unlock_irq(&queue->state_lock);
>>   }
>>   static inline void nvmet_tcp_arm_queue_deadline(struct 
>> nvmet_tcp_queue *queue)
>> @@ -1512,8 +1529,12 @@ static void nvmet_tcp_data_ready(struct sock *sk)
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
>> @@ -1621,6 +1642,75 @@ static int nvmet_tcp_set_queue_sock(struct 
>> nvmet_tcp_queue *queue)
>>       return ret;
>>   }
>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>> +static void nvmet_tcp_tls_handshake_done(void *data, int status,
>> +                     key_serial_t peerid)
>> +{
>> +    struct nvmet_tcp_queue *queue = data;
>> +
>> +    pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
>> +         queue->idx, peerid, status);
>> +    spin_lock_irq(&queue->state_lock);
>> +    if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
>> +        pr_warn("queue %d: TLS handshake already completed\n",
>> +            queue->idx);
>> +        spin_unlock_irq(&queue->state_lock);
>> +        return;
>> +    }
>> +    if (!status)
>> +        queue->tls_pskid = peerid;
>> +    queue->state = NVMET_TCP_Q_CONNECTING;
>> +    spin_unlock_irq(&queue->state_lock);
>> +
>> +    cancel_delayed_work_sync(&queue->tls_handshake_work);
>> +    if (status) {
> 
> I think that after this call, you cannot reference anything
> in queue as it may have been released. Or I'm missing something?
> 
I guess I can, as this code is gated by the state change above.
Once we are here the state has been updated, so the timeout work will
short circuit and not delete the queue.

Cheers,

Hannes


