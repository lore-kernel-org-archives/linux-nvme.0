Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C251CD1292
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 21:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YInNjenBEU9RznDu3LnjePOFAk394CVnXBX1QXZ8QEI=; b=vL54hdEIvqvvP5+L84/8eI4fuA
	XsficNjBrcTmzfU1JHSF23lQUBpx4M37fcz7pezphYLNi9KL0qytpjfUJh1e5rvn++Tpy+mJOWrVK
	g91ZTPvW9LC3WunhDZaINg1E2eNR1FpiETm+UnKHC8rPmZp8zYLG8LM8DkaExB8f0QhlMxy5v35ZJ
	jfXtNuPZy82HLPN3lZ42H0/VzeNiCTT2oKJ0uoGI1NhDMkNuJNH418UDK0NN/3/E2Qmf43Fc8OVnJ
	NLosoHO/ID1JQ+uK2AVFTl8Ab8Osu19QWCZjve0HECp9ehID9oCcknvWlIV8CC/RpdfofJiLGYYYv
	wgWI5NaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtZrY-0000000DWxl-1q2W;
	Sun, 07 Apr 2024 21:15:40 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtZrV-0000000DWxD-1Jf9
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 21:15:38 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41632e3de82so534315e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 14:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712524535; x=1713129335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YInNjenBEU9RznDu3LnjePOFAk394CVnXBX1QXZ8QEI=;
        b=SSvjRs2KLkH9GAPnjLhu+1vVouo7TSXYzLKGfsLR5Z95r+Bkp2Q1Mf92K+h0Hi9Fr1
         qaofDI+aNnDx7WlKNtnVN3UshQVuCe7CwNJ0Z/N5crY+cPEwfEzJSbDkMQtOAZ8QvO5x
         3LDoQ4MZdqclQVE+UrjeVJhGr5wTC15/AOmoD7ULVibgFVUvM/Wp0jwmGk4x8S8RARGR
         L5edieqCUszOgIMq0RPkm/cLgVlgwmI6hyV+owOVIJFC87IgjAcQVNcB/NpfvaR3+BvX
         wWq4uD/Bw8VLJaztzp17iMa9Ouy8mZJB5OuU0HIF34VcFC8fWpxwyc6Uoq989TzswX2h
         H2sw==
X-Forwarded-Encrypted: i=1; AJvYcCVuE20IcW34cBjRqJTPikaYwjxEqLbT1/uY000ICs0b7FYtjlhTV5H47wzI4p7m8OGwRXV9RnfBIo7qXV+HlTaah9mQaTZNy3qEL7ORZd0=
X-Gm-Message-State: AOJu0YzUg/u0Pu0/juDlRB9nGNCkO+a3AYi9VC/Z/tuRcNlelBAebckd
	M3d6kjyHGdgl0zQvagOH/qoW0oUAXfF/xKQFO8Iq1dmnOFHAewvoxzhNtO5d
X-Google-Smtp-Source: AGHT+IHSATkEozJXIfq+KF3J4jRSvF31XegR8IVvf6hiKHVTpukIQt7s9Rotb7Nkc3pSJEXRmnGA5g==
X-Received: by 2002:a05:600c:4f95:b0:414:f154:e652 with SMTP id n21-20020a05600c4f9500b00414f154e652mr5581420wmq.3.1712524535143;
        Sun, 07 Apr 2024 14:15:35 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c310700b0041649f850e7sm4695372wmo.32.2024.04.07.14.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 14:15:34 -0700 (PDT)
Message-ID: <e7200e48-7c86-4cd0-9fa8-4a3d62578a12@grimberg.me>
Date: Mon, 8 Apr 2024 00:15:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] nvme-tcp: sanitize TLS key handling
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-9-hare@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240318150316.138501-9-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_141537_400463_46DC5DF3 
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



On 18/03/2024 17:03, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> There is a difference between TLS configured (ie the user has
> provisioned/requested a key) and TLS enabled (ie the connection
> is encrypted with TLS). This becomes important for secure concatenation,
> where the initial authentication is run unencrypted (ie with
> TLS configured, but not enabled), and then the queue is reset to
> run over TLS (ie TLS configured _and_ enabled).

1. configured/enabled confuse (me at least) in this context.
2. What does "queue is reset" mean?

