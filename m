Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFAB606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BeJWWxou;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Fpwxr5lD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LW6m9gHY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=U2A951FI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XPs2345R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KYKNoxIjK0QtPjmFS9un3/8eyLA4VwbkMm6SUmz5Lk0=; b=BeJWWxoutfBY/u
	+z+J26WxRLAZJA2FVZLRkc0ct6Vzl0a7pGygjoobPyz3s4iTYl5TupuzNF4SL7ef2fd0IqE9Pt3Cv
	BHD7wPxGz1fm/+akAmMtAq0daRBDjmykjShefBt38fUP/+4sN3f2Y3+ySzmqO5NRWsqRWISv9sfw+
	p4QFlQHwsfboINcS9KYqLTqs3zGOlgM5A1zmWxZTgWzZCGX6qOOYgax1iLoKQO5TwpGJSwWFp1i5s
	kefuhRbBx0LtZktTqkFQO/70+Df+4OMiL1Znw4pT6YwHFpEAjqC1WWeYq5Ws91MwmzAlHUp5gF3Qy
	K/SzyM/nwyX9UOI15RRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPEMd-0000000BRw5-3YOT;
	Fri, 06 Nov 2026 07:27:55 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPEMc-0000000BRvQ-0BON
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 07:27:55 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0BAE2219F;
	Fri,  6 Nov 2026 07:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793950072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYKNoxIjK0QtPjmFS9un3/8eyLA4VwbkMm6SUmz5Lk0=;
	b=Fpwxr5lDNdbQ3QhKYb9bJZrY4tZskMNN2M9YxOkSe6E1YP6vYO+IDA+Ta0L+LYUrcp1UlV
	CkQ4NTwkWaZdAcDDcDYC+YFKL1nnuTPOAYhTBni0QeoedgjWYGjRHSdtP2rlHT1LMOymf6
	i68h0nhZnLWo+ePduJJBIKw6Szrxdpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793950072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYKNoxIjK0QtPjmFS9un3/8eyLA4VwbkMm6SUmz5Lk0=;
	b=LW6m9gHYvrEHX7YXwS7FRtGPbnpyDtAr0nHan3/WA50GBsvjNaRXZvoRxMZPqp5/HchuHI
	P4bfTL3871YC2vAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=U2A951FI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XPs2345R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793950071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYKNoxIjK0QtPjmFS9un3/8eyLA4VwbkMm6SUmz5Lk0=;
	b=U2A951FIyukKfqk1gG2a8MqwoDaF88CKWUqgZXN7XNpB4+TnEvpZs6AqJ1/+98Nf/XfsO8
	BS11QkTDzjGEqwJUXjjV9OlFldqdzm+USV/KQvzCzSbnX+fHgXe24qfsrMtnFlEX4nEO5K
	t54XF97Z8zPunxUg9sAs4pubCGnpR2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793950071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYKNoxIjK0QtPjmFS9un3/8eyLA4VwbkMm6SUmz5Lk0=;
	b=XPs2345RYHgNY/5hEPY9/LwwKkkXJl8yRlqwJC7bz9lG/meWIXUnFwxXnjlJ6HN8Jl/x+M
	V+zGL0xnmbIhrYDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C152134E9;
	Fri,  6 Nov 2026 07:27:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9kn/E3eB7Wq3OQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 06 Nov 2026 07:27:51 +0000
Message-ID: <e01e30b2-f8b3-4e69-bca8-5892493afc96@suse.de>
Date: Fri, 6 Nov 2026 08:27:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] nvmet: take subsys->lock in
 nvmet_subsys_attr_tbkas_store()
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
 <20261106015842.3534898-5-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261106015842.3534898-5-kanie@linux.alibaba.com>
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,alibaba.com:email,suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: E0BAE2219F
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_232754_235480_CCF7C8FF 
X-CRM114-Status: GOOD (  18.56  )
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
> The tbkas store handler walks subsys->ctrls to force every controller
> to reconnect, but it holds only nvmet_config_sem for write.
> subsys->ctrls is protected by subsys->lock: nvmet_alloc_ctrl() adds an
> entry under subsys->lock, and nvmet_ctrl_free() removes it under
> subsys->lock with list_del() + kfree(). A concurrent controller
> teardown can therefore corrupt the walk.
> 
> This is the same bug fixed for nvmet_subsys_attr_qid_max_store() in
> commit 9f426f140511 ("nvmet: take subsys->lock while
> force-reconnecting in nvmet_subsys_attr_qid_max_store()"), which
> missed this second instance of the pattern. Take subsys->lock around
> the list_for_each_entry() loop. ->delete_ctrl() only queues
> asynchronous controller teardown, so it does not re-enter subsys->lock
> under the loop.
> 
> Fixes: e98e45e9465b ("nvmet: Add traffic based keep alive support to configfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/target/configfs.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index b3a5242d06f9..c17f2c8ab2df 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1466,8 +1466,10 @@ static ssize_t nvmet_subsys_attr_tbkas_store(struct config_item *item,
>   	subsys->tbkas = tbkas;
>   
>   	/* Force reconnect */
> +	mutex_lock(&subsys->lock);
>   	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
>   		ctrl->ops->delete_ctrl(ctrl);
> +	mutex_unlock(&subsys->lock);
>   	up_write(&nvmet_config_sem);
>   
>   	return count;

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

