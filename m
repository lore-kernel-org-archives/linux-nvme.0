Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3A0C77B70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 15:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ak1K+vRmIloYPOQ3MJjjTi4yIDrE8JaA30dlZZ/rLBg=; b=kbddzMDTuptRLDGEynKBCLy1kn
	VeU9pSiUFtqybtXPxyyK+NSAgAJuAFRGw/MvRN1n9nBsiinEMlpw8cvcpT7vX9DAhyezqZ7qD7Otf
	N8v8fxhqnahQpkWdOHobrhAr7ROxZDSZQuendozIaRNyukP4AyemkSFnHpxIMqzzP+HClBR+QrLoD
	KAFPgQSDlSihG0QadNGhrr8hwst3cOV19KzzHG4eq6Ka5gDv2c8zBrnFrcV/iFIkiGVdkYY/PodQC
	pX1rc4hCEcTVlVtRoK1+u5anbmJY/Oy1DDTLEGt+2Mn77yH2cjVW9k3bmTKxTtGicv17+5f9f1H0s
	O7//jreQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poQmi-00GtIQ-36;
	Mon, 17 Apr 2023 15:28:52 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poQmd-00GtFS-2R
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 15:28:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 14B531F86C;
	Mon, 17 Apr 2023 15:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681745323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ak1K+vRmIloYPOQ3MJjjTi4yIDrE8JaA30dlZZ/rLBg=;
	b=za6X6QoMnUyaquiC9ok1b3Pn121gPNYwXGfNXHmJqzpZO4PwiD4bxSKRuar1sXuX6Qnurx
	W04359B/2O5FWwRNFCmLefOHZRQe1ryeVkNlo8hur/HmlGf5KhtuxmwFupfN4eDPVjSow+
	GvQq2oE1lIJXfhPVKIEe6Nferh7md0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681745323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ak1K+vRmIloYPOQ3MJjjTi4yIDrE8JaA30dlZZ/rLBg=;
	b=ZLes80kHx5gQp9gA7aHAsD9HqRxR+daZDvSGcImEJOa9aEOKCnI8F4n6cAvMqFZcsXADtA
	NzDcEFyi5oyj02Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2D661390E;
	Mon, 17 Apr 2023 15:28:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pE2ENKplPWSkNQAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 17 Apr 2023 15:28:42 +0000
Message-ID: <4e9b3f94-b059-b225-9fa6-68178ebda990@suse.de>
Date: Mon, 17 Apr 2023 17:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 11/18] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-12-hare@suse.de>
 <73d59afa-d385-2616-fc74-13ad3bfe49be@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <73d59afa-d385-2616-fc74-13ad3bfe49be@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_082848_085949_4FB18F42 
X-CRM114-Status: GOOD (  26.00  )
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

