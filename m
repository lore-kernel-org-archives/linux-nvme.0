Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FACC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 22:03:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F89D64DA1
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 22:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F89D64DA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HpRxw0fB0NSrOGoZ1/kSnK8cfkut93iVW7i2qVgu3ks=; b=3FtKv7ECkLBAoVCCQZaxvpoTo
	GsOWoNLaV0xKHBdShyF4Kx631SOPePR8wKd1tUqzO3pn+DVUG9Mb9WsUGLHO+dZhMplh+m8QAzuG2
	U6NojoSTrfPc+zUJaOaom1pZa/uxq+1pruSaaX3G9PifWaW3TIKaW0Zh/sA75HUowWw/FNxEluIGG
	u8tyUaH1Sr4QMEANRGl7SiOGyhTZWDM3eeI3iHoQbz9B1sfvNrIoZdtmLVrdKk8M7AJwE+HOk53UG
	ByGuAdZQ64rmqKKCboaoskljKG5Y/CuDSXSHKNUdj+7x5Gxg8ZubEf5OViEA6APLTvrNY6qT+PqRW
	4OAW8QVKw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5FNs-0003FB-Op; Thu, 28 Jan 2021 22:03:24 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5FNp-0003EX-JS
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 22:03:23 +0000
Received: by mail-wr1-f50.google.com with SMTP id s7so3943709wru.5
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 14:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K2suuWRgNXdt+NO5zcLxuJrOKV3bEk83YNPV1X5sIjU=;
 b=IHDKVnOGjxs2UoytimaeLBSG2+011E2b+BHmw2ICIlfVSddVDXJCjf6gdjWe/cEpwY
 5TPR8j0cSnmFNWyfCmKEH67lSfE+rxu5qU/VYMLDJpH9hl99M6AhkiUhYcY9bC/vXktW
 mUz6YJBj0Sw+SMS8+tOm6kSwqcB7OXYiaGzVJ5UIlqQkVtAwbCVAyiMb9OLHEJhs4/Ot
 c+miZ68bcyvXuTYzfBH1P262HaxTXLk7d29LKzcP9q9lNjFcpBmE+JASL01JIlqPIQQc
 UxqPKJeGYswt2Il2G/jK8v4zSErm6Ag5YFROdLgRJXHHcQeszxD1RPuNF5OSasIurHtI
 BXZA==
X-Gm-Message-State: AOAM5316maHAN6zNu3zvrwkaMstIg9IPKcwvIQZ+PudwOclNaDKt3FGS
 EzjNjqsl1NqX0SKYVFxVeMBdhyGpsbk=
X-Google-Smtp-Source: ABdhPJwbdMl11sVWJVTnftKnTGo+OcuOF0Y6aYjRcEJrK06GARFbpJZRM5sQ1plRNbpwbq0tGD/lDw==
X-Received: by 2002:a5d:6541:: with SMTP id z1mr1212538wrv.128.1611871399594; 
 Thu, 28 Jan 2021 14:03:19 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578?
 ([2601:647:4802:9070:3d48:4849:d506:e578])
 by smtp.gmail.com with ESMTPSA id u10sm6922672wmj.40.2021.01.28.14.03.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 14:03:19 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
To: elad.grupi@dell.com, linux-nvme@lists.infradead.org
References: <20210128152758.114112-1-elad.grupi@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2c2a3aa6-ca43-e9b0-7928-28c6962ea1bc@grimberg.me>
Date: Thu, 28 Jan 2021 14:03:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128152758.114112-1-elad.grupi@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_170321_670069_2ED1713E 
X-CRM114-Status: GOOD (  21.37  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> ---
>   drivers/nvme/target/tcp.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index d535080b781f..dac737bac874 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -647,7 +647,7 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
>   	struct nvmet_tcp_cmd *cmd = queue->snd_cmd;
>   	int ret = 0;
>   
> -	if (!cmd || queue->state == NVMET_TCP_Q_DISCONNECTING) {
> +	if (!cmd) {
>   		cmd = nvmet_tcp_fetch_cmd(queue);
>   		if (unlikely(!cmd))
>   			return 0;
> @@ -1453,9 +1453,27 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   	sock->sk->sk_state_change = nvmet_tcp_state_change;
>   	queue->write_space = sock->sk->sk_write_space;
>   	sock->sk->sk_write_space = nvmet_tcp_write_space;
> +
> +	switch (sk->sk_state) {
> +	case TCP_FIN_WAIT1:
> +	case TCP_CLOSE_WAIT:
> +	case TCP_CLOSE:
> +		/* FALLTHRU */
> +		sock->sk->sk_data_ready =  queue->data_ready;
> +		sock->sk->sk_state_change = queue->state_change;
> +		sock->sk->sk_write_space = queue->write_space;
> +		sk->sk_user_data = NULL;
> +		queue->state = NVMET_TCP_Q_DISCONNECTING;
> +		ret = -ENOTCONN;
> +		break;
> +	default:
> +		queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
> +		ret = 0;
> +	}
> +
>   	write_unlock_bh(&sock->sk->sk_callback_lock);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
> @@ -1506,8 +1524,6 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   	if (ret)
>   		goto out_destroy_sq;
>   
> -	queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
> -
>   	return 0;
>   out_destroy_sq:
>   	mutex_lock(&nvmet_tcp_queue_mutex);
> 


What about this instead?
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index c41902f7ce39..6388d18ca7c2 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1494,16 +1494,28 @@ static int nvmet_tcp_set_queue_sock(struct 
nvmet_tcp_queue *queue)
                 ip_sock_set_tos(sock->sk, inet->rcv_tos);

         write_lock_bh(&sock->sk->sk_callback_lock);
-       sock->sk->sk_user_data = queue;
-       queue->data_ready = sock->sk->sk_data_ready;
-       sock->sk->sk_data_ready = nvmet_tcp_data_ready;
-       queue->state_change = sock->sk->sk_state_change;
-       sock->sk->sk_state_change = nvmet_tcp_state_change;
-       queue->write_space = sock->sk->sk_write_space;
-       sock->sk->sk_write_space = nvmet_tcp_write_space;
+       switch (sk->sk_state) {
+       case TCP_FIN_WAIT1:
+       case TCP_CLOSE_WAIT:
+       case TCP_CLOSE:
+               /*
+                * If the socket is already closing, don't even start
+                * consuming it
+                */
+               ret = -ENOTCONN;
+               break;
+       default:
+               sock->sk->sk_user_data = queue;
+               queue->data_ready = sock->sk->sk_data_ready;
+               sock->sk->sk_data_ready = nvmet_tcp_data_ready;
+               queue->state_change = sock->sk->sk_state_change;
+               sock->sk->sk_state_change = nvmet_tcp_state_change;
+               queue->write_space = sock->sk->sk_write_space;
+               sock->sk->sk_write_space = nvmet_tcp_write_space;
+       }
         write_unlock_bh(&sock->sk->sk_callback_lock);

-       return 0;
+       return ret;
  }
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
