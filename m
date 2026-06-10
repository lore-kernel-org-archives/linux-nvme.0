Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D69CD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 11:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IrOyckYWKkxD6I1B3I18ppD9vOxVfSqzvArf4qIqMr4=; b=dqKCE5fdcA1iOM+fPkhORvLZ3z
	CiVJrv+pjPTCr14jKMwFPqUikDwZZ4b1Fg4Vu81qiNchfwmzC2+de/k4+WxqtF4HoCtipp8uX9fBB
	tZ0LXNkAnbJezczLN5Xtcp4jYlbM9YwD8L4j+YGg8V6+Tjg1X8d0Pxwtj3ctwuOVO7R5FEka5bKAt
	QfTwfZTxOhOuAlOHl+PryUlZK96Be+GlAWRl04KCo+2CUO9vxenBZWXyMIC1v7weTA/ezhysV87Vf
	Vu8pzM9F8WNKf37qbygynRnOokYfk0I1SpYTE9/KvpbsAB/WbHu1xBAiPzjmR19vJl9Ws11SnvJ3h
	0roGPeaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXHDU-00000007YI0-27dS;
	Wed, 10 Jun 2026 11:35:28 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXHDR-00000007YHQ-39Hn
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 11:35:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D646975942;
	Wed, 10 Jun 2026 11:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781091324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrOyckYWKkxD6I1B3I18ppD9vOxVfSqzvArf4qIqMr4=;
	b=mU17d8vuo3/B2rhFveTIH8QZnzyvjPsG/tOf18Ht2BfaZtA3R+AsOBWta2MRfV7LFUEhvT
	AnfUhe1hVM5nL/EFbTQDFt7MP2r9q6I/akjyH7xVPl03iX+AQ+0T7o0ooYHHtvwgeLIFcm
	LqzsH1tYP0P2bT9WXc881iCmYRINc+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781091324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrOyckYWKkxD6I1B3I18ppD9vOxVfSqzvArf4qIqMr4=;
	b=96qrAoI3yzO0N5JQ/ZNykkacUKAPXwqM3lzQpCuP2XiCAr36LL8kjtkBhVZOvoz+o42gLi
	QEKYa5k4YTK5p+DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MYvnbNtF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=68Yyhlk2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781091323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrOyckYWKkxD6I1B3I18ppD9vOxVfSqzvArf4qIqMr4=;
	b=MYvnbNtFXqUhJc3VtPgvu27JaYpiRCfdc1pIJKnc2YQkri+roVfydMXuEgHAxi/MxIkqZB
	JXy99e/eAjpdwkuZxoY+amJZOTP2rJWiHtzCeK0F+mUy+bCzHOkDxLqSXlPTP3sWweUtMz
	wHGdkq5nUPn2P1q0s2hmI1TfTUk7ErI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781091323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrOyckYWKkxD6I1B3I18ppD9vOxVfSqzvArf4qIqMr4=;
	b=68Yyhlk2aRuU44/bGOyW73QXRfNA0AGYoiLflMYiZ9oiVZLIB0HCFrpjWJwvuj+XOfxalI
	zWrIu+byp6SHQTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB8E7779A7;
	Wed, 10 Jun 2026 11:35:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uU9FKftLKWpMNwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Jun 2026 11:35:23 +0000
Message-ID: <9f85e335-4a5c-49f5-b5e3-f52237701689@suse.de>
Date: Wed, 10 Jun 2026 13:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme-fc: Do not cancel requests in io target before
 it is initialized
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mlombard@arkamax.eu, mkhalfella@purestorage.com, randyj@purestorage.com,
 hch@lst.de, linux-nvme@lists.infradead.org, dwagner@suse.de,
 emilne@redhat.com
References: <20260528092734.258899-1-mlombard@redhat.com>
 <20260528092734.258899-2-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260528092734.258899-2-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D646975942
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_043525_946522_DCE805B2 
X-CRM114-Status: GOOD (  14.52  )
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

On 5/28/26 11:27, Maurizio Lombardi wrote:
> From: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> A new nvme-fc controller in CONNECTING state sees admin request timeout
> schedules ctrl->ioerr_work to abort inflight requests. This ends up
> calling __nvme_fc_abort_outstanding_ios() which aborts requests in both
> admin and io tagsets. In case fc_ctrl->tag_set was not initialized we
> see the warning below. This is because ctrl.queue_count is initialized
> early in nvme_fc_alloc_ctrl().
> 
> nvme nvme0: NVME-FC{0}: starting error recovery Connectivity Loss
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> lpfc 0000:ab:00.0: queue 0 connect admin queue failed (-6).
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> Workqueue: nvme-reset-wq nvme_fc_ctrl_ioerr_work [nvme_fc]
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x57/0x80
>   register_lock_class+0x567/0x580
>   __lock_acquire+0x330/0xb90
>   lock_acquire.part.0+0xad/0x210
>   blk_mq_tagset_busy_iter+0xf9/0xc00
>   __nvme_fc_abort_outstanding_ios+0x23f/0x320 [nvme_fc]
>   nvme_fc_ctrl_ioerr_work+0x172/0x210 [nvme_fc]
>   process_one_work+0x82c/0x1450
>   worker_thread+0x5ee/0xfd0
>   kthread+0x3a0/0x750
>   ret_from_fork+0x439/0x670
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> 
> Update the check in __nvme_fc_abort_outstanding_ios() confirm that io
> tagset was created before iterating over busy requests. Also make sure
> to cancel ctrl->ioerr_work before removing io tagset.
> 
> Reviewed-by: Randy Jennings <randyj@purestorage.com>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Signed-off-by: James Smart <jsmart833426@gmail.com>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/fc.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 

Would be nice to have a 'Fixes' tag.
Otherwise:

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

