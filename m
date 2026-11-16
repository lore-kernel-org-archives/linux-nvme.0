Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4909606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gfEeH+ur;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aBW17kY7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ki+lfelX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=znwH4v1y;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UoLu+QNi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Ahlta8N83pw3OBdlmXEoRisYO+FVEctaK/N7UlSdVQs=; b=gfEeH+urfXRg2/
	/3WFooRlp8Qskk8KjV8Xnxy2JLrTcTa7xFnuMuLyijp8pP79XrFwuXWZNVohogO9pG10kuN/GFU+X
	bXlsV4nb3cszC4CGmxElhBgxBPyskD9xNdONdYNJ6qnra5fgIk82oyRRDLmmO7RoHJZ6mJxMeYt7G
	uHhoJHUrlSPkhmHTC2Rl95ziEQ7LUEIvEoOBlvcBRUbW11bxDuiE5OuuP5gWjSJtgwp66O5O/R6gr
	0Ml4o1BmMy6lUawH1ip/8JRTCMS5oQq+8xdTe60jwI7gMVCfrX/RTvFQSjElerOYa7qhjxU8gm/+P
	G0Q1h51gILNxbszxnuwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrHS-00000001Q7q-1r7u;
	Mon, 16 Nov 2026 07:37:34 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrHP-00000001Q7L-2qef
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 07:37:33 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C8321FCF7;
	Mon, 16 Nov 2026 07:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794814649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ahlta8N83pw3OBdlmXEoRisYO+FVEctaK/N7UlSdVQs=;
	b=aBW17kY7a/SJCSAemer7aZE355RkEQctEDunQO45ULQgnFZ5l8V9V919uEtyxCBp8Wnt3s
	9iQ6n28HKkgtJTpVyBSRGX5rUEx4gyWaifGdvUOgVHehAugcCkgR/3S82TxASiN/qaslRy
	O5kDruzeHCUHG1qJ/pj1oOmjO8kMSYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794814649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ahlta8N83pw3OBdlmXEoRisYO+FVEctaK/N7UlSdVQs=;
	b=Ki+lfelX+5JRg1KRn5F4jKSlDXvkoXYYhq82spafRNZ4pP+JutQQ0WfnegpXuj+3tgweeF
	3SOVMmLJrvGolcCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=znwH4v1y;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UoLu+QNi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794814648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ahlta8N83pw3OBdlmXEoRisYO+FVEctaK/N7UlSdVQs=;
	b=znwH4v1yJ9EZYu/0cLfheLAW3yjQ6YBSc0RHIrCHOIde9VdJ60oqws3a+hypuLVTpLvIdQ
	s0Kb2OUL/CKfFFZhl+T3HHZHbwSiRJWqtqEqKzLnqyfK3zgUoYah6bT5fZvJkeLyDP/VPA
	dj9O4sKc4Zku+i8TDIWPqEzrZnbE690=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794814648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ahlta8N83pw3OBdlmXEoRisYO+FVEctaK/N7UlSdVQs=;
	b=UoLu+QNisU0gC/nj8ikOfX1gWh8R4Gfl8YpjaPVKn7AtAD6LSRjKydvwb9PqW3PckEsOFv
	uDWqHnZY/XkV1WBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0B0813408;
	Mon, 16 Nov 2026 07:37:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1uQWLbey+moEMgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Nov 2026 07:37:27 +0000
Message-ID: <0cec2aa3-62c2-411f-a51b-9a3f3d25820b@suse.de>
Date: Mon, 16 Nov 2026 08:37:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/17] nvme-fc: perform error recovery directly from
 ioerr_work
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>,
 Randy Jennings <randyj@purestorage.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-14-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261114030454.2836543-14-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,kernel.org,nvidia.com,purestorage.com,suse.de,lists.infradead.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,purestorage.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 5C8321FCF7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_233731_870892_36D31AEC 
