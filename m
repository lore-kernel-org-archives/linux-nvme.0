Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAF2D3C935
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 23:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cLIvzD5jl18UzojFUMsR/ehnrcpR0TnkE/bpIXF4kJ4=; b=Sq2u7sdfI5EnfoEsI8VD4laxZr
	ZV8Up0nLSzksD8csc1GwaVoNIy0Yb7lqzA6tBM6/8SGFJZja7pl6GWkyT1EivLzddq5wOYIHs8y7l
	o0I9nXu6kMtuJJY6+aLzfNqsAloc0rR+jo+u0TTExJcWNAa6sSs3dClBY52ntLWOeRYRYzKf4BWEG
	lBO9kVl/wEmx7rHk/WgmdjuRDRPf+Fq7kS5Dm7vsEd4CQtq7fbAxX9syfDnf9kl2hChsOkmUW6kom
	IIfnltBYQgKv69vT044/UlSlUTBAKV+xdnXQFi1Es1Vn3Nss5tsGYJV1obwW/i2OOSEsLC/ojAm/Z
	Q9si01yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2exM-00000005atN-0Z0V;
	Sun, 20 Oct 2024 23:03:28 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2exG-00000005asp-3vwS
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 23:03:26 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d58377339so4317364f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 16:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729465400; x=1730070200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLIvzD5jl18UzojFUMsR/ehnrcpR0TnkE/bpIXF4kJ4=;
        b=RG0oaJ9DJbjZtzhasG1yk9h6feMyv1HRXCLF7i0ACCcbHqzTFkNoPGaCA0pGqN7Tgg
         vUaUh2JI0o9m5EKnOpL7pp2npwrGgY2LQjJLK/hPG4bZ2+3MythdTe0G/1r331lduT8C
         1g6mW4B00fs4R4+FUgmMrDFSawqI7+fImkRKXha1W858JbUGGfcywv5giWWsUsDCGAcD
         R4dqPPWMyCxHXWQfemDXkdqP/LPfk5nOVqh/RKILrJFUkQvgU3/aZQgGWwaqj5WEmayp
         fP0GT/niGiFzPFGcUX/r4ydFLIbCzuAV2ZZ+0dsZUte4MDPQVnrxNNdyL91n/JdtG8ih
         ZxtA==
X-Gm-Message-State: AOJu0YwhyuujM5eyWao+V+Dl/U2MqWc3+shE5CkIJ73fqQXp1M2Wvv5K
	9fL/5iq3MxssKJOD8iwtpyhP9SooWVJQNH45ZW8d+HiUFxG9iuKq
X-Google-Smtp-Source: AGHT+IHrI83ObdnnyHm1CwucYZ4YW89kx140DZxqTMfeQth5VAINWU4WZLYVYb/JlDOzZT0j5cR7jw==
X-Received: by 2002:a05:6000:90:b0:37d:5296:4b37 with SMTP id ffacd0b85a97d-37eab2e2fbbmr8559348f8f.24.1729465399952;
        Sun, 20 Oct 2024 16:03:19 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b93ea6sm2773294f8f.84.2024.10.20.16.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 16:03:18 -0700 (PDT)
Message-ID: <d10ae711-330f-4110-8cbd-74f51562be31@grimberg.me>
Date: Mon, 21 Oct 2024 02:03:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 2/2] nvmet: support reservation feature
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com,
 shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com
Cc: linux-nvme@lists.infradead.org
References: <20241017044809.122021-1-kanie@linux.alibaba.com>
 <20241017044809.122021-3-kanie@linux.alibaba.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241017044809.122021-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_160323_202711_2BA18B0E 
X-CRM114-Status: GOOD (  31.53  )
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




