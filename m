Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48951EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 08:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5V9zwjDBETfsgnUsDaVrgPAcqMUGWtU8SPWKgIp3Hac=; b=YdyZZxhpiOJyJxU6R6N4hgTQRc
	qJw3CamgX0uGBGva7e2c0gm3dJE6/ZSBWNmUdfHslbm1ILIH1hjsmWqz3i3M8E6QbclVLRBC8pa8A
	WKK1+2wKhukLwn/N4inFORuGtPpvD+PHaRmFIvir+8D4Q0SIG6II4KaRiJNu452krr+ZjuM/6MP1x
	qqyLjXouK3z7vdHYwC7Mao7tCGdz/yvA8qKxNIixUwJFKWRtaB1yF3byUBBjupRvAnYznZRSJ/YII
	g8PZLtlHXJbYPduQzPXMLrJhXmv3pz45xb9O5bdNvI0UN0QLYHZbNoDMRcbgQpDN7TBvqhphBtc0P
	z42DCBcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvfT-00GSX4-1q;
	Mon, 07 Aug 2023 08:32:47 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvfM-00GSUS-2e
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 08:32:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2600421889;
	Mon,  7 Aug 2023 08:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691397157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5V9zwjDBETfsgnUsDaVrgPAcqMUGWtU8SPWKgIp3Hac=;
	b=lN7ZfMx+c38JArZOjxD2ZQI5ZfYBeSRYUtrwWMdNLYkfxNBMgHzaLm5/A3wEiAxZUDfOmB
	P0nQQ9LFM//XKgS/3wpk8DAPgPOx13L230A5rsXBJuInhhn5MeHJZIlSYNPZjFfi7TAM2y
	Z/psC8kFVimrNPF5JzhhG61hZ20xLcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691397157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5V9zwjDBETfsgnUsDaVrgPAcqMUGWtU8SPWKgIp3Hac=;
	b=VZDlJXThwtX2SXEqTzmN8MJCNi5OVFbN9EqBwhTOtjrtfmg79UWyYeKkxc1FUBirWdqeuZ
	FKqWOBaAfi0rZOBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACD8A13487;
	Mon,  7 Aug 2023 08:32:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Z7Y4JySs0GScBgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 07 Aug 2023 08:32:36 +0000
Message-ID: <2861a805-150a-dc92-1067-e62cea4b9b5a@suse.de>
Date: Mon, 7 Aug 2023 10:32:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 08/14] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-9-hare@suse.de>
 <6a2b615a-b618-0152-4292-7640cbaebfef@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <6a2b615a-b618-0152-4292-7640cbaebfef@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_013241_156144_9412EE69 
X-CRM114-Status: GOOD (  28.85  )
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

