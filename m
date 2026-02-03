Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24377E83047
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 03:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jD93p9PbofhUPahCvCCoyKCv9XPqegoVegjypikEILM=; b=2Oem+bujJ6RWkBuYdOJqU4Whsb
	gIJWCkeldmbZp/GYjVOclOxU3PDpjNTcReqTf7wpYSHdF0tB4Tf496GCZlc/a0VnOCPSdyIn6Xcms
	RNpa97MkXsjbQhmgwv01h1a7/XLicckibqreCznuVNT4/JaWMwT8kws2DSZba9HB4wZxB5QHJ/Er3
	/UFnSbHI+kx1zEo5Tp8CH7kIPfwWmSwCx03EZxg8DBcCEJs8PAe8pG6LE4J/uJ8e4HWlomnB5lMwP
	YxE7un+I8QGgjwscFP8DXlZRyUeq/SQVkzILaWEx7w9NOlHBugls+0HV7mbdMC0/mR8KuGOUiv5cU
	g3whBjkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn6xX-00000005zSA-31oI;
	Tue, 03 Feb 2026 03:20:11 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn6xU-00000005zQS-31Ee
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 03:20:10 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 865F75BCC3;
	Tue,  3 Feb 2026 03:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770088806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jD93p9PbofhUPahCvCCoyKCv9XPqegoVegjypikEILM=;
	b=BArumtqrxUAD19MFhKsqQKlxWWM6P+7qhyOTLTTK0s4XRcEY2QAaskN5g8ST1nlcWX0NeK
	RzoqoyArIaDxw4z3Hf+3yLkadPhV//wgl/t0JCCrC0ZxxG2yLxsq803dkiiwOiFTiXKprA
	+7kRA/HGxm4lgNDlx1aBOX2enCcD4QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770088806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jD93p9PbofhUPahCvCCoyKCv9XPqegoVegjypikEILM=;
	b=uY0ft3Ldl7IL45ygwOlqBtYkbxvrLLCivvxZMGYNPyMEQmIvVGrOpO4Qfsak5md+D3i/uV
	GF6NVPAD5XtpF7Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BArumtqr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uY0ft3Ld
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770088806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jD93p9PbofhUPahCvCCoyKCv9XPqegoVegjypikEILM=;
	b=BArumtqrxUAD19MFhKsqQKlxWWM6P+7qhyOTLTTK0s4XRcEY2QAaskN5g8ST1nlcWX0NeK
	RzoqoyArIaDxw4z3Hf+3yLkadPhV//wgl/t0JCCrC0ZxxG2yLxsq803dkiiwOiFTiXKprA
	+7kRA/HGxm4lgNDlx1aBOX2enCcD4QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770088806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jD93p9PbofhUPahCvCCoyKCv9XPqegoVegjypikEILM=;
	b=uY0ft3Ldl7IL45ygwOlqBtYkbxvrLLCivvxZMGYNPyMEQmIvVGrOpO4Qfsak5md+D3i/uV
	GF6NVPAD5XtpF7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 693663EA62;
	Tue,  3 Feb 2026 03:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QU/dCGFpgWlHeAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Feb 2026 03:20:01 +0000
Message-ID: <77a00fa1-5707-4859-8a7a-e823ca18c9fe@suse.de>
Date: Tue, 3 Feb 2026 04:19:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] nvmet: Implement CCR nvme command
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-4-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260130223531.2478849-4-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email]
X-Rspamd-Queue-Id: 865F75BCC3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_192009_091135_34CCF4D4 
X-CRM114-Status: GOOD (  26.86  )
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

