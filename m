Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C57C46467
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tCxa8/bzYSVbsxyvwXILYMcXnG1Vfo460M2v6tBE9D4=; b=so2iXJhkgamh/cv66SkWbpnkAN
	JijDacZTPtfce9dCoHsRM49Pg2tWEg6od2D38FW3ms+7qwPMez6O1YJ/L97HxLvOdjMctE0DJcoC2
	EQ9b+egulmf4td9ATfdH+TV1v0xRpT3QoHcDy2JdQRa8VM+QESDOXBySwMpSXTchnLr8Vs+QMptkn
	8dIVoNjZfNt+3lYGKONfHXrr7F90b7lt5RiD3ODX6UlhG6vRO7byGwk+yG/mmjTSmEyf+2yDfpTW7
	misghUbTBfqMQMMjEH3Bb1U1DR87/+zoqj1YTlCo9b8nOLmChBnlTWWs+TCZwPjhnbLY73ghcvUuB
	YSO43V2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCfFk-000via-O4; Tue, 03 Jan 2023 11:14:44 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCezk-000rNG-K2
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 10:58:14 +0000
Received: by mail-wm1-f54.google.com with SMTP id ay40so22390477wmb.2
        for <linux-nvme@lists.infradead.org>; Tue, 03 Jan 2023 02:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCxa8/bzYSVbsxyvwXILYMcXnG1Vfo460M2v6tBE9D4=;
        b=rtwTokoiasC/Imd2NgOzGJT9agSidT/rPzocFJTwcqs/asdG5g3GOLZMI8kcohFdnA
         DEaNz6/3U3F43PxKbI1Jvb7Hhcxv1nbZ8XNg+/0UqwHRpIuhsgIQBIvOMola8Z5E9ZKO
         MWubdaYp4EcbohQoMu6OpPfTj0e0hzSrXVCw7nBFEKl30cZcd+1X+jW0V89hAHaYRefA
         XSFDto5kPpr5V6tDnAcMyMMlxmEBzIKPoB4CXrFtFBlGTEhDDOS7m1fEl6iE0hoCUogt
         RL9Wtu5nkl9CsOaSdhEKxpAco27DeQxwsq9qLg7CwHVXblyd1CtBw2vjL2ghFaXf265U
         bIEQ==
X-Gm-Message-State: AFqh2kpqeaLQJgTnWeFH/6U17Jjhe+Tr7JRl4HqSWIB7mafYz8ggwsLU
	hvjMYDlA5MIb0Wr8D/FlYbA=
X-Google-Smtp-Source: AMrXdXuP8RPZZ/s8kgtjhcZ0413swT+AiW4Dp1q+Va6g/6KkQqp37AeQ7gkq5KFtcN3PJHVrGSUhJA==
X-Received: by 2002:a1c:5442:0:b0:3cf:7385:677f with SMTP id p2-20020a1c5442000000b003cf7385677fmr29902600wmi.35.1672743491202;
        Tue, 03 Jan 2023 02:58:11 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n41-20020a05600c3ba900b003d358beab9dsm46017751wms.47.2023.01.03.02.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 02:58:10 -0800 (PST)
Message-ID: <f7bbf0e6-9316-111b-585d-2b29ff95e96b@grimberg.me>
Date: Tue, 3 Jan 2023 12:58:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/4] nvmet: fix hang in nvmet_ns_disable()
Content-Language: en-US
To: Taehee Yoo <ap420073@gmail.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, axboe@fb.com, hch@lst.de, kch@nvidia.com
Cc: larrystevenwise@gmail.com, anthony.j.knapp@intel.com,
 pizhenwei@bytedance.com
References: <20230103100357.875854-1-ap420073@gmail.com>
 <20230103100357.875854-4-ap420073@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230103100357.875854-4-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_025812_798413_503CDD19 
X-CRM114-Status: GOOD (  24.77  )
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



