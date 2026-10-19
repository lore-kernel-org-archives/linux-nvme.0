Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450F5606AF91
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rJXUTpur;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oV77sMda;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3Xapmkwr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oV77sMda;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3Xapmkwr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xh6PJJlV875LKrbewHDu4bmlG53O8CsIX2VAY6YWyNo=; b=rJXUTpurOpzjNo6PZJ8tMe5R9g
	hA4XCigDp6rMeb3dpSTtQid28dyPix87os5pOLMsAQOUREsgEYTkoBeVqHya1segtKYElXLcY7r6K
	JBYRuSJoSbD8BbFw3mod1KHBk0y5+dP7hW3dKeQ74Ap78ZpowSiYv1/yLwuv5Vmsth7kq3XR5FrId
	MpQ0itKlHlBoHuMuO7yfcpICzIaUhKvGiW1jJGW+LB2slFlz+dtGJ83fZ6SPc/kxdKu7fJ4dYniYP
	n1C9wyPL9qXhKVKhatHBjdEuZ4xO4CqDh1tU7XBg/dB6Ik4UC08prvT4R0cZAL80aNWzdgAPS4ZOM
	0X4Xt29A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIpmX-00000007ujo-3SJo;
	Mon, 19 Oct 2026 16:00:13 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIpmV-00000007uii-0wNL
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 16:00:12 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8283E21CF9;
	Mon, 19 Oct 2026 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792425609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xh6PJJlV875LKrbewHDu4bmlG53O8CsIX2VAY6YWyNo=;
	b=oV77sMdaONFdoQfC+DNxIvq3EWEHRGfbQdCllc6m8gHKDSa1X7aHbhsNa4T62S7f8rpRTK
	+i03UjZrPFEdLLZvVC4C+8mrZGREP5E1pkxEWfXtUdyKQ2weg5lv//Mok+z3NSc96NahqC
	nvqwnLOM6VNuzvFkj50PGtgnAtl4e7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792425609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xh6PJJlV875LKrbewHDu4bmlG53O8CsIX2VAY6YWyNo=;
	b=3Xapmkwr4z9uH/PDkeyI1mFfbK6bIa9VeeUi++zNooUai8532BVHV3tW2QwNUA6KDDg3ft
	tZvO7bu0iakAu9DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oV77sMda;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3Xapmkwr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792425609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xh6PJJlV875LKrbewHDu4bmlG53O8CsIX2VAY6YWyNo=;
	b=oV77sMdaONFdoQfC+DNxIvq3EWEHRGfbQdCllc6m8gHKDSa1X7aHbhsNa4T62S7f8rpRTK
	+i03UjZrPFEdLLZvVC4C+8mrZGREP5E1pkxEWfXtUdyKQ2weg5lv//Mok+z3NSc96NahqC
	nvqwnLOM6VNuzvFkj50PGtgnAtl4e7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792425609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xh6PJJlV875LKrbewHDu4bmlG53O8CsIX2VAY6YWyNo=;
	b=3Xapmkwr4z9uH/PDkeyI1mFfbK6bIa9VeeUi++zNooUai8532BVHV3tW2QwNUA6KDDg3ft
	tZvO7bu0iakAu9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47F20134B3;
	Mon, 19 Oct 2026 16:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rdRvCYk+1moLSwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 19 Oct 2026 16:00:09 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 03/18] nvmet: Implement CCR nvme command
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Justin Tee <justin.tee@broadcom.com>, 
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
 Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260920182936.2317916-4-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-4-mkhalfella@purestorage.com>
Date: Mon, 19 Oct 2026 18:00:01 +0200
Message-Id: <179242560183.3619480.12432335570480465347.b4-review@b4>
X-Mailer: b4 0.16.0
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org,suse.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: 8283E21CF9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_090011_415422_AED455DE 
X-CRM114-Status: GOOD (  16.09  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> +void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
> +{
> +	struct nvmet_ctrl *ictrl, *sctrl = req->sq->ctrl;
> +	struct nvme_command *cmd = req->cmd;
> +	struct nvmet_ccr *ccr, *new_ccr;
> +	int ccr_active, ccr_total;
> +	u16 cntlid, status = NVME_SC_SUCCESS;
> +
> +	if (!nvmet_check_transfer_len(req, 0))
> +		return;
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

nvmet_ctrl_fatal_error will log an error, is this desired?

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
> +		if (strncmp(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE))
> +			continue;
> +
> +		/* Avoid racing with a controller that is becoming ready */

I think this comment could a bit more eleborate, it took me a while
to figure out the impact of it. What about something like:

                /*
                 * Enabling the controller (nvmet_start_ctrl()) regenerates
                 * ciu and cirn under ctrl->lock. Hold the lock so that a
                 * controller becoming ready concurrently is matched against
                 * either the old or the new instance, never a mix of both.
                 *
                 * CSTS.RDY is not checked on purpose: a disabled controller
                 * can still have commands in flight, so a matching instance
                 * must go through the CCR path rather than being reported as
                 * already reset.
                 */

-- 
Daniel Wagner <wagi@kernel.org>

