Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66272C41513
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 08:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5G1Qic1sPRfBrcvBuEkm07D96aAeD9ozH9QL+JRXOg4=; b=IIDhDzJgF1BCOfb98ulmBBHxz2
	L5fG44OAH5Mv1K4Mpd+89TT9sg03GPTAqPUky6FB8Ds/LtDCH7k3SzdIzDgCfNDK3Zkyt9OBWEyxp
	Z7zciJ3cc9D2lmgQD9Zbewbpw0QbrUXt5ff29rnPqj4/4QRAIiKPOntCf3h/ZzXNyIvicuvs6UPjp
	6HAmhcWvFmsRFOkUPaEDfDWsuRypwNozfQxgjiJcopsCQb3ED4KbR4KQRK3oVAAulaUIAnoGM3uUn
	hHCZ6ZvgCtOUK3NuPl8mXeWtECDOneuY/Li5FrIb1Dy0unP+oKPRnFZHVL1/zhGlBAWC0YcmTNiJa
	v5oxFORQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvTV-00GQbb-1C;
	Mon, 07 Aug 2023 08:20:25 +0000
Received: from mail-lj1-f172.google.com ([209.85.208.172])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvTR-00GQb2-2m
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 08:20:24 +0000
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b9cb0bb04bso14898221fa.0
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 01:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691396419; x=1692001219;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5G1Qic1sPRfBrcvBuEkm07D96aAeD9ozH9QL+JRXOg4=;
        b=PBsQtb7RJF8MbVpI7tRI5p5cQhyrWXPEUl0FgOhNtnY3txu6buPFn8Kz1kcACkFRyP
         IMCZjgiorajS5dP7RKO65UAstTCD6tGk9O6LtM1q2YNaCx1tuL2QLHHP72lRz/paJkcT
         KVhRV+uySpS4i51ovsyRsp5chCIfItmt310MdD06QgT1KUUoPBUMceCkBawBmowTrPk4
         S9dJac9SSuDmI45pLM+549bSR2nph98v+OqPSbWk873SEXECw6KyygkVt6MZokGjobHs
         MAyXejFTgmFtAgcb8HuT5w0iiqm43MKHAsOfViJxGYGcPXcbssQb97x3JS0okSviKKm9
         d2/g==
X-Gm-Message-State: ABy/qLbHPWRaA4GL39Qvidm+O+VKp+i6eC6Ls/PwCQZDleT5s4ZDy2LM
	OWeQ/q42BI7kHSANMTzijYY=
X-Google-Smtp-Source: APBJJlENxO+db70b+p1X+FeOmUyYkikSN78YtAspcFayzGTGB+SfUg2VkE6f1m5OorxAT4rG+cYYwQ==
X-Received: by 2002:a2e:a7cf:0:b0:2b6:9969:d0ab with SMTP id x15-20020a2ea7cf000000b002b69969d0abmr18685785ljp.4.1691396418575;
        Mon, 07 Aug 2023 01:20:18 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y8-20020a7bcd88000000b003fe2b081661sm14400462wmj.30.2023.08.07.01.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 01:20:18 -0700 (PDT)
Message-ID: <6a2b615a-b618-0152-4292-7640cbaebfef@grimberg.me>
Date: Mon, 7 Aug 2023 11:20:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/14] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-9-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230803105102.30949-9-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_012021_925319_7B20C3EA 
X-CRM114-Status: GOOD (  36.17  )
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



