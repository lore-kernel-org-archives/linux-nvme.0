Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AC2C7EE22
	for <linux-nvme@archiver.kernel.org>; Wed, 10 May 2023 07:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GDIMYPwPQt1HYGUjL2W22ftdEC39hQmkO0IG6jQB5dk=; b=B/ibVbZP021DDlIYsNAblReozk
	ynhGEaa3hEywt9Z7cQx27ShiY5eYVUHniS1NzYMRqLYGeAVy7dm1pZz9L6BSC5eaj9YhsTh/QWLm1
	3YoH7hBwkpzWU1GEMw00znJ+zNaUYIMrDunpPpyKOATxIUVNZynpj7FaRYD2TejMzx5djjhkjfTUT
	Cvdt+2r7lyzbX0ZiRyi5eZlS1MANL8Br5w7TZ/dvalu2r5Wy9xJjlR8HhaTWEMlTXUki5i4vyfuTp
	FJQnnDSRW20Ffu5zx0SqJuIunnctAGx4QEp/Wo61QjQErRrZhn6rWDxTO3cqGQrMH0wZ37E1DHYmM
	6Mw0zfoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pweOc-005PKf-13;
	Wed, 10 May 2023 07:37:58 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pweOY-005PJg-0Y
	for linux-nvme@lists.infradead.org;
	Wed, 10 May 2023 07:37:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1CA521A45;
	Wed, 10 May 2023 07:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683704271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDIMYPwPQt1HYGUjL2W22ftdEC39hQmkO0IG6jQB5dk=;
	b=oVzguMd0qI/2BZBTdT7uclwsZXxvBZBAOSfZ63BwNqeYgjfABOejZVK/aw285mCdi6Egrb
	bgJo2tdnBONA6idgtRg/ylVXtTNurKeHPVhTQXFAljKn88QMap5ydZfz3J+6/lHIXfMh4l
	E8aw+tv58z6GuWKv69xCKjfTvNK2tT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683704271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDIMYPwPQt1HYGUjL2W22ftdEC39hQmkO0IG6jQB5dk=;
	b=6fFNeY4QtNeLBajpvFuiK2sfyY8Sxktgb9HOlPt1wpwZWD4mpW+aafH68NqRDDbkFYbfn3
	lNcSVd8jsMBvPPCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6835E138E5;
	Wed, 10 May 2023 07:37:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id oxjYD85JW2SWTgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 10 May 2023 07:37:50 +0000
Message-ID: <206d203b-a921-0f69-ea75-fc17dc505e19@suse.de>
Date: Wed, 10 May 2023 09:37:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 11/17] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-12-hare@suse.de>
 <31551564-2fcb-50d2-99c3-3d09473fce06@nvidia.com>
 <55ffd26c-9776-a2c7-99b2-fc45de60c0bd@suse.de>
 <09624f1c-a1e9-ad8b-bccf-c7696c398b4f@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <09624f1c-a1e9-ad8b-bccf-c7696c398b4f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_003754_502331_B0E799CB 
X-CRM114-Status: GOOD (  26.39  )
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

