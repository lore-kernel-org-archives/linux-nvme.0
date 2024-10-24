Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7886BCE8E68
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 12:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MI7Y4sz6/24QvQa2OIQ3WZu21F4a/TtbDAdNuW7w09Q=; b=qMMXbiD6jtZgXdCUhXmH2sIccm
	EEdL6HskC7Dcz1BKfQg7WCpiu4K5kfSTrtkxn1ySrqz55pjzr0yeyHG2Z4L8km9+reoTYPY9xHOWg
	QsSkXE/fhG5gQo3vdFc1kytaW1WDmmgxoPPHkkOpl5c8801wqo5b2Y8IQa4oHZxf3iOlFukZX+Xsr
	QhbMHxkNfs/bNGDeHWD5FiMphBD+ZtvTOdbg4asz+gTlB+owLd6Q+ckACkplTVy1zlczk9yHu67Au
	mgwtyzog+bsN2eEeFeyJpfhCDsdGHCF7VuIn60vNfZtdgEKXQSuYWIfNyGZ6ghMfGWcmwQSf0unRg
	S+ObOaSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wY6-00000000HUM-2k1X;
	Thu, 24 Oct 2024 12:02:42 +0000
Received: from mta-03.yadro.com ([89.207.88.253])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wWu-00000000HNb-1er9
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 12:01:31 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 939B6E000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1729771282; bh=MI7Y4sz6/24QvQa2OIQ3WZu21F4a/TtbDAdNuW7w09Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=CvKgtzUK6hPgSJ6BUygvqfLB4utzME1OoOWZvzXCaZK+ohYMA91GtsRd2FENxIlYb
	 XtiH26qLdc3ojbQgVagBHL1U0hEPU00rBH4yXO8LV0EL1/za5/D9H8D55+M32DcITI
	 ndtJP4u6OxxWxfG82YxSrwER6JIBK6w5ehsmDrfPiuibCpAIGkWxF7oYQmCDM/XNnT
	 ExWOd4sUv+DgfcVIy0I+DlPmPZ/6EgebRjDxXVLXdPM1qXuHcgF4VrzydCrB8W6v+5
	 JnJTZbv1Bg+u79Zcnnon2kuTsY4N7IpiKSWVbmo93lwqCiREY0y6Hg83tivJdC+D3D
	 qnUA2wOVKhQow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1729771282; bh=MI7Y4sz6/24QvQa2OIQ3WZu21F4a/TtbDAdNuW7w09Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=aEvwEQz/1b2L2BMEeoWbHJ3c3x2VgOMWcXvAt321IHnVjwYUoKZSYvOTfQjKYr/Cg
	 2Rvy0Htzr0F9awMbusB1Xo5Ez+A42Eb/zaHUYP2EGzH9YNIfQhzxH0L/XGj5U/VImU
	 luPUPWPfFo4G2c2n2TmeV1icvUEnhYRqr/TduW0d1Mi8xC2pcV8ubLdkAkcqjU69hv
	 DybqggShmv6PqKOq+/27XzZ4veRrRjMQqs9DnyO+/wFYpsdBp5inuTQjtfT4mNzwIa
	 i5KZB/ntHqGdiH3vAWAEGDyRX+8lRP6ahKFNjOPmQuM2HTiJZtSJX04QtPTejMUVQI
	 tnniNsV0l3PYg==
Date: Thu, 24 Oct 2024 15:01:20 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
	<shinichiro.kawasaki@wdc.com>, <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v18 2/2] nvmet: support reservation feature
Message-ID: <20241024120120.GO22571@yadro.com>
References: <20241024025200.119965-1-kanie@linux.alibaba.com>
 <20241024025200.119965-3-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241024025200.119965-3-kanie@linux.alibaba.com>
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_050129_371182_702704F5 
X-CRM114-Status: GOOD (  30.92  )
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

