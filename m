Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656F0C25B76
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 08:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t3sJQTzTpwDLBHrZLaU2sxYImFTL4QtEkT39EGZ4krc=; b=OtAXV7iIt824kG04HJKq2kVgU6
	LnZssnIgWssA98p47dO6fSAKLotK646j6MUS6pVl4enpEL6xwlx+wXkNtuOJn4o9xf46tV5cEQtdK
	JxXUgugfC49o98cfV5LbB0DVWTwiH6q/BHvLzOSQNA7VQ9XLuYtAwYKjNJNu7l3ntWROqhszg7r8M
	D2nWG+Sah1PY6+0YRGtDahUjoLt77nLzTxEFOPYqLnh9dFdVWbGZgud0kCTpzS5ZEqX5zqsLifCRR
	LWjNAywcrcKT3Br3lOUSboKaWU/3PRTaCNYfzjkFIU6r3JRE2n1dlJobYaVgcaVToq6fV9HXE2ild
	XM4wrOJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE3CI-0000000G3yk-3Bum;
	Mon, 03 Jun 2024 08:37:42 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE3CD-0000000G3xm-168Z
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 08:37:41 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 155241FE55;
	Mon,  3 Jun 2024 08:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717403854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3sJQTzTpwDLBHrZLaU2sxYImFTL4QtEkT39EGZ4krc=;
	b=lcybNdW6eLAb9fR4khQjjMlzWVRLean7ZwNJhfXiji+o/qAMczaSB4ivc74mkiVB+1G8GZ
	ZSiRJPLXRSeN48TNjNMqJF5Ryb7N7BXH5GRsL8AEuNT7k6l85KB4glcY0RkEqvSqxUXLl6
	DhbS5wxx6uJ+PWicj215me8yrQQrIK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717403854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3sJQTzTpwDLBHrZLaU2sxYImFTL4QtEkT39EGZ4krc=;
	b=1EEc5Vbz4i9pQJIHyYdxetOKGFe+yzuqmeWLwl0weBCblobhxBa9kJbYUCBrTrfXmq9I9b
	mAcRGST/KieSVIBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717403854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3sJQTzTpwDLBHrZLaU2sxYImFTL4QtEkT39EGZ4krc=;
	b=lcybNdW6eLAb9fR4khQjjMlzWVRLean7ZwNJhfXiji+o/qAMczaSB4ivc74mkiVB+1G8GZ
	ZSiRJPLXRSeN48TNjNMqJF5Ryb7N7BXH5GRsL8AEuNT7k6l85KB4glcY0RkEqvSqxUXLl6
	DhbS5wxx6uJ+PWicj215me8yrQQrIK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717403854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3sJQTzTpwDLBHrZLaU2sxYImFTL4QtEkT39EGZ4krc=;
	b=1EEc5Vbz4i9pQJIHyYdxetOKGFe+yzuqmeWLwl0weBCblobhxBa9kJbYUCBrTrfXmq9I9b
	mAcRGST/KieSVIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1E0613A93;
	Mon,  3 Jun 2024 08:37:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +jT/Nc2AXWbYbwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Jun 2024 08:37:33 +0000