On 1/30/26 23:34, Mohamed Khalfella wrote:
> Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
> Reset) command is an nvme command issued to source controller by
> initiator to reset impacted controller. Implement CCR command for linux
> nvme target.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/target/admin-cmd.c | 74 +++++++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c      | 71 +++++++++++++++++++++++++++++++
>   drivers/nvme/target/nvmet.h     | 13 ++++++
>   include/linux/nvme.h            | 23 ++++++++++
>   4 files changed, 181 insertions(+)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index ade1145df72d..c0fd8eca2e44 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -376,7 +376,9 @@ static void nvmet_get_cmd_effects_admin(struct nvmet_ctrl *ctrl,
>   	log->acs[nvme_admin_get_features] =
>   	log->acs[nvme_admin_async_event] =
>   	log->acs[nvme_admin_keep_alive] =
> +	log->acs[nvme_admin_cross_ctrl_reset] =
>   		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
> +
>   }
>   
>   static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
> @@ -1615,6 +1617,75 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
>   	nvmet_req_complete(req, status);
>   }
>   
> +void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
> +{
> +	struct nvmet_ctrl *ictrl, *sctrl = req->sq->ctrl;
> +	struct nvme_command *cmd = req->cmd;
> +	struct nvmet_ccr *ccr, *new_ccr;
> +	int ccr_active, ccr_total;
> +	u16 cntlid, status = NVME_SC_SUCCESS;
> +
> +	cntlid = le16_to_cpu(cmd->ccr.icid);
> +	if (sctrl->cntlid == cntlid) {
> +		req->error_loc =
> +			offsetof(struct nvme_cross_ctrl_reset_cmd, icid);
> +		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +		goto out;
> +	}
> +
> +	/* Find and get impacted controller */
> +	ictrl = nvmet_ctrl_find_get_ccr(sctrl->subsys, sctrl->hostnqn,
> +					cmd->ccr.ciu, cntlid,
> +					le64_to_cpu(cmd->ccr.cirn));
> +	if (!ictrl) {
> +		/* Immediate Reset Successful */
> +		nvmet_set_result(req, 1);
> +		status = NVME_SC_SUCCESS;
> +		goto out;
> +	}
> +
> +	ccr_total = ccr_active = 0;
> +	mutex_lock(&sctrl->lock);
> +	list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
> +		if (ccr->ctrl == ictrl) {
> +			status = NVME_SC_CCR_IN_PROGRESS | NVME_STATUS_DNR;
> +			goto out_unlock;
> +		}
> +
> +		ccr_total++;
> +		if (ccr->ctrl)
> +			ccr_active++;
> +	}
> +
> +	if (ccr_active >= NVMF_CCR_LIMIT) {
> +		status = NVME_SC_CCR_LIMIT_EXCEEDED;
> +		goto out_unlock;
> +	}
> +	if (ccr_total >= NVMF_CCR_PER_PAGE) {
> +		status = NVME_SC_CCR_LOGPAGE_FULL;
> +		goto out_unlock;
> +	}
> +
> +	new_ccr = kmalloc(sizeof(*new_ccr), GFP_KERNEL);
> +	if (!new_ccr) {
> +		status = NVME_SC_INTERNAL;
> +		goto out_unlock;
> +	}
> +
> +	new_ccr->ciu = cmd->ccr.ciu;
> +	new_ccr->icid = cntlid;
> +	new_ccr->ctrl = ictrl;
> +	list_add_tail(&new_ccr->entry, &sctrl->ccr_list);
> +
> +out_unlock:
> +	mutex_unlock(&sctrl->lock);
> +	if (status == NVME_SC_SUCCESS)
> +		nvmet_ctrl_fatal_error(ictrl);
> +	nvmet_ctrl_put(ictrl);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
>   u32 nvmet_admin_cmd_data_len(struct nvmet_req *req)
>   {
>   	struct nvme_command *cmd = req->cmd;
> @@ -1692,6 +1763,9 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
>   	case nvme_admin_keep_alive:
>   		req->execute = nvmet_execute_keep_alive;
>   		return 0;
> +	case nvme_admin_cross_ctrl_reset:
> +		req->execute = nvmet_execute_cross_ctrl_reset;
> +		return 0;
>   	default:
>   		return nvmet_report_invalid_opcode(req);
>   	}
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 0d2a1206e08f..54dd0dcfa12b 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -114,6 +114,20 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
>   	return 0;
>   }
>   
> +void nvmet_ctrl_cleanup_ccrs(struct nvmet_ctrl *ctrl, bool all)
> +{
> +	struct nvmet_ccr *ccr, *tmp;
> +
> +	lockdep_assert_held(&ctrl->lock);
> +
> +	list_for_each_entry_safe(ccr, tmp, &ctrl->ccr_list, entry) {
> +		if (all || ccr->ctrl == NULL) {
> +			list_del(&ccr->entry);
> +			kfree(ccr);
> +		}
> +	}
> +}
> +
>   static u32 nvmet_max_nsid(struct nvmet_subsys *subsys)
>   {
>   	struct nvmet_ns *cur;
> @@ -1396,6 +1410,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
>   	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
>   		ctrl->ciu = ((u8)(ctrl->ciu + 1)) ? : 1;
>   		ctrl->cirn = get_random_u64();
> +		nvmet_ctrl_cleanup_ccrs(ctrl, false);
>   	}
>   	ctrl->csts = NVME_CSTS_RDY;
>   
> @@ -1501,6 +1516,38 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
>   	return ctrl;
>   }
>   
> +struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
> +					   const char *hostnqn, u8 ciu,
> +					   u16 cntlid, u64 cirn)
> +{
> +	struct nvmet_ctrl *ctrl;
> +	bool found = false;
> +
> +	mutex_lock(&subsys->lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (ctrl->cntlid != cntlid)
> +			continue;
> +		if (strncmp(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE))
> +			continue;
> +
Why do we compare the hostnqn here, too? To my understanding the host 
NQN is tied to the controller, so the controller ID should be sufficient
here.

> +		/* Avoid racing with a controller that is becoming ready */
> +		mutex_lock(&ctrl->lock);
> +		if (ctrl->ciu == ciu && ctrl->cirn == cirn)
> +			found = true;
> +		mutex_unlock(&ctrl->lock);
> +
> +		if (found) {
> +			if (kref_get_unless_zero(&ctrl->ref))
> +				goto out;
> +			break;
> +		}
> +	};
> +	ctrl = NULL;
> +out:
> +	mutex_unlock(&subsys->lock);
> +	return ctrl;
> +}
> +
>   u16 nvmet_check_ctrl_status(struct nvmet_req *req)
>   {
>   	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
> @@ -1626,6 +1673,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>   		subsys->clear_ids = 1;
>   #endif
>   
> +	INIT_LIST_HEAD(&ctrl->ccr_list);
>   	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
>   	INIT_LIST_HEAD(&ctrl->async_events);
>   	INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
> @@ -1740,12 +1788,35 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>   }
>   EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
>   
> +static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
> +{
> +	struct nvmet_subsys *subsys = ctrl->subsys;
> +	struct nvmet_ctrl *sctrl;
> +	struct nvmet_ccr *ccr;
> +
> +	mutex_lock(&ctrl->lock);
> +	nvmet_ctrl_cleanup_ccrs(ctrl, true);
> +	mutex_unlock(&ctrl->lock);
> +
> +	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
> +		mutex_lock(&sctrl->lock);
> +		list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
> +			if (ccr->ctrl == ctrl) {
> +				ccr->ctrl = NULL;
> +				break;
> +			}
> +		}
> +		mutex_unlock(&sctrl->lock);
> +	}
> +}
> +