On Thu, Oct 24, 2024 at 10:52:00AM +0800, Guixin Liu wrote:
> This patch implements the reservation feature, including:
>   1. reservation register(register, unregister and replace).
>   2. reservation acquire(acquire, preempt, preempt and abort).
>   3. reservation release(release and clear).
>   4. reservation report.
>   5. set feature and get feature of reservation notify mask.
>   6. get log page of reservation event.
> 
> Not supported:
>   1. persistent reservation through power loss.
> 
> Test cases:
>   Use nvme-cli and fio to test all implemented sub features:
>   1. use nvme resv-register to register host a registrant or
>      unregister or replace a new key.
>   2. use nvme resv-acquire to set host to the holder, and use fio
>      to send read and write io in all reservation type. And also
>      test preempt and "preempt and abort".
>   3. use nvme resv-report to show all registrants and reservation
>      status.
>   4. use nvme resv-release to release all registrants.
>   5. use nvme get-log to get events generated by the preceding
>      operations.
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
>  drivers/nvme/target/Makefile      |    2 +-
>  drivers/nvme/target/admin-cmd.c   |   24 +-
>  drivers/nvme/target/configfs.c    |   27 +
>  drivers/nvme/target/core.c        |   58 +-
>  drivers/nvme/target/fabrics-cmd.c |    4 +-
>  drivers/nvme/target/nvmet.h       |   66 +-
>  drivers/nvme/target/pr.c          | 1163 +++++++++++++++++++++++++++++
>  7 files changed, 1332 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/nvme/target/pr.c
> 
> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
> index c402c44350b2..f2b025bbe10c 100644
> --- a/drivers/nvme/target/Makefile
> +++ b/drivers/nvme/target/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)      += nvme-fcloop.o
>  obj-$(CONFIG_NVME_TARGET_TCP)          += nvmet-tcp.o
> 
>  nvmet-y                += core.o configfs.o admin-cmd.o fabrics-cmd.o \
> -                       discovery.o io-cmd-file.o io-cmd-bdev.o
> +                       discovery.o io-cmd-file.o io-cmd-bdev.o pr.o
>  nvmet-$(CONFIG_NVME_TARGET_DEBUGFS)    += debugfs.o
>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)   += passthru.o
>  nvmet-$(CONFIG_BLK_DEV_ZONED)          += zns.o
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 081f0473cd9e..19428745c795 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -176,6 +176,10 @@ static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
>         log->iocs[nvme_cmd_read] =
>         log->iocs[nvme_cmd_flush] =
>         log->iocs[nvme_cmd_dsm] =
> +       log->iocs[nvme_cmd_resv_acquire] =
> +       log->iocs[nvme_cmd_resv_register] =
> +       log->iocs[nvme_cmd_resv_release] =
> +       log->iocs[nvme_cmd_resv_report] =
>                 cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
>         log->iocs[nvme_cmd_write] =
>         log->iocs[nvme_cmd_write_zeroes] =
> @@ -340,6 +344,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
>                 return nvmet_execute_get_log_cmd_effects_ns(req);
>         case NVME_LOG_ANA:
>                 return nvmet_execute_get_log_page_ana(req);
> +       case NVME_LOG_RESERVATION:
> +               return nvmet_execute_get_log_page_resv(req);
>         }
>         pr_debug("unhandled lid %d on qid %d\n",
>                req->cmd->get_log_page.lid, req->sq->qid);
> @@ -433,7 +439,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>         id->nn = cpu_to_le32(NVMET_MAX_NAMESPACES);
>         id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
>         id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
> -                       NVME_CTRL_ONCS_WRITE_ZEROES);
> +                       NVME_CTRL_ONCS_WRITE_ZEROES |
> +                       NVME_CTRL_ONCS_RESERVATIONS);
> 
>         /* XXX: don't report vwc if the underlying device is write through */
>         id->vwc = NVME_CTRL_VWC_PRESENT;
> @@ -551,6 +558,15 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>         id->nmic = NVME_NS_NMIC_SHARED;
>         id->anagrpid = cpu_to_le32(req->ns->anagrpid);
> 
> +       if (req->ns->pr.enable)
> +               id->rescap = NVME_PR_SUPPORT_WRITE_EXCLUSIVE |
> +                       NVME_PR_SUPPORT_EXCLUSIVE_ACCESS |
> +                       NVME_PR_SUPPORT_WRITE_EXCLUSIVE_REG_ONLY |
> +                       NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_REG_ONLY |
> +                       NVME_PR_SUPPORT_WRITE_EXCLUSIVE_ALL_REGS |
> +                       NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_ALL_REGS |
> +                       NVME_PR_SUPPORT_IEKEY_VER_1_3_DEF;
> +
>         memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
> 
>         id->lbaf[0].ds = req->ns->blksize_shift;
> @@ -861,6 +877,9 @@ void nvmet_execute_set_features(struct nvmet_req *req)
>         case NVME_FEAT_WRITE_PROTECT:
>                 status = nvmet_set_feat_write_protect(req);
>                 break;
> +       case NVME_FEAT_RESV_MASK:
> +               status = nvmet_set_feat_resv_notif_mask(req, cdw11);
> +               break;
>         default:
>                 req->error_loc = offsetof(struct nvme_common_command, cdw10);
>                 status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> @@ -959,6 +978,9 @@ void nvmet_execute_get_features(struct nvmet_req *req)
>         case NVME_FEAT_WRITE_PROTECT:
>                 status = nvmet_get_feat_write_protect(req);
>                 break;
> +       case NVME_FEAT_RESV_MASK:
> +               status = nvmet_get_feat_resv_notif_mask(req);
> +               break;
>         default:
>                 req->error_loc =
>                         offsetof(struct nvme_common_command, cdw10);
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 685e89b35d33..eeee9e9b854c 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -769,6 +769,32 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
> 
>  CONFIGFS_ATTR_WO(nvmet_ns_, revalidate_size);
> 
> +static ssize_t nvmet_ns_resv_enable_show(struct config_item *item, char *page)
> +{
> +       return sysfs_emit(page, "%d\n", to_nvmet_ns(item)->pr.enable);
> +}
> +
> +static ssize_t nvmet_ns_resv_enable_store(struct config_item *item,
> +               const char *page, size_t count)
> +{
> +       struct nvmet_ns *ns = to_nvmet_ns(item);
> +       bool val;
> +
> +       if (kstrtobool(page, &val))
> +               return -EINVAL;
> +
> +       mutex_lock(&ns->subsys->lock);
> +       if (ns->enabled) {
> +               pr_err("the ns:%d is already enabled.\n", ns->nsid);
> +               mutex_unlock(&ns->subsys->lock);
> +               return -EINVAL;
> +       }
> +       ns->pr.enable = val;
> +       mutex_unlock(&ns->subsys->lock);
> +       return count;
> +}
> +CONFIGFS_ATTR(nvmet_ns_, resv_enable);
> +
>  static struct configfs_attribute *nvmet_ns_attrs[] = {
>         &nvmet_ns_attr_device_path,
>         &nvmet_ns_attr_device_nguid,
> @@ -777,6 +803,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
>         &nvmet_ns_attr_enable,
>         &nvmet_ns_attr_buffered_io,
>         &nvmet_ns_attr_revalidate_size,
> +       &nvmet_ns_attr_resv_enable,
>  #ifdef CONFIG_PCI_P2PDMA
>         &nvmet_ns_attr_p2pmem,
>  #endif
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index ed2424f8a396..a2af7a9bc3b9 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -611,6 +611,12 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>         if (ret)
>                 goto out_restore_subsys_maxnsid;
> 
> +       if (ns->pr.enable) {
> +               ret = nvmet_pr_init_ns(ns);
> +               if (ret)
> +                       goto out_remove_from_subsys;
> +       }
> +
>         subsys->nr_namespaces++;
> 
>         nvmet_ns_changed(subsys, ns->nsid);
> @@ -620,6 +626,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>         mutex_unlock(&subsys->lock);
>         return ret;
> 
> +out_remove_from_subsys:
> +       xa_erase(&subsys->namespaces, ns->nsid);
>  out_restore_subsys_maxnsid:
>         subsys->max_nsid = nvmet_max_nsid(subsys);
>         percpu_ref_exit(&ns->ref);
> @@ -663,6 +671,9 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
>         wait_for_completion(&ns->disable_done);
>         percpu_ref_exit(&ns->ref);
> 
> +       if (ns->pr.enable)
> +               nvmet_pr_exit_ns(ns);
> +
>         mutex_lock(&subsys->lock);
> 
>         subsys->nr_namespaces--;
> @@ -766,6 +777,7 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
>         trace_nvmet_req_complete(req);
> 
>         req->ops->queue_response(req);
> +       nvmet_pr_put_ns_pc_ref(req);
>         if (ns)
>                 nvmet_put_namespace(ns);
>  }
> @@ -929,18 +941,39 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
>                 return ret;
>         }
> 
> +       if (req->ns->pr.enable) {
> +               ret = nvmet_parse_pr_cmd(req);
> +               if (!ret)
> +                       return ret;
> +       }
> +
>         switch (req->ns->csi) {
>         case NVME_CSI_NVM:
>                 if (req->ns->file)
> -                       return nvmet_file_parse_io_cmd(req);
> -               return nvmet_bdev_parse_io_cmd(req);
> +                       ret = nvmet_file_parse_io_cmd(req);
> +               else
> +                       ret = nvmet_bdev_parse_io_cmd(req);
> +               break;
>         case NVME_CSI_ZNS:
>                 if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> -                       return nvmet_bdev_zns_parse_io_cmd(req);
> -               return NVME_SC_INVALID_IO_CMD_SET;
> +                       ret = nvmet_bdev_zns_parse_io_cmd(req);
> +               else
> +                       ret = NVME_SC_INVALID_IO_CMD_SET;
> +               break;
>         default:
> -               return NVME_SC_INVALID_IO_CMD_SET;
> +               ret = NVME_SC_INVALID_IO_CMD_SET;
> +       }
> +       if (ret)
> +               return ret;
> +
> +       if (req->ns->pr.enable) {
> +               ret = nvmet_pr_check_cmd_access(req);
> +               if (ret)
> +                       return ret;
> +
> +               ret = nvmet_pr_get_ns_pc_ref(req);
>         }
> +       return ret;
>  }
> 
>  bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
> @@ -964,6 +997,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
>         req->ns = NULL;
>         req->error_loc = NVMET_NO_ERROR_LOC;
>         req->error_slba = 0;
> +       req->pc_ref = NULL;
> 
>         /* no support for fused commands yet */
>         if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
> @@ -1015,6 +1049,7 @@ EXPORT_SYMBOL_GPL(nvmet_req_init);
>  void nvmet_req_uninit(struct nvmet_req *req)
>  {
>         percpu_ref_put(&req->sq->ref);
> +       nvmet_pr_put_ns_pc_ref(req);
>         if (req->ns)
>                 nvmet_put_namespace(req->ns);
>  }
> @@ -1383,7 +1418,8 @@ static void nvmet_fatal_error_handler(struct work_struct *work)
>  }
> 
>  u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
> -               struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp)
> +               struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp,
> +               uuid_t *hostid)
>  {
>         struct nvmet_subsys *subsys;
>         struct nvmet_ctrl *ctrl;
> @@ -1462,6 +1498,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>         }
>         ctrl->cntlid = ret;
> 
> +       uuid_copy(&ctrl->hostid, hostid);
> +
>         /*
>          * Discovery controllers may use some arbitrary high value
>          * in order to cleanup stale discovery sessions
> @@ -1478,6 +1516,9 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>         nvmet_start_keep_alive_timer(ctrl);
> 
>         mutex_lock(&subsys->lock);
> +       ret = nvmet_ctrl_init_pr(ctrl);
> +       if (ret)
> +               goto init_pr_fail;
>         list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
>         nvmet_setup_p2p_ns_map(ctrl, req);
>         nvmet_debugfs_ctrl_setup(ctrl);
> @@ -1486,6 +1527,10 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>         *ctrlp = ctrl;
>         return 0;
> 
> +init_pr_fail:
> +       mutex_unlock(&subsys->lock);
> +       nvmet_stop_keep_alive_timer(ctrl);
> +       ida_free(&cntlid_ida, ctrl->cntlid);
>  out_free_sqs:
>         kfree(ctrl->sqs);
>  out_free_changed_ns_list:
> @@ -1504,6 +1549,7 @@ static void nvmet_ctrl_free(struct kref *ref)
>         struct nvmet_subsys *subsys = ctrl->subsys;
> 
>         mutex_lock(&subsys->lock);
> +       nvmet_ctrl_destroy_pr(ctrl);
>         nvmet_release_p2p_ns_map(ctrl);
>         list_del(&ctrl->subsys_entry);
>         mutex_unlock(&subsys->lock);
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index c4b2eddd5666..28a84af1b4c0 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -245,12 +245,10 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
>         d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
>         d->hostnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
>         status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
> -                                 le32_to_cpu(c->kato), &ctrl);
> +                                 le32_to_cpu(c->kato), &ctrl, &d->hostid);
>         if (status)
>                 goto out;
> 
> -       uuid_copy(&ctrl->hostid, &d->hostid);
> -
>         dhchap_status = nvmet_setup_auth(ctrl);
>         if (dhchap_status) {
>                 pr_err("Failed to setup authentication, dhchap status %u\n",
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 190f55e6d753..1e5851f6d29b 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -20,6 +20,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/radix-tree.h>
>  #include <linux/t10-pi.h>
> +#include <linux/kfifo.h>
> 
>  #define NVMET_DEFAULT_VS               NVME_VS(1, 3, 0)
> 
> @@ -30,6 +31,7 @@
>  #define NVMET_MN_MAX_SIZE              40
>  #define NVMET_SN_MAX_SIZE              20
>  #define NVMET_FR_MAX_SIZE              8
> +#define NVMET_PR_LOG_QUEUE_SIZE                64
> 
>  /*
>   * Supported optional AENs:
> @@ -56,6 +58,38 @@
>  #define IPO_IATTR_CONNECT_SQE(x)       \
>         (cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
> 
> +struct nvmet_pr_registrant {
> +       u64                     rkey;
> +       uuid_t                  hostid;
> +       enum nvme_pr_type       rtype;
> +       struct list_head        entry;
> +       struct rcu_head         rcu;
> +};
> +
> +struct nvmet_pr {
> +       bool                    enable;
> +       unsigned long           notify_mask;
> +       atomic_t                generation;
> +       struct nvmet_pr_registrant __rcu *holder;
> +       /*
> +        * During the execution of the reservation command, mutual
> +        * exclusion is required throughout the process. However,
> +        * while waiting asynchronously for the 'per controller
> +        * percpu_ref' to complete before the 'preempt and abort'
> +        * command finishes, a semaphore is needed to ensure mutual
> +        * exclusion instead of a mutex.
> +        */
> +       struct semaphore        pr_sem;
> +       struct list_head        registrant_list;
> +};
> +
> +struct nvmet_pr_per_ctrl_ref {
> +       struct percpu_ref       ref;
> +       struct completion       free_done;
> +       struct completion       confirm_done;
> +       uuid_t                  hostid;
> +};
> +