Message-ID: <8058afc6-8272-42fa-a024-e477a29148e1@suse.de>
Date: Mon, 3 Jun 2024 10:37:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests nvme 041,042 leak memory
To: Maurizio Lombardi <m.lombardi85@mail.ru>,
 Maurizio Lombardi <mlombard@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Yi Zhang <yi.zhang@redhat.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
 <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
 <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com>
 <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me>
 <ZldW7nNrqHCTYTEF@kbusch-mbp.dhcp.thefacebook.com>
 <93883147-490d-4065-a741-3e49288ea3af@grimberg.me>
 <CAFL455=ixC0S8aU+AouQFtDFN0bFdNgSXH0d9a2-VXegj8dPuQ@mail.gmail.com>
 <Zlipe2FVAIRmas1e@kbusch-mbp.dhcp.thefacebook.com>
 <CAFL455kq_prujkCbNUwJzpqhL1B_P_Yu+b83kBSc0FQRAhQs8w@mail.gmail.com>
 <CAFL455ndGuGRCv7X6S6qtiEi6KhBs_sxgeyfzoLCqu6i8TyNuQ@mail.gmail.com>
 <ZlngkgSTK6IPcVc9@kalibr>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZlngkgSTK6IPcVc9@kalibr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[mail.ru,redhat.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[mail.ru];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_013738_025772_C46EDDBB 
X-CRM114-Status: GOOD (  22.09  )
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

On 5/31/24 16:37, Maurizio Lombardi wrote:
> V Fri, May 31, 2024 at 01:55:03PM +0200, Maurizio Lombardi napsal(a):
>> Maybe a better idea:
>>
>> move device_initialize() to the very beginning of nvme_init_ctrl()
>> initialize ctrl->instance to a negative value, so we can check in the
>> .release() method if we have to call ida_free() or not.
>>
> 
> This is how it would look like, I did some base testing with TCP
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 371e14f0a203..f809a4fc23f9 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -886,7 +886,7 @@ int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_wait);
> 
> -static void nvme_ctrl_auth_work(struct work_struct *work)
> +void nvme_ctrl_auth_work(struct work_struct *work)
>   {
>   	struct nvme_ctrl *ctrl =
>   		container_of(work, struct nvme_ctrl, dhchap_auth_work);
> @@ -934,14 +934,13 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
>   				 "qid %d: authentication failed\n", q);
>   	}
>   }
> +EXPORT_SYMBOL_GPL(nvme_ctrl_auth_work);
> 
>   int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_dhchap_queue_context *chap;
>   	int i, ret;
> 
> -	mutex_init(&ctrl->dhchap_auth_mutex);
> -	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
>   	if (!ctrl->opts)
>   		return 0;
>   	ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 954f850f113a..e775c4df9af5 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4572,14 +4572,16 @@ static void nvme_free_ctrl(struct device *dev)
>   		container_of(dev, struct nvme_ctrl, ctrl_device);
>   	struct nvme_subsystem *subsys = ctrl->subsys;
> 
> -	if (!subsys || ctrl->instance != subsys->instance)
> +	if (ctrl->instance >= 0 &&
> +			(!subsys || ctrl->instance != subsys->instance))
>   		ida_free(&nvme_instance_ida, ctrl->instance);
>   	key_put(ctrl->tls_key);
>   	nvme_free_cels(ctrl);
>   	nvme_mpath_uninit(ctrl);
>   	nvme_auth_stop(ctrl);
>   	nvme_auth_free(ctrl);
> -	__free_page(ctrl->discard_page);
> +	if (ctrl->discard_page)
> +		__free_page(ctrl->discard_page);
>   	free_opal_dev(ctrl->opal_dev);
> 
>   	if (subsys) {
> @@ -4610,6 +4612,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
>   	spin_lock_init(&ctrl->lock);
>   	mutex_init(&ctrl->scan_lock);
> +	mutex_init(&ctrl->dhchap_auth_mutex);
>   	INIT_LIST_HEAD(&ctrl->namespaces);
>   	xa_init(&ctrl->cels);
>   	init_rwsem(&ctrl->namespaces_rwsem);
> @@ -4621,6 +4624,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
>   	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
>   	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
> +	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
> +
>   	init_waitqueue_head(&ctrl->state_wq);
> 
>   	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
> @@ -4631,16 +4636,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> 
>   	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
>   			PAGE_SIZE);
> -	ctrl->discard_page = alloc_page(GFP_KERNEL);
> -	if (!ctrl->discard_page) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> 
> -	ret = ida_alloc(&nvme_instance_ida, GFP_KERNEL);
> -	if (ret < 0)
> -		goto out;
> -	ctrl->instance = ret;
> +	ctrl->instance = -1;
> 
>   	device_initialize(&ctrl->ctrl_device);
>   	ctrl->device = &ctrl->ctrl_device;
> @@ -4654,16 +4651,28 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   		ctrl->device->groups = nvme_dev_attr_groups;
>   	ctrl->device->release = nvme_free_ctrl;
>   	dev_set_drvdata(ctrl->device, ctrl);
> +
> +	ret = ida_alloc(&nvme_instance_ida, GFP_KERNEL);
> +	if (ret < 0)
> +		goto out;
> +
> +	ctrl->instance = ret;
>   	ret = dev_set_name(ctrl->device, "nvme%d", ctrl->instance);
>   	if (ret)
> -		goto out_release_instance;
> +		goto out;
> +
> +	ctrl->discard_page = alloc_page(GFP_KERNEL);
> +	if (!ctrl->discard_page) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> 
>   	nvme_get_ctrl(ctrl);
>   	cdev_init(&ctrl->cdev, &nvme_dev_fops);
>   	ctrl->cdev.owner = ops->module;
>   	ret = cdev_device_add(&ctrl->cdev, ctrl->device);
>   	if (ret)
> -		goto out_free_name;
> +		goto out_put_ctrl;
> 
>   	/*
>   	 * Initialize latency tolerance controls.  The sysfs files won't
> @@ -4684,14 +4693,9 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	nvme_fault_inject_fini(&ctrl->fault_inject);
>   	dev_pm_qos_hide_latency_tolerance(ctrl->device);
>   	cdev_device_del(&ctrl->cdev, ctrl->device);
> -out_free_name:
> +out_put_ctrl:
>   	nvme_put_ctrl(ctrl);
> -	kfree_const(ctrl->device->kobj.name);
> -out_release_instance:
> -	ida_free(&nvme_instance_ida, ctrl->instance);
>   out:
> -	if (ctrl->discard_page)
> -		__free_page(ctrl->discard_page);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(nvme_init_ctrl);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index cacc56f4bbf4..b0e378e6ca63 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -1124,6 +1124,7 @@ static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
>   #ifdef CONFIG_NVME_HOST_AUTH
>   int __init nvme_init_auth(void);
>   void __exit nvme_exit_auth(void);
> +void nvme_ctrl_auth_work(struct work_struct *work);
>   int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
>   void nvme_auth_stop(struct nvme_ctrl *ctrl);
>   int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 51a62b0c645a..bc749bebe134 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2302,7 +2302,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>   	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
>   				0 /* no quirks, we're perfect! */);
>   	if (ret)
> -		goto out_kfree_queues;
> +		goto out_put_ctrl;
> 
>   	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
>   	WARN_ON_ONCE(!changed);
> @@ -2322,12 +2322,11 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
> 
>   out_uninit_ctrl:
>   	nvme_uninit_ctrl(&ctrl->ctrl);
> +out_put_ctrl:
>   	nvme_put_ctrl(&ctrl->ctrl);
>   	if (ret > 0)
>   		ret = -EIO;
>   	return ERR_PTR(ret);
> -out_kfree_queues:
> -	kfree(ctrl->queues);
>   out_free_ctrl:
>   	kfree(ctrl);
>   	return ERR_PTR(ret);
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8b5e4327fe83..9787a4fdbb00 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2759,7 +2759,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
> 
>   	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
>   	if (ret)
> -		goto out_kfree_queues;
> +		goto out_put_ctrl;
> 
>   	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
>   		WARN_ON_ONCE(1);
> @@ -2782,12 +2782,11 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
> 
>   out_uninit_ctrl:
>   	nvme_uninit_ctrl(&ctrl->ctrl);
> +out_put_ctrl:
>   	nvme_put_ctrl(&ctrl->ctrl);
>   	if (ret > 0)
>   		ret = -EIO;
>   	return ERR_PTR(ret);
> -out_kfree_queues:
> -	kfree(ctrl->queues);
>   out_free_ctrl:
>   	kfree(ctrl);
>   	return ERR_PTR(ret);
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index e589915ddef8..6d1359915b6c 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -550,10 +550,8 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
> 
>   	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_loop_ctrl_ops,
>   				0 /* no quirks, we're perfect! */);
> -	if (ret) {
> -		kfree(ctrl);
> +	if (ret)
>   		goto out;
> -	}
> 
>   	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
>   		WARN_ON_ONCE(1);
> @@ -611,8 +609,8 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
>   	kfree(ctrl->queues);
>   out_uninit_ctrl:
>   	nvme_uninit_ctrl(&ctrl->ctrl);
> -	nvme_put_ctrl(&ctrl->ctrl);
>   out:
> +	nvme_put_ctrl(&ctrl->ctrl);
>   	if (ret > 0)
>   		ret = -EIO;
>   	return ERR_PTR(ret);
> --
> 2.43.0
> 
Hmm. Don't really like it.
We took great pains of moving then entire DH-CHAP code into its own
file, and this patch reverts it and is causing the DH-CHAP code to be
littered all over the place.

Cheers,

Hannes


