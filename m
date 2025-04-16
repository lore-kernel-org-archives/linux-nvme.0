Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1F1C369AB
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 00:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iw0pUso11WucIlqdtormnEIGUdCPzU4SSaBeRiqQKmE=; b=vKydEBjoz3I/YHGQ3Q49tlplDQ
	QCyw0osyQ8c7SPh3EP3ztK9i51tYo/5vW9wLOd4cst0LxVFgf78NkHkZOYQIz8mfuZy8fis1fokGj
	lzrqNUF0IREZ4gwsAHQIOD47oBG0cjKiX4GliYcRS502zH9ifPXxj9KtKWkwyjFJIPzjH/14Xh9Ut
	Z7fC/j/VV95WsfDQ8flmiFnWyv9PjW4DsYjG5923fmySY1TYg0skkjsnMQiWC8104d9uZVryiRxNQ
	aU4XaIecyZx0DKBWge9tXEFUoywP5d4R3UiMDWvGiyzbSO3r/FUsqXxP5PybXVfXJIA2d2s0dBAV0
	Rk8KeMRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4qYq-00000007eD5-21ox;
	Wed, 16 Apr 2025 00:23:28 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4qYo-00000007eCE-2QGJ
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 00:23:27 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2240b4de12bso84196795ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 15 Apr 2025 17:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744763006; x=1745367806; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iw0pUso11WucIlqdtormnEIGUdCPzU4SSaBeRiqQKmE=;
        b=SmgajhJcdQfbydZOsKmHgNEzY3CcYWx3F+tuIpxevF0yifz+XgP9AKp4dSY8AtJkpm
         M2JZDqzpqTZfhTWqXA01RhkpEFxK+WNKUcIDpwBW5FFdihFBIpjb/CQM6r6XOJoZJMLy
         fSXFKn7+6NJJgGB7Y5kQ+MtqPxZYemxNElAZpt3Pc8xhCXamSnnkFu+qaE6ibEWudBOe
         qSyX2Zm1hV0WIsxDOsYTnBTMojMKhv2AuufyObwJgShxiPAHwT1/Gg/0fTywq8H79mT7
         zYo2azHMNay0awVXwUvoOQG3UWWUHD/HCCEfws928grjm5S96ch8fEqRTAaurf8MCvQt
         UaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744763006; x=1745367806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iw0pUso11WucIlqdtormnEIGUdCPzU4SSaBeRiqQKmE=;
        b=Vs2PzmjtwueV/J3SmC7AXT0kc8zMLlGVksDQG9GHq+kRiL7pl22lgmD84HlLlpUuQw
         et8D1mDLzjXxUTJbV+cXUUX0j8bsnNyyqtkEqeOwUDL1zqW3htIuIOm1LAL9GJ3k4bWD
         knTtv6MI/E8Xp+d2ABiNeQV4Q0hjlyWcaYFzx2u9JABT8Fgj9eSAyXUFOvR8VAzoU3/n
         eDZUnSVumLoOEfZRv72isDAMPf0OxmtgL28a5SoG1kiDuXTljvws+bZMnYIq7z01Ib7B
         HNcQtA8mAGIAL1vb1JNxSmWXCgcnMaHn3+My/or62Y/ssC1jsdTVRLx0E08F4sYzp2Cq
         47eA==
X-Forwarded-Encrypted: i=1; AJvYcCWTeYh+9PZIQvcLru19H04BFFSZfuh4ZdNadXKhXggAX9O12+gi10xJQCpnS4OJnHldlXtAOHKVykLd@lists.infradead.org
X-Gm-Message-State: AOJu0Yw/m97L4xq9YDenhnW87yr4RsaSbTyhVIYwsUmoywJt1+inXFqJ
	eh4IrRVMAmQIS9HOxIES3TpDOXJiKw+rZhtcpAf4h5tosnjpV/OTJbBZ2Q72Uj4=
X-Gm-Gg: ASbGnct2IBLmdbXH476/89EFG1wKMnguZJtM+w0DN1BHsmLYvo/D775+2M+t2dy3VJG
	3hkBsXqw9+26w5kiOR980oYFL8cGt1n5bzJufQMuGK6u9emeQzXfMCEh2g/C4xHMraZ7fWOi9Fi
	dWG1MzobCc2bFLKOyUXTz1sK7ShCYfH3SFHeTZ22PpaMnUtKje0mRVpg7fpxHgLQC8wX80z4cbK
	E4orp/ZJ0BDaClauE5R6Nfzi+g451ZEt3lZVg6za1ejGtpCwUQXUFm+9T0rkJpKVW8WXTruqp4L
	ZIUUk+Y8VIfRCV1zdBSFd9MOTleyHi2e0tg6j/Dm7izfOD5jvxPz8/Ooj+6ZIw==
X-Google-Smtp-Source: AGHT+IGJeuMbV3k0jW0loSUVH+gLC2S4UZu8cTZSGuHwWDNvXgkQSKSyUr1KJ9g5nRzZz+sWuGPBcQ==
X-Received: by 2002:a17:903:2a83:b0:229:1717:8812 with SMTP id d9443c01a7336-22c316d894dmr19110515ad.0.1744763005749;
        Tue, 15 Apr 2025 17:23:25 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22c33fe7289sm1417125ad.244.2025.04.15.17.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 17:23:25 -0700 (PDT)