X-CRM114-Status: GOOD (  31.33  )
X-Spam-Score: -4.4 (----)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/14/26 4:04 AM, Mohamed Khalfella wrote:
> Now that nvme_fc_start_ioerr_recovery() moves the controller to
> RESETTING before queueing ioerr_work, the nvme_reset_ctrl() call in
> nvme_fc_error_recovery() fails with -EBUSY and no recovery runs.
> 
> Do the recovery in the work itself instead: stop the keep-alive and
> the AEN submission, tear down the association so that any command a
> core work item is waiting on is aborted at once, stop the controller,
> move to CONNECTING and schedule a reconnect. If the CONNECTING
> transition fails the controller is being deleted and the delete path
> finishes the job. This is how rdma and tcp structure their error
> recovery too.
> 
> The work is only ever queued right after a successful transition to
> RESETTING, so when it runs it owns the controller: a reset or a
> firmware activation holding RESETTING cannot be in progress at the
> same time, and the work does not need to re-check the state.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/fc.c | 57 ++++++++++++++++--------------------------
>   1 file changed, 21 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index c4603be38144..0ba621649afe 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -229,6 +229,8 @@ static struct device *fc_udev_device;
>   static void nvme_fc_complete_rq(struct request *rq);
>   static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
>   					 char *errmsg);
> +static void __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl,
> +					    bool start_queues);
>   
>   /* *********************** FC-NVME Port Management ************************ */
>   
> @@ -987,7 +989,8 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>   static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
>   static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
>   
> -static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
> +static void nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl);
> +static void nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status);
>   
>   static void
>   __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
> @@ -1880,7 +1883,23 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
>   	struct nvme_fc_ctrl *ctrl =
>   			container_of(work, struct nvme_fc_ctrl, ioerr_work);
>   
> -	nvme_fc_error_recovery(ctrl, "transport detected io error");

Hmm. _Some_ message would be nice here.

> +	nvme_stop_keep_alive(&ctrl->ctrl);
> +	flush_work(&ctrl->ctrl.async_event_work);
> +
> +	/* will block while waiting for io to terminate */
> +	nvme_fc_delete_association(ctrl);
> +	nvme_stop_ctrl(&ctrl->ctrl);
> +
> +	/* Do not reconnect if controller is being deleted */
> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
> +		return;
Same here; it's the same condition than the original 
nvme_fc_error_recovery() checked for, so we should keep the
logging message.

> +
> +	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
> +		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
> +		return;
> +	}
> +
> +	nvme_fc_reconnect_or_delete(ctrl, -ENOTCONN);

And you can move this under the 'else' condition from the above
if-clause.

>   }
>   
>   /*
> @@ -2528,39 +2547,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
>   		nvme_unquiesce_admin_queue(&ctrl->ctrl);
>   }
>   
> -static void
> -nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
> -{
> -	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
> -
> -	/*
> -	 * if an error (io timeout, etc) while (re)connecting, the remote
> -	 * port requested terminating of the association (disconnect_ls)
> -	 * or an error (timeout or abort) occurred on an io while creating
> -	 * the controller.  Abort any ios on the association and let the
> -	 * create_association error path resolve things.
> -	 */
> -	if (state == NVME_CTRL_CONNECTING) {
> -		__nvme_fc_abort_outstanding_ios(ctrl, true);
> -		dev_warn(ctrl->ctrl.device,
> -			"NVME-FC{%d}: transport error during (re)connect\n",
> -			ctrl->cnum);
> -		return;
> -	}
> -
> -	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
> -	if (state != NVME_CTRL_LIVE)
> -		return;
> -
> -	dev_warn(ctrl->ctrl.device,
> -		"NVME-FC{%d}: transport association event: %s\n",
> -		ctrl->cnum, errmsg);
> -	dev_warn(ctrl->ctrl.device,
> -		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);
> -
> -	nvme_reset_ctrl(&ctrl->ctrl);
> -}
> -
>   static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
>   {
>   	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
> @@ -3399,7 +3385,6 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
>   	}
>   }
>   
> -
>   static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
>   	.name			= "fc",
>   	.module			= THIS_MODULE,

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

