Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C745606A328
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=c7/FTXBg;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mck2kT8g;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MN1Zj7vp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KI2I3V9G;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EKApCIPH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=EQ6AbfgTcddfKws4WVJBgg+PWjxw5fpkMt6xhD0VETU=; b=c7/FTXBgh/cWLE
	Dv8dukkQ0DHyoP5/oQaBGCoFbQ0p5AXzwE8gKC4iXRFxKMadE8Fj6uogRKgTHXyqU8UlWXzV5bwlZ
	jPZmrQfEjTXE3+bc24UrkI9Ai2HJWsDITltF+8cosNixvss1vVH1ScIvKajqptBLr8EjxN1O5EIPT
	Bfw4AzS50TPzhT5RRKyxwlhhZOg3Qn7+ddPR0IEp6X8P0CXVKj8CcYXW3kN3YZ5cgnDbllwW7TObs
	Bd4kye/bYdeRy1YHYoQkfHFYkDC6RYx9HMQ7O4eds4GOyuZQe+AYYmIREnwW9tPZ4Coc7sDpGxzBa
	JwWbW1fztw3UvBR28DJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPEM5-0000000BRpD-2xgT;
	Fri, 06 Nov 2026 07:27:21 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPEM3-0000000BRoo-42Gq
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 07:27:21 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA2A61F78E;
	Fri,  6 Nov 2026 07:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793950036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQ6AbfgTcddfKws4WVJBgg+PWjxw5fpkMt6xhD0VETU=;
	b=mck2kT8g2ZzK67giSxhMVetukXmCHxnl3PtuaXZVKC7tZiaNE/CHYOh+m3j85kIIjCPNVW
	QE1xIZzVFOQ0qJcfgFqZPgK4xk1Zk8yRB61KroPLYYeBnAH17aAYAqHnDoVB3iWRUXsuOM
	0+mKrbKIuT/hfc9E/UOu2VzN1ER8qGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793950036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQ6AbfgTcddfKws4WVJBgg+PWjxw5fpkMt6xhD0VETU=;
	b=MN1Zj7vpmJAMYcjV+eddFWxyNc98a3AJpJz4MGiV0TWb8M6bzS3FBdbBBhQ7Wqn1DIlY2O
	/pQMgQgZ97YP7BCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793950035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQ6AbfgTcddfKws4WVJBgg+PWjxw5fpkMt6xhD0VETU=;
	b=KI2I3V9GveFsWrkwYpmH7gl7/BkCTSg9lnsxP9gZY7j5znbdCXtjf2Cu2AEIOJhlxsUjFf
	2n1YcOBii0/iiPjzC9qQR6oIAigrCm6ItCqR+6f2iD7k/O9Y3x3qko3gk4kyy3v2NM+Iu0
	4Xa61I/gbFHroCGYkFgrBydVIxSipVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793950035;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQ6AbfgTcddfKws4WVJBgg+PWjxw5fpkMt6xhD0VETU=;
	b=EKApCIPH4VEhiYg23wrRzdBLNoaNAeSXVQWaRxWJ2WZ+oD8iERPLwzvYJZl5dAog6dkhg2
	frudAW39T7im8YAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45FA0134E9;
	Fri,  6 Nov 2026 07:27:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3RexB1OB7WqKOAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 06 Nov 2026 07:27:15 +0000
Message-ID: <58fc6953-b73f-4a0f-b67b-9e5aa6a32db2@suse.de>
Date: Fri, 6 Nov 2026 08:27:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] nvme-auth: fix data race on ctrl->transaction
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
 <20261106015842.3534898-4-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261106015842.3534898-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,alibaba.com:email]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_232720_154265_47D58B22 
X-CRM114-Status: GOOD (  18.67  )
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

On 11/6/26 2:58 AM, Guixin Liu wrote:
> nvme_ctrl_auth_work() queues the DH-HMAC-CHAP exchange of every queue
> on nvme-auth-wq without waiting for them, so multiple
> nvme_queue_auth_work() instances run concurrently and all increment
> ctrl->transaction in nvme_queue_auth_work(). The plain increment is a
> data race, and the lost updates hand the same transaction id to
> concurrent queues.
> 
> The controller side only echoes the transaction id within a queue, so
> the race has no functional impact today, but the increment is still
> unsynchronized and KCSAN reports it. Use an atomic_t.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/host/auth.c | 2 +-
>   drivers/nvme/host/nvme.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 85f005a5efd0..107355ee9ef1 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -765,7 +765,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
>   		return;
>   	}
>   
> -	chap->transaction = ctrl->transaction++;
> +	chap->transaction = (u16)atomic_fetch_inc(&ctrl->transaction);
>   
>   	/* DH-HMAC-CHAP Step 1: send negotiate */
>   	dev_dbg(ctrl->device, "%s: qid %d send negotiate\n",
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 92c048002ecd..1fb676dade12 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -446,7 +446,7 @@ struct nvme_ctrl {
>   	struct nvme_dhchap_queue_context *dhchap_ctxs;
>   	struct nvme_dhchap_key *host_key;
>   	struct nvme_dhchap_key *ctrl_key;
> -	u16 transaction;
> +	atomic_t transaction;
>   #endif
>   	key_serial_t tls_pskid;
>   
Hi-speed authentication races ... every day a new surprise.
Although I wonder why a normal 'atomic_inc_return' isn't sufficient.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

