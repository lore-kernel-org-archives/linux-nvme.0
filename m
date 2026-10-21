Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA15606A320
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vUvTjqSz;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RLdgg1Oj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4db/Ka8q;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RLdgg1Oj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4db/Ka8q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WGfQmBZ4yxVe0RdyHuCTGzSXPSVaIfSw0HjTNZJfjAs=; b=vUvTjqSzO6eQicTZE1UnmXgWqu
	UpWRF3oGAOqqv5TybpUmXMxUF8bvFBwAkX6k5gZW/J5IfwSoSrHrF0huKnxAZ5YcnY9bRPmwxNbNj
	IS4g/ykM9zWc62EmZ/556b563C0QlViuZ0telpzvxkNvZxA2Fcs29snecuAuOdmU5JPBp3R/SekFW
	DVjLtVuO/XSca6llgPI9n2VJk6SW1YuSyqKslZvD68Ci+0ScbdOorgTXJtzEAjFGzVCPh2vpTCyU7
	ccMWnyVRXBA3ual2ntyJPu19gj8yqbw7EcYg3DQk+s2cW2Oe1ggYvLmrudUzFYZVg5DeMC6F3a9Ct
	J3ti9sxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJUG5-0000000Bi33-14To;
	Wed, 21 Oct 2026 11:13:25 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJUG3-0000000Bi2c-2YZH
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 11:13:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCEAB21DF0;
	Wed, 21 Oct 2026 11:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792581201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGfQmBZ4yxVe0RdyHuCTGzSXPSVaIfSw0HjTNZJfjAs=;
	b=RLdgg1OjrcpdZtLahGCyC5VP/bT+pKRgV0eu8zWSAeCEYq1vfEnA69MilNeBcYjXLztYDI
	66MpmB7UKqlfOkIeaTD4YUpwookyvCVpbMrBgOqIohtsoadMY32KrVE7knRaOQzB06+jPE
	KU74pQKmRvlzeM6NjUxG2UrNUahAUFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792581201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGfQmBZ4yxVe0RdyHuCTGzSXPSVaIfSw0HjTNZJfjAs=;
	b=4db/Ka8qpXJYCjnF6/jIRjgTe1+Eh0gvs3K05FQneLURwljoxIQK8fff2bjS0iCj6eU5mw
	Ix/p7ZgOsPtBBkCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RLdgg1Oj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="4db/Ka8q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792581201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGfQmBZ4yxVe0RdyHuCTGzSXPSVaIfSw0HjTNZJfjAs=;
	b=RLdgg1OjrcpdZtLahGCyC5VP/bT+pKRgV0eu8zWSAeCEYq1vfEnA69MilNeBcYjXLztYDI
	66MpmB7UKqlfOkIeaTD4YUpwookyvCVpbMrBgOqIohtsoadMY32KrVE7knRaOQzB06+jPE
	KU74pQKmRvlzeM6NjUxG2UrNUahAUFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792581201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGfQmBZ4yxVe0RdyHuCTGzSXPSVaIfSw0HjTNZJfjAs=;
	b=4db/Ka8qpXJYCjnF6/jIRjgTe1+Eh0gvs3K05FQneLURwljoxIQK8fff2bjS0iCj6eU5mw
	Ix/p7ZgOsPtBBkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 652B9134A5;
	Wed, 21 Oct 2026 11:13:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rzHyDlGe2GrQAwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 Oct 2026 11:13:21 +0000
Message-ID: <29d89a6e-2f8c-4a31-9f12-bab5f97b645c@suse.de>
Date: Wed, 21 Oct 2026 13:13:20 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nvme-fabrics: clear the poll map if no poll queues
 are mapped
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Surabhi Gogte <sgogte@purestorage.com>,
 Hannes Reinecke <hare@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>,
 Frederic Weisbecker <frederic@kernel.org>, Aaron Tomlin
 <atomlin@atomlin.com>, Maurizio Lombardi <mlombard@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
 <20261014-nvme-fabrics-isolcpu-v1-5-355156be27b2@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261014-nvme-fabrics-isolcpu-v1-5-355156be27b2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: BCEAB21DF0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_041323_800694_5304A5B7 
X-CRM114-Status: GOOD (  21.76  )
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/14/26 9:46 AM, Daniel Wagner wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> blk_mq_alloc_tag_set sets the nr_queues of every map to nr_hw_queues.
> When nr_poll_queues is set but no queues are left for polling,
> nvmf_map_queues skips the poll map and leaves it this way, with all CPUs
> mapped to hctx 0.  The queue then claims poll support, polled I/O ends
> up on hctx 0, which isn't a poll queue, and hctx 0 is marked as a poll
> hctx, so even the Connect command of the first I/O queue is marked as
> polled.
> 
> Clear the poll map when no poll queues are mapped, so polled I/O is
> rejected with -EOPNOTSUPP.
> 
> Fixes: 1a9460cef571 ("nvme-tcp: support simple polling")
> Fixes: 5651cd3c4336 ("nvme-rdma: fix queue mapping when queue count is limited")
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fabrics.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 27a8ce51d2b3..3d7ad86c1955 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -1199,6 +1199,13 @@ void nvmf_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
>   			io_queues[HCTX_TYPE_DEFAULT] +
>   			io_queues[HCTX_TYPE_READ];
>   		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
> +	} else {
> +		/*
> +		 * blk_mq_alloc_tag_set sets nr_queues of all maps to
> +		 * nr_hw_queues.  Clear the poll map, otherwise the queue claims
> +		 * poll support and polled I/O ends up on hctx 0.
> +		 */
> +		set->map[HCTX_TYPE_POLL].nr_queues = 0;
>   	}
>   
>   	dev_info(ctrl->device,
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