On 17/10/2024 7:48, Guixin Liu wrote:
> This patch implements the reservation feature, including:
>    1. reservation register(register, unregister and replace).
>    2. reservation acquire(acquire, preempt, preempt and abort).
>    3. reservation release(release and clear).
>    4. reservation report.
>    5. set feature and get feature of reservation notify mask.
>    6. get log page of reservation event.
>
> Not supported:
>    1. persistent reservation through power loss.
>
> Test cases:
>    Use nvme-cli and fio to test all implemented sub features:
>    1. use nvme resv-register to register host a registrant or
>       unregister or replace a new key.
>    2. use nvme resv-acquire to set host to the holder, and use fio
>       to send read and write io in all reservation type. And also
>       test preempt and "preempt and abort".
>    3. use nvme resv-report to show all registrants and reservation
>       status.
>    4. use nvme resv-release to release all registrants.
>    5. use nvme get-log to get events generated by the preceding
>       operations.
>
> In addition, make reservation configurable, one can set ns to
> support reservation before enable ns. The default of resv_enable
> is false.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/target/Makefile      |    2 +-
>   drivers/nvme/target/admin-cmd.c   |   24 +-
>   drivers/nvme/target/configfs.c    |   27 +
>   drivers/nvme/target/core.c        |   58 +-
>   drivers/nvme/target/fabrics-cmd.c |    4 +-
>   drivers/nvme/target/nvmet.h       |   55 +-
>   drivers/nvme/target/pr.c          | 1172 +++++++++++++++++++++++++++++
>   7 files changed, 1330 insertions(+), 12 deletions(-)
>   create mode 100644 drivers/nvme/target/pr.c
>
> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
> index c402c44350b2..f2b025bbe10c 100644
> --- a/drivers/nvme/target/Makefile
> +++ b/drivers/nvme/target/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
>   obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
>   
>   nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
> -			discovery.o io-cmd-file.o io-cmd-bdev.o
> +			discovery.o io-cmd-file.o io-cmd-bdev.o pr.o
>   nvmet-$(CONFIG_NVME_TARGET_DEBUGFS)	+= debugfs.o
>   nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
>   nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 081f0473cd9e..19428745c795 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -176,6 +176,10 @@ static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
>   	log->iocs[nvme_cmd_read] =
>   	log->iocs[nvme_cmd_flush] =
>   	log->iocs[nvme_cmd_dsm]	=
> +	log->iocs[nvme_cmd_resv_acquire] =
> +	log->iocs[nvme_cmd_resv_register] =
> +	log->iocs[nvme_cmd_resv_release] =
> +	log->iocs[nvme_cmd_resv_report] =
>   		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
>   	log->iocs[nvme_cmd_write] =
>   	log->iocs[nvme_cmd_write_zeroes] =
> @@ -340,6 +344,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
>   		return nvmet_execute_get_log_cmd_effects_ns(req);
>   	case NVME_LOG_ANA:
>   		return nvmet_execute_get_log_page_ana(req);
> +	case NVME_LOG_RESERVATION:
> +		return nvmet_execute_get_log_page_resv(req);
>   	}
>   	pr_debug("unhandled lid %d on qid %d\n",
>   	       req->cmd->get_log_page.lid, req->sq->qid);
> @@ -433,7 +439,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   	id->nn = cpu_to_le32(NVMET_MAX_NAMESPACES);
>   	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
>   	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
> -			NVME_CTRL_ONCS_WRITE_ZEROES);
> +			NVME_CTRL_ONCS_WRITE_ZEROES |
> +			NVME_CTRL_ONCS_RESERVATIONS);
>   
>   	/* XXX: don't report vwc if the underlying device is write through */
>   	id->vwc = NVME_CTRL_VWC_PRESENT;
> @@ -551,6 +558,15 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>   	id->nmic = NVME_NS_NMIC_SHARED;
>   	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
>   
> +	if (req->ns->pr.enable)
> +		id->rescap = NVME_PR_SUPPORT_WRITE_EXCLUSIVE |
> +			NVME_PR_SUPPORT_EXCLUSIVE_ACCESS |
> +			NVME_PR_SUPPORT_WRITE_EXCLUSIVE_REG_ONLY |
> +			NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_REG_ONLY |
> +			NVME_PR_SUPPORT_WRITE_EXCLUSIVE_ALL_REGS |
> +			NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_ALL_REGS |
> +			NVME_PR_SUPPORT_IEKEY_VER_1_3_DEF;
> +
>   	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
>   
>   	id->lbaf[0].ds = req->ns->blksize_shift;
> @@ -861,6 +877,9 @@ void nvmet_execute_set_features(struct nvmet_req *req)
>   	case NVME_FEAT_WRITE_PROTECT:
>   		status = nvmet_set_feat_write_protect(req);
>   		break;
> +	case NVME_FEAT_RESV_MASK:
> +		status = nvmet_set_feat_resv_notif_mask(req, cdw11);
> +		break;
>   	default:
>   		req->error_loc = offsetof(struct nvme_common_command, cdw10);
>   		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> @@ -959,6 +978,9 @@ void nvmet_execute_get_features(struct nvmet_req *req)
>   	case NVME_FEAT_WRITE_PROTECT:
>   		status = nvmet_get_feat_write_protect(req);
>   		break;
> +	case NVME_FEAT_RESV_MASK:
> +		status = nvmet_get_feat_resv_notif_mask(req);
> +		break;
>   	default:
>   		req->error_loc =
>   			offsetof(struct nvme_common_command, cdw10);
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 685e89b35d33..eeee9e9b854c 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -769,6 +769,32 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
>   
>   CONFIGFS_ATTR_WO(nvmet_ns_, revalidate_size);
>   
> +static ssize_t nvmet_ns_resv_enable_show(struct config_item *item, char *page)
> +{
> +	return sysfs_emit(page, "%d\n", to_nvmet_ns(item)->pr.enable);
> +}
> +
> +static ssize_t nvmet_ns_resv_enable_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_ns *ns = to_nvmet_ns(item);
> +	bool val;
> +
> +	if (kstrtobool(page, &val))
> +		return -EINVAL;
> +
> +	mutex_lock(&ns->subsys->lock);
> +	if (ns->enabled) {
> +		pr_err("the ns:%d is already enabled.\n", ns->nsid);
> +		mutex_unlock(&ns->subsys->lock);
> +		return -EINVAL;
> +	}
> +	ns->pr.enable = val;
> +	mutex_unlock(&ns->subsys->lock);
> +	return count;
> +}
> +CONFIGFS_ATTR(nvmet_ns_, resv_enable);
> +
>   static struct configfs_attribute *nvmet_ns_attrs[] = {
>   	&nvmet_ns_attr_device_path,
>   	&nvmet_ns_attr_device_nguid,
> @@ -777,6 +803,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
>   	&nvmet_ns_attr_enable,
>   	&nvmet_ns_attr_buffered_io,
>   	&nvmet_ns_attr_revalidate_size,
> +	&nvmet_ns_attr_resv_enable,
>   #ifdef CONFIG_PCI_P2PDMA
>   	&nvmet_ns_attr_p2pmem,
>   #endif
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index ed2424f8a396..a2af7a9bc3b9 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -611,6 +611,12 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>   	if (ret)
>   		goto out_restore_subsys_maxnsid;
>   
> +	if (ns->pr.enable) {
> +		ret = nvmet_pr_init_ns(ns);
> +		if (ret)
> +			goto out_remove_from_subsys;
> +	}
> +
>   	subsys->nr_namespaces++;
>   
>   	nvmet_ns_changed(subsys, ns->nsid);
> @@ -620,6 +626,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>   	mutex_unlock(&subsys->lock);
>   	return ret;
>   
> +out_remove_from_subsys:
> +	xa_erase(&subsys->namespaces, ns->nsid);
>   out_restore_subsys_maxnsid:
>   	subsys->max_nsid = nvmet_max_nsid(subsys);
>   	percpu_ref_exit(&ns->ref);
> @@ -663,6 +671,9 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
>   	wait_for_completion(&ns->disable_done);
>   	percpu_ref_exit(&ns->ref);
>   
> +	if (ns->pr.enable)
> +		nvmet_pr_exit_ns(ns);
> +
>   	mutex_lock(&subsys->lock);
>   
>   	subsys->nr_namespaces--;
> @@ -766,6 +777,7 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
>   	trace_nvmet_req_complete(req);
>   
>   	req->ops->queue_response(req);
> +	nvmet_pr_put_ns_pc_ref(req);
>   	if (ns)
>   		nvmet_put_namespace(ns);
>   }
> @@ -929,18 +941,39 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
>   		return ret;
>   	}
>   
> +	if (req->ns->pr.enable) {
> +		ret = nvmet_parse_pr_cmd(req);
> +		if (!ret)
> +			return ret;
> +	}
> +
>   	switch (req->ns->csi) {
>   	case NVME_CSI_NVM:
>   		if (req->ns->file)
> -			return nvmet_file_parse_io_cmd(req);
> -		return nvmet_bdev_parse_io_cmd(req);
> +			ret = nvmet_file_parse_io_cmd(req);
> +		else
> +			ret = nvmet_bdev_parse_io_cmd(req);
> +		break;
>   	case NVME_CSI_ZNS:
>   		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> -			return nvmet_bdev_zns_parse_io_cmd(req);
> -		return NVME_SC_INVALID_IO_CMD_SET;
> +			ret = nvmet_bdev_zns_parse_io_cmd(req);
> +		else
> +			ret = NVME_SC_INVALID_IO_CMD_SET;
> +		break;
>   	default:
> -		return NVME_SC_INVALID_IO_CMD_SET;
> +		ret = NVME_SC_INVALID_IO_CMD_SET;
> +	}
> +	if (ret)
> +		return ret;
> +
> +	if (req->ns->pr.enable) {
> +		ret = nvmet_pr_check_cmd_access(req);
> +		if (ret)
> +			return ret;
> +
> +		ret = nvmet_pr_get_ns_pc_ref(req);
>   	}
> +	return ret;
>   }
>   
>   bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
> @@ -964,6 +997,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
>   	req->ns = NULL;
>   	req->error_loc = NVMET_NO_ERROR_LOC;
>   	req->error_slba = 0;
> +	req->pc_ref = NULL;
>   
>   	/* no support for fused commands yet */
>   	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
> @@ -1015,6 +1049,7 @@ EXPORT_SYMBOL_GPL(nvmet_req_init);
>   void nvmet_req_uninit(struct nvmet_req *req)
>   {
>   	percpu_ref_put(&req->sq->ref);
> +	nvmet_pr_put_ns_pc_ref(req);
>   	if (req->ns)
>   		nvmet_put_namespace(req->ns);
>   }
> @@ -1383,7 +1418,8 @@ static void nvmet_fatal_error_handler(struct work_struct *work)
>   }
>   
>   u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
> -		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp)
> +		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp,
> +		uuid_t *hostid)
>   {
>   	struct nvmet_subsys *subsys;
>   	struct nvmet_ctrl *ctrl;
> @@ -1462,6 +1498,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>   	}
>   	ctrl->cntlid = ret;
>   
> +	uuid_copy(&ctrl->hostid, hostid);
> +
>   	/*
>   	 * Discovery controllers may use some arbitrary high value
>   	 * in order to cleanup stale discovery sessions
> @@ -1478,6 +1516,9 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>   	nvmet_start_keep_alive_timer(ctrl);
>   
>   	mutex_lock(&subsys->lock);
> +	ret = nvmet_ctrl_init_pr(ctrl);
> +	if (ret)
> +		goto init_pr_fail;
>   	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
>   	nvmet_setup_p2p_ns_map(ctrl, req);
>   	nvmet_debugfs_ctrl_setup(ctrl);
> @@ -1486,6 +1527,10 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>   	*ctrlp = ctrl;
>   	return 0;
>   
> +init_pr_fail:
> +	mutex_unlock(&subsys->lock);
> +	nvmet_stop_keep_alive_timer(ctrl);
> +	ida_free(&cntlid_ida, ctrl->cntlid);
>   out_free_sqs:
>   	kfree(ctrl->sqs);
>   out_free_changed_ns_list:
> @@ -1504,6 +1549,7 @@ static void nvmet_ctrl_free(struct kref *ref)
>   	struct nvmet_subsys *subsys = ctrl->subsys;
>   
>   	mutex_lock(&subsys->lock);
> +	nvmet_ctrl_destroy_pr(ctrl);
>   	nvmet_release_p2p_ns_map(ctrl);
>   	list_del(&ctrl->subsys_entry);
>   	mutex_unlock(&subsys->lock);
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index c4b2eddd5666..28a84af1b4c0 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -245,12 +245,10 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
>   	d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
>   	d->hostnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
>   	status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
> -				  le32_to_cpu(c->kato), &ctrl);
> +				  le32_to_cpu(c->kato), &ctrl, &d->hostid);
>   	if (status)
>   		goto out;
>   
> -	uuid_copy(&ctrl->hostid, &d->hostid);
> -
>   	dhchap_status = nvmet_setup_auth(ctrl);
>   	if (dhchap_status) {
>   		pr_err("Failed to setup authentication, dhchap status %u\n",
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 190f55e6d753..51552f0430b4 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -20,6 +20,7 @@
>   #include <linux/blkdev.h>
>   #include <linux/radix-tree.h>
>   #include <linux/t10-pi.h>
> +#include <linux/kfifo.h>
>   
>   #define NVMET_DEFAULT_VS		NVME_VS(1, 3, 0)
>   
> @@ -30,6 +31,7 @@
>   #define NVMET_MN_MAX_SIZE		40
>   #define NVMET_SN_MAX_SIZE		20
>   #define NVMET_FR_MAX_SIZE		8
> +#define NVMET_PR_LOG_QUEUE_SIZE		64
>   
>   /*
>    * Supported optional AENs:
> @@ -56,6 +58,30 @@
>   #define IPO_IATTR_CONNECT_SQE(x)	\
>   	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
>   
> +struct nvmet_pr_registrant {
> +	u64			rkey;
> +	uuid_t			hostid;
> +	enum nvme_pr_type	rtype;
> +	struct list_head	entry;
> +	struct rcu_head		rcu;
> +};
> +
> +struct nvmet_pr {
> +	bool			enable;
> +	unsigned long		notify_mask;
> +	atomic_t		generation;
> +	struct nvmet_pr_registrant __rcu *holder;
> +	struct mutex		pr_lock;
> +	struct list_head	registrant_list;
> +};
> +
> +struct nvmet_pr_per_ctrl_ref {
> +	struct percpu_ref	ref;
> +	struct completion	free_done;
> +	struct completion	confirm_done;
> +	uuid_t			hostid;
> +};
> +
>   struct nvmet_ns {
>   	struct percpu_ref	ref;
>   	struct file		*bdev_file;
> @@ -85,6 +111,8 @@ struct nvmet_ns {
>   	int			pi_type;
>   	int			metadata_size;
>   	u8			csi;
> +	struct nvmet_pr		pr;
> +	struct xarray		pr_per_ctrl_refs;
>   };
>   
>   static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
> @@ -191,6 +219,13 @@ static inline bool nvmet_port_secure_channel_required(struct nvmet_port *port)
>       return nvmet_port_disc_addr_treq_secure_channel(port) == NVMF_TREQ_REQUIRED;
>   }
>   
> +struct nvmet_pr_log_mgr {
> +	struct mutex		lock;
> +	u64			lost_count;
> +	u64			counter;
> +	DECLARE_KFIFO(log_queue, struct nvme_pr_log, NVMET_PR_LOG_QUEUE_SIZE);
> +};
> +
>   struct nvmet_ctrl {
>   	struct nvmet_subsys	*subsys;
>   	struct nvmet_sq		**sqs;
> @@ -246,6 +281,7 @@ struct nvmet_ctrl {
>   	u8			*dh_key;
>   	size_t			dh_keysize;
>   #endif
> +	struct nvmet_pr_log_mgr pr_log_mgr;
>   };
>   
>   struct nvmet_subsys {
> @@ -412,6 +448,7 @@ struct nvmet_req {
>   	struct device		*p2p_client;
>   	u16			error_loc;
>   	u64			error_slba;
> +	struct nvmet_pr_per_ctrl_ref *pc_ref;
>   };
>   
>   #define NVMET_MAX_MPOOL_BVEC		16
> @@ -498,7 +535,8 @@ void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
>   
>   void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
>   u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
> -		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp);
> +		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp,
> +		uuid_t *hostid);
>   struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
>   				       const char *hostnqn, u16 cntlid,
>   				       struct nvmet_req *req);
> @@ -761,4 +799,19 @@ static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
>   static inline const char *nvmet_dhchap_dhgroup_name(u8 dhgid) { return NULL; }
>   #endif
>   
> +int nvmet_pr_init_ns(struct nvmet_ns *ns);
> +u16 nvmet_parse_pr_cmd(struct nvmet_req *req);
> +u16 nvmet_pr_check_cmd_access(struct nvmet_req *req);
> +int nvmet_ctrl_init_pr(struct nvmet_ctrl *ctrl);
> +void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl);
> +void nvmet_pr_exit_ns(struct nvmet_ns *ns);
> +void nvmet_execute_get_log_page_resv(struct nvmet_req *req);
> +u16 nvmet_set_feat_resv_notif_mask(struct nvmet_req *req, u32 mask);
> +u16 nvmet_get_feat_resv_notif_mask(struct nvmet_req *req);
> +u16 nvmet_pr_get_ns_pc_ref(struct nvmet_req *req);
> +static inline void nvmet_pr_put_ns_pc_ref(struct nvmet_req *req)
> +{
> +	if (req->pc_ref)
> +		percpu_ref_put(&req->pc_ref->ref);
> +}
>   #endif /* _NVMET_H */
> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
> new file mode 100644
> index 000000000000..7795a103dd3b
> --- /dev/null
> +++ b/drivers/nvme/target/pr.c
> @@ -0,0 +1,1172 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVMe over Fabrics Persist Reservation.
> + * Copyright (c) 2024 Guixin Liu, Alibaba Group.
> + * All rights reserved.
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/unaligned.h>
> +#include <linux/lockdep.h>
> +#include "nvmet.h"
> +
> +#define NVMET_PR_NOTIFI_MASK_ALL \
> +	(1 << NVME_PR_NOTIFY_BIT_REG_PREEMPTED | \
> +	 1 << NVME_PR_NOTIFY_BIT_RESV_RELEASED | \
> +	 1 << NVME_PR_NOTIFY_BIT_RESV_PREEMPTED)
> +
> +static inline bool nvmet_pr_parse_ignore_key(u32 cdw10)
> +{
> +	/* Ignore existing key, bit 03. */
> +	return (cdw10 >> 3) & 1;
> +}
> +
> +static inline struct nvmet_ns *nvmet_pr_to_ns(struct nvmet_pr *pr)
> +{
> +	return container_of(pr, struct nvmet_ns, pr);
> +}
> +
> +static struct nvmet_pr_registrant *
> +nvmet_pr_find_registrant(struct nvmet_pr *pr, uuid_t *hostid)
> +{
> +	struct nvmet_pr_registrant *reg;
> +
> +	list_for_each_entry_rcu(reg, &pr->registrant_list, entry,
> +				rcu_read_lock_held() ||
> +				lockdep_is_held(&pr->pr_lock)) {
> +		if (uuid_equal(&reg->hostid, hostid))
> +			return reg;
> +	}
> +	return NULL;
> +}
> +
> +u16 nvmet_set_feat_resv_notif_mask(struct nvmet_req *req, u32 mask)
> +{
> +	u32 nsid = le32_to_cpu(req->cmd->common.nsid);
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	struct nvmet_ns *ns;
> +	unsigned long idx;
> +	u16 status;
> +
> +	if (mask & ~(NVMET_PR_NOTIFI_MASK_ALL)) {
> +		req->error_loc = offsetof(struct nvme_common_command, cdw11);
> +		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +	}
> +
> +	if (nsid != U32_MAX) {
> +		status = nvmet_req_find_ns(req);
> +		if (status)
> +			return status;
> +		if (!req->ns->pr.enable)
> +			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +
> +		WRITE_ONCE(req->ns->pr.notify_mask, mask);
> +		goto success;
> +	}
> +
> +	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
> +		if (ns->pr.enable)
> +			WRITE_ONCE(ns->pr.notify_mask, mask);
> +	}
> +
> +success:
> +	nvmet_set_result(req, mask);
> +	return NVME_SC_SUCCESS;
> +}
> +
> +u16 nvmet_get_feat_resv_notif_mask(struct nvmet_req *req)
> +{
> +	u16 status;
> +
> +	status = nvmet_req_find_ns(req);
> +	if (status)
> +		return status;
> +
> +	if (!req->ns->pr.enable)
> +		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +
> +	nvmet_set_result(req, READ_ONCE(req->ns->pr.notify_mask));
> +	return status;
> +}
> +
> +void nvmet_execute_get_log_page_resv(struct nvmet_req *req)
> +{
> +	struct nvmet_pr_log_mgr *log_mgr = &req->sq->ctrl->pr_log_mgr;
> +	struct nvme_pr_log next_log = {0};
> +	struct nvme_pr_log log = {0};
> +	u16 status = NVME_SC_SUCCESS;
> +	u64 lost_count;
> +	u64 cur_count;
> +	u64 next_count;
> +
> +	mutex_lock(&log_mgr->lock);
> +	if (!kfifo_get(&log_mgr->log_queue, &log))
> +		goto out;
> +
> +	/*
> +	 * We can't get the last in kfifo.
> +	 * Utilize the current count and the count from the next log to
> +	 * calculate the number of lost logs, while also addressing cases
> +	 * of overflow. If there is no subsequent log, the number of lost
> +	 * logs is equal to the lost_count within the nvmet_pr_log_mgr.
> +	 */
> +	cur_count = le64_to_cpu(log.count);
> +	if (kfifo_peek(&log_mgr->log_queue, &next_log)) {
> +		next_count = le64_to_cpu(next_log.count);
> +		if (next_count > cur_count)
> +			lost_count = next_count - cur_count - 1;
> +		else
> +			lost_count = U64_MAX - cur_count + next_count - 1;
> +	} else {
> +		lost_count = log_mgr->lost_count;
> +	}
> +
> +	log.count = cpu_to_le64((cur_count + lost_count) == 0 ?
> +				1 : (cur_count + lost_count));
> +	log_mgr->lost_count -= lost_count;
> +
> +	log.nr_pages = kfifo_len(&log_mgr->log_queue);
> +
> +out:
> +	status = nvmet_copy_to_sgl(req, 0, &log, sizeof(log));
> +	mutex_unlock(&log_mgr->lock);
> +	nvmet_req_complete(req, status);
> +}
> +
> +static void nvmet_pr_add_resv_log(struct nvmet_ctrl *ctrl, u8 log_type,
> +				  u32 nsid)
> +{
> +	struct nvmet_pr_log_mgr *log_mgr = &ctrl->pr_log_mgr;
> +	struct nvme_pr_log log = {0};
> +
> +	mutex_lock(&log_mgr->lock);
> +	log_mgr->counter++;
> +	if (log_mgr->counter == 0)
> +		log_mgr->counter = 1;
> +
> +	log.count = cpu_to_le64(log_mgr->counter);
> +	log.type = log_type;
> +	log.nsid = cpu_to_le32(nsid);
> +
> +	if (!kfifo_put(&log_mgr->log_queue, log)) {
> +		pr_info("a reservation log lost, cntlid:%d, log_type:%d, nsid:%d\n",
> +			ctrl->cntlid, log_type, nsid);
> +		log_mgr->lost_count++;
> +	}
> +
> +	mutex_unlock(&log_mgr->lock);
> +}
> +
> +static void nvmet_pr_resv_released(struct nvmet_pr *pr, uuid_t *hostid)
> +{
> +	struct nvmet_ns *ns = nvmet_pr_to_ns(pr);
> +	struct nvmet_subsys *subsys = ns->subsys;
> +	struct nvmet_ctrl *ctrl;
> +
> +	if (test_bit(NVME_PR_NOTIFY_BIT_RESV_RELEASED, &pr->notify_mask))
> +		return;
> +
> +	mutex_lock(&subsys->lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (!uuid_equal(&ctrl->hostid, hostid) &&
> +		    nvmet_pr_find_registrant(pr, &ctrl->hostid)) {
> +			nvmet_pr_add_resv_log(ctrl,
> +				NVME_PR_LOG_RESERVATION_RELEASED, ns->nsid);
> +			nvmet_add_async_event(ctrl, NVME_AER_CSS,
> +				NVME_AEN_RESV_LOG_PAGE_AVALIABLE,
> +				NVME_LOG_RESERVATION);
> +		}
> +	}
> +	mutex_unlock(&subsys->lock);
> +}
> +
> +static void nvmet_pr_send_event_to_host(struct nvmet_pr *pr, uuid_t *hostid,
> +					  u8 log_type)
> +{
> +	struct nvmet_ns *ns = nvmet_pr_to_ns(pr);
> +	struct nvmet_subsys *subsys = ns->subsys;
> +	struct nvmet_ctrl *ctrl;
> +
> +	mutex_lock(&subsys->lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (uuid_equal(hostid, &ctrl->hostid)) {
> +			nvmet_pr_add_resv_log(ctrl, log_type, ns->nsid);
> +			nvmet_add_async_event(ctrl, NVME_AER_CSS,
> +				NVME_AEN_RESV_LOG_PAGE_AVALIABLE,
> +				NVME_LOG_RESERVATION);
> +		}
> +	}
> +	mutex_unlock(&subsys->lock);
> +}
> +
> +static void nvmet_pr_resv_preempted(struct nvmet_pr *pr, uuid_t *hostid)
> +{
> +	if (test_bit(NVME_PR_NOTIFY_BIT_RESV_PREEMPTED, &pr->notify_mask))
> +		return;
> +
> +	nvmet_pr_send_event_to_host(pr, hostid,
> +		NVME_PR_LOG_RESERVATOPM_PREEMPTED);
> +}
> +
> +static void nvmet_pr_registration_preempted(struct nvmet_pr *pr,
> +					    uuid_t *hostid)
> +{
> +	if (test_bit(NVME_PR_NOTIFY_BIT_REG_PREEMPTED, &pr->notify_mask))
> +		return;
> +
> +	nvmet_pr_send_event_to_host(pr, hostid,
> +		NVME_PR_LOG_REGISTRATION_PREEMPTED);
> +}
> +
> +static inline void nvmet_pr_set_new_holder(struct nvmet_pr *pr, u8 new_rtype,
> +					   struct nvmet_pr_registrant *reg)
> +{
> +	reg->rtype = new_rtype;
> +	rcu_assign_pointer(pr->holder, reg);
> +}
> +
> +static u16 nvmet_pr_register(struct nvmet_req *req,
> +			     struct nvmet_pr_register_data *d)
> +{
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	struct nvmet_pr_registrant *new, *reg;
> +	struct nvmet_pr *pr = &req->ns->pr;
> +	u16 status = NVME_SC_SUCCESS;
> +	u64 nrkey = le64_to_cpu(d->nrkey);
> +
> +	new = kmalloc(sizeof(*new), GFP_KERNEL);
> +	if (!new)
> +		return NVME_SC_INTERNAL;
> +
> +	mutex_lock(&pr->pr_lock);
> +	reg = nvmet_pr_find_registrant(pr, &ctrl->hostid);
> +	if (reg) {
> +		if (reg->rkey != nrkey)
> +			status = NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
> +		kfree(new);
> +		goto out;
> +	}
> +
> +	memset(new, 0, sizeof(*new));
> +	INIT_LIST_HEAD(&new->entry);
> +	new->rkey = nrkey;
> +	uuid_copy(&new->hostid, &ctrl->hostid);
> +	list_add_tail_rcu(&new->entry, &pr->registrant_list);
> +
> +out:
> +	mutex_unlock(&pr->pr_lock);
> +	return status;
> +}
> +
> +static void nvmet_pr_unregister_one(struct nvmet_pr *pr,
> +				    struct nvmet_pr_registrant *reg)
> +{
> +	struct nvmet_pr_registrant *first_reg;
> +	struct nvmet_pr_registrant *holder;
> +	u8 original_rtype;
> +
> +	lockdep_assert_held(&pr->pr_lock);
> +	list_del_rcu(&reg->entry);
> +
> +	holder = rcu_dereference_protected(pr->holder,
> +			lockdep_is_held(&pr->pr_lock));
> +	if (reg != holder)
> +		goto out;
> +
> +	original_rtype = holder->rtype;
> +	if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
> +	    original_rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
> +		first_reg = list_first_or_null_rcu(&pr->registrant_list,
> +				struct nvmet_pr_registrant, entry);
> +		if (first_reg)
> +			first_reg->rtype = original_rtype;
> +		rcu_assign_pointer(pr->holder, first_reg);
> +	} else {
> +		rcu_assign_pointer(pr->holder, NULL);
> +
> +		if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_REG_ONLY ||
> +		    original_rtype == NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY)
> +			nvmet_pr_resv_released(pr, &reg->hostid);
> +	}
> +out:
> +	kfree_rcu(reg, rcu);
> +}
> +
> +static u16 nvmet_pr_unregister(struct nvmet_req *req,
> +			       struct nvmet_pr_register_data *d,
> +			       bool ignore_key)
> +{
> +	u16 status = NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	struct nvmet_pr *pr = &req->ns->pr;
> +	struct nvmet_pr_registrant *reg;
> +
> +	mutex_lock(&pr->pr_lock);
> +	list_for_each_entry_rcu(reg, &pr->registrant_list, entry,
> +				lockdep_is_held(&pr->pr_lock)) {
> +		if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
> +			if (ignore_key || reg->rkey == le64_to_cpu(d->crkey)) {
> +				status = NVME_SC_SUCCESS;
> +				nvmet_pr_unregister_one(pr, reg);
> +			}
> +			break;
> +		}
> +	}
> +	mutex_unlock(&pr->pr_lock);
> +
> +	return status;
> +}
> +
> +static void nvmet_pr_update_reg_rkey(struct nvmet_pr_registrant *reg,
> +				     void *attr)
> +{
> +	reg->rkey = *(u64 *)attr;
> +}
> +
> +static u16 nvmet_pr_update_reg_attr(struct nvmet_pr *pr,
> +			struct nvmet_pr_registrant *reg,
> +			void (*change_attr)(struct nvmet_pr_registrant *reg,
> +			void *attr),
> +			void *attr)
> +{
> +	struct nvmet_pr_registrant *holder;
> +	struct nvmet_pr_registrant *new;
> +
> +	lockdep_assert_held(&pr->pr_lock);
> +	holder = rcu_dereference_protected(pr->holder,
> +			lockdep_is_held(&pr->pr_lock));
> +	if (reg != holder) {
> +		change_attr(reg, attr);
> +		return NVME_SC_SUCCESS;
> +	}
> +
> +	new = kmalloc(sizeof(*new), GFP_ATOMIC);
> +	if (!new)
> +		return NVME_SC_INTERNAL;
> +
> +	new->rkey = holder->rkey;
> +	new->rtype = holder->rtype;
> +	uuid_copy(&new->hostid, &holder->hostid);
> +	INIT_LIST_HEAD(&new->entry);
> +
> +	change_attr(new, attr);
> +	list_replace_rcu(&holder->entry, &new->entry);
> +	rcu_assign_pointer(pr->holder, new);
> +	kfree_rcu(holder, rcu);
> +
> +	return NVME_SC_SUCCESS;
> +}
> +
> +static u16 nvmet_pr_replace(struct nvmet_req *req,
> +			    struct nvmet_pr_register_data *d,
> +			    bool ignore_key)
> +{
> +	u16 status = NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	struct nvmet_pr *pr = &req->ns->pr;
> +	struct nvmet_pr_registrant *reg;
> +	u64 nrkey = le64_to_cpu(d->nrkey);
> +
> +	mutex_lock(&pr->pr_lock);
> +	list_for_each_entry_rcu(reg, &pr->registrant_list, entry,
> +				lockdep_is_held(&pr->pr_lock)) {
> +		if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
> +			if (ignore_key || reg->rkey == le64_to_cpu(d->crkey))
> +				status = nvmet_pr_update_reg_attr(pr, reg,
> +						nvmet_pr_update_reg_rkey,
> +						&nrkey);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&pr->pr_lock);
> +	return status;
> +}
> +
> +static void nvmet_execute_pr_register(struct nvmet_req *req)
> +{
> +	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
> +	bool ignore_key = nvmet_pr_parse_ignore_key(cdw10);
> +	struct nvmet_pr_register_data *d;
> +	u8 reg_act = cdw10 & 0x07; /* Reservation Register Action, bit 02:00 */
> +	u16 status;
> +
> +	d = kmalloc(sizeof(*d), GFP_KERNEL);
> +	if (!d) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
> +	if (status)
> +		goto free_data;
> +
> +	switch (reg_act) {
> +	case NVME_PR_REGISTER_ACT_REG:
> +		status = nvmet_pr_register(req, d);
> +		break;
> +	case NVME_PR_REGISTER_ACT_UNREG:
> +		status = nvmet_pr_unregister(req, d, ignore_key);
> +		break;
> +	case NVME_PR_REGISTER_ACT_REPLACE:
> +		status = nvmet_pr_replace(req, d, ignore_key);
> +		break;
> +	default:
> +		req->error_loc = offsetof(struct nvme_common_command, cdw10);
> +		status = NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
> +		break;
> +	}
> +free_data:
> +	kfree(d);
> +out:
> +	if (!status)
> +		atomic_inc(&req->ns->pr.generation);
> +	nvmet_req_complete(req, status);
> +}
> +
> +static u16 nvmet_pr_acquire(struct nvmet_req *req,
> +			    struct nvmet_pr_registrant *reg,
> +			    u8 rtype)
> +{
> +	struct nvmet_pr *pr = &req->ns->pr;
> +	struct nvmet_pr_registrant *holder;
> +
> +	lockdep_assert_held(&pr->pr_lock);
> +	holder = rcu_dereference_protected(pr->holder,
> +			lockdep_is_held(&pr->pr_lock));
> +	if (holder && reg != holder)
> +		return  NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
> +	if (holder && reg == holder) {
> +		if (holder->rtype == rtype)
> +			return NVME_SC_SUCCESS;
> +		return NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
> +	}
> +
> +	nvmet_pr_set_new_holder(pr, rtype, reg);
> +	return NVME_SC_SUCCESS;
> +}
> +
> +static void nvmet_pr_confirm_ns_pc_ref(struct percpu_ref *ref)
> +{
> +	struct nvmet_pr_per_ctrl_ref *pc_ref =
> +		container_of(ref, struct nvmet_pr_per_ctrl_ref, ref);
> +
> +	complete(&pc_ref->confirm_done);
> +}
> +
> +static void nvmet_pr_set_ctrl_to_abort(struct nvmet_req *req, uuid_t *hostid)
> +{
> +	struct nvmet_pr_per_ctrl_ref *pc_ref;
> +	struct nvmet_ns *ns = req->ns;
> +	unsigned long idx;
> +
> +	xa_for_each(&ns->pr_per_ctrl_refs, idx, pc_ref) {
> +		if (uuid_equal(&pc_ref->hostid, hostid)) {
> +			percpu_ref_kill_and_confirm(&pc_ref->ref,
> +						nvmet_pr_confirm_ns_pc_ref);
> +			wait_for_completion(&pc_ref->confirm_done);
> +		}
> +	}
> +}
> +
> +static u16 nvmet_pr_unreg_all_host_by_prkey(struct nvmet_req *req, u64 prkey,
> +					    uuid_t *send_hostid,
> +					    bool abort)
> +{
> +	u16 status = NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
> +	struct nvmet_pr_registrant *reg, *tmp;
> +	struct nvmet_pr *pr = &req->ns->pr;
> +	uuid_t hostid;
> +
> +	lockdep_assert_held(&pr->pr_lock);
> +
> +	list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
> +		if (reg->rkey == prkey) {
> +			status = NVME_SC_SUCCESS;
> +			uuid_copy(&hostid, &reg->hostid);
> +			if (abort)
> +				nvmet_pr_set_ctrl_to_abort(req, &hostid);
> +			nvmet_pr_unregister_one(pr, reg);
> +			if (!uuid_equal(&hostid, send_hostid))
> +				nvmet_pr_registration_preempted(pr, &hostid);
> +		}
> +	}
> +	return status;
> +}
> +
> +static void nvmet_pr_unreg_all_others_by_prkey(struct nvmet_req *req,
> +					       u64 prkey,
> +					       uuid_t *send_hostid,
> +					       bool abort)
> +{
> +	struct nvmet_pr_registrant *reg, *tmp;
> +	struct nvmet_pr *pr = &req->ns->pr;
> +	uuid_t hostid;
> +
> +	lockdep_assert_held(&pr->pr_lock);
> +
> +	list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
> +		if (reg->rkey == prkey &&
> +		    !uuid_equal(&reg->hostid, send_hostid)) {
> +			uuid_copy(&hostid, &reg->hostid);
> +			if (abort)
> +				nvmet_pr_set_ctrl_to_abort(req, &hostid);
> +			nvmet_pr_unregister_one(pr, reg);
> +			nvmet_pr_registration_preempted(pr, &hostid);
> +		}
> +	}
> +}
> +
> +static void nvmet_pr_unreg_all_others(struct nvmet_req *req,
> +				      uuid_t *send_hostid,
> +				      bool abort)
> +{
> +	struct nvmet_pr_registrant *reg, *tmp;
> +	struct nvmet_pr *pr = &req->ns->pr;
> +	uuid_t hostid;
> +
> +	lockdep_assert_held(&pr->pr_lock);
> +
> +	list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
> +		if (!uuid_equal(&reg->hostid, send_hostid)) {
> +			uuid_copy(&hostid, &reg->hostid);
> +			if (abort)
> +				nvmet_pr_set_ctrl_to_abort(req, &hostid);
> +			nvmet_pr_unregister_one(pr, reg);
> +			nvmet_pr_registration_preempted(pr, &hostid);
> +		}
> +	}
> +}
> +
> +static void nvmet_pr_update_holder_rtype(struct nvmet_pr_registrant *reg,
> +					 void *attr)
> +{
> +	u8 new_rtype = *(u8 *)attr;
> +
> +	reg->rtype = new_rtype;
> +}
> +
> +static u16 nvmet_pr_preempt(struct nvmet_req *req,
> +			    struct nvmet_pr_registrant *reg,
> +			    u8 rtype,
> +			    struct nvmet_pr_acquire_data *d,
> +			    bool abort)
> +{
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	struct nvmet_pr *pr = &req->ns->pr;
> +	struct nvmet_pr_registrant *holder;
> +	enum nvme_pr_type original_rtype;
> +	u64 prkey = le64_to_cpu(d->prkey);
> +	u16 status;
> +
> +	lockdep_assert_held(&pr->pr_lock);
> +	holder = rcu_dereference_protected(pr->holder,
> +			lockdep_is_held(&pr->pr_lock));
> +	if (!holder)
> +		return nvmet_pr_unreg_all_host_by_prkey(req, prkey,
> +					&ctrl->hostid, abort);
> +
> +	original_rtype = holder->rtype;
> +	if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
> +	    original_rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
> +		if (!prkey) {
> +			/*
> +			 * To prevent possible access from other hosts, and
> +			 * avoid terminate the holder, set the new holder
> +			 * first before unregistering.
> +			 */
> +			nvmet_pr_set_new_holder(pr, rtype, reg);
> +			nvmet_pr_unreg_all_others(req, &ctrl->hostid, abort);
> +			return NVME_SC_SUCCESS;
> +		}
> +		return nvmet_pr_unreg_all_host_by_prkey(req, prkey,
> +				&ctrl->hostid, abort);
> +	}
> +
> +	if (holder == reg) {
> +		status = nvmet_pr_update_reg_attr(pr, holder,
> +				nvmet_pr_update_holder_rtype, &rtype);
> +		if (!status && original_rtype != rtype)
> +			nvmet_pr_resv_released(pr, &reg->hostid);
> +		return status;
> +	}
> +
> +	if (prkey == holder->rkey) {
> +		/*
> +		 * Same as before, set the new holder first.
> +		 */
> +		nvmet_pr_set_new_holder(pr, rtype, reg);
> +		nvmet_pr_unreg_all_others_by_prkey(req, prkey, &ctrl->hostid,
> +						abort);
> +		if (original_rtype != rtype)
> +			nvmet_pr_resv_released(pr, &reg->hostid);
> +		return NVME_SC_SUCCESS;
> +	}
> +
> +	if (prkey)
> +		return nvmet_pr_unreg_all_host_by_prkey(req, prkey,
> +					&ctrl->hostid, abort);
> +	return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +}
> +
> +static void nvmet_pr_do_abort(struct nvmet_req *req)
> +{
> +	struct nvmet_pr_per_ctrl_ref *pc_ref;
> +	struct nvmet_ns *ns = req->ns;
> +	unsigned long idx;
> +
> +	/*
> +	 * The target does not support abort, just wait per-controller ref to 0.
> +	 */
> +	xa_for_each(&ns->pr_per_ctrl_refs, idx, pc_ref) {
> +		if (percpu_ref_is_dying(&pc_ref->ref)) {

Is this possible that we get here without the ref dying? Maybe a warn
is appropriate here? just feels incorrect to blindly do nothing and just
skip...

> +			wait_for_completion(&pc_ref->free_done);
> +			reinit_completion(&pc_ref->confirm_done);
> +			reinit_completion(&pc_ref->free_done);
> +			percpu_ref_resurrect(&pc_ref->ref);
> +		}
> +	}

I'm wandering if the do_abort should be deferred to a wq? this will
block the transport thread for a long time, preventing progress
for other namespaces that can accept IO perhaps?

The rest looks fine, although I am having a hard time reviewing a single
patch of this size...