Maybe add documentation here that the first CCR cleanup is for clearing
CCRs issued from this controller, and the second is for CCRs issued _to_
this controller.

>   static void nvmet_ctrl_free(struct kref *ref)
>   {
>   	struct nvmet_ctrl *ctrl = container_of(ref, struct nvmet_ctrl, ref);
>   	struct nvmet_subsys *subsys = ctrl->subsys;
>   
>   	mutex_lock(&subsys->lock);
> +	nvmet_ctrl_complete_pending_ccr(ctrl);
>   	nvmet_ctrl_destroy_pr(ctrl);
>   	nvmet_release_p2p_ns_map(ctrl);
>   	list_del(&ctrl->subsys_entry);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index f5d9a01ec60c..93d6ac41cf85 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -269,6 +269,7 @@ struct nvmet_ctrl {
>   	u32			kato;
>   	u64			cirn;
>   
> +	struct list_head	ccr_list;
>   	struct nvmet_port	*port;
>   
>   	u32			aen_enabled;
> @@ -315,6 +316,13 @@ struct nvmet_ctrl {
>   	struct nvmet_pr_log_mgr pr_log_mgr;
>   };
>   
> +struct nvmet_ccr {
> +	struct nvmet_ctrl	*ctrl;
> +	struct list_head	entry;
> +	u16			icid;
> +	u8			ciu;
> +};
> +
>   struct nvmet_subsys {
>   	enum nvme_subsys_type	type;
>   
> @@ -578,6 +586,7 @@ void nvmet_req_free_sgls(struct nvmet_req *req);
>   void nvmet_execute_set_features(struct nvmet_req *req);
>   void nvmet_execute_get_features(struct nvmet_req *req);
>   void nvmet_execute_keep_alive(struct nvmet_req *req);
> +void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req);
>   
>   u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid, bool create);
>   u16 nvmet_check_io_cqid(struct nvmet_ctrl *ctrl, u16 cqid, bool create);
> @@ -620,6 +629,10 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args);
>   struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
>   				       const char *hostnqn, u16 cntlid,
>   				       struct nvmet_req *req);
> +struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
> +					   const char *hostnqn, u8 ciu,
> +					   u16 cntlid, u64 cirn);
> +void nvmet_ctrl_cleanup_ccrs(struct nvmet_ctrl *ctrl, bool all);
>   void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
>   u16 nvmet_check_ctrl_status(struct nvmet_req *req);
>   ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 5135cdc3c120..0f305b317aa3 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -23,6 +23,7 @@
>   
>   #define NVMF_CQT_MS		0
>   #define NVMF_CCR_LIMIT		4
> +#define NVMF_CCR_PER_PAGE	511
>   
>   #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
>   
> @@ -1225,6 +1226,22 @@ struct nvme_zone_mgmt_recv_cmd {
>   	__le32			cdw14[2];
>   };
>   
> +struct nvme_cross_ctrl_reset_cmd {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__le32			nsid;
> +	__le64			rsvd2[2];
> +	union nvme_data_ptr	dptr;
> +	__u8			rsvd10;
> +	__u8			ciu;
> +	__le16			icid;
> +	__le32			cdw11;
> +	__le64			cirn;
> +	__le32			cdw14;
> +	__le32			cdw15;
> +};
> +
>   struct nvme_io_mgmt_recv_cmd {
>   	__u8			opcode;
>   	__u8			flags;

I would have expected this definitions in the
first patch. But probably not that important.

> @@ -1323,6 +1340,7 @@ enum nvme_admin_opcode {
>   	nvme_admin_virtual_mgmt		= 0x1c,
>   	nvme_admin_nvme_mi_send		= 0x1d,
>   	nvme_admin_nvme_mi_recv		= 0x1e,
> +	nvme_admin_cross_ctrl_reset	= 0x38,
>   	nvme_admin_dbbuf		= 0x7C,
>   	nvme_admin_format_nvm		= 0x80,
>   	nvme_admin_security_send	= 0x81,
> @@ -1356,6 +1374,7 @@ enum nvme_admin_opcode {
>   		nvme_admin_opcode_name(nvme_admin_virtual_mgmt),	\
>   		nvme_admin_opcode_name(nvme_admin_nvme_mi_send),	\
>   		nvme_admin_opcode_name(nvme_admin_nvme_mi_recv),	\
> +		nvme_admin_opcode_name(nvme_admin_cross_ctrl_reset),	\
>   		nvme_admin_opcode_name(nvme_admin_dbbuf),		\
>   		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
>   		nvme_admin_opcode_name(nvme_admin_security_send),	\
> @@ -2009,6 +2028,7 @@ struct nvme_command {
>   		struct nvme_dbbuf dbbuf;
>   		struct nvme_directive_cmd directive;
>   		struct nvme_io_mgmt_recv_cmd imr;
> +		struct nvme_cross_ctrl_reset_cmd ccr;
>   	};
>   };
>   
> @@ -2173,6 +2193,9 @@ enum {
>   	NVME_SC_PMR_SAN_PROHIBITED	= 0x123,
>   	NVME_SC_ANA_GROUP_ID_INVALID	= 0x124,
>   	NVME_SC_ANA_ATTACH_FAILED	= 0x125,
> +	NVME_SC_CCR_IN_PROGRESS		= 0x13f,
> +	NVME_SC_CCR_LOGPAGE_FULL	= 0x140,
> +	NVME_SC_CCR_LIMIT_EXCEEDED	= 0x141,
>   
>   	/*
>   	 * I/O Command Set Specific - NVM commands:

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

