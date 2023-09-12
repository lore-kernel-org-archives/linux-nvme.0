Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E655CA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NOCDxLoz5dFv0/gPDS0jUZCfIKEpZ3/jbUqReq5zzw4=; b=eJzWX04dNq9j7gQdhdrab5ij9F
	wTWu2XsQftipldrfF+caBLfi4dQsBkPzFf4ayG4JUMpt5uRMu3bqHCJvMvQcsCptPkkKCDD8t7Hdh
	cG6K3TNrgcRAX2D2Y8/oRZO0HhsabztJfT/PRm6ikyqlc80w5DIHV7EAplfUBhxqow2DS8zCFuVZt
	V+EwO+dBumCz79bFjblqiXN0oPjapX8kdrZMHdvz0VbbrXTneLmrJkqeFa91s3Us8MoImMK/bTzcq
	UigJUMoSrMT0bKnHNLQ/OnEsnb8qyyp5xAiIhY3Pymvxd5jbALPPZ2QQSh1f5jfNnK2A9lZau2fb3
	7Sm7KBjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg2Re-003K7l-0r;
	Tue, 12 Sep 2023 12:24:42 +0000
Received: from mail-lf1-f44.google.com ([209.85.167.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg2Rb-003K7A-1o
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 12:24:41 +0000
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4ffd3c9330dso1253449e87.0
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 05:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694521476; x=1695126276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOCDxLoz5dFv0/gPDS0jUZCfIKEpZ3/jbUqReq5zzw4=;
        b=PeJyDXHaMP3vV6SFGSPSSmRaUSWkXy2AE5Dv4dky3zHW/DbKVfNqfVVXfFxI1giga4
         5wGT44WdQjckejKTOvhKTk7i8QPx0BK1+RKiXrkTF2E6I7129Vgi0HfLhAf7rlXWh+Bk
         Mfsmb17IPa76KM1ocAQv1vaz8Z7QBi+RhofkzzKKA58oM3GVJokN7WWUAHgfExsX/3t/
         MPgUp9NEwKx/vkp3QvoPiqSnnqnudzWjLLs6GQWGTOUFxDmpz6leQncdl8ofpdeTN9qz
         VgD7UMrim+Fp7TFTWNUdrxjZEliFp7yByF/EIQmR3t9Mua6ukdi276L/8Ht1yGVFzJRy
         YWFA==
X-Gm-Message-State: AOJu0YyDCqLsfeJOeimIJSIzhx40kfEUn4XpZtbRSyazjhzZ13qWhWX8
	KvdBckqTPXnjgOSEjtdwDqc=
X-Google-Smtp-Source: AGHT+IHIljqWj86jh6DRHkow9KtCtuTidCdlVoRowjHJprPTrMeHXUr1k5KeeAzcma+99sqiJgepoQ==
X-Received: by 2002:a19:7402:0:b0:501:c223:fa22 with SMTP id v2-20020a197402000000b00501c223fa22mr7973159lfe.6.1694521476414;
        Tue, 12 Sep 2023 05:24:36 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id lx24-20020a170906af1800b0099cb349d570sm6771663ejb.185.2023.09.12.05.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 05:24:35 -0700 (PDT)
Message-ID: <b736e71b-5d4f-f43e-289d-fdcbffc4ce83@grimberg.me>
Date: Tue, 12 Sep 2023 15:24:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RFC] nvmet-tcp: add new workqueue to surpress lockdep
 warning
Content-Language: en-US
To: Guoqing Jiang <guoqing.jiang@linux.dev>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20230726142939.10062-1-guoqing.jiang@linux.dev>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230726142939.10062-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_052439_621929_DDFE51C7 
X-CRM114-Status: GOOD (  27.58  )
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



On 7/26/23 17:29, Guoqing Jiang wrote:
> During the test of nvme-tcp, lockdep complains when discover local
> nvme tcp device.
> 
> [   87.699136] ======================================================
> [   87.699137] WARNING: possible circular locking dependency detected
> [   87.699138] 6.5.0-rc3+ #16 Tainted: G            E
> [   87.699139] ------------------------------------------------------
> [   87.699140] kworker/0:4H/1522 is trying to acquire lock:
> [   87.699141] ffff93c4df45f538 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: __flush_workqueue+0x99/0x4f0
> [   87.699147]
>                 but task is already holding lock:
> [   87.699148] ffffafb40272fe40 ((work_completion)(&queue->io_work)){+.+.}-{0:0}, at: process_one_work+0x236/0x590
> [   87.699151]
>                 which lock already depends on the new lock.
> [   87.699152]
>                 the existing dependency chain (in reverse order) is:
> [   87.699153]
>                 -> #2 ((work_completion)(&queue->io_work)){+.+.}-{0:0}:
> [   87.699155]        __flush_work+0x7a/0x5c0
> [   87.699157]        __cancel_work_timer+0x155/0x1e0
> [   87.699158]        cancel_work_sync+0x10/0x20
> [   87.699160]        nvmet_tcp_release_queue_work+0xcf/0x490 [nvmet_tcp]
> [   87.699163]        process_one_work+0x2bd/0x590
> [   87.699165]        worker_thread+0x52/0x3f0
> [   87.699166]        kthread+0x109/0x140
> [   87.699168]        ret_from_fork+0x46/0x70
> [   87.699170]        ret_from_fork_asm+0x1b/0x30
> [   87.699172]
>                 -> #1 ((work_completion)(&queue->release_work)){+.+.}-{0:0}:
> [   87.699174]        process_one_work+0x28c/0x590
> [   87.699175]        worker_thread+0x52/0x3f0
> [   87.699177]        kthread+0x109/0x140
> [   87.699177]        ret_from_fork+0x46/0x70
> [   87.699179]        ret_from_fork_asm+0x1b/0x30
> [   87.699180]
>                 -> #0 ((wq_completion)nvmet-wq){+.+.}-{0:0}:
> [   87.699182]        __lock_acquire+0x1523/0x2590
> [   87.699184]        lock_acquire+0xd6/0x2f0
> [   87.699185]        __flush_workqueue+0xc5/0x4f0
> [   87.699187]        nvmet_tcp_install_queue+0x30/0x160 [nvmet_tcp]
> [   87.699189]        nvmet_install_queue+0xbf/0x200 [nvmet]
> [   87.699196]        nvmet_execute_admin_connect+0x18b/0x2f0 [nvmet]
> [   87.699200]        nvmet_tcp_io_work+0x7e3/0x850 [nvmet_tcp]
> [   87.699203]        process_one_work+0x2bd/0x590
> [   87.699204]        worker_thread+0x52/0x3f0
> [   87.699206]        kthread+0x109/0x140
> [   87.699207]        ret_from_fork+0x46/0x70
> [   87.699208]        ret_from_fork_asm+0x1b/0x30
> [   87.699209]
>                 other info that might help us debug this:
> [   87.699210] Chain exists of:
>                   (wq_completion)nvmet-wq --> (work_completion)(&queue->release_work) --> (work_completion)(&queue->io_work)
> [   87.699212]  Possible unsafe locking scenario:
> [   87.699213]        CPU0                    CPU1
> [   87.699214]        ----                    ----
> [   87.699214]   lock((work_completion)(&queue->io_work));
> [   87.699215]                                lock((work_completion)(&queue->release_work));
> [   87.699217]                                lock((work_completion)(&queue->io_work));
> [   87.699218]   lock((wq_completion)nvmet-wq);
>                          -> need to hold release_work since queue_work(nvmet_wq, &queue->release_work)
> [   87.699219]
>                  *** DEADLOCK ***
> [   87.699220] 2 locks held by kworker/0:4H/1522:
> [   87.699221]  #0: ffff93c4df45f338 ((wq_completion)nvmet_tcp_wq){+.+.}-{0:0}, at: process_one_work+0x236/0x590
> [   87.699224]  #1: ffffafb40272fe40 ((work_completion)(&queue->io_work)){+.+.}-{0:0}, at: process_one_work+0x236/0x590
> [   87.699227]
>                 stack backtrace:
> [   87.699229] CPU: 0 PID: 1522 Comm: kworker/0:4H Tainted: G            E      6.5.0-rc3+ #16
> [   87.699230] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
> [   87.699231] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
> 
> The above happens because nvmet_tcp_io_work can trigger below path
> 
> 	-> nvmet_tcp_try_recv
> 	 -> nvmet_tcp_try_recv_one
> 	  -> nvmet_tcp_try_recv_data
> 	   -> nvmet_tcp_execute_request
> 	    -> cmd->req.execute = nvmet_execute_admin_connect
> 	     -> nvmet_install_queue
> 	      -> ctrl->ops->install_queue = nvmet_install_queue
> 	       -> nvmet_tcp_install_queue
> 	        -> flush_workqueue(nvmet_wq)
> 
> And release_work (nvmet_tcp_release_queue_work) is also queued in
> nvmet_wq, which need to flush io_work (nvmet_tcp_io_work) due to
> cancel_work_sync(&queue->io_work).

I'm not sure I understand the resolution here. io_work does not
run on nvmet_wq, but on nvmet_tcp_wq. What does separating another
workqueue give here?

> 
> We can surpress the lockdep warning by checking if the relevant work
> is pending. So the simplest might be just add the checking before
> flush_workqueue(nvmet_wq). However, there are other works are also
> queued on the same queue, I am not sure if we should flush other
> works unconditionally, so a new dedicated workqueue is added.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>   drivers/nvme/target/tcp.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 868aa4de2e4c..ac611cb299a8 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -189,6 +189,7 @@ static LIST_HEAD(nvmet_tcp_queue_list);
>   static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
>   
>   static struct workqueue_struct *nvmet_tcp_wq;
> +static struct workqueue_struct *nvmet_tcp_release_wq;
>   static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>   static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
> @@ -1288,7 +1289,7 @@ static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
>   	spin_lock(&queue->state_lock);
>   	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
>   		queue->state = NVMET_TCP_Q_DISCONNECTING;
> -		queue_work(nvmet_wq, &queue->release_work);
> +		queue_work(nvmet_tcp_release_wq, &queue->release_work);
>   	}
>   	spin_unlock(&queue->state_lock);
>   }
> @@ -1847,6 +1848,8 @@ static u16 nvmet_tcp_install_queue(struct nvmet_sq *sq)
>   	if (sq->qid == 0) {
>   		/* Let inflight controller teardown complete */
>   		flush_workqueue(nvmet_wq);
> +		if (work_pending(&queue->release_work))
> +			flush_workqueue(nvmet_tcp_release_wq);

This is effectively just never flushes anything. when we install
the queue it's own release_work never really runs. So what your
patch effectively does is just to remove the flush altogether.

The workqueue separation has nothing to do with anything afaict.

Am I missing something here?

