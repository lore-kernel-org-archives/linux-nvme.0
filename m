Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B07606A338
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zakkqPUE;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=da0OI6a/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tcpNguDb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=da0OI6a/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tcpNguDb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TnX57kfpDTvM/Hg1CJe7VJGQwZbWZtV4xHRKwoUkMr4=; b=zakkqPUEEky0H6
	k3EXzHRxKYwEEP1FloxS904fCcEQPzykABWBLrtPw5bAS57SGsz+oKzpoMg3vNUKBVWoHpybIUsEQ
	z5JIISfh/Jwof673xJ4oyuR3Bq613/4VZ//6BNHnu3g/jgtoXWUQOzO+hUYEKKY6/k2D0EJWuPm7v
	4kjnQcrhuXdvO4JeqQjk4VQUdDx/VXqJw08PuAMp7hkB7xqQRXE5SeLDFitqydxNcAuh1LLtplqea
	U2K1iAxUVsdHlQOeBu+8xrv9mjMkaBtnnvkqOfG7xwVbTwOPc0/xUAQ9Ml5FY+4GG1pGzFan0RBK1
	fveCmXDFEYhw7JaSs/ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRWjO-0000000ARwD-23yH;
	Thu, 12 Nov 2026 15:28:54 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRWjL-0000000ARv6-40JG
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 15:28:53 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 90C5B1FB7F;
	Thu, 12 Nov 2026 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794497329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TnX57kfpDTvM/Hg1CJe7VJGQwZbWZtV4xHRKwoUkMr4=;
	b=da0OI6a/TVHq5+9utQ+WQwjitbXcD20zMOa4MSKB+Y6cP8iO0i4ZZp17h2jxV58QdvadSV
	lyCfEVAwlpakJ7m5h+ru41uQpUzKiyB8ARg2SkOjkNjhiPdh7beJfYdR4oOB4I2zh3w23w
	/KLgTNcqhTR+UpNTOOLz5v5h85R5vXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794497329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TnX57kfpDTvM/Hg1CJe7VJGQwZbWZtV4xHRKwoUkMr4=;
	b=tcpNguDbaUNhSHHHZYLmmrBR2c5ymbUEMFIoXmXQmFfnWec7GiMYz93bjPD4c1yRz/sRIf
	tUTa/rTtS5tLnXAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794497329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TnX57kfpDTvM/Hg1CJe7VJGQwZbWZtV4xHRKwoUkMr4=;
	b=da0OI6a/TVHq5+9utQ+WQwjitbXcD20zMOa4MSKB+Y6cP8iO0i4ZZp17h2jxV58QdvadSV
	lyCfEVAwlpakJ7m5h+ru41uQpUzKiyB8ARg2SkOjkNjhiPdh7beJfYdR4oOB4I2zh3w23w
	/KLgTNcqhTR+UpNTOOLz5v5h85R5vXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794497329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TnX57kfpDTvM/Hg1CJe7VJGQwZbWZtV4xHRKwoUkMr4=;
	b=tcpNguDbaUNhSHHHZYLmmrBR2c5ymbUEMFIoXmXQmFfnWec7GiMYz93bjPD4c1yRz/sRIf
	tUTa/rTtS5tLnXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49DC2134A0;
	Thu, 12 Nov 2026 15:28:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l1jtCDHb9WqVAgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 12 Nov 2026 15:28:49 +0000
Message-ID: <e59c66fd-a50c-4a34-9d00-33e53f007e2c@suse.de>
Date: Thu, 12 Nov 2026 16:28:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvme-multipath: don't wait for a grace period in
 nvme_mpath_set_live()
To: Qiliang Yuan <qiliang.yuan@linux.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261111-bug-nvme-mpath-set-live-srcu-v2-0-fc772914d293@linux.dev>
 <20261111-bug-nvme-mpath-set-live-srcu-v2-2-fc772914d293@linux.dev>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261111-bug-nvme-mpath-set-live-srcu-v2-2-fc772914d293@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_072852_452674_C4495FC4 
