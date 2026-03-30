Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD73FB3D17
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2026 10:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v5E8LeARa/w7TLsTlyPc6GeM4lRcAWk7XiN7P4LmW5Y=; b=eUQS9smSCCNJBbpTtz6/bNNuqm
	UGD8fcI56Gfh8EnxYGEtBn2wmIZi3ayqryRZk7VCoUtQ+fZ3Eo8DyMBSBtPN+bAmDKvlA+qsRvOeH
	LfrNgM3QpLMuMynFZBdaB8ySLnP3DzXR5pOfWuCysDbhBiePHIvx7nOdWMkegWNBvsjQK+IZlnJNn
	zUiq/gcFkXnUoaZGusn3D9UeKcBlMsfHsE+oL9URgm5TBJQo12uYpLtmbZJ4FtNSXa+R/qITTla+0
	gkmo16n+lcgb6zGuxkSUKhWlggasx4P8m9tkf1bns15eOUblDBw3R9op9Qc12y5EQGsvpbXCMKLhN
	R6TStsgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7A8A-0000000B5i4-2tJ6;
	Mon, 30 Mar 2026 10:46:02 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7A88-0000000B5hh-2BmO
	for linux-nvme@lists.infradead.org;
	Mon, 30 Mar 2026 10:46:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9BB4E5BD2D;
	Mon, 30 Mar 2026 10:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774867558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v5E8LeARa/w7TLsTlyPc6GeM4lRcAWk7XiN7P4LmW5Y=;
	b=ahLvF5S9ovtimZcI+DPFK7RYw2uyqo4DH7/O6AMVszgLWxMTJMsKjCLU2Srjumlb7dQLpD
	d9OX5k+6/hgdrrDSB8idgE1PMHNeMKz1PQniMKFvE0hVmx0OPxEWdl55ZR1MRj3Py5HaC/
	sVgjfyr6WNmgO2qs4ZqpmDsV1Uo++aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774867558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v5E8LeARa/w7TLsTlyPc6GeM4lRcAWk7XiN7P4LmW5Y=;
	b=nXkfrLSmqJ/2OzMaTAQhXjqXcZFHBjeMZtD8DsnFXFdEN1Xvo9d5ysiN+1ZDDtyIhiHzN7
	zUoN8GX+R6YKHzDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ahLvF5S9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nXkfrLSm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774867558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v5E8LeARa/w7TLsTlyPc6GeM4lRcAWk7XiN7P4LmW5Y=;
	b=ahLvF5S9ovtimZcI+DPFK7RYw2uyqo4DH7/O6AMVszgLWxMTJMsKjCLU2Srjumlb7dQLpD
	d9OX5k+6/hgdrrDSB8idgE1PMHNeMKz1PQniMKFvE0hVmx0OPxEWdl55ZR1MRj3Py5HaC/
	sVgjfyr6WNmgO2qs4ZqpmDsV1Uo++aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774867558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v5E8LeARa/w7TLsTlyPc6GeM4lRcAWk7XiN7P4LmW5Y=;
	b=nXkfrLSmqJ/2OzMaTAQhXjqXcZFHBjeMZtD8DsnFXFdEN1Xvo9d5ysiN+1ZDDtyIhiHzN7
	zUoN8GX+R6YKHzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 588544A0A2;
	Mon, 30 Mar 2026 10:45:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gAL0FGZUymmYcgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 30 Mar 2026 10:45:58 +0000
Message-ID: <204893dd-d256-4f37-955a-1fa724048021@suse.de>
Date: Mon, 30 Mar 2026 12:45:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/15] nvmet: Implement CCR nvme command
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260328004518.1729186-4-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260328004518.1729186-4-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,kernel.dk,kernel.org,grimberg.me];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 9BB4E5BD2D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260330_034600_880717_B58A957D 
X-CRM114-Status: GOOD (  26.31  )
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

On 3/28/26 01:43, Mohamed Khalfella wrote:
> Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
> Reset) command is an nvme command issued to source controller by
> initiator to reset impacted controller. Implement CCR command for linux
> nvme target.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/target/admin-cmd.c | 74 ++++++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c      | 76 +++++++++++++++++++++++++++++++++
>   drivers/nvme/target/nvmet.h     | 13 ++++++
>   include/linux/nvme.h            | 23 ++++++++++
>   4 files changed, 186 insertions(+)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index ec09e30eca18..0a37c0eeebb5 100644
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
> @@ -1613,6 +1615,75 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
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
> +	new_ccr = kmalloc_obj(*new_ccr, GFP_KERNEL);
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
> @@ -1690,6 +1761,9 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
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
> index e8b945a01f35..2e0c31d82bad 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -117,6 +117,20 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
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
> @@ -1399,6 +1413,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
>   	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
>   		ctrl->ciu = ((u8)(ctrl->ciu + 1)) ? : 1;
>   		ctrl->cirn = get_random_u64();
> +		nvmet_ctrl_cleanup_ccrs(ctrl, false);
>   	}
>   	ctrl->csts = NVME_CSTS_RDY;
>   
> @@ -1504,6 +1519,35 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
>   	return ctrl;
>   }
>   
> +struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
> +					   const char *hostnqn, u8 ciu,
> +					   u16 cntlid, u64 cirn)
> +{
> +	struct nvmet_ctrl *ctrl, *ictrl = NULL;
> +	bool found = false;
> +
> +	mutex_lock(&subsys->lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (ctrl->cntlid != cntlid)
> +			continue;
> +
> +		/* Avoid racing with a controller that is becoming ready */
> +		mutex_lock(&ctrl->lock);
> +		if (ctrl->ciu == ciu && ctrl->cirn == cirn)
> +			found = true;
> +		mutex_unlock(&ctrl->lock);
> +
> +		if (found) {
> +			if (kref_get_unless_zero(&ctrl->ref))
> +				ictrl = ctrl;
> +			break;
> +		}
> +	};
> +	mutex_unlock(&subsys->lock);
> +
> +	return ictrl;
> +}
> +
>   u16 nvmet_check_ctrl_status(struct nvmet_req *req)
>   {
>   	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
> @@ -1629,6 +1673,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>   		subsys->clear_ids = 1;
>   #endif
>   
> +	INIT_LIST_HEAD(&ctrl->ccr_list);
>   	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
>   	INIT_LIST_HEAD(&ctrl->async_events);
>   	INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
> @@ -1739,12 +1784,43 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>   }
>   EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
>   
> +static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
> +{
> +	struct nvmet_subsys *subsys = ctrl->subsys;
> +	struct nvmet_ctrl *sctrl;
> +	struct nvmet_ccr *ccr;
> +
> +	lockdep_assert_held(&subsys->lock);
> +
> +	/* Cleanup all CCRs issued by ctrl as source controller */
> +	mutex_lock(&ctrl->lock);
> +	nvmet_ctrl_cleanup_ccrs(ctrl, true);
> +	mutex_unlock(&ctrl->lock);
> +
> +	/*
> +	 * Find all CCRs targeting ctrl as impacted controller and
> +	 * set ccr->ctrl to NULL. This tells the source controller
> +	 * that CCR completed successfully.
> +	 */
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

Do I see this correct that with this implementation a CCR is only 
complete once the controller resets? IOW the CCR has to wait for
the controller to be reset, but it does not invoke a controller reset
itself?

Is that intended?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

