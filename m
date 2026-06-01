Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E3CCD6E56
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 09:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zB+5U6nqOlRHrdhXowBHRIOIpTrrbNrhxpFYfIybrI0=; b=1WVIWfP0LhhlqvqgvO4Xadzwkk
	HEXolZA9tihEW1CZcIPcAJb9uP2bZOmttz9pbG/ScZ2XoAGRSoEwDLRifYqhhcFpGAXFoarrwfwQ6
	wVXQn4GkouLzDytTXB0ToinXnTa1oyes0V0T19/N7hg0cxV6wXyA6dz4izwShQaUM+Ih2JAdby+ce
	AcJo3fxYHfHPfZlJiuJhv8fju3W2XxjSNmKl8E3WFqwvepjbh/lKkqi7312/f/aWtc/naB1z/eF88
	5MgB/bmqD25vhqMeUXXmXaBl3QbvZ9wNcfOtswS0UKJ/0aW9mud+Oln7pYhXY0DojjZItO2V2oM8f
	1zqj8MGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTzEu-0000000AWOC-2ysH;
	Mon, 01 Jun 2026 09:47:20 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTzEr-0000000AWGs-2TNz
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 09:47:19 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40BC56B463;
	Mon,  1 Jun 2026 09:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780307234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zB+5U6nqOlRHrdhXowBHRIOIpTrrbNrhxpFYfIybrI0=;
	b=aSE9DufDdM4U9C8gW/qRBnT81W9x9ARRIHnRwzmPioFe2QFKk7VmoyjJLh/8N/bnx+CH3o
	l5xh/RW0soRYl/SP5IKSOCrTkvToQuxogPG9ozJj7x5isfGSwR1KZC+uw0UapxiVmz3Mve
	Vfkrnr6ojKvluuezcKsLt5Sh36PJQ74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780307234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zB+5U6nqOlRHrdhXowBHRIOIpTrrbNrhxpFYfIybrI0=;
	b=cUt+1En84S99BLvKzTeuXwzPjb77Yvtpa9m6Hs8t6IhY70U4P+XCtiXvmq8dg3i9w+tpRY
	HRSN32o9jsyiCxAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780307234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zB+5U6nqOlRHrdhXowBHRIOIpTrrbNrhxpFYfIybrI0=;
	b=aSE9DufDdM4U9C8gW/qRBnT81W9x9ARRIHnRwzmPioFe2QFKk7VmoyjJLh/8N/bnx+CH3o
	l5xh/RW0soRYl/SP5IKSOCrTkvToQuxogPG9ozJj7x5isfGSwR1KZC+uw0UapxiVmz3Mve
	Vfkrnr6ojKvluuezcKsLt5Sh36PJQ74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780307234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zB+5U6nqOlRHrdhXowBHRIOIpTrrbNrhxpFYfIybrI0=;
	b=cUt+1En84S99BLvKzTeuXwzPjb77Yvtpa9m6Hs8t6IhY70U4P+XCtiXvmq8dg3i9w+tpRY
	HRSN32o9jsyiCxAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E01C779A7;
	Mon,  1 Jun 2026 09:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jdmSCSJVHWoiYgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 01 Jun 2026 09:47:14 +0000
Date: Mon, 1 Jun 2026 11:47:13 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mlombard@arkamax.eu, mkhalfella@purestorage.com, 
	randyj@purestorage.com, hch@lst.de, linux-nvme@lists.infradead.org, emilne@redhat.com
Subject: Re: [PATCH 1/1] nvme-fc: Do not cancel requests in io target before
 it is initialized
Message-ID: <564f1396-dd4a-4246-931e-8541c8625211@flourine.local>
References: <20260528092734.258899-1-mlombard@redhat.com>
 <20260528092734.258899-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528092734.258899-2-mlombard@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_024717_785625_2946439C 
X-CRM114-Status: GOOD (  11.09  )
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

On Thu, May 28, 2026 at 11:27:34AM +0200, Maurizio Lombardi wrote:
> -	if (ctrl->ctrl.queue_count > 1) {
> +	if (ctrl->ctrl.queue_count > 1 && ctrl->ctrl.tagset) {
>  		nvme_quiesce_io_queues(&ctrl->ctrl);
>  		nvme_sync_io_queues(&ctrl->ctrl);
>  		blk_mq_tagset_busy_iter(&ctrl->tag_set,

Yes, that makes sense.

> @@ -2900,6 +2900,11 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
>  out_delete_hw_queues:
>  	nvme_fc_delete_hw_io_queues(ctrl);
>  out_cleanup_tagset:
> +	/*
> +	 * In CONNECTING state ctrl->ioerr_work will abort both admin
> +	 * and io tagsets. Cancel it first before removing io tagset.
> +	 */
> +	cancel_work_sync(&ctrl->ioerr_work);
>  	nvme_remove_io_tag_set(&ctrl->ctrl);
>  	nvme_fc_free_io_queues(ctrl);

Again, does makes sense but which tree is this based on? I don't see
this hunk in master or in nvme-7.2.