X-CRM114-Status: GOOD (  25.82  )
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

On 11/11/26 2:10 PM, Qiliang Yuan wrote:
> When a path goes live, nvme_mpath_set_live() waits for an SRCU grace
> period of the namespace head before kicking the requeue work, so that
> bios which found no usable path are on the requeue list by the time it
> runs.
> 
> The ANA work calls nvme_mpath_set_live() for every namespace that
> becomes optimized or non-optimized, one after another, so an ANA change
> waits for one grace period per namespace.
> 
> Start the grace period with start_poll_synchronize_srcu() instead and
> have nvme_requeue_work() wait for it only if it has not completed yet.
> Take the cookie under head->lock, so that concurrent callers store
> their cookies in order and the requeue work never sees an older one.
> The grace periods of all namespaces then run in parallel, and requeue
> work kicked for other reasons finds the cookie completed and does not
> wait.
> 
> Flipping an ANA group from inaccessible to optimized ten times over
> nvme-tcp loopback, nvme_read_ana_log() takes (median, min-max in
> parentheses):
> 
>    namespaces  before (ms)          after (ms)        change
>           256  51.9 (42.5-85.4)     8.9 (2.6-12.0)      -83%
>          1024  157.5 (133.5-179.6)  49.5 (32.8-67.1)    -69%
> 
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
> ---
>   drivers/nvme/host/multipath.c | 15 ++++++++++++++-
>   drivers/nvme/host/nvme.h      |  1 +
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index a92a05b1f925a..9c1023102902c 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -712,6 +712,11 @@ static void nvme_requeue_work(struct work_struct *work)
>   		container_of(work, struct nvme_ns_head, requeue_work);
>   	struct bio *bio, *next;
>   
> +	/* Let bios that found no usable path reach the requeue list first. */
> +	if (!poll_state_synchronize_srcu(&head->srcu,
> +					 READ_ONCE(head->requeue_srcu_cookie)))
> +		synchronize_srcu(&head->srcu);
> +
>   	spin_lock_irq(&head->requeue_lock);
>   	next = bio_list_get(&head->requeue_list);
>   	spin_unlock_irq(&head->requeue_lock);
> @@ -767,6 +772,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   	mutex_init(&head->lock);
>   	spin_lock_init(&head->requeue_lock);
>   	INIT_WORK(&head->requeue_work, nvme_requeue_work);
> +	head->requeue_srcu_cookie = get_completed_synchronize_srcu();
>   	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
>   	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
>   
> @@ -849,9 +855,16 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>   			__nvme_find_path(head, node);
>   		srcu_read_unlock(&head->srcu, srcu_idx);
>   	}
> +	/*
> +	 * Have nvme_requeue_work() wait for the grace period instead of
> +	 * blocking here, so that namespaces going live together, e.g. on
> +	 * an ANA change, do not wait for one grace period each. Start it
> +	 * under head->lock so that the newest cookie is stored last.
> +	 */
> +	WRITE_ONCE(head->requeue_srcu_cookie,
> +		   start_poll_synchronize_srcu(&head->srcu));
>   	mutex_unlock(&head->lock);
>   
> -	synchronize_srcu(&head->srcu);
>   	nvme_mpath_revalidate_zones(head);
>   	kblockd_schedule_work(&head->requeue_work);
>   }
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 8833a463f1c84..3fff9b394b1cd 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -587,6 +587,7 @@ struct nvme_ns_head {
>   		__guarded_by(&requeue_lock);
>   	spinlock_t		requeue_lock;
>   	struct work_struct	requeue_work;
> +	unsigned long		requeue_srcu_cookie;
>   	struct work_struct	partition_scan_work;
>   	struct mutex		lock;
>   	unsigned long		flags;
> 
Looks good.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

