Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C88C43458
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2026 11:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I+W01JOsngTzL+rKSPgK1XPvUG8PHglRzJrrMSkzbPc=; b=X1CI5YoCaODnrT01ne8h7yI5na
	ycaI7qa7fjfAsiInLsPSuMjOmNphm5B4al7haiAkxYnZllCN24xlt73Yu5mIk0LVYDJNalLQXrFK9
	B8bcWASfsnO+HyalXCGaq4LkgNoFJWjtC5UZz3A/lBysLNjAdnIvYiXJJB7La4ZpkC4kKleYeES6b
	CEd50BkBiy02+HVATXGBsUIDNV/2bByHdKcAe4RSr+KypBqPWW4rAixAPB2VU9pC2HK4e6bB4VI4w
	31vVdrbrhWdVebRY0h78B5xSyQZuhuPSzAJp3cHyuzAuD9oKDw6zZkbLqZxnAbg4YlCz47NViJife
	78Cm5jXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wesng-00000001QMX-0nxx;
	Wed, 01 Jul 2026 11:08:16 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wesnd-00000001QLn-3q0o
	for linux-nvme@lists.infradead.org;
	Wed, 01 Jul 2026 11:08:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF24B75B80;
	Wed,  1 Jul 2026 11:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782904090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+W01JOsngTzL+rKSPgK1XPvUG8PHglRzJrrMSkzbPc=;
	b=YWxLfVhS7ZP67BmU3uQ2r6ERwWCsgfWAX06Zh2ZMDRt90ckTVnMl+0nma/GCHHIY6coDNg
	3puOjsDaJxfaaWYDOKGL+ZF0DhrQu6ci2XiqN4NfsAWVYT4wetLTwDIU6/xYgBJ+WVc30n
	/r43VMjsNu+DFpLhek3e8AagRMIACoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782904090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+W01JOsngTzL+rKSPgK1XPvUG8PHglRzJrrMSkzbPc=;
	b=keccVJbifdqwoVAsHojtwJSH3p+kDj+122DDhkDIxvNNUVH8f51KVSI72b79Vuuf81MSfH
	c8VKdiqtmBk71YCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YWxLfVhS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=keccVJbi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782904090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+W01JOsngTzL+rKSPgK1XPvUG8PHglRzJrrMSkzbPc=;
	b=YWxLfVhS7ZP67BmU3uQ2r6ERwWCsgfWAX06Zh2ZMDRt90ckTVnMl+0nma/GCHHIY6coDNg
	3puOjsDaJxfaaWYDOKGL+ZF0DhrQu6ci2XiqN4NfsAWVYT4wetLTwDIU6/xYgBJ+WVc30n
	/r43VMjsNu+DFpLhek3e8AagRMIACoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782904090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+W01JOsngTzL+rKSPgK1XPvUG8PHglRzJrrMSkzbPc=;
	b=keccVJbifdqwoVAsHojtwJSH3p+kDj+122DDhkDIxvNNUVH8f51KVSI72b79Vuuf81MSfH
	c8VKdiqtmBk71YCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55AB2779AA;
	Wed,  1 Jul 2026 11:08:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4WoEExr1RGoreAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 01 Jul 2026 11:08:10 +0000
Message-ID: <9be94be1-2831-4973-b571-47bcd1c023aa@suse.de>
Date: Wed, 1 Jul 2026 13:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvme-rdma: parallelize I/O queue setup
To: Surabhi Gogte <sgogte@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 mkhalfella@purestorage.com, randyj@purestorage.com, adailey@purestorage.com
References: <20260625212722.1302344-1-sgogte@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260625212722.1302344-1-sgogte@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AF24B75B80
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_040814_104861_3FDF7EDD 
X-CRM114-Status: GOOD (  18.91  )
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

On 6/25/26 11:27 PM, Surabhi Gogte wrote:
> This patch series parallelizes nvme-rdma connection and reconnection by
> setting up I/O queues in parallel instead of sequentially. Allocation and
> startup of each queue are combined into a single per-queue async work
> item, so per-queue connection latency overlaps across all queues. This
> matters most on high-core-count hosts with many I/O queues, where serial
> setup dominates connect time.
> 
> Patch 1 is a preparatory refactor: nvme_rdma_alloc_queue() takes a queue
> pointer so allocation and startup can be folded into a single async
> worker.
> 
> Patch 2 contains the implementation for async setup of I/O queues.
> 
> Testing on a 64-core host with 64 I/O queues shows nvme-rdma connection
> time reduced from ~1.4s to 416ms.
> 
> Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
> ---
> Changes from v2->v3:
> - Split the series into two patches: extract the nvme_rdma_alloc_queue()
>    refactor into a separate preparatory patch.
> - Replace the atomic error flag in struct nvme_rdma_ctrl with a per-work
>    nvme_rdma_setup_ctx { queue, err } struct.
> - Fix formatting changes regarding line overflow indentation and nesting.
> 
> Changes from v1->v2:
> - Remove separate workqueue and use the async API instead.
> 
> Previous versions:
> v1: https://lore.kernel.org/all/20260529001354.1003640-1-sgogte@purestorage.com/
> v2: https://lore.kernel.org/all/20260604195321.2232838-1-sgogte@purestorage.com/
> 
> Surabhi Gogte (2):
>    nvme-rdma: refactor nvme_rdma_alloc_queue() to take a queue pointer
>    nvme-rdma: parallelize I/O queue allocation and startup
> 
>   drivers/nvme/host/rdma.c | 135 ++++++++++++++++++++++++---------------
>   1 file changed, 82 insertions(+), 53 deletions(-)
> 
I would think that the same argument holds for nvme-tcp as the drivers
are pretty similar. Can you update nvme-tcp, too, to take advantage of
parallel I/O queue setup?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

