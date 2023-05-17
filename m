Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D65C77B7F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 07:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QLqrjJsnIB2N6yBxeoj25vKMQ6BC6HBL/+vq8ROpYfE=; b=QFIWCYj4kF+x0OXU69KMF8pSJO
	xoYYhYNGEOYtjlY9BjbNisQ8mNYk6R0nLY+XlYx11ulW8TeP8i9g8MuNjBkkd919+CyO0he7PNRj5
	xgv2eWO046ksiDH/yF9IqAjaIb+z+uiPNteZ5ylGxrpMf/GLqLtUWUhWmabGQJcHyGMQP91b7YZZT
	PASSXrMDl3wE9LVQkea3lT/B0JwjKMiialVV5BsFdH8By6tUma1pcNvEIpAYDZPNhRoc9NomFdSU8
	z2Fr68RpfvL6AFvCrF5Z6Jajm4ToxxYrq5MpMxod/ZaVYYo6Vn1BWWynXYTUhImzih18ojqzAwejA
	KW+XW+Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBo0-008iK5-0y;
	Wed, 17 May 2023 07:42:40 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBnw-008iIJ-1m
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 07:42:38 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3079b59230eso19245f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 00:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684309354; x=1686901354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLqrjJsnIB2N6yBxeoj25vKMQ6BC6HBL/+vq8ROpYfE=;
        b=OzHrzOXJJL46BaZzotmfce7Cs96u2lIrB1HgL36zlb8sFFFWRbxPnTnfMz0hODaSMH
         80Qi6v3gzQ9ZkvUuVfU8opRPG7qZZ9cEim4vRZ2+OEVpANpagF+m3u/vMdXhfhfoFp+4
         ny+/TBFoWnsoYkWVlIgwpgxMol+sI7D3VvmB1qUoYPYB47b8dlLrxS+qaCSVfKwU+6AI
         F3+j7zy3n81w7jpkA275yVJ3fJWldoVKjlzEI5JV1e72XNqHupNQtOks1sDW9fDu9nSv
         LZFV+isehJ+RU2vgNfbqVGLxKZqz4QWL9Pa1IsiVaeYOwnUI+z7SlujYQpWgaI+9mGqe
         r+wA==
X-Gm-Message-State: AC+VfDz/TCGnBMdXJD/LH/AZ8HDviNB8t8GMepUD/HN9P1yfG8X7QTGk
	fPpDIiiJ7aQ4t5dw+gbbwVvBSVwLFwI=
X-Google-Smtp-Source: ACHHUZ6dh+yN1BFImfTxQPIcqngcWsWqp9kJJzx0fp9heGaKmnTYnV8Q4IqAEpWhy+KJdStXAkCtNg==
X-Received: by 2002:a5d:54c9:0:b0:307:5561:5eec with SMTP id x9-20020a5d54c9000000b0030755615eecmr1233107wrv.0.1684309353634;
        Wed, 17 May 2023 00:42:33 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b003078681a1e8sm1940449wrp.54.2023.05.17.00.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:42:33 -0700 (PDT)
Message-ID: <f2909fb6-26e4-f99f-c55b-1dcec577bb44@grimberg.me>
Date: Wed, 17 May 2023 10:42:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvmet-rdma: Release connections synchronously
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230511150321.103172-1-bvanassche@acm.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230511150321.103172-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_004236_593962_0C9FCEDE 
X-CRM114-Status: GOOD (  31.93  )
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



