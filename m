Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8747C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  3 May 2022 11:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Pw2+4T+SFH2Iagw3q36C7JEjIQQBsNO3DRXY51xsec=; b=Ma9hS2dQMeuUrMv4qZtfyfH8IH
	1Hu8IXAG99Zu5Nay7eFlHxHwZ6KZXhJRfe0BJMOCIpyKoxjuWxJxpg8fOwoqZXPDls996QcseN6lg
	hbT8kZ18usTjwqMoRzzQbwrBM94bX3C8igAnPWi+phLyQgvDofVDmYyXXIX4Yn5xeyEaH8wYvsBiM
	TxV1r+OAeAXTH9OP+JDBWgfS1rVqyS6ObsGWPW8a75TqTSYAw/+dQ5TsKY6J23sAzvtD01PxIvZjU
	2EMlmpqjMiwprCHx2EMhBA4gWEI2gRk2tZPBYYeViB9wAD8OlhcTaK9mfUAG4Z+Cg38pYIaQxFOMT
	D8NEgWAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlr0u-005f0l-3w; Tue, 03 May 2022 11:48:20 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlr0r-005ezX-0D
 for linux-nvme@lists.infradead.org; Tue, 03 May 2022 11:48:18 +0000
Received: by mail-wr1-f52.google.com with SMTP id x18so23051463wrc.0
 for <linux-nvme@lists.infradead.org>; Tue, 03 May 2022 04:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=+Pw2+4T+SFH2Iagw3q36C7JEjIQQBsNO3DRXY51xsec=;
 b=vYQ6GpDH9iRu1tfDv3/sduyvdfCee5aSGDzv7YpwZ0lGIANySF+LSC+CDmUxJJkgR6
 +MO0TisGr2vISWpJmNa96NZ9Yn5sC+wDyDpH7xR3qeOsF26xgY02zZIvIqCEAg7wfoHt
 74kPOy5qU5w0F5JgnUda6ePS2Vn7GHWr3M0O8Nez9Mku/+j0lBR2EyTjryWm8ETxQSt/
 I01koq2jgsPStFVyoYQjK0mgJ8lXFSBYlWpS1u4rch+7ZsdGzCREO1T9xwqzreb4mQy3
 7jKgvCkitDJ71sVtk8IM/N5bW0jhGTRTNDEyCSqjF9UsYRhgFB6G2IBfMFjOsgPwVMVJ
 F0JA==
X-Gm-Message-State: AOAM532MSxqu4W0dQIEBaPHGrk8PF/9tHKFIikjPxcQ6E1waEeuksygk
 7BYG82Xf/HWAMmijHxEjGXY=
X-Google-Smtp-Source: ABdhPJzwf7ro0tdW+HKneOpNRAXdBIL1IdQ3fk3QZQ44hBzEcQNFeTIuoqnW0AYbwqtM3fbPhRRDbw==
X-Received: by 2002:a05:6000:168e:b0:20c:547d:11a1 with SMTP id
 y14-20020a056000168e00b0020c547d11a1mr11707529wrd.37.1651578493528; 
 Tue, 03 May 2022 04:48:13 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 j30-20020adfb31e000000b0020c5253d8c2sm8950606wrd.14.2022.05.03.04.48.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 May 2022 04:48:12 -0700 (PDT)
Message-ID: <31923ed3-3d6e-b25c-6971-9d5cdfd4e057@grimberg.me>
Date: Tue, 3 May 2022 14:48:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme-host: tcp: do not read from the socket if we are
 performing a reset
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, cleech@redhat.com
References: <20220415101437.292254-1-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220415101437.292254-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220503_044817_094057_DE509E4C 
X-CRM114-Status: GOOD (  28.69  )
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


> nvme_tcp_io_work() may be scheduled while the controller is resetting,
> triggering kernel crashes because of invalid memory accesses.
> 
> general protection fault, probably for non-canonical
> address 0x82f4228d6e5c6

Can you please provide more details on what kernel this happened? Does
this reproduce in upstream kernel?

>   [exception RIP: _copy_to_iter+1344]
>   [ffffa8a9e5c07c90] __skb_datagram_iter at ffffffffb0c339d8
>   [ffffa8a9e5c07cf8] skb_copy_datagram_iter at ffffffffb0c33c83
>   [ffffa8a9e5c07d28] nvme_tcp_recv_data at ffffffffc04dbff7 [nvme_tcp]
>   [ffffa8a9e5c07d78] nvme_tcp_recv_skb at ffffffffc04dc90e [nvme_tcp]
>   [ffffa8a9e5c07dc0] tcp_read_sock at ffffffffb0cfedbe
>   [ffffa8a9e5c07e10] nvme_tcp_try_recv at ffffffffc04da518 [nvme_tcp]
>   [ffffa8a9e5c07e58] nvme_tcp_io_work at ffffffffc04dbc54 [nvme_tcp]
>   [ffffa8a9e5c07e88] process_one_work at ffffffffb0505408
>   [ffffa8a9e5c07ed0] worker_thread at ffffffffb05059a0
> 
> Fix this bug by preventing nvme_tcp_io_work() from running if the queue
> is not flagged as "LIVE" and is not in the process of
> connecting to the target.

The current controller teardown flow is supposed to guarantee that
io_work will not run after a queue is being stopped. See
nvme_tcp_stop_queue() it shuts down the socket to deny any new
datagrams to go to the network (or come from the network), restore
socket calls so data_ready/write_space are not called again, and
cancels the io_work. New submissions are prevented as the queue
state clears LIVE.

So in theory, io_work should not be running in conjunction with
queue shutdown. Can you explain how it happens to get there?

> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/tcp.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ad3a2bf2f1e9..e3ef014bbc0b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -103,6 +103,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_ALLOCATED	= 0,
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
> +	NVME_TCP_Q_CONNECTING	= 3,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -1213,6 +1214,10 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   		bool pending = false;
>   		int result;
>   
> +		if (unlikely(!test_bit(NVME_TCP_Q_LIVE, &queue->flags) &&
> +				!test_bit(NVME_TCP_Q_CONNECTING, &queue->flags)))
> +			return;

How is this protecting anything? If the queue is torn down we may access
other freed memory, not just from accessing the sockets.

> +
>   		if (mutex_trylock(&queue->send_mutex)) {
>   			result = nvme_tcp_try_send(queue);
>   			mutex_unlock(&queue->send_mutex);
> @@ -1670,6 +1675,8 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>   	int ret;
>   
> +	set_bit(NVME_TCP_Q_CONNECTING, &ctrl->queues[idx].flags);
> +
>   	if (idx)
>   		ret = nvmf_connect_io_queue(nctrl, idx);
>   	else
> @@ -1683,6 +1690,7 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
>   		dev_err(nctrl->device,
>   			"failed to connect queue: %d ret=%d\n", idx, ret);
>   	}
> +	clear_bit(NVME_TCP_Q_CONNECTING, &ctrl->queues[idx].flags);
>   	return ret;
>   }
>   

Question, can you tell from your stack dump if this queue is the admin
queue or I/O queue?

If this is indeed the admin queue, please check if you have a related
fix applied:
0fa0f99fc84e ("nvme: fix a possible use-after-free in controller reset 
during load")