On 8/3/23 13:50, Hannes Reinecke wrote:
> Add a fabrics option 'tls' and start the TLS handshake upcall
> with the default PSK. When TLS is started the PSK key serial
> number is displayed in the sysfs attribute 'tls_key'
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/Kconfig   |  14 ++++
>   drivers/nvme/host/core.c    |   2 +-
>   drivers/nvme/host/fabrics.c |  12 ++++
>   drivers/nvme/host/fabrics.h |   3 +
>   drivers/nvme/host/nvme.h    |   1 +
>   drivers/nvme/host/sysfs.c   |  20 ++++++
>   drivers/nvme/host/tcp.c     | 130 ++++++++++++++++++++++++++++++++++--
>   7 files changed, 175 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 2f6a7f8c94e8..96a74041bb0a 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -92,6 +92,20 @@ config NVME_TCP
>   
>   	  If unsure, say N.
>   
> +config NVME_TCP_TLS
> +	bool "NVMe over Fabrics TCP TLS encryption support"
> +	depends on NVME_TCP
> +	select NVME_COMMON
> +	select NVME_KEYRING
> +	select NET_HANDSHAKE
> +	help
> +	  Enables TLS encryption for NVMe TCP using the netlink handshake API.
> +
> +	  The TLS handshake daemon is availble at
> +	  https://github.com/oracle/ktls-utils.
> +
> +	  If unsure, say N.
> +
>   config NVME_AUTH
>   	bool "NVM Express over Fabrics In-Band Authentication"
>   	depends on NVME_CORE
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dfc574d0f18d..b52e9c9bffd6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4380,7 +4380,7 @@ static void nvme_free_ctrl(struct device *dev)
>   
>   	if (!subsys || ctrl->instance != subsys->instance)
>   		ida_free(&nvme_instance_ida, ctrl->instance);
> -
> +	key_put(ctrl->tls_key);
>   	nvme_free_cels(ctrl);
>   	nvme_mpath_uninit(ctrl);
>   	nvme_auth_stop(ctrl);
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 8175d49f2909..ddad482c3537 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -647,6 +647,9 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_DISCOVERY,		"discovery"		},
>   	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
>   	{ NVMF_OPT_DHCHAP_CTRL_SECRET,	"dhchap_ctrl_secret=%s"	},
> +#ifdef CONFIG_NVME_TCP_TLS
> +	{ NVMF_OPT_TLS,			"tls"			},
> +#endif
>   	{ NVMF_OPT_ERR,			NULL			}
>   };
>   
> @@ -671,6 +674,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	opts->hdr_digest = false;
>   	opts->data_digest = false;
>   	opts->tos = -1; /* < 0 == use transport default */
> +	opts->tls = false;
>   
>   	options = o = kstrdup(buf, GFP_KERNEL);
>   	if (!options)
> @@ -955,6 +959,14 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			kfree(opts->dhchap_ctrl_secret);
>   			opts->dhchap_ctrl_secret = p;
>   			break;
> +		case NVMF_OPT_TLS:
> +			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
> +				pr_err("TLS is not supported\n");
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			opts->tls = true;
> +			break;
>   		default:
>   			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
>   				p);
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index 82e7a27ffbde..dac17c3fee26 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -70,6 +70,7 @@ enum {
>   	NVMF_OPT_DISCOVERY	= 1 << 22,
>   	NVMF_OPT_DHCHAP_SECRET	= 1 << 23,
>   	NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
> +	NVMF_OPT_TLS		= 1 << 25,
>   };
>   
>   /**
> @@ -102,6 +103,7 @@ enum {
>    * @dhchap_secret: DH-HMAC-CHAP secret
>    * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for bi-directional
>    *              authentication
> + * @tls:        Start TLS encrypted connections (TCP)
>    * @disable_sqflow: disable controller sq flow control
>    * @hdr_digest: generate/verify header digest (TCP)
>    * @data_digest: generate/verify data digest (TCP)
> @@ -128,6 +130,7 @@ struct nvmf_ctrl_options {
>   	struct nvmf_host	*host;
>   	char			*dhchap_secret;
>   	char			*dhchap_ctrl_secret;
> +	bool			tls;
>   	bool			disable_sqflow;
>   	bool			hdr_digest;
>   	bool			data_digest;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index f35647c470af..6fe7966f720b 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -357,6 +357,7 @@ struct nvme_ctrl {
>   	struct nvme_dhchap_key *ctrl_key;
>   	u16 transaction;
>   #endif
> +	struct key *tls_key;
>   
>   	/* Power saving configuration */
>   	u64 ps_max_latency_us;
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 212e1b05d298..03a64674d0a4 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -527,6 +527,19 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
>   	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
>   #endif
>   
> +#ifdef CONFIG_NVME_TCP_TLS
> +static ssize_t tls_key_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	if (!ctrl->tls_key)
> +		return 0;
> +	return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
> +}
> +static DEVICE_ATTR_RO(tls_key);
> +#endif
> +
>   static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_reset_controller.attr,
>   	&dev_attr_rescan_controller.attr,
> @@ -553,6 +566,9 @@ static struct attribute *nvme_dev_attrs[] = {
>   #ifdef CONFIG_NVME_AUTH
>   	&dev_attr_dhchap_secret.attr,
>   	&dev_attr_dhchap_ctrl_secret.attr,
> +#endif
> +#ifdef CONFIG_NVME_TCP_TLS
> +	&dev_attr_tls_key.attr,
>   #endif
>   	NULL
>   };
> @@ -583,6 +599,10 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
>   	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
>   		return 0;
>   #endif
> +#ifdef CONFIG_NVME_TCP_TLS
> +	if (a == &dev_attr_tls_key.attr && !ctrl->opts)
> +		return 0;
> +#endif

