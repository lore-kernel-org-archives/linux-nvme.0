Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC7FC3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 22:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YONT5yeQ3T80sf/dDflh+nbF1VvUxDAUo/SSIX5JPpU=; b=n6nrIrCNTk7xH6uvUH8PNoOkr8
	eV+9IFdnYtQ+Of9xb+KJ/bzUdAB/AjkgKZnkFDPRm9jFrD40K5Ym1yQ7ea00tRoQqcGLfBTKorqVN
	A/kPFp4QyHgiPtUL/KmVRRypLRfI+RAyWdpx5K7y+7nGBJ6Yi/Q+uwizePKUsB2+llWmybdtbNFJa
	m1EErXpcPw1S7lPnlmhGgFWHaY2qwpe10wbyM1IhYn8LFoWc46ERUR5X+Rgt3wwIYFmkSw51CFRJ9
	F4d0IGHplXpD+OLG1r45uFd7lCB3ehxgRUvD73/krobCde/E6DqvrAZNIVUGTGKJfwBTrP17AVyx7
	VGkBpCGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45Qp-00000000DQs-3vb9;
	Sun, 13 Apr 2025 22:04:03 +0000
Received: from mail-ej1-f49.google.com ([209.85.218.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45Qn-00000000DQR-09Uj
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 22:04:02 +0000
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aca99fc253bso577483066b.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 15:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744581839; x=1745186639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YONT5yeQ3T80sf/dDflh+nbF1VvUxDAUo/SSIX5JPpU=;
        b=j6XmHSmqumhEcpBpkann7IxkWpVDFPqSLoQiupTfyTeMb4M61iUvokAeEFx3cOt9WO
         nQZmCxtcdGUcdU40O+/svtsNJXhfNRvcs+Tan3rbkfGQ/EUKHXGmUQkSyuXOD2xnKBWO
         5ORMfswXdhN1j0/gVJ+pefH/IyLe/WmY9/forpRY1okCi6a9rnAE34Oi3Q4dCsVgv5Ij
         CU8AR/S3GvX7FtDlrZuTDPVtey4xGuKe7uqXPozc1EscRpeZIIyly7HNqblxf3NlxQ0N
         I/mQfgOZf5FBQbFibmsJfjLG4p1XOh7OYrYl0HVyFWO9NVMXOx12VacPKMcAhN3ISHyD
         L7VA==
X-Gm-Message-State: AOJu0YwQBJ3brEgoUBRXuxBaQdDF2tqtAj86ndVH1yPMSpEnQyv5arCv
	eo3oRF1JV3ocFvbCwTVXZ4aceY6kd479arplUKwdEKX1s6O/niry
X-Gm-Gg: ASbGnctBLJnVThymTx02K1bs8Yh28j47797IOASyK0yLawOjht6ZMqIR+2ALsCpLYD3
	JeOpNePVlUAYp/8DWiZ6jebVoSLhv/4CFLYqBSUVrUbOVfsojil6a2LOpI1xSb2mQS9/hoSsyA7
	Fmb7wHdsdSrGbMbdqICq6Ft/Y4HRwwkXFIWCuun4Yj+fssDZkhqmShDKBMKmXwpi9IqrQiAip8E
	Tdy+pb024WZjQA5B03/drtGsmYkLBs6bUj8cDcEV94Qfh3prpoxigen8IuhR7l85epiw8vQjZvU
	yg80S0sfGLxouSWTB0qKqojwbMPP0ls532LwX7+H1sHycOuWgZ8atlri0H6bETyu7jpBeyLp
X-Google-Smtp-Source: AGHT+IEiKLfe3AT3FpfDTLzZaqr45zgUDZttsr7Ly01b+8c35GOhUM20P7v/fOtTiiyw8FxiSohwWw==
X-Received: by 2002:a17:906:6a22:b0:aca:e1ea:c5fc with SMTP id a640c23a62f3a-acae1eacccbmr564928066b.26.1744581838979;
        Sun, 13 Apr 2025 15:03:58 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb41e4sm805576466b.108.2025.04.13.15.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 15:03:58 -0700 (PDT)
Message-ID: <94ec166a-2025-4743-8e36-fd1e96c33d6e@grimberg.me>
Date: Mon, 14 Apr 2025 01:03:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
To: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com,
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_150401_115134_FD18790A 
X-CRM114-Status: GOOD (  29.05  )
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



On 24/03/2025 14:07, Daniel Wagner wrote:
> The TP4129 mendates that the failover should be delayed by CQT.  Thus when
> nvme_decide_disposition returns FAILOVER do not immediately re-queue it on
> the namespace level instead queue it on the ctrl's request_list and
> moved later to the namespace's requeue_list.
>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/core.c      | 19 ++++++++++++++++
>   drivers/nvme/host/fc.c        |  4 ++++
>   drivers/nvme/host/multipath.c | 52 ++++++++++++++++++++++++++++++++++++++++---
>   drivers/nvme/host/nvme.h      | 15 +++++++++++++
>   drivers/nvme/host/rdma.c      |  2 ++
>   drivers/nvme/host/tcp.c       |  1 +
>   6 files changed, 90 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 135045528ea1c79eac0d6d47d5f7f05a7c98acc4..f3155c7735e75e06c4359c26db8931142c067e1d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -239,6 +239,7 @@ static void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl)
>   
>   	flush_work(&ctrl->reset_work);
>   	nvme_stop_ctrl(ctrl);
> +	nvme_flush_failover(ctrl);

This will terminate all pending failvoer commands - this is the intended 
behavior?

>   	nvme_remove_namespaces(ctrl);
>   	ctrl->ops->delete_ctrl(ctrl);
>   	nvme_uninit_ctrl(ctrl);
> @@ -1310,6 +1311,19 @@ static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
>   	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
>   }
>   
> +void nvme_schedule_failover(struct nvme_ctrl *ctrl)
> +{
> +	unsigned long delay;
> +
> +	if (ctrl->cqt)
> +		delay = msecs_to_jiffies(ctrl->cqt);
> +	else
> +		delay = ctrl->kato * HZ;

This delay was there before?

> +
> +	queue_delayed_work(nvme_wq, &ctrl->failover_work, delay);
> +}
> +EXPORT_SYMBOL_GPL(nvme_schedule_failover);
> +
>   static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>   						 blk_status_t status)
>   {
> @@ -1336,6 +1350,8 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>   		dev_err(ctrl->device,
>   			"failed nvme_keep_alive_end_io error=%d\n",
>   				status);
> +
> +		nvme_schedule_failover(ctrl);
>   		return RQ_END_IO_NONE;
>   	}
>   
> @@ -4716,6 +4732,7 @@ EXPORT_SYMBOL_GPL(nvme_remove_io_tag_set);
>   
>   void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   {
> +	nvme_schedule_failover(ctrl);
>   	nvme_mpath_stop(ctrl);
>   	nvme_auth_stop(ctrl);
>   	nvme_stop_failfast_work(ctrl);
> @@ -4842,6 +4859,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   
>   	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
>   	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
> +	INIT_DELAYED_WORK(&ctrl->failover_work, nvme_failover_work);
> +	INIT_LIST_HEAD(&ctrl->failover_list);
>   	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
>   	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
>   	ctrl->ka_last_check_time = jiffies;
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index cdc1ba277a5c23ef1afd26e6911b082f3d12b215..bd897b29cd286008b781bbcb4230e08019da6b6b 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2553,6 +2553,8 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
>   {
>   	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
>   
> +	nvme_schedule_failover(&ctrl->ctrl);
> +
>   	/*
>   	 * if an error (io timeout, etc) while (re)connecting, the remote
>   	 * port requested terminating of the association (disconnect_ls)
> @@ -3378,6 +3380,8 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
>   	/* will block will waiting for io to terminate */
>   	nvme_fc_delete_association(ctrl);
>   
> +	nvme_schedule_failover(&ctrl->ctrl);
> +
>   	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
>   		dev_err(ctrl->ctrl.device,
>   			"NVME-FC{%d}: error_recovery: Couldn't change state "
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 2a7635565083046c575efe1793362ae10581defd..a14b055796b982df96609f53174a5d1334c1c0c4 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -86,9 +86,11 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
>   void nvme_failover_req(struct request *req)
>   {
>   	struct nvme_ns *ns = req->q->queuedata;
> +	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
>   	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
>   	unsigned long flags;
>   	struct bio *bio;
> +	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
>   
>   	nvme_mpath_clear_current_path(ns);
>   
> @@ -121,9 +123,53 @@ void nvme_failover_req(struct request *req)
>   	blk_steal_bios(&ns->head->requeue_list, req);
>   	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
>   
> -	nvme_req(req)->status = 0;
> -	nvme_end_req(req);
> -	kblockd_schedule_work(&ns->head->requeue_work);
> +	spin_lock_irqsave(&ctrl->lock, flags);
> +	list_add_tail(&req->queuelist, &ctrl->failover_list);
> +	spin_unlock_irqrestore(&ctrl->lock, flags);

So these request - which we stripped their bios, are now placed
on a failover queue?

> +
> +	if (state == NVME_CTRL_DELETING) {
> +		/*
> +		 * request which fail over in the DELETING state were
> +		 * canceled and blk_mq_tagset_wait_completed_request will
> +		 * block until they have been proceed. Though
> +		 * nvme_failover_work is already stopped. Thus schedule
> +		 * a failover; it's still necessary to delay these commands
> +		 * by CQT.
> +		 */
> +		nvme_schedule_failover(ctrl);

This condition is unclear. Isn't any request failing over should do this?
Something is unclear here.

> +	}
> +}
> +
> +void nvme_flush_failover(struct nvme_ctrl *ctrl)
> +{
> +	LIST_HEAD(failover_list);
> +	struct request *rq;
> +	bool kick = false;
> +
> +	spin_lock_irq(&ctrl->lock);
> +	list_splice_init(&ctrl->failover_list, &failover_list);
> +	spin_unlock_irq(&ctrl->lock);
> +
> +	while (!list_empty(&failover_list)) {
> +		rq = list_entry(failover_list.next,
> +				struct request, queuelist);
> +		list_del_init(&rq->queuelist);
> +
> +		nvme_req(rq)->status = 0;
> +		nvme_end_req(rq);
> +		kick = true;
> +	}
> +
> +	if (kick)
> +		nvme_kick_requeue_lists(ctrl);
> +}
> +
> +void nvme_failover_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
> +					struct nvme_ctrl, failover_work);
> +
> +	nvme_flush_failover(ctrl);
>   }
>   
>   void nvme_mpath_start_request(struct request *rq)
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 7563332b5b7b76fc6165ec8c6f2d144737d4fe85..10eb323bdaf139526959180c1e66ab4579bb145d 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -411,6 +411,9 @@ struct nvme_ctrl {
>   
>   	enum nvme_ctrl_type cntrltype;
>   	enum nvme_dctype dctype;
> +
> +	struct delayed_work failover_work;
> +	struct list_head failover_list;
>   };
>   
>   static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
> @@ -954,6 +957,9 @@ void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
>   void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
>   void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys);
>   void nvme_failover_req(struct request *req);
> +void nvme_failover_work(struct work_struct *work);
> +void nvme_schedule_failover(struct nvme_ctrl *ctrl);
> +void nvme_flush_failover(struct nvme_ctrl *ctrl);
>   void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
>   int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
>   void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid);
> @@ -996,6 +1002,15 @@ static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
>   static inline void nvme_failover_req(struct request *req)
>   {
>   }
> +static inline void nvme_failover_work(struct work_struct *work)
> +{
> +}
> +static inline void nvme_schedule_failover(struct nvme_ctrl *ctrl)
> +{
> +}
> +static inline void nvme_flush_failover(struct nvme_ctrl *ctrl)
> +{
> +}
>   static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
>   {
>   }
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 86a2891d9bcc7a990cd214a7fe93fa5c55b292c7..9bee376f881b4c3ebe5502abf23a8e76829780ff 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1127,6 +1127,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>   
>   	nvme_stop_keep_alive(&ctrl->ctrl);
>   	flush_work(&ctrl->ctrl.async_event_work);
> +	nvme_schedule_failover(&ctrl->ctrl);
>   	nvme_rdma_teardown_io_queues(ctrl, false);
>   	nvme_unquiesce_io_queues(&ctrl->ctrl);
>   	nvme_rdma_teardown_admin_queue(ctrl, false);
> @@ -2153,6 +2154,7 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
>   
>   static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
>   {
> +	nvme_schedule_failover(&ctrl->ctrl);
>   	nvme_rdma_teardown_io_queues(ctrl, shutdown);
>   	nvme_quiesce_admin_queue(&ctrl->ctrl);
>   	nvme_disable_ctrl(&ctrl->ctrl, shutdown);
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index d0023bcfd8a79a193adf2807a24481c8c164a174..3a6c1d3febaf233996e4dcf684793327b5d1412f 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2345,6 +2345,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   
>   	nvme_stop_keep_alive(ctrl);
>   	flush_work(&ctrl->async_event_work);
> +	nvme_schedule_failover(ctrl);
>   	nvme_tcp_teardown_io_queues(ctrl, false);
>   	/* unquiesce to fail fast pending requests */
>   	nvme_unquiesce_io_queues(ctrl);
>

What is the reason for rdma and tcp not being identical?