On 1/3/23 12:03, Taehee Yoo wrote:
> nvme target namespace is enabled or disabled by nvmet_ns_enable() or
> nvmet_ns_disable().
> The subsys->lock is used to disallow to use namespace data while
> nvmet_ns_enable() or nvmet_ns_disable() are working.
> The ns->enabled boolean variable prevents using namespace data in wrong
> state such as uninitialized state.
> 
> nvmet_ns_disable() acquires ns->lock and set ns->enabled false.
> Then, it releases ns->lock for a while to wait ns->disable_done completion.
> At this point, nvmet_ns_enable() can be worked concurrently and it calls
> percpu_ref_init().
> So, ns->disable_done will never be completed.
> Therefore hang would occur at this point.
> 
>     CPU0                                     CPU1
>     nvmet_ns_disable();
>     mutex_lock(&subsys->lock);               nvmet_ns_enable();
>                                              mutex_lock(&subsys->lock);
>     ns->enabled = false;
>     mutex_unlock(&subsys->lock);
>                                              percpu_ref_init();
>     wait_for_completion(&ns->disable_done);  <-- infinite wait
> 
>     mutex_lock(&subsys->lock);
>     mutex_unlock(&subsys->lock);
> 
> INFO: task bash:926 blocked for more than 30 seconds.
>        Tainted: G        W          6.1.0+ #17
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:bash            state:D stack:27200 pid:926   ppid:911
> flags:0x00004000
> Call Trace:
>   <TASK>
>   __schedule+0xafc/0x2930
>   ? io_schedule_timeout+0x160/0x160
>   ? _raw_spin_unlock_irq+0x24/0x50
>   ? __wait_for_common+0x39b/0x5c0
>   ? usleep_range_state+0x190/0x190
>   schedule+0x130/0x230
>   schedule_timeout+0x18a/0x240
>   ? usleep_range_state+0x190/0x190
>   ? rcu_read_lock_sched_held+0x12/0x80
>   ? lock_downgrade+0x700/0x700
>   ? do_raw_spin_trylock+0xb5/0x180
>   ? lock_contended+0xdf0/0xdf0
>   ? _raw_spin_unlock_irq+0x24/0x50
>   ? trace_hardirqs_on+0x3c/0x190
>   __wait_for_common+0x1ca/0x5c0
>   ? usleep_range_state+0x190/0x190
>   ? bit_wait_io+0xf0/0xf0
>   ? _raw_spin_unlock_irqrestore+0x59/0x70
>   nvmet_ns_disable+0x288/0x490
>   ? nvmet_ns_enable+0x970/0x970
>   ? lockdep_hardirqs_on_prepare+0x410/0x410
>   ? rcu_read_lock_sched_held+0x12/0x80
>   ? configfs_write_iter+0x1df/0x480
>   ? nvmet_ns_revalidate_size_store+0x220/0x220
>   nvmet_ns_enable_store+0x85/0xe0
> [ ... ]
> 
> Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>   drivers/nvme/target/configfs.c | 14 +++++++-------
>   drivers/nvme/target/core.c     | 10 ++++++----
>   drivers/nvme/target/nvmet.h    |  8 +++++++-
>   3 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 907143870da5..d878c4231d65 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -348,7 +348,7 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
>   
>   	mutex_lock(&subsys->lock);
>   	ret = -EBUSY;
> -	if (ns->enabled)
> +	if (ns->state != NVMET_NS_DISABLED)
>   		goto out_unlock;
>   
>   	ret = -EINVAL;
> @@ -390,7 +390,7 @@ static ssize_t nvmet_ns_p2pmem_store(struct config_item *item,
>   	int error;
>   
>   	mutex_lock(&ns->subsys->lock);
> -	if (ns->enabled) {
> +	if (ns->state != NVMET_NS_DISABLED) {
>   		ret = -EBUSY;
>   		goto out_unlock;
>   	}
> @@ -427,7 +427,7 @@ static ssize_t nvmet_ns_device_uuid_store(struct config_item *item,
>   	int ret = 0;
>   
>   	mutex_lock(&subsys->lock);
> -	if (ns->enabled) {
> +	if (ns->state != NVMET_NS_DISABLED) {
>   		ret = -EBUSY;
>   		goto out_unlock;
>   	}
> @@ -458,7 +458,7 @@ static ssize_t nvmet_ns_device_nguid_store(struct config_item *item,
>   	int ret = 0;
>   
>   	mutex_lock(&subsys->lock);
> -	if (ns->enabled) {
> +	if (ns->state != NVMET_NS_DISABLED) {
>   		ret = -EBUSY;
>   		goto out_unlock;
>   	}
> @@ -523,7 +523,7 @@ CONFIGFS_ATTR(nvmet_ns_, ana_grpid);
>   
>   static ssize_t nvmet_ns_enable_show(struct config_item *item, char *page)
>   {
> -	return sprintf(page, "%d\n", to_nvmet_ns(item)->enabled);
> +	return sprintf(page, "%d\n", !!to_nvmet_ns(item)->state);
>   }
>   
>   static ssize_t nvmet_ns_enable_store(struct config_item *item,
> @@ -561,7 +561,7 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
>   		return -EINVAL;
>   
>   	mutex_lock(&ns->subsys->lock);
> -	if (ns->enabled) {
> +	if (ns->state != NVMET_NS_DISABLED) {
>   		pr_err("disable ns before setting buffered_io value.\n");
>   		mutex_unlock(&ns->subsys->lock);
>   		return -EINVAL;
> @@ -587,7 +587,7 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
>   		return -EINVAL;
>   
>   	mutex_lock(&ns->subsys->lock);
> -	if (!ns->enabled) {
> +	if (ns->state != NVMET_NS_ENABLED) {
>   		pr_err("enable ns before revalidate.\n");
>   		mutex_unlock(&ns->subsys->lock);
>   		return -EINVAL;
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index f66ed13d7c11..58a91fb9c2f7 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -563,7 +563,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>   		goto out_unlock;
>   	}
>   
> -	if (ns->enabled)
> +	if (ns->state != NVMET_NS_DISABLED)
>   		goto out_unlock;
>   
>   	ret = -EMFILE;
> @@ -598,7 +598,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>   	subsys->nr_namespaces++;
>   
>   	nvmet_ns_changed(subsys, ns->nsid);
> -	ns->enabled = true;
> +	ns->state = NVMET_NS_ENABLED;
>   	ret = 0;
>   out_unlock:
>   	mutex_unlock(&subsys->lock);
> @@ -621,10 +621,10 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
>   	struct nvmet_ctrl *ctrl;
>   
>   	mutex_lock(&subsys->lock);
> -	if (!ns->enabled)
> +	if (ns->state != NVMET_NS_ENABLED)
>   		goto out_unlock;
>   
> -	ns->enabled = false;
> +	ns->state = NVMET_NS_DISABLING;
>   	xa_erase(&ns->subsys->namespaces, ns->nsid);
>   	if (ns->nsid == subsys->max_nsid)
>   		subsys->max_nsid = nvmet_max_nsid(subsys);
> @@ -652,6 +652,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
>   	subsys->nr_namespaces--;
>   	nvmet_ns_changed(subsys, ns->nsid);
>   	nvmet_ns_dev_disable(ns);
> +	ns->state = NVMET_NS_DISABLED;
>   out_unlock:
>   	mutex_unlock(&subsys->lock);
>   }
> @@ -689,6 +690,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
>   	uuid_gen(&ns->uuid);
>   	ns->buffered_io = false;
>   	ns->csi = NVME_CSI_NVM;
> +	ns->state = NVMET_NS_DISABLED;
>   
>   	return ns;
>   }
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 89bedfcd974c..e609787577c6 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -56,6 +56,12 @@
>   #define IPO_IATTR_CONNECT_SQE(x)	\
>   	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
>   
> +enum nvmet_ns_state {
> +	NVMET_NS_ENABLED,
> +	NVMET_NS_DISABLING,
> +	NVMET_NS_DISABLED
> +};
> +
>   struct nvmet_ns {
>   	struct percpu_ref	ref;
>   	struct block_device	*bdev;
> @@ -69,7 +75,7 @@ struct nvmet_ns {
>   	u32			anagrpid;
>   
>   	bool			buffered_io;
> -	bool			enabled;
> +	enum nvmet_ns_state	state;
>   	struct nvmet_subsys	*subsys;
>   	const char		*device_path;
>   

This looks reasonable to me...
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