> +static void nvmet_pr_set_ctrl_to_abort(struct nvmet_req *req, uuid_t *hostid)
> +{
> +       struct nvmet_pr_per_ctrl_ref *pc_ref;
> +       struct nvmet_ns *ns = req->ns;
> +       unsigned long idx;
> +
> +       xa_for_each(&ns->pr_per_ctrl_refs, idx, pc_ref) {
> +               if (uuid_equal(&pc_ref->hostid, hostid)) {
> +                       percpu_ref_kill_and_confirm(&pc_ref->ref,
> +                                               nvmet_pr_confirm_ns_pc_ref);
> +                       wait_for_completion(&pc_ref->confirm_done);
> +               }
> +       }
> +}
> +
> +static void nvmet_pr_do_abort(struct work_struct *w)
> +{
> +       struct nvmet_req *req = container_of(w, struct nvmet_req, r.abort_work);
> +       struct nvmet_pr_per_ctrl_ref *pc_ref;
> +       struct nvmet_ns *ns = req->ns;
> +       unsigned long idx;
> +
> +       /*
> +        * The target does not support abort, just wait per-controller ref to 0.
> +        */
> +       xa_for_each(&ns->pr_per_ctrl_refs, idx, pc_ref) {
> +               if (percpu_ref_is_dying(&pc_ref->ref)) {
> +                       wait_for_completion(&pc_ref->free_done);
> +                       reinit_completion(&pc_ref->confirm_done);
> +                       reinit_completion(&pc_ref->free_done);
> +                       percpu_ref_resurrect(&pc_ref->ref);
> +               }
> +       }

If you want just to protect this particular loop against of a parallel
execution, why simply not to protect it by its own mutex?

> +       up(&ns->pr.pr_sem);
> +       nvmet_req_complete(req, NVME_SC_SUCCESS);
> +}
> +