Date: Tue, 15 Apr 2025 17:23:24 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Message-ID: <20250416002324.GB78596-mkhalfella@purestorage.com>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_172326_619372_54D3996B 
X-CRM114-Status: GOOD (  26.03  )
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

On 2025-03-24 13:07:58 +0100, Daniel Wagner wrote:
> The TP4129 mendates that the failover should be delayed by CQT.  Thus when
> nvme_decide_disposition returns FAILOVER do not immediately re-queue it on
> the namespace level instead queue it on the ctrl's request_list and
> moved later to the namespace's requeue_list.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  drivers/nvme/host/core.c      | 19 ++++++++++++++++
>  drivers/nvme/host/fc.c        |  4 ++++
>  drivers/nvme/host/multipath.c | 52 ++++++++++++++++++++++++++++++++++++++++---
>  drivers/nvme/host/nvme.h      | 15 +++++++++++++
>  drivers/nvme/host/rdma.c      |  2 ++
>  drivers/nvme/host/tcp.c       |  1 +
>  6 files changed, 90 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 135045528ea1c79eac0d6d47d5f7f05a7c98acc4..f3155c7735e75e06c4359c26db8931142c067e1d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -239,6 +239,7 @@ static void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl)
>  
>  	flush_work(&ctrl->reset_work);
>  	nvme_stop_ctrl(ctrl);
> +	nvme_flush_failover(ctrl);
>  	nvme_remove_namespaces(ctrl);
>  	ctrl->ops->delete_ctrl(ctrl);
>  	nvme_uninit_ctrl(ctrl);
> @@ -1310,6 +1311,19 @@ static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
>  	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
>  }
>  
> +void nvme_schedule_failover(struct nvme_ctrl *ctrl)
> +{
> +	unsigned long delay;
> +
> +	if (ctrl->cqt)
> +		delay = msecs_to_jiffies(ctrl->cqt);
> +	else
> +		delay = ctrl->kato * HZ;
> +
> +	queue_delayed_work(nvme_wq, &ctrl->failover_work, delay);
> +}
> +EXPORT_SYMBOL_GPL(nvme_schedule_failover);
> +
>  static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>  						 blk_status_t status)
>  {
> @@ -1336,6 +1350,8 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>  		dev_err(ctrl->device,
>  			"failed nvme_keep_alive_end_io error=%d\n",
>  				status);
> +
> +		nvme_schedule_failover(ctrl);
>  		return RQ_END_IO_NONE;
>  	}
>  
> @@ -4716,6 +4732,7 @@ EXPORT_SYMBOL_GPL(nvme_remove_io_tag_set);
>  
>  void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>  {
> +	nvme_schedule_failover(ctrl);
>  	nvme_mpath_stop(ctrl);
>  	nvme_auth_stop(ctrl);
>  	nvme_stop_failfast_work(ctrl);
> @@ -4842,6 +4859,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>  
>  	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
>  	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
> +	INIT_DELAYED_WORK(&ctrl->failover_work, nvme_failover_work);
> +	INIT_LIST_HEAD(&ctrl->failover_list);
>  	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
>  	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
>  	ctrl->ka_last_check_time = jiffies;
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index cdc1ba277a5c23ef1afd26e6911b082f3d12b215..bd897b29cd286008b781bbcb4230e08019da6b6b 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2553,6 +2553,8 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
>  {
>  	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
>  
> +	nvme_schedule_failover(&ctrl->ctrl);
> +
>  	/*
>  	 * if an error (io timeout, etc) while (re)connecting, the remote
>  	 * port requested terminating of the association (disconnect_ls)
> @@ -3378,6 +3380,8 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
>  	/* will block will waiting for io to terminate */
>  	nvme_fc_delete_association(ctrl);
>  
> +	nvme_schedule_failover(&ctrl->ctrl);
> +
>  	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
>  		dev_err(ctrl->ctrl.device,
>  			"NVME-FC{%d}: error_recovery: Couldn't change state "
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 2a7635565083046c575efe1793362ae10581defd..a14b055796b982df96609f53174a5d1334c1c0c4 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -86,9 +86,11 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
>  void nvme_failover_req(struct request *req)
>  {
>  	struct nvme_ns *ns = req->q->queuedata;
> +	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
>  	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
>  	unsigned long flags;
>  	struct bio *bio;
> +	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
>  
>  	nvme_mpath_clear_current_path(ns);
>  
> @@ -121,9 +123,53 @@ void nvme_failover_req(struct request *req)
>  	blk_steal_bios(&ns->head->requeue_list, req);
>  	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
>  
> -	nvme_req(req)->status = 0;
> -	nvme_end_req(req);
> -	kblockd_schedule_work(&ns->head->requeue_work);
> +	spin_lock_irqsave(&ctrl->lock, flags);
> +	list_add_tail(&req->queuelist, &ctrl->failover_list);
> +	spin_unlock_irqrestore(&ctrl->lock, flags);
> +

In case the delay in nvme_schedule_failover() is larget than request
timeout, is it possible for timeout callback to be called while a
request is sitting in failover_list?

Is there any guarantee to prevent this from happening? I understand from
the patch that we do not want this to happen, right?

