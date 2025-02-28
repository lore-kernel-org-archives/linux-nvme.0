Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A91EC19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 07:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Or88AIhb6LQklMGUedSdIR+3YxZ40XHoN6SmMnb8kw=; b=ToLNNdKv7/nPR03PvzNtTXi4C3
	i6kX+wUTl3mir0ZXQ/Apr9hY9cAjFqueQU2voz1keYb9+/KsuJYBsdcx8k6l5fA8CnY+lrFI6HmwG
	E9wihlDD5u825RTp0auXDekIcgBepCCEILo7/OR0TWlYu5ZUHKJotg9LuEJ+HnJXNYsT/H56IrpWG
	Wb5mqs26qfVlaWlygdwntAZDiaEzicKFJ7+HyiUjp/hhs/OzSnijYfNjX8QFgnpRNbOsRYZK0NpqU
	jWHv5ltchnwOoEKhkDKbs8Ec3fSQ3vM22HIulcb1yGUr+jo9CjetcU+4bL7NFvWQq5PnH5ihfc79Z
	gHgwyqrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnuuW-0000000A16V-2kwv;
	Fri, 28 Feb 2025 07:35:52 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnuuU-0000000A15j-0Tuo
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 07:35:51 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84C451F38F;
	Fri, 28 Feb 2025 07:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740728148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Or88AIhb6LQklMGUedSdIR+3YxZ40XHoN6SmMnb8kw=;
	b=RvDTk5Xk1dK6xGp+0OasjPJVzr/FrmE4X5kI/ERuG3MsZiOcBMtbaGKXkqQVcEMRx3xg57
	PQzamWb7TwQnu0I9li+s7iDOJMOuyHepesXP5Ls+s5y1VQg4tAEqTFrOmzy1BcpewG1QJu
	/M4dPuFc8uOAKf+Sl+Qv3b9KBg76r0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740728148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Or88AIhb6LQklMGUedSdIR+3YxZ40XHoN6SmMnb8kw=;
	b=iIOVL3zgEj6QohM6gI/r+YJgnidKVedKrYsrzbF9RpD1a3SAyWh3NrF244Kdy8aXBOuFP5
	7l2EfxAQ0+oHsyBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RvDTk5Xk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iIOVL3zg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740728148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Or88AIhb6LQklMGUedSdIR+3YxZ40XHoN6SmMnb8kw=;
	b=RvDTk5Xk1dK6xGp+0OasjPJVzr/FrmE4X5kI/ERuG3MsZiOcBMtbaGKXkqQVcEMRx3xg57
	PQzamWb7TwQnu0I9li+s7iDOJMOuyHepesXP5Ls+s5y1VQg4tAEqTFrOmzy1BcpewG1QJu
	/M4dPuFc8uOAKf+Sl+Qv3b9KBg76r0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740728148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Or88AIhb6LQklMGUedSdIR+3YxZ40XHoN6SmMnb8kw=;
	b=iIOVL3zgEj6QohM6gI/r+YJgnidKVedKrYsrzbF9RpD1a3SAyWh3NrF244Kdy8aXBOuFP5
	7l2EfxAQ0+oHsyBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FF21137AC;
	Fri, 28 Feb 2025 07:35:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kYnICVRnwWfJJwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Feb 2025 07:35:48 +0000
Message-ID: <5ad20030-6e88-4fd1-8d2f-0093283ce8c7@suse.de>
Date: Fri, 28 Feb 2025 08:35:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] nvmet-fc: free pending reqs on tgtport unregister
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-9-c0bd83d43e6a@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226-nvmet-fcloop-v1-9-c0bd83d43e6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 84C451F38F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_233550_299928_81135991 
X-CRM114-Status: GOOD (  21.04  )
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

On 2/26/25 19:46, Daniel Wagner wrote:
> When nvmet_fc_unregister_targetport is called by the LLDD, it's not
> possible to communicate with the host, thus all pending request will not
> be process. Thus explicitly free them.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fc.c | 39 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 391917b4ce0115dbc0ad99d1fb363b1af6ee0685..a5f7cb18ac9f49e41626e1c9a031c3cc830af9ba 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1610,6 +1610,37 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
>   	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
>   }
>   
> +static void
> +nvmet_fc_free_pending_reqs(struct nvmet_fc_tgtport *tgtport)
> +{
> +	struct nvmet_fc_ls_req_op *lsop;
> +	struct nvmefc_ls_req *lsreq;
> +
> +	/*
> +	 * After this point the connection is lost and thus any pending
> +	 * request can't be processed by the normal completion path. This
> +	 * is likely a request from nvmet_fc_send_ls_req_async.
> +	 */
> +	for (;;) {
> +		lsop = list_first_entry_or_null(&tgtport->ls_req_list,
> +						struct nvmet_fc_ls_req_op,
> +						lsreq_list);
> +		if (!lsop)
> +			break;
> +
> +		list_del(&lsop->lsreq_list);
> +
> +		if (!lsop->req_queued)
> +			continue;
> +
> +		lsreq = &lsop->ls_req;
> +		fc_dma_unmap_single(tgtport->dev, lsreq->rqstdma,
> +				    (lsreq->rqstlen + lsreq->rsplen),
> +				    DMA_BIDIRECTIONAL);
> +		nvmet_fc_tgtport_put(tgtport);
> +	}
> +}
> +
>   /**
>    * nvmet_fc_unregister_targetport - transport entry point called by an
>    *                              LLDD to deregister/remove a previously
> @@ -1633,13 +1664,7 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
>   
>   	flush_workqueue(nvmet_wq);
>   
> -	/*
> -	 * should terminate LS's as well. However, LS's will be generated
> -	 * at the tail end of association termination, so they likely don't
> -	 * exist yet. And even if they did, it's worthwhile to just let
> -	 * them finish and targetport ref counting will clean things up.
> -	 */
> -
> +	nvmet_fc_free_pending_reqs(tgtport);
>   	nvmet_fc_tgtport_put(tgtport);
>   
>   	return 0;
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