On 5/11/23 18:03, Bart Van Assche wrote:
> Lockdep complains about flushing queue->release_work in the NVMe RDMA target
> driver because all instances of queue->release_work have the same lock class
> key. Assigning a different lock class key to each release_work instance is
> difficult because dynamically registered lock class keys must be unregistered
> and the last use of the work_struct lock class key happens after the work
> callback has returned. Hence rework the code for releasing connections as
> follows:
> * Add an argument to __nvmet_rdma_queue_disconnect() and also to
>    nvmet_rdma_queue_disconnect() that indicates whether or not these functions
>    are called from inside a CM handler callback.
> * Do not call rdma_destroy_id() if called from inside a CM handler callback.
> * Let these functions return a negative value if the caller should free the
>    CM ID.
> * Let the CM handler return a negative value if its caller should free the
>    CM ID.
> * Remove queue->release_work since releasing connections now happens
>    synchronously.
> 
> This patch suppresses the following lockdep complaint:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.3.0 #62 Not tainted
> ------------------------------------------------------
> kworker/1:3/455 is trying to acquire lock:
> ffff88813bfd9420 (&id_priv->handler_mutex){+.+.}-{3:3}, at: rdma_destroy_id+0x17/0x20 [rdma_cm]
> 
> but task is already holding lock:
> ffff888131327db0 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x793/0x1350
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #3 ((work_completion)(&queue->release_work)){+.+.}-{0:0}:
>         process_one_work+0x7dc/0x1350
>         worker_thread+0xfc/0x1260
>         kthread+0x29e/0x340
>         ret_from_fork+0x2c/0x50
> 
> -> #2 ((wq_completion)nvmet-wq){+.+.}-{0:0}:
>         __flush_workqueue+0x130/0x12f0
>         nvmet_rdma_cm_handler+0x961/0x39c0 [nvmet_rdma]
>         cma_cm_event_handler+0xb2/0x2f0 [rdma_cm]
>         cma_ib_req_handler+0x1096/0x4a50 [rdma_cm]
>         cm_process_work+0x46/0x3b0 [ib_cm]
>         cm_req_handler+0x20e2/0x61d0 [ib_cm]
>         cm_work_handler+0xc15/0x6ce0 [ib_cm]
>         process_one_work+0x843/0x1350
>         worker_thread+0xfc/0x1260
>         kthread+0x29e/0x340
>         ret_from_fork+0x2c/0x50
> 
> -> #1 (&id_priv->handler_mutex/1){+.+.}-{3:3}:
>         __mutex_lock+0x186/0x18f0
>         cma_ib_req_handler+0xc3c/0x4a50 [rdma_cm]
>         cm_process_work+0x46/0x3b0 [ib_cm]
>         cm_req_handler+0x20e2/0x61d0 [ib_cm]
>         cm_work_handler+0xc15/0x6ce0 [ib_cm]
>         process_one_work+0x843/0x1350
>         worker_thread+0xfc/0x1260
>         kthread+0x29e/0x340
>         ret_from_fork+0x2c/0x50
> 
> -> #0 (&id_priv->handler_mutex){+.+.}-{3:3}:
>         __lock_acquire+0x2fc0/0x60f0
>         lock_acquire+0x1a7/0x4e0
>         __mutex_lock+0x186/0x18f0
>         rdma_destroy_id+0x17/0x20 [rdma_cm]
>         nvmet_rdma_free_queue+0x7a/0x380 [nvmet_rdma]
>         nvmet_rdma_release_queue_work+0x3e/0x90 [nvmet_rdma]
>         process_one_work+0x843/0x1350
>         worker_thread+0xfc/0x1260
>         kthread+0x29e/0x340
>         ret_from_fork+0x2c/0x50
> 
> other info that might help us debug this:
> 
> Chain exists of:
>    &id_priv->handler_mutex --> (wq_completion)nvmet-wq --> (work_completion)(&queue->release_work)
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock((work_completion)(&queue->release_work));
>                                 lock((wq_completion)nvmet-wq);
>                                 lock((work_completion)(&queue->release_work));
>    lock(&id_priv->handler_mutex);
> 
>   *** DEADLOCK ***
> 
> 2 locks held by kworker/1:3/455:
>   #0: ffff888127b28538 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_one_work+0x766/0x1350
>   #1: ffff888131327db0 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x793/0x1350
> 
> stack backtrace:
> CPU: 1 PID: 455 Comm: kworker/1:3 Not tainted 6.3.0 #62
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
> Workqueue: nvmet-wq nvmet_rdma_release_queue_work [nvmet_rdma]
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x57/0x90
>   check_noncircular+0x27b/0x310
>   __lock_acquire+0x2fc0/0x60f0
>   lock_acquire+0x1a7/0x4e0
>   __mutex_lock+0x186/0x18f0
>   rdma_destroy_id+0x17/0x20 [rdma_cm]
>   nvmet_rdma_free_queue+0x7a/0x380 [nvmet_rdma]
>   nvmet_rdma_release_queue_work+0x3e/0x90 [nvmet_rdma]
>   process_one_work+0x843/0x1350
>   worker_thread+0xfc/0x1260
>   kthread+0x29e/0x340
>   ret_from_fork+0x2c/0x50
>   </TASK>
> 
> See also https://lore.kernel.org/all/rsmmxrchy6voi5qhl4irss5sprna3f5owkqtvybxglcv2pnylm@xmrnpfu3tfpe/
> 
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/nvme/target/rdma.c | 70 ++++++++++++++++++++------------------
>   1 file changed, 37 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 4597bca43a6d..cfd9d4368248 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -101,7 +101,6 @@ struct nvmet_rdma_queue {
>   	spinlock_t		rsps_lock;
>   	struct nvmet_rdma_cmd	*cmds;
>   
> -	struct work_struct	release_work;
>   	struct list_head	rsp_wait_list;
>   	struct list_head	rsp_wr_wait_list;
>   	spinlock_t		rsp_wr_wait_lock;
> @@ -167,7 +166,8 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
>   static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc);
>   static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc);
>   static void nvmet_rdma_qp_event(struct ib_event *event, void *priv);
> -static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue);
> +static int nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue,
> +				       bool from_cm_handler);
>   static void nvmet_rdma_free_rsp(struct nvmet_rdma_device *ndev,
>   				struct nvmet_rdma_rsp *r);
>   static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
> @@ -693,7 +693,7 @@ static void nvmet_rdma_error_comp(struct nvmet_rdma_queue *queue)
>   		 * of admin connect error, just disconnect and
>   		 * cleanup the queue
>   		 */
> -		nvmet_rdma_queue_disconnect(queue);
> +		nvmet_rdma_queue_disconnect(queue, false);
>   	}
>   }
>   
> @@ -1360,17 +1360,6 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
>   	kfree(queue);
>   }
>   
> -static void nvmet_rdma_release_queue_work(struct work_struct *w)
> -{
> -	struct nvmet_rdma_queue *queue =
> -		container_of(w, struct nvmet_rdma_queue, release_work);
> -	struct nvmet_rdma_device *dev = queue->dev;
> -
> -	nvmet_rdma_free_queue(queue);
> -
> -	kref_put(&dev->ref, nvmet_rdma_free_dev);
> -}
> -
>   static int
>   nvmet_rdma_parse_cm_connect_req(struct rdma_conn_param *conn,
>   				struct nvmet_rdma_queue *queue)
> @@ -1441,11 +1430,6 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
>   	if (ret)
>   		goto out_destroy_sq;
>   
> -	/*
> -	 * Schedules the actual release because calling rdma_destroy_id from
> -	 * inside a CM callback would trigger a deadlock. (great API design..)
> -	 */
> -	INIT_WORK(&queue->release_work, nvmet_rdma_release_queue_work);
>   	queue->dev = ndev;
>   	queue->cm_id = cm_id;
>   	queue->port = port->nport;
> @@ -1582,11 +1566,6 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
>   		goto put_device;
>   	}
>   
> -	if (queue->host_qid == 0) {
> -		/* Let inflight controller teardown complete */
> -		flush_workqueue(nvmet_wq);
> -	}
> -
>   	ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
>   	if (ret) {
>   		/*

You could have simply removed this hunk alone to make lockdep quiet on
this, without the need to rework the async queue removal.

The flush here was added to prevent a reset/connect/disconnect storm
causing the target to run out of resources (which we have seen reports
about in the distant past). What prevents it now?

And you both reworked the teardown, and still removed the flush, I don't
get why both are needed.