On 4/17/23 17:26, Sagi Grimberg wrote:
> 
> 
> On 4/17/23 16:02, Hannes Reinecke wrote:
>> Add a fabrics option 'tls' and start the TLS handshake upcall
>> with the default PSK. When TLS is started the PSK key serial
>> number is displayed in the sysfs attribute 'tls_key'
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/Kconfig   |  14 ++++
>>   drivers/nvme/host/core.c    |  23 ++++++-
>>   drivers/nvme/host/fabrics.c |  10 +++
>>   drivers/nvme/host/fabrics.h |   3 +
>>   drivers/nvme/host/nvme.h    |   1 +
>>   drivers/nvme/host/tcp.c     | 127 ++++++++++++++++++++++++++++++++++--
>>   6 files changed, 170 insertions(+), 8 deletions(-)
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
>> index 79aa215aec76..937013127c91 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3889,6 +3889,19 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO 
>> | S_IWUSR,
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
>> @@ -3915,6 +3928,9 @@ static struct attribute *nvme_dev_attrs[] = {
>>   #ifdef CONFIG_NVME_AUTH
>>       &dev_attr_dhchap_secret.attr,
>>       &dev_attr_dhchap_ctrl_secret.attr,
>> +#endif
>> +#ifdef CONFIG_NVME_TCP_TLS
>> +    &dev_attr_tls_key.attr,
>>   #endif
>>       NULL
>>   };
>> @@ -3945,7 +3961,10 @@ static umode_t 
>> nvme_dev_attrs_are_visible(struct kobject *kobj,
>>       if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
>>           return 0;
>>   #endif
>> -
>> +#ifdef CONFIG_NVME_TCP_TLS
>> +    if (a == &dev_attr_tls_key.attr && !ctrl->opts)
>> +        return 0;
>> +#endif
>>       return a->mode;
>>   }
>> @@ -5080,7 +5099,7 @@ static void nvme_free_ctrl(struct device *dev)
>>       if (!subsys || ctrl->instance != subsys->instance)
>>           ida_free(&nvme_instance_ida, ctrl->instance);
>> -
>> +    key_put(ctrl->tls_key);
>>       nvme_free_cels(ctrl);
>>       nvme_mpath_uninit(ctrl);
>>       nvme_auth_stop(ctrl);
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index bbaa04a0c502..a8d6c22515ca 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -609,6 +609,7 @@ static const match_table_t opt_tokens = {
>>       { NVMF_OPT_DISCOVERY,        "discovery"        },
>>       { NVMF_OPT_DHCHAP_SECRET,    "dhchap_secret=%s"    },
>>       { NVMF_OPT_DHCHAP_CTRL_SECRET,    "dhchap_ctrl_secret=%s"    },
>> +    { NVMF_OPT_TLS,            "tls"            },
>>       { NVMF_OPT_ERR,            NULL            }
>>   };
>> @@ -632,6 +633,7 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>       opts->hdr_digest = false;
>>       opts->data_digest = false;
>>       opts->tos = -1; /* < 0 == use transport default */
>> +    opts->tls = false;
>>       options = o = kstrdup(buf, GFP_KERNEL);
>>       if (!options)
>> @@ -918,6 +920,14 @@ static int nvmf_parse_options(struct 
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
>> index dcac3df8a5f7..5db36e250e7a 100644
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
>>       int            max_reconnects;
>>       char            *dhchap_secret;
>>       char            *dhchap_ctrl_secret;
>> +    bool            tls;
>>       bool            disable_sqflow;
>>       bool            hdr_digest;
>>       bool            data_digest;
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index bf46f122e9e1..fbcc0ccf2ef2 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -347,6 +347,7 @@ struct nvme_ctrl {
>>       struct nvme_dhchap_key *ctrl_key;
>>       u16 transaction;
>>   #endif
>> +    struct key *tls_key;
>>       /* Power saving configuration */
>>       u64 ps_max_latency_us;
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 0a39743da4e4..b80bcc5fe447 100644
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
>> @@ -1492,7 +1509,79 @@ static void nvme_tcp_set_queue_io_cpu(struct 
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
>> @@ -1616,6 +1705,14 @@ static int nvme_tcp_alloc_queue(struct 
>> nvme_ctrl *nctrl, int qid)
>>           goto err_rcv_pdu;
>>       }
>> +#ifdef CONFIG_NVME_TCP_TLS
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
>> @@ -1759,10 +1856,22 @@ static int nvme_tcp_start_io_queues(struct 
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
>> +        if (!psk_id) {
>> +            dev_err(ctrl->device, "no valid PSK found\n");
>> +            ret = -ENOKEY;
>> +            goto out_free_queue;
>> +        }
>> +    }
>> -    ret = nvme_tcp_alloc_queue(ctrl, 0);
>> +    ret = nvme_tcp_alloc_queue(ctrl, 0, psk_id);
>>       if (ret)
>> -        return ret;
>> +        goto out_free_queue;
>>       ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
>>       if (ret)
>> @@ -1778,9 +1887,15 @@ static int nvme_tcp_alloc_admin_queue(struct 
>> nvme_ctrl *ctrl)
>>   static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>>   {
>>       int i, ret;
>> +    key_serial_t psk_id;
>> +    if (!ctrl->tls_key) {
>> +        dev_err(ctrl->device, "no PSK negotiated\n");
>> +        return -ENOKEY;
>> +    }
> 
> is ctrl->tls_key always set? Looks like this is the expectation.
> 

It needs to be set when TLS is enabled for the admin queue.
Otherwise no.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