Probably you want to check that the transport is tcp.

>   
>   	return a->mode;
>   }
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index c3b3b938c0f9..98400ad5f969 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -8,9 +8,13 @@
>   #include <linux/init.h>
>   #include <linux/slab.h>
>   #include <linux/err.h>
> +#include <linux/key.h>
>   #include <linux/nvme-tcp.h>
> +#include <linux/nvme-keyring.h>
>   #include <net/sock.h>
>   #include <net/tcp.h>
> +#include <net/tls.h>
> +#include <net/handshake.h>
>   #include <linux/blk-mq.h>
>   #include <crypto/hash.h>
>   #include <net/busy_poll.h>
> @@ -31,6 +35,16 @@ static int so_priority;
>   module_param(so_priority, int, 0644);
>   MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>   
> +#ifdef CONFIG_NVME_TCP_TLS
> +/*
> + * TLS handshake timeout
> + */
> +static int tls_handshake_timeout = 10;
> +module_param(tls_handshake_timeout, int, 0644);
> +MODULE_PARM_DESC(tls_handshake_timeout,
> +		 "nvme TLS handshake timeout in seconds (default 10)");
> +#endif
> +
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   /* lockdep can detect a circular dependency of the form
>    *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
> @@ -146,7 +160,10 @@ struct nvme_tcp_queue {
>   	struct ahash_request	*snd_hash;
>   	__le32			exp_ddgst;
>   	__le32			recv_ddgst;
> -
> +#ifdef CONFIG_NVME_TCP_TLS
> +	struct completion       tls_complete;
> +	int                     tls_err;
> +#endif
>   	struct page_frag_cache	pf_cache;
>   
>   	void (*state_change)(struct sock *);
> @@ -1509,7 +1526,80 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>   	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
>   }
>   
> -static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
> +#ifdef CONFIG_NVME_TCP_TLS
> +static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
> +{
> +	struct nvme_tcp_queue *queue = data;
> +	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
> +	int qid = nvme_tcp_queue_id(queue);
> +	struct key *tls_key;
> +
> +	dev_dbg(ctrl->ctrl.device, "queue %d: TLS handshake done, key %x, status %d\n",
> +		qid, pskid, status);
> +
> +	if (status) {
> +		queue->tls_err = -status;
> +		goto out_complete;
> +	}
> +
> +	tls_key = key_lookup(pskid);
> +	if (IS_ERR(tls_key)) {
> +		dev_warn(ctrl->ctrl.device, "queue %d: Invalid key %x\n",
> +			 qid, pskid);
> +		queue->tls_err = -ENOKEY;
> +	} else {
> +		ctrl->ctrl.tls_key = tls_key;
> +		queue->tls_err = 0;
> +	}
> +
> +out_complete:
> +	complete(&queue->tls_complete);
> +}
> +
> +static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
> +			      struct nvme_tcp_queue *queue,
> +			      key_serial_t pskid)
> +{
> +	int qid = nvme_tcp_queue_id(queue);
> +	int ret;
> +	struct tls_handshake_args args;
> +	unsigned long tmo = tls_handshake_timeout * HZ;
> +	key_serial_t keyring = nvme_keyring_id();
> +
> +	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
> +		qid, pskid);
> +	memset(&args, 0, sizeof(args));
> +	args.ta_sock = queue->sock;
> +	args.ta_done = nvme_tcp_tls_done;
> +	args.ta_data = queue;
> +	args.ta_my_peerids[0] = pskid;
> +	args.ta_num_peerids = 1;
> +	args.ta_keyring = keyring;
> +	args.ta_timeout_ms = tls_handshake_timeout * 1000;
> +	queue->tls_err = -EOPNOTSUPP;
> +	init_completion(&queue->tls_complete);
> +	ret = tls_client_hello_psk(&args, GFP_KERNEL);
> +	if (ret) {
> +		dev_err(nctrl->device, "queue %d: failed to start TLS: %d\n",
> +			qid, ret);
> +		return ret;
> +	}
> +	if (wait_for_completion_timeout(&queue->tls_complete, tmo) == 0) {

Maybe this should be interruptible as well?

> +		dev_err(nctrl->device,
> +			"queue %d: TLS handshake timeout\n", qid);
> +		ret = -ETIMEDOUT;
> +	} else {
> +		dev_dbg(nctrl->device,
> +			"queue %d: TLS handshake complete, error %d\n",
> +			qid, queue->tls_err);
> +		ret = queue->tls_err;
> +	}
> +	return ret;
> +}
> +#endif
> +
> +static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
> +				key_serial_t pskid)
>   {
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>   	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
> @@ -1633,6 +1723,14 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>   		goto err_rcv_pdu;
>   	}
>   
> +#ifdef CONFIG_NVME_TCP_TLS

pskid is passed unconditionally, is the ifdef needed?
maybe make nvme_tcp_start_tls stub if not defined?

> +	/* If PSKs are configured try to start TLS */
> +	if (pskid) {
> +		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
> +		if (ret)
> +			goto err_init_connect;
> +	}
> +#endif
>   	ret = nvme_tcp_init_connection(queue);
>   	if (ret)
>   		goto err_init_connect;
> @@ -1782,10 +1880,22 @@ static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
>   static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   {
>   	int ret;
> +	key_serial_t psk_id = 0;
> +
> +	if (ctrl->opts->tls) {
> +		psk_id = nvme_tls_psk_default(NULL,
> +					      ctrl->opts->host->nqn,
> +					      ctrl->opts->subsysnqn);

is the returned tls_key_id guaranteed to be non-zero?

> +		if (!psk_id) {
> +			dev_err(ctrl->device, "no valid PSK found\n");
> +			ret = -ENOKEY;
> +			goto out_free_queue;
> +		}
> +	}
>   
> -	ret = nvme_tcp_alloc_queue(ctrl, 0);
> +	ret = nvme_tcp_alloc_queue(ctrl, 0, psk_id);
>   	if (ret)
> -		return ret;
> +		goto out_free_queue;
>   
>   	ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
>   	if (ret)
> @@ -1801,9 +1911,17 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   {
>   	int i, ret;
> +	key_serial_t psk_id = 0;
>   
> +	if (ctrl->opts->tls) {
> +		if (!ctrl->tls_key) {
> +			dev_err(ctrl->device, "no PSK negotiated\n");
> +			return -ENOKEY;
> +		}
> +		psk_id = key_serial(ctrl->tls_key);
> +	}
>   	for (i = 1; i < ctrl->queue_count; i++) {
> -		ret = nvme_tcp_alloc_queue(ctrl, i);
> +		ret = nvme_tcp_alloc_queue(ctrl, i, psk_id);
>   		if (ret)
>   			goto out_free_queues;
>   	}
> @@ -2630,7 +2748,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
>   			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
>   			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
>   			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
> -			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
> +			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS,
>   	.create_ctrl	= nvme_tcp_create_ctrl,
>   };
>   

