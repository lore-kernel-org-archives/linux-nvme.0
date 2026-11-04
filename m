Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD18606A326
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zGKoTqeS;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zLVjw27E;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9dRCCVHz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DrhunRWx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Sk7oMjjx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mpwlx8C+vzOoycdHJZBTE7aV+HpHFeyxckRCX7eRe1g=; b=zGKoTqeSTFoNWZ
	BwVCRaMqeM6j4zznnijiBv4XhlXlmy68dm/+CCYonGo/VGHjg2nVJ+BZJHSPi6kiyIhqhVTiGrk9n
	Y4LXyYCOalBMnqAKoWz4ZvDqdWAeT/EP7TLBVsgjVGMGCZZcPAoOfYzqwEBanJAF6g2HkJK9eKW1Y
	3QYJxYm+Uk3l1rpZKlC8uCqH5dUdJqWmCtaqXFdXGlsNZjan/mBDYryLHY6CzZYPgZlLql/hz5zWJ
	S1o0FgP+qy5ns6wOmJEJ4IjTL9NBHDL7JAoOMXlMf4B8rXdl632yfbB/yiE91ZZ3LCjv6QXtbXwtG
	5XadVE4aSPpq6JT+YbTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOViM-00000004bAf-0LVf;
	Wed, 04 Nov 2026 07:47:22 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOViI-00000004b9p-26dh
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 07:47:20 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3EA052204F;
	Wed,  4 Nov 2026 07:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793778436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpwlx8C+vzOoycdHJZBTE7aV+HpHFeyxckRCX7eRe1g=;
	b=zLVjw27EPqBMIflHqiLeeF8J+YqatOFojoiXMMJuoxWYxpOV0l6wuF/41za5kMWLzjZHyQ
	tqfrADmZRluQSF6RgEUO3Y84sDuCcrm//qBdBlCjQb+Wt0uuEjCmqBbFuWn+6RclCyoJDc
	R3ljDEmVGy58iPxoXX6rrR4dGClFlx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793778436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpwlx8C+vzOoycdHJZBTE7aV+HpHFeyxckRCX7eRe1g=;
	b=9dRCCVHzNf6pbriKoyBcBXKvtOVP1jKpFK6ZlgP1sk/Cl4mVcQ2DBdmeUcaSE4Cx3Tof0Z
	sWzPjLqQdgvTqtBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DrhunRWx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Sk7oMjjx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793778435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpwlx8C+vzOoycdHJZBTE7aV+HpHFeyxckRCX7eRe1g=;
	b=DrhunRWxwZGFqCmtLUw77CQZGPwJIRDZGgwnN6pT/mrEW0oWo2ihaOALHCNnice90cGFUo
	700HZjP2BiErNo6xQupPkTTF/v2ef4tidKGLD/xA434crB+EbUFzFPM3V6kpAYHP5uBPbv
	Nd0BI2AGNSGEfq9ZCekreaYqpeMZYIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793778435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpwlx8C+vzOoycdHJZBTE7aV+HpHFeyxckRCX7eRe1g=;
	b=Sk7oMjjx3y/6tKrPkjWvrrtfBuKwjCSaDqoFFhwLzrgB3WMCy597wxCWa3JITC6xEtMN+1
	vL9uW+qPY8inLlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD9CC134A5;
	Wed,  4 Nov 2026 07:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +JyjHgLj6mrvTAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Nov 2026 07:47:14 +0000
Message-ID: <20873ebb-b60e-4800-9302-4fe7717151be@suse.de>
Date: Wed, 4 Nov 2026 08:47:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Surabhi Gogte <sgogte@purestorage.com>,
 Hannes Reinecke <hare@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>,
 Frederic Weisbecker <frederic@kernel.org>, Aaron Tomlin
 <atomlin@atomlin.com>, Maurizio Lombardi <mlombard@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3EA052204F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWELVE(0.00)[16];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_234718_691647_BE578598 