On 8/7/23 10:20, Sagi Grimberg wrote:
> 
> 
> On 8/3/23 13:50, Hannes Reinecke wrote:
>> Add a fabrics option 'tls' and start the TLS handshake upcall
>> with the default PSK. When TLS is started the PSK key serial
>> number is displayed in the sysfs attribute 'tls_key'
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/Kconfig   |  14 ++++
>>   drivers/nvme/host/core.c    |   2 +-
>>   drivers/nvme/host/fabrics.c |  12 ++++
>>   drivers/nvme/host/fabrics.h |   3 +
>>   drivers/nvme/host/nvme.h    |   1 +
>>   drivers/nvme/host/sysfs.c   |  20 ++++++
>>   drivers/nvme/host/tcp.c     | 130 ++++++++++++++++++++++++++++++++++--
>>   7 files changed, 175 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
>> index 2f6a7f8c94e8..96a74041bb0a 100644
>> --- a/drivers/nvme/host/Kconfig
>> +++ b/drivers/nvme/host/Kconfig
>> @@ -92,6 +92,20 @@ config NVME_TCP
>>         If unsure, say N.
>> +config NVME_TCP_TLS
>> +    bool "NVMe over Fabrics TCP TLS encryption support"
>> +    depends on NVME_TCP
>> +    select NVME_COMMON
>> +    select NVME_KEYRING
>> +    select NET_HANDSHAKE
>> +    help
>> +      Enables TLS encryption for NVMe TCP using the netlink handshake 
>> API.
>> +
>> +      The TLS handshake daemon is availble at
>> +      https://github.com/oracle/ktls-utils.
>> +
>> +      If unsure, say N.
>> +
>>   config NVME_AUTH
>>       bool "NVM Express over Fabrics In-Band Authentication"
>>       depends on NVME_CORE
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index dfc574d0f18d..b52e9c9bffd6 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4380,7 +4380,7 @@ static void nvme_free_ctrl(struct device *dev)
>>       if (!subsys || ctrl->instance != subsys->instance)
>>           ida_free(&nvme_instance_ida, ctrl->instance);
>> -
>> +    key_put(ctrl->tls_key);
>>       nvme_free_cels(ctrl);
>>       nvme_mpath_uninit(ctrl);
>>       nvme_auth_stop(ctrl);
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 8175d49f2909..ddad482c3537 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -647,6 +647,9 @@ static const match_table_t opt_tokens = {
>>       { NVMF_OPT_DISCOVERY,        "discovery"        },
>>       { NVMF_OPT_DHCHAP_SECRET,    "dhchap_secret=%s"    },
>>       { NVMF_OPT_DHCHAP_CTRL_SECRET,    "dhchap_ctrl_secret=%s"    },
>> +#ifdef CONFIG_NVME_TCP_TLS
>> +    { NVMF_OPT_TLS,            "tls"            },
>> +#endif
>>       { NVMF_OPT_ERR,            NULL            }
>>   };
>> @@ -671,6 +674,7 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>       opts->hdr_digest = false;
>>       opts->data_digest = false;
>>       opts->tos = -1; /* < 0 == use transport default */
>> +    opts->tls = false;
>>       options = o = kstrdup(buf, GFP_KERNEL);
>>       if (!options)
>> @@ -955,6 +959,14 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>               kfree(opts->dhchap_ctrl_secret);
>>               opts->dhchap_ctrl_secret = p;
>>               break;
>> +        case NVMF_OPT_TLS:
>> +            if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
>> +                pr_err("TLS is not supported\n");
>> +                ret = -EINVAL;
>> +                goto out;
>> +            }
>> +            opts->tls = true;
>> +            break;
>>           default:
>>               pr_warn("unknown parameter or missing value '%s' in ctrl 
>> creation request\n",
>>                   p);
>> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>> index 82e7a27ffbde..dac17c3fee26 100644
>> --- a/drivers/nvme/host/fabrics.h
>> +++ b/drivers/nvme/host/fabrics.h
>> @@ -70,6 +70,7 @@ enum {
>>       NVMF_OPT_DISCOVERY    = 1 << 22,
>>       NVMF_OPT_DHCHAP_SECRET    = 1 << 23,
>>       NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
>> +    NVMF_OPT_TLS        = 1 << 25,
>>   };
>>   /**
>> @@ -102,6 +103,7 @@ enum {
>>    * @dhchap_secret: DH-HMAC-CHAP secret
>>    * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for 
>> bi-directional
>>    *              authentication
>> + * @tls:        Start TLS encrypted connections (TCP)
>>    * @disable_sqflow: disable controller sq flow control
>>    * @hdr_digest: generate/verify header digest (TCP)
>>    * @data_digest: generate/verify data digest (TCP)
>> @@ -128,6 +130,7 @@ struct nvmf_ctrl_options {
>>       struct nvmf_host    *host;
>>       char            *dhchap_secret;
>>       char            *dhchap_ctrl_secret;
>> +    bool            tls;
>>       bool            disable_sqflow;
>>       bool            hdr_digest;
>>       bool            data_digest;
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index f35647c470af..6fe7966f720b 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -357,6 +357,7 @@ struct nvme_ctrl {
>>       struct nvme_dhchap_key *ctrl_key;
>>       u16 transaction;
>>   #endif
>> +    struct key *tls_key;
>>       /* Power saving configuration */
>>       u64 ps_max_latency_us;
>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index 212e1b05d298..03a64674d0a4 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -527,6 +527,19 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | 
>> S_IWUSR,
>>       nvme_ctrl_dhchap_ctrl_secret_show, 
>> nvme_ctrl_dhchap_ctrl_secret_store);
>>   #endif
>> +#ifdef CONFIG_NVME_TCP_TLS
>> +static ssize_t tls_key_show(struct device *dev,
>> +                struct device_attribute *attr, char *buf)
>> +{
>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> +
>> +    if (!ctrl->tls_key)
>> +        return 0;
>> +    return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
>> +}
>> +static DEVICE_ATTR_RO(tls_key);
>> +#endif
>> +
>>   static struct attribute *nvme_dev_attrs[] = {
>>       &dev_attr_reset_controller.attr,
>>       &dev_attr_rescan_controller.attr,
>> @@ -553,6 +566,9 @@ static struct attribute *nvme_dev_attrs[] = {
>>   #ifdef CONFIG_NVME_AUTH
>>       &dev_attr_dhchap_secret.attr,
>>       &dev_attr_dhchap_ctrl_secret.attr,
>> +#endif
>> +#ifdef CONFIG_NVME_TCP_TLS
>> +    &dev_attr_tls_key.attr,
>>   #endif
>>       NULL
>>   };
>> @@ -583,6 +599,10 @@ static umode_t nvme_dev_attrs_are_visible(struct 
>> kobject *kobj,
>>       if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
>>           return 0;
>>   #endif
>> +#ifdef CONFIG_NVME_TCP_TLS
>> +    if (a == &dev_attr_tls_key.attr && !ctrl->opts)
>> +        return 0;
>> +#endif
> 
> Probably you want to check that the transport is tcp.
> 
Probably.

>>       return a->mode;
>>   }
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index c3b3b938c0f9..98400ad5f969 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
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
>>   #include <linux/blk-mq.h>
>>   #include <crypto/hash.h>
>>   #include <net/busy_poll.h>
>> @@ -31,6 +35,16 @@ static int so_priority;
>>   module_param(so_priority, int, 0644);
>>   MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>> +#ifdef CONFIG_NVME_TCP_TLS
>> +/*
>> + * TLS handshake timeout
>> + */
>> +static int tls_handshake_timeout = 10;
>> +module_param(tls_handshake_timeout, int, 0644);
>> +MODULE_PARM_DESC(tls_handshake_timeout,
>> +         "nvme TLS handshake timeout in seconds (default 10)");
>> +#endif
>> +
>>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>   /* lockdep can detect a circular dependency of the form
>>    *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
>> @@ -146,7 +160,10 @@ struct nvme_tcp_queue {
>>       struct ahash_request    *snd_hash;
>>       __le32            exp_ddgst;
>>       __le32            recv_ddgst;
>> -
>> +#ifdef CONFIG_NVME_TCP_TLS
>> +    struct completion       tls_complete;
>> +    int                     tls_err;
>> +#endif
>>       struct page_frag_cache    pf_cache;
>>       void (*state_change)(struct sock *);
>> @@ -1509,7 +1526,80 @@ static void nvme_tcp_set_queue_io_cpu(struct 
>> nvme_tcp_queue *queue)
>>       queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, 
>> false);
>>   }
>> -static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>> +#ifdef CONFIG_NVME_TCP_TLS
>> +static void nvme_tcp_tls_done(void *data, int status, key_serial_t 
>> pskid)
>> +{
>> +    struct nvme_tcp_queue *queue = data;
>> +    struct nvme_tcp_ctrl *ctrl = queue->ctrl;
>> +    int qid = nvme_tcp_queue_id(queue);
>> +    struct key *tls_key;
>> +
>> +    dev_dbg(ctrl->ctrl.device, "queue %d: TLS handshake done, key %x, 
>> status %d\n",
>> +        qid, pskid, status);
>> +
>> +    if (status) {
>> +        queue->tls_err = -status;
>> +        goto out_complete;
>> +    }
>> +
>> +    tls_key = key_lookup(pskid);
>> +    if (IS_ERR(tls_key)) {
>> +        dev_warn(ctrl->ctrl.device, "queue %d: Invalid key %x\n",
>> +             qid, pskid);
>> +        queue->tls_err = -ENOKEY;
>> +    } else {
>> +        ctrl->ctrl.tls_key = tls_key;
>> +        queue->tls_err = 0;
>> +    }
>> +
>> +out_complete:
>> +    complete(&queue->tls_complete);
>> +}
>> +
>> +static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>> +                  struct nvme_tcp_queue *queue,
>> +                  key_serial_t pskid)
>> +{
>> +    int qid = nvme_tcp_queue_id(queue);
>> +    int ret;
>> +    struct tls_handshake_args args;
>> +    unsigned long tmo = tls_handshake_timeout * HZ;
>> +    key_serial_t keyring = nvme_keyring_id();
>> +
>> +    dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>> +        qid, pskid);
>> +    memset(&args, 0, sizeof(args));
>> +    args.ta_sock = queue->sock;
>> +    args.ta_done = nvme_tcp_tls_done;
>> +    args.ta_data = queue;
>> +    args.ta_my_peerids[0] = pskid;
>> +    args.ta_num_peerids = 1;
>> +    args.ta_keyring = keyring;
>> +    args.ta_timeout_ms = tls_handshake_timeout * 1000;
>> +    queue->tls_err = -EOPNOTSUPP;
>> +    init_completion(&queue->tls_complete);
>> +    ret = tls_client_hello_psk(&args, GFP_KERNEL);
>> +    if (ret) {
>> +        dev_err(nctrl->device, "queue %d: failed to start TLS: %d\n",
>> +            qid, ret);
>> +        return ret;
>> +    }
>> +    if (wait_for_completion_timeout(&queue->tls_complete, tmo) == 0) {
> 
> Maybe this should be interruptible as well?
> 
Hmm. Maybe. I'll look into it.

>> +        dev_err(nctrl->device,
>> +            "queue %d: TLS handshake timeout\n", qid);
>> +        ret = -ETIMEDOUT;
>> +    } else {
>> +        dev_dbg(nctrl->device,
>> +            "queue %d: TLS handshake complete, error %d\n",
>> +            qid, queue->tls_err);
>> +        ret = queue->tls_err;
>> +    }
>> +    return ret;
>> +}
>> +#endif
>> +
>> +static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>> +                key_serial_t pskid)
>>   {
>>       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>>       struct nvme_tcp_queue *queue = &ctrl->queues[qid];
>> @@ -1633,6 +1723,14 @@ static int nvme_tcp_alloc_queue(struct 
>> nvme_ctrl *nctrl, int qid)
>>           goto err_rcv_pdu;
>>       }
>> +#ifdef CONFIG_NVME_TCP_TLS
> 
> pskid is passed unconditionally, is the ifdef needed?
> maybe make nvme_tcp_start_tls stub if not defined?
> 
Yes, correct.
It's not defined without the #ifdef.

>> +    /* If PSKs are configured try to start TLS */
>> +    if (pskid) {
>> +        ret = nvme_tcp_start_tls(nctrl, queue, pskid);
>> +        if (ret)
>> +            goto err_init_connect;
>> +    }
>> +#endif
>>       ret = nvme_tcp_init_connection(queue);
>>       if (ret)
>>           goto err_init_connect;
>> @@ -1782,10 +1880,22 @@ static int nvme_tcp_start_io_queues(struct 
>> nvme_ctrl *ctrl,
>>   static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>>   {
>>       int ret;
>> +    key_serial_t psk_id = 0;
>> +
>> +    if (ctrl->opts->tls) {
>> +        psk_id = nvme_tls_psk_default(NULL,
>> +                          ctrl->opts->host->nqn,
>> +                          ctrl->opts->subsysnqn);
> 
> is the returned tls_key_id guaranteed to be non-zero?
> 
I _think_ so; but let me check.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