> +static void nvmet_execute_pr_acquire(struct nvmet_req *req)
> +{
> +       u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
> +       bool ignore_key = nvmet_pr_parse_ignore_key(cdw10);
> +       /* Reservation type, bit 15:08 */
> +       u8 rtype = (u8)((cdw10 >> 8) & 0xff);
> +       /* Reservation acquire action, bit 02:00 */
> +       u8 acquire_act = cdw10 & 0x07;
> +       struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +       struct nvmet_pr_acquire_data *d = NULL;
> +       struct nvmet_pr *pr = &req->ns->pr;
> +       struct nvmet_pr_registrant *reg;
> +       u16 status = NVME_SC_SUCCESS;
> +
> +       if (ignore_key ||
> +           rtype < NVME_PR_WRITE_EXCLUSIVE ||
> +           rtype > NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
> +               status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +               goto out;
> +       }
> +
> +       d = kmalloc(sizeof(*d), GFP_KERNEL);
> +       if (!d) {
> +               status = NVME_SC_INTERNAL;
> +               goto out;
> +       }
> +
> +       status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
> +       if (status)
> +               goto free_data;
> +
> +       status = NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
> +       down(&pr->pr_sem);
> +       list_for_each_entry_rcu(reg, &pr->registrant_list, entry,
> +                               lockdep_is_held(&pr->pr_lock)) {

lockdep_is_held does not work with semaphores. Using a semaphore drops
your lockdep effort.

> +               if (uuid_equal(&reg->hostid, &ctrl->hostid) &&
> +                   reg->rkey == le64_to_cpu(d->crkey)) {
> +                       status = __nvmet_execute_pr_acquire(req, reg,
> +                                       acquire_act, rtype, d);
> +                       break;
> +               }
> +       }
> +
> +       if (!status && acquire_act == NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT) {
> +               kfree(d);
> +               INIT_WORK(&req->r.abort_work, nvmet_pr_do_abort);
> +               queue_work(nvmet_wq, &req->r.abort_work);
> +               return;
> +       }
> +
> +       up(&pr->pr_sem);
> +
> +free_data:
> +       kfree(d);
> +out:
> +       nvmet_req_complete(req, status);
> +}
> +
> +u16 nvmet_pr_get_ns_pc_ref(struct nvmet_req *req)
> +{
> +       struct nvmet_pr_per_ctrl_ref *pc_ref;
> +
> +       pc_ref = xa_load(&req->ns->pr_per_ctrl_refs,
> +                       req->sq->ctrl->cntlid);
> +       if (unlikely(!percpu_ref_tryget_live(&pc_ref->ref)))
> +               return NVME_SC_INTERNAL;
> +       req->pc_ref = pc_ref;
> +       return NVME_SC_SUCCESS;
> +}
> +
> +static void nvmet_pr_ctrl_ns_all_cmds_done(struct percpu_ref *ref)
> +{
> +       struct nvmet_pr_per_ctrl_ref *pc_ref =
> +               container_of(ref, struct nvmet_pr_per_ctrl_ref, ref);
> +
> +       complete(&pc_ref->free_done);
> +}
> +
> +static int nvmet_pr_alloc_and_insert_pc_ref(struct nvmet_ns *ns,
> +                                           unsigned long idx,
> +                                           uuid_t *hostid)
> +{
> +       struct nvmet_pr_per_ctrl_ref *pc_ref;
> +       int ret;
> +
> +       pc_ref = kmalloc(sizeof(*pc_ref), GFP_ATOMIC);
> +       if (!pc_ref)
> +               return  -ENOMEM;
> +
> +       ret = percpu_ref_init(&pc_ref->ref, nvmet_pr_ctrl_ns_all_cmds_done,
> +                       PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
> +       if (ret)
> +               goto free;
> +
> +       init_completion(&pc_ref->free_done);
> +       init_completion(&pc_ref->confirm_done);
> +       uuid_copy(&pc_ref->hostid, hostid);
> +
> +       ret = xa_insert(&ns->pr_per_ctrl_refs, idx, pc_ref, GFP_KERNEL);
> +       if (ret)
> +               goto exit;
> +       return ret;
> +exit:
> +       percpu_ref_exit(&pc_ref->ref);
> +free:
> +       kfree(pc_ref);
> +       return ret;
> +}
> +
> +int nvmet_ctrl_init_pr(struct nvmet_ctrl *ctrl)
> +{
> +       struct nvmet_subsys *subsys = ctrl->subsys;
> +       struct nvmet_pr_per_ctrl_ref *pc_ref;
> +       struct nvmet_ns *ns = NULL;
> +       unsigned long idx;
> +       int ret;
> +
> +       ctrl->pr_log_mgr.counter = 0;
> +       ctrl->pr_log_mgr.lost_count = 0;
> +       mutex_init(&ctrl->pr_log_mgr.lock);
> +       INIT_KFIFO(ctrl->pr_log_mgr.log_queue);
> +
> +       /*
> +        * Here we are under subsys lock, if an ns not in subsys->namespaces,
> +        * we can make sure that ns is not enabled, and not call
> +        * nvmet_pr_init_ns(), see more details in nvmet_ns_enable().
> +        * So just check ns->pr.enable.
> +        */
> +       xa_for_each(&subsys->namespaces, idx, ns) {
> +               if (ns->pr.enable) {
> +                       ret = nvmet_pr_alloc_and_insert_pc_ref(ns, ctrl->cntlid,
> +                                                       &ctrl->hostid);
> +                       if (ret)
> +                               goto free_per_ctrl_refs;
> +               }
> +       }
> +       return 0;
> +
> +free_per_ctrl_refs:
> +       xa_for_each(&subsys->namespaces, idx, ns) {
> +               if (ns->pr.enable) {
> +                       pc_ref = xa_erase(&ns->pr_per_ctrl_refs, ctrl->cntlid);
> +                       if (pc_ref)
> +                               percpu_ref_exit(&pc_ref->ref);
> +                       kfree(pc_ref);
> +               }
> +       }
> +       return ret;
> +}
> +
> +void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl)
> +{
> +       struct nvmet_pr_per_ctrl_ref *pc_ref;
> +       struct nvmet_ns *ns;
> +       unsigned long idx;
> +
> +       kfifo_free(&ctrl->pr_log_mgr.log_queue);
> +       mutex_destroy(&ctrl->pr_log_mgr.lock);
> +
> +       xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
> +               if (ns->pr.enable) {
> +                       pc_ref = xa_erase(&ns->pr_per_ctrl_refs, ctrl->cntlid);
> +                       if (pc_ref)
> +                               percpu_ref_exit(&pc_ref->ref);
> +                       kfree(pc_ref);
> +               }
> +       }
> +}
> +
> +int nvmet_pr_init_ns(struct nvmet_ns *ns)
> +{
> +       struct nvmet_subsys *subsys = ns->subsys;
> +       struct nvmet_pr_per_ctrl_ref *pc_ref;
> +       struct nvmet_ctrl *ctrl = NULL;
> +       unsigned long idx;
> +       int ret;
> +
> +       ns->pr.holder = NULL;
> +       atomic_set(&ns->pr.generation, 0);
> +       sema_init(&ns->pr.pr_sem, 1);
> +       INIT_LIST_HEAD(&ns->pr.registrant_list);
> +       ns->pr.notify_mask = 0;
> +
> +       xa_init(&ns->pr_per_ctrl_refs);
> +
> +       list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +               ret = nvmet_pr_alloc_and_insert_pc_ref(ns, ctrl->cntlid,
> +                                               &ctrl->hostid);
> +               if (ret)
> +                       goto free_per_ctrl_refs;
> +       }
> +       return 0;
> +
> +free_per_ctrl_refs:
> +       xa_for_each(&ns->pr_per_ctrl_refs, idx, pc_ref) {
> +               xa_erase(&ns->pr_per_ctrl_refs, idx);
> +               percpu_ref_exit(&pc_ref->ref);
> +               kfree(pc_ref);
> +       }
> +       return ret;
> +}
> +
> +void nvmet_pr_exit_ns(struct nvmet_ns *ns)
> +{
> +       struct nvmet_pr_registrant *reg, *tmp;
> +       struct nvmet_pr_per_ctrl_ref *pc_ref;
> +       struct nvmet_pr *pr = &ns->pr;
> +       unsigned long idx;
> +
> +       list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
> +               list_del(&reg->entry);
> +               kfree(reg);
> +       }
> +
> +       xa_for_each(&ns->pr_per_ctrl_refs, idx, pc_ref) {
> +               /*
> +                * No command on ns here, we can safely free pc_ref.
> +                */
> +               pc_ref = xa_erase(&ns->pr_per_ctrl_refs, idx);
> +               percpu_ref_exit(&pc_ref->ref);
> +               kfree(pc_ref);
> +       }
> +
> +       xa_destroy(&ns->pr_per_ctrl_refs);
> +}
> --
> 2.43.0

BR,
 Dmitry