X-CRM114-Status: GOOD (  38.65  )
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 3:57 PM, Daniel Wagner wrote:
> blk_mq_alloc_request_hctx uses the first online CPU in hctx->cpumask to
> select the software context for a request.
> 
> Since commit a46c27026da1 ("blk-mq: don't schedule block kworker on
> isolated CPUs"), hctx->cpumask excludes isolated CPUs. If a hardware
> context is mapped only to isolated CPUs, the mask is empty and
> blk_mq_alloc_request_hctx fails with -EXDEV.
> 
> The NVMe fabrics transports use blk_mq_alloc_request_hctx to allocate
> the Connect command for each I/O queue. As a result, connecting to a
> controller can fail when using isolcpus=domain or an isolated cpuset
> partition.
> 
> Passthrough requests bypass the software queues and go directly to
> hctx->dispatch. Their software context is only used to select the
> completion CPU and as a hint when freeing the tag.
> 
> Use the software context of an online housekeeping CPU for passthrough
> requests.
> 
> Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
> Tested-by: Maurizio Lombardi <mlombard@redhat.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> Connecting a fabrics controller fails when all CPUs of a hardware
> context are isolated with isolcpus=domain or an isolated cpuset
> partition. Since commit a46c27026da1 ("blk-mq: don't schedule block
> kworker on isolated CPUs") the CPU mask of such a hardware context is
> empty and blk_mq_alloc_request_hctx() fails the Connect command with
> -EXDEV. This patch lets passthrough requests use the software context
> of a housekeeping CPU instead.
> 
> The nvme fabrics fixes from v1 (patches 1 and 3-5) are in nvme-7.4, so
> only the blk-mq patch is left. The blktest for this patch is nvme/070,
> posted separately.
> ---
> Changes in v2:
> - Only the blk-mq patch left, the nvme patches are in nvme-7.4.
> - Reword the commit message to describe what the fix does (Hannes).
> - Add Tested-by from Maurizio.
> - Link to v1: https://patch.msgid.link/20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org
> ---
>   block/blk-mq.c | 37 +++++++++++++++++++++++++++++++++++--
>   1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5fca78778c31..77685e6283fa 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -717,6 +717,25 @@ struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
>   }
>   EXPORT_SYMBOL(blk_mq_alloc_request);
>   
> +/*
> + * Return an online CPU which is neither isolated from the scheduler domains
> + * nor from managed interrupts, or nr_cpu_ids if there is none.
> + */
> +static unsigned int blk_mq_housekeeping_cpu(void)
> +{
> +	unsigned int cpu;
> +
> +	rcu_read_lock();
> +	for_each_online_cpu(cpu) {
> +		if (!cpu_is_isolated(cpu) &&
> +		    housekeeping_test_cpu(cpu, HK_TYPE_MANAGED_IRQ))
> +			break;
> +	}
> +	rcu_read_unlock();
> +
> +	return cpu;
> +}
> +
>   struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   	blk_opf_t opf, blk_mq_req_flags_t flags, unsigned int hctx_idx)
>   {
> @@ -767,8 +786,22 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   	if (!blk_mq_hw_queue_mapped(data.hctx))
>   		goto out_queue_exit;
>   	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> -	if (cpu >= nr_cpu_ids)
> -		goto out_queue_exit;
> +	if (cpu >= nr_cpu_ids) {
> +		/*
> +		 * Isolated CPUs are not part of hctx->cpumask, so it can be
> +		 * empty although online CPUs are mapped to this hardware
> +		 * context. Passthrough requests are inserted directly into
> +		 * hctx->dispatch, so use the software context of a
> +		 * housekeeping CPU for them. Inactive hardware contexts have
> +		 * no online CPU left.
> +		 */
> +		if (!blk_op_is_passthrough(opf) ||
> +		    test_bit(BLK_MQ_S_INACTIVE, &data.hctx->state))
> +			goto out_queue_exit;
> +		cpu = blk_mq_housekeeping_cpu();
> +		if (cpu >= nr_cpu_ids)
> +			goto out_queue_exit;
> +	}
>   	data.ctx = __blk_mq_get_ctx(q, cpu);
>   
>   	if (q->elevator)
> 
> ---
> base-commit: c8c53d669d4e45b3a804013251a34387d7e11bfb
> change-id: 20261013-nvme-fabrics-isolcpu-5b4948362f88
> 
> Best regards,
> --
> Daniel Wagner <dwagner@suse.de>
> 

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