On 5/10/23 01:16, Max Gurtovoy wrote:
> 
> 
> On 09/05/2023 17:22, Hannes Reinecke wrote:
>> On 5/9/23 11:48, Max Gurtovoy wrote:
>>>
>>>
>>> On 19/04/2023 9:57, Hannes Reinecke wrote:
>>>> Add a fabrics option 'tls' and start the TLS handshake upcall
>>>> with the default PSK. When TLS is started the PSK key serial
>>>> number is displayed in the sysfs attribute 'tls_key'
>>>
>>> Can you please explain the flow for the TLS handshake in the cover 
>>> letter ?
>>
>> Sure. Will do so in the next round.
>>
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>> ---
>>>>   drivers/nvme/host/Kconfig   |  14 ++++
>>>>   drivers/nvme/host/core.c    |  23 ++++++-
>>>>   drivers/nvme/host/fabrics.c |  12 ++++
>>>>   drivers/nvme/host/fabrics.h |   3 +
>>>>   drivers/nvme/host/nvme.h    |   1 +
>>>>   drivers/nvme/host/tcp.c     | 129 
>>>> ++++++++++++++++++++++++++++++++++--
>>>>   6 files changed, 174 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
>>>> index 2f6a7f8c94e8..96a74041bb0a 100644
>>>> --- a/drivers/nvme/host/Kconfig
>>>> +++ b/drivers/nvme/host/Kconfig
>>>> @@ -92,6 +92,20 @@ config NVME_TCP
>>>>         If unsure, say N.
>>>> +config NVME_TCP_TLS
>>>> +    bool "NVMe over Fabrics TCP TLS encryption support"
>>>> +    depends on NVME_TCP
>>>> +    select NVME_COMMON
>>>> +    select NVME_KEYRING
>>>> +    select NET_HANDSHAKE
>>>> +    help
>>>> +      Enables TLS encryption for NVMe TCP using the netlink 
>>>> handshake API.
>>>> +
>>>> +      The TLS handshake daemon is availble at
>>>> +      https://github.com/oracle/ktls-utils.
>>>> +
>>>> +      If unsure, say N.
>>>> +
>>>>   config NVME_AUTH
>>>>       bool "NVM Express over Fabrics In-Band Authentication"
>>>>       depends on NVME_CORE
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>> index 79aa215aec76..937013127c91 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -3889,6 +3889,19 @@ static DEVICE_ATTR(dhchap_ctrl_secret, 
>>>> S_IRUGO | S_IWUSR,
>>>>       nvme_ctrl_dhchap_ctrl_secret_show, 
>>>> nvme_ctrl_dhchap_ctrl_secret_store);
>>>>   #endif
>>>> +#ifdef CONFIG_NVME_TCP_TLS
>>>> +static ssize_t tls_key_show(struct device *dev,
>>>> +                struct device_attribute *attr, char *buf)
>>>> +{
>>>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>>> +
>>>> +    if (!ctrl->tls_key)
>>>> +        return 0;
>>>> +    return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
>>>> +}
>>>> +static DEVICE_ATTR_RO(tls_key);
>>>> +#endif
>>>> +
>>>>   static struct attribute *nvme_dev_attrs[] = {
>>>>       &dev_attr_reset_controller.attr,
>>>>       &dev_attr_rescan_controller.attr,
>>>> @@ -3915,6 +3928,9 @@ static struct attribute *nvme_dev_attrs[] = {
>>>>   #ifdef CONFIG_NVME_AUTH
>>>>       &dev_attr_dhchap_secret.attr,
>>>>       &dev_attr_dhchap_ctrl_secret.attr,
>>>> +#endif
>>>> +#ifdef CONFIG_NVME_TCP_TLS
>>>> +    &dev_attr_tls_key.attr,
>>>>   #endif
>>>>       NULL
>>>>   };
>>>> @@ -3945,7 +3961,10 @@ static umode_t 
>>>> nvme_dev_attrs_are_visible(struct kobject *kobj,
>>>>       if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
>>>>           return 0;
>>>>   #endif
>>>> -
>>>> +#ifdef CONFIG_NVME_TCP_TLS
>>>> +    if (a == &dev_attr_tls_key.attr && !ctrl->opts)
>>>> +        return 0;
>>>> +#endif
>>>>       return a->mode;
>>>>   }
>>>> @@ -5080,7 +5099,7 @@ static void nvme_free_ctrl(struct device *dev)
>>>>       if (!subsys || ctrl->instance != subsys->instance)
>>>>           ida_free(&nvme_instance_ida, ctrl->instance);
>>>> -
>>>> +    key_put(ctrl->tls_key);
>>>>       nvme_free_cels(ctrl);
>>>>       nvme_mpath_uninit(ctrl);
>>>>       nvme_auth_stop(ctrl);
>>>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>>>> index bbaa04a0c502..2aa8fb991455 100644
>>>> --- a/drivers/nvme/host/fabrics.c
>>>> +++ b/drivers/nvme/host/fabrics.c
>>>> @@ -609,6 +609,9 @@ static const match_table_t opt_tokens = {
>>>>       { NVMF_OPT_DISCOVERY,        "discovery"        },
>>>>       { NVMF_OPT_DHCHAP_SECRET,    "dhchap_secret=%s"    },
>>>>       { NVMF_OPT_DHCHAP_CTRL_SECRET,    "dhchap_ctrl_secret=%s"    },
>>>> +#ifdef CONFIG_NVME_TCP_TLS
>>>
>>> This ifdef is redundant IMO.
>>> We have to many of those already in the code and we should reduce to 
>>> be able to keep the code maintainable.
>>>
>> We have been going back and forth on this, and the consensus was to 
>> _have_ a compilation flag here. This allows the userland utility 
>> nvme-cli to determine whether tls support is available on any given 
>> kernel.
> 
> nvme-cli will determine tls support using check for "static const 
> match_table_t opt_tokens" ?
> 
Yes. The table is displayed by doing a 'cat' on /dev/nvme-fabrics, and
nvme-cli will be parsing that to figure out if a particular option is
supported.

>>
>>>> +    { NVMF_OPT_TLS,            "tls"            },
>>>> +#endif
>>>>       { NVMF_OPT_ERR,            NULL            }
>>>>   };
>>>> @@ -632,6 +635,7 @@ static int nvmf_parse_options(struct 
>>>> nvmf_ctrl_options *opts,
>>>>       opts->hdr_digest = false;
>>>>       opts->data_digest = false;
>>>>       opts->tos = -1; /* < 0 == use transport default */
>>>> +    opts->tls = false;
>>>>       options = o = kstrdup(buf, GFP_KERNEL);
>>>>       if (!options)
>>>> @@ -918,6 +922,14 @@ static int nvmf_parse_options(struct 
>>>> nvmf_ctrl_options *opts,
>>>>               kfree(opts->dhchap_ctrl_secret);
>>>>               opts->dhchap_ctrl_secret = p;
>>>>               break;
>>>> +        case NVMF_OPT_TLS:
>>>> +            if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
>>>> +                pr_err("TLS is not supported\n");
>>>> +                ret = -EINVAL;
>>>> +                goto out;
>>>> +            }
>>>> +            opts->tls = true;
>>>> +            break;
>>>>           default:
>>>>               pr_warn("unknown parameter or missing value '%s' in 
>>>> ctrl creation request\n",
>>>>                   p);
>>>> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>>>> index dcac3df8a5f7..5db36e250e7a 100644
>>>> --- a/drivers/nvme/host/fabrics.h
>>>> +++ b/drivers/nvme/host/fabrics.h
>>>> @@ -70,6 +70,7 @@ enum {
>>>>       NVMF_OPT_DISCOVERY    = 1 << 22,
>>>>       NVMF_OPT_DHCHAP_SECRET    = 1 << 23,
>>>>       NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
>>>> +    NVMF_OPT_TLS        = 1 << 25,
>>>>   };
>>>>   /**
>>>> @@ -102,6 +103,7 @@ enum {
>>>>    * @dhchap_secret: DH-HMAC-CHAP secret
>>>>    * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for 
>>>> bi-directional
>>>>    *              authentication
>>>> + * @tls:        Start TLS encrypted connections (TCP)
>>>>    * @disable_sqflow: disable controller sq flow control
>>>>    * @hdr_digest: generate/verify header digest (TCP)
>>>>    * @data_digest: generate/verify data digest (TCP)
>>>> @@ -128,6 +130,7 @@ struct nvmf_ctrl_options {
>>>>       int            max_reconnects;
>>>>       char            *dhchap_secret;
>>>>       char            *dhchap_ctrl_secret;
>>>> +    bool            tls;
>>>>       bool            disable_sqflow;
>>>>       bool            hdr_digest;
>>>>       bool            data_digest;
>>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>>> index bf46f122e9e1..fbcc0ccf2ef2 100644
>>>> --- a/drivers/nvme/host/nvme.h
>>>> +++ b/drivers/nvme/host/nvme.h
>>>> @@ -347,6 +347,7 @@ struct nvme_ctrl {
>>>>       struct nvme_dhchap_key *ctrl_key;
>>>>       u16 transaction;
>>>>   #endif
>>>> +    struct key *tls_key;
>>>>       /* Power saving configuration */
>>>>       u64 ps_max_latency_us;
>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>> index 9deba481ae6a..d25695cf4e03 100644
>>>> --- a/drivers/nvme/host/tcp.c
>>>> +++ b/drivers/nvme/host/tcp.c
>>>> @@ -8,9 +8,13 @@
>>>>   #include <linux/init.h>
>>>>   #include <linux/slab.h>
>>>>   #include <linux/err.h>
>>>> +#include <linux/key.h>
>>>>   #include <linux/nvme-tcp.h>
>>>> +#include <linux/nvme-keyring.h>
>>>>   #include <net/sock.h>
>>>>   #include <net/tcp.h>
>>>> +#include <net/tls.h>
>>>> +#include <net/handshake.h>
>>>>   #include <linux/blk-mq.h>
>>>>   #include <crypto/hash.h>
>>>>   #include <net/busy_poll.h>
>>>> @@ -31,6 +35,16 @@ static int so_priority;
>>>>   module_param(so_priority, int, 0644);
>>>>   MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>>>> +#ifdef CONFIG_NVME_TCP_TLS
>>>> +/*
>>>> + * TLS handshake timeout
>>>> + */
>>>> +static int tls_handshake_timeout = 10;
>>>> +module_param(tls_handshake_timeout, int, 0644);
>>>> +MODULE_PARM_DESC(tls_handshake_timeout,
>>>> +         "nvme TLS handshake timeout in seconds (default 10)");
>>>> +#endif
>>>
>>> Module param under ifdef also sounds redundant.
>>>> +
>>>>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>>>   /* lockdep can detect a circular dependency of the form
>>>>    *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
>>>> @@ -146,7 +160,10 @@ struct nvme_tcp_queue {
>>>>       struct ahash_request    *snd_hash;
>>>>       __le32            exp_ddgst;
>>>>       __le32            recv_ddgst;
>>>> -
>>>> +#ifdef CONFIG_NVME_TCP_TLS
>>>> +    struct completion       tls_complete;
>>>> +    int                     tls_err;
>>>> +#endif
>>>>       struct page_frag_cache    pf_cache;
>>>>       void (*state_change)(struct sock *);
>>>> @@ -1502,7 +1519,79 @@ static void nvme_tcp_set_queue_io_cpu(struct 
>>>> nvme_tcp_queue *queue)
>>>>       queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, 
>>>> false);
>>>>   }
>>>> -static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>>>> +#ifdef CONFIG_NVME_TCP_TLS
>>>> +static void nvme_tcp_tls_done(void *data, int status, key_serial_t 
>>>> pskid)
>>>> +{
>>>> +    struct nvme_tcp_queue *queue = data;
>>>> +    struct nvme_tcp_ctrl *ctrl = queue->ctrl;
>>>> +    int qid = nvme_tcp_queue_id(queue);
>>>> +    struct key *tls_key;
>>>> +
>>>> +    dev_dbg(ctrl->ctrl.device, "queue %d: TLS handshake done, key 
>>>> %x, status %d\n",
>>>> +        qid, pskid, status);
>>>> +
>>>> +    if (status) {
>>>> +        queue->tls_err = -status;
>>>> +        goto out_complete;
>>>> +    }
>>>> +
>>>> +    tls_key = key_lookup(pskid);
>>>> +    if (IS_ERR(tls_key)) {
>>>> +        dev_warn(ctrl->ctrl.device, "queue %d: Invalid key %x\n",
>>>> +             qid, pskid);
>>>> +        queue->tls_err = -ENOKEY;
>>>> +    } else {
>>>> +        ctrl->ctrl.tls_key = tls_key;
>>>> +        queue->tls_err = 0;
>>>> +    }
>>>> +
>>>> +out_complete:
>>>> +    complete(&queue->tls_complete);
>>>> +}
>>>> +
>>>> +static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>>>> +                  struct nvme_tcp_queue *queue,
>>>> +                  key_serial_t pskid)
>>>> +{
>>>> +    int qid = nvme_tcp_queue_id(queue);
>>>> +    int ret;
>>>> +    struct tls_handshake_args args;
>>>> +    unsigned long tmo = tls_handshake_timeout * HZ;
>>>> +    key_serial_t keyring = nvme_keyring_id();
>>>> +
>>>> +    dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>>>> +        qid, pskid);
>>>> +    args.ta_sock = queue->sock;
>>>> +    args.ta_done = nvme_tcp_tls_done;
>>>> +    args.ta_data = queue;
>>>> +    args.ta_my_peerids[0] = pskid;
>>>> +    args.ta_num_peerids = 1;
>>>> +    args.ta_keyring = keyring;
>>>> +    args.ta_timeout_ms = tls_handshake_timeout * 1000;
>>>> +    queue->tls_err = -EOPNOTSUPP;
>>>> +    init_completion(&queue->tls_complete);
>>>> +    ret = tls_client_hello_psk(&args, GFP_KERNEL);
>>>> +    if (ret) {
>>>> +        dev_err(nctrl->device, "queue %d: failed to start TLS: %d\n",
>>>> +            qid, ret);
>>>> +        return ret;
>>>> +    }
>>>> +    if (wait_for_completion_timeout(&queue->tls_complete, tmo) == 0) {
>>>> +        dev_err(nctrl->device,
>>>> +            "queue %d: TLS handshake timeout\n", qid);
>>>> +        ret = -ETIMEDOUT;
>>>> +    } else {
>>>> +        dev_dbg(nctrl->device,
>>>> +            "queue %d: TLS handshake complete, error %d\n",
>>>> +            qid, queue->tls_err);
>>>> +        ret = queue->tls_err;
>>>> +    }
>>>> +    return ret;
>>>> +}
>>>> +#endif
>>>> +
>>>> +static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>>>> +                key_serial_t pskid)
>>>>   {
>>>>       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>>>>       struct nvme_tcp_queue *queue = &ctrl->queues[qid];
>>>> @@ -1626,6 +1715,14 @@ static int nvme_tcp_alloc_queue(struct 
>>>> nvme_ctrl *nctrl, int qid)
>>>>           goto err_rcv_pdu;
>>>>       }
>>>> +#ifdef CONFIG_NVME_TCP_TLS
>>>> +    /* If PSKs are configured try to start TLS */
>>>> +    if (pskid) {
>>>> +        ret = nvme_tcp_start_tls(nctrl, queue, pskid);
>>>> +        if (ret)
>>>> +            goto err_init_connect;
>>>> +    }
>>>> +#endif
>>>
>>> Maybe reduce ifdef here and use IS_ENABLED ? (might be done in 
>>> nvme_tcp_start_tls too)
>>>
>> Then I would need to have a dummy definition for 'nvme_tcp_start_tls';
>> but yeah, could do.
>>
>>>>       ret = nvme_tcp_init_connection(queue);
>>>>       if (ret)
>>>>           goto err_init_connect;
>>>> @@ -1769,10 +1866,22 @@ static int nvme_tcp_start_io_queues(struct 
>>>> nvme_ctrl *ctrl,
>>>>   static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>>>>   {
>>>>       int ret;
>>>> +    key_serial_t psk_id = 0;
>>>> +
>>>> +    if (ctrl->opts->tls) {
>>>> +        psk_id = nvme_tls_psk_default(NULL,
>>>> +                          ctrl->opts->host->nqn,
>>>> +                          ctrl->opts->subsysnqn);
> 
> After the patch squash you will not need this defaulk psk and also the 
> opts->tls.
> Why not ask the user provide it explicitly always ? why do we need a 
> default ?
> I'm not TLS expert, but seem redundant..
> 
> 
No. 'tls' enables a TLS connection with the credential from the keyring
which matches the host and controller identification.
We could ask the user, but the information would be the same.
They only can differ if the user specifies a different keyring, and then
we might need to specify which key we want to use.

>>>> +        if (!psk_id) {
>>>> +            dev_err(ctrl->device, "no valid PSK found\n");
>>>> +            ret = -ENOKEY;
>>>> +            goto out_free_queue;
>>>> +        }
>>>> +    }
>>>> -    ret = nvme_tcp_alloc_queue(ctrl, 0);
>>>> +    ret = nvme_tcp_alloc_queue(ctrl, 0, psk_id);
>>>>       if (ret)
>>>> -        return ret;
>>>> +        goto out_free_queue;
>>>>       ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
>>>>       if (ret)
>>>> @@ -1788,9 +1897,17 @@ static int nvme_tcp_alloc_admin_queue(struct 
>>>> nvme_ctrl *ctrl)
>>>>   static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>>>>   {
>>>>       int i, ret;
>>>> +    key_serial_t psk_id = 0;
>>>> +    if (ctrl->opts->tls) {
>>>> +        if (!ctrl->tls_key) {
>>>> +            dev_err(ctrl->device, "no PSK negotiated\n");
>>>> +            return -ENOKEY;
>>>> +        }
>>>> +        psk_id = key_serial(ctrl->tls_key);
>>>> +    }
>>>>       for (i = 1; i < ctrl->queue_count; i++) {
>>>> -        ret = nvme_tcp_alloc_queue(ctrl, i);
>>>> +        ret = nvme_tcp_alloc_queue(ctrl, i, psk_id);
>>>>           if (ret)
>>>>               goto out_free_queues;
>>>>       }
>>>> @@ -2699,7 +2816,7 @@ static struct nvmf_transport_ops 
>>>> nvme_tcp_transport = {
>>>>                 NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
>>>>                 NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
>>>>                 NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
>>>> -              NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
>>>> +              NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS,
>>>>       .create_ctrl    = nvme_tcp_create_ctrl,
>>>>   };
>>
>> Cheers,
>>
>> Hannes

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


