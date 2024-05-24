Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB64C25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 24 May 2024 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lx1TaTlMdf+ZCYVX/OpQEsqe43TuyuiYbq/WZTrfxXM=; b=U/Um901bi+udVzn6hh+cE9YOtC
	ZcLVBnoveu5kurLF8WZRIe9nsyruMqYhByUguAd7zmustfg0BkvWxJPv0Y52UhmUhKrNknSbaBths
	uyNywj3wcetptKzCZQcZ2zay5rN9MsmdQxU62/dPJLNgiFOiekYaZih6/RamHVG+yKT4bE3DH+ot8
	MvIWAFLNnc7nMYLzSYPrqZLM5BdAWzs2l8aRcEOzO+xe6zHyO5Wo325Q94lUQt1TyM6I64ZUj+tbm
	EILJTjCKllSMngRwK1d4j/LbilY/YR2SOaQZemH+ZlWIUYEYzmOrsxwNzEwvjyH2bACRzrwz+ZpV8
	SJa7Ckdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAWqV-00000009Er7-04Tz;
	Fri, 24 May 2024 15:28:39 +0000
Received: from mail-lf1-f42.google.com ([209.85.167.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAWqS-00000009Eqc-073F
	for linux-nvme@lists.infradead.org;
	Fri, 24 May 2024 15:28:37 +0000
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52397dd31a0so276391e87.0
        for <linux-nvme@lists.infradead.org>; Fri, 24 May 2024 08:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716564513; x=1717169313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lx1TaTlMdf+ZCYVX/OpQEsqe43TuyuiYbq/WZTrfxXM=;
        b=ZHWiI21eGfDCFl+itBeci9uAaAYjL/tsqczry2vTZIrp+N8lU7yQncHMXbDT5+nF9A
         73KHCe5qJk7xvqS67axoROjuzcGjo0GCdQJeha91GBS4wPEbO5c44ZEUcZZWugpt3sO/
         Yj/Yit231GD8o1Vesno/XRHq0vCduj5+BaVr2P9Lij6Ey9ForjNuaA3ST1auu89GP+rv
         d0vfMR2TKKfO+SppshS99ibIZm44vewkiHHurBnwACH3Xts72AwRrupe1kQYMIbS4bDk
         cJbwyu5JzTbz5tiP72vlgnOhj8JC0J1nwdS39k/O1bgHU4jzoTsLhjcwXEgo2JGHvjZ1
         Aphg==
X-Forwarded-Encrypted: i=1; AJvYcCXEVpbAkrVXomk5Q/ts/Ys0z7rp4ql74VFXNJycW5hIf0RUDFciifnNEsCjNk5sZvt8BRM5d2lyc+g4MFVIvhWCieSqkUT37FelM+J+ylc=
X-Gm-Message-State: AOJu0YyUJUdjZLePX1m161Xau2o1l63iEENDT5yIlo34shSYgTUTN3Qr
	JB1dydYRiCv1QhZqXoZJdZ+bb2ZbUKeMocDthj/t/ZWYjmlnGJ3v
X-Google-Smtp-Source: AGHT+IGl9xJQ6r01H9jO05PO4qy5WY0xC3jVq5G5hMvOxJLPBgyR8EphKm55VE96XQk6MdTCBlA4Jw==
X-Received: by 2002:a05:6512:68f:b0:51f:6b63:75a6 with SMTP id 2adb3069b0e04-529619867acmr1691888e87.0.1716564512816;
        Fri, 24 May 2024 08:28:32 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fad638sm56270845e9.29.2024.05.24.08.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 08:28:32 -0700 (PDT)
Message-ID: <d5045b2f-5edb-45bc-924a-3363d6feec58@grimberg.me>
Date: Fri, 24 May 2024 18:28:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme: use srcu for iterating namespace list
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 shinichiro.kawasaki@wdc.com, hch@lst.de
Cc: axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
References: <20240523172050.4080218-1-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240523172050.4080218-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_082836_110155_B2B99CD6 
X-CRM114-Status: GOOD (  27.13  )
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



On 23/05/2024 20:20, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>
> The nvme pci driver synchronizes with all the namespace queues during a
> reset to ensure that there's no pending timeout work.
>
> Meanwhile the timeout work potentially iterates those same namespaces to
> freeze their queues.
>
> Each of those namespace iterations use the same read lock. If a write
> lock should somehow get between the synchronize and freeze steps, then
> forward progress is deadlocked.
>
> We had been relying on the nvme controller state machine to ensure the
> reset work wouldn't conflict with timeout work. That guarantee may be a
> bit fragile to rely on, so iterate the namespace lists without taking a
> lock to fix potential circular locks, as reported by lockdep.
>
> Link: https://lore.kernel.org/all/20220930001943.zdbvolc3gkekfmcv@shindev/
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v2:
>    Improved changelog
>
>   drivers/nvme/host/core.c      | 97 +++++++++++++++++++++--------------
>   drivers/nvme/host/ioctl.c     | 12 ++---
>   drivers/nvme/host/multipath.c | 21 ++++----
>   drivers/nvme/host/nvme.h      |  3 +-
>   4 files changed, 78 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7706df2373494..b7cd46f3cef69 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3684,9 +3684,10 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>   struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   {
>   	struct nvme_ns *ns, *ret = NULL;
> +	int srcu_idx;
>   
> -	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +	srcu_idx = srcu_read_lock(&ctrl->srcu);
> +	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
>   		if (ns->head->ns_id == nsid) {
>   			if (!nvme_get_ns(ns))
>   				continue;
> @@ -3696,7 +3697,7 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   		if (ns->head->ns_id > nsid)
>   			break;
>   	}
> -	up_read(&ctrl->namespaces_rwsem);
> +	srcu_read_unlock(&ctrl->srcu, srcu_idx);
>   	return ret;
>   }
>   EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
> @@ -3710,7 +3711,7 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
>   
>   	list_for_each_entry_reverse(tmp, &ns->ctrl->namespaces, list) {
>   		if (tmp->head->ns_id < ns->head->ns_id) {
> -			list_add(&ns->list, &tmp->list);
> +			list_add_rcu(&ns->list, &tmp->list);
>   			return;
>   		}
>   	}
> @@ -3776,17 +3777,18 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   	if (nvme_update_ns_info(ns, info))
>   		goto out_unlink_ns;
>   
> -	down_write(&ctrl->namespaces_rwsem);
> +	mutex_lock(&ctrl->namespaces_lock);
>   	/*
>   	 * Ensure that no namespaces are added to the ctrl list after the queues
>   	 * are frozen, thereby avoiding a deadlock between scan and reset.
>   	 */
>   	if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
> -		up_write(&ctrl->namespaces_rwsem);
> +		mutex_unlock(&ctrl->namespaces_lock);
>   		goto out_unlink_ns;
>   	}
>   	nvme_ns_add_to_ctrl_list(ns);
> -	up_write(&ctrl->namespaces_rwsem);
> +	mutex_unlock(&ctrl->namespaces_lock);
> +	synchronize_srcu(&ctrl->srcu);
>   	nvme_get_ctrl(ctrl);
>   
>   	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups))
> @@ -3809,9 +3811,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   
>    out_cleanup_ns_from_list:
>   	nvme_put_ctrl(ctrl);
> -	down_write(&ctrl->namespaces_rwsem);
> -	list_del_init(&ns->list);
> -	up_write(&ctrl->namespaces_rwsem);
> +	mutex_lock(&ctrl->namespaces_lock);
> +	list_del_rcu(&ns->list);
> +	mutex_unlock(&ctrl->namespaces_lock);
> +	synchronize_srcu(&ctrl->srcu);
>    out_unlink_ns:
>   	mutex_lock(&ctrl->subsys->lock);
>   	list_del_rcu(&ns->siblings);
> @@ -3861,9 +3864,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>   	del_gendisk(ns->disk);
>   
> -	down_write(&ns->ctrl->namespaces_rwsem);
> -	list_del_init(&ns->list);
> -	up_write(&ns->ctrl->namespaces_rwsem);
> +	mutex_lock(&ns->ctrl->namespaces_lock);
> +	list_del_rcu(&ns->list);
> +	mutex_unlock(&ns->ctrl->namespaces_lock);
> +	synchronize_srcu(&ns->ctrl->srcu);
>   
>   	if (last_path)
>   		nvme_mpath_shutdown_disk(ns->head);
> @@ -3953,16 +3957,17 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   	struct nvme_ns *ns, *next;
>   	LIST_HEAD(rm_list);
>   
> -	down_write(&ctrl->namespaces_rwsem);
> +	mutex_lock(&ctrl->namespaces_lock);
>   	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
>   		if (ns->head->ns_id > nsid)
> -			list_move_tail(&ns->list, &rm_list);
> +			list_splice_init_rcu(&ns->list, &rm_list,
> +					     synchronize_rcu);
>   	}
> -	up_write(&ctrl->namespaces_rwsem);
> +	mutex_unlock(&ctrl->namespaces_lock);
> +	synchronize_srcu(&ctrl->srcu);
>   
>   	list_for_each_entry_safe(ns, next, &rm_list, list)
>   		nvme_ns_remove(ns);
> -
>   }
>   
>   static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
> @@ -4132,9 +4137,10 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>   	/* this is a no-op when called from the controller reset handler */
>   	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
>   
> -	down_write(&ctrl->namespaces_rwsem);
> -	list_splice_init(&ctrl->namespaces, &ns_list);
> -	up_write(&ctrl->namespaces_rwsem);
> +	mutex_lock(&ctrl->namespaces_lock);
> +	list_splice_init_rcu(&ctrl->namespaces, &ns_list, synchronize_rcu);
> +	mutex_unlock(&ctrl->namespaces_lock);
> +	synchronize_srcu(&ctrl->srcu);
>   
>   	list_for_each_entry_safe(ns, next, &ns_list, list)
>   		nvme_ns_remove(ns);
> @@ -4582,6 +4588,7 @@ static void nvme_free_ctrl(struct device *dev)
>   	key_put(ctrl->tls_key);
>   	nvme_free_cels(ctrl);
>   	nvme_mpath_uninit(ctrl);
> +	cleanup_srcu_struct(&ctrl->srcu);
>   	nvme_auth_stop(ctrl);
>   	nvme_auth_free(ctrl);
>   	__free_page(ctrl->discard_page);
> @@ -4614,10 +4621,15 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	ctrl->passthru_err_log_enabled = false;
>   	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
>   	spin_lock_init(&ctrl->lock);
> +	mutex_init(&ctrl->namespaces_lock);
> +
> +	ret = init_srcu_struct(&ctrl->srcu);
> +	if (ret)
> +		return ret;
> +
>   	mutex_init(&ctrl->scan_lock);
>   	INIT_LIST_HEAD(&ctrl->namespaces);
>   	xa_init(&ctrl->cels);
> -	init_rwsem(&ctrl->namespaces_rwsem);
>   	ctrl->dev = dev;
>   	ctrl->ops = ops;
>   	ctrl->quirks = quirks;
> @@ -4697,6 +4709,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   out:
>   	if (ctrl->discard_page)
>   		__free_page(ctrl->discard_page);
> +	cleanup_srcu_struct(&ctrl->srcu);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(nvme_init_ctrl);
> @@ -4705,22 +4718,24 @@ EXPORT_SYMBOL_GPL(nvme_init_ctrl);
>   void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_ns *ns;
> +	int srcu_idx;
>   
> -	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	srcu_idx = srcu_read_lock(&ctrl->srcu);
> +	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
>   		blk_mark_disk_dead(ns->disk);
> -	up_read(&ctrl->namespaces_rwsem);
> +	srcu_read_unlock(&ctrl->srcu, srcu_idx);
>   }
>   EXPORT_SYMBOL_GPL(nvme_mark_namespaces_dead);
>   
>   void nvme_unfreeze(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_ns *ns;
> +	int srcu_idx;
>   
> -	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	srcu_idx = srcu_read_lock(&ctrl->srcu);
> +	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
>   		blk_mq_unfreeze_queue(ns->queue);
> -	up_read(&ctrl->namespaces_rwsem);
> +	srcu_read_unlock(&ctrl->srcu, srcu_idx);
>   	clear_bit(NVME_CTRL_FROZEN, &ctrl->flags);
>   }
>   EXPORT_SYMBOL_GPL(nvme_unfreeze);
> @@ -4728,14 +4743,15 @@ EXPORT_SYMBOL_GPL(nvme_unfreeze);
>   int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
>   {
>   	struct nvme_ns *ns;
> +	int srcu_idx;
>   
> -	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +	srcu_idx = srcu_read_lock(&ctrl->srcu);
> +	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
>   		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
>   		if (timeout <= 0)
>   			break;
>   	}
> -	up_read(&ctrl->namespaces_rwsem);
> +	srcu_read_unlock(&ctrl->srcu, srcu_idx);
>   	return timeout;
>   }
>   EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
> @@ -4743,23 +4759,25 @@ EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
>   void nvme_wait_freeze(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_ns *ns;
> +	int srcu_idx;
>   
> -	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	srcu_idx = srcu_read_lock(&ctrl->srcu);
> +	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
>   		blk_mq_freeze_queue_wait(ns->queue);
> -	up_read(&ctrl->namespaces_rwsem);
> +	srcu_read_unlock(&ctrl->srcu, srcu_idx);
>   }
>   EXPORT_SYMBOL_GPL(nvme_wait_freeze);
>   
>   void nvme_start_freeze(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_ns *ns;
> +	int srcu_idx;
>   
>   	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
> -	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	srcu_idx = srcu_read_lock(&ctrl->srcu);
> +	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
>   		blk_freeze_queue_start(ns->queue);
> -	up_read(&ctrl->namespaces_rwsem);
> +	srcu_read_unlock(&ctrl->srcu, srcu_idx);
>   }
>   EXPORT_SYMBOL_GPL(nvme_start_freeze);
>   
> @@ -4802,11 +4820,12 @@ EXPORT_SYMBOL_GPL(nvme_unquiesce_admin_queue);
>   void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_ns *ns;
> +	int srcu_idx;
>   
> -	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	srcu_idx = srcu_read_lock(&ctrl->srcu);
> +	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
>   		blk_sync_queue(ns->queue);
> -	up_read(&ctrl->namespaces_rwsem);
> +	srcu_read_unlock(&ctrl->srcu, srcu_idx);
>   }
>   EXPORT_SYMBOL_GPL(nvme_sync_io_queues);
>   
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 499a8bb7cac7d..0f05058692b55 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -789,16 +789,16 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
>   		bool open_for_write)
>   {
>   	struct nvme_ns *ns;
> -	int ret;
> +	int ret, srcu_idx;
>   
> -	down_read(&ctrl->namespaces_rwsem);
> +	srcu_idx = srcu_read_lock(&ctrl->srcu);
>   	if (list_empty(&ctrl->namespaces)) {
>   		ret = -ENOTTY;
>   		goto out_unlock;
>   	}
>   
> -	ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
> -	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
> +	ns = list_first_or_null_rcu(&ctrl->namespaces, struct nvme_ns, list);
> +	if (!ns) {

Hmm, this seems like a functional change. the error suggest that the 
list must
contain only a single member to execute. Not sure why though. But this looks
like the change disagrees with the assumption.