> So to differentiate between those two states store the provisioned
> key in opts->tls_key (as we're using the same TLS key for all queues)
> and only the key serial of the key negotiated by the TLS handshake
> in queue->tls_pskid.

I have some recollection of asking about it, but can you explain why is
a tls_pskid now stored per-queue? What do we lose if tls_pskid moves from
nvme_tcp_queue to nvme_tcp_ctrl ?

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c  |  1 -
>   drivers/nvme/host/sysfs.c |  2 +-
>   drivers/nvme/host/tcp.c   | 54 +++++++++++++++++++++++++++++----------
>   3 files changed, 42 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2baf5786a92f..9b601655f423 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4567,7 +4567,6 @@ static void nvme_free_ctrl(struct device *dev)
>   
>   	if (!subsys || ctrl->instance != subsys->instance)
>   		ida_free(&nvme_instance_ida, ctrl->instance);
> -	key_put(ctrl->tls_key);
>   	nvme_free_cels(ctrl);
>   	nvme_mpath_uninit(ctrl);
>   	nvme_auth_stop(ctrl);
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index ec581608f16c..1f9e57fbfee3 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -671,7 +671,7 @@ static ssize_t tls_key_show(struct device *dev,
>   			    struct device_attribute *attr, char *buf)
>   {
>   	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	struct key *key = ctrl->tls_key;
> +	struct key *key = ctrl->opts->tls_key;
>   
>   	if (!key)
>   		return 0;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4a58886e1354..7018dc0dd026 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -163,6 +163,7 @@ struct nvme_tcp_queue {
>   	__le32			recv_ddgst;
>   	struct completion       tls_complete;
>   	int                     tls_err;
> +	key_serial_t		tls_pskid;
>   	struct page_frag_cache	pf_cache;
>   
>   	void (*state_change)(struct sock *);
> @@ -205,7 +206,15 @@ static inline int nvme_tcp_queue_id(struct nvme_tcp_queue *queue)
>   	return queue - queue->ctrl->queues;
>   }
>   
> -static inline bool nvme_tcp_tls(struct nvme_ctrl *ctrl)
> +static inline bool nvme_tcp_tls_enabled(struct nvme_tcp_queue *queue)
> +{
> +	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
> +		return 0;
> +
> +	return (queue->tls_pskid != 0);
> +}
> +
> +static inline bool nvme_tcp_tls_configured(struct nvme_ctrl *ctrl)
>   {
>   	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
>   		return 0;
> @@ -1418,7 +1427,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>   	memset(&msg, 0, sizeof(msg));
>   	iov.iov_base = icresp;
>   	iov.iov_len = sizeof(*icresp);
> -	if (nvme_tcp_tls(&queue->ctrl->ctrl)) {
> +	if (nvme_tcp_tls_enabled(queue)) {
>   		msg.msg_control = cbuf;
>   		msg.msg_controllen = sizeof(cbuf);
>   	}
> @@ -1430,7 +1439,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>   		goto free_icresp;
>   	}
>   	ret = -ENOTCONN;
> -	if (nvme_tcp_tls(&queue->ctrl->ctrl)) {
> +	if (nvme_tcp_tls_enabled(queue)) {
>   		ctype = tls_get_record_type(queue->sock->sk,
>   					    (struct cmsghdr *)cbuf);
>   		if (ctype != TLS_RECORD_TYPE_DATA) {
> @@ -1581,7 +1590,11 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
>   		key_put(tls_key);
>   		queue->tls_err = -EKEYREVOKED;
>   	} else {
> -		ctrl->ctrl.tls_key = tls_key;
> +		queue->tls_pskid = key_serial(tls_key);
> +		if (qid == 0)
> +			ctrl->ctrl.tls_key = tls_key;
> +		else
> +			key_put(tls_key);
>   		queue->tls_err = 0;
>   	}
>   
> @@ -1762,7 +1775,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   	}
>   
>   	/* If PSKs are configured try to start TLS */
> -	if (IS_ENABLED(CONFIG_NVME_TCP_TLS) && pskid) {
> +	if (nvme_tcp_tls_configured(nctrl) && pskid) {
>   		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
>   		if (ret)
>   			goto err_init_connect;
> @@ -1823,6 +1836,12 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
>   	mutex_lock(&queue->queue_lock);
>   	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
>   		__nvme_tcp_stop_queue(queue);
> +	/* Stopping the queue will disable TLS, so clear the PSK ID */
> +	if (queue->tls_pskid) {
> +		dev_dbg(nctrl->device, "queue %d clear TLS PSK %08x\n",
> +			qid, queue->tls_pskid);
> +		queue->tls_pskid = 0;
> +	}
>   	mutex_unlock(&queue->queue_lock);
>   }
>   
> @@ -1919,16 +1938,17 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   	int ret;
>   	key_serial_t pskid = 0;
>   
> -	if (nvme_tcp_tls(ctrl)) {
> +	if (nvme_tcp_tls_configured(ctrl)) {
>   		if (ctrl->opts->tls_key)
>   			pskid = key_serial(ctrl->opts->tls_key);
> -		else
> +		else {
>   			pskid = nvme_tls_psk_default(ctrl->opts->keyring,
>   						      ctrl->opts->host->nqn,
>   						      ctrl->opts->subsysnqn);
> -		if (!pskid) {
> -			dev_err(ctrl->device, "no valid PSK found\n");
> -			return -ENOKEY;
> +			if (!pskid) {
> +				dev_err(ctrl->device, "no valid PSK found\n");
> +				return -ENOKEY;
> +			}
>   		}
>   	}
>   
> @@ -1949,15 +1969,17 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   
>   static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   {
> +	struct nvme_tcp_ctrl *tcp_ctrl = to_tcp_ctrl(ctrl);
> +	key_serial_t pskid = ctrl->tls_key ? key_serial(ctrl->tls_key) : 0;
>   	int i, ret;
>   
> -	if (nvme_tcp_tls(ctrl) && !ctrl->tls_key) {
> +	if (nvme_tcp_tls_configured(ctrl) && !pskid) {
>   		dev_err(ctrl->device, "no PSK negotiated\n");
>   		return -ENOKEY;
>   	}
> +
>   	for (i = 1; i < ctrl->queue_count; i++) {
> -		ret = nvme_tcp_alloc_queue(ctrl, i,
> -				key_serial(ctrl->tls_key));
> +		ret = nvme_tcp_alloc_queue(ctrl, i, pskid);
>   		if (ret)
>   			goto out_free_queues;
>   	}
> @@ -2138,6 +2160,12 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
>   	if (remove)
>   		nvme_unquiesce_admin_queue(ctrl);
>   	nvme_tcp_destroy_admin_queue(ctrl, remove);
> +	if (ctrl->tls_key) {
> +		dev_dbg(ctrl->device, "Wipe negotiated TLS_PSK %08x\n",
> +			key_serial(ctrl->tls_key));
> +		key_put(ctrl->tls_key);
> +		ctrl->tls_key = NULL;
> +	}
>   }
>   
>   static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,


